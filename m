Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342C2CEF177
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 14:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syApV-0001M8-64; Tue, 08 Oct 2024 10:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syApP-0001LI-94
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:04:43 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syApM-0005Xa-Ta
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:04:43 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2f75c56f16aso58581571fa.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 07:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728396279; x=1729001079; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o1qSDScTeeLaAzPcPpZKLPt/co+VeoQz2jK30EZXs6M=;
 b=Q+pjcRm/5YXF+m8i1mAZ8G5ZnArGcMlscwVtMf6jibS3ZeBIgKkSPNx6GpzLj32qy+
 GKnoFF3NfopMuRtvq4S8YMbWCIO9cXbGdioMsf4VzA5cdJUgNXpfC0t8YCLY1QuY6zwt
 E+i6pzRMWjYrt0mpdqntf4hq+RQyJk4iDOFX1ZLZVP+cz0H0/XIXEFBy/QPGOfqrzH9F
 WodSScnGJTunJRH7JwEv55HQgIitfLd4rG23vhonutdwoM9qrthAgcwljQXwGdKsHrhx
 JVLt/IYqbCKLiiv+K2oW23kuXUA6cCON3AqGQ9fU1k4xw4G0Z2Qz5DpFb82uFEPfhqIP
 9F3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728396279; x=1729001079;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o1qSDScTeeLaAzPcPpZKLPt/co+VeoQz2jK30EZXs6M=;
 b=pcZMjHm4x6Gkghi78MOWSBPrXGH0JblkaxzNUFli8snZJxYw7EKGYvrrdhowFRBs6p
 sAftfvtQeEKKR/3ASSMR/bdBu+t7lg8tMZqw0D7q260NSeNdpTiTV5OSYFAk3e1Zu7XN
 JS85u2Jp12g1kwzf+VeybXGeFPsrggZUqGvBeOZv7usP9JVGgBnnkRlWed48s+UB9Uba
 NWggNWKoiVs5ARMd+Mmmy50Iluq7xpYU8vqCVtO840GW8kQ+2ofnG+P4MPlblxp3bfYC
 r9BEymw493ZeFogdo42u1C5cUrZUSVHz3ldujT+/eQ51g4XJrzwnasV9xVNxckAvoo7A
 W/GA==
X-Gm-Message-State: AOJu0YzbbHWm53Ve87ABl7or7KsH1iBCExLsTjK6fbReQseDP42V2giu
 o7gdn9yhq0FQjoHAnv7+QiHoDnJd2jqCbSn64Xnl0JTXJc4yYOoDK0Gb2GlX+0MsETENUvHQ54x
 Z8NvkeXScW1QPbb0r8NP7gFgIWIs5bSTTk+rTNw==
X-Google-Smtp-Source: AGHT+IEoUVUPWTcIHGH0LtYVq6h9WCiS/hR9j+IQy7BDdEdvR0uKHoGPapc5HDxL6pSCVaVZMo7DnZ+d7Y0OjB6uDXE=
X-Received: by 2002:a05:651c:b10:b0:2fa:d1f9:9fb8 with SMTP id
 38308e7fff4ca-2faf3c0c4cbmr80108671fa.8.1728396277172; Tue, 08 Oct 2024
 07:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20241005200600.493604-1-richard.henderson@linaro.org>
 <20241005200600.493604-2-richard.henderson@linaro.org>
In-Reply-To: <20241005200600.493604-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2024 15:04:25 +0100
Message-ID: <CAFEAcA-++cf9jxuihQxkdPhXRVHs+HnngPdyXh=ibh1xv3Bvyg@mail.gmail.com>
Subject: Re: [PATCH v2 01/21] accel/tcg: Assert noreturn from write-only page
 for atomics
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@kernel.org, alex.bennee@linaro.org, 
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 5 Oct 2024 at 21:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> There should be no "just in case"; the page is already
> in the tlb, and known to be not readable.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/cputlb.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 117b516739..fd6459b695 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1852,10 +1852,9 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>          /*
>           * Since we don't support reads and writes to different
>           * addresses, and we do have the proper page loaded for
> -         * write, this shouldn't ever return.  But just in case,
> -         * handle via stop-the-world.
> +         * write, this shouldn't ever return.
>           */
> -        goto stop_the_world;
> +        g_assert_not_reached();
>      }
>      /* Collect tlb flags for read. */
>      tlb_addr |= tlbe->addr_read;

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

