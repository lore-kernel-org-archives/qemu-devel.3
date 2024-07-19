Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BA1C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 07:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUi9k-0000Jn-I2; Fri, 19 Jul 2024 03:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sUi9i-0000BQ-Ra
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:35:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sUi9g-0007Xz-QG
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721374551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lNX2hbOaqvpUVHpd9Zf8nc3yaqcFzei+hqclPAddTy0=;
 b=aCHJmp6t7m8vILfUqdWJ9oYANDCSWtkgv1D6DPBWOQcfBxYmSO/4uSskkXtwPiGNUpKgl7
 wbvOeffZ5vGGypD3T9e1mPOCMzXlw+xRey5Z8pq9sFylKypdzJf4vHlS2/kF0XwkCcq8pE
 WwPKEXIJ25JJ86nlcXulnMV33NMt9yI=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-xZFlKk6WMg2z3F2DBCzU_A-1; Fri, 19 Jul 2024 03:35:49 -0400
X-MC-Unique: xZFlKk6WMg2z3F2DBCzU_A-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-6698f11853aso9249157b3.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 00:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721374549; x=1721979349;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lNX2hbOaqvpUVHpd9Zf8nc3yaqcFzei+hqclPAddTy0=;
 b=wbeFTsjda+V4+HGXTYhKIeMaUdUdXZdMj4HLIl0ihKiLg596uHtxnT6dI0Hwkoi9zI
 WolJT6I065jFRGvS5dHlDbKh122EwrSs5SApVh/MvwcbVNi9IKZEqG+rV/DEWVmtIh5f
 gWt8YEd1VzVKzifQzVORvZIvoDrky3Ss8Iy1HW5niMV18YNAQnrlXtvM0IDdyKYBRltD
 OlsmQ4qrXrN9G7riTN8srHiYFUePX/lFtG62JdMmGuH2OAEwPhnPCcyJkV6r7ZrCID5V
 Y8xeDHMY+2hs2IEu7hGIcuvzfwHPQVlW5qwtD8YTVJu0hOLcKxoJFHgdW7m0BLpWkz5O
 PLrQ==
X-Gm-Message-State: AOJu0Ywm5yBww5hOap2VN6TigJk0v78eRwLZ20EmYbSo0vH1UWS+1PPb
 6ZQxYRKf1INaj9E6JqKUC3NK/QqgXTkk45HJuOy1fJ2Jb3BqKQmkbl22t3UJVfuEDNlWxHiqayB
 sAqLp/RfbZadxwGsOs30om8HtRxleyJjxZYzmEQv5G8rOrYkSVMVwrH/BGLSjtCBVi2HsdGj93V
 BMLOet+y2L7qppdUlvz3KuuGLIgc+V1Hsp6Q19nw==
X-Received: by 2002:a81:a553:0:b0:62f:945a:7bb1 with SMTP id
 00721157ae682-665005735c7mr82517957b3.42.1721374549307; 
 Fri, 19 Jul 2024 00:35:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHont6Ycs0K4/EdCZ2+YhII3E8b9bI+lFe/O8CIzYWHjZhjEXRY/ELNj8liVq7Vvucj4vE2+65Dr6g6s8FzLjA=
X-Received: by 2002:a81:a553:0:b0:62f:945a:7bb1 with SMTP id
 00721157ae682-665005735c7mr82517767b3.42.1721374549028; Fri, 19 Jul 2024
 00:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240712132459.3974109-1-berrange@redhat.com>
 <20240712132459.3974109-19-berrange@redhat.com>
In-Reply-To: <20240712132459.3974109-19-berrange@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 19 Jul 2024 10:35:38 +0300
Message-ID: <CAPMcbCokwutsD4fFiDHh+ajOJs_1hfLtnyTGVL_A4AzoAhhCQQ@mail.gmail.com>
Subject: Re: [PATCH v3 18/22] qga: don't disable fsfreeze commands if vss_init
 fails
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000855000061d94be22"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

