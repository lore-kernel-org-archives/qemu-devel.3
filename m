Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23944D2C139
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 15:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Lf3-0005qf-UH; Tue, 05 Nov 2024 10:40:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1t8Ley-0005mT-UX
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:40:01 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1t8Leu-0005C6-VE
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:39:59 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e5a0177531so4294152a91.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 07:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1730821195; x=1731425995;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LczKHoa9mpjalqfPke8igIps+7h+8PqShfDcNsj7l30=;
 b=p8qdiC6KzTE8JFYt1cbW84Q56OIGjGSAGHprR1M+iOOLHUvQRSGyGXYlkg3tRnjNT3
 0Vp/GKFMfs62aKQf8BFNkVFWpmXqlpN3J7uYtAdlnaqkMfOIry1AU2IzIlslIPtjlts9
 80XoxxF8292CfThy/5yF0iuRh/GuAW7gBy3GdsRldXtC4Ccu+vuxKxyTyST5+eQwMeDq
 8SO627j9a2/DDn8okXIEnEohYjkekX77eTQshpu0uDem1edh55mD6fu8VMlkJu4l1oWG
 gt27hed8x9fA5dq3EWjz7wFPiMi2HOHQz8ghDnYHNURsiwNsn7T2nbzKcpsUBk9CI6UL
 9Oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730821195; x=1731425995;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LczKHoa9mpjalqfPke8igIps+7h+8PqShfDcNsj7l30=;
 b=e6b4ZyS1pQeJ4zeIqvX7XNcD18ZJy83tQX1SsH/DTcZUYO7Fey+H5lIHaZkf/3TsUB
 5JjhkpM2s5OtlUsCT/Qll4ypwJeFQUtKVquAZCO8EXXsix9+6yNBGJW9Rx2IUoH+N5bD
 Tr7GFABHpkM0Q/FKmPBqKCJWPs+GyCn6tNbGh7YA79QNuepbJ+CEqSpNc/4aw70nGgO0
 Ixe4B5aklwH0Ly5gVFzOT5n/pZpu/KEY25WAO5HosZVmSJjFROkxVota94C43pZKzLTD
 PJm0HFjRxhxnukVWtrqlMXku8gPuJuqniN87GYunTulYaOTQOvLh6iy/zC2spXAJM8Q3
 4gtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdj+NY127qrhp8qZag7bP1qHIJHVaIY+fTEfAaVkyx2G8KaoiemDD9cT4ZJ9yeF4Vo7U0N90mQ+SMl@nongnu.org
X-Gm-Message-State: AOJu0Yw1txhrd1evKQ+pgfCOoQ90kqc93ZCTNgbTEd1Iqbrl0p7Yd005
 tt+uWKkHxTfi2MDPFH+x5z6PLBRB6NPfPp9LhqE+rEPq87aQWbmabTfJzyMVD1+IDrjhe7AVO9R
 PX+Ccci9k87mLn2vJRxN8QWwgxxBfSmZQoH3rCg==
X-Google-Smtp-Source: AGHT+IFhqD2XtJ/Jz9QQjMPAHfpdLxfS84PSWFM9h5H2vbA2Q+lrQyj7Gq+dnIOnmi0yKbumSjyjjtRVMHKSkRBD+es=
X-Received: by 2002:a17:90b:3b89:b0:2e2:d197:40f3 with SMTP id
 98e67ed59e1d1-2e8f11de644mr36694541a91.35.1730821194704; Tue, 05 Nov 2024
 07:39:54 -0800 (PST)
MIME-Version: 1.0
References: <20241024200031.80327-1-iii@linux.ibm.com>
 <20241024200031.80327-5-iii@linux.ibm.com>
In-Reply-To: <20241024200031.80327-5-iii@linux.ibm.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 5 Nov 2024 08:39:43 -0700
Message-ID: <CANCZdfrhzc-HZabUjkAMTgcHR0+6OQPxNshkQfMYD4wbNcm=wQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] user: Introduce host_interrupt_signal
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000007b1fb206262c3683"
Received-SPF: none client-ip=2607:f8b0:4864:20::1030;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1030.google.com
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

--0000000000007b1fb206262c3683
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 2:00=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:

