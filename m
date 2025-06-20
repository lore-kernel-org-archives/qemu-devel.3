Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D05C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 12:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSaqA-000711-He; Fri, 20 Jun 2025 08:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1uSaq7-00070L-V5
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:27:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1uSaq5-00089y-Pq
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750422444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rV5zQIyqDjNAC11vowRalPjH1E2sTSQ8IIHvMggJ0PI=;
 b=TrA7lxYBp1E61AaWwAv1ps1mlCmbXY1KRjpCwEkml2piehXSnbm7vnrSNRaBF+rBD3Y0nU
 2eKqoRT+KFX8CLmdM4ltMLulLdxGIJ8MruP8cheJvtIAqNwDeWEHjfOt97CUk2LnedpgbS
 12wZxCtZV+hfl7Qy+T+NZ9Qv8cv+D7I=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-p6ppniegOaGpJt7MQUNVdw-1; Fri, 20 Jun 2025 08:27:22 -0400
X-MC-Unique: p6ppniegOaGpJt7MQUNVdw-1
X-Mimecast-MFC-AGG-ID: p6ppniegOaGpJt7MQUNVdw_1750422440
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-70e33aeaad4so21421317b3.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 05:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750422440; x=1751027240;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rV5zQIyqDjNAC11vowRalPjH1E2sTSQ8IIHvMggJ0PI=;
 b=jNekJZ34f+IWWeeTs9RAh5EGbLo5jjfpzu2x2+Wvf8PGk2rd94k6/7ycSQn/1z/HXf
 tWJ3TMKtGb0VknjWbqvY7jqCK4dAyAv/bx/pNRliE1mimDrYfv/XjqZxLxmy8RK96sDA
 mlBAhzU0WI0hMLDSJyAPfN8+r2G16RTwCi8wlXITkynXVYBa4Yf6mid2J/Jocze/1ilk
 YNUpFVzyik32Hj0c+uHiPOzAbHflumTa4xKCHjuDdgXZ8RF2BkL3OKLRVm9Ll7PTPkSJ
 ReRTxeMB+vzlc4vk4AjZ/sOGJvrBtUx0KKo9VN2OI9HSLV0YyyqKXh7jtuSlpJ3AXHEv
 cMTg==
X-Gm-Message-State: AOJu0Ywt7vMXmRwMkDt5MnaE+x6oZ8PGN0wFE51blWu/eOGfyVwp7KvK
 f8/O/qr99igXx6oh5CmoaMJc9rFydPbdPQo/1HAedBOfmIwBBoMhP3w8NRMwHV7lSCC8c65LU/K
 S5iKoH1kflicyZWAsbduF4oys8UNceYlKOa34TGLZFqomaTJJDTsKZlDHCdt6ROZYwueoKShXYQ
 NIysansYa2ir3R0J9myeT/Ss67vkiX89o91FejcDEqO7ty
X-Gm-Gg: ASbGncugGqzb5AKmg5Qig5JjPBDtgWfNxbMTNZQN1ajEEGT/xugxuixDSXkOKYaQamv
 gGO9lPH6t60c88io6UW/mrzXkP8O7ssZ37oorQAX3s9GQ5nzEiHIZNA0hBhPJU1zUW1ltIWD94b
 Q1gsg=
X-Received: by 2002:a05:690c:6890:b0:70e:29d2:fba1 with SMTP id
 00721157ae682-712c64e5763mr38375327b3.23.1750422440220; 
 Fri, 20 Jun 2025 05:27:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdy/y7utJKvXN5FWPyW9+LZo4kPvEiueNGPUcFrB+ksg+qg0Z3BVA1paX1isgDAVU8yFgstFBWZfP8ZqyGwzM=
X-Received: by 2002:a05:690c:6890:b0:70e:29d2:fba1 with SMTP id
 00721157ae682-712c64e5763mr38375027b3.23.1750422439780; Fri, 20 Jun 2025
 05:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250620102140.38556-1-kkostiuk@redhat.com>
