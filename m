Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D209C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 13:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmZX3-00082g-3S; Tue, 19 Mar 2024 09:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZWz-0007rq-Is
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:29:30 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZWx-0000hZ-Sn
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:29:29 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3412f49bac7so1982476f8f.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 06:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710854966; x=1711459766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3nB3TZlc7jTJ0yNtXWEO59gMLzaLXXUwsm0VtuVM+9s=;
 b=v8FMQi+huXYx1ktI8f39nwzfUPXm+DpJKQn+zuwEwrxZQD4yEMGoSNoW9/oNZGYFFb
 eCXaKkrbrBNOeCumDIhDf3i0X0wGLKBix6oY2151e5hvbmpno2t4x/2NQSnN485/1srj
 mD1Q7RyYj4DsVA8o8Vmhtw4qey46qgaib1efGeGo//kysHNnkJoXplZ2VfUs6Z6W6OT6
 CrvsJ3ZrCniBy1U4us0H0xj/bnEtvDo9rmkuji5E6lnu7jZnRtYoSRYTc0TLWHlf/FB4
 v8dG1Sxb7Iosr0lGIg91lqfeq+cGsdSh0YqU/UglYUxrnuW81kpzkUV+cG/0vh2GTnOB
 Mwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710854966; x=1711459766;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3nB3TZlc7jTJ0yNtXWEO59gMLzaLXXUwsm0VtuVM+9s=;
 b=J0i5+X6xQrcVfyRp2osJAbn6q1CMEq0wf2Ji6AssV0qeqgR+UTlozSxmMoqd14POjM
 zixKsbMPHD5EqIGx934dKgCCAbja+WrOP3DYCl7GLg2JnlsERo0ne/t1Klu5cS2JxODP
 fG8SATOTmKThS0/9pNsfgakpdyo9l0+IfdfwO8+d3lDKMPipPuL7/79HLRRp1gvO6dL0
 erjAuYBD9s2TeoPVd5UlssfW0zhBV33lA9MypqB756AoqkZDuAzR2QVxa47F/c+FLq0i
 /f83TX5A7m03iOqVi6NeyrR9kJs2IqAZkltCRd0WbkUhrTTkTHDlk+8KK7t8sbVdc5Hx
 nePA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgRrAjpFqx+Ar59o6afOq4zMJY2AUcja6My2hyEZbTtaWDmuAwh7NWUlor73UZwXrtlpc+hwgTeRzFN16Pldy09UH9deI=
X-Gm-Message-State: AOJu0YxbiYiyAc+f8MptUta0Z6f+zTMpJd8y6gijs556C56ZUAmleNWD
 yieaqKxZ11X9P9Cp8J8xGaQvSQciaz2z6o8Zor2duH3N9RKBbo2/xPIIckhU80Mc2bn79EL2Uv3
 Xarw=
X-Google-Smtp-Source: AGHT+IGsodAvj7RWAomNkSGUDsQolDt8vgfrWRFn0aj5fvpEAMyE8wmzWK2V+n2cDgSkcvigBV9YRw==
X-Received: by 2002:a5d:4a4c:0:b0:33e:c2ed:7898 with SMTP id
 v12-20020a5d4a4c000000b0033ec2ed7898mr8032097wrs.54.1710854966237; 
 Tue, 19 Mar 2024 06:29:26 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 dw11-20020a0560000dcb00b0033b66c2d61esm12316405wrb.48.2024.03.19.06.29.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 06:29:26 -0700 (PDT)
