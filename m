Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C810F94CB6
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 23:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFKSB-0003pJ-WA; Tue, 21 Apr 2026 19:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wFKS8-0003oh-4J
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 19:24:24 -0400
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wFKS4-0006Uv-VW
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 19:24:23 -0400
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-2de831d2b20so444544eec.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 16:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776813859; x=1777418659; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ScxLFJmTTrijIZGbaLxvISlXmaRGqu/BCc1A9gOVpw=;
 b=N5w4IT+h7ezfMkTSWHHHCX51Bfep0lmRajKH4SiAibVWrMfgmK9S0Z7K144ns5Ioiv
 ZtWmk2lz2uIzIrdxdQhQbcbH4KpinVIueB7CYtsuWgAF69tHM8GvWHjhLdle/MwIFwl0
 zwidFErkHJZTTttwQBFhbqG/5swoyusdLZxW7nYJlVTn01abjOQtLhBj7jSox1ad5kwY
 n/zcPEzmtWCM6qKhlq8BcNk7ydBJD7QD+atNqwNkVmA2JG3KWcqoW8AGLn6qwutDi02U
 +5FmewmhIZ2SuOTK3OWJyrO1JPGpG6xReDkRNG8OQaUrENoQgdTg9BzxX7QPyqH3kepc
 lsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776813859; x=1777418659;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6ScxLFJmTTrijIZGbaLxvISlXmaRGqu/BCc1A9gOVpw=;
 b=roAInnE4pOPL7SUk0aO5ogogpguiJaZFAQppvVLK+eMzWIKl4TyQBH2tB3WtjZSDMy
 Mu67X4f3YzAwzRYD5i9qdWGZl8cEdA1ulS4vQpoA1S5M4FC6yUSPdS/OiuYG4rpvlKPi
 rTwxjhQe6ac95XxbHbSqQ/T2otIXm8Am9ELpA54EL5qXwYzzr1IU0m6y+AVmYj/pvd4+
 znvcCrPKh1OtvApPtP8qKsoVbvtqX7rMr7ffPvFfVGIms9XxwLETRgX4l8RTdQI8OGcd
 rjAKyqtmDkQkwfsD6eavHi8OBCUwvgdy/pn6QfKHESs3Ajf6M2HVAbwzgq5ZNqrTWtT+
 KGuQ==
X-Gm-Message-State: AOJu0YyVLJflhkqYrM0SefjsflYZD/xdbVwjUpSMHytzSWooTaFbYnGz
 SnVtLjdKlwhJu1Ld2FttqxgzGSQtEp8XDbCKk7fESkf5pf6H6To4NQD8
X-Gm-Gg: AeBDieu0a8cfmaqDaRwqYhv92RxcG8wK+tEv5NSJfuKpE4P0GrIoQ/rn78MHpFxLkVg
 iLvh3DFbQoQtLZgVfcltmqsIPdRD0rENErFX9X4DxkFDEIHqZ4Tg2R2v+WfXU/SUOT0QUYU0Vfp
 w4xbWwt09LkKCy3BDMZM6u1HWtZe2dwgsLUQuG1pDANFlzq+Apk0+CA0kOQFwcIJlR2JpFDifai
 g23uoWLKJrSzzQdXsMkKPM33F+wkl1vTeIBz+udXbFmXcNl0IdG2Jsi74hpMp+ULdcv+ocNSudQ
 a54d2HOH49l7C9SZgEFV0EQ+qAGc5F4vDNe5Ol4xei3HbquaXPfTPAGeDloiPA4FU1gz8zkx5WQ
 z7RPe9edn4FlpGd53H23aJGSZs/fj13zeISwjHxigVbYN2dr6i1QbIFFAbmIFtD2VQlfusnp+ub
 xzphmFaWWD0ot2SswJKMzXWMOYf2/xuUZh2WjPmF3/TdHFqfOs214kvgwnzsRLc+csw1GXwlYSv
 zLmlzmTHCviYsGo3Nc=
X-Received: by 2002:a05:693c:2b04:b0:2e1:f72:3f2a with SMTP id
 5a478bee46e88-2e4647d03admr10600739eec.4.1776813858561; 
 Tue, 21 Apr 2026 16:24:18 -0700 (PDT)
Received: from localhost ([2601:645:8200:47:44d:4684:400f:ef2])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e79c2954f6sm19093626eec.30.2026.04.21.16.24.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 16:24:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 16:24:16 -0700
Message-Id: <DHZ7Y1A1LLPK.3R5MOKPN5NWPD@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <rbolshakov@ddn.com>,
 <phil@philjordan.eu>, <agraf@csgraf.de>, <peter.maydell@linaro.org>,
 "Mohamed Mediouni" <mohamed@unpredictable.fr>
Subject: Re: [PATCH v2] target/arm/hvf: Fix WFI halting to stop idle vCPU
 spinning
