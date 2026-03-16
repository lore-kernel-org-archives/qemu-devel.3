Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AAAF4645B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 12:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w26m1-0000eM-LP; Mon, 16 Mar 2026 08:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1w26lt-0000dZ-C1; Mon, 16 Mar 2026 08:10:13 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1w26lr-0002Lw-FO; Mon, 16 Mar 2026 08:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=rI2uUmihn7ZE4MWFbgjlsv4HIfNn8wbsw19hwO0Y1NE=; b=bX3MYyEtrMPF93u
 jUAWWuIN6SEx1CC/dS0Rh+570WqgcoiN/KYARh0n+45X5wlgjDGb3zYPfztf0RZWpddrfGkdRXo+S
 BbtR7lGqfFbYO/Dmv9YAt2OtRAI/zlMmE1M7mK+9xq34mvJihfqALCEa0a2+ysMyD8ARUvFI+BTEk
 5I=;
Date: Mon, 16 Mar 2026 13:13:53 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/3] target/ppc: Explicitly declare CFAR register as 64-bit
Message-ID: <abfzbfghwmumGsvN@hive.localdomain>
References: <20260315170832.40331-1-philmd@linaro.org>
 <20260315170832.40331-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260315170832.40331-2-philmd@linaro.org>
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
> The Come-From Address Register (CFAR) register is only available
> on 64-bit CPUs, and is 64-bit wide. Prefer the 64-bit APIs over
> the 'target-long' one. No logical change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/ppc/cpu.h       |  2 +-
>  target/ppc/translate.c | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index aba8109bbba..63c8fa25acc 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1285,7 +1285,7 @@ struct CPUArchState {
>      target_ulong ctr;
>      uint32_t crf[8];       /* condition register */
>  #if defined(TARGET_PPC64)
> -    target_ulong cfar;
> +    uint64_t cfar;
>  #endif
>      target_ulong xer;      /* XER (with SO, OV, CA split out) */
>      target_ulong so;
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index f26b0281737..0fc81570a8b 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -69,7 +69,7 @@ static TCGv cpu_msr;
>  static TCGv cpu_ctr;
>  static TCGv cpu_lr;
>  #if defined(TARGET_PPC64)
> -static TCGv cpu_cfar;
> +static TCGv_i64 cpu_cfar;
>  #endif
>  static TCGv cpu_xer, cpu_so, cpu_ov, cpu_ca, cpu_ov32, cpu_ca32;
>  static TCGv cpu_reserve;
> @@ -124,8 +124,8 @@ void ppc_translate_init(void)
>                                  offsetof(CPUPPCState, lr), "lr");
>  
>  #if defined(TARGET_PPC64)
> -    cpu_cfar = tcg_global_mem_new(tcg_env,
> -                                  offsetof(CPUPPCState, cfar), "cfar");
> +    cpu_cfar = tcg_global_mem_new_i64(tcg_env,
> +                                    offsetof(CPUPPCState, cfar), "cfar");
>  #endif
>  
>      cpu_xer = tcg_global_mem_new(tcg_env,
> @@ -626,12 +626,12 @@ void spr_write_lr(DisasContext *ctx, int sprn, int gprn)
>  /* CFAR */
>  void spr_read_cfar(DisasContext *ctx, int gprn, int sprn)
>  {
> -    tcg_gen_mov_tl(cpu_gpr[gprn], cpu_cfar);
> +    tcg_gen_mov_i64(cpu_gpr[gprn], cpu_cfar);
>  }
>  
>  void spr_write_cfar(DisasContext *ctx, int sprn, int gprn)
>  {
> -    tcg_gen_mov_tl(cpu_cfar, cpu_gpr[gprn]);
> +    tcg_gen_mov_i64(cpu_cfar, cpu_gpr[gprn]);
>  }
>  
>  /* Breakpoint */
> -- 
> 2.53.0
> 
> 

Change of 

  - tcg_gen_movi_tl(cpu_cfar, nip);
  + tcg_gen_movi_i64(cpu_cfar, nip);

in gen_update_branch_history() should be in this patch and not the last
one, I'm guessing you just missed it when splitting.

Other than that

Reviewed-by: Anton Johansson <anjo@rev.ng>

