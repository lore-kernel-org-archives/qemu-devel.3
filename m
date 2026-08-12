Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DDEC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8Pk-0007ze-Hq; Wed, 12 Aug 2026 08:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu8Pg-0007vg-Gh; Wed, 12 Aug 2026 08:50:33 -0400
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu8PS-0000dk-W5; Wed, 12 Aug 2026 08:50:23 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 0540FEC01F2;
 Wed, 12 Aug 2026 08:50:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 12 Aug 2026 08:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786539015; x=1786625415; bh=qWrKqiLJWwkjtSSuvdmid3VrEIcWT5YN
 ZjDfVp1fuOw=; b=tvrDvHF/Z//njT2da1qtJuiis05ckxBE+v7y3QzeDpbrtPL/
 YQXOa4ceOGzLSnvZeevfw5293cE9TcvcIGlnAN6CTglkrs7/s9u8l5pM/B4Vjkno
 6TBcbrdiP1lK6B7oHrrOFmL8ohRvCmBQe6q4/BI4MfbpPsagLhfhwis4rRpGkHp4
 aa4p31yaVoQXQyr8yYBS2/wRm5Fruh52mMwXJLcv1qRziJCBDtZL9bnrc3VrRp6j
 /+2/ATNfuQz2SAvYVaqP3wa4o+e8OwqhLH1yPuVjmgDjgkcXwYsPRvB6qljQrE/M
 iaVDlypsoeVDgo2JlyfmY17WqX5wDTBv9+BVjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786539015; x=
 1786625415; bh=qWrKqiLJWwkjtSSuvdmid3VrEIcWT5YNZjDfVp1fuOw=; b=h
 B4v8vtd7hohUoFtY4DFNZyxAlh75fGXbzdjk6IHRr9GVYbIDumT4iwRdwWhijIgd
 CZn9wPB1HfQ0vrbW+SzMJcAbK1Z5qeyc3RYDS+y+pqvSDegKmEP84YvpYuIXiK1E
 3hddTHBIUmGQ8tY1LxPSkifo8abveWpQ2J58R5mgBz27ujPOYGbqIixlj5aOjqzQ
 MdtQyAnMGJfrjT6F8XGU0z5rwrimCL3StB0YaIba2UADr8lybAUlNULyCzi/lYpb
 PQuJU4k3R0km4+2X/Na9KyYzeiFXCBvz2a5oMrVn43rFTN7ZlrfRy9RvVmmgbQDt
 J+mDyXBgPT+Q1WbvHS5Tw==
X-ME-Sender: <xms:Bmx8anFgtm6JlDCzbAqihRGsRSoF-A4SQBaEgvgkXhZsHIzbhTmC-Q>
 <xme:Bmx8akcXCu97o54MZ_YouQau_uAyPf9im-VoURi16_R-JovUG8RbeI3XafD9uc8jF
 _ke9mkZ07xdX_hju16yjDa3kpEHabMnMNTSLkrKN_hGis9i_QetMlk6>
X-ME-Received: <xmr:Bmx8ahG9fE3v_PYrfz517LlWSLXNO1TXzLCnq3sOlzc7k3BWJRB6YgZNRGldMv9-WCFmGg>
X-ME-Proxy-Cause: dmFkZTFSQ6bX1pXq2VoAPXFmnupD1bi9jM4uOP0PFHX/2PPqwvWtyPKDgpIq7bXf/r/e/l
 cTYdg3KmA5fCkeZZEbh3XWkbLJm9eKpWEUPTr8tGkRhIUiW1cNrXC58vnzmOdzEG9ZNicx
 4zCLAQxvNp+kdKV/6Ys7lgvV5WiMedVrMLs69boSwQskzyXn+XqbzTlajRD5u3O7dpORJF
 OURWmHA+sYSlbY3TeQMCc7HRG2fC1t/oYzTEw8gCeiQToSCHNafUiW68VBDipl3oFa84pr
 EckXAt/+hwiJVlmOqRXXwR4aoV/ZS5XWwO2refQB/2LW4IKhocbkYdFaHkiEZmOI3QEDJA
 lZ38ZMxe1rqqZxwNVlTFs7AZ0vPthvMXV5S5XEdzgQYyraaJJNfTa/mx1RSv/7Fj8ZNwl+
 G8kFgahyBUgssIos1cQrdcV6oK21h3JIKxv83DDdFXhFuzJvNiLotUUYTAQqxys0+3BqoI
 zk8HbG5tjCNDhaAyYtdvLbgLIh20wg/0MB5gZUEa6s0NgPXxyIu4Hl9DLvZYnOL+MfIHfQ
 UsFg16Zv0hToy6epZf6Gm/TyzKMDfyKdU9zUCkZcXVkgpGST5FI6WJHlhPBmqF+y6OYKB+
 Ek056UebuKYrOf9rgi+VE1yRHxtvDmVo+sPJvzxj1Qjjn3gk1Cjx+aMfpr4A
