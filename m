Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDC9D58B07
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 12:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w26ua-0003fY-E1; Mon, 16 Mar 2026 08:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1w26uU-0003aT-J9; Mon, 16 Mar 2026 08:19:04 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1w26uS-0004XM-Kt; Mon, 16 Mar 2026 08:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=1Qyk0o4Z+0GYSxKJVJAQk7A2x9XycTVjuJAQEHYTjN4=; b=KXJd4mhHyvgzpw1
 mzqlN8FeVoJ6ZxJNI3htBrfVjNbPJUMVCtuxwujFESpfwUBwwzcTGG97AfOyYBk/DjrpcLbanYFj/
 1mlBmyPLZwQQU2YsMXqB+BK1oGv8MSe0HtV/ytSFokGChws/g5Ur1gNP84tjzyk2FBZXcWLCe3FOz
 nc=;
Date: Mon, 16 Mar 2026 13:22:47 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/3] target/ppc: Explicitly declare 'cpu_reserve_val2'
 register as 64-bit
Message-ID: <abf1Lh3rFI7kLfDt@hive.localdomain>
References: <20260315170832.40331-1-philmd@linaro.org>
 <20260315170832.40331-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260315170832.40331-3-philmd@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 15/03/26, Philippe Mathieu-Daudé wrote:
> When TARGET_PPC64 is set, the 'target_ulong' type expand to
> the 'uint64_t' one. Use the latter which is more explicity,
> similarly with the TCG and migration APIs. No logical change
> intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/ppc/cpu.h       | 2 +-
>  target/ppc/machine.c   | 2 +-
>  target/ppc/translate.c | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 63c8fa25acc..f4438982928 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1298,7 +1298,7 @@ struct CPUArchState {
>      target_ulong reserve_length; /* Reservation larx op size (bytes) */
>      target_ulong reserve_val;    /* Reservation value */
>  #if defined(TARGET_PPC64)
> -    target_ulong reserve_val2;
> +    uint64_t reserve_val2;
>  #endif
>  
>      /* These are used in supervisor mode only */
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 49cfdc6d674..b44c3ccf0ae 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -682,7 +682,7 @@ static const VMStateDescription vmstate_reservation = {
>          VMSTATE_UINTTL(env.reserve_length, PowerPCCPU),
>          VMSTATE_UINTTL(env.reserve_val, PowerPCCPU),
>  #if defined(TARGET_PPC64)
> -        VMSTATE_UINTTL(env.reserve_val2, PowerPCCPU),
> +        VMSTATE_UINT64(env.reserve_val2, PowerPCCPU),
>  #endif
>          VMSTATE_END_OF_LIST()
>      }
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 0fc81570a8b..ecf75c1376e 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -76,7 +76,7 @@ static TCGv cpu_reserve;
>  static TCGv cpu_reserve_length;
>  static TCGv cpu_reserve_val;
>  #if defined(TARGET_PPC64)
> -static TCGv cpu_reserve_val2;
> +static TCGv_i64 cpu_reserve_val2;
>  #endif
>  static TCGv cpu_fpscr;
>  static TCGv_i32 cpu_access_type;
> @@ -152,7 +152,7 @@ void ppc_translate_init(void)
>                                           offsetof(CPUPPCState, reserve_val),
>                                           "reserve_val");
>  #if defined(TARGET_PPC64)
> -    cpu_reserve_val2 = tcg_global_mem_new(tcg_env,
> +    cpu_reserve_val2 = tcg_global_mem_new_i64(tcg_env,
>                                            offsetof(CPUPPCState, reserve_val2),
>                                            "reserve_val2");
>  #endif
> -- 
> 2.53.0
> 
> 

There's a use left in gen_stqcx_()

    tcg_gen_xor_tl(t1, t1, cpu_reserve_val2);

since the entire function is guarded by TARGET_PPC64 we can just use
tcg_gen_*_i64() throughout?

Otherwise,

Reviewed-by: Anton Johansson <anjo@rev.ng>

