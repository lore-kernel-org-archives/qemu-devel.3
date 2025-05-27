Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56469C54FB3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 02:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJkPz-0001oM-Ju; Mon, 26 May 2025 22:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uJkPy-0001oD-2J
 for qemu-devel@nongnu.org; Mon, 26 May 2025 22:51:54 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uJkPv-0001oE-O5
 for qemu-devel@nongnu.org; Mon, 26 May 2025 22:51:53 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-603fdd728ccso3969369a12.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 19:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748314309; x=1748919109; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zGaj5elvX7i5WoAejbcvqWKyBo7pLuzN/8QcZla0GKA=;
 b=NP1A+uFxUqMx7QVZcYX6Vveidq2M7biE7iY1Z7KiVeOGjQ4DqPPUtDyqhpX3t0TZ9E
 Lx5aozejLggrfOxt0iAtw7ie+a0152zFeWOIVufCAQ5Nd1VNS5t2HSH7B7nBw/vR35Vm
 iLS+cpfeafkFjzURMjZ5GzJPC2RdYDqkHSubezz4jlEmv6yKRc26u9wdKvjnJMqn3pKk
 mLM659K15DpWS4By5H6oZIAqiMWIvtqzfsxvAipLpq29QFsWh3GeUPiQRonedL5Z2R9r
 Gw2ECnR0ibdPnHdSb3a3neh2zUzWEAnWzKzkbxE/R7VW7oOn/T5MyGf41DSR8UuqOi3f
 fxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748314309; x=1748919109;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zGaj5elvX7i5WoAejbcvqWKyBo7pLuzN/8QcZla0GKA=;
 b=XW6MkjrC6WHyrEGMe3NuStVzp5Yoo7cYERJ7nrr3Ammxy9C9TzUJxysy2BzrFKHjNq
 k+5nkd1M+VbkzlT62T7tbqhqCfb2Yp0mcue0twJjKqpHOBdT6UA7beGDzR1Q4U0koS6d
 FhtwRvdN9ILihqHKJAY3Br5illtQQpFvl9Uafqxhe3UjoqpI7wdmtW9QB8a5JZz15ng5
 LIZEupAETt5aHr+7HTNedfdNFOH1t6+WrL4umwTuXbBqheB2bp5QYMnD3gTA1qfpJPLF
 VPlDBRhQB4xLMhqzlKC7vHVtFGTU3lml1CgB7D9ZBB66IVgf/CsQ+ZEZ1gM9ckH/+isS
 eSkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7OosRd6lLepJLy0OjkO/R9tfvF3rjN0UDjE0l642EeFvOA3A352giPGG8CdxG7DEFEB38uePDMS+4@nongnu.org
X-Gm-Message-State: AOJu0YwFH0mOzJN/KY6SVULlTjcTjb4yzTwtdBuz+vxDv0EF1btQ3YZN
 eWJ/34BOa4HxhQY2YThlSFOD3on+xGXvibwxJ51/aRiUsw14JNWZE5EBpGz6JLP6snzB9cCkWRz
 49Jaw/hi1HJEI1IpwwN5Bpv0sLj8J92c=
X-Gm-Gg: ASbGnctc10Ezsg/4iBqM2FB7qLz+qI3O5tRZOisuQMkICwsEfOnqgTa30FZ5rdztJt3
 UlfcH/t2lPX3C2vMatJFmde+cTGW25rdnsGclpxpg2V/K79LalAQzDJezQRDlHc7X1oB3zNFPxK
 HFUFpr6e7Umf87pzK0I0aINmeS4kw7CJsyC64qf7gUu7jaP+ZCvA9NlA==
