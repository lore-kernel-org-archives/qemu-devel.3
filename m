Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95F7C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 15:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNDrJ-0007kf-Sm; Fri, 28 Jun 2024 11:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sNDrF-0007jM-T4
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:49:53 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sNDrD-0006Kh-AO
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:49:53 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f6fabe9da3so5056745ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 08:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719589789; x=1720194589; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lLSjeWFz/Etjndhrd3Mp6CK9MIuDbD5+XHj4tyTFEAk=;
 b=DsfX8U3zG4DybP4Af2cgO5dXHpdY+PXx7GfQ8CvnRB0nlDaEe7oNIalgi0Sq39Fahx
 16ljJXM6Rn4yz/FZtSyAGY1ROMgIv1yz/cuEP1aNAfTK1i+2/VYEvnhCDu79vZ7fswYe
 JPlIuusrf8lU8rd3LcXJz7XQOikSDwAAvzbHhvfz4CrxA1fFOXKdVKwm+mVl+aSxzeni
 fUmvFG4IQdwk4W0kqwIpByOD2EBwAD3mDjdNuHGUSM8XjbDcW4oeZDRI3x1joKVen4Qe
 WpYAyFAMhOydTeh7lMJD23wwUXACpJ2vCNcIs6bETjkOt00IHMYFG7FBKIGFs/IadsvZ
 N9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719589789; x=1720194589;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lLSjeWFz/Etjndhrd3Mp6CK9MIuDbD5+XHj4tyTFEAk=;
 b=aOcc6fuYeQm4Ono0u48vKzovTNbn9ohNZJCJJEkPIq9uVKfUcB7qEev6T14/bIbJlq
 HHSjXbF5J784E8W6jmrGmBa24PT/V6E8GdgvfklpdymhqMiBt2QzpaVcCZL9EjGBtnLt
 ls39LlaAJvMZw+8MSJKhSZMn1vDVDBEVHCpyP4saqvbbgl5RPOpzEpYbhZa8A0LLgR/4
 uWU9lj9tx/+Nmq3cKGqlWL5b/Rs/y3ar/q/qmwGyWr2x3j7zEaRzYNxPtpeOlQ+ogDDC
 Yb0HN6Fua188cd4E3ag/hiSB4v4AQHcn/vHyMUeyU3iYQ/i8tKIYL0bsIkpMSavJ6W/d
 Indw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3jJapqDMwLfH3sTALkPZkjeJLiOkPSalC1jCxhYQRolbP1u45ZhVgrWGnnoRpdEKxSb7PgPiWRJu+kgD4i5q8UUm3ak4=
X-Gm-Message-State: AOJu0Yyc0nMEwmmUxM4Hdq+z5EOBHO8gJagtvijO4AOZCm74lfVzz6zu
 3GogdDmMwN0v9XzfL9L0UX7O7AtzRvne1Nw0dKMkbA9YzGpDFqhE6XnhF2jlDTE=
X-Google-Smtp-Source: AGHT+IEiq3ED360YLpSgaf9uNfqunV7q5ZtNvOGDuxk9S8fnuuZeF/crnoveQjshm3aOmWBLiCQ/qg==
X-Received: by 2002:a17:903:1cf:b0:1f9:ef8b:7eb1 with SMTP id
 d9443c01a7336-1fa23ec6523mr174093955ad.16.1719589789358; 
 Fri, 28 Jun 2024 08:49:49 -0700 (PDT)
Received: from [192.168.0.102] ([191.205.218.108])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac10c9059sm16912185ad.49.2024.06.28.08.49.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 08:49:49 -0700 (PDT)
Subject: Re: [PATCH v6 06/11] target/arm: Factor out code for setting MTE TCF0
 field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org
References: <20240628050850.536447-1-gustavo.romero@linaro.org>
 <20240628050850.536447-7-gustavo.romero@linaro.org>
 <18343152-c677-4075-8c55-9a2802742a79@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <790bf46c-bf01-b8db-2030-af669cd98c49@linaro.org>
Date: Fri, 28 Jun 2024 12:49:44 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <18343152-c677-4075-8c55-9a2802742a79@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.965,
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

Hi Phil,

