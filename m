Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4F5C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 20:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXS9S-0000Rv-0E; Tue, 06 Feb 2024 15:34:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXS9Q-0000RD-Qp
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:34:40 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXS9P-0007k1-EK
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:34:40 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d958e0d73dso9074255ad.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 12:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707251677; x=1707856477; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CEt5J+6LdVSAOxfzeXKE68Kf+C7F2HF5Hao2SVqblEY=;
 b=VNmmyxGxm4SJUjNGv2jCGC0rFnTXqqNuPBefavhRdaz+EXFVnSk+Nkmj41ZKxdvXlA
 P38m2bCcCF8EqfEpF60LjZswpt4DSTHFj7Ia8teLCRejSz35FH0LDZKmU5Iqr3RpLJ50
 fWykQkTgVqe0jKThCrluNCEAIdIZ412G+KPsf0tMa9Ph5TUsV1Be925xzNqtMdzQ8fES
 y9l7nJvPiY5je1XiNiKYvde7BrCXm5/JRt8oeFNg+n+LPDOln49+pov5rE/h57KH5bsD
 LifmmvAtPhXn+z99if30W5dhCKHqkccRdBaAHxmICKhtao0Hx9p4Q6HlvRg9+4sXeq2R
 GkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707251677; x=1707856477;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CEt5J+6LdVSAOxfzeXKE68Kf+C7F2HF5Hao2SVqblEY=;
 b=Ttqqte7FGn44r3JHVJTAy4nJARsA14M5TRH/NAUaWHLBnyXIOFOdeG6z03Du/dOT7F
 ejGrCx5Wlfkp+XX2sZoi+Tfv2N1giX/jnJcx8w7i9AqKpLOuILICWuibDFQ1Q+ld1l+1
 CP/FOGX/Li6akEpCRcguBb++7B+SLzxrSDzuSl/CrSFyTRPKyVLiO27IwMYhmAAT2zqq
 W2o3iuZfmpHPP/F0r+KIjdEpANxXmYfThdXyjWV2CblucSR/qiIWcgtBtHBAIf1k/kQ9
 V7XvGF95IKAIQQl30wVM8USPHXnlYc2ZfQZm6NLxVx5UUN0Uc+EEqMrdrnSAOKDF0Hvs
 LSJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoGeNZ3I3jAkBkBib5ETHCE5fjYjD1BR9+DNEx8UWor2J+YSfs9XelNzNqG2rFZvCdEE25xmJU0e6s4toCLNElY6r2FS8=
X-Gm-Message-State: AOJu0YznsR4Npe2owFaO5eYbEEEfAIMYBeGDVZjBivHBCsMKZ8E0S3hC
 vEJk7aoWY/FAkRI1gmnInEU7j+qyENrpLwiyYsRvl2ScgkvVZJoOz20QSXzt7hM=
X-Google-Smtp-Source: AGHT+IE03q38kJL8e0SROEanYSdLzSJQoEYPc1Pb+CvVRCxFWlWdcPsZyVr46xg204aOUwnyOc0Myg==
X-Received: by 2002:a17:902:d546:b0:1d9:e181:51b0 with SMTP id
 z6-20020a170902d54600b001d9e18151b0mr3139225plf.23.1707251676904; 
 Tue, 06 Feb 2024 12:34:36 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCU6Hmf4JzgodANkiQ+nRr44uH98gYpw4wNEoyDOCJcb/GfiiJXzMJ7vvHVhZafvGbxsFxTRm5/eYkL7VkuJKb5y0ZB7DvqIsEx1XGOx6xPqGiGTyTtTd7JjhgY=
Received: from [192.168.0.100] ([43.252.112.200])
 by smtp.gmail.com with ESMTPSA id
 kx15-20020a170902f94f00b001d8f82c61cdsm2297697plb.231.2024.02.06.12.34.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 12:34:36 -0800 (PST)
Message-ID: <768c7884-1a59-461c-a810-4f8a89d4bfda@linaro.org>
Date: Wed, 7 Feb 2024 06:34:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] target/arm: Use new CBAR encoding for all v8 CPUs, 
 not all aarch64 CPUs
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240206132931.38376-1-peter.maydell@linaro.org>
 <20240206132931.38376-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240206132931.38376-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2/6/24 23:29, Peter Maydell wrote:
> We support two different encodings for the AArch32 IMPDEF
> CBAR register -- older cores like the Cortex A9, A7, A15
> have this at 4, c15, c0, 0; newer cores like the
> Cortex A35, A53, A57 and A72 have it at 1 c15 c0 0.
> 
> When we implemented this we picked which encoding to
> use based on whether the CPU set ARM_FEATURE_AARCH64.
> However this isn't right for three cases:
>   * the qemu-system-arm 'max' CPU, which is supposed to be
>     a variant on a Cortex-A57; it ought to use the same
>     encoding the A57 does and which the AArch64 'max'
>     exposes to AArch32 guest code
>   * the Cortex-R52, which is AArch32-only but has the CBAR
>     at the newer encoding (and where we incorrectly are
>     not yet setting ARM_FEATURE_CBAR_RO anyway)
>   * any possible future support for other v8 AArch32
>     only CPUs, or for supporting "boot the CPU into
>     AArch32 mode" on our existing cores like the A57 etc
> 
> Make the decision of the encoding be based on whether
> the CPU implements the ARM_FEATURE_V8 flag instead.
> 
> This changes the behaviour only for the qemu-system-arm
> '-cpu max'. We don't expect anybody to be relying on the
> old behaviour because:
>   * it's not what the real hardware Cortex-A57 does
>     (and that's what our ID register claims we are)

Not even that, because max resets MIDR.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

