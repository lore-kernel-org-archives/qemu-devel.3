Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B427AC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 14:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSctZ-0002GN-5t; Fri, 20 Jun 2025 10:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uSctT-0002D7-4o
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 10:39:03 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uSctR-0001nh-Bm
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 10:39:02 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ae04d3d63e6so221855666b.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 07:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750430337; x=1751035137; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=phMSKdbahPARNWfkS7zIBhRvgxVfEs15lqcI5c+111I=;
 b=GyONDFm97IkllUCQ8GGcWwpTV44AIvUsD9jBhJ5vZi3Qd48nNvrIdXEt2rnrp6RQlq
 NTSe6SQ2gwMqFMsSW/CPGES/QiCs+aQA6MCaHsqOxjdUzeqSWjF1qxhrm7qo/27mxLGq
 ZlX5hMiwKNv5c+nCpHCjTce2YDKGuG2bBwB+CVlwVfI1tYMon7Yl+Xhpl/IaUP9F1n4z
 7wj4hWjz0jmgPJc7CB8yCDNmNc49qL47J0zuFLjyOYOMgIbl5uLV42ZXxr4JTkjq0G8U
 1w0gJ0QDP8Ik0yOhvoMla35hN2HObhKTYY/zkzIfc4rz7sFNKrglzH6VAL9a6f10RJE4
 MpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750430337; x=1751035137;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=phMSKdbahPARNWfkS7zIBhRvgxVfEs15lqcI5c+111I=;
 b=tq/gtUzWDgB/yOVdcQ2FH/WWGZhcUwk7FFScw72dX3OyYVWvyI2Yf4MPQlByNGVJRS
 tZCjpb3nAPFVZgCUG9t0uepS05RbjWZTZUG1vSsihnb/kP8TdDWz2TGQAywdbDzZomim
 v/qv6bs3iMCGZAXvlMAtFpQwwMcZa5JFAp68PJUWaftpBtUVcqJgVpLhw1QKAfHhYB6D
 orgEPESa1MFOiORCvjPR3Nw9KhCjDzXGKQ0+D4qHoXOMdy6NXRVUiZLte4DLWBan6/f2
 GYXiAFxTAhJd9dkLdT8Ngr9WVueHtFovJyfWc1uVMdiK8tT42xZuXTRb7eNTLg6PILqP
 ZxFw==
X-Gm-Message-State: AOJu0Yyq24kjKlMLr4GQ/lHdoFb00aVSQ91hkqw88ME4QafUQ86s1NgE
 F2L2wAToAXivGlDFswNyLoEt6acCLhEGYtnKYSLw0Qr78XKC/+YHFnFHA+fu7IsOG0BrtJTs2CY
 pXxVkRD95VfsmIWV7Kp7re8Ns32Vbf50doRPD
X-Gm-Gg: ASbGncvaUz+zkk8itamRBHIN+vtKyLTDZozPfHD5mIGbVCIbvuFbmSXS6yJsnAtLfix
 kv5D8APiej9/gCvlwz8JhiVHrOEOqQqsfPcdiQKM3X+4MM4CMZFrZ8/HOpuEd10FdTzu2CV30+m
 fI78iOHXJNQG4V/RG91KBQCXpaskEywWG8h2t5AaF2c9Y+h7iLOWKEQYgaibKU2+19JxNwIH3k3
 LETMg==
X-Google-Smtp-Source: AGHT+IHLtid/4ZTPOkRuqZBHCMRySj3SBJgQObIVHfJWCeWaAnGGvPpdAYnvoYWQC5FXhyGgkWgTDw/iiBRqKzkzSkg=
X-Received: by 2002:a17:907:9612:b0:ad8:a935:b90f with SMTP id
 a640c23a62f3a-ae057927b32mr325554166b.7.1750430337122; Fri, 20 Jun 2025
 07:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250620143720.3143-1-tanishdesai37@gmail.com>
