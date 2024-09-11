Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E60EE021C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 09:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soJZd-0003vj-76; Wed, 11 Sep 2024 05:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lwhsu@freebsd.org>) id 1soJZb-0003u4-M9
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:23:39 -0400
Received: from mx2.freebsd.org ([96.47.72.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lwhsu@freebsd.org>) id 1soJZX-0004T9-QC
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:23:38 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4X3Zr40YQZz3hCW
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 09:23:32 +0000 (UTC)
 (envelope-from lwhsu@freebsd.org)
Received: from smtp.freebsd.org (smtp.freebsd.org
 [IPv6:2610:1c1:1:606c::24b:4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R10" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4X3Zr34Xk8z4Fw6
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 09:23:31 +0000 (UTC)
 (envelope-from lwhsu@freebsd.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1726046611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a6Wrw4m2ESemBFZ6jibwr1pn+SIAwSUGgu6UdJWaoMY=;
 b=v1sRG0xuPe1JWQK/2h/BFsN8N/ZDwBlWYgyB84n5fkjto3unbq9LqjtuVVxyJjlQtmGorU
 uX5Q7c1qBhZoaJA+deM6D3/Ss3vmCpYN6hSjyOjX7r36Oa2JR7VeXFb9XjsouR37j8d5mo
 lMzR2eVjjdd2RqWdpKNpwDFLnxScZ1BIGOrw/lb0gNpox8pHCmAufOa6isWF+AsMYTymXW
 +T3pgZu5YSsvZJSx4y+X3OErDRMqEjvaYAcTPm3boimKl3bdkUzW5nAke3J5C5FHBAGr4E
 Xpz9IfOfdrT6R5azInaEVYC5zymzRd/zN51ysIcoNiarotVDlx0pdkrErA5Uzg==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1726046611; a=rsa-sha256; cv=none;
 b=FwC4xEKp6HNYJCPM+WZyzELq/x9FaNaUFzQnmfpNcXUo1TRB7PP+JiQ/ran/LEykBTgkOa
 pR1XPdNgH24FpBbr7V7szeaqoYoSDAs244NgJltfFgxqtx7x+8JXUQnofyCzOjmeb3Bo4M
 OhxkXwF4htGf7kfhEvmqStp7ELBzK7+RTGPZSQRap+7JoMH5VVij4L7be3TXUYNh5cxCjz
 Z8ThOjXvzz/C1Snizea87XsJshZBJungXAcOWdKBhbV5QsnCL6Ey8Dl6cf78qC7tQ4eKrI
 2kFwnO/wparnzOzlPc837AqELRfpr1l6lFLDTZ24VIjh1AZbjzjZqC2CWO4PeA==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1726046611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a6Wrw4m2ESemBFZ6jibwr1pn+SIAwSUGgu6UdJWaoMY=;
 b=LKaVkMe8mDLISe5eV603de7ZOTd/znO5o71i9Ny+uavtRpy4ubN13ehXkokNRKb8ydIDzs
 1n7LMhdvRKLIJHCHcbGZYxiUxMDjQ4hfrQq26JI2mZmTL2rfb5seRgNxymFJg3Qh3NMJXL
 5B5hR/v2qzgJE+1bt5qltpLvu1fv8F/UDr0YwgOgkiTmZxntbm09EVHmR6cLuLtxXnb4XQ
 p4XXzPTApGHRf9oIyVj/7VVrRuoPad+vsg8HnDtSKZFAKQIDEfbuRbuPQY0t1uqI0i8T/P
 4B44hQe87WJJxFPgvZ5G/Cv6Okvz2HMtvqApMPOknwjkNHVYbowXrTrsQAzVuw==
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "smtp.gmail.com", Issuer "WR4" (verified OK))
 (Authenticated sender: lwhsu/mail)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4X3Zr340frz16NS
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 09:23:31 +0000 (UTC)
 (envelope-from lwhsu@freebsd.org)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-710d77380cdso2366621a34.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 02:23:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YxIs/v6MGXDkwwKwkemmcWEyxtWTFS+1AaVA/FUMr86aqWHl+X7
 sJyrPQH3fVJSYtxS3d0GdMJyb5fQji+XGc83tW+fURF2OBfXWt6c+uK7gDjsCBvqa5/H4WJNJXY
 rTA3I1AXEzI0RFGq1rvcDfrDNaVw=
X-Google-Smtp-Source: AGHT+IFalpGmx6eSR4jPrl9dIMFNNvy5WpcsAQDTOliFZKEwNLpDwpKVUQqaDOqJD9AYXR2s0Uol4dooEMXmc//bMDQ=
X-Received: by 2002:a05:6830:380b:b0:710:f76b:350f with SMTP id
 46e09a7af769-710f76b361emr3024539a34.30.1726046610917; Wed, 11 Sep 2024
 02:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240911090149.286257-1-thuth@redhat.com>
In-Reply-To: <20240911090149.286257-1-thuth@redhat.com>
From: Li-Wen Hsu <lwhsu@freebsd.org>
Date: Wed, 11 Sep 2024 17:23:20 +0800
X-Gmail-Original-Message-ID: <CAKBkRUyW4USU0hkfcWHFOUno1QS=FMddCr5_apvvhxKHz73RVQ@mail.gmail.com>
Message-ID: <CAKBkRUyW4USU0hkfcWHFOUno1QS=FMddCr5_apvvhxKHz73RVQ@mail.gmail.com>
Subject: Re: [PATCH] Update FreeBSD CI jobs FreeBSD 14.1
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 Warner Losh <imp@bsdimp.com>, 
 Ed Maste <emaste@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000001c18600621d48b3b"
Received-SPF: pass client-ip=96.47.72.81; envelope-from=lwhsu@freebsd.org;
 helo=mx2.freebsd.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000001c18600621d48b3b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 5:02=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:

> The current FreeBSD CI jobs are failing installation since the
> "opencv" package is now missing there. Updating to 14.1 fixes
> the issue.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
>

Reviewed-by: Li-Wen Hsu <lwhsu@FreeBSD.org>


> ---
>  Here's the output of a successful run:
>  https://gitlab.com/thuth/qemu/-/jobs/7795460644
>
>  .gitlab-ci.d/cirrus.yml                                  | 6 +++---
>  .gitlab-ci.d/cirrus/{freebsd-13.vars =3D> freebsd-14.vars} | 2 +-
>  tests/lcitool/refresh                                    | 4 ++--
>  tests/vm/freebsd                                         | 6 +++---
>  4 files changed, 9 insertions(+), 9 deletions(-)
>  rename .gitlab-ci.d/cirrus/{freebsd-13.vars =3D> freebsd-14.vars} (95%)
>
> diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
> index 75df1273bc..92c97eefc1 100644
> --- a/.gitlab-ci.d/cirrus.yml
> +++ b/.gitlab-ci.d/cirrus.yml
> @@ -46,13 +46,13 @@
>    variables:
>      QEMU_JOB_CIRRUS: 1
>
> -x64-freebsd-13-build:
> +x64-freebsd-14-build:
>    extends: .cirrus_build_job
>    variables:
> -    NAME: freebsd-13
> +    NAME: freebsd-14
>      CIRRUS_VM_INSTANCE_TYPE: freebsd_instance
>      CIRRUS_VM_IMAGE_SELECTOR: image_family
> -    CIRRUS_VM_IMAGE_NAME: freebsd-13-3
> +    CIRRUS_VM_IMAGE_NAME: freebsd-14-1
>      CIRRUS_VM_CPUS: 8
>      CIRRUS_VM_RAM: 8G
>      UPDATE_COMMAND: pkg update; pkg upgrade -y
> diff --git a/.gitlab-ci.d/cirrus/freebsd-13.vars
> b/.gitlab-ci.d/cirrus/freebsd-14.vars
> similarity index 95%
> rename from .gitlab-ci.d/cirrus/freebsd-13.vars
> rename to .gitlab-ci.d/cirrus/freebsd-14.vars
> index 69c948b503..aba0eff4b9 100644
> --- a/.gitlab-ci.d/cirrus/freebsd-13.vars
> +++ b/.gitlab-ci.d/cirrus/freebsd-14.vars
> @@ -1,6 +1,6 @@
>  # THIS FILE WAS AUTO-GENERATED
>  #
> -#  $ lcitool variables freebsd-13 qemu
> +#  $ lcitool variables freebsd-14 qemu
>  #
>  # https://gitlab.com/libvirt/libvirt-ci
>
> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index ac803e34f1..290804f6be 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -207,14 +207,14 @@ try:
>      #
>      # Cirrus packages lists for GitLab
>      #
> -    generate_cirrus("freebsd-13")
> +    generate_cirrus("freebsd-14")
>      generate_cirrus("macos-13")
>      generate_cirrus("macos-14")
>
>      #
>      # VM packages lists
>      #
> -    generate_pkglist("freebsd", "freebsd-13")
> +    generate_pkglist("freebsd", "freebsd-14")
>
>      #
>      # Ansible package lists
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index 1247f40a38..74b3b1e520 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -28,8 +28,8 @@ class FreeBSDVM(basevm.BaseVM):
>      name =3D "freebsd"
>      arch =3D "x86_64"
>
> -    link =3D "
> https://download.freebsd.org/releases/CI-IMAGES/13.2-RELEASE/amd64/Latest=
/FreeBSD-13.2-RELEASE-amd64-BASIC-CI.raw.xz
> "
> -    csum =3D
> "a4fb3b6c7b75dd4d58fb0d75e4caf72844bffe0ca00e66459c028b198ffb3c0e"
> +    link =3D "
> https://download.freebsd.org/releases/CI-IMAGES/14.1-RELEASE/amd64/Latest=
/FreeBSD-14.1-RELEASE-amd64-BASIC-CI.raw.xz
> "
> +    csum =3D
> "202fe27a05427f0a86d3ebb97712745186f2776ccc4f70d95466dd99a0238ba5"
>      size =3D "20G"
>
>      BUILD_SCRIPT =3D """
> @@ -39,7 +39,7 @@ class FreeBSDVM(basevm.BaseVM):
>          mkdir src build; cd src;
>          tar -xf /dev/vtbd1;
>          cd ../build;
> -        ../src/configure --python=3Dpython3.9
> --extra-ldflags=3D-L/usr/local/lib \
> +        ../src/configure --extra-ldflags=3D-L/usr/local/lib \
>                           --extra-cflags=3D-I/usr/local/include
> {configure_opts};
>          gmake --output-sync -j{jobs} {target} {verbose};
>      """
> --
> 2.46.0
>
>

--0000000000001c18600621d48b3b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Wed, Sep 11, 2024 at 5:02=E2=80=AFPM Thomas Huth &lt;<a href=3D"m=
ailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">The current FreeBSD CI jobs are fai=
ling installation since the<br>
&quot;opencv&quot; package is now missing there. Updating to 14.1 fixes<br>
the issue.<br>
<br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank">thuth@redhat.com</a>&gt;<br></blockquote><div><br>Reviewed-by: =
Li-Wen Hsu &lt;lwhsu@FreeBSD.org&gt;<br></div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0Here&#39;s the output of a successful run:<br>
=C2=A0<a href=3D"https://gitlab.com/thuth/qemu/-/jobs/7795460644" rel=3D"no=
referrer" target=3D"_blank">https://gitlab.com/thuth/qemu/-/jobs/7795460644=
</a><br>
<br>
=C2=A0.gitlab-ci.d/cirrus.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 6 +++---<br>
=C2=A0.gitlab-ci.d/cirrus/{freebsd-13.vars =3D&gt; freebsd-14.vars} | 2 +-<=
br>
=C2=A0tests/lcitool/refresh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 4 ++--<br>
=C2=A0tests/vm/freebsd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 6 +++---<br>
=C2=A04 files changed, 9 insertions(+), 9 deletions(-)<br>
=C2=A0rename .gitlab-ci.d/cirrus/{freebsd-13.vars =3D&gt; freebsd-14.vars} =
(95%)<br>
<br>
diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml<br>
index 75df1273bc..92c97eefc1 100644<br>
--- a/.gitlab-ci.d/cirrus.yml<br>
+++ b/.gitlab-ci.d/cirrus.yml<br>
@@ -46,13 +46,13 @@<br>
=C2=A0 =C2=A0variables:<br>
=C2=A0 =C2=A0 =C2=A0QEMU_JOB_CIRRUS: 1<br>
<br>
-x64-freebsd-13-build:<br>
+x64-freebsd-14-build:<br>
=C2=A0 =C2=A0extends: .cirrus_build_job<br>
=C2=A0 =C2=A0variables:<br>
-=C2=A0 =C2=A0 NAME: freebsd-13<br>
+=C2=A0 =C2=A0 NAME: freebsd-14<br>
=C2=A0 =C2=A0 =C2=A0CIRRUS_VM_INSTANCE_TYPE: freebsd_instance<br>
=C2=A0 =C2=A0 =C2=A0CIRRUS_VM_IMAGE_SELECTOR: image_family<br>
-=C2=A0 =C2=A0 CIRRUS_VM_IMAGE_NAME: freebsd-13-3<br>
+=C2=A0 =C2=A0 CIRRUS_VM_IMAGE_NAME: freebsd-14-1<br>
=C2=A0 =C2=A0 =C2=A0CIRRUS_VM_CPUS: 8<br>
=C2=A0 =C2=A0 =C2=A0CIRRUS_VM_RAM: 8G<br>
=C2=A0 =C2=A0 =C2=A0UPDATE_COMMAND: pkg update; pkg upgrade -y<br>
diff --git a/.gitlab-ci.d/cirrus/freebsd-13.vars b/.gitlab-ci.d/cirrus/free=
bsd-14.vars<br>
similarity index 95%<br>
rename from .gitlab-ci.d/cirrus/freebsd-13.vars<br>
rename to .gitlab-ci.d/cirrus/freebsd-14.vars<br>
index 69c948b503..aba0eff4b9 100644<br>
--- a/.gitlab-ci.d/cirrus/freebsd-13.vars<br>
+++ b/.gitlab-ci.d/cirrus/freebsd-14.vars<br>
@@ -1,6 +1,6 @@<br>
=C2=A0# THIS FILE WAS AUTO-GENERATED<br>
=C2=A0#<br>
-#=C2=A0 $ lcitool variables freebsd-13 qemu<br>
+#=C2=A0 $ lcitool variables freebsd-14 qemu<br>
=C2=A0#<br>
=C2=A0# <a href=3D"https://gitlab.com/libvirt/libvirt-ci" rel=3D"noreferrer=
" target=3D"_blank">https://gitlab.com/libvirt/libvirt-ci</a><br>
<br>
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh<br>
index ac803e34f1..290804f6be 100755<br>
--- a/tests/lcitool/refresh<br>
+++ b/tests/lcitool/refresh<br>
@@ -207,14 +207,14 @@ try:<br>
=C2=A0 =C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0 =C2=A0# Cirrus packages lists for GitLab<br>
=C2=A0 =C2=A0 =C2=A0#<br>
-=C2=A0 =C2=A0 generate_cirrus(&quot;freebsd-13&quot;)<br>
+=C2=A0 =C2=A0 generate_cirrus(&quot;freebsd-14&quot;)<br>
=C2=A0 =C2=A0 =C2=A0generate_cirrus(&quot;macos-13&quot;)<br>
=C2=A0 =C2=A0 =C2=A0generate_cirrus(&quot;macos-14&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0 =C2=A0# VM packages lists<br>
=C2=A0 =C2=A0 =C2=A0#<br>
-=C2=A0 =C2=A0 generate_pkglist(&quot;freebsd&quot;, &quot;freebsd-13&quot;=
)<br>
+=C2=A0 =C2=A0 generate_pkglist(&quot;freebsd&quot;, &quot;freebsd-14&quot;=
)<br>
<br>
=C2=A0 =C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0 =C2=A0# Ansible package lists<br>
diff --git a/tests/vm/freebsd b/tests/vm/freebsd<br>
index 1247f40a38..74b3b1e520 100755<br>
--- a/tests/vm/freebsd<br>
+++ b/tests/vm/freebsd<br>
@@ -28,8 +28,8 @@ class FreeBSDVM(basevm.BaseVM):<br>
=C2=A0 =C2=A0 =C2=A0name =3D &quot;freebsd&quot;<br>
=C2=A0 =C2=A0 =C2=A0arch =3D &quot;x86_64&quot;<br>
<br>
-=C2=A0 =C2=A0 link =3D &quot;<a href=3D"https://download.freebsd.org/relea=
ses/CI-IMAGES/13.2-RELEASE/amd64/Latest/FreeBSD-13.2-RELEASE-amd64-BASIC-CI=
.raw.xz" rel=3D"noreferrer" target=3D"_blank">https://download.freebsd.org/=
releases/CI-IMAGES/13.2-RELEASE/amd64/Latest/FreeBSD-13.2-RELEASE-amd64-BAS=
IC-CI.raw.xz</a>&quot;<br>
-=C2=A0 =C2=A0 csum =3D &quot;a4fb3b6c7b75dd4d58fb0d75e4caf72844bffe0ca00e6=
6459c028b198ffb3c0e&quot;<br>
+=C2=A0 =C2=A0 link =3D &quot;<a href=3D"https://download.freebsd.org/relea=
ses/CI-IMAGES/14.1-RELEASE/amd64/Latest/FreeBSD-14.1-RELEASE-amd64-BASIC-CI=
.raw.xz" rel=3D"noreferrer" target=3D"_blank">https://download.freebsd.org/=
releases/CI-IMAGES/14.1-RELEASE/amd64/Latest/FreeBSD-14.1-RELEASE-amd64-BAS=
IC-CI.raw.xz</a>&quot;<br>
+=C2=A0 =C2=A0 csum =3D &quot;202fe27a05427f0a86d3ebb97712745186f2776ccc4f7=
0d95466dd99a0238ba5&quot;<br>
=C2=A0 =C2=A0 =C2=A0size =3D &quot;20G&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0BUILD_SCRIPT =3D &quot;&quot;&quot;<br>
@@ -39,7 +39,7 @@ class FreeBSDVM(basevm.BaseVM):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mkdir src build; cd src;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tar -xf /dev/vtbd1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cd ../build;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ../src/configure --python=3Dpython3.9=C2=A0 --=
extra-ldflags=3D-L/usr/local/lib \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ../src/configure --extra-ldflags=3D-L/usr/loca=
l/lib \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 --extra-cflags=3D-I/usr/local/include {configure_opts};<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gmake --output-sync -j{jobs} {target} {ve=
rbose};<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-- <br>
2.46.0<br>
<br>
</blockquote></div></div>

--0000000000001c18600621d48b3b--

