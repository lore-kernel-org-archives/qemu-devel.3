Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20864C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 13:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmZMt-0003eQ-Eg; Tue, 19 Mar 2024 09:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZMq-0003aL-Dg
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:19:00 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZMo-0007J3-0z
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:18:59 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-34173b6b985so1639304f8f.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 06:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710854335; x=1711459135; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9is3wRDqnKK9nkNr7GpZXnLeUKxzIUEZI5RDqBcsf54=;
 b=hW9buH+99n4Bq/kjKD+FWYdQDTXpbosjtApRuE8hH4y7GbLqS8YAQxOSJ3R1QWmI6o
 PTqOtNYDouOyIBmANdHLFXTMmVIrn9GpRwGgagaIpJRPey58hwpBzYT4tiCYmMe4ms6F
 bQR+M7kJzlIGSndMehUvevFfyZmQdWJYNFD8n8NTeKXfMNtUYLr/JUhQJLPifSRxQ+8G
 vUYpMC64062R3EPSYOQd5SJjnnZ8qSTDZFD3GuLqoZTr5yzJlytrJPPqDDbrgm7Yt174
 7YXICKy5/UtgrzfqDKSeR2+KNyhBfujW2jKA9exLK6RH7F/D4H2KMDYrH/VQ340eQ1cH
 IVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710854335; x=1711459135;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9is3wRDqnKK9nkNr7GpZXnLeUKxzIUEZI5RDqBcsf54=;
 b=IF1XFW6JRWHLuqgUiC1lBZXQ1Qlg8h2Woe4h/E+7atspYiMr//qfn9x/KXjHWAIoDk
 LSC8ulyU/f/g1BG6f3CfbndVvgYXXw9/LJjz3RxbTcufRv4KHR9V1/UFpJglzDx/pORp
 KZjJ5VteDy3lfFHVc0n8ifoLy/JcGTb0ktGjkQsR3aXi8C2Is4kPerjJAW9yG5XNrYYF
 rFGrKctiLxnLaJbeGaD2QAWvctgr+QDAagqkyu37r5o9UbSJDv5Qv0kjKvRj+9ZVuMw7
 aWQsQjfcnyi/Q8Wys0jtsPFSMVGX2eOpJaN+MiJ3gsqq7BavDPz9KiIcFdgEeTblRu/q
 Qu+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP+fJoj7AN71RbFbdFBnvxTYXc4Smv1pYf1/6k5EVsKpRKFDnIJ0ckbULx0NallNrMY2AvV6SIOlsMDPTjHmYaEOexSMQ=
X-Gm-Message-State: AOJu0YxgexkYF+oWSK4siaeYIhonfbK+BoZ2N2jo8BoBZOGc0M4uuaqI
 Yx3aS55Sx/al2dAkhXrCZm9tDgmfyDIg0N2jh8r3tse37SQ60EvLQtlidSk6oTw=
X-Google-Smtp-Source: AGHT+IHD7Rvsa33O4s8jd+zIiPAxjM68sLT4mcH4dH+QP9rf9tTCRfLxUAKd4PidjZ3oBfenzAGOEA==
X-Received: by 2002:a05:6000:124e:b0:33d:7afa:fb0b with SMTP id
 j14-20020a056000124e00b0033d7afafb0bmr8761042wrx.15.1710854335434; 
 Tue, 19 Mar 2024 06:18:55 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 bo6-20020a056000068600b003418016b04csm3512135wrb.76.2024.03.19.06.18.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 06:18:55 -0700 (PDT)
Message-ID: <aeeb7f81-1e43-4a89-bec3-faf047e4d53a@linaro.org>
Date: Tue, 19 Mar 2024 17:18:52 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/22] plugins: Move function pointer in qemu_plugin_dyn_cb
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-6-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240316015720.3661236-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x431.google.com
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
> The out-of-line function pointer is mutually exclusive
> with inline expansion, so move it into the union.
> Wrap the pointer in a structure named 'regular' to match
> PLUGIN_CB_REGULAR.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/plugin.h  | 4 +++-
>   accel/tcg/plugin-gen.c | 4 ++--
>   plugins/core.c         | 8 ++++----
>   3 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index 12a96cea2a..143262dca8 100644
> --- a/include/qemu/plugin.h
> +++ b/include/qemu/plugin.h
> @@ -84,13 +84,15 @@ enum plugin_dyn_cb_subtype {
>    * instance of a callback to be called upon the execution of a particular TB.
>    */
>   struct qemu_plugin_dyn_cb {
> -    union qemu_plugin_cb_sig f;
>       void *userp;
>       enum plugin_dyn_cb_subtype type;
>       /* @rw applies to mem callbacks only (both regular and inline) */
>       enum qemu_plugin_mem_rw rw;
>       /* fields specific to each dyn_cb type go here */
>       union {
> +        struct {
> +            union qemu_plugin_cb_sig f;
> +        } regular;
>           struct {
>               qemu_plugin_u64 entry;
>               enum qemu_plugin_op op;

While we are cleaning this, maybe this could be only a union (moving rw 
and userp to fields), and only type + union would be used.
Even if we duplicate userp in regular, and mem_cb, it would be much more 
readable.
For instance, userp is never used by inline operations.

> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index 8028786c7b..c56f104aee 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -431,7 +431,7 @@ static TCGOp *append_udata_cb(const struct qemu_plugin_dyn_cb *cb,
>       }
>   
>       /* call */
> -    op = copy_call(&begin_op, op, cb->f.vcpu_udata, cb_idx);
> +    op = copy_call(&begin_op, op, cb->regular.f.vcpu_udata, cb_idx);
>   
>       return op;
>   }
> @@ -479,7 +479,7 @@ static TCGOp *append_mem_cb(const struct qemu_plugin_dyn_cb *cb,
>   
>       if (type == PLUGIN_GEN_CB_MEM) {
>           /* call */
> -        op = copy_call(&begin_op, op, cb->f.vcpu_udata, cb_idx);
> +        op = copy_call(&begin_op, op, cb->regular.f.vcpu_udata, cb_idx);
>       }
>   
>       return op;
> diff --git a/plugins/core.c b/plugins/core.c
> index 4487cb7c48..837c373690 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -342,7 +342,7 @@ void plugin_register_dyn_cb__udata(GArray **arr,
>   
>       dyn_cb->userp = udata;
>       /* Note flags are discarded as unused. */
> -    dyn_cb->f.vcpu_udata = cb;
> +    dyn_cb->regular.f.vcpu_udata = cb;
>       dyn_cb->type = PLUGIN_CB_REGULAR;
>   }
>   
> @@ -359,7 +359,7 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
>       /* Note flags are discarded as unused. */
>       dyn_cb->type = PLUGIN_CB_REGULAR;
>       dyn_cb->rw = rw;
> -    dyn_cb->f.generic = cb;
> +    dyn_cb->regular.f.vcpu_mem = cb;
>   }
>   
>   /*
> @@ -511,8 +511,8 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
>           }
>           switch (cb->type) {
>           case PLUGIN_CB_REGULAR:
> -            cb->f.vcpu_mem(cpu->cpu_index, make_plugin_meminfo(oi, rw),
> -                           vaddr, cb->userp);
> +            cb->regular.f.vcpu_mem(cpu->cpu_index, make_plugin_meminfo(oi, rw),
> +                                   vaddr, cb->userp);
>               break;
>           case PLUGIN_CB_INLINE:
>               exec_inline_op(cb, cpu->cpu_index);

