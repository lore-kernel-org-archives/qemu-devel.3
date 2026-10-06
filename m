Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50313CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN5L-00069L-7h; Wed, 07 Oct 2026 04:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xEHoG-0006ry-VP
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:55:40 -0400
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xEHnv-00054V-DJ
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:54:59 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 23A431D0013B
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2026 11:15:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 06 Oct 2026 11:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1791299712; x=1791386112; bh=oWXl1xLop7Xootm4gcsXVU3kz7w2XUBD
 8nMHNBq31Po=; b=mEU3bUzAxiI6JCecLtE+gzY8+uYSfDAApwlWnhW7BMMS7t8y
 MkEHjTd2fctllGHvrOroh+O/kSxtcHw871u/AOPMlE5VX3YbxVv1W4bpCiKsToiw
 WChGmZAX1YVmw5tSife23M22+WF5pFiowM/xUyywItvLQU/KbQe52Ju9aOJeh7S1
 d8AaqFAGgM4oQjMxdWla7hBNDMx/lEO+0RM78JYrbh6VnpN/D8y/8UfKye2FjQ8P
 ua7J6wBJkCxyH9IGhmoDHGgk49PRncfkRQRa3lh4YWHb7W5e4x/9NZb9n4vKt90I
 nfPu+9rXZaZppmMJ5T2MYcqTps8+CnK08BYqyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791299712; x=
 1791386112; bh=oWXl1xLop7Xootm4gcsXVU3kz7w2XUBD8nMHNBq31Po=; b=y
 DMAxrbcuSgKH9i0+KQZ46iIOt9jxJRzyxj2vfjyrx2L4+FO3Vl9Bo8941i+oPsQG
 TJRejY470RqAnYEproqdZTfEmPha6XD4ASoPnF2/kwUZFbGtc9sp6fIvd6/xYvhy
 gTrI1SMdkr8nv3+jdPab1+HtZ6NlqyAwcDdQ0MSozD3Abby7RRd+jYO2a6/2ofzj
 Fs6NDd6f3DvnzH40mr45H9hU2OBekYIiBP4t4MFsc7EAoksX72Ua5zQ0+MqUJbTP
 pQKarq7/bYpv6fwyUe94Yx9KtKlpAzSS32h086NoW+rAv68R9KTMzmK778t/+l50
 rDYaaj35dxcDaVskZbwIA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791299712; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:eyLuZJpNfg/EKRX6xrZ0cmHDHbstMtnHtgfR1m7G2rGAA0n
 DwQgkdz4/3xLOn40lQ44Qp3q7fwCVTBK7/V0A6KaTkXOY8++B3s7kdkPwMqTTB9v
 x4M0TgRkOQQSeFcPRSaQmfeP49ai8CPaT23BMtl1fQZPy13OwHqTKoxVrbghjXBs
 Cu+S6+mgqKHedmjNbGKP/BlSLoe+0E9VSHQuK1aTq2tEDZ2kaFiAexNAo/uQC7rR
 +QdE8uNdvdCTTonsv1dY3Jm5RWtv9/MrAWYhuXSMgPwycSnnXrvZSRcfIPMOzWLr
 wV1yb2ZD7BIYjdI7hPfUdlB93ZEDEEKvr7vkE5A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:J9RjXFNiR0Amsa/ACgbpB4vZx2XQz8nBBSNaifojXuA=:oWXl1xLop7Xootm4gcsXVU3kz7w2XUBD8nMHNBq31Po=;
X-ME-Sender: <xms:gBDFaprmfj9hdOGHpmSU4efA60QqwBt0jGoUS7VuRv8YDDOu2f--XQ>
 <xme:gBDFav92xsuksYC9Yc9lg0l-0Hi14ra285WA4xEve1495IGI6eZkn4-t0vAZU-QLk
 wgAU-bYdjN5oQxQV6VvFIUuKtxI0GHppxkLzWhf5zB89UmgIViQGkU>