On 6/28/24 4:08 AM, Philippe Mathieu-Daudé wrote:
> On 28/6/24 07:08, Gustavo Romero wrote:
>> Factor out the code used for setting the MTE TCF0 field from the prctl
>> code into a convenient function. Other subsystems, like gdbstub, need to
>> set this field as well, so keep it as a separate function to avoid
>> duplication and ensure consistency in how this field is set across the
>> board.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   linux-user/aarch64/meson.build       |  2 ++
>>   linux-user/aarch64/mte_user_helper.c | 34 ++++++++++++++++++++++++++++
>>   linux-user/aarch64/mte_user_helper.h | 25 ++++++++++++++++++++
>>   linux-user/aarch64/target_prctl.h    | 22 ++----------------
>>   4 files changed, 63 insertions(+), 20 deletions(-)
>>   create mode 100644 linux-user/aarch64/mte_user_helper.c
>>   create mode 100644 linux-user/aarch64/mte_user_helper.h
>>
>> diff --git a/linux-user/aarch64/meson.build b/linux-user/aarch64/meson.build
>> index 248c578d15..f75bb3cd75 100644
>> --- a/linux-user/aarch64/meson.build
>> +++ b/linux-user/aarch64/meson.build
>> @@ -9,3 +9,5 @@ vdso_le_inc = gen_vdso.process('vdso-le.so',
>>                                  extra_args: ['-r', '__kernel_rt_sigreturn'])
>>   linux_user_ss.add(when: 'TARGET_AARCH64', if_true: [vdso_be_inc, vdso_le_inc])
>> +
>> +linux_user_ss.add(when: 'TARGET_AARCH64', if_true: [files('mte_user_helper.c')])
>> diff --git a/linux-user/aarch64/mte_user_helper.c b/linux-user/aarch64/mte_user_helper.c
>> new file mode 100644
>> index 0000000000..8be6deaf03
>> --- /dev/null
>> +++ b/linux-user/aarch64/mte_user_helper.c
>> @@ -0,0 +1,34 @@
>> +/*
>> + * ARM MemTag convenience functions.
>> + *
>> + * This code is licensed under the GNU GPL v2 or later.
>> + *
>> + * SPDX-License-Identifier: LGPL-2.1-or-later
>> + */
>> +
> 
>    #include "qemu/osdep.h"
>    #include "qemu.h"
> 
>> +#include <sys/prctl.h>
>> +#include "mte_user_helper.h"
>> +
>> +void arm_set_mte_tcf0(CPUArchState *env, abi_long value)
>> +{
>> +    /*
>> +     * Write PR_MTE_TCF to SCTLR_EL1[TCF0].
>> +     *
>> +     * The kernel has a per-cpu configuration for the sysadmin,
>> +     * /sys/devices/system/cpu/cpu<N>/mte_tcf_preferred,
>> +     * which qemu does not implement.
>> +     *
>> +     * Because there is no performance difference between the modes, and
>> +     * because SYNC is most useful for debugging MTE errors, choose SYNC
>> +     * as the preferred mode.  With this preference, and the way the API
>> +     * uses only two bits, there is no way for the program to select
>> +     * ASYMM mode.
>> +     */
>> +    unsigned tcf = 0;
>> +    if (value & PR_MTE_TCF_SYNC) {
>> +        tcf = 1;
>> +    } else if (value & PR_MTE_TCF_ASYNC) {
>> +        tcf = 2;
>> +    }
>> +    env->cp15.sctlr_el[1] = deposit64(env->cp15.sctlr_el[1], 38, 2, tcf);
>> +}
>> diff --git a/linux-user/aarch64/mte_user_helper.h b/linux-user/aarch64/mte_user_helper.h
>> new file mode 100644
>> index 0000000000..ee3f6b190a
>> --- /dev/null
>> +++ b/linux-user/aarch64/mte_user_helper.h
>> @@ -0,0 +1,25 @@
>> +/*
>> + * ARM MemTag convenience functions.
>> + *
>> + * This code is licensed under the GNU GPL v2 or later.
>> + *
>> + * SPDX-License-Identifier: LGPL-2.1-or-later
>> + */
>> +
>> +#ifndef AARCH64_MTE_USER_HELPER_H
>> +#define AARCH64_MTE USER_HELPER_H
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu.h"
> 
> NACK. See my comment on v5.

