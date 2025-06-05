Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D587C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 18:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNFTc-0008B6-Kt; Thu, 05 Jun 2025 14:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uNFTa-0008AY-9Y
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 14:38:06 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uNFTY-0005ai-8U
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 14:38:06 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6020ff8d51dso2376113a12.2
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 11:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749148682; x=1749753482; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vn8EN64+MBIJI7ktzruVu1z79zON2wnPe1iCAwoHyd0=;
 b=fP+YyeNaJ4q49yX4NFabREzmqRUihwJoyGNI5BSGCdJFw9Av5/wM+KYxoQD6xeHjkr
 HtCEYqf2PeMHkaq/GOBEazqgj5Q63L3CwG0IEK+RPWsmH0KwiMnlliziNaNN0EgVp6jM
 h3tZisvu/3e894b+NX78mhNStWo4S4sa5rEYi9QNWXHDYpHRd3soAJQy7jKsETspRsP+
 VaIrwGJr+00FjbyK8R8QQ+158szz08XsM6uwJmHTe3v+tQNiC166mz6ivwkwyvgAPgdq
 qCgGAyaL2/xiKsr+X6T6qjHm0tFDY/G0XRLgyBHO1Dv5pkvddJc2KCgFK0DLi1K0PZi4
 8DEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749148682; x=1749753482;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vn8EN64+MBIJI7ktzruVu1z79zON2wnPe1iCAwoHyd0=;
 b=NsK8FeXzKgbXaVnmX9pILTYtproivnwckBwmX9SdPrZbxZK1cDKiZgTUG8NWKUE0v9
 EPEMFyjXLaWHR0uwvPNfjLQpBFh9ie5mpgsSAI74Y4KMS0uAX9I0dxmWhK1DrMpLneC1
 PMQUDw24GIgNtOALNNB6izPMHYbnrjCDBzkllv8vBkIv1U9gPweijlX5oBvbV4E/waqO
 Z1jOSSdrLw2e2gHSSL5l2gwrF4DAqskfDOXcyjPk4eC/TZcN6IRpFg09wxif3C1EEWR9
 k5TKxG8e846SJ8pgh0c6EZBZPmFE9hF0GUnAlKp3/Pb0YY6NU0g50m8Lmpvb953x8qOI
 pPRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9izrrqVI2/8/ouGohgGpyvtT2BmSTWGdz/f2pZX1GGJ3VBZqSkzhTKy6CYfsTwaPwWQQZq6UE2qRm@nongnu.org
X-Gm-Message-State: AOJu0YyaHeJTU641BqXYNI9T4CAjlB7s6x+wQ+zLXmgNC1lDwiy5ynCI
 rFyzCLC1NHDN7Y3yYAZYl0NhUGPevI3b52RXdh528U75oZXvIRjmrr+lVmd0XzboSYX4g2JfgcT
 3w0yD/90AcMkcExhv6NvzO9CWnw0TdAI=
X-Gm-Gg: ASbGncuJxEBPg/9g+4P8QUeeYpCX2ELI9/OcN3UftkrN0/3pBf51Xkm1EcQLgXChIFI
 MRCWlFG3Yn4fNV1cdnP01ohnxi21if0FXz8AJS2EEAbymHzMefIMqPlXIjUJ14JUSpfTutMFLbC
 KQC/VoQcCTp4lnbMBEroZpwfbpbJ3TBM7B1C3Co+2JWA==
X-Google-Smtp-Source: AGHT+IFAotr1aWsjMdHwMC+wbjNnnhwUvmA0qx9FpJQmZhbDQU4WShY6h5az0QoAouOzaCFl9WMQviPtqG8zM5dwsN4=
X-Received: by 2002:a17:907:944b:b0:ad8:9878:b898 with SMTP id
 a640c23a62f3a-ade1a9c823cmr26103166b.9.1749148682242; Thu, 05 Jun 2025
 11:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250601181231.3461-1-tanishdesai37@gmail.com>
 <20250601181231.3461-3-tanishdesai37@gmail.com>
 <20250602222434.GB320269@fedora>
 <7f4eefa2-9e00-4ba2-898f-c480c2123904@redhat.com>
In-Reply-To: <7f4eefa2-9e00-4ba2-898f-c480c2123904@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 5 Jun 2025 14:37:50 -0400
X-Gm-Features: AX0GCFvp9x41CLLl2mzb_Zsqx3aVVObl3ap4UGmtFakED4qAlemhVSga9BIircI
Message-ID: <CAJSP0QX=e3GkB5L0rpAf8YfkJDKOZYJcx553tut+7Hp2NK3XYg@mail.gmail.com>
Subject: Re: [PATCH 2/3] trace/ftrace: seperate cold paths of tracing functions
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Tanish Desai <tanishdesai37@gmail.com>, qemu-devel@nongnu.org, 
 Mads Ynddal <mads@ynddal.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x536.google.com
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

