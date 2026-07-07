Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03404C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh9qA-0003b1-7l; Tue, 07 Jul 2026 13:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1wh9q7-0003aA-7V; Tue, 07 Jul 2026 13:44:11 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1wh9q4-0008Pk-9H; Tue, 07 Jul 2026 13:44:10 -0400
Received: from smtp02.univ-lille.fr (smtp02.univ-lille.fr [194.254.129.96])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4gvpW846SBzBsGC;
 Tue,  7 Jul 2026 19:44:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1783446244;
 bh=hrz5pfiNV4fVj4kWCkfW/dDH1+4ZDQBQ82RxZJvmuxU=;
 h=From:Subject:Date:In-Reply-To:Cc:To:References:From;
 b=RC0n+hR2+iS1Z4CEuWeweHphjQgDgRgUHAy0Ft17selRImcLTZ2KYhljjUHZlrYq4
 hSE1LWZEubC5WDz47xAMWrhxBvFAWuamrd9UeAOnQo1CgXuz8HqrA2A+lxLZakTkcK
 Bx4tgA4Y+1rox5JIQbWPfk0AigHOJGDl+AfU2NvGxhRJlxO0GUFAwGnMDhbvaDthY6
 Q0/hnR25ZIIgSVEfqAVAMx87XBHw2Sq4kcCHh2r6PxIkNL5E5YlqBRpOKmp/dStX+E
 WoLOwtI5nGlAD2vWroA3BTdgLLbhSKrRk+KifDtKiGihyOXrNYMQ/D6d9FG8xsPHlk
 94JxIZsaKSkHw==
Received: from smtpclient.apple (unknown [134.206.211.23])
 (Authenticated sender: gilles.grimaud)
 by smtp02.univ-lille.fr (Postfix) with ESMTPSA id 4gvpW82kDjz6syF;
 Tue,  7 Jul 2026 19:44:04 +0200 (CEST)
From: gilles grimaud <gilles.grimaud@univ-lille.fr>
Message-Id: <74CAA1D6-D549-4063-A8D2-98818ED474C9@univ-lille.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_4596B68F-0EDB-45C7-B343-6F609C2869EF"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [RFC PATCH] target/arm: report M-profile BKPT to gdbstub when
 attached
Date: Tue, 7 Jul 2026 19:43:54 +0200
In-Reply-To: <a14481eb-9eed-43c0-a29c-187798f7f769@linaro.org>
Cc: qemu-arm@nongnu.org
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260705224407.32464-1-gilles.grimaud@univ-lille.fr>
 <CAFEAcA9Heev=ydTzO2u3EzeF_2q7dytOF8=67qF8ZMMY6Ky2Tw@mail.gmail.com>
 <a14481eb-9eed-43c0-a29c-187798f7f769@linaro.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=194.254.129.82;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-1.univ-lille.fr
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


--Apple-Mail=_4596B68F-0EDB-45C7-B343-6F609C2869EF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Thanks for the comments.

Since this is an RFC, this is exactly the kind of guidance I=E2=80=99m =
looking for.
I am new to QEMU, so I am mainly trying to understand what the right =
model
should be if this patch is not the right approach.

To clarify the motivation: I hit this while working on RP2040/Pico =
support,
but I do not think the issue is RP2040-specific. The Pico SDK uses a
breakpoint instruction as part of its normal exit/debug path. On Arm
M-profile this is BKPT; on RP2350/RISC-V the analogous pattern use
EBREAK.

So the practical question for me is how QEMU should model firmware that
deliberately executes a breakpoint instruction as a debugger stop point =
through
The J-TAG.

For Arm M-profile, my understanding is that BKPT can be consumed by the
debug system when an external debugger is present, otherwise it follows =
the
architectural guest exception path. I was led to this interpretation =
partly
by QEMU's own gdbstub documentation, which describes the gdbstub as a
low-level debugging facility in the same general space as JTAG-style
debugging.

That led me to the proposed rule:

  M-profile guest BKPT + attached QEMU gdbstub client:
      report a stop to the gdbstub

  otherwise:
      keep the existing architectural guest-visible path

I understand Peter's point that guest breakpoint instructions may also =
be
part of a guest-visible debugging mechanism, for example with a debugger
running inside the guest. This RFC was not trying to solve that broader
problem.

If there is a better way to emulate this bare-metal firmware pattern,
ideally without touching QEMU's normal execution path, I would be very
happy to drop this RFC and try that instead.

Thanks again for your time,
Gilles