From: "Scott J. Goldman" <scottjgo@gmail.com>
To: "Scott J. Goldman" <scottjgo@gmail.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: aerc 0.21.0
References: <20260410044726.61853-1-scottjgo@gmail.com>
 <20260410055045.63001-1-scottjgo@gmail.com>
 <86D19C52-2A31-4802-ADF2-703D9AE83E75@unpredictable.fr>
 <DHUW6DNJWPDC.1MEF4S1911AJ1@gmail.com>
 <803470a9-5669-4c29-89fb-2c9be4656512@linaro.org>
 <DHVPR5CMUKMG.3803OP5N2C9J3@gmail.com>
In-Reply-To: <DHVPR5CMUKMG.3803OP5N2C9J3@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=scottjgo@gmail.com; helo=mail-dy1-x1336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri Apr 17, 2026 at 1:30 PM PDT, Scott J. Goldman wrote:
> On Fri Apr 17, 2026 at 2:57 AM PDT, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Scott,
>>
>> On 16/4/26 23:20, Scott J. Goldman wrote:
>>> Philippe-- apologies for the nag here but this is a fix for a unfortuna=
te
>>> regression. Any chance you could take a look? Thanks!
>>>=20
>>> On Thu Apr 9, 2026 at 11:18 PM PDT, Mohamed Mediouni wrote:
>>>>
>>>>
>>>>> On 10. Apr 2026, at 07:50, Scott J. Goldman <scottjgo@gmail.com> wrot=
e:
>>>>>
>>>>> Commit b5f8f77271 ("accel/hvf: Implement WFI without using pselect()"=
)
>>>>> changed hvf_wfi() from blocking the vCPU thread with pselect() to
>>>>> returning EXCP_HLT, intending QEMU's main event loop to handle the
>>>>> idle wait. However, cpu->halted was never set, so cpu_thread_is_idle(=
)
>>>>> always returns false and the vCPU thread spins at 100% CPU per core
>>>>> while the guest is idle.
>>>>>
>>>>> Fix this by:
>>>>>
>>>>> 1. Setting cpu->halted =3D 1 in hvf_wfi() so the vCPU thread sleeps o=
n
>>>>>    halt_cond in qemu_process_cpu_events().
>>>>>
>>>>> 2. Arming a host-side QEMU_CLOCK_HOST timer to fire when the guest's
>>>>>    virtual timer (CNTV_CVAL_EL0) would expire. This is necessary
>>>>>    because HVF only delivers HV_EXIT_REASON_VTIMER_ACTIVATED during
>>>>>    hv_vcpu_run(), which is not called while the CPU is halted. The
>>>>>    timer callback mirrors the VTIMER_ACTIVATED handler: it raises the
>>>>>    vtimer IRQ through the GIC and marks vtimer_masked, causing the
>>>>>    interrupt delivery chain to wake the vCPU via qemu_cpu_kick().
>>>>>
>>>>> 3. Clearing cpu->halted in hvf_arch_vcpu_exec() when cpu_has_work()
>>>>>    indicates a pending interrupt, and cancelling the WFI timer.
>>>>>
>>>>> Fixes: b5f8f77271 ("accel/hvf: Implement WFI without using pselect()"=
)
>>>>> Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
>>>>
>>>> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>>>> ---
>>>>> include/system/hvf_int.h |  1 +
>>>>> target/arm/hvf/hvf.c     | 65 +++++++++++++++++++++++++++++++++++++++=
-
>>>>> 2 files changed, 65 insertions(+), 1 deletion(-)
>>
>> I haven't looked at your patch yet. While looking at commit
>> b5f8f77271 I noticed the previous a14afa985e3 ("accel/hvf: Skip
>> WFI if CPU has work to do") is different in my local tree, where
>> I have:
>>
>> -- >8 --
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index 5fc8f6bbbd9..1a76c9cf402 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -2037,6 +2037,11 @@ static int hvf_wfi(CPUState *cpu)
>>           return 0;
>>       }
>>
>> +    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIQ)=
) {
>> +        /* Interrupt pending, no need to wait */
>> +        return EXCP_INTERRUPT;
>> +    }
>> +
>>       return EXCP_HLT;
>>   }
>>
>> ---
>>
>> Does that help? Now I'm really confused.
>
>
> Hi Phillipe-- Appreciate your help here. The good news is the bug is
> very easy to reproduce (start a linux VM with 1 cpu, watch the vCPU on
> the host will always spin 100%). The bad news is I double checked my
> bisect and you can see before b5f8f77271 there is no problem, and after
> the commit is introduced, the problem appears. I also applied the
> additional cpu_test_interrupt() patch you suggested and it did not
> change the behavior.
>
> thanks
> -sjg

Hi Philippe- Apologies again for bugging you, but it looks like v11 is
about to be released and it would be a bummer if this regression went
out with the stable version. Have you had a chance to either look at my
patch or check if there was some other simpler fix?

Also, I'm not a regular qemu contributor, so if there is some process
here, that I'm missing, please let me know.

thanks
-sjg

