Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEF6F94CBE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 22:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFgDJ-0006gC-GZ; Wed, 22 Apr 2026 18:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFgDH-0006g4-Vf
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 18:38:31 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFgDD-0005HI-Qg
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 18:38:31 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2b45cb89f7eso40008065ad.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 15:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776897506; x=1777502306; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hmLzuVW1/xw3Uea85BR5uvUGO4gmHcmYevHTf9PXHZo=;
 b=aFP7W4HmvmRzPAg7q05cQAq3v7wkluOWxfKrOgGg3Yobcovv0bPGVehojrKoUqD4aJ
 vCP69A2W6TrXnQ8k5RWsZiDaPp+7m8e0wUetOP096j+XoFYthwswEIZi2NELPuQ95UBK
 Vv5vBl9JqXXTyMke125GfMD0hPYXncfk/H9DQ4P23yTBDdCFtY/V0lZEgF3VbnnjTgp6
 04G/D8mh58Gfu5jixDzWYin3oFc0er+/pHaZXwrHe04JFgO3Y1evMcu59lBd8uZjVOj1
 SlbmJcI5YNztjNKh8CAeEyOdKP6UZegAldZwrZbTJrYw129+8jIX56WZ2wzyBC/1+jOh
 xxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776897506; x=1777502306;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hmLzuVW1/xw3Uea85BR5uvUGO4gmHcmYevHTf9PXHZo=;
 b=YaCW7/HWqc+xIFRFIg6Wd+79wXoL6rr9Id6OAyRf6vyWJ64b8nM4tkG7KBE3HNflZf
 gCVmm1XZ/hEwJ5KbXSJ1HWIAFEB6t5iH5J6NxSvhXfYXqsrkMpLjpTBZwqgdmK6P7B0b
 vysxLbeTD1hYg2Wv+NmF+j2duizmyQAR7QBVhCDq14JIPSPQSUy9Ev4rqil9oVv19HiI
 VrTMsJSTe21eLEvQoQXZ2AOZCYCm/3Pg3dhcYH6B6eH3zzGT2HEgyuzcYWdG4w+EK8fg
 jaJFfZUXSytKLhOa5uWSa0BUiGzTeeG3cj2A8tm4p7EX/eYJUp38+rwNU0zXtZPNL80c
 PXiQ==
X-Gm-Message-State: AOJu0YyfhCPyeE+LVmC7IX8+cmo3EAkwP89oy5N3CG1fBe0pFk3nQvs9
 VfJNvdmmTqacpRFPXeV3NDGBOM+2T6tcNiIMxfjpVTolILG+D4lnMTPxVBeA0dlk+zeYNf8pMtu
 uCYiPfAU=
X-Gm-Gg: AeBDietxZi5cvfzkznPCW21yuIWbFq8C+WABQJ7Bn0GGulOZb21QTEfqlnnFsRcR153
 P6/b0FXgAIgZ6+Y+P4m0gHJZgc8yXTqpOLxQAMfwybmWSyyLi3s/rktqMRwRbsvNzDB3DgQ8jGB
 so8T68fJMRiXyYSxusnN5qIB51g3yekg6j0AUAT97qdrIVRgrtKvk2u4Vy+HZA4o6NO5MEr0f3U
 KlaN6C8CwAqMybQKp6bjv7TY9esh0tA8TwfuehZkpKJrE2AwkNLDdDlW9H+8knUG2EPHEvBYg95
 YyWUHw9EqW0xYPKwWJAHitKJZNC2VH6K4sN0yoPL8TsvbiHjtTuh2L2RKJ0ElvUlVhkXT/YtwPQ
 pOFLX7xGHYtEOflFrIo2fa5U3+WevPbHGswreWjrMEYh0zxDJ4swzriQT9s8KtmSu+NvCKtn0L2
 ikKzITp9jmOh5j/JqCuL6Wz0K20WpslHUpVZ21xUpHJ83ks8fXtspYcR81Awmd
X-Received: by 2002:a17:903:1a83:b0:2b0:61c2:8e83 with SMTP id
 d9443c01a7336-2b5f9f36f53mr244440115ad.20.1776897505441; 
 Wed, 22 Apr 2026 15:38:25 -0700 (PDT)
Received: from [192.168.1.134] ([110.239.0.232])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab3ac1fsm185161295ad.70.2026.04.22.15.38.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 15:38:25 -0700 (PDT)
Message-ID: <18c98e81-6149-4406-ac59-f718290f5cc5@linaro.org>
Date: Thu, 23 Apr 2026 08:38:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 28/32] target/arm: hoist event broadcast code into a
 helper
To: qemu-devel@nongnu.org
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
 <20260422125250.1303100-29-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260422125250.1303100-29-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 4/22/26 22:52, Alex Bennée wrote:
> We will shortly call it from more places.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/internals.h     | 19 +++++++++++++++++++
>   target/arm/tcg/op_helper.c |  9 +--------
>   2 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index dc593f1fec8..089f679ac0a 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -682,6 +682,25 @@ bool arm_is_psci_call(ARMCPU *cpu, int excp_type);
>   /* Actually handle a PSCI call */
>   void arm_handle_psci_call(ARMCPU *cpu);
>   
> +/**
> + * arm_broadcast_event: set the event_register for all PEs
> + *
> + * This kicks all PEs which will up which are waiting on the event
> + * register.
> + */
> +static inline void arm_broadcast_event(void)
> +{
> +    CPUState *cs;
> +
> +    CPU_FOREACH(cs) {
> +        ARMCPU *target_cpu = ARM_CPU(cs);
> +        target_cpu->env.event_register = true;
> +        if (!qemu_cpu_is_self(cs)) {
> +            qemu_cpu_kick(cs);
> +        }
> +    }
> +}
> +

This is pretty heavy-weight to inline though.
More comments on usage for the next patch.


r~

