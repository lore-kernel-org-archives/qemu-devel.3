Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216B3C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPbJ-0001bO-7f; Tue, 05 Mar 2024 02:52:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1rhPao-0001Ks-LM
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:52:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1rhPal-0000Wl-6t
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709625121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=69t9u0eprnTv+4dldzEw3cGU+1s8XW9ijzG2bmFfDYE=;
 b=OZSHcaYLOeccz2i6oJlIG9KwbEvVH0EnIozHii5+vbERT4YHw4NsTvUxoyNI7E8diFVPM5
 aVPW7stHVmskkqsC4r39eGZaBiFebWhbyH5V/XvygICGGffqcdOKW6tbus1L7iCBNM6nbm
 jV53gHDqZm62/xnW9jNBB3EXuvoh290=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-Pd8kVVM4OWCX0RLMqVCJCQ-1; Tue, 05 Mar 2024 02:50:04 -0500
X-MC-Unique: Pd8kVVM4OWCX0RLMqVCJCQ-1
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-4d353dc8d41so151083e0c.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 23:50:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709625003; x=1710229803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=69t9u0eprnTv+4dldzEw3cGU+1s8XW9ijzG2bmFfDYE=;
 b=sA1bL65ml0l8heYKywzIgtBtVqiR+pivBv6o2R0Uv0N7P8lQHpSR6cXosrNBuajCVW
 gx5ZMmXbtdU+MULwSECt/Mr0ZAvbGvl56kicGNSxp3h8V+ht3VsuiSKppd4+N/tPNf25
 ncd3wnN5k3+82eCdB4GAtuI+9eYX2AqSr529DBFmikmQb+m5ffQyVk7AFMKkybCAu/NK
 AxbrK5ami9ugnT8T4Ycj8Y30ut5z79EUO61hcD7yVH8Cu5MH5jMj/LQaFWoAzodP80fL
 6CQUz/2ZduI75I7uEQR7cogcczorRo1dD0jijnh6/nAEQHeRWmtjNuwZB0T876rojAOX
 k3WA==
X-Gm-Message-State: AOJu0Yx73hhSIveBnHsG+T2KBm7hn6ZtsElrll7BmKIOf1GPqFNIh5KF
 yluMdKBK89u22RBjgi+ZMevx+MqRDIvzU/TapZEKPpAJ62wwH7cPl03Cx7e8xJOljpyb5xcfO5R
 84cnePnFtE8/MrtGB4wEAayP8oz0iQo4C+I/Vf5R2X0tp7i32wqkNrbUkCKJ3CZ7MuTw37kuIj0
 qZqpbNP7xhliv4w4vhTUX4qnRAWhs=
X-Received: by 2002:a05:6122:2007:b0:4ca:15b2:a09b with SMTP id
 l7-20020a056122200700b004ca15b2a09bmr1012488vkd.13.1709625003645; 
 Mon, 04 Mar 2024 23:50:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFzswztjGoL1uSPcBuIU4TU6v3dbxQc9NxgONPro4apr4oSzEwjgK262aFwkQKk/kjbGx20Ylh77nYQzTOofI=
X-Received: by 2002:a05:6122:2007:b0:4ca:15b2:a09b with SMTP id
 l7-20020a056122200700b004ca15b2a09bmr1012471vkd.13.1709625003357; Mon, 04 Mar
 2024 23:50:03 -0800 (PST)
MIME-Version: 1.0
References: <20240304134532.28506-1-kkostiuk@redhat.com>
 <20240304134532.28506-2-kkostiuk@redhat.com>
In-Reply-To: <20240304134532.28506-2-kkostiuk@redhat.com>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Tue, 5 Mar 2024 09:49:51 +0200
Message-ID: <CAGoVJZyurMK+U2thF9tJntgg1v0FGsFcZHXb7-S-qqNe0Ny22A@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] qga/commands-win32: Declare const qualifier before
 type
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
> Most of the code base use the 'const' qualifier *before*
> the type being qualified. Use the same style to unify.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Message-ID: <20240222152835.72095-2-philmd@linaro.org>
> Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
>
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
> @@ -2148,18 +2148,18 @@ static ga_matrix_lookup_t const WIN_VERSION_MATRI=
X[2][7] =3D {
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
> @@ -2185,16 +2185,16 @@ static void ga_get_win_version(RTL_OSVERSIONINFOE=
XW *info, Error **errp)
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
> 2.44.0
>

Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>


