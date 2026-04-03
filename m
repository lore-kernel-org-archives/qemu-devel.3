Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA43FE88D68
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 21:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8mB7-0006Tp-HT; Fri, 03 Apr 2026 17:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8mB6-0006Th-Fc
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:35:44 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8mB4-0005F2-U1
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:35:44 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c70f91776fcso866989a12.0
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 14:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775252141; x=1775856941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ndx0up5CpcMwLnp/yDvyOMQs3vzA6ogm2gRKvfvFcrE=;
 b=o4nnbwTPpeekKt7wpgb5kupFaPdxYxbj6mme3ArD1J3dFBsN7gJAZIUr/M6SZ4+yOm
 6uGjU++IwJenvSJ3Czp11PYneYV8PycX/XWYwoes4njWmLpXhEnUlEqqn83EMrcBRTh3
 Rp3RMl4cEhF/3uvnkkpoLnsBb3jy2tJxr6b58fe5bDWafVRJ4g17BqeKF8Apzg35PVOY
 5Zg4usWaPxfBUMVqNc7O93rB5pKInCqdIRaIezEVczwfZX3YKdp1cuEado149Jzhil6F
 /oDrbCZBKQBYLoMAejSv1MjmD77/PEkQNmHtuadxlWpbKLR9z+GZLBDyWlsDTyBfLojg
 ZMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775252141; x=1775856941;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ndx0up5CpcMwLnp/yDvyOMQs3vzA6ogm2gRKvfvFcrE=;
 b=Snc+ugfkNHFq8/Nxx1KEJc5xSZC1fwEyGv3bu9JyttT9FMQe45wobiL7dhtk1C+tEm
 V9gwgoG7GhMzkPFhC1Dis2YsstAaFacUVLsDeOZ+RnRciFCka7o1mUa2ZYImLONbQU0j
 z81wfj9JVa6d4dDF7kEli/xuCDKdHGdAlKJnAYhUkUxfS96phzb0+aUuEOn9RshI2zNk
 rC5SSfmGViVz7uCC9aDTLY+5yYMwZ6HVIH73s9iuYUpqG3oVU6AiLChwD8diFpPz8YfZ
 apqTjPIuUYo/u4dXlPCz0jHBxWBbx6KrRHaJBeIMb4DbK7pVTBsvWd8tLF1MssIuHhJ1
 iqzQ==
X-Gm-Message-State: AOJu0Yy595odZEDih10POtVDFkUHInLjbiNfHo0ltY8+4DGUzLBaImLZ
 YcHVxyxrSerkI/soccV7wFNCfqqiIZn7YgNtC8UpU9VjLtGL6O9DwqqI+YzkNQcMR/YBXosRGOI
 DDZN2dAo=
X-Gm-Gg: ATEYQzz/y2KtZjppwSSGCtmSPUWygamkV2NdwQitm6yTyKjaXel/5dAtJfcQMGktREg
 TPss1cqKAkkkx1Jgm0C1sZOR0z/4vrEHd+bHMeQdCLM9OPRSohSptUiaQj09SpvTJcpLEKXzjUQ
 0vdNct4xJt6OjNnzQ5rWhtEF+boY8dBUyo5McAyZfRMcxbq4QLym5jfuj0YK343X+u44mi1MOrl
 tp/B8H02iu92BQ/BWxfiN9VkLxH2wk3YtVfvCkpwSBgPQetvWx06L+snOKtHQ+iFBsVHaxyI3rn
 dCkpOGvDsGC+r2szWEH37PcaLhJqdQ4OXxZBLxNWNUZJgFSzfvy0jV+hN6FVxDeNXkQHADxlvIU
 9oU7K3Rj5kT965MYKsotXA3EZ5OWEITfiOcXu+hZrTRg77lTSh3lrcVTDAo5AUWqDMdAKOAcZzD
 jGZZdmbNozTRUm84GJ21A+UchdZigR+fUadmmOTtAr+FFXEdLGK9HarbcRIwo4ZjRugjU=
X-Received: by 2002:a05:6a21:3283:b0:398:9662:10ff with SMTP id
 adf61e73a8af0-39f2eda28b2mr4396566637.4.1775252141293; 
 Fri, 03 Apr 2026 14:35:41 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c65935cbsm6064299a12.26.2026.04.03.14.35.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 14:35:40 -0700 (PDT)
Message-ID: <6d54c78d-0a65-4b89-8672-cc3c965d8763@linaro.org>
Date: Sat, 4 Apr 2026 07:35:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 8/8] target/arm: Compile KVM as common object
To: qemu-devel@nongnu.org
References: <20260401201753.92290-1-philmd@linaro.org>
 <20260401201753.92290-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260401201753.92290-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 4/2/26 06:17, Philippe Mathieu-Daudé wrote:
> Neither of kvm.c nor hyp_gdbstub.c use target-specific code.
> Move them from arm_system_ss[] to arm_common_system_ss[] to
> compile them once. The arm_system_ss[] source set ends up
> unused, remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/meson.build | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/arm/meson.build b/target/arm/meson.build
> index f14debc6a2f..1b5d346d474 100644
> --- a/target/arm/meson.build
> +++ b/target/arm/meson.build
> @@ -1,7 +1,6 @@
>   arm_ss = ss.source_set()
>   arm_common_ss = ss.source_set()
>   arm_common_system_ss = ss.source_set()
> -arm_system_ss = ss.source_set()
>   arm_user_ss = ss.source_set()
>   
>   arm_common_system_ss.add(files('gdbstub.c'))
> @@ -19,7 +18,6 @@ arm_common_ss.add(files(
>   arm_common_system_ss.add(files(
>     'arm-qmp-cmds.c',
>   ))
> -arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
>   
>   arm_user_ss.add(files('cpu.c'))
>   arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
> @@ -39,7 +37,12 @@ arm_user_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
>   arm_common_system_ss.add(files('cpu.c'))
>   arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
>     'cpu32-stubs.c'))
> -arm_common_system_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
> +arm_common_system_ss.add(when: 'CONFIG_KVM', if_true: files(
> +  'kvm.c',
> +  'hyp_gdbstub.c',
> +), if_false: files(
> +  'kvm-stub.c',
> +))
>   arm_common_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
>   arm_common_system_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
>   		                 if_true: files('common-semi-target.c'))
> @@ -67,7 +70,6 @@ else
>   endif
>   
>   target_arch += {'arm': arm_ss}
> -target_system_arch += {'arm': arm_system_ss}
>   target_user_arch += {'arm': arm_user_ss}
>   target_common_arch += {'arm': arm_common_ss}
>   target_common_system_arch += {'arm': arm_common_system_ss}


