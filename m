Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7DAC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 08:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdR2Z-00052F-Pp; Fri, 23 Feb 2024 03:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rdR2W-000520-Rl
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 03:36:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rdR2U-0007K4-Uu
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 03:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708677373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ePTOfy7nyN7unCr+O6J4zuXiAnhsRKKWaDiKrtZQXuU=;
 b=GGXB3+F/CM3DpwPctV3pPIaVgTDXqIjHsYadhLOgrVcrKunSUEb925tqEDsc/vY4L+90WE
 GNuQLRFRxu6OeiU795QRY39bYpry6ZJ/26lRZqfbU//UO1Nfq4UNC1k1p+AKszBhPqcJ/6
 UxyPCvkg0JmjLfsKWSnTJrtbMtwQiO8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-sdX7vfZSNoONSR0yz_O1cw-1; Fri, 23 Feb 2024 03:36:09 -0500
X-MC-Unique: sdX7vfZSNoONSR0yz_O1cw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2d264c84b99so753941fa.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 00:36:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708677368; x=1709282168;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ePTOfy7nyN7unCr+O6J4zuXiAnhsRKKWaDiKrtZQXuU=;
 b=euaqhPocVbZWQllkHLdAd7MPEnoLkyt4qJT3bhRB78hvmGCLTwj9j0PSFZG9wq4Zt0
 gLuf0Kmka28+3N2c2eCIea3N6LXINbZTCdq4gu1Pl2c1wOhlz6FLnNl2tFN8X5Wynpv7
 950p1SQqS9TMLPSCYN0D2lA2jzJDeDDdp+azysO9BOUz6Mdaolzl9sIk7TZOwnmKZMDm
 poZXfr5hyRGFjr9hI1ZlYszglFiwtLqSshClcAXwwgATXkUHEbqGHQaRpp/MK6Lk86R0
 oV6xFQ4PFIQZ+uOrj+8khV/VflaMca5mCeMH29yMCFsWWRzkt32eFQ5VG5AM123UNiCQ
 +ykw==
X-Gm-Message-State: AOJu0YzJk1tOBKJ9xHy7xjWvyQrOaj3Nb67+pQjx2ffeptLIx6KTy4Y/
 A8QYIPpO+oNtnoyn2u6PxTg4bDVlBR7HhekHs5ZrvdzWZJhCs+CrzEtxQZ/3VLUeVRUrifzBRzy
 d8aP+6Ooz1D9IdLOeJZk6FL5zsT85qdrE7XNfkgrIOGsUIBzPUtcPPi2FcVWfQ4j4/YM620oGrP
 6NAvURTqshn6yVmqv4vl9H7L1ydkg=
X-Received: by 2002:a2e:9e4e:0:b0:2d2:40cb:8182 with SMTP id
 g14-20020a2e9e4e000000b002d240cb8182mr732515ljk.49.1708677368002; 
 Fri, 23 Feb 2024 00:36:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjVuaoe0eCKn1pXhg0ENffuIBmA9NyzQjWQZs1s1Zyj3e7yTlcdxAst0yh70M2cc66rWGSQ6QyrQYpY4TPBN4=
X-Received: by 2002:a2e:9e4e:0:b0:2d2:40cb:8182 with SMTP id
 g14-20020a2e9e4e000000b002d240cb8182mr732506ljk.49.1708677367717; Fri, 23 Feb
 2024 00:36:07 -0800 (PST)
MIME-Version: 1.0
References: <20240222152835.72095-1-philmd@linaro.org>
 <20240222152835.72095-2-philmd@linaro.org>
In-Reply-To: <20240222152835.72095-2-philmd@linaro.org>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 23 Feb 2024 10:35:56 +0200
Message-ID: <CAPMcbCoq_8bodxzs9cZhwa=ZkeebKyDW54Fv2Pf7o1rc_DTzvQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] qga/commands-win32: Declare const qualifier before
 type
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Dehan Meng <demeng@redhat.com>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="00000000000089f3c0061208737f"
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

