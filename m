Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE440CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMrk-00068q-OZ; Wed, 07 Oct 2026 04:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xEHFp-0002fh-8X
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:19:43 -0400
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xEHFZ-0006yp-8R
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:19:26 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 1E8FC7A0139
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2026 11:12:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 06 Oct 2026 11:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1791299567; x=1791385967; bh=a0HA3daietqtclncs6logHCQSy+D8rYZ
 7Y8M8Fs8XNM=; b=WX/60QfyWq85LJJgHV8+fJbHRYABHI/3eP0UnWKSwqwm5hgf
 QTjmrt6UgWLllA1a3pyix34uikklAXiyLHcCiSTTPTiQheih+15vz2nJ+mHpjKGf
 6AaTbnXrOsKzc6HzSJeJY/HpQ5bZ54oYl580PTJiqn6xy0hoc6QnTSfKJdFQ/2kg
 OJA7H1dnp38xoVXmpO8wRJ7hfj0SFuWNdsNze+Mfymh8Rrcpx5ZqKTfXGXBTpI8N
 n/dbEthOCnEjHA6tccjFP+CbN6h/MHPkhQxGh7kFVC0aJdia97LOOnPeHVDYDek0
 Hd0uMID2Ag2vkpf2sOG0+g9BkZfHrYeNdQrOUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791299567; x=
 1791385967; bh=a0HA3daietqtclncs6logHCQSy+D8rYZ7Y8M8Fs8XNM=; b=F
 EBtAN4EquLZVMXA1PM2qtLZYfS0gfiNXhp/gjl+CCrwDK14WX3zB67YW70Qr6BAN
 3lCwL79aQlcaFQBwjUxp+b7tcuchOS3QtDw5LlGfvZDDpzIFyVsKv4HviYlLyouP
 stLC4urkJcDmY4R7xO6NTZmwvmA/J0FUIJiKMpL1wHM/6jTy0GFtkzTe8CU/azRH
 j/kTB7p3Fe4F6iVVmMSdOy0135gxuGCgRiVrLf0/35OwXGmQtrKkblNMZJm2fpAD
 kldla9nzSlP+CGxmJgkJeE+wPA2ZvJ3kyerEz1Rad9KP483FSMPDKqLNgCDeOU47
 mB75j0R6g6iskr+sVh8Sw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791299567; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:eaUUUqPx+LJ9rIpKrL+bokf8sNqAUujXqEchrue0+sd/CpK
 sGnXyfXrykQzIHg1vAgRSt2jxyq6tvJh4itNL8bdEB4HgX/AfI9bDi9mqkjkL7ll
 6z/LNi3H3cLqZ+oiDn4fL5RrOGqqrBcxidMak+54RhKqhCWZL+2bT/XELd8RPs4A
 /8IpYqni9Z6/mHJIXf0UmwZ99YFZH37vA56UdMT9IN/w/2InBnFCXfl06Z3mMiJ5
 mMRr2siVP0WPARotdY2htNF4YF/JV/1dkseFoV6lX6zZcrgO5xRbh5kBbY3wGZag
 Ob/o2GVMKLs5mB6gfB9ztdSBvwcg4yQUr+bPeFA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:Mm5tsuJ8pbS0c+JXBG9kqmI2u0UTN8gYgT58wKCjgO8=:a0HA3daietqtclncs6logHCQSy+D8rYZ7Y8M8Fs8XNM=;
X-ME-Sender: <xms:7w_FauSbiIXth32L3aBARsUqT961HJVxDbHNL4rCjfcuFOk2c-VVwQ>
 <xme:7w_FaoEjAaPFahv2H2G4FUNz6Tba9vPTdINs_QSqezTtcRVrJ_fcDehJRAO9opuJ8
 Y36CIceBnyY41XAehzsQmHmGVNf_5dQHe3NrIa6aEXSXXnHOfrfws0a>
