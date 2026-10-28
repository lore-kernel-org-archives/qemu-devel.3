Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE8D606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bzSE85UU;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kfEpOkOT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLzV8-0007U4-Gh; Wed, 28 Oct 2026 04:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xLzV6-0007SW-NK
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 04:59:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xLzV4-0002mX-Qq
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 04:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793177953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wWpXYPPO30PaZcroQkr2VKF9/A3AwaF5AHG6wSn6di0=;
 b=bzSE85UUbcl9sId16xofxqQHH+1RYEM/TGg5pmivqfTZJRrbjrHZPeYWocMrfM7mfyI2Pu
 dZcyjCisKJueHTzHxZM2cLDCuFrBw5frzsGl58Ag68l4QtM3u51YEpUetfX/4Knhi0gkks
 +CmcqozJPPp+iB+MkPenfDMsY4kLEZ4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-mSje6eSAP26joV3HDBh6rw-1; Wed, 28 Oct 2026 04:59:12 -0400
X-MC-Unique: mSje6eSAP26joV3HDBh6rw-1
X-Mimecast-MFC-AGG-ID: mSje6eSAP26joV3HDBh6rw_1793177951
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91c70349f65so17342316d6.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 01:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793177951; cv=none;
 d=google.com; s=arc-20260327;
 b=AN63o8abU2mE+OcE+bPMfsE7Bv5M3BrKaTLdRuzZK7tRGIarZ7yd7YkFpxNjLAkRfZ
 wIJwj2yDy0U1zm8jcPcOuk9jd1vGYRoPFqWbQs5xEfcSDZWYAoUN/0odoFEnntZ4EqHs
 vg/bz3Heba04ReyvCt44gWocXyA+l4o/Q9HsepUgtybBo5BEfTk2S97EO2whjntfKQaV
 ZTyF+ImbYLsWvMraGSZPr/adpD/gHW1wJqtEezR80snzf0Gj13k6rzotRWQK/Bcu/WUA
 eiaPaNGTXRFb4m1Ahf42XBUOOVnVOgZDN5BVTsuvZ/sQL+/a240chC7KL8u29O8id116
 5Qsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wWpXYPPO30PaZcroQkr2VKF9/A3AwaF5AHG6wSn6di0=;
 fh=lJ3l5h8sU9OcQSbaOuYA9KlOiaqQMCXiQDGuHTun508=;
 b=Tsr89jXEIFJ7Sq008UIipSqSmD735zDnZFCDIWTu9F0qHMbFLwKimgkmmJS7fsDlSO
 j4OFTGxqWikZRVYa4OofMLtusrdm8scs7X2vmOiy4Luy9Xbj0V4DlD5jRwi0rhrBxanG
 4yoolWNF1qwMXoOXCsKOdv0+qfxOFn9KZ7IqRm7BxEsNhedtlNkojJxkyZo8iKtPNTO0
 yPeF3/TTXWyqj25IGjW+VxfFIBDP/yS98kHKSb+idxc7bTHatFIXTOxMAkbpDT/9z13/
 6pVUHiwl4WtQIugep6qOqU7Es3tSyrPfWMn7yy7PfM/EUfFjZFlTyI2HzgY2Xksb01+e
 hIhQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793177951; x=1793782751; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wWpXYPPO30PaZcroQkr2VKF9/A3AwaF5AHG6wSn6di0=;
 b=kfEpOkOTbRHXK4xGp5FlypjPtmNV0RbUFzeOJxi3hfYHjgJ8iffiixS1xU2371cEXb
 T0M984EeWHKaImF8Rv8OdJMChYYekGa1XyPv8Xa2/yEWKBxeScbPkozSdEhohjGMzL8I
 5B9iC8gDUx5GXkw2y1wFoJH6WSURjIku68c5oYj/+NKlxmncwy2Uxvs+/lWZaivvkwGl
 WmH0O4NMletIEurnDL5/E21GsBH+ux+I3q8MWHJwfcAHRIRghuA8WEw4T1wsAac3tXp8
 aRQuuK3CZBILBW4oMfAV3ZhNMJX4DgZsWIG5mRb6ccMLGO8MJ1WTmKcsqiKCUSyIVOll
 fzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793177951; x=1793782751;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wWpXYPPO30PaZcroQkr2VKF9/A3AwaF5AHG6wSn6di0=;
 b=q+oXiZsl0GPQe17T7BMOFHb7ykH7WLp3pjLpq6pyCmBiK5eTMGZpcvdWbmS7iAzS7m
 mgTcPFQe9GfbTioMWxrGj8EyM1fZTrdvJxfBl5mp81Kc+MaTPYEgmfIMU1CpLRDEbvPA
 icE5cAZ2nKjKcZpCejyV32zDV//OXSNPIxmubPjNwvf0jXIlTSTjYe9oXpa7f7B0BPCl
 hz56N9Mt2q6L0yEX9BHk+T79rwpXk/NqE1g1e0XVoVpX5+hqGNXLHDaHzhBQNKTrncP4
 E07GRLWa9TZtkhVpwttbLAPc2X2oOd0vqvOZ+pKxFHbWdVFPLDJOKZrWmUpFnjndwSdj
 FvOw==
X-Gm-Message-State: AFq9FYI+xdRw1Zi1wvs/GtizWtvE+VK1LpoZeuFkmY51YfQTwn8MkvFE
 e3aW9RWZ8DpNPF/+7VwVLKlynozhyGTg3jo+MMe23bMLD32jLqqpq2pFhoaMtrfJMDo+GQidjXE
 UpUeXH0gaUJqTYrataaGXxhlHaDwA7XAn3mUSN6YAjkV9DQZCgXIQB4SV++2zQNGmSw7z/RiMBW
 0/q+CJs1Obyqsoi4Uz8ZQXXShv+tHxA2Q=
X-Gm-Gg: AYBFou1afkY84a/9NxtvXf4yQYCG4FhrSlKNtA+jPsc2GmRQBrrP532px5s5il3//y9
 pt8WAk8W/7y9aj5T/gOjKlvuWbje/UfPxGEhrF3ueOHy8yQ1geUF0rWrtw3dSCwkgXMLMWNBkn0
 1gSfRq+2qM6FKOkonm1l5X6AYOL+2n5KY0IpyBFTqPZIFJ7PQG214klJkHBYaUhFQn9DJs+Y7cX
 ixiu8ocHQ5kiLHWB5Y=
X-Received: by 2002:a05:6214:8617:b0:91c:711c:27f3 with SMTP id
 6a1803df08f44-91c7cf4a0eemr25987736d6.21.1793177951364; 
 Wed, 28 Oct 2026 01:59:11 -0700 (PDT)
X-Received: by 2002:a05:6214:8617:b0:91c:711c:27f3 with SMTP id
 6a1803df08f44-91c7cf4a0eemr25987546d6.21.1793177950923; Wed, 28 Oct 2026
 01:59:10 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015173250.65942-1-bogorodskiy@gmail.com>
 <20261015173250.65942-2-bogorodskiy@gmail.com>
In-Reply-To: <20261015173250.65942-2-bogorodskiy@gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Wed, 28 Oct 2026 10:58:59 +0200
X-Gm-Features: AclHuK9YDcPvjRkwZ7tCWk2Kl27czJlklP3WZhYbSRw-TVsBY3AicrjFRrjoynY
Message-ID: <CAPMcbCos82eavn8oci6O+T+Qbw6Vt8UWPezwA0Fc9KDN1CLX0w@mail.gmail.com>
Subject: Re: [PATCH 1/2] qga: fix build on illumos
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 michael.roth@amd.com
Content-Type: multipart/alternative; boundary="000000000000c8bffb065ee2c6a2"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000c8bffb065ee2c6a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 8:33=E2=80=AFPM Roman Bogorodskiy <bogorodskiy@gmai=
l.com>
wrote:

> Currently, build fails on illumos with:
>
> ../qga/commands-posix.c: In function 'qmp_guest_get_load':
> ../qga/commands-posix.c:1408:9: error: implicit declaration of function
> 'getloadavg' [-Wimplicit-function-declaration]
>  1408 |     if (getloadavg(loadavg, G_N_ELEMENTS(loadavg)) < 0) {
>       |         ^~~~~~~~~~
> ../qga/commands-posix.c:1408:9: warning: nested extern declaration of
> 'getloadavg' [-Wnested-externs]
>
> This happens because including <sys/loadavg.h> which is needed
> for getloadavg() on illumos is nested under the "#ifdef HAVE_GETIFADDRS"
> block, and is not included when HAVE_GETIFADDRS is not defined.
>
> As getloadavg() does not depend on HAVE_GETIFADDRS, include
> <sys/loadavg.h> outside of the "#ifdef HAVE_GETIFADDRS".
>
> Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> ---
>  qga/commands-posix.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 837e285b6d..f58169b43e 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -16,6 +16,9 @@
>  #include <sys/utsname.h>
>  #include <sys/wait.h>
>  #include <dirent.h>
> +#if defined(CONFIG_SOLARIS) && defined(CONFIG_GETLOADAVG)
> +#include <sys/loadavg.h>
> +#endif
>  #include "qga-qapi-commands.h"
>  #include "qapi/error.h"
>  #include "qemu/host-utils.h"
> @@ -43,9 +46,6 @@
>  #include <net/ethernet.h>
>  #endif
>  #ifdef CONFIG_SOLARIS
> -#ifdef CONFIG_GETLOADAVG
> -#include <sys/loadavg.h>
> -#endif
>

What is the difference?

Before commit we check CONFIG_GETLOADAVG inside CONFIG_SOLARIS, so
this is definitly the same that you change CONFIG_GETLOADAVG
&& CONFIG_SOLARIS


Best Regards,
Kostiantyn Kostiuk.



>  #include <sys/sockio.h>
>  #endif
>  #endif
> --
> 2.55.0
>
>

--000000000000c8bffb065ee2c6a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 15,=
 2026 at 8:33=E2=80=AFPM Roman Bogorodskiy &lt;<a href=3D"mailto:bogorodski=
y@gmail.com">bogorodskiy@gmail.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">Currently, build fails on illumos with:<b=
r>
<br>
../qga/commands-posix.c: In function &#39;qmp_guest_get_load&#39;:<br>
../qga/commands-posix.c:1408:9: error: implicit declaration of function &#3=
9;getloadavg&#39; [-Wimplicit-function-declaration]<br>
=C2=A01408 |=C2=A0 =C2=A0 =C2=A0if (getloadavg(loadavg, G_N_ELEMENTS(loadav=
g)) &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~<br>
../qga/commands-posix.c:1408:9: warning: nested extern declaration of &#39;=
getloadavg&#39; [-Wnested-externs]<br>
<br>
This happens because including &lt;sys/loadavg.h&gt; which is needed<br>
for getloadavg() on illumos is nested under the &quot;#ifdef HAVE_GETIFADDR=
S&quot;<br>
block, and is not included when HAVE_GETIFADDRS is not defined.<br>
<br>
As getloadavg() does not depend on HAVE_GETIFADDRS, include<br>
&lt;sys/loadavg.h&gt; outside of the &quot;#ifdef HAVE_GETIFADDRS&quot;.<br=
>
<br>
Signed-off-by: Roman Bogorodskiy &lt;<a href=3D"mailto:bogorodskiy@gmail.co=
m" target=3D"_blank">bogorodskiy@gmail.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-posix.c | 6 +++---<br>
=C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 837e285b6d..f58169b43e 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -16,6 +16,9 @@<br>
=C2=A0#include &lt;sys/utsname.h&gt;<br>
=C2=A0#include &lt;sys/wait.h&gt;<br>
=C2=A0#include &lt;dirent.h&gt;<br>
+#if defined(CONFIG_SOLARIS) &amp;&amp; defined(CONFIG_GETLOADAVG)<br>
+#include &lt;sys/loadavg.h&gt;<br>
+#endif<br>
=C2=A0#include &quot;qga-qapi-commands.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;qemu/host-utils.h&quot;<br>
@@ -43,9 +46,6 @@<br>
=C2=A0#include &lt;net/ethernet.h&gt;<br>
=C2=A0#endif<br>
=C2=A0#ifdef CONFIG_SOLARIS<br>
-#ifdef CONFIG_GETLOADAVG<br>
-#include &lt;sys/loadavg.h&gt;<br>
-#endif<br></blockquote><div><br></div><div>What is the difference?=C2=A0<b=
r><br></div><div>Before commit we check=C2=A0CONFIG_GETLOADAVG inside=C2=A0=
CONFIG_SOLARIS, so</div><div>this is definitly the same that you change=C2=
=A0CONFIG_GETLOADAVG &amp;&amp;=C2=A0CONFIG_SOLARIS</div><div><br></div><di=
v><div><br clear=3D"all"></div><div><div dir=3D"ltr" class=3D"gmail_signatu=
re"><div dir=3D"ltr"><div>Best Regards,</div><div>Kostiantyn Kostiuk.</div>=
</div></div></div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
=C2=A0#include &lt;sys/sockio.h&gt;<br>
=C2=A0#endif<br>
=C2=A0#endif<br>
-- <br>
2.55.0<br>
<br>
</blockquote></div></div>

--000000000000c8bffb065ee2c6a2--


