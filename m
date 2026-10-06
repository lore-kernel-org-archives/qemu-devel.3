Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EE3CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN5g-0006m8-SV; Wed, 07 Oct 2026 04:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xEHqb-00075g-VS
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:57:47 -0400
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xEHqX-0005P0-FH
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:57:36 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 115E91D000FD
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2026 12:01:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Tue, 06 Oct 2026 12:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1791302490; x=1791388890; bh=lvYaFXklwPJOLjlynE1+2oA/w8Tkcx5O
 CJUYiP31nE4=; b=HtX4Za3JeGLN2ehrMPLWjoxCsU34hbUAZpUsn1irBxSMlmOO
 FFXhhI9Grhi7kyL7srCximO1fS8KLm2/ehpSmVULSARLnjjabT58eYtQEYUskqcQ
 416BVzv15ZtCcaefdSva0DBxbDTGOOQakU4NwZ8nePaN+C8FAjm5IC9+ODv0tSnM
 5T2gfa9m66R72khsFCT99S+dJEd8oyGKmPM/V7++fxxy9Nk7quTeGbmWk5dK+G9D
 J9GVXE8HWHjVhjL0EvAVgTA2JbjtZJ5M+x848eDSktsirJvpLPDc3eY6i0ltpbe1
 88NjqGJxx4ZXHjvg3p5ccF5cRIf/QaxoaZ16eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791302490; x=
 1791388890; bh=lvYaFXklwPJOLjlynE1+2oA/w8Tkcx5OCJUYiP31nE4=; b=Z
 7wm8MwIgTwWobZK/h2dZ3I+Pvt84GM0UkcmJ0dJmqewnFTxNjwRpxBTPzDWYQoLv
 ver/Ki1y7MNWX5LDktCmcL0ZKh5ya5e1LQGGWItMTGV/AL/UzeLCr6DOIS0L/I2F
 zlTu5TC0JX3b4PlGdZXT7yDw90Mv2VExY7Wmvwqfxum36Iu6lbEmBKDuh83tyvt1
 N32wvL6MnijDOviuMVgcU3o8ymMNx+wEq8KRgSsCxdN1oR1x1Ds4/vH8BkWqWN4b
 RjAc5u0H0vNdysXPbkcXzfszjFsm+/rMNn3oVz5ISP25lbyKdQp0IWaRMVGQYPp9
 Hxi5cqyuDp43v1e+/yawQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791302490; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:X3ecj81XFrpS/f6XXh3yE6MoHIXWTrouSWCBfFPPyGDXtW4
 olsDDVUO8zZc+7qJQhoXvKzJscAtUIflg1EcWftOCKe9ij1HOiEFgLSN1k01Gu/6
 Ysq9nfhkK73NSPFA6RbwbJ4Au2g0rh02NLVtcLWmFe3JZ11TJuHOSPmmqpTKPVGf
 p/sY9WcxlN7H5R2CNiPyE0gco/KeWOnZh6gPQjv9ziknNJ6GbUWKB1LczHLD4k6i
 bdoiwJv0RzT6hIsf3czqxYrd1MGHqxvxcVWeRy76hIvopjWzXkqrjyaOcOtbiccP
 pHMezz4A2x9a88wYMDpjLuP3SaLE2aEiOadlBEw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:YUyIfW4in5wrVT3XOYZOssFtvVilMQitxHB4Slf//xU=:lvYaFXklwPJOLjlynE1+2oA/w8Tkcx5OCJUYiP31nE4=;
X-ME-Sender: <xms:WhvFahi2W8S1CmcZuFaFKt9Lv6UTrCDu6eOCeNqxkPezTYWK_62izg>
 <xme:WhvFaqUDXkxnKaXTmY8hGgE4oO53a4qaDeeVGeh_r37WYU98EjifFg4hG_GdQ4hZ-
 hpGI49WPJlxysO-aUT2XhkzUURk71wGD8soFyIWPESQvy9DiIZlDso>
