Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C29BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 08:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSBnh-0005pZ-Ij; Fri, 12 Jul 2024 04:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBnf-0005iD-MA
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:38:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBnc-0000Au-MP
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720773519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yQgQOeRxuBW2n5nC3THAbfiJ0Su8darvJOxseX1clkI=;
 b=enCeerwlndVtOr2Du+u7yH60o/Y2VEwAXJl8SC28+HNf0YvuXCeEFb60OwnA8uAQcDKXWi
 WsKoRSvpoV5LT6uZ0FiHZXB3QNR2UWmQRN5mNJnpp9Z/jo5n9v5odNSUoQ0B0NlCo5+0Gs
 bZ0CGcRpNFkWDjeYxlx4g9cwXCWeegw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-fHjXvc-3Nou44odBByCUlQ-1; Fri, 12 Jul 2024 04:38:37 -0400
X-MC-Unique: fHjXvc-3Nou44odBByCUlQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-650f5b28822so31807377b3.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 01:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720773516; x=1721378316;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yQgQOeRxuBW2n5nC3THAbfiJ0Su8darvJOxseX1clkI=;
 b=lp08DofoZarAWVun2Wu1XY54B36+DiyvyJFhiwb6aTnr1fuV9L3r9BeK0teSCUJzjx
 MAG8kmFbV6j6k7JhrL7YmbgHzBbE1MT5nsuFw8g6Mu2M/F+9+LimwuyIgRZ8/LGYk0a/
 ONk5XU7IMJ6/fC0TJnRuTwykVYs3OfpNCvUhDA760jn0af8cf5wxaGpUwOhLEwjmhmmc
 H+xNRM5TT9IgxCGrf3jIImnNvD1Xy4RkwW9CGAheq75I3VgMiYWEL92V5B6jUPzXbIlQ
 6YQmVp6mB+oQ3XiR2/8WTdgIPp2XeQf5S7Cu91tnEiaW+WgSqQp5SB8dUWfqQRNLaO/y
 yvjg==
X-Gm-Message-State: AOJu0Yyou+TuBRN9TgVt/Eat4FB2FZp0h3Rzf1LRcGr4b0Xdg/5NQKmm
 ZrcHhq3UMGyU46wk1HYwDKdArEm5lyNNJqhQ4VA+9/dv2Ez7mjrIN9xVuMhhtlnC3SIRGjbO8vu
 FcvDvNRbgtSbcA6wfnm/t0YgWuKQuO4CQyXnBk0Va3lXtuJwxWOQvJnfnnMCBn/5gFpsYtLh23F
 ht6cElfIuX7Ta5lxI/uPIzzodfRl8=
X-Received: by 2002:a0d:ee84:0:b0:64b:2701:e13e with SMTP id
 00721157ae682-658f08cc646mr113138837b3.43.1720773516570; 
 Fri, 12 Jul 2024 01:38:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc87WtHNEiPqKNNXWf6EQJUTcFpEGRXgI9KC0aGZcyK4qiZRR0rsO3FRJ0J9/8mYIrSrpFoQZvKv1Tg8uUSqU=
X-Received: by 2002:a0d:ee84:0:b0:64b:2701:e13e with SMTP id
 00721157ae682-658f08cc646mr113138737b3.43.1720773516313; Fri, 12 Jul 2024
 01:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-9-berrange@redhat.com>
In-Reply-To: <20240613154406.1365469-9-berrange@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 12 Jul 2024 11:38:25 +0300
Message-ID: <CAPMcbCpc5PHV5HEAbc10_Cf76Fes2gOpv9edLKSTBfe9DvsitA@mail.gmail.com>
Subject: Re: [PATCH v2 14/22] qga: conditionalize schema for commands
 requiring fstrim
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002ddbb5061d08cee3"
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

