Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A53C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 21:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sihGs-0002oK-0q; Mon, 26 Aug 2024 17:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sihGq-0002nO-Bl
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 17:29:04 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sihGo-0005Lf-TO
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 17:29:04 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20230059241so38709825ad.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 14:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724707740; x=1725312540; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UZgaGrtWdYG9hqPTnzYp4dteoFkvJ92Yn68iMQAe2Q0=;
 b=RyctlTKvyj4oyVTuLdapxOhAA2yMkLhWj3PnZY8ZaKcx2VSucq5Y/PkEuDBhl/PJlq
 kmty5lLmFQhXID2va+KnKdCKuG4kPIW4v/Glsd/Wv/SCmw5r+C1DbfFkRtKz6hadDEf1
 UW/OIpPZS7cTba2UAKY5rcadvx8luCy2x0D4Ohr7O67/NVRiO/uvgbSy12FyWniN80mF
 iYUjMCax/7Wwnohb/vSvnh+f9gxSU9yx6okF1JcjrE4LNZImtFB+txvJcuI7eKZK2Oog
 vjqPl7jW+ZcP+EE4xMebkJfMQx0+szkPbkWkOAeglwFvLWn/caKy23EraSlz/Qol5Ly4
 7XUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724707740; x=1725312540;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UZgaGrtWdYG9hqPTnzYp4dteoFkvJ92Yn68iMQAe2Q0=;
 b=INIK8mpsOEgwaW/NREHlwrGELEDCkxb7FU4uUjkTnejbBrYxtMYkNObcop9PBvr8Fm
 dZmWNMR7IZq9t+IKqire4GbufqG3sm1eAwAzg/6IMZeavxrgiW/i/aCX4b3SE7rkZ58K
 C3qgZdg3U2TljULJMKLum8unOR7b0YvP/KECUTfMBB4+iAIvWjIHo40tpi3rkn+pg+Yd
 ORsao3XZOnIV/LEn/cJLdPwR5CAAEDq4BSIDvx6YIVVbw12bsazzIsX6Cr6Pbh0D2qwk
 Us8xxvQ48+bd0hJogohX9JpHlLqboSbb+bsohG2LnIsmR+V0s0+CrsyTtE7T5xBPALBH
 gsrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUttjT9vqKVyQrhNlD8D60TM5SEggHePKAfQ+BllP9vFWJqwP0AxvPrpYqctP52ZOqYDClBRlc6rEFI@nongnu.org
X-Gm-Message-State: AOJu0YwVQ8+IgoFGW3zlOOiWl765hhqCuyXdHQpdeOdfcHSGdIzDCey0
 Ls3HX10lsO1BshZRBAGEAqUKTT66w5YISeSRtOLSN7blmXEDtLMyp2F420wP3VM=
X-Google-Smtp-Source: AGHT+IFpbPIN2srbbwUAOIceB59Faa43hQ+hODthIGHAi699s/JOaCXq7kzLzcFRWk0ugs0Y9/t3rg==
X-Received: by 2002:a17:902:e546:b0:1fc:6b8b:4918 with SMTP id
 d9443c01a7336-2039e4ef0ccmr97668985ad.41.1724707740370; 
 Mon, 26 Aug 2024 14:29:00 -0700 (PDT)
Received: from [192.168.98.227] ([1.145.75.248])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2038557f0aasm71516445ad.80.2024.08.26.14.28.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 14:28:59 -0700 (PDT)
Message-ID: <ced03178-38a4-4f72-8418-e4a4bcfa21f0@linaro.org>
Date: Tue, 27 Aug 2024 07:28:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/17] bsd-user: Implement RISC-V CPU initialization
 and main loop
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>
References: <20240824045635.8978-1-itachis@FreeBSD.org>
 <20240824045635.8978-2-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240824045635.8978-2-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 8/24/24 14:56, Ajeet Singh wrote:
> From: Mark Corbin<mark@dibsco.co.uk>
> 
> Added the initial implementation for RISC-V CPU initialization and main
> loop. This includes setting up the general-purpose registers and
> program counter based on the provided target architecture definitions.
> 
> Signed-off-by: Mark Corbin<mark@dibsco.co.uk>
> Signed-off-by: Ajeet Singh<itachis@FreeBSD.org>
> Co-authored-by: Jessica Clarke<jrtc27@jrtc27.com>
> ---
>   bsd-user/riscv/target_arch_cpu.h | 39 ++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
>   create mode 100644 bsd-user/riscv/target_arch_cpu.h


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

