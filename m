Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4511DC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 08:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSBmj-00011m-1m; Fri, 12 Jul 2024 04:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBmg-0000sn-7o
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:37:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBmd-00084d-Uz
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720773459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gSojWqzFmQ39x2ddb/5+xWj7/mJK0P8J8vM/9aefmuY=;
 b=OSPyurWxffQVaukYnSKrYPDHatlOWvaelgxWBBwNqzHTCMekw4BR+k8NI5kXyYOWoKj04Y
 uEOv8+8i085YUOseSYWIAFKZHvkcffPuUmkZE1GaAhUB32PwpEI8J+s3DDFA1WKYcix2C/
 pbN5PlBCrU2k8u6cWt39awB31FvkWYI=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-JUHNs6wRNNqS9cJPYFReuQ-1; Fri, 12 Jul 2024 04:37:34 -0400
X-MC-Unique: JUHNs6wRNNqS9cJPYFReuQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-e03a3aafc6eso2977208276.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 01:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720773454; x=1721378254;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gSojWqzFmQ39x2ddb/5+xWj7/mJK0P8J8vM/9aefmuY=;
 b=q5KsaUTos4ZFrBz7IY4bePEwbJ56i/1Rxtz3O2XJFI5hTQrtp+Eyt46h1OgEz2QIOU
 vKFqTOCzm65ojJTaCwy3EUxGPfe5MDjuG9XtjgtUb0v8U+tRVxFHknTF/so1b6xjjgwo
 5cRHHfA7hxdEkng2klq9O2sD0cZioI+YMfm9TVNwcjoSEddiZXSSHC4z6m+Eogpvhix0
 oLp87A+ZSO2LuLdcBRmIkNDwGaNN3iIjqgLOZUyxNbBjIijopejUkxKreewNTHxr2qvl
 gRQ8RraoOsC4V1kKYEV+sHU0j1gLRrDZ7Y3nwSNRJ6BFggJR5xMc0sSGebcTwZYZZeZA
 X8qQ==
X-Gm-Message-State: AOJu0Yw9D489xNKQjs2Qp/CXskHCbYsyN2r/mnRJYnWCcXxuK6wo8YMS
 UGryYb4cyyjxQmOo07E51PNZQrahcX6by89s6NxnbkiKcm+HmUrL9jS0creVhUaW1wTgjRN/b09
 bq3bX1yxT9Mgf7l27fUA/CIP/Dckft7YNlAhQpqQg5tPqdOY6UrOqci5HO7P/HAQVrLmv/dEh7w
 n2LIPHTvmwrp6yETYhC8osRL3zCPs=
X-Received: by 2002:a25:2684:0:b0:e03:5e64:e658 with SMTP id
 3f1490d57ef6-e041b07a4e4mr12452600276.32.1720773453857; 
 Fri, 12 Jul 2024 01:37:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF41LI8S4vjiYNKYfhS09m0T0AJhnmX+ddcCi8UFkzuCRmT0l1qrP6zM3dBBExHCLEvRnsn0DaSgrB5F+PpHwo=
X-Received: by 2002:a25:2684:0:b0:e03:5e64:e658 with SMTP id
 3f1490d57ef6-e041b07a4e4mr12452586276.32.1720773453597; Fri, 12 Jul 2024
 01:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-8-berrange@redhat.com>
In-Reply-To: <20240613154406.1365469-8-berrange@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 12 Jul 2024 11:37:22 +0300
Message-ID: <CAPMcbCo0i8BQpeysyzTASiWXNcKNUpOYdAeh51MQtRBuaCr76g@mail.gmail.com>
Subject: Re: [PATCH v2 13/22] qga: conditionalize schema for commands
 requiring fsfreeze
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000070e218061d08ca9a"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
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

