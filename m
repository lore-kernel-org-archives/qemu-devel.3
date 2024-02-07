Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8075FC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 19:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXo4s-0000pK-EW; Wed, 07 Feb 2024 14:59:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1rXo4r-0000p4-Ci
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 14:59:25 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1rXo4p-0002oe-F7
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 14:59:25 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-560c696ccffso354268a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 11:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1707335962; x=1707940762;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rdm1ISFzJpNXI93O9dFvZl8pbSopkyWIRj/AFKO4vKs=;
 b=Vdu44+ei5nqsjyqPzX0Vyp31ZoPfeKvWVujSLzDwLVm9bbJjbhgfs9q6wbTfJHrK6G
 XE8hZzRLzWCj3pJDilAk9qE94MObI6gLreZz9On4o7Ni7LJB2UBS1c+7DZ+JeTgxzCNt
 NCOpyAgWLVkL8L2Nwe0m887fidGJZ3zSJ6KQjRyVXAVEQ36d8PuYcv4vOBcZiD1vqWPp
 h/5khmOtox2+lytakL54chkKO/F6Gf9P0THxI6rcqeMbpF+aiD+lzcVY0gIu8HvbWo/3
 anYV26N/spQ5G00znZ0B1+wnIv2+JUw0no1kA9+eh3HfA8gH6MwgyMnTXLa4W+sdC5pm
 TWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707335962; x=1707940762;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rdm1ISFzJpNXI93O9dFvZl8pbSopkyWIRj/AFKO4vKs=;
 b=kO9QlWM0PiBkK9AJFaBDMnfyKAWnZyf5fpHUF/z8OHSQ5f6CWhfXZwdGMnmmSvPvHW
 WONjD6plmpluCm2jGr9pFCbFTfCUveZySNmBj9G+UrKFpP5Z5TtISkyNsrOS5e8SwcfA
 mSO0ny10gosEI7qs+tbajW5KabnSzTdhDx6ljOKB/PmxbrmqCUI9n1kFuabZtI47QPz/
 Y+809KM3MSxaOhzLzWjC7EQIBH2f2v/MADkjVy2Su0mgSqf6PBiPfy2EGpTJN/UoyGM5
 JKBFJcG/eA3UcnOzKI4XlVnD3if2JIlVVaUD0VDcr6L1464WoBZ4IzsMoBAfeIu3/N1D
 sDsQ==
X-Gm-Message-State: AOJu0YwqRM7SBFC4XZ6wbbXtrsn6jC1eOTW1Y/fzIlx8EmK6V+oBdZGA
 Qyzk/ObWlHfscBvzrTS9/cYV5UrT/JLaconYysQTzhZIqfo3qJ2PAeK5jQ2usXrVwIiLQIsjy/S
 6RJQQaZ+EEtWvdcLZOW2ij4wJ85VD3PC7zUHggg==
X-Google-Smtp-Source: AGHT+IEyG6w8ZFMR5QbBoIT3Ll+ytqHaPKaaE0fP025U1cA0KOAFdobmHiR3RvKFwuhQO911Lk4J4F60PtTxBKr876M=
X-Received: by 2002:a05:6402:180a:b0:560:24d8:d2d1 with SMTP id
 g10-20020a056402180a00b0056024d8d2d1mr499927edy.11.1707335961835; Wed, 07 Feb
 2024 11:59:21 -0800 (PST)
MIME-Version: 1.0
References: <20240207163812.3231697-1-alex.bennee@linaro.org>
 <20240207163812.3231697-9-alex.bennee@linaro.org>
In-Reply-To: <20240207163812.3231697-9-alex.bennee@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 7 Feb 2024 12:59:10 -0700
Message-ID: <CANCZdfq+V9tV1H1fKUacLNCpGkJ43S3vTgORQwqX3MhrCMsSeQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] meson: Link with libinotify on FreeBSD
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
Content-Type: multipart/alternative; boundary="000000000000848efc0610d0213b"
Received-SPF: none client-ip=2a00:1450:4864:20::52e;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x52e.google.com
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

--000000000000848efc0610d0213b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 9:38=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:

> From: Ilya Leoshkevich <iii@linux.ibm.com>
>
> make vm-build-freebsd fails with:
>
>     ld: error: undefined symbol: inotify_init1
>     >>> referenced by filemonitor-inotify.c:183
> (../src/util/filemonitor-inotify.c:183)
>     >>>               util_filemonitor-inotify.c.o:(qemu_file_monitor_new=
)
> in archive libqemuutil.a
>
> On FreeBSD the inotify functions are defined in libinotify.so. Add it
> to the dependencies.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20240206002344.12372-5-iii@linux.ibm.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  meson.build      | 23 +++++++++++++++++++----
>  util/meson.build |  6 +++++-
>  2 files changed, 24 insertions(+), 5 deletions(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>



> diff --git a/meson.build b/meson.build
> index b5d6dc94a83..e5d6f2d057e 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2384,6 +2384,22 @@ else
>  endif
>  config_host_data.set('CONFIG_ASAN_IFACE_FIBER', have_asan_fiber)
>
> +have_inotify_init =3D cc.has_header_symbol('sys/inotify.h', 'inotify_ini=
t')
> +have_inotify_init1 =3D cc.has_header_symbol('sys/inotify.h',
> 'inotify_init1')
> +inotify =3D not_found
> +if (have_inotify_init or have_inotify_init1) and host_os =3D=3D 'freebsd=
'
> +  # libinotify-kqueue
> +  inotify =3D cc.find_library('inotify')
> +  if have_inotify_init
> +    have_inotify_init =3D inotify.found()
> +  endif
> +  if have_inotify_init1
> +    have_inotify_init1 =3D inotify.found()
> +  endif
> +endif
> +config_host_data.set('CONFIG_INOTIFY', have_inotify_init)
> +config_host_data.set('CONFIG_INOTIFY1', have_inotify_init1)
> +
>  # has_header_symbol
>  config_host_data.set('CONFIG_BLKZONED',
>                       cc.has_header_symbol('linux/blkzoned.h',
> 'BLKOPENZONE'))
> @@ -2400,10 +2416,6 @@ config_host_data.set('CONFIG_FIEMAP',
>  config_host_data.set('CONFIG_GETRANDOM',
>                       cc.has_function('getrandom') and
>                       cc.has_header_symbol('sys/random.h',
> 'GRND_NONBLOCK'))
> -config_host_data.set('CONFIG_INOTIFY',
> -                     cc.has_header_symbol('sys/inotify.h',
> 'inotify_init'))
> -config_host_data.set('CONFIG_INOTIFY1',
> -                     cc.has_header_symbol('sys/inotify.h',
> 'inotify_init1'))
>  config_host_data.set('CONFIG_PRCTL_PR_SET_TIMERSLACK',
>                       cc.has_header_symbol('sys/prctl.h',
> 'PR_SET_TIMERSLACK'))
>  config_host_data.set('CONFIG_RTNETLINK',
> @@ -4407,6 +4419,9 @@ summary_info +=3D {'libudev':           libudev}
>  summary_info +=3D {'FUSE lseek':        fuse_lseek.found()}
>  summary_info +=3D {'selinux':           selinux}
>  summary_info +=3D {'libdw':             libdw}
> +if host_os =3D=3D 'freebsd'
> +  summary_info +=3D {'libinotify-kqueue': inotify}
> +endif
>  summary(summary_info, bool_yn: true, section: 'Dependencies')
>
>  if host_arch =3D=3D 'unknown'
> diff --git a/util/meson.build b/util/meson.build
> index af3bf5692d8..0ef9886be04 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -104,7 +104,11 @@ if have_block
>    util_ss.add(files('throttle.c'))
>    util_ss.add(files('timed-average.c'))
>    if config_host_data.get('CONFIG_INOTIFY1')
> -    util_ss.add(files('filemonitor-inotify.c'))
> +    freebsd_dep =3D []
> +    if host_os =3D=3D 'freebsd'
> +      freebsd_dep =3D inotify
> +    endif
> +    util_ss.add(files('filemonitor-inotify.c'), freebsd_dep)
>    else
>      util_ss.add(files('filemonitor-stub.c'))
>    endif
> --
> 2.39.2
>
>

--000000000000848efc0610d0213b
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
make vm-build-freebsd fails with:<br>
<br>
=C2=A0 =C2=A0 ld: error: undefined symbol: inotify_init1<br>
=C2=A0 =C2=A0 &gt;&gt;&gt; referenced by filemonitor-inotify.c:183 (../src/=
util/filemonitor-inotify.c:183)<br>
=C2=A0 =C2=A0 &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0util_filemonitor-inotify.c.o:(qemu_file_monitor_new) in archive libqe=
muutil.a<br>
<br>
On FreeBSD the inotify functions are defined in libinotify.so. Add it<br>
to the dependencies.<br>
<br>
Signed-off-by: Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.com" ta=
rget=3D"_blank">iii@linux.ibm.com</a>&gt;<br>
Reviewed-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"=
_blank">thuth@redhat.com</a>&gt;<br>
Message-Id: &lt;<a href=3D"mailto:20240206002344.12372-5-iii@linux.ibm.com"=
 target=3D"_blank">20240206002344.12372-5-iii@linux.ibm.com</a>&gt;<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
---<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 | 23 +++++++++++++++++++----<br>
=C2=A0util/meson.build |=C2=A0 6 +++++-<br>
=C2=A02 files changed, 24 insertions(+), 5 deletions(-)<br></blockquote><di=
v><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.=
com">imp@bsdimp.com</a>&gt;</div><div><br></div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
diff --git a/meson.build b/meson.build<br>
index b5d6dc94a83..e5d6f2d057e 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -2384,6 +2384,22 @@ else<br>
=C2=A0endif<br>
=C2=A0config_host_data.set(&#39;CONFIG_ASAN_IFACE_FIBER&#39;, have_asan_fib=
er)<br>
<br>
+have_inotify_init =3D cc.has_header_symbol(&#39;sys/inotify.h&#39;, &#39;i=
notify_init&#39;)<br>
+have_inotify_init1 =3D cc.has_header_symbol(&#39;sys/inotify.h&#39;, &#39;=
inotify_init1&#39;)<br>
+inotify =3D not_found<br>
+if (have_inotify_init or have_inotify_init1) and host_os =3D=3D &#39;freeb=
sd&#39;<br>
+=C2=A0 # libinotify-kqueue<br>
+=C2=A0 inotify =3D cc.find_library(&#39;inotify&#39;)<br>
+=C2=A0 if have_inotify_init<br>
+=C2=A0 =C2=A0 have_inotify_init =3D inotify.found()<br>
+=C2=A0 endif<br>
+=C2=A0 if have_inotify_init1<br>
+=C2=A0 =C2=A0 have_inotify_init1 =3D inotify.found()<br>
+=C2=A0 endif<br>
+endif<br>
+config_host_data.set(&#39;CONFIG_INOTIFY&#39;, have_inotify_init)<br>
+config_host_data.set(&#39;CONFIG_INOTIFY1&#39;, have_inotify_init1)<br>
+<br>
=C2=A0# has_header_symbol<br>
=C2=A0config_host_data.set(&#39;CONFIG_BLKZONED&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 cc.has_header_symbol(&#39;linux/blkzoned.h&#39;, &#39;BLKOPENZONE&#39;)=
)<br>
@@ -2400,10 +2416,6 @@ config_host_data.set(&#39;CONFIG_FIEMAP&#39;,<br>
=C2=A0config_host_data.set(&#39;CONFIG_GETRANDOM&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 cc.has_function(&#39;getrandom&#39;) and<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 cc.has_header_symbol(&#39;sys/random.h&#39;, &#39;GRND_NONBLOCK&#39;))<=
br>
-config_host_data.set(&#39;CONFIG_INOTIFY&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0cc.has_header_symbol(&#39;sys/inotify.h&#39;, &#39;inotify_init&#39;))<b=
r>
-config_host_data.set(&#39;CONFIG_INOTIFY1&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0cc.has_header_symbol(&#39;sys/inotify.h&#39;, &#39;inotify_init1&#39;))<=
br>
=C2=A0config_host_data.set(&#39;CONFIG_PRCTL_PR_SET_TIMERSLACK&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 cc.has_header_symbol(&#39;sys/prctl.h&#39;, &#39;PR_SET_TIMERSLACK&#39;=
))<br>
=C2=A0config_host_data.set(&#39;CONFIG_RTNETLINK&#39;,<br>
@@ -4407,6 +4419,9 @@ summary_info +=3D {&#39;libudev&#39;:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0libudev}<br>
=C2=A0summary_info +=3D {&#39;FUSE lseek&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 f=
use_lseek.found()}<br>
=C2=A0summary_info +=3D {&#39;selinux&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0selinux}<br>
=C2=A0summary_info +=3D {&#39;libdw&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0libdw}<br>
+if host_os =3D=3D &#39;freebsd&#39;<br>
+=C2=A0 summary_info +=3D {&#39;libinotify-kqueue&#39;: inotify}<br>
+endif<br>
=C2=A0summary(summary_info, bool_yn: true, section: &#39;Dependencies&#39;)=
<br>
<br>
=C2=A0if host_arch =3D=3D &#39;unknown&#39;<br>
diff --git a/util/meson.build b/util/meson.build<br>
index af3bf5692d8..0ef9886be04 100644<br>
--- a/util/meson.build<br>
+++ b/util/meson.build<br>
@@ -104,7 +104,11 @@ if have_block<br>
=C2=A0 =C2=A0util_ss.add(files(&#39;throttle.c&#39;))<br>
=C2=A0 =C2=A0util_ss.add(files(&#39;timed-average.c&#39;))<br>
=C2=A0 =C2=A0if config_host_data.get(&#39;CONFIG_INOTIFY1&#39;)<br>
-=C2=A0 =C2=A0 util_ss.add(files(&#39;filemonitor-inotify.c&#39;))<br>
+=C2=A0 =C2=A0 freebsd_dep =3D []<br>
+=C2=A0 =C2=A0 if host_os =3D=3D &#39;freebsd&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 freebsd_dep =3D inotify<br>
+=C2=A0 =C2=A0 endif<br>
+=C2=A0 =C2=A0 util_ss.add(files(&#39;filemonitor-inotify.c&#39;), freebsd_=
dep)<br>
=C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0util_ss.add(files(&#39;filemonitor-stub.c&#39;))<br>
=C2=A0 =C2=A0endif<br>
-- <br>
2.39.2<br>
<br>
</blockquote></div></div>

--000000000000848efc0610d0213b--

