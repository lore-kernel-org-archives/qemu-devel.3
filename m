Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8459C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 20:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbQSP-0001EV-C5; Fri, 24 Jan 2025 15:39:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbQSK-0001ED-GC
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 15:39:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbQSI-0000tI-14
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 15:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737751143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eG5bWqHH+c4d1MtsT+f8vW1Jd1n6ncZRfUeGbKS71TY=;
 b=YqNAcGYymRju6Ksz84cLXTuwPj+/Z1ij54gwNe5pZYJthlK/4MLa+Nifa+PetmlHhcxFTi
 +eXjedVFJ0lHgym1/5Xlt7lmLl41ZdANJ4Ome5YRdEfreZSwDA+vBAFd3Y3boChi7pmI3S
 yRYZzUJYjIczZPtySqoGtmeFS16xKL0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-koZx3QhcNiGUYoM5z_txnQ-1; Fri, 24 Jan 2025 15:38:38 -0500
X-MC-Unique: koZx3QhcNiGUYoM5z_txnQ-1
X-Mimecast-MFC-AGG-ID: koZx3QhcNiGUYoM5z_txnQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385dcae001fso1003938f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 12:38:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737751116; x=1738355916;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eG5bWqHH+c4d1MtsT+f8vW1Jd1n6ncZRfUeGbKS71TY=;
 b=QPU9TbO1WP5kwHUlohCAsaQQ2wPdYEiLj/BTe8/AzQfIdSE/FZp68ToAShawH7xe5G
 Q2B2fhA/lewbFhQ7V7kcF417XfgBQxKF4zDcx7X6dVCAL4BQa5EjoZm1kig0okaidzrk
 bKQadFlJJG1AnqRT4eZWQQ4NNBQn/ywILv6J3ULPrQx+v/4lAg+Kx/P9TFJ2aiNP0i5O
 r3ZO7JLNxptt4sdxidqqsbICXJtFb781nCI4xA5OdrkUFGbfwIu0/0umrE5YnM2KP9Vx
 Vx1IoRb1s/x3OImprSgOBMjUPtsfzOJ08f9/wlss1b0VMY6nty38cCbcVe5+Cv531AwQ
 L9kw==
X-Gm-Message-State: AOJu0YzMXE2hnw0xWRS87FRt875vcehzWbVJmXKyMCW7WL6GaZfO0dI1
 FCFTOrBnqPi9unVhAjrWhx1mRSZDQrYiEuQokir0qnhuxIL8Qc+qcsITOZHAQbsNO/xo7W5EeKR
 PuLmwKAZGFoRVMMvOIaMBxwDZkIa+ffkOgOqr1OLQaKdrwPbYLc65CU1jgnshuO+UD4ZgYhS14z
 X8ujYtqQhm1D9X1XkJC9iC7jv6KySaXMHw8KfxXA==
X-Gm-Gg: ASbGncvU1zIhdbGxbdS7bD+XJeLIHbe9zUcAInQ5Ure2Mw5rZp3bIXZ8Co9W5xz7SLs
 Nv2JVuGkUv9jBUpHPNHHeCt6NXQaa7vEWMnyzDlYXFR1a3t01dCU=
X-Received: by 2002:a5d:6b8b:0:b0:38a:8b2c:53ac with SMTP id
 ffacd0b85a97d-38bf57b3fe9mr21523285f8f.42.1737751116596; 
 Fri, 24 Jan 2025 12:38:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8zYQ+dRFOzc5c4EvsgVByC99ebPcKEt/rE74XtBzdgN8l6K1zxWzuZNKBA/OwvGDHzeG3it6SBBorvPoSVvw=
X-Received: by 2002:a5d:6b8b:0:b0:38a:8b2c:53ac with SMTP id
 ffacd0b85a97d-38bf57b3fe9mr21523263f8f.42.1737751116135; Fri, 24 Jan 2025
 12:38:36 -0800 (PST)
MIME-Version: 1.0
References: <20250124094442.13207-1-pbonzini@redhat.com>
 <CAJSP0QXMO8WX1iPKqqfTK7LyDX1kWmgaSbDBVfE6V8go7Vr5WA@mail.gmail.com>
