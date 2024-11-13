Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5D8D41C0C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 07:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tB7Ms-0006xU-43; Wed, 13 Nov 2024 02:00:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tB7Mq-0006xC-EG
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 02:00:44 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tB7Mo-00047G-MN
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 02:00:44 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4314fa33a35so53403185e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 23:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731481239; x=1732086039; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H7M6hFUlSuJTvE1z5BEpJmH3T3tcrOuzz7A2rSeEHKE=;
 b=FGR1WzInYosbOo9Q6RliLY9HR0Gb9U9uKVPrp0V3Rccmay6piO9qPUd6jwFXUOBERv
 PSYA0VWzf2uCRU3dAa3ItBiMn1wcgJD5U8oa5EOHwCHSrjm8N+D8uO9FXqNhtTgNFsOk
 kRvdbZs7Gy5GJI/KKH8xoN/7sdKKvzdQpaXceltFXcoqrAfRTvdwlnfUyORqkneu9hf1
 mr6v/pw9EO2gAj4Y46WXwUTYH8lTZJmN58Z1GGWCnbS1mjrFFBwW6xKtqC3+7gQvf/xu
 WLmDhzmItW6F4AoODVbGq5fQfZ/+A7JMF8SFM0ep0HYf1v86EM3au/jM8ZPFpKg7jC+3
 C0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731481239; x=1732086039;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H7M6hFUlSuJTvE1z5BEpJmH3T3tcrOuzz7A2rSeEHKE=;
 b=rWGLTzWPmUsxAn91Fwz0Cfb7JEdCL0EnEN0pUwxpbYRVDo1o+wnXPsDeF8X1VQu9EB
 pniuQMALMmcsZsO6ut1fO3hK8GAkuCWGc5GUUJUwyh0Dqfwqjv+g+YXI9uwT5byX7tfC
 cbZkY3gmaKBciizPwN6hmDU8zsxOxoDSegr8erGsrv+O030GfXsdyfjdw9pGmCb8/K6+
 EoLFuLSNRzUzB+OsjJe6f890gh6HVJ6Egom5TS+GJzAmSBEtqbGyDcgmjm2oZ4eivu9T
 hjx2DHbOcov2rqx/3aL9/0FJkk/kf7NhincBjecoJRwqOU/zGGSjk2Ujpv2BEhm2xyb1
 dwAg==
X-Gm-Message-State: AOJu0YwU5rzDDvZhPEnbEKnibJc10bI0oVzba+XGKQtAOnp6lQxbG4TJ
 VIWLpJPIrZZrhtqxpHySDr4Hc+Z+x3/nTxxiZohKeMcnMY486wHUUWg3jvFu
X-Google-Smtp-Source: AGHT+IGtQfsNfsPGo2wDYzxUdQDcINhmp5b8M+Oxfb9ZDoYRV+EsDdjIVBJoacrscRYU5/VKh6G0mA==
X-Received: by 2002:a05:6000:178d:b0:37c:d23a:1e4 with SMTP id
 ffacd0b85a97d-38208124802mr3567605f8f.30.1731481239029; 
 Tue, 12 Nov 2024 23:00:39 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381fbf416c6sm9099754f8f.54.2024.11.12.23.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 23:00:37 -0800 (PST)
Date: Wed, 13 Nov 2024 07:00:35 +0000
From: Stafford Horne <shorne@gmail.com>
To: Joel Holdsworth <jholdsworth@nvidia.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/openrisc: Fixed undercounting of TTCR in continuous
 mode
Message-ID: <ZzROk0C5GOJZCqpA@antec>
References: <20240607222933.45791-1-jholdsworth@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607222933.45791-1-jholdsworth@nvidia.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x331.google.com
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

On Fri, Jun 07, 2024 at 03:29:33PM -0700, Joel Holdsworth via wrote:
> In the existing design, TTCR is prone to undercounting when running in
> continuous mode. This manifests as a timer interrupt appearing to
> trigger a few cycles prior to the deadline set in SPR_TTMR_TP.
> 
> When the timer triggers, the virtual time delta in nanoseconds between
> the time when the timer was set, and when it triggers is calculated.
> This nanoseconds value is then divided by TIMER_PERIOD (50) to compute
> an increment of cycles to apply to TTCR.
> 
> However, this calculation rounds down the number of cycles causing the
> undercounting.
> 
> A simplistic solution would be to instead round up the number of cycles,
> however this will result in the accumulation of timing error over time.
> 
> This patch corrects the issue by calculating the time delta in
> nanoseconds between when the timer was last reset and the timer event.
> This approach allows the TTCR value to be rounded up, but without
> accumulating error over time.
> 
> Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
> ---
>  hw/openrisc/cputimer.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
> index 835986c4db..ddc129aa48 100644
> --- a/hw/openrisc/cputimer.c
> +++ b/hw/openrisc/cputimer.c
> @@ -29,7 +29,8 @@
>  /* Tick Timer global state to allow all cores to be in sync */
>  typedef struct OR1KTimerState {
>      uint32_t ttcr;
> -    uint64_t last_clk;
> +    uint32_t ttcr_offset;
> +    uint64_t clk_offset;
>  } OR1KTimerState;
>  
>  static OR1KTimerState *or1k_timer;
> @@ -37,6 +38,8 @@ static OR1KTimerState *or1k_timer;
>  void cpu_openrisc_count_set(OpenRISCCPU *cpu, uint32_t val)
>  {
>      or1k_timer->ttcr = val;
> +    or1k_timer->ttcr_offset = val;
> +    or1k_timer->clk_offset = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>  }
>  
>  uint32_t cpu_openrisc_count_get(OpenRISCCPU *cpu)
> @@ -53,9 +56,8 @@ void cpu_openrisc_count_update(OpenRISCCPU *cpu)
>          return;
>      }
>      now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -    or1k_timer->ttcr += (uint32_t)((now - or1k_timer->last_clk)
> -                                    / TIMER_PERIOD);
> -    or1k_timer->last_clk = now;
> +    or1k_timer->ttcr = (now - or1k_timer->clk_offset + TIMER_PERIOD - 1) / TIMER_PERIOD +
> +        or1k_timer->ttcr_offset;
>  }
>  
>  /* Update the next timeout time as difference between ttmr and ttcr */
> @@ -69,7 +71,7 @@ void cpu_openrisc_timer_update(OpenRISCCPU *cpu)
>      }
>  
>      cpu_openrisc_count_update(cpu);
> -    now = or1k_timer->last_clk;
> +    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>  
>      if ((cpu->env.ttmr & TTMR_TP) <= (or1k_timer->ttcr & TTMR_TP)) {
>          wait = TTMR_TP - (or1k_timer->ttcr & TTMR_TP) + 1;
> @@ -110,7 +112,8 @@ static void openrisc_timer_cb(void *opaque)
>      case TIMER_NONE:
>          break;
>      case TIMER_INTR:
> -        or1k_timer->ttcr = 0;
> +        /* Zero the count by applying a negative offset to the counter */
> +        or1k_timer->ttcr_offset += UINT32_MAX - (cpu->env.ttmr & TTMR_TP);

Hi Joel,

I am trying to get this merged as I am finally getting some time for this again
after a long project at work.

Why here do you do += UINT32_MAX - (cpu->env.ttmr & TTMR_TP)?
Is there an edge case I am not thinking of that is making you use UINT32_MAX?

Wouldn't this be the same as
    r1k_timer->ttcr_offset -= 1 - (cpu->env.ttmr & TTMR_TP);

-Stafford

