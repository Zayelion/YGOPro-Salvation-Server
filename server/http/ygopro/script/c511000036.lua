--Jurassic Impact
function c511000036.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000036.condition)
	e1:SetTarget(c511000036.target)
	e1:SetOperation(c511000036.activate)
	c:RegisterEffect(e1)
end
function c511000036.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c511000036.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<Duel.GetLP(1-tp)
end
function c511000036.tfilter(c)
	return c:IsDestructable()
end
function c511000036.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000036.tfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c511000036.tfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,0,g:GetCount()*300)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c511000036.tfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,c) end
	local sg=Duel.GetMatchingGroup(c511000036.tfilter,tp,LOCATION_MZONE,LOCATION_MZONE,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c511000036.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(c511000036.tfilter,tp,LOCATION_MZONE,0,nil)
	local g2=Duel.GetMatchingGroup(c511000036.tfilter,tp,0,LOCATION_MZONE,nil)
	local ct1=Duel.Destroy(g1,REASON_EFFECT)
	local ct2=Duel.Destroy(g2,REASON_EFFECT)
	Duel.Damage(tp,ct1*300,REASON_EFFECT)
	Duel.Damage(1-tp,ct2*300,REASON_EFFECT)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE_START+PHASE_END)
	e1:SetOperation(c511000036.countop)
	if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_END then
		e1:SetLabel(1)
	else
		e1:SetLabel(0)
	end
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,1)
	e1:SetLabelObject(tc)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_CANNOT_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,1)
	e2:SetCondition(c511000036.limcon)
	e2:SetLabelObject(e1)
	e2:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,1)
	Duel.RegisterEffect(e2,tp)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	Duel.RegisterEffect(e3,tp)
end
function c511000036.limcon(e)
	return e:GetLabelObject():GetLabel()<3
end
function c511000036.countop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()~=tp then return end
	local ct=e:GetLabel()
	e:SetLabel(ct+1)
end