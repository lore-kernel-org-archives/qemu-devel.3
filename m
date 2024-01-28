Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31575C47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 16:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rU8E1-0005Ft-8c; Sun, 28 Jan 2024 11:41:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rU8Dy-0005Fa-6g
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 11:41:38 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rU8Dv-0005d8-QZ
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 11:41:37 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40ed356a6ecso17213945e9.2
 for <qemu-devel@nongnu.org>; Sun, 28 Jan 2024 08:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706460093; x=1707064893; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sqOqm4ElsKpVefZwKgQtCJ/3q2vSZn90FIKaczBGKQM=;
 b=bcVwIKMzJD2DBr2z/GsPeNpDo39Bzm5lI9jD4KebhQXwBAKYpp0tE2eVbR5ManQ9Cn
 WojkPIcHcJjMRn/4RyVjYpixj16HziExEYM+cVWwSADY9SPgc1D3ZhDjBz1pYAQ7e0QD
 J8zbrfISYvAg6GoaKL6LlIOJnMlFZQz/tfnO+xPttKJj6soTKSZPKjXbXnOg+Bo84sKd
 spgpcB0qU8s4e/ZTiNLOWBUxloLH5ZtmxqwGxmcIAH2ODSqNZVMvVTQsq2dKVlw/nrNg
 f7lVQyWCXjtqdrpW+RJhNRE5/OkbCFfdBfFFwSXy75ZOKSpcNf4KKxKNZXe9crbunoUF
 IMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706460093; x=1707064893;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sqOqm4ElsKpVefZwKgQtCJ/3q2vSZn90FIKaczBGKQM=;
 b=TWgrGuvXlNEDyZvqiKdecCODqHsEgzt7zYCLLMQsTTwS40LvDQoFXMd1rn0WNdK2vT
 q3MX2MqRT9GnxKz21ODRynxMGVftKLH/QsFOWa8jA4SlILF7Y/XFCem5VaQCxq2CyeLq
 /nA9G0Wf565+avtGrKSvchveuq6Af7eYizWmS9zvfjYcxAQ3G5VH4/i1HxUB2PZro8f/
 hy2MgOWOxmvDvK/KZkdmuTgFcRIqfRTX6+b5ElzeEyuK/nTKvofyXbr//yi3gf7Z7o0S
 gywvMSQgZiO34JwYKf8MWCVrXIvldsVSkE3xImb7L+iIZuKQaTqSggp2lon7DAd2Q0qH
 +G7w==
X-Gm-Message-State: AOJu0YxKJxSSODDzpID54/tVxm2OQhfXr9N+aCZnWh720CmL7LjhMNfk
 ysm5SyQesQvpJVFtT6/gT1OqYmXfibSx/mLtvlYs9eS+PsxkZhGmSU7Vo9avlE4=
X-Google-Smtp-Source: AGHT+IH3NNlxwVwRbrYWxlHH863T4jPFqCPOPCn5f+fLxKYUnF3l9dTB7gvoQC/Glt9HfBDRqCjzHA==
X-Received: by 2002:adf:ffd2:0:b0:33a:e5be:792 with SMTP id
 x18-20020adfffd2000000b0033ae5be0792mr2370455wrs.19.1706460093404; 
 Sun, 28 Jan 2024 08:41:33 -0800 (PST)
Received: from [192.168.69.100] (sev93-h02-176-184-17-196.dsl.sta.abo.bbox.fr.
 [176.184.17.196]) by smtp.gmail.com with ESMTPSA id
 v2-20020adfa1c2000000b0033921f48044sm5999416wrv.55.2024.01.28.08.41.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jan 2024 08:41:33 -0800 (PST)
Message-ID: <f322e2fe-81eb-4943-81f2-bf3bb0b37805@linaro.org>
Date: Sun, 28 Jan 2024 17:41:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/33] target: Uninline cpu_mmu_index()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
 <20240128044213.316480-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240128044213.316480-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 28/1/24 05:41, Richard Henderson wrote:
