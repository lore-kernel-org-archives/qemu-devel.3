Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B29C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 16:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmcLK-0000Fg-O6; Tue, 19 Mar 2024 12:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rmcLJ-0000FW-8S
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:29:37 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rmcLH-0005s2-QE
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:29:37 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-513d23be0b6so6097820e87.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 09:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710865774; x=1711470574; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W2Srg22AE0AWU2Gj48L8/81cWD2wsldztszIqu60bPQ=;
 b=EJcDbdg0JXEGNHzrV3gdEbTsbA7KPstxVZU6Hd7HmhGhFpa4KFxptIzLJYWuOwnHXX
 DevmNxmvM7XRRXnyZg1095W1wDy1EI8dnOOa+lmJO1cyHs4j0UfHQQjz/JoFqzXpS4KK
 E0BLIFBSbfOrazCtzraX64QVLZZ7gFcSBHv49Eo7SOScSqvX4PCMlAtm/fPvGCWEktcq
 QSDVioPPa07DyX4i7WZOarBnwnVWAW856NzhK+fxQAFzpPhKdxx5v2qzYmK/UF/ynqmk
 O3Me7BmRvJhjFIlA1JvXNcp18PZGKjGMrJg6pQZ3tzfuqInY0pJjzq4qvVjeFtQfy0K6
 Oj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710865774; x=1711470574;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W2Srg22AE0AWU2Gj48L8/81cWD2wsldztszIqu60bPQ=;
 b=Wvl8icIFXMeHlsVsJTphcTcxSDrQjbuZZ9/XaWRBQDu7UuoIqPQTWvGasOtsMNuyEx
 rne8MEaQz9sxRQP8U6th5n2MWUm53bMxLxXQ4+uVUsbRsiDt2va9mVGZLrCbJ6cbADB8
 ESPTk58KYM2x0XHsQEfJ79oE5iH2AlH42h8f6DeHMEra/pAIkR2CzkabeHuNsap8A4j6
 GpCGvRiGs6DzDSsfCxZXM8FxLl5K+XXGpzkEaRtfGTYsFT+NMrO9x4HgvWLy4wNMy/pO
 cUA8AcQDHbKezCkvuNo5V5Dtc7B45dt1KCQPwaGsRerHDA7pubxIh4NZV5XUvnxEM7V4
 OxAw==
X-Gm-Message-State: AOJu0YzyykmYgLDq29nsvQZeaNWYZTgPpmLFwWRPVRVQbInbFh4JKypI
 K/vo9E/uL9VtCSB264p7Ld7V8wesJyHhEusuxiFJcCx2nf8xXClF
X-Google-Smtp-Source: AGHT+IGOBYe4JbuL+YUgKCDBvQN6GTzsWGwD5Gd3GD9pBamWwoS5mJyOrKEZEdbl+1OvipwRWRwMkw==
X-Received: by 2002:a05:6512:443:b0:513:bebd:79d4 with SMTP id
 y3-20020a056512044300b00513bebd79d4mr2293683lfk.49.1710865773781; 
 Tue, 19 Mar 2024 09:29:33 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 c12-20020ac25f6c000000b00513c170a4desm1982019lfc.236.2024.03.19.09.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 09:29:33 -0700 (PDT)
Date: Tue, 19 Mar 2024 17:29:32 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH-for-9.1 1/8] target/microblaze: Use correct string format
 in do_unaligned_access()
Message-ID: <Zfm9bE4hHwA_22fG@toto>
References: <20240319062855.8025-1-philmd@linaro.org>
 <20240319062855.8025-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240319062855.8025-2-philmd@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Mar 19, 2024 at 07:28:48AM +0100, Philippe Mathieu-Daudé wrote:
> 'addr' is of type 'vaddr'; no need to cast, use the
> corresponding format string.
> 
> Fixes: ab0c8d0f5b ("target/microblaze: Use cc->do_unaligned_access")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> ---
>  target/microblaze/helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
> index d25c9eb4d3..0a12c4ea94 100644
> --- a/target/microblaze/helper.c
> +++ b/target/microblaze/helper.c
> @@ -279,8 +279,8 @@ void mb_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>      iflags = cpu->env.iflags;
>  
>      qemu_log_mask(CPU_LOG_INT,
> -                  "Unaligned access addr=" TARGET_FMT_lx " pc=%x iflags=%x\n",
> -                  (target_ulong)addr, cpu->env.pc, iflags);
> +                  "Unaligned access addr=0x%"VADDR_PRIx" pc=0x%x iflags=0x%x\n",
> +                  addr, cpu->env.pc, iflags);
>  
>      esr = ESR_EC_UNALIGNED_DATA;
>      if (likely(iflags & ESR_ESS_FLAG)) {
> -- 
> 2.41.0
> 

