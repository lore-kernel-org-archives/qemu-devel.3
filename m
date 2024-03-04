Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DE7C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 12:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh702-0004gC-5s; Mon, 04 Mar 2024 07:00:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rh6zw-0004fh-L2
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:00:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rh6zu-0001A2-Ki
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:00:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709553642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5CVwbaybbAvs7uRccksOImnnt714UIk95sp84aBoyAA=;
 b=aTXpSVG7RHDloHc6rGzTqHhgJeIjt3llcjx2qajydx7MGeiP4b1eL8JyeOAEXG5wzaqtI/
 9u5hRpnvu5jpCJVxrSOss5bQ9HORXYMInnxMwZ9uE1BvR789cc44znkhBgSMvMVt9MEiBL
 jgoM2xb7xK350Bh0k1xkdDummgL3+Qo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-CmXOeJjYNOKzuW2iTHMtbQ-1; Mon, 04 Mar 2024 07:00:40 -0500
X-MC-Unique: CmXOeJjYNOKzuW2iTHMtbQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d32656e8c2so27121111fa.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 04:00:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709553638; x=1710158438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5CVwbaybbAvs7uRccksOImnnt714UIk95sp84aBoyAA=;
 b=H+27HtP0xf+IaeLTfStclRiP9009kYqXnJk3Ds4u45ThmKJrINmW6Jg7CceFZlAASW
 B2Dq210ipZXMe1LlpMy+NTM9dao51vUrvix8kllZpky6UKR4npIBOLakhzvsB5iRBO75
 +yQaen3sLT8fh04rYRz/tyBgqx891WY9/Pz9O8WojGLr1jzcTx0ggbWjOkixd0eeD87F
 618/3Il6E2VIDzngXKidfB2sao7/Uu5qXi0xVngoaEXQiSp3BVj0pK8z/l6puSCnktWA
 rB5nAcRjt25vUJ5XS+Fip0sZaTICOhLEcM6VBXAQYwjPGaAnWqM/+vLP7mWHAfznyRLN
 kuqA==
X-Gm-Message-State: AOJu0YypWbAw3oBoV2dOexViN5YMt1MD21cr4Oq8qCCusIc25D0jGdvW
 pI3i7LV/Ef5ftF5H3/clN1bQ5fnPzxTiaGSn8uRZf8apxTOFcKzwoj0BUq/uY/AohzZNXqeeOWk
 GqrcP1mlBk4vzfCku6ZsGU4CSBKkX/ESY2+NIK6yCKrHCXSEmlXSrpeJKkAIItfPwRmC+v3dtvh
 AzyqA087lrWk647UOvDH+bKrAmvTVBBYSGfG2SQw==
X-Received: by 2002:a2e:a41a:0:b0:2d3:6ff0:31b8 with SMTP id
 p26-20020a2ea41a000000b002d36ff031b8mr4666070ljn.19.1709553638624; 
 Mon, 04 Mar 2024 04:00:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELwLHZAfHfqM4FsQmRKv/hU72XBepVOpTUM3eO6366BnJWXWQlau/qFiNPfThisk7scHg63Up+bzVuym2Lo7s=
X-Received: by 2002:a2e:a41a:0:b0:2d3:6ff0:31b8 with SMTP id
 p26-20020a2ea41a000000b002d36ff031b8mr4666043ljn.19.1709553638161; Mon, 04
 Mar 2024 04:00:38 -0800 (PST)
MIME-Version: 1.0
References: <20240301172858.665135-1-andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20240301172858.665135-1-andrey.drobyshev@virtuozzo.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 4 Mar 2024 14:00:27 +0200
Message-ID: <CAPMcbCrOijMTjm+LhfGyHXjPpQs4gp3Zwh9UKoThMfVwF6e=3g@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] qga/commands-posix: replace code duplicating
 commands with a helper
