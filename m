Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50260C02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 18:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYUDt-0002SB-6z; Thu, 16 Jan 2025 13:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYUDo-0002LQ-UF
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 13:04:03 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYUDn-0006zy-El
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 13:04:00 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso22814325ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 10:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737050638; x=1737655438; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8kgC30jazF4cfvpxwVBnAORcmR3M1RTBERKmQy8MHbg=;
 b=J90elZaCbkhLH0sg3qEqkzbwdPth+pV1uLNtDXL2emNu/jtCjw8nVnt+mI6ycPhT1e
 b0ltwrzNMuQsKCEr/09jhGTMzVkHhdfynZPkC/7dG/VOANBPBXW1jWjo3kwlipvXKRXA
 pQ0reP3K8noP1oJzGwQVrcmD9UjrX4RdO2Km4z/br2M3w2W1VBx9tiOXjD7Qx+RbnnyW
 LgXXxDdQ9TTBr4EpNGUOsggqqNQWDQekQEYt3g8T4nKFktxeOjlqgpZiH70pEjDbhf1g
 8uDUK2SmKyhbd5Q/WzI7NTk/ueE5ukXhq42uHM/Qi1vuEQIXE5e1dxFTV9a+OXa/tK06
 R6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737050638; x=1737655438;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8kgC30jazF4cfvpxwVBnAORcmR3M1RTBERKmQy8MHbg=;
 b=CwPSfrP7IAiIfsuFdm189XQ2DWZgeDCoaAgPogsh3kvsh3w61skLenCfyawMDgYFKK
 96p3RQNShs9rVZanmLThbGfiggwQ4vwlCg1hLkngHKe3o7p9CJRXrD0Z1UlZqIpS9NH6
 a0IcjTNJ7VJLEARIlyTwg4xbtQ0v8u/2+9Y6Dgrf1ByWzkitpKMZ0CxRcj6JDaqXROtv
 hmsW4EWZ4W9FHkmqPmQbWgnEwNHEQJnXsHxrmJeGs8FX0g9hEclhpyhKrIU2SN7oZK0G
 YWeSIfjCy9z1GYq6jLRABUIK8uWARWpFSI30q9NlDn2N0Q4pxI03EJoSK2ciRmQ8KCbl
 U2sQ==
X-Gm-Message-State: AOJu0YylvfNyX9Ef1ZskOGErDyYMkdX/TFqT8aRe2z/N801ifMuygy9M
 yemDiFZz8chfCK/I980UP3V1YZyEE6MP/woyTj6uY5wCe0ckd3uY7omH+BmwZY3dwztgoi1pHfy
 H
X-Gm-Gg: ASbGnctFQkCULWlE7EF+NUKYqoYGIYgr64SQcqMZESY+CseNw4c+mm/gOB80U1pydFJ
 wxJNph5lw805rkc1MuQ5tT9tQPArm5JxXX3IgY2OvzeGkqvOmnry48DFBqe2SgSu13uRRSxMgwO
 NIQrX9DU85hwOFKfLe5nK68fUcZ3pWNORvf/I/LF8s7oz+Of22Ech9GufYNx/xtE79ewFmeuVu6
 AS/TNtB3EpMnfIy3eB4V07Ux2U82/+dQ49OOdFXoPXg1T20lcs3/dRIqNsfFcgnLKLWeZzIaWjC
 DQYcvctsZsOMunGsXpoKiCA=
X-Google-Smtp-Source: AGHT+IENgYBnoLviiHTKt49a+q8kYnrUlgdqTZiTq0nLflIpahVTmIFxV+iM9dKVW6DOejRz6ic3mg==
X-Received: by 2002:a17:902:db09:b0:216:5556:8b46 with SMTP id
 d9443c01a7336-21a83fd96e7mr581163695ad.49.1737050638199; 
 Thu, 16 Jan 2025 10:03:58 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2cea2014sm3106775ad.41.2025.01.16.10.03.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 10:03:57 -0800 (PST)
Message-ID: <059bf00e-52dc-48a7-83a7-16057e421920@linaro.org>
Date: Thu, 16 Jan 2025 10:03:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 12/13] hw/arm/virt: Remove deprecated
 virt-2.12 machine
To: qemu-devel@nongnu.org
References: <20250116145944.38028-1-philmd@linaro.org>
 <20250116145944.38028-13-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250116145944.38028-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 1/16/25 06:59, Philippe Mathieu-Daudé wrote:
> This machine has been supported for a period of more than 6 years.
> According to our versioned machine support policy (see commit
> ce80c4fa6ff "docs: document special exception for machine type
> deprecation & removal") it can now be removed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/virt.c | 11 -----------
>   1 file changed, 11 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index f15d6f230b4..d22b445fe99 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3528,14 +3528,3 @@ static void virt_machine_3_0_options(MachineClass *mc)
>       compat_props_add(mc->compat_props, hw_compat_3_0, hw_compat_3_0_len);
>   }
>   DEFINE_VIRT_MACHINE(3, 0)
> -
> -static void virt_machine_2_12_options(MachineClass *mc)
> -{
> -    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> -
> -    virt_machine_3_0_options(mc);
> -    compat_props_add(mc->compat_props, hw_compat_2_12, hw_compat_2_12_len);
> -    vmc->no_highmem_ecam = true;
> -    mc->max_cpus = 255;
> -}
> -DEFINE_VIRT_MACHINE(2, 12)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

