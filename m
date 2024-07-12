Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2452AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 08:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSBpl-0006AQ-Bd; Fri, 12 Jul 2024 04:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBpi-00061e-UC
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBpg-0000u7-Hn
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720773647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cU7xMbmdUMnoZT03AIvzlpmQXz9nAWjhP19BzjLF5ZE=;
 b=Tj9wVwGjF+lbHmq8s9SBmbOKMx9a1jKN9GXjJzvf4e04pXBVofNUMCFzJgJSEWvbhB2258
 99DM/DYCjA31wGN4J8YjrcJP79a2qDiu7+Rge3DIWkaLBsHXVDO8uNZkjkfEvJ3OSQj0YM
 uZq195MXTylXvXSF+u2jztCwx69LpSk=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-6oFnm5ikPh6DUBISCSUrUg-1; Fri, 12 Jul 2024 04:40:45 -0400
X-MC-Unique: 6oFnm5ikPh6DUBISCSUrUg-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-e0360f8d773so3013637276.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 01:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720773644; x=1721378444;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cU7xMbmdUMnoZT03AIvzlpmQXz9nAWjhP19BzjLF5ZE=;
 b=Qp9ZWHczwZfFGHvXxSWq7aC2/SVF0YZBWMFn+i+7uIixgJYIrEjJoUBpuESJWOaUkO
 QXblSIT/beaVH18YTQ45tiwY4zET/9YjN2PaR6YaMHBr6MN4Z12ju9xLBqcm4s7URaQu
 AIRXM3Vj3WdDnTcvjIbfrOSVuur/2qH1B8IiV+FYKdOvFmZck2+vAfcE6wwreY9Fo2OC
 ApOzdHhgOJBgXgNAqCHFv6p86qfs0GKojLXs9U0j/kkuu3PDkpehhY6C1POjYdMsi1JP
 M/QkA+cKPy3CQMdIRfFLg2kSrrdG5X/dwZg5u4zdMsAyLGtwrIqnlVh43qPMa/lfWsAq
 ub2g==
X-Gm-Message-State: AOJu0YwYvi0IyHAi8KL+sxC8QW62fJsu0qqyPtoejDQwZDgY2NDnNiNi
 7KUyFNHvdGOKxF+K+F8U29wH43AprxxpGYBp4t1Bbs2wZJF97oHxTol/t5KZ4D2aCCtirHTziPq
 xtGv36SaND3PMri36ZqFZg/3Fdp0MRHeCN/u1coiG0pZj4Z9YvdZFPpgfB/SFgrJNuOJ8aw6pt8
 GaZEdAZKhgRraAESUvgJFkghfOSLZiVdlJAKAs6Q==
X-Received: by 2002:a25:ac8d:0:b0:e03:33cf:6fc9 with SMTP id
 3f1490d57ef6-e041b059873mr12188848276.20.1720773644619; 
 Fri, 12 Jul 2024 01:40:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDcRssanza1IVkCoAkbWQPOie2eljZ4h9mIHrOt+KE8FL3g6YW5Z4WwvwfLyzbUr+NJt3lqO62Sz38VQQbzbg=
X-Received: by 2002:a25:ac8d:0:b0:e03:33cf:6fc9 with SMTP id
 3f1490d57ef6-e041b059873mr12188835276.20.1720773644355; Fri, 12 Jul 2024
 01:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-10-berrange@redhat.com>
In-Reply-To: <20240613154406.1365469-10-berrange@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 12 Jul 2024 11:40:33 +0300
Message-ID: <CAPMcbCpUFQdnpT=_LR2u6FzLnfW3VnX9hE2kMUFf8ww6gKEFbA@mail.gmail.com>
Subject: Re: [PATCH v2 15/22] qga: conditionalize schema for commands
 requiring libudev
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000cf9c2d061d08d5fd"
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