To: qemu-devel@nongnu.org
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, michael.roth@amd.com, 
 marcandre.lureau@redhat.com, philmd@linaro.org, den@virtuozzo.com, 
 Dehan Meng <demeng@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000053cf4e0612d47986"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000053cf4e0612d47986
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For series
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Fri, Mar 1, 2024 at 7:29=E2=80=AFPM Andrey Drobyshev <
andrey.drobyshev@virtuozzo.com> wrote:

> v1 --> v2:
>  * Replace commit for guest-get-fsinfo: instead of reporting statvfs(3)
>    values directly, keep the old ones but add an additional optional
>    field 'total-bytes-root', only reported in POSIX.  Also tweak the
>    fields description in qga/qapi-schema.json to document where the
>    values come from.
>
> v1: https://lists.nongnu.org/archive/html/qemu-devel/2024-02/msg05766.htm=
l
>
> Andrey Drobyshev (7):
>   qga: guest-get-fsinfo: add optional 'total-bytes-root' field
>   qga: introduce ga_run_command() helper for guest cmd execution
>   qga/commands-posix: qmp_guest_shutdown: use ga_run_command helper
>   qga/commands-posix: qmp_guest_set_time: use ga_run_command helper
>   qga/commands-posix: execute_fsfreeze_hook: use ga_run_command helper
>   qga/commands-posix: use ga_run_command helper when suspending via
>     sysfs
>   qga/commands-posix: qmp_guest_set_user_password: use ga_run_command
>     helper
>
>  qga/commands-posix.c | 389 +++++++++++++++++++------------------------
>  qga/commands-win32.c |   1 +
>  qga/qapi-schema.json |  12 +-
>  3 files changed, 182 insertions(+), 220 deletions(-)
>
> --
> 2.39.3
>
>

--00000000000053cf4e0612d47986
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>For series <br></div><div>Reviewed-b=
y: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com" target=3D"=
_blank">kkostiuk@redhat.com</a>&gt;</div></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 1, 2024 at 7:29=E2=80=
=AFPM Andrey Drobyshev &lt;<a href=3D"mailto:andrey.drobyshev@virtuozzo.com=
">andrey.drobyshev@virtuozzo.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">v1 --&gt; v2:<br>
=C2=A0* Replace commit for guest-get-fsinfo: instead of reporting statvfs(3=
)<br>
=C2=A0 =C2=A0values directly, keep the old ones but add an additional optio=
nal<br>
=C2=A0 =C2=A0field &#39;total-bytes-root&#39;, only reported in POSIX.=C2=
=A0 Also tweak the<br>
=C2=A0 =C2=A0fields description in qga/qapi-schema.json to document where t=
he<br>
=C2=A0 =C2=A0values come from.<br>
<br>
v1: <a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2024-02/msg=
05766.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nongnu.org/a=
rchive/html/qemu-devel/2024-02/msg05766.html</a><br>
<br>
Andrey Drobyshev (7):<br>
=C2=A0 qga: guest-get-fsinfo: add optional &#39;total-bytes-root&#39; field=
<br>
=C2=A0 qga: introduce ga_run_command() helper for guest cmd execution<br>
=C2=A0 qga/commands-posix: qmp_guest_shutdown: use ga_run_command helper<br=
>
=C2=A0 qga/commands-posix: qmp_guest_set_time: use ga_run_command helper<br=
>
=C2=A0 qga/commands-posix: execute_fsfreeze_hook: use ga_run_command helper=
<br>
=C2=A0 qga/commands-posix: use ga_run_command helper when suspending via<br=
>
=C2=A0 =C2=A0 sysfs<br>
=C2=A0 qga/commands-posix: qmp_guest_set_user_password: use ga_run_command<=
br>
=C2=A0 =C2=A0 helper<br>
<br>
=C2=A0qga/commands-posix.c | 389 +++++++++++++++++++-----------------------=
-<br>
=C2=A0qga/commands-win32.c |=C2=A0 =C2=A01 +<br>
=C2=A0qga/qapi-schema.json |=C2=A0 12 +-<br>
=C2=A03 files changed, 182 insertions(+), 220 deletions(-)<br>
<br>
-- <br>
2.39.3<br>
<br>
</blockquote></div></div>

--00000000000053cf4e0612d47986--


