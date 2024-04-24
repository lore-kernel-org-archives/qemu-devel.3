Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9832C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 09:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzZ1J-0005Ir-UK; Wed, 24 Apr 2024 05:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rzZ1D-0005IY-60
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 05:34:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rzZ1B-0003wr-4z
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 05:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713951260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7jnxP9geMg/2L/qjk8udop7PnrXxGQRDe36Q2tGqvUM=;
 b=H3YtlvcCDuMp+JqmvXrXVwaoheBaQ5ryCEk3rz5mnl/Iz+W5RRFmprb8InmlozW/ZqV1P9
 8RwyrvDN2BFeYacKXlToWO+lrRivSgDj42Syr3PRVUpmINDLSMyZNElxKAAiRuTYBzwfbj
 EyomR79coD0K/p6qjpezvmJbCmrRcO4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-Qyx71XjqOi6kx640FRoEYA-1; Wed, 24 Apr 2024 05:34:18 -0400
X-MC-Unique: Qyx71XjqOi6kx640FRoEYA-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6150dcdf83fso137572877b3.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 02:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713951257; x=1714556057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7jnxP9geMg/2L/qjk8udop7PnrXxGQRDe36Q2tGqvUM=;
 b=oxzRzM+uibwrnBU72S19TCeHTkKe6T5vr5Hv1ogsueW2fDRAOaayydCuYoOx4Zw7Pl
 0QqTDHvUE/xM1Ah6TAeaw/v7QOJimlScgrVGK20Wjh3ZPUowwTSUXc11aZc2e2IHprDV
 /D7PYk4ADenMbOUKLm1F2f08AjuZIIUVf1j8+ne9iDMEWBIr/jpQb0LOGwF/kEy9rsF3
 FerucFwKjrQkFVjAHuMNbHSJuP2qQ4GuB2VPVhEzAXynfmB2stNuYbbeB4m7USIKE6m1
 dRs/UdanKxePXq7yhbDA2Agd/awFmcqiZcf0AC1ROI5NcolGP8KRbxHCgUkR5VLlgrR5
 Zd5w==
X-Gm-Message-State: AOJu0YxH+Z9DNUsC2S0OdeSHTqFFxCuWN1FeIeBjrhCA5rcsA5npKher
 aVAeR6/UvnvtXwpjwEaC8cqv2GDmKmGFSiLVQpaHrHoMGGy4UCD/eaCYwmFnNuBDgQSOfrrtzEF
 3iH66Jo0vrBKeTlXzq4QN7i8l/qYH0J/xTthx4GEaFCSjE+/C+5CtsrgtEix+UxFHf5Kj8hkJNn
 HSL495JVBIf1fZ9w+QuLr89f8aDOw=
X-Received: by 2002:a05:690c:fd0:b0:615:4700:94cb with SMTP id
 dg16-20020a05690c0fd000b00615470094cbmr2455068ywb.1.1713951257493; 
 Wed, 24 Apr 2024 02:34:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX0gJSywsjFEz74c/kXNE8RWsofkSuPgoqqZAMx/XRawQKduwPY++ydfwmEk+K7PR2G2xMqVyePaN8+Cmk9oI=
X-Received: by 2002:a05:690c:fd0:b0:615:4700:94cb with SMTP id
 dg16-20020a05690c0fd000b00615470094cbmr2455051ywb.1.1713951257126; Wed, 24
 Apr 2024 02:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240320161648.158226-1-andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20240320161648.158226-1-andrey.drobyshev@virtuozzo.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 24 Apr 2024 12:34:06 +0300
Message-ID: <CAPMcbCrKw==M5PtGxYHSpxb3ozaSfONsxkK3qM38piqeuQS-HQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] qga/commands-posix: replace code duplicating
 commands with a helper
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, michael.roth@amd.com, 
 marcandre.lureau@redhat.com, philmd@linaro.org, den@virtuozzo.com
Content-Type: multipart/alternative; boundary="000000000000d7fb1d0616d45fbf"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--000000000000d7fb1d0616d45fbf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

To series:

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>


