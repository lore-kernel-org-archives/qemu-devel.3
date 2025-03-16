Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F167BC282DE
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Mar 2025 20:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttuV3-0007Zr-7Q; Sun, 16 Mar 2025 16:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ttuUu-0007ZP-Sk; Sun, 16 Mar 2025 16:22:13 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ttuUr-0000jO-Bf; Sun, 16 Mar 2025 16:22:11 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6003d977ab7so2111278eaf.2; 
 Sun, 16 Mar 2025 13:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742156527; x=1742761327; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VUKKF8KqU6DFKbMo9MQQd+ILSeTusNpPyKw0j2wt3Xs=;
 b=TU2moJKJudh6YLA10TQ4b7YcT5hK+tCM1UNiZLXYrGZ8msSPdLfhKaNa3G66X9WZB9
 mfKqIbo4y801djXoRYV4knAdLulKrdeFtP6EKT+73oTBvfvGVt67lji8LLPJO9Pfnw+C
 mIDmTLquAaLgYBuFUJUhpCMiKM/vuvtsvMxhiPkVlcpf9CEz+NoQvoanGgnjbpaWDebX
 ZO/1XtDYJ+8wQxc+9zaHPj4vaeacBEIxEyEbXkcAf2oYGiYeugHgRSrTQcJRPArEfm0E
 i20w1b0mxAh5C4l8WNtno3prM+2plESGKVc86Ov7Xnhh7NqK3FUNDaZ2fFzjDQfjNXgC
 j62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742156527; x=1742761327;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VUKKF8KqU6DFKbMo9MQQd+ILSeTusNpPyKw0j2wt3Xs=;
 b=sVrGEhY7cd4tiR8Q4oJXYC7TVY6NDbfwzuK86CqgOFwZUEMI5OmtEd83+kkTX/kpHL
 fy0UKIXQyw5dRlnpSDxcY+d7QJB37+ckYAKstBegBZoaZD39Wm69bRJb2jQ1yGfCQcB3
 9dhMiv31fB85kRTuNQBcC2+UYwADSMaUbsOpKU9sfvakHpUedBSW1H7BxObkVfsQptzu
 6sZikAxBSnYBamCPbYNnvYCwmNysBzCtyWmmtyMAU3pOCF1xoQaP+azpEGZIXTPkkSKw
 YG/yv+K2sG7DzVA3eS7+Ukzk+U63Zq0/190hE9KHq0yPNQ/6yNO1bIUtU/In83s/IBve
 y9pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgRJAwhz5ivI+zhT2Qlh2Ed+s6TVoyxiXjONvGYLHDu8LfTWCzCGZ43QIW39KFTf+if3xyTOjIrA==@nongnu.org
X-Gm-Message-State: AOJu0YxW45TU3KGw/1n2tZj2UxhouOKUiKin/MWmADziDl0fnvbfm3Pw
 tetCBFF6ix7uYA1yUR+DpXyT6el/dywlLYM0i6TH4tHyjcrDtsjjn8qv/2z/1PupMtF8L+O6MBT
 4vgQ9kXBiff83s2x6274WfhJvpGo=
X-Gm-Gg: ASbGncs8krSRO05ebPmR2rflhQ/Ys422+XUDNWyjRrfWoKiEPeKKOOLK/PX4FSQTvMs
 QT42gYozqaXZXt5YT3rlkUBvA9+h4EUTHodXtzfJxc50jj7VKEAnbSoyiiL3o67fknn9tLJgw55
 6q0u7z4wdIcXCYZiDPETo+EMJVKPWbwZRK0KjtSLskqg4x95vNo9+P6r+F
X-Google-Smtp-Source: AGHT+IGXRYOae8sAwUCnMNoHdpmFlHsqIuYaw512rTD+2sO6LC5EO9ATr0IGXkNyYTxhajWYCteKTtxJO7q8d7zs3NU=
X-Received: by 2002:a05:6820:1e11:b0:601:a677:d126 with SMTP id
 006d021491bc7-601e45692bcmr5137782eaf.2.1742156527440; Sun, 16 Mar 2025
 13:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250311160847.388670-1-thuth@redhat.com>
In-Reply-To: <20250311160847.388670-1-thuth@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sun, 16 Mar 2025 21:21:55 +0100
X-Gm-Features: AQ5f1JrYAHop8lShftr7SM_f19bO-5NdvSa45LiJFQE54YUJwRdHMAt3Wfsk6dU
Message-ID: <CAPan3WqXwAWeAqbQypF7PCXh_pjDUgbbiWwXkPSbXrFetfMZAQ@mail.gmail.com>
Subject: Re: [PATCH] docs/system: Fix the information on how to run certain
 functional tests
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f61d2306307b6c7d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000f61d2306307b6c7d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Tue, Mar 11, 2025 at 5:08=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:

> The tests have been converted to the functional framework, so
> we should not talk about Avocado here anymore.
>
> Fixes: f7d6b772200 ("tests/functional: Convert BananaPi tests to the
> functional framework")
> Fixes: 380f7268b7b ("tests/functional: Convert the OrangePi tests to the
> functional framework")
> Fixes: 4c0a2df81c9 ("tests/functional: Convert some tests that download
> files via fetch_asset()")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/system/arm/bananapi_m2u.rst | 5 ++---
>  docs/system/arm/orangepi.rst     | 6 +++---
>  docs/system/devices/igb.rst      | 4 ++--
>  3 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/docs/system/arm/bananapi_m2u.rst
> b/docs/system/arm/bananapi_m2u.rst
> index 587b4886553..d30db8d04c3 100644
> --- a/docs/system/arm/bananapi_m2u.rst
> +++ b/docs/system/arm/bananapi_m2u.rst
> @@ -135,6 +135,5 @@ provide the following command:
>  .. code-block:: bash
>
>    $ cd qemu-build-dir
> -  $ AVOCADO_ALLOW_LARGE_STORAGE=3Dyes tests/venv/bin/avocado \
> -    --verbose --show=3Dapp,console run -t machine:bpim2u \
> -    ../tests/avocado/boot_linux_console.py
> +  $ QEMU_TEST_ALLOW_LARGE_STORAGE=3D1 \
> +    meson test --suite thorough func-arm-arm_bpim2u
> diff --git a/docs/system/arm/orangepi.rst b/docs/system/arm/orangepi.rst
> index db87e81fec4..8b9448ca7b0 100644
> --- a/docs/system/arm/orangepi.rst
> +++ b/docs/system/arm/orangepi.rst
> @@ -257,9 +257,9 @@ Orange Pi PC integration tests
>
Perhaps for consistency, we can also rename to 'functional tests' here.


>
>  The Orange Pi PC machine has several integration tests included.
>
And same on this line.


>  To run the whole set of tests, build QEMU from source and simply
> -provide the following command:
> +provide the following command from the build directory:
>
>  .. code-block:: bash
>
> -  $ AVOCADO_ALLOW_LARGE_STORAGE=3Dyes avocado --show=3Dapp,console run \
> -     -t machine:orangepi-pc tests/avocado/boot_linux_console.py
> +  $ QEMU_TEST_ALLOW_LARGE_STORAGE=3D1 \
> +    meson test --suite thorough func-arm-arm_orangepi
>
I've tried to run on my Ubuntu 24.04.1 LTS based system using this exact
same command, but got this error:

$ QEMU_TEST_ALLOW_LARGE_STORAGE=3D1 meson test --suite thorough
func-arm-arm_orangepi

ERROR: Build data file '/home/user/qemu/build/meson-private/build.dat'
references functions or classes that don't exist. This probably means that
it was generated with an old version of meson. Consider reconfiguring the
directory with "meson setup --reconfigure".

The meson version I have installed via apt-get is 1.3.2-1ubuntu1. Only when
running using the 'meson' command from the pyvenv, it runs OK:

$ QEMU_TEST_ALLOW_LARGE_STORAGE=3D1 ./pyvenv/bin/meson test --suite thoroug=
h
func-arm-arm_orangepi
ninja: Entering directory `/home/user/qemu/build'
[1/6] Generating qemu-version.h with a custom command (wrapped by meson to
capture output)
1/1 qemu:func-thorough+func-arm-thorough+thorough / func-arm-arm_orangepi
     OK             165.81s   5 subtests passed



> diff --git a/docs/system/devices/igb.rst b/docs/system/devices/igb.rst
> index 04e79dfe549..9145af5c757 100644
> --- a/docs/system/devices/igb.rst
> +++ b/docs/system/devices/igb.rst
> @@ -57,11 +57,11 @@ directory:
>    meson test qtest-x86_64/qos-test
>
>  ethtool can test register accesses, interrupts, etc. It is automated as =
an
> -Avocado test and can be ran with the following command:
> +functional test and can be ran with the following command:
>
>  .. code:: shell
>
> -  make check-avocado AVOCADO_TESTS=3Dtests/avocado/netdev-ethtool.py
> +  meson test --suite thorough func-x86_64-netdev_ethtool
>
>  References
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --
> 2.48.1
>
>

--=20
Niek Linnenbank

--000000000000f61d2306307b6c7d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Thomas,</div><br><div class=3D"gmail_quote gmail_q=
uote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 11, 2025 =
at 5:08=E2=80=AFPM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thut=
h@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">The tests have been converted to the functional framework, so<b=
r>
we should not talk about Avocado here anymore.<br>
<br>
Fixes: f7d6b772200 (&quot;tests/functional: Convert BananaPi tests to the f=
unctional framework&quot;)<br>
Fixes: 380f7268b7b (&quot;tests/functional: Convert the OrangePi tests to t=
he functional framework&quot;)<br>
Fixes: 4c0a2df81c9 (&quot;tests/functional: Convert some tests that downloa=
d files via fetch_asset()&quot;)<br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank">thuth@redhat.com</a>&gt;<br>
---<br>
=C2=A0docs/system/arm/bananapi_m2u.rst | 5 ++---<br>
=C2=A0docs/system/arm/orangepi.rst=C2=A0 =C2=A0 =C2=A0| 6 +++---<br>
=C2=A0docs/system/devices/igb.rst=C2=A0 =C2=A0 =C2=A0 | 4 ++--<br>
=C2=A03 files changed, 7 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/docs/system/arm/bananapi_m2u.rst b/docs/system/arm/bananapi_m2=
u.rst<br>
index 587b4886553..d30db8d04c3 100644<br>
--- a/docs/system/arm/bananapi_m2u.rst<br>
+++ b/docs/system/arm/bananapi_m2u.rst<br>
@@ -135,6 +135,5 @@ provide the following command:<br>
=C2=A0.. code-block:: bash<br>
<br>
=C2=A0 =C2=A0$ cd qemu-build-dir<br>
-=C2=A0 $ AVOCADO_ALLOW_LARGE_STORAGE=3Dyes tests/venv/bin/avocado \<br>
-=C2=A0 =C2=A0 --verbose --show=3Dapp,console run -t machine:bpim2u \<br>
-=C2=A0 =C2=A0 ../tests/avocado/boot_linux_console.py<br>
+=C2=A0 $ QEMU_TEST_ALLOW_LARGE_STORAGE=3D1 \<br>
+=C2=A0 =C2=A0 meson test --suite thorough func-arm-arm_bpim2u<br>
diff --git a/docs/system/arm/orangepi.rst b/docs/system/arm/orangepi.rst<br=
>
index db87e81fec4..8b9448ca7b0 100644<br>
--- a/docs/system/arm/orangepi.rst<br>
+++ b/docs/system/arm/orangepi.rst<br>
@@ -257,9 +257,9 @@ Orange Pi PC integration tests<br></blockquote><div>Per=
haps for consistency, we can also rename to &#39;functional tests&#39; here=
.</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
=C2=A0The Orange Pi PC machine has several integration tests included.<br><=
/blockquote><div>And same on this line.</div><div>=C2=A0<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
=C2=A0To run the whole set of tests, build QEMU from source and simply<br>
-provide the following command:<br>
+provide the following command from the build directory:<br>
<br>
=C2=A0.. code-block:: bash<br>
<br>
-=C2=A0 $ AVOCADO_ALLOW_LARGE_STORAGE=3Dyes avocado --show=3Dapp,console ru=
n \<br>
-=C2=A0 =C2=A0 =C2=A0-t machine:orangepi-pc tests/avocado/boot_linux_consol=
e.py<br>
+=C2=A0 $ QEMU_TEST_ALLOW_LARGE_STORAGE=3D1 \<br>
+=C2=A0 =C2=A0 meson test --suite thorough func-arm-arm_orangepi<br></block=
quote><div>I&#39;ve tried to run on my Ubuntu 24.04.1 LTS based system usin=
g this exact same command, but got this error:</div><div><br></div><div>$ Q=
EMU_TEST_ALLOW_LARGE_STORAGE=3D1 meson test --suite thorough func-arm-arm_o=
rangepi<br><br>ERROR: Build data file &#39;/home/user/qemu/build/meson-priv=
ate/build.dat&#39; references functions or classes that don&#39;t exist. Th=
is probably means that it was generated with an old version of meson. Consi=
der reconfiguring the directory with &quot;meson setup --reconfigure&quot;.=
</div><div><br></div><div><div>The meson version I have installed via apt-g=
et is 1.3.2-1ubuntu1. Only when running using the &#39;meson&#39; command f=
rom the pyvenv, it runs OK:</div></div><div><br></div><div>$ QEMU_TEST_ALLO=
W_LARGE_STORAGE=3D1 ./pyvenv/bin/meson test --suite thorough func-arm-arm_o=
rangepi<br>ninja: Entering directory `/home/user/qemu/build&#39;<br>[1/6] G=
enerating qemu-version.h with a custom command (wrapped by meson to capture=
 output)<br>1/1 qemu:func-thorough+func-arm-thorough+thorough / func-arm-ar=
m_orangepi =C2=A0 =C2=A0 =C2=A0 =C2=A0OK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 165.81s =C2=A0 5 subtests passed</div><div><br></div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/docs/system/devices/igb.rst b/docs/system/devices/igb.rst<br>
index 04e79dfe549..9145af5c757 100644<br>
--- a/docs/system/devices/igb.rst<br>
+++ b/docs/system/devices/igb.rst<br>
@@ -57,11 +57,11 @@ directory:<br>
=C2=A0 =C2=A0meson test qtest-x86_64/qos-test<br>
<br>
=C2=A0ethtool can test register accesses, interrupts, etc. It is automated =
as an<br>
-Avocado test and can be ran with the following command:<br>
+functional test and can be ran with the following command:<br>
<br>
=C2=A0.. code:: shell<br>
<br>
-=C2=A0 make check-avocado AVOCADO_TESTS=3Dtests/avocado/netdev-ethtool.py<=
br>
+=C2=A0 meson test --suite thorough func-x86_64-netdev_ethtool<br>
<br>
=C2=A0References<br>
=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-- <br>
2.48.1<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></div></div>

--000000000000f61d2306307b6c7d--

