Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FE6C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 14:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQpV5-00050U-3f; Mon, 08 Jul 2024 10:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sQpV0-0004lV-0n
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:37:50 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sQpUx-0003ej-Mt
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:37:49 -0400
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-81028024ec8so875849241.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 07:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1720449465; x=1721054265;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IV8C7TOWiA/jHjkH2AJCLuksU3FbrQCJeDbWcKU/MAY=;
 b=AGdHfo/bB2w9lzg/goNFttAqd+UKVBCC7SoXl0WpBaZhOVn1YR658FoMFTbO+wloOO
 E1CEsDm9SRAvWh8sNKD3n6/rSPFnlQVm/wKY1Pi8qMG0g09Vu6t3rh1aEd8fiI17cpsZ
 FsqEVqR9IcR5WVkgEg5doRZUBwojZ+9RS5QlDF0HCDzkBZ7pwiSf9Z92UwThSZwJ7dFo
 M4FzN4gN7MRUeq9nIsPC+L7bKqYj3n6ZUqDNYPUCFDKE3g99wBXxnsNDWOYSpSet/9xe
 pM1JKrRyzBpCMTXCjLIWr9AsKrnh12FX5h6gu17Vp5flk7tJI6siEesjSswFMHi9b5hq
 ruJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720449465; x=1721054265;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IV8C7TOWiA/jHjkH2AJCLuksU3FbrQCJeDbWcKU/MAY=;
 b=QlYEqUubb9x9efecqIKibols3o4NaQiOCfito/w78ksXr+DgYX2jNpwHrASwg6lbXh
 Tb6wyaXvngZROv/E0JZQAIE0Ff2/EOpne/d7ePAZxLc04Denamb2tax/iJdeaN+Ya/Fg
 GsShi4oeqZViO3gRHV/D3pYjRHu9FdIv4NmHl+mhKuY4ifl4NFXRgIqA7UEwoIwtvpGk
 o4/bkLJQ8zivQb9aTr2CdomNXkTzjmOWmJ00vttUHFDXBOa/FVlNnOOYNk/OvAPPFhP7
 +2IllI9gPb+ft+VPQIcPItSg0004JUUd3uvRZBydl0643+D977pZRGT5osh5dH6gqZeK
 PB8w==
X-Gm-Message-State: AOJu0YzOGkPyzDiIQqk6UP9k+PH5ZDsZiuxC8OiRYwj9yipDLARZOC+E
 9w1+Z6uirB3rFHVvFA1LCaY4ap3SX45aygCnNhlVvlB9yIeAnVCyuBihcjnHMCb30oTlhJwPDUN
 h2NMvezGKGuk06n8xigWv1tJcDb2mRlNa3Grw+NveJACxPy0=
X-Google-Smtp-Source: AGHT+IHRo3JIsuBHMrg8akgaVEkijiaGElEHOmDACJdGKvAwWNQPOcaQfgc2jK+43gVRXnQLpGDHxSZoOg+YTKFuej4=
X-Received: by 2002:a05:6102:19ca:b0:48f:95aa:ae2b with SMTP id
 ada2fe7eead31-48fee6bcc74mr11506837137.28.1720449465221; Mon, 08 Jul 2024
 07:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240624094647.77156-1-phil@philjordan.eu>
In-Reply-To: <20240624094647.77156-1-phil@philjordan.eu>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Mon, 8 Jul 2024 16:37:34 +0200
Message-ID: <CAAibmn0HizdzdqACQRQHamzYqL6J1_FPo-bzOodJQM2CCZv_dg@mail.gmail.com>
Subject: Re: [PATCH] i386/hvf: Integrates x2APIC support with hvf accel
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, lists@philjordan.eu, 
 minhquangbui99@gmail.com
Content-Type: multipart/alternative; boundary="0000000000003aa0c2061cbd5bb3"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::92d;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x92d.google.com
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

--0000000000003aa0c2061cbd5bb3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping!

It would be nice to get this one in before the 9.1 merge window closes.

Thanks,
Phil




On Mon, 24 Jun 2024 at 11:47, Phil Dennis-Jordan <phil@philjordan.eu> wrote=
:

