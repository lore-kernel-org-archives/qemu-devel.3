Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4663C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 18:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKLBA-0003rE-Q4; Wed, 28 May 2025 14:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uKLB9-0003r1-9g
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:07:03 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uKLB5-0003GR-1n
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:07:00 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-604e2a2f200so203085a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 11:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748455617; x=1749060417; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M6236ywtr9+LtNr4buXSOp5osv8YRQ0gWTBMyLR8odU=;
 b=ZXFGVACFTru+dzZRwi+/hVbVzJZPeInGD3RV42JLbdCJesCM2hVkvej2z+ESxJ22qh
 lmcyTP0sxYiCGvHEgBsSB88XXeoTekPd5f3/ET6P/6C1FJKDvkWm+NZXn8Um2N9TFbl0
 hIzpYQXPwwbPzz+6LbQoxE9FgAX9zvS6t2tUJeLJU5YZY4nnN3Hb0ZwwhKQ2qaVbiz9/
 p+JGugbwRRAev80ftaul/Z4PuKlf0xY/xsZWzZFrq/NcjInmIWYV2z2KMMvSw35i3lwO
 uKwkm78ntbqPhf+qlh84rDgGTvwzthi87+gz8bZtVKARrfwtHgsCzwgz+uqqAH4qoRLY
 lEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748455617; x=1749060417;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M6236ywtr9+LtNr4buXSOp5osv8YRQ0gWTBMyLR8odU=;
 b=WABm/b57QURw0iPCVCJEmSZ9SaXR3YeEg0veGPpwMIf8VLa2ELl6jnwcbGE0Q0l4AO
 PFLzj6oZ4mewUbpnXRbb+soXk/umFDDTmGvItVZxObdJ3VOC0O/ZAmyuhSNr9uagocQG
 /eHhSNcCoQm4fa0l7Qd0+j5uKaNI8pFRNJ7msvvVn02aauFIUtWXkq0Y/MCcnpm6HCdt
 kQSh+v2hhO0yyCcrJl7fiNB6+0BV80rPgO5TdBl3UDOtmjXHA6CcNo3t+zsfonaCCrGc
 C1kEZaBqFXDt8D5BV5kbC4s+o1IYfra2WDTWkAbinIJ98n4iUrbg0A/Ymvdl0KdZHhlk
 yLtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3ubtc21GZA7VK3TEA41N37WsUOA5GXue3Ma0jAGIxcqUSoFRO7F0ZnOTBuvO6knIl7y8VAH1wVnk+@nongnu.org
X-Gm-Message-State: AOJu0YwHBXccL3XGxf24ph3jvY9EjnTyGBNeZfL5hV+eGbQL/P+54MVq
 9VHFdolunLmEUE8Agd8e5DsHHGMLcf285pDheYlGXrELq6MZoFba1UYuFqjwLOpt4Cncj5Gl2Z6
 OKXCm10yJNIIARUjQFt3Yh6epYX6dNq4=
X-Gm-Gg: ASbGncs3mROX+aGiFGj/nCpp5LCb4Gq2/XlrGEUHenYwJ2vDo7JOMQCa43y6YRjsvVO
 HgKgh42toioUfNIS+WntFE0LsfPFHHS75VLPln1SGd1xHeJZ6JSyD01QQApGEwnce2YKvy0tzNu
 dVyfSQpUHIwyaPmq1vEukLF4UuCmhig2M=
X-Google-Smtp-Source: AGHT+IFbk5U9WLLoa0BHEd24rwBASamiTWBqdKxV0TUhORSbdrlZT4UfS8CohopY9J4Yhj4uNE2xRdLLWsl7XNm1q1Y=
X-Received: by 2002:a05:6402:909:b0:5ff:abf8:3563 with SMTP id
 4fb4d7f45d1cf-602d9afa16bmr13684652a12.14.1748455617284; Wed, 28 May 2025
 11:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250519185108.14412-1-tanishdesai37@gmail.com>
 <CAJSP0QVOSGKnt8YCay5r+HR2O6xCz9Nb5Hp4TOzsSHE9fpYgHw@mail.gmail.com>
 <CABgObfY5uMM+Z4QpxqCya8om4_=0eYFN2dnWGYD0vsYhrmaR7w@mail.gmail.com>
 <CAJSP0QXi=UbkdZ499GzMjW49UeCwvk1=EyE=51-jL-P6PH_UXQ@mail.gmail.com>
 <CAH_Y1je5u3GoaUJ3LfHxcp0MMpEjVPbGkYOw3mo8As+tEPExdg@mail.gmail.com>
In-Reply-To: <CAH_Y1je5u3GoaUJ3LfHxcp0MMpEjVPbGkYOw3mo8As+tEPExdg@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 28 May 2025 14:06:44 -0400
X-Gm-Features: AX0GCFtNnFk2puxw8JCLZAjLYwQhBUSEhBqmVpfJIdSjrgAi_7a3Txx10DMwBZs
Message-ID: <CAJSP0QWM63GA1LHcTiSF=sivzghtompzJqQORRchveTHWmUW6A@mail.gmail.com>
Subject: Re: [PATCH] trace/simple: seperate hot paths of tracing fucntions
To: Tanish Desai <tanishdesai37@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Mads Ynddal <mads@ynddal.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x534.google.com
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

On Mon, May 26, 2025 at 10:51=E2=80=AFPM Tanish Desai <tanishdesai37@gmail.=
com> wrote:
>
> > Can you explain 3 more?
> Pablo and I have looked into object files for one of default trace point =
"trace_vhost_commit"(first tracepoint of hw/virtio) before and after making=
 this change and we found that by moves the hot-path check for _simple_trac=