X-ME-Received: <xmr:gBDFalV3EsMyL8nM3yBEzxZIlrpYUSpy0HxOM1ve6ZrQ_8OFarzG8-MaBI3hGZwFL8akynKTOceTm8KvnWw_gqc>
X-ME-Proxy-Cause: dmFkZTF+o4pF1VLyBV77zycDXtyJqGbqLFyo6o+oe4XjorfTtgKB/NKwmtZE/urEbPvG7I
 XHa0eQRnnpiIdQoLQGbEgoiV5ml4IS/k2t9RkGVOxXqNOmaLpPKY2QQuP6cHkDu1NSIQ+2
 XDdu2vZ0zddqo0+34qv9pD+fbIUJd/we8F+pDvItu9ElCSCJqhAirWCOGnT/p3QbokHay/
 MNWsv6gOORRG9KOtkozOS9mVzTMl8UJGt/C0h+Yp6HoCEC6yaVVa1wmSruBknrE3Y2FE/l
 DpHZJV95TzIMYgX+TBRspp8cgsplDx95lNUO77V87qyXQTavKhubUuUK3qUz8lU5ytC2TT
 OFzbWbi3dt68uPUsBXhcBdHYoKoUKaIT3UTfm3pqDveTUpBdxYU3nUxunG98FEn5PccPwl
 kr7VO+6Ziz/unCw8Rz2NnlpVQvQlSlTmt4YNrDpzH8Ti2ptKHf0ZtP5DCF8u9o/eHr6Gby
 3JdMysWlr/E9GHOVw0JzX5u/Rf/Z/bhkvTSItzJhKbKfvJfQEqtSPEYJf3CiT55CJcjD73
 Et0NA+awQu9HEFNQDEPS111pleTzxGpmCkNaV6grbnRzySEgsDJPydpMRQzzuAKcNGYSbZ
 jcYTKXqpcL6dgHl3uhcATOHOm6kySs5ep7k5gF1vmDNOkpcmLdGLSXE1zs4Q
X-ME-Proxy: <xmx:gBDFatAkQRAFylcTUZfoyo3wDiLwvSQItmWNvChZH-UJ4a0Q27j5zw>
 <xmx:gBDFauyUDfdMfYHxrUtiEy8JDA7JD_xT1ZT2IQPABGg4Ad4SbZQJPg>
 <xmx:gBDFaiD07j4C1_E8mlSe7BTLuXt27RkesbXeIRr_5wuC_6tYnyfCiw>
 <xmx:gBDFajYt9LJWsiOuCqJM4xkrhFTmYnI447BC_SAArU2D06qxnq2MDA>
 <xmx:gBDFahfKim6k1qPaZ0c4dU9N0xtew1qDfF1svrRxAfu5IYLai_NDZIGh>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 11:15:11 -0400 (EDT)
Message-ID: <d847535e9b5cc9a424e67cc8aefd39aa5241acd2.camel@alistair23.me>
Subject: Re: [PATCH v2 05/23] target/riscv: Remove vext_continuous_ldst_tlb
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 07 Oct 2026 01:15:09 +1000
In-Reply-To: <20260821040404.268123-6-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
 <20260821040404.268123-6-richard.henderson@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
