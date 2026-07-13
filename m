Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8969C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEZT-0004Aj-5b; Mon, 13 Jul 2026 07:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wjEZR-0004AR-6s
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:11:33 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wjEZP-0006ex-8R
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:11:32 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-476d8e647e9so3088887f8f.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 04:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783941089; x=1784545889; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9cvW9Hj8m088+L/Cb6813m3dv+GkmPK+BWsRpFGbdKo=;
 b=HdfjJREwPS+geZcnnRlyB+eTpuSgkO+Yh4fp2yICH052ZvcqtVUzdZvWGiGOU3YAmC
 aJ1XHBQ07CHMR5TqvRjlm88LwTRTYsI3vKjQW1nwp2f9TmOXuYozXaZSiWofoe9LFotB
 tzHs4HtgwyezK7Mc/1ZKEi29nIcNiDnajwhSWD8oUzIjn//MtjHnMp49AoWEQjB+75CN
 QrUiaukPh90S1ACXZOHcs6c0YWdg6TpOdDRVYaJH01i/ckoGrCqX9qSp5I/fASwXwYxG
 tdDCzNM6Go88ApWNUO4iBTq7WyIlDwpEp3/0ko0CpljmMi4Qdp1sxCHrny2QfVgUQCQg
 O3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783941089; x=1784545889;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9cvW9Hj8m088+L/Cb6813m3dv+GkmPK+BWsRpFGbdKo=;
 b=E3rEz6+rT3saFIc0dQ3+s0VlJ2D2FMOye5zsjic+WDa5n8rE7bXCdHzf8xM34zMY3e
 ZsxT8ptKsL2n0DopbRtkRprxyMxpvkilf6iHjbv2m/me/19pbG0gE4LOQFWRLLVoSuVC
 Bku4oUwJaqPXVOGduW4TN2PqH4R5mEwVp7fZC/zGU3yL74ncQSN6KYYbEuQ3RYI4t+Jq
 viUxiPEHrWD/LRFqFk1LvFS3XboMS5IMlL1okHEKN4RVOtGLhg3/oqPpbE5jcS9dLajA
 P6foRTl/MNBWh/oel7oWfT7ktq/YoyhB54Ay4GrUnEYEiGCpcXCZo+OJdvKH7bfeK7dI
 fOeg==
X-Forwarded-Encrypted: i=1;
 AHgh+RozUP/7zaufC1gtczlL1ujdpP8y6yCjRPj6SoX4fPRYvgF+TF/IIYjs2oU4YqSlrb5e1ndskL7qm5j5@nongnu.org
X-Gm-Message-State: AOJu0Yxk0xgqZhSd7jzS5RHpAATjOEafR4jfCFAkfiQ4/SPWyp3gZUvX
 MGSwO9zpFxHFlcrm78K+b6etEzoxRhzHBOolBJITp8vgxgKh2AAwwmU3fLhjqqFuH6c=
X-Gm-Gg: AfdE7ck3Nz4FhwKFw/t1YZgcc9DrzbyIoCkT/+MDdzWUi2dTokFxYNQETE33q/HQJQp
 U+ueUrroExcn16cradiI9kpGb+e8pqepxwbjZgwPzJ68DEDejTtz4E19K1dbtVqucdfYDNo7QAw
 XD85zkOEgUxa1qbpLrKAdhEUs5YdnN1Vz846y6wd4ZIKClT5UNS7nD/LmX1FdMdWA9mFi6IwltA
 Wty27Smk69n06j/NbvD3nJ5d/23SuXQyrsHYvpK68wCcILqzlTadEAv6DjOHKTWJslQki3bflTb
 IvfSwHamAps86ydW64bvrj4RLTIrmuEcnJTg/KBLxKO4zUsyLQ3RLNfELRDj75RVlQRZsku5gSe
 UIG1YuS1HCGyQ/g8XOb8G1uKmAR1QGuQT9vUw5AlEcEyKDNbC4dVNHGcLZnrO9K9T/hTjXW/zMs
 S9Wfowt4Kmk+bT
X-Received: by 2002:a05:6000:22c7:b0:472:8343:7f5e with SMTP id
 ffacd0b85a97d-47f2dc8ce54mr9392571f8f.5.1783941088926; 
 Mon, 13 Jul 2026 04:11:28 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1e6ccsm85132232f8f.5.2026.07.13.04.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 04:11:28 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0D80C5F7F1;
 Mon, 13 Jul 2026 12:11:27 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: gilles grimaud <gilles.grimaud@univ-lille.fr>
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,  Peter Maydell
 <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [RFC PATCH] target/arm: report M-profile BKPT to gdbstub when
 attached
