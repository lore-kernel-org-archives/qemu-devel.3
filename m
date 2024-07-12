Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470AEC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 09:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSCfB-0004H8-FV; Fri, 12 Jul 2024 05:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSCf9-0004GI-FM
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:33:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSCf7-0007dn-7I
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720776834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EPMIPqRt+NO1utoJ9LZWfos/cfn8dF8tCoYKToSpJY8=;
 b=MVChQZG0AgE2r6WeGTYO0WLrkH+YG/CkQB0tMJSfpbox38yqbjQDV0a3rl8rt+k/wxKF5u
 4Bq6UqkUZwN0xbngWK8FtfwQ9nCdQZtCpjtGFhpN0V29NkqVuR0ToI1jsHxr/ApWdPAjOv
 IufQyPpJysls8MQ0/Id8HA+e7TLz0xQ=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-O1Au8WQoP7SycdEcuKHQtw-1; Fri, 12 Jul 2024 05:33:50 -0400
X-MC-Unique: O1Au8WQoP7SycdEcuKHQtw-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-e03a544b9c8so2987099276.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 02:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720776830; x=1721381630;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EPMIPqRt+NO1utoJ9LZWfos/cfn8dF8tCoYKToSpJY8=;
 b=NIqXyY3vu9tGkPIu2XI9rmpObxls3HuKiAG9WTKlI1v21yHsqQrkI7lsAbtJbzQneT
 3+CP8A8cmvubNq40D4thxY5SCZOGN8gamCr5YSUUSg3P5+pE9mYv/2lG1ykxJMCDt8nf
 iivZ7v8wRA9Q98FaqivzGPmeixk9wYsqCjbrMz/Q3BYJ4/W1VA+Hhj6g02myBZWiln3r
 sYpqxcnvMd5ZsfJEWg0rndKWpbjntJ3EZGsXx/J0yjk9ZPNfI5CrfgwSF1z6Eecm9S/F
 cPjpWC8LlfcVNO1mUpDA9mztPYuRWWDIEkqnH3ejfVj+71QWJq/BiY9glwESLQNpy/d5
 pxdA==
X-Gm-Message-State: AOJu0Ywl68lLKtn8Hv6j9VWGFmQAEWzdmCop2YGbzscot1rgrvfVc91L
 8JPVYVBiSjDq9zK2yHMFCL1fm0y+NT567ShG9vbvhGhLLGRjBAVKGO9yWqzdcQcOt4/fk8nqCS5
 //a6uLAaHsGJMt7KC5RVIyYELDylLoJceZY6ILzEjRNj3GyCvtOKrvns5zMO0sR6j8yPOUyZnyp
 FZYujxUFchj8idYiuC+75qV3qGuPU=
X-Received: by 2002:a25:bfc9:0:b0:e02:b7d6:c97 with SMTP id
 3f1490d57ef6-e041b03d1b1mr13192055276.8.1720776830187; 
 Fri, 12 Jul 2024 02:33:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFtinr4Y4VGNCP+RD1URafqpB7vJLOuVm8BhnvxCv5mYWUSjrKjHNBtCl5NRaFKIRVY0LUJyroL3zdWeA5DAo=
X-Received: by 2002:a25:bfc9:0:b0:e02:b7d6:c97 with SMTP id
 3f1490d57ef6-e041b03d1b1mr13192042276.8.1720776829887; Fri, 12 Jul 2024
 02:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613150127.1361931-2-berrange@redhat.com>
In-Reply-To: <20240613150127.1361931-2-berrange@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 12 Jul 2024 12:33:39 +0300
Message-ID: <CAPMcbCoiPJHqurkhMraOodUu8Ks8srGG1yJR33wbDAKbOVGHzA@mail.gmail.com>
Subject: Re: [PATCH v2 01/22] qga: drop blocking of guest-get-memory-block-size
 command
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000aefad6061d099357"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

--000000000000aefad6061d099357
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Thu, Jun 13, 2024 at 6:01=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> This command has never existed in tree, since it was renamed to
> guest-get-memory-block-info before being merged.
>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qga/commands-posix.c | 2 +-
>  qga/commands-win32.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 7f05996495..76af98ba32 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -3099,7 +3099,7 @@ GList *ga_command_init_blockedrpcs(GList
> *blockedrpcs)
>              "guest-suspend-disk", "guest-suspend-ram",
>              "guest-suspend-hybrid", "guest-get-vcpus", "guest-set-vcpus"=
,
>              "guest-get-memory-blocks", "guest-set-memory-blocks",
> -            "guest-get-memory-block-size", "guest-get-memory-block-info"=
,
> +            "guest-get-memory-block-info",
>              NULL};
>          char **p =3D (char **)list;
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 0d1b836e87..9fe670d5b4 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -1995,7 +1995,7 @@ GList *ga_command_init_blockedrpcs(GList
> *blockedrpcs)
>          "guest-suspend-hybrid",
>          "guest-set-vcpus",
>          "guest-get-memory-blocks", "guest-set-memory-blocks",
> -        "guest-get-memory-block-size", "guest-get-memory-block-info",
> +        "guest-get-memory-block-info",
>          NULL};
>      char **p =3D (char **)list_unsupported;
>
> --
> 2.45.1
>
>

--000000000000aefad6061d099357
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 13, 2024 at 6:01=E2=
=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com"=
>berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">This command has never existed in tree, since it was re=
named to<br>
guest-get-memory-block-info before being merged.<br>
<br>
Reviewed-by: Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@=
linaro.org" target=3D"_blank">manos.pitsidianakis@linaro.org</a>&gt;<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-posix.c | 2 +-<br>
=C2=A0qga/commands-win32.c | 2 +-<br>
=C2=A02 files changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 7f05996495..76af98ba32 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -3099,7 +3099,7 @@ GList *ga_command_init_blockedrpcs(GList *blockedrpcs=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;guest-suspend-disk&qu=
ot;, &quot;guest-suspend-ram&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;guest-suspend-hybrid&=
quot;, &quot;guest-get-vcpus&quot;, &quot;guest-set-vcpus&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;guest-get-memory-bloc=
ks&quot;, &quot;guest-set-memory-blocks&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-get-memory-block-siz=
e&quot;, &quot;guest-get-memory-block-info&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-get-memory-block-inf=
o&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL};<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char **p =3D (char **)list;<br>
<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index 0d1b836e87..9fe670d5b4 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -1995,7 +1995,7 @@ GList *ga_command_init_blockedrpcs(GList *blockedrpcs=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;guest-suspend-hybrid&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;guest-set-vcpus&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;guest-get-memory-blocks&quot;, &quo=
t;guest-set-memory-blocks&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-get-memory-block-size&quot;, &quot=
;guest-get-memory-block-info&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-get-memory-block-info&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL};<br>
=C2=A0 =C2=A0 =C2=A0char **p =3D (char **)list_unsupported;<br>
<br>
-- <br>
2.45.1<br>
<br>
</blockquote></div>

--000000000000aefad6061d099357--


