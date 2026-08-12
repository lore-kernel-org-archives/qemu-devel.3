Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB5CC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8Y3-0001il-N9; Wed, 12 Aug 2026 08:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu8Y2-0001ap-3i; Wed, 12 Aug 2026 08:59:10 -0400
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu8Xz-0002ym-Dn; Wed, 12 Aug 2026 08:59:08 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 341B5EC0199;
 Wed, 12 Aug 2026 08:59:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 12 Aug 2026 08:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786539546; x=1786625946; bh=FAwmWdGqvLZIEtQCn24m4Wuk4Z5LOCoo
 dVy4jasrlUY=; b=PVVWCtt7SZruaPjDt6u3lQ7QTbO/2slzXJfSnZy91KOsM4BP
 FqJwCfB1mOd/zfGVcVnzmFxQAs0hwmYK8R5Ol/pW5g+i3ewkaz/V9HI9YzrOEfJW
 +bEaqzqH+qRjl9zqol3hXnuWREg/wH7v1XxThc+i+/9JB/7hBq6cO/nJMjuBGirr
 1gOe6gt2ptUw7bFWgiLsVJ1O7UgBwxkhQ/UVF7KoIlUhhLYAFnzcQSNsADlTYV0k
 /xi8FdFX6YCPmEKiqulYNcpaI49vTzKAD832gtgT4sTr3WBegBRDUuL3ip7UgRS5
 SKxe1Ie4Ib+ya0wz65CfXEd3Grp9Vd9+ijVxHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786539546; x=
 1786625946; bh=FAwmWdGqvLZIEtQCn24m4Wuk4Z5LOCoodVy4jasrlUY=; b=Q
 hQOf2nEW2re7x3US1AchyibisjlIreF8X0QFGzlLNFx9drgg4IJHU72A16DGupvs
 QgVnx6bsEVgzv68C+HSE4vaq2ROTgPRKn1k7U1CIi/eIJwYgpvSRenVhI9FxAhSW
 kmQBYcKpmo70FowizLtXotVWrU/ezCjoi35BH7NTzSw7TOuarpzUxeUaCKvSxjJC
 lEjik9LR3bNl0gEhCz1S0yQDQgSO6JNjEoH1+WMM80DcQ1Doi6klLzpRurmgtr5N
 6VxNAx3bIoKEnyajOiUy/GYGKHVqIHwPRmsO8+acslQZpyTpKrKBO0LEcNb4IQN3
 0Kesoqf3AIbdqaX4TihAw==
X-ME-Sender: <xms:Gm58aiTUNpMVCl_W-2K2zDDVBQ8vQMdDDW6Ck5nG_4Yxs3Yog5fZgg>
 <xme:Gm58asGWuFc6x9XglIYH3j0pXIvjFXCWRnfSWRvcJk-RwPDxrST3lr4-DLUh46kmR
 WquzJhhihXBegDY3NJ-A30yPCG40J3dWfBoRBnL-M0ooibJMkvGmBQH>
X-ME-Received: <xmr:Gm58au9IimTpbIzq3Bu9V12dT3gzQMFdqgIm4VEBxW8cXou-CcxNSr7G1z1sXycB19gY7A>
X-ME-Proxy-Cause: dmFkZTER5Ds7srHUvu0SUnRF+6GMygnhAD1nU33VYrdecsSgUmqPAPW6jj8rIJuqIUEJWP
 pAl4yimYFIEQmg5R82InhtyFRurkIzDP3rXzMKuHBIju/9fX+YCC7ruZ6UZwOAgena1mqB
 CAinksaw5enVhzrBDTdOUsdFaBktBRBYVosZD6GeFK2h+4FWUD4F3dKahMco37svGLAMBI
 mTCVrTzedSqaCrWexg3NG9DQ+R/TakE3UflhJD7KzzfhZdpNwjwh1PDMJ3jlDJfv1pLdJ5
 rRoA8TQ0KvoYaoc83riK0+VMSLslZ9iB3VkPw6BMKAtGg9UpepiKr3hjkYEBPVMvf7loMn
 F6UbUo8HRHVb0mAvZWiWBKp/c/Fp9kb/WIn1SWqQV07JZ38K0B1kN3ynLnEaShu123fKx2
 kQOBc65SQQGGjx0WPQAzDGmfj57gBgYVjMh1/kRqU4Cb1Lc8i74BQV2ng4r9UeY/YVtdSi
 NG+jA9wkupEYJ1b+uqaWK0MU3/0WKdk5stRAwPEokpzDeGlVGdNIHhMqdlIe4YSpNYbGLX
 AHwG3tR+WnC6vBIsboJuUQkKanQ/vwjCWrYxUAKzia6BlmYIiA2XJFfjEj4xXMdGtW+GAo
 B0MsjIrTm/wjT6N77Y4B5ExeRANN0Tf+Lo/5BIz/8RfQc/3NxuP64LjzRz/w
