Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE488C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 13:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmZQS-0004rX-4h; Tue, 19 Mar 2024 09:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZQO-0004r1-JK
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:22:40 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZQM-00083I-JL
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:22:40 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-512e39226efso4705096e87.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 06:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710854557; x=1711459357; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FzO2mY54sAd+tcGMjhgXB/qSFCkijyXCIzsq6Nfh7FU=;
 b=V1230y5KZI1CH8fEbZ7vLP2mY3URcVhQlqRJj0CbRxoTs7MdcX8ac2SCbNJPLxlwhZ
 cnvW4SkVAxHtQIsuyq5CVKFSG9pXqOkh2i1X/JJ9BEbtPn4C8wsmu+4eoa+v3+FHCGX6
 5HD6KDUnjyULYD3DPk0aIXipk++S9T3jS6VX4JP/tH0pbE0wdDujS1n4ja5iJsjh2svP
 dM0x8AAwjYvZex3eyJ57xCIxr4evhD+XpwdNiWPFp/eAF/CsiolK2evDOKrP76kL+uYa
 QvoBkBej4P29cMnVl5niRd2tSV/to+xscic5+mq/uYmMzH6VNyR9YlaF+UG6yiDWG2d4
 Pa/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710854557; x=1711459357;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FzO2mY54sAd+tcGMjhgXB/qSFCkijyXCIzsq6Nfh7FU=;
 b=miDymnNl5mqR0ZEkbv+842Xr3ZlCmJGq5Vj8LG2Ognn89IE2LiA2Hffh63EHciZt8W
 yx17wwq3kGKvr8+xbXsHOtMTPIQfZosDpoog7GYLrW9anMoQ1WHTc2iHK2d7vSs/VkK4
 AnoNJl21B1/1EtKNVn6HgDrHjN+mJvocYXLebwoseSTyqBuSOrBIxWBni0Zh6J5mSQN0
 XBLhXg5gUxn9A9CxN28n9pKRa0rMvSzulMP2xLH6xmwjAa37AhInTFr8m/SGeFtoLGS4
 z/LpXUUYRi6CrQyryBfGTIRTmu5vJ6cRpdslXH777/0WTWvT8SEDJFDDhdoMqKZExFr+
 ladg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJSLxS/xNVhXe2DMP1WQfL+81EmQF06SWIfbdo7A7FnRJnrfVrltmMInW6MW0x1f1mcc65Eu/D0FEENqKhcTJqtmerglM=
X-Gm-Message-State: AOJu0YwPONAy0jpqT9RWgRHVAXAlwguCx1FADsUJrxAodVHsYUL5Y2tM
 bqUrDhRfgHidsAEGxrS4Q6iCd2vXN05dM35S3RoXF4IUShYPs7v8U9cEy229tHY=
X-Google-Smtp-Source: AGHT+IHuOBBFJiaLoLkP6wqr5ubAnk6I4mk68L/ezeWTD6E0pks2Spi1aaZX3GNWTN+C3vNPytS5pQ==
X-Received: by 2002:ac2:5b10:0:b0:513:dd66:d5ed with SMTP id
 v16-20020ac25b10000000b00513dd66d5edmr7674556lfn.29.1710854556712; 
 Tue, 19 Mar 2024 06:22:36 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 i18-20020adffc12000000b0033e786abf84sm12383456wrr.54.2024.03.19.06.22.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 06:22:36 -0700 (PDT)