--00000000000089f3c0061208737f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Thu, Feb 22, 2024 at 5:28=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Most of the code base use the 'const' qualifier *before*
> the type being qualified. Use the same style to unify.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  qga/commands-win32.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index a1015757d8..79b5a580c9 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -2120,11 +2120,11 @@ GuestUserList *qmp_guest_get_users(Error **errp)
>  typedef struct _ga_matrix_lookup_t {
>      int major;
>      int minor;
> -    char const *version;
> -    char const *version_id;
> +    const char *version;
> +    const char *version_id;
>  } ga_matrix_lookup_t;
>
> -static ga_matrix_lookup_t const WIN_VERSION_MATRIX[2][7] =3D {
> +static const ga_matrix_lookup_t WIN_VERSION_MATRIX[2][7] =3D {
>      {
>          /* Desktop editions */
>          { 5, 0, "Microsoft Windows 2000",   "2000"},
> @@ -2148,18 +2148,18 @@ static ga_matrix_lookup_t const
> WIN_VERSION_MATRIX[2][7] =3D {
>
>  typedef struct _ga_win_10_0_t {
>      int first_build;
> -    char const *version;
> -    char const *version_id;
> +    const char *version;
> +    const char *version_id;
>  } ga_win_10_0_t;
>
> -static ga_win_10_0_t const WIN_10_0_SERVER_VERSION_MATRIX[4] =3D {
> +static const ga_win_10_0_t WIN_10_0_SERVER_VERSION_MATRIX[4] =3D {
>      {14393, "Microsoft Windows Server 2016",    "2016"},
>      {17763, "Microsoft Windows Server 2019",    "2019"},
>      {20344, "Microsoft Windows Server 2022",    "2022"},
>      {0, 0}
>  };
>
> -static ga_win_10_0_t const WIN_10_0_CLIENT_VERSION_MATRIX[3] =3D {
> +static const ga_win_10_0_t WIN_10_0_CLIENT_VERSION_MATRIX[3] =3D {
>      {10240, "Microsoft Windows 10",    "10"},
>      {22000, "Microsoft Windows 11",    "11"},
>      {0, 0}
> @@ -2185,16 +2185,16 @@ static void
> ga_get_win_version(RTL_OSVERSIONINFOEXW *info, Error **errp)
>      return;
>  }
>
> -static char *ga_get_win_name(OSVERSIONINFOEXW const *os_version, bool id=
)
> +static char *ga_get_win_name(const OSVERSIONINFOEXW *os_version, bool id=
)
>  {
>      DWORD major =3D os_version->dwMajorVersion;
>      DWORD minor =3D os_version->dwMinorVersion;
>      DWORD build =3D os_version->dwBuildNumber;
>      int tbl_idx =3D (os_version->wProductType !=3D VER_NT_WORKSTATION);
> -    ga_matrix_lookup_t const *table =3D WIN_VERSION_MATRIX[tbl_idx];
> -    ga_win_10_0_t const *win_10_0_table =3D tbl_idx ?
> +    const ga_matrix_lookup_t *table =3D WIN_VERSION_MATRIX[tbl_idx];
> +    const ga_win_10_0_t *win_10_0_table =3D tbl_idx ?
>          WIN_10_0_SERVER_VERSION_MATRIX : WIN_10_0_CLIENT_VERSION_MATRIX;
> -    ga_win_10_0_t const *win_10_0_version =3D NULL;
> +    const ga_win_10_0_t *win_10_0_version =3D NULL;
>      while (table->version !=3D NULL) {
>          if (major =3D=3D 10 && minor =3D=3D 0) {
>              while (win_10_0_table->version !=3D NULL) {
> --
> 2.41.0
>
>

--00000000000089f3c0061208737f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 2=
2, 2024 at 5:28=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailt=
o:philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">Most of the code base use the &#39;co=
nst&#39; qualifier *before*<br>
the type being qualified. Use the same style to unify.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0qga/commands-win32.c | 22 +++++++++++-----------<br>
=C2=A01 file changed, 11 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index a1015757d8..79b5a580c9 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -2120,11 +2120,11 @@ GuestUserList *qmp_guest_get_users(Error **errp)<br=
>
=C2=A0typedef struct _ga_matrix_lookup_t {<br>
=C2=A0 =C2=A0 =C2=A0int major;<br>
=C2=A0 =C2=A0 =C2=A0int minor;<br>
-=C2=A0 =C2=A0 char const *version;<br>
-=C2=A0 =C2=A0 char const *version_id;<br>
+=C2=A0 =C2=A0 const char *version;<br>
+=C2=A0 =C2=A0 const char *version_id;<br>
=C2=A0} ga_matrix_lookup_t;<br>
<br>
-static ga_matrix_lookup_t const WIN_VERSION_MATRIX[2][7] =3D {<br>
+static const ga_matrix_lookup_t WIN_VERSION_MATRIX[2][7] =3D {<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Desktop editions */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 5, 0, &quot;Microsoft Windows 2000&quot=
;,=C2=A0 =C2=A0&quot;2000&quot;},<br>
@@ -2148,18 +2148,18 @@ static ga_matrix_lookup_t const WIN_VERSION_MATRIX[=
2][7] =3D {<br>
<br>
=C2=A0typedef struct _ga_win_10_0_t {<br>
=C2=A0 =C2=A0 =C2=A0int first_build;<br>
-=C2=A0 =C2=A0 char const *version;<br>
-=C2=A0 =C2=A0 char const *version_id;<br>
+=C2=A0 =C2=A0 const char *version;<br>
+=C2=A0 =C2=A0 const char *version_id;<br>
=C2=A0} ga_win_10_0_t;<br>
<br>
-static ga_win_10_0_t const WIN_10_0_SERVER_VERSION_MATRIX[4] =3D {<br>
+static const ga_win_10_0_t WIN_10_0_SERVER_VERSION_MATRIX[4] =3D {<br>
=C2=A0 =C2=A0 =C2=A0{14393, &quot;Microsoft Windows Server 2016&quot;,=C2=
=A0 =C2=A0 &quot;2016&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{17763, &quot;Microsoft Windows Server 2019&quot;,=C2=
=A0 =C2=A0 &quot;2019&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{20344, &quot;Microsoft Windows Server 2022&quot;,=C2=
=A0 =C2=A0 &quot;2022&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{0, 0}<br>
=C2=A0};<br>
<br>
-static ga_win_10_0_t const WIN_10_0_CLIENT_VERSION_MATRIX[3] =3D {<br>
+static const ga_win_10_0_t WIN_10_0_CLIENT_VERSION_MATRIX[3] =3D {<br>
=C2=A0 =C2=A0 =C2=A0{10240, &quot;Microsoft Windows 10&quot;,=C2=A0 =C2=A0 =
&quot;10&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{22000, &quot;Microsoft Windows 11&quot;,=C2=A0 =C2=A0 =
&quot;11&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{0, 0}<br>
@@ -2185,16 +2185,16 @@ static void ga_get_win_version(RTL_OSVERSIONINFOEXW=
 *info, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0}<br>
<br>
-static char *ga_get_win_name(OSVERSIONINFOEXW const *os_version, bool id)<=
br>
+static char *ga_get_win_name(const OSVERSIONINFOEXW *os_version, bool id)<=
br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0DWORD major =3D os_version-&gt;dwMajorVersion;<br>
=C2=A0 =C2=A0 =C2=A0DWORD minor =3D os_version-&gt;dwMinorVersion;<br>
=C2=A0 =C2=A0 =C2=A0DWORD build =3D os_version-&gt;dwBuildNumber;<br>
=C2=A0 =C2=A0 =C2=A0int tbl_idx =3D (os_version-&gt;wProductType !=3D VER_N=
T_WORKSTATION);<br>
-=C2=A0 =C2=A0 ga_matrix_lookup_t const *table =3D WIN_VERSION_MATRIX[tbl_i=
dx];<br>
-=C2=A0 =C2=A0 ga_win_10_0_t const *win_10_0_table =3D tbl_idx ?<br>
+=C2=A0 =C2=A0 const ga_matrix_lookup_t *table =3D WIN_VERSION_MATRIX[tbl_i=
dx];<br>
+=C2=A0 =C2=A0 const ga_win_10_0_t *win_10_0_table =3D tbl_idx ?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WIN_10_0_SERVER_VERSION_MATRIX : WIN_10_0=
_CLIENT_VERSION_MATRIX;<br>
-=C2=A0 =C2=A0 ga_win_10_0_t const *win_10_0_version =3D NULL;<br>
+=C2=A0 =C2=A0 const ga_win_10_0_t *win_10_0_version =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0while (table-&gt;version !=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (major =3D=3D 10 &amp;&amp; minor =3D=
=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (win_10_0_table-&gt;v=
ersion !=3D NULL) {<br>
-- <br>
2.41.0<br>
<br>
</blockquote></div>

--00000000000089f3c0061208737f--


