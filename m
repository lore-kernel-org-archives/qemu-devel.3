Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C23EC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtstS-0006dZ-PP; Tue, 11 Aug 2026 16:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtstR-0006dM-BC; Tue, 11 Aug 2026 16:16:13 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtstP-0003NU-3z; Tue, 11 Aug 2026 16:16:13 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 506C91400122;
 Tue, 11 Aug 2026 16:16:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 16:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786479370; x=1786565770; bh=Z0GaMpVdrg8+yJkoHX/2iQZ7QQtOAF9Q
 Cz5s54u8VxI=; b=EC1u1pNmL/y7jcdn/4gP5uvof1YBZrtQMsyt99obZB6Fdev0
 z6033c8q1DC0s+ETniNUL02sWylq8xqJ3r8BeNg+XYxZ8HBxJd1sbPXlbRpKUHgv
 JwMFqiaQFZQBYmXiAny9fuCe9s929/BthBh6WW/PF9ObRlnf4Wgw5TTu847RFgEF
 YAay0hnCQqZiGItSxFl24KxvdvtSAgxiNmrT+4YkhAXU0TPbNLuHWD4LkwqlZAxK
 jQ9wSW/8DAD6h0zJ/kDjoEPtxYIT8VogAxYVnwmacG8R4DWuNf5zx0dQ5CVPKLRT
 wlHZl/rOVbtKIuj022zJTYNQ3CwlJJkTfNrkiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786479370; x=
 1786565770; bh=Z0GaMpVdrg8+yJkoHX/2iQZ7QQtOAF9QCz5s54u8VxI=; b=Q
 Wv7WGlwMCnd2uGvZ/TInQMiUrN1MhNbLr9p24xCdEqTxaLT0m50FmvNU/Fi9plwj
 sqXjZ0mP13jbGQVaPZ4oE1BIObG6ZB7+uJfuk2x4TYSGpOetAFKSh6iGzmKur75I
 fg/FvEjq/HCVQBqyacOhjgo2rYJcP9VF0y0HQn9Dz16YF8c2zlmY+SiLkDxBLgmU
 QjLawIG+pC1nMvG3UYxhnvTyK+4AfUP9KAIEvnghHN0UZ4FfSWOF/7b1+OOi5B7q
 d3J62W5hAKegHu7f/+e/W3SuyKjJvnDas9CiT21L+Bsg3htD4xmbVkDuHWkwpG4Q
 c0VFrMc9FCZpgCpXJ8TRA==
X-ME-Sender: <xms:CoN7akD58xk2JnAkQu68PBmVNLJJiEo2fRnRDRohrTs3QXB275BR0g>
 <xme:CoN7aq2LaCOKGtsSuxwExe7BeD10g_xhuYNqy7C-CPr8mEZS1HZhJFa-216Pf8W-9
 ZLwpmxQT_mwnh8R5LRGG3RfIR803bpJ7TMcYMTsFX3W6LdoApxP6Fw>
X-ME-Received: <xmr:CoN7amuZEaZD2y17qJrpaJHMP_7Jj_xqezcZzAjWpJqImgHDOwImj49L-pKHsFBPOpa4dg>
X-ME-Proxy-Cause: dmFkZTEP9kqAiepBnLUzYTEmm/+7GhepH5FUKkXCUNAwun6jMBS4uzPQKN5cz2waLKnUpA
 asjdfiPoa5vv9iJv40wc63PCJsJjJinY/iZ2S4tROP/G2MLqMbB9Jq4EpHPTABI/nC0nKs
 nI+kb76q/Xkbqw8TyzqLRlbLly2WpLv7qpeBFJ/reatnxTEmZ7r9mP66HXQXNxgcV/9f9O
 L/IgiVNxiq8/gwQUUdkFp5ZqZQh42VRngK3kJtyjdG9e0x32p/Ag6GZ0EPGbtcP0xQHb/s
 U2adUFFtW6uan3ceTkZ6BHsIRGfTFmrH1CL6ZeBloLQsXuyZz4b7OJhaqyy1D08qISOMD5
 iEQgL8mxYK/PrMy9Y0QHkihfeL1TOrYA4orOgkj8+3FHY9FfUE164/5ce5h1+7aj7X06Ue
 s3KYFdwq9pTvvS/ystAi39ypArfDRiCfg8X3zZ+T0ORwi3M2Es2RvZxaIoMgYdX7AZ8pgv
 jrRtIMYgdJmzTS0eReWE9NICci2iXURoKe4mKVoawi1wZje6oGYpbOLcogAONPgmYuRch8
 95LGTnWTcbPT+beMluTKK49Bg8oxmBcj7UFUl9sA8v/1tvQdr7iZtClwp9TqFFQfUYGBqq
 7+/09CZ7fWjSMgyO/Zf0859MYO2bv8oiPbGTfqldPb7KR7vYD2B9bCCkWqWA