--00000000000070e218061d08ca9a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Thu, Jun 13, 2024 at 6:44=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> Rather than creating stubs for every command that just return
> QERR_UNSUPPORTED, use 'if' conditions in the schema to fully
> exclude generation of the filesystem freezing commands on POSIX
> platforms lacking the required APIs.
>
> The command will be rejected at QMP dispatch time instead,
> avoiding reimplementing rejection by blocking the stub commands.
> This changes the error message for affected commands from
>
>     {"class": "CommandNotFound", "desc": "Command FOO has been disabled"}
>
> to
>
>     {"class": "CommandNotFound", "desc": "The command FOO has not been
> found"}
>
> This has the additional benefit that the QGA protocol reference
> now documents what conditions enable use of the command.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qga/commands-posix.c | 47 --------------------------------------------
>  qga/qapi-schema.json | 15 +++++++++-----
>  2 files changed, 10 insertions(+), 52 deletions(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index b7f96aa005..9207cb7a8f 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1144,39 +1144,6 @@ error:
>
>  #endif /* HAVE_GETIFADDRS */
>
> -#if !defined(CONFIG_FSFREEZE)
> -
> -GuestFsfreezeStatus qmp_guest_fsfreeze_status(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -
> -    return 0;
> -}
> -
> -int64_t qmp_guest_fsfreeze_freeze(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -
> -    return 0;
> -}
> -
> -int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
> -                                       strList *mountpoints,
> -                                       Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -
> -    return 0;
> -}
> -
> -int64_t qmp_guest_fsfreeze_thaw(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -
> -    return 0;
> -}
> -#endif /* CONFIG_FSFREEZE */
> -
>  #if !defined(CONFIG_FSTRIM)
>  GuestFilesystemTrimResponse *
>  qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
> @@ -1189,20 +1156,6 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum=
,
> Error **errp)
>  /* add unsupported commands to the list of blocked RPCs */
>  GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
>  {
> -#if !defined(CONFIG_FSFREEZE)
> -    {
> -        const char *list[] =3D {
> -            "guest-fsfreeze-status",
> -            "guest-fsfreeze-freeze", "guest-fsfreeze-freeze-list",
> -            "guest-fsfreeze-thaw", NULL};
> -        char **p =3D (char **)list;
> -
> -        while (*p) {
> -            blockedrpcs =3D g_list_append(blockedrpcs, g_strdup(*p++));
> -        }
> -    }
> -#endif
> -
>  #if !defined(CONFIG_FSTRIM)
>      blockedrpcs =3D g_list_append(blockedrpcs, g_strdup("guest-fstrim"))=
;
>  #endif
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 2704b814ab..098fa7a08b 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -412,7 +412,8 @@
>  # Since: 0.15.0
>  ##
>  { 'enum': 'GuestFsfreezeStatus',
> -  'data': [ 'thawed', 'frozen' ] }
> +  'data': [ 'thawed', 'frozen' ],
> +  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSFREEZE'] } }
>
>  ##
>  # @guest-fsfreeze-status:
> @@ -428,7 +429,8 @@
>  # Since: 0.15.0
>  ##
>  { 'command': 'guest-fsfreeze-status',
> -  'returns': 'GuestFsfreezeStatus' }
> +  'returns': 'GuestFsfreezeStatus',
> +  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSFREEZE'] } }
>
>  ##
>  # @guest-fsfreeze-freeze:
> @@ -450,7 +452,8 @@
>  # Since: 0.15.0
>  ##
>  { 'command': 'guest-fsfreeze-freeze',
> -  'returns': 'int' }
> +  'returns': 'int',
> +  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSFREEZE'] } }
>
>  ##
>  # @guest-fsfreeze-freeze-list:
> @@ -470,7 +473,8 @@
>  ##
>  { 'command': 'guest-fsfreeze-freeze-list',
>    'data':    { '*mountpoints': ['str'] },
> -  'returns': 'int' }
> +  'returns': 'int',
> +  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSFREEZE'] } }
>
>  ##
>  # @guest-fsfreeze-thaw:
> @@ -487,7 +491,8 @@
>  # Since: 0.15.0
>  ##
>  { 'command': 'guest-fsfreeze-thaw',
> -  'returns': 'int' }
> +  'returns': 'int',
> +  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSFREEZE'] } }
>
>  ##
>  # @GuestFilesystemTrimResult:
> --
> 2.45.1
>
>

--00000000000070e218061d08ca9a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 13, 2024 at 6:44=E2=
=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com"=
>berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">Rather than creating stubs for every command that just =
return<br>
QERR_UNSUPPORTED, use &#39;if&#39; conditions in the schema to fully<br>
exclude generation of the filesystem freezing commands on POSIX<br>
platforms lacking the required APIs.<br>
<br>
The command will be rejected at QMP dispatch time instead,<br>
avoiding reimplementing rejection by blocking the stub commands.<br>
This changes the error message for affected commands from<br>
<br>
=C2=A0 =C2=A0 {&quot;class&quot;: &quot;CommandNotFound&quot;, &quot;desc&q=
uot;: &quot;Command FOO has been disabled&quot;}<br>
<br>
to<br>
<br>
=C2=A0 =C2=A0 {&quot;class&quot;: &quot;CommandNotFound&quot;, &quot;desc&q=
uot;: &quot;The command FOO has not been found&quot;}<br>
<br>
This has the additional benefit that the QGA protocol reference<br>
now documents what conditions enable use of the command.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-posix.c | 47 -------------------------------------------=
-<br>
=C2=A0qga/qapi-schema.json | 15 +++++++++-----<br>
=C2=A02 files changed, 10 insertions(+), 52 deletions(-)<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index b7f96aa005..9207cb7a8f 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -1144,39 +1144,6 @@ error:<br>
<br>
=C2=A0#endif /* HAVE_GETIFADDRS */<br>
<br>
-#if !defined(CONFIG_FSFREEZE)<br>
-<br>
-GuestFsfreezeStatus qmp_guest_fsfreeze_status(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-<br>
-=C2=A0 =C2=A0 return 0;<br>
-}<br>
-<br>
-int64_t qmp_guest_fsfreeze_freeze(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-<br>
-=C2=A0 =C2=A0 return 0;<br>
-}<br>
-<br>
-int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strList *=
mountpoints,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **e=
rrp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-<br>
-=C2=A0 =C2=A0 return 0;<br>
-}<br>
-<br>
-int64_t qmp_guest_fsfreeze_thaw(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-<br>
-=C2=A0 =C2=A0 return 0;<br>
-}<br>
-#endif /* CONFIG_FSFREEZE */<br>
-<br>
=C2=A0#if !defined(CONFIG_FSTRIM)<br>
=C2=A0GuestFilesystemTrimResponse *<br>
=C2=A0qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)<br>
@@ -1189,20 +1156,6 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, =
Error **errp)<br>
=C2=A0/* add unsupported commands to the list of blocked RPCs */<br>
=C2=A0GList *ga_command_init_blockedrpcs(GList *blockedrpcs)<br>
=C2=A0{<br>
-#if !defined(CONFIG_FSFREEZE)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *list[] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-fsfreeze-status&quot=
;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-fsfreeze-freeze&quot=
;, &quot;guest-fsfreeze-freeze-list&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-fsfreeze-thaw&quot;,=
 NULL};<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 char **p =3D (char **)list;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (*p) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blockedrpcs =3D g_list_append(bl=
ockedrpcs, g_strdup(*p++));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-#endif<br>
-<br>
=C2=A0#if !defined(CONFIG_FSTRIM)<br>
=C2=A0 =C2=A0 =C2=A0blockedrpcs =3D g_list_append(blockedrpcs, g_strdup(&qu=
ot;guest-fstrim&quot;));<br>
=C2=A0#endif<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index 2704b814ab..098fa7a08b 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -412,7 +412,8 @@<br>
=C2=A0# Since: 0.15.0<br>
=C2=A0##<br>
=C2=A0{ &#39;enum&#39;: &#39;GuestFsfreezeStatus&#39;,<br>
-=C2=A0 &#39;data&#39;: [ &#39;thawed&#39;, &#39;frozen&#39; ] }<br>
+=C2=A0 &#39;data&#39;: [ &#39;thawed&#39;, &#39;frozen&#39; ],<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_WIN32&#39;, &#39;CONFIG=
_FSFREEZE&#39;] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-fsfreeze-status:<br>
@@ -428,7 +429,8 @@<br>
=C2=A0# Since: 0.15.0<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-fsfreeze-status&#39;,<br>
-=C2=A0 &#39;returns&#39;: &#39;GuestFsfreezeStatus&#39; }<br>
+=C2=A0 &#39;returns&#39;: &#39;GuestFsfreezeStatus&#39;,<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_WIN32&#39;, &#39;CONFIG=
_FSFREEZE&#39;] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-fsfreeze-freeze:<br>
@@ -450,7 +452,8 @@<br>
=C2=A0# Since: 0.15.0<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-fsfreeze-freeze&#39;,<br>
-=C2=A0 &#39;returns&#39;: &#39;int&#39; }<br>
+=C2=A0 &#39;returns&#39;: &#39;int&#39;,<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_WIN32&#39;, &#39;CONFIG=
_FSFREEZE&#39;] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-fsfreeze-freeze-list:<br>
@@ -470,7 +473,8 @@<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-fsfreeze-freeze-list&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;:=C2=A0 =C2=A0 { &#39;*mountpoints&#39;: [&#39;s=
tr&#39;] },<br>
-=C2=A0 &#39;returns&#39;: &#39;int&#39; }<br>
+=C2=A0 &#39;returns&#39;: &#39;int&#39;,<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_WIN32&#39;, &#39;CONFIG=
_FSFREEZE&#39;] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-fsfreeze-thaw:<br>
@@ -487,7 +491,8 @@<br>
=C2=A0# Since: 0.15.0<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-fsfreeze-thaw&#39;,<br>
-=C2=A0 &#39;returns&#39;: &#39;int&#39; }<br>
+=C2=A0 &#39;returns&#39;: &#39;int&#39;,<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_WIN32&#39;, &#39;CONFIG=
_FSFREEZE&#39;] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestFilesystemTrimResult:<br>
-- <br>
2.45.1<br>
<br>
</blockquote></div>

--00000000000070e218061d08ca9a--


