Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE410606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pnGQzyAg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWAhY-00013d-HS; Wed, 25 Nov 2026 05:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWAhV-000136-QV
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 05:58:09 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWAhT-0000sG-Nd
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 05:58:09 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so72153865e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 02:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795604286; x=1796209086; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9ojd6QLbo6svWTxF6DUELPeNw20UDvUeJORZrpfd3O4=;
 b=pnGQzyAgWCbaVDQRaKQV641y0jNdUS+A48KQo4KoZMpuVAw6UaJ3yBf32rW+ucggIJ
 BDHUDF/HJBmesAMg16Rlb0aWDbmtab7VNs5Oa/2/Y4sNgEfCZVx2dtz0pXFHbn4zDuoN
 uhE+QI8MDN0DR0pAGevzKT1AO4bYxC+bkmaWx2upVyHns33cGbNPqd/x5/d/m8a4YcwO
 C+XKcCQyAgHu0aFmFDdNE/iXzJAKqcCIq4SX4LDiGX5AiocD2AHXkhheL7W4LNbyJ4Kw
 dxVVVnFyinbOoPDySvK7/p11KP/UtGU3QpsQqulwlakLT392E0RNS2cJ3W39W4oNalX8
 PUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795604286; x=1796209086;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9ojd6QLbo6svWTxF6DUELPeNw20UDvUeJORZrpfd3O4=;
 b=JwMFhvuVdZQesHzIgaC1us4mgzAWOwCqL5inU/ntwOHqelwUPZTcbZabaUFuyEp0eR
 BAdr8gRU7eDROBWaTvOspAaFgLisOtcxFvf2i2tIFyBifZFhvJx3CzaYPqXEa0F9XQqr
 39bUC3LzweUyMg+U4B5vBUFO9XC/ZCFG9zxcfssNCLfEEW6c5dijFFsc7gUVRjMnrjpx
 romKBbbKsWDA1PeI5P4pFzX76OKjDCP+B1VRRllXvIyNY2CKC7ZIQmH8cWj49/MO2Rov
 p8P1n96MP8TBLOEPQr/X1ZHhpCY7kuFr12r3GlUp6/Lvb2AZqP7JhvWjUr3eArIP4cco
 saQw==
X-Forwarded-Encrypted: i=1;
 AL+hErGRrfjv+A7iT16W1L1gwN/AFf98WYBciX80q1UHzznD3Pp1Lr3PWKsqOn5ACBj2KpBhecgasfUkpJII@nongnu.org
X-Gm-Message-State: APuU4Z/terJLn8enoA7Ra6zndc+FpvEkkeCsbepFt0yjy/LRkgB9PuYR
 eZFifdZ05F4D9+tjf0jVBg/qekLrQpKljsx5Hni7gBm93vu3GJjCDoSg
X-Gm-Gg: AZFdTZcWV2OSo7uDZEVBUal3bJlTCNof0JWRuvSFiDQKDMLXs/xfNdSme4Su/ivNwF3
 vBuolHBjFGDkjrftnkRNw+pKY4g6TvR36SBiMxl9AR45YdPzcipx/IlJnMUjD8Qykn6HV9y59lV
 ZCHA30GTQCG3uTLRuBm2ak2UXABYZHu1/Be5aMUtjnzBuW1kYai+xpecHS5JkE4pIZs2jl145Jx
 qqj08k/T6EARVEoVaANyZWZt7T8u/Ex6sxOpht4504h8R3cIkKTDXIyXAGotgC4FCBewezv4poR
 PD7G066Bwhggs3przOLD0kRQTJgYdFiom0rHib/exGu/h7ENCR6iLEtq3ERc6lvHK9WhGUgbi6C
 OAxuNFGWK75akzsHDQqvrATugInlCtf7TDViO6ZKLZQGNwD3OkdUHhdBLNWPBj6qIZerxSYniYi
 pZvz8KGavJ5yebe8cIy7WsCr198OVZGPmePdSnk8tXaOSaQiuVBIYniNMQmIGq/RQ8AoDH2TjSv
 Gps4XaGSoR7EpS+CPXn/eUqCokGrEPvg+0/kZLu3Z2j9ER9U0R0jvW4j6jEq5s8a9CHV3WD6N3Z
 8L1HcgPXVExfKGMIqXSx7wD5gf6e63tYhxU=
X-Received: by 2002:a05:600c:4f81:b0:4bb:5e8c:13bc with SMTP id
 5b1f17b1804b1-4bb88805902mr337651085e9.7.1795604285398; 
 Wed, 25 Nov 2026 02:58:05 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906817ccsm285486235e9.5.2026.11.25.02.58.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 02:58:04 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <8888e81f-ec6b-4211-afef-215eba880e01@xen.org>
Date: Wed, 25 Nov 2026 10:58:03 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/21] i386/xen: Don't resample GSI when per-vCPU
 upcall vector is in use
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Hui Peng <benquike@gmail.com>,
 Mark Syms <mark.syms@citrix.com>, Feifan Qian <bea1e@proton.me>,
 David Woodhouse <dwmw@amazon.co.uk>
References: <20261124232247.23169-1-dwmw2@infradead.org>
 <20261124232247.23169-3-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-3-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The callback_via GSI (or PCI INTx) and the per-vCPU upcall vector are
> mutually exclusive delivery mechanisms for Xen event channel upcalls.
> Xen itself will never assert the callback GSI for a vCPU which has a
> per-vCPU upcall vector configured.
> 
> When the interrupt is acked, QEMU's resampling logic reasserts the
> GSI if evtchn_upcall_pending is still set. If the guest has configured
> a per-vCPU upcall vector, events are delivered through that vector and
> the GSI is unexpected; a guest which receives both the vector upcall
> and a spurious GSI interrupt for the same event can crash. This was
> observed in production with Windows guests on a different VMM which
> implements the same resampling logic.
> 
> If a per-vCPU upcall vector is configured, don't resample the GSI;
> just deassert it.
> 
> Fixes: ddf0fd9ae1fd ("hw/xen: Support HVM_PARAM_CALLBACK_TYPE_GSI callback")
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   target/i386/kvm/xen-emu.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
Reviewed-by: Paul Durrant <paul@xen.org>

