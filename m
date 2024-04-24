Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21869C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 14:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzdtb-00077D-DC; Wed, 24 Apr 2024 10:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rzdtV-00076C-GQ
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 10:46:45 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rzdtS-0005gb-Qv
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 10:46:45 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a55ab922260so477394166b.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 07:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713970001; x=1714574801; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YqZ0BRIapaMHeZ3lavwFhX+MMvltS4Y1Ce+4y0p7Jts=;
 b=FR2PfGcNiSjHZb5XqVyPghY4VGG+YPv7EeIzHMXaHCxXjkgTZU8G4Irx3jwtEbX+wK
 gyS7sBb7g2H6KC0E9VrZKVPzpAs/45XWmXNSJdfV7Wo6fXNeKm1ZWNECmZknLRMdZUUS
 yHkLC1kFOwRS9eFMR6t/2wDJHrMAc2wTee7BrwaYeB4PyYPQ8vz+45qY/e8NfZF6OWNr
 ir8QbaKeTgjFiFWdy0CLfjDQdeWsCX9ekNhMjYHLuXPUSV0LDCEf2PQXcd9a9YhInKpD
 BYJs1a4r4hzFxer7ctuCIB9B6Xo7L1znbWkLzdYR4CxBWWlpUCOr84dwk5CJ88XzGftM
 Fdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713970001; x=1714574801;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YqZ0BRIapaMHeZ3lavwFhX+MMvltS4Y1Ce+4y0p7Jts=;
 b=aKi4l3yH+r7BOXgOcPO2U3koCi1BNT/Smyu7biJR9DcKoOC32tkouzLkDIZjrOUIhf
 ZBTEsPJhXk/fzLmfTv5oRWq55fKmDEAp/KJAXAKOUGwVJnt9hVNjB1T5woA3qMjyJm50
 z2aZM+3cl5WEmINIGjnZnFjvBzi6kSDCn7rFo3J8yfw87bgzpfarbhqFjvgJ0bEUjhi6
 T6ucrmYZGUw1mqnF3Be8uHCuQgloTP9N3eGQHBMJkKMV5FkXHVTllE2UG45AF2ynHJdl
 gh5kj139RJLuqWzmVrJXG0XeSuz221WXf+Fsq+s4HHNbaZgw4dq+AViSAfjVZxbj9wYx
 aUxw==
X-Gm-Message-State: AOJu0YzyMktQCxiR1auGvVH0zMbhbI+LiTRFvyx0Mn9btwXHrlAig2Tc
 MmPEWcV/K+eoQrm4Ah2DSO8ZmsbT/cfhm2bKN7SVWL1DTVybSX12Lp3GNG6X20ZQC7Vs8QI42fO
 a4jY=
X-Google-Smtp-Source: AGHT+IEeU8xcwX/+nJgDZkd944Ela0X3y0YOLO2axABSFVxGvvCvgYzsUFMvfOb+42Tw0AXDbq5z1w==
X-Received: by 2002:a17:906:cb8f:b0:a58:71e7:d1e8 with SMTP id
 mf15-20020a170906cb8f00b00a5871e7d1e8mr1788434ejb.52.1713970000894; 
 Wed, 24 Apr 2024 07:46:40 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 bu6-20020a170906a14600b00a57c75871d8sm2998529ejb.106.2024.04.24.07.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 07:46:40 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:46:39 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: christoph.muellner@vrull.eu, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH v3] target/riscv: Raise exceptions on wrs.nto
Message-ID: <20240424-31025d6338d49bfbda2be736@orel>
References: <20240424142808.62936-2-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424142808.62936-2-ajones@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Apr 24, 2024 at 04:28:09PM +0200, Andrew Jones wrote:
> Implementing wrs.nto to always just return is consistent with the
> specification, as the instruction is permitted to terminate the
> stall for any reason, but it's not useful for virtualization, where
> we'd like the guest to trap to the hypervisor in order to allow
> scheduling of the lock holding VCPU. Change to always immediately
> raise exceptions when the appropriate conditions are present,
> otherwise continue to just return. Note, immediately raising
> exceptions is also consistent with the specification since the
> time limit that should expire prior to the exception is
> implementation-specific.
> 
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Christoph M??llner <christoph.muellner@vrull.eu>
> ---
> v3:
>  - Sending again, hoping the ?? remains in M??llner

