Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6CFC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPaP-000191-KB; Tue, 05 Mar 2024 02:51:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1rhPaM-00016g-Nx
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:51:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1rhPaL-0000PT-54
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709625096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=epsljffcJ+kb6RBugPDl79LNSVAc29n9A981i8D4cJ0=;
 b=gl0hWO68tQfc8mHFy5hA3GMrHEmmfkdiQZ2/2Xy3cnU4mL11nmIQzuzvWSEK5zakOF+xx2
 ViLGIBUsL3PRhEpJ42Y/Uuiv7VC/65vPCDncO9CnJ5pT7T3OHII4OHtGGe8S5fpqohqTGy
 q48z7i+HfG8RziiWozoBeRt7zQiv6OI=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-VQu05qOiM0GV72obG2yRoQ-1; Tue, 05 Mar 2024 02:50:29 -0500
X-MC-Unique: VQu05qOiM0GV72obG2yRoQ-1
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-4d36418f4e1so702149e0c.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 23:50:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709625029; x=1710229829;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=epsljffcJ+kb6RBugPDl79LNSVAc29n9A981i8D4cJ0=;
 b=VRX5hrIJRRYHmvkb8X1zpU8HZLCmceDbLIqc02OqFNXxlw6WhtNc8OsG+PudLK/FGl
 WtHiHFIgsYhF7rMLDJRaGEzijAflX7JtPNgLWhPNFqNI1fDsoe5qLhSETFGIAuQrXsfr
 OVXD80gFvQ7zpkjaSBqKIxzFW+TmMLCm4hJXbjIZEbD2daC0qtBUm7WS+ebGwAv2qyY5
 KYQpS4+IIvlMWqfMrd4KvoAN/W379QX+IfdvHG0EdxJiSM090wqXm2mZzHQhxLjmliPG
 +pawcSCMsGMa0cv+eLOCL4UnJy7q3e3Qcy56lbxrrh6TYGNmvF+ALZIEM+so9SH7rquk
 zwmw==
X-Gm-Message-State: AOJu0YzNuE3RlGFzEB1C2/I6V1iMRcZ7UJZxDIdeA62JXcZ0wIR86vTF
 r83nQ1KVIIko4fRqAskxzoDF8dj3v9BpLGcv6OLi8PtDjEAVHXXW4MhYleGObjrk3ZPLhyZrjdu
 Z8gCBJgxl7EFCNvf9FY/6ha4W1/rncfP6f7gZNY/JJNs9l8KHJkjeedVUoruXJAzEHHjMA2FO58
 h8h9dHuugTllx9IdWfVuFc1WnDwXc=
X-Received: by 2002:a05:6122:1d15:b0:4d3:45a2:ae53 with SMTP id
 gc21-20020a0561221d1500b004d345a2ae53mr1088617vkb.16.1709625029267; 
 Mon, 04 Mar 2024 23:50:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCyljjAUwdULUZ/kV70KiHlTxzqFMyeEZqZ121un1k0Dss/XjXsKZanIGSXO3Zr8D+KhbZf6mLgVJQWNxdRYk=
X-Received: by 2002:a05:6122:1d15:b0:4d3:45a2:ae53 with SMTP id
 gc21-20020a0561221d1500b004d345a2ae53mr1088606vkb.16.1709625029018; Mon, 04
 Mar 2024 23:50:29 -0800 (PST)
MIME-Version: 1.0
References: <20240304134532.28506-1-kkostiuk@redhat.com>
 <20240304134532.28506-3-kkostiuk@redhat.com>
