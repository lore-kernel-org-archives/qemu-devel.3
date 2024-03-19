Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87B4C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 13:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmZcD-0005AZ-Ib; Tue, 19 Mar 2024 09:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZcB-000586-Sg
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:34:51 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZc9-0001p7-HX
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:34:51 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-513dc9d6938so4804077e87.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 06:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710855287; x=1711460087; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NeKU3Djrp5NYt0r/bciwFci0Vg3B/aPtdFjxOJ+MXUw=;
 b=iqWkacRYNyzpWJyS7tptoOZJc68N++NFj+e89QNGgOEzQHqHGLSbn1qy6vI2V0kar2
 CL6MYJEoTZTChPRw/auPc1FwFFsVTv9HeEBd1VpzWINJQi3/X2w0MszDkQCI77dGErk9
 +IqFbc3/TCosJe1NJoKRKGOlXaKzauARcQAhHX168/gHLvUoegohF7KPlZO/obXdjSVI
 xSjKwgRXrZyXxz1dBlERRhFTgmq/0/+DxRVNUlOt2iBli0l8nfuuf0W2R2OlR/0abeNg
 tNvUkilnMF9VFdpEzvyLIv856AjKrW5T+bobHYYzVBOh2NZMS6QXorOH0hLAwbY+4dWi
 oVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710855287; x=1711460087;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NeKU3Djrp5NYt0r/bciwFci0Vg3B/aPtdFjxOJ+MXUw=;
 b=Rwg258dLHSesijuThmvU05YEbxmElhWw+09l2/hEidZqkAGlLrUhsoe7jHwjokR863
 5tpX8BglN7mBpfQbn5Kj1OkfajerzXhvyqg4WxL/kZkA3gZMAEK/7rm3K3/KN1O/3FP+
 WA+fJmlSNUouhyUeERmCPN7+ONWf5r9iNkkq/h7vGGyvvbefCR1rM1F77RKrQ1Y4cfM5
 VwCUsgwoZwXoC8+fXgZNzgAkc0kt4OdWbdS5dTwKAq01Ij6ZJWrVV72uZskGA71K/9wM
 qCsnrCKJR2iH17v+H8DNoHRvuTjQBp+M67piwwZFa2W6LYqDac68Rfeua0eiOJN7UrO8
 1N2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuYeWud2vtdKNK8L088mbPT11E0QR0CCiyOU1NQ0t6QieWhUG7vTRi+717ANeHK25kjQ/bdJMFe9FAd2gFBgXZV3ag910=
X-Gm-Message-State: AOJu0YyWl7bo3GJ2kFUDCTJOs2ktHNGo0zoiY8S9e93lQyfdmEQ+RJZm
 mus1tM2tOrDEZ2pIbbY2sCr8nAoMAZM+nGvSs8BnkpSUDvGN9u3Dp/6JR3aysErjyH7iVueYh9A
 h3u4=
X-Google-Smtp-Source: AGHT+IGWWPIDnr1XsNg7GeolCbpBbXvfmWA8QXzyowO/HzlpacM3qemVnh++CGrsgajJ9xZXxPEZdA==
X-Received: by 2002:ac2:598c:0:b0:513:a732:4878 with SMTP id
 w12-20020ac2598c000000b00513a7324878mr9952533lfn.41.1710855287028; 
 Tue, 19 Mar 2024 06:34:47 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a05600c4fd200b004140bece5d1sm8844879wmq.8.2024.03.19.06.34.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 06:34:46 -0700 (PDT)
