Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887B6C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 13:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmZWa-0007Xs-D3; Tue, 19 Mar 2024 09:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZVv-0007NR-HQ
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:28:27 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZVs-0000VE-Dl
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:28:23 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41412411622so14423395e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 06:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710854899; x=1711459699; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NrwoVB7d5PUZwMDkO7HXqVjIlZg4tw3VMbNbG2CJPGE=;
 b=F2OzamavqC+fxdPPuh256fWdSpgcRESwd0AzpeXCMzIPXol11z8Qc8xGMdd10GXYOd
 vgFmwotYoRCSpRloqGdZoCUHoGvqjxqzDepIhoWHkMzO6bLf/p5WkexVpk2bMqAGbmhR
 2kVa6oy5khIzUSEX9hcOmBt1xPuuCOwTK8ciTmGbbexOxuKpuO6cpX/D5J4Nu304hhdB
 nHdSZN3vnEmsGCsb/T/AHiBz3bcjQSCtrt+IIKQykZ/LMPk0LO6gouWKrqdqc9lDQBF6
 tr8Yyt10jZFEKc8V4U/hqCKODHvKexr4gEqQxT4bGkO4nQFDn4PSvi9c5jKsxyvUtXkQ
 p1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710854899; x=1711459699;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NrwoVB7d5PUZwMDkO7HXqVjIlZg4tw3VMbNbG2CJPGE=;
 b=Ny10iGzJpeqRIPONgM5Xrz8RbvaBY4D1jL0dvib0ilbH/BAz/PwBk0QpceSjCGTGJ5
 GrcXbukUMzuW3Ftmt1i0c0O7VXhym/TUWbZd9hk4SYnQc/aasWPnghvVVI/nkEwXbxD4
 QN4hcdUVeR14xeSHQjSzjZXxcr/B5XDywy+RZIBuiHq8tRHdb+aiMF8Os0ga11I0Ya+G
 mT79xjkdCiQco5Up1awwv+SgWV5UF71Oyfy/7ET9MGIKMBm43fkuPfjhnqGo6Erc+JZy
 0pTdmOW4Ge9kswZHJXoMDVX5dzAbnk0UY7aUpKaGRqoJizxQ4T0+yh5F/yrvwpIg0Abk
 VLZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqDJOX2Cxll7XCrEqaG8D6y2CmGRbfCnWMdU5E+QEI+ZOr7O1nwTgXIpR5I8O6ry2TVc6PD1JjrBmrBdtd0e7VhxUTQ4Q=
X-Gm-Message-State: AOJu0YwmfD1O72IHxvYIdUkpP7zAskvBgSExjTZlSmimwOLJI86DEkZl
 fVVC8Pyjq83Eci1RZdfboHfDJDVgJrflxNSKEjcTwk7YkR/jSyN2NAojsPSaeq4=
X-Google-Smtp-Source: AGHT+IHeOtgjVqE5k3i2vQCSeAzKIFp7MDhCwwNYDcz69/brEstqxhTP5hyYG4y8/Fcl2filgKN+kA==
X-Received: by 2002:a5d:6da9:0:b0:341:72b8:83c9 with SMTP id
 u9-20020a5d6da9000000b0034172b883c9mr4441913wrs.70.1710854898744; 
 Tue, 19 Mar 2024 06:28:18 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 dw11-20020a0560000dcb00b0033b66c2d61esm12316405wrb.48.2024.03.19.06.28.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 06:28:18 -0700 (PDT)
