Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220C3EE645D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 07:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soefz-0002V6-QJ; Thu, 12 Sep 2024 03:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1soefv-0002F9-Tf
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:55:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1soeft-0003O2-U9
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726127731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GYuAzKRPwKXdLR51g4pTaW+DdfDDz3/bRa9ka2TBzd4=;
 b=cq39fQxoJt5jZolXUDKTxrtmammqVD+vfBphzYvVjyQcyrSiC8AkcIBP8qyOVm/y6fmstD
 /vhfoDU6TiQ2OdZbjTz5aI7cpkXejVraJN5QzbbfRRecjmbex/abB2CVvQfD7q3Ln9nMRC
 p2ooRssTiBuZI417erw9f8AQnBDo0Z8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-7MPsS6IeOMKnyZAgNEXBFg-1; Thu, 12 Sep 2024 03:55:29 -0400
X-MC-Unique: 7MPsS6IeOMKnyZAgNEXBFg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6c5135456cbso13561086d6.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 00:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726127729; x=1726732529;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GYuAzKRPwKXdLR51g4pTaW+DdfDDz3/bRa9ka2TBzd4=;
 b=Y49wVAT8z8SLwZLQaOMKd5qHeEMTewncQG9VPXQZ3yUypM99jqregln/91j/3CuIZ/
 wa2cCkOywbYbJDA0a+dmc1214+/WgsdDTUdtKhqP9U7b9YhW/nMzlWox2peFuVofTXpG
 tiqwU3TXVviTvGYzdx08vbwK6xgslvbJ7a7FYxkHtiC2eIdYdsjtIO5iIV+g8G2dHDk8
 TXISXmrhbjSDlOUQizXTs82fdr/6Yv3miwUAz5QHEwmA3on5rz0nvke2hMblklsUxgPb
 v/ufwmYlS72giT+gw74KWFbPtmAylUz5h3ogmz9T0moSgEtjVazk/YG9xcmaeg4xYPHe
 QpmQ==
X-Gm-Message-State: AOJu0YyTveYYnZ7vKBtFDXBmD2Y8nvTJ8evZwTn/LPNAs6TXlZBS4HGG
 JtHjVaGihWj69KucIYzx/dHlFbHvC6w3+MSYfqbiCuYzcJmlqQFGcs3l01QDceRiush9C+dBThB
 RK1qS0T+V7gzYRsVu6p+19bmGzm3fazba0a0Ob3+Wk1e6DuoUS/41M6oNQxKrUzJ9ep2sOPQL6H
 zoH/S3THqdSNZDBuIEUQGRFZtx+Sw=
X-Received: by 2002:a05:6214:5f0e:b0:6c5:688a:63c4 with SMTP id
 6a1803df08f44-6c573592a86mr22544496d6.51.1726127728862; 
 Thu, 12 Sep 2024 00:55:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKYSQM2o5ImHZVNioJKaVuALI4Pr8xRutuVxNDsiV3mjzY7N/hf95WvjpcFkJcFyW/GhjRLnPkCNRqUOEhdPw=
X-Received: by 2002:a05:6214:5f0e:b0:6c5:688a:63c4 with SMTP id
 6a1803df08f44-6c573592a86mr22544366d6.51.1726127728581; Thu, 12 Sep 2024
 00:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240911131206.2503035-1-armbru@redhat.com>
 <20240911131206.2503035-2-armbru@redhat.com>
In-Reply-To: <20240911131206.2503035-2-armbru@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Thu, 12 Sep 2024 10:55:17 +0300
Message-ID: <CAPMcbCqftaBMTcLVOJVh4K+Lzm9RoSOT+Xe6CcTpRe2iW+HTnw@mail.gmail.com>
Subject: Re: [PATCH 1/2] qga/qapi-schema: Drop obsolete note on "unsupported"
 errors
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, eblake@redhat.com, 
 philmd@linaro.org
Content-Type: multipart/alternative; boundary="0000000000001974300621e76ebc"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

--0000000000001974300621e76ebc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Wed, Sep 11, 2024 at 4:12=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> The note talks about "unsupported" errors and QERR_UNSUPPORTED.  The
> former is vague, and the latter makes sense only in C, not in external
> interface documentation.  Fortunately, we don't have to address this
> anymore: recent merge commit 3b5efc553eb got rid of these errors.
> Delete the note.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qga/qapi-schema.json | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 495706cf73..0537bb7886 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1,15 +1,6 @@
>  # *-*- Mode: Python -*-*
>  # vim: filetype=3Dpython
>
> -##
> -# =3D General note concerning the use of guest agent interfaces
> -#
> -# "unsupported" is a higher-level error than the errors that
> -# individual commands might document.  The caller should always be
> -# prepared to receive QERR_UNSUPPORTED, even if the given command
> -# doesn't specify it, or doesn't document any failure mode at all.
> -##
> -
>  ##
>  # =3D QEMU guest agent protocol commands and structs
>  ##
> --
> 2.46.0
>
>

--0000000000001974300621e76ebc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 1=
1, 2024 at 4:12=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@r=
edhat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">The note talks about &quot;unsupported&quot; er=
rors and QERR_UNSUPPORTED.=C2=A0 The<br>
former is vague, and the latter makes sense only in C, not in external<br>
interface documentation.=C2=A0 Fortunately, we don&#39;t have to address th=
is<br>
anymore: recent merge commit 3b5efc553eb got rid of these errors.<br>
Delete the note.<br>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/qapi-schema.json | 9 ---------<br>
=C2=A01 file changed, 9 deletions(-)<br>
<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index 495706cf73..0537bb7886 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -1,15 +1,6 @@<br>
=C2=A0# *-*- Mode: Python -*-*<br>
=C2=A0# vim: filetype=3Dpython<br>
<br>
-##<br>
-# =3D General note concerning the use of guest agent interfaces<br>
-#<br>
-# &quot;unsupported&quot; is a higher-level error than the errors that<br>
-# individual commands might document.=C2=A0 The caller should always be<br=
>
-# prepared to receive QERR_UNSUPPORTED, even if the given command<br>
-# doesn&#39;t specify it, or doesn&#39;t document any failure mode at all.=
<br>
-##<br>
-<br>
=C2=A0##<br>
=C2=A0# =3D QEMU guest agent protocol commands and structs<br>
=C2=A0##<br>
-- <br>
2.46.0<br>
<br>
</blockquote></div>

--0000000000001974300621e76ebc--