--000000000000cf9c2d061d08d5fd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Thu, Jun 13, 2024 at 6:44=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> Rather than creating stubs for every command that just return
> QERR_UNSUPPORTED, use 'if' conditions in the schema to fully
> exclude generation of the filesystem trimming commands on POSIX
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
>  qga/commands-linux.c | 8 --------
>  qga/qapi-schema.json | 8 ++++----
>  2 files changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/qga/commands-linux.c b/qga/commands-linux.c
> index 73b13fbaf6..89bdcded01 100644
> --- a/qga/commands-linux.c
> +++ b/qga/commands-linux.c
> @@ -1049,14 +1049,6 @@ GuestDiskInfoList *qmp_guest_get_disks(Error **err=
p)
>      return ret;
>  }
>
> -#else
> -
> -GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}
> -
>  #endif
>
>  /* Return a list of the disk device(s)' info which @mount lies on */
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 0f27375ea0..0b7f911ca5 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -985,7 +985,7 @@
>             'media-errors-hi': 'uint64',
>             'number-of-error-log-entries-lo': 'uint64',
>             'number-of-error-log-entries-hi': 'uint64' },
> -  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
> +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV' ] } }
>
>  ##
>  # @GuestDiskSmart:
> @@ -1000,7 +1000,7 @@
>    'base': { 'type': 'GuestDiskBusType' },
>    'discriminator': 'type',
>    'data': { 'nvme': 'GuestNVMeSmart' },
> -  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
> +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV' ] } }
>
>  ##
>  # @GuestDiskInfo:
> @@ -1026,7 +1026,7 @@
>    'data': {'name': 'str', 'partition': 'bool', '*dependencies': ['str'],
>             '*address': 'GuestDiskAddress', '*alias': 'str',
>             '*smart': 'GuestDiskSmart'},
> -  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
> +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV' ] } }
>
>  ##
>  # @guest-get-disks:
> @@ -1040,7 +1040,7 @@
>  ##
>  { 'command': 'guest-get-disks',
>    'returns': ['GuestDiskInfo'],
> -  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
> +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV' ] } }
>
>  ##
>  # @GuestFilesystemInfo:
> --
> 2.45.1
>
>

--000000000000cf9c2d061d08d5fd
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
exclude generation of the filesystem trimming commands on POSIX<br>
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
=C2=A0qga/commands-linux.c | 8 --------<br>
=C2=A0qga/qapi-schema.json | 8 ++++----<br>
=C2=A02 files changed, 4 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/qga/commands-linux.c b/qga/commands-linux.c<br>
index 73b13fbaf6..89bdcded01 100644<br>
--- a/qga/commands-linux.c<br>
+++ b/qga/commands-linux.c<br>
@@ -1049,14 +1049,6 @@ GuestDiskInfoList *qmp_guest_get_disks(Error **errp)=
<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
-#else<br>
-<br>
-GuestDiskInfoList *qmp_guest_get_disks(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-=C2=A0 =C2=A0 return NULL;<br>
-}<br>
-<br>
=C2=A0#endif<br>
<br>
=C2=A0/* Return a list of the disk device(s)&#39; info which @mount lies on=
 */<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index 0f27375ea0..0b7f911ca5 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -985,7 +985,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;media-errors-hi&#39;: &#39;u=
int64&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;number-of-error-log-entries-=
lo&#39;: &#39;uint64&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;number-of-error-log-entries-=
hi&#39;: &#39;uint64&#39; },<br>
-=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39; ] } }<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LIBUDEV&#39; ] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestDiskSmart:<br>
@@ -1000,7 +1000,7 @@<br>
=C2=A0 =C2=A0&#39;base&#39;: { &#39;type&#39;: &#39;GuestDiskBusType&#39; }=
,<br>
=C2=A0 =C2=A0&#39;discriminator&#39;: &#39;type&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: { &#39;nvme&#39;: &#39;GuestNVMeSmart&#39; },<=
br>
-=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39; ] } }<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LIBUDEV&#39; ] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestDiskInfo:<br>
@@ -1026,7 +1026,7 @@<br>
=C2=A0 =C2=A0&#39;data&#39;: {&#39;name&#39;: &#39;str&#39;, &#39;partition=
&#39;: &#39;bool&#39;, &#39;*dependencies&#39;: [&#39;str&#39;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*address&#39;: &#39;GuestDis=
kAddress&#39;, &#39;*alias&#39;: &#39;str&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*smart&#39;: &#39;GuestDiskS=
mart&#39;},<br>
-=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39; ] } }<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LIBUDEV&#39; ] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-get-disks:<br>
@@ -1040,7 +1040,7 @@<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-get-disks&#39;,<br>
=C2=A0 =C2=A0&#39;returns&#39;: [&#39;GuestDiskInfo&#39;],<br>
-=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39; ] } }<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LIBUDEV&#39; ] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestFilesystemInfo:<br>
-- <br>
2.45.1<br>
<br>
</blockquote></div>

--000000000000cf9c2d061d08d5fd--