In-Reply-To: <CAJSP0QXMO8WX1iPKqqfTK7LyDX1kWmgaSbDBVfE6V8go7Vr5WA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 24 Jan 2025 21:38:24 +0100
X-Gm-Features: AWEUYZnC92OiEBXQ51AvAQdaAwBelIg-MKTMeMALlWwUdUquf8l6DADujsNM-YE
Message-ID: <CABgObfZA9jJCUBwFCOPdoxaKbekmUefKnrWxf-pQyspgd7Jo5w@mail.gmail.com>
Subject: Re: [PULL 00/48] i386, rust changes for 2024-01-24
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000fc5f66062c79b514"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, HTML_OBFUSCATE_05_10=0.26, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

--000000000000fc5f66062c79b514
Content-Type: text/plain; charset="UTF-8"

Il ven 24 gen 2025, 20:05 Stefan Hajnoczi <stefanha@gmail.com> ha scritto:

> Hi Paolo,
> Please take a look at this failure and send a v2 pull request, if
> necessary:
>
> thread '<unnamed>' panicked at 'already borrowed',
> rust/qemu-api/libqemu_api.rlib.p/structured/cell.rs:450:5
> note: run with `RUST_BACKTRACE=1` environment variable to display a
> backtrace
> fatal runtime error: failed to initiate panic, error 5
>
> https://gitlab.com/qemu-project/qemu/-/jobs/8946857796


Yes, it's a real bug.

Paolo


>
> Thanks,
> Stefan
>
> >
> > ----------------------------------------------------------------
> > Paolo Bonzini (39):
> >       rust: pl011: fix repr(C) for PL011Class
> >       target/i386: inline gen_jcc into sole caller
> >       target/i386: remove trailing 1 from gen_{j, cmov, set}cc1
> >       target/i386: unify REP and REPZ/REPNZ generation
> >       target/i386: unify choice between single and repeated string
> instructions
> >       target/i386: reorganize ops emitted by do_gen_rep, drop repz_opt
> >       target/i386: tcg: move gen_set/reset_* earlier in the file
> >       target/i386: fix RF handling for string instructions
> >       target/i386: make cc_op handling more explicit for repeated string
> instructions.
> >       target/i386: do not use gen_op_jz_ecx for repeated string
> operations
> >       target/i386: optimize CX handling in repeated string operations
> >       target/i386: execute multiple REP/REPZ iterations without leaving
> TB
> >       target/i386: pull computation of string update value out of loop
> >       target/i386: extract common bits of gen_repz/gen_repz_nz
> >       target/i386: avoid using s->tmp0 for add to implicit registers
> >       rust: vmstate: add new type safe implementation
> >       rust: vmstate: implement VMState for non-leaf types
> >       rust: vmstate: add varray support to vmstate_of!
> >       rust: vmstate: implement Zeroable for VMStateField
> >       rust: vmstate: implement VMState for scalar types
> >       rust: vmstate: add public utility macros to implement VMState
> >       rust: qemu_api: add vmstate_struct
> >       rust: pl011: switch vmstate to new-style macros
> >       rust: vmstate: remove translation of C vmstate macros
> >       rust: vmstate: make order of parameters consistent in vmstate_clock
> >       rust: prefer NonNull::new to assertions
> >       rust: pl011: remove unnecessary "extern crate"
> >       rust: pl011: hide unnecessarily "pub" items from outside
> pl011::device
> >       rust: pl011: extract conversion to RegisterOffset
> >       rust: pl011: extract CharBackend receive logic into a separate
> function
> >       rust: pl011: pull interrupt updates out of read/write ops
> >       rust: pl011: extract PL011Registers
> >       rust: pl011: wrap registers with BqlRefCell
> >       rust: pl011: remove duplicate definitions
> >       rust: pl011: pull device-specific code out of MemoryRegionOps
> callbacks
> >       rust: pl011: drop use of ControlFlow
> >       rust: qdev: make reset take a shared reference
> >       rust/zeroable: Implement Zeroable with const_zero macro
> >       rust: qemu-api: add sub-subclass to the integration tests
> >
> > Tao Su (4):
> >       target/i386: Introduce SierraForest-v2 model
> >       target/i386: Export BHI_NO bit to guests
> >       target/i386: Add new CPU model ClearwaterForest
> >       docs: Add GNR, SRF and CWF CPU models
> >
> > Zhao Liu (5):
> >       stub: Fix build failure with --enable-user --disable-system
> --enable-tools
> >       rust/qdev: Make REALIZE safe
> >       rust/pl011: Avoid bindings::*
> >       memattrs: Convert unspecified member to bool
> >       memattrs: Check the size of MemTxAttrs
> >
> >  docs/system/cpu-models-x86.rst.inc     |  50 ++-
> >  include/exec/memattrs.h                |  21 +-
> >  target/i386/cpu.h                      |  33 +-
> >  target/i386/cpu.c                      | 156 +++++++-
> >  target/i386/tcg/translate.c            | 363 ++++++++++-------
> >  target/i386/tcg/emit.c.inc             |  55 +--
> >  rust/hw/char/pl011/src/device.rs       | 489 +++++++++++++----------
> >  rust/hw/char/pl011/src/device_class.rs |  73 ++--
> >  rust/hw/char/pl011/src/lib.rs          |  67 ++--
> >  rust/hw/char/pl011/src/memory_ops.rs   |  25 +-
> >  rust/qemu-api/src/prelude.rs           |   2 +
> >  rust/qemu-api/src/qdev.rs              |  16 +-
> >  rust/qemu-api/src/qom.rs               |  21 +-
> >  rust/qemu-api/src/vmstate.rs           | 700
> +++++++++++++++++++++------------
> >  rust/qemu-api/src/zeroable.rs          | 118 +++---
> >  rust/qemu-api/tests/tests.rs           |  56 ++-
> >  stubs/meson.build                      |   4 +-
> >  17 files changed, 1403 insertions(+), 846 deletions(-)
> > --
> > 2.48.1
> >
> >
>
>

