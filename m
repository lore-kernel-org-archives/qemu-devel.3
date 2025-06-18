Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0773C71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 09:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRp6V-0003O7-QO; Wed, 18 Jun 2025 05:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uRp6T-0003Nv-J5
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 05:29:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uRp6L-00008Q-Ls
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 05:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750238939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7n1zWtfpue7IIpmzwuLkqlzLkSSoe7c5lR1D+TGtRxk=;
 b=SB37EJd3aX802WWBIUSiMAwx3/1cV/baQx6SQS+29AmVdIQC0PoWXYBAi2b8/AL18Wt/bn
 yRLf5mPxovjH5bBPFH8pRD2gjiRLmal02RyjFRtbQiY9o9j1IdgkLmK0w+UcqH8Wv2wxh2
 AzKjAYxpsYe51SYzqngYe6BGc0iWqW0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-7DD5FnqIP5el8Psh84oMsw-1; Wed, 18 Jun 2025 05:28:57 -0400
X-MC-Unique: 7DD5FnqIP5el8Psh84oMsw-1
X-Mimecast-MFC-AGG-ID: 7DD5FnqIP5el8Psh84oMsw_1750238936
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6fad2a25b65so112861746d6.3
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 02:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750238936; x=1750843736;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7n1zWtfpue7IIpmzwuLkqlzLkSSoe7c5lR1D+TGtRxk=;
 b=QVr9akPG3ycvrOgitWDvtorB7UxjdIDkn+uc1bu7FmVy0qKluiI4ayPO+E9geadOrC
 z1Viuv+yrv4IgXUp/xGTb+aSqfSvWDmBuJi1652KqLFS2pGjpIdN3xtUKMrxfBAS7mqV
 yqi81OETk4X+miq5hs/bUUKCWsBUSUVRAVjiuZhqfKoLT9z9xWhzUIiMtkgzEfRLgiBk
 d68gyP2KFBXOLdef1aZoql1q7O/6ASAhZjeTn5w/w/yA7HwCd6oh10aKae3mg3kphfbw
 SW2sqmXf/6ne2RRrEcfr8H1mQN17xrTBp41GS2vw6knfUV8Sk37AKPHieIL8SuC5ZQur
 1MAg==
X-Gm-Message-State: AOJu0YzVYLHTKLg/PNimx1rWHWm+X9T36gY3wI8ILYyvQO3NcSJiByfS
 0AkJPlYas4nNWxO5TEVMHNbq5UNkcapMhaAXHrlh2Z1YPQ//1q1kM6748s3LvKQ/UILs42e2QLA
 Tb3I3wv7OQDSybjGRhilwB4GQzbkp0hIjacqgvSspv19nYbQxo1GjZM7MS5hVK/IUbtxHDXdl6U
 tgoQ1LFuWhXE/Z0xd6yv3lXbyI3Gc9KPI=
X-Gm-Gg: ASbGncu+R12Za2/X1zcYppVpMZKB3M4q0yg8AXiY1dTRoiZ2Imo7ycjTC38Vy2kOVU1
 ScXracnJVSPW1R+0qV7pjOZlrVg5pK69BQp6Hpawgnl6d3F/M/iM1OtXMDtt+6w5X3HY5J8EXm/
 kF14Bbmg==
X-Received: by 2002:ad4:5d6f:0:b0:6fa:d8bb:294c with SMTP id
 6a1803df08f44-6fb47726e99mr244564796d6.14.1750238936680; 
 Wed, 18 Jun 2025 02:28:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrz8JVihBtKp8l/+5DJKQFiMFlrmzIaAlS/6s2qYYfu0dygmlSb2+H+nkj0tRX3agn/b4fQkG+fmqRjPOkZiQ=
X-Received: by 2002:ad4:5d6f:0:b0:6fa:d8bb:294c with SMTP id
 6a1803df08f44-6fb47726e99mr244564636d6.14.1750238936444; Wed, 18 Jun 2025
 02:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250618091806.170110-1-eashurov@redhat.com>
In-Reply-To: <20250618091806.170110-1-eashurov@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Wed, 18 Jun 2025 12:28:45 +0300
X-Gm-Features: Ac12FXwP2D3oJyPjPhKDbwM27GdopkLapCheeAXFJqW_6AcOxJTCuPiHQScxwGA
Message-ID: <CAPMcbCrHRGU9JVBRU+j5Lprr93K3gQxgvW0xNZxWMuze8xKdhA@mail.gmail.com>
Subject: Re: [PATCH v2] qga/vss-win32: Add VSS provider unregistration retry
To: Elizabeth Ashurov <eashurov@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000144a560637d5427b"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000144a560637d5427b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Wed, Jun 18, 2025 at 12:18=E2=80=AFPM Elizabeth Ashurov <eashurov@redhat=
.com>
wrote:

> This commit improves the QGA VSS provider installation flow by attempting
> to unregister the VSS provider if it's already
> found during installation. This allows for a retry of installation even i=
f
> a previous unregistration failed or was not performed.
> This will prevent inconsistencies between QGA and QGA-VSS versions.
> Before this commit, QGA can use QGA-VSS from the previous installation.
>
> Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
> ---
>  qga/vss-win32/install.cpp | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> index 5cea5bcf74..9fe0dfc384 100644
> --- a/qga/vss-win32/install.cpp
> +++ b/qga/vss-win32/install.cpp
> @@ -287,9 +287,13 @@ STDAPI COMRegister(void)
>
>      chk(QGAProviderFind(QGAProviderCount, (void *)&count));
>      if (count) {
> -        errmsg(E_ABORT, "QGA VSS Provider is already installed");
> -        qga_debug_end;
> -        return E_ABORT;
> +        qga_debug("QGA VSS Provider is already installed. Attempting to
> unregister first.");
> +        hr =3D COMUnregister();
> +        if (FAILED(hr)) {
> +            errmsg(hr, "Failed to unregister existing QGA VSS Provider.
> Aborting installation.");
> +            qga_debug_end;
> +            return E_ABORT;
> +        }
>      }
>
>      chk(CoCreateInstance(CLSID_COMAdminCatalog, NULL,
> CLSCTX_INPROC_SERVER,
> --
> 2.49.0
>
>

--000000000000144a560637d5427b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, J=
un 18, 2025 at 12:18=E2=80=AFPM Elizabeth Ashurov &lt;<a href=3D"mailto:eas=
hurov@redhat.com">eashurov@redhat.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">This commit improves the QGA VSS provi=
der installation flow by attempting to unregister the VSS provider if it&#3=
9;s already<br>
found during installation. This allows for a retry of installation even if =
a previous unregistration failed or was not performed.<br>
This will prevent inconsistencies between QGA and QGA-VSS versions.<br>
Before this commit, QGA can use QGA-VSS from the previous installation.<br>
<br>
Signed-off-by: Elizabeth Ashurov &lt;<a href=3D"mailto:eashurov@redhat.com"=
 target=3D"_blank">eashurov@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/vss-win32/install.cpp | 10 +++++++---<br>
=C2=A01 file changed, 7 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp<br>
index 5cea5bcf74..9fe0dfc384 100644<br>
--- a/qga/vss-win32/install.cpp<br>
+++ b/qga/vss-win32/install.cpp<br>
@@ -287,9 +287,13 @@ STDAPI COMRegister(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0chk(QGAProviderFind(QGAProviderCount, (void *)&amp;coun=
t));<br>
=C2=A0 =C2=A0 =C2=A0if (count) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 errmsg(E_ABORT, &quot;QGA VSS Provider is alre=
ady installed&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qga_debug_end;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return E_ABORT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qga_debug(&quot;QGA VSS Provider is already in=
stalled. Attempting to unregister first.&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hr =3D COMUnregister();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (FAILED(hr)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errmsg(hr, &quot;Failed to unreg=
ister existing QGA VSS Provider. Aborting installation.&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qga_debug_end;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return E_ABORT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0chk(CoCreateInstance(CLSID_COMAdminCatalog, NULL, CLSCT=
X_INPROC_SERVER,<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div>

--000000000000144a560637d5427b--