In-Reply-To: <20240304134532.28506-3-kkostiuk@redhat.com>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Tue, 5 Mar 2024 09:50:17 +0200
Message-ID: <CAGoVJZwVDpMdYn=P3pxON2nggeRuSGmz=W-433iZ8ThjOgjGHA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] qga/commands-win32: Do not set
 matrix_lookup_t/win_10_0_t arrays size
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Dehan Meng <demeng@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Mar 4, 2024 at 3:45=E2=80=AFPM Konstantin Kostiuk <kkostiuk@redhat.=
com> wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
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
> Split WIN_VERSION_MATRIX into WIN_CLIENT_VERSION_MATRIX and
> WIN_SERVER_VERSION_MATRIX because  multidimensional array must
> have bounds for all dimensions except the first.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Message-ID: <20240222152835.72095-3-philmd@linaro.org>
> Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> ---
>  qga/commands-win32.c | 52 +++++++++++++++++++++-----------------------
>  1 file changed, 25 insertions(+), 27 deletions(-)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 79b5a580c9..a830f1494e 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -2124,45 +2124,42 @@ typedef struct _ga_matrix_lookup_t {
>      const char *version_id;
>  } ga_matrix_lookup_t;
>
> -static const ga_matrix_lookup_t WIN_VERSION_MATRIX[2][7] =3D {
> -    {
> -        /* Desktop editions */
> -        { 5, 0, "Microsoft Windows 2000",   "2000"},
> -        { 5, 1, "Microsoft Windows XP",     "xp"},
> -        { 6, 0, "Microsoft Windows Vista",  "vista"},
> -        { 6, 1, "Microsoft Windows 7"       "7"},
> -        { 6, 2, "Microsoft Windows 8",      "8"},
> -        { 6, 3, "Microsoft Windows 8.1",    "8.1"},
> -        { 0, 0, 0}
> -    },{
> -        /* Server editions */
> -        { 5, 2, "Microsoft Windows Server 2003",        "2003"},
> -        { 6, 0, "Microsoft Windows Server 2008",        "2008"},
> -        { 6, 1, "Microsoft Windows Server 2008 R2",     "2008r2"},
> -        { 6, 2, "Microsoft Windows Server 2012",        "2012"},
> -        { 6, 3, "Microsoft Windows Server 2012 R2",     "2012r2"},
> -        { 0, 0, 0},
> -        { 0, 0, 0}
> -    }
> +static const ga_matrix_lookup_t WIN_CLIENT_VERSION_MATRIX[] =3D {
> +    { 5, 0, "Microsoft Windows 2000",   "2000"},
> +    { 5, 1, "Microsoft Windows XP",     "xp"},
> +    { 6, 0, "Microsoft Windows Vista",  "vista"},
> +    { 6, 1, "Microsoft Windows 7"       "7"},
> +    { 6, 2, "Microsoft Windows 8",      "8"},
> +    { 6, 3, "Microsoft Windows 8.1",    "8.1"},
> +    { }
> +};
> +
> +static const ga_matrix_lookup_t WIN_SERVER_VERSION_MATRIX[] =3D {
> +    { 5, 2, "Microsoft Windows Server 2003",        "2003"},
> +    { 6, 0, "Microsoft Windows Server 2008",        "2008"},
> +    { 6, 1, "Microsoft Windows Server 2008 R2",     "2008r2"},
> +    { 6, 2, "Microsoft Windows Server 2012",        "2012"},
> +    { 6, 3, "Microsoft Windows Server 2012 R2",     "2012r2"},
> +    { },
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
> @@ -2191,7 +2188,8 @@ static char *ga_get_win_name(const OSVERSIONINFOEXW=
 *os_version, bool id)
>      DWORD minor =3D os_version->dwMinorVersion;
>      DWORD build =3D os_version->dwBuildNumber;
>      int tbl_idx =3D (os_version->wProductType !=3D VER_NT_WORKSTATION);
> -    const ga_matrix_lookup_t *table =3D WIN_VERSION_MATRIX[tbl_idx];
> +    const ga_matrix_lookup_t *table =3D tbl_idx ?
> +        WIN_SERVER_VERSION_MATRIX : WIN_CLIENT_VERSION_MATRIX;
>      const ga_win_10_0_t *win_10_0_table =3D tbl_idx ?
>          WIN_10_0_SERVER_VERSION_MATRIX : WIN_10_0_CLIENT_VERSION_MATRIX;
>      const ga_win_10_0_t *win_10_0_version =3D NULL;
> --
> 2.44.0
>

Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>


