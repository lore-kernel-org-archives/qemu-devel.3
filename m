Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05525C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgge9-0005Tj-Ku; Mon, 06 Jul 2026 06:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wggdy-0005SU-US
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:33:43 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wggdx-0001vn-6k
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:33:42 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493c83474ddso26318815e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334019; x=1783938819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q0rqZ8DzQgMhw+yZoWl4RA7L9y8b3UQYzzJkK/9Xpog=;
 b=MbjssHVe/QCKJEUlshLOqFhYObhf0iDxyuYzHINXe7jH0RGYXGyF8WWPH+FdaqYvmg
 BKIN22PWlRVZ5U1XmIq/rpMOgQd6q8AG+qIigmV82G0WSuImur0t8DBuDX5W13OTTqlo
 UkeCty0r9JMF/HxARRL6KFh6QCGwnAs+kWMAuYp26/oWtcrv7fe0Bz9ZH9gry01hycQj
 7Ymvr+VixvN4K+LxTnNBDsODxTcm4Lf/FJ36nH13L9Hngo4K8iuatHzYGYNm5gOafxIB
 UdR+cQq/Q9UTIQPG6SLVyQQ+oE419/7fPiCBUN3v5VfgA8MyVwhxMa53vvo7HbZx+27J
 9Qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334019; x=1783938819;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q0rqZ8DzQgMhw+yZoWl4RA7L9y8b3UQYzzJkK/9Xpog=;
 b=DpKYHHBhdLx7pqw4Uoz++wi/cv6ruJtLzc5KY8mAJsxqQ4+Tj6mk5yOLslVgo4utzQ
 NibXaoRoCmYWxRw5RaYE10RHMDxxYtKjf+N9eqJNZqobJ4P9QlXBIoDerVxpCMTK28GG
 Oae35BRe7MdVvXNXLlsSE/m/fOQp116P6+FrACk7E+EgOjMBo84AySNZ8scoC4V008hK
 obLf1WquGUJq6ONxR2W/sb7tj7Fa7KNSYFnlGn6wXxru0JHj3kfdMsLyXVj+AvAkw16d
 uighM0qbxJDoG9PdCDiQl8aOW8kjn4nUZhTRIJanlUo4WENpgnFLm0aV/mgTVgp/9T2i
 VqEg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpr2VDQJeAGO+VZYpkTJVgu01Yws6zFKHJeFb7f2aG1eaTPccgpOk7LxYqlFnD1PE/O8Nhg3IJm8Qio@nongnu.org
X-Gm-Message-State: AOJu0YxFVzoE+4dYLM1cXOTAjBcasRFlyQrkfw0MB2ALBo+10EHjipI5
 t4XlU/N4dq4HOWw6hED1NMDS9jJDdVTkL9LNy2AmBbm2gNVHvEUz8gxE9vjXwiHH6Ho=
X-Gm-Gg: AfdE7ckG11xleOzcTQhEuQ8hwoCJSSAVC9Thp8bGLrFpfFpcWFr2hqaPbWmzsDqzvSw
 Rf0XkqM9SzP1CTiqdlLtg2Cz7HGXngkeLMwmW2CUK2e/w+WQ6KQ76u7wQdQnTnBAWcah2kBxm7N
 sXAVP7Fjl3mX1EwdfILNbUwlI9sJjWU9zlyDXNOCTMNe/Mkrke+k8NtuXgotP/JT7ujN6XjnjhH
 Fy2ZSGgLiPhck6JLjW9rByZvasq5MFCl9kit3eUNfNHKkTfMs+tIpUFyyM7hckx1+Zvf3USIvlg
 JdKVJ12Jz/oVcp17aZaL2jZ2SrKqLBQdniWtGljLVV4lroebvry1t3U8gvm4UnryBtjwe7GhqTt
 oUyBGj8Fi2VX8bBo8J4RU9zdvIt+N1jw+B86OZhgjL3f3q5xVLb4SXJNJ+VuzN24ivMOqkFlPl0
 uXT92EBFbpC4/W
