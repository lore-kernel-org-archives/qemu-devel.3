Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7863CCD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 22:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX5KS-0006kO-Or; Tue, 09 Jun 2026 18:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX5KG-0006cU-CP
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 18:53:40 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX5KE-0005o9-70
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 18:53:39 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8422a92b6d6so3234930b3a.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 15:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781045615; x=1781650415; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bix95w6wyKbo5l8Fq3BebeqByC+zcspubXm/BONPVs4=;
 b=rN2tsKSxOalkBJhMzTKELp3Cgbs2gShjn1YB/14JDdEQMFVbDZdQy2QqJPFjZ6BcqN
 qVL5YIavUmkbPN7JE423VIX9XX3n7x9+ripv0Y4z1cr7W/WmcRKjQA1qbubjBJZ8c/xf
 3Ggh6a1GrpvCKoPI+EzehbPMJmXDaEa9UajhECsKf26pKFNnx0fFmltKQqkQz/t8wUIB
 LfuPSUFXPUorSUAdVjghZTuaTmTZn+W9+5HsNS8roK58Kx+WpWHWiz1+1YQzR5h85Nr/
 vHkrNY6J8EoWp+vrwxF3qfvFTFlgn7V50dqluu6eZevmZW5FHyBC/yMSL+DlkROzPf/s
 Ydmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781045615; x=1781650415;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bix95w6wyKbo5l8Fq3BebeqByC+zcspubXm/BONPVs4=;
 b=TqAHRgPjKhCK3p56eJAqtygrgbBbaSbnJed2iP+Rg8m7bxNRsp8ZcQIgjCgxedMB55
 a5MHRSXMTZpOlh5ApmtlvNuFWvEQuRXkgFuVqPT1dDQbLApymWV9L7XIjfWYjBxxuNky
 zFSFDy+7WnXNOQMqS5EFttzFZfoJP7JvsHXG8jsMgsDcu717Z3AlBxdj5DXehoelTkO0
 Bl9DpNw0mXXi2zvxxSgKX+hwQKCTFl+OgAF0P7FMdQnC7Og5WxbqzaixF+BdayxZWyWi
 aYOapdvASFxW1zqCko/hpS5SJ9vEzeHLe282M1zFcYEU5zkocaW0N6Jfh2KSycCbsNnA
 8FsQ==
X-Gm-Message-State: AOJu0Yz06xbm2+EvPYOr2206mGvBboDYNPID/1sP1Qc2qmJ3jOwMBO1d
 e+6nmnJmwDU+OlhIxBLW4UsvDu+z7xCVSqB2vSsRTnev7osyUDlU/Shx/rjM8B8VUDWozBQ2vcy
 b5Z3G9fM=
X-Gm-Gg: Acq92OEt2Xi4jCZ6cbX3XyUm9nASSeGXD9qJFpdxNfCPnff00Ta1gX7XWYb1Hn4i9AC
 WQDOzgYa+pvvtk0Jq4lPi4E/EYCwqrzsVN638zs5z5szKuV9qW7WZAI4mIjbRNZpfmNZTShFJIa
 yXt9XVgK5LBpaEdFztAoQgGPWbDAhwnBImeUPXNfNcpg0Sq9g111KbPQQ2O7pVDCLiea+XQN5yy
 NbrfT6O/MExRNsvj0YN2LctBavr4+Zl5Eole/vcQGJSSxYjKyTyZHez9muanD+STLDghY4qRkgZ
 PaMNNvTdx9j3j+GC68aDkvhFXqYG8GcDETSGxVrOtcMUpAkApq6pj3QhuVsMm4YbjDRg1be2No4
 ZjKv1inuKgEpJz6eQcVL2JYZNtgUlzpCOdu6AD2mPzqqa7vgZDlTGHI0P5b320PIm2l1tDiL7wm
 D+NWUhuAW1NK+CvgY19dGbusf1EGsB4iTUeigX1s2I4hKmvSJODQWJ1EFJhg==
X-Received: by 2002:a05:6a00:4295:b0:842:5bc8:ccf7 with SMTP id
 d2e1a72fcca58-842b685cee9mr16476600b3a.34.1781045615000; 
 Tue, 09 Jun 2026 15:53:35 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-842828e21c8sm26870216b3a.49.2026.06.09.15.53.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 15:53:34 -0700 (PDT)
Message-ID: <c293bc4b-930c-4514-ae97-9b83f5224adf@linaro.org>
Date: Tue, 9 Jun 2026 15:53:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Implement /proc/cpuinfo for ppc cpus
To: qemu-devel@nongnu.org
References: <20260609220929.83951-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260609220929.83951-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 6/9/26 15:09, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> I've tried to mimic what I've seen on two debian porterboxes (ppc64 and
> ppc64le), which are running via KVM/QEMU. I assume the model type of
> pSeries and such doesn't make much sense for some older ppc chips, so
> any better suggestions here are welcome.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: qemu-ppc@nongnu.org
> ---
>   linux-user/ppc/target_proc.h | 38 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/ppc/target_proc.h b/linux-user/ppc/target_proc.h
> index 43fe29ca72..fa965c0e69 100644
> --- a/linux-user/ppc/target_proc.h
> +++ b/linux-user/ppc/target_proc.h
> @@ -1 +1,37 @@
> -/* No target-specific /proc support */
> +/*
> + * ppc specific proc functions for linux-user
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef PPC_TARGET_PROC_H
> +#define PPC_TARGET_PROC_H
> +
> +static int open_cpuinfo(CPUArchState *cpu_env, int fd)
> +{
> +    int i, num_cpus;
> +
> +    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(env_cpu(cpu_env));
> +    DeviceClass *dc = DEVICE_CLASS(ppc_cpu_get_family_class(pcc));
> +
> +    num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
> +    for (i = 0; i < num_cpus; i++) {
> +        dprintf(fd, "processor:\t: %d\n", i);
> +        dprintf(fd, "cpu:\t\t: %s%s\n",

There are extra ':' here.  Should be

processor	:
cpu		:

not

processor:	:
cpu:		:

> +                    dc->desc,
> +                    pcc->insns_flags & PPC_ALTIVEC ? ", altivec supported":"");
> +        dprintf(fd, "clock\t\t: 3425.000000MHz\n");

Why hardcoded?  Is the clock not accessible to user-only?


> +        dprintf(fd, "revision\t: %d.%d (pvr %04x %04x)\n\n",
> +                    (pcc->pvr >> 8) & 0x0f, pcc->pvr & 0x0f,
> +                    pcc->pvr >> 16, pcc->pvr & 0xffff);

There's quite a bit of decode of pvr for maj.min in the kernel.


r~