On Thu, Jun 5, 2025 at 9:57=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> On 6/3/25 00:24, Stefan Hajnoczi wrote:
> > On Sun, Jun 01, 2025 at 06:12:30PM +0000, Tanish Desai wrote:
> >> Moved rarely used (cold) code from the header file to the C file to av=
oid
> >> unnecessary inlining and reduce binary size.
> >
> > How much of a binary size reduction do you measure? Most trace events
> > are only called once, so the difference in code size is likely to be
> > small.
>
> Indeed I don't think there would be much reduction.  I expect a bigger
> benefit in terms of improved register allocation when tracepoints are
> disabled, keeping unused tracepoint code out of the TLB, and the like.
>
> That is, the difference in code size would be in the functions that
> include tracepoints, not in QEMU overall.  That's a bit difficult to
> measure because you would have to isolate tracepoint code in the
> "before" .o files, but we can try.
>
> >> This improves code organization
> >> and follows good practices for managing cold paths.
> >
> > It's easier to understand the code generator and the generated code whe=
n
> > each trace event is implemented as a single function in the header file=
.
> > Splitting the trace event up adds complexity. I don't think this is a
> > step in the right direction.
>
> I am not sure I agree on that; something like
>
> static inline void trace_smmu_config_cache_inv(uint32_t sid)
> {
>      if (trace_event_get_state(TRACE_SMMU_CONFIG_CACHE_INV)) {
>          _simple__trace_smmu_config_cache_inv(sid);
>          _log__trace_smmu_config_cache_inv(sid);
>      }
>      QEMU_SMMU_CONFIG_CACHE_INV(sid);
>      tracepoint(qemu, smmu_config_cache_inv(sid));
> }
>
> and one function per backend seems the most readable way to format the
> code in the headers.  I understand that most of the time you'll have
> only one backend enabled, but still the above seems pretty good and
> clarifies the difference between efficient backends like dtrace and UST
> and the others.
>
> This series doesn't go all the way to something like the above, but it
> does go in that direction.

It's nice to share a single trace_event_get_state() conditional
between all backends that use it. There is no need to move the
generated code from .h into a .c file to achieve this though.

In the absence of performance data this patch series seems like
premature optimization and code churn to me.

> Now, in all honesty the main reason to do this was to allow reusing the
> C code generator when it's Rust code that is using tracepoints; but I do
> believe that these changes make sense on their own, and I didn't want to
> make these a blocker for Rust enablement as well (Tanish has already
> looked into generating Rust code for the simple backend, for example).

How is this patch series related to Rust tracing? If generated code
needs to be restructured so Rust can call it, then that's a strong
justification.

Stefan

>
> Paolo
>
>
> >> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> >> ---
> >>   scripts/tracetool/backend/ftrace.py | 44 +++++++++++++++++++++------=
--
> >>   1 file changed, 32 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/b=
ackend/ftrace.py
> >> index baed2ae61c..c9717d7b42 100644
> >> --- a/scripts/tracetool/backend/ftrace.py
> >> +++ b/scripts/tracetool/backend/ftrace.py
> >> @@ -23,6 +23,10 @@
> >>   def generate_h_begin(events, group):
> >>       out('#include "trace/ftrace.h"',
> >>           '')
> >> +    for event in events:
> >> +        out('void _ftrace_%(api)s(%(args)s);',
> >> +            api=3Devent.api(),
> >> +            args=3Devent.args)
> >>
> >>
> >>   def generate_h(event, group):
> >> @@ -30,26 +34,42 @@ def generate_h(event, group):
> >>       if len(event.args) > 0:
> >>           argnames =3D ", " + argnames
> >>
> >> -    out('    {',
> >> +    out('        if (trace_event_get_state(%(event_id)s)) {',
> >> +        '           _ftrace_%(api)s(%(args)s);',
> >> +        '        }',
> >> +        name=3Devent.name,
> >> +        args=3D", ".join(event.args.names()),
> >> +        event_id=3D"TRACE_" + event.name.upper(),
> >> +        event_lineno=3Devent.lineno,
> >> +        event_filename=3Dos.path.relpath(event.filename),
> >> +        fmt=3Devent.fmt.rstrip("\n"),
> >> +        argnames=3Dargnames,
> >> +        api=3Devent.api()
> >> +        )
> >> +
> >> +
> >> +def generate_c(event, group):
> >> +        argnames =3D ", ".join(event.args.names())
> >> +        if len(event.args) > 0:
> >> +            argnames =3D ", " + argnames
> >> +        out('void _ftrace_%(api)s(%(args)s){',
> >>           '        char ftrace_buf[MAX_TRACE_STRLEN];',
> >>           '        int unused __attribute__ ((unused));',
> >>           '        int trlen;',
> >> -        '        if (trace_event_get_state(%(event_id)s)) {',
> >>           '#line %(event_lineno)d "%(event_filename)s"',
> >> -        '            trlen =3D snprintf(ftrace_buf, MAX_TRACE_STRLEN,=
',
> >> -        '                             "%(name)s " %(fmt)s "\\n" %(arg=
names)s);',
> >> +        '       trlen =3D snprintf(ftrace_buf, MAX_TRACE_STRLEN,',
> >>           '#line %(out_next_lineno)d "%(out_filename)s"',
> >> -        '            trlen =3D MIN(trlen, MAX_TRACE_STRLEN - 1);',
> >> -        '            unused =3D write(trace_marker_fd, ftrace_buf, tr=
len);',
> >> -        '        }',
> >> -        '    }',
> >> -        name=3Devent.name,
> >> -        args=3Devent.args,
> >> -        event_id=3D"TRACE_" + event.name.upper(),
> >> +        '                       "%(name)s " %(fmt)s "\\n" %(argnames)=
s);',
> >> +        '       trlen =3D MIN(trlen, MAX_TRACE_STRLEN - 1);',
> >> +        '       unused =3D write(trace_marker_fd, ftrace_buf, trlen);=
',
> >> +        '}',
> >>           event_lineno=3Devent.lineno,
> >>           event_filename=3Dos.path.relpath(event.filename),
> >> +        name=3Devent.name,
> >>           fmt=3Devent.fmt.rstrip("\n"),
> >> -        argnames=3Dargnames)
> >> +        argnames=3Dargnames,
> >> +        api=3Devent.api(),
> >> +        args=3Devent.args)
> >>
> >>
> >>   def generate_h_backend_dstate(event, group):
> >> --
> >> 2.34.1
> >>
>
>

