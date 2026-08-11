Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A5FC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtszK-00025m-0P; Tue, 11 Aug 2026 16:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtszC-000237-CM; Tue, 11 Aug 2026 16:22:12 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtszA-00049V-N6; Tue, 11 Aug 2026 16:22:10 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C1564140016F;
 Tue, 11 Aug 2026 16:22:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 11 Aug 2026 16:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786479727; x=1786566127; bh=mU8/9OWnb0D6m7JSLbHflwgFheQfpNfq
 zpyH5e40CMo=; b=lxkEYzCV7sznO7MIWwlcUZPXuEoJUcYbDMH8WCTvZuICZ38K
 z967BpjCHQJh31fBhPadrsnx9RsmzFr2LPg3Z8ULs5ivn+6lpvruzj9pfcSYXpyD
 0himJ+Ie4LzsHgYVX4CbgT8o3AJCYfIkfMuELCRPkNhZBe/wbDQQ+HKXhdCJP+yu
 HUSdVxvJyGwu7NtfQJBTZ1L3oUdR2PT1PQ2agEt0Qxm+XBK9yy/IwNAkOXt058TW
 v3iSdu6LE5lH9/Ps1MeHIAWJMARBZZ5xwr/FL/oJKc0HJpZmUGqriQc/lj6trqet
 gqteNKjah6jxugFdPtRPc1P9LVevg/U60v4g4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786479727; x=
 1786566127; bh=mU8/9OWnb0D6m7JSLbHflwgFheQfpNfqzpyH5e40CMo=; b=J
 a0fufWXDVHjB0fnqCWL3ndyiJwk2StxHsotEtqINBA0cKfqYDEHKFUkgCYD75Znm
 spA/np6XCML5dZhj9wUTTLic1FYLlOrybgcGsizmQ48SkOb/VhLFWtQ3Vqb3dtB8
 W/h0ioPySOX17IXOgeKKjiy/qKKkktjzq7OPUaab2eC4NI/5qpVUSMPqveIqKozl
 vAt59EY9QHG/G3qAowCspSNRFl3ZqVCheBD3LH5VEVoo7k2duGVSMl73jm+jczZJ
 jKC/UzAnXo5QuAB8z/FC7JM8usa9as2I7yBpq8+kQX1jKiBJD2NE5UiXr4wh/9eT
 oWiRB9s+rhVAr2EIvF8Qg==
X-ME-Sender: <xms:b4R7aqtaye59LAgtlCr7ZLTBuNjZ-M5i1lSZAZFc3XbTZnqRWuwK6A>
 <xme:b4R7ajwobRCc5z4rheOOUAhj1GIbnwVh4L3dfdn6fHNQcuAOevumDi1uMC6y8qKrv
 7ddt3TqgTbRRD6yUdHkU2Vo6Wn2NG2mcbJMcQilGr7DwlwRUfYecBI>
X-ME-Received: <xmr:b4R7ak68hAvYFDhCrBYVMpy4qjixyVgPv3M5foHLHQM3uz9D7Wuze073jI8Ik2eZ6kj4Sw>
X-ME-Proxy-Cause: dmFkZTGFUpSS2GT1z7DHoWv8NCM7+16aVte8EPcTOexXdW4G8RGpvTIDkkb9QH/6b3lrEi
 1QfIZs+N3MbyOFqV8mRj8GKZrEOXVeiF+EFez4pVjLgnRU9i+JfRj3PTXYYbmI5N2UMtHV
 K2j88n1elLZIEH7515+VW5iiht/TNZB1dGxKz6HzYBQCgC2eOodtqOJdSpZNqeALwZqEuI
 DFqpAvMiJtrOwf7l1T1ujDu4b5y0MFoi9u9/JAb7eppzTrOWqRV1Eielyobcy6YkxQ5D6V
 mYp08JdTcFEtTlaUcpcdcO6LKBUhXgLUvkDF8vn8Oz+1Wx0Q/AlGDibx/qsu8xqDLhn5UD
 QKf5WWtFFyIZoAaOvykG/5XLuIub+E+gQbvOBepv5ND57PQveefKc1mOeEG7Nh/97n5PHn
 zpZcyJdBbq83CJHY+weiDKFA1P0dMkMu0/GGa58Y2VSzV4V8Ktyb2hkqqSE11FdGz5/Sop
 0DGnoU1FVJWjI7Tb818A/TU7JPhX7TlmBy7irKRxShjcpJzLSa2i0Xtec0Or3ZMIJKuLm9
 lzcb6pNoVDZ8JG2Lc6Zf1QAlCU+dgK2Jt1H+hAkLGjDgTtwmzbacI3FaYVmx56lQv/4K/I
 e3pW6ueJ+YPhUU5Cl9BsvZ6wq4st1FoQCSM86d3X/Q8Gq7Ls9mf7uYYiArpQ
