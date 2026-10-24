Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83C0606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kUHi1Fpa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKeJZ-0004eE-IT; Sat, 24 Oct 2026 12:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adrien.kohlbecker@gmail.com>)
 id 1xKdxj-00082T-RZ
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 11:47:15 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adrien.kohlbecker@gmail.com>)
 id 1xKdxh-0006ae-Fu
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 11:47:15 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6b1f31c63ebso4844439a12.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 08:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792856831; x=1793461631; darn=nongnu.org;
 h=content-transfer-encoding:content-type:subject:references
 :in-reply-to:message-id:cc:to:from:date:mime-version:feedback-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+PC1BPGG8wRFBnlRszmhJMWM19lUGInf67vrhi7bNg0=;
 b=kUHi1FparqOc8DSSumpd2yvUC75wkSP/+FndJUiKgKaK2UfJlB3+GIZ/t0icbB5FBl
 lO+Hi3rf1pttjps18wLfMcdDQB294C7krZpkM3S3LJQrDP+28QDGWO4DAZCCsAdzcZNm
 14F7eJrn6Rd+PW/ulk9c3NAFqVo1MPAqSvZWiOuazqtXbLtg8TD9V5Aopx3T8LVNMRr8
 LJ74DXwzLatf2N5sDnwL8shSe0EVdHfUKZ9ZP4mRFsuYi2kHU41h0NoOBjKjCCChvoHi
 cfCMYLSB1hOp69GGwWHfb9f2Z87cIrHeyTvhH3h1zn/sNVFxsro1AF2Qoe8sAfVTICEC
 jkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792856831; x=1793461631;
 h=content-transfer-encoding:content-type:subject:references
 :in-reply-to:message-id:cc:to:from:date:mime-version:feedback-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+PC1BPGG8wRFBnlRszmhJMWM19lUGInf67vrhi7bNg0=;
 b=NiSNx3vhF0BDAfoC4UY/39I04/o8eXIISyu5TOEskpTyIeljS1ljq6PTG3fGEgiWOp
 /elJudkypwBaO892LQ0gWxvdxgEt6Ot7Hk1rO6NSVb5leBMe+UFIUg6iNBLppP+gMZnX
 KJsN36xP3AW7dm4zl4uqfNKdia6kUqjal2opMfPs5RqmPd3C2Fpu98WngAN5EksuyZkj
 keD2XZA11mpq+A5omHEdm3iTewwI+ggvki1ZTATdhIORnzOKWAfZjukGVrsdK6cSexj/
 erEL4sw7GyjQL4ltI9aDlgVEBnS31Alg/2mNf6FNyIRUTtGusBfep8UrVF0Q9bEopaoB
 XliA==
X-Gm-Message-State: AFq9FYJM4yMGWi9S7s54przn8SxQ20daNDiZrai6wfNRJ2FDuW/ckp7s
 PwkeksS4IeczLZvVu9hdRMd2g3NZSqiaF92MgliEKO2TwNJS/RXKn18J
X-Gm-Gg: AYBFou2mYvd9EDBEjcghuNvclebUWeShvZ6J3VFlPSUZJ1qtl9W83Iot0yZfdlQlbAj
 CrqJbAC6JXr1Q64aJHOwX8HrT6QJXLOhHhOhDOjip+KEtrc8OpGoCkj7Sl6XX2vcws2f5A021Zg
 MDEsTqfYg8FxqFUiH2YLoG8cmDVj1FBRoP4CgGgFJDaH4Udp5pTO1LQpwFze/56CHefgaSI8juz
 am7486pnhwYurDZYB5deEvMKpbhG8I++0mvcmjO5faYmaIDrqTGJZSnqpwfmZ1AUwinfgTphrfC
 jJEpX1QgXMdQeJ5jFqOpCkaMTZQIBOYcEZKOYO6nvXRk5/G4qSe5bOfX4i4Mqwrgw7IiD203rkf
 lEdNncG96IQamgqPAhte9hXlgt2++mlhPVnIrf2DUp9CCGoWD6JB3Zr5nz2JcDAcT0PUFrlSCom
 tWGJ22GuUNw5JpHR55q3CHiwJ/PAclwLzcXAsBZWm7PFuucVspQ1DoXa7h6DQaFCtcazgcdmKNn
 7LV86piFXGaWBG6hlZLGLu4Ge+JwZGLWZMBb/G0xyVKGOsI4IggkrmMnH30CuQ5PZJUA3VKGpl6
 c9jOA4W4XY2wbnqUzGMIKYYSG0nIMEPbURm4Tlbxwj0aXuZP6wGmMgmPfR2Q/EkOWFcz5th/Sw=
 =
