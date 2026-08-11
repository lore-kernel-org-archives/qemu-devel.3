Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDA7C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsxr-00014u-SX; Tue, 11 Aug 2026 16:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsxh-00010G-9I; Tue, 11 Aug 2026 16:20:38 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsxf-00045f-Qj; Tue, 11 Aug 2026 16:20:37 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 137D21400106;
 Tue, 11 Aug 2026 16:20:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 11 Aug 2026 16:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786479635; x=1786566035; bh=SJNmDYvGYwKd0VaZPzWVmc2jzAOjPzwZ
 R4ojhzPHo1w=; b=NcHzfJmnt7fdTUCi1Fb07XA86IceX1clNd30nnnzbzSX8gJQ
 Rsn5flTnomkZyRQxtVOSTQKWg7n4LBzOZZt1c40JchiF09BzYoiDRftm/Uu4WPEb
 VNaHHctSp1+CQ7smE7B2bQYCRP+Mg2W7E3KsPxDL9ZwhJriQ8PWq+A6DAncnwUTR
 AFxQVkpVGAiqW5YUAQ54vn90uCqa0eBmmr8U7KvrXwQHbn5gtiHjIFzo/0fltWWV
 M9EVAhfdS4EundKVFNl2SVSmimSpsYo1FWqtpd6788Z9u611h5lHSlXgkoxluKEc
 ZdLguI3MlPclnWcoD9o2TLrFkYdwZQKpdUhG3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786479635; x=
 1786566035; bh=SJNmDYvGYwKd0VaZPzWVmc2jzAOjPzwZR4ojhzPHo1w=; b=P
 7IzH7V1VvtsL61h/TxBiIjlwwbw5DhYpUG0tXeK8UunBdT6KII2lpYHINO5vdNnu
 weQKaTxxODKI0uEEpYaJymCqfAZwMyFIhUgSvHP4+aagG2jzlJs5YC0WMQxedUNz
 Gy1AhJ7f8nzOlTlCE9VYE7x6imJ4YNRmE9TU+g579MsI4oQzKxmcCQufneK21ZOh
 GJZfw0GbIsjcVWvFuTWwN985Xc5DCYPSqLvcK52QlZNKXvdEvP1jLLrkOhowXt5+
 ws2l/8TMm6CXRZZvDvHG1zEAp/eGPN9+6PsziRv+PutA73qBKoZyAeeAKnCqGBvz
 V9T131A8aQyhTa/SfpgqA==
X-ME-Sender: <xms:EoR7ahM85O7c-bW5HyYn1qjfW-rVLfxzXSGuXgnuUU1DEUdeyB3bJg>
 <xme:EoR7aoSRQj7Mz1p-DOELJZ5_1orQXUpnaJu2zhMGKyBL3ca40t-3E17LH0MG162Tw
 Vj1y2nEcLybE7-2rb7xTbgkBrFFb2W-LorKhdfFOh4zr40g-FQ00w>
X-ME-Received: <xmr:EoR7avY_Wcp5wdsXLkCvqFMqi5uf0X_bqOaIgjm93M50-h2vaJhhVsYyn4DdYi8i2inAog>
X-ME-Proxy-Cause: dmFkZTE0EZyRZ7wKPWgKPXWQORKjyGpPS2MXjeq7cO5+xq581WzrhI4X6Z/eKYPJqimyGV
 eBh135KcADSLxdtMQb3+CThtL4jkcoJeOaMfFjYssGEAwo9Th+FktpBmFO0Hx/OaA5IKAM
 WWFj1Yxed6ihZbWE3ss7Ki2u1KRuhrh+nsnEcg/+UvugGikBQHU9zCz4LdzSJ787B5Sx4w
 rEJ02Ya1x9DyBFIBJskbnXhTLOvjhyEId4Lz82HVQFJNpAIXUr7dEy5FDtQOPHKp/ziRK8
 lWeQRlKaqTQEzvHgovHVNNePqFfQvh8F2ZZPjC8QpM9U/2vZxSlwFXhVU1OJ646aJQPbsE
 McxhsLj61b8k7gqpOi153XN5bZ01UlEixTeMvRhP4dcvVdTXrzg3aPqIMyOaEiOt5lFmEm
 XOtXBuyAj97LRJHmNcAPQ3S0kynAD234LSc7Phy/j6+fKPvlOLeRRgsSi0/ytjK8Cxq3HD
 xZexg2aNGq9XG9pDRpkN5iJ6ECBvohSHDfGIdHGk9DJqhF02YjWl70dcXEiuBQNZFzqJ1G
 ho9/ieouOQCTYgNkyyhEzLp1cJ/A6Ot/ttK20Yfi38xvgtE8CyqKItc9t1xgz4k9y93Jvh
 KNyCiN9XOjqoe50v+Jasa3qSkBg6WT7y3ZgYGS7PSU/guB1engzNHMoJdhjA