X-Received: by 2002:a05:600d:8654:20b0:493:bfea:2786 with SMTP id
 5b1f17b1804b1-493d11f6d34mr81656625e9.32.1783334019166; 
 Mon, 06 Jul 2026 03:33:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef183e7sm436267335e9.2.2026.07.06.03.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:33:38 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4AA1D5F83B;
 Mon, 06 Jul 2026 11:33:37 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gilles Grimaud <gilles.grimaud@univ-lille.fr>,  qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH] target/arm: report M-profile BKPT to gdbstub when
 attached
In-Reply-To: <CAFEAcA9Heev=ydTzO2u3EzeF_2q7dytOF8=67qF8ZMMY6Ky2Tw@mail.gmail.com>
 (Peter Maydell's message of "Mon, 6 Jul 2026 10:21:31 +0100")
References: <20260705224407.32464-1-gilles.grimaud@univ-lille.fr>
 <CAFEAcA9Heev=ydTzO2u3EzeF_2q7dytOF8=67qF8ZMMY6Ky2Tw@mail.gmail.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Mon, 06 Jul 2026 11:33:37 +0100
Message-ID: <877bn8wgou.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Sun, 5 Jul 2026 at 23:44, Gilles Grimaud
> <gilles.grimaud@univ-lille.fr> wrote:
>>
>> While working on Raspberry Pi Pico/RP2040 support, I noticed that Pico S=
DK
>> programs deliberately execute BKPT from _exit(). On real hardware this is
>> useful when a debug probe is attached: returning from main() stops the
>> debugger at the program exit point.
>>
>> Under QEMU this currently does not behave like the debug-probe case. For
>> M-profile guests, the BKPT instruction is routed through the architectur=
al
>> guest debug exception path. Without halting debug, that path should rema=
in a
>> guest-visible DebugMonitor exception when DebugMonitor is enabled, or es=
calate
>> towards HardFault otherwise. This patch deliberately leaves that no-debu=
gger
>> architectural path unchanged.
>>
>> The problem addressed here is the case where GDB is connected to QEMU's
>> gdbstub. In that situation, firmware that uses BKPT as a debugger stop p=
oint
>> should stop in the attached debugger. Instead, the M-profile guest curre=
ntly
>> continues down the guest exception path and may end in HardFault/lockup =
rather
>> than reporting a clean trap to GDB.
>>
>> This is not specific to the RP2040 machine model. It is a generic
>> Cortex-M/gdbstub interaction: firmware that uses BKPT as a debugger stop=
 point
>> should be reported to the attached debugger, while keeping the guest
>> architectural exception path when no debugger is attached.
>>
>> Expose a small gdbstub helper to test whether a CPU is visible to an att=
ached
>> debugger. When an M-profile BKPT instruction is executed with such a deb=
ugger
>> attached, leave the translated block with EXCP_DEBUG so the existing gdb=
stub
>> stop path reports a trap to GDB.
>>
>> Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
>> ---
>>  gdbstub/gdbstub.c      | 13 ++++++++++++-
>>  include/exec/gdbstub.h |  6 ++++++
>>  target/arm/tcg/debug.c |  9 +++++++++
>>  3 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
>> index c3c944e965..9f259fc005 100644
>> --- a/gdbstub/gdbstub.c
>> +++ b/gdbstub/gdbstub.c
>> @@ -237,6 +237,18 @@ static GDBProcess *gdb_get_cpu_process(CPUState *cp=
u)
>>      return gdb_get_process(gdb_get_cpu_pid(cpu));
>>  }
>>
>> +bool gdb_cpu_is_attached(CPUState *cpu)
>> +{
>> +    GDBProcess *process;
>> +
>> +    if (!gdbserver_state.init || !cpu) {
>> +        return false;
>> +    }
>> +
>> +    process =3D gdb_get_cpu_process(cpu);
>> +    return process && process->attached;
>> +}
>
> No other architecture, CPU or board in QEMU needs to do this,
> so my instinct is to say that M-profile should not be special here.
> Richard, Alex: how do we usually handle breakpoint insns for the
> gdbstub ?

For TCG guests we never insert BKPT instructions and treat the system as
having infinite hardware breakpoints.

From what I can tell we should only route the debug event to an external
monitor if the right DHCSR and DEMCR bits are set. Even then the spec
has a lot of behaviour with is IMPDEF.

I think the v7M rules are different to the v7a/v8a ones.

>
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