Message-ID: <199426d0-deea-4bfc-b2cd-8150fc5f21d2@linaro.org>
Date: Tue, 19 Mar 2024 17:22:33 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/22] plugins: Use emit_before_op for PLUGIN_GEN_FROM_TB
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-9-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240316015720.3661236-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lf1-x12e.google.com
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
> By having the qemu_plugin_cb_flags be recorded in the TCGHelperInfo,
> we no longer need to distinguish PLUGIN_CB_REGULAR from
> PLUGIN_CB_REGULAR_R, so place all TB callbacks in the same queue.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/plugin-gen.c | 96 +++++++++++++++++++++++++-----------------
>   plugins/api.c          |  6 +--
>   2 files changed, 58 insertions(+), 44 deletions(-)
> 
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index 8fa342b425..f92aa80510 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -207,6 +207,7 @@ static void plugin_gen_empty_callback(enum plugin_gen_from from)
>   {
>       switch (from) {
>       case PLUGIN_GEN_AFTER_INSN:
> +    case PLUGIN_GEN_FROM_TB:
>           tcg_gen_plugin_cb(from);
>           break;
>       case PLUGIN_GEN_FROM_INSN:
> @@ -216,8 +217,6 @@ static void plugin_gen_empty_callback(enum plugin_gen_from from)
>            */
>           gen_wrapped(from, PLUGIN_GEN_ENABLE_MEM_HELPER,
>                       gen_empty_mem_helper);
> -        /* fall through */
> -    case PLUGIN_GEN_FROM_TB:
>           gen_wrapped(from, PLUGIN_GEN_CB_UDATA, gen_empty_udata_cb_no_rwg);
>           gen_wrapped(from, PLUGIN_GEN_CB_UDATA_R, gen_empty_udata_cb_no_wg);
>           gen_wrapped(from, PLUGIN_GEN_CB_INLINE, gen_empty_inline_cb);
> @@ -632,24 +631,6 @@ void plugin_gen_disable_mem_helpers(void)
>                      offsetof(CPUState, plugin_mem_cbs) - offsetof(ArchCPU, env));
>   }
>   
> -static void plugin_gen_tb_udata(const struct qemu_plugin_tb *ptb,
> -                                TCGOp *begin_op)
> -{
> -    inject_udata_cb(ptb->cbs[PLUGIN_CB_REGULAR], begin_op);
> -}
> -
> -static void plugin_gen_tb_udata_r(const struct qemu_plugin_tb *ptb,
> -                                  TCGOp *begin_op)
> -{
> -    inject_udata_cb(ptb->cbs[PLUGIN_CB_REGULAR_R], begin_op);
> -}
> -
> -static void plugin_gen_tb_inline(const struct qemu_plugin_tb *ptb,
> -                                 TCGOp *begin_op)
> -{
> -    inject_inline_cb(ptb->cbs[PLUGIN_CB_INLINE], begin_op, op_ok);
> -}
> -
>   static void plugin_gen_insn_udata(const struct qemu_plugin_tb *ptb,
>                                     TCGOp *begin_op, int insn_idx)
>   {
> @@ -708,6 +689,41 @@ static void gen_disable_mem_helper(struct qemu_plugin_tb *ptb,
>       }
>   }
>   
> +static void gen_udata_cb(struct qemu_plugin_dyn_cb *cb)
> +{
> +    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
> +
> +    tcg_gen_ld_i32(cpu_index, tcg_env,
> +                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
> +    tcg_gen_call2(cb->regular.f.vcpu_udata, cb->regular.info, NULL,
> +                  tcgv_i32_temp(cpu_index),
> +                  tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
> +    tcg_temp_free_i32(cpu_index);
> +}
> +
> +static void gen_inline_cb(struct qemu_plugin_dyn_cb *cb)
> +{
> +    GArray *arr = cb->inline_insn.entry.score->data;
> +    size_t offset = cb->inline_insn.entry.offset;
> +    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
> +    TCGv_i64 val = tcg_temp_ebb_new_i64();
> +    TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
> +
> +    tcg_gen_ld_i32(cpu_index, tcg_env,
> +                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
> +    tcg_gen_muli_i32(cpu_index, cpu_index, g_array_get_element_size(arr));
> +    tcg_gen_ext_i32_ptr(ptr, cpu_index);
> +    tcg_temp_free_i32(cpu_index);
> +
> +    tcg_gen_addi_ptr(ptr, ptr, (intptr_t)arr->data);
> +    tcg_gen_ld_i64(val, ptr, offset);
> +    tcg_gen_addi_i64(val, val, cb->inline_insn.imm);
> +    tcg_gen_st_i64(val, ptr, offset);
> +
> +    tcg_temp_free_i64(val);
> +    tcg_temp_free_ptr(ptr);
> +}
> +
>   /* #define DEBUG_PLUGIN_GEN_OPS */
>   static void pr_ops(void)
>   {
> @@ -786,6 +802,8 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
>           {
>               enum plugin_gen_from from = op->args[0];
>               struct qemu_plugin_insn *insn = NULL;
> +            const GArray *cbs;
> +            int i, n;
>   
>               if (insn_idx >= 0) {
>                   insn = g_ptr_array_index(plugin_tb->insns, insn_idx);
> @@ -798,6 +816,25 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
>                   assert(insn != NULL);
>                   gen_disable_mem_helper(plugin_tb, insn);
>                   break;
> +
> +            case PLUGIN_GEN_FROM_TB:
> +                assert(insn == NULL);
> +
> +                cbs = plugin_tb->cbs[PLUGIN_CB_REGULAR];
> +                for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
> +                    struct qemu_plugin_dyn_cb *cb =
> +                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
> +                    gen_udata_cb(cb);
> +                }
> +
> +                cbs = plugin_tb->cbs[PLUGIN_CB_INLINE];
> +                for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
> +                    struct qemu_plugin_dyn_cb *cb =
> +                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
> +                    gen_inline_cb(cb);
> +                }
> +                break;
> +

Maybe I am missing something, but couldn't we simply mix all cbs 
possible. This way, the order mentioned by user when registering is the 
only one that matters, and he can select to mix callbacks and inline ops 
freely.
Just checking the type of callback would be needed to know which gen_* 
fn should be used.

>               default:
>                   g_assert_not_reached();
>               }
> @@ -813,25 +850,6 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
>               enum plugin_gen_cb type = op->args[1];
>   
>               switch (from) {
> -            case PLUGIN_GEN_FROM_TB:
> -            {
> -                g_assert(insn_idx == -1);
> -
> -                switch (type) {
> -                case PLUGIN_GEN_CB_UDATA:
> -                    plugin_gen_tb_udata(plugin_tb, op);
> -                    break;
> -                case PLUGIN_GEN_CB_UDATA_R:
> -                    plugin_gen_tb_udata_r(plugin_tb, op);
> -                    break;
> -                case PLUGIN_GEN_CB_INLINE:
> -                    plugin_gen_tb_inline(plugin_tb, op);
> -                    break;
> -                default:
> -                    g_assert_not_reached();
> -                }
> -                break;
> -            }
>               case PLUGIN_GEN_FROM_INSN:
>               {
>                   g_assert(insn_idx >= 0);
> diff --git a/plugins/api.c b/plugins/api.c
> index 8fa5a600ac..5d119e8049 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -92,11 +92,7 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
>                                             void *udata)
>   {
>       if (!tb->mem_only) {
> -        int index = flags == QEMU_PLUGIN_CB_R_REGS ||
> -                    flags == QEMU_PLUGIN_CB_RW_REGS ?
> -                    PLUGIN_CB_REGULAR_R : PLUGIN_CB_REGULAR;
> -
> -        plugin_register_dyn_cb__udata(&tb->cbs[index],
> +        plugin_register_dyn_cb__udata(&tb->cbs[PLUGIN_CB_REGULAR],
>                                         cb, flags, udata);
>       }
>   }