X-ME-Received: <xmr:WhvFagN-_kh_ATtfertdEzGlDJ9yM7oWbD33VcdnFZtRE1Yr6A3GowThKxcY2__c3CNZrNXRoAbtvOoPpCG49Lw>
X-ME-Proxy-Cause: dmFkZTEYMtdbh8BN8iu+VIRG40NDiIdfyy/28bIlz1ORDCS+wKDYzcIdkVT2/mNpOkK0C3
 1c11ymyKDa0C2uGLkFNp0GphGcpAUwM8arFqoYYHfT/PFwX9m15UueOT6Uf9SwiXbvgTS7
 M0KaGk+z/099+h1adR9GFbvx/XrcgJvaE7MJ0LHP7Zc6NzEc/jEf9dHDGOtzlU8TEPnypL
 XHU1zrRuFtqSyNnwxYMjJeudWeYrqvizxAdEI0HZ0q+kzNfibzvKSoXTcdvPx6gmDYUtf5
 o6waLhYNRs1Owniqd4zLP1q8feLpdzBtZwYFZJDF6T5rSrXI9Cl5c+DRqNnDeULoTZDcEH
 7pkx/jenSjo60R09Oca/t301Ldww0xUS5yNUrgJn1jmryjk0gbK2USxoEX+0hPmBNKZzE8
 kfVxXU77O4GVuALgAnU0IZS7jk4p00decBl/dFUbCQDjwYm9XnFrDHGHcbGNUuI1XUn+f/
 CEUSFkRHtjyHznNsFDrFXh1hOQnPzccdLGQBFHHj3FXmuS5Nj1hWGUzNKIG9TsLQZ4HXKM
 b4RlxfahKKlhp6fDa2PW685mlu+G0i+kQzuGNGjubYR2SUi8QOmyPzXXRxByAuS7qy0QBq
 +/sDGeolG8wUD+s/ZpyAjMDM1cozWwcG1rkTUJM2jbLDxQwsCSv5tyY1OQhw
X-ME-Proxy: <xmx:WhvFauZQKDCf3PeAMO8wA8yL8wV9YxCdQgIiqYOxHbjSQBBOC7jT3w>
 <xmx:WhvFakoeX_Zksd58_cdZrY2nx0Y6j25U0pACREj3f3vBPK_JxMVSZg>
 <xmx:WhvFaibluFyiPuWP0MEy6JHD2RNGh3el9jPpM9uxNKIu4o6n7XNdAQ>
 <xmx:WhvFasQwAzbd_j4mDQJdpzr3GAkXm2IA5Zkikbd_vt0bPKLn6XSjMw>
 <xmx:WhvFao1HvO8GgedXGxI5ckgiZlBzN_6v8Yp58npWM6U9Kycux4x_McCt>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 12:01:29 -0400 (EDT)
Message-ID: <121ff0265628f526f12804be58bd41d788e2f81e.camel@alistair23.me>
Subject: Re: [PATCH v2 15/23] target/riscv: Pass MemOpIdx to vext_ldst_us
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 07 Oct 2026 02:01:28 +1000
In-Reply-To: <20260821040404.268123-16-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
 <20260821040404.268123-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.62.0 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.146;
 envelope-from=alistair@alistair23.me; helo=fout-b3-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