ZToKPiBEcm9wIHRoZSB1c2FnZSBpbiB2ZXh0X3BhZ2VfbGRzdF91cywgbWVyZ2luZyB0aGUgbmYg
PT0gMQo+IGNhc2UgaW50byB0aGUgdmV4dF9sZHN0X25mX3RsYiBsb29wLgo+IElubGluZSBpdCBp
bnRvIHRoZSBsYXN0IHVzZSBpbiB2ZXh0X2xkc3RfdXMuCj4gCj4gU2lnbmVkLW9mZi1ieTogUmlj
aGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+CgpSZXZpZXdlZC1i
eTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgoKQWxpc3RhaXIK
Cj4gLS0tCj4gwqB0YXJnZXQvcmlzY3YvdGNnL3ZlY3Rvcl9oZWxwZXIuYyB8IDM0ICsrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLS0tLQo+IC0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKSwgMjQgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90
Y2cvdmVjdG9yX2hlbHBlci5jCj4gYi90YXJnZXQvcmlzY3YvdGNnL3ZlY3Rvcl9oZWxwZXIuYwo+
IGluZGV4IGRhMWU3MDRjNTYuLjYzYTUxZjJiNDggMTAwNjQ0Cj4gLS0tIGEvdGFyZ2V0L3Jpc2N2
L3RjZy92ZWN0b3JfaGVscGVyLmMKPiArKysgYi90YXJnZXQvcmlzY3YvdGNnL3ZlY3Rvcl9oZWxw
ZXIuYwo+IEBAIC0yNzIsMTcgKzI3Miw2IEBAIEdFTl9WRVhUX0hPU1RfU1RfRUxFTShzdGVfaCwg
dWludDE2X3QsIEgyLAo+IHN0d19sZSkKPiDCoEdFTl9WRVhUX0hPU1RfU1RfRUxFTShzdGVfdywg
dWludDMyX3QsIEg0LCBzdGxfbGUpCj4gwqBHRU5fVkVYVF9IT1NUX1NUX0VMRU0oc3RlX2QsIHVp
bnQ2NF90LCBIOCwgc3RxX2xlKQo+IMKgCj4gLXN0YXRpYyBpbmxpbmUgUUVNVV9BTFdBWVNfSU5M
SU5FIHZvaWQKPiAtdmV4dF9jb250aW51b3VzX2xkc3RfdGxiKENQVVJJU0NWU3RhdGUgKmVudiwg
dmV4dF9sZHN0X2VsZW1fZm5fdGxiCj4gKmxkc3RfdGxiLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdm9pZCAqdmQsIHVpbnQzMl90IGV2bCwgdGFy
Z2V0X3Vsb25nIGFkZHIsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB1aW50MzJfdCByZWdfc3RhcnQsIHVpbnRwdHJfdCByYSwgdWludDMyX3QKPiBl
c3opCj4gLXsKPiAtwqDCoMKgIHVpbnQzMl90IGk7Cj4gLcKgwqDCoCBmb3IgKGkgPSBlbnYtPnZz
dGFydDsgaSA8IGV2bDsgZW52LT52c3RhcnQgPSArK2ksIGFkZHIgKz0gZXN6KSB7Cj4gLcKgwqDC
oMKgwqDCoMKgIGxkc3RfdGxiKGVudiwgYWRqdXN0X2FkZHIoZW52LCBhZGRyKSwgaSwgdmQsIHJh
KTsKPiAtwqDCoMKgIH0KPiAtfQo+IC0KPiDCoHN0YXRpYyBpbmxpbmUgUUVNVV9BTFdBWVNfSU5M
SU5FIHZvaWQKPiDCoHZleHRfY29udGludW91c19sZHN0X2hvc3QoQ1BVUklTQ1ZTdGF0ZSAqZW52
LCB2ZXh0X2xkc3RfZWxlbV9mbl9ob3N0Cj4gKmxkc3RfaG9zdCwKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdm9pZCAqdmQsIHVpbnQzMl90IGV2bCwg
dWludDMyX3QgcmVnX3N0YXJ0LAo+IHZvaWQgKmhvc3QsCj4gQEAgLTQ2NSwxNSArNDU0LDEwIEBA
IHZleHRfcGFnZV9sZHN0X3VzKENQVVJJU0NWU3RhdGUgKmVudiwgdm9pZCAqdmQsCj4gdGFyZ2V0
X3Vsb25nIGFkZHIsCj4gwqDCoMKgwqDCoMKgwqDCoCB9Cj4gwqDCoMKgwqDCoMKgwqDCoCBlbnYt
PnZzdGFydCArPSBlbGVtczsKPiDCoMKgwqDCoCB9IGVsc2Ugewo+IC3CoMKgwqDCoMKgwqDCoCBp
ZiAobmYgPT0gMSkgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZleHRfY29udGludW91c19s
ZHN0X3RsYihlbnYsIGxkc3RfdGxiLCB2ZCwgZXZsLCBhZGRyLAo+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZW52LT52c3RhcnQsIHJhLCBlc3opOwo+IC3CoMKgwqDCoMKgwqDCoCB9IGVsc2Ugewo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGZvciAodWludDMyX3QgaSA9IGVudi0+dnN0YXJ0OyBpIDwgZXZs
OyBlbnYtPnZzdGFydCA9Cj4gKytpKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB2ZXh0X2xkc3RfbmZfdGxiKGVudiwgdmQsIGFkZHIsIGksIG5mLCBlc3osCj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bWF4X2VsZW1zLCBsZHN0X3RsYiwgcmEpOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgYWRkciArPSBtc2l6ZTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gK8KgwqDCoMKg
wqDCoMKgIGZvciAodWludDMyX3QgaSA9IGVudi0+dnN0YXJ0OyBpIDwgZXZsOyBlbnYtPnZzdGFy
dCA9ICsraSkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZleHRfbGRzdF9uZl90bGIoZW52
LCB2ZCwgYWRkciwgaSwgbmYsIGVzeiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWF4X2VsZW1zLCBsZHN0X3RsYiwgcmEpOwo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFkZHIgKz0gbXNpemU7Cj4gwqDCoMKgwqDCoMKgwqDCoCB9
Cj4gwqDCoMKgwqAgfQo+IMKgfQo+IEBAIC00OTUsMTMgKzQ3OSwxNSBAQCB2ZXh0X2xkc3RfdXMo
dm9pZCAqdmQsIHRhcmdldF91bG9uZyBiYXNlLAo+IENQVVJJU0NWU3RhdGUgKmVudiwgdWludDMy
X3QgZGVzYywKPiDCoAo+IMKgI2lmIGRlZmluZWQoQ09ORklHX1VTRVJfT05MWSkKPiDCoMKgwqDC
oCAvKgo+IC3CoMKgwqDCoCAqIEZvciBkYXRhIHNpemVzIDw9IDYgYnl0ZXMgd2UgZ2V0IGJldHRl
ciBwZXJmb3JtYW5jZSBieSBzaW1wbHkKPiBjYWxsaW5nCj4gLcKgwqDCoMKgICogdmV4dF9jb250
aW51b3VzX2xkc3RfdGxiCj4gK8KgwqDCoMKgICogRm9yIGRhdGEgc2l6ZXMgPD0gNiBieXRlcyB3
ZSBnZXQgYmV0dGVyIHBlcmZvcm1hbmNlCj4gK8KgwqDCoMKgICogYnkgc2ltcGx5IGNhbGxpbmcg
bGRzdF90bGIuCj4gwqDCoMKgwqDCoCAqLwo+IMKgwqDCoMKgIGlmIChuZiA9PSAxICYmIChldmwg
PDwgbG9nMl9lc3opIDw9IDYpIHsKPiDCoMKgwqDCoMKgwqDCoMKgIGFkZHIgPSBiYXNlICsgKGVu
di0+dnN0YXJ0IDw8IGxvZzJfZXN6KTsKPiAtwqDCoMKgwqDCoMKgwqAgdmV4dF9jb250aW51b3Vz
X2xkc3RfdGxiKGVudiwgbGRzdF90bGIsIHZkLCBldmwsIGFkZHIsCj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW52LT52
c3RhcnQsIHJhLCBlc3opOwo+ICvCoMKgwqDCoMKgwqDCoCBmb3IgKHVpbnQzMl90IGkgPSBlbnYt
PnZzdGFydDsgaSA8IGV2bDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudi0+dnN0YXJ0
ID0gKytpLCBhZGRyICs9IGVzeikgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxkc3RfdGxi
KGVudiwgYWRqdXN0X2FkZHIoZW52LCBhZGRyKSwgaSwgdmQsIHJhKTsKPiArwqDCoMKgwqDCoMKg
wqAgfQo+IMKgwqDCoMKgwqDCoMKgwqAgZW52LT52c3RhcnQgPSAwOwo+IMKgwqDCoMKgwqDCoMKg
wqAgdmV4dF9zZXRfdGFpbF9lbGVtc18xcyhldmwsIHZkLCBkZXNjLCBuZiwgZXN6LCBtYXhfZWxl
bXMpOwo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo=


