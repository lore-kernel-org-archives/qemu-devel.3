Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53865CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN1V-0000Hq-IY; Wed, 07 Oct 2026 04:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xEHgI-0005vK-7T
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:47:07 -0400
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xEHfw-0003Ee-5K
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:46:48 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 680DD7A0135
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2026 11:12:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 06 Oct 2026 11:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1791299521; x=1791385921; bh=8KWN5emcZfHcW/SY967a8Rrw9nneklyF
 lYp6QqDVLs0=; b=f6+kxaooI5n7fi+8qJXo8yYcrdAg2vdJhf2vuM95PqNGyr5w
 lYbWFlx81GGeBjCZa8h9xFYVLRjG93dtxH13dSc1V1ZzNMGTJC4QN72DWDfEMbdm
 FlogjsqJL59am4BYTloVZYsJ7HXKB3wWz/F7h9FY02jHrF/SNcR4fog9UI0AtWmF
 xVdeWfQ4jth86QDkPp/Nv18E3idn4jCUGFgE3AfacjKTEYCo0hGkq2YTDTUNZzOR
 Dzh1I7W4FH3pik6gGHEuOsPfzQAEcNrCiVkQw+V94ZOTy3sqqiz/5HTMyLBuAxcQ
 dY0WaRmo+3tEdq88m3H9H/S+wdqUf0DruxHpUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791299521; x=
 1791385921; bh=8KWN5emcZfHcW/SY967a8Rrw9nneklyFlYp6QqDVLs0=; b=f
 5dd77AZ0UA8BuSh0PTuHD/QiQ1tXwyPyAxlMTntcbmXpk4pY+0baMh0pd0VCxNFf
 8ZHy+wnyYKvltG6y/SamQ1CpVltIOMZzolzGf1kaUjMNrYzxd9DoRxSGu3aLUEg9
 25hOXjoEs2NPC5UiB/Cgzyc7ianrGkwo+S3B0gkDHv024QSyHNy66zhL2OoOxnZM
 TXYp0VgaWbL2yP3rKygykhcvID1faNN10CFf0F78HgLwkLm+quaODCgVIBVHV6hB
 4g/xpnDij0DzDl4gGrJt/p1/uZmq0NqIiHhVec3CxyTjJy1/ZpuqtPcSZFGUFXLw
 5JNU/i+iaCQizxJ/kU6cQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791299521; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:DB+PJRI90Xqm7e2flzdFq2Whe59HIwMngYlHvT7eyQSQGYS
 SpxolcT8xGzC0NmmAx37jE8yiRL4cGZ50tx2FSRKIiSN9KT4FEqE/HQF4G2l0Me1
 0mvdQX8xr5F+oczfCy0D6fOH4f/jMyRYN5zEk0uoe6DxYWnfNnph/L8/Xa/vzYe8
 qniYINyG+XORupd01meVRJcV80e0Hr9Cc62RgTdPLZleaYxWdKKnuvq986FKQquv
 Jl2z4pg+QQ8XIgVcSP1zDJB7rPqgylR5kkLYYQJNEmtjJvx5c4WXIMVAWCNIkIsR
 /jsmcu4RbzxdQHXWpOVlzqQL6aZOQ0XCRYAFOww==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:HxQXJlqjjG1MwBJ425VAxZnx8OoW5kR85qsF2LI27uA=:8KWN5emcZfHcW/SY967a8Rrw9nneklyFlYp6QqDVLs0=;
X-ME-Sender: <xms:wQ_FakK_ZO7FHjsM6OY8xrn3y7nsdnLCMQdcjbyHB4iFW-kQIwEiXA>
 <xme:wQ_FaoemKi_CcL3kTRU9a_Cgvs3ADB9dIyhr8RR5xZ5mXIQCrJoc8W3Wk1RBhclk7
 9RSJjWhnqr7bEDcocn9w3yo2H8GhDKFth8blPrXjwUSXiBuFx6okQux>