> Support for x2APIC mode was recently introduced in the software emulated
> APIC implementation for TCG. Enabling it when using macOS=E2=80=99s hvf
> accelerator is useful and significantly helps performance, as Qemu
> currently uses the emulated APIC when running on hvf as well.
>
> This change wires up the read & write operations for the MSR VM exits
> and allow-lists the CPUID flag in the x86 hvf runtime.
>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>  target/i386/hvf/x86_cpuid.c |  4 ++--
>  target/i386/hvf/x86_emu.c   | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
> index e56cd8411b..4f260d46a8 100644
> --- a/target/i386/hvf/x86_cpuid.c
> +++ b/target/i386/hvf/x86_cpuid.c
> @@ -64,8 +64,8 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_=
t
> idx,
>               CPUID_PAT | CPUID_PSE36 | CPUID_CLFLUSH | CPUID_MMX |
>               CPUID_FXSR | CPUID_SSE | CPUID_SSE2 | CPUID_SS;
>          ecx &=3D CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSSE3 =
|
> -             CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID |
> -             CPUID_EXT_SSE41 | CPUID_EXT_SSE42 | CPUID_EXT_MOVBE |
> +             CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID |
> CPUID_EXT_SSE41 |
> +             CPUID_EXT_SSE42 | CPUID_EXT_X2APIC | CPUID_EXT_MOVBE |
>               CPUID_EXT_POPCNT | CPUID_EXT_AES | CPUID_EXT_XSAVE |
>               CPUID_EXT_AVX | CPUID_EXT_F16C | CPUID_EXT_RDRAND;
>          ecx |=3D CPUID_EXT_HYPERVISOR;
> diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
> index 38c782b8e3..be675bcfb7 100644
> --- a/target/i386/hvf/x86_emu.c
> +++ b/target/i386/hvf/x86_emu.c
> @@ -663,6 +663,15 @@ static void exec_lods(CPUX86State *env, struct
> x86_decode *decode)
>      env->eip +=3D decode->len;
>  }
>
> +static void raise_exception(CPUX86State *env, int exception_index,
> +                            int error_code)
> +{
> +    env->exception_nr =3D exception_index;
> +    env->error_code =3D error_code;
> +    env->has_error_code =3D true;
> +    env->exception_injected =3D 1;
> +}
> +
>  void simulate_rdmsr(CPUX86State *env)
>  {
>      X86CPU *cpu =3D env_archcpu(env);
> @@ -677,6 +686,17 @@ void simulate_rdmsr(CPUX86State *env)
>      case MSR_IA32_APICBASE:
>          val =3D cpu_get_apic_base(cpu->apic_state);
>          break;
> +    case MSR_APIC_START ... MSR_APIC_END: {
> +        int ret;
> +        int index =3D (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
> +
> +        ret =3D apic_msr_read(index, &val);
> +        if (ret < 0) {
> +            raise_exception(env, EXCP0D_GPF, 0);
> +        }
> +
> +        break;
> +    }
>      case MSR_IA32_UCODE_REV:
>          val =3D cpu->ucode_rev;
>          break;
> @@ -777,6 +797,17 @@ void simulate_wrmsr(CPUX86State *env)
>      case MSR_IA32_APICBASE:
>          cpu_set_apic_base(cpu->apic_state, data);
>          break;
> +    case MSR_APIC_START ... MSR_APIC_END: {
> +        int ret;
> +        int index =3D (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
> +
> +        ret =3D apic_msr_write(index, data);
> +        if (ret < 0) {
> +            raise_exception(env, EXCP0D_GPF, 0);
> +        }
> +
> +        break;
> +    }
>      case MSR_FSBASE:
>          wvmcs(cs->accel->fd, VMCS_GUEST_FS_BASE, data);
>          break;
> --
> 2.39.3 (Apple Git-146)
>
>

--0000000000003aa0c2061cbd5bb3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Ping!</div><div><br></div><div>It would be nice to ge=
t this one in before the 9.1 merge window closes.</div><div><br></div><div>=
Thanks,</div><div>Phil</div><div><br></div><div><br></div><div><br></div></=
div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Mon, 24 Jun 2024 at 11:47, Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@p=
hiljordan.eu" target=3D"_blank">phil@philjordan.eu</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Support for x2APIC mode w=
as recently introduced in the software emulated<br>
APIC implementation for TCG. Enabling it when using macOS=E2=80=99s hvf<br>
accelerator is useful and significantly helps performance, as Qemu<br>
currently uses the emulated APIC when running on hvf as well.<br>
<br>
This change wires up the read &amp; write operations for the MSR VM exits<b=
r>
and allow-lists the CPUID flag in the x86 hvf runtime.<br>
<br>
Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu"=
 target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
---<br>
=C2=A0target/i386/hvf/x86_cpuid.c |=C2=A0 4 ++--<br>
=C2=A0target/i386/hvf/x86_emu.c=C2=A0 =C2=A0| 31 ++++++++++++++++++++++++++=
+++++<br>
=C2=A02 files changed, 33 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c<br>
index e56cd8411b..4f260d46a8 100644<br>
--- a/target/i386/hvf/x86_cpuid.c<br>
+++ b/target/i386/hvf/x86_cpuid.c<br>
@@ -64,8 +64,8 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t =
idx,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUID_PAT | CPUID_PSE36 | =
CPUID_CLFLUSH | CPUID_MMX |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUID_FXSR | CPUID_SSE | C=
PUID_SSE2 | CPUID_SS;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ecx &amp;=3D CPUID_EXT_SSE3 | CPUID_EXT_P=
CLMULQDQ | CPUID_EXT_SSSE3 |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUID_EXT_FMA | CPUID_EXT_=
CX16 | CPUID_EXT_PCID |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUID_EXT_SSE41 | CPUID_EX=
T_SSE42 | CPUID_EXT_MOVBE |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUID_EXT_FMA | CPUID_EXT_=
CX16 | CPUID_EXT_PCID | CPUID_EXT_SSE41 |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUID_EXT_SSE42 | CPUID_EX=
T_X2APIC | CPUID_EXT_MOVBE |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUID_EXT_POPCNT | CPUID_E=
XT_AES | CPUID_EXT_XSAVE |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUID_EXT_AVX | CPUID_EXT_=
F16C | CPUID_EXT_RDRAND;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ecx |=3D CPUID_EXT_HYPERVISOR;<br>
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c<br>
index 38c782b8e3..be675bcfb7 100644<br>
--- a/target/i386/hvf/x86_emu.c<br>
+++ b/target/i386/hvf/x86_emu.c<br>
@@ -663,6 +663,15 @@ static void exec_lods(CPUX86State *env, struct x86_dec=
ode *decode)<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;eip +=3D decode-&gt;len;<br>
=C2=A0}<br>
<br>
+static void raise_exception(CPUX86State *env, int exception_index,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 int error_code)<br>
+{<br>
+=C2=A0 =C2=A0 env-&gt;exception_nr =3D exception_index;<br>
+=C2=A0 =C2=A0 env-&gt;error_code =3D error_code;<br>
+=C2=A0 =C2=A0 env-&gt;has_error_code =3D true;<br>
+=C2=A0 =C2=A0 env-&gt;exception_injected =3D 1;<br>
+}<br>
+<br>
=C2=A0void simulate_rdmsr(CPUX86State *env)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0X86CPU *cpu =3D env_archcpu(env);<br>
@@ -677,6 +686,17 @@ void simulate_rdmsr(CPUX86State *env)<br>
=C2=A0 =C2=A0 =C2=A0case MSR_IA32_APICBASE:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D cpu_get_apic_base(cpu-&gt;apic_st=
ate);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 case MSR_APIC_START ... MSR_APIC_END: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int index =3D (uint32_t)env-&gt;regs[R_ECX] - =
MSR_APIC_START;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D apic_msr_read(index, &amp;val);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise_exception(env, EXCP0D_GPF,=
 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0case MSR_IA32_UCODE_REV:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D cpu-&gt;ucode_rev;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -777,6 +797,17 @@ void simulate_wrmsr(CPUX86State *env)<br>
=C2=A0 =C2=A0 =C2=A0case MSR_IA32_APICBASE:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_set_apic_base(cpu-&gt;apic_state, dat=
a);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 case MSR_APIC_START ... MSR_APIC_END: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int index =3D (uint32_t)env-&gt;regs[R_ECX] - =
MSR_APIC_START;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D apic_msr_write(index, data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise_exception(env, EXCP0D_GPF,=
 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0case MSR_FSBASE:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wvmcs(cs-&gt;accel-&gt;fd, VMCS_GUEST_FS_=
BASE, data);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-- <br>
2.39.3 (Apple Git-146)<br>
<br>
</blockquote></div>

--0000000000003aa0c2061cbd5bb3--

