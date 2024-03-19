Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFB5C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 13:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmZ8u-00064G-PK; Tue, 19 Mar 2024 09:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZ8s-00063n-4f
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:04:34 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZ8p-0004iU-5k
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:04:33 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33e285a33bdso2855275f8f.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 06:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710853469; x=1711458269; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sh/JVFnjzuH/uQkkWe5XswA0o7bmzs9y7r1Fipfo2q4=;
 b=TUW0ywJAXC6wkUWWunuIeM3DKqp4vCZLcRSamNA8doCgyHZCbJhWCyI3HlIc6Yx4Du
 Nyxbnm0mdordEC9Ld7yf794we561d88hevRtrdJS9V/dZcdWhzPgxVrWd3RCUnopHOYh
 jchCeDZT/3HPky7AOxROQ2StYOZoxjwu+y/HkmYXxUMuHyHOUENrddcK6eijfKloYco4
 Lcs0Pwu0FfUK5PreZzSHofkpclq9Q8XaYsLwCtN38lXwck1afNyQGWZDFbIUMFLp9oq7
 4mVBR+tqBOwh+sfb7PaDEnNh56fpPLUOhsG8VDWQBExOQn6888LhWLXUcGQHk4Cg99H4
 bVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710853469; x=1711458269;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sh/JVFnjzuH/uQkkWe5XswA0o7bmzs9y7r1Fipfo2q4=;
 b=dyQyddE9x3vdQWFxvmnyDA3f6mbWq8MdlkTn9y/8spv2TJrNOwbf0bh1P4g72WS2bb
 OntbUsXKG2W/kObeG91O9xX7W7q12+f2l4xuhC3HFOkjbKLRQlGTIz30ZTiVtrUFvhzc
 g4cCHQgeTS7siKWY4E1UTYJuoV0hG7WFCVO99GGlqoWHGskuzZw/fioIP7WJ115QmkZ6
 ldaPIY8Yj4di3ubzkIVyNg76w8frBxAS932MfZNDoJPjbWVDgZCfbAd1rblqHaoYx6oV
 4UP1NXjrJSZh0A7Mbxix32l9f/Pw28tCps43larvGSxXnyQFE0zPj1WnWMT/VvANx4vl
 l46g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaq/F6crMV2G0ksRwn0gztyszMZJKlttb/C5hZwwbRCyMHg+rhuyU99CxP7KLgth0PSsKoC4hLmbpK53oZYycgCm680Zc=
X-Gm-Message-State: AOJu0YyzvxdGZM+Aacoqvq2EkSUZlIMM3W9pPQAQ/VotPxziEkNUBYTG
 01DByyOX1Rc9idPSwg3p3llVp6yG+/ftOTdBj5Aa9GasITjEOKLe/KV/4EhDSnc=
X-Google-Smtp-Source: AGHT+IFBy+bnQ8bsl8uypXjzNAKHZa96PmeHvCyxxJ6WTn5F1x2AHCvmDaUh2lccnecID7kM0WYxjQ==
X-Received: by 2002:a5d:4252:0:b0:33e:40a3:22c8 with SMTP id
 s18-20020a5d4252000000b0033e40a322c8mr10639847wrr.33.1710853469130; 
 Tue, 19 Mar 2024 06:04:29 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 p6-20020adfcc86000000b0033ec072a491sm12290778wrj.35.2024.03.19.06.04.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 06:04:28 -0700 (PDT)
Message-ID: <42421ddd-3a97-407c-a5a5-22f7bc87f8ed@linaro.org>
Date: Tue, 19 Mar 2024 17:04:25 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/22] tcg: Remove INDEX_op_plugin_cb_{start,end}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-15-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240316015720.3661236-15-richard.henderson@linaro.org>
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
> These opcodes are no longer used.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h |  2 --
>   include/tcg/tcg-opc.h       |  2 --
>   accel/tcg/plugin-gen.c      | 18 ------------------
>   tcg/tcg-op.c                | 10 ----------
>   4 files changed, 32 deletions(-)
> 
> diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
> index 72b80b20d0..009e2778c5 100644
> --- a/include/tcg/tcg-op-common.h
> +++ b/include/tcg/tcg-op-common.h
> @@ -76,8 +76,6 @@ void tcg_gen_lookup_and_goto_ptr(void);
>   
>   void tcg_gen_plugin_cb(unsigned from);
>   void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
> -void tcg_gen_plugin_cb_start(unsigned from, unsigned type, unsigned wr);
> -void tcg_gen_plugin_cb_end(void);
>   
>   /* 32 bit ops */
>   
> diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
> index be9e36e386..546eb49c11 100644
> --- a/include/tcg/tcg-opc.h
> +++ b/include/tcg/tcg-opc.h
> @@ -199,8 +199,6 @@ DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
>   
>   DEF(plugin_cb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
>   DEF(plugin_mem_cb, 0, 1, 1, TCG_OPF_NOT_PRESENT)
> -DEF(plugin_cb_start, 0, 0, 3, TCG_OPF_NOT_PRESENT)
> -DEF(plugin_cb_end, 0, 0, 0, TCG_OPF_NOT_PRESENT)
>   
>   /* Replicate ld/st ops for 32 and 64-bit guest addresses. */
>   DEF(qemu_ld_a32_i32, 1, 1, 1,
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index b5261edc38..c8f0e0ecaa 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -58,29 +58,11 @@
>   # define CONFIG_SOFTMMU_GATE 0
>   #endif
>   
> -/*
> - * plugin_cb_start TCG op args[]:
> - * 0: enum plugin_gen_from
> - * 1: enum plugin_gen_cb
> - * 2: set to 1 for mem callback that is a write, 0 otherwise.
> - */
> -
>   enum plugin_gen_from {
>       PLUGIN_GEN_FROM_TB,
>       PLUGIN_GEN_FROM_INSN,
>       PLUGIN_GEN_AFTER_INSN,
>       PLUGIN_GEN_AFTER_TB,
> -    PLUGIN_GEN_N_FROMS,
> -};
> -
> -enum plugin_gen_cb {
> -    PLUGIN_GEN_CB_UDATA,
> -    PLUGIN_GEN_CB_UDATA_R,
> -    PLUGIN_GEN_CB_INLINE,
> -    PLUGIN_GEN_CB_MEM,
> -    PLUGIN_GEN_ENABLE_MEM_HELPER,
> -    PLUGIN_GEN_DISABLE_MEM_HELPER,
> -    PLUGIN_GEN_N_CBS,
>   };
>   

Nice that you could remove this enum sounded duplicated from the similar 
one when registering ops/cbs.

>   static void plugin_gen_empty_callback(enum plugin_gen_from from)
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 0ae12fa49d..eff3728622 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -322,16 +322,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
>       tcg_gen_op2(INDEX_op_plugin_mem_cb, tcgv_i64_arg(addr), meminfo);
>   }
>   
> -void tcg_gen_plugin_cb_start(unsigned from, unsigned type, unsigned wr)
> -{
> -    tcg_gen_op3(INDEX_op_plugin_cb_start, from, type, wr);
> -}
> -
> -void tcg_gen_plugin_cb_end(void)
> -{
> -    tcg_emit_op(INDEX_op_plugin_cb_end, 0);
> -}
> -
>   /* 32 bit ops */
>   
>   void tcg_gen_discard_i32(TCGv_i32 arg)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