On Wed, Mar 20, 2024 at 6:17=E2=80=AFPM Andrey Drobyshev <
andrey.drobyshev@virtuozzo.com> wrote:

> v3 -> v4:
>   * Patch 1/7:
>     - Replaced "since 8.3" with "since 9.0" as we're now at v9.0.0-rc0;
>     - Renamed the field to 'total-bytes-privileged';
>     - Got rid of the implementation details in the docs;
>   * Patch 6/7: added g_autoptr macro to local error declaration.
>
> v3: https://lists.nongnu.org/archive/html/qemu-devel/2024-03/msg04068.htm=
l
>
> Andrey Drobyshev (7):
>   qga: guest-get-fsinfo: add optional 'total-bytes-privileged' field
>   qga: introduce ga_run_command() helper for guest cmd execution
>   qga/commands-posix: qmp_guest_shutdown: use ga_run_command helper
>   qga/commands-posix: qmp_guest_set_time: use ga_run_command helper
>   qga/commands-posix: execute_fsfreeze_hook: use ga_run_command helper
>   qga/commands-posix: don't do fork()/exec() when suspending via sysfs
>   qga/commands-posix: qmp_guest_set_user_password: use ga_run_command
>     helper
>
>  qga/commands-posix.c | 404 +++++++++++++++++++------------------------
>  qga/commands-win32.c |   1 +
>  qga/qapi-schema.json |   7 +-
>  3 files changed, 187 insertions(+), 225 deletions(-)
>
> --
> 2.39.3
>
>

--000000000000d7fb1d0616d45fbf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>To series:</div><div><br></div><div>Reviewed-by: Kons=
tantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com">kkostiuk@redhat.c=
om</a>&gt;</div><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Wed, Mar 20, 2024 at 6:17=E2=80=AFPM Andrey Drobyshe=
v &lt;<a href=3D"mailto:andrey.drobyshev@virtuozzo.com">andrey.drobyshev@vi=
rtuozzo.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">v3 -&gt; v4:<br>
=C2=A0 * Patch 1/7:<br>
=C2=A0 =C2=A0 - Replaced &quot;since 8.3&quot; with &quot;since 9.0&quot; a=
s we&#39;re now at v9.0.0-rc0;<br>
=C2=A0 =C2=A0 - Renamed the field to &#39;total-bytes-privileged&#39;;<br>
=C2=A0 =C2=A0 - Got rid of the implementation details in the docs;<br>
=C2=A0 * Patch 6/7: added g_autoptr macro to local error declaration.<br>
<br>
v3: <a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2024-03/msg=
04068.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nongnu.org/a=
rchive/html/qemu-devel/2024-03/msg04068.html</a><br>
<br>
Andrey Drobyshev (7):<br>
=C2=A0 qga: guest-get-fsinfo: add optional &#39;total-bytes-privileged&#39;=
 field<br>
=C2=A0 qga: introduce ga_run_command() helper for guest cmd execution<br>
=C2=A0 qga/commands-posix: qmp_guest_shutdown: use ga_run_command helper<br=
>
=C2=A0 qga/commands-posix: qmp_guest_set_time: use ga_run_command helper<br=
>
=C2=A0 qga/commands-posix: execute_fsfreeze_hook: use ga_run_command helper=
<br>
=C2=A0 qga/commands-posix: don&#39;t do fork()/exec() when suspending via s=
ysfs<br>
=C2=A0 qga/commands-posix: qmp_guest_set_user_password: use ga_run_command<=
br>
=C2=A0 =C2=A0 helper<br>
<br>
=C2=A0qga/commands-posix.c | 404 +++++++++++++++++++-----------------------=
-<br>
=C2=A0qga/commands-win32.c |=C2=A0 =C2=A01 +<br>
=C2=A0qga/qapi-schema.json |=C2=A0 =C2=A07 +-<br>
=C2=A03 files changed, 187 insertions(+), 225 deletions(-)<br>
<br>
-- <br>
2.39.3<br>
<br>
</blockquote></div>

--000000000000d7fb1d0616d45fbf--


