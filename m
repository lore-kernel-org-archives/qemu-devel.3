Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09C0C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgh46-0004iG-Ez; Mon, 06 Jul 2026 07:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wgh44-0004gO-Cw
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 07:00:40 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wgh42-0000a3-Ht
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 07:00:40 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-493b786d6c0so15158905e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 04:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783335637; x=1783940437; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ACMcFZRjo2pLPoopeWKTBZZti+C4GgglbX4kSs9CRfA=;
 b=kEdw+fkdlWTdbSzYInl9YKHX4UHDjfElkKIa0hV5U1O8vmmWHDCwxkNFvlEXty70nA
 iYV5bfXpdn3EBIqWt1u4ls8QuV+AMrohKQMC9/CTHzlSTi59q7VawxnX/25ildZpM9LM
 +91D1WsIN2cC5qtbIv1zz7mCEvoSLL6BLI5PmEYVrQXjp7dW0gdv1XIDP+4ynGivRPbe
 dztp5lovSaMyuzc9meteUNif9SrKEYS0b6w64JIkk/WKNnOtZbiLI+bbL/Z/LXaeLalK
 FjKA58YV/zrxgMmxvn4+zA565W87q5udCXz5V3ZH7d5KCJAd0FTqMmaM4tv1N3Rxmivd
 48Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783335637; x=1783940437;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ACMcFZRjo2pLPoopeWKTBZZti+C4GgglbX4kSs9CRfA=;
 b=kPDsZchanxxXNdyVuxzN/4CBOhTQI4aKumwc+3Pr8iwA9/Ewcdm8fOrzWh7pqmORMS
 GsKYCw00UjBQsUiDLG5AUjc0l++3PqQq40jD+44JmGL6V6zc88oSlSZkSFJSCuTg7a3/
 HmHAAwHcpvn8OU4QGuorCNFBTcmgJxklp6FHH+RrsBjgRoUkGCO7gE9LFph3EMIEUHf4
 FQTDxg1WqzWLHUHf9a4WiY+DS0WJHTf06elgytmj0iEBwnZrVNmEKqbMnF1IuMa23kie
 YeqCXfvf3HyAzlSdwXefFTErtUSjb+B+GO6PSXgkXYmWWwGW7q+zX6IcjsHpf6ZZgt9V
 2CIA==
X-Forwarded-Encrypted: i=1;
 AHgh+RprQWK3EBFPKVNOesxM7ejNktI5bQeuTYtEo/jqnFXRCHo1X1CqGrxY5SBNnq4/F0FJynNYnNOt4+qs@nongnu.org
X-Gm-Message-State: AOJu0YybZnt81VtJdJunfc+66BBLuirqhXsgUKJlSjpGOotYV0ULU8Ql
 naonT/ixsz0sr29XqHCu4naInDZHdO7+lD7a948QpjiebZ0VU0jVpx9lVRx3fF45uo8=
X-Gm-Gg: AfdE7ckh17I+sYYsQEvlujv7S4neaNUfDVG2Q5G/FWc2wr2CmTgXkoXrEZWyENvATG2
 iLxgN3k0d0RchyqAaFeF0ZCuqCUpmOfuznnuuxCC9Z9QQDuOyDP688H2lsEWy9lqsr5pJHksicG
 huEO5XA/QE9vLnTVzOb14HzPyTvi/760WjZLv+ScHTKGQvjMQLjy8hMdqwcL7AO1yeLZX64tWqe
 CFRbjvoExjqluzTn1zPjrXehK5WswltE1PogwE5l8RVI54f21rSS9jfdBttJbeMjTZL1cpyoh84
 uUfTg9YrcX89RtjhJL2M658L4lFNRNvoCvBkAY0b9Pq31HdS1sE1fwgGsBonT9EaYyhon5He8sc
 C6p8qnY4vyJzMTcReIOtak2OEqlnJQ4LEe+FXAvlZiQducI0NpBQ4HevmPbbCU4hX4VCc1t5Vws
 nzK4/xejvInxEu8y9jCz1gswk=
