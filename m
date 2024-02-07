Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE232C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 19:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXo3b-0007yn-IL; Wed, 07 Feb 2024 14:58:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1rXo3a-0007y5-6U
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 14:58:06 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1rXo3Y-0002he-3k
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 14:58:05 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2cf4fafa386so13620001fa.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 11:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1707335881; x=1707940681;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e2r8ewQ3GKlhxv+VAGTlsx90mzqAeYJV/OC68iAZzz4=;
 b=s6S3YJLh8k4uFPDmldHjfLlM+ObEIwvjRaMipPypVnCa2k/2oDt1E3ID0yoh8Sqr6w
 gP5/EBBJRB1Rl+xwo7R1kF7dLaZtzJhEdXx5iAJwIm7pCl3BTEzYhmHDCxtECzo6L4nY
 PXTERke6q3sOzoGTuKKDPXbLk7rr0RvsqYT1b4IFuAJHBjLcQ1agLNqR6W5Ac0JCR5ms
 tTYN3I+B/WqZqv2K0XFN5jPT8lHPpHRh36Thqj58DbessAp8NVTcqyradzrVaB1WRt+B
 W6UXa+dpben2mx13ipshZ/um0xBV6s8C27QuArMkOmSu4uGWrNWP7zuvoBIJWwjEuR0x
 RWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707335881; x=1707940681;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e2r8ewQ3GKlhxv+VAGTlsx90mzqAeYJV/OC68iAZzz4=;
 b=EaUvrqgSqs96cmLE2KFoGN/kCN8/XJvIH5d7QAT37UM6n4fLxMuzSxIOQxevnDP5L5
 P8aToevbyZEH8IGIUtkiqF7InEI8D/fkpzHOrArLI/vHKt+kaf0jX5oxxtHoQGdjUI+J
 Km6kQWbhJEfTuBeCtDjXUnypT8LGAs9CDeB7SnC/yofiaIsq2CXKeSvDSOfsJf3VIpHz
 7lLXE1vLHzKbB3WGL4Watx9GuH6gFk9z4dKWn2bsQ4BbgWkS4xvIP0gAcn2xcWk62PkX
 ArfVMKdZp1Pd0C3Tpmt+nNgx9tGsZP+AG7T8+rAm+4SwNimGC3wI44FSMaHMTVAbyTWE
 IkHQ==
X-Gm-Message-State: AOJu0YzrDO0A9dqFDRU+FYmxm4vIjSGZG26PsUCKbN/DZ0S/jvf3QQdx
 m+6EpDAaWtgOYQGw6h6xTPUDtZ4u0evSS4vDk160tCoHdOtroFQvSkGc1ve5YukWuMDQO1uPuKQ
 ewaz66ohK57jpYZSJGkNr3FIJXgwsKVMkSLae0g==
X-Google-Smtp-Source: AGHT+IEnNiIp7DVMeTEf9W8ZiZ9tV3spxV7ZvP/tnsMsVWy67rLQQ5oRCp/mcLdONHaHaessZ2oh0z9kRSR+uHtFTl8=
X-Received: by 2002:a05:651c:388:b0:2d0:7b53:9330 with SMTP id
 e8-20020a05651c038800b002d07b539330mr3915736ljp.14.1707335881131; Wed, 07 Feb
 2024 11:58:01 -0800 (PST)
MIME-Version: 1.0
References: <20240207163812.3231697-1-alex.bennee@linaro.org>
 <20240207163812.3231697-8-alex.bennee@linaro.org>
In-Reply-To: <20240207163812.3231697-8-alex.bennee@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 7 Feb 2024 12:57:50 -0700
Message-ID: <CANCZdfqNka9Ro50BcGAXhVU00bjUpsSjNSe8F00-053cBHmrzA@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] test-util-filemonitor: Adapt to the FreeBSD
 inotify rename semantics
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Chris Wulff <crwulff@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>, Bin Meng <bin.meng@windriver.com>, 
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 Marek Vasut <marex@denx.de>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Beraldo Leal <bleal@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, Ed Maste <emaste@freebsd.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Li-Wen Hsu <lwhsu@freebsd.org>, 
 Laurent Vivier <laurent@vivier.eu>, Kyle Evans <kevans@freebsd.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: multipart/alternative; boundary="000000000000b5201a0610d01c93"
Received-SPF: none client-ip=2a00:1450:4864:20::22e;
 envelope-from=wlosh@bsdimp.com; helo=mail-lj1-x22e.google.com
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

--000000000000b5201a0610d01c93
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 9:38=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:

> From: Ilya Leoshkevich <iii@linux.ibm.com>
>
> Unlike on Linux, on FreeBSD renaming a file when the destination
> already exists results in an IN_DELETE event for that existing file:
>
>     $ FILEMONITOR_DEBUG=3D1 build/tests/unit/test-util-filemonitor
>     Rename /tmp/test-util-filemonitor-K13LI2/fish/one.txt ->
> /tmp/test-util-filemonitor-K13LI2/two.txt
>     Event id=3D200000000 event=3D2 file=3Done.txt
>     Queue event id 200000000 event 2 file one.txt
>     Queue event id 100000000 event 2 file two.txt
>     Queue event id 100000002 event 2 file two.txt
>     Queue event id 100000000 event 0 file two.txt
>     Queue event id 100000002 event 0 file two.txt
>     Event id=3D100000000 event=3D0 file=3Dtwo.txt
>     Expected event 0 but got 2
>
> This difference in behavior is not expected to break the real users, so
> teach the test to accept it.
>

