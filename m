Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDC7606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kl7F54rQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWAt0-0007hK-0U; Wed, 25 Nov 2026 06:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWAsz-0007gW-5F
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:10:01 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWAsx-0008NM-Hr
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:10:00 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6b8977f2785so7385282a12.3
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795604998; x=1796209798; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kfPJCXNF97QeG6OnA8OUfo8WFxokwzAlfPX1tH79C4g=;
 b=Kl7F54rQKR3sVP5yo5ETW0Ff3SGRP305AoIk9gRK72VW56YKwayO5iny79ULywNSjL
 FhAajVEgjG5FZsB55jEUXtYVSsMTTpR+sB/6oUyKhHFXDvy09bg9+JDm+DJS33iYyqHm
 uDgnbz6NDA5NjsvNHaHqG3FFZwz3XPCQHTLwGfGliAAfm7oZgqCrgm2xbCGjkD9y6X2U
 gA5TAAx9338VoD9sg8J3QunTszivU0KzR1cHEKPr1pOAkol4e4r98bY0rTSWj33GN5s+
 zF8kMOitquqrYd8By+Y0q2K7UjpAO+qia4nlJmqTvN302NuUM0gul5ku+EpsaqcykuPM
 8uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795604998; x=1796209798;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kfPJCXNF97QeG6OnA8OUfo8WFxokwzAlfPX1tH79C4g=;
 b=2pEv3b9s7JSsmePkuNVfBMDpYd2a4SW/aoFH46x3LtBYL0Rgj8Rjw/6DAIVVicbHYd
 xExYHUvMwkFwyGx98GqNMoratQ9QJ6WVzgBanXahVvW+k2BgwcvFRRDm8Bko5zj465oN
 OmOi59LTEVv56sqjPQwVxZZ2RVqKmNcrT5OldHs1FDHX9D/+HPCt6lL7idshO41oQJVO
 iFpf0qxIOakOCk2D8av1ZSJAfZ8I93SpntInbsUbI+EuUKDVq6Y99nMXRbnUokSMjy5u
 LgnSm5i0JIebZH6kHIFU1PaSAxIgy9ubvfvEzr+8Dzlh11DPgdZyMlZ6x+mhdRvIwgGm
 v62g==
X-Forwarded-Encrypted: i=1;
 AL+hErEmP8uMdBJnCNPOcUUOvsrrLOxt/clfB4RsK07XgvOjrOUrxrAmX3EyvLqupAjCffWz8pFMggtkAQdi@nongnu.org
X-Gm-Message-State: APuU4Z+CxRbYQG9+jQXeoMz+CZ6BJ7RZWAJIh6cBFytv7TE1wK3pJ0FO
 oaPcw8DkZs2vZA5fERt+l6GCMZheDgcle/Y43iKf/FkT6cS5t4/y/4oG
X-Gm-Gg: AZFdTZcAIiwkVxD3gex09v0Cpd1CSuDW2lz0/UXuiQOaiwl/SthXqmpBqM9XYwqo8/n
 x2WXZD27yHc7+EyCN+N+TjROF62pQXgSTnOmCFyNu7+eZbeV6UOSvnI4QSrqT1LOuQ5UxH+9XpV
 YB60GeYcCu1YcrSQ6qrCG1QUUOE5rk8VJYoJTmxYWi5TqBUhbkhIiOCOYlTKZZ9tLy/3uxaqkOG
 XrjV74Vgoo6DLoi12qAApCxNDTkqJpvfEgvX1ql7s+z+3OKSUQpyhUGczSnT7KpNcjFOn7zzIda
 8QKoYFotnDAJ/coN8TI4Gc5wmY5nKz0z0WQbYkhIhuRENMUxsUoioOHsPsGzugyUadedPNqRoVS
 j+BiAFWKorOStWodkLL/tvZzlKlxUz+9ipX/qTbno9WfJnes9ZNE2citHfKhDv/nO/nl+QTXgEf
 jJK8ZvNuT9zbhkRyqLCQkb5fvmCUWpV0enRpuUJiBUFMKqmTv4L0JPxdISdTeJKIGAYsMVE53Jh
 bV+PFIDvYjZ3KHBg/xmgHvBRWGgBsDCBIwkEM4MUt067SRWUiVMNmIKNhh1B5x+ijvA9087NC7q
 uabi0ottBoUAIv778kQGZPNApcbtmN8m7FI=
X-Received: by 2002:a05:6402:2743:b0:6b4:be3f:51b3 with SMTP id
 4fb4d7f45d1cf-6ba37d17d1dmr13152584a12.12.1795604997575; 
 Wed, 25 Nov 2026 03:09:57 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370e8ad0sm8023171a12.18.2026.11.25.03.09.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 03:09:56 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <70dd9b2f-3c91-4363-a61b-2569e60960e9@xen.org>
Date: Wed, 25 Nov 2026 11:09:54 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/21] hw/xen: Validate grant copy segments against the
 page size
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
 <20261124232247.23169-7-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-7-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=xadimgnik@gmail.com; helo=mail-ed1-x534.google.com
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
> Reject a grant copy segment whose offset and length reach beyond the
> granted page, matching Xen's GNTST_bad_copy_arg behaviour, in both the
> emulated gnttab backend and the libxengnttab fallback. The only current
> caller, xen-block, already bounds its segments to a single page.
> 
> Fixes: b08d88e30f06 ("hw/xen: Add emulated implementation of grant table operations")
> Fixes: c412ba47b2ec ("hw/xen: Add gnttab operations to allow redirection to internal emulation")
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_gnttab.c | 10 ++++++++++
>   hw/xen/xen-operations.c  | 11 +++++++++++
>   2 files changed, 21 insertions(+)
> 
Reviewed-by: Paul Durrant <paul@xen.org>

