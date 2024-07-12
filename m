Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71198C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 08:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSBsl-0000mB-Hu; Fri, 12 Jul 2024 04:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBsW-0008Uu-IP
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:43:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBsU-0001vo-Fc
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720773817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XCO2KchFl25utxlkQyBW/M2Ln6RYUq1Lpgysq2NeLno=;
 b=RqxHc6EjtGxwPLhZeabITO9qYQDFa6t+taCxtaO9E1OcSy4WUPTYg0qB1f8x4dpIOMoqbw
 95lLt109BvHynsB1E/7j+RJ2W1xki+FRoZna6/GpFDsQNg/JIz3HmwSzIy5NYYhwVOANsB
 7f2uP0gdmoJ3RZzcT01K8962Sj9SlvU=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-21FcbEvqOu-KjMbt-NEk5g-1; Fri, 12 Jul 2024 04:43:36 -0400
X-MC-Unique: 21FcbEvqOu-KjMbt-NEk5g-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e03a59172dbso2989362276.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 01:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720773815; x=1721378615;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XCO2KchFl25utxlkQyBW/M2Ln6RYUq1Lpgysq2NeLno=;
 b=Q31x4lXvYC9X8/MoNk7sOv6z3Unvmf50CVK/HcEt6Gf072LV/3ZlvyLbN56SHh7bdS
 sJvkeP8ffbHT4GK5TpkWUtDp6XHcgNzuDKWJnn5ngxSdMDWjpi3XfzSUHOKhNlQvorek
 Z5HlpFiCOYsZmp9ByqiieaN6gJeikdIjkiqZLJ0D8CumHEwvMeYZXO3TJB6hvy9p3+9o
 yDrPS1hzO+fEyGPC8R/S/BHsYXXpBOJpA07Xefv4M5Ave2tS164jcnAvfGz/hm1/zNvy
 SEcL+51XNIeW1TQq66dr2x60Tj8hQl/0hfAtJEklPrMkM8YJ/v7ixPzNN8hSQ6t+Pt4b
 1QRg==
X-Gm-Message-State: AOJu0YwDHf/i6LhbrOYuHPq8DlGlyFYK9slXtpZnD6400+EyxQeTrv5D
 28QM7IOmddqCsisqpL0XovHJWF74eITTY7I7+UEqiysC+5OJzb+UeQZUqHJZrDqSppuzllft/IM
 fhws1kBBwswGpVNVLUchZIH+TIY6AktcYN/oqMAj3klLl7DjuSk7SejZXM/5qHTJwqDjEn8dQ69
 u0sxyYxjfpYysp8shekCYmvERm9PI=
X-Received: by 2002:a05:6902:18d1:b0:e05:7ba1:5a7c with SMTP id
 3f1490d57ef6-e057ba15b61mr6432950276.45.1720773815710; 
 Fri, 12 Jul 2024 01:43:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEULWEV7b1RymaPa6sIuGZGbHXlNWNC4p6OZg11nt3imtxhnLxb0zEmrgAfDBRqt3Oot88QTKy5f1K9T+fQuW0=
X-Received: by 2002:a05:6902:18d1:b0:e05:7ba1:5a7c with SMTP id
 3f1490d57ef6-e057ba15b61mr6432933276.45.1720773815444; Fri, 12 Jul 2024
 01:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-11-berrange@redhat.com>
In-Reply-To: <20240613154406.1365469-11-berrange@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 12 Jul 2024 11:43:24 +0300
Message-ID: <CAPMcbCoCAVAxRu4HE+EKUNG2NemNsKCiqEhfS1CCFLhaZr3r4Q@mail.gmail.com>
Subject: Re: [PATCH v2 16/22] qga: conditionalize schema for commands
 requiring utmpx
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000236e7061d08e075"
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

