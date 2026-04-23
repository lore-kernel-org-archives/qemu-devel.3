Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC90FC0360
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 16:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFwaa-0004dk-45; Thu, 23 Apr 2026 12:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFwaR-0004cX-83
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 12:07:31 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFwaL-00012h-Bm
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 12:07:31 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so88012345e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 09:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776960443; x=1777565243; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yfAiObZ3/L7bbfA/Mc+v8ngsTTi9idV92oVHEVsd0y4=;
 b=fuU5euylkvXtFkbGvX2fU3mObLjgEcbAF4i7dJke4haT0hGBTfq+APKfCb9vyeN69h
 7Lnq+8U9a9KWEDjpN3PQiuFLMTomS5+b9Ng3Y0Y6Z+u94kXFxkL0TJ5JhUuPzsMzpu9n
 WB5txdzGoKRdRRoGpGmjBuohikxY/T0A5FrOTrGQRiClEvagbudEfQF9R/Ko6PotNqfH
 gHr1RLQhpq5AV5p6ybW5ZnDFg+CrHcSYMYQJpfdC/iW6tAjhDa7ApELqjG094CGsTP6r
 3Qp1EWQb+9YgwOFKlp6HN37B0jZjaxh3GKtKHN2pObOG8nF1zZ/AvC8di7puBT4RfRTS
 Vdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776960443; x=1777565243;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yfAiObZ3/L7bbfA/Mc+v8ngsTTi9idV92oVHEVsd0y4=;
 b=Q+kMDIkZ94mzId9oRR24Bo7WszLppY7AS5kSNI6XYoEkuZ4s2rGNVRl1IJRegkG4Cw
 uzk5OEzSa/8k9cW0lIXnXx25dvbIeGgafRuFdFV5ZImKHDjh3mxAdWIjKZQp3lf7wtYv
 Ua0qiXGeX2q5ssMEslEWfkUz9vxJN3D9bOg4DzqGlcdiIIcvxCo4QZiO6qr8K7M2cJuY
 Ki2VnyU+McziYsHNpkc+hwk9UU1jWSjZguCzaIwm66a1ODr1+dj4/fZmPF47j3/SHkvy
 FVVJmuOl4RxR94CBGrxgz7GOU0j3C5cooN+3ylEmWidBLjOBHCigMSBGAxphQXfN/p2q
 01/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8CWaNEyC5Z386uaGtcWgjKPTAOA+XOW10DmroCzjG7STJ/CoOcht8UX5WwGR1SH25YtbGLilOCuTge@nongnu.org
X-Gm-Message-State: AOJu0YyQk3FzcMIJxiihHNUCar2xzIStOcS/aCGLyGoCjHa/P4wPjSXS
 +gYzDyjXM7Tyx2374BAPhUPJScVhjCO0XD1Qlh2jp+chhTKslWQlG+cY4/rFNrwd9sE=
X-Gm-Gg: AeBDieu6peY8qbvlfkcglyKMldysMie8O2bMXuvW9UsknXJFpjIrHSUkXiF8EUNB8rD
 NSkdoKMrBCIJkut3kSx5syCDvcptqM80tBsJZdCjN8+z7Y0BqkFPUfQsZa78/+j/MBIHTvpxJpj
 shxrrCsNiBtCd+2zYHmYP7PJt28Jse3Tegd96aIL4mCMR5q4FSfPf8l5iFS4tgzMn4rokqHK9Tz
 nPiVInuJMIF+MvVXxopTSaj09JUmviUVMiU4ZVwhsnxpp2Qi+ivfdWP0i/+p2w/TVMdD1EQHdvV
 xPAexB+luOT0DHi+14+55CXK9tkpFJiMRbv75hfMvL+Tu0kN2kAIJF0nw04/AziOnU9Yx3uaGG4
 uYK1/zT8OxB2uba/u0Z6VWYpU/fubPRaTS9LbCuzKQJJDpTdJ5Imwf/HzByeFaS7M2WrEbpoK0g
 2r4f6OY2kVe1yNsK47NL76qM4kujhBTHGBYvESC6xK9MfessC9O/AVlcz+6/+/BgLihAM8PxaYO
 OzyygbIqr8nMzo=