X-ME-Received: <xmr:wQ_Faj3kzthuIPCJHe7cKezWWh98OOJrZhECJOIUJV-_g9eQWWEystouBcHah2CdYoY8wJIAt4EWY0ijaBkyrcc>
X-ME-Proxy-Cause: dmFkZTF+o4pF1VLyBV77zycDXtyJqGbqLFyo6o+oe4XjorfTtgKB/NKwmtZE/urEbPvG7I
 XHa0eQRnnpiIdQoLQGbEgoiV5ml4IS/k2t9RkGVOxXqNOmaLpPKY2QQuP6cHkDu1NSIQ+2
 XDdu2vZ0zddqo0+34qv9pD+fbIUJd/we8F+pDvItu9ElCSCJqhAirWCOGnT/p3QbokHay/
 MNWsv6gOORRG9KOtkozOS9mVzTMl8UJGt/C0h+Yp6HoCEC6yaVVa1wmSruBknrE3Y2FE/l
 DpHZJV95TzIMYgX+TBRspp8cgsplDx95lNUO77V87qyXQTavKhubUuUK3qUz8lU5ytC2rd
 x+3l9MIlZramaZqOZrHEonKAWCGZO8RaTIf9HKKW48Lnt3EYl71Jn1oTj9/1V8hwuBNuAl
 1rOIa8wdMKg6Q2poFzE2R3Mww5kSgBgFMfyJVCn8J/txAYuqlihs7g+7R2kLhfNdJUEMPX
 6F4umebC4UBmT9paH8D7KQIlQ8d1PaRxTxTn2b9Lhf+IOXgXPV7mfP2rBv2kmztl1NxjEG
 gNhpZKTC+NLwbOsqGnMV/gxK24lv4Hty5tXmT0VTIj6sLJPQ3cWL3E2GD4kEy090BlZ0bn
 hTOpyA58/pU9Ovk1+eFOc1Xuz+fv4I0uhNEoYspj/ksRP8Cfu0lSo4XJa6Rg
X-ME-Proxy: <xmx:wQ_FapjzMzGNW5XDpcio3kEN-lp-gRce5QtU-8eqTMtEyan10T1KKQ>
 <xmx:wQ_FahRQlzQ99Qp4EpcDF0US12L6rECLl6cG43DJOG0J9jYZ2FtLcg>
 <xmx:wQ_FaiiUmWloGEfpAtFmMWbO-IoWdQQzN9xzyOavJRJ_7zI7Aft2cw>
 <xmx:wQ_Fap6AwaB_EgJq6dZ7goIorJ3u5xGsdSOLdteM5NhvLgS0qAp9oQ>
 <xmx:wQ_Fal9F_--pSihFVCFmHYzvfzodtJdcrjcDI3ueGIC0C0qX-fllx9TK>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 11:12:00 -0400 (EDT)