In-Reply-To: <20250620102140.38556-1-kkostiuk@redhat.com>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Fri, 20 Jun 2025 16:27:08 +0400
X-Gm-Features: AX0GCFuWzmHCFcQCJjz_jRrTOat8dkTYuTf4DVvSCbdCqhid-9aItbPOsg5fP00
Message-ID: <CAGoVJZw=itB_sZ4k+VjWMZ5k6ViT1NRmrFJ-A7XtJ1oPenPHbQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update Kostiantyn Kostiuk transliteration
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000bb2ab70637fffb4e"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000bb2ab70637fffb4e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+1

Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>

On Fri, Jun 20, 2025 at 2:23=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@redhat=
.com>
wrote:

> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 94c4076127..3e7ca85c55 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3370,7 +3370,7 @@ T: git https://repo.or.cz/qemu/armbru.git qapi-next
>
>  QEMU Guest Agent
>  M: Michael Roth <michael.roth@amd.com>
> -M: Konstantin Kostiuk <kkostiuk@redhat.com>
> +M: Kostiantyn Kostiuk <kkostiuk@redhat.com>
>  S: Maintained
>  F: qga/
>  F: contrib/systemd/qemu-guest-agent.service
> @@ -3381,7 +3381,7 @@ F: tests/*/test-qga*
>  T: git https://github.com/mdroth/qemu.git qga
>
>  QEMU Guest Agent Win32
> -M: Konstantin Kostiuk <kkostiuk@redhat.com>
> +M: Kostiantyn Kostiuk <kkostiuk@redhat.com>
>  S: Maintained
>  F: qga/*win32*
>  F: qga/vss-win32/
> --
> 2.48.1
>
>
>

--000000000000bb2ab70637fffb4e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">+1<br><div><br></div><div>Reviewed-by: Yan Vugenfirer &lt;=
<a href=3D"mailto:yvugenfi@redhat.com">yvugenfi@redhat.com</a>&gt;</div></d=
iv><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Fri, Jun 20, 2025 at 2:23=E2=80=AFPM Kostiantyn Kosti=
uk &lt;<a href=3D"mailto:kkostiuk@redhat.com">kkostiuk@redhat.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb=
(204,204,204);padding-left:1ex">Signed-off-by: Kostiantyn Kostiuk &lt;<a hr=
ef=3D"mailto:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>=
&gt;<br>
---<br>
=C2=A0MAINTAINERS | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 94c4076127..3e7ca85c55 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -3370,7 +3370,7 @@ T: git <a href=3D"https://repo.or.cz/qemu/armbru.git"=
 rel=3D"noreferrer" target=3D"_blank">https://repo.or.cz/qemu/armbru.git</a=
> qapi-next<br>
<br>
=C2=A0QEMU Guest Agent<br>
=C2=A0M: Michael Roth &lt;<a href=3D"mailto:michael.roth@amd.com" target=3D=
"_blank">michael.roth@amd.com</a>&gt;<br>
-M: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com" target=3D=
"_blank">kkostiuk@redhat.com</a>&gt;<br>
+M: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com" target=3D=
"_blank">kkostiuk@redhat.com</a>&gt;<br>
=C2=A0S: Maintained<br>
=C2=A0F: qga/<br>
=C2=A0F: contrib/systemd/qemu-guest-agent.service<br>
@@ -3381,7 +3381,7 @@ F: tests/*/test-qga*<br>
=C2=A0T: git <a href=3D"https://github.com/mdroth/qemu.git" rel=3D"noreferr=
er" target=3D"_blank">https://github.com/mdroth/qemu.git</a> qga<br>
<br>
=C2=A0QEMU Guest Agent Win32<br>
-M: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com" target=3D=
"_blank">kkostiuk@redhat.com</a>&gt;<br>
+M: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com" target=3D=
"_blank">kkostiuk@redhat.com</a>&gt;<br>
=C2=A0S: Maintained<br>
=C2=A0F: qga/*win32*<br>
=C2=A0F: qga/vss-win32/<br>
-- <br>
2.48.1<br>
<br>
<br>
</blockquote></div>

--000000000000bb2ab70637fffb4e--


