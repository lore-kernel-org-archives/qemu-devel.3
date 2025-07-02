Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B06C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWzGK-0006va-Ab; Wed, 02 Jul 2025 11:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzGA-0006u8-BG
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:20:30 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzG3-0007s3-DD
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:20:28 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2eb6c422828so4927fac.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751469620; x=1752074420; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D28DbDgHnfNf/tYw+qtpEqTnG8anLVbGrbbKzFlQCnM=;
 b=cdpoSymE1DAJeNLbSqE5Abfk9cp5zOEjDP/qgF3nbZjHpwzpdrDV66ojJSvQswn/NL
 ar+cTQQxeUU8wjKd386VAidmneCLXD0dlCBemY/8XkOcQxHCU5xWbGFS/R4gSLvVEIEW
 DeLsxac8eHJTMNks4NANjteiXTJjOF8aTAM0se7tvx1tXC6xeWcC50DjqU6VKjgjNUFW
 bH7XyrSfRj6ccAjmN2wZHtEs2GPJ0TIFPR3pXAX3j9zCBn2YmqooHyswpGX8VAih5PoF
 bQzjYPRqHWH/QphYpwuxS6KNy30OPBGj7qdce+2LTyVkeelikwyQ0n7EwtJlj/2V51JX
 qV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751469620; x=1752074420;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D28DbDgHnfNf/tYw+qtpEqTnG8anLVbGrbbKzFlQCnM=;
 b=GS3UER1NHPgjN3cXYAzj0zKkmIudO3HadhwWQS0vT05EV5PGLttk5axrWCBFxlWqfp
 BKmtWvFxvOfN1fyv58veW3iQs270WPyIJktVBrwD8jkx5EPiCIepSO0IORqnaRgewg9H
 mY92jYCRJtWmy8BAhd/gc83W23alEupm2nz2zh8hJY6H5ivYpvjWuzTR80MzcFGrX+GI
 pbDV8rsjfcjz5mD+mBvWNEkaGmcdeSWWFJ8pBjBLh0QrT3r4mDlO9AkPq/MPLZ7GQat5
 +UzeBOrpL+P3GuP8PCA90Ehmy3m0RY7EuRbc2nQTSEn+qncdx4pprYLss4sVThex5727
 aKsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQNiml6Ybw7O9fKYAWbvHZB4mckK58XQEbhnU7HR9bsmCpKceOkHYC4fqPLDCBk2QVf6mtrnVMwOuF@nongnu.org
X-Gm-Message-State: AOJu0YzPvzsTYpYJ0h70UpnltIkBhPom/7AEmX2AgmSQjK0LYE4um4Hz
 e4Y2V6UGGMUz+SPdHo5vPRjmrOrqeTt9lB8oa0LkTY+HPKz/INiV27sslMmzh91Tl3SmFcX22fI
 wk2lESd8=
X-Gm-Gg: ASbGncuZO/h1l2fgbyV9XfxPF0N7cEaGR1UOS03Ln0LGkBnfHpmUd298hqDus6P5e/M
 uyVrPmBYFx4f0nQUtH7I20wEm/tTpDJhqHJOIu/+7imMV+Yy4w2szT9iolbDeJNXRx0o0msGLM3
 VCJ1MFwPRmcq/16btJWFQD9uTWdRkUq31T2LVFkPRDOt+0g0DdooF5MfmOE+xV28Sz3BHtkAcvF
 YEmba2TOY3dDvFvxpc8QS1+0tEKNQNQ5VQfBkolgihJVlxyqP7U3MNYIDeSwwa1yksLjINU9H2v
 k/Jp4ooMqagCpnJBBDI5QWodZ4hQ1gD8sn+2omrIIiMi5MuostgRpTftCF980ETx/URQIpbQKgA
 1
X-Google-Smtp-Source: AGHT+IEXNdax9hyDxE93KV5cibepbIoRmpKneCwdaczYDZJi8LEUYUYYdU11yJyS8PEmWYeiVnTBlA==
X-Received: by 2002:a05:6870:469f:b0:2da:b440:5b1 with SMTP id
 586e51a60fabf-2f6472a5f71mr2256621fac.5.1751469620318; 
 Wed, 02 Jul 2025 08:20:20 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4eb552fsm3886184fac.9.2025.07.02.08.20.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:20:19 -0700 (PDT)
Message-ID: <5301a330-be07-4cb8-9f2e-83c90e9ffade@linaro.org>
Date: Wed, 2 Jul 2025 09:20:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 58/68] accel/tcg: Factor mttcg_cpu_exec() out for re-use
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-59-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-59-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

On 7/1/25 08:40, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops-mttcg.h |  1 +
>   accel/tcg/tcg-accel-ops-mttcg.c | 16 ++++++++++++----
>   2 files changed, 13 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