X-ME-Received: <xmr:7w_Faq-24uG9w7WsVgggrzlC_gzAvEn6atWCSDiqfl1ibfEOB-7fzqbAofLzcKSbz5STRCS2M4Nk0BF0Kwx11HE>
X-ME-Proxy-Cause: dmFkZTEl7aq6felP5dblyjPqWzSmrHhN1WjCZMLqd89JHkdGn2WeJeoE35WPZr3sGPJ/tX
 D+iEhgNBe/iEs+FXlh+vjs5/At4esFa74xX20wkR1h1/0M2FYiKgfIYGJW8kaF74M0AF43
 JqcIK4kIC74PwGv4kzNntMOlWOHlOnKAqwFAYpeGxE58o811bbAuanIiNTv35nDkAzTicS
 hGumKH0C+XYMHDzXaWM0GGRVj4OhwPq1wpPPn/kVmQelmAMEH5Z057DaeV82OfmpS/EfdO
 Zu5WDfjJCdkp7Mp9q3ESVwl/452+MZzjU/wmJM+ebUKzg/3pkrsWswJ0/Y/7ouAgvfN0d7
 C7nuF48zDbijLDsaTLPqsyx9wQ/TnT9CDHkSOX9u5qMu4D4TVyaviUsJvwsqIKEgp80AmW
 6W+FOfmHBb3NBPFFKOaLagIHqZelcjoT382IFRrjVu1GSYb5LwueKr18Hb/JaiKu6keg7+
 MJOkmI7r164Q2QwgUrKbiWR1AaV+hdKSCe2vnW9yQfwxjZoxHnubWpzEyz3EpJrs5SBD/d
 dZB9ZimPq9R49EcG50KTrNupFwH6cfruRxT26dWe2gjoShyaEbR+T/+xWeF1FsqQ+dgWet
 28bxy/B5pt5x+S5y21wHwOXYNIIfeqTb/gDsVVzHly2iGxRMKf3uq3nhL/cw
X-ME-Proxy: <xmx:7w_FaiL6zrqtksIDg1i3U200saaSweEbpW1q1rISpY-wHZVpBxpJ-Q>
 <xmx:7w_FatYUscYS-Qgx6VpH18r3N_lRTaFcpCNvr_EUvxvDRj-YjOaleA>
 <xmx:7w_FasKmMGShpVnDt4wos_dz3VBn26HXjc0nLBPLkU8YGr41hhHUSg>
 <xmx:7w_FajDIwr8xpwrEs1cq-3M2ePFtJxU5Q_0ODXq3LahTmZFUFXXA7A>
 <xmx:7w_Faokk2lYR59xt1JJIx59SimwaOOlWgdlk_gJMhONJGXW9UQOUHXDV>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 11:12:47 -0400 (EDT)
Message-ID: <0a9f8801342551c999bff354dcb8d7204d688f56.camel@alistair23.me>
Subject: Re: [PATCH v2 04/23] target/riscv: Drop is_load parameter from
 vext_continuous_ldst_tlb
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 07 Oct 2026 01:12:46 +1000
In-Reply-To: <20260821040404.268123-5-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
 <20260821040404.268123-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.62.0 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.155;
 envelope-from=alistair@alistair23.me; helo=fhigh-b4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