X-ME-Proxy: <xmx:b4R7atU4bBYjyOMzcesDGRrKIUNO3hywPWQnYaLq34Nnh3yFRXAzFw>
 <xmx:b4R7ag2Z_RXb06xCe_3qkxPWPYbfa-Am6v3hwUPUjX0KD37hywtG_w>
 <xmx:b4R7ai1cQnu8Db82r0wE89KD20_2us3YluBH_Y-saHuG2ABly7VF-Q>
 <xmx:b4R7ar8o74OWH_2kBjbrrlugGivHMwzKUeHrXQ3cPudjwrKs6oUM-Q>
 <xmx:b4R7amzW8AjMj9DeA4ZzlJXFrV9JU0VcGgjAiHyHPEC6Uk2bbd3Gfbk_>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:22:07 -0400 (EDT)
Message-ID: <6327945cf92de01961061767b136f33374c2ac1a.camel@alistair23.me>
Subject: Re: [PATCH 29/56] disas/riscv: Handle aliases of csrrwi during decode
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:22:07 +1000
In-Reply-To: <20260809223545.730664-30-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-30-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.157;
 envelope-from=alistair@alistair23.me; helo=fhigh-a6-smtp.messagingengine.com
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
ZToKPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25A
bGluYXJvLm9yZz4KClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFu
Y2lzQHdkYy5jb20+CgpBbGlzdGFpcgoKPiAtLS0KPiDCoGRpc2FzL3Jpc2N2LmggfMKgIDIgLS0K
PiDCoGRpc2FzL3Jpc2N2LmMgfCAyOCArKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gwqAy
IGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pCj4gCj4gZGlm
ZiAtLWdpdCBhL2Rpc2FzL3Jpc2N2LmggYi9kaXNhcy9yaXNjdi5oCj4gaW5kZXggZDhjNWFjZDk2
OS4uM2JiY2JmMTBmYiAxMDA2NDQKPiAtLS0gYS9kaXNhcy9yaXNjdi5oCj4gKysrIGIvZGlzYXMv
cmlzY3YuaAo+IEBAIC04NCw4ICs4NCw2IEBAIHR5cGVkZWYgZW51bSB7Cj4gwqDCoMKgwqAgcnZj
X2ltbV9lcV96ZXJvLAo+IMKgwqDCoMKgIHJ2Y19pbW1fZXFfbjEsCj4gwqDCoMKgwqAgcnZjX2lt
bV9lcV9wMSwKPiAtwqDCoMKgIHJ2Y19jc3JfZXFfMHgwMDEsCj4gLcKgwqDCoCBydmNfY3NyX2Vx
XzB4MDAyLAo+IMKgfSBydmNfY29uc3RyYWludDsKPiDCoAo+IMKgdHlwZWRlZiBlbnVtIHsKPiBk
aWZmIC0tZ2l0IGEvZGlzYXMvcmlzY3YuYyBiL2Rpc2FzL3Jpc2N2LmMKPiBpbmRleCA5ZWM3OWJh
ZjRkLi5kM2NiZmI4NmFjIDEwMDY0NAo+IC0tLSBhL2Rpc2FzL3Jpc2N2LmMKPiArKysgYi9kaXNh
cy9yaXNjdi5jCj4gQEAgLTEwNjMsOCArMTA2Myw2IEBAIHN0YXRpYyBjb25zdCBydmNfY29uc3Ry
YWludCBydmNjX3JldFtdID0gewo+IHJ2Y19yZF9lcV94MCwgcnZjX3JzMV9lcV9yYSwKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBydmNfZW5kIH07Cj4gwqBzdGF0aWMgY29uc3QgcnZj
X2NvbnN0cmFpbnQgcnZjY19qcltdID0geyBydmNfcmRfZXFfeDAsCj4gcnZjX2ltbV9lcV96ZXJv
LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBydmNfZW5kIH07Cj4gLXN0YXRpYyBjb25z
dCBydmNfY29uc3RyYWludCBydmNjX2Zzcm1pW10gPSB7IHJ2Y19jc3JfZXFfMHgwMDIsCj4gcnZj
X2VuZCB9Owo+IC1zdGF0aWMgY29uc3QgcnZjX2NvbnN0cmFpbnQgcnZjY19mc2ZsYWdzaVtdID0g
eyBydmNfY3NyX2VxXzB4MDAxLAo+IHJ2Y19lbmQgfTsKPiDCoAo+IMKgLyogcHNldWRvLWluc3Ry
dWN0aW9uIG1ldGFkYXRhICovCj4gwqAKPiBAQCAtMTE0NSwxMiArMTE0Myw2IEBAIHN0YXRpYyBj
b25zdCBydl9jb21wX2RhdGEgcnZjcF9zdWJ3W10gPSB7Cj4gwqDCoMKgwqAgeyBydl9vcF9pbGxl
Z2FsLCBOVUxMIH0KPiDCoH07Cj4gwqAKPiAtc3RhdGljIGNvbnN0IHJ2X2NvbXBfZGF0YSBydmNw
X2NzcnJ3aVtdID0gewo+IC3CoMKgwqAgeyBydl9vcF9mc3JtaSwgcnZjY19mc3JtaSB9LAo+IC3C
oMKgwqAgeyBydl9vcF9mc2ZsYWdzaSwgcnZjY19mc2ZsYWdzaSB9LAo+IC3CoMKgwqAgeyBydl9v
cF9pbGxlZ2FsLCBOVUxMIH0KPiAtfTsKPiAtCj4gwqBzdGF0aWMgY29uc3QgcnZfY29tcF9kYXRh
IHJ2Y3BfZnNnbmpfc1tdID0gewo+IMKgwqDCoMKgIHsgcnZfb3BfZm12X3MsIHJ2Y2NfZm12X3Mg
fSwKPiDCoMKgwqDCoCB7IHJ2X29wX2lsbGVnYWwsIE5VTEwgfQo+IEBAIC0xNzIyLDcgKzE3MTQs
NyBAQCBzdGF0aWMgY29uc3QgcnZfb3Bjb2RlX2RhdGEgcnZpX29wY29kZV9kYXRhW10gPQo+IHsK
PiDCoMKgwqDCoCB7ICJjc3JydyIsIHJ2X2NvZGVjX2lfY3NyLCBydl9mbXRfcmRfY3NyX3JzMSB9
LAo+IMKgwqDCoMKgIHsgImNzcnJzIiwgcnZfY29kZWNfaV9jc3IsIHJ2X2ZtdF9yZF9jc3JfcnMx
IH0sCj4gwqDCoMKgwqAgeyAiY3NycmMiLCBydl9jb2RlY19pX2NzciwgcnZfZm10X3JkX2Nzcl9y
czEgfSwKPiAtwqDCoMKgIHsgImNzcnJ3aSIsIHJ2X2NvZGVjX2lfY3NyLCBydl9mbXRfcmRfY3Ny
X3ppbW0sIHJ2Y3BfY3NycndpIH0sCj4gK8KgwqDCoCB7ICJjc3Jyd2kiLCBydl9jb2RlY19pX2Nz
ciwgcnZfZm10X3JkX2Nzcl96aW1tIH0sCj4gwqDCoMKgwqAgeyAiY3NycnNpIiwgcnZfY29kZWNf
aV9jc3IsIHJ2X2ZtdF9yZF9jc3JfemltbSB9LAo+IMKgwqDCoMKgIHsgImNzcnJjaSIsIHJ2X2Nv
ZGVjX2lfY3NyLCBydl9mbXRfcmRfY3NyX3ppbW0gfSwKPiDCoMKgwqDCoCB7ICJmbHciLCBydl9j
b2RlY19pLCBydl9mbXRfZnJkX29mZnNldF9yczEgfSwKPiBAQCAtNDQ2OSw3ICs0NDYxLDEzIEBA
IHN0YXRpYyB2b2lkIGRlY29kZV9pbnN0X29wY29kZShydl9kZWNvZGUgKmRlYywKPiBydl9pc2Eg
aXNhKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBicmVhazsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIDU6IG9wID0gcnZf
b3BfY3NycndpOyBicmVhazsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIDU6Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzd2l0Y2ggKG9wZXJhbmRfY3NyMTIoaW5zdCkp
IHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgMTogb3AgPSBydl9vcF9m
c2ZsYWdzaTsgYnJlYWs7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIDI6
IG9wID0gcnZfb3BfZnNybWk7IGJyZWFrOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZGVmYXVsdDogb3AgPSBydl9vcF9jc3Jyd2k7IGJyZWFrOwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgNjogb3AgPSBydl9vcF9jc3Jyc2k7IGJy
ZWFrOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIDc6IG9wID0gcnZfb3BfY3NycmNp
OyBicmVhazsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+IEBAIC00OTkxLDE2ICs0OTg5
LDYgQEAgc3RhdGljIGJvb2wgY2hlY2tfY29uc3RyYWludHMocnZfZGVjb2RlICpkZWMsCj4gY29u
c3QgcnZjX2NvbnN0cmFpbnQgKmMpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIGZhbHNlOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGJyZWFrOwo+IC3CoMKgwqDCoMKgwqDCoCBjYXNlIHJ2Y19jc3JfZXFfMHgw
MDE6Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCEoaW1tID09IDB4MDAxKSkgewo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIH0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiAtwqDCoMKg
wqDCoMKgwqAgY2FzZSBydmNfY3NyX2VxXzB4MDAyOgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGlmICghKGltbSA9PSAweDAwMikpIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybiBmYWxzZTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgYnJlYWs7Cj4gwqDCoMKgwqDCoMKgwqDCoCBkZWZhdWx0OiBicmVhazsKPiDC
oMKgwqDCoMKgwqDCoMKgIH0KPiDCoMKgwqDCoMKgwqDCoMKgIGMrKzsK