> Attaching to the gdbstub of a running process requires stopping its
> threads. For threads that run on a CPU, cpu_exit() is enough, but the
> only way to grab attention of a thread that is stuck in a long-running
> syscall is to interrupt it with a signal.
>
> Reserve a host realtime signal for this, just like it's already done
> for TARGET_SIGABRT on Linux. This may reduce the number of available
> guest realtime signals by one, but this is acceptable, since there are
> quite a lot of them, and it's unlikely that there are apps that need
> them all.
>
> Set signal_pending for the safe_sycall machinery to prevent invoking
> the syscall. This is a lie, since we don't queue a guest signal, but
> process_pending_signals() can handle the absence of pending signals.
> The syscall returns with QEMU_ERESTARTSYS errno, which arranges for
> the automatic restart. This is important, because it helps avoiding
> disturbing poorly written guests.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  bsd-user/signal.c     | 12 ++++++++++++
>  include/user/signal.h |  2 ++
>  linux-user/signal.c   | 11 +++++++++++
>  3 files changed, 25 insertions(+)
>
> diff --git a/bsd-user/signal.c b/bsd-user/signal.c
> index a2b11a97131..992736df5c5 100644
> --- a/bsd-user/signal.c
> +++ b/bsd-user/signal.c
> @@ -49,6 +49,8 @@ static inline int sas_ss_flags(TaskState *ts, unsigned
> long sp)
>          on_sig_stack(ts, sp) ? SS_ONSTACK : 0;
>  }
>
> +int host_interrupt_signal =3D SIGRTMAX;
> +
>

I'd be tempted to use SIGRTMAX + 1 or even TARGET_NSIG. 127 or 128 would
work and not overflow any arrays (or hit any bounds tests) I'd likely use
SIGRTMAX + 1,
though, since it avoids any edge-cases from sig =3D=3D NSIG that might be i=
n
the code
unnoticed.

Now, having said that, I don't think that there's too many (any?) programs
we need
to run as bsd-user that have real-time signals, much less one that uses
SIGRTMAX,
but stranger things have happened. But it is a little wiggle room just in
case.

Other than that:

Reviewed-by: Warner Losh <imp@bsdimp.com>



