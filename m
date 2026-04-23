Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B49F589A4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 12:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFsrC-0000jE-30; Thu, 23 Apr 2026 08:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFsrA-0000j2-KC
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 08:08:32 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFsr8-0004pQ-Hn
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 08:08:32 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488ad135063so58258545e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 05:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776946107; x=1777550907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zSTjV5J/44GAA3EnTElOCmB2+krdvC6LR4tezh4F57Y=;
 b=OivWCho1uNqMBZRqbUz4UtwQAzBcQLBkYKfaPz2vhCZhO52klujyZ2XN4CeHMQPKv2
 MF5oB2LZT1sVhFfUb1+wOHkMt/ci5TK1b9+3XqGdTChNPwQPAJBminY3h+z4PZjdS+Wg
 QsjbDIeqGRzCyuZkAuyBVeclPQ7LodhcM5kF8cD3KRKz7Xgw/nZhBD4Op4mTeqF+Ax2t
 ixPOezQVdrOospxixOjLk6QERNBknaz2TZuq+QalQK0Wn/suxCww9uw/40TAkS2+F+kI
 a9D6+TyNj/yVcVCjNEFfRhof1TGTQ/dgLjNrV7S7u7Hz/M8M3GPZOiKrt8Ux0wGJ2hYr
 GSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776946107; x=1777550907;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zSTjV5J/44GAA3EnTElOCmB2+krdvC6LR4tezh4F57Y=;
 b=QEKFQc3uk1yLyH9WaSTFJ5cEktFeyDjBBcAEAosOHkNzQiGn4h0r0VXiK0GHK4A0qU
 jKTynd+ZF/mOPRQyRNT2Dsi8MTQhWUWXIySc3iteglFErzgL5g/sSB8NGiYmDjpX+Zgn
 R9QDDL9XmC/3OJbfdg4S8lsHQ+YPaW8PqruefpqhTm7kQK6VAZeJxcS0/qpgQvgSqCVk
 733lytwDj/M3SAE/ZRoZdCmAReRJIBfccmut+/wP2NKV9ApGQl87cGEuIikoyCCzhmPN
 8yq65N9SCXdhPb9AXXMbhqMGE2oomX8DDpZpzs8x0eH9H7uZvqdsWJP/kZnzop2M7bZ8
 iOMw==
X-Gm-Message-State: AOJu0YxjxzlYdFn0tONDfdFDkMvdup67FkPNbE8En84C8jEY3xmB8ZnV
 da4boaM2ePjpmm6IlYgAvwblefahuoQRzwGTQptyOWxwhkxR6Vc/Cjfot7hjdxPH1xlFTllctoA
 CzLOAQoM=
X-Gm-Gg: AeBDievgwzoiR55QbHMRjeBfmPohEn64uOskRzzqE4PnBo+Ajl9fg3b3ploiSqro8sO
 gj8tul+XyzkvifNnmmL9E84Ri7anuIa+aeECUxOVHGc9oxEdhIXN5BVPw7L/r7BDsvnnuWb/mAa
 hVZuoTWsE6ynEVMn1AGNix2vXTG8ez0vygODLwKmk79Dzcwmbi+CXinDfyQrVyoObK5Sfqi0mKT
 a5BvPV7RQ6XkuWpdmKNJcx2RjFsBpi1ZCes/RR7ynoVu6LV+ScOTGBMlpNdTkXuYUZSEKv3hnlI
 buBalTdG1Z1FRZSHJJzQcGW6j0saH7y3tCXeB1ymcbckHpI9L2S60MjtbF9VTaPZicZJ3HEAfWk
 BxJ7rlAGqY3bEmhBuWAjm5czn/zOej8SHZSsZfu989JtjjXNX5v6x/bupiV5b6udixQxbwN/nzi
 lSSB/Mzq83PrA5R195icM5tWn8ejzVsUo8ug==
X-Received: by 2002:a05:600c:3423:b0:488:fd7e:1063 with SMTP id
 5b1f17b1804b1-488fd7e1253mr205138745e9.29.1776946107159; 
 Thu, 23 Apr 2026 05:08:27 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8188sm546017935e9.2.2026.04.23.05.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 05:08:26 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3F7C85F7F9;
 Thu, 23 Apr 2026 13:08:25 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 29/32] target/arm: implement global monitor events