--000000000000855000061d94be22
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Fri, Jul 12, 2024 at 4:26=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> The fsfreeze commands are already written to report an error if
> vss_init() fails. Reporting a more specific error message is more
> helpful than a generic "command is disabled" message, which cannot
> between an admin config decision and lack of platform support.
>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qga/commands-win32.c | 18 +++---------------
>  qga/main.c           |  4 ++++
>  2 files changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 2533e4c748..5866cc2e3c 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -1203,7 +1203,7 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error
> **errp)
>  GuestFsfreezeStatus qmp_guest_fsfreeze_status(Error **errp)
>  {
>      if (!vss_initialized()) {
> -        error_setg(errp, QERR_UNSUPPORTED);
> +        error_setg(errp, "fsfreeze not possible as VSS failed to
> initialize");
>          return 0;
>      }
>
> @@ -1231,7 +1231,7 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool
> has_mountpoints,
>      Error *local_err =3D NULL;
>
>      if (!vss_initialized()) {
> -        error_setg(errp, QERR_UNSUPPORTED);
> +        error_setg(errp, "fsfreeze not possible as VSS failed to
> initialize");
>          return 0;
>      }
>
> @@ -1266,7 +1266,7 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
>      int i;
>
>      if (!vss_initialized()) {
> -        error_setg(errp, QERR_UNSUPPORTED);
> +        error_setg(errp, "fsfreeze not possible as VSS failed to
> initialize");
>          return 0;
>      }
>
> @@ -1961,18 +1961,6 @@ done:
>  /* add unsupported commands to the list of blocked RPCs */
>  GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
>  {
> -    if (!vss_init(true)) {
> -        g_debug("vss_init failed, vss commands are going to be disabled"=
);
> -        const char *list[] =3D {
> -            "guest-get-fsinfo", "guest-fsfreeze-status",
> -            "guest-fsfreeze-freeze", "guest-fsfreeze-thaw", NULL};
> -        char **p =3D (char **)list;
> -
> -        while (*p) {
> -            blockedrpcs =3D g_list_append(blockedrpcs, g_strdup(*p++));
> -        }
> -    }
> -
>      return blockedrpcs;
>  }
>
> diff --git a/qga/main.c b/qga/main.c
> index f4d5f15bb3..17b6ce18ac 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -1395,6 +1395,10 @@ static GAState *initialize_agent(GAConfig *config,
> int socket_activation)
>                     " '%s': %s", config->state_dir, strerror(errno));
>          return NULL;
>      }
> +
> +    if (!vss_init(true)) {
> +        g_debug("vss_init failed, vss commands will not function");
> +    }
>  #endif
>
>      if (ga_is_frozen(s)) {
> --
> 2.45.1
>
>

--000000000000855000061d94be22
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a hr=
ef=3D"mailto:kkostiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 12=
, 2024 at 4:26=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:ber=
range@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">The fsfreeze commands are already writ=
ten to report an error if<br>
vss_init() fails. Reporting a more specific error message is more<br>
helpful than a generic &quot;command is disabled&quot; message, which canno=
t<br>
between an admin config decision and lack of platform support.<br>
<br>
Reviewed-by: Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@=
linaro.org" target=3D"_blank">manos.pitsidianakis@linaro.org</a>&gt;<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-win32.c | 18 +++---------------<br>
=C2=A0qga/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++++<br>
=C2=A02 files changed, 7 insertions(+), 15 deletions(-)<br>
<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index 2533e4c748..5866cc2e3c 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -1203,7 +1203,7 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error *=
*errp)<br>
=C2=A0GuestFsfreezeStatus qmp_guest_fsfreeze_status(Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (!vss_initialized()) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;fsfreeze not possible a=
s VSS failed to initialize&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -1231,7 +1231,7 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mount=
points,<br>
=C2=A0 =C2=A0 =C2=A0Error *local_err =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!vss_initialized()) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;fsfreeze not possible a=
s VSS failed to initialize&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -1266,7 +1266,7 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!vss_initialized()) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;fsfreeze not possible a=
s VSS failed to initialize&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -1961,18 +1961,6 @@ done:<br>
=C2=A0/* add unsupported commands to the list of blocked RPCs */<br>
=C2=A0GList *ga_command_init_blockedrpcs(GList *blockedrpcs)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 if (!vss_init(true)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;vss_init failed, vss commands ar=
e going to be disabled&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *list[] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-get-fsinfo&quot;, &q=
uot;guest-fsfreeze-status&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-fsfreeze-freeze&quot=
;, &quot;guest-fsfreeze-thaw&quot;, NULL};<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 char **p =3D (char **)list;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (*p) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blockedrpcs =3D g_list_append(bl=
ockedrpcs, g_strdup(*p++));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0 =C2=A0return blockedrpcs;<br>
=C2=A0}<br>
<br>
diff --git a/qga/main.c b/qga/main.c<br>
index f4d5f15bb3..17b6ce18ac 100644<br>
--- a/qga/main.c<br>
+++ b/qga/main.c<br>
@@ -1395,6 +1395,10 @@ static GAState *initialize_agent(GAConfig *config, i=
nt socket_activation)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
; &#39;%s&#39;: %s&quot;, config-&gt;state_dir, strerror(errno));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 if (!vss_init(true)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;vss_init failed, vss commands wi=
ll not function&quot;);<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (ga_is_frozen(s)) {<br>
-- <br>
2.45.1<br>
<br>
</blockquote></div></div>

--000000000000855000061d94be22--


