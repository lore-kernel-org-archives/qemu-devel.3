Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5418C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 17:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxVxu-0007EC-1d; Thu, 18 Apr 2024 13:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rxVxs-0006zt-Dr
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 13:54:28 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rxVxq-00082Y-Cd
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 13:54:28 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1e3f17c6491so10285835ad.2
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 10:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713462865; x=1714067665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=whIoKvXWb73c4A504Etb/2Ah58TpZ/Pv17mUzNCfrIU=;
 b=cGKFifpRm6FAkrJWfp/FA2CytZO2hGgYAiwuRZ2BeoSGAVoLg3JYMinOyc4ocap8IA
 gh1JbHWqywXCoQfPqWObE/nU15kPVDfeUevKpKd2CjOJPpFpbJ+2eZbt5p39g9ChAQDW
 auDUUU031K4PRSoP9PFUbUr1E6JYfajZJuozZzw6q0xQ4byO+M3s1YtOPid9JZKMgeyV
 Mf0DIO43pbBgFe55miEe1ixinCF4fQj1sXi9ZU+Y2saONLgqmEXVeM06TXxeuAUyk7e9
 BUYV4HwpQzDMn9J5pagCZK4fAUOITwLXDPW0h8qt4agfuFPSN1wPRShVcZkTWX8qMaEN
 hhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713462865; x=1714067665;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=whIoKvXWb73c4A504Etb/2Ah58TpZ/Pv17mUzNCfrIU=;
 b=rSN0p+7k7xsJ51+rl05oS0NgUR9TiZXBInaqO8E2v6M4F7QX9LPwWchPJX2qmTFbLn
 AwGBhi8HxJy9qzmTvJOfDsAUoWRGleehf4d5yvIc5omO2tmOy1et62Irxi5A2cyoC+GH
 v7Y+DDTQX3GQIvNV/Pdp5Gj6FEHWKF3mrIoH9S5Q2WuIKZHblFG9c7bptznBxAO98Tz3
 aaq4kCZHM7biPCm7WSnagYl1VfNnZaKwc77kGWNCs+zsra6/evnV5cbTHKtWzx48LxyE
 Nws3laJR4dSuwl2P5Lh4aNk+HGGKLmm4jbA0JUVQ8c0EacV+SfsgE+IdZiPA6nGl7U5B
 ewrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs/8cziD3rAKfJk5ZKK3QuxCNHilsIYGQlcA3otuyWoM9NEqc9JFRtw8AfVSGQWXER5Sb8v4yH1wVET1meVeS0VJB29Js=
X-Gm-Message-State: AOJu0YyyxQoZZujka27A+GhbRHJwl8hvmWw1q45mNeiMmTNCj15/2x4c
 dkoF+Hwc2JWKWsCKpU8TBnB9dTOqGFegv62upP15505r+EWEOOyoaBWuq9ZK/b8=
X-Google-Smtp-Source: AGHT+IFNAJx6HebBGb1gcEPzT143E/UIvrh+n6B7I06Ip2N+9havl4TjQu8uy8yIM0rV91wdZQqclg==
X-Received: by 2002:a17:902:7c88:b0:1e4:4045:481b with SMTP id
 y8-20020a1709027c8800b001e44045481bmr3828983pll.29.1713462864702; 
 Thu, 18 Apr 2024 10:54:24 -0700 (PDT)
Received: from ?IPV6:2604:3d08:937d:c610::fc11? ([2604:3d08:937d:c610::fc11])
 by smtp.gmail.com with ESMTPSA id
 y15-20020a170902d64f00b001e510b3e807sm1795949plh.263.2024.04.18.10.54.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 10:54:24 -0700 (PDT)
Message-ID: <183c28e1-c0d8-48ab-99f1-dd9dcdf3c851@linaro.org>
Date: Thu, 18 Apr 2024 10:54:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] accel/tcg: Set CPUState.plugin_ra before all plugin
 callbacks
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240416040609.1313605-1-richard.henderson@linaro.org>
 <20240416040609.1313605-3-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240416040609.1313605-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 4/15/24 21:06, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h  |  1 +