X-ME-Proxy: <xmx:CoN7ai5sym87mIC2vNoA6NHq6KtwaVyERE8PZkOovbQIft7oVTNA9A>
 <xmx:CoN7avJrR0kX_4rvwQzcER20eahG5hGPy-J50WTfXv-euUdGh2qc1w>
 <xmx:CoN7aq7lRqahtq-5DrrGn_ckZB-x3NGunzYq-HP4I_EHpH_dZ2FmDA>
 <xmx:CoN7aqyaU4mS1YFu8-gevjkDLGHRO1x2uzHTZu1wt709x5v7_53OJw>
 <xmx:CoN7alXXIGE6MPTV2r2GuCnM0xZ4-dHTYYXSVJ0zUQ12GO5i2Sy1RGah>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:16:10 -0400 (EDT)
Message-ID: <5194f92be870a8195330dd2e321b45a603482403.camel@alistair23.me>
Subject: Re: [PATCH 21/56] disas/riscv: Handle c.{srli,srai} imm during decode
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:16:09 +1000
In-Reply-To: <20260809223545.730664-22-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-22-richard.henderson@linaro.org>
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
ZToKPiBaZXJvIHNoaWZ0IGltbWVkaWF0ZSB0byBjLnNybGkgYW5kIGMuc3JhaSBhcmUgbm90IGls
bGVnYWwsCj4gYnV0IGFyZSByZXNlcnZlZCBhcyBISU5Ucy7CoCBHbyBhaGVhZCBhbmQgZGlzYXNz
ZW1ibGUgYXMKPiBzaGlmdHMgcmF0aGVyIHRoYW4gZmFsbGluZyBiYWNrIHRvIGludmFsaWQuCj4g
Cj4gT24gdGhlIG90aGVyIGhhbmQsIHNoaWZ0IGltbWVkaWF0ZSA+PSAzMiB3aXRoIFJWMzIgaXMK
PiByZXNlcnZlZCBmb3IgY3VzdG9tIGV4dGVuc2lvbnMsIGFuZCB3ZSBuZWVkIHRvIHJlamVjdCB0
aG9zZQo+IGVhcmx5IHNvIHRoYXQgdGhlIGV4dGVuc2lvbiBkaXNhc3NlbWJsZXJzIGdldCBhIGxv
b2sgaW4uCj4gCj4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVu
ZGVyc29uQGxpbmFyby5vcmc+CgpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3Rh
aXIuZnJhbmNpc0B3ZGMuY29tPgoKQWxpc3RhaXIKCj4gLS0tCj4gwqBkaXNhcy9yaXNjdi5jIHwg
MTQgKysrKysrKysrKy0tLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kaXNhcy9yaXNjdi5jIGIvZGlzYXMvcmlz
Y3YuYwo+IGluZGV4IGQ2ZmJiM2JjYTYuLmE4ZmJlZmI5YmQgMTAwNjQ0Cj4gLS0tIGEvZGlzYXMv
cmlzY3YuYwo+ICsrKyBiL2Rpc2FzL3Jpc2N2LmMKPiBAQCAtMTkwNiw5ICsxOTA2LDkgQEAgc3Rh
dGljIGNvbnN0IHJ2X29wY29kZV9kYXRhIHJ2aV9vcGNvZGVfZGF0YVtdID0KPiB7Cj4gwqDCoMKg
wqAgeyAiYy5sdWkiLCBydl9jb2RlY19jaV9sdWksIHJ2X2ZtdF9yZF91aW1tLCBOVUxMLCBydl9v
cF9sdWksCj4gcnZfb3BfbHVpLAo+IMKgwqDCoMKgwqDCoCBydl9vcF9sdWkgfSwKPiDCoMKgwqDC
oCB7ICJjLnNybGkiLCBydl9jb2RlY19jYl9zaDYsIHJ2X2ZtdF9yZF9yczFfaW1tLCBOVUxMLAo+
IHJ2X29wX3NybGksCj4gLcKgwqDCoMKgwqAgcnZfb3Bfc3JsaSwgcnZfb3Bfc3JsaSwgcnZjZF9p
bW1fbnogfSwKPiArwqDCoMKgwqDCoCBydl9vcF9zcmxpLCBydl9vcF9zcmxpIH0sCj4gwqDCoMKg
wqAgeyAiYy5zcmFpIiwgcnZfY29kZWNfY2Jfc2g2LCBydl9mbXRfcmRfcnMxX2ltbSwgTlVMTCwK
PiBydl9vcF9zcmFpLAo+IC3CoMKgwqDCoMKgIHJ2X29wX3NyYWksIHJ2X29wX3NyYWksIHJ2Y2Rf
aW1tX256IH0sCj4gK8KgwqDCoMKgwqAgcnZfb3Bfc3JhaSwgcnZfb3Bfc3JhaSB9LAo+IMKgwqDC
oMKgIHsgImMuYW5kaSIsIHJ2X2NvZGVjX2NiX2ltbSwgcnZfZm10X3JkX3JzMV9pbW0sIE5VTEws
Cj4gcnZfb3BfYW5kaSwKPiDCoMKgwqDCoMKgwqAgcnZfb3BfYW5kaSwgcnZfb3BfYW5kaSB9LAo+
IMKgwqDCoMKgIHsgImMuc3ViIiwgcnZfY29kZWNfY3MsIHJ2X2ZtdF9yZF9yczFfcnMyLCBOVUxM
LCBydl9vcF9zdWIsCj4gcnZfb3Bfc3ViLAo+IEBAIC0zMDQyLDEwICszMDQyLDE2IEBAIHN0YXRp
YyB2b2lkIGRlY29kZV9pbnN0X29wY29kZShydl9kZWNvZGUKPiAqZGVjLCBydl9pc2EgaXNhKQo+
IMKgwqDCoMKgwqDCoMKgwqAgY2FzZSA0Ogo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzd2l0
Y2ggKChpbnN0ID4+IDEwKSAmIDBiMTEpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2Fz
ZSAwOgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3AgPSBydl9vcF9jX3NybGk7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBGb3IgcnYzMiwgc2hhbXRbNV09
MSBpcyBkZXNpZ25hdGVkIGZvciBjdXN0b20KPiBleHRlbnNpb25zLiAqLwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGlzYSAhPSBydjMyIHx8IChpbnN0ICYgMHgxMDAwKSA9
PSAwKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9wID0gcnZf
b3BfY19zcmxpOyAvKiBvciB1bnNwZWNpZmllZCBISU5UICovCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB9Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgMToKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIG9wID0gcnZfb3BfY19zcmFpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgLyogRm9yIHJ2MzIsIHNoYW10WzVdPTEgaXMgZGVzaWduYXRlZCBmb3IgY3VzdG9t
Cj4gZXh0ZW5zaW9ucy4gKi8KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChp
c2EgIT0gcnYzMiB8fCAoaW5zdCAmIDB4MTAwMCkgPT0gMCkgewo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvcCA9IHJ2X29wX2Nfc3JhaTsgLyogb3IgdW5zcGVjaWZp
ZWQgSElOVCAqLwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjYXNlIDI6IG9wID0gcnZfb3BfY19hbmRpOyBicmVhazsKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgY2FzZSAzOgo=