X-Received: by 2002:a05:600c:8411:b0:493:a976:5c6e with SMTP id
 5b1f17b1804b1-493d11def4cmr103935365e9.16.1783335636898; 
 Mon, 06 Jul 2026 04:00:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c636ec8asm300931765e9.1.2026.07.06.04.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 04:00:36 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 554595F83B;
 Mon, 06 Jul 2026 12:00:35 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gilles Grimaud <gilles.grimaud@univ-lille.fr>,  qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH] target/arm: report M-profile BKPT to gdbstub when
 attached
In-Reply-To: <CAFEAcA_2G-CogeB=8cFs37PNdYL88_PcsD6eNehev8A3XNH82w@mail.gmail.com>
 (Peter Maydell's message of "Mon, 6 Jul 2026 11:39:33 +0100")
References: <20260705224407.32464-1-gilles.grimaud@univ-lille.fr>
 <CAFEAcA9Heev=ydTzO2u3EzeF_2q7dytOF8=67qF8ZMMY6Ky2Tw@mail.gmail.com>
 <877bn8wgou.fsf@draig.linaro.org>
 <CAFEAcA_2G-CogeB=8cFs37PNdYL88_PcsD6eNehev8A3XNH82w@mail.gmail.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Mon, 06 Jul 2026 12:00:35 +0100
Message-ID: <87y0fov0vg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

> On Mon, 6 Jul 2026 at 11:33, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > On Sun, 5 Jul 2026 at 23:44, Gilles Grimaud
>> > <gilles.grimaud@univ-lille.fr> wrote:
>> >>
>> >> While working on Raspberry Pi Pico/RP2040 support, I noticed that Pic=
o SDK
>> >> programs deliberately execute BKPT from _exit(). On real hardware thi=
s is
>> >> useful when a debug probe is attached: returning from main() stops the
>> >> debugger at the program exit point.
>> >>
>> >> Under QEMU this currently does not behave like the debug-probe case. =
For
>> >> M-profile guests, the BKPT instruction is routed through the architec=
tural
>> >> guest debug exception path. Without halting debug, that path should r=
emain a
>> >> guest-visible DebugMonitor exception when DebugMonitor is enabled, or=
 escalate
>> >> towards HardFault otherwise. This patch deliberately leaves that no-d=
ebugger
>> >> architectural path unchanged.
>> >>
>> >> The problem addressed here is the case where GDB is connected to QEMU=
's
>> >> gdbstub. In that situation, firmware that uses BKPT as a debugger sto=
p point
>> >> should stop in the attached debugger. Instead, the M-profile guest cu=
rrently
>> >> continues down the guest exception path and may end in HardFault/lock=
up rather
>> >> than reporting a clean trap to GDB.
>> >>
>> >> This is not specific to the RP2040 machine model. It is a generic
>> >> Cortex-M/gdbstub interaction: firmware that uses BKPT as a debugger s=
top point
>> >> should be reported to the attached debugger, while keeping the guest
>> >> architectural exception path when no debugger is attached.
>
>> > No other architecture, CPU or board in QEMU needs to do this,
>> > so my instinct is to say that M-profile should not be special here.
>> > Richard, Alex: how do we usually handle breakpoint insns for the
>> > gdbstub ?
>>
>> For TCG guests we never insert BKPT instructions and treat the system as
>> having infinite hardware breakpoints.
>
> This isn't about gdbstub-inserted breakpoints, it's about
> what happens when the guest code has a breakpoint insn in it
> already (either hardcoded, or also could happen if we're running
> gdb inside the guest). That's something that can happen for any
> CPU type.

So far nothing - there is a helper_debug in sparc which raises the
internal EXCP_DEBUG exception but as far as I can tell it is never
called.

We could treat gdbstub as an external debug monitor but we don't
currently model it as such.


>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

