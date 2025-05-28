Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6E1C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 19:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKMTs-0004fn-OA; Wed, 28 May 2025 15:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uKMTn-0004eS-DS
 for qemu-devel@nongnu.org; Wed, 28 May 2025 15:30:24 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uKMTh-0008RH-Bp
 for qemu-devel@nongnu.org; Wed, 28 May 2025 15:30:22 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ad89f9bb725so18713266b.2
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 12:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748460612; x=1749065412; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bIl76kKjT8Xak0MCCqOCzQN6JVwh1ocAb1w+bmarCLE=;
 b=NbQiAikUUJm26yjTpVph0q0GpTzOYyrkyGqF52q1mCr1I6aLhxguX7yrEbNBBh8qk4
 EgovweYBqYJNOXLu1orySzUOSGVAkHs83ZvjVCNjLkrRjFwevyADcWQTuo/odsM+f5nE
 Hxe8VtQoQpXM1NQaPh1DywHWDDAcrZ/2gkKgJZlo/51jSQkhbM2p9r9VaB0tHIw4LTTQ
 5Y7vYYLlupUVwGsMtl5co2FKFnuDhq5QKEaKKrZjithw285/4D32JhT6K/5yDsaQ8MCW
 bUj7iJfMDO0YXJRi7kNkhrl0bErivoIFWjTPr/xujtoi2H9yzImie54FI+nwtLdnygFa
 00NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748460612; x=1749065412;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bIl76kKjT8Xak0MCCqOCzQN6JVwh1ocAb1w+bmarCLE=;
 b=SGTJkgDr+YI+TeIDjov7yd1BQnZgP6jWAX9JxJiZeDh8A1Eh0lxb2dUhLl5aMQqIyd
 dm8FMFIuwZ8tADQiga7fCWRpPAlySWl+qMgLj7lmYUcbirhinr+wb//3vxslAZt7286S
 dplJS6Ket9fMJvlGEgxlU3OgXsnR4jnQDauK/Y6tTwbA8ZVPwwcHoClmImSxsJi9j0BI
 2c4glWBldnHBohMOFjFmv5k4zCobHA926Otvz08awLDLwZNnOOu310zDMjbmLZHLqeau
 qIp7CvlShoZ8kTv9wxUAVcLPtc4jtZGYHlzDdCkdv2awREeGaNvEinyQ9DSCCy6w3H9t
 PUbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8AmqoNDNfjf/UGLrWOxsTwdvWHcm8AXmdnYYKft1uCXHBU4NYWZV0+tww2bAOLM9/KNgX+6pzXRjp@nongnu.org
X-Gm-Message-State: AOJu0Yw7jNoYwMKLLfxwXEOkuvITkf699/m5/MwRNglyXQPzCD4Hcue0
 h77KmB4QiZijGb7zeg/Oarc5J1gvCwgl9bAF2TiSZc3cLjtkfHu1f/PiI6NPBc7qwUSgfTFUaE5
 BYGhhdWv7/GL8PzhRMmHExyVq+E7MZ8wmWP9eE7r2aQ==
X-Gm-Gg: ASbGncs4wRJwd3lepTwg4R985hDWDfTRcCawa5cwCdt8u9ez11AQCuNwp577XTJox9o
 k1nHSiADMJORvCcmDTux8tZKPljZqV7HWK9IgwOk8HpwixGTJVKIvy+kye57tV/VmFPz9+ASp6t
 /jHG40Tv/dZHLJoiFnZWtablhjlQWJ+D2L
X-Google-Smtp-Source: AGHT+IHPnP/CbojgJpHJiLP+5/z6xFBJI9Iapvku2gfxf9AOMUV2NHExdG9h009/O+r+jBKggfD6i+CCLQ3jzLCxq4o=
X-Received: by 2002:a17:907:944c:b0:ad8:9988:44d2 with SMTP id
 a640c23a62f3a-ad899884717mr564083566b.20.1748460612121; Wed, 28 May 2025
 12:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250519185108.14412-1-tanishdesai37@gmail.com>
 <CAJSP0QVOSGKnt8YCay5r+HR2O6xCz9Nb5Hp4TOzsSHE9fpYgHw@mail.gmail.com>
 <CABgObfY5uMM+Z4QpxqCya8om4_=0eYFN2dnWGYD0vsYhrmaR7w@mail.gmail.com>
 <CAJSP0QXi=UbkdZ499GzMjW49UeCwvk1=EyE=51-jL-P6PH_UXQ@mail.gmail.com>
 <CAH_Y1je5u3GoaUJ3LfHxcp0MMpEjVPbGkYOw3mo8As+tEPExdg@mail.gmail.com>
 <CAJSP0QWM63GA1LHcTiSF=sivzghtompzJqQORRchveTHWmUW6A@mail.gmail.com>