> Le 7 juil. 2026 =C3=A0 19:27, Richard Henderson =
<richard.henderson@linaro.org> a =C3=A9crit :
>=20
> On 7/6/26 02:21, Peter Maydell wrote:
>> On Sun, 5 Jul 2026 at 23:44, Gilles Grimaud
>> <gilles.grimaud@univ-lille.fr> wrote:
>>>=20
>>> While working on Raspberry Pi Pico/RP2040 support, I noticed that =
Pico SDK
>>> programs deliberately execute BKPT from _exit(). On real hardware =
this is
>>> useful when a debug probe is attached: returning from main() stops =
the
>>> debugger at the program exit point.
>>>=20
>>> Under QEMU this currently does not behave like the debug-probe case. =
For
>>> M-profile guests, the BKPT instruction is routed through the =
architectural
>>> guest debug exception path. Without halting debug, that path should =
remain a
>>> guest-visible DebugMonitor exception when DebugMonitor is enabled, =
or escalate
>>> towards HardFault otherwise. This patch deliberately leaves that =
no-debugger
>>> architectural path unchanged.
>>>=20
>>> The problem addressed here is the case where GDB is connected to =
QEMU's
>>> gdbstub. In that situation, firmware that uses BKPT as a debugger =
stop point
>>> should stop in the attached debugger. Instead, the M-profile guest =
currently
>>> continues down the guest exception path and may end in =
HardFault/lockup rather
>>> than reporting a clean trap to GDB.
>>>=20
>>> This is not specific to the RP2040 machine model. It is a generic
>>> Cortex-M/gdbstub interaction: firmware that uses BKPT as a debugger =
stop point
>>> should be reported to the attached debugger, while keeping the guest
>>> architectural exception path when no debugger is attached.
>>>=20
>>> Expose a small gdbstub helper to test whether a CPU is visible to an =
attached
>>> debugger. When an M-profile BKPT instruction is executed with such a =
debugger
>>> attached, leave the translated block with EXCP_DEBUG so the existing =
gdbstub
>>> stop path reports a trap to GDB.
>>>=20
>>> Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
>>> ---
>>>  gdbstub/gdbstub.c      | 13 ++++++++++++-
>>>  include/exec/gdbstub.h |  6 ++++++
>>>  target/arm/tcg/debug.c |  9 +++++++++
>>>  3 files changed, 27 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
>>> index c3c944e965..9f259fc005 100644
>>> --- a/gdbstub/gdbstub.c
>>> +++ b/gdbstub/gdbstub.c
>>> @@ -237,6 +237,18 @@ static GDBProcess *gdb_get_cpu_process(CPUState =
*cpu)
>>>      return gdb_get_process(gdb_get_cpu_pid(cpu));
>>>  }
>>>=20
>>> +bool gdb_cpu_is_attached(CPUState *cpu)
>>> +{
>>> +    GDBProcess *process;
>>> +
>>> +    if (!gdbserver_state.init || !cpu) {
>>> +        return false;
>>> +    }
>>> +
>>> +    process =3D gdb_get_cpu_process(cpu);
>>> +    return process && process->attached;
>>> +}
>> No other architecture, CPU or board in QEMU needs to do this,
>> so my instinct is to say that M-profile should not be special here.
>> Richard, Alex: how do we usually handle breakpoint insns for the
>> gdbstub ?
>=20
> We handle them via CPUBreakpoint structures; we never inject code =
changes.
>=20
> The patch description explains the confusion: this is attempting to =
replicate a feature of the Raspberry Pi Pico SDK, wherein a guest BPKT =
really is trapped by an external debugger.
>=20
> The only question is whether we want to follow that, and I suspect the =
answer is no.
>=20
>=20
> r~