In-Reply-To: <354DA850-F992-40A9-A143-F061C6D516F6@univ-lille.fr> (gilles
 grimaud's message of "Sat, 11 Jul 2026 00:19:11 +0200")
References: <20260705224407.32464-1-gilles.grimaud@univ-lille.fr>
 <CAFEAcA9Heev=ydTzO2u3EzeF_2q7dytOF8=67qF8ZMMY6Ky2Tw@mail.gmail.com>
 <a14481eb-9eed-43c0-a29c-187798f7f769@linaro.org>
 <CAFEAcA9x7tjW9xuT_XwNntdvoVtLrCL_PB+50tfhiW2XDvsCiw@mail.gmail.com>
 <F797F544-7BE3-4478-B319-0D4843095731@unpredictable.fr>
 <354DA850-F992-40A9-A143-F061C6D516F6@univ-lille.fr>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Mon, 13 Jul 2026 12:11:26 +0100
Message-ID: <87ech7cffl.fsf@draig.linaro.org>
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

gilles grimaud <gilles.grimaud@univ-lille.fr> writes:

> Thanks everyone for the detailed comments.
>
> Let me try to summarize where I think the discussion stands, and then go =
through the questions that have emerged, from the most
> specific ones to the more general and still unresolved ones.
>
> My RFC originally came from reading QEMU's gdbstub as, at least conceptua=
lly, an analogue of an external low-level debugger such as
> a JTAG-attached debugger. From that perspective, having an attached GDB c=
lient consume a guest BKPT used as an external
> debugger stop point seemed natural.
>
<snip>
>
> ```
> Should the external debugger get a first chance to consume the debug even=
t,
> and if it does not, should the event be reinjected into the guest?
> ```
>
> For Cortex-M, a rule that simply maps every BKPT to EXCP_DEBUG whenever G=
DB is attached could clearly steal an exception that
> should have remained guest-visible.
>
> This means that any generic abstraction would need to define not only whe=
n an external debugger may intercept a guest breakpoint
> instruction, but also what happens when it does not consume it.
>
> 5. Should QEMU's gdbstub be modelled as an external debug monitor?
>
> This now seems to me to be the most general question behind the RFC.
>
> If the answer is yes, then some variant of the behaviour I proposed seems=
 natural: a breakpoint instruction that would be consumed
> by an external debugger on real hardware should be reportable to an attac=
hed GDB client.
>
> If the answer is no, then I think we need to clarify what the intended re=
lationship is between QEMU's gdbstub and the architecture's
> external debug facilities.
>
> Alex's remark captures the current situation well:
>
>> "We could treat gdbstub as an external debug monitor but we don't curren=
tly model it as such."
>
> So perhaps the main remaining design question is where this abstraction s=
hould live.
>
> Should target-specific code directly know whether GDB is attached, as in =
my RFC?
>
> Or should there be a generic QEMU debug layer representing an external de=
bugger, with target code only reporting
> architecture-specific debug events and deciding, from architectural state=
, whether they are eligible for external interception?
>
> The latter seems cleaner to me, especially if the same issue exists for A=
rm BKPT, RISC-V EBREAK, and breakpoint instructions on other
> architectures.
>
> My current feeling is therefore that the original RFC probably puts the f=
ix too low and too specifically in the Arm code, but that the
> underlying problem remains real: QEMU does not appear to have a clearly d=
efined generic model for what should happen when guest
> code deliberately executes a breakpoint instruction while an external GDB=
 client is attached.
>
> ----
>
> I have tried to summarize the discussion as faithfully as possible, as I =
was beginning to lose track of the different points and positions.
>
> This leaves me with one final question, which may actually be the key to =
choosing between the possible models discussed above.
>
> Even if you decide that QEMU's gdbstub should represent an external debug=
ger, what exactly should that imply?
>
> Does attaching a GDB client itself mean that architectural external halti=
ng debug is active, so that eligible guest breakpoint instructions
> should naturally be consumed by the external debugger?
>
> Or does it only mean that an external debugger is available, while actual=
 interception must still depend on the architectural debug
> state, such as DHCSR.C_DEBUGEN and the relevant architecture-specific con=
figuration?
>
> My original patch implicitly assumes the first model:
>
> GDB attached
>     =3D> external halting debug active
>     =3D> M-profile BKPT is reported to GDB
>
> But the discussion around DHCSR, DEMCR, self-hosted debugging, and the ro=
le of the gdbstub suggests that this equivalence may be
> exactly what needs to be decided first.
>
> Perhaps answering this question would also tell us where the abstraction =
should live: either directly in target-specific exception
> handling, or in a more generic QEMU external-debug layer with
> architecture-specific eligibility rules.

I think if the gdbstub is going to intercept what would otherwise be
guest visible exceptions then that should be opt-in behaviour via some
sort of flag for gdbstub. Otherwise guests will get confused when they
miss them. For example we know Windows uses breakpoints during its
boot-up for some sort of internal book keeping.

While giving the option to intercept guest visible exceptions in gdbstub
could be done globally if we want to properly model the external debug
interface we probably need to come up with some new API's between
gdbstub and the guest architecture.

For example on ARM the guest can make changes to register state to limit
what the external debugger can do. I see arm_debug_check_breakpoints
does call arm_generate_debug_exceptions which takes into account the
state of OSLAR_EL1. Would anyone actually want to model
DBGAUTHSTATUS_EL1 which can limit which worlds the debugger can see?
Generally the big benefit of using gdbstub with emulation is you do get
full visibility of the system which is helpful when debugging low level
code. Also most of this stuff seems to be very IMPDEF which is not
normally something QEMU needs to worry about.


>
> Have I missed an important case or misunderstood the emerging consensus h=
ere?
>
> Thanks again for the discussion,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