X-Received: by 2002:a17:907:868c:b0:c3f:8c92:3b54 with SMTP id
 a640c23a62f3a-c46bd956b63mr283516166b.0.1792856830427; 
 Sat, 24 Oct 2026 08:47:10 -0700 (PDT)
Received: from fauth-c1-smtp.messagingengine.com
 (fauth-c1-smtp.messagingengine.com. [204.75.18.200])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd795bf8sm101695666b.70.2026.10.24.08.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 08:47:09 -0700 (PDT)
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
 by mailfauth.ams.internal (Postfix) with ESMTP id 4BB15198003A;
 Sat, 24 Oct 2026 11:47:08 -0400 (EDT)
Received: from ams-imap-01 ([10.64.2.21])
 by ams-compute-01.internal (MEProxy); Sat, 24 Oct 2026 11:47:08 -0400
X-ME-Sender: <xms:-9Lcaq3U7L3RaEbHSe7UCu05_ywSeZdCWAL9RYRJI6wEzGaLhzjWJA>
 <xme:-9Lcan7P9JWd1a9OvM0gH5gJCm_8RPEU-X-Y5Vcdn5HPT3xd4HrGEt76GabmC0tYM
 Fg0otUD5Vj9HeXbowYS0TWQ1FAUZIBHYwsTOK00FbEJxyV5B_b61Pp->
X-ME-Proxy-Cause: dmFkZTEihKyTpVw3x928/Nt/0fe8JiaEakK7FRyRYDodG7XVtlBLdoLDJulfDZIUgO6LmX
 /hqiSYx5JWhUzyWJCT2gKkxadDiHWj8NKtX0EWUEzsOEoUPXLR/XXZXeZ3w+lwzlRfXcPu
 8SHjDwNh43Xumlcx22SSDDGG6IJkAHUHMZafQrhrzeV9xWiwAog9HJPK6Vt7j+flG4stYX
 ov85472BLMOXKqpEcKcMfA4cFJR0Rtf97QUhLBvZ+Tg14ZHoE+bAWrnVDUu+yGQh4y8xO1
 D4Avqf+Rf8aVL5i7ufZHvum/vsyKxvyELFZdG8wP+dVMZ9qixJlSObd+1AELHxGIzJEcY8
 37moUNv4yl75vs3qRVuNWRz/5rwPwF0c9XGIg1eS1sNoNXgydV/Es67+qunGkzes9skKG7
 HHxs0wFqX76gzI98SZoZA3zfE2hLP2ycGZD/an09mGEEuRn6tmHZ/7TKal6VKzzMAl+Kod
 BIVffZuWTU3pj4DBbPg4K9N7YJDoiGK97qFN0pg4WGdZTWMh8gomGAK5uRZP5btMS+1nMQ
 HWa0Dy7kceE5OtPtyur17HtoUEZVbUASc2dKvuSxr6NDMqT6dIMVNpfeAg9bmwZLwN3QXJ
 Ow2D8Bs5JvS/RA0vDfZs82zr6LhX3V0S5hAPy/vquwZwmQacDj8YHj+E/IJA
X-ME-Proxy: <xmx:_NLcasjJZZp6xS0mRK6q1Jxn-LS7XqlWACNVG5-MoL5vnvenpc_F2g>
 <xmx:_NLcar6ALcCGLXc1kn_3nW4pPEWTfUP8fY867ulx2q0XODLrG-GGfw>
 <xmx:_NLcasYXRcsuQlSY7ttLHM9bkhH9LThubKNPPFOIuklU7GXX3BHtaQ>
 <xmx:_NLcao4t8MPBXPP55wDP6LrsNsrA1iyJoXl9O4kIZk5Ig6Kq6pRFVQ>
 <xmx:_NLcanC2Lo50asohfOSmBzaL9tfRHWMUpHULjVBRcmFUDZ55RQcE9yYm>
Feedback-ID: i51ae481e:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
 id EA155FA008F; Sat, 24 Oct 2026 11:47:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Sat, 24 Oct 2026 17:46:46 +0200
From: "Adrien Kohlbecker" <adrien.kohlbecker@gmail.com>
To: "Peter Maydell" <peter.maydell@linaro.org>,
 "Mohamed Mediouni" <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, "Alexander Graf" <agraf@csgraf.de>,
 qemu-arm@nongnu.org
Message-Id: <6dcdb40d-e74e-4034-ba6e-5cccd57b71ab@app.fastmail.com>
In-Reply-To: <CAFEAcA8GicYKBQDACcGzR+baM8Zi49uN+dfhu-GDH9Pgiq8J3g@mail.gmail.com>
References: <20261022213647.21665-1-mohamed@unpredictable.fr>
 <20261022213647.21665-3-mohamed@unpredictable.fr>
 <CAFEAcA8GicYKBQDACcGzR+baM8Zi49uN+dfhu-GDH9Pgiq8J3g@mail.gmail.com>
