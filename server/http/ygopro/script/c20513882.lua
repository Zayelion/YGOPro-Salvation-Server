--Painful Escape
--By: HelixReactor
function c20513882.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c20513882.cost)
	e1:SetTarget(c20513882.target)
	e1:SetOperation(c20513882.activate)
	c:RegisterEffect(e1)
end
function c20513882.filter(c)
	return c:IsFaceup() and Duel.IsExistingMatchingCard(c20513882.filter2,c:GetControler(),LOCATION_DECK+LOCATION_GRAVE,0,1,nil,c:GetRace(),c:GetAttribute(),c:GetLevel(),c:GetCode())
end
function c20513882.filter2(c,race,attr,lv,code)
	return c:IsRace(race) and c:IsAttribute(attr) and c:GetLevel()==lv and not c:IsCode(code) and c:IsAbleToHand()
end
function c20513882.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c20513882.filter,1,nil) end
	local rg=Duel.SelectReleaseGroup(tp,c20513882.filter,1,1,nil)
	Duel.Release(rg,REASON_COST)
	e:SetLabelObject(rg:GetFirst())
end
function c20513882.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c20513882.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20513882.filter,tp,LOCATION_MZONE,0,1,nil) end
	local tc=e:GetLabelObject()
	Duel.SetTargetCard(tc)
end
function c20513882.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOHAND)
	local g=Duel.SelectMatchingCard(tp,c20513882.filter2,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,tc:GetRace(),tc:GetAttribute(),tc:GetLevel(),tc:GetCode())
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end