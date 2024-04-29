Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0370C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 10:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1OMi-0001CM-QZ; Mon, 29 Apr 2024 06:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1OMh-0001CA-CV
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:36:07 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1OMf-0002In-Nt
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:36:07 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41ba0bb5837so18460975e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 03:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714386964; x=1714991764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fM9InGCU6snWGfgvZhrA/Ym9xNPXHBTXHoMKaE0MyV8=;
 b=z01ZAsgN2lqlc0DIvQOXYKlzx10p/Jgmpg82vQ5DIpGKTDyeDq8zyeRtZBZnFnufOr
 x+cEbaffROQbZeaXxSgAINwM/MKbMU5p4BgKeNqTjradvFXRp+QRdVQN0daPV4w87oMs
 ByUKg13IUP2FnDXJ6Ljm7y/MKCuZK15+cNUIkXceM36XPtdLLIOvQibFRweaciNwxOru
 DiTdAZ1xlmJcfyyeM4o1JXbYNfD3h0SU4/u897g1VTiyUDbc8PiKW/Z9Foo6CSiEqXTL
 lbdEfWSTPANJVQ7HlIJNW/Aa4DAxTe4zNwS41LDmx7OeFC+zQbhXx46/bWy2l37lN1aC
 Bzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714386964; x=1714991764;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fM9InGCU6snWGfgvZhrA/Ym9xNPXHBTXHoMKaE0MyV8=;
 b=qsLcSKxLQYSbHNVNltMreVkMompJAvzwtIuNfyxUBRJ7u3HKgvT6Ydeof11FS+vhmL
 KnueNxED71XVAiZoLh9c9vxZkar3OHlwwdnx3xpZCcDoBZ92n6KtDlE3fuhVExXZbksh
 BbhAN64j8iDilx5CKZynuo6k2p/XVUK95kRf2x+C0tzhkDx059MvNjyPW717bVC1JJOp
 K25nJM1k5kUeG2pahqV5VLR0L0f1xisHXSd6Una5LA3fMKrnsoQiLVR9xFh2rH65KfWq
 OBzuUM2W/4yGPBabMTk2gK8jBMo2M/phL/zAFVzqVXsd1H/IyX5hi6u8zGLy0z4ZEYNf
 Hyhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhm4vbT00V4SNxQifLRbdoqsqUTUGfZGQ2tSq9A8TJaYfowpWso0Y5gHt4suhpTEF9WH3dEwmPdDh1LN5KDijBjNE+vGM=
X-Gm-Message-State: AOJu0Yyo5938qhA/gSBZSYhB0tXURQ5XZV/qThvF/t029cPF1Q86emzY
 3OJid5QwOrbpeuJ4PXMq9H8yEQfV2KIGTuYOV4vZoDu1Iac8G4DnnGg3y+kuXYo=
X-Google-Smtp-Source: AGHT+IFphzHECm09b3D59lhCbZNmlrnla7ezYAjQrIIomgk209tdrZkoRWjIziKeO11R4u6QAHjfLA==
X-Received: by 2002:a05:600c:3b23:b0:41a:bdaf:8d6b with SMTP id
 m35-20020a05600c3b2300b0041abdaf8d6bmr7535545wms.34.1714386964071; 
 Mon, 29 Apr 2024 03:36:04 -0700 (PDT)
Received: from [10.79.37.248] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a05600c4f9200b004169836bf9asm44720073wmq.23.2024.04.29.03.36.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 03:36:03 -0700 (PDT)
Message-ID: <84cc7ce7-6a1b-44bd-bf55-ed7460316da8@linaro.org>
Date: Mon, 29 Apr 2024 12:36:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/33] accel/tcg: Record when translator_fake_ldb is
 used
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424233131.988727-1-richard.henderson@linaro.org>
 <20240424233131.988727-8-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424233131.988727-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 25/4/24 01:31, Richard Henderson wrote:

Remove left-over command from commit dcd092a063 ("accel/tcg: Improve
can_do_io management").

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/translator.h | 3 ++-
>   accel/tcg/translator.c    | 2 ++
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/exec/translator.h b/include/exec/translator.h
> index 974cc4f9c4..e92dfba035 100644
> --- a/include/exec/translator.h
> +++ b/include/exec/translator.h
> @@ -72,8 +72,8 @@ typedef enum DisasJumpType {
>    * @num_insns: Number of translated instructions (including current).
>    * @max_insns: Maximum number of instructions to be translated in this TB.
>    * @singlestep_enabled: "Hardware" single stepping enabled.
> - * @saved_can_do_io: Known value of cpu->neg.can_do_io, or -1 for unknown.
>    * @plugin_enabled: TCG plugin enabled in this TB.
> + * @fake_insn: True if translator_fake_ldb used.
>    * @insn_start: The last op emitted by the insn_start hook,
>    *              which is expected to be INDEX_op_insn_start.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


