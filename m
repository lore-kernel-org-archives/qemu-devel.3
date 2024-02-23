Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5E5C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 08:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdR4N-0006TK-9K; Fri, 23 Feb 2024 03:38:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rdR4K-0006RX-Fl
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 03:38:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rdR4I-0007ea-R5
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 03:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708677486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rW5zRbIULXRlq6PtVjsrXlxVhHNPKF6xTxPaK2oYPMU=;
 b=fme8GC6GCk6uCzOPO38+/ZG2IUE3IKKHGcARV62fN2cAgI8tcsjSp+XGyyvIuAGqz/L2LZ
 GB/wYtxusgdW6artR1yDtHlvAyGRJ9oxoFusWFjNty3Od7JH2EHtN5CwOPKFaTPHNzwzHz
 ztntGq8oxJzuxXZFzYyDYHlODDXeMRA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-PxBSAs69PAiVWg1fu6KF4A-1; Fri, 23 Feb 2024 03:38:04 -0500
X-MC-Unique: PxBSAs69PAiVWg1fu6KF4A-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2d24466f7e3so5438141fa.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 00:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708677483; x=1709282283;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rW5zRbIULXRlq6PtVjsrXlxVhHNPKF6xTxPaK2oYPMU=;
 b=sgbkPELKWkKBYlmBj/OUUN/Nj3hIxJN6ytWY0I5EUjYNaALmF7hBVrcVcmCZowiSSV
 YYT6YDI64Kpl6ILFgmjsxYVmfhY07n4mXriJWOboCGUTlXKIU/xHBa0n57YktYtUDvrp
 kFyPQPcyIUS1nJfPnN1EN2dcIkvfRyzD7y5I6ThK2Ecg8cZtimyZMI+FHByFMg9bX04I
 wfbgBQDvPK2vreOZ3xGyxAj6R4ZMJ4lIWKDlunuCkuIl7eSiO+uAnp0OzjAJIprsjh9q
 ozYVwPl6G06yiW/lcDXv7UKvSJihBYxLAqT3SrVL2WuwnpyC7wZLdg47dvE6bfSTjV6z
 WslA==
X-Gm-Message-State: AOJu0YxHpAGq8Z4tk0xlVvpbNPQDrx6vPZDvq6AuClvLGiAnPpSCu1Zo
 +sBUNUAlMpC93ZbECpZa7xhIUMYN+Kl0xKJz42MFUGfMVhWRlvHwIdkxSJngtmJ6ws3xeA5j+Zi
 11NaO/9nloIiqylCtDYkNz+/3eNMaUZXjwxxkIyY4Iv1oPDV17vXynMLl+5UjW0CcrWWF0icW8l
 NOsWFfQppTcFhJX33tZh459YLJwws=
X-Received: by 2002:a2e:b34a:0:b0:2d2:62e0:fa3d with SMTP id
 q10-20020a2eb34a000000b002d262e0fa3dmr793746lja.12.1708677483028; 
 Fri, 23 Feb 2024 00:38:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsy3KsIZe1ioQKp7judYSGpxuFa/tVuCKCk5uZ7eZt+z8uzOXgda8zFwwfB8+NZWVQAWkG/Z8m78IsCPtmy78=
X-Received: by 2002:a2e:b34a:0:b0:2d2:62e0:fa3d with SMTP id
 q10-20020a2eb34a000000b002d262e0fa3dmr793733lja.12.1708677482718; Fri, 23 Feb
 2024 00:38:02 -0800 (PST)
MIME-Version: 1.0
References: <20240222152835.72095-1-philmd@linaro.org>
 <20240222152835.72095-3-philmd@linaro.org>
In-Reply-To: <20240222152835.72095-3-philmd@linaro.org>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 23 Feb 2024 10:37:52 +0200
Message-ID: <CAPMcbCqL=3JnqtODFgN50Kru0NErX_sFd=tLHBi_GX6i_Ob_-Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] qga/commands-win32: Do not set
 matrix_lookup_t/win_10_0_t arrays size
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Dehan Meng <demeng@redhat.com>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="00000000000064bedf0612087a1f"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--00000000000064bedf0612087a1f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

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
>      {
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

--00000000000064bedf0612087a1f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 2=
2, 2024 at 5:28=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailt=
o:philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">ga_get_win_name() iterates over all e=
lements in the arrays by<br>
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
+static const ga_matrix_lookup_t WIN_VERSION_MATRIX[2][] =3D {<br>
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
</blockquote></div>

--00000000000064bedf0612087a1f--