In-Reply-To: <20250620143720.3143-1-tanishdesai37@gmail.com>
From: Tanish Desai <tanishdesai37@gmail.com>
Date: Fri, 20 Jun 2025 20:08:46 +0530
X-Gm-Features: Ac12FXzbLgc38tom0Gcf2ntrE-lvhIXUk3r_-KUyN7ZopNxUYoVu-MbVjNYkOc4
Message-ID: <CAH_Y1jc3Bx9hKD=hUG3_smpOVb_Q1iGuCpQ4HSGkng9nrp2bbQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] tracetool: cleanup "if(true)" check from
 trace_foo()
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000072c649063801d2be"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=tanishdesai37@gmail.com; helo=mail-ej1-x62a.google.com
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

--00000000000072c649063801d2be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry forgot to CC Alex and Paolo .


On Fri, 20 Jun 2025 at 8:07=E2=80=AFPM, Tanish Desai <tanishdesai37@gmail.c=
om>
wrote:

> This series of patch aims to removes the leftover if (true) condition
> from trace_foo, a remnant from the TCG tracing feature removal.
>
> It replaces it with a proper trace_event_get_state(...)
> check where necessary (for log/simple/syslog and ftrace backend).
>
> Additionally, this change centralizes the generation of
> trace_event_get_state(...) calls into format/h.py,
> eliminating redundant code across individual backends.
>
> This cleanup results in more consistent and less
> repetitive backend code.
>
> Tanish Desai (3):
>   tracetool: removed the unused vcpu property
>   tracetool: introduce generate_unconditional
>   tracetool: remove redundant event_get_state checks
>
>  scripts/tracetool/__init__.py         |  6 +++---
>  scripts/tracetool/backend/__init__.py |  3 +++
>  scripts/tracetool/backend/dtrace.py   |  3 ++-
>  scripts/tracetool/backend/ftrace.py   |  3 ---
>  scripts/tracetool/backend/log.py      |  9 +--------
>  scripts/tracetool/backend/simple.py   | 11 +----------
>  scripts/tracetool/backend/syslog.py   | 11 +----------
>  scripts/tracetool/backend/ust.py      |  2 +-
>  scripts/tracetool/format/h.py         | 13 +++++++++----
>  9 files changed, 21 insertions(+), 40 deletions(-)
>
> --
> 2.34.1
>
>

--00000000000072c649063801d2be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><br clear=3D"all">Sorry forgot to CC Alex and Paolo .</di=
v><div><br></div><div><br><div class=3D"gmail_quote gmail_quote_container">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, 20 Jun 2025 at 8:07=E2=80=AFP=
M, Tanish Desai &lt;<a href=3D"mailto:tanishdesai37@gmail.com">tanishdesai3=
7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;=
padding-left:1ex;border-left-color:rgb(204,204,204)">This series of patch a=
ims to removes the leftover if (true) condition<br>
from trace_foo, a remnant from the TCG tracing feature removal.<br>
<br>
It replaces it with a proper trace_event_get_state(...)<br>
check where necessary (for log/simple/syslog and ftrace backend).<br>
<br>
Additionally, this change centralizes the generation of<br>
trace_event_get_state(...) calls into format/h.py,<br>
eliminating redundant code across individual backends.<br>
<br>
This cleanup results in more consistent and less<br>
repetitive backend code.<br>
<br>
Tanish Desai (3):<br>
=C2=A0 tracetool: removed the unused vcpu property<br>
=C2=A0 tracetool: introduce generate_unconditional<br>
=C2=A0 tracetool: remove redundant event_get_state checks<br>
<br>
=C2=A0scripts/tracetool/__init__.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 6 +++---<br>
=C2=A0scripts/tracetool/backend/__init__.py |=C2=A0 3 +++<br>
=C2=A0scripts/tracetool/backend/dtrace.py=C2=A0 =C2=A0|=C2=A0 3 ++-<br>
=C2=A0scripts/tracetool/backend/ftrace.py=C2=A0 =C2=A0|=C2=A0 3 ---<br>
=C2=A0scripts/tracetool/backend/log.py=C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 +-----=
---<br>
=C2=A0scripts/tracetool/backend/simple.py=C2=A0 =C2=A0| 11 +----------<br>
=C2=A0scripts/tracetool/backend/syslog.py=C2=A0 =C2=A0| 11 +----------<br>
=C2=A0scripts/tracetool/backend/ust.py=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0scripts/tracetool/format/h.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 13 +=
++++++++----<br>
=C2=A09 files changed, 21 insertions(+), 40 deletions(-)<br>
<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--00000000000072c649063801d2be--