Message-ID: <983c9134-fa97-46b7-a502-59cb30498b2f@linaro.org>
Date: Tue, 19 Mar 2024 17:34:45 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/22] plugins: Use emit_before_op for PLUGIN_GEN_FROM_INSN
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-11-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240316015720.3661236-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 3/16/24 05:57, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/plugin.h  |   1 -
>   accel/tcg/plugin-gen.c | 286 ++++++++++-------------------------------
>   plugins/api.c          |   8 +-
>   3 files changed, 67 insertions(+), 228 deletions(-)
> 
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index 793c44f1f2..ee1c1b174a 100644
> --- a/include/qemu/plugin.h
> +++ b/include/qemu/plugin.h
> @@ -73,7 +73,6 @@ enum plugin_dyn_cb_type {
>   
>   enum plugin_dyn_cb_subtype {
>       PLUGIN_CB_REGULAR,
> -    PLUGIN_CB_REGULAR_R,
>       PLUGIN_CB_INLINE,
>       PLUGIN_N_CB_SUBTYPES,
>   };
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index aa74e580bd..4785838eca 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -104,30 +104,6 @@ void HELPER(plugin_vcpu_mem_cb)(unsigned int vcpu_index,
>                                   void *userdata)
>   { }
>   
> -static void gen_empty_udata_cb(void (*gen_helper)(TCGv_i32, TCGv_ptr))
> -{
> -    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
> -    TCGv_ptr udata = tcg_temp_ebb_new_ptr();
> -
> -    tcg_gen_movi_ptr(udata, 0);
> -    tcg_gen_ld_i32(cpu_index, tcg_env,
> -                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
> -    gen_helper(cpu_index, udata);
> -
> -    tcg_temp_free_ptr(udata);
> -    tcg_temp_free_i32(cpu_index);
> -}
> -
> -static void gen_empty_udata_cb_no_wg(void)
> -{
> -    gen_empty_udata_cb(gen_helper_plugin_vcpu_udata_cb_no_wg);
> -}
> -
> -static void gen_empty_udata_cb_no_rwg(void)
> -{
> -    gen_empty_udata_cb(gen_helper_plugin_vcpu_udata_cb_no_rwg);
> -}
> -
>   /*
>    * For now we only support addi_i64.
>    * When we support more ops, we can generate one empty inline cb for each.
> @@ -176,51 +152,19 @@ static void gen_empty_mem_cb(TCGv_i64 addr, uint32_t info)
>       tcg_temp_free_i32(cpu_index);
>   }
>   
> -/*
> - * Share the same function for enable/disable. When enabling, the NULL
> - * pointer will be overwritten later.
> - */
> -static void gen_empty_mem_helper(void)
> -{
> -    TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
> -
> -    tcg_gen_movi_ptr(ptr, 0);
> -    tcg_gen_st_ptr(ptr, tcg_env, offsetof(CPUState, plugin_mem_cbs) -
> -                                 offsetof(ArchCPU, env));
> -    tcg_temp_free_ptr(ptr);
> -}
> -
>   static void gen_plugin_cb_start(enum plugin_gen_from from,
>                                   enum plugin_gen_cb type, unsigned wr)
>   {
>       tcg_gen_plugin_cb_start(from, type, wr);
>   }
>   
> -static void gen_wrapped(enum plugin_gen_from from,
> -                        enum plugin_gen_cb type, void (*func)(void))
> -{
> -    gen_plugin_cb_start(from, type, 0);
> -    func();
> -    tcg_gen_plugin_cb_end();
> -}
> -
>   static void plugin_gen_empty_callback(enum plugin_gen_from from)
>   {
>       switch (from) {
>       case PLUGIN_GEN_AFTER_INSN:
>       case PLUGIN_GEN_FROM_TB:
> -        tcg_gen_plugin_cb(from);
> -        break;
>       case PLUGIN_GEN_FROM_INSN:
> -        /*
> -         * Note: plugin_gen_inject() relies on ENABLE_MEM_HELPER being
> -         * the first callback of an instruction
> -         */
> -        gen_wrapped(from, PLUGIN_GEN_ENABLE_MEM_HELPER,
> -                    gen_empty_mem_helper);
> -        gen_wrapped(from, PLUGIN_GEN_CB_UDATA, gen_empty_udata_cb_no_rwg);
> -        gen_wrapped(from, PLUGIN_GEN_CB_UDATA_R, gen_empty_udata_cb_no_wg);
> -        gen_wrapped(from, PLUGIN_GEN_CB_INLINE, gen_empty_inline_cb);
> +        tcg_gen_plugin_cb(from);
>           break;
>       default:
>           g_assert_not_reached();
> @@ -374,18 +318,6 @@ static TCGOp *copy_mul_i32(TCGOp **begin_op, TCGOp *op, uint32_t v)
>       return op;
>   }
>   
> -static TCGOp *copy_st_ptr(TCGOp **begin_op, TCGOp *op)
> -{
> -    if (UINTPTR_MAX == UINT32_MAX) {
> -        /* st_i32 */
> -        op = copy_op(begin_op, op, INDEX_op_st_i32);
> -    } else {
> -        /* st_i64 */
> -        op = copy_st_i64(begin_op, op);
> -    }
> -    return op;
> -}
> -
>   static TCGOp *copy_call(TCGOp **begin_op, TCGOp *op, void *func, int *cb_idx)
>   {
>       TCGOp *old_op;
> @@ -409,32 +341,6 @@ static TCGOp *copy_call(TCGOp **begin_op, TCGOp *op, void *func, int *cb_idx)
>       return op;
>   }
>   
> -/*
> - * When we append/replace ops here we are sensitive to changing patterns of
> - * TCGOps generated by the tcg_gen_FOO calls when we generated the
> - * empty callbacks. This will assert very quickly in a debug build as
> - * we assert the ops we are replacing are the correct ones.
> - */
> -static TCGOp *append_udata_cb(const struct qemu_plugin_dyn_cb *cb,
> -                              TCGOp *begin_op, TCGOp *op, int *cb_idx)
> -{
> -    /* const_ptr */
> -    op = copy_const_ptr(&begin_op, op, cb->userp);
> -
> -    /* copy the ld_i32, but note that we only have to copy it once */
> -    if (*cb_idx == -1) {
> -        op = copy_op(&begin_op, op, INDEX_op_ld_i32);
> -    } else {
> -        begin_op = QTAILQ_NEXT(begin_op, link);
> -        tcg_debug_assert(begin_op && begin_op->opc == INDEX_op_ld_i32);
> -    }
> -
> -    /* call */
> -    op = copy_call(&begin_op, op, cb->regular.f.vcpu_udata, cb_idx);
> -
> -    return op;
> -}
> -
>   static TCGOp *append_inline_cb(const struct qemu_plugin_dyn_cb *cb,
>                                  TCGOp *begin_op, TCGOp *op,
>                                  int *unused)
> @@ -488,11 +394,6 @@ typedef TCGOp *(*inject_fn)(const struct qemu_plugin_dyn_cb *cb,
>                               TCGOp *begin_op, TCGOp *op, int *intp);
>   typedef bool (*op_ok_fn)(const TCGOp *op, const struct qemu_plugin_dyn_cb *cb);
>   
> -static bool op_ok(const TCGOp *op, const struct qemu_plugin_dyn_cb *cb)
> -{
> -    return true;
> -}
> -
>   static bool op_rw(const TCGOp *op, const struct qemu_plugin_dyn_cb *cb)
>   {
>       int w;
> @@ -530,12 +431,6 @@ static void inject_cb_type(const GArray *cbs, TCGOp *begin_op,
>       rm_ops_range(begin_op, end_op);
>   }
>   
> -static void
> -inject_udata_cb(const GArray *cbs, TCGOp *begin_op)
> -{
> -    inject_cb_type(cbs, begin_op, append_udata_cb, op_ok);
> -}
> -
>   static void
>   inject_inline_cb(const GArray *cbs, TCGOp *begin_op, op_ok_fn ok)
>   {
> @@ -548,71 +443,6 @@ inject_mem_cb(const GArray *cbs, TCGOp *begin_op)
>       inject_cb_type(cbs, begin_op, append_mem_cb, op_rw);
>   }
>   
> -/* we could change the ops in place, but we can reuse more code by copying */
> -static void inject_mem_helper(TCGOp *begin_op, GArray *arr)
> -{
> -    TCGOp *orig_op = begin_op;
> -    TCGOp *end_op;
> -    TCGOp *op;
> -
> -    end_op = find_op(begin_op, INDEX_op_plugin_cb_end);
> -    tcg_debug_assert(end_op);
> -
> -    /* const ptr */
> -    op = copy_const_ptr(&begin_op, end_op, arr);
> -
> -    /* st_ptr */
> -    op = copy_st_ptr(&begin_op, op);
> -
> -    rm_ops_range(orig_op, end_op);
> -}
> -
> -/*
> - * Tracking memory accesses performed from helpers requires extra work.
> - * If an instruction is emulated with helpers, we do two things:
> - * (1) copy the CB descriptors, and keep track of it so that they can be
> - * freed later on, and (2) point CPUState.plugin_mem_cbs to the descriptors, so
> - * that we can read them at run-time (i.e. when the helper executes).
> - * This run-time access is performed from qemu_plugin_vcpu_mem_cb.
> - *
> - * Note that plugin_gen_disable_mem_helpers undoes (2). Since it
> - * is possible that the code we generate after the instruction is
> - * dead, we also add checks before generating tb_exit etc.
> - */
> -static void inject_mem_enable_helper(struct qemu_plugin_tb *ptb,
> -                                     struct qemu_plugin_insn *plugin_insn,
> -                                     TCGOp *begin_op)
> -{
> -    GArray *cbs[2];
> -    GArray *arr;
> -    size_t n_cbs, i;
> -
> -    cbs[0] = plugin_insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR];
> -    cbs[1] = plugin_insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE];
> -
> -    n_cbs = 0;
> -    for (i = 0; i < ARRAY_SIZE(cbs); i++) {
> -        n_cbs += cbs[i]->len;
> -    }
> -
> -    plugin_insn->mem_helper = plugin_insn->calls_helpers && n_cbs;
> -    if (likely(!plugin_insn->mem_helper)) {
> -        rm_ops(begin_op);
> -        return;
> -    }
> -    ptb->mem_helper = true;
> -
> -    arr = g_array_sized_new(false, false,
> -                            sizeof(struct qemu_plugin_dyn_cb), n_cbs);
> -
> -    for (i = 0; i < ARRAY_SIZE(cbs); i++) {
> -        g_array_append_vals(arr, cbs[i]->data, cbs[i]->len);
> -    }
> -
> -    qemu_plugin_add_dyn_cb_arr(arr);
> -    inject_mem_helper(begin_op, arr);
> -}
> -
>   /* called before finishing a TB with exit_tb, goto_tb or goto_ptr */
>   void plugin_gen_disable_mem_helpers(void)
>   {
> @@ -621,30 +451,6 @@ void plugin_gen_disable_mem_helpers(void)
>       }
>   }
>   
> -static void plugin_gen_insn_udata(const struct qemu_plugin_tb *ptb,
> -                                  TCGOp *begin_op, int insn_idx)
> -{
> -    struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
> -
> -    inject_udata_cb(insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR], begin_op);
> -}
> -
> -static void plugin_gen_insn_udata_r(const struct qemu_plugin_tb *ptb,
> -                                    TCGOp *begin_op, int insn_idx)
> -{
> -    struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
> -
> -    inject_udata_cb(insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR_R], begin_op);
> -}
> -
> -static void plugin_gen_insn_inline(const struct qemu_plugin_tb *ptb,
> -                                   TCGOp *begin_op, int insn_idx)
> -{
> -    struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
> -    inject_inline_cb(insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE],
> -                     begin_op, op_ok);
> -}
> -
>   static void plugin_gen_mem_regular(const struct qemu_plugin_tb *ptb,
>                                      TCGOp *begin_op, int insn_idx)
>   {
> @@ -662,11 +468,51 @@ static void plugin_gen_mem_inline(const struct qemu_plugin_tb *ptb,
>       inject_inline_cb(cbs, begin_op, op_rw);
>   }
>   
> -static void plugin_gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
> -                                         TCGOp *begin_op, int insn_idx)
> +static void gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
> +                                  struct qemu_plugin_insn *insn)
>   {
> -    struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
> -    inject_mem_enable_helper(ptb, insn, begin_op);
> +    GArray *cbs[2];
> +    GArray *arr;
> +    size_t n_cbs;
> +
> +    /*
> +     * Tracking memory accesses performed from helpers requires extra work.
> +     * If an instruction is emulated with helpers, we do two things:
> +     * (1) copy the CB descriptors, and keep track of it so that they can be
> +     * freed later on, and (2) point CPUState.plugin_mem_cbs to the
> +     * descriptors, so that we can read them at run-time
> +     * (i.e. when the helper executes).
> +     * This run-time access is performed from qemu_plugin_vcpu_mem_cb.
> +     *
> +     * Note that plugin_gen_disable_mem_helpers undoes (2). Since it
> +     * is possible that the code we generate after the instruction is
> +     * dead, we also add checks before generating tb_exit etc.
> +     */
> +    if (!insn->calls_helpers) {
> +        return;
> +    }
> +
> +    cbs[0] = insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR];
> +    cbs[1] = insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE];
> +    n_cbs = cbs[0]->len + cbs[1]->len;
> +
> +    if (n_cbs == 0) {
> +        insn->mem_helper = false;
> +        return;
> +    }
> +    insn->mem_helper = true;
> +    ptb->mem_helper = true;
> +
> +    arr = g_array_sized_new(false, false,
> +                            sizeof(struct qemu_plugin_dyn_cb), n_cbs);
> +    g_array_append_vals(arr, cbs[0]->data, cbs[0]->len);
> +    g_array_append_vals(arr, cbs[1]->data, cbs[1]->len);
> +
> +    qemu_plugin_add_dyn_cb_arr(arr);
> +
> +    tcg_gen_st_ptr(tcg_constant_ptr((intptr_t)arr), tcg_env,
> +                   offsetof(CPUState, plugin_mem_cbs) -
> +                   offsetof(ArchCPU, env));
>   }
>   
>   static void gen_disable_mem_helper(void)
> @@ -830,6 +676,26 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
>                   }
>                   break;
>   
> +            case PLUGIN_GEN_FROM_INSN:
> +                assert(insn != NULL);
> +
> +                gen_enable_mem_helper(plugin_tb, insn);
> +
> +                cbs = insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR];
> +                for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
> +                    struct qemu_plugin_dyn_cb *cb =
> +                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
> +                    gen_udata_cb(cb);
> +                }
> +
> +                cbs = insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE];
> +                for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
> +                    struct qemu_plugin_dyn_cb *cb =
> +                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
> +                    gen_inline_cb(cb);
> +                }
> +                break;
> +
>               default:
>                   g_assert_not_reached();
>               }
> @@ -845,28 +711,6 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
>               enum plugin_gen_cb type = op->args[1];
>   
>               switch (from) {
> -            case PLUGIN_GEN_FROM_INSN:
> -            {
> -                g_assert(insn_idx >= 0);
> -
> -                switch (type) {
> -                case PLUGIN_GEN_CB_UDATA:
> -                    plugin_gen_insn_udata(plugin_tb, op, insn_idx);
> -                    break;
> -                case PLUGIN_GEN_CB_UDATA_R:
> -                    plugin_gen_insn_udata_r(plugin_tb, op, insn_idx);
> -                    break;
> -                case PLUGIN_GEN_CB_INLINE:
> -                    plugin_gen_insn_inline(plugin_tb, op, insn_idx);
> -                    break;
> -                case PLUGIN_GEN_ENABLE_MEM_HELPER:
> -                    plugin_gen_enable_mem_helper(plugin_tb, op, insn_idx);
> -                    break;
> -                default:
> -                    g_assert_not_reached();
> -                }
> -                break;
> -            }
>               case PLUGIN_GEN_FROM_MEM:
>               {
>                   g_assert(insn_idx >= 0);
> diff --git a/plugins/api.c b/plugins/api.c
> index 5d119e8049..29cce2d97c 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -115,12 +115,8 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
>                                               void *udata)
>   {
>       if (!insn->mem_only) {
> -        int index = flags == QEMU_PLUGIN_CB_R_REGS ||
> -                    flags == QEMU_PLUGIN_CB_RW_REGS ?
> -                    PLUGIN_CB_REGULAR_R : PLUGIN_CB_REGULAR;
> -
> -        plugin_register_dyn_cb__udata(&insn->cbs[PLUGIN_CB_INSN][index],
> -                                      cb, flags, udata);
> +        plugin_register_dyn_cb__udata(
> +            &insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR], cb, flags, udata);
>       }
>   }
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