Message-ID: <68f039c60dab24f7642d99e067f46d3e278250da.camel@alistair23.me>
Subject: Re: [PATCH v2 03/23] target/riscv: Split out vext_ldst_nf_host
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 07 Oct 2026 01:11:58 +1000
In-Reply-To: <20260821040404.268123-4-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
 <20260821040404.268123-4-richard.henderson@linaro.org>
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
ZToKPiBQcm92aWRlIGEgaGVscGVyIHRoYXQgY2FsbHMgbGRzdF9ob3N0IGZvciBhbGwgTkYgdmVj
dG9ycy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5k
ZXJzb25AbGluYXJvLm9yZz4KClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFp
ci5mcmFuY2lzQHdkYy5jb20+CgpBbGlzdGFpcgoKPiAtLS0KPiDCoHRhcmdldC9yaXNjdi90Y2cv
dmVjdG9yX2hlbHBlci5jIHwgMjMgKysrKysrKysrKysrKystLS0tLS0tLS0KPiDCoDEgZmlsZSBj
aGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQg
YS90YXJnZXQvcmlzY3YvdGNnL3ZlY3Rvcl9oZWxwZXIuYwo+IGIvdGFyZ2V0L3Jpc2N2L3RjZy92
ZWN0b3JfaGVscGVyLmMKPiBpbmRleCBiMDRkNDYxYzA4Li42MTA4Y2YzYTZjIDEwMDY0NAo+IC0t
LSBhL3RhcmdldC9yaXNjdi90Y2cvdmVjdG9yX2hlbHBlci5jCj4gKysrIGIvdGFyZ2V0L3Jpc2N2
L3RjZy92ZWN0b3JfaGVscGVyLmMKPiBAQCAtMzM3LDYgKzMzNywxNSBAQCBzdGF0aWMgdm9pZCB2
ZXh0X3NldF9uZl9lbGVtc18xcyh2b2lkICp2ZCwKPiB1aW50MzJfdCBpLCB1aW50MzJfdCBuZiwK
PiDCoMKgwqDCoCB9Cj4gwqB9Cj4gwqAKPiArc3RhdGljIHZvaWQgdmV4dF9sZHN0X25mX2hvc3Qo
dm9pZCAqdmQsIHZvaWQgKmhvc3QsIHVpbnQzMl90IGksCj4gdWludDMyX3QgbmYsCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWlu
dDMyX3QgZXN6LCB1aW50MzJfdCBtYXhfZWxlbXMsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmV4dF9sZHN0X2VsZW1fZm5faG9z
dCAqbGRzdF9ob3N0KQo+ICt7Cj4gK8KgwqDCoCBmb3IgKHVpbnQzMl90IGsgPSAwOyBrIDwgbmY7
IGsrKywgaG9zdCArPSBlc3opIHsKPiArwqDCoMKgwqDCoMKgwqAgbGRzdF9ob3N0KHZkLCBpICsg
ayAqIG1heF9lbGVtcywgaG9zdCk7Cj4gK8KgwqDCoCB9Cj4gK30KPiArCj4gwqBzdGF0aWMgdm9p
ZCB2ZXh0X2xkc3RfbmZfdGxiKENQVVJJU0NWU3RhdGUgKmVudiwgdm9pZCAqdmQsCj4gdGFyZ2V0
X3Vsb25nIGFkZHIsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBpLCB1aW50MzJfdCBuZiwKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IGVz
eiwgdWludDMyX3QgbWF4X2VsZW1zLAo+IEBAIC00MTksNyArNDI4LDcgQEAgdmV4dF9wYWdlX2xk
c3RfdXMoQ1BVUklTQ1ZTdGF0ZSAqZW52LCB2b2lkICp2ZCwKPiB0YXJnZXRfdWxvbmcgYWRkciwK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmV4dF9sZHN0X2VsZW1fZm5f
aG9zdCAqbGRzdF9ob3N0LCB1aW50cHRyX3QgcmEpCj4gwqB7Cj4gwqDCoMKgwqAgdm9pZCAqaG9z
dDsKPiAtwqDCoMKgIGludCBpLCBrLCBmbGFnczsKPiArwqDCoMKgIGludCBmbGFnczsKPiDCoMKg
wqDCoCB1aW50MzJfdCBlc3ogPSAxIDw8IGxvZzJfZXN6Owo+IMKgwqDCoMKgIHVpbnQzMl90IHNp
emUgPSAoZWxlbXMgKiBuZikgPDwgbG9nMl9lc3o7Cj4gwqDCoMKgwqAgdWludDMyX3QgbXNpemUg
PSBuZiAqIGVzejsKPiBAQCAtNDUwLDEzICs0NTksOSBAQCB2ZXh0X3BhZ2VfbGRzdF91cyhDUFVS
SVNDVlN0YXRlICplbnYsIHZvaWQgKnZkLAo+IHRhcmdldF91bG9uZyBhZGRyLAo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB2ZXh0X2NvbnRpbnVvdXNfbGRzdF9ob3N0KGVudiwgbGRzdF9ob3N0
LCB2ZCwgZXZsLCBlbnYtCj4gPnZzdGFydCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGhvc3QsIGVz
eiwgaXNfbG9hZCk7Cj4gwqDCoMKgwqDCoMKgwqDCoCB9IGVsc2Ugewo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGZvciAoaSA9IGVudi0+dnN0YXJ0OyBpIDwgZXZsOyArK2kpIHsKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGsgPSAwOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgd2hpbGUgKGsgPCBuZikgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBsZHN0X2hvc3QodmQsIGkgKyBrICogbWF4X2VsZW1zLCBob3N0KTsKPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaG9zdCArPSBlc3o7Cj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGsrKzsKPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIH0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmb3IgKHVpbnQzMl90
IGkgPSBlbnYtPnZzdGFydDsgaSA8IGV2bDsgKytpKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB2ZXh0X2xkc3RfbmZfaG9zdCh2ZCwgaG9zdCwgaSwgbmYsIGVzeiwgbWF4X2Vs
ZW1zLAo+IGxkc3RfaG9zdCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBob3N0
ICs9IG1zaXplOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gwqDCoMKgwqDCoMKgwqDC
oCB9Cj4gwqDCoMKgwqDCoMKgwqDCoCBlbnYtPnZzdGFydCArPSBlbGVtczsKPiBAQCAtNDY1LDcg
KzQ3MCw3IEBAIHZleHRfcGFnZV9sZHN0X3VzKENQVVJJU0NWU3RhdGUgKmVudiwgdm9pZCAqdmQs
Cj4gdGFyZ2V0X3Vsb25nIGFkZHIsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZleHRfY29u
dGludW91c19sZHN0X3RsYihlbnYsIGxkc3RfdGxiLCB2ZCwgZXZsLCBhZGRyLAo+IGVudi0+dnN0
YXJ0LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmEsIGVzeiwgaXNfbG9hZCk7Cj4gwqDCoMKgwqDCoMKgwqDC
oCB9IGVsc2Ugewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvciAoaSA9IGVudi0+dnN0YXJ0
OyBpIDwgZXZsOyBlbnYtPnZzdGFydCA9ICsraSkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGZvciAodWludDMyX3QgaSA9IGVudi0+dnN0YXJ0OyBpIDwgZXZsOyBlbnYtPnZzdGFydCA9Cj4g
KytpKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmV4dF9sZHN0X25mX3Rs
YihlbnYsIHZkLCBhZGRyLCBpLCBuZiwgZXN6LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtYXhfZWxlbXMsIGxkc3Rf
dGxiLCByYSk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWRkciArPSBtc2l6
ZTsK


