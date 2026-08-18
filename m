Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FA5C5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 03:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwAcW-00030I-2q; Mon, 17 Aug 2026 23:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wwAcU-0002zh-Iq; Mon, 17 Aug 2026 23:36:10 -0400
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wwAcS-0007su-Sh; Mon, 17 Aug 2026 23:36:10 -0400
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 402697A0158;
 Mon, 17 Aug 2026 23:36:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Mon, 17 Aug 2026 23:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1787024167; x=1787110567; bh=BxzDvCUDUR9cIUQ0GCK6Xrd29zatf3pI
 mJz15A7Iim0=; b=Z5b0tp3UsEZGZ0SsZfxi+XczuZtiMrQ4gd5Z8E994nk+rd3Z
 g1GrdUBTe9TahwFwLXVAFwR0gx9Svucru0Kdgbg+zdfdegjmF6izFPc+kpz+ojI5
 gHwyl146nIDfppJUAre0+cyautQPvCZA05ckOiGBJ7iIa9L4Dx587UFgWes2WmLQ
 YtqvWkMUTuLRqMpaBqb2g6nfslOVoMPeueZX+C8Mqt4wJhx81PCv6Fv7xg6WWLLr
 DPA0ioGtDOtjge3DtnsBtrD3OUECUmlkf14qPlaLVy4Jn+wfO+BwiAhVZGn1npZh
 hbu2lsovQOYHsfb4lh68/XzYR2kx/qlMw/Xwvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787024167; x=
 1787110567; bh=BxzDvCUDUR9cIUQ0GCK6Xrd29zatf3pImJz15A7Iim0=; b=V
 y8jLcuw83zRNLGajJMErFs0oVIHkDZ0v3br5yj2I7yImPYeouVch3yjWaZ7SUbl5
 3IFy1Vl5RU3MBZCJVTGwyY6Za/pKmNdsZfGqgWtUdiqZ7n9doGSvqPTvmi3KLIly
 F7VY/92CtkAqBjDZl62woWND0S4skRfuwEZiW2jTCP3vARdvYfgC9lD9CMmn/g3g
 +TmW1uRB+lm6oTqisRybdT/9PjkxPICVx4Z4ZRLbsPuf/YTfabm0xbjdcJEcaf63
 yr4pdhg5ZHcAaOVcoveCploRrh+7UcVXD0PsK+JunULULOdFsXW4wAV0b5BVPZw7
 OE8dgKZ2ka8v3PfJcaZcg==
X-ME-Sender: <xms:JtODattquMfP_gTOcaQapaz0QHqSVqXvQyTXX8znHNgb-ycJygmLxA>
 <xme:JtODamnC-y9tRjpCuxKqZl7q5oDZoR7YWo4ngqeIOzIF1jm_ygkOIE6bewBP9OIfR
 RJa_rbQ_tubsdeqex7q1LasjAttNfG2DYZZvk2HzO3iArWdp2p_nFU>
X-ME-Received: <xmr:JtODaosme1M-f9StcZrG2fFEkGAg4LDNb6tnd8dNCwcpEc3Ysik80A_eha8bDgfXBw9UAiCP7pruH5xjKO1QkX6hP-8>
X-ME-Proxy-Cause: dmFkZTGPFYID+zTiYQaqLZYysGzD6u8s2u5JFzTDdL+uP08foKUR6FQRRcGFuf+DiztYEi
 Jk1yx1EaFZ4j+OWoMGUdyeHfsPkbMa2TVqWU3edDO6SbbnNk+9KzUuXdbJdLCSgYEocT3B
 hdAayYNaTY/+dPaz5sVlGeZyq6E2D8STT85Ibmd1BCTTX8fmN2YvRmrygDyqom09xAjSFy
 iM6vZRcekPKjOwEV5v6Kg6+nq9iPvCv5veOwl8zWqfTchsaa0C1Xq5rAIIJNt5iJRJPlIF
 /LzuXkumz10ROfaEaZfn5MGgRKFXYDi9oIejoLOi7RSSko9sFIwiPAZ+UspKai3vp2SBCL
 7pmdfI2KqOFuLMB2rZUq/qlyoFuuKfyW+xlhG9ScYNuFUXS55xlJm0rvU5TtjciLiTGS4w
 Q5dZgTg1mQG//GvztNnXjHuZBlGKgpSJ5tVAyJQnuQMBqH2rTcTer/neO6IuacfDwWZeSL
 aQuyPJO0utwjeQJcpWkK5Trn8sSFiLZaSvxs6yloZi5HBHPJgzJvS1RkIiCIcZB1giExce
 9iwxuLLY7LKgjuaCKwTpU9RpgQrFkB+lmyoyoNW5u5+/bnlIBY6sTg72E1pNcY1Ja4Ml7L
 oKWsoZdsivVmZ/oq2mP/NJrU/qwuevhqQF4aTQ6yKgFxe4Lq1Dw5rWTOitSA