e_vhost_commit into the caller (in the .h file) and leaves the full stack-f=
rame prologue and tracepoint body in the cold path. By inlining only the if=
 (trace_events_enabled()) test at the call site, we eliminate the 11-instru=
ction prologue overhead (stack allocation, canary load/store, register spil=
ls, and argument masking) on every vhost commit(trace call) when tracing is=
 disabled.
> The old disassembled code looks like this:-
> 0x10stp x29, x30, [sp, #-64]!Prologue: allocates 64-byte frame and saves =
old FP (x29) & LR (x30)
> 0x14adrp x3, trace_events_enabled_countPrologue: computes page-base of th=
e trace-enable counter
> 0x18adrp x2, __stack_chk_guardImportant (maybe prolog don't know?)(stack-=
protector): starts up the stack-canary load
> 0x1cmov x29, spPrologue: sets new frame pointer
> 0x20ldr x3, [x3]Prologue: loads the actual trace-enabled count
> 0x24stp x19, x20, [sp, #16]Prologue: spills callee-saved regs used by thi=
s function (x19, x20)
> 0x28and w20, w0, #0xffTracepoint setup: extracts the low-8 bits of arg0 a=
s the =E2=80=9Cevent boolean=E2=80=9D
> 0x2cldr x2, [x2]Prologue (cont=E2=80=99d): completes loading of the stack=
-canary value
> 0x30and w19, w1, #0xffTracepoint setup: extracts low-8 bits of arg1
> 0x34ldr w0, [x3]Important: loads the current trace-enabled flag from memo=
ry
> 0x38ldr x1, [x2]Prologue (cont=E2=80=99d): reads the canary
> 0x3cstr x1, [sp, #56]Prologue (cont=E2=80=99d): writes the canary into th=
e new frame
> 0x40mov x1, #0Prologue (cont=E2=80=99d): zeroes out x1 for the upcoming b=
ranch test
> 0x44cbnz w0, 0x88Important: if tracing is disabled (w0=3D=3D0) skip the h=
eavy path entirely
> Saving 11/14 instructions!Also We have not considered epilog instructiona=
l saves would be definitely more than 11.
> Old flow: Every call does ~11 insns of prologue + tracepoint check, even =
if tracing is disabled.
> New flow: We inline a tiny if (trace_enabled) at the caller; only when it=
=E2=80=99s true do you call into a full function with its prologue.(Extra i=
nstructions)

Good, inlining worked as intended.

Please send a v2 with an updated commit description explaining the
purpose and with a disassembly snippet of the trace_vhost_commit()
call site showing what happens.

Thanks!

Stefan

>
> On Wed, May 21, 2025 at 11:46=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.=
com> wrote:
>>
>> On Tue, May 20, 2025 at 4:52=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.c=
om> wrote:
>> > Il mar 20 mag 2025, 21:01 Stefan Hajnoczi <stefanha@gmail.com> ha scri=
tto:
>> >>
>> >> On Mon, May 19, 2025 at 2:52=E2=80=AFPM Tanish Desai <tanishdesai37@g=
mail.com> wrote:
>> >> >
>> >> > Remove hot paths from .c file and added it in .h file to keep it in=
line.
>> >>
>> >> Please include performance results in the commit description so it's
>> >> clear what impact this change has.
>> >
>> >
>> > Hi Stefan,
>> >
>> > I am replying because I take the blame for this :) and as an example o=
f how he could interact with the maintainer.
>> >
>> > For now we mostly looked at differences between the code that tracetoo=
l generates for the various backends, and the observation that some of them=
 put code in the .h and some in the .c file. I explained to Tanish the conc=
ept of separating hot vs cold code in theory, showed him some examples in Q=
EMU where performance measurements were done in the past, and suggested app=
lying this to various backends (starting with the one with the weirdest cho=
ice!). However we didn't do any measurement yet.
>> >
>> > Some possibilities that come to mind:
>> >
>> > 1) maybe the coroutine benchmarks are enough to show a difference, wit=
h some luck
>> >
>> > 2) a new microbenchmark (or a set of microbenchmarks that try various =
level of register pressure around the tracepoint), which would be nice to h=
ave anyway
>>
>> 2 is going above and beyond :). I'm not trying to make life hard.
>>
>> Another option if 1 or 2 are difficult to quantify: I'd be happy with
>> just a "before" and "after" disassembly snippet from objdump showing
>> that the instructions at a call site changed as intended.
>>
>> What I'm looking for is a commit description that explains the purpose
>> of the commit followed by, since this is a performance improvement,
>> some form of evidence that the change achieved its goal. At that point
>> it's easy for me to merge because it has a justification and the
>> nature of the commit will be clear to anyone looking at the git log in
>> the future.
>>
>> > 3) perhaps we could try to check the code size for some object files i=
n block/ (for example libblock.a.p/*.c.o), as a proxy for how much instruct=
ion cache space is saved when all tracepoints are disabled
>> >
>> > We can start from 3, but also try 1+3 and 2+3 if it fails if you think=
 that would be more persuasive.
>>
>> Can you explain 3 more? Total code size on disk should stay about the
>> same because most trace events only have one call site. Moving code
>> between the caller and callee doesn't make a big difference in either
>> direction. At runtime there is a benefit from inlining the condition
>> check since the call site no longer needs to execute the callee's
>> function prologue/epilogue when the trace event is runtime-disabled,
>> but that CPU cycle and instruction cache effect won't be visible from
>> the on-disk code size.
>>
>> Thanks,
>> Stefan