Yes, I saw your comment in v5 about it, I haven't ignored it, I just wanted to
publish v6 updating the parts we reached out a consensus.

So,

>>>> diff --git a/linux-user/aarch64/mte_user_helper.h b/linux-user/aarch64/mte_user_helper.h
>>>> new file mode 100644
>>>> index 0000000000..ee3f6b190a
>>>> --- /dev/null
>>>> +++ b/linux-user/aarch64/mte_user_helper.h
>>>> @@ -0,0 +1,25 @@
>>>> +/*
>>>> + * ARM MemTag convenience functions.
>>>> + *
>>>> + * This code is licensed under the GNU GPL v2 or later.
>>>> + *
>>>> + * SPDX-License-Identifier: LGPL-2.1-or-later
>>>> + */
>>>> +
>>>> +#ifndef AARCH64_MTE_USER_HELPER_H
>>>> +#define AARCH64_MTE USER_HELPER_H
>>>> +
>>>> +#include "qemu/osdep.h"
>>>
>>> https://www.qemu.org/docs/master/devel/style.html#include-directives
>>>
>>>    Do not include “qemu/osdep.h” from header files since the .c file
>>>    will have already included it.
>>>

I thought you meant osdep.h should not be included _at all_ in my case, either
in mte_user_helper.h or in mte_user_helper.c. Maybe the wording in the docs
should be "Do not include "qemu/osdep.h" from header files. Include it from .c
files, when necessary.".

I think we agree osdep.h is necessary and must be put in mte_user_helper.c. But
that left me wondering how it would work for sources including mte_user_helper.h,
because it can be the case they don't have the declarations for the types used in
the function prototypes, in this case, for CPUArchState and abi_long types in
arm_set_mte_tcf0. It just happens that gdbstub64.c, that includes this header file,
actually includes osdep.h at the top of includes, so all good, but how about other
types not provided by the osdep.h, they would have to be included in the .c that
defines the function (in this case mte_user_helper.c) and also in the .h that
includes the function prototype (in this case gdbstub64.c) anyways, which is the
case of abi_long type, which is not provided by osdep.h, for instance. Luckily,
gdbstub64.c also includes cpu.h, so for abi_long it's fine also, but is a tad odd
to me. Anyways, see my code suggestion below.


>>>> +#include "qemu.h"
>>>
>>> "qemu.h" shouldn't be required neither.
>>
>> If I remove qemu/osdep.h CPUArchState can't resolved. If I remove qemu.h
>> then abi_long can't be resolved. I'm in a tight corner here.
>
> Does it work with "exec/cpu-all.h"?

It resolves the abi_long declaration, yes, but then it fails to resolve MMU_USER_IDX.
I think one level up of include works, so how about cpu.h? cpu.h works.

So, how about:

diff --git a/linux-user/aarch64/mte_user_helper.c b/linux-user/aarch64/mte_user_helper.c
index 8be6deaf03..a0e8abd551 100644
--- a/linux-user/aarch64/mte_user_helper.c
+++ b/linux-user/aarch64/mte_user_helper.c
@@ -6,7 +6,9 @@
   * SPDX-License-Identifier: LGPL-2.1-or-later
   */
  
+#include "qemu/osdep.h"
  #include <sys/prctl.h>
+#include "cpu.h"
  #include "mte_user_helper.h"
  
  void arm_set_mte_tcf0(CPUArchState *env, abi_long value)
diff --git a/linux-user/aarch64/mte_user_helper.h b/linux-user/aarch64/mte_user_helper.h
index ee3f6b190a..07fc0bcebf 100644
--- a/linux-user/aarch64/mte_user_helper.h
+++ b/linux-user/aarch64/mte_user_helper.h
@@ -9,9 +9,6 @@
  #ifndef AARCH64_MTE_USER_HELPER_H
  #define AARCH64_MTE USER_HELPER_H
  
-#include "qemu/osdep.h"
-#include "qemu.h"
-
  /**
   * arm_set_mte_tcf0 - Set TCF0 field in SCTLR_EL1 register
   * @env: The CPU environment


Cheers,
Gustavo