X-ME-Proxy: <xmx:JtODascLY6UU0oB9gferr4Ld2L_8XpnESDW-J2zdeT5fw1klIZPaXQ>
 <xmx:JtODaozbHkNNMbdkEHIoUnhqM9iJpabgap6SWxbiS6p92SbcAihcPQ>
 <xmx:JtODaqFQk_PI1BAwkJeVjZ5z6dwAeO3Jk_0JmdMEtqEnU7gJ80dMgw>
 <xmx:JtODakww169PkRUYbw2oXXO-N2ZldbK2s0mF-hVSYtURM5pBGpS7Qg>
 <xmx:J9ODasGumC-YPujpXjNB-dW6nU0G3wE-SZK6zbL01vtDMbr30h6Irh7Z>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 23:36:05 -0400 (EDT)
Message-ID: <1bc1cebdca2e1d20dd98334b0210a3d80e746fb9.camel@alistair23.me>
Subject: Re: [RFC PATCH 18/18] target/riscv: Pass first/last to
 pmp_hart_has_privs
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org
Date: Tue, 18 Aug 2026 13:36:03 +1000
In-Reply-To: <20260815203730.1468365-19-richard.henderson@linaro.org>
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
 <20260815203730.1468365-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.157;
 envelope-from=alistair@alistair23.me; helo=fhigh-b6-smtp.messagingengine.com
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

