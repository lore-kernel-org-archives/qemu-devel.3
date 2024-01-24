Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCF5C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 16:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSgQy-0005aw-Ie; Wed, 24 Jan 2024 11:49:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rSgQp-0005YP-58
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 11:48:57 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rSgQn-0005oY-Iy
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 11:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KLrjAdLK6WVrzWFIBbWRC5Rg1vURk6rL+hWSaiy2ySo=; b=WRMhlpiJ9VqkDnbHfWQkqZpm92
 2NuulomqXHYhm9+ko1jSTBOmIUNImvwLfPuhjg3WMhhFXnr06/eJfpU/UIi9ApiRhLj2E324gooir
 gbHOMCt/3eaetjz+++4i7Xi5+XfhnQnl4W5g3RM9mRGLU2tof/FjVk0lMcvlJpvfkv5Y=;
Date: Wed, 24 Jan 2024 17:48:59 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>, 
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH 3/9] accel/tcg: Rename tcg_cpus_exec() -> tcg_cpu_exec()
Message-ID: <6nqxh6k7xt7eoh7kogjlw3rg35xyu5sy5atswsdqi2flwkpsfm@t4o3ivrlwau6>
References: <20240124101639.30056-1-philmd@linaro.org>
 <20240124101639.30056-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240124101639.30056-4-philmd@linaro.org>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 24/01/24, Philippe Mathieu-Daudé wrote:
> tcg_cpus_exec() operates on a single vCPU, rename it
> as 'tcg_cpu_exec'.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  accel/tcg/tcg-accel-ops.h       | 2 +-
>  accel/tcg/tcg-accel-ops-mttcg.c | 2 +-
>  accel/tcg/tcg-accel-ops-rr.c    | 2 +-
>  accel/tcg/tcg-accel-ops.c       | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
> index 17c7ed00eb..44c4079972 100644
> --- a/accel/tcg/tcg-accel-ops.h
> +++ b/accel/tcg/tcg-accel-ops.h
> @@ -15,7 +15,7 @@
>  #include "sysemu/cpus.h"
>  
>  void tcg_cpu_destroy(CPUState *cpu);
> -int tcg_cpus_exec(CPUState *cpu);
> +int tcg_cpu_exec(CPUState *cpu);
>  void tcg_handle_interrupt(CPUState *cpu, int mask);
>  void tcg_cpu_init_cflags(CPUState *cpu, bool parallel);
>  
> diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
> index bcba314a65..c552b45b8e 100644
> --- a/accel/tcg/tcg-accel-ops-mttcg.c
> +++ b/accel/tcg/tcg-accel-ops-mttcg.c
> @@ -92,7 +92,7 @@ static void *mttcg_cpu_thread_fn(void *arg)
>          if (cpu_can_run(cpu)) {
>              int r;
>              bql_unlock();
> -            r = tcg_cpus_exec(cpu);
> +            r = tcg_cpu_exec(cpu);
>              bql_lock();
>              switch (r) {
>              case EXCP_DEBUG:
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index 0617f66b5b..894e73e52c 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -258,7 +258,7 @@ static void *rr_cpu_thread_fn(void *arg)
>                  if (icount_enabled()) {
>                      icount_prepare_for_run(cpu, cpu_budget);
>                  }
> -                r = tcg_cpus_exec(cpu);
> +                r = tcg_cpu_exec(cpu);
>                  if (icount_enabled()) {
>                      icount_process_data(cpu);
>                  }
> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> index 9b84b84218..9c957f421c 100644
> --- a/accel/tcg/tcg-accel-ops.c
> +++ b/accel/tcg/tcg-accel-ops.c
> @@ -68,7 +68,7 @@ void tcg_cpu_destroy(CPUState *cpu)
>      cpu_thread_signal_destroyed(cpu);
>  }
>  
> -int tcg_cpus_exec(CPUState *cpu)
> +int tcg_cpu_exec(CPUState *cpu)
>  {
>      int ret;
>      assert(tcg_enabled());
> -- 
> 2.41.0
> 
Reviewed-by: Anton Johansson <anjo@rev.ng>

