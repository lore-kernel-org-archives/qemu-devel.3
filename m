Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FB71061B01
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Daz-0008UU-2r; Mon, 30 Mar 2026 10:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w7Dax-0008UJ-PM
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:27:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w7Dav-00024V-RB
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774880876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TxmVapdaxKqdmjIXL9PiDcwQ3CyXwN/8S5d9T4z1KJ8=;
 b=ShI1h8f0i61FQkVKNNr7AClrW4QP873h93obk6BZLaoY0Cr5NzfkGsxSVQiOIzYXoJyWMs
 3L+MeoifZIjNWGoU1FxtkN+scIsrsrjcFftjECA4+vr/Dis/MVZvR3xjoDR9DTSAiM7Bf4
 IGhLh6lG3Vih5ZCNfjJB2nApUNGnGvo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-6nQUa29zP7WSxv2DpNfS7w-1; Mon, 30 Mar 2026 10:27:55 -0400
X-MC-Unique: 6nQUa29zP7WSxv2DpNfS7w-1
X-Mimecast-MFC-AGG-ID: 6nQUa29zP7WSxv2DpNfS7w_1774880874
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cfc648b036so1648518185a.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 07:27:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774880874; cv=none;
 d=google.com; s=arc-20240605;
 b=DFVDyqteXOdbWq0jKC1sBYU6gWLTFFr5zl08rsT9yLmVjEwzCZRShKrI+PPLT8lVDK
 iLuHaSMLQ+kNDg8+FfAv5+eCoQY2CusN8P0648gnqTvZCRDr4OzN2eD+Fm/xWj77HI31
 f5Eg6GumNUjxYUCLtBlKYNevTL0iFNse0h9iWa2iU8qWR7gSplYPqW/rHB7XaXAgdvEc
 oe8+LNl6SAw649gkqr0b/9HuV1Qj5255tPJv7VozhnEZTYNyuP8T2MMbonAZA9oZEVGR
 +8fVDvt/BG4Wf5Xeg1v0pyHJGBF0hho1uZU8R3NKPbcXJI0oIb3ipNLNxN2URroaG9RS
 BbmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TxmVapdaxKqdmjIXL9PiDcwQ3CyXwN/8S5d9T4z1KJ8=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=T1qZVQSykq57tNdhBH0ca0pLetNnD7xu+cTJR3CpEyZHRGMkyCm3OKqz7Ny1pAcaro
 2fA/9IaSyM2aBqyH25YIK2oZ4MtpqauCX8AMh9vcmGo8rTz5lkOuW2gCyxbtnlnJDGYH
 SY96SrwIQMMrNFuebbQoDfzGR/CEXV4ahI7xjlrbd5Y8cJVfxXKL+eC3KiyOakkvwmk1
 tIHwHQaofo4gXMj99XzWy90lLCyQr92Pk3lAwGRoBd1qtXoJ6+hw25oA7u3BZWajS0QG
 6gjeimmZYBvSWH3h6K361PyvlInkAwtpYf7xZmxDs+oWNm+ddd6VGGnm32tUPfkSwkCX
 Gdmw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774880874; x=1775485674; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TxmVapdaxKqdmjIXL9PiDcwQ3CyXwN/8S5d9T4z1KJ8=;
 b=q6H7HwtwKuFU+1j/1uXnMkPvr+IxiIMxgU1ViP4AigeqEok1gIGwKxiiTGU4QM67Pe
 vJ9v9R3wgLIBQBpU2w+wuhDIqdars8gycnWLu+ipzxvN51CPT77fT1xFQefcjT8Uk7yx
 hhDGu/L4FhtI1QecCVZvkzrhRA2hB+C5wO43rs/6MIwveXnXFqGhkzTG9TQBIMdgFvJe
 5CWNo+57LQuK4gZASoDcFX2txQIM4QQBwLRKgT02HxfGWUfsGmNn453TMpEKwa1Tb+K9
 Ydmo/Ef3pvYM2U9ugeaEHubT0trLTwm9YYh9xuJb+jhy2uwGDvIAWVgkXmkwZAYrxoLa
 wulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774880874; x=1775485674;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TxmVapdaxKqdmjIXL9PiDcwQ3CyXwN/8S5d9T4z1KJ8=;
 b=DwpEPlRr07D6E3uMjv19oPapZ4urD8ml/yT4ZXOTSbEoEnDFbPqWNMNAnhg53sJTUE
 fPYm+ObPQwt+Rn2quTdi3UKn5vVrru0QUk649KNf27CZVAmix0HMd4jhcmOyaUOP/ORN
 62MhWOxASsJF/jlr949s2cJkNpbALXi78mp7v3ym4SvbqdgvFm+2TYEBf9uqKKEunKKI
 k5zVV0cnu3u3/avrXrhFQbyrxCpWXuZQI8G+KgyBLHvi+h4V68zhlqBBG+wQRC2Xyc75
 NWXiQ0ss9xy9gnqDr1sVSm1g39CA94ukD8CzYCbG6jAwm6Qy3JCkgB0F0AQ/8nmyaEMn
 1R/A==
