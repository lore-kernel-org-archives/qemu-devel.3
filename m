Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BCDCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMeQ-0006Kv-LG; Wed, 07 Oct 2026 04:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xEHCn-0002Re-Im
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:16:49 -0400
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xEHCb-0006em-1w
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:16:25 -0400
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id C828D7A0111
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2026 11:56:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Tue, 06 Oct 2026 11:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1791302177; x=1791388577; bh=RF3e3nY71uQ+q8A+VrvCfcb+e35wERY4
 aG7xa+LKRvU=; b=iW7TTV79inEPgh2UPPJmyA6wjs2VY36hMjidukdgydp9p4wa
 /GFlCk5OoVOyQrxbn2qGneo9HlAoFT8QsO68wSLCSPI17YNhc+gku9UBFN/fbCHS
 K1p48nKTHNCdAAPEOLSWdvPOSke7pougiNwy4d8YVFA1QCNI4INEkP7ZXaY9a202
 NOEsDHUJRKBdbRBGDlyweMPhll14NEyWGhX+v4CgHzqggPJf8Ygk3Ga5YoLmayDl
 HQO6bb2VZ7vauH9iLPIK3m6Rrb3ddBEHjzMABlh0dcrm2Yte6VzUmCzkONd0pjSJ
 9e7SIa9JM0wSCsmRwBhNM/FYWE2ssOBSrPoT/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791302177; x=
 1791388577; bh=RF3e3nY71uQ+q8A+VrvCfcb+e35wERY4aG7xa+LKRvU=; b=A
 If0WaWOEW51/eIKwRTQPqFaOVBTYbgIepR3bHXf9lg/drpcJSHX/ygRrQRVPhbb8
 kANXih023adGXKHKAN1eV6BnqSyG78YCeCkHbUUGneJMgbw/IUdxujK9npEIHM6J
 o1s6orQmqM4GvXmfUXO7JmaEIvpCVZgaIkn80WrHjA5aWtEoBkxQZQuCM0ABTLYD
 TDiY2XcNhl7bWzRvkXUnf/MPWIzBLSSXH6aJ89I3jp+J5V6jsalvGTxEQCULDpvc
 SpkKMwiXKQrYqo5JG61dmFquDhUsSvAta7PC7KkBkEYKZCZY+vEozW0U9Rvq2LQu
 EQaQpjG9HIv/1QtPpIr0A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791302177; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:qUqXfs9KU29ua/0Gu3wG23RZcGL238+m9KghItk3Jfw7Rl3
 VK9CqInj8z269zpqJ1yQ5wdXLTqSyNiOFQR0wq0OTEpe4Kc3BhqcAZnDlHMPtOoH
 AJhd5VLIO0R7rYWCiZSiEzZ7LR3eoxoALr3YwRnWPZhXlQXqLGow0uvZ5HrSMSAm
 KZjYxRXn46U8wHb8VpUyuKJ8D8NzGuSApHTJQ9y8vp/2WGLlwW4Wql3Gf+Wh1xnw
 zHPgaN7zWdHD/xgweObH/Te56j7iYAXbiQXlcFcjlLjwZP/wZhZuPtgGc1ppufK/
 v3+iKfbnvzNhrjX4pzbaY4mX5xqex0yOmczshKg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:70tapj+KuF6hiFjvQmOuqppIQUC5mEEt6nhZ2J9tLWk=:RF3e3nY71uQ+q8A+VrvCfcb+e35wERY4aG7xa+LKRvU=;
X-ME-Sender: <xms:IRrFaoXL1FhKKpq5qe45HLPhPmLxxkRPO7Qezvq6tBfz3swABonxgg>
 <xme:IRrFag4RqJN7re-O4ErcgxQm9wg9zdyQKTYUSudXCoJWmPYiosmsC-3qLbrpDu64S
 SGb7pwXsooQpIlHAczJFAgJdjsMPaDMoFxsiLArZHK7hw7GO9fhebA>
