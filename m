Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75135C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 21:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXp83-0004UN-Qs; Wed, 07 Feb 2024 16:06:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1rXp80-0004TR-VF
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 16:06:46 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1rXp7u-0007hS-Md
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 16:06:43 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5601eb97b29so486331a12.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 13:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1707339996; x=1707944796;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gh5NF6YhaHOWiRc2S6jbyUGr9y31fomAyBbbtNeJX3c=;
 b=LDOhY6AZF+xmxMyeSgoxT4VKkYU/+8XX8J6Pnj6UntlC4wnxwFWZdFfLvDWPniJr9O
 UWDfo9E2YpBmNY5JhMsJbF+zK8LnXyY+epslDUHXPSS3f4D3jfnubri5qlgUqmG8Jyey
 GXNMFAgYWxO6toHb7E1/pOVVQiPADXo8KdOWYPQcXVyE7i7Ddb80hVpWopgksY8FXpbj
 tk95S3KxB9ON2ftTRL+EHuJPszkzpL8HBthCnD2/cI1mZDK4+BsyGj3qR6QFmwE13opX
 zhb/YxJgGD4jXJ+ykKGQbdzagGNyXdLdYHaZPz1idhutVrTaRt818/YlG2Q7CTmZt6Ei
 fRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707339996; x=1707944796;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gh5NF6YhaHOWiRc2S6jbyUGr9y31fomAyBbbtNeJX3c=;
 b=UhqEHk69aVUNaXBRD0GNY4S7RfP0m63DnN8+SyQzDDiSGQQSv++NdHrICkEflg8Mxz
 mGxZ4fi7b3oEfNnZq/eD0vsaBqBkM78bBw3zshafuwtoqFVPFAhmwz4U7xO6p1u8B0Ey
 hdg7QQ4XTqv9KamMx7GT6hiWSFcbOkisXIuzhnQCzMgyQEdu07pme3w+hWd9bfeFPMiX
 8u/5BRtlJhW3d3aYOKUBT34OonBc/DK3tOJN+eeFY10L5CvAQgP31K4RJZdhWJm651NK
 RDbRZ41kx1gyrhPbMwEj8MbaLOV9yJEI6m/hnUi6BORuvkLV1tLh2jUiYMVgTEhBARyo
 EswA==
X-Gm-Message-State: AOJu0YyQ+GFeL+zvxtfbly5vT0x0ZEIiEwPOi6OOqKZC1VCxU5MthXA5
 n8jtKpGGNqKQ6pAs8Pyb3ZLI59m+roXZVCEJUicH+tjHdah0KF2o1DS0WGuHRHauNUhAy5uea96
 xFHUZk1M0p2UD2IohHM7F8Ua8EFs3fe4rdzv0uw==
X-Google-Smtp-Source: AGHT+IGmIkQ9BPOMs4p0CXeiI67xhhDx0pv1MFVXJPeBOMCo6gvXBlh48GntaipIr7Qlo8M3XuTs1BkWDr5ABb3CLGI=
X-Received: by 2002:a05:6402:180a:b0:560:24d8:d2d1 with SMTP id
 g10-20020a056402180a00b0056024d8d2d1mr636398edy.11.1707339996233; Wed, 07 Feb
 2024 13:06:36 -0800 (PST)
MIME-Version: 1.0
References: <20240129164514.73104-1-philmd@linaro.org>
 <20240129164514.73104-30-philmd@linaro.org>
