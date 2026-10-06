Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4EBCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMvW-0003OC-2x; Wed, 07 Oct 2026 04:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xEHcT-0005Kc-5b
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:43:04 -0400
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair@alistair23.me>) id 1xEHcJ-0001ZF-JR
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:42:54 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id DCE0F7A016D
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2026 11:54:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 06 Oct 2026 11:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1791302082; x=1791388482; bh=H7cC4e8Hc/YFyRkmSwaS9v2OdZdGTdwG
 hG9/bmrKtQU=; b=P++S07HhvBtxEKxhgDRbTm/ol3ivuX+z+bQsuQKk/fPM07Bz
 gTDn0da6J8gGC6I0zOqvBfecY1pvw/LJWhT8mZsEA3PHCfLIF3+K2/rOlV+KiVJA
 zfDEkE8p9qUPLY/jcVIgnZlw97LK9Uo+shM6fRRayZBVPItSZCa4ZeETPWFW5SKP
 5ymYqrOZY/9KwfvZHwilPWcFhiAjJJFZSC8nbAyP+KA34g01Ty0FQi9fo3zGxbIc
 DAsLmmp6BCmsgKxwYUwhvhDzKSza4mOyQxsD6eMWILiDmKF0trWUJRCYGw28se4r
 HRrEt/QZtKSePIpifZxkKUVv6xxtgiS1NPpqpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791302082; x=
 1791388482; bh=H7cC4e8Hc/YFyRkmSwaS9v2OdZdGTdwGhG9/bmrKtQU=; b=y
 6C1AHIj4fdEj5XQGasYWgEWbbHYGa5z2jKZWRsPKDBXMFchbcsWw+nHY78tYwYn7
 5ACNfB4rbQgzw3eVUNOYBhEdg4ht8nb3tlwFRAnpM+uo2Mx8omFxuUvSIzYcs+sf
 ML4fGIPTuDXggYjGyullsxmTTL2XhJDb62XrvyYrRnVPOTPzpyx95ZDpoIx6ifE3
 N+3l+sgVP6c6Zd5xM82UnGo+VEIS/VC0Z0pZ730qUOQutmeggqA2v1mqfk7wVdzn
 ZFBdg5vQX2M1lmlGzpRMk0Q5giTwyqXZLW2n36P3CG4LqFW7rlhGrcL+ODnzpAtM
 6zYKgkuCSivUntjFfSv0w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791302082; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:VokXSUoFI9Pso8aS/pzl+mBJZdBxgkUJ4glt+X8J61qCbrI
 1UtMhVrdbsxXviMf8eLkYpJpoy8th8MJZRc2XRena8TnRUF32mRyhEtUsWReuZTD
 1magxmN9cLaPqAA2PejFBMPcM6CO1I8QTXGvIfNbqSBa/1Bb/QPAzxxWPLSl4/Qk
 KE85SL39IeRzvaeT/bXQfl7qvhgKN4rxWVma1/brkGQWxp+gviIsJoChCJrOseiv
 0mYrA/CdlyjPGkfyx4krrrdFawXBx+9gg3oTu0ejQaLza76Z3iKC6Ccve1a0cSUO
 d+Ixx4urawzxtWKUpUch7uUaydxpFo9WWaBUjpA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:1QcNCRgkflQk1OWgSHfC/Oy7251gMsofB829k5eIiEU=:H7cC4e8Hc/YFyRkmSwaS9v2OdZdGTdwGhG9/bmrKtQU=;
X-ME-Sender: <xms:whnFaicIOTNBZXIcoY8hluoIA147eHjyhBxZvIDg8jL2dOHxsXVztw>
 <xme:whnFaghuJwCg2OIGDo6ShZGslwex3WbVVfYo7QkIUe1bnZVIyhL5LAlvha5So8C5T
 W1SnnmRdSxjNPt-QNngaAgNPcPEduq_AmAhyoK-5vwSVA4_kD9x_v5a>
