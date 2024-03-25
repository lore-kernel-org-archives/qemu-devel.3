Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC0FC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 19:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ropus-0005mY-1u; Mon, 25 Mar 2024 15:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ropum-0005mD-J2
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:23:24 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ropuk-0007kR-Vu
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:23:24 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1e0000cdf99so36849545ad.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 12:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711394601; x=1711999401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kpnT3ZJVl7ZW4tzI11v8BlXbyBRnovpBnl3cbWzKr+o=;
 b=himXkmsfJQOyiHcYoNASSd85nrAi/zdQhX3I6Z7oj8lAQj6lGVXhgLX78nTfMf/YB3
 /2Ne3Iuc/YIwspQ7AEsHJJX+t7HJ/EeLxLe1xLriCH/zfXJj5LswW9HRENhOCGqnEJco
 noleOFLEscGqIDyEnQ/TYmtrbc8f0j1OZNaKHhBQkZZapjmyFqyDZwlohdgqyJurOTet
 7PrY2Pr8jNFD0dFr8SE5A7JrO4GqLvNPa5tpC512lRn4bHNQc4XIhbpbz41lympDnYm8
 eM4LFwYSpmtyFhQuOvdaZ9EbMbYuV8ro8iPX4Nfjb2FLMNmoO5R7ozwl0MGhwAvgBRMd
 EBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711394601; x=1711999401;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kpnT3ZJVl7ZW4tzI11v8BlXbyBRnovpBnl3cbWzKr+o=;
 b=sDSXZRaiwZ7/NjaR+OZk5qdihB/p64I1KzEah38aARg3OeevJTzoCMb6pZMPoKGpqn
 NiZankBTKkZ7w/Xqq5/tFE8Z/4YU6xvMfjimpTmFMVhZB8xxH0YHTYxEWCXLx/pM+PBe
 tBx6I9BEeK2pKu+TPQsOK0PAP6HTEaOo2Y+7x0c83M2f+goko/38wPcvdp8g3Ygdevjc
 BaF8PBE6aRM8bREzsB0dPaIIRcv2Yo8Q/QPAGZHuezFRm/Gr/O8dimPumYRLU4rhImQT
 2gSSoxGL0dKUGxgkWyNzyaojQaSIEstFp+um/Huf0SXyhMR3ZVC0isD2chH6vnNrmxzs
 mLqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoioxZSmEh13Ds7tOjPQVFspkOFJnAN/kPuLjAJtMjjk/r8nqzM0ONvceNsBxvIuApf/YYp8GaGgC5VtzkjkM7kAYHCDQ=
X-Gm-Message-State: AOJu0YxeUI60FQqmruIMx0xdy9Ks11ZjDzTHUL6MoULUwLmOhly9gzkv
 p+++Rr06RfM+pjeV/431iyTkrMTmDWtwvKRGKkKhCW/QQ+fR+7bnEMtaOzadcMQ=
X-Google-Smtp-Source: AGHT+IHA3idBooFYq9cX21eJrEAUTqDeC4nDNd9TgJdN1TCALyDhgVuw1c+sqfJ1Hb3qBfiwc2U+kg==
X-Received: by 2002:a17:902:d50f:b0:1e0:bd7f:194 with SMTP id
 b15-20020a170902d50f00b001e0bd7f0194mr4683229plg.36.1711394600759; 
 Mon, 25 Mar 2024 12:23:20 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 q8-20020a170902b10800b001e00d9680cesm5039111plr.130.2024.03.25.12.23.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 12:23:20 -0700 (PDT)
Message-ID: <32cec6a3-3535-4464-983a-894d3ba937bf@linaro.org>
Date: Mon, 25 Mar 2024 09:23:17 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] plugins: distinct types for callbacks
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240325124151.336003-1-pierrick.bouvier@linaro.org>
 <20240325124151.336003-8-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240325124151.336003-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/25/24 02:41, Pierrick Bouvier wrote:
> To prevent errors when writing new types of callbacks or inline
> operations, we split callbacks data to distinct types.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/qemu/plugin.h  | 46 ++++++++++++++-----------
>   plugins/plugin.h       |  2 +-
>   accel/tcg/plugin-gen.c | 58 +++++++++++++++++---------------
>   plugins/core.c         | 76 ++++++++++++++++++++++--------------------
>   4 files changed, 98 insertions(+), 84 deletions(-)
> 
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index bb224b8e4c7..a078229942f 100644
> --- a/include/qemu/plugin.h
> +++ b/include/qemu/plugin.h
> @@ -73,34 +73,40 @@ enum plugin_dyn_cb_type {
>       PLUGIN_CB_INLINE_STORE_U64,
>   };
>   
> +struct qemu_plugin_regular_cb {
> +    union qemu_plugin_cb_sig f;
> +    TCGHelperInfo *info;
> +    void *userp;
> +    enum qemu_plugin_mem_rw rw;
> +};
> +
> +struct qemu_plugin_inline_cb {
> +    qemu_plugin_u64 entry;
> +    enum qemu_plugin_op op;
> +    uint64_t imm;
> +    enum qemu_plugin_mem_rw rw;
> +};

Do you still need 'op' anymore here?
It seems redundant with 'type'.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

