Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BF5C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 22:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tufbL-0003Ch-DR; Tue, 18 Mar 2025 18:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1tufb6-0003AE-Hq; Tue, 18 Mar 2025 18:39:49 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1tufb3-00017o-1U; Tue, 18 Mar 2025 18:39:44 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3fab0bc2f51so1449963b6e.1; 
 Tue, 18 Mar 2025 15:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742337579; x=1742942379; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JHtAOQUQZTKmeIASbuQa+FlALNIbFaRPOL6lzW0Xv/g=;
 b=iGppbB6tXbD4x2atiUhaP1a1nMGboSboYATdatVMJ3O9UPtNP4lk5w/bOGFY1rYHAe
 DrQkKUYaHEg+aEapNqGKZtEpx53/4Dvc2zstTZvuxv+B+DdoXDVCo8eQVHM8ENQ77327
 Y0PJhHApingr3xhM34RM216m0DSZr12TBjMl0goX+I2W3UulrOKc4c8wNLPa1SO1YL7W
 dwbJt6E+mY4ysBzSaopGlVELNi+OW3ZgCzT6dBQGtmYKWO+Nkf4XeuQwCGg2yRvqByqv
 jSIOB7LbLz4GoFtypNrIxdZlgr6vNTGnluFyT5zH8ioaa7uo/+tlTH2fciHGvzRQbTka
 PtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742337579; x=1742942379;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JHtAOQUQZTKmeIASbuQa+FlALNIbFaRPOL6lzW0Xv/g=;
 b=YdCwW25SqG0tzKKCbl7qwjYVLgenpfjBiTggVdVbXjxyvhNhPFxFLwaLiPvVyYVNs+
 XQx41j72oiHfLlKTj6ZWVX3gemB3FsdjKoygiMteP0Gc34BOlAEEV8EpV6ALy6q5pGUl
 FVJqCq/a2hO4S82XRY0lG0Ry64ej+3f0/TIXlHKNDwpTBH559WbYxAJttuE14jPsKw5Z
 L2XxW6xcRGf5YQIE/yMoRFZ9iaK2tctaL7IuL0J44lY6IKZUwz8ctCWOGvlGrXfqQ1Yj
 gr02n63cwft2j3oumLRrJYAMSL86oADAzNt6CVhFmtEsWMvINPUBuALQzfzXm9NqKR1N
 Ro2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFK4AdBMX3TFVUdYDdmtPjvsld48WKN6wRq8Xg6phl5Fw7GsMGjDqBj4Y4cUAk+jsfyFHwC46gTw==@nongnu.org
X-Gm-Message-State: AOJu0YyN93em6RumbGXcRWCZW/svSYj7aQzcR4uPcsjsETYHEajsCw1p
 upgVaQthkZ/ld34b7onqDt4jak7oVOC/MxgaQzXjfU405bMbSMA3F3yAJnTmnUxILt/5bVQeh75
 dSD66327AegG4Y+sgtuTkZCn7LpvRWw==
X-Gm-Gg: ASbGncuFlWea0bGm9woqZbanaVNkfviYg0TW9tEO4njNFyQTmfw7jCiOm3kcD+FHW+r
 bXTKXRpzdkPlZ8xm1uRC4RhfiTU2MWJebRCGxI6eRilQFHl+aykM+SPpN6eocm+gimwdvQGIWcy
 8aKNO6Yn1XyStuNHHKWmqJYvni5ioBtPbJPcIqXu7NY9jxwxQYOGNEb3J3ykrGzZWFbPI=
X-Google-Smtp-Source: AGHT+IHPPJnu/IBUy2ne60AcQx3dGtqDQnfcM3xUjKkd0GBUIq6NuLLONsphUy1Wj9MNeIyHPYYa6EOb2thmC6/HaY0=
X-Received: by 2002:a05:6808:1a12:b0:3f6:a889:59c6 with SMTP id
 5614622812f47-3fead5b8a1amr252824b6e.26.1742337578855; Tue, 18 Mar 2025
 15:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250318061420.20378-1-thuth@redhat.com>
In-Reply-To: <20250318061420.20378-1-thuth@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Tue, 18 Mar 2025 23:39:26 +0100
X-Gm-Features: AQ5f1JolfDRaPkGSblr53vYMU7YR1tVqBaEWUHfH6W6mw8GX6keQ9HVwyZEa4_4
Message-ID: <CAPan3WpZrouYnzXSF991nQ=mYdkt+BKdBS2_4B4u7vESMYtUHw@mail.gmail.com>
Subject: Re: [PATCH] docs/system/arm: Use "functional tests" instead of
 "integration tests"
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000007773c80630a5947a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

--0000000000007773c80630a5947a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>

On Tue, Mar 18, 2025 at 7:14=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:

> From: Thomas Huth <thuth@redhat.com>
>
> We don't use the term "integration tests" for these kind of tests
> anymore, it's "functional tests" nowadays.
>
> Suggested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/system/arm/bananapi_m2u.rst | 6 +++---
>  docs/system/arm/orangepi.rst     | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/docs/system/arm/bananapi_m2u.rst
> b/docs/system/arm/bananapi_m2u.rst
> index 6efa222c16f..03cc5618c38 100644
> --- a/docs/system/arm/bananapi_m2u.rst
> +++ b/docs/system/arm/bananapi_m2u.rst
> @@ -125,10 +125,10 @@ And then boot it.
>
>    $ qemu-system-arm -M bpim2u -nographic -sd sd.img
>
> -Banana Pi M2U integration tests
> -"""""""""""""""""""""""""""""""
> +Banana Pi M2U functional tests
> +""""""""""""""""""""""""""""""
>
> -The Banana Pi M2U machine has several integration tests included.
> +The Banana Pi M2U machine has several functional tests included.
>  To run the whole set of tests, build QEMU from source and simply
>  provide the following command:
>
> diff --git a/docs/system/arm/orangepi.rst b/docs/system/arm/orangepi.rst
> index 716062fca9c..d81f6c3bfd2 100644
> --- a/docs/system/arm/orangepi.rst
> +++ b/docs/system/arm/orangepi.rst
> @@ -252,10 +252,10 @@ and set the following environment variables before
> booting:
>  Optionally you may save the environment variables to SD card with
> 'saveenv'.
>  To continue booting simply give the 'boot' command and NetBSD boots.
>
> -Orange Pi PC integration tests
> -""""""""""""""""""""""""""""""
> +Orange Pi PC functional tests
> +"""""""""""""""""""""""""""""
>
> -The Orange Pi PC machine has several integration tests included.
> +The Orange Pi PC machine has several functional tests included.
>  To run the whole set of tests, build QEMU from source and simply
>  provide the following command from the build directory:
>
> --
> 2.48.1
>
>

--=20
Niek Linnenbank

--0000000000007773c80630a5947a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Reviewed-by: Niek Linnenbank &lt;<a href=3D"mailto:ni=
eklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt;</div><br><div clas=
s=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_att=
r">On Tue, Mar 18, 2025 at 7:14=E2=80=AFAM Thomas Huth &lt;<a href=3D"mailt=
o:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">From: Thomas Huth &lt;<a href=3D"mailto=
:thuth@redhat.com" target=3D"_blank">thuth@redhat.com</a>&gt;<br>
<br>
We don&#39;t use the term &quot;integration tests&quot; for these kind of t=
ests<br>
anymore, it&#39;s &quot;functional tests&quot; nowadays.<br>
<br>
Suggested-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.co=
m" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank">thuth@redhat.com</a>&gt;<br>
---<br>
=C2=A0docs/system/arm/bananapi_m2u.rst | 6 +++---<br>
=C2=A0docs/system/arm/orangepi.rst=C2=A0 =C2=A0 =C2=A0| 6 +++---<br>
=C2=A02 files changed, 6 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/docs/system/arm/bananapi_m2u.rst b/docs/system/arm/bananapi_m2=
u.rst<br>
index 6efa222c16f..03cc5618c38 100644<br>
--- a/docs/system/arm/bananapi_m2u.rst<br>
+++ b/docs/system/arm/bananapi_m2u.rst<br>
@@ -125,10 +125,10 @@ And then boot it.<br>
<br>
=C2=A0 =C2=A0$ qemu-system-arm -M bpim2u -nographic -sd sd.img<br>
<br>
-Banana Pi M2U integration tests<br>
-&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&q=
uot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot=
;&quot;&quot;&quot;&quot;&quot;&quot;<br>
+Banana Pi M2U functional tests<br>
+&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&q=
uot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot=
;&quot;&quot;&quot;&quot;&quot;<br>
<br>
-The Banana Pi M2U machine has several integration tests included.<br>
+The Banana Pi M2U machine has several functional tests included.<br>
=C2=A0To run the whole set of tests, build QEMU from source and simply<br>
=C2=A0provide the following command:<br>
<br>
diff --git a/docs/system/arm/orangepi.rst b/docs/system/arm/orangepi.rst<br=
>
index 716062fca9c..d81f6c3bfd2 100644<br>
--- a/docs/system/arm/orangepi.rst<br>
+++ b/docs/system/arm/orangepi.rst<br>
@@ -252,10 +252,10 @@ and set the following environment variables before bo=
oting:<br>
=C2=A0Optionally you may save the environment variables to SD card with &#3=
9;saveenv&#39;.<br>
=C2=A0To continue booting simply give the &#39;boot&#39; command and NetBSD=
 boots.<br>
<br>
-Orange Pi PC integration tests<br>
-&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&q=
uot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot=
;&quot;&quot;&quot;&quot;&quot;<br>
+Orange Pi PC functional tests<br>
+&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&q=
uot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot=
;&quot;&quot;&quot;&quot;<br>
<br>
-The Orange Pi PC machine has several integration tests included.<br>
+The Orange Pi PC machine has several functional tests included.<br>
=C2=A0To run the whole set of tests, build QEMU from source and simply<br>
=C2=A0provide the following command from the build directory:<br>
<br>
-- <br>
2.48.1<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></div></div>

--0000000000007773c80630a5947a--

