Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD53C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJZI-000503-Ps; Fri, 10 Jul 2026 18:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1wiJZE-0004wr-8D; Fri, 10 Jul 2026 18:19:32 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1wiJZ9-0005EE-DS; Fri, 10 Jul 2026 18:19:32 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4gxmTQ0bpcz7tZ8;
 Sat, 11 Jul 2026 00:19:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1783721962;
 bh=Pm0gWdyOlKOjvs+f+QOFzEFKg1RprWe9S1z+QJCAOsQ=;
 h=From:Subject:Date:In-Reply-To:Cc:To:References:From;
 b=vEr9xEMQEk8D3iBT/vr1aTOs9WKHyKsbUaLz0PyGhqXZy6oMeGPAkigUONNjw3i4S
 /0R1auNS19FLpurxM/cjhrCjrr77Zjl0M0ZuBSoQmMbaWC/sxqWN0KvfuKTQreWSxQ
 NPerK1n6gi3yWyQnaiXxcVPRA/JJUyuUNgS4q8/7n1ixtmvLRb18J0nh+KjNeXriL/
 jl/UayjcCEqsnA9+VXrr7/d3BkHAt8XuTDbH4S5a+WSNSec5SLCTn7+qXRKs/OaaKJ
 jkLbxnu8u9BHqmNyiWTYT9n3uV+ehqiMx2+KJjAwtN89K+5+yamG5oDrORruPA2xKC
 gMN9BhRP9uQ5Q==
