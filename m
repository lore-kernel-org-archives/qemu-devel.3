Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B248E606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f6SNde8X
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWAot-0005bI-35; Wed, 25 Nov 2026 06:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWAon-0005ah-Ht
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:05:42 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWAok-00063O-H7
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:05:41 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c50d3ac6b51so1218879966b.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795604737; x=1796209537; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rj/OmW4asS9jNN/viln1BFpfuwXmJiprMQIHIS8uDWw=;
 b=f6SNde8XlqW1h56QffKUjkLCiL5AHkpCNOb4pSrvqq9MlqlYxOTBp9nLauyXcj3qea
 z2EtXP/v8/babAD+XhalROwH8tAtnVBoYz5RiyYtTxmLehiqNO8CgOX8tc25tEJro8qg
 B6Bs8bseWuNg6uXK/ZxB8fhZYgsqYMj5F6TVVyhn1s2xd/mGxecQMG+lUhJKw5Ylk1y5
 idbBV+qvYLU7d5yfHK/GX1pD2I8M8wQZtW2vJJFISjYi4RWqtLPsnp/3LHBr9uVbJqbw
 29tYmDvpPtK7vVbFS2SMX3Hf00KiZXzgnv2cLDI0WNupN1OeNDGueQpINnPHntzFhNH/
 TmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795604737; x=1796209537;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rj/OmW4asS9jNN/viln1BFpfuwXmJiprMQIHIS8uDWw=;
 b=AwW9K756g15m8hKpiHmdW9VHebl6DW+N5j7Y875uNQoX4PSWhhV7WP7GM1IxdoIihT
 A8SM6PdqbF5IFIk9chm3mvxufGGQzHZYhpRYEOYnrghpFFoGqsudcufZLYxy+CokzyV3
 OR2vKeB5OjC/lDi+H2H7zdBYgnJ2Gb1Y/TwXjGBcpT5xW3pidABCHZkwbm1Xmv89Rhqv
 DZAXk9BKwN//a+PUVapCOdcp3fx6wf15GmlZiOjegFGm6s7UI8PxT6jexTSGF39iTmzP
 Mq3nQcP19kysVgvVniaCroFGNv/B4qYbJxddoNk4J0KHu4c7q+qAh16SXN6d7My1WA0L
 109w==
X-Forwarded-Encrypted: i=1;
 AL+hErHhDtg+DBioieBnVS+GSTae+8aWrX1kdyYrG0ejOldfGCvm+bwnLHmrqXeHgCMwvNdC06nGyNI2XImZ@nongnu.org
X-Gm-Message-State: APuU4Z/eQpJtDzP+cFlRk/U2QDam3LQF4i4ApXVWCjhffhlqhemD71BI
 2bre1xX+dje8UokZMbnacCxBrqG1SXaXeYjhbTrRaToflGhXarJr5m/eJ7VZCEVF
X-Gm-Gg: AZFdTZcwKkjCfUJbFVfGgNHeYMEs8TGCZJSY7UMpXn5mtQmGuzD4N4LIesrioLhgDBF
 EHZgF03lN42s4jgWII5/6t6OnhLBIwZ1w4kc08ef6aj5aOrKExLdEsgOUMte5qNfsGez6K6NwDl
 COFyc9+qxQnufNE9Eti/dtf5TH7QdDVcp88wXj26Lgri4HNtQ2p5y1faz5gUKxF66XK57y1t5h/
 l2m2LO/0oAN/xHPDAS/jbcwHtCyq45aAL8Erm1+8hvP+aXJjsYHMfbSqRRAFK4dZ3A7LXKRceS8
 z3vRNQquSaVJozSCT6wKn4IBt0Acu1TtLxV7ddS0K7YfTYTb4c3bEfLyoYVSnjpkwap+Oi6g8K1
 kz2FnuKCwceenXjM/dvzJG8ILQS/GBfpybca3VBNT5kNBU7I+dv7hv7n5072zZv/AfHAB0nBZ8H
 R1shvlVx9v0gUswpGm4SNwWPX9ABlA0silz4qdFFaKX2xZ3dIaUvmfRZS871gBy++OYiF82LphL
 IAnLrbQ+6xuP/J7hRKMnKXWCN5GhT78a9WqokIvtDz3VT2W4NegQydlFMdwhzpqhfLVGN4fLAoy
 VGYWBiRkvqHoHIXc+5z1kASJZEozjB5x0l4=
X-Received: by 2002:a17:906:ad8:b0:c2e:4397:7c82 with SMTP id
 a640c23a62f3a-c513a5e6a7fmr1084197166b.6.1795604736841; 
 Wed, 25 Nov 2026 03:05:36 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afc316bsm614560066b.56.2026.11.25.03.05.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 03:05:36 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <e2cdc050-42c0-4565-aec9-2568c391d756@xen.org>
Date: Wed, 25 Nov 2026 11:05:34 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/21] hw/xen: Publish backend features before setting
 state to InitWait
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
 <20261124232247.23169-5-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-5-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=xadimgnik@gmail.com; helo=mail-ej1-x62c.google.com
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
> The XenbusStateInitWait transition tells the frontend that the
> backend's parameters are readable, but xen_device_realize() set it
> before calling the implementation's realize method — which is what
> writes the feature nodes ('max-ring-page-order' et al. for xen-block,
> 'feature-rx-copy' for xen-net).
> 
> Linux blkfront reads 'max-ring-page-order' with xenbus_read_unsigned():
> no wait, no retry, default 0. Lose the race and it silently negotiates
> a single-page ring — 32 request slots instead of 256. A device
> hot-plugged into a running guest loses essentially every time; at boot
> the frontend doesn't come looking until long after realize finished.
> Netfront reads its feature nodes the same way.
> 
> Commit 240cc11369fc ("hw/xen: Avoid crash when backend watch fires too
> early") introduced this by moving the realize call after the block of
> code which both populates the initial xenstore nodes *and* sets
> InitWait. The crash it fixed was real — xen-block's realize processes
> watch events via blkconf_geometry()'s aio_poll(), and the handlers fell
> over when the nodes didn't yet exist — but only the node population
> needed to come first.
> 
> So keep the node population and the 'online' write before realize, and
> move only the InitWait transition after it. A watch event during
> realize now finds the frontend in Initialising and no backend 'state'
> node, which the handlers tolerate; none of the three realize
> implementations reads the backend state. Verified against the original
> 2023 crash reproducer as well as the ring-order negotiation.
> 
> Fixes: 240cc11369fc ("hw/xen: Avoid crash when backend watch fires too early")
> Reported-by: Mark Syms <mark.syms@citrix.com>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/xen/xen-bus.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
Reviewed-by: Paul Durrant <paul@xen.org>