T24gVGh1LCAyMDI2LTA4LTIwIGF0IDIxOjAzIC0wNzAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToKPiBVc2UgbW11IGRhdGEgcGFzc2VkIGluIHdpdGggVkRBVEEuCj4gCj4gU2lnbmVkLW9mZi1i
eTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+CgpSZXZp
ZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgoKQWxp
c3RhaXIKCj4gLS0tCj4gwqB0YXJnZXQvcmlzY3YvdGNnL3ZlY3Rvcl9oZWxwZXIuYyB8IDIzICsr
KysrKysrKysrKysrKysrKystLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy92ZWN0
b3JfaGVscGVyLmMKPiBiL3RhcmdldC9yaXNjdi90Y2cvdmVjdG9yX2hlbHBlci5jCj4gaW5kZXgg
NzY5OTA4OTRlNS4uOWIwYzNmNzBjMiAxMDA2NDQKPiAtLS0gYS90YXJnZXQvcmlzY3YvdGNnL3Zl
Y3Rvcl9oZWxwZXIuYwo+ICsrKyBiL3RhcmdldC9yaXNjdi90Y2cvdmVjdG9yX2hlbHBlci5jCj4g
QEAgLTE1OCw2ICsxNTgsMTkgQEAgc3RhdGljIGlubGluZSB2b2lkIHZleHRfc2V0X2VsZW1fbWFz
ayh2b2lkICp2MCwKPiBpbnQgaW5kZXgsCj4gwqDCoMKgwqAgKCh1aW50NjRfdCAqKXYwKVtpZHhd
ID0gZGVwb3NpdDY0KG9sZCwgcG9zLCAxLCB2YWx1ZSk7Cj4gwqB9Cj4gwqAKPiArc3RhdGljIGlu
bGluZSBNZW1PcElkeCB2ZXh0X29pKHVpbnQzMl90IGRlc2MsIE1lbU9wIG1lbW9wKQo+ICt7Cj4g
K8KgwqDCoCB1aW50MzJfdCBkYXRhID0gc2ltZF9kYXRhKGRlc2MpOwo+ICsKPiArwqDCoMKgIGlm
IChGSUVMRF9FWDMyKHNpbWRfZGF0YShkZXNjKSwgVkRBVEEsIEJTV0FQKSkgewo+ICvCoMKgwqDC
oMKgwqDCoCBtZW1vcCB8PSBNT19CU1dBUDsKPiArwqDCoMKgIH0KPiArwqDCoMKgIGlmIChGSUVM
RF9FWDMyKHNpbWRfZGF0YShkZXNjKSwgVkRBVEEsIEFMSUdOKSkgewo+ICvCoMKgwqDCoMKgwqDC
oCBtZW1vcCB8PSBNT19BTElHTjsKPiArwqDCoMKgIH0KPiArwqDCoMKgIHJldHVybiBtYWtlX21l
bW9wX2lkeChtZW1vcCwgRklFTERfRVgzMihkYXRhLCBWREFUQSwgTUVNX0lEWCkpOwo+ICt9Cj4g
Kwo+IMKgc3RhdGljIGlubGluZSBNZW1PcElkeCB2ZXh0X21ha2VfbWVtb3BfaWR4KENQVVJJU0NW
U3RhdGUgKmVudiwKPiBzaXplX3Qgc2l6ZSkKPiDCoHsKPiDCoMKgwqDCoCBpbnQgbW11X2lkeCA9
IHJpc2N2X2Vudl9tbXVfaW5kZXgoZW52LCBmYWxzZSk7Cj4gQEAgLTQwNiwxMiArNDE5LDEyIEBA
IHZleHRfbGRzdF91c19ub3RhaWwodm9pZCAqdmQsIHRhcmdldF91bG9uZwo+IGJhc2UsIENQVVJJ
U0NWU3RhdGUgKmVudiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHVpbnQzMl90IG1heF9lbGVtcywgYm9vbCB2bWEsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB2ZXh0X2xkc3RfZWxlbV9mbl90bGIgKmxkc3RfdGxiLAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmV4dF9sZHN0X2VsZW1fZm5faG9z
dCAqbGRzdF9ob3N0LAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1
aW50cHRyX3QgcmEsIGJvb2wgaXNfbG9hZCkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgdWludHB0cl90IHJhLCBib29sIGlzX2xvYWQsIE1lbU9wSWR4IG9pKQo+IMKg
ewo+IMKgwqDCoMKgIHRhcmdldF91bG9uZyBlbGVtcywgYWRkciwgbGFzdCwgbGFzdF9pbl9wYWdl
LCBwYWdlX3NwbGl0Owo+IMKgwqDCoMKgIHVpbnQzMl90IGVzeiA9IDEgPDwgbG9nMl9lc3o7Cj4g
wqDCoMKgwqAgdWludDMyX3QgbXNpemUgPSBuZiAqIGVzejsKPiAtwqDCoMKgIGludCBtbXVfaW5k
ZXggPSByaXNjdl9lbnZfbW11X2luZGV4KGVudiwgZmFsc2UpOwo+ICvCoMKgwqAgaW50IG1tdV9p
bmRleCA9IGdldF9tbXVpZHgob2kpOwo+IMKgwqDCoMKgIE1NVUFjY2Vzc1R5cGUgYWNjZXNzX3R5
cGUgPSBpc19sb2FkID8gTU1VX0RBVEFfTE9BRCA6Cj4gTU1VX0RBVEFfU1RPUkU7Cj4gwqDCoMKg
wqAgdWludDMyX3QgaSA9IGVudi0+dnN0YXJ0Owo+IMKgwqDCoMKgIHZvaWQgKmhvc3Q7Cj4gQEAg
LTUwNSw3ICs1MTgsOCBAQCB2ZXh0X2xkc3RfdXModm9pZCAqdmQsIHRhcmdldF91bG9uZyBiYXNl
LAo+IENQVVJJU0NWU3RhdGUgKmVudiwgdWludDMyX3QgZGVzYywKPiDCoMKgwqDCoCB1aW50MzJf
dCBtYXhfZWxlbXMgPSB2ZXh0X21heF9lbGVtcyhkZXNjLCBsb2cyX2Vzeik7Cj4gwqAKPiDCoMKg
wqDCoCB2ZXh0X2xkc3RfdXNfbm90YWlsKHZkLCBiYXNlLCBlbnYsIGxvZzJfZXN6LCB2ZXh0X25m
KGRlc2MpLCBldmwsCj4gbWF4X2VsZW1zLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHZleHRfdm1hKGRlc2MpLCBsZHN0X3RsYiwgbGRzdF9ob3N0LCBy
YSwKPiBpc19sb2FkKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB2ZXh0X3ZtYShkZXNjKSwgbGRzdF90bGIsIGxkc3RfaG9zdCwgcmEsCj4gaXNfbG9h
ZCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2ZXh0
X29pKGRlc2MsIGxvZzJfZXN6KSk7Cj4gwqAKPiDCoMKgwqDCoCBlbnYtPnZzdGFydCA9IDA7Cj4g
wqDCoMKgwqAgdmV4dF9zZXRfdGFpbF9lbGVtc18xcyhldmwsIHZkLCBkZXNjLCBuZiwgMSA8PCBs
b2cyX2VzeiwKPiBtYXhfZWxlbXMpOwo+IEBAIC05NDcsNyArOTYxLDggQEAgdmV4dF9sZHN0X3do
b2xlKHZvaWQgKnZkLCB0YXJnZXRfdWxvbmcgYmFzZSwKPiBDUFVSSVNDVlN0YXRlICplbnYsIHVp
bnQzMl90IGRlc2MsCj4gwqDCoMKgwqAgdWludDMyX3QgZXZsID0gKHJpc2N2X2NwdV9jZmcoZW52
KS0+dmxlbmIgKiB2ZXh0X25mKGRlc2MpKSA+Pgo+IGxvZzJfZXN6Owo+IMKgCj4gwqDCoMKgwqAg
dmV4dF9sZHN0X3VzX25vdGFpbCh2ZCwgYmFzZSwgZW52LCBsb2cyX2VzeiwgMSwgZXZsLCBldmws
IGZhbHNlLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGxkc3RfdGxiLCBsZHN0X2hvc3QsIHJhLCBpc19sb2FkKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsZHN0X3RsYiwgbGRzdF9ob3N0LCByYSwgaXNf
bG9hZCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2
ZXh0X29pKGRlc2MsIGxvZzJfZXN6KSk7Cj4gwqDCoMKgwqAgZW52LT52c3RhcnQgPSAwOwo+IMKg
fQo+IMKgCg==