X-ME-Proxy: <xmx:Gm58amK_jTzj4dauHBJF_VbcxdBM6Chq5nM294fGt4uALDaygJz6KA>
 <xmx:Gm58ahaRIsGGD2yW8N3IB8GpErqEyTS2GOBTr1JQn511BwLSUohB_Q>
 <xmx:Gm58agIOJAfcNLGfWK4tAJI7bfjiASpxUTGjNMfKSOz2ApF0cjtrFg>
 <xmx:Gm58anA-KX9V_IRLUw1ycFvZD5k0yVl5KPmC4RSV-CRoH2kWj3Vi-w>
 <xmx:Gm58aqVsqjnvfA7FJKQ2BtuLGTuzGZfYUVL4FTdRDzPJopjw41y3SKnp>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 08:59:05 -0400 (EDT)
Message-ID: <a926c30acdf5df737cf7d9d72f6f280104b2d641.camel@alistair23.me>
Subject: Re: [PATCH 53/56] disas/riscv: Tidy decode of c.mop.n
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 22:59:05 +1000
In-Reply-To: <20260809223545.730664-54-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-54-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.145;
 envelope-from=alistair@alistair23.me; helo=fout-a2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

T24gU3VuLCAyMDI2LTA4LTA5IGF0IDE1OjM1IC0wNzAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToKPiBNZXJnZSBuZXN0ZWQgaWYncy4KPiBSZXVzZSBvcGVyYW5kX2Ntb3BfaW1tIGZvciB6aWNm
aXNzIGRlY29kZS4KPiBSZXR1cm4gcG9pbnRlcnMgZGlyZWN0bHkuCj4gCj4gU2lnbmVkLW9mZi1i
eTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+CgpSZXZp
ZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgoKQWxp
c3RhaXIKCj4gLS0tCj4gwqBkaXNhcy9yaXNjdi5jIHwgMTkgKysrKysrKysrLS0tLS0tLS0tLQo+
IMKgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCj4gCj4g
ZGlmZiAtLWdpdCBhL2Rpc2FzL3Jpc2N2LmMgYi9kaXNhcy9yaXNjdi5jCj4gaW5kZXggODljMmU2
Mzk0MS4uOTY4MmU2ZjVhNSAxMDA2NDQKPiAtLS0gYS9kaXNhcy9yaXNjdi5jCj4gKysrIGIvZGlz
YXMvcmlzY3YuYwo+IEBAIC0xMDI3LDE4ICsxMDI3LDE3IEBAIHN0YXRpYyBjb25zdCBydl9vcGNv
ZGVfZGF0YQo+ICpkZWNvZGVfaW5zdF9vcGNvZGUocnZfZGVjb2RlICpkZWMsIHJ2X2lzYSBpc2Ep
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+IMKgwqDCoMKgwqDCoMKgwqAgY2Fz
ZSAyOiBvcCA9IHJ2X29wX2NfbGk7IGJyZWFrOwo+IMKgwqDCoMKgwqDCoMKgwqAgY2FzZSAzOgo+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChkZWMtPmNmZyAmJiBkZWMtPmNmZy0+ZXh0X3pj
bW9wKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoKCgoaW5zdCA+PiAy
KSAmIDBiMTExMTExKSA9PSAwYjEwMDAwMCkgJiYKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgKCgoaW5zdCA+PiAxMSkgJiAwYjExKSA9PSAwYjApKSB7Cj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCBjbW9wX2NvZGUg
PSAwOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjbW9wX2NvZGUg
PSAoKGluc3QgPj4gOCkgJiAwYjExMSk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIG9wID0gcnZfb3BfY19tb3A7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGlmIChkZWMtPmNmZy0+ZXh0X3ppY2Zpc3MpIHsKPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvcCA9IChjbW9wX2NvZGUgPT0gMCkg
PyBydl9vcF9jX3NzcHVzaCA6IG9wOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIG9wID0gKGNtb3BfY29kZSA9PSAyKSA/IHJ2X29wX2Nfc3Nwb3BjaGsg
Ogo+IG9wOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChkZWMtPmNmZwo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJiYgZGVjLT5jZmctPmV4dF96Y21vcAo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJiYgKChpbnN0ID4+IDIpICYgMGIxMTExMTEpID09IDBi
MTAwMDAwCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmJiAoKGluc3QgPj4gMTEp
ICYgMGIxMSkgPT0gMCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGRl
Yy0+Y2ZnLT5leHRfemljZmlzcykgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBzd2l0Y2ggKG9wZXJhbmRfY21vcF9pbW0oaW5zdCkpIHsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSAxOiByZXR1cm4gJnJ2aV9vcGNvZGVfZGF0
YVtydl9vcF9jX3NzcHVzaF07Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGNhc2UgNTogcmV0dXJuCj4gJnJ2aV9vcGNvZGVfZGF0YVtydl9vcF9jX3NzcG9wY2hrXTsK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJu
ICZydmlfb3Bjb2RlX2RhdGFbcnZfb3BfY19tb3BdOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB9Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChpbnN0ICYgKCgxIDw8IDEyKSB8ICgw
eDFmIDw8IDIpKSkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN3aXRjaCAo
KGluc3QgPj4gNykgJiAwYjExMTExKSB7Cg==