In-Reply-To: <ede428ce-a99e-4630-a000-7d8356f08ac7@linaro.org> (Richard
 Henderson's message of "Thu, 23 Apr 2026 09:00:15 +1000")
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
 <20260422125250.1303100-30-alex.bennee@linaro.org>
 <ede428ce-a99e-4630-a000-7d8356f08ac7@linaro.org>
User-Agent: mu4e 1.14.1-pre3; emacs 30.1
Date: Thu, 23 Apr 2026 13:08:25 +0100
Message-ID: <87se8lx4jq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 4/22/26 22:52, Alex Benn=C3=A9e wrote:
>> Moving from Exclusive to Open Access should generate event stream
>> events. Technically a non-exclusive store to any address range covered
>> by the global monitor should also trigger such an event but we can
>> only detect that after the event by seeing if memory doesn't match
>> cpu_exclusive_val when processing the eventual store exclusive.
>> The CLREX instruction has the same effect as do other operations
>> clearing the exclusive state (such as eret).
>> We special case STLR/STL (Store Release) instructions to generate
>> events because their use is a suggested pattern for clearing locks
>> that might be sleeping. We only trigger the event if we detect an
>> exclusive instruction is running.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>> v2
>>    - add gen_global_event_reg() and use that
>>    - add handling for STL/STLR
>> ---
>>   target/arm/internals.h         |  1 +
>>   target/arm/tcg/translate.h     | 14 ++++++++++++++
>>   target/arm/tcg/translate-a64.c | 23 +++++++++++++++++++++++
>>   target/arm/tcg/translate.c     | 20 ++++++++++++++++++++
>>   4 files changed, 58 insertions(+)
>> diff --git a/target/arm/internals.h b/target/arm/internals.h
>> index 089f679ac0a..7045b4a56bd 100644
>> --- a/target/arm/internals.h
>> +++ b/target/arm/internals.h
>> @@ -709,6 +709,7 @@ static inline void arm_broadcast_event(void)
>>   static inline void arm_clear_exclusive(CPUARMState *env)
>>   {
>>       env->exclusive_addr =3D -1;
>> +    arm_broadcast_event();
>>   }
>
> An out-of-line arm_broadcast_event suggests an out of line arm_clear_excl=
usive too.
>
>> @@ -3544,6 +3553,7 @@ static bool trans_STLR(DisasContext *s, arg_stlr *=
a)
>>       TCGv_i64 clean_addr;
>>       MemOp memop;
>>       bool iss_sf =3D ldst_iss_sf(a->sz, false, false);
>> +    TCGLabel *skip_monitor_event =3D gen_new_label();
>>         /*
>>        * StoreLORelease is the same as Store-Release for QEMU, but
>> @@ -3562,6 +3572,19 @@ static bool trans_STLR(DisasContext *s, arg_stlr =
*a)
>>                                   true, a->rn !=3D 31, memop);
>>       do_gpr_st(s, cpu_reg(s, a->rt), clean_addr, memop, true, a->rt,
>>                 iss_sf, a->lasr);
>> +
>> +    /*
>> +     * We don't fully model the global monitor as it would be very
>> +     * expensive for every memory access. However in the Arm ARM "Use
>> +     * of Wait for Event (WFE) and Send Event (SEV) with lock" it does
>> +     * give the example of using STLR to clear a lock. So if a lock is
>> +     * active trigger the global event register so we don't deadlock
>> +     * while sleeping.
>> +     */
>> +    tcg_gen_brcondi_i64(TCG_COND_EQ, cpu_exclusive_addr, -1, skip_monit=
or_event);
>> +    gen_global_event_reg();
>> +    gen_set_label(skip_monitor_event);
>> +
>>       return true;
>>   }
>>=20=20=20
>
> Um, no.  Just because STLR is used in the example, *any* change to the
> memory region must raise the event.  There's nothing special about
> STLR vs STL vs STB etc.

I think in the context of locks the release is important. But yes I
agree this isn't covering all the global monitor cases.

> The only thing I can think that would handle this is to set up a
> watchpoint in WFE before going to sleep, then wake on the watchpoint
> trigger.  Disabling the watchpoint on any other wakeup could be
> annoying.

The global monitor and the event stream are different things though. So
if we are committing to fully modelling the monitor (which would also
solve the ABA issue) it couldn't just be active while doing WFEs.

We could generate a postscript for every store which might be cheaper
than slow-pathing a whole page for the global monitor. If we supported
sub-pages maybe slow-pathing a cache-lines worth of address space makes
more sense.

Another option would be exposing a exclusive address mask as a dedicated
register to the backend and making the check part of the softmmu
generated code?

I guess we could put the monitor active state in tb_flags to avoid the
cost of code generation when no one uses ldstexcl because they have
access to far atomics instead?

>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

