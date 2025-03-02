Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48A7C19F32
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Mar 2025 05:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tobcU-00009D-EG; Sun, 02 Mar 2025 00:12:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1tobcT-00008p-3Q
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 00:12:05 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1tobcQ-0001aC-V1
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 00:12:04 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2fee05829edso1378580a91.3
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 21:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1740892321; x=1741497121;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bg41XWjGBI0wWMomF6XX3kV2TMeWbrG+QGNtBoNCATI=;
 b=csfZ01pY4vTQ6qYazq5xVaWzRI6c7bdhI7PrRgi3BTsNgsl7TlRVe1C9S0v+0j5ENO
 2cuYU+NuPKMYRfqPxLUkegFpWCMN9w2BHo5j/pgN1fZNk6RsIqdD+cG1jpUXAjLM7Tmd
 8JNSNc513RrQDpEt+QfXzpevf6/ogiBfoHIK+8pcAK/vnHGdvGs/7l/Uaerdf+03DRdW
 6q9zNfglSHgoutsWen8BwNam2bnWf3F2IVI6VThTAR63dLRA5ypm10TQTuhsCnWU3683
 e5bO5lRnltDRoGCPRwoW9xSizg0S0op+KvmmlsEvTCJdYVhAwESsk7graPcyjcXfm9ym
 YfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740892321; x=1741497121;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bg41XWjGBI0wWMomF6XX3kV2TMeWbrG+QGNtBoNCATI=;
 b=XGWW1t2pxZ5skf1CNfeewQcrtppAyALc8+HSTi0TA34R+gDc0/tTAxsBf6fhrOUCNR
 DLfRdaSBp4ar7zSp4lRtO6e4z0cAbtaL0DfCPf2iMKlUH7PmFCVHDKEokiwwduNKwO1+
 JH7Yna2iqullocOAfaaKtuHDKMXqFAxQ/XOpw5UggTXCxJ8/vsioo67fKZQC8w+vZKH4
 3uOPcDq499QYZrfSDNrk/bpRcaWyKBluYC0KRFLteRnPYzJfxemhkzQXARt9wOXY8l3e
 0tX6uAqxy1S7v+VVdOrJfHOfKhNwwRKS5iVCK0JyXFu/GeJ3Ij0P3zd4Df4fgz76gRG9
 DBOA==
X-Gm-Message-State: AOJu0YwkZHCvSYo3n80v1XIA0E/iuu7dvq86f62zPK/x/ULVbfis3ZuX
 RIb6qVGuM7QmlKEdjmsJurlXgTqtSTd1oOE3J5YSzlkBXR95RI+Eut8oduqPgS8WmfXccD5QzMl
 SlEHPPyQtLyh2txcKWrOw2z74Gay4QsA4anCXkQ==
X-Gm-Gg: ASbGncvEUxwZ+KaQvKlxL3qA0yC4FYDJjvyVJPiaKTki02H1MgvAkaHnof4Oti0jYx2
 MCUFDmrpN+DrCcUZKjCIOUKElX/LfY7GWt/6jrbIAfyqW9ac5IeCGDd1BjEmRJWr1zFA4Wr9bAu
 Yjm4yXAfkoeFXmLd6GicWL+E2vtfWwhg9QImP1Ub8TNEXXasS8x8NNIsu5
X-Google-Smtp-Source: AGHT+IFpbwP3aFV+Q7uDOZBhsCoAbFcGQil7mj34O/ugll6HA3+7cuw9AeaFV9xsJUdGixEEkTOgFuAc3iXr05xcgGk=
X-Received: by 2002:a17:90b:4c4e:b0:2ee:6d04:9dac with SMTP id
 98e67ed59e1d1-2febabf3d5bmr12137978a91.32.1740892319513; Sat, 01 Mar 2025
 21:11:59 -0800 (PST)
MIME-Version: 1.0
References: <20250207162048.1890669-1-imammedo@redhat.com>
 <20250207162048.1890669-2-imammedo@redhat.com>
In-Reply-To: <20250207162048.1890669-2-imammedo@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 1 Mar 2025 22:11:48 -0700
X-Gm-Features: AQ5f1Jo2gjZPJz6MjKCd2KNVrQNbnV3hr_L1-_W_cnfFzFk2h-wKRQgiXeBA0bM
Message-ID: <CANCZdfoa4RcxCmVUh=Mx+8cUpAV1MyDsayoZPcrpWJeZXNWuJA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] bsd-user: drop not longer used target_reset_cpu()
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000004c1b18062f5514c9"
Received-SPF: none client-ip=2607:f8b0:4864:20::1035;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000004c1b18062f5514c9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 9:21=E2=80=AFAM Igor Mammedov <imammedo@redhat.com> =
wrote:

