Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8919CC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 12:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdUEz-0002ys-Ec; Fri, 23 Feb 2024 07:01:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rdUEo-0002tc-JQ
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:01:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rdUEm-0002e0-4v
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:01:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708689666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3uLfuFbRtlqLCT+VL8zQAYil5QZjCVo4msDIqtAkx0s=;
 b=bm4j8Q5w6QgykGdtBd5UG31epthdqcifnYIp1iHvrVV/en7POo3VM3SJRV3M++DHyI9irp
 Z5hdVuKN8badR0enwdJ/oAFC7hLxnKAw8GZI1aC0PWddIye53w1p2J8VAT334+xykNIsK/
 T2q8bqxEGjojcKCURsqmRY3Hvi5bNfI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683--uPBvd4nNdi-7xNTVyRBYA-1; Fri, 23 Feb 2024 07:01:04 -0500
X-MC-Unique: -uPBvd4nNdi-7xNTVyRBYA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-512aa50323cso877821e87.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 04:01:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708689663; x=1709294463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3uLfuFbRtlqLCT+VL8zQAYil5QZjCVo4msDIqtAkx0s=;
 b=n4A2uycSO3APGa7N6WZqrWNXEWn10JjcHQOF790QXzKFUcP4W7MyU1syuSa2JXzNf1
 kGAkN4h+yeCiFi0IP2k5D4n9pU6EUpuSQbujEa4X/nr6odX5IatRTeVGMgKAWzSORiw8
 Pu6adaSPCaNBEauvfApUzUPIbqxdnDyRyVrj7GdCI3oXScNWua1AgCjyaVICpyc84ywD
 7D6A2lL45Cqd7f/2HW/39BPdR1GcCgrMZULGa4u4qGK3kBroZq3Lhjou5zNrpjnlUs7C
 6Va0ASSs8++eGy6uoJCXPMVpAJhqlksP68PqK2o8Lz3FKVCDGwDTP6wezNlN12KAfbg2
 Uv7A==
X-Gm-Message-State: AOJu0Yx+dh4Dmnlhtfr7VmMvb+KNMmXUST4z0npuRocKRS8CDz4vJsma
 WS8/BZfMFyFTKe0kz2jmboYQcTf+/azAVzy0hx5IkphHmYsXL/pG3pbPD8LmVfvIB+dws6aLhrP
 qUpb+9s04CaWD2IhH/FI9lzn4hxQbLUCLpUalfNblXwlwymNGlMTVD4+HhAnbGaJoeudqKjwYqL
 DKJ0yMTAJQUji7/ObXrd+rxg5+hqI=
X-Received: by 2002:ac2:48ab:0:b0:512:cfac:3d81 with SMTP id
 u11-20020ac248ab000000b00512cfac3d81mr1035335lfg.68.1708689663293; 
 Fri, 23 Feb 2024 04:01:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2gnI5dQDrlqikuxykKmjembFk7AwxNvB8m0AHraS49+HNJKqLrhLEVznsUhiHge8QLVZVl6bGzLjvukpB4jc=
X-Received: by 2002:ac2:48ab:0:b0:512:cfac:3d81 with SMTP id
 u11-20020ac248ab000000b00512cfac3d81mr1035329lfg.68.1708689662907; Fri, 23
 Feb 2024 04:01:02 -0800 (PST)
MIME-Version: 1.0
References: <20240222152835.72095-1-philmd@linaro.org>
 <20240222152835.72095-3-philmd@linaro.org>
In-Reply-To: <20240222152835.72095-3-philmd@linaro.org>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 23 Feb 2024 14:00:51 +0200
Message-ID: <CAPMcbCr5jRuxZAyGpqiPvw=QgMAqWpFb0qjpiFGRhqLSfr4jQg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] qga/commands-win32: Do not set
 matrix_lookup_t/win_10_0_t arrays size
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Dehan Meng <demeng@redhat.com>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="00000000000063afe906120b5020"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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

