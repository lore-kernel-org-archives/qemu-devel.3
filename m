Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065A0C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4M2A-0000tp-8f; Tue, 07 May 2024 10:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4M1w-0000p8-4g
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:43:01 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4M1u-0006Nh-1q
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:42:55 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41b782405bbso22524825e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715092972; x=1715697772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jjhSQNkjeQtumZCCXmYh7ZT/mmpA23TX58VPvX/vMnE=;
 b=Zqzqjni/FoZTwxEJUUloxq/VInZxR4j0GABBMy1SoqtF+BcU10XuV8U69FaB4qJm0i
 dn8jiGzhATPslYgv4sKtAGf8dIQWvVPaDAVt30DVqBP0J7H7B6t4nbshAVzWfyaijkyk
 IW5SNMnHWPFpY2VmphMD3h7FFTtmegu6B04LTTlW14yFo1TLZFpFQ1ZOusJP56M0Zwsx
 at4GF9wE6ijNF3o5cxpwN+kEEmlugzbSJleSk7Mg2QEI/ZOF01k0IMthK0w+dUEbOtMr
 9AkKYeD5qbJ7sFo2p/vvceqT4/Z6LLSgegYsZ6OMSnZgT3qRz/rhnAXC3QzB1FgNsY2j
 iRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715092972; x=1715697772;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jjhSQNkjeQtumZCCXmYh7ZT/mmpA23TX58VPvX/vMnE=;
 b=jpWPO4hBQnfR72FMYAk9UKZmtuFHy5MiIGHNI3O1/cZ+n2iHdW3+fJ2ZDLfXCTrHud
 5e4qYwIIdfx027DMlZz4WG/csYn38ZlLxWK+J8BrNGdpWvJ2ioqrJ47DLHb8smpZPnbh
 M7r+448JxPomgcNvmDtGtTg7OuEVAH0WiENTd8bV2RjQhi50iGHWA/3Y6ghFJaR2p6/k
 44pkecHwVv8DRYCnFzS67cGXV90DN4vcE9k4XrNeV5Sv5704HupgLrZrdDgWQfyZTvNw
 XFKu7XPaNJynBDTNStEPF9lPQCQ8S2miubmNHLlmAtV3acSdyvLryW31+MiBb/Qylli9
 +fog==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8b1l4sVuwK1zQe/SF+EV3jJPXiJXXtBuZ/H6EZWSP1A5N7De7zkWszLgsq8YcOXHgRgcFXl6e6T4seZRe3aP4imJWLcE=
X-Gm-Message-State: AOJu0Yx14lTgNRWEeRWSSJZm1wIuHGZVQrDsI3NyJz0qWS+XsrQKL/jz
 SFKa3bR19t4a+qosNobqnUnlNjWMWcPCLi81WncJ3Uw7HEg7f0CcpsTamfeCbc4=
X-Google-Smtp-Source: AGHT+IH6nxDLXJZP/F19hjLjrOsZYdYpsCucZ/rc//Wlf2POgrKev61WE8pHBzZRDFfVTNfP9F2h9g==
X-Received: by 2002:a05:600c:46c6:b0:41a:2044:1b3e with SMTP id
 5b1f17b1804b1-41f719d627fmr254715e9.32.1715092972196; 
 Tue, 07 May 2024 07:42:52 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.243])
 by smtp.gmail.com with ESMTPSA id
 r9-20020a05600c35c900b0041bf5b9fb93sm20011217wmq.5.2024.05.07.07.42.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 07:42:51 -0700 (PDT)
Message-ID: <04b91274-add5-4855-8989-a4a988750ec9@linaro.org>
Date: Tue, 7 May 2024 16:42:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sh4: Update DisasContextBase.insn_start
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ysato@users.sourceforge.jp
References: <20240506195506.385921-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240506195506.385921-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 6/5/24 21:55, Richard Henderson wrote:
> Match the extra inserts of INDEX_op_insn_start,

Maybe insert here:

(see commit e03291cd9a "Emit insn_start for each insn in gUSA region")

  fixing
> the db->num_insns != 1 assert in translator_loop.
> 
> Fixes: dcd092a0636 ("accel/tcg: Improve can_do_io management")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sh4/translate.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index e599ab9d1a..b3282f3ac7 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -2189,6 +2189,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
>        */
>       for (i = 1; i < max_insns; ++i) {
>           tcg_gen_insn_start(pc + i * 2, ctx->envflags);
> +        ctx->base.insn_start = tcg_last_op();
>       }
>   }
>   #endif

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


