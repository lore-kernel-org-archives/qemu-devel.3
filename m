Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A074C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTAkX-0000FE-DG; Sat, 21 Jun 2025 22:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAkW-0000C8-7v
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:48:04 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAkU-0007Rg-Hn
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:48:03 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-748e81d37a7so1866577b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750560481; x=1751165281; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=21ihWKbjO+Zvuiu1/dzZIg0sa2Rl+NQdA7gph3CEY+w=;
 b=wYhJ/fqoBsKYVi9KrWA893ybmRqFWTjBxlaT2QKZLA9LcNHz2mL71v3AP0JIqTE+TD
 W3zfIFpFCjNnjUDiKE9gV0o1PzQaa1lsNGzn96SDyKgh3zisPHZ3Ieh8SxZL5RjvCkOq
 QX1HsOohOStMvbYP5w3VQk3LEC9wjtoCTkMvo49emr/kE2/nJoVLC1419NejF2HR6na3
 LcIWrupA8gYdM4l4APs3j8i9ZchduB4nBEFnnxqtMFKHWxEyTFcHLxOzhh70VGXdq/uM
 rWd/+UmuY1BIFSSWsesnnw406yV+4KVsyvfZzffTSfmZ2oLK6mxijKd6WjTeozY2dfwq
 DiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750560481; x=1751165281;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=21ihWKbjO+Zvuiu1/dzZIg0sa2Rl+NQdA7gph3CEY+w=;
 b=nGKQMZlIkWSXr0A60v8c8iGfbeqcJZXzByf2UKMkHdutZk5sbVeHyf+o2jWF+XU1To
 N5FAPgQ2a5P2Dt+KnZn3MH3pdNQXgxSdof+rE5x4Du0ehvKQVS/csXk3Tk8/Qeb+XsdP
 ddOLoBClHewY+nzeRona1pBqBkJCQrqzmd0h/ItrncfOvtbIcEiAPtP3L0udR+yif903
 eJsP/iehw03sjX/jXhtk/yNx1dDB6qwoF4Hy/hjf8VGQNOYhD5H6PQjkohXRnAMrsw4w
 cvf/Y+RZwTYW3kUFQDnmngzMkIanOX4pIKfvnKbImd9zS+D/1MamtTBghMoBXF5yQ9Zw
 16CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTVjqeBopht/THE2E+wlywc+0Ii19qZO9cI3p1G1G2ff6Gr4S2XbpS5PWrFtn7t+wh3GsY42kwQTPD@nongnu.org
X-Gm-Message-State: AOJu0YwF+5HZMjxzEbL+5w9rsMsclED++foKiQjTwx/fZa4MG/7sPG5J
 imCR2WdAOBNz7b8h7QTfs3EtSnutIO2CAlToKgWwUX2VYN5gEGLgy8rmuAinmntQ0iE=
X-Gm-Gg: ASbGncsMylzEWVli9u6FqbxSw4NHs7C/pESSz841CPqynLZgOm1P/1rmejFTLumsrHW
 1Kd62rERfCnMEesi3gqg7Ed42wnnIOchYuoz80dZxmGREuFKDKvtlfdDcSMVocLDr9ss1Le+lWk
 PDiFAUigniTmL61Vr0y7f3fYur4qB/DiTebmeG89ziaj9XVHTzOtaB7dKyaxAmm/DTMzqlvJxaw
 6VyMHeLoUVEgd2y3xee7q6AaX+Y0nmdX+re/I8RWaHNyQrtU4EtKLUd3unGqJhKOLHCiU4wJDu8
 nmqXE4iuSyV83zLrDu016ZQIi/kEftFptfqNi0g9vcwvMyPfIEf0Zr4C191lL1PgejQ1aIn0kd6
 W1zAnQ/B5Ji2IsL/Va2OFankcJr0v
X-Google-Smtp-Source: AGHT+IH8EBawHGQ8SGyQFOr/2OyD4ultvAFSwpxo+oVsMADORgjYl3L/KwrDEb0u+LgU8u0aczFpGg==
X-Received: by 2002:a05:6a00:a87:b0:736:8c0f:7758 with SMTP id
 d2e1a72fcca58-7490d7abc7bmr9234412b3a.10.1750560481067; 
 Sat, 21 Jun 2025 19:48:01 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a621ceasm5376548b3a.97.2025.06.21.19.48.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:48:00 -0700 (PDT)
Message-ID: <36eb59d6-6346-4ba6-91b2-72de12342d84@linaro.org>
Date: Sat, 21 Jun 2025 19:47:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 15/42] accel/split: Implement
 synchronize_pre_resume()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-16-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/split/split-accel-ops.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
> index 6b3ddf21a17..65feb929404 100644
> --- a/accel/split/split-accel-ops.c
> +++ b/accel/split/split-accel-ops.c
> @@ -175,7 +175,17 @@ static void split_synchronize_pre_loadvm(CPUState *cpu)
>   
>   static void split_synchronize_pre_resume(bool step_pending)
>   {
> -    g_assert_not_reached();
> +    AccelState *as = current_accel();
> +    SplitAccelState *sas = SPLIT_ACCEL(as);
> +    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
> +    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
> +
> +    if (hwc->ops->synchronize_pre_resume) {
> +        hwc->ops->synchronize_pre_resume(step_pending);
> +    }
> +    if (swc->ops->synchronize_pre_resume) {
> +        swc->ops->synchronize_pre_resume(step_pending);
> +    }
>   }
>   
>   static void split_handle_interrupt(CPUState *cpu, int mask)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