X-Received: by 2002:a05:600c:a108:b0:488:a82f:bbb4 with SMTP id
 5b1f17b1804b1-488fb78a0famr339935395e9.26.1776960443293; 
 Thu, 23 Apr 2026 09:07:23 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-489207ebd3asm144467295e9.6.2026.04.23.09.07.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 09:07:22 -0700 (PDT)
Message-ID: <c7fcf10d-f5d6-4ba9-8258-5e510eaaabe7@linaro.org>
Date: Thu, 23 Apr 2026 18:07:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 13/15] hvf: arm: physical timer emulation
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>
References: <20260316130642.13246-1-mohamed@unpredictable.fr>
 <20260316130642.13246-14-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260316130642.13246-14-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/3/26 14:06, Mohamed Mediouni wrote:
> Enable this through leveraging TCG's physical timer emulation.
> This allows nested virtualisation to work with a kernel-irqchip=off + GICv2.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   target/arm/hvf/hvf.c | 28 +++++++++++++++++++---------
>   1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 88d4732fbf..33fdd9705e 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -189,7 +189,9 @@ void hvf_arm_init_debug(void)
>   #define SYSREG_OSDLR_EL1      SYSREG(2, 0, 1, 3, 4)
>   #define SYSREG_LORC_EL1       SYSREG(3, 0, 10, 4, 3)
>   #define SYSREG_CNTPCT_EL0     SYSREG(3, 3, 14, 0, 1)
> +#define SYSREG_CNTP_TVAL_EL0   SYSREG(3, 3, 14, 2, 0)
>   #define SYSREG_CNTP_CTL_EL0   SYSREG(3, 3, 14, 2, 1)
> +#define SYSREG_CNTP_CVAL_EL0   SYSREG(3, 3, 14, 2, 2)
>   #define SYSREG_PMCR_EL0       SYSREG(3, 3, 9, 12, 0)
>   #define SYSREG_PMUSERENR_EL0  SYSREG(3, 3, 9, 14, 0)
>   #define SYSREG_PMCNTENSET_EL0 SYSREG(3, 3, 9, 12, 1)
> @@ -1719,9 +1721,15 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
>   
>       switch (reg) {
>       case SYSREG_CNTPCT_EL0:
> -        *val = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
> -              gt_cntfrq_period_ns(arm_cpu);
> -        return 0;
> +    case SYSREG_CNTP_CTL_EL0:
> +    case SYSREG_CNTP_CVAL_EL0:
> +    case SYSREG_CNTP_TVAL_EL0:
> +        assert(!hvf_irqchip_in_kernel());
> +        /* Call the TCG sysreg handler. */
> +        if (hvf_sysreg_read_cp(cpu, "PTimer", reg, val)) {
> +            return 0;
> +        }
> +        break;
>       case SYSREG_OSLSR_EL1:
>           *val = env->cp15.oslsr_el1;
>           return 0;
> @@ -2015,12 +2023,14 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
>           env->cp15.oslsr_el1 = val & 1;
>           return 0;
>       case SYSREG_CNTP_CTL_EL0:
> -        /*
> -         * Guests should not rely on the physical counter, but macOS emits
> -         * disable writes to it. Let it do so, but ignore the requests.
> -         */
> -        qemu_log_mask(LOG_UNIMP, "Unsupported write to CNTP_CTL_EL0\n");
> -        return 0;
> +    case SYSREG_CNTP_CVAL_EL0:
> +    case SYSREG_CNTP_TVAL_EL0:
> +        assert(!hvf_irqchip_in_kernel());
> +        /* Call the TCG sysreg handler. */
> +        if (hvf_sysreg_write_cp(cpu, "PTimer", reg, val)) {
> +            return 0;
> +        }
> +        break;
>       case SYSREG_OSDLR_EL1:
>           /* Dummy register */
>           return 0;

Modulo the hvf_irqchip_in_kernel check, this reminds me of
https://lore.kernel.org/qemu-devel/20250620130709.31073-11-philmd@linaro.org/
;)