X-ME-Received: <xmr:IRrFariJXpYJr85oo7GlPLhqwTpKfhAo8zPXudou4g_ry24nuWAhltv-Cr6CpqbNNQzFJTwfbwsINxLMxF8KAf0>
X-ME-Proxy-Cause: dmFkZTF2uB5BkfvHGkM6vVZ5eZxvFEVVqVCsMtE+IDbXhUuaPYspa4gBx87mnymjqXTmml
 O2zH1M/AIOpH+psVAGUWutHYCsDXS0lXQWOjBUUrydKiTmUonHXP1b1Y1Nxd0eH5PqV1a3
 ypnPF+RUzTEQrK1NTC0XgIGGFRe0dRyn3Jnhy8jSGojRsuoJp0DtOE2zyz6rirdWxxrpkK
 2uHz/dnICJ93FWr5GjDXrZlm1QDp78uajo56Lpx8FNLxWkRTgF1rhhM+1y9y3a1/J1WmiY
 08iiYo+0Kev9WnI2yB2ou6fb15Lkj+2NQFGzTHKZcqz5IQrxm9L+MRyk/rbvZPEIecxKKr
 Nt3LfnuqeAsRjMGtqtGtqA1CoMBdinLW63xppwY0qg/pXNDS0m6upG6cwhISkk1PJRPVHh
 9kkzodRynLKBdDUTqzozuniLUSIfyTGCZrV0uTKVfzONGvAD/QZHk2z/HoPuX6o6eKeLVQ
 djUlTw2Zm9/rZc8P1DhBGjQ5WJ1A6a6T2ybWKCx1PttDW2uWn/dxgC9B9py9Dd+Tyd69Jb
 1VTBz9N3AN7s/6636dzQVFZdZIfFP1Wb4YP8l/wo9wKhcT6wNOsrqvFpZ8YXxOdxpMYtZq
 iZxJ3f/U9/Xbnsv5Xn49oGIMF4Rs4fAFhlfiZl5TH4mDQ7s+a43gUnyQzesw
X-ME-Proxy: <xmx:IRrFavfqbS29B_qso7pZ2FLuInZGGcJYWemmXQCVDSQieq7v8WS8zQ>
 <xmx:IRrFaof9GBsn7GyrHfPiCa2XYREmnGBbAEquwcIwsM6EqBX423OTiA>
 <xmx:IRrFah_AqbClyjZvID9UYasNKO1QzooFt6WGMF8-bH1plVFRyY5uKw>
 <xmx:IRrFaski2COxJDZ_S4mXgBQnqh5ErE66ePvtkVsXdq_s-Pc1o97WzA>
 <xmx:IRrFaq5aWUdvWo_pzNB3y3JwGL3y6xDm2sgt3JoRp0LV7SqTJL02vWJl>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 11:56:16 -0400 (EDT)
Message-ID: <d7206db523bf413744992f46035f3af8bbabfa28.camel@alistair23.me>
Subject: Re: [PATCH v2 12/23] target/riscv: Mark VSTART_CHECK_EARLY_EXIT
 unlikely
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 07 Oct 2026 01:56:15 +1000
In-Reply-To: <20260821040404.268123-13-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
 <20260821040404.268123-13-richard.henderson@linaro.org>
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
ZToKPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25A
bGluYXJvLm9yZz4KClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFu
Y2lzQHdkYy5jb20+CgpBbGlzdGFpcgoKPiAtLS0KPiDCoHRhcmdldC9yaXNjdi90Y2cvdmVjdG9y
X2ludGVybmFscy5oIHwgMiArLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90Y2cvdmVjdG9yX2lu
dGVybmFscy5oCj4gYi90YXJnZXQvcmlzY3YvdGNnL3ZlY3Rvcl9pbnRlcm5hbHMuaAo+IGluZGV4
IDU2ODFiODE4MTUuLmQwODEzOTdmNjUgMTAwNjQ0Cj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy92
ZWN0b3JfaW50ZXJuYWxzLmgKPiArKysgYi90YXJnZXQvcmlzY3YvdGNnL3ZlY3Rvcl9pbnRlcm5h
bHMuaAo+IEBAIC0yNiw3ICsyNiw3IEBACj4gwqAjaW5jbHVkZSAiaW50ZXJuYWxzLmgiCj4gwqAK
PiDCoCNkZWZpbmUgVlNUQVJUX0NIRUNLX0VBUkxZX0VYSVQoZW52LCB2bCkgZG8geyBcCj4gLcKg
wqDCoCBpZiAoZW52LT52c3RhcnQgPj0gdmwpIHvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFwKPiArwqDCoMKgIGlmICh1bmxpa2VseShlbnYtPnZzdGFydCA+PSB2bCkpIHvCoMKg
wqDCoMKgwqDCoCBcCj4gwqDCoMKgwqDCoMKgwqDCoCBlbnYtPnZzdGFydCA9IDA7wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybjvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgXAo+IMKgwqDCoMKgIH3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCg==