This looks like my mail reader (neomutt)'s problem. The patch was correct
(also for v2) and other readers render it correctly. Sorry for the noise.

Thanks,
drew

> v2:
>  - Added #ifndef CONFIG_USER_ONLY around helper call
> 
>  target/riscv/helper.h                       |  1 +
>  target/riscv/insn_trans/trans_rvzawrs.c.inc | 29 ++++++++++++++-------
>  target/riscv/op_helper.c                    | 11 ++++++++
>  3 files changed, 32 insertions(+), 9 deletions(-)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 8a635238514d..451261ce5a4f 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -132,6 +132,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
>  DEF_HELPER_1(sret, tl, env)
>  DEF_HELPER_1(mret, tl, env)
>  DEF_HELPER_1(wfi, void, env)
> +DEF_HELPER_1(wrs_nto, void, env)
>  DEF_HELPER_1(tlb_flush, void, env)
>  DEF_HELPER_1(tlb_flush_all, void, env)
>  /* Native Debug */
> diff --git a/target/riscv/insn_trans/trans_rvzawrs.c.inc b/target/riscv/insn_trans/trans_rvzawrs.c.inc
> index 32efbff4d5a5..0eef03383889 100644
> --- a/target/riscv/insn_trans/trans_rvzawrs.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzawrs.c.inc
> @@ -16,7 +16,7 @@
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> -static bool trans_wrs(DisasContext *ctx)
> +static bool trans_wrs_sto(DisasContext *ctx, arg_wrs_sto *a)
>  {
>      if (!ctx->cfg_ptr->ext_zawrs) {
>          return false;
> @@ -40,12 +40,23 @@ static bool trans_wrs(DisasContext *ctx)
>      return true;
>  }
>  
> -#define GEN_TRANS_WRS(insn)                                     \
> -static bool trans_ ## insn(DisasContext *ctx, arg_ ## insn *a)  \
> -{                                                               \
> -    (void)a;                                                    \
> -    return trans_wrs(ctx);                                      \
> -}
> +static bool trans_wrs_nto(DisasContext *ctx, arg_wrs_nto *a)
> +{
> +    if (!ctx->cfg_ptr->ext_zawrs) {
> +        return false;
> +    }
>  
> -GEN_TRANS_WRS(wrs_nto)
> -GEN_TRANS_WRS(wrs_sto)
> +    /*
> +     * Depending on the mode of execution, mstatus.TW and hstatus.VTW, wrs.nto
> +     * should raise an exception when the implementation-specific bounded time
> +     * limit has expired. Our time limit is zero, so we either return
> +     * immediately, as does our implementation of wrs.sto, or raise an
> +     * exception, as handled by the wrs.nto helper.
> +     */
> +#ifndef CONFIG_USER_ONLY
> +    gen_helper_wrs_nto(tcg_env);
> +#endif
> +
> +    /* We only get here when helper_wrs_nto() doesn't raise an exception. */
> +    return trans_wrs_sto(ctx, NULL);
> +}
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index f414aaebdbab..2baf5bc3ca19 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -380,6 +380,17 @@ void helper_wfi(CPURISCVState *env)
>      }
>  }
>  
> +void helper_wrs_nto(CPURISCVState *env)
> +{
> +    if (env->virt_enabled && (env->priv == PRV_S || env->priv == PRV_U) &&
> +        get_field(env->hstatus, HSTATUS_VTW) &&
> +        !get_field(env->mstatus, MSTATUS_TW)) {
> +        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
> +    } else if (env->priv != PRV_M && get_field(env->mstatus, MSTATUS_TW)) {
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +    }
> +}
> +
>  void helper_tlb_flush(CPURISCVState *env)
>  {
>      CPUState *cs = env_cpu(env);
> -- 
> 2.44.0
> 