> target_reset_cpu() static inlines have no user,
> remove them.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: Warner Losh <imp@bsdimp.com>
> CC: Kyle Evans <kevans@freebsd.org>
> ---
>  bsd-user/aarch64/target_arch_cpu.h | 5 -----
>  bsd-user/arm/target_arch_cpu.h     | 4 ----
>  bsd-user/i386/target_arch_cpu.h    | 5 -----
>  bsd-user/riscv/target_arch_cpu.h   | 4 ----
>  bsd-user/x86_64/target_arch_cpu.h  | 5 -----
>  5 files changed, 23 deletions(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

Warner


> diff --git a/bsd-user/aarch64/target_arch_cpu.h
> b/bsd-user/aarch64/target_arch_cpu.h
> index 87fbf6d677..46a448e93f 100644
> --- a/bsd-user/aarch64/target_arch_cpu.h
> +++ b/bsd-user/aarch64/target_arch_cpu.h
> @@ -181,9 +181,4 @@ static inline void target_cpu_clone_regs(CPUARMState
> *env, target_ulong newsp)
>      pstate_write(env, 0);
>  }
>
> -static inline void target_cpu_reset(CPUArchState *env)
> -{
> -}
> -
> -
>  #endif /* TARGET_ARCH_CPU_H */
> diff --git a/bsd-user/arm/target_arch_cpu.h
> b/bsd-user/arm/target_arch_cpu.h
> index bc2eaa0bf4..b9583b0f92 100644
> --- a/bsd-user/arm/target_arch_cpu.h
> +++ b/bsd-user/arm/target_arch_cpu.h
> @@ -206,8 +206,4 @@ static inline void target_cpu_clone_regs(CPUARMState
> *env, target_ulong newsp)
>      env->regs[0] =3D 0;
>  }
>
> -static inline void target_cpu_reset(CPUArchState *env)
> -{
> -}
> -
>  #endif /* TARGET_ARCH_CPU_H */
> diff --git a/bsd-user/i386/target_arch_cpu.h
> b/bsd-user/i386/target_arch_cpu.h
> index 5d4c931dec..371e702799 100644
> --- a/bsd-user/i386/target_arch_cpu.h
> +++ b/bsd-user/i386/target_arch_cpu.h
> @@ -194,9 +194,4 @@ static inline void target_cpu_clone_regs(CPUX86State
> *env, target_ulong newsp)
>      env->regs[R_EAX] =3D 0;
>  }
>
> -static inline void target_cpu_reset(CPUArchState *env)
> -{
> -    cpu_reset(env_cpu(env));
> -}
> -
>  #endif /* TARGET_ARCH_CPU_H */
> diff --git a/bsd-user/riscv/target_arch_cpu.h
> b/bsd-user/riscv/target_arch_cpu.h
> index ef92f00480..d3cc5adbf4 100644
> --- a/bsd-user/riscv/target_arch_cpu.h
> +++ b/bsd-user/riscv/target_arch_cpu.h
> @@ -141,8 +141,4 @@ static inline void target_cpu_clone_regs(CPURISCVStat=
e
> *env, target_ulong newsp)
>      env->gpr[xT0] =3D 0;
>  }
>
> -static inline void target_cpu_reset(CPUArchState *env)
> -{
> -}
> -
>  #endif /* TARGET_ARCH_CPU_H */
> diff --git a/bsd-user/x86_64/target_arch_cpu.h
> b/bsd-user/x86_64/target_arch_cpu.h
> index f82042e30a..8ec5c65fab 100644
> --- a/bsd-user/x86_64/target_arch_cpu.h
> +++ b/bsd-user/x86_64/target_arch_cpu.h
> @@ -169,9 +169,4 @@ static inline void target_cpu_clone_regs(CPUX86State
> *env, target_ulong newsp)
>      env->regs[R_EAX] =3D 0;
>  }
>
> -static inline void target_cpu_reset(CPUArchState *env)
> -{
> -    cpu_reset(env_cpu(env));
> -}
> -
>  #endif /* TARGET_ARCH_CPU_H */
> --
> 2.43.0
>
>