X-Google-Smtp-Source: AGHT+IFoSSSG2G2WPIA5X8ryarF1GBwqVaVWQp8JQdIDnSsHAzFIIOdPvAXFcykdskzx33knHEtmcPB9DYWYHpG/J48=
X-Received: by 2002:a17:907:72cf:b0:ad2:417b:2ab5 with SMTP id
 a640c23a62f3a-ad85b32d8e0mr758411966b.60.1748314309069; Mon, 26 May 2025
 19:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250519185108.14412-1-tanishdesai37@gmail.com>
 <CAJSP0QVOSGKnt8YCay5r+HR2O6xCz9Nb5Hp4TOzsSHE9fpYgHw@mail.gmail.com>
 <CABgObfY5uMM+Z4QpxqCya8om4_=0eYFN2dnWGYD0vsYhrmaR7w@mail.gmail.com>
 <CAJSP0QXi=UbkdZ499GzMjW49UeCwvk1=EyE=51-jL-P6PH_UXQ@mail.gmail.com>
In-Reply-To: <CAJSP0QXi=UbkdZ499GzMjW49UeCwvk1=EyE=51-jL-P6PH_UXQ@mail.gmail.com>
From: Tanish Desai <tanishdesai37@gmail.com>
Date: Tue, 27 May 2025 08:21:37 +0530
X-Gm-Features: AX0GCFsYwKgqf5goWdjvsMhj0-Ru8lkI0VBQxA8YepvvYxsWE3SG37XVOps641A
Message-ID: <CAH_Y1je5u3GoaUJ3LfHxcp0MMpEjVPbGkYOw3mo8As+tEPExdg@mail.gmail.com>
Subject: Re: [PATCH] trace/simple: seperate hot paths of tracing fucntions
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Mads Ynddal <mads@ynddal.dk>
Content-Type: multipart/alternative; boundary="00000000000059105d0636152522"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=tanishdesai37@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--00000000000059105d0636152522
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Can you explain 3 more?
Pablo and I have looked into object files for one of default trace point "
trace_vhost_commit"(first tracepoint of hw/virtio) before and after making
this change and we found that by moves the hot-path check for
_simple_trace_vhost_commit into the caller (in the .h file) and leaves the
full stack-frame prologue and tracepoint body in the cold path. By inlining
only the if (trace_events_enabled()) test at the call site, we eliminate
the 11-instruction prologue overhead (stack allocation, canary load/store,
register spills, and argument masking) on every vhost commit(trace call)
when tracing is disabled.
The old disassembled code looks like this:-
0x10 stp x29, x30, [sp, #-64]! *Prologue:* allocates 64-byte frame and
saves old FP (x29) & LR (x30)
0x14 adrp x3, trace_events_enabled_count *Prologue:* computes page-base of
the trace-enable counter
0x18 adrp x2, __stack_chk_guard *Important (maybe prolog don't
know?)(stack-protector):* starts up the stack-canary load
0x1c mov x29, sp *Prologue:* sets new frame pointer
0x20 ldr x3, [x3] *Prologue:* loads the actual trace-enabled count
0x24 stp x19, x20, [sp, #16] *Prologue:* spills callee-saved regs used by
this function (x19, x20)
0x28 and w20, w0, #0xff *Tracepoint setup:* extracts the low-8 bits of arg0
as the =E2=80=9Cevent boolean=E2=80=9D
0x2c ldr x2, [x2] *Prologue (cont=E2=80=99d):* completes loading of the
stack-canary value
0x30 and w19, w1, #0xff *Tracepoint setup:* extracts low-8 bits of arg1
0x34 ldr w0, [x3] *Important:* loads the current trace-enabled flag from
memory
0x38 ldr x1, [x2] *Prologue (cont=E2=80=99d):* reads the canary
0x3c str x1, [sp, #56] *Prologue (cont=E2=80=99d):* writes the canary into =
the new
frame
0x40 mov x1, #0 *Prologue (cont=E2=80=99d):* zeroes out x1 for the upcoming=
 branch
test
0x44 cbnz w0, 0x88 *Important:* if tracing is disabled (w0=3D=3D0) skip the
heavy path entirely
Saving 11/14 instructions!Also We have not considered epilog
instructional saves
would be definitely more than 11.
Old flow: Every call does ~11 insns of prologue + tracepoint check, even if
tracing is disabled.
New flow: We inline a tiny if (trace_enabled) at the caller; only when it=
=E2=80=99s
true do you call into a full function with its prologue.(Extra instructions=
)

On Wed, May 21, 2025 at 11:46=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:

> On Tue, May 20, 2025 at 4:52=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> > Il mar 20 mag 2025, 21:01 Stefan Hajnoczi <stefanha@gmail.com> ha
> scritto:
> >>
> >> On Mon, May 19, 2025 at 2:52=E2=80=AFPM Tanish Desai <tanishdesai37@gm=
ail.com>
> wrote:
> >> >
> >> > Remove hot paths from .c file and added it in .h file to keep it
> inline.
> >>
> >> Please include performance results in the commit description so it's
> >> clear what impact this change has.
> >
> >
> > Hi Stefan,
> >
> > I am replying because I take the blame for this :) and as an example of
> how he could interact with the maintainer.
> >
> > For now we mostly looked at differences between the code that tracetool
> generates for the various backends, and the observation that some of them
> put code in the .h and some in the .c file. I explained to Tanish the
> concept of separating hot vs cold code in theory, showed him some example=
s
> in QEMU where performance measurements were done in the past, and suggest=
ed
> applying this to various backends (starting with the one with the weirdes=
t
> choice!). However we didn't do any measurement yet.
> >
> > Some possibilities that come to mind:
> >
> > 1) maybe the coroutine benchmarks are enough to show a difference, with
> some luck
> >
> > 2) a new microbenchmark (or a set of microbenchmarks that try various
> level of register pressure around the tracepoint), which would be nice to
> have anyway
>
> 2 is going above and beyond :). I'm not trying to make life hard.
>
> Another option if 1 or 2 are difficult to quantify: I'd be happy with
> just a "before" and "after" disassembly snippet from objdump showing
> that the instructions at a call site changed as intended.
>
> What I'm looking for is a commit description that explains the purpose
> of the commit followed by, since this is a performance improvement,
> some form of evidence that the change achieved its goal. At that point
> it's easy for me to merge because it has a justification and the
> nature of the commit will be clear to anyone looking at the git log in
> the future.
>
> > 3) perhaps we could try to check the code size for some object files in
> block/ (for example libblock.a.p/*.c.o), as a proxy for how much
> instruction cache space is saved when all tracepoints are disabled
> >
> > We can start from 3, but also try 1+3 and 2+3 if it fails if you think
> that would be more persuasive.
>
> Can you explain 3 more? Total code size on disk should stay about the
> same because most trace events only have one call site. Moving code
> between the caller and callee doesn't make a big difference in either
> direction. At runtime there is a benefit from inlining the condition
> check since the call site no longer needs to execute the callee's
> function prologue/epilogue when the trace event is runtime-disabled,
> but that CPU cycle and instruction cache effect won't be visible from
> the on-disk code size.
>
> Thanks,
> Stefan
>

--00000000000059105d0636152522
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt; Can you explain 3 more?=C2=A0<div>Pablo and I have lo=
oked into object files for one of default trace point &quot;<font face=3D"m=
onospace">trace_vhost_commit</font>&quot;(first tracepoint of hw/virtio) be=
fore and after making this change and we found that by=C2=A0<span style=3D"=
white-space:unset">moves the hot-path check for=C2=A0</span><code style=3D"=
white-space:unset">_simple_trace_vhost_commit</code><span style=3D"white-sp=
ace:unset">=C2=A0into the caller (in the=C2=A0</span><code style=3D"white-s=
pace:unset">.h</code><span style=3D"white-space:unset">=C2=A0file) and leav=
es the full stack-frame prologue and tracepoint body in the cold path. By i=
nlining only the=C2=A0</span><code style=3D"white-space:unset">if (trace_ev=
ents_enabled())</code><span style=3D"white-space:unset">=C2=A0test at the c=
all site, we eliminate the 11-instruction prologue overhead (stack allocati=
on, canary load/store, register spills, and argument masking) on every vhos=
t commit(trace call) when tracing is disabled.<br>The old disassembled code=
 looks like this:-=C2=A0</span></div><table><tbody><tr><td>0x10</td><td><co=
de>stp x29, x30, [sp, #-64]!</code></td><td><strong>Prologue:</strong>=C2=
=A0allocates 64-byte frame and saves old FP (x29) &amp; LR (x30)</td></tr><=
/tbody></table><table><tbody><tr><td>0x14</td><td><code>adrp x3, trace_even=
ts_enabled_count</code></td><td><strong>Prologue:</strong>=C2=A0computes pa=
ge-base of the trace-enable counter</td></tr></tbody></table><table><tbody>=
<tr><td>0x18</td><td><code>adrp x2, __stack_chk_guard</code></td><td><stron=
g>Important (maybe prolog don&#39;t know?)(stack-protector):</strong>=C2=A0=
starts up the stack-canary load</td></tr></tbody></table><table><tbody><tr>=
<td>0x1c</td><td><code>mov x29, sp</code></td><td><strong>Prologue:</strong=
>=C2=A0sets new frame pointer</td></tr></tbody></table><table><tbody><tr><t=
d>0x20</td><td><code>ldr x3, [x3]</code></td><td><strong>Prologue:</strong>=
=C2=A0loads the actual trace-enabled count</td></tr></tbody></table><table>=
<tbody><tr><td>0x24</td><td><code>stp x19, x20, [sp, #16]</code></td><td><s=
trong>Prologue:</strong>=C2=A0spills callee-saved regs used by this functio=
n (x19, x20)</td></tr></tbody></table><table><tbody><tr><td>0x28</td><td><c=
ode>and w20, w0, #0xff</code></td><td><strong>Tracepoint setup:</strong>=C2=
=A0extracts the low-8 bits of arg0 as the =E2=80=9Cevent boolean=E2=80=9D</=
td></tr></tbody></table><table><tbody><tr><td>0x2c</td><td><code>ldr x2, [x=
2]</code></td><td><strong>Prologue (cont=E2=80=99d):</strong>=C2=A0complete=
s loading of the stack-canary value</td></tr></tbody></table><table><tbody>=
<tr><td>0x30</td><td><code>and w19, w1, #0xff</code></td><td><strong>Tracep=
oint setup:</strong>=C2=A0extracts low-8 bits of arg1</td></tr></tbody></ta=
ble><table><tbody><tr><td>0x34</td><td><code>ldr w0, [x3]</code></td><td><s=
trong>Important:</strong>=C2=A0loads the current trace-enabled flag from me=
mory</td></tr></tbody></table><table><tbody><tr><td>0x38</td><td><code>ldr =
x1, [x2]</code></td><td><strong>Prologue (cont=E2=80=99d):</strong>=C2=A0re=
ads the canary</td></tr></tbody></table><table><tbody><tr><td>0x3c</td><td>=
<code>str x1, [sp, #56]</code></td><td><strong>Prologue (cont=E2=80=99d):</=
strong>=C2=A0writes the canary into the new frame</td></tr></tbody></table>=
<table><tbody><tr><td>0x40</td><td><code>mov x1, #0</code></td><td><strong>=
Prologue (cont=E2=80=99d):</strong>=C2=A0zeroes out x1 for the upcoming bra=
nch test</td></tr></tbody></table><table><tbody><tr><td>0x44</td><td><code>=
cbnz w0, 0x88</code></td><td><strong>Important:</strong>=C2=A0if tracing is=
 disabled (w0=3D=3D0) skip the heavy path entirely</td></tr></tbody></table=
><div>Saving 11/14 instructions!<span style=3D"white-space:unset">Also We h=
ave not considered epilog=C2=A0</span>instructional<span style=3D"white-spa=
ce:unset">=C2=A0saves would be definitely=C2=A0more than 11.</span></div><d=
iv>Old flow: Every call does ~11 insns of prologue + tracepoint check, even=
 if tracing is disabled.<br>New flow: We inline a tiny if (trace_enabled) a=
t the caller; only when it=E2=80=99s true do you call into a full function =
with its prologue.(Extra instructions)</div></div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, M=
ay 21, 2025 at 11:46=E2=80=AFPM Stefan Hajnoczi &lt;<a href=3D"mailto:stefa=
nha@gmail.com">stefanha@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Tue, May 20, 2025 at 4:52=E2=80=AFPM Pa=
olo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank">pb=
onzini@redhat.com</a>&gt; wrote:<br>
&gt; Il mar 20 mag 2025, 21:01 Stefan Hajnoczi &lt;<a href=3D"mailto:stefan=
ha@gmail.com" target=3D"_blank">stefanha@gmail.com</a>&gt; ha scritto:<br>
&gt;&gt;<br>
&gt;&gt; On Mon, May 19, 2025 at 2:52=E2=80=AFPM Tanish Desai &lt;<a href=
=3D"mailto:tanishdesai37@gmail.com" target=3D"_blank">tanishdesai37@gmail.c=
om</a>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Remove hot paths from .c file and added it in .h file to keep=
 it inline.<br>
&gt;&gt;<br>
&gt;&gt; Please include performance results in the commit description so it=
&#39;s<br>
&gt;&gt; clear what impact this change has.<br>
&gt;<br>
&gt;<br>
&gt; Hi Stefan,<br>
&gt;<br>
&gt; I am replying because I take the blame for this :) and as an example o=
f how he could interact with the maintainer.<br>
&gt;<br>
&gt; For now we mostly looked at differences between the code that tracetoo=
l generates for the various backends, and the observation that some of them=
 put code in the .h and some in the .c file. I explained to Tanish the conc=
ept of separating hot vs cold code in theory, showed him some examples in Q=
EMU where performance measurements were done in the past, and suggested app=
lying this to various backends (starting with the one with the weirdest cho=
ice!). However we didn&#39;t do any measurement yet.<br>
&gt;<br>
&gt; Some possibilities that come to mind:<br>
&gt;<br>
&gt; 1) maybe the coroutine benchmarks are enough to show a difference, wit=
h some luck<br>
&gt;<br>
&gt; 2) a new microbenchmark (or a set of microbenchmarks that try various =
level of register pressure around the tracepoint), which would be nice to h=
ave anyway<br>
<br>
2 is going above and beyond :). I&#39;m not trying to make life hard.<br>
<br>
Another option if 1 or 2 are difficult to quantify: I&#39;d be happy with<b=
r>
just a &quot;before&quot; and &quot;after&quot; disassembly snippet from ob=
jdump showing<br>
that the instructions at a call site changed as intended.<br>
<br>
What I&#39;m looking for is a commit description that explains the purpose<=
br>
of the commit followed by, since this is a performance improvement,<br>
some form of evidence that the change achieved its goal. At that point<br>
it&#39;s easy for me to merge because it has a justification and the<br>
nature of the commit will be clear to anyone looking at the git log in<br>
the future.<br>
<br>
&gt; 3) perhaps we could try to check the code size for some object files i=
n block/ (for example libblock.a.p/*.c.o), as a proxy for how much instruct=
ion cache space is saved when all tracepoints are disabled<br>
&gt;<br>
&gt; We can start from 3, but also try 1+3 and 2+3 if it fails if you think=
 that would be more persuasive.<br>
<br>
Can you explain 3 more? Total code size on disk should stay about the<br>
same because most trace events only have one call site. Moving code<br>
between the caller and callee doesn&#39;t make a big difference in either<b=
r>
direction. At runtime there is a benefit from inlining the condition<br>
check since the call site no longer needs to execute the callee&#39;s<br>
function prologue/epilogue when the trace event is runtime-disabled,<br>
but that CPU cycle and instruction cache effect won&#39;t be visible from<b=
r>
the on-disk code size.<br>
<br>
Thanks,<br>
Stefan<br>
</blockquote></div>

--00000000000059105d0636152522--