--000000000000fc5f66062c79b514
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 24 gen 2025, 20:05 Stefan=
 Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.com">stefanha@gmail.com</a>&=
gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Hi Paolo,<br>
Please take a look at this failure and send a v2 pull request, if necessary=
:<br>
<br>
thread &#39;&lt;unnamed&gt;&#39; panicked at &#39;already borrowed&#39;,<br=
>
rust/qemu-api/libqemu_api.rlib.p/structured/<a href=3D"http://cell.rs:450" =
target=3D"_blank" rel=3D"noreferrer">cell.rs:450</a>:5<br>
note: run with `RUST_BACKTRACE=3D1` environment variable to display a backt=
race<br>
fatal runtime error: failed to initiate panic, error 5<br>
<br>
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/8946857796" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qem=
u/-/jobs/8946857796</a></blockquote></div></div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Yes, it&#39;s a real bug.</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><br>
<br>
Thanks,<br>
Stefan<br>
<br>
&gt;<br>
&gt; ----------------------------------------------------------------<br>
&gt; Paolo Bonzini (39):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: pl011: fix repr(C) for PL011Class<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/i386: inline gen_jcc into sole caller=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/i386: remove trailing 1 from gen_{j, =
cmov, set}cc1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/i386: unify REP and REPZ/REPNZ genera=
tion<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/i386: unify choice between single and=
 repeated string instructions<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/i386: reorganize ops emitted by do_ge=
n_rep, drop repz_opt<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/i386: tcg: move gen_set/reset_* earli=
er in the file<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/i386: fix RF handling for string inst=
ructions<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/i386: make cc_op handling more explic=
it for repeated string instructions.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/i386: do not use gen_op_jz_ecx for re=
peated string operations<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/i386: optimize CX handling in repeate=
d string operations<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/i386: execute multiple REP/REPZ itera=
tions without leaving TB<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/i386: pull computation of string upda=
te value out of loop<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/i386: extract common bits of gen_repz=
/gen_repz_nz<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/i386: avoid using s-&gt;tmp0 for add =
to implicit registers<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: vmstate: add new type safe implementat=
ion<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: vmstate: implement VMState for non-lea=
f types<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: vmstate: add varray support to vmstate=
_of!<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: vmstate: implement Zeroable for VMStat=
eField<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: vmstate: implement VMState for scalar =
types<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: vmstate: add public utility macros to =
implement VMState<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: qemu_api: add vmstate_struct<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: pl011: switch vmstate to new-style mac=
ros<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: vmstate: remove translation of C vmsta=
te macros<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: vmstate: make order of parameters cons=
istent in vmstate_clock<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: prefer NonNull::new to assertions<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: pl011: remove unnecessary &quot;extern=
 crate&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: pl011: hide unnecessarily &quot;pub&qu=