--0000000000004c1b18062f5514c9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 7, =
2025 at 9:21=E2=80=AFAM Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat=
.com">imammedo@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">target_reset_cpu() static inlines have no user,<br=
>
remove them.<br>
<br>
Signed-off-by: Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com" tar=
get=3D"_blank">imammedo@redhat.com</a>&gt;<br>
---<br>
CC: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"_blank">imp=
@bsdimp.com</a>&gt;<br>
CC: Kyle Evans &lt;<a href=3D"mailto:kevans@freebsd.org" target=3D"_blank">=
kevans@freebsd.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/aarch64/target_arch_cpu.h | 5 -----<br>
=C2=A0bsd-user/arm/target_arch_cpu.h=C2=A0 =C2=A0 =C2=A0| 4 ----<br>
=C2=A0bsd-user/i386/target_arch_cpu.h=C2=A0 =C2=A0 | 5 -----<br>
=C2=A0bsd-user/riscv/target_arch_cpu.h=C2=A0 =C2=A0| 4 ----<br>
=C2=A0bsd-user/x86_64/target_arch_cpu.h=C2=A0 | 5 -----<br>
=C2=A05 files changed, 23 deletions(-)<br></blockquote><div><br></div><div>=
Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.c=
om</a>&gt;</div><div><br></div><div>Warner</div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
diff --git a/bsd-user/aarch64/target_arch_cpu.h b/bsd-user/aarch64/target_a=
rch_cpu.h<br>
index 87fbf6d677..46a448e93f 100644<br>
--- a/bsd-user/aarch64/target_arch_cpu.h<br>
+++ b/bsd-user/aarch64/target_arch_cpu.h<br>
@@ -181,9 +181,4 @@ static inline void target_cpu_clone_regs(CPUARMState *e=
nv, target_ulong newsp)<br>
=C2=A0 =C2=A0 =C2=A0pstate_write(env, 0);<br>
=C2=A0}<br>
<br>
-static inline void target_cpu_reset(CPUArchState *env)<br>
-{<br>
-}<br>
-<br>
-<br>
=C2=A0#endif /* TARGET_ARCH_CPU_H */<br>
diff --git a/bsd-user/arm/target_arch_cpu.h b/bsd-user/arm/target_arch_cpu.=
h<br>
index bc2eaa0bf4..b9583b0f92 100644<br>
--- a/bsd-user/arm/target_arch_cpu.h<br>
+++ b/bsd-user/arm/target_arch_cpu.h<br>
@@ -206,8 +206,4 @@ static inline void target_cpu_clone_regs(CPUARMState *e=
nv, target_ulong newsp)<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;regs[0] =3D 0;<br>
=C2=A0}<br>
<br>
-static inline void target_cpu_reset(CPUArchState *env)<br>
-{<br>
-}<br>
-<br>
=C2=A0#endif /* TARGET_ARCH_CPU_H */<br>
diff --git a/bsd-user/i386/target_arch_cpu.h b/bsd-user/i386/target_arch_cp=
u.h<br>
index 5d4c931dec..371e702799 100644<br>
--- a/bsd-user/i386/target_arch_cpu.h<br>
+++ b/bsd-user/i386/target_arch_cpu.h<br>
@@ -194,9 +194,4 @@ static inline void target_cpu_clone_regs(CPUX86State *e=
nv, target_ulong newsp)<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;regs[R_EAX] =3D 0;<br>
=C2=A0}<br>
<br>
-static inline void target_cpu_reset(CPUArchState *env)<br>
-{<br>
-=C2=A0 =C2=A0 cpu_reset(env_cpu(env));<br>
-}<br>
-<br>
=C2=A0#endif /* TARGET_ARCH_CPU_H */<br>
diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_=
cpu.h<br>
index ef92f00480..d3cc5adbf4 100644<br>
--- a/bsd-user/riscv/target_arch_cpu.h<br>
+++ b/bsd-user/riscv/target_arch_cpu.h<br>
@@ -141,8 +141,4 @@ static inline void target_cpu_clone_regs(CPURISCVState =
*env, target_ulong newsp)<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;gpr[xT0] =3D 0;<br>
=C2=A0}<br>
<br>
-static inline void target_cpu_reset(CPUArchState *env)<br>
-{<br>
-}<br>
-<br>
=C2=A0#endif /* TARGET_ARCH_CPU_H */<br>
diff --git a/bsd-user/x86_64/target_arch_cpu.h b/bsd-user/x86_64/target_arc=
h_cpu.h<br>
index f82042e30a..8ec5c65fab 100644<br>
--- a/bsd-user/x86_64/target_arch_cpu.h<br>
+++ b/bsd-user/x86_64/target_arch_cpu.h<br>
@@ -169,9 +169,4 @@ static inline void target_cpu_clone_regs(CPUX86State *e=
nv, target_ulong newsp)<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;regs[R_EAX] =3D 0;<br>
=C2=A0}<br>
<br>
-static inline void target_cpu_reset(CPUArchState *env)<br>
-{<br>
-=C2=A0 =C2=A0 cpu_reset(env_cpu(env));<br>
-}<br>
-<br>
=C2=A0#endif /* TARGET_ARCH_CPU_H */<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--0000000000004c1b18062f5514c9--