Message-ID: <b8f5dc4f-9c83-472c-bcc5-5a0fe69ad0b3@linaro.org>
Date: Tue, 19 Mar 2024 17:28:15 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/22] plugins: Simplify callback queues
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-16-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240316015720.3661236-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32c.google.com
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
> We have qemu_plugin_dyn_cb.type to differentiate the various
> callback types, so we do not need to keep them in separate queues.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/plugin.h  | 35 ++++++----------
>   accel/tcg/plugin-gen.c | 90 ++++++++++++++++++++++--------------------
>   plugins/api.c          | 18 +++------
>   3 files changed, 65 insertions(+), 78 deletions(-)
> 
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index ee1c1b174a..cf9758be55 100644
> --- a/include/qemu/plugin.h
> +++ b/include/qemu/plugin.h
> @@ -66,15 +66,8 @@ union qemu_plugin_cb_sig {
>   };
>   
>   enum plugin_dyn_cb_type {
> -    PLUGIN_CB_INSN,
> -    PLUGIN_CB_MEM,
> -    PLUGIN_N_CB_TYPES,
> -};
> -
> -enum plugin_dyn_cb_subtype {
>       PLUGIN_CB_REGULAR,
>       PLUGIN_CB_INLINE,
> -    PLUGIN_N_CB_SUBTYPES,
>   };
>   
>   /*
> @@ -84,7 +77,7 @@ enum plugin_dyn_cb_subtype {
>    */
>   struct qemu_plugin_dyn_cb {
>       void *userp;
> -    enum plugin_dyn_cb_subtype type;
> +    enum plugin_dyn_cb_type type;
>       /* @rw applies to mem callbacks only (both regular and inline) */
>       enum qemu_plugin_mem_rw rw;
>       /* fields specific to each dyn_cb type go here */
> @@ -106,7 +99,8 @@ struct qemu_plugin_insn {
>       GByteArray *data;
>       uint64_t vaddr;
>       void *haddr;
> -    GArray *cbs[PLUGIN_N_CB_TYPES][PLUGIN_N_CB_SUBTYPES];
> +    GArray *insn_cbs;
> +    GArray *mem_cbs;
>       bool calls_helpers;
>   
>       /* if set, the instruction calls helpers that might access guest memory */
> @@ -135,16 +129,9 @@ static inline void qemu_plugin_insn_cleanup_fn(gpointer data)
>   
>   static inline struct qemu_plugin_insn *qemu_plugin_insn_alloc(void)
>   {
> -    int i, j;
>       struct qemu_plugin_insn *insn = g_new0(struct qemu_plugin_insn, 1);
> -    insn->data = g_byte_array_sized_new(4);
>   
> -    for (i = 0; i < PLUGIN_N_CB_TYPES; i++) {
> -        for (j = 0; j < PLUGIN_N_CB_SUBTYPES; j++) {
> -            insn->cbs[i][j] = g_array_new(false, false,
> -                                          sizeof(struct qemu_plugin_dyn_cb));
> -        }
> -    }
> +    insn->data = g_byte_array_sized_new(4);
>       return insn;
>   }
>   
> @@ -161,7 +148,7 @@ struct qemu_plugin_tb {
>       /* if set, the TB calls helpers that might access guest memory */
>       bool mem_helper;
>   
> -    GArray *cbs[PLUGIN_N_CB_SUBTYPES];
> +    GArray *cbs;
>   };
>   
>   /**
> @@ -174,22 +161,22 @@ struct qemu_plugin_insn *qemu_plugin_tb_insn_get(struct qemu_plugin_tb *tb,
>                                                    uint64_t pc)
>   {
>       struct qemu_plugin_insn *insn;
> -    int i, j;
>   
>       if (unlikely(tb->n == tb->insns->len)) {
>           struct qemu_plugin_insn *new_insn = qemu_plugin_insn_alloc();
>           g_ptr_array_add(tb->insns, new_insn);
>       }
> +
>       insn = g_ptr_array_index(tb->insns, tb->n++);
>       g_byte_array_set_size(insn->data, 0);
>       insn->calls_helpers = false;
>       insn->mem_helper = false;
>       insn->vaddr = pc;
> -
> -    for (i = 0; i < PLUGIN_N_CB_TYPES; i++) {
> -        for (j = 0; j < PLUGIN_N_CB_SUBTYPES; j++) {
> -            g_array_set_size(insn->cbs[i][j], 0);
> -        }
> +    if (insn->insn_cbs) {
> +        g_array_set_size(insn->insn_cbs, 0);
> +    }
> +    if (insn->mem_cbs) {
> +        g_array_set_size(insn->mem_cbs, 0);
>       }
>   
>       return insn;
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index c8f0e0ecaa..669e343cfb 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -89,9 +89,8 @@ void plugin_gen_disable_mem_helpers(void)
>   static void gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
>                                     struct qemu_plugin_insn *insn)
>   {
> -    GArray *cbs[2];
>       GArray *arr;
> -    size_t n_cbs;
> +    size_t len;
>   
>       /*
>        * Tracking memory accesses performed from helpers requires extra work.
> @@ -110,22 +109,25 @@ static void gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
>           return;
>       }
>   
> -    cbs[0] = insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR];
> -    cbs[1] = insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE];
> -    n_cbs = cbs[0]->len + cbs[1]->len;
> -
> -    if (n_cbs == 0) {
> +    if (!insn->mem_cbs || !insn->mem_cbs->len) {
>           insn->mem_helper = false;
>           return;
>       }
>       insn->mem_helper = true;
>       ptb->mem_helper = true;
>   
> +    /*
> +     * TODO: It seems like we should be able to use ref/unref
> +     * to avoid needing to actually copy this array.
> +     * Alternately, perhaps we could allocate new memory adjacent
> +     * to the TranslationBlock itself, so that we do not have to
> +     * actively manage the lifetime after this.
> +     */
> +    len = insn->mem_cbs->len;
>       arr = g_array_sized_new(false, false,
> -                            sizeof(struct qemu_plugin_dyn_cb), n_cbs);
> -    g_array_append_vals(arr, cbs[0]->data, cbs[0]->len);
> -    g_array_append_vals(arr, cbs[1]->data, cbs[1]->len);
> -
> +                            sizeof(struct qemu_plugin_dyn_cb), len);
> +    memcpy(arr->data, insn->mem_cbs->data,
> +           len * sizeof(struct qemu_plugin_dyn_cb));
>       qemu_plugin_add_dyn_cb_arr(arr);
>   
>       tcg_gen_st_ptr(tcg_constant_ptr((intptr_t)arr), tcg_env,
> @@ -294,18 +296,21 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
>               case PLUGIN_GEN_FROM_TB:
>                   assert(insn == NULL);
>   
> -                cbs = plugin_tb->cbs[PLUGIN_CB_REGULAR];
> +                cbs = plugin_tb->cbs;
>                   for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
>                       struct qemu_plugin_dyn_cb *cb =
>                           &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
> -                    gen_udata_cb(cb);
> -                }
>   
> -                cbs = plugin_tb->cbs[PLUGIN_CB_INLINE];
> -                for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
> -                    struct qemu_plugin_dyn_cb *cb =
> -                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
> -                    gen_inline_cb(cb);
> +                    switch (cb->type) {
> +                    case PLUGIN_CB_REGULAR:
> +                        gen_udata_cb(cb);
> +                        break;
> +                    case PLUGIN_CB_INLINE:
> +                        gen_inline_cb(cb);
> +                        break;
> +                    default:
> +                        g_assert_not_reached();
> +                    }
>                   }
>                   break;
>   
> @@ -314,18 +319,21 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
>   
>                   gen_enable_mem_helper(plugin_tb, insn);
>   
> -                cbs = insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR];
> +                cbs = insn->insn_cbs;
>                   for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
>                       struct qemu_plugin_dyn_cb *cb =
>                           &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
> -                    gen_udata_cb(cb);
> -                }
>   
> -                cbs = insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE];
> -                for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
> -                    struct qemu_plugin_dyn_cb *cb =
> -                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
> -                    gen_inline_cb(cb);
> +                    switch (cb->type) {
> +                    case PLUGIN_CB_REGULAR:
> +                        gen_udata_cb(cb);
> +                        break;
> +                    case PLUGIN_CB_INLINE:
> +                        gen_inline_cb(cb);
> +                        break;
> +                    default:
> +                        g_assert_not_reached();
> +                    }
>                   }
>                   break;
>   
> @@ -352,21 +360,22 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
>   
>               tcg_ctx->emit_before_op = op;
>   
> -            cbs = insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR];
> +            cbs = insn->mem_cbs;
>               for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
>                   struct qemu_plugin_dyn_cb *cb =
>                       &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
> -                if (cb->rw & rw) {
> -                    gen_mem_cb(cb, meminfo, addr);
> -                }
> -            }
>   
> -            cbs = insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE];
> -            for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
> -                struct qemu_plugin_dyn_cb *cb =
> -                    &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
>                   if (cb->rw & rw) {
> -                    gen_inline_cb(cb);
> +                    switch (cb->type) {
> +                    case PLUGIN_CB_REGULAR:
> +                        gen_mem_cb(cb, meminfo, addr);
> +                        break;
> +                    case PLUGIN_CB_INLINE:
> +                        gen_inline_cb(cb);
> +                        break;
> +                    default:
> +                        g_assert_not_reached();
> +                    }
>                   }
>               }
>   
> @@ -390,13 +399,10 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db,
>   
>       if (test_bit(QEMU_PLUGIN_EV_VCPU_TB_TRANS, cpu->plugin_state->event_mask)) {
>           struct qemu_plugin_tb *ptb = tcg_ctx->plugin_tb;
> -        int i;
>   
>           /* reset callbacks */
> -        for (i = 0; i < PLUGIN_N_CB_SUBTYPES; i++) {
> -            if (ptb->cbs[i]) {
> -                g_array_set_size(ptb->cbs[i], 0);
> -            }
> +        if (ptb->cbs) {
> +            g_array_set_size(ptb->cbs, 0);
>           }
>           ptb->n = 0;
>   
> diff --git a/plugins/api.c b/plugins/api.c
> index 29cce2d97c..3912c9cc8f 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -92,8 +92,7 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
>                                             void *udata)
>   {
>       if (!tb->mem_only) {
> -        plugin_register_dyn_cb__udata(&tb->cbs[PLUGIN_CB_REGULAR],
> -                                      cb, flags, udata);
> +        plugin_register_dyn_cb__udata(&tb->cbs, cb, flags, udata);
>       }
>   }
>   
> @@ -104,8 +103,7 @@ void qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
>       uint64_t imm)
>   {
>       if (!tb->mem_only) {
> -        plugin_register_inline_op_on_entry(
> -            &tb->cbs[PLUGIN_CB_INLINE], 0, op, entry, imm);
> +        plugin_register_inline_op_on_entry(&tb->cbs, 0, op, entry, imm);
>       }
>   }
>   
> @@ -115,8 +113,7 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
>                                               void *udata)
>   {
>       if (!insn->mem_only) {
> -        plugin_register_dyn_cb__udata(
> -            &insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR], cb, flags, udata);
> +        plugin_register_dyn_cb__udata(&insn->insn_cbs, cb, flags, udata);
>       }
>   }
>   
> @@ -127,8 +124,7 @@ void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>       uint64_t imm)
>   {
>       if (!insn->mem_only) {
> -        plugin_register_inline_op_on_entry(
> -            &insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE], 0, op, entry, imm);
> +        plugin_register_inline_op_on_entry(&insn->insn_cbs, 0, op, entry, imm);
>       }
>   }
>   
> @@ -143,8 +139,7 @@ void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
>                                         enum qemu_plugin_mem_rw rw,
>                                         void *udata)
>   {
> -    plugin_register_vcpu_mem_cb(&insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR],
> -                                cb, flags, rw, udata);
> +    plugin_register_vcpu_mem_cb(&insn->mem_cbs, cb, flags, rw, udata);
>   }
>   
>   void qemu_plugin_register_vcpu_mem_inline_per_vcpu(
> @@ -154,8 +149,7 @@ void qemu_plugin_register_vcpu_mem_inline_per_vcpu(
>       qemu_plugin_u64 entry,
>       uint64_t imm)
>   {
> -    plugin_register_inline_op_on_entry(
> -        &insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE], rw, op, entry, imm);
> +    plugin_register_inline_op_on_entry(&insn->mem_cbs, rw, op, entry, imm);
>   }
>   
>   void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,

Great, that makes sense.
I expressed in another patch why we didn't mix all cbs together, so good 
to see this here.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