T24gU2F0LCAyMDI2LTA4LTE1IGF0IDEzOjM3IC0wNzAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToKPiBUaGlzIGVsaW1pbmF0ZXMgYW4gYW1iaWd1aXR5IHdpdGggc2l6ZSA9PSAwIGFuZCBhbHNv
Cj4gYWxpZ25zIHdpdGggdGhlIHVuZGVybHlpbmcgaHcgcmVwcmVzZW50YXRpb24uCj4gCj4gU2ln
bmVkLW9mZi1ieTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5v
cmc+CgpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMu
Y29tPgoKQWxpc3RhaXIKCj4gLS0tCj4gwqB0YXJnZXQvcmlzY3YvdGNnL3BtcC5owqDCoMKgwqDC
oMKgwqAgfMKgIDUgKystLS0KPiDCoHRhcmdldC9yaXNjdi90Y2cvY3B1X2hlbHBlci5jIHzCoCAy
ICstCj4gwqB0YXJnZXQvcmlzY3YvdGNnL3BtcC5jwqDCoMKgwqDCoMKgwqAgfCAyNCArKysrLS0t
LS0tLS0tLS0tLS0tLS0tLS0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAy
NCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy9wbXAuaCBi
L3RhcmdldC9yaXNjdi90Y2cvcG1wLmgKPiBpbmRleCA0Yzk1YzI3NjdhLi5lYWNiNWI1MzQ5IDEw
MDY0NAo+IC0tLSBhL3RhcmdldC9yaXNjdi90Y2cvcG1wLmgKPiArKysgYi90YXJnZXQvcmlzY3Yv
dGNnL3BtcC5oCj4gQEAgLTcwLDkgKzcwLDggQEAgdHlwZWRlZiBzdHJ1Y3Qgewo+IMKgCj4gwqB0
eXBlZGVmIHN0cnVjdCBDUFVBcmNoU3RhdGUgQ1BVUklTQ1ZTdGF0ZTsKPiDCoAo+IC1ib29sIHBt
cF9oYXJ0X2hhc19wcml2cyhDUFVSSVNDVlN0YXRlICplbnYsIGh3YWRkciBhZGRyLAo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludCBzaXplLCBwbXBf
cHJpdl90IHByaXZzLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHBtcF9wcml2X3QgKmFsbG93ZWRfcHJpdnMsCj4gK2Jvb2wgcG1wX2hhcnRfaGFzX3By
aXZzKENQVVJJU0NWU3RhdGUgKmVudiwgaHdhZGRyIGZpcnN0LCBod2FkZHIKPiBsYXN0LAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBtcF9wcml2X3Qg
cHJpdnMsIHBtcF9wcml2X3QgKmFsbG93ZWRfcHJpdnMsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByaXZpbGVnZV9tb2RlX3QgbW9kZSk7Cj4gwqB1
aW50NjRfdCBwbXBfZ2V0X3RsYl9zaXplKENQVVJJU0NWU3RhdGUgKmVudiwgaHdhZGRyIGFkZHIp
Owo+IMKgdm9pZCBwbXBfdXBkYXRlX3J1bGVfYWRkcihDUFVSSVNDVlN0YXRlICplbnYsIHVpbnQz
Ml90IHBtcF9pbmRleCk7Cj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90Y2cvY3B1X2hlbHBl
ci5jCj4gYi90YXJnZXQvcmlzY3YvdGNnL2NwdV9oZWxwZXIuYwo+IGluZGV4IGZiMTI1MGE0Yjgu
LjdlZjVhYjUyNzcgMTAwNjQ0Cj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy9jcHVfaGVscGVyLmMK
PiArKysgYi90YXJnZXQvcmlzY3YvdGNnL2NwdV9oZWxwZXIuYwo+IEBAIC05MTYsNyArOTE2LDcg
QEAgc3RhdGljIGludCBnZXRfcGh5c2ljYWxfYWRkcmVzc19wbXAoQ1BVUklTQ1ZTdGF0ZQo+ICpl
bnYsIGludCAqcHJvdCwKPiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBUUkFOU0xBVEVfU1VDQ0VT
UzsKPiDCoMKgwqDCoCB9Cj4gwqAKPiAtwqDCoMKgIHBtcF9oYXNfcHJpdnMgPSBwbXBfaGFydF9o
YXNfcHJpdnMoZW52LCBmaXJzdCwgbGFzdCAtIGZpcnN0ICsgMSwKPiArwqDCoMKgIHBtcF9oYXNf
cHJpdnMgPSBwbXBfaGFydF9oYXNfcHJpdnMoZW52LCBmaXJzdCwgbGFzdCwKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgMSA8PCBhY2Nlc3NfdHlwZSwgJnBtcF9wcml2LAo+IG1vZGUpOwo+IMKgwqDC
oMKgIGlmICghcG1wX2hhc19wcml2cykgewo+IMKgwqDCoMKgwqDCoMKgwqAgKnByb3QgPSAwOwo+
IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGNnL3BtcC5jIGIvdGFyZ2V0L3Jpc2N2L3RjZy9w
bXAuYwo+IGluZGV4IGZjMDM1Yzk1Y2YuLmQzY2JiMmNiMmUgMTAwNjQ0Cj4gLS0tIGEvdGFyZ2V0
L3Jpc2N2L3RjZy9wbXAuYwo+ICsrKyBiL3RhcmdldC9yaXNjdi90Y2cvcG1wLmMKPiBAQCAtMzcy
LDEyICszNzIsMTAgQEAgc3RhdGljIGJvb2wKPiBwbXBfaGFydF9oYXNfcHJpdnNfZGVmYXVsdChD
UFVSSVNDVlN0YXRlICplbnYsIHBtcF9wcml2X3QgcHJpdnMsCj4gwqAgKiBwbXBjZmcgYnV0IGlz
IG5vdCBhY3RlZCB1cG9uIGR1cmluZyBhY2Nlc3MgY2hlY2tzLiBDYWNoZQo+IGF0dHJpYnV0ZXMK
PiDCoCAqIGhhdmUgbm8gZnVuY3Rpb25hbCBpbXBhY3QgaW4gUUVNVSBlbXVsYXRpb24uCj4gwqAg
Ki8KPiAtYm9vbCBwbXBfaGFydF9oYXNfcHJpdnMoQ1BVUklTQ1ZTdGF0ZSAqZW52LCBod2FkZHIg
YWRkciwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
bnQgc2l6ZSwgcG1wX3ByaXZfdCBwcml2cywKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBwbXBfcHJpdl90ICphbGxvd2VkX3ByaXZzLAo+ICtib29sIHBt
cF9oYXJ0X2hhc19wcml2cyhDUFVSSVNDVlN0YXRlICplbnYsIGh3YWRkciBmaXJzdCwgaHdhZGRy
Cj4gbGFzdCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBwbXBfcHJpdl90IHByaXZzLCBwbXBfcHJpdl90ICphbGxvd2VkX3ByaXZzLAo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcml2aWxlZ2VfbW9kZV90
IG1vZGUpCj4gwqB7Cj4gLcKgwqDCoCBpbnQgcG1wX3NpemUgPSAwOwo+IMKgwqDCoMKgIHVpbnQ4
X3QgcG1wX3JlZ2lvbnMgPSByaXNjdl9jcHVfY2ZnKGVudiktPnBtcF9yZWdpb25zOwo+IMKgCj4g
wqDCoMKgwqAgLyogU2hvcnQgY3V0IGlmIG5vIHJ1bGVzICovCj4gQEAgLTM4NSwyMCArMzgzLDYg
QEAgYm9vbCBwbXBfaGFydF9oYXNfcHJpdnMoQ1BVUklTQ1ZTdGF0ZSAqZW52LAo+IGh3YWRkciBh
ZGRyLAo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHBtcF9oYXJ0X2hhc19wcml2c19kZWZhdWx0
KGVudiwgcHJpdnMsIGFsbG93ZWRfcHJpdnMsCj4gbW9kZSk7Cj4gwqDCoMKgwqAgfQo+IMKgCj4g
LcKgwqDCoCBpZiAoc2l6ZSA9PSAwKSB7Cj4gLcKgwqDCoMKgwqDCoMKgIGlmIChyaXNjdl9jcHVf
Y2ZnKGVudiktPm1tdSkgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qCj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAqIElmIHNpemUgaXMgdW5rbm93biAoMCksIGFzc3VtZSB0aGF0IGFs
bCBieXRlcwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBmcm9tIGFkZHIgdG8gdGhlIGVu
ZCBvZiB0aGUgcGFnZSB3aWxsIGJlIGFjY2Vzc2VkLgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKi8KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwbXBfc2l6ZSA9IC0oYWRkciB8IFRBUkdF
VF9QQUdFX01BU0spOwo+IC3CoMKgwqDCoMKgwqDCoCB9IGVsc2Ugewo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHBtcF9zaXplID0gMiA8PCByaXNjdl9jcHVfbXhsKGVudik7Cj4gLcKgwqDCoMKg
wqDCoMKgIH0KPiAtwqDCoMKgIH0gZWxzZSB7Cj4gLcKgwqDCoMKgwqDCoMKgIHBtcF9zaXplID0g
c2l6ZTsKPiAtwqDCoMKgIH0KPiAtCj4gwqDCoMKgwqAgLyoKPiDCoMKgwqDCoMKgICogMS4xMCBk
cmFmdCBwcml2IHNwZWMgc3RhdGVzIHRoZXJlIGlzIGFuIGltcGxpY2l0IG9yZGVyCj4gwqDCoMKg
wqDCoCAqIGZyb20gbG93IHRvIGhpZ2gKPiBAQCAtNDEwLDggKzM5NCw4IEBAIGJvb2wgcG1wX2hh
cnRfaGFzX3ByaXZzKENQVVJJU0NWU3RhdGUgKmVudiwKPiBod2FkZHIgYWRkciwKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7Cj4gwqDCoMKgwqDCoMKgwqDCoCB9Cj4gwqAKPiAt
wqDCoMKgwqDCoMKgwqAgcyA9IHBtcF9pc19pbl9yYW5nZShlbnYsIGksIGFkZHIpOwo+IC3CoMKg
wqDCoMKgwqDCoCBlID0gcG1wX2lzX2luX3JhbmdlKGVudiwgaSwgYWRkciArIHBtcF9zaXplIC0g
MSk7Cj4gK8KgwqDCoMKgwqDCoMKgIHMgPSBwbXBfaXNfaW5fcmFuZ2UoZW52LCBpLCBmaXJzdCk7
Cj4gK8KgwqDCoMKgwqDCoMKgIGUgPSBwbXBfaXNfaW5fcmFuZ2UoZW52LCBpLCBsYXN0KTsKPiDC
oAo+IMKgwqDCoMKgwqDCoMKgwqAgLyogZnVsbHkgaW5zaWRlICovCj4gwqDCoMKgwqDCoMKgwqDC
oCBpZiAocyAmJiBlKSB7Cg==