X-ME-Received: <xmr:whnFaiq8mbiiNjvOhVaJfnHd-PfrWgbRecuVUhmosjQOgUxx3EUQ4wHPx86iB-PrpHcLek8SZBGCs2t3z4AlGZI>
X-ME-Proxy-Cause: dmFkZTFOqF1usMb5NMqU++q56ZEpml9nfG4yDT+PAmTCigMR1RFEtlJfhkQYkauGKyzdma
 3KBaqw0wPpqt9p+0dZEoJeSX1tNsePsSNuAbpz4s0F9wuKvQfUUfgXtSiELAW6SOQVLUYi
 eNd8A+0XSwGw4bibpyyHQFWYQ6REoiZ1BKJ/q5Vx/RgLI/zmWhJUnX1PkuiluPQn61sYNz
 c63PAK+pTpJ/JMqKv2gf+wmSvBYrCU4bqN1QCpPeCRh4K+623vSYcTCb3U/d1Fh1LuxqIs
 r3Q1CIukUaAldbV6DETnY2YjtPg0DZ79Yq+ecH7JYdr+ZNfbnhone2ObJ2IdiIKTJTSdBo
 NkMDivyN/elgXjmlvhHRb6DXK1UO34b9pp6Fn61pIVx88tD04uwIoNAXyXfpqM6/iQwdSG
 T748NUXW60pMb7s0ncmj8pows3tDIJpgcIpzS15Jax3+rlPc3F4ZJhlhhdgAWGpEwh0z4c
 twg/w4srZusH6B8j31PMWn+OMfWMj2QKMswuihm7/tYg9XXy+hFOV40yhwf4lTlNxsgwZC
 qGd7NRXzFi4obO0mvy86ZFdkMEZin38asRWpaxSSUxehHLpPAFH38Kjn+5ZVYkKqRB5mQg
 l0V2lEUKYG9nk/3ZBmQ7KoUuUeTHZUQj/T32LqlNeZnLsD+gmb/SB+nY4JMw
X-ME-Proxy: <xmx:whnFaoHRDE1-Ndm40R2FE0cCmCwYR0W0A8UwSsdt5axUBs0Zak0m5A>
 <xmx:whnFakkiGYhkHtZfPkXMB4iMC-kc740UhNOcCEnnI_U-FfNJ6t_kvg>
 <xmx:whnFarmyl1n7SNICqV1a6PBIr8nIAY9KQ18jbkqQZCgRWC7ZdDWnJQ>
 <xmx:whnFalvKFgsVbhflPZVIgaey_7mlZ_ZmQ8HaSgbaUZ8yDeoeZ1DZ6g>
 <xmx:whnFatgZdvk4xqqLNIcSN0USioN9KgVp77__LQ6SQJXPIGzENM3jeFtG>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 11:54:41 -0400 (EDT)
Message-ID: <c8a998a09a70aadddd2ccb68b590a7a6929ca223.camel@alistair23.me>
Subject: Re: [PATCH v2 10/23] target/riscv: Split out vext_ldst_us_notail
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 07 Oct 2026 01:54:40 +1000
In-Reply-To: <20260821040404.268123-11-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
 <20260821040404.268123-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.62.0 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.155;
 envelope-from=alistair@alistair23.me; helo=fhigh-b4-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
