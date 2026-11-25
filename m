Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811F7606A329
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yTGSK+Vc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWBD5-000203-MI; Wed, 25 Nov 2026 06:30:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWBD3-0001zZ-Kc
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:30:45 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWBD1-0001Ka-Um
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:30:45 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c4d21051042so56444166b.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795606241; x=1796211041; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Afcqxjv+MkGGt0UAmpL0zC/ETeooQhBIhJHHPCywLOU=;
 b=yTGSK+VcHM5f0ikLgdbW9JGqXOjArtfTCwCD0PR2K0cSq3zMX8/b5qC/IBa+7/YWfZ
 TeZl1rFcCtw+TWEcIB4hgovbie3AiLrHUdboWaTr9Bm5mPCQK2GFOn8lANdktRoVeyh2
 yBB+vBjx97mG8bexDP/HtagEWgAT6U0o3m3C+DZwkVk4hyLaEFPXEhPb/Dn96blKWIUK
 dvwwX/3vCgm5AgglB/nLLWept/nvuaqInil4J7hXLlGJ7SApMHnhmjCufz7TyBbdiTuq
 JGfEI49r/AjYFduzpxvbUjOaYopSkBthqJuxpk11kcMf/jY05nbJFQUoaFrtP6Pc5nEv
 whuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795606241; x=1796211041;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Afcqxjv+MkGGt0UAmpL0zC/ETeooQhBIhJHHPCywLOU=;
 b=WNYT7+lkEXG47K1Xa2GGYj1HlY9b/12/OPOd3RPSRT404eQqiQMbsg1acZvogeul4G
 CAgc93KQxIM6XpqMpxv4PRv36FzVC6ipv5dGrR5va4KB2C093h5efm+iPVDX9cqZoRD9
 vHJm0vsyQENJWkBuulWCL8RTTtVWZpkA5l7mRHIg4/p21ZeoBbiXALhl2cPIWkkHpXB6
 LMvqPss8IwuiWw/H9tqb3IrpQ1N7K6HNihFt2hNcQyfiTllwzQr7J1QAUjYY2n63DIFK
 bFD5w2WLcvZD1VxXC4EvU7gB67ndWvat6c6udbjZbOH0xmbazDeP1ysIzZntxG0mxRq8
 pfmQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH/HwU9J2Q0KzVlGxMenJiKzFHP9c9tgXOht54NeFFSWPx7XydnG0VbWducjESLl2pLq3aWaHISsAAd@nongnu.org
X-Gm-Message-State: APuU4Z/de+3ekS/GXHgdx8tY0gEO3He9pHurTYFUiZB9vxvGH7I5FnkC
 ps7nu3GLbK99PpuH1args5TRfkwTXBmnqmL/G+qs5EY421FHQRUCA7jl
X-Gm-Gg: AZFdTZdEE5N+7ooYwC3BjJcU4IWUPGRGDReVyq0IwHVOUWLctPiKcKuMlR8qVJg/htn
 qb6/Y6S8VxBy1uI72+BK41HWhktCIGP59K+L4sQKmr8CVc6Lu8lB8+4nJzw2JK4OrB6qOkZ8HKE
 LlvAEojf68hkErROpQ2K4MOcZQ9F7ANk+N/zU0695Py3gtxGm5A5JTxnhXyh7qULGFDb+mq1n/g
 OLj8ECqOaPfjLTjef5m++ZxJMWGmZOhx17Oi099kcX661YTe7jwE2l+lGPCs79EMRsDC2fcyAuA
 tEC1MXfgg+6yJJrzK6MfhXsocag7ZZG48MLQkGK2zIlEJX0vUUjIBHocritD9wRTHIzN8kLO0rY
 /ynZ4JcGMdXy6jA+sit3qTdUNN0y+KYfg++o+SoLN25P0VuOOf+/7VEvAfWmnMgIwzRz7WIHdEH
 lfHPGMZ5cBoll4cNNEeKmhm0REdFFprn/9Us5OxXM59w9Vfd6m9LcKYhPJu+HYHNMJ4Vk/bPfyn
 YvPoaRMNRP0/D/qMnoSJoaMU8RNT+mCep9g5onWr8h3nAUAkN8W41jptLw3QngtpGDEtJI4xkjI
 eeKfcxXfZDfgdTv6JCTUjNTdCske9Ixr3kGRdTsLFcQId77Y6jzJWQ6i
X-Received: by 2002:a17:906:1e04:b0:c3f:d912:ff8e with SMTP id
 a640c23a62f3a-c513a5ec26dmr1199239866b.16.1795606241345; 
 Wed, 25 Nov 2026 03:30:41 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afc2579sm599898266b.52.2026.11.25.03.30.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 03:30:40 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <cfc1fd74-4843-4017-899f-7b30b6baa448@xen.org>
Date: Wed, 25 Nov 2026 11:30:39 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 17/21] hw/9pfs/xen-9p-backend: Close event channel
 handle on disconnect
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
 <20261124232247.23169-18-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-18-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=xadimgnik@gmail.com; helo=mail-ej1-x62d.google.com
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
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Disconnect only unbound the port, then dropped the pointer, leaking the
> handle and its file descriptor on every disconnect/reconnect cycle.
> Close the handle; closing also unbinds.
> 
> Fixes: b37eeb020123 ("xen/9pfs: introduce Xen 9pfs backend")
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4523
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/9pfs/xen-9p-backend.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
Reviewed-by: Paul Durrant <paul@xen.org>

