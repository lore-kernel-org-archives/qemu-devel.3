Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E88C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWx8-0006PG-S0; Wed, 22 Jul 2026 09:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wmWx5-0006LE-NG
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 09:25:35 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wmWx3-0001GT-SC
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 09:25:35 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-475417f010dso7180241f8f.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 06:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784726731; x=1785331531; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AyJNZsOQSrsXajtXHSxh9uMxVQmxpbqD8AJxt9yc8os=;
 b=l1LDnyrqOQyd6BFGJ/O9pVNcqAWCaAH4mkfsZape/uzpaRSTDQZUYXlyWfIuCVx6KL
 uHsr6pMpQMwAnUKI9wBAMw6d51kWkDqd7l17zhINYP/+rwgB6dHw+tBZpQYWrtMffMeQ
 TfrtDaYm8Fd6eClIk1GKLEjeRtTqZ0QEAxdVllmB6VeL/3gAb5LEJ7Z2WkM4m+0k0ISq
 FsuYJjitDyDmMFgYtrDr/iRusaNYl6ZR43Q9OcKHuIkAXBCw5wzugs2u38S1aP54PEiS
 ulGldfylRwcLzOnaOIs2rgx5c3qXwQNx9+hRISAFctqgtvO7ou4UuzDaRKCmxEIyX76z
 ZrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784726731; x=1785331531;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AyJNZsOQSrsXajtXHSxh9uMxVQmxpbqD8AJxt9yc8os=;
 b=m8pq8vzqXZYK44MHfzi/P3puK/zFjSpASFVggHGxBFFi/d8lnfYrzYE2W9GLkIVvjq
 61rZZFd/FJgJM4JYILsZYemr3bMA9pusrCGSYifIzvOLUpqbVUT0jM5P41iz7XAjPyrP
 7vR4TysdTexL6Lr5hasL2x0cN8ipigRgCd3CFnJKoHmmVlKO8A5//moRhe1vHlho+wto
 xasvsGgEFw6E7dzZYNha1v/jcTfPcvQoJNbKmdD/h5FW795IOfKDEsgJlv1IL4+bl+h8
 TyhGwWDyUAjhiFGObTC+cbmWugH/qKNJAL/ISd5eL2SMMrNcyZdMEoig84yuv2ocYEaE
 t6Ow==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0HQ4O/2c+R1zuQAfDFQKzTqBuihTWGJIuhg0m4yd1ynA8ckPjpEA1ALZcfBE6fJa7u7YEVTb18RlP@nongnu.org
X-Gm-Message-State: AOJu0YwrU7p9EyTrPheTVE/6FHhC/MAL/VhIWoBdJmF0aJIQv3OAYwm/
 zDzEn3oUdZaZ3no8JYHCt11DA0wzcHR8XtBVKjZO0m2TQ3JxVTvqwi2L57K68e4TSjc=
X-Gm-Gg: AR+sD13d9axzku+/jGFzIH6sb1kDpm21kUXl/tVJoUepfz4dSrLckH4HRdPlSStoMpt
 hMm5tWOvPNOG92i09vmCin+4qE0tSDmWoZ6ruof556WpZyZcXu2FlsidYERCiJNPtmaeW+RAEHz
 a3/C7eijAmAQg1uW52KELHNY3ZIh5hrmZ3sUiAjkRSJqw/i5nKR4yFn4774rU5uFvCUyaN+NQ50
 zXR6vxrDMOnrimHZqvKFlAP9rcBXnRENY1Suc8P1M4wFxz7C9wYoIPjAmCpHIfNisCLu7a60a+l
 Jyrrhs/vaglw08DzvnDW4gHHMySvzSHEOtbvdHwZ894UtNBw5Ec9V3RTGFfFxXOx4xkJZr//nwl
 RBroAcBRUq4oYgcEDTG+t2/HAmWDcg6Z2SjSDC0lss1nnwPhPWrtzshHDsOI8w9whL/0TPw3WJy
 Xxi+5Ja4itTvX/
X-Received: by 2002:a05:6000:2f84:b0:47d:ec60:657e with SMTP id
 ffacd0b85a97d-47f623376femr25719255f8f.39.1784726730474; 
 Wed, 22 Jul 2026 06:25:30 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5a2sm6616016f8f.7.2026.07.22.06.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 06:25:29 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 756A85F7DE;
 Wed, 22 Jul 2026 14:25:28 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PULL 20/71] target/arm: teach arm_cpu_has_work about halting
 reasons
In-Reply-To: <90bbd0b0-dce4-4945-8ad9-96c895e712ed@oss.qualcomm.com>
 ("Philippe =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 22 Jul 2026
 13:07:29 +0200")
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
 <20260610161202.2235298-21-peter.maydell@linaro.org>
 <90bbd0b0-dce4-4945-8ad9-96c895e712ed@oss.qualcomm.com>
User-Agent: mu4e 1.14.3-pre1; emacs 30.1
Date: Wed, 22 Jul 2026 14:25:28 +0100
Message-ID: <87a4rjrwaf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> Hi,
>
> On 10/6/26 18:11, Peter Maydell wrote:
>> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> With the advent of WFE and WFI we need to pay closer attention to
>> the
>> reason why the vCPU may be sleeping to figure out if we should wake
>> it up.
>> Create env->halt_reason to track this and then re-order the tests so
>> we:
>>    - ignore everything is the vCPU is powered off
>>    - wake up if the event_register is set and we were in a WFE
>>    - otherwise any IRQ event does wake the vCPU up.
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-id: 20260529082948.363931-3-alex.bennee@linaro.org
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   target/arm/arm-powerctl.c  |  6 +++---
>>   target/arm/cpu.c           | 40 +++++++++++++++++++++++++++-----------
>>   target/arm/cpu.h           | 16 +++++++++++++++
>>   target/arm/internals.h     | 11 +++++++++++
>>   target/arm/kvm.c           |  5 +++--
>>   target/arm/machine.c       |  2 +-
>>   target/arm/tcg/op_helper.c |  3 +++
>>   7 files changed, 66 insertions(+), 17 deletions(-)
>
> This patch updated TCG and KVM but missed HVF and WHPX:
>
>  - target/arm/hvf/hvf.c
>  - target/arm/whpx/whpx-all.c

Do they need it if they implement cpus_accel->cpu_thread_is_idle?

>
>
>> diff --git a/target/arm/internals.h b/target/arm/internals.h
>> index 21cbd2b1db..b2035b9417 100644
>> --- a/target/arm/internals.h
>> +++ b/target/arm/internals.h
>> @@ -2063,4 +2063,15 @@ bool arm_cpu_match_cpreg_mig_tolerance(ARMCPU *cp=
u, uint64_t kvmidx,
>>                                          ARMCPRegMigToleranceType type);
>>     +/**
>> + * arm_set_cpu_power_state() - set power state synced with halt_reason
>> + */
>> +static inline void arm_set_cpu_power_state(ARMCPU *cpu, ARMPSCIState st=
ate)
>> +{
>> +    CPUARMState *env =3D &cpu->env;
>> +
>> +    cpu->power_state =3D state;
>> +    env->halt_reason =3D state =3D=3D PSCI_OFF ? HALT_PSCI : NOT_HALTED;
>> +}
>> +
>>   #endif
> Why not add/use a getter()?

How do you mean? Add it as a CPUClass API? Seems overkill for what is
currently handled internally by Arm.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