ZToKPiBUaGlzIHBhcmFtZXRlciBpcyB1bnVzZWQuCj4gCj4gU2lnbmVkLW9mZi1ieTogUmljaGFy
ZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+CgpSZXZpZXdlZC1ieTog
QWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgoKQWxpc3RhaXIKCj4g
LS0tCj4gwqB0YXJnZXQvcmlzY3YvdGNnL3ZlY3Rvcl9oZWxwZXIuYyB8IDE0ICsrKysrKy0tLS0t
LS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQo+
IAo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGNnL3ZlY3Rvcl9oZWxwZXIuYwo+IGIvdGFy
Z2V0L3Jpc2N2L3RjZy92ZWN0b3JfaGVscGVyLmMKPiBpbmRleCA2MTA4Y2YzYTZjLi5kYTFlNzA0
YzU2IDEwMDY0NAo+IC0tLSBhL3RhcmdldC9yaXNjdi90Y2cvdmVjdG9yX2hlbHBlci5jCj4gKysr
IGIvdGFyZ2V0L3Jpc2N2L3RjZy92ZWN0b3JfaGVscGVyLmMKPiBAQCAtMjc0LDkgKzI3NCw4IEBA
IEdFTl9WRVhUX0hPU1RfU1RfRUxFTShzdGVfZCwgdWludDY0X3QsIEg4LAo+IHN0cV9sZSkKPiDC
oAo+IMKgc3RhdGljIGlubGluZSBRRU1VX0FMV0FZU19JTkxJTkUgdm9pZAo+IMKgdmV4dF9jb250
aW51b3VzX2xkc3RfdGxiKENQVVJJU0NWU3RhdGUgKmVudiwgdmV4dF9sZHN0X2VsZW1fZm5fdGxi
Cj4gKmxkc3RfdGxiLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB2b2lkICp2ZCwgdWludDMyX3QgZXZsLCB0YXJnZXRfdWxvbmcgYWRkciwKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3QgcmVnX3N0YXJ0
LCB1aW50cHRyX3QgcmEsIHVpbnQzMl90Cj4gZXN6LAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBib29sIGlzX2xvYWQpCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2b2lkICp2ZCwgdWludDMyX3QgZXZsLCB0
YXJnZXRfdWxvbmcgYWRkciwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHVpbnQzMl90IHJlZ19zdGFydCwgdWludHB0cl90IHJhLCB1aW50MzJfdAo+
IGVzeikKPiDCoHsKPiDCoMKgwqDCoCB1aW50MzJfdCBpOwo+IMKgwqDCoMKgIGZvciAoaSA9IGVu
di0+dnN0YXJ0OyBpIDwgZXZsOyBlbnYtPnZzdGFydCA9ICsraSwgYWRkciArPSBlc3opIHsKPiBA
QCAtNDY3LDggKzQ2Niw4IEBAIHZleHRfcGFnZV9sZHN0X3VzKENQVVJJU0NWU3RhdGUgKmVudiwg
dm9pZCAqdmQsCj4gdGFyZ2V0X3Vsb25nIGFkZHIsCj4gwqDCoMKgwqDCoMKgwqDCoCBlbnYtPnZz
dGFydCArPSBlbGVtczsKPiDCoMKgwqDCoCB9IGVsc2Ugewo+IMKgwqDCoMKgwqDCoMKgwqAgaWYg
KG5mID09IDEpIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2ZXh0X2NvbnRpbnVvdXNfbGRz
dF90bGIoZW52LCBsZHN0X3RsYiwgdmQsIGV2bCwgYWRkciwKPiBlbnYtPnZzdGFydCwKPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmEsIGVzeiwgaXNfbG9hZCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmV4
dF9jb250aW51b3VzX2xkc3RfdGxiKGVudiwgbGRzdF90bGIsIHZkLCBldmwsIGFkZHIsCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBlbnYtPnZzdGFydCwgcmEsIGVzeik7Cj4gwqDCoMKgwqDCoMKgwqDCoCB9
IGVsc2Ugewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmb3IgKHVpbnQzMl90IGkgPSBlbnYt
PnZzdGFydDsgaSA8IGV2bDsgZW52LT52c3RhcnQgPQo+ICsraSkgewo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHZleHRfbGRzdF9uZl90bGIoZW52LCB2ZCwgYWRkciwgaSwgbmYs
IGVzeiwKPiBAQCAtNTAxLDkgKzUwMCw4IEBAIHZleHRfbGRzdF91cyh2b2lkICp2ZCwgdGFyZ2V0
X3Vsb25nIGJhc2UsCj4gQ1BVUklTQ1ZTdGF0ZSAqZW52LCB1aW50MzJfdCBkZXNjLAo+IMKgwqDC
oMKgwqAgKi8KPiDCoMKgwqDCoCBpZiAobmYgPT0gMSAmJiAoZXZsIDw8IGxvZzJfZXN6KSA8PSA2
KSB7Cj4gwqDCoMKgwqDCoMKgwqDCoCBhZGRyID0gYmFzZSArIChlbnYtPnZzdGFydCA8PCBsb2cy
X2Vzeik7Cj4gLcKgwqDCoMKgwqDCoMKgIHZleHRfY29udGludW91c19sZHN0X3RsYihlbnYsIGxk
c3RfdGxiLCB2ZCwgZXZsLCBhZGRyLCBlbnYtCj4gPnZzdGFydCwgcmEsCj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXN6
LCBpc19sb2FkKTsKPiAtCj4gK8KgwqDCoMKgwqDCoMKgIHZleHRfY29udGludW91c19sZHN0X3Rs
YihlbnYsIGxkc3RfdGxiLCB2ZCwgZXZsLCBhZGRyLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudi0+dnN0YXJ0LCBy
YSwgZXN6KTsKPiDCoMKgwqDCoMKgwqDCoMKgIGVudi0+dnN0YXJ0ID0gMDsKPiDCoMKgwqDCoMKg
wqDCoMKgIHZleHRfc2V0X3RhaWxfZWxlbXNfMXMoZXZsLCB2ZCwgZGVzYywgbmYsIGVzeiwgbWF4
X2VsZW1zKTsKPiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsK


