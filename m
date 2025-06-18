Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65132C7115B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 08:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRo5n-0008L9-OX; Wed, 18 Jun 2025 04:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uRo5i-0008KH-GA
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 04:24:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uRo5g-0005xR-0q
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 04:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750235049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XOd/TwSeFf3sn9dmgp438m1OZfBUEXiJMJgYzBxE9cs=;
 b=QLvJjlC92/s6LtEYtvYq1EQkt7CYVV9z99dcsU/+TSxmz/ZLWr56ZOTGE+hX+70ITO4Iik
 As/3f8/IfC2rXO586BP4eraKk49ihiGyMyoS4W1NDohiQBUUTexcIgJhPw5vjhV3aj+nEs
 wM3zEkqDjzdlgT6Ob2Tjb/Mp2xDV+20=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-G-iAP0DNP3mFo3VyOoX2uw-1; Wed, 18 Jun 2025 04:24:04 -0400
X-MC-Unique: G-iAP0DNP3mFo3VyOoX2uw-1
X-Mimecast-MFC-AGG-ID: G-iAP0DNP3mFo3VyOoX2uw_1750235044
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6fb32203ca6so143544196d6.3
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 01:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750235043; x=1750839843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XOd/TwSeFf3sn9dmgp438m1OZfBUEXiJMJgYzBxE9cs=;
 b=ifYlOWg45Fn0DYPPEYMIVBfiBx+8D/ePXwfEF1M5afZdLGlypl1/TFIjTzFpwgTUlg
 6uEwRM0whUYEEUtOSh3BvWCWxcXQMrhuFqPk/ce2Nr7bmeSBMACFWi9UYBpszEVduAre
 OhJapqq4SFoiWp9a3nIQz23BIMAKqpIM1ihUY4N+VIpoIYqNDuzIuwheosOAIPz0vusF
 XyAPh6K68LlmEnt9zKfbBs43KS7Ofmg9LLk2huvFvX1blYzvxK3wH1lE3AgYGzthdOtA
 NDRvmKmD9GPVvNKCp+uYc/JWNRNrgWuNCzWJ6VU0z6hvEWjjMHRpZdi50r2+li7OSujl
 Z9fw==
X-Gm-Message-State: AOJu0YyX1ivYoIwrAGrjHrFhm2HZwxQgwS18eYD4IlB5Qp1pXAosuknG
 SJtkVtEJq5g7GNLM20MYRC2c82kfK1TU5xOe9afVr3hhyVgNXB3mn/hv9rR/qrCX0xW3vTZnoIy
 ukLibsS3qr825tYOzm9NwxyLYPrmPHcp2GmoSnrgZCX0br3S3hDkR7hqrVd3Nw1GZyK26t6eLEy
 aToL39ebxIrQeFuo+6sMPbPGRYK3Cuqgo=
X-Gm-Gg: ASbGncufef3TqJolFc/H8lYznHSLiIILuZkrYacEs1lNuVV+Gb0IjZwVcmoyCHIFnEW
 /FfNCzn1w6XJr7Ri8xpPO19LkUjVbkXXo86FF5jw0eg3lo8kKw5aKnHIJT/coiJxfb0SmPwBlqI
 SVFoKZfQ==
X-Received: by 2002:a05:6214:485:b0:6fa:c166:d8b9 with SMTP id
 6a1803df08f44-6fb47773332mr237124896d6.2.1750235043676; 
 Wed, 18 Jun 2025 01:24:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9RSySQkWj3M/dahViG5Yq8tRNFP7oHvJC102e0mYJUCmRNiRzNUdyllZyxX0YHL21CNOxoWnWddivo7U4+5M=
X-Received: by 2002:a05:6214:485:b0:6fa:c166:d8b9 with SMTP id
 6a1803df08f44-6fb47773332mr237124756d6.2.1750235043418; Wed, 18 Jun 2025
 01:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250617174733.156349-1-eashurov@redhat.com>
In-Reply-To: <20250617174733.156349-1-eashurov@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Wed, 18 Jun 2025 11:23:52 +0300
X-Gm-Features: Ac12FXzIF8piB2BqUJql_PoQGJBdjq1X5VHTo-AbJgbq1Z_GgC5NW_JobpTy2os
Message-ID: <CAPMcbCrW6XzVUYOoBnxZC4E3Ma7FZtKGOwWwKZ6A0_Hd4jJmQg@mail.gmail.com>
Subject: Re: [PATCH] qga/vss-win32: Add VSS provider unregistration retry
To: Elizabeth Ashurov <eashurov@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000000969050637d45adb"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
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

--0000000000000969050637d45adb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Best Regards,
Konstantin Kostiuk.


On Tue, Jun 17, 2025 at 8:47=E2=80=AFPM Elizabeth Ashurov <eashurov@redhat.=
com>
wrote:

> This commit improves the QGA VSS provider installation flow
> by attempting to unregister the VSS provider if it's already
> found during installation. This allows for a retry of installation
> even if a previous unregistration failed or was not performed.
>

Please add:
This will prevent inconsistencies between QGA and QGA-VSS versions.
Before this commit, QGA can use QGA-VSS from the previous installation.


>
> Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
> ---
>  qga/vss-win32/install.cpp | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> index 5cea5bcf74..a136d46050 100644
> --- a/qga/vss-win32/install.cpp
> +++ b/qga/vss-win32/install.cpp
> @@ -263,6 +263,7 @@ STDAPI COMRegister(void)
>      qga_debug_begin;
>
>      HRESULT hr;
> +    HRESULT unregisterHr;
>
extra HRESULT is redundant; you can reuse existing one


>      COMInitializer initializer;
>      COMPointer<IUnknown> pUnknown;
>      COMPointer<ICOMAdminCatalog2> pCatalog;
> @@ -287,9 +288,13 @@ STDAPI COMRegister(void)
>
>      chk(QGAProviderFind(QGAProviderCount, (void *)&count));
>      if (count) {
> -        errmsg(E_ABORT, "QGA VSS Provider is already installed");
> -        qga_debug_end;
> -        return E_ABORT;
> +        qga_debug("QGA VSS Provider is already installed. Attempting to
> unregister first.");
> +        unregisterHr =3D COMUnregister();
> +        if (FAILED(unregisterHr)) {
> +            errmsg(unregisterHr, "Failed to unregister existing QGA VSS
> Provider. Aborting installation.");
> +            qga_debug_end;
> +            return E_ABORT;
>

.git/rebase-apply/patch:29: trailing whitespace.
            return E_ABORT;
warning: 1 line adds whitespace errors.
please fix

> +        }
>      }
>
>      chk(CoCreateInstance(CLSID_COMAdminCatalog, NULL,
> CLSCTX_INPROC_SERVER,
> --
> 2.49.0
>
>

--0000000000000969050637d45adb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br clear=3D"all"></div><div><div di=
r=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</di=
v><div>Konstantin Kostiuk.</div></div></div></div><br></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Tue, Jun 17, 2025 at 8:47=E2=80=AFPM Elizabeth Ashurov &lt;<a href=3D"=
mailto:eashurov@redhat.com">eashurov@redhat.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">This commit improves the QGA=
 VSS provider installation flow<br>
by attempting to unregister the VSS provider if it&#39;s already<br>
found during installation. This allows for a retry of installation<br>
even if a previous unregistration failed or was not performed.<br></blockqu=
ote><div><br></div><div>Please add:<br></div><div>This will prevent inconsi=
stencies between QGA and QGA-VSS versions.</div><div>Before this commit, QG=
A can use QGA-VSS from the previous installation.<br></div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Signed-off-by: Elizabeth Ashurov &lt;<a href=3D"mailto:eashurov@redhat.com"=
 target=3D"_blank">eashurov@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/vss-win32/install.cpp | 11 ++++++++---<br>
=C2=A01 file changed, 8 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp<br>
index 5cea5bcf74..a136d46050 100644<br>
--- a/qga/vss-win32/install.cpp<br>
+++ b/qga/vss-win32/install.cpp<br>
@@ -263,6 +263,7 @@ STDAPI COMRegister(void)<br>
=C2=A0 =C2=A0 =C2=A0qga_debug_begin;<br>
<br>
=C2=A0 =C2=A0 =C2=A0HRESULT hr;<br>
+=C2=A0 =C2=A0 HRESULT unregisterHr;<br></blockquote><div>extra HRESULT is =
redundant; you can reuse existing one<br></div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0COMInitializer initializer;<br>
=C2=A0 =C2=A0 =C2=A0COMPointer&lt;IUnknown&gt; pUnknown;<br>
=C2=A0 =C2=A0 =C2=A0COMPointer&lt;ICOMAdminCatalog2&gt; pCatalog;<br>
@@ -287,9 +288,13 @@ STDAPI COMRegister(void)<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unregisterHr =3D COMUnregister();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (FAILED(unregisterHr)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errmsg(unregisterHr, &quot;Faile=
d to unregister existing QGA VSS Provider. Aborting installation.&quot;);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qga_debug_end;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return E_ABORT; <br></blockquote=
><div><br></div><div>.git/rebase-apply/patch:29: trailing whitespace.<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return E_ABORT; <br>warning: 1 li=
ne adds whitespace errors.</div><div>please fix<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0chk(CoCreateInstance(CLSID_COMAdminCatalog, NULL, CLSCT=
X_INPROC_SERVER,<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div></div>

--0000000000000969050637d45adb--