--Apple-Mail=_4596B68F-0EDB-45C7-B343-6F609C2869EF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><div>Thanks for the =
comments.</div><div><br></div><div>Since this is an RFC, this is exactly =
the kind of guidance I=E2=80=99m looking for.</div><div>I am new to =
QEMU, so I am mainly trying to understand what the right =
model</div><div>should be if this patch is not the right =
approach.</div><div><br></div><div>To clarify the motivation: I hit this =
while working on RP2040/Pico support,</div><div>but I do not think the =
issue is RP2040-specific. The Pico SDK uses a</div><div>breakpoint =
instruction as part of its normal exit/debug path. On =
Arm</div><div>M-profile this is BKPT; on RP2350/RISC-V the analogous =
pattern use</div><div>EBREAK.</div><div><br></div><div>So the practical =
question for me is how QEMU should model firmware =
that</div><div>deliberately executes a breakpoint instruction as a =
debugger stop point through</div><div>The =
J-TAG.</div><div><br></div><div><div>For Arm M-profile, my understanding =
is that BKPT can be consumed by the</div><div>debug system when an =
external debugger is present, otherwise it follows =
the</div><div>architectural guest exception path. I was led to this =
interpretation partly</div><div>by QEMU's own gdbstub documentation, =
which describes the gdbstub as a</div><div>low-level debugging facility =
in the same general space as =
JTAG-style</div><div>debugging.</div></div><div><br></div><div>That led =
me to the proposed rule:</div><div><br></div><div>&nbsp; M-profile guest =
BKPT + attached QEMU gdbstub client:</div><div>&nbsp; &nbsp; &nbsp; =
report a stop to the gdbstub</div><div><br></div><div>&nbsp; =
otherwise:</div><div>&nbsp; &nbsp; &nbsp; keep the existing =
architectural guest-visible path</div><div><br></div><div>I understand =
Peter's point that guest breakpoint instructions may also =
be</div><div>part of a guest-visible debugging mechanism, for example =
with a debugger</div><div>running inside the guest. This RFC was not =
trying to solve that =
broader</div><div>problem.</div><div><br></div><div><div>If there is a =
better way to emulate this bare-metal firmware =
pattern,</div><div>ideally without touching QEMU's normal execution =
path, I would be very</div><div>happy to drop this RFC and try that =
instead.</div></div><div><br></div><div>Thanks again for your =
time,</div><div>Gilles</div><div><br class=3D"Apple-interchange-newline">
</div>
<div><br><blockquote type=3D"cite"><div>Le 7 juil. 2026 =C3=A0 19:27, =
Richard Henderson &lt;richard.henderson@linaro.org&gt; a =C3=A9crit =
:</div><br class=3D"Apple-interchange-newline"><div><meta =
charset=3D"UTF-8"><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">On =
7/6/26 02:21, Peter Maydell wrote:</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: solid;">On =
Sun, 5 Jul 2026 at 23:44, Gilles =
Grimaud<br>&lt;gilles.grimaud@univ-lille.fr&gt; wrote:<br><blockquote =
type=3D"cite"><br>While working on Raspberry Pi Pico/RP2040 support, I =
noticed that Pico SDK<br>programs deliberately execute BKPT from =
_exit(). On real hardware this is<br>useful when a debug probe is =
attached: returning from main() stops the<br>debugger at the program =
exit point.<br><br>Under QEMU this currently does not behave like the =
debug-probe case. For<br>M-profile guests, the BKPT instruction is =
routed through the architectural<br>guest debug exception path. Without =
halting debug, that path should remain a<br>guest-visible DebugMonitor =
exception when DebugMonitor is enabled, or escalate<br>towards HardFault =
otherwise. This patch deliberately leaves that =
no-debugger<br>architectural path unchanged.<br><br>The problem =
addressed here is the case where GDB is connected to QEMU's<br>gdbstub. =
In that situation, firmware that uses BKPT as a debugger stop =
point<br>should stop in the attached debugger. Instead, the M-profile =
guest currently<br>continues down the guest exception path and may end =
in HardFault/lockup rather<br>than reporting a clean trap to =
GDB.<br><br>This is not specific to the RP2040 machine model. It is a =
generic<br>Cortex-M/gdbstub interaction: firmware that uses BKPT as a =
debugger stop point<br>should be reported to the attached debugger, =
while keeping the guest<br>architectural exception path when no debugger =
is attached.<br><br>Expose a small gdbstub helper to test whether a CPU =
is visible to an attached<br>debugger. When an M-profile BKPT =
instruction is executed with such a debugger<br>attached, leave the =
translated block with EXCP_DEBUG so the existing gdbstub<br>stop path =
reports a trap to GDB.<br><br>Signed-off-by: Gilles Grimaud =
&lt;gilles.grimaud@univ-lille.fr&gt;<br>---<br>&nbsp;gdbstub/gdbstub.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 13 =
++++++++++++-<br>&nbsp;include/exec/gdbstub.h | &nbsp;6 =
++++++<br>&nbsp;target/arm/tcg/debug.c | &nbsp;9 +++++++++<br>&nbsp;3 =
files changed, 27 insertions(+), 1 deletion(-)<br><br>diff --git =
a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c<br>index c3c944e965..9f259fc005 =
100644<br>--- a/gdbstub/gdbstub.c<br>+++ b/gdbstub/gdbstub.c<br>@@ =
-237,6 +237,18 @@ static GDBProcess *gdb_get_cpu_process(CPUState =
*cpu)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
gdb_get_process(gdb_get_cpu_pid(cpu));<br>&nbsp;}<br><br>+bool =
gdb_cpu_is_attached(CPUState *cpu)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;GDBProcess *process;<br>+<br>+ &nbsp;&nbsp;&nbsp;if =
(!gdbserver_state.init || !cpu) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return false;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;process =3D =
gdb_get_cpu_process(cpu);<br>+ &nbsp;&nbsp;&nbsp;return process =
&amp;&amp; process-&gt;attached;<br>+}<br></blockquote>No other =
architecture, CPU or board in QEMU needs to do this,<br>so my instinct =
is to say that M-profile should not be special here.<br>Richard, Alex: =
how do we usually handle breakpoint insns for the<br>gdbstub =
?<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">We handle them via CPUBreakpoint =
structures; we never inject code changes.</span><br style=3D"caret-color: =
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
display: inline !important;">The patch description explains the =
confusion: this is attempting to replicate a feature of the Raspberry Pi =
Pico SDK, wherein a guest BPKT really is trapped by an external =
debugger.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
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
display: inline !important;">The only question is whether we want to =
follow that, and I suspect the answer is no.</span><br =
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
display: inline =
!important;">r~</span></div></blockquote></div><br></body></html>=

--Apple-Mail=_4596B68F-0EDB-45C7-B343-6F609C2869EF--