X-Gm-Message-State: AOJu0YxPSpvRH6wn8ry/nLB1l6EqvI1lrwhmwDpuxOwU6+/hhMyfJb/g
 DPvut3ffH1tt95rG5qIv3EANb69SmsZhMsI9IlFOVjijRIjTd2bKD1KhK2RlhEgZ/x0rQD5Ixhj
 0SJF8UiSoUGxEE1fPP28rY+2qdf2/NYUtERMM6rBTvs+ZGUUQHam93SeFNz8qZpmKa9daJsNhUr
 99MhfsME52aALgNSAI0CU0OElwmvtcfQ0=
X-Gm-Gg: ATEYQzwel19jzZozzNw4I/kAkJpkpBLDW/wW0O8pyKgZ2ZEqGnGcpksPqRGNJWnoxHQ
 Ao1TdRwSPFoD2lyoOFHIyePqnAWq6koVuq2dpgjGJ2Ydr/aKF6KFo3bPmIKnyuVJ10oA+w6nTW6
 Q/KejyKQha3FSdx/Dc0i8ykrPA43M2OFlDylPhuIGWgmGtpnY5OdmykeIvoqPsSdPFc2AgoIZpp
 Zu2Ve0Z
X-Received: by 2002:a05:620a:2901:b0:8c6:b247:4c with SMTP id
 af79cd13be357-8d01c595ff3mr1781370085a.2.1774880874439; 
 Mon, 30 Mar 2026 07:27:54 -0700 (PDT)
X-Received: by 2002:a05:620a:2901:b0:8c6:b247:4c with SMTP id
 af79cd13be357-8d01c595ff3mr1781365085a.2.1774880873942; Mon, 30 Mar 2026
 07:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260330141818.286412-1-pbonzini@redhat.com>
In-Reply-To: <20260330141818.286412-1-pbonzini@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 30 Mar 2026 17:27:43 +0300
X-Gm-Features: AQROBzA0rE8QSwdMLkdvIDeZ-SYg4L8LJ1HF6Plv7fQvw_qhWUXw-kW4iA0JxwU
Message-ID: <CAPMcbCpaMD0M+UzZ=sqJe=UykQcwHdNTosH56-DBoVVqAT-ayw@mail.gmail.com>
Subject: Re: [PATCH] thread-win32: replace CRITICAL_SECTION with SRWLOCK
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000002bbc5064e3ea87e"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--00000000000002bbc5064e3ea87e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think we don't need Windows XP support, so

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Mon, Mar 30, 2026 at 5:19=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:

> SRWLOCK is a much cheaper primitive than CRITICAL_SECTION, which
> basically exists only as a legacy API.  The SRWLOCK is a single word
> in memory and it is cheaper to just initialize it always.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  util/qemu-thread-win32.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
> index 272afc33856..3037732a6fe 100644
> --- a/util/qemu-thread-win32.c
> +++ b/util/qemu-thread-win32.c
> @@ -242,7 +242,7 @@ struct QemuThreadData {
>      /* Only used for joinable threads. */
>      bool              exited;
>      void             *ret;
> -    CRITICAL_SECTION  cs;
> +    SRWLOCK           lock;
>  };
>
>  static bool atexit_registered;
> @@ -295,9 +295,9 @@ void qemu_thread_exit(void *arg)
>      notifier_list_notify(&data->exit, NULL);
>      if (data->mode =3D=3D QEMU_THREAD_JOINABLE) {
>          data->ret =3D arg;
> -        EnterCriticalSection(&data->cs);
> +        AcquireSRWLockExclusive(&data->lock);
>          data->exited =3D true;
> -        LeaveCriticalSection(&data->cs);
> +        ReleaseSRWLockExclusive(&data->lock);
>      } else {
>          g_free(data);
>      }
> @@ -328,7 +328,6 @@ void *qemu_thread_join(QemuThread *thread)
>          CloseHandle(handle);
>      }
>      ret =3D data->ret;
> -    DeleteCriticalSection(&data->cs);
>      g_free(data);
>      return ret;
>  }
> @@ -357,6 +356,7 @@ void qemu_thread_create(QemuThread *thread, const cha=
r
> *name,
>      struct QemuThreadData *data;
>
>      data =3D g_malloc(sizeof *data);
> +    InitializeSRWLock(&data->lock);
>      data->start_routine =3D start_routine;
>      data->arg =3D arg;
>      data->mode =3D mode;
> @@ -364,10 +364,6 @@ void qemu_thread_create(QemuThread *thread, const
> char *name,
>      data->name =3D g_strdup(name);
>      notifier_list_init(&data->exit);
>
> -    if (data->mode !=3D QEMU_THREAD_DETACHED) {
> -        InitializeCriticalSection(&data->cs);
> -    }
> -
>      hThread =3D (HANDLE) _beginthreadex(NULL, 0, win32_start_routine,
>                                        data, 0, &thread->tid);
>      if (!hThread) {
> @@ -406,14 +402,14 @@ HANDLE qemu_thread_get_handle(QemuThread *thread)
>          return NULL;
>      }
>
> -    EnterCriticalSection(&data->cs);
> +    AcquireSRWLockExclusive(&data->lock);
>      if (!data->exited) {
>          handle =3D OpenThread(SYNCHRONIZE | THREAD_SUSPEND_RESUME |
>                              THREAD_SET_CONTEXT, FALSE, thread->tid);
>      } else {
>          handle =3D NULL;
>      }
> -    LeaveCriticalSection(&data->cs);
> +    ReleaseSRWLockExclusive(&data->lock);
>      return handle;
>  }
>
> --
> 2.53.0
>
>

--00000000000002bbc5064e3ea87e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I think we don&#39;t need Windows XP support, so<br><=
br></div><div>Reviewed-by:=C2=A0Kostiantyn Kostiuk &lt;<a href=3D"mailto:kk=
ostiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div></div><br><div class=3D=
"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Mon, Mar 30, 2026 at 5:19=E2=80=AFPM Paolo Bonzini &lt;<a href=3D"mailto:=
pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">SRWLOCK is a much cheaper primitive=
 than CRITICAL_SECTION, which<br>
basically exists only as a legacy API.=C2=A0 The SRWLOCK is a single word<b=
r>
in memory and it is cheaper to just initialize it always.<br>
<br>
Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" tar=
get=3D"_blank">pbonzini@redhat.com</a>&gt;<br>
---<br>
=C2=A0util/qemu-thread-win32.c | 16 ++++++----------<br>
=C2=A01 file changed, 6 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c<br>
index 272afc33856..3037732a6fe 100644<br>
--- a/util/qemu-thread-win32.c<br>
+++ b/util/qemu-thread-win32.c<br>
@@ -242,7 +242,7 @@ struct QemuThreadData {<br>
=C2=A0 =C2=A0 =C2=A0/* Only used for joinable threads. */<br>
=C2=A0 =C2=A0 =C2=A0bool=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ex=
ited;<br>
=C2=A0 =C2=A0 =C2=A0void=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*re=
t;<br>
-=C2=A0 =C2=A0 CRITICAL_SECTION=C2=A0 cs;<br>
+=C2=A0 =C2=A0 SRWLOCK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lock;<br>
=C2=A0};<br>
<br>
=C2=A0static bool atexit_registered;<br>
@@ -295,9 +295,9 @@ void qemu_thread_exit(void *arg)<br>
=C2=A0 =C2=A0 =C2=A0notifier_list_notify(&amp;data-&gt;exit, NULL);<br>
=C2=A0 =C2=A0 =C2=A0if (data-&gt;mode =3D=3D QEMU_THREAD_JOINABLE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;ret =3D arg;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 EnterCriticalSection(&amp;data-&gt;cs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 AcquireSRWLockExclusive(&amp;data-&gt;lock);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;exited =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 LeaveCriticalSection(&amp;data-&gt;cs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ReleaseSRWLockExclusive(&amp;data-&gt;lock);<b=
r>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(data);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -328,7 +328,6 @@ void *qemu_thread_join(QemuThread *thread)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CloseHandle(handle);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0ret =3D data-&gt;ret;<br>
-=C2=A0 =C2=A0 DeleteCriticalSection(&amp;data-&gt;cs);<br>
=C2=A0 =C2=A0 =C2=A0g_free(data);<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
@@ -357,6 +356,7 @@ void qemu_thread_create(QemuThread *thread, const char =
*name,<br>
=C2=A0 =C2=A0 =C2=A0struct QemuThreadData *data;<br>
<br>
=C2=A0 =C2=A0 =C2=A0data =3D g_malloc(sizeof *data);<br>
+=C2=A0 =C2=A0 InitializeSRWLock(&amp;data-&gt;lock);<br>
=C2=A0 =C2=A0 =C2=A0data-&gt;start_routine =3D start_routine;<br>
=C2=A0 =C2=A0 =C2=A0data-&gt;arg =3D arg;<br>
=C2=A0 =C2=A0 =C2=A0data-&gt;mode =3D mode;<br>
@@ -364,10 +364,6 @@ void qemu_thread_create(QemuThread *thread, const char=
 *name,<br>
=C2=A0 =C2=A0 =C2=A0data-&gt;name =3D g_strdup(name);<br>
=C2=A0 =C2=A0 =C2=A0notifier_list_init(&amp;data-&gt;exit);<br>
<br>
-=C2=A0 =C2=A0 if (data-&gt;mode !=3D QEMU_THREAD_DETACHED) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 InitializeCriticalSection(&amp;data-&gt;cs);<b=
r>
-=C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0 =C2=A0hThread =3D (HANDLE) _beginthreadex(NULL, 0, win32_star=
t_routine,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data, 0, =
&amp;thread-&gt;tid);<br>
=C2=A0 =C2=A0 =C2=A0if (!hThread) {<br>
@@ -406,14 +402,14 @@ HANDLE qemu_thread_get_handle(QemuThread *thread)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 EnterCriticalSection(&amp;data-&gt;cs);<br>
+=C2=A0 =C2=A0 AcquireSRWLockExclusive(&amp;data-&gt;lock);<br>
=C2=A0 =C2=A0 =C2=A0if (!data-&gt;exited) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0handle =3D OpenThread(SYNCHRONIZE | THREA=
D_SUSPEND_RESUME |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0THREAD_SET_CONTEXT, FALSE, thread-&gt;tid);<=
br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0handle =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 LeaveCriticalSection(&amp;data-&gt;cs);<br>
+=C2=A0 =C2=A0 ReleaseSRWLockExclusive(&amp;data-&gt;lock);<br>
=C2=A0 =C2=A0 =C2=A0return handle;<br>
=C2=A0}<br>
<br>
-- <br>
2.53.0<br>
<br>
</blockquote></div>

--00000000000002bbc5064e3ea87e--