In-Reply-To: <20240129164514.73104-30-philmd@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 7 Feb 2024 14:06:25 -0700
Message-ID: <CANCZdfoEAbV9cTg3R4RMD8PV6s0NAMvg1xhgspp-cX310uaF2Q@mail.gmail.com>
Subject: Re: [PATCH v3 29/29] user: Prefer fast cpu_env() over slower CPU QOM
 cast macro
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, qemu-ppc@nongnu.org, 
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="000000000000fc97cb0610d111a8"
Received-SPF: none client-ip=2a00:1450:4864:20::530;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--000000000000fc97cb0610d111a8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[[ I dont know if it's too late ]]

On Mon, Jan 29, 2024 at 9:48=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  bsd-user/signal.c   | 3 +--
>  linux-user/signal.c | 6 ++----
>  2 files changed, 3 insertions(+), 6 deletions(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>


> diff --git a/bsd-user/signal.c b/bsd-user/signal.c
> index ca31470772..c6f0b1be38 100644
> --- a/bsd-user/signal.c
> +++ b/bsd-user/signal.c
> @@ -463,14 +463,13 @@ static int fatal_signal(int sig)
>  void force_sig_fault(int sig, int code, abi_ulong addr)
>  {
>      CPUState *cpu =3D thread_cpu;
> -    CPUArchState *env =3D cpu_env(cpu);
>      target_siginfo_t info =3D {};
>
>      info.si_signo =3D sig;
>      info.si_errno =3D 0;
>      info.si_code =3D code;
>      info.si_addr =3D addr;
> -    queue_signal(env, sig, QEMU_SI_FAULT, &info);
> +    queue_signal(cpu_env(cpu), sig, QEMU_SI_FAULT, &info);
>  }
>
>  static void host_signal_handler(int host_sig, siginfo_t *info, void *puc=
)
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index c9527adfa3..f78f7fc476 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -623,7 +623,6 @@ void signal_init(void)
>  void force_sig(int sig)
>  {
>      CPUState *cpu =3D thread_cpu;
> -    CPUArchState *env =3D cpu_env(cpu);
>      target_siginfo_t info =3D {};
>
>      info.si_signo =3D sig;
> @@ -631,7 +630,7 @@ void force_sig(int sig)
>      info.si_code =3D TARGET_SI_KERNEL;
>      info._sifields._kill._pid =3D 0;
>      info._sifields._kill._uid =3D 0;
> -    queue_signal(env, info.si_signo, QEMU_SI_KILL, &info);
> +    queue_signal(cpu_env(cpu), info.si_signo, QEMU_SI_KILL, &info);
>  }
>
>  /*
> @@ -641,14 +640,13 @@ void force_sig(int sig)
>  void force_sig_fault(int sig, int code, abi_ulong addr)
>  {
>      CPUState *cpu =3D thread_cpu;
> -    CPUArchState *env =3D cpu_env(cpu);
>      target_siginfo_t info =3D {};
>
>      info.si_signo =3D sig;
>      info.si_errno =3D 0;
>      info.si_code =3D code;
>      info._sifields._sigfault._addr =3D addr;
> -    queue_signal(env, sig, QEMU_SI_FAULT, &info);
> +    queue_signal(cpu_env(cpu), sig, QEMU_SI_FAULT, &info);
>  }
>
>  /* Force a SIGSEGV if we couldn't write to memory trying to set
> --
> 2.41.0
>
>

--000000000000fc97cb0610d111a8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">[[ I dont=C2=A0know if it&#39;s too late =
]]</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Mon, Jan 29, 2024 at 9:48=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<=
a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">Mechanical patch produ=
ced running the command documented<br>
in scripts/coccinelle/cpu_env.cocci_template header.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/signal.c=C2=A0 =C2=A0| 3 +--<br>
=C2=A0linux-user/signal.c | 6 ++----<br>
=C2=A02 files changed, 3 insertions(+), 6 deletions(-)<br></blockquote><div=
><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.c=
om">imp@bsdimp.com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
diff --git a/bsd-user/signal.c b/bsd-user/signal.c<br>
index ca31470772..c6f0b1be38 100644<br>
--- a/bsd-user/signal.c<br>
+++ b/bsd-user/signal.c<br>
@@ -463,14 +463,13 @@ static int fatal_signal(int sig)<br>
=C2=A0void force_sig_fault(int sig, int code, abi_ulong addr)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cpu =3D thread_cpu;<br>
-=C2=A0 =C2=A0 CPUArchState *env =3D cpu_env(cpu);<br>
=C2=A0 =C2=A0 =C2=A0target_siginfo_t info =3D {};<br>
<br>
=C2=A0 =C2=A0 =C2=A0info.si_signo =3D sig;<br>
=C2=A0 =C2=A0 =C2=A0info.si_errno =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0info.si_code =3D code;<br>
=C2=A0 =C2=A0 =C2=A0info.si_addr =3D addr;<br>
-=C2=A0 =C2=A0 queue_signal(env, sig, QEMU_SI_FAULT, &amp;info);<br>
+=C2=A0 =C2=A0 queue_signal(cpu_env(cpu), sig, QEMU_SI_FAULT, &amp;info);<b=
r>
=C2=A0}<br>
<br>
=C2=A0static void host_signal_handler(int host_sig, siginfo_t *info, void *=
puc)<br>
diff --git a/linux-user/signal.c b/linux-user/signal.c<br>
index c9527adfa3..f78f7fc476 100644<br>
--- a/linux-user/signal.c<br>
+++ b/linux-user/signal.c<br>
@@ -623,7 +623,6 @@ void signal_init(void)<br>
=C2=A0void force_sig(int sig)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cpu =3D thread_cpu;<br>
-=C2=A0 =C2=A0 CPUArchState *env =3D cpu_env(cpu);<br>
=C2=A0 =C2=A0 =C2=A0target_siginfo_t info =3D {};<br>
<br>
=C2=A0 =C2=A0 =C2=A0info.si_signo =3D sig;<br>
@@ -631,7 +630,7 @@ void force_sig(int sig)<br>
=C2=A0 =C2=A0 =C2=A0info.si_code =3D TARGET_SI_KERNEL;<br>
=C2=A0 =C2=A0 =C2=A0info._sifields._kill._pid =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0info._sifields._kill._uid =3D 0;<br>
-=C2=A0 =C2=A0 queue_signal(env, info.si_signo, QEMU_SI_KILL, &amp;info);<b=
r>
+=C2=A0 =C2=A0 queue_signal(cpu_env(cpu), info.si_signo, QEMU_SI_KILL, &amp=
;info);<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
@@ -641,14 +640,13 @@ void force_sig(int sig)<br>
=C2=A0void force_sig_fault(int sig, int code, abi_ulong addr)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cpu =3D thread_cpu;<br>
-=C2=A0 =C2=A0 CPUArchState *env =3D cpu_env(cpu);<br>
=C2=A0 =C2=A0 =C2=A0target_siginfo_t info =3D {};<br>
<br>
=C2=A0 =C2=A0 =C2=A0info.si_signo =3D sig;<br>
=C2=A0 =C2=A0 =C2=A0info.si_errno =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0info.si_code =3D code;<br>
=C2=A0 =C2=A0 =C2=A0info._sifields._sigfault._addr =3D addr;<br>
-=C2=A0 =C2=A0 queue_signal(env, sig, QEMU_SI_FAULT, &amp;info);<br>
+=C2=A0 =C2=A0 queue_signal(cpu_env(cpu), sig, QEMU_SI_FAULT, &amp;info);<b=
r>
=C2=A0}<br>
<br>
=C2=A0/* Force a SIGSEGV if we couldn&#39;t write to memory trying to set<b=
r>
-- <br>
2.41.0<br>
<br>
</blockquote></div></div>

--000000000000fc97cb0610d111a8--

