Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7DFC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 08:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdR4i-0006jC-9C; Fri, 23 Feb 2024 03:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rdR4g-0006iX-Q8
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 03:38:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rdR4f-0007io-Bi
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 03:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708677506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KMbO43XvkVkH73aduxqN/926IJEczTOgN+F3XYmnUpk=;
 b=gOFTqgyRl4ISNI+yN1cWF5b712ePYUUsvGkBqjO+S5RUIn3NIJb/m8cDAjHfLuWFX1W1HL
 +q6v/lYde0Ju0QYW9xtNRliGcqFKbgz2OxS+8cG7q0Wj89Y91lgcV+olpPErRfae6wISsW
 fWxXooL3XywRhlwS8iOaIFUiY+KQJvE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-v6fwm4R3ON26wd0PJFeIeQ-1; Fri, 23 Feb 2024 03:38:23 -0500
X-MC-Unique: v6fwm4R3ON26wd0PJFeIeQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d23b0ca7f7so5240951fa.3
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 00:38:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708677502; x=1709282302;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KMbO43XvkVkH73aduxqN/926IJEczTOgN+F3XYmnUpk=;
 b=f0EGyntLWsbmLJ4w+tv4Bs8w9fkPG19/b5o0XTiyzTSlzOt6YIbHymS7cFH1bEjV6E
 ggmSnZ6nWM9F4aPJ+mAgJ9ygcJ+Pg1MT6fQHoeCtDCSSyuy0iEVi4N491M6qICCbv5KL
 CxzAMyNLgyT9yhKFBoHjOqsHE1Q18MvUqSBZPgiJ4rvbIsD8xPGYHLgf9AKfG2g4Jbhe
 2HxYcuBrFETTt7xR7JORh7V6SAKdUOvhWzVmHRaUAAofj0P+i4OiVSRxTJtVLNlKXWGi
 AG9H9zfwc6mnYr/QV4b56hH/Axz5vFy8/tHbeMe0TGvETFr0Obq1+AF1mLu5WUdCm1Ve
 5PTw==
X-Gm-Message-State: AOJu0Yy6G4l9vq9aqKe5OBbLIRTfiAVDG1a8nWMpYGwx8+k2Air+5iUI
 lUgLvUBDlpSZnQFfplqtfR8CPvYhkQGHhRIP8CKi8qXjGOSMoi7yLd8Is8dRJYVT4k1r8qD8W/4
 x81eGm6DUfGwI4mT/NdIGJJxk9uFNvn8Qj0QRsie5jsX3et0CnAORa3D5gylPYdB1wLkAcNgCow
 wr0mODpjs5nMBJYrMj2U6mRApozOI=
X-Received: by 2002:a05:651c:b14:b0:2d2:3a2d:d2fa with SMTP id
 b20-20020a05651c0b1400b002d23a2dd2famr914130ljr.28.1708677502468; 
 Fri, 23 Feb 2024 00:38:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgt1cktqV2h3315RBW5jDcXxr+0KRN92UU46BczVNR9/fRJ0LDiZQzpEaqZFkW3A1Wp6+YDdFnLOwlmS9ErgU=
X-Received: by 2002:a05:651c:b14:b0:2d2:3a2d:d2fa with SMTP id
 b20-20020a05651c0b1400b002d23a2dd2famr914121ljr.28.1708677502289; Fri, 23 Feb
 2024 00:38:22 -0800 (PST)
MIME-Version: 1.0
References: <20240222152835.72095-1-philmd@linaro.org>
 <20240222152835.72095-4-philmd@linaro.org>
In-Reply-To: <20240222152835.72095-4-philmd@linaro.org>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 23 Feb 2024 10:38:11 +0200
Message-ID: <CAPMcbCpPvKi=odfm0jO+Ak6jt4koqDMEvWG==JJV87xNfjks-A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] qga-win: Add support of Windows Server 2025 in
 get-osinfo command
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Dehan Meng <demeng@redhat.com>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000008f5c390612087b68"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000008f5c390612087b68
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Thu, Feb 22, 2024 at 5:29=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> From: Dehan Meng <demeng@redhat.com>
>
> Add support of Windows Server 2025 in get-osinfo command
>
> Signed-off-by: Dehan Meng <demeng@redhat.com>
> Message-ID: <20240222025352.58859-2-demeng@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  qga/commands-win32.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 87ce6e2870..9749e4e6a3 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -2155,6 +2155,7 @@ static const ga_win_10_0_t
> WIN_10_0_SERVER_VERSION_MATRIX[] =3D {
>      {14393, "Microsoft Windows Server 2016",    "2016"},
>      {17763, "Microsoft Windows Server 2019",    "2019"},
>      {20344, "Microsoft Windows Server 2022",    "2022"},
> +    {26040, "MIcrosoft Windows Server 2025",    "2025"},
>      { }
>  };
>
> --
> 2.41.0
>
>

--0000000000008f5c390612087b68
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 2=
2, 2024 at 5:29=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailt=
o:philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">From: Dehan Meng &lt;<a href=3D"mailt=
o:demeng@redhat.com" target=3D"_blank">demeng@redhat.com</a>&gt;<br>
<br>
Add support of Windows Server 2025 in get-osinfo command<br>
<br>
Signed-off-by: Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com" target=
=3D"_blank">demeng@redhat.com</a>&gt;<br>
Message-ID: &lt;<a href=3D"mailto:20240222025352.58859-2-demeng@redhat.com"=
 target=3D"_blank">20240222025352.58859-2-demeng@redhat.com</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0qga/commands-win32.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index 87ce6e2870..9749e4e6a3 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -2155,6 +2155,7 @@ static const ga_win_10_0_t WIN_10_0_SERVER_VERSION_MA=
TRIX[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0{14393, &quot;Microsoft Windows Server 2016&quot;,=C2=
=A0 =C2=A0 &quot;2016&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{17763, &quot;Microsoft Windows Server 2019&quot;,=C2=
=A0 =C2=A0 &quot;2019&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{20344, &quot;Microsoft Windows Server 2022&quot;,=C2=
=A0 =C2=A0 &quot;2022&quot;},<br>
+=C2=A0 =C2=A0 {26040, &quot;MIcrosoft Windows Server 2025&quot;,=C2=A0 =C2=
=A0 &quot;2025&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{ }<br>
=C2=A0};<br>
<br>
-- <br>
2.41.0<br>
<br>
</blockquote></div>

--0000000000008f5c390612087b68--