Message-ID: <dea47206-d142-46ce-bcc8-afbd61a7860f@linaro.org>
Date: Tue, 19 Mar 2024 17:29:24 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/22] plugins: Split out common cb expanders
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-19-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240316015720.3661236-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x430.google.com
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
>   accel/tcg/plugin-gen.c | 84 +++++++++++++++++++++---------------------
>   1 file changed, 41 insertions(+), 43 deletions(-)
> 
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index 10d917abd3..28414c4ff1 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -194,6 +194,37 @@ static void gen_mem_cb(struct qemu_plugin_dyn_cb *cb,
>       tcg_temp_free_i32(cpu_index);
>   }
>   
> +static void inject_cb(struct qemu_plugin_dyn_cb *cb)
> +
> +{
> +    switch (cb->type) {
> +    case PLUGIN_CB_REGULAR:
> +        gen_udata_cb(cb);
> +        break;
> +    case PLUGIN_CB_INLINE:
> +        gen_inline_cb(cb);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static void inject_mem_cb(struct qemu_plugin_dyn_cb *cb,
> +                          enum qemu_plugin_mem_rw rw,
> +                          qemu_plugin_meminfo_t meminfo, TCGv_i64 addr)
> +{
> +    if (cb->rw & rw) {
> +        switch (cb->type) {
> +        case PLUGIN_CB_MEM_REGULAR:
> +            gen_mem_cb(cb, meminfo, addr);
> +            break;
> +        default:
> +            inject_cb(cb);
> +            break;
> +        }
> +    }
> +}
> +
>   static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
>   {
>       TCGOp *op, *next;
> @@ -255,19 +286,8 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
>   
>                   cbs = plugin_tb->cbs;
>                   for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
> -                    struct qemu_plugin_dyn_cb *cb =
> -                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
> -
> -                    switch (cb->type) {
> -                    case PLUGIN_CB_REGULAR:
> -                        gen_udata_cb(cb);
> -                        break;
> -                    case PLUGIN_CB_INLINE:
> -                        gen_inline_cb(cb);
> -                        break;
> -                    default:
> -                        g_assert_not_reached();
> -                    }
> +                    inject_cb(
> +                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i));
>                   }
>                   break;
>   
> @@ -278,19 +298,8 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
>   
>                   cbs = insn->insn_cbs;
>                   for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
> -                    struct qemu_plugin_dyn_cb *cb =
> -                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
> -
> -                    switch (cb->type) {
> -                    case PLUGIN_CB_REGULAR:
> -                        gen_udata_cb(cb);
> -                        break;
> -                    case PLUGIN_CB_INLINE:
> -                        gen_inline_cb(cb);
> -                        break;
> -                    default:
> -                        g_assert_not_reached();
> -                    }
> +                    inject_cb(
> +                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i));
>                   }
>                   break;
>   
> @@ -307,33 +316,22 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
>           {
>               TCGv_i64 addr = temp_tcgv_i64(arg_temp(op->args[0]));
>               qemu_plugin_meminfo_t meminfo = op->args[1];
> +            enum qemu_plugin_mem_rw rw =
> +                (qemu_plugin_mem_is_store(meminfo)
> +                 ? QEMU_PLUGIN_MEM_W : QEMU_PLUGIN_MEM_R);
>               struct qemu_plugin_insn *insn;
>               const GArray *cbs;
> -            int i, n, rw;
> +            int i, n;
>   
>               assert(insn_idx >= 0);
>               insn = g_ptr_array_index(plugin_tb->insns, insn_idx);
> -            rw = qemu_plugin_mem_is_store(meminfo) ? 2 : 1;
>   
>               tcg_ctx->emit_before_op = op;
>   
>               cbs = insn->mem_cbs;
>               for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
> -                struct qemu_plugin_dyn_cb *cb =
> -                    &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
> -
> -                if (cb->rw & rw) {
> -                    switch (cb->type) {
> -                    case PLUGIN_CB_MEM_REGULAR:
> -                        gen_mem_cb(cb, meminfo, addr);
> -                        break;
> -                    case PLUGIN_CB_INLINE:
> -                        gen_inline_cb(cb);
> -                        break;
> -                    default:
> -                        g_assert_not_reached();
> -                    }
> -                }
> +                inject_mem_cb(&g_array_index(cbs, struct qemu_plugin_dyn_cb, i),
> +                              rw, meminfo, addr);
>               }
>   
>               tcg_ctx->emit_before_op = NULL;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