Subject: Re: [PATCH 2/6] target/arm: sync vCPU state after PSCI CPU_ON reset
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=adrien.kohlbecker@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 24 Oct 2026 12:09:48 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Peter,

Thanks for the review. I should say I'm not very familiar with QEMU's
internals: I hit this as a user, while trying to kexec in an HVF guest
on a Mac, and the patch is the smallest change I found that made it
work. So I can't really answer your questions about which sync call is
the right one, and I'd defer to you and Mohamed on that.

On KVM: the same kexec works for me on KVM (an AWS Graviton host), but
I don't know why, so the KVM sentence in the commit message is a guess
and I'm happy to drop it.

What I can offer is a simple way to reproduce it. Boot the Ubuntu
24.04 arm64 cloud image on an Apple Silicon Mac with
"-M virt -accel hvf -cpu host -smp 2", then as root:

  echo 0 > /sys/devices/system/cpu/cpu1/online
  echo 1 > /sys/devices/system/cpu/cpu1/online

With QEMU 11.0.1 the guest panics on the second command ("kernel BUG
at arch/arm64/kernel/smp.c:388", in cpu_die()). It did that every
time I tried (5 runs). With my patch applied, CPU1 comes back and the
guest keeps running.

I also tried calling cpu_synchronize_state() before cpu_reset()
instead of cpu_synchronize_post_reset() after it, in case that is a
better fit. That fixes the reproducer too (4 runs).

I'm happy to test whatever version you think is right.

Thanks,
Adrien

On Fri, Oct 23, 2026, at 14:19, Peter Maydell wrote:
> On Thu, 22 Oct 2026 at 22:36, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>>
>> From: Adrien Kohlbecker <adrien.kohlbecker@gmail.com>
>>
>> arm_set_cpu_on_async_work() resets the target CPU and sets its entry
>> point and context ID in CPUARMState, but never tells the accelerator
>> that the register state changed. TCG reads CPUARMState directly, and
>> KVM re-pushes state on reset, but HVF only writes CPUARMState back to
>> the hardware vCPU when cpu->vcpu_dirty is set.
>
> My first reaction to "this works on KVM but HVF does something
> differently and it doesn't work" is "so why are we doing things
> differently?".
>
>> A vCPU that reached PSCI_OFF is left clean: its last hv_vcpu_run() exit
>> was a WFI or a cancel, and flush_cpu_state() cleared the flag. A later
>> CPU_ON then resets and re-points only the QEMU-side copy. The vCPU
>> resumes in its old context, with the old MMU state and vector table, and
>> never runs the requested entry point.
>>
>> This shows up when a guest that already onlined and offlined its
>> secondary CPUs boots another kernel, for example kexec on Apple Silicon:
>> the new kernel logs "CPUn: failed to come online" for every secondary.
>> Fresh vCPUs are created dirty and single-CPU guests never issue CPU_ON,
>> so the ordinary boot path is unaffected.
>>
>> Call cpu_synchronize_post_reset() after resetting the target, in both
>> arm_set_cpu_on_async_work() and arm_set_cpu_on_and_reset_async_work().
>> It is a no-op for TCG.
>>
>> Signed-off-by: Adrien Kohlbecker <adrien.kohlbecker@gmail.com>
>> ---
>>  target/arm/arm-powerctl.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
>> index ef14a1f8a9..e197a0ebda 100644
>> --- a/target/arm/arm-powerctl.c
>> +++ b/target/arm/arm-powerctl.c
>> @@ -16,6 +16,7 @@
>>  #include "qemu/log.h"
>>  #include "qemu/main-loop.h"
>>  #include "system/tcg.h"
>> +#include "system/hw_accel.h"
>>  #include "target/arm/multiprocessing.h"
>>  #include "trace.h"
>>
>> @@ -80,6 +81,7 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
>>
>>      /* Start the new CPU at the requested address */
>>      cpu_set_pc(target_cpu_state, info->entry);
>> +    cpu_synchronize_post_reset(target_cpu_state);
>
> This isn't a CPU reset, so do we really need
> cpu_synchronize_post_reset ?
>
>>      g_free(info);
>>
>> @@ -189,6 +191,7 @@ static void arm_set_cpu_on_and_reset_async_work(CPUState *target_cpu_state,
>>
>>      /* Initialize the cpu we are turning on */
>>      cpu_reset(target_cpu_state);
>> +    cpu_synchronize_post_reset(target_cpu_state);
>
> I'm not sure whether cpu_synchronize_post_reset() is supposed to be
> "after we just did a full system reset" (the way i386 uses it) or
> also "after we did a single cpu reset" (the way s390 uses it).
>
>>      target_cpu_state->halted = 0;
>>
>>      /* Finally set the power status */
>
> -- PMM