In-Reply-To: <CAJSP0QWM63GA1LHcTiSF=sivzghtompzJqQORRchveTHWmUW6A@mail.gmail.com>
From: Tanish Desai <tanishdesai37@gmail.com>
Date: Thu, 29 May 2025 01:00:01 +0530
X-Gm-Features: AX0GCFszF39JlwGbYel28GhvN6MefykaU89STugHmZ_3nbYkhATLwUbKJloq18Q
Message-ID: <CAH_Y1jeQxtQHokFoVFmBVruoODF_CFVnyM9WaB3x8pDESijtdg@mail.gmail.com>
Subject: Re: [PATCH] trace/simple: seperate hot paths of tracing fucntions
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Mads Ynddal <mads@ynddal.dk>
Content-Type: multipart/alternative; boundary="000000000000b081090636373523"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=tanishdesai37@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000b081090636373523
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have shared v2 with updated commit msg to everyone in form of a new PATCH=
.
Please check it and let me know if anything is still missing or confusing.


On Wed, 28 May 2025 at 11:36=E2=80=AFPM, Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:

> On Mon, May 26, 2025 at 10:51=E2=80=AFPM Tanish Desai <tanishdesai37@gmai=
l.com>
> wrote:
> >
> > > Can you explain 3 more?
> > Pablo and I have looked into object files for one of default trace poin=
t
> "trace_vhost_commit"(first tracepoint of hw/virtio) before and after maki=
ng
> this change and we found that by moves the hot-path check for
> _simple_trace_vhost_commit into the caller (in the .h file) and leaves th=
e
> full stack-frame prologue and tracepoint body in the cold path. By inlini=
ng
> only the if (trace_events_enabled()) test at the call site, we eliminate
> the 11-instruction prologue overhead (stack allocation, canary load/store=
,
> register spills, and argument masking) on every vhost commit(trace call)
> when tracing is disabled.
> > The old disassembled code looks like this:-
> > 0x10stp x29, x30, [sp, #-64]!Prologue: allocates 64-byte frame and save=
s
> old FP (x29) & LR (x30)
> > 0x14adrp x3, trace_events_enabled_countPrologue: computes page-base of
> the trace-enable counter
> > 0x18adrp x2, __stack_chk_guardImportant (maybe prolog don't
> know?)(stack-protector): starts up the stack-canary load
> > 0x1cmov x29, spPrologue: sets new frame pointer
> > 0x20ldr x3, [x3]Prologue: loads the actual trace-enabled count
> > 0x24stp x19, x20, [sp, #16]Prologue: spills callee-saved regs used by
> this function (x19, x20)
> > 0x28and w20, w0, #0xffTracepoint setup: extracts the low-8 bits of arg0
> as the =E2=80=9Cevent boolean=E2=80=9D
> > 0x2cldr x2, [x2]Prologue (cont=E2=80=99d): completes loading of the sta=
ck-canary
> value
> > 0x30and w19, w1, #0xffTracepoint setup: extracts low-8 bits of arg1
> > 0x34ldr w0, [x3]Important: loads the current trace-enabled flag from
> memory
> > 0x38ldr x1, [x2]Prologue (cont=E2=80=99d): reads the canary
> > 0x3cstr x1, [sp, #56]Prologue (cont=E2=80=99d): writes the canary into =
the new
> frame
> > 0x40mov x1, #0Prologue (cont=E2=80=99d): zeroes out x1 for the upcoming=
 branch
> test
> > 0x44cbnz w0, 0x88Important: if tracing is disabled (w0=3D=3D0) skip the
> heavy path entirely
> > Saving 11/14 instructions!Also We have not considered epilog
> instructional saves would be definitely more than 11.
> > Old flow: Every call does ~11 insns of prologue + tracepoint check, eve=
n
> if tracing is disabled.
> > New flow: We inline a tiny if (trace_enabled) at the caller; only when
> it=E2=80=99s true do you call into a full function with its prologue.(Ext=
ra
> instructions)
>
> Good, inlining worked as intended.
>
> Please send a v2 with an updated commit description explaining the
> purpose and with a disassembly snippet of the trace_vhost_commit()
> call site showing what happens.
>
> Thanks!
>
> Stefan
>
> >
> > On Wed, May 21, 2025 at 11:46=E2=80=AFPM Stefan Hajnoczi <stefanha@gmai=
l.com>
> wrote:
> >>
> >> On Tue, May 20, 2025 at 4:52=E2=80=AFPM Paolo Bonzini <pbonzini@redhat=
.com>
> wrote:
> >> > Il mar 20 mag 2025, 21:01 Stefan Hajnoczi <stefanha@gmail.com> ha
> scritto:
> >> >>
> >> >> On Mon, May 19, 2025 at 2:52=E2=80=AFPM Tanish Desai <
> tanishdesai37@gmail.com> wrote:
> >> >> >
> >> >> > Remove hot paths from .c file and added it in .h file to keep it
> inline.
> >> >>
> >> >> Please include performance results in the commit description so it'=
s
> >> >> clear what impact this change has.
> >> >
> >> >
> >> > Hi Stefan,
> >> >
> >> > I am replying because I take the blame for this :) and as an example
> of how he could interact with the maintainer.
> >> >
> >> > For now we mostly looked at differences between the code that
> tracetool generates for the various backends, and the observation that so=
me
> of them put code in the .h and some in the .c file. I explained to Tanish
> the concept of separating hot vs cold code in theory, showed him some
> examples in QEMU where performance measurements were done in the past, an=
d
> suggested applying this to various backends (starting with the one with t=
he
> weirdest choice!). However we didn't do any measurement yet.
> >> >
> >> > Some possibilities that come to mind:
> >> >
> >> > 1) maybe the coroutine benchmarks are enough to show a difference,
> with some luck
> >> >
> >> > 2) a new microbenchmark (or a set of microbenchmarks that try variou=
s
> level of register pressure around the tracepoint), which would be nice to
> have anyway
> >>
> >> 2 is going above and beyond :). I'm not trying to make life hard.
> >>
> >> Another option if 1 or 2 are difficult to quantify: I'd be happy with
> >> just a "before" and "after" disassembly snippet from objdump showing
> >> that the instructions at a call site changed as intended.
> >>
> >> What I'm looking for is a commit description that explains the purpose
> >> of the commit followed by, since this is a performance improvement,
> >> some form of evidence that the change achieved its goal. At that point
> >> it's easy for me to merge because it has a justification and the
> >> nature of the commit will be clear to anyone looking at the git log in
> >> the future.
> >>
> >> > 3) perhaps we could try to check the code size for some object files
> in block/ (for example libblock.a.p/*.c.o), as a proxy for how much
> instruction cache space is saved when all tracepoints are disabled
> >> >
> >> > We can start from 3, but also try 1+3 and 2+3 if it fails if you
> think that would be more persuasive.
> >>
> >> Can you explain 3 more? Total code size on disk should stay about the
> >> same because most trace events only have one call site. Moving code
> >> between the caller and callee doesn't make a big difference in either
> >> direction. At runtime there is a benefit from inlining the condition
> >> check since the call site no longer needs to execute the callee's
> >> function prologue/epilogue when the trace event is runtime-disabled,
> >> but that CPU cycle and instruction cache effect won't be visible from
> >> the on-disk code size.
> >>
> >> Thanks,
> >> Stefan
>

--000000000000b081090636373523
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I have shared v2 with updated commit msg to everyone in f=
orm of a new PATCH.</div><div dir=3D"auto">Please check it and let me know =
if anything is still missing or confusing.<br clear=3D"all"><br clear=3D"al=
l"><div dir=3D"auto"><div dir=3D"ltr" class=3D"gmail_signature" data-smartm=
ail=3D"gmail_signature"><br></div></div></div><div><div class=3D"gmail_quot=
e gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 28 M=
ay 2025 at 11:36=E2=80=AFPM, Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha=
@gmail.com">stefanha@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;borde=
r-left-style:solid;padding-left:1ex;border-left-color:rgb(204,204,204)">On =
Mon, May 26, 2025 at 10:51=E2=80=AFPM Tanish Desai &lt;<a href=3D"mailto:ta=
nishdesai37@gmail.com" target=3D"_blank">tanishdesai37@gmail.com</a>&gt; wr=
ote:<br>
&gt;<br>
&gt; &gt; Can you explain 3 more?<br>
&gt; Pablo and I have looked into object files for one of default trace poi=
nt &quot;trace_vhost_commit&quot;(first tracepoint of hw/virtio) before and=
 after making this change and we found that by moves the hot-path check for=
 _simple_trace_vhost_commit into the caller (in the .h file) and leaves the=
 full stack-frame prologue and tracepoint body in the cold path. By inlinin=
g only the if (trace_events_enabled()) test at the call site, we eliminate =
the 11-instruction prologue overhead (stack allocation, canary load/store, =
register spills, and argument masking) on every vhost commit(trace call) wh=
en tracing is disabled.<br>
&gt; The old disassembled code looks like this:-<br>
&gt; 0x10stp x29, x30, [sp, #-64]!Prologue: allocates 64-byte frame and sav=
es old FP (x29) &amp; LR (x30)<br>
&gt; 0x14adrp x3, trace_events_enabled_countPrologue: computes page-base of=
 the trace-enable counter<br>
&gt; 0x18adrp x2, __stack_chk_guardImportant (maybe prolog don&#39;t know?)=
(stack-protector): starts up the stack-canary load<br>
&gt; 0x1cmov x29, spPrologue: sets new frame pointer<br>
&gt; 0x20ldr x3, [x3]Prologue: loads the actual trace-enabled count<br>
&gt; 0x24stp x19, x20, [sp, #16]Prologue: spills callee-saved regs used by =
this function (x19, x20)<br>
&gt; 0x28and w20, w0, #0xffTracepoint setup: extracts the low-8 bits of arg=
0 as the =E2=80=9Cevent boolean=E2=80=9D<br>
&gt; 0x2cldr x2, [x2]Prologue (cont=E2=80=99d): completes loading of the st=
ack-canary value<br>
&gt; 0x30and w19, w1, #0xffTracepoint setup: extracts low-8 bits of arg1<br=
>
&gt; 0x34ldr w0, [x3]Important: loads the current trace-enabled flag from m=
emory<br>
&gt; 0x38ldr x1, [x2]Prologue (cont=E2=80=99d): reads the canary<br>
&gt; 0x3cstr x1, [sp, #56]Prologue (cont=E2=80=99d): writes the canary into=
 the new frame<br>
&gt; 0x40mov x1, #0Prologue (cont=E2=80=99d): zeroes out x1 for the upcomin=
g branch test<br>
&gt; 0x44cbnz w0, 0x88Important: if tracing is disabled (w0=3D=3D0) skip th=
e heavy path entirely<br>
&gt; Saving 11/14 instructions!Also We have not considered epilog instructi=
onal saves would be definitely more than 11.<br>
&gt; Old flow: Every call does ~11 insns of prologue + tracepoint check, ev=
en if tracing is disabled.<br>
&gt; New flow: We inline a tiny if (trace_enabled) at the caller; only when=
 it=E2=80=99s true do you call into a full function with its prologue.(Extr=
a instructions)<br>
<br>
Good, inlining worked as intended.<br>
<br>
Please send a v2 with an updated commit description explaining the<br>
purpose and with a disassembly snippet of the trace_vhost_commit()<br>
call site showing what happens.<br>
<br>
Thanks!<br>
<br>
Stefan<br>
<br>
&gt;<br>
&gt; On Wed, May 21, 2025 at 11:46=E2=80=AFPM Stefan Hajnoczi &lt;<a href=
=3D"mailto:stefanha@gmail.com" target=3D"_blank">stefanha@gmail.com</a>&gt;=
 wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Tue, May 20, 2025 at 4:52=E2=80=AFPM Paolo Bonzini &lt;<a href=
=3D"mailto:pbonzini@redhat.com" target=3D"_blank">pbonzini@redhat.com</a>&g=
t; wrote:<br>
&gt;&gt; &gt; Il mar 20 mag 2025, 21:01 Stefan Hajnoczi &lt;<a href=3D"mail=
to:stefanha@gmail.com" target=3D"_blank">stefanha@gmail.com</a>&gt; ha scri=
tto:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; On Mon, May 19, 2025 at 2:52=E2=80=AFPM Tanish Desai &lt;=
<a href=3D"mailto:tanishdesai37@gmail.com" target=3D"_blank">tanishdesai37@=
gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; Remove hot paths from .c file and added it in .h fil=
e to keep it inline.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Please include performance results in the commit descript=
ion so it&#39;s<br>
&gt;&gt; &gt;&gt; clear what impact this change has.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Hi Stefan,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I am replying because I take the blame for this :) and as an =
example of how he could interact with the maintainer.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; For now we mostly looked at differences between the code that=
 tracetool generates for the various backends, and the observation that som=
e of them put code in the .h and some in the .c file. I explained to Tanish=
 the concept of separating hot vs cold code in theory, showed him some exam=
ples in QEMU where performance measurements were done in the past, and sugg=
ested applying this to various backends (starting with the one with the wei=
rdest choice!). However we didn&#39;t do any measurement yet.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Some possibilities that come to mind:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; 1) maybe the coroutine benchmarks are enough to show a differ=
ence, with some luck<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; 2) a new microbenchmark (or a set of microbenchmarks that try=
 various level of register pressure around the tracepoint), which would be =
nice to have anyway<br>
&gt;&gt;<br>
&gt;&gt; 2 is going above and beyond :). I&#39;m not trying to make life ha=
rd.<br>
&gt;&gt;<br>
&gt;&gt; Another option if 1 or 2 are difficult to quantify: I&#39;d be hap=
py with<br>
&gt;&gt; just a &quot;before&quot; and &quot;after&quot; disassembly snippe=
t from objdump showing<br>
&gt;&gt; that the instructions at a call site changed as intended.<br>
&gt;&gt;<br>
&gt;&gt; What I&#39;m looking for is a commit description that explains the=
 purpose<br>
&gt;&gt; of the commit followed by, since this is a performance improvement=
,<br>
&gt;&gt; some form of evidence that the change achieved its goal. At that p=
oint<br>
&gt;&gt; it&#39;s easy for me to merge because it has a justification and t=
he<br>
&gt;&gt; nature of the commit will be clear to anyone looking at the git lo=
g in<br>
&gt;&gt; the future.<br>
&gt;&gt;<br>
&gt;&gt; &gt; 3) perhaps we could try to check the code size for some objec=
t files in block/ (for example libblock.a.p/*.c.o), as a proxy for how much=
 instruction cache space is saved when all tracepoints are disabled<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; We can start from 3, but also try 1+3 and 2+3 if it fails if =
you think that would be more persuasive.<br>
&gt;&gt;<br>
&gt;&gt; Can you explain 3 more? Total code size on disk should stay about =
the<br>
&gt;&gt; same because most trace events only have one call site. Moving cod=
e<br>
&gt;&gt; between the caller and callee doesn&#39;t make a big difference in=
 either<br>
&gt;&gt; direction. At runtime there is a benefit from inlining the conditi=
on<br>
&gt;&gt; check since the call site no longer needs to execute the callee&#3=
9;s<br>
&gt;&gt; function prologue/epilogue when the trace event is runtime-disable=
d,<br>
&gt;&gt; but that CPU cycle and instruction cache effect won&#39;t be visib=
le from<br>
&gt;&gt; the on-disk code size.<br>
&gt;&gt;<br>
&gt;&gt; Thanks,<br>
&gt;&gt; Stefan<br>
</blockquote></div></div>

--000000000000b081090636373523--