ot; items from outside pl011::device<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: pl011: extract conversion to RegisterO=
ffset<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: pl011: extract CharBackend receive log=
ic into a separate function<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: pl011: pull interrupt updates out of r=
ead/write ops<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: pl011: extract PL011Registers<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: pl011: wrap registers with BqlRefCell<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: pl011: remove duplicate definitions<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: pl011: pull device-specific code out o=
f MemoryRegionOps callbacks<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: pl011: drop use of ControlFlow<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: qdev: make reset take a shared referen=
ce<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust/zeroable: Implement Zeroable with const=
_zero macro<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust: qemu-api: add sub-subclass to the inte=
gration tests<br>
&gt;<br>
&gt; Tao Su (4):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/i386: Introduce SierraForest-v2 model=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/i386: Export BHI_NO bit to guests<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/i386: Add new CPU model ClearwaterFor=
est<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0docs: Add GNR, SRF and CWF CPU models<br>
&gt;<br>
&gt; Zhao Liu (5):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0stub: Fix build failure with --enable-user -=
-disable-system --enable-tools<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust/qdev: Make REALIZE safe<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rust/pl011: Avoid bindings::*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memattrs: Convert unspecified member to bool=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memattrs: Check the size of MemTxAttrs<br>
&gt;<br>
&gt;=C2=A0 docs/system/cpu-models-x86.rst.inc=C2=A0 =C2=A0 =C2=A0|=C2=A0 50=
 ++-<br>
&gt;=C2=A0 include/exec/memattrs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 21 +-<br>
&gt;=C2=A0 target/i386/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 33 +-<br>
&gt;=C2=A0 target/i386/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 156 +++++++-<br>
&gt;=C2=A0 target/i386/tcg/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 363 ++++++++++-------<br>
&gt;=C2=A0 target/i386/tcg/emit.c.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 55 +--<br>
&gt;=C2=A0 rust/hw/char/pl011/src/<a href=3D"http://device.rs" rel=3D"noref=
errer noreferrer" target=3D"_blank">device.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 489 +++++++++++++----------<br>
&gt;=C2=A0 rust/hw/char/pl011/src/<a href=3D"http://device_class.rs" rel=3D=
"noreferrer noreferrer" target=3D"_blank">device_class.rs</a> |=C2=A0 73 ++=
--<br>
&gt;=C2=A0 rust/hw/char/pl011/src/<a href=3D"http://lib.rs" rel=3D"noreferr=
er noreferrer" target=3D"_blank">lib.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 67 ++--<br>
&gt;=C2=A0 rust/hw/char/pl011/src/<a href=3D"http://memory_ops.rs" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">memory_ops.rs</a>=C2=A0 =C2=A0|=C2=
=A0 25 +-<br>
&gt;=C2=A0 rust/qemu-api/src/<a href=3D"http://prelude.rs" rel=3D"noreferre=
r noreferrer" target=3D"_blank">prelude.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 rust/qemu-api/src/<a href=3D"http://qdev.rs" rel=3D"noreferrer n=
oreferrer" target=3D"_blank">qdev.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 16 +-<br>
&gt;=C2=A0 rust/qemu-api/src/<a href=3D"http://qom.rs" rel=3D"noreferrer no=
referrer" target=3D"_blank">qom.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 21 +-<br>
&gt;=C2=A0 rust/qemu-api/src/<a href=3D"http://vmstate.rs" rel=3D"noreferre=
r noreferrer" target=3D"_blank">vmstate.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 700 +++++++++++++++++++++------------<br>
&gt;=C2=A0 rust/qemu-api/src/<a href=3D"http://zeroable.rs" rel=3D"noreferr=
er noreferrer" target=3D"_blank">zeroable.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | 118 +++---<br>
&gt;=C2=A0 rust/qemu-api/tests/<a href=3D"http://tests.rs" rel=3D"noreferre=
r noreferrer" target=3D"_blank">tests.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 56 ++-<br>
&gt;=C2=A0 stubs/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 17 files changed, 1403 insertions(+), 846 deletions(-)<br>
&gt; --<br>
&gt; 2.48.1<br>
&gt;<br>
&gt;<br>
<br>
</blockquote></div></div></div>

--000000000000fc5f66062c79b514--