X-ME-Proxy: <xmx:EoR7al03EVSBlvvMnAPwcawo4cwoAQTJUviO2Y96BFbOp20sYJvyTA>
 <xmx:EoR7avUoTCcJwyscnxJiytpCz3IFglw0zLPw3LNN7CiMELDCdfuFyw>
 <xmx:EoR7avUR4EiLl-JRy9cRv8nF5NkJxwIWJyZiMT_mM3zO_tdtvFmV9w>
 <xmx:EoR7auc-x8WVWbK2Oug-2pzGBtg_7vyxkCuSe-r5vvp8n4MTlZP7mQ>
 <xmx:E4R7anR9pBCmNdz5MLTHBYXoBF-W1IsyUZzOZWCWSq4vjOS2nZokSIgh>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:20:34 -0400 (EDT)
Message-ID: <3f7e759627bab0242cb6953f05d822ee87479335.camel@alistair23.me>
Subject: Re: [PATCH 27/56] disas/riscv: Handle aliases of csrrw during decode
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:20:34 +1000
In-Reply-To: <20260809223545.730664-28-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-28-richard.henderson@linaro.org>
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
Y2lzQHdkYy5jb20+CgpBbGlzdGFpcgoKPiAtLS0KPiDCoGRpc2FzL3Jpc2N2LmMgfCAyMiArKysr
KysrKystLS0tLS0tLS0tLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAx
MyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZGlzYXMvcmlzY3YuYyBiL2Rpc2FzL3Jp
c2N2LmMKPiBpbmRleCBiZGUxY2M2ZTYyLi5lNDY0YjhiMDc1IDEwMDY0NAo+IC0tLSBhL2Rpc2Fz
L3Jpc2N2LmMKPiArKysgYi9kaXNhcy9yaXNjdi5jCj4gQEAgLTEwODEsOSArMTA4MSw2IEBAIHN0
YXRpYyBjb25zdCBydmNfY29uc3RyYWludCBydmNjX2Zycm1bXSA9IHsKPiBydmNfcnMxX2VxX3gw
LCBydmNfY3NyX2VxXzB4MDAyLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcnZj
X2VuZCB9Owo+IMKgc3RhdGljIGNvbnN0IHJ2Y19jb25zdHJhaW50IHJ2Y2NfZnJmbGFnc1tdID0g
eyBydmNfcnMxX2VxX3gwLAo+IHJ2Y19jc3JfZXFfMHgwMDEsCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBydmNfZW5kIH07Cj4gLXN0YXRpYyBjb25zdCBydmNfY29uc3Ry
YWludCBydmNjX2ZzY3NyW10gPSB7IHJ2Y19jc3JfZXFfMHgwMDMsCj4gcnZjX2VuZCB9Owo+IC1z
dGF0aWMgY29uc3QgcnZjX2NvbnN0cmFpbnQgcnZjY19mc3JtW10gPSB7IHJ2Y19jc3JfZXFfMHgw
MDIsCj4gcnZjX2VuZCB9Owo+IC1zdGF0aWMgY29uc3QgcnZjX2NvbnN0cmFpbnQgcnZjY19mc2Zs
YWdzW10gPSB7IHJ2Y19jc3JfZXFfMHgwMDEsCj4gcnZjX2VuZCB9Owo+IMKgc3RhdGljIGNvbnN0
IHJ2Y19jb25zdHJhaW50IHJ2Y2NfZnNybWlbXSA9IHsgcnZjX2Nzcl9lcV8weDAwMiwKPiBydmNf
ZW5kIH07Cj4gwqBzdGF0aWMgY29uc3QgcnZjX2NvbnN0cmFpbnQgcnZjY19mc2ZsYWdzaVtdID0g
eyBydmNfY3NyX2VxXzB4MDAxLAo+IHJ2Y19lbmQgfTsKPiDCoAo+IEBAIC0xMTY2LDE0ICsxMTYz
LDYgQEAgc3RhdGljIGNvbnN0IHJ2X2NvbXBfZGF0YSBydmNwX3N1YndbXSA9IHsKPiDCoMKgwqDC
oCB7IHJ2X29wX2lsbGVnYWwsIE5VTEwgfQo+IMKgfTsKPiDCoAo+IC1zdGF0aWMgY29uc3QgcnZf
Y29tcF9kYXRhIHJ2Y3BfY3NycndbXSA9IHsKPiAtwqDCoMKgIHsgcnZfb3BfZnNjc3IsIHJ2Y2Nf
ZnNjc3IgfSwKPiAtwqDCoMKgIHsgcnZfb3BfZnNybSwgcnZjY19mc3JtIH0sCj4gLcKgwqDCoCB7
IHJ2X29wX2ZzZmxhZ3MsIHJ2Y2NfZnNmbGFncyB9LAo+IC3CoMKgwqAgeyBydl9vcF9pbGxlZ2Fs
LCBOVUxMIH0KPiAtfTsKPiAtCj4gLQo+IMKgc3RhdGljIGNvbnN0IHJ2X2NvbXBfZGF0YSBydmNw
X2NzcnJzW10gPSB7Cj4gwqDCoMKgwqAgeyBydl9vcF9yZGN5Y2xlLCBydmNjX3JkY3ljbGUgfSwK
PiDCoMKgwqDCoCB7IHJ2X29wX3JkdGltZSwgcnZjY19yZHRpbWUgfSwKPiBAQCAtMTc2MSw3ICsx
NzUwLDcgQEAgc3RhdGljIGNvbnN0IHJ2X29wY29kZV9kYXRhIHJ2aV9vcGNvZGVfZGF0YVtdID0K
PiB7Cj4gwqDCoMKgwqAgeyAic2ZlbmNlLnZtIiwgcnZfY29kZWNfciwgcnZfZm10X3JzMSB9LAo+
IMKgwqDCoMKgIHsgInNmZW5jZS52bWEiLCBydl9jb2RlY19yLCBydl9mbXRfcnMxX3JzMiB9LAo+
IMKgwqDCoMKgIHsgIndmaSIsIHJ2X2NvZGVjX25vbmUsIHJ2X2ZtdF9ub25lIH0sCj4gLcKgwqDC
oCB7ICJjc3JydyIsIHJ2X2NvZGVjX2lfY3NyLCBydl9mbXRfcmRfY3NyX3JzMSwgcnZjcF9jc3Jy
dyB9LAo+ICvCoMKgwqAgeyAiY3NycnciLCBydl9jb2RlY19pX2NzciwgcnZfZm10X3JkX2Nzcl9y
czEgfSwKPiDCoMKgwqDCoCB7ICJjc3JycyIsIHJ2X2NvZGVjX2lfY3NyLCBydl9mbXRfcmRfY3Ny
X3JzMSwgcnZjcF9jc3JycyB9LAo+IMKgwqDCoMKgIHsgImNzcnJjIiwgcnZfY29kZWNfaV9jc3Is
IHJ2X2ZtdF9yZF9jc3JfcnMxIH0sCj4gwqDCoMKgwqAgeyAiY3NycndpIiwgcnZfY29kZWNfaV9j
c3IsIHJ2X2ZtdF9yZF9jc3JfemltbSwgcnZjcF9jc3Jyd2kgfSwKPiBAQCAtNDQ0Myw3ICs0NDMy
LDE0IEBAIHN0YXRpYyB2b2lkIGRlY29kZV9pbnN0X29wY29kZShydl9kZWNvZGUgKmRlYywKPiBy
dl9pc2EgaXNhKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJl
YWs7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2Ug
MTogb3AgPSBydl9vcF9jc3JydzsgYnJlYWs7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2Fz
ZSAxOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3dpdGNoIChvcGVyYW5kX2Nz
cjEyKGluc3QpKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIDE6IG9w
ID0gcnZfb3BfZnNmbGFnczsgYnJlYWs7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjYXNlIDI6IG9wID0gcnZfb3BfZnNybTsgYnJlYWs7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjYXNlIDM6IG9wID0gcnZfb3BfZnNjc3I7IGJyZWFrOwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVmYXVsdDogb3AgPSBydl9vcF9jc3JydzsgYnJlYWs7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBicmVhazsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSAyOiBvcCA9
IHJ2X29wX2NzcnJzOyBicmVhazsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSAzOiBv
cCA9IHJ2X29wX2NzcnJjOyBicmVhazsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSA0
Ogo=


