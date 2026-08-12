Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9699C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8Ww-0007IC-A0; Wed, 12 Aug 2026 08:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu8We-0007Ad-T2; Wed, 12 Aug 2026 08:57:46 -0400
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu8WZ-0002j1-AT; Wed, 12 Aug 2026 08:57:44 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id A04AEEC01AC;
 Wed, 12 Aug 2026 08:57:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 12 Aug 2026 08:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786539457; x=1786625857; bh=Au1QFiPAj99+CckM0sclW9UCGpjAy8pR
 0iuJ+7uXcOk=; b=Vy+xOJm9N92JZ+HgnxzQTBSoyyCfQlws8m6U1dHUzS6+5Rs1
 uPv8Nak1qKjVVO1KZOWLGvkIjTuho0CowH0rbZ7YBK2fxkBOHCkQhDpLXcw37T/5
 D6neqRx23zQyj5A8cIzozLDEhi8ivfy+n/xQiqzVkiP4HYIA9VGyQVBPf5L+NgPU
 16qSm+HhH/piPleAZ+WBxZ5ttAjmfnJJX/lcYxpgktigIILo2GubvfkZswX71MzJ
 VaB7JDMZoyrmVfRq8b+OYygDPxibdkcF85CqlwNsYpxdyUjpPY8JGvafyDue6yuE
 Yie9GJpTxxc3vG7mbGGQAKg87wtWBEAXRCoK0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786539457; x=
 1786625857; bh=Au1QFiPAj99+CckM0sclW9UCGpjAy8pR0iuJ+7uXcOk=; b=l
 fjB1W2QXJYKMV4LrfJgEKFpoA2yVMggSGQ0DRShyIylggA91CNWxa6wDv9vVibeq
 UocL7CZJgc4iKb9CSYGmNbz5lk46XvlgHfmYI3MSbmZ1btp54lJmdEtF1vvmqWXl
 NFP0/YALiLTcRCST+s+yZpL+sh8wsrTAhdkjZJixbIiiVUaOl3baOM+2Qv8Jitvb
 suaUhW33m9RQX+uvOI6WcqMOmVeDQ/rEQktDUJbnGdtysm04p3AOwvAvvMr1N2OL
 eIxwYTtH9Iyev9ab6y22zs87ORPknIZDr4hE7D5uO1XLQEiB0Dc7Uw0QbwiGHaLB
 /4QyZoUUGBqJplyZHTGZg==
X-ME-Sender: <xms:wW18an7mwnFgkJC1uLcBA3OVYbymfcJNVxfhkl2NN7kUYnYnOeejbg>
 <xme:wW18ahND0ehNI_wLkVCbpGg09nj-MwNkAtyJ4HvmAoy3ZsCNAhW8adsxDIgceA90u
 gMAZfgksHjijlBZVwNEOmDClBG1DM2OIQRJAXGsNY9BxPA2veJeCUBR>
X-ME-Received: <xmr:wW18atlTdU7reqdn7o9jmn0HmTJ3IvCyvvDnDV3csIfZEYG59jOVWHvOkzdud_irzS2PlQ>
X-ME-Proxy-Cause: dmFkZTEn/h1HsYL9SQSYKc/le2Y/f6khyiVUuJriweaacEMJ9c/rJRbtyk6NFqTjjZUezT
 oBfdqDt8pt/Xc926V7AocRhKTePGPv+BfDaI57Dsu13L7uq/6Q0/9vha0kMYynN8ycVSyu
 hebenHBebcjmdRtWf0Yz8/M0x5CpqshIEtHQHYQ9M5Fd/BHJQPIQMtNrqH5Iy372vsypVJ
 39xCmMQ5KlDhTUp9xGqfFdiN3z0IhAkww3K35/mYi4vKXTnWJwbFGX+GvCRcsihGmYuKTa
 ClbMjMurRGnH5YiXfgNtBGTCGhYuafMR0MgJMYjOKM+9qB4eaPDozS+14sCdgNSFYsfqBH
 Uhkb96eFB/+Q2JksSc6ZMbdf3WeEC/uLfH02NpaZLUNu+XUf8QBJ9tLt6HWE/RiwKNfeks
 zyw7VJ7u0iKHBjsF8rOeXij9A7itgASG0Y57HM9XGZZEfeIW9wyNTADJ4TG5K582cth8hB
 PHjdm/vTHnQwaNAHZWe7Jxf/XkHsLnV3CmZ+5UY3T65NlcN2FFafG+S4lBbn5NUmuTZN5P
 6IXHxqivPjYwFq34EAv2rWVnH+ifQJm9mpR/KwEA/KRBxRO3k9w70b23xBGQw8xHXV+53N
 DYx42IeHkgYovz0okK0n09uR5zJTvvFI4p3WAli190aq6pKtGirDIU9lyYSA