Reviewed-by: Warner Losh <imp@bsdimp.com>


Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Message-Id: <20240206002344.12372-4-iii@linux.ibm.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/unit/test-util-filemonitor.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tests/unit/test-util-filemonitor.c
> b/tests/unit/test-util-filemonitor.c
> index a22de275955..02e67fc96ac 100644
> --- a/tests/unit/test-util-filemonitor.c
> +++ b/tests/unit/test-util-filemonitor.c
> @@ -360,6 +360,14 @@ test_file_monitor_events(void)
>          { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
>            .filesrc =3D "one.txt", .watchid =3D &watch4,
>            .eventid =3D QFILE_MONITOR_EVENT_DELETED },
> +#ifdef __FreeBSD__
> +        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
> +          .filesrc =3D "two.txt", .watchid =3D &watch0,
> +          .eventid =3D QFILE_MONITOR_EVENT_DELETED },
> +        { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
> +          .filesrc =3D "two.txt", .watchid =3D &watch2,
> +          .eventid =3D QFILE_MONITOR_EVENT_DELETED },
> +#endif
>          { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
>            .filesrc =3D "two.txt", .watchid =3D &watch0,
>            .eventid =3D QFILE_MONITOR_EVENT_CREATED },
> --
> 2.39.2
>
>

--000000000000b5201a0610d01c93
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 7, 2024 at 9:38=E2=80=AFA=
M Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.benne=
e@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">From: Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.com"=
 target=3D"_blank">iii@linux.ibm.com</a>&gt;<br>
<br>
Unlike on Linux, on FreeBSD renaming a file when the destination<br>
already exists results in an IN_DELETE event for that existing file:<br>
<br>
=C2=A0 =C2=A0 $ FILEMONITOR_DEBUG=3D1 build/tests/unit/test-util-filemonito=
r<br>
=C2=A0 =C2=A0 Rename /tmp/test-util-filemonitor-K13LI2/fish/one.txt -&gt; /=
tmp/test-util-filemonitor-K13LI2/two.txt<br>
=C2=A0 =C2=A0 Event id=3D200000000 event=3D2 file=3Done.txt<br>
=C2=A0 =C2=A0 Queue event id 200000000 event 2 file one.txt<br>
=C2=A0 =C2=A0 Queue event id 100000000 event 2 file two.txt<br>
=C2=A0 =C2=A0 Queue event id 100000002 event 2 file two.txt<br>
=C2=A0 =C2=A0 Queue event id 100000000 event 0 file two.txt<br>
=C2=A0 =C2=A0 Queue event id 100000002 event 0 file two.txt<br>
=C2=A0 =C2=A0 Event id=3D100000000 event=3D0 file=3Dtwo.txt<br>
=C2=A0 =C2=A0 Expected event 0 but got 2<br>
<br>
This difference in behavior is not expected to break the real users, so<br>
teach the test to accept it.<br></blockquote><div><br></div><div>Reviewed-b=
y: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt;=
</div><div><br></div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
Suggested-by: Daniel P. Berrange &lt;<a href=3D"mailto:berrange@redhat.com"=
 target=3D"_blank">berrange@redhat.com</a>&gt;<br>
Signed-off-by: Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.com" ta=
rget=3D"_blank">iii@linux.ibm.com</a>&gt;<br>
Message-Id: &lt;<a href=3D"mailto:20240206002344.12372-4-iii@linux.ibm.com"=
 target=3D"_blank">20240206002344.12372-4-iii@linux.ibm.com</a>&gt;<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
---<br>
=C2=A0tests/unit/test-util-filemonitor.c | 8 ++++++++<br>
=C2=A01 file changed, 8 insertions(+)<br>
<br>
diff --git a/tests/unit/test-util-filemonitor.c b/tests/unit/test-util-file=
monitor.c<br>
index a22de275955..02e67fc96ac 100644<br>
--- a/tests/unit/test-util-filemonitor.c<br>
+++ b/tests/unit/test-util-filemonitor.c<br>
@@ -360,6 +360,14 @@ test_file_monitor_events(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ .type =3D QFILE_MONITOR_TEST_OP_EVENT,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.filesrc =3D &quot;one.txt&quot;, =
.watchid =3D &amp;watch4,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.eventid =3D QFILE_MONITOR_EVENT_D=
ELETED },<br>
+#ifdef __FreeBSD__<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 { .type =3D QFILE_MONITOR_TEST_OP_EVENT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .filesrc =3D &quot;two.txt&quot;, .watc=
hid =3D &amp;watch0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .eventid =3D QFILE_MONITOR_EVENT_DELETE=
D },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 { .type =3D QFILE_MONITOR_TEST_OP_EVENT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .filesrc =3D &quot;two.txt&quot;, .watc=
hid =3D &amp;watch2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .eventid =3D QFILE_MONITOR_EVENT_DELETE=
D },<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ .type =3D QFILE_MONITOR_TEST_OP_EVENT,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.filesrc =3D &quot;two.txt&quot;, =
.watchid =3D &amp;watch0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.eventid =3D QFILE_MONITOR_EVENT_C=
REATED },<br>
-- <br>
2.39.2<br>
<br>
</blockquote></div></div>

--000000000000b5201a0610d01c93--