--0000000000002ddbb5061d08cee3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Thu, Jun 13, 2024 at 6:44=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> Rather than creating stubs for every command that just return
> QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
> fully exclude generation of the filesystem trimming commands
> on POSIX platforms lacking required APIs.
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
>  qga/commands-posix.c | 13 -------------
>  qga/qapi-schema.json |  9 ++++++---
>  2 files changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 9207cb7a8f..d92fa0ec87 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1144,22 +1144,9 @@ error:
>
>  #endif /* HAVE_GETIFADDRS */
>
> -#if !defined(CONFIG_FSTRIM)
> -GuestFilesystemTrimResponse *
> -qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}
> -#endif
> -
>  /* add unsupported commands to the list of blocked RPCs */
>  GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
>  {
> -#if !defined(CONFIG_FSTRIM)
> -    blockedrpcs =3D g_list_append(blockedrpcs, g_strdup("guest-fstrim"))=
;
> -#endif
> -
>      return blockedrpcs;
>  }
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 098fa7a08b..0f27375ea0 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -509,7 +509,8 @@
>  ##
>  { 'struct': 'GuestFilesystemTrimResult',
>    'data': {'path': 'str',
> -           '*trimmed': 'int', '*minimum': 'int', '*error': 'str'} }
> +           '*trimmed': 'int', '*minimum': 'int', '*error': 'str'},
> +  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSTRIM'] } }
>
>  ##
>  # @GuestFilesystemTrimResponse:
> @@ -519,7 +520,8 @@
>  # Since: 2.4
>  ##
>  { 'struct': 'GuestFilesystemTrimResponse',
> -  'data': {'paths': ['GuestFilesystemTrimResult']} }
> +  'data': {'paths': ['GuestFilesystemTrimResult']},
> +  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSTRIM'] } }
>
>  ##
>  # @guest-fstrim:
> @@ -541,7 +543,8 @@
>  ##
>  { 'command': 'guest-fstrim',
>    'data': { '*minimum': 'int' },
> -  'returns': 'GuestFilesystemTrimResponse' }
> +  'returns': 'GuestFilesystemTrimResponse',
> +  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSTRIM'] } }
>
>  ##
>  # @guest-suspend-disk:
> --
> 2.45.1
>
>

--0000000000002ddbb5061d08cee3
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
QERR_UNSUPPORTED, use &#39;if&#39; conditions in the QAPI schema to<br>
fully exclude generation of the filesystem trimming commands<br>
on POSIX platforms lacking required APIs.<br>
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
=C2=A0qga/commands-posix.c | 13 -------------<br>
=C2=A0qga/qapi-schema.json |=C2=A0 9 ++++++---<br>
=C2=A02 files changed, 6 insertions(+), 16 deletions(-)<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 9207cb7a8f..d92fa0ec87 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -1144,22 +1144,9 @@ error:<br>
<br>
=C2=A0#endif /* HAVE_GETIFADDRS */<br>
<br>
-#if !defined(CONFIG_FSTRIM)<br>
-GuestFilesystemTrimResponse *<br>
-qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-=C2=A0 =C2=A0 return NULL;<br>
-}<br>
-#endif<br>
-<br>
=C2=A0/* add unsupported commands to the list of blocked RPCs */<br>
=C2=A0GList *ga_command_init_blockedrpcs(GList *blockedrpcs)<br>
=C2=A0{<br>
-#if !defined(CONFIG_FSTRIM)<br>
-=C2=A0 =C2=A0 blockedrpcs =3D g_list_append(blockedrpcs, g_strdup(&quot;gu=
est-fstrim&quot;));<br>
-#endif<br>
-<br>
=C2=A0 =C2=A0 =C2=A0return blockedrpcs;<br>
=C2=A0}<br>
<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index 098fa7a08b..0f27375ea0 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -509,7 +509,8 @@<br>
=C2=A0##<br>
=C2=A0{ &#39;struct&#39;: &#39;GuestFilesystemTrimResult&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: {&#39;path&#39;: &#39;str&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*trimmed&#39;: &#39;int&#39;=
, &#39;*minimum&#39;: &#39;int&#39;, &#39;*error&#39;: &#39;str&#39;} }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*trimmed&#39;: &#39;int&#39;=
, &#39;*minimum&#39;: &#39;int&#39;, &#39;*error&#39;: &#39;str&#39;},<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_WIN32&#39;, &#39;CONFIG=
_FSTRIM&#39;] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestFilesystemTrimResponse:<br>
@@ -519,7 +520,8 @@<br>
=C2=A0# Since: 2.4<br>
=C2=A0##<br>
=C2=A0{ &#39;struct&#39;: &#39;GuestFilesystemTrimResponse&#39;,<br>
-=C2=A0 &#39;data&#39;: {&#39;paths&#39;: [&#39;GuestFilesystemTrimResult&#=
39;]} }<br>
+=C2=A0 &#39;data&#39;: {&#39;paths&#39;: [&#39;GuestFilesystemTrimResult&#=
39;]},<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_WIN32&#39;, &#39;CONFIG=
_FSTRIM&#39;] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-fstrim:<br>
@@ -541,7 +543,8 @@<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-fstrim&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: { &#39;*minimum&#39;: &#39;int&#39; },<br>
-=C2=A0 &#39;returns&#39;: &#39;GuestFilesystemTrimResponse&#39; }<br>
+=C2=A0 &#39;returns&#39;: &#39;GuestFilesystemTrimResponse&#39;,<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_WIN32&#39;, &#39;CONFIG=
_FSTRIM&#39;] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-suspend-disk:<br>
-- <br>
2.45.1<br>
<br>
</blockquote></div>

--0000000000002ddbb5061d08cee3--