--0000000000000236e7061d08e075
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Thu, Jun 13, 2024 at 6:44=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> Rather than creating stubs for every command that just return
> QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
> fully exclude generation of the get-users command on POSIX
> platforms lacking required APIs.
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
>  qga/commands-posix.c | 10 +---------
>  qga/qapi-schema.json |  6 ++++--
>  2 files changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index d92fa0ec87..a353f64ae6 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1212,15 +1212,7 @@ GuestUserList *qmp_guest_get_users(Error **errp)
>      return head;
>  }
>
> -#else
> -
> -GuestUserList *qmp_guest_get_users(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}
> -
> -#endif
> +#endif /* HAVE_UTMPX */
>
>  /* Replace escaped special characters with their real values. The
> replacement
>   * is done in place -- returned value is in the original string.
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 0b7f911ca5..70d4f173ad 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1413,7 +1413,8 @@
>  # Since: 2.10
>  ##
>  { 'struct': 'GuestUser',
> -  'data': { 'user': 'str', 'login-time': 'number', '*domain': 'str' } }
> +  'data': { 'user': 'str', 'login-time': 'number', '*domain': 'str' },
> +  'if': { 'any': ['CONFIG_WIN32', 'HAVE_UTMPX' ] } }
>
>  ##
>  # @guest-get-users:
> @@ -1425,7 +1426,8 @@
>  # Since: 2.10
>  ##
>  { 'command': 'guest-get-users',
> -  'returns': ['GuestUser'] }
> +  'returns': ['GuestUser'],
> +  'if': { 'any': ['CONFIG_WIN32', 'HAVE_UTMPX' ] } }
>
>  ##
>  # @GuestTimezone:
> --
> 2.45.1
>
>

--0000000000000236e7061d08e075
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
fully exclude generation of the get-users command on POSIX<br>
platforms lacking required APIs.<br>
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
=C2=A0qga/commands-posix.c | 10 +---------<br>
=C2=A0qga/qapi-schema.json |=C2=A0 6 ++++--<br>
=C2=A02 files changed, 5 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index d92fa0ec87..a353f64ae6 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -1212,15 +1212,7 @@ GuestUserList *qmp_guest_get_users(Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0return head;<br>
=C2=A0}<br>
<br>
-#else<br>
-<br>
-GuestUserList *qmp_guest_get_users(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-=C2=A0 =C2=A0 return NULL;<br>
-}<br>
-<br>
-#endif<br>
+#endif /* HAVE_UTMPX */<br>
<br>
=C2=A0/* Replace escaped special characters with their real values. The rep=
lacement<br>
=C2=A0 * is done in place -- returned value is in the original string.<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index 0b7f911ca5..70d4f173ad 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -1413,7 +1413,8 @@<br>
=C2=A0# Since: 2.10<br>
=C2=A0##<br>
=C2=A0{ &#39;struct&#39;: &#39;GuestUser&#39;,<br>
-=C2=A0 &#39;data&#39;: { &#39;user&#39;: &#39;str&#39;, &#39;login-time&#3=
9;: &#39;number&#39;, &#39;*domain&#39;: &#39;str&#39; } }<br>
+=C2=A0 &#39;data&#39;: { &#39;user&#39;: &#39;str&#39;, &#39;login-time&#3=
9;: &#39;number&#39;, &#39;*domain&#39;: &#39;str&#39; },<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_WIN32&#39;, &#39;HAVE_U=
TMPX&#39; ] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-get-users:<br>
@@ -1425,7 +1426,8 @@<br>
=C2=A0# Since: 2.10<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-get-users&#39;,<br>
-=C2=A0 &#39;returns&#39;: [&#39;GuestUser&#39;] }<br>
+=C2=A0 &#39;returns&#39;: [&#39;GuestUser&#39;],<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_WIN32&#39;, &#39;HAVE_U=
TMPX&#39; ] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestTimezone:<br>
-- <br>
2.45.1<br>
<br>
</blockquote></div>

--0000000000000236e7061d08e075--