Received: from smtpclient.apple (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4gxmTP5cZcz7vn9;
 Sat, 11 Jul 2026 00:19:21 +0200 (CEST)
From: gilles grimaud <gilles.grimaud@univ-lille.fr>
Message-Id: <354DA850-F992-40A9-A143-F061C6D516F6@univ-lille.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_35B17FC6-321D-4C5B-9BDA-D5B304FBA657"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [RFC PATCH] target/arm: report M-profile BKPT to gdbstub when
 attached
Date: Sat, 11 Jul 2026 00:19:11 +0200
In-Reply-To: <F797F544-7BE3-4478-B319-0D4843095731@unpredictable.fr>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260705224407.32464-1-gilles.grimaud@univ-lille.fr>
 <CAFEAcA9Heev=ydTzO2u3EzeF_2q7dytOF8=67qF8ZMMY6Ky2Tw@mail.gmail.com>
 <a14481eb-9eed-43c0-a29c-187798f7f769@linaro.org>
 <CAFEAcA9x7tjW9xuT_XwNntdvoVtLrCL_PB+50tfhiW2XDvsCiw@mail.gmail.com>
 <F797F544-7BE3-4478-B319-0D4843095731@unpredictable.fr>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=194.254.129.106;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-2.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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


--Apple-Mail=_35B17FC6-321D-4C5B-9BDA-D5B304FBA657
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


Thanks everyone for the detailed comments.

Let me try to summarize where I think the discussion stands, and then go =
through the questions that have emerged, from the most specific ones to =
the more general and still unresolved ones.

My RFC originally came from reading QEMU's gdbstub as, at least =
conceptually, an analogue of an external low-level debugger such as a =
JTAG-attached debugger. =46rom that perspective, having an attached GDB =
client consume a guest BKPT used as an external debugger stop point =
seemed natural.

The discussion has made clear that this assumption is precisely where =
the issue lies.

Alex pointed out that:

> "We could treat gdbstub as an external debug monitor but we don't =
currently model it as such."

Richard was more skeptical about whether QEMU should reproduce this =
behaviour at all, describing the patch as attempting to replicate a case =
where a guest BKPT is trapped by an external debugger, and adding:

> "The only question is whether we want to follow that, and I suspect =
the answer is no."

On the other hand, Mohamed pointed out that this is a typical Cortex-M =
debugging pattern, supported by the architectural behaviour of BKPT, and =
argued that QEMU's gdbstub matching the behaviour of an OpenOCD-provided =
GDB stub would be desirable.

Peter also broadened the issue beyond the Pico case, asking whether =
breakpoint instructions are not generally expected to be trapped by an =
external JTAG debugger, and expressing surprise that QEMU does not =
already handle this.

So, at this point, I think the RFC has raised the following questions.

1. Is semihosting an alternative here?

Alex mentioned semihosting as the mechanism normally used when code =
running on real hardware requests a service from a JTAG-attached =
debugger.

I agree that semihosting addresses a related class of interactions, but =
I do not think it is an alternative for this particular problem, as Alex =
also qualified with "not for breakpoints".

The goal here is precisely to run existing firmware unchanged. The Pico =
SDK already deliberately executes BKPT in its exit/debug path, and =
replacing that mechanism with semihosting would change the guest =
software rather than reproduce its existing behaviour.

So I think this particular question is mostly resolved: semihosting is =
relevant context, but not a transparent replacement for guest breakpoint =
instructions already present in existing firmware.

2. Is this problem specific to the Pico, or even to Arm M-profile?

I initially encountered the problem while working on RP2040 support, but =
the discussion strongly suggests that the underlying issue is more =
general.

I had already noted the analogous use of EBREAK on RISC-V, for example =
on RP2350 firmware.

Mohamed also described the x86 case, where QEMU distinguishes different =
kinds of breakpoint instructions and traps guest debug exceptions when =
GDB is attached, while noting the additional problem of reinjecting =
exceptions that are not intended for the external debugger.

Peter's comment also points in this direction:

> "But aren't breakpoint instructions of all kinds typically trapped to =
the external jtag debugger, on any architecture ? I'm a bit surprised =
that we don't do this already."

So my current understanding is that the problem should probably not be =
framed as an Arm M-profile-specific one.

If that is correct, then my current patch is addressing the issue at the =
wrong abstraction level by adding Arm-specific knowledge directly in =
target/arm/tcg/debug.c. I was in fact already expecting to face the same =
question for RISC-V EBREAK.

This would suggest that QEMU may instead need a more explicitly defined =
generic policy for guest breakpoint instructions executed while an =
external GDB client is attached, with architecture-specific code only =
deciding whether a particular debug event is eligible for external =
interception.

3. Which architectural state should control the interception?

Even if we agree that a guest breakpoint instruction may be consumed by =
an external debugger, my original condition is clearly too simple:

```
arm_feature(env, ARM_FEATURE_M) && gdb_cpu_is_attached(cs)
```

Alex explicitly mentioned DHCSR, DEMCR, and IMPDEF behaviour.

Mohamed cited, in particular, the architectural role of DHCSR.C_DEBUGEN =
and the Armv8-M rule that BKPT may lead either to debug halt, =
DebugMonitor, HardFault, or lockup depending on the debug configuration.

So the technical question is not merely whether a GDB client is =
attached. It is also which architectural state QEMU should take into =
account when deciding whether the breakpoint is consumed by the external =
debugger.

For Arm M-profile, this seems to include at least questions around:

* DHCSR.C_DEBUGEN;
* whether halting debug is enabled or permitted in the current processor =
state;
* DEMCR and DebugMonitor configuration;
* possible architecture-version-specific or IMPDEF behaviour.

This raises another conceptual question: should attaching GDB to QEMU =
merely make an external debugger available, or should it also imply some =
architectural debug configuration equivalent to what a real debug probe =
would establish?

4. How should self-hosted debugging be preserved?

This seems to me the main practical difficulty.

Peter explicitly pointed out that a guest breakpoint instruction may =
belong to a debugger running inside the guest itself.

Mohamed's x86 example makes the problem particularly clear: QEMU may =
first intercept a debug exception while GDB is attached, but if that =
exception is not intended for the external debugger, it must remain =
visible to the guest. Mohamed also mentioned that there is currently a =
bug in the x86 path where some such exceptions are ignored instead of =
reinjected.

So perhaps the real question is not simply:

```
external debugger or guest exception?
```

but rather:

```
Should the external debugger get a first chance to consume the debug =
event,
and if it does not, should the event be reinjected into the guest?
```

For Cortex-M, a rule that simply maps every BKPT to EXCP_DEBUG whenever =
GDB is attached could clearly steal an exception that should have =
remained guest-visible.

This means that any generic abstraction would need to define not only =
when an external debugger may intercept a guest breakpoint instruction, =
but also what happens when it does not consume it.

5. Should QEMU's gdbstub be modelled as an external debug monitor?

This now seems to me to be the most general question behind the RFC.

If the answer is yes, then some variant of the behaviour I proposed =
seems natural: a breakpoint instruction that would be consumed by an =
external debugger on real hardware should be reportable to an attached =
GDB client.

If the answer is no, then I think we need to clarify what the intended =
relationship is between QEMU's gdbstub and the architecture's external =
debug facilities.

Alex's remark captures the current situation well:

> "We could treat gdbstub as an external debug monitor but we don't =
currently model it as such."

So perhaps the main remaining design question is where this abstraction =
should live.

Should target-specific code directly know whether GDB is attached, as in =
my RFC?

Or should there be a generic QEMU debug layer representing an external =
debugger, with target code only reporting architecture-specific debug =
events and deciding, from architectural state, whether they are eligible =
for external interception?

The latter seems cleaner to me, especially if the same issue exists for =
Arm BKPT, RISC-V EBREAK, and breakpoint instructions on other =
architectures.

My current feeling is therefore that the original RFC probably puts the =
fix too low and too specifically in the Arm code, but that the =
underlying problem remains real: QEMU does not appear to have a clearly =
defined generic model for what should happen when guest code =
deliberately executes a breakpoint instruction while an external GDB =
client is attached.

----

I have tried to summarize the discussion as faithfully as possible, as I =
was beginning to lose track of the different points and positions.

This leaves me with one final question, which may actually be the key to =
choosing between the possible models discussed above.

Even if you decide that QEMU's gdbstub should represent an external =
debugger, what exactly should that imply?

Does attaching a GDB client itself mean that architectural external =
halting debug is active, so that eligible guest breakpoint instructions =
should naturally be consumed by the external debugger?

Or does it only mean that an external debugger is available, while =
actual interception must still depend on the architectural debug state, =
such as DHCSR.C_DEBUGEN and the relevant architecture-specific =
configuration?

My original patch implicitly assumes the first model:

GDB attached
    =3D> external halting debug active
    =3D> M-profile BKPT is reported to GDB

But the discussion around DHCSR, DEMCR, self-hosted debugging, and the =
role of the gdbstub suggests that this equivalence may be exactly what =
needs to be decided first.

Perhaps answering this question would also tell us where the abstraction =
should live: either directly in target-specific exception handling, or =
in a more generic QEMU external-debug layer with architecture-specific =
eligibility rules.

Have I missed an important case or misunderstood the emerging consensus =
here?

Thanks again for the discussion,
--
Gilles




> Le 8 juil. 2026 =C3=A0 12:10, Mohamed Mediouni =
<mohamed@unpredictable.fr> a =C3=A9crit :
>=20
>=20
>=20
>> On 8. Jul 2026, at 11:31, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>>=20
>> On Tue, 7 Jul 2026 at 18:27, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>=20
>>> On 7/6/26 02:21, Peter Maydell wrote:
>>>> No other architecture, CPU or board in QEMU needs to do this,
>>>> so my instinct is to say that M-profile should not be special here.
>>>> Richard, Alex: how do we usually handle breakpoint insns for the
>>>> gdbstub ?
>>>=20
>>> We handle them via CPUBreakpoint structures; we never inject code =
changes.
>>=20
>> I don't mean "breakpoints that the gdbstub requests", I mean
>> "breakpoint insns that are already in the guest code that get
>> executed".
>>=20
>>> The patch description explains the confusion: this is attempting to =
replicate a feature of
>>> the Raspberry Pi Pico SDK, wherein a guest BPKT really is trapped by =
an external debugger.
>>=20
>> But aren't breakpoint instructions of all kinds typically trapped
>> to the external jtag debugger, on any architecture ? I'm a bit
>> surprised that we don't do this already.
>=20
> Some context on the gdbstub implementation from the x86 side:
>=20
> WHPX's gdbstub support is implemented with overriding the instruction
> instead of leveraging HW breakpoints - although a bit hackily.
>=20
> A big concern is still allowing self-hosted debug to work fine which
> makes things a bit harder.
>=20
> x86 makes things easier by having multiple different breakpoint =
instructions.
> Linux uses int3 and we use int1*  for QEMU gdbstub-controlled =
breakpoints so
> that things (mostly) work out for everyone.
>=20
> And then, QEMU traps all debug exceptions from the guest when gdb is =
attached
> and is supposed to take action when it=E2=80=99s an int1 breakpoint =
and not others.
>=20
> Although we currently have a bug there that the non int1s just get =
ignored
> instead of being injected back.
>=20
> * on x86, the Intel manual says "Hardware vendors may use the INT1 =
instruction for hardware debug"=20
>=20
> On Cortex-M self-hosted debug is far less used than for emulating =
bigger chips.
>=20
> And then there=E2=80=99s emulating such a thing using hardware virt =
and using HW breakpoints
> which quickly becomes quite complicated...


--Apple-Mail=_35B17FC6-321D-4C5B-9BDA-D5B304FBA657
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div>
<meta charset=3D"UTF-8"><div><div>Thanks everyone for the detailed =
comments.</div><div><br></div><div>Let me try to summarize where I think =
the discussion stands, and then go through the questions that have =
emerged, from the most specific ones to the more general and still =
unresolved ones.</div><div><br></div><div>My RFC originally came from =
reading QEMU's gdbstub as, at least conceptually, an analogue of an =
external low-level debugger such as a JTAG-attached debugger. =46rom =
that perspective, having an attached GDB client consume a guest BKPT =
used as an external debugger stop point seemed =
natural.</div><div><br></div><div>The discussion has made clear that =
this assumption is precisely where the issue =
lies.</div><div><br></div><div>Alex pointed out =
that:</div><div><br></div><div>&gt; "We could treat gdbstub as an =
external debug monitor but we don't currently model it as =
such."</div><div><br></div><div>Richard was more skeptical about whether =
QEMU should reproduce this behaviour at all, describing the patch as =
attempting to replicate a case where a guest BKPT is trapped by an =
external debugger, and adding:</div><div><br></div><div>&gt; "The only =
question is whether we want to follow that, and I suspect the answer is =
no."</div><div><br></div><div>On the other hand, Mohamed pointed out =
that this is a typical Cortex-M debugging pattern, supported by the =
architectural behaviour of BKPT, and argued that QEMU's gdbstub matching =
the behaviour of an OpenOCD-provided GDB stub would be =
desirable.</div><div><br></div><div>Peter also broadened the issue =
beyond the Pico case, asking whether breakpoint instructions are not =
generally expected to be trapped by an external JTAG debugger, and =
expressing surprise that QEMU does not already handle =
this.</div><div><br></div><div>So, at this point, I think the RFC has =
raised the following questions.</div><div><br></div><div>1. Is =
semihosting an alternative here?</div><div><br></div><div>Alex mentioned =
semihosting as the mechanism normally used when code running on real =
hardware requests a service from a JTAG-attached =
debugger.</div><div><br></div><div>I agree that semihosting addresses a =
related class of interactions, but I do not think it is an alternative =
for this particular problem, as Alex also qualified with "not for =
breakpoints".</div><div><br></div><div>The goal here is precisely to run =
existing firmware unchanged. The Pico SDK already deliberately executes =
BKPT in its exit/debug path, and replacing that mechanism with =
semihosting would change the guest software rather than reproduce its =
existing behaviour.</div><div><br></div><div>So I think this particular =
question is mostly resolved: semihosting is relevant context, but not a =
transparent replacement for guest breakpoint instructions already =
present in existing firmware.</div><div><br></div><div>2. Is this =
problem specific to the Pico, or even to Arm =
M-profile?</div><div><br></div><div>I initially encountered the problem =
while working on RP2040 support, but the discussion strongly suggests =
that the underlying issue is more general.</div><div><br></div><div>I =
had already noted the analogous use of EBREAK on RISC-V, for example on =
RP2350 firmware.</div><div><br></div><div>Mohamed also described the x86 =
case, where QEMU distinguishes different kinds of breakpoint =
instructions and traps guest debug exceptions when GDB is attached, =
while noting the additional problem of reinjecting exceptions that are =
not intended for the external debugger.</div><div><br></div><div>Peter's =
comment also points in this direction:</div><div><br></div><div>&gt; =
"But aren't breakpoint instructions of all kinds typically trapped to =
the external jtag debugger, on any architecture ? I'm a bit surprised =
that we don't do this already."</div><div><br></div><div>So my current =
understanding is that the problem should probably not be framed as an =
Arm M-profile-specific one.</div><div><br></div><div>If that is correct, =
then my current patch is addressing the issue at the wrong abstraction =
level by adding Arm-specific knowledge directly in =
target/arm/tcg/debug.c. I was in fact already expecting to face the same =
question for RISC-V EBREAK.</div><div><br></div><div>This would suggest =
that QEMU may instead need a more explicitly defined generic policy for =
guest breakpoint instructions executed while an external GDB client is =
attached, with architecture-specific code only deciding whether a =
particular debug event is eligible for external =
interception.</div><div><br></div><div>3. Which architectural state =
should control the interception?</div><div><br></div><div>Even if we =
agree that a guest breakpoint instruction may be consumed by an external =
debugger, my original condition is clearly too =
simple:</div><div><br></div><div>```</div><div>arm_feature(env, =
ARM_FEATURE_M) &amp;&amp; =
gdb_cpu_is_attached(cs)</div><div>```</div><div><br></div><div>Alex =
explicitly mentioned DHCSR, DEMCR, and IMPDEF =
behaviour.</div><div><br></div><div>Mohamed cited, in particular, the =
architectural role of DHCSR.C_DEBUGEN and the Armv8-M rule that BKPT may =
lead either to debug halt, DebugMonitor, HardFault, or lockup depending =
on the debug configuration.</div><div><br></div><div>So the technical =
question is not merely whether a GDB client is attached. It is also =
which architectural state QEMU should take into account when deciding =
whether the breakpoint is consumed by the external =
debugger.</div><div><br></div><div>For Arm M-profile, this seems to =
include at least questions around:</div><div><br></div><div>* =
DHCSR.C_DEBUGEN;</div><div>* whether halting debug is enabled or =
permitted in the current processor state;</div><div>* DEMCR and =
DebugMonitor configuration;</div><div>* possible =
architecture-version-specific or IMPDEF =
behaviour.</div><div><br></div><div>This raises another conceptual =
question: should attaching GDB to QEMU merely make an external debugger =
available, or should it also imply some architectural debug =
configuration equivalent to what a real debug probe would =
establish?</div><div><br></div><div>4. How should self-hosted debugging =
be preserved?</div><div><br></div><div>This seems to me the main =
practical difficulty.</div><div><br></div><div>Peter explicitly pointed =
out that a guest breakpoint instruction may belong to a debugger running =
inside the guest itself.</div><div><br></div><div>Mohamed's x86 example =
makes the problem particularly clear: QEMU may first intercept a debug =
exception while GDB is attached, but if that exception is not intended =
for the external debugger, it must remain visible to the guest. Mohamed =
also mentioned that there is currently a bug in the x86 path where some =
such exceptions are ignored instead of =
reinjected.</div><div><br></div><div>So perhaps the real question is not =
simply:</div><div><br></div><div>```</div><div>external debugger or =
guest exception?</div><div>```</div><div><br></div><div>but =
rather:</div><div><br></div><div>```</div><div>Should the external =
debugger get a first chance to consume the debug event,</div><div>and if =
it does not, should the event be reinjected into the =
guest?</div><div>```</div><div><br></div><div>For Cortex-M, a rule that =
simply maps every BKPT to EXCP_DEBUG whenever GDB is attached could =
clearly steal an exception that should have remained =
guest-visible.</div><div><br></div><div>This means that any generic =
abstraction would need to define not only when an external debugger may =
intercept a guest breakpoint instruction, but also what happens when it =
does not consume it.</div><div><br></div><div>5. Should QEMU's gdbstub =
be modelled as an external debug monitor?</div><div><br></div><div>This =
now seems to me to be the most general question behind the =
RFC.</div><div><br></div><div>If the answer is yes, then some variant of =
the behaviour I proposed seems natural: a breakpoint instruction that =
would be consumed by an external debugger on real hardware should be =
reportable to an attached GDB client.</div><div><br></div><div>If the =
answer is no, then I think we need to clarify what the intended =
relationship is between QEMU's gdbstub and the architecture's external =
debug facilities.</div><div><br></div><div>Alex's remark captures the =
current situation well:</div><div><br></div><div>&gt; "We could treat =
gdbstub as an external debug monitor but we don't currently model it as =
such."</div><div><br></div><div>So perhaps the main remaining design =
question is where this abstraction should =
live.</div><div><br></div><div>Should target-specific code directly know =
whether GDB is attached, as in my RFC?</div><div><br></div><div>Or =
should there be a generic QEMU debug layer representing an external =
debugger, with target code only reporting architecture-specific debug =
events and deciding, from architectural state, whether they are eligible =
for external interception?</div><div><br></div><div>The latter seems =
cleaner to me, especially if the same issue exists for Arm BKPT, RISC-V =
EBREAK, and breakpoint instructions on other =
architectures.</div><div><br></div><div>My current feeling is therefore =
that the original RFC probably puts the fix too low and too specifically =
in the Arm code, but that the underlying problem remains real: QEMU does =
not appear to have a clearly defined generic model for what should =
happen when guest code deliberately executes a breakpoint instruction =
while an external GDB client is =
attached.</div><div><br></div><div>----</div><div><br></div><div>I have =
tried to summarize the discussion as faithfully as possible, as I was =
beginning to lose track of the different points and =
positions.</div><div><br></div><div><div>This leaves me with one final =
question, which may actually be the key to choosing between the possible =
models discussed above.</div><div><br></div><div>Even if you decide that =
QEMU's gdbstub should represent an external debugger, what exactly =
should that imply?</div><div><br></div><div>Does attaching a GDB client =
itself mean that architectural external halting debug is active, so that =
eligible guest breakpoint instructions should naturally be consumed by =
the external debugger?</div><div><br></div><div>Or does it only mean =
that an external debugger is available, while actual interception must =
still depend on the architectural debug state, such as DHCSR.C_DEBUGEN =
and the relevant architecture-specific =
configuration?</div><div><br></div><div>My original patch implicitly =
assumes the first model:</div><div><br></div><div>GDB =
attached</div><div>&nbsp; &nbsp; =3D&gt; external halting debug =
active</div><div>&nbsp; &nbsp; =3D&gt; M-profile BKPT is reported to =
GDB</div><div><br></div><div>But the discussion around DHCSR, DEMCR, =
self-hosted debugging, and the role of the gdbstub suggests that this =
equivalence may be exactly what needs to be decided =
first.</div><div><br></div><div>Perhaps answering this question would =
also tell us where the abstraction should live: either directly in =
target-specific exception handling, or in a more generic QEMU =
external-debug layer with architecture-specific eligibility =
rules.</div><div><br></div></div><div>Have I missed an important case or =
misunderstood the emerging consensus =
here?</div><div><br></div><div>Thanks again for the =
discussion,</div><div>--</div><div>Gilles</div><div><br></div></div><div><=
br></div><br class=3D"Apple-interchange-newline">
</div>
<div><br><blockquote type=3D"cite"><div>Le 8 juil. 2026 =C3=A0 12:10, =
Mohamed Mediouni &lt;mohamed@unpredictable.fr&gt; a =C3=A9crit =
:</div><br class=3D"Apple-interchange-newline"><div><meta =
charset=3D"UTF-8"><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: solid;">On =
8. Jul 2026, at 11:31, Peter Maydell &lt;peter.maydell@linaro.org&gt; =
wrote:<br><br>On Tue, 7 Jul 2026 at 18:27, Richard =
Henderson<br>&lt;richard.henderson@linaro.org&gt; wrote:<br><blockquote =
type=3D"cite"><br>On 7/6/26 02:21, Peter Maydell wrote:<br><blockquote =
type=3D"cite">No other architecture, CPU or board in QEMU needs to do =
this,<br>so my instinct is to say that M-profile should not be special =
here.<br>Richard, Alex: how do we usually handle breakpoint insns for =
the<br>gdbstub ?<br></blockquote><br>We handle them via CPUBreakpoint =
structures; we never inject code changes.<br></blockquote><br>I don't =
mean "breakpoints that the gdbstub requests", I mean<br>"breakpoint =
insns that are already in the guest code that =
get<br>executed".<br><br><blockquote type=3D"cite">The patch description =
explains the confusion: this is attempting to replicate a feature =
of<br>the Raspberry Pi Pico SDK, wherein a guest BPKT really is trapped =
by an external debugger.<br></blockquote><br>But aren't breakpoint =
instructions of all kinds typically trapped<br>to the external jtag =
debugger, on any architecture ? I'm a bit<br>surprised that we don't do =
this already.<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Some context on the gdbstub implementation =
from the x86 side:</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">WHPX's gdbstub support is implemented with =
overriding the instruction</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">instead of leveraging HW breakpoints - =
although a bit hackily.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">A big concern is still allowing self-hosted =
debug to work fine which</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">makes things a bit harder.</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">x86 makes things easier by having multiple =
different breakpoint instructions.</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Linux uses int3 and we use int1* &nbsp;for =
QEMU gdbstub-controlled breakpoints so</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">that things (mostly) work out for =
everyone.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">And then, QEMU traps all debug exceptions =
from the guest when gdb is attached</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">and is supposed to take action when it=E2=80=99=
s an int1 breakpoint and not others.</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Although we currently have a bug there that =
the non int1s just get ignored</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">instead of being injected back.</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">* on x86, the Intel manual says "Hardware =
vendors may use the INT1 instruction for hardware debug"<span =
class=3D"Apple-converted-space">&nbsp;</span></span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">On Cortex-M self-hosted debug is far less =
used than for emulating bigger chips.</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">And then there=E2=80=99s emulating such a =
thing using hardware virt and using HW breakpoints</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">which quickly becomes quite =
complicated...</span></div></blockquote></div><br></body></html>=

--Apple-Mail=_35B17FC6-321D-4C5B-9BDA-D5B304FBA657--

