Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBA7C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 10:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt2U7-0000i9-CK; Fri, 14 Mar 2025 06:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tt2U3-0000hj-GL
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tt2Tv-0007L2-Uj
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741948893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ngJ3ircqWYsHCCK18Lp5L0HTrxUTDjyPeDH7DlB2UI4=;
 b=YoR/lHx1Bg72H8WSqDzqkSb6oOBeVc10qO0GCzx75qPgbyOsSRIiRJTYyV9Nl4bCRZrFEb
 fP4lxxkBqDxR/aoQDl39lc7W25i29RtoTqOwmDyN16tQvtpu0fAgWTF30ZZ0bYABeKUrHU
 W3W5qQjaGpAx0V+zMM5Hhbex4skB4lY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-pWS5RFRuPOWBbiH-0ZQeZw-1; Fri, 14 Mar 2025 06:41:31 -0400
X-MC-Unique: pWS5RFRuPOWBbiH-0ZQeZw-1
X-Mimecast-MFC-AGG-ID: pWS5RFRuPOWBbiH-0ZQeZw_1741948891
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c3c8f8ab79so340574985a.2
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 03:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741948891; x=1742553691;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ngJ3ircqWYsHCCK18Lp5L0HTrxUTDjyPeDH7DlB2UI4=;
 b=OsOk+B1bVN2lYTt3P3GztSaeViUbn8VXnOuLCygPiajJLhg9zlNGUssMGptcm6nt5a
 wJPkXq+FVvkkuJlkQqGN308prm+5gpfj3qJxLczyon9cICquGJHRsUos44gNhpVb9poN
 H6gifWdz492Qyz0V9v5nShrN4fN4ZAA1FANOwKZKpQr8vfISnQjdSra1mPb/AO7ilwKn
 c6OK7YdloHQF95xyglWckJ8MJRhZrHBQHtBN5wdKkHGjqBeFwoGOfbTGVLyduuzMVqvA
 /a3bpMk4JgQFjrPSWxPeokprJ09t6YY9uh1S+dc3YHNIKF2vc3gJSZpi2xgO9920TRxA
 vJaQ==
X-Gm-Message-State: AOJu0YwPFO8XzzbwE35/gLCPhoth/OWQvPAiD63sGdU2xuCHe4/HGNuM
 /U6w/WiZuXT0pY3FV/g8q0C3b3a71hjjzZMLVQiOVDL8g2z01GpyJrC3GYP1P5ayo9HGV9/k7t2
 Ulvy0vbWc7q7CWwoX9ACm7GB+V3YiRZ9v751b1ywNsElwtKbZe3xp62MEm5vZYJZtjvq+neA+7n
 f1IYyh85F+n6mBDBN/X/LZ8J1KSCU=
X-Gm-Gg: ASbGncuNjcjj+/6Qzpne4qvE/yVx7Y2NF8HA9YFxtEjWrHhH7o5UGx1EontaSP2UbrS
 tNHjQO+Wvo3I1TWVbL+IA4QZOhsFmaEtiSgjzEl5GgqDtX145xfJhMx3xjK/S+3c3w62Ig5maLl
 o=
X-Received: by 2002:a05:620a:4515:b0:7c5:4194:bbcc with SMTP id
 af79cd13be357-7c57c80ef7bmr211154185a.29.1741948890942; 
 Fri, 14 Mar 2025 03:41:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqe0cooRM1issZw5mbq7RTC0A9HcUtAOpc5os+TOnisXPa+8Ela8ZQYSKL3S7/FsOPMYbQeV5Y8Nika1lo3GU=
X-Received: by 2002:a05:620a:4515:b0:7c5:4194:bbcc with SMTP id
 af79cd13be357-7c57c80ef7bmr211152685a.29.1741948890670; Fri, 14 Mar 2025
 03:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250314102307.2806696-1-alex.bennee@linaro.org>
In-Reply-To: <20250314102307.2806696-1-alex.bennee@linaro.org>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 14 Mar 2025 12:41:20 +0200
X-Gm-Features: AQ5f1JodDbyv3hlHHliVtcbR-FG8IwXlhbCEVyKGEIcZ3n9jFYd9Cy4uD9fEhxQ
Message-ID: <CAPMcbCoKBRererw0cjgyxnLdDLYEa0Vb5nzJ4MtPbUWYjdsTHg@mail.gmail.com>
Subject: Re: [RFC PATCH] meson.build: don't bother with split-debug for windows
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000d8832706304b14e8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--000000000000d8832706304b14e8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Best Regards,
Konstantin Kostiuk.


On Fri, Mar 14, 2025 at 12:23=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:

> It was reported this breaks the final artefacts on windows when run
> under Wine.
>

Not only Wine, but Windows as well. Tested on Windows Server 2022.


>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Konstantin Kostiuk <kkostiuk@redhat.com>
> ---
>  meson.build | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index c2c71b6f8a..9b1af6d030 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -601,8 +601,10 @@ if get_option('tsan')
>    qemu_ldflags =3D ['-fsanitize=3Dthread'] + qemu_ldflags
>  endif
>
> -if get_option('debug') and get_option('split_debug')
> -  qemu_cflags +=3D '-gsplit-dwarf'
> +if host_os !=3D 'windows'
> +  if get_option('debug') and get_option('split_debug')
> +    qemu_cflags +=3D '-gsplit-dwarf'
> +  endif
>  endif
>
>  # Detect support for PT_GNU_RELRO + DT_BIND_NOW.
> --
> 2.39.5
>
>
Tested-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

--000000000000d8832706304b14e8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div><br clear=3D"all"><=
/div><div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>=
Best Regards,</div><div>Konstantin Kostiuk.</div></div></div></div><br></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On F=
ri, Mar 14, 2025 at 12:23=E2=80=AFPM Alex Benn=C3=A9e &lt;<a href=3D"mailto=
:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">It was rep=
orted this breaks the final artefacts on windows when run<br>
under Wine.<br></blockquote><div><br></div><div>Not only Wine, but Windows =
as well. Tested on Windows Server 2022.</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
Cc: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com" target=3D=
"_blank">kkostiuk@redhat.com</a>&gt;<br>
---<br>
=C2=A0meson.build | 6 ++++--<br>
=C2=A01 file changed, 4 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index c2c71b6f8a..9b1af6d030 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -601,8 +601,10 @@ if get_option(&#39;tsan&#39;)<br>
=C2=A0 =C2=A0qemu_ldflags =3D [&#39;-fsanitize=3Dthread&#39;] + qemu_ldflag=
s<br>
=C2=A0endif<br>
<br>
-if get_option(&#39;debug&#39;) and get_option(&#39;split_debug&#39;)<br>
-=C2=A0 qemu_cflags +=3D &#39;-gsplit-dwarf&#39;<br>
+if host_os !=3D &#39;windows&#39;<br>
+=C2=A0 if get_option(&#39;debug&#39;) and get_option(&#39;split_debug&#39;=
)<br>
+=C2=A0 =C2=A0 qemu_cflags +=3D &#39;-gsplit-dwarf&#39;<br>
+=C2=A0 endif<br>
=C2=A0endif<br>
<br>
=C2=A0# Detect support for PT_GNU_RELRO + DT_BIND_NOW.<br>
-- <br>
2.39.5<br>
<br></blockquote><div><br></div><div>Tested-by: Konstantin Kostiuk &lt;<a h=
ref=3D"mailto:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a=
>&gt;<br></div><div>Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:k=
kostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><div=
>=C2=A0</div></div></div>
</div>

--000000000000d8832706304b14e8--


