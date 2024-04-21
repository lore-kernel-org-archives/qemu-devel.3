Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D445BC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2024 05:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryPvz-0000fg-HN; Sun, 21 Apr 2024 01:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryPvx-0000ZG-EY
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 01:40:13 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryPvs-0002Tj-L6
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 01:40:10 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6f0b9f943cbso1946116b3a.0
 for <qemu-devel@nongnu.org>; Sat, 20 Apr 2024 22:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713678007; x=1714282807; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PwQBYwQawxFNJhePCzL9r4GMXMMI39MpWNvRJNu5+7c=;
 b=Hay0hmg4n3xvTbiROgzLC/4jdFD8jQF/1OFI71Q0a+79bADcHoAFNV9+aVYPCqKwkF
 5aEpzJfBkI6vIi3IVJxeb6jxnTzGCCuUvTDjoPrRkfDCvXRAOj40BZ0UZKfQTL5zRMfY
 QKyWL5XrPOE+fPbjcFNKeOuwZhkiSC81mseW711AqgvcNUCANrUVXiF6H3cDZia+V+57
 lwATN0bpkkuuUYI3FMud1lQUcTh+iQ864375FhyWEO/ZNgaiWb3q1648BQyxhAc6VOZ7
 6XaE7mJ2yKMU0xnVefuOrbFpvacVidEG9AhIuUW5E0wtrB0XfuMppZTkfe6iVFRaI9ky
 oNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713678007; x=1714282807;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PwQBYwQawxFNJhePCzL9r4GMXMMI39MpWNvRJNu5+7c=;
 b=UtSquF/APSUm36SxoRtXNPs+6gdpDCXutiqcZZh6hDLhnp2RTmTMbHrdfBSqpOL2/L
 R0SNuSEMdvoxT5KsHE4jxbvNdDjjrHugn0fbjppP6itTuZ/M9tJ0PymOHXRyn++t6/9S
 cq3l8n9vBowyQefTSWY+QeabcG7RBMHxn26YZhnK8OwjW0m+KJbMEbPZ553xI3fwDclw
 NBLdlblnbWBsBTcnQP3sNNA/zfChGBA+/y2iWfc4dOyyGU1GBE/b3gd/+ODx64Kd8bAE
 JKJuf4E0FbRuX433CE1NpQ45Qpu57labfrr/9isFIzUNGHor4/CY7v2Uv4xvfjzyx8Ri
 +e1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9j3zDDQTEM+dwImKwScAEWt5OwnmabOX6zWcMaGe7+4WGthoow5BcLt0o9/eBV+RxTI7NH/FvmlTiAN9yq1nNW7mHeSI=
X-Gm-Message-State: AOJu0Ywd53cDADLrGHZ1EzeN8hmayPzf3LiEHWBPj11YIs2NLFhCnNSZ
 yptPVgZlZ7VFbNda6F2Iy0t4a0O+xemHprY46mMUIV2e8pQCMQl1ad/fwkTabPg=
X-Google-Smtp-Source: AGHT+IHWEZvvxWISddT1VLSJQvFFHKIikRucpofRAHsOBEeua4xTjfPzshOsCGiQqau3fB18e3wX0Q==
X-Received: by 2002:a05:6a00:10d5:b0:6ed:cd4c:cc11 with SMTP id
 d21-20020a056a0010d500b006edcd4ccc11mr9276668pfu.25.1713678007020; 
 Sat, 20 Apr 2024 22:40:07 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a056a00130900b006eae2d9298esm5639126pfu.194.2024.04.20.22.40.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Apr 2024 22:40:06 -0700 (PDT)
Message-ID: <f397f267-06d9-46c1-8acc-1c9ebf9c3773@linaro.org>
Date: Sat, 20 Apr 2024 22:40:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240419183135.12276-1-dorjoychy111@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240419183135.12276-1-dorjoychy111@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 4/19/24 11:31, Dorjoy Chowdhury wrote:
> +
> +    /*
> +     * Instantiate a temporary CPU object to build mp_affinity
> +     * of the possible CPUs.
> +     */
> +    cpuobj = object_new(ms->cpu_type);
> +    armcpu = ARM_CPU(cpuobj);
> +
>       for (n = 0; n < ms->possible_cpus->len; n++) {
>           ms->possible_cpus->cpus[n].type = ms->cpu_type;
>           ms->possible_cpus->cpus[n].arch_id =
> -            sbsa_ref_cpu_mp_affinity(sms, n);
> +            sbsa_ref_cpu_mp_affinity(armcpu, n);
>           ms->possible_cpus->cpus[n].props.has_thread_id = true;
>           ms->possible_cpus->cpus[n].props.thread_id = n;
>       }
> +
> +    object_unref(cpuobj);

Why is this instantiation necessary?

> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1314,8 +1314,18 @@ static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>       }
>   }
>   
> -uint64_t arm_build_mp_affinity(int idx, uint8_t clustersz)
> +uint64_t arm_build_mp_affinity(ARMCPU *cpu, int idx, uint8_t clustersz)
>   {
> +    if (cpu->has_smt) {
> +        /*
> +         * Right now, the ARM CPUs with SMT supported by QEMU only have
> +         * one thread per core. So Aff0 is always 0.
> +         */

Well, this isn't true.

     -smp [[cpus=]n][,maxcpus=maxcpus][,drawers=drawers][,books=books][,sockets=sockets]
                    [,dies=dies][,clusters=clusters][,cores=cores][,threads=threads]

I would expect all of Aff[0-3] to be settable with the proper topology parameters.


r~

