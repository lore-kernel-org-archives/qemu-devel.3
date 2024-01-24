Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A905FC48260
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 16:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSgPD-0004aB-7j; Wed, 24 Jan 2024 11:47:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rSgOy-0004Wy-Jf
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 11:47:02 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rSgOx-0005UL-5w
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 11:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=05Op+hCi7NgxDbyXwiP63Ul26v6mFSq0qSoGouuMJMs=; b=UNi1ZocjfQhHB4WWk9S+NzdAzS
 bzz9tsTFMVCLwnCIUJB7X5acpQEjjeTGXj63GXHcaMce765jEZLfwX0IlnWVqZwn5lsOzC88baXZR
 yajuo6v0jclaS1RgfV4Ac7zix6WpBoHrl89qPTgb3DEw//36DrZeCAO0mI8/KcYMTkbQ=;
Date: Wed, 24 Jan 2024 17:47:04 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>, 
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH 2/9] accel/tcg: Rename tcg_cpus_destroy() ->
 tcg_cpu_destroy()
Message-ID: <u4lkgkrini7eik7crwc43wlteizpzxvmmzdoqfxit2kkxua672@uva7byifji37>
References: <20240124101639.30056-1-philmd@linaro.org>
 <20240124101639.30056-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240124101639.30056-3-philmd@linaro.org>
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
> tcg_cpus_destroy() operates on a single vCPU, rename it
> as 'tcg_cpu_destroy'.
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
> index f9bc6330e2..17c7ed00eb 100644
> --- a/accel/tcg/tcg-accel-ops.h
> +++ b/accel/tcg/tcg-accel-ops.h
> @@ -14,7 +14,7 @@
>  
>  #include "sysemu/cpus.h"
>  
> -void tcg_cpus_destroy(CPUState *cpu);
> +void tcg_cpu_destroy(CPUState *cpu);
>  int tcg_cpus_exec(CPUState *cpu);
>  void tcg_handle_interrupt(CPUState *cpu, int mask);
>  void tcg_cpu_init_cflags(CPUState *cpu, bool parallel);
> diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
> index af7307013a..bcba314a65 100644
> --- a/accel/tcg/tcg-accel-ops-mttcg.c
> +++ b/accel/tcg/tcg-accel-ops-mttcg.c
> @@ -118,7 +118,7 @@ static void *mttcg_cpu_thread_fn(void *arg)
>          qemu_wait_io_event(cpu);
>      } while (!cpu->unplug || cpu_can_run(cpu));
>  
> -    tcg_cpus_destroy(cpu);
> +    tcg_cpu_destroy(cpu);
>      bql_unlock();
>      rcu_remove_force_rcu_notifier(&force_rcu.notifier);
>      rcu_unregister_thread();
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index 3208035d85..0617f66b5b 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -131,7 +131,7 @@ static void rr_deal_with_unplugged_cpus(void)
>  
>      CPU_FOREACH(cpu) {
>          if (cpu->unplug && !cpu_can_run(cpu)) {
> -            tcg_cpus_destroy(cpu);
> +            tcg_cpu_destroy(cpu);
>              break;
>          }
>      }
> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> index 813065c0ec..9b84b84218 100644
> --- a/accel/tcg/tcg-accel-ops.c
> +++ b/accel/tcg/tcg-accel-ops.c
> @@ -63,7 +63,7 @@ void tcg_cpu_init_cflags(CPUState *cpu, bool parallel)
>      cpu->tcg_cflags |= cflags;
>  }
>  
> -void tcg_cpus_destroy(CPUState *cpu)
> +void tcg_cpu_destroy(CPUState *cpu)
>  {
>      cpu_thread_signal_destroyed(cpu);
>  }
> -- 
> 2.41.0
> 
Reviewed-by: Anton Johansson <anjo@rev.ng>