> From: Anton Johansson <anjo@rev.ng>
> 
> Uninlines the target-defined cpu_mmu_index() function by moving its
> definition to target/*/cpu.c.  This allows for compiling memory access
> functions in accel/tcg/cputlb.c without having to know target specifics.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Message-Id: <20240119144024.14289-13-anjo@rev.ng>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-common.h | 10 ++++++++++
>   target/alpha/cpu.h        |  9 ---------
>   target/arm/cpu.h          | 13 -------------
>   target/avr/cpu.h          |  7 -------
>   target/cris/cpu.h         |  4 ----
>   target/hexagon/cpu.h      |  9 ---------
>   target/hppa/cpu.h         | 13 -------------
>   target/i386/cpu.h         |  7 -------
>   target/loongarch/cpu.h    | 12 ------------
>   target/m68k/cpu.h         |  4 ----
>   target/microblaze/cpu.h   | 15 ---------------
>   target/mips/cpu.h         |  5 -----
>   target/nios2/cpu.h        |  6 ------
>   target/openrisc/cpu.h     | 12 ------------
>   target/ppc/cpu.h          |  8 --------
>   target/riscv/cpu.h        |  3 ---
>   target/rx/cpu.h           |  5 -----
>   target/s390x/cpu.h        | 31 -------------------------------
>   target/sh4/cpu.h          | 10 ----------
>   target/sparc/cpu.h        | 28 ----------------------------
>   target/tricore/cpu.h      |  5 -----
>   target/xtensa/cpu.h       |  5 -----
>   target/alpha/cpu.c        |  8 ++++++++
>   target/arm/cpu.c          |  5 +++++
>   target/avr/cpu.c          |  5 +++++
>   target/cris/cpu.c         |  4 ++++
>   target/hexagon/cpu.c      |  9 +++++++++
>   target/hppa/cpu.c         | 13 +++++++++++++
>   target/i386/cpu.c         |  7 +++++++
>   target/loongarch/cpu.c    | 12 ++++++++++++
>   target/m68k/cpu.c         |  5 +++++
>   target/microblaze/cpu.c   | 16 ++++++++++++++++
>   target/mips/cpu.c         |  5 +++++
>   target/nios2/cpu.c        |  6 ++++++
>   target/openrisc/cpu.c     | 12 ++++++++++++
>   target/ppc/cpu.c          |  9 +++++++++
>   target/riscv/cpu_helper.c |  2 +-
>   target/rx/cpu.c           |  5 +++++
>   target/s390x/cpu.c        | 31 +++++++++++++++++++++++++++++++
>   target/sh4/cpu.c          | 13 +++++++++++++
>   target/sparc/cpu.c        | 28 ++++++++++++++++++++++++++++
>   target/tricore/cpu.c      |  5 +++++
>   target/xtensa/cpu.c       |  4 ++++
>   43 files changed, 213 insertions(+), 212 deletions(-)
> 
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 3109c6b67d..4724135f30 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -34,6 +34,16 @@ void cpu_list_lock(void);
>   void cpu_list_unlock(void);
>   unsigned int cpu_list_generation_id_get(void);
>   
> +/**
> + * cpu_mmu_index:
> + * @env: The cpu environment
> + * @ifetch: True for code access, false for data access.
> + *
> + * Return the core mmu index for the current translation regime.
> + * This function is used by generic TCG code paths.
> + */
> +int cpu_mmu_index(CPUArchState *env, bool ifetch);
> +
>   void tcg_iommu_init_notifier_list(CPUState *cpu);
>   void tcg_iommu_free_notifier_list(CPUState *cpu);

I'm kind of reluctant to use CPUArchState in a -common.h header
(except in include/hw/core/cpu.h::cpu_env).

Last Wednesday community call I mentioned to Anton I have a branch
going in the same direction he is taking, and suggested him to wait
to compare and unify our works.

