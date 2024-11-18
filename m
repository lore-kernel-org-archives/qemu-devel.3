Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F01BD591AC
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 18:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD6BP-0006Ig-9I; Mon, 18 Nov 2024 13:09:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tD6BE-00064g-Jz
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 13:08:59 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tD6BC-0000Ga-Va
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 13:08:56 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-71e681bc315so3165906b3a.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 10:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731953333; x=1732558133; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x3YKLWEoJEZiugqOIoMw/A1yWG9hG0NaybisXoLZs+E=;
 b=hNYEoaBNPcRUttvvZ/hz+XiAJW61AxfCAC91ShkpCiELzZvPw0b73+c6PZBKpOPbVZ
 rDzFBraO+5FknWssDOEatOmvmkilIMjB3nBlugLScpJc49NIxT4wnyVBD3XxXS9fMwaj
 xB4L67YNvGUsECKOVJZHJSHU9FnZfKOwjv8SJfGdQn5QJVkFtC5Eg1WYwNlD6UOoY/a3
 WaCOhVqIGL+F/y7GyrMHLaMKdrN+d7DDpnl4cQ7ZuGgTeOquQEC6IWnA3ehmJVkguDfl
 Tccz4x2aPKK4+FJbGf3NPCU7li6P1aYDLmmrFYB9sG9wV1NmUSBriSopYc/iyKAk/Uwr
 LXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731953333; x=1732558133;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x3YKLWEoJEZiugqOIoMw/A1yWG9hG0NaybisXoLZs+E=;
 b=f5dT9n1mwK7NLuBUNAt5M23896aftb22YrzVvf7aB0JdDSlR/nKQZh+R8mzOVyj0x1
 L9g87FT7bnaxEcE55M+b/TmsB/rtBBirsSWVkbeZfDdXCWmm83IPhjLAFHQdfZglGN2e
 cyWJN9s7oDRe4y/BczPBSTDHeUQv8LaEW5ufAFpHD0io1GTUmXcZBN5ghs6kqMjLoHwq
 UPm/Lty/ZTbTjNV33H8YkATlmRnxlOMnMc6xyHdbNssmPBnwQmaHsYz/gO23i6qHwPqH
 fLz7ZjWOOcKLnEq/4/651cKVErvQJq7yk7XbdRtEGO7D+jSguV+Bf0oS7Wi1ddrc6J4q
 10Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBub2TI5UzR5dMpYI5SYWHui1cn+zqJomZys3OOCDA8lLvjWJdJvj9ARSAMSH375AMNOokHmgNsbyN@nongnu.org
X-Gm-Message-State: AOJu0YyQZGuGvkjl8/0L++m8bF8v+BcaTltVP1p7tUfBYcmYciqh4HvL
 RHsvPK22JSewo6XRvJh+Q8vR6HGL4RBh2nW7QsNOS+mEIGqdbbDvAHaB1MBZ4Bk=
X-Google-Smtp-Source: AGHT+IG417VHxS7RIxyQFfbi6me5I1FcMH9npQ2Atc+Xp9iyS/1HVZj5SOAX1Bh8/faIhoHSnM9NgA==
X-Received: by 2002:a05:6a00:2d1c:b0:724:6c21:f0c with SMTP id
 d2e1a72fcca58-724af8f8a24mr412479b3a.4.1731953332682; 
 Mon, 18 Nov 2024 10:08:52 -0800 (PST)
Received: from [192.168.0.4] ([71.212.139.183])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724771ffd76sm6555962b3a.177.2024.11.18.10.08.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 10:08:52 -0800 (PST)
Message-ID: <9993f4ae-2a3a-4b5c-b2b2-3ebb59d9b098@linaro.org>
Date: Mon, 18 Nov 2024 10:08:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch: fix alignment error in tci.
To: guoguangyao <guoguangyao18@mails.ucas.ac.cn>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn
References: <20241118133243.291769-1-guoguangyao18@mails.ucas.ac.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241118133243.291769-1-guoguangyao18@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 11/18/24 05:32, guoguangyao wrote:
> Add alignment and check for fpr in
> CPUArchState, fix alignment error in
> tcg interpreter when executing LASX.
> 
> Signed-off-by: guoguangyao <guoguangyao18@mails.ucas.ac.cn>
> ---
>   target/loongarch/cpu.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 86c86c6c95..f955f9f618 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -302,7 +302,7 @@ typedef struct CPUArchState {
>       uint64_t gpr[32];
>       uint64_t pc;
>   
> -    fpr_t fpr[32];
> +    fpr_t fpr[32] QEMU_ALIGNED(16);
>       bool cf[8];
>       uint32_t fcsr0;
>       lbt_t  lbt;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> @@ -487,6 +487,7 @@ static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
>   
>   #define CPU_RESOLVING_TYPE TYPE_LOONGARCH_CPU
>   
> +QEMU_BUILD_BUG_ON((offsetof(CPULoongArchState, fpr[0]) & (15)) != 0);
>   void loongarch_cpu_post_init(Object *obj);
>   
>   #endif /* LOONGARCH_CPU_H */