--00000000000063afe906120b5020
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 5:28=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> ga_get_win_name() iterates over all elements in the arrays by
> checking the 'version' field is non-NULL. Since the arrays are
> guarded by a NULL terminating element, we don't need to specify
> their size:
>
>   static char *ga_get_win_name(...)
>   {
>       ...
>       const ga_matrix_lookup_t *table =3D WIN_VERSION_MATRIX[tbl_idx];
>       const ga_win_10_0_t *win_10_0_table =3D ...
>       ...
>       while (table->version !=3D NULL) {
>                     ^^^^^^^^^^^^^^^
>               while (win_10_0_table->version !=3D NULL) {
>                                      ^^^^^^^^^^^^^^^
>
> This will simplify maintenance when adding new entries to these
> arrays.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  qga/commands-win32.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 79b5a580c9..87ce6e2870 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -2124,7 +2124,7 @@ typedef struct _ga_matrix_lookup_t {
>      const char *version_id;
>  } ga_matrix_lookup_t;
>
> -static const ga_matrix_lookup_t WIN_VERSION_MATRIX[2][7] =3D {
> +static const ga_matrix_lookup_t WIN_VERSION_MATRIX[2][] =3D {
>

I love this idea but mingw-gcc - no.

../qga/commands-win32.c:2125:33: error: array type has incomplete element
type =E2=80=98ga_matrix_lookup_t[]=E2=80=99 {aka =E2=80=98struct _ga_matrix=
_lookup_t[]=E2=80=99}
 2125 | static const ga_matrix_lookup_t WIN_VERSION_MATRIX[2][] =3D {
      |                                 ^~~~~~~~~~~~~~~~~~
../qga/commands-win32.c:2125:33: note: declaration of =E2=80=98WIN_VERSION_=
MATRIX=E2=80=99
as multidimensional array must have bounds for all dimensions except the
first

I think we can do the same as with Win10 and create 2 variables:
 WIN_SERVER_VERSION_MATRIX and WIN_CLIENT_VERSION_MATRIX

If you want I can fix this by myself.


Best Regards,
Konstantin Kostiuk.

     {
>          /* Desktop editions */
>          { 5, 0, "Microsoft Windows 2000",   "2000"},
> @@ -2133,7 +2133,7 @@ static const ga_matrix_lookup_t
> WIN_VERSION_MATRIX[2][7] =3D {
>          { 6, 1, "Microsoft Windows 7"       "7"},
>          { 6, 2, "Microsoft Windows 8",      "8"},
>          { 6, 3, "Microsoft Windows 8.1",    "8.1"},
> -        { 0, 0, 0}
> +        { }
>      },{
>          /* Server editions */
>          { 5, 2, "Microsoft Windows Server 2003",        "2003"},
> @@ -2141,28 +2141,27 @@ static const ga_matrix_lookup_t
> WIN_VERSION_MATRIX[2][7] =3D {
>          { 6, 1, "Microsoft Windows Server 2008 R2",     "2008r2"},
>          { 6, 2, "Microsoft Windows Server 2012",        "2012"},
>          { 6, 3, "Microsoft Windows Server 2012 R2",     "2012r2"},
> -        { 0, 0, 0},
> -        { 0, 0, 0}
> +        { },
>      }
>  };
>
>  typedef struct _ga_win_10_0_t {
>      int first_build;
> -    const char *version;
> -    const char *version_id;
> +    char const *version;
> +    char const *version_id;
>  } ga_win_10_0_t;
>
> -static const ga_win_10_0_t WIN_10_0_SERVER_VERSION_MATRIX[4] =3D {
> +static const ga_win_10_0_t WIN_10_0_SERVER_VERSION_MATRIX[] =3D {
>      {14393, "Microsoft Windows Server 2016",    "2016"},
>      {17763, "Microsoft Windows Server 2019",    "2019"},
>      {20344, "Microsoft Windows Server 2022",    "2022"},
> -    {0, 0}
> +    { }
>  };
>
> -static const ga_win_10_0_t WIN_10_0_CLIENT_VERSION_MATRIX[3] =3D {
> +static const ga_win_10_0_t WIN_10_0_CLIENT_VERSION_MATRIX[] =3D {
>      {10240, "Microsoft Windows 10",    "10"},
>      {22000, "Microsoft Windows 11",    "11"},
> -    {0, 0}
> +    { }
>  };
>
>  static void ga_get_win_version(RTL_OSVERSIONINFOEXW *info, Error **errp)
> --
> 2.41.0
>
>

--00000000000063afe906120b5020
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 22, 2024 at 5:28=E2=80=AF=
PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">phi=
lmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">ga_get_win_name() iterates over all elements in the arrays by=
<br>
checking the &#39;version&#39; field is non-NULL. Since the arrays are<br>
guarded by a NULL terminating element, we don&#39;t need to specify<br>
their size:<br>
<br>
=C2=A0 static char *ga_get_win_name(...)<br>
=C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 const ga_matrix_lookup_t *table =3D WIN_VERSION_MATRIX=
[tbl_idx];<br>
=C2=A0 =C2=A0 =C2=A0 const ga_win_10_0_t *win_10_0_table =3D ...<br>
=C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 while (table-&gt;version !=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^^^^^=
^^^^^^^^^^<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (win_10_0_table-&gt;=
version !=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^^^^^^^^<=
br>
<br>
This will simplify maintenance when adding new entries to these<br>
arrays.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0qga/commands-win32.c | 19 +++++++++----------<br>
=C2=A01 file changed, 9 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index 79b5a580c9..87ce6e2870 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -2124,7 +2124,7 @@ typedef struct _ga_matrix_lookup_t {<br>
=C2=A0 =C2=A0 =C2=A0const char *version_id;<br>
=C2=A0} ga_matrix_lookup_t;<br>
<br>
-static const ga_matrix_lookup_t WIN_VERSION_MATRIX[2][7] =3D {<br>
+static const ga_matrix_lookup_t WIN_VERSION_MATRIX[2][] =3D {<br></blockqu=
ote><div><br></div><div>I love this idea but mingw-gcc - no.<br><br>../qga/=
commands-win32.c:2125:33: error: array type has incomplete element type =E2=
=80=98ga_matrix_lookup_t[]=E2=80=99 {aka =E2=80=98struct _ga_matrix_lookup_=
t[]=E2=80=99}<br>=C2=A02125 | static const ga_matrix_lookup_t WIN_VERSION_M=
ATRIX[2][] =3D {<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ^~~~~~~~~~~~~~~~~~<br>../qga/commands-win32.c:2125:33: note: declara=
tion of =E2=80=98WIN_VERSION_MATRIX=E2=80=99 as multidimensional array must=
 have bounds for all dimensions except the first</div><div><br></div><div>I=
 think we can do the same as with Win10 and create 2 variables:</div><div>=
=C2=A0WIN_SERVER_VERSION_MATRIX and WIN_CLIENT_VERSION_MATRIX<br><br></div>=
<div>If you want I can fix this by myself.</div><div><br></div><div><br cle=
ar=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"=
><div>Best Regards,</div><div>Konstantin Kostiuk.</div></div></div></div></=
div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Desktop editions */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 5, 0, &quot;Microsoft Windows 2000&quot=
;,=C2=A0 =C2=A0&quot;2000&quot;},<br>
@@ -2133,7 +2133,7 @@ static const ga_matrix_lookup_t WIN_VERSION_MATRIX[2]=
[7] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 6, 1, &quot;Microsoft Windows 7&quot;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;7&quot;},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 6, 2, &quot;Microsoft Windows 8&quot;,=
=C2=A0 =C2=A0 =C2=A0 &quot;8&quot;},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 6, 3, &quot;Microsoft Windows 8.1&quot;=
,=C2=A0 =C2=A0 &quot;8.1&quot;},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 { 0, 0, 0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 { }<br>
=C2=A0 =C2=A0 =C2=A0},{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Server editions */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 5, 2, &quot;Microsoft Windows Server 20=
03&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;2003&quot;},<br>
@@ -2141,28 +2141,27 @@ static const ga_matrix_lookup_t WIN_VERSION_MATRIX[=
2][7] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 6, 1, &quot;Microsoft Windows Server 20=
08 R2&quot;,=C2=A0 =C2=A0 =C2=A0&quot;2008r2&quot;},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 6, 2, &quot;Microsoft Windows Server 20=
12&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;2012&quot;},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 6, 3, &quot;Microsoft Windows Server 20=
12 R2&quot;,=C2=A0 =C2=A0 =C2=A0&quot;2012r2&quot;},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 { 0, 0, 0},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 { 0, 0, 0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 { },<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0};<br>
<br>
=C2=A0typedef struct _ga_win_10_0_t {<br>
=C2=A0 =C2=A0 =C2=A0int first_build;<br>
-=C2=A0 =C2=A0 const char *version;<br>
-=C2=A0 =C2=A0 const char *version_id;<br>
+=C2=A0 =C2=A0 char const *version;<br>
+=C2=A0 =C2=A0 char const *version_id;<br>
=C2=A0} ga_win_10_0_t;<br>
<br>
-static const ga_win_10_0_t WIN_10_0_SERVER_VERSION_MATRIX[4] =3D {<br>
+static const ga_win_10_0_t WIN_10_0_SERVER_VERSION_MATRIX[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0{14393, &quot;Microsoft Windows Server 2016&quot;,=C2=
=A0 =C2=A0 &quot;2016&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{17763, &quot;Microsoft Windows Server 2019&quot;,=C2=
=A0 =C2=A0 &quot;2019&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{20344, &quot;Microsoft Windows Server 2022&quot;,=C2=
=A0 =C2=A0 &quot;2022&quot;},<br>
-=C2=A0 =C2=A0 {0, 0}<br>
+=C2=A0 =C2=A0 { }<br>
=C2=A0};<br>
<br>
-static const ga_win_10_0_t WIN_10_0_CLIENT_VERSION_MATRIX[3] =3D {<br>
+static const ga_win_10_0_t WIN_10_0_CLIENT_VERSION_MATRIX[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0{10240, &quot;Microsoft Windows 10&quot;,=C2=A0 =C2=A0 =
&quot;10&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{22000, &quot;Microsoft Windows 11&quot;,=C2=A0 =C2=A0 =
&quot;11&quot;},<br>
-=C2=A0 =C2=A0 {0, 0}<br>
+=C2=A0 =C2=A0 { }<br>
=C2=A0};<br>
<br>
=C2=A0static void ga_get_win_version(RTL_OSVERSIONINFOEXW *info, Error **er=
rp)<br>
-- <br>
2.41.0<br>
<br>
</blockquote></div></div>

--00000000000063afe906120b5020--