ZToKPiBTcGxpdCBvdXQgdmV4dF9sZHN0X3VzX3RhaWwgdGhhdCBkb2Vzbid0IHVzZSAnZGVzYycu
Cj4gCj4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29u
QGxpbmFyby5vcmc+CgpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJh
bmNpc0B3ZGMuY29tPgoKQWxpc3RhaXIKCj4gLS0tCj4gwqB0YXJnZXQvcmlzY3YvdGNnL3ZlY3Rv
cl9oZWxwZXIuYyB8IDM0ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQo+IC0tCj4gwqAx
IGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCj4gCj4gZGlm
ZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90Y2cvdmVjdG9yX2hlbHBlci5jCj4gYi90YXJnZXQvcmlz
Y3YvdGNnL3ZlY3Rvcl9oZWxwZXIuYwo+IGluZGV4IGFiZmQyZWM0NWQuLjc2ZjNiYWJlZDYgMTAw
NjQ0Cj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy92ZWN0b3JfaGVscGVyLmMKPiArKysgYi90YXJn
ZXQvcmlzY3YvdGNnL3ZlY3Rvcl9oZWxwZXIuYwo+IEBAIC00NzIsMTQgKzQ3MiwxNCBAQCBzdGF0
aWMgdm9pZCB2ZXh0X3Rlc3RfYWxpZ25tZW50KENQVVJJU0NWU3RhdGUKPiAqZW52LCB2YWRkciBh
ZGRyLCB1aW50MzJfdCBlc3osCj4gwqB9Cj4gwqAKPiDCoHN0YXRpYyBpbmxpbmUgUUVNVV9BTFdB
WVNfSU5MSU5FIHZvaWQKPiAtdmV4dF9sZHN0X3VzKHZvaWQgKnZkLCB0YXJnZXRfdWxvbmcgYmFz
ZSwgQ1BVUklTQ1ZTdGF0ZSAqZW52LAo+IHVpbnQzMl90IGRlc2MsCj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB2ZXh0X2xkc3RfZWxlbV9mbl90bGIgKmxkc3RfdGxiLAo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdmV4dF9sZHN0X2VsZW1fZm5faG9zdCAqbGRzdF9ob3N0LCB1aW50MzJf
dCBsb2cyX2VzeiwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IGV2bCwgdWlu
dHB0cl90IHJhLCBib29sIGlzX2xvYWQpCj4gK3ZleHRfbGRzdF91c19ub3RhaWwodm9pZCAqdmQs
IHRhcmdldF91bG9uZyBiYXNlLCBDUFVSSVNDVlN0YXRlICplbnYsCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IGxvZzJfZXN6LCB1aW50MzJfdCBuZiwg
dWludDMyX3QgZXZsLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1
aW50MzJfdCBtYXhfZWxlbXMsIGJvb2wgdm1hLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB2ZXh0X2xkc3RfZWxlbV9mbl90bGIgKmxkc3RfdGxiLAo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2ZXh0X2xkc3RfZWxlbV9mbl9ob3N0ICps
ZHN0X2hvc3QsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnRw
dHJfdCByYSwgYm9vbCBpc19sb2FkKQo+IMKgewo+IMKgwqDCoMKgIHRhcmdldF91bG9uZyBlbGVt
cywgYWRkciwgbGFzdCwgbGFzdF9pbl9wYWdlLCBwYWdlX3NwbGl0Owo+IC3CoMKgwqAgdWludDMy
X3QgbmYgPSB2ZXh0X25mKGRlc2MpOwo+IC3CoMKgwqAgdWludDMyX3QgbWF4X2VsZW1zID0gdmV4
dF9tYXhfZWxlbXMoZGVzYywgbG9nMl9lc3opOwo+IMKgwqDCoMKgIHVpbnQzMl90IGVzeiA9IDEg
PDwgbG9nMl9lc3o7Cj4gwqDCoMKgwqAgdWludDMyX3QgbXNpemUgPSBuZiAqIGVzejsKPiDCoMKg
wqDCoCBpbnQgbW11X2luZGV4ID0gcmlzY3ZfZW52X21tdV9pbmRleChlbnYsIGZhbHNlKTsKPiBA
QCAtNTAzLDcgKzUwMyw3IEBAIHZleHRfbGRzdF91cyh2b2lkICp2ZCwgdGFyZ2V0X3Vsb25nIGJh
c2UsCj4gQ1BVUklTQ1ZTdGF0ZSAqZW52LCB1aW50MzJfdCBkZXNjLAo+IMKgwqDCoMKgwqDCoMKg
wqAgZm9yICg7IGkgPCBldmw7IGVudi0+dnN0YXJ0ID0gKytpLCBhZGRyICs9IGVzeikgewo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsZHN0X3RsYihlbnYsIGFkanVzdF9hZGRyKGVudiwgYWRk
ciksIGksIHZkLCByYSk7Cj4gwqDCoMKgwqDCoMKgwqDCoCB9Cj4gLcKgwqDCoMKgwqDCoMKgIGdv
dG8gdGFpbDsKPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+IMKgwqDCoMKgIH0KPiDCoCNlbmRp
Zgo+IMKgCj4gQEAgLTUzNSw3ICs1MzUsNyBAQCB2ZXh0X2xkc3RfdXModm9pZCAqdmQsIHRhcmdl
dF91bG9uZyBiYXNlLAo+IENQVVJJU0NWU3RhdGUgKmVudiwgdWludDMyX3QgZGVzYywKPiDCoAo+
IMKgwqDCoMKgwqDCoMKgwqAgLyogVXN1YWxseSB0aGUgZmlyc3QgcGFnZSBjb250YWlucyB0aGUg
ZW50aXJlIHZlY3Rvci4gKi8KPiDCoMKgwqDCoMKgwqDCoMKgIGlmIChsaWtlbHkocGFnZV9ldmwg
PT0gZXZsKSkgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gdGFpbDsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm47Cj4gwqDCoMKgwqDCoMKgwqDCoCB9Cj4gwqDCoMKgwqDC
oMKgwqDCoCBlbnYtPnZzdGFydCA9IGkgPSBwYWdlX2V2bDsKPiDCoMKgwqDCoMKgwqDCoMKgIGFk
ZHIgKz0gZWxlbXMgKiBtc2l6ZTsKPiBAQCAtNTQ1LDcgKzU0NSw3IEBAIHZleHRfbGRzdF91cyh2
b2lkICp2ZCwgdGFyZ2V0X3Vsb25nIGJhc2UsCj4gQ1BVUklTQ1ZTdGF0ZSAqZW52LCB1aW50MzJf
dCBkZXNjLAo+IMKgwqDCoMKgIGlmICh1bmxpa2VseShwYWdlX3NwbGl0ICUgbXNpemUpKSB7Cj4g
wqDCoMKgwqDCoMKgwqDCoCB2ZXh0X2xkc3RfbmZfdGxiKGVudiwgdmQsIGFkZHIsIGkrKywgbmYs
IGVzeiwgbWF4X2VsZW1zLAo+IGxkc3RfdGxiLCByYSk7Cj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAo
aSA9PSBldmwpIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIHRhaWw7Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+IMKgwqDCoMKgwqDCoMKgwqAgfQo+IMKgwqDCoMKg
wqDCoMKgwqAgZW52LT52c3RhcnQgPSBpOwo+IMKgwqDCoMKgwqDCoMKgwqAgYWRkciArPSBtc2l6
ZTsKPiBAQCAtNTY0LDEwICs1NjQsMjIgQEAgdmV4dF9sZHN0X3VzKHZvaWQgKnZkLCB0YXJnZXRf
dWxvbmcgYmFzZSwKPiBDUFVSSVNDVlN0YXRlICplbnYsIHVpbnQzMl90IGRlc2MsCj4gwqDCoMKg
wqDCoMKgwqDCoCB2ZXh0X3BhZ2VfbGRzdF91c190bGIoZW52LCB2ZCwgYWRkciwgaSwgZXZsLCBu
ZiwgbG9nMl9lc3osCj4gbWF4X2VsZW1zLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsZHN0X3RsYiwgbW11X2luZGV4LCByYSk7
Cj4gwqDCoMKgwqAgfQo+ICt9Cj4gKwo+ICtzdGF0aWMgaW5saW5lIFFFTVVfQUxXQVlTX0lOTElO
RSB2b2lkCj4gK3ZleHRfbGRzdF91cyh2b2lkICp2ZCwgdGFyZ2V0X3Vsb25nIGJhc2UsIENQVVJJ
U0NWU3RhdGUgKmVudiwKPiB1aW50MzJfdCBkZXNjLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdmV4dF9sZHN0X2VsZW1fZm5fdGxiICpsZHN0X3RsYiwKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHZleHRfbGRzdF9lbGVtX2ZuX2hvc3QgKmxkc3RfaG9zdCwgdWludDMyX3QgbG9nMl9l
c3osCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBldmwsIHVpbnRwdHJfdCBy
YSwgYm9vbCBpc19sb2FkKQo+ICt7Cj4gK8KgwqDCoCB1aW50MzJfdCBuZiA9IHZleHRfbmYoZGVz
Yyk7Cj4gK8KgwqDCoCB1aW50MzJfdCBtYXhfZWxlbXMgPSB2ZXh0X21heF9lbGVtcyhkZXNjLCBs
b2cyX2Vzeik7Cj4gKwo+ICvCoMKgwqAgdmV4dF9sZHN0X3VzX25vdGFpbCh2ZCwgYmFzZSwgZW52
LCBsb2cyX2VzeiwgdmV4dF9uZihkZXNjKSwgZXZsLAo+IG1heF9lbGVtcywKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2ZXh0X3ZtYShkZXNjKSwgbGRz
dF90bGIsIGxkc3RfaG9zdCwgcmEsCj4gaXNfbG9hZCk7Cj4gwqAKPiAtIHRhaWw6Cj4gwqDCoMKg
wqAgZW52LT52c3RhcnQgPSAwOwo+IC3CoMKgwqAgdmV4dF9zZXRfdGFpbF9lbGVtc18xcyhldmws
IHZkLCBkZXNjLCBuZiwgZXN6LCBtYXhfZWxlbXMpOwo+ICvCoMKgwqAgdmV4dF9zZXRfdGFpbF9l
bGVtc18xcyhldmwsIHZkLCBkZXNjLCBuZiwgMSA8PCBsb2cyX2VzeiwKPiBtYXhfZWxlbXMpOwo+
IMKgfQo+IMKgCj4gwqAvKgo=


