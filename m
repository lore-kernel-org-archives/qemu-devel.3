Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AE5C0219B
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2025 19:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thDFS-00060g-UB; Sun, 09 Feb 2025 14:45:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1thDFP-0005zh-Hi
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 14:45:43 -0500
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1thDFM-0000OH-B9
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 14:45:42 -0500
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-51f6f80e27cso1015483e0c.0
 for <qemu-devel@nongnu.org>; Sun, 09 Feb 2025 11:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1739130337; x=1739735137;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=urNuZnXPwv+gJ6vliVoctc1I7osNV5qRMxUlbAmOQQA=;
 b=VjMyjEG8ibVIoVKsUXkpdL656fgGSU3AzM/o/H5KW47hJtQ4PqDTw/OSJP/DHfofwJ
 aBH3c5pwDz35E/GoE1IGSVu7EquyfLdx7rM8pYoAm2caAtVtPox9XIFkuRfwN6dlhHCK
 Xi4VymXxSzZr7F2CuPiUE9TOIqwJMRKwcXBc+AvwV80vsVPrVMBYlw7ktLAmiDgxTMCT
 mo2X7a4Nk8MtQByhszJb2SJJ1feL7TEcqHsEunH0qWC26gbrOF7po0s++D8CfxSiVxDh
 1Pe+0MErEGx+U0hTK/mWBqLWYjQzbbVv33lEXCcP13r9/2bBq+LeiUhqkq1q755ZGBN6
 x9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739130337; x=1739735137;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=urNuZnXPwv+gJ6vliVoctc1I7osNV5qRMxUlbAmOQQA=;
 b=Hp8KGLw4b1i5EZvGzKRXqclzftsTsLALtAUl9gYdGFKx7craiZ2QJvwWQMpCrKHgrM
 om5/HTWueZsKC4tc47eP6pOKE4QCZZGsuERIjtSfBicDcjB1/zlK9ZFo2xlwU2vSz1Cq
 Dbj+z3tu3NnvFkgMlKpHplZ7wpci/b1pO5PBY7y8g2IbZO+a3IiQTe0mOzUYRAGi2y5v
 Y990k7T6m67lmjtIWK7PZGf9A6A4zhFrVHifo6lopTeE0kCOn4ATT78FqXvHQEu8cBXQ
 lEhoVZna/KE6gy/cxtRZJV6v5yyH2CHZdxlz2neZdEeGJCprwnS4r73M7R9GtPfxnVTP
 2cDw==
X-Gm-Message-State: AOJu0YzUBkcnXz9JQb1xRkzaqiWqZEFSa+JtCvMtz3b4oRN19GDUAs2q
 agJqshHWfbNMAzghvSaVZnqwi3+IDrkYSoCr89/hCbLh1uE+mveRezgvH6jBfgD2nRzHm4FQ7uJ
 oVcOql/XLmxT+0FCzRX1iCCXkAZlyfVmm1Sfr
X-Gm-Gg: ASbGncvpW0Me2nszeNOSCwwMy9T+PgReU0DwzOKCg/cI0O2BqzlyysPIneFKpmDaR3M
 whBfPNdfdLP4spdVRaY+MDWxFV+1crlzx1NZd/I2AMCaBjNUWGoDhDu860vLKqpOlkTEexRLI
X-Google-Smtp-Source: AGHT+IF7BIN9NBvFhuwEbhxnFJqw9dJgEUC4vS2m+LPBfU+zwxkY9m1zAx0R2dOjsUtpaV5gdCrJthOyTd5Mgv+THb8=
X-Received: by 2002:a05:6122:2c84:b0:51f:405f:c967 with SMTP id
 71dfb90a1353d-51f405fcc7amr4059363e0c.7.1739130335635; Sun, 09 Feb 2025
 11:45:35 -0800 (PST)
MIME-Version: 1.0
References: <20241209203629.74436-1-phil@philjordan.eu>
 <20241209203629.74436-2-phil@philjordan.eu>
 <64671a22-a1d3-4d76-839c-287e5cf2390b@linaro.org>
In-Reply-To: <64671a22-a1d3-4d76-839c-287e5cf2390b@linaro.org>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Sun, 9 Feb 2025 20:45:24 +0100
X-Gm-Features: AWEUYZmZ5HszkudiG_qqFFkPBoFn_OqWcR7OBBCUhj8xxekGCQHH3XwdROj7Yqw
Message-ID: <CAAibmn3=-R69ap7AkdwS9w0LO__FmCtMp2eHbZVNn2bt-+D_5A@mail.gmail.com>
Subject: Re: [PATCH 01/11] hvf: Add facility for initialisation code prior to
 first vCPU run
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000dfc52a062dbad566"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::a29;
 envelope-from=phil@philjordan.eu; helo=mail-vk1-xa29.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000dfc52a062dbad566
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Feb 2025 at 22:02, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
>
wrote:

> +Igor
>
> On 9/12/24 21:36, phil@philjordan.eu wrote:
> > From: Phil Dennis-Jordan <phil@philjordan.eu>
> >
> > Some VM state required for fully configuring vCPUs is only available
> > after all devices have been through their init phase. This extra
> > function, called just before each vCPU makes its first VM entry,
> > allows us to perform such architecture-specific initialisation.
> >
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > ---
> >   accel/hvf/hvf-accel-ops.c | 5 +++++
> >   include/sysemu/hvf_int.h  | 1 +
> >   target/arm/hvf/hvf.c      | 4 ++++
> >   target/i386/hvf/hvf.c     | 4 ++++
> >   4 files changed, 14 insertions(+)
> >
> > diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
> > index d60874d3e6..c17a9a10de 100644
> > --- a/accel/hvf/hvf-accel-ops.c
> > +++ b/accel/hvf/hvf-accel-ops.c
> > @@ -442,6 +442,11 @@ static void *hvf_cpu_thread_fn(void *arg)
> >       cpu_thread_signal_created(cpu);
> >       qemu_guest_random_seed_thread_part2(cpu->random_seed);
> >
> > +    if (!cpu_can_run(cpu)) {
> > +        qemu_wait_io_event(cpu);
> > +    }
> > +    hvf_vcpu_before_first_run(cpu);
>
> Could this be fixed by the cpu_list_add() split?
> https://lore.kernel.org/qemu-devel/20250128142152.9889-1-philmd@linaro.or=
g/
>
>
You mean by implementing a wire() handler for HVF CPU classes? Possibly -
I'll need to apply those patches locally and trace in what context those
wire methods would run. HVF wants most vCPU-specific functions to be run on
the thread owning the vCPU, so if wire() runs on the main QEMU event
handling thread (or anything other than the vCPU's own thread), it won't
work for patches 2 & 7 from this series which actually do stuff in these
before_first_run() handlers.

I notice that Igor's v2 of the cpu_list_add patch set no longer includes
the wire()/unwire() handlers=E2=80=A6
https://patchew.org/QEMU/20250207162048.1890669-1-imammedo@redhat.com/

Another option might be to use async_run_on_cpu() for such early
on-vCPU-thread initialisation, but I figured that option would perhaps be a
little to indirect to readers of the code and difficult to reason about.

>       do {
> >           if (cpu_can_run(cpu)) {
> >               r =3D hvf_vcpu_exec(cpu);
>

--000000000000dfc52a062dbad566
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 5 Feb 2025 a=
t 22:02, Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.or=
g" target=3D"_blank">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">+Igor<br>
<br>
On 9/12/24 21:36, <a href=3D"mailto:phil@philjordan.eu" target=3D"_blank">p=
hil@philjordan.eu</a> wrote:<br>
&gt; From: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu" tar=
get=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; <br>
&gt; Some VM state required for fully configuring vCPUs is only available<b=
r>
&gt; after all devices have been through their init phase. This extra<br>
&gt; function, called just before each vCPU makes its first VM entry,<br>
&gt; allows us to perform such architecture-specific initialisation.<br>
&gt; <br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0accel/hvf/hvf-accel-ops.c | 5 +++++<br>
&gt;=C2=A0 =C2=A0include/sysemu/hvf_int.h=C2=A0 | 1 +<br>
&gt;=C2=A0 =C2=A0target/arm/hvf/hvf.c=C2=A0 =C2=A0 =C2=A0 | 4 ++++<br>
&gt;=C2=A0 =C2=A0target/i386/hvf/hvf.c=C2=A0 =C2=A0 =C2=A0| 4 ++++<br>
&gt;=C2=A0 =C2=A04 files changed, 14 insertions(+)<br>
&gt; <br>
&gt; diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c<br>
&gt; index d60874d3e6..c17a9a10de 100644<br>
&gt; --- a/accel/hvf/hvf-accel-ops.c<br>
&gt; +++ b/accel/hvf/hvf-accel-ops.c<br>
&gt; @@ -442,6 +442,11 @@ static void *hvf_cpu_thread_fn(void *arg)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_thread_signal_created(cpu);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_guest_random_seed_thread_part2(cpu-&gt;=
random_seed);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 if (!cpu_can_run(cpu)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_wait_io_event(cpu);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 hvf_vcpu_before_first_run(cpu);<br>
<br>
Could this be fixed by the cpu_list_add() split?<br>
<a href=3D"https://lore.kernel.org/qemu-devel/20250128142152.9889-1-philmd@=
linaro.org/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/q=
emu-devel/20250128142152.9889-1-philmd@linaro.org/</a><br>
<br></blockquote><div><br></div><div>You mean by implementing a wire() hand=
ler for HVF CPU classes? Possibly - I&#39;ll need to apply those patches lo=
cally and trace in what context those wire methods would run. HVF wants mos=
t vCPU-specific functions to be run on the thread owning the vCPU, so if wi=
re() runs on the main QEMU event handling thread (or anything other than th=
e vCPU&#39;s own thread), it won&#39;t work for patches 2 &amp; 7 from this=
 series which actually do stuff in these before_first_run() handlers.</div>=
<div><br></div><div>I  notice that Igor&#39;s v2 of the cpu_list_add patch =
set no longer includes the wire()/unwire() handlers=E2=80=A6</div><div><a h=
ref=3D"https://patchew.org/QEMU/20250207162048.1890669-1-imammedo@redhat.co=
m/">https://patchew.org/QEMU/20250207162048.1890669-1-imammedo@redhat.com/<=
/a></div><div><br></div><div>Another option might be to use async_run_on_cp=
u() for such early on-vCPU-thread initialisation, but I figured that option=
 would perhaps be a little to indirect to readers of the code and difficult=
 to reason about.</div><div><br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0do {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cpu_can_run(cpu)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D hvf_vcpu_e=
xec(cpu);<br>
</blockquote></div></div>
</div>

--000000000000dfc52a062dbad566--

