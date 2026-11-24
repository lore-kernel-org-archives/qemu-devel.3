Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B691F606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=T27dIYIq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVkeT-0005r2-Ua; Tue, 24 Nov 2026 02:09:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xVkeP-0005qh-UG; Tue, 24 Nov 2026 02:09:13 -0500
Received: from [115.124.30.132] (helo=out30-132.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xVkeL-0000bg-R4; Tue, 24 Nov 2026 02:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1795504123; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=BcIxW31gf5DIgRJMQI6FaWxjVh34h+AQV8ZQtE/5clQ=;
 b=T27dIYIqYZm0JFn85Dco0bmbP6e+aBCSGPCgjFcggAMhar3h/G/i0hipjkqRtDBElhgIN8J14H7XopScD0xBwT94Yn0UgTEkqHNq08hZbRH6+iPn52AgUfOtFlef+ckAjgALD9tx0Onl0O8eNBRy8MbpvFliLqZV9rSv7oEeLRY=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0XFNkkNS_1795504121; 
Received: from 30.166.65.115(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XFNkkNS_1795504121 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 24 Nov 2026 15:08:42 +0800
Message-ID: <77c100f8-6852-4a7d-9bb6-f67fab049c08@linux.alibaba.com>
Date: Tue, 24 Nov 2026 15:08:41 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Keep cycle overflow deadlines in virtual
 nanoseconds
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20261119222036.71913-1-philmd@oss.qualcomm.com>
From: TianCheng TANG <lyndra@linux.alibaba.com>
In-Reply-To: <20261119222036.71913-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.132 (deferred)
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-24.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Philippe,

在 2026/11/20 06:20, Philippe Mathieu-Daudé 写道:

> The cycle counter uses icount_get(), which already returns virtual
> time in nanoseconds. The PMU overflow helper applies icount_to_ns()
> to both cycle and instruction counters, so cycle overflow timers
> are delayed by the icount shift.
>
> Pass the counter context to the helper and scale only instruction
> counts.
>
> Fixes: b2d7a7c7e4e30 ("target/riscv: Implement privilege mode filtering for cycle/instret")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Reviewed-by: TANG Tiancheng <lyndra@linux.alibaba.com>

> ---
>   target/riscv/tcg/pmu.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
> index 0165faf06b86..cd4de9cde0ab 100644
> --- a/target/riscv/tcg/pmu.c
> +++ b/target/riscv/tcg/pmu.c
> @@ -281,12 +281,15 @@ static gboolean pmu_remove_event_map(gpointer key, gpointer value,
>       return (GPOINTER_TO_UINT(value) == GPOINTER_TO_UINT(udata)) ? true : false;
>   }
>   
> -static int64_t pmu_icount_ticks_to_ns(int64_t value)
> +static int64_t pmu_icount_ticks_to_ns(CPURISCVState *env, uint32_t ctr_idx,
> +                                      int64_t value)
>   {
>       int64_t ret = 0;
>   
>       if (icount_enabled()) {
> -        ret = icount_to_ns(value);
> +        /* The cycle counter counts ns of virtual time, see icount_get() */
> +        ret = riscv_pmu_ctr_monitor_instructions(env, ctr_idx) ?
> +              icount_to_ns(value) : value;

As an optional cleanup, could we call riscv_pmu_ctr_monitor_instructions()
once in riscv_pmu_setup_timer() and reuse the result for the fixed-event
check and both conversions?

Thanks,
Tiancheng

>       } else {
>           ret = (NANOSECONDS_PER_SECOND / RISCV_TIMEBASE_FREQ) * value;
>       }
> @@ -456,8 +459,9 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
>   
>       if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>           riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> -        overflow_ns = pmu_icount_ticks_to_ns((int64_t)overflow_delta);
> -        overflow_left = pmu_icount_ticks_to_ns(overflow_left) ;
> +        overflow_ns = pmu_icount_ticks_to_ns(env, ctr_idx,
> +                                             (int64_t)overflow_delta);
> +        overflow_left = pmu_icount_ticks_to_ns(env, ctr_idx, overflow_left);
>       } else {
>           return -1;
>       }