>  /*
>   * The BSD ABIs use the same signal numbers across all the CPU
> architectures, so
>   * (unlike Linux) these functions are just the identity mapping. This
> might not
> @@ -489,6 +491,12 @@ static void host_signal_handler(int host_sig,
> siginfo_t *info, void *puc)
>      uintptr_t pc =3D 0;
>      bool sync_sig =3D false;
>
> +    if (host_sig =3D=3D host_interrupt_signal) {
> +        ts->signal_pending =3D 1;
> +        cpu_exit(thread_cpu);
> +        return;
> +    }
> +
>      /*
>       * Non-spoofed SIGSEGV and SIGBUS are synchronous, and need special
>       * handling wrt signal blocking and unwinding.
> @@ -852,6 +860,9 @@ void signal_init(void)
>
>      for (i =3D 1; i <=3D TARGET_NSIG; i++) {
>          host_sig =3D target_to_host_signal(i);
> +        if (host_sig =3D=3D host_interrupt_signal) {
> +            continue;
> +        }
>          sigaction(host_sig, NULL, &oact);
>          if (oact.sa_sigaction =3D=3D (void *)SIG_IGN) {
>              sigact_table[i - 1]._sa_handler =3D TARGET_SIG_IGN;
> @@ -870,6 +881,7 @@ void signal_init(void)
>              sigaction(host_sig, &act, NULL);
>          }
>      }
> +    sigaction(host_interrupt_signal, &act, NULL);
>  }
>
>  static void handle_pending_signal(CPUArchState *env, int sig,
> diff --git a/include/user/signal.h b/include/user/signal.h
> index 19b6b9e5ddc..7fa33b05d91 100644
> --- a/include/user/signal.h
> +++ b/include/user/signal.h
> @@ -20,4 +20,6 @@
>   */
>  int target_to_host_signal(int sig);
>
> +extern int host_interrupt_signal;
> +
>  #endif
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 84bb8a34808..f0bcbd367d5 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -514,6 +514,8 @@ static int core_dump_signal(int sig)
>      }
>  }
>
> +int host_interrupt_signal;
> +
>  static void signal_table_init(void)
>  {
>      int hsig, tsig, count;
> @@ -540,6 +542,7 @@ static void signal_table_init(void)
>      hsig =3D SIGRTMIN;
>      host_to_target_signal_table[SIGABRT] =3D 0;
>      host_to_target_signal_table[hsig++] =3D TARGET_SIGABRT;
> +    host_interrupt_signal =3D hsig++;
>
>      for (tsig =3D TARGET_SIGRTMIN;
>           hsig <=3D SIGRTMAX && tsig <=3D TARGET_NSIG;
> @@ -619,6 +622,8 @@ void signal_init(void)
>          }
>          sigact_table[tsig - 1]._sa_handler =3D thand;
>      }
> +
> +    sigaction(host_interrupt_signal, &act, NULL);
>  }
>
>  /* Force a synchronously taken signal. The kernel force_sig() function
> @@ -966,6 +971,12 @@ static void host_signal_handler(int host_sig,
> siginfo_t *info, void *puc)
>      bool sync_sig =3D false;
>      void *sigmask;
>
> +    if (host_sig =3D=3D host_interrupt_signal) {
> +        ts->signal_pending =3D 1;
> +        cpu_exit(thread_cpu);
> +        return;
> +    }
> +
>      /*
>       * Non-spoofed SIGSEGV and SIGBUS are synchronous, and need special
>       * handling wrt signal blocking and unwinding.  Non-spoofed SIGILL,
> --
> 2.47.0
>
>

--0000000000007b1fb206262c3683
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 24, 2024 at 2:00=E2=80=AF=
PM Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.com">iii@linux.ibm.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">Attaching to the gdbstub of a running process requires stopping its<br>
threads. For threads that run on a CPU, cpu_exit() is enough, but the<br>
only way to grab attention of a thread that is stuck in a long-running<br>
syscall is to interrupt it with a signal.<br>
<br>
Reserve a host realtime signal for this, just like it&#39;s already done<br=
>
for TARGET_SIGABRT on Linux. This may reduce the number of available<br>
guest realtime signals by one, but this is acceptable, since there are<br>
quite a lot of them, and it&#39;s unlikely that there are apps that need<br=
>
them all.<br>
<br>
Set signal_pending for the safe_sycall machinery to prevent invoking<br>
the syscall. This is a lie, since we don&#39;t queue a guest signal, but<br=
>
process_pending_signals() can handle the absence of pending signals.<br>
The syscall returns with QEMU_ERESTARTSYS errno, which arranges for<br>
the automatic restart. This is important, because it helps avoiding<br>
disturbing poorly written guests.<br>
<br>
Signed-off-by: Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.com" ta=
rget=3D"_blank">iii@linux.ibm.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/signal.c=C2=A0 =C2=A0 =C2=A0| 12 ++++++++++++<br>
=C2=A0include/user/signal.h |=C2=A0 2 ++<br>
=C2=A0linux-user/signal.c=C2=A0 =C2=A0| 11 +++++++++++<br>
=C2=A03 files changed, 25 insertions(+)<br>
<br>
diff --git a/bsd-user/signal.c b/bsd-user/signal.c<br>
index a2b11a97131..992736df5c5 100644<br>
--- a/bsd-user/signal.c<br>
+++ b/bsd-user/signal.c<br>
@@ -49,6 +49,8 @@ static inline int sas_ss_flags(TaskState *ts, unsigned lo=
ng sp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0on_sig_stack(ts, sp) ? SS_ONSTACK : 0;<br=
>
=C2=A0}<br>
<br>
+int host_interrupt_signal =3D SIGRTMAX;<br>
+<br></blockquote><div><br></div><div>I&#39;d be tempted to use SIGRTMAX=C2=
=A0+ 1 or even TARGET_NSIG. 127 or 128 would</div><div>work and not overflo=
w any arrays (or hit any bounds tests) I&#39;d likely use SIGRTMAX=C2=A0+ 1=
,</div><div>though, since it avoids any edge-cases from sig =3D=3D NSIG tha=
t might be in the code</div><div>unnoticed.</div><div><br></div><div>Now, h=
aving said that, I don&#39;t think that there&#39;s too many (any?) program=
s we need</div><div>to run as bsd-user that have real-time signals, much le=
ss one that uses SIGRTMAX,</div><div>but stranger things have happened. But=
 it is a little wiggle room just in case.</div><div><br></div><div>Other th=
an that:</div><div><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"m=
ailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt;</div><div><br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0/*<br>
=C2=A0 * The BSD ABIs use the same signal numbers across all the CPU archit=
ectures, so<br>
=C2=A0 * (unlike Linux) these functions are just the identity mapping. This=
 might not<br>
@@ -489,6 +491,12 @@ static void host_signal_handler(int host_sig, siginfo_=
t *info, void *puc)<br>
=C2=A0 =C2=A0 =C2=A0uintptr_t pc =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0bool sync_sig =3D false;<br>
<br>
+=C2=A0 =C2=A0 if (host_sig =3D=3D host_interrupt_signal) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ts-&gt;signal_pending =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_exit(thread_cpu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * Non-spoofed SIGSEGV and SIGBUS are synchronous, and =
need special<br>
=C2=A0 =C2=A0 =C2=A0 * handling wrt signal blocking and unwinding.<br>
@@ -852,6 +860,9 @@ void signal_init(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 1; i &lt;=3D TARGET_NSIG; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host_sig =3D target_to_host_signal(i);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host_sig =3D=3D host_interrupt_signal) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sigaction(host_sig, NULL, &amp;oact);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (oact.sa_sigaction =3D=3D (void *)SIG_=
IGN) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sigact_table[i - 1]._sa_han=
dler =3D TARGET_SIG_IGN;<br>
@@ -870,6 +881,7 @@ void signal_init(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sigaction(host_sig, &amp;ac=
t, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 sigaction(host_interrupt_signal, &amp;act, NULL);<br>
=C2=A0}<br>
<br>
=C2=A0static void handle_pending_signal(CPUArchState *env, int sig,<br>
diff --git a/include/user/signal.h b/include/user/signal.h<br>
index 19b6b9e5ddc..7fa33b05d91 100644<br>
--- a/include/user/signal.h<br>
+++ b/include/user/signal.h<br>
@@ -20,4 +20,6 @@<br>
=C2=A0 */<br>
=C2=A0int target_to_host_signal(int sig);<br>
<br>
+extern int host_interrupt_signal;<br>
+<br>
=C2=A0#endif<br>
diff --git a/linux-user/signal.c b/linux-user/signal.c<br>
index 84bb8a34808..f0bcbd367d5 100644<br>
--- a/linux-user/signal.c<br>
+++ b/linux-user/signal.c<br>
@@ -514,6 +514,8 @@ static int core_dump_signal(int sig)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+int host_interrupt_signal;<br>
+<br>
=C2=A0static void signal_table_init(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int hsig, tsig, count;<br>
@@ -540,6 +542,7 @@ static void signal_table_init(void)<br>
=C2=A0 =C2=A0 =C2=A0hsig =3D SIGRTMIN;<br>
=C2=A0 =C2=A0 =C2=A0host_to_target_signal_table[SIGABRT] =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0host_to_target_signal_table[hsig++] =3D TARGET_SIGABRT;=
<br>
+=C2=A0 =C2=A0 host_interrupt_signal =3D hsig++;<br>
<br>
=C2=A0 =C2=A0 =C2=A0for (tsig =3D TARGET_SIGRTMIN;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hsig &lt;=3D SIGRTMAX &amp;&amp; tsig &l=
t;=3D TARGET_NSIG;<br>
@@ -619,6 +622,8 @@ void signal_init(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sigact_table[tsig - 1]._sa_handler =3D th=
and;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 sigaction(host_interrupt_signal, &amp;act, NULL);<br>
=C2=A0}<br>
<br>
=C2=A0/* Force a synchronously taken signal. The kernel force_sig() functio=
n<br>
@@ -966,6 +971,12 @@ static void host_signal_handler(int host_sig, siginfo_=
t *info, void *puc)<br>
=C2=A0 =C2=A0 =C2=A0bool sync_sig =3D false;<br>
=C2=A0 =C2=A0 =C2=A0void *sigmask;<br>
<br>
+=C2=A0 =C2=A0 if (host_sig =3D=3D host_interrupt_signal) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ts-&gt;signal_pending =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_exit(thread_cpu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * Non-spoofed SIGSEGV and SIGBUS are synchronous, and =
need special<br>
=C2=A0 =C2=A0 =C2=A0 * handling wrt signal blocking and unwinding.=C2=A0 No=
n-spoofed SIGILL,<br>
-- <br>
2.47.0<br>
<br>
</blockquote></div></div>

--0000000000007b1fb206262c3683--