X-ME-Proxy: <xmx:wW18agShJ_2TD8_cXC-7LzWNObb1sm0XhgoT49QFC5kvJhlRFaOuSg>
 <xmx:wW18ahAvt4AZvTuhD2euqyISm0J82Ath59nLN3iQZRNM9jcvEEiL_A>
 <xmx:wW18anTt0Y3_J_GsArh_yKlOqgldb6InjbWQ0iY2jpI_BKXy1flTlA>
 <xmx:wW18avrNCeduqexcIesbodFoYLf09qm2GwFywcc85XEexNfFdQCTCQ>
 <xmx:wW18aovpKmB9m8EqM145YPrezhB6J0WQ9rUgg9yf0JXkVBAHxLz1-DQa>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 08:57:37 -0400 (EDT)
Message-ID: <6d79e89585820642dc9bf05ac51c9b0bffec29c5.camel@alistair23.me>
Subject: Re: [PATCH 51/56] disas/riscv: Merge all mop.rr.n to one pattern
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 22:57:36 +1000
In-Reply-To: <20260809223545.730664-52-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-52-richard.henderson@linaro.org>
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
ZToKPiBBdm9pZCBwZXJmb3JtaW5nIGFyaXRobWV0aWMgb24gcnZfb3BfbW9wX3JyXzAuCj4gVHJl
YXQgdGhlICduJyBhcyBhbiBpbW1lZGlhdGUuCj4gQ3JlYXRlIGEgY29kZWMgYW5kIGZvcm1hdCB0
byBtYXRjaC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5o
ZW5kZXJzb25AbGluYXJvLm9yZz4KClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlz
dGFpci5mcmFuY2lzQHdkYy5jb20+CgpBbGlzdGFpcgoKPiAtLS0KPiDCoGRpc2FzL3Jpc2N2LmjC
oMKgwqDCoMKgwqDCoCB8wqAgMiArKwo+IMKgZGlzYXMvcmlzY3YuY8KgwqDCoMKgwqDCoMKgIHwg
MTMgKysrKysrKysrKysrLQo+IMKgZGlzYXMvcmlzY3Ytb3AuYy5pbmMgfMKgIDkgKy0tLS0tLS0t
Cj4gwqAzIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4g
Cj4gZGlmZiAtLWdpdCBhL2Rpc2FzL3Jpc2N2LmggYi9kaXNhcy9yaXNjdi5oCj4gaW5kZXggYjQ3
YTdmMDE1MC4uNDc2NDdmNzUwZiAxMDA2NDQKPiAtLS0gYS9kaXNhcy9yaXNjdi5oCj4gKysrIGIv
ZGlzYXMvcmlzY3YuaAo+IEBAIC0xNjEsNiArMTYxLDcgQEAgdHlwZWRlZiBlbnVtIHsKPiDCoMKg
wqDCoCBydl9jb2RlY19scCwKPiDCoMKgwqDCoCBydl9jb2RlY19jbW9wX3NzLAo+IMKgwqDCoMKg
IHJ2X2NvZGVjX21vcF9yLAo+ICvCoMKgwqAgcnZfY29kZWNfbW9wX3JyLAo+IMKgfSBydl9jb2Rl
YzsKPiDCoAo+IMKgLyogc3RydWN0dXJlcyAqLwo+IEBAIC0yODYsNSArMjg3LDYgQEAgdHlwZWRl
ZiBzdHJ1Y3Qgewo+IMKgI2RlZmluZSBydl9mbXRfcmQyX2ltbcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAiT1x0MCwyLCgxKSxpIgo+IMKgI2RlZmluZSBydl9mbXRfZmxpwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIk9cdDMsaCIKPiDCoCNkZWZpbmUgcnZfZm10
X21vcF9ywqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiTy5pXHQwLDEiCj4gKyNk
ZWZpbmUgcnZfZm10X21vcF9ycsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJPLmlc
dDAsMSwyIgo+IMKgCj4gwqAjZW5kaWYgLyogRElTQVNfUklTQ1ZfSCAqLwo+IGRpZmYgLS1naXQg
YS9kaXNhcy9yaXNjdi5jIGIvZGlzYXMvcmlzY3YuYwo+IGluZGV4IDQ1MGE1YzgxNDIuLjZlYzYy
YTU4MzAgMTAwNjQ0Cj4gLS0tIGEvZGlzYXMvcmlzY3YuYwo+ICsrKyBiL2Rpc2FzL3Jpc2N2LmMK
PiBAQCAtNjUwLDYgKzY1MCwxMSBAQCBzdGF0aWMgdWludDMyX3Qgb3BlcmFuZF9tb3Bfcl9pbW0o
cnZfaW5zdCBpbnN0KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXh0cmFjdDMyKGluc3QsIDIw
LCAyKTsKPiDCoH0KPiDCoAo+ICtzdGF0aWMgdWludDMyX3Qgb3BlcmFuZF9tb3BfcnJfaW1tKHJ2
X2luc3QgaW5zdCkKPiArewo+ICvCoMKgwqAgcmV0dXJuIChleHRyYWN0MzIoaW5zdCwgMzAsIDEp
IDw8IDIpIHwgZXh0cmFjdDMyKGluc3QsIDI2LCAyKTsKPiArfQo+ICsKPiDCoC8qIGluc3RydWN0
aW9uIG1ldGFkYXRhICovCj4gwqAKPiDCoHN0YXRpYyBjb25zdCBydl9vcGNvZGVfZGF0YSBydmlf
b3Bjb2RlX2RhdGFbXSA9IHsKPiBAQCAtMjU3Miw3ICsyNTc3LDcgQEAgc3RhdGljIGNvbnN0IHJ2
X29wY29kZV9kYXRhCj4gKmRlY29kZV9pbnN0X29wY29kZShydl9kZWNvZGUgKmRlYywgcnZfaXNh
IGlzYSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCA9PSAwYjEwMDAwMDEpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW1tX21vcDMgPSBkZXBvc2l0MzIoZXh0cmFjdDMyKGlu
c3QsIDI2LCAyKSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMiwgMSwgZXh0
cmFjdDMyKGluc3QsCj4gMzAsIDEpKTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBvcCA9IHJ2X29wX21vcF9ycl8wICsgaW1tX21vcDM7Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3AgPSBydl9vcF9tb3Bf
cnI7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8q
IGlmIHppY2Zpc3MgZW5hYmxlZCBhbmQgbW9wMyBpcyBzaGFkb3cKPiBzdGFjayAqLwo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZGVjLT5jZmct
PmV4dF96aWNmaXNzICYmCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKChpbW1fbW9wMyAmIDBiMTExKSA9PSAwYjExMSkpIHsKPiBAQCAt
MzA2MSw2ICszMDY2LDEyIEBAIHN0YXRpYyB2b2lkIGRlY29kZV9pbnN0X29wZXJhbmRzKHJ2X2Rl
Y29kZQo+ICpkZWMsIHJ2X2lzYSBpc2EsCj4gwqDCoMKgwqDCoMKgwqDCoCBkZWMtPnJzMSA9IG9w
ZXJhbmRfcnMxKGluc3QpOwo+IMKgwqDCoMKgwqDCoMKgwqAgZGVjLT5pbW0gPSBvcGVyYW5kX21v
cF9yX2ltbShpbnN0KTsKPiDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ICvCoMKgwqAgY2FzZSBy
dl9jb2RlY19tb3BfcnI6Cj4gK8KgwqDCoMKgwqDCoMKgIGRlYy0+cmQgPSBvcGVyYW5kX3JkKGlu
c3QpOwo+ICvCoMKgwqDCoMKgwqDCoCBkZWMtPnJzMSA9IG9wZXJhbmRfcnMxKGluc3QpOwo+ICvC
oMKgwqDCoMKgwqDCoCBkZWMtPnJzMiA9IG9wZXJhbmRfcnMyKGluc3QpOwo+ICvCoMKgwqDCoMKg
wqDCoCBkZWMtPmltbSA9IG9wZXJhbmRfbW9wX3JyX2ltbShpbnN0KTsKPiArwqDCoMKgwqDCoMKg
wqAgYnJlYWs7Cj4gwqDCoMKgwqAgZGVmYXVsdDoKPiDCoMKgwqDCoMKgwqDCoMKgIGdfYXNzZXJ0
X25vdF9yZWFjaGVkKCk7Cj4gwqDCoMKgwqAgfQo+IGRpZmYgLS1naXQgYS9kaXNhcy9yaXNjdi1v
cC5jLmluYyBiL2Rpc2FzL3Jpc2N2LW9wLmMuaW5jCj4gaW5kZXggMjIyZDI0OWE3MC4uMjEwMGU1
NDQ3NSAxMDA2NDQKPiAtLS0gYS9kaXNhcy9yaXNjdi1vcC5jLmluYwo+ICsrKyBiL2Rpc2FzL3Jp
c2N2LW9wLmMuaW5jCj4gQEAgLTg3NCwxNCArODc0LDcgQEAgT1AoYW1vY2FzX3csICJhbW9jYXMu
dyIsIHJ2X2NvZGVjX3JfYSwKPiBydl9mbXRfYXFybF9yZF9yczJfcnMxKQo+IMKgT1AoYW1vY2Fz
X2QsICJhbW9jYXMuZCIsIHJ2X2NvZGVjX3JfYSwgcnZfZm10X2FxcmxfcmRfcnMyX3JzMSkKPiDC
oE9QKGFtb2Nhc19xLCAiYW1vY2FzLnEiLCBydl9jb2RlY19yX2EsIHJ2X2ZtdF9hcXJsX3JkX3Jz
Ml9yczEpCj4gwqBPUChtb3BfciwgIm1vcC5yIiwgcnZfY29kZWNfbW9wX3IsIHJ2X2ZtdF9tb3Bf
cikKPiAtT1AobW9wX3JyXzAsICJtb3AucnIuMCIsIHJ2X2NvZGVjX3IsIHJ2X2ZtdF9yZF9yczFf
cnMyKQo+IC1PUChtb3BfcnJfMSwgIm1vcC5yci4xIiwgcnZfY29kZWNfciwgcnZfZm10X3JkX3Jz
MV9yczIpCj4gLU9QKG1vcF9ycl8yLCAibW9wLnJyLjIiLCBydl9jb2RlY19yLCBydl9mbXRfcmRf
cnMxX3JzMikKPiAtT1AobW9wX3JyXzMsICJtb3AucnIuMyIsIHJ2X2NvZGVjX3IsIHJ2X2ZtdF9y
ZF9yczFfcnMyKQo+IC1PUChtb3BfcnJfNCwgIm1vcC5yci40IiwgcnZfY29kZWNfciwgcnZfZm10
X3JkX3JzMV9yczIpCj4gLU9QKG1vcF9ycl81LCAibW9wLnJyLjUiLCBydl9jb2RlY19yLCBydl9m
bXRfcmRfcnMxX3JzMikKPiAtT1AobW9wX3JyXzYsICJtb3AucnIuNiIsIHJ2X2NvZGVjX3IsIHJ2
X2ZtdF9yZF9yczFfcnMyKQo+IC1PUChtb3BfcnJfNywgIm1vcC5yci43IiwgcnZfY29kZWNfciwg
cnZfZm10X3JkX3JzMV9yczIpCj4gK09QKG1vcF9yciwgIm1vcC5yciIsIHJ2X2NvZGVjX21vcF9y
ciwgcnZfZm10X21vcF9ycikKPiDCoE9QKGNfbW9wXzEsICJjLm1vcC4xIiwgcnZfY29kZWNfY2lf
bm9uZSwgcnZfZm10X25vbmUpCj4gwqBPUChjX21vcF8zLCAiYy5tb3AuMyIsIHJ2X2NvZGVjX2Np
X25vbmUsIHJ2X2ZtdF9ub25lKQo+IMKgT1AoY19tb3BfNSwgImMubW9wLjUiLCBydl9jb2RlY19j
aV9ub25lLCBydl9mbXRfbm9uZSkK