X-ME-Proxy: <xmx:Bmx8atWG1HyYClwdZkxs_hB4vf5asaY3o6PUItQBImFn82Q0RYHblA>
 <xmx:Bmx8aoLU5ofKxRsdAAVkyZKIVzXDlbF8c4M62YvnE1yL9kz5Eh98Lw>
 <xmx:Bmx8al9VLb18jLk9CpniNKaagGLIaiUhTIp_Lo4R6iBFbHlfXEOKWw>
 <xmx:Bmx8ajLp1Qlfl_MIA25Iv1Awu7B3ZrFduaoBi8LW4OdpS1F8Ny2F1A>
 <xmx:B2x8ahfHJEFfp7k6iOxtjvQymXBai65ZjhLvhTUyAPqh6Qzmx03HxYku>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 08:50:14 -0400 (EDT)
Message-ID: <a847b3e98668cd69487fc64c8c7d840e202518ea.camel@alistair23.me>
Subject: Re: [PATCH 43/56] disas/riscv: Fix isa decoding of rev8
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-stable@nongnu.org
Date: Wed, 12 Aug 2026 22:50:14 +1000
In-Reply-To: <20260809223545.730664-44-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-44-richard.henderson@linaro.org>
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
ZToKPiBUaGUgZW5jb2Rpbmcgb2YgcmV2OCBpcyBkaWZmZXJlbnQgZm9yIHJ2MzIgYW5kIHJ2NjQu
Cj4gCj4gQ2M6IHFlbXUtc3RhYmxlQG5vbmdudS5vcmcKPiBGaXhlczogMDJjMWI1NjlhMTUgKCJk
aXNhcy9yaXNjdjogQWRkIFpiW2FiY3NdIGluc3RydWN0aW9ucyIpCj4gU2lnbmVkLW9mZi1ieTog
UmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+CgpSZXZpZXdl
ZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgoKQWxpc3Rh
aXIKCj4gLS0tCj4gwqBkaXNhcy9yaXNjdi5jIHwgMTIgKysrKysrKysrKy0tCj4gwqAxIGZpbGUg
Y2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0
IGEvZGlzYXMvcmlzY3YuYyBiL2Rpc2FzL3Jpc2N2LmMKPiBpbmRleCA5NDQyYTZjMTE1Li40MTQx
NzQxZDc5IDEwMDY0NAo+IC0tLSBhL2Rpc2FzL3Jpc2N2LmMKPiArKysgYi9kaXNhcy9yaXNjdi5j
Cj4gQEAgLTMyOTIsOCArMzI5MiwxNiBAQCBzdGF0aWMgY29uc3QgcnZfb3Bjb2RlX2RhdGEKPiAq
ZGVjb2RlX2luc3Rfb3Bjb2RlKHJ2X2RlY29kZSAqZGVjLCBydl9pc2EgaXNhKQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgMGIwMTEwMDogb3AgPSBydl9vcF9yb3JpOyBi
cmVhazsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIDBiMDExMDE6Cj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzd2l0Y2ggKChpbnN0ID4+
IDIwKSAmIDBiMTExMTExMSkgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjYXNlIDBiMDAxMTAwMDogb3AgPSBydl9vcF9yZXY4OyBicmVhazsKPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSAwYjAxMTEwMDA6IG9wID0gcnZfb3Bf
cmV2ODsgYnJlYWs7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNh
c2UgMGIwMDExMDAwOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGlmIChpc2EgPT0gcnYzMikgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3AgPSBydl9vcF9yZXY4Owo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSAwYjAxMTEwMDA6Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGlzYSA9PSBydjY0KSB7Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvcCA9
IHJ2X29wX3Jldjg7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGJyZWFrOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSAw
YjAwMDAxMTE6IG9wID0gcnZfb3BfYnJldjg7IGJyZWFrOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYnJlYWs7Cg==