>   accel/tcg/plugin-gen.c | 50 +++++++++++++++++++++++++++++++++++++-----
>   2 files changed, 46 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 10cd492aff..f4af37c13d 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -350,6 +350,7 @@ typedef union IcountDecr {
>   typedef struct CPUNegativeOffsetState {
>       CPUTLB tlb;
>   #ifdef CONFIG_PLUGIN
> +    uintptr_t plugin_ra;
>       GArray *plugin_mem_cbs;
>   #endif
>       IcountDecr icount_decr;
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index 36e9134a5d..f96b49cce6 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -37,6 +37,12 @@ enum plugin_gen_from {
>       PLUGIN_GEN_AFTER_TB,
>   };
>   
> +enum plugin_gen_ra {
> +    GEN_RA_DONE,
> +    GEN_RA_FROM_TB,
> +    GEN_RA_FROM_INSN,
> +};
> +
>   /* called before finishing a TB with exit_tb, goto_tb or goto_ptr */
>   void plugin_gen_disable_mem_helpers(void)
>   {
> @@ -151,11 +157,38 @@ static void gen_mem_cb(struct qemu_plugin_dyn_cb *cb,
>       tcg_temp_free_i32(cpu_index);
>   }
>   
> -static void inject_cb(struct qemu_plugin_dyn_cb *cb)
> +static void inject_ra(enum plugin_gen_ra *gen_ra)
> +{
> +    TCGv_ptr ra;
> +
> +    switch (*gen_ra) {
> +    case GEN_RA_DONE:
> +        return;
> +    case GEN_RA_FROM_TB:
> +        ra = tcg_constant_ptr(NULL);
> +        break;
> +    case GEN_RA_FROM_INSN:
> +        ra = tcg_temp_ebb_new_ptr();
> +        tcg_gen_plugin_pc(ra);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    tcg_gen_st_ptr(ra, tcg_env,
> +                   offsetof(CPUState, neg.plugin_ra) -
> +                   offsetof(ArchCPU, env));
> +    tcg_temp_free_ptr(ra);
> +    *gen_ra = GEN_RA_DONE;
> +}
> +
> +static void inject_cb(struct qemu_plugin_dyn_cb *cb,
> +                      enum plugin_gen_ra *gen_ra)
>   
>   {
>       switch (cb->type) {
>       case PLUGIN_CB_REGULAR:
> +        inject_ra(gen_ra);
>           gen_udata_cb(cb);
>           break;
>       case PLUGIN_CB_INLINE:
> @@ -167,16 +200,18 @@ static void inject_cb(struct qemu_plugin_dyn_cb *cb)
>   }
>   
>   static void inject_mem_cb(struct qemu_plugin_dyn_cb *cb,
> +                          enum plugin_gen_ra *gen_ra,
>                             enum qemu_plugin_mem_rw rw,
>                             qemu_plugin_meminfo_t meminfo, TCGv_i64 addr)
>   {
>       if (cb->rw & rw) {
>           switch (cb->type) {
>           case PLUGIN_CB_MEM_REGULAR:
> +            inject_ra(gen_ra);
>               gen_mem_cb(cb, meminfo, addr);
>               break;
>           default:
> -            inject_cb(cb);
> +            inject_cb(cb, gen_ra);
>               break;
>           }
>       }
> @@ -186,6 +221,7 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
>   {
>       TCGOp *op, *next;
>       int insn_idx = -1;
> +    enum plugin_gen_ra gen_ra;
>   
>       if (unlikely(qemu_loglevel_mask(LOG_TB_OP_PLUGIN)
>                    && qemu_log_in_addr_range(plugin_tb->vaddr))) {
> @@ -205,10 +241,12 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
>        */
>       memset(tcg_ctx->free_temps, 0, sizeof(tcg_ctx->free_temps));
>   
> +    gen_ra = GEN_RA_FROM_TB;
>       QTAILQ_FOREACH_SAFE(op, &tcg_ctx->ops, link, next) {
>           switch (op->opc) {
>           case INDEX_op_insn_start:
>               insn_idx++;
> +            gen_ra = GEN_RA_FROM_INSN;
>               break;
>   
>           case INDEX_op_plugin_cb:
> @@ -244,7 +282,8 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
>                   cbs = plugin_tb->cbs;
>                   for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
>                       inject_cb(
> -                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i));
> +                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i),
> +                        &gen_ra);
>                   }
>                   break;
>   
> @@ -256,7 +295,8 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
>                   cbs = insn->insn_cbs;
>                   for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
>                       inject_cb(
> -                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i));
> +                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i),
> +                        &gen_ra);
>                   }
>                   break;
>   
> @@ -288,7 +328,7 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
>               cbs = insn->mem_cbs;
>               for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
>                   inject_mem_cb(&g_array_index(cbs, struct qemu_plugin_dyn_cb, i),
> -                              rw, meminfo, addr);
> +                              &gen_ra, rw, meminfo, addr);
>               }
>   
>               tcg_ctx->emit_before_op = NULL;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

