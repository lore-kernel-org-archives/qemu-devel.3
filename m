Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BA1C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 17:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6w81-0002p4-Hj; Tue, 14 May 2024 13:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s6w7v-0002oo-SD
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:39:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s6w7t-000492-Ln
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715708383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IIxMWR/3cY1HKMpESjUQGMKSQB7iXsSOYocffdPsFrc=;
 b=HH73Aa3IO1GHACmukvhBcfjI7vuYcbcmnbsgNyO58hK/POV58xMHolrenQZUwVPRAULJSD
 WahnBJPdYkuzqbXHByF5NGn+hGRvBLqOE+N2iv26PBYP9miq2tF0g7hM9XaeAkgOlMiCJ4
 W64RFoxw9YIQUXu6S6yfKHf6saQK1H8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-d4y1g2uQNseIaU5X-1xxLQ-1; Tue, 14 May 2024 13:39:42 -0400
X-MC-Unique: d4y1g2uQNseIaU5X-1xxLQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-61dfa4090c1so90859777b3.3
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 10:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715708381; x=1716313181;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IIxMWR/3cY1HKMpESjUQGMKSQB7iXsSOYocffdPsFrc=;
 b=MvBtTM7Fpk+GjdqZda7XGo2MJmh5Nu72bVUqjURZzOiUzCfe2VtoBLgW0xAPhvmVUd
 ubFEkT6IlaysMWe3a+SdqO+ncHvbaIcylr7HdY0hONN4gn5zKvofuN6JM5sl8TxmeIKD
 fHVCy2FAFTurAjiipBz3A8tp6SwZ8B1KRSjSF+NjtNct55OcKQdkNH9Xz+ylhNq2av+b
 hcY5ar9U31ymFFG2IVjQz6eW0dWIP61BNfC4uP5hUu8rMpOtttD0/fNoyr/3sq7VNgz5
 uq6AZ4OawPI9d8jy42sDJtAcdY1ROq2qfoNBVIyGbU7Y7+VrUAqnJxulGRucMMGBEzag
 oGTQ==
X-Gm-Message-State: AOJu0Yzrf0nS4dDlaB626k22nRIQG+GHr3M2X56M/ZZMNKhuzh287AYG
 X9hazlkTAfOpvyhh63hu5xK1QqeIOtPbsLL0fl9ypvrFRbcRbaHOoc69MJ1JDU23kJh/9ba4Q3n
 99Bg+uPMz9x+4dDk7EoZtDTqsbJV+TidJQV5afHQG7mAVLhs2AxIyDTx3DYhcG91rJzB/hDWHOL
 GTrXUoBWyQGW7Te3V6dRDvb9+sYd9Xv1CE1UFzFw==
X-Received: by 2002:a25:bc49:0:b0:deb:d672:db6a with SMTP id
 3f1490d57ef6-dee4f1ce8damr13835001276.5.1715708381176; 
 Tue, 14 May 2024 10:39:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRDUCMEvpIXYEReUUhok9DUbfsIw+x+8NdbDNWo95LoYI5Y3wsEqDeyDg3xqwy75CboUQ7d3JX8foEqPLuKpI=
X-Received: by 2002:a25:bc49:0:b0:deb:d672:db6a with SMTP id
 3f1490d57ef6-dee4f1ce8damr13834980276.5.1715708380863; Tue, 14 May 2024
 10:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240514105829.729342-1-armbru@redhat.com>
 <20240514105829.729342-3-armbru@redhat.com>
In-Reply-To: <20240514105829.729342-3-armbru@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Tue, 14 May 2024 20:39:30 +0300
Message-ID: <CAPMcbCqonNs5jMvDbhUd5wZFJaV+Zcdztoc425fHrYrf9+QY5Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] qga: Shorten several error messages
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, michael.roth@amd.com
Content-Type: multipart/alternative; boundary="00000000000094796806186d7c86"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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

--00000000000094796806186d7c86
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>



On Tue, May 14, 2024 at 1:58=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Some, but not all error messages are of the form
>
>     Guest agent command failed, error was '<actual error message>'
>
> For instance, command guest-exec can fail with an error message like
>
>     Guest agent command failed, error was 'Failed to execute child proces=
s
> =E2=80=9C/bin/invalid-cmd42=EF=BF=BD=E2=82=AC? (No such file or directory=
)'
>
> Shorten this to just just the actual error message.  The guest-exec
> example becomes
>
>     Failed to execute child process =E2=80=9C/bin/invalid-cmd42=EF=BF=BD=
=E2=82=AC? (No such file
> or directory)
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qga/commands-win32.c | 24 ++++++++----------------
>  qga/commands.c       |  5 ++---
>  2 files changed, 10 insertions(+), 19 deletions(-)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index ed31077457..0d1b836e87 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -278,8 +278,7 @@ static void acquire_privilege(const char *name, Error
> **errp)
>          TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY, &token))
>      {
>          if (!LookupPrivilegeValue(NULL, name, &priv.Privileges[0].Luid))=
 {
> -            error_setg(errp, QERR_QGA_COMMAND_FAILED,
> -                       "no luid for requested privilege");
> +            error_setg(errp, "no luid for requested privilege");
>              goto out;
>          }
>
> @@ -287,14 +286,12 @@ static void acquire_privilege(const char *name,
> Error **errp)
>          priv.Privileges[0].Attributes =3D SE_PRIVILEGE_ENABLED;
>
>          if (!AdjustTokenPrivileges(token, FALSE, &priv, 0, NULL, 0)) {
> -            error_setg(errp, QERR_QGA_COMMAND_FAILED,
> -                       "unable to acquire requested privilege");
> +            error_setg(errp, "unable to acquire requested privilege");
>              goto out;
>          }
>
>      } else {
> -        error_setg(errp, QERR_QGA_COMMAND_FAILED,
> -                   "failed to open privilege token");
> +        error_setg(errp, "failed to open privilege token");
>      }
>
>  out:
> @@ -308,8 +305,7 @@ static void execute_async(DWORD WINAPI
> (*func)(LPVOID), LPVOID opaque,
>  {
>      HANDLE thread =3D CreateThread(NULL, 0, func, opaque, 0, NULL);
>      if (!thread) {
> -        error_setg(errp, QERR_QGA_COMMAND_FAILED,
> -                   "failed to dispatch asynchronous command");
> +        error_setg(errp, "failed to dispatch asynchronous command");
>      }
>  }
>
> @@ -1418,22 +1414,19 @@ static void check_suspend_mode(GuestSuspendMode
> mode, Error **errp)
>
>      ZeroMemory(&sys_pwr_caps, sizeof(sys_pwr_caps));
>      if (!GetPwrCapabilities(&sys_pwr_caps)) {
> -        error_setg(errp, QERR_QGA_COMMAND_FAILED,
> -                   "failed to determine guest suspend capabilities");
> +        error_setg(errp, "failed to determine guest suspend
> capabilities");
>          return;
>      }
>
>      switch (mode) {
>      case GUEST_SUSPEND_MODE_DISK:
>          if (!sys_pwr_caps.SystemS4) {
> -            error_setg(errp, QERR_QGA_COMMAND_FAILED,
> -                       "suspend-to-disk not supported by OS");
> +            error_setg(errp, "suspend-to-disk not supported by OS");
>          }
>          break;
>      case GUEST_SUSPEND_MODE_RAM:
>          if (!sys_pwr_caps.SystemS3) {
> -            error_setg(errp, QERR_QGA_COMMAND_FAILED,
> -                       "suspend-to-ram not supported by OS");
> +            error_setg(errp, "suspend-to-ram not supported by OS");
>          }
>          break;
>      default:
> @@ -2175,8 +2168,7 @@ static void ga_get_win_version(RTL_OSVERSIONINFOEXW
> *info, Error **errp)
>      HMODULE module =3D GetModuleHandle("ntdll");
>      PVOID fun =3D GetProcAddress(module, "RtlGetVersion");
>      if (fun =3D=3D NULL) {
> -        error_setg(errp, QERR_QGA_COMMAND_FAILED,
> -            "Failed to get address of RtlGetVersion");
> +        error_setg(errp, "Failed to get address of RtlGetVersion");
>          return;
>      }
>
> diff --git a/qga/commands.c b/qga/commands.c
> index 88c1c99fe5..27b16313ea 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -475,7 +475,7 @@ GuestExec *qmp_guest_exec(const char *path,
>              guest_exec_task_setup, &has_merge, &pid, input_data ? &in_fd
> : NULL,
>              has_output ? &out_fd : NULL, has_output ? &err_fd : NULL,
> &gerr);
>      if (!ret) {
> -        error_setg(errp, QERR_QGA_COMMAND_FAILED, gerr->message);
> +        error_setg(errp, "%s", gerr->message);
>          g_error_free(gerr);
>          goto done;
>      }
> @@ -586,8 +586,7 @@ GuestTimezone *qmp_guest_get_timezone(Error **errp)
>      info =3D g_new0(GuestTimezone, 1);
>      tz =3D g_time_zone_new_local();
>      if (tz =3D=3D NULL) {
> -        error_setg(errp, QERR_QGA_COMMAND_FAILED,
> -                   "Couldn't retrieve local timezone");
> +        error_setg(errp, "Couldn't retrieve local timezone");
>          goto error;
>      }
>
> --
> 2.45.0
>
>

--00000000000094796806186d7c86
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<div><div dir=
=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div =
dir=3D"ltr"><br></div></div></div><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 14, 2024 at 1:58=E2=80=AF=
PM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Some, but not all error messages are of the form<br>
<br>
=C2=A0 =C2=A0 Guest agent command failed, error was &#39;&lt;actual error m=
essage&gt;&#39;<br>
<br>
For instance, command guest-exec can fail with an error message like<br>
<br>
=C2=A0 =C2=A0 Guest agent command failed, error was &#39;Failed to execute =
child process =E2=80=9C/bin/invalid-cmd42=EF=BF=BD=E2=82=AC? (No such file =
or directory)&#39;<br>
<br>
Shorten this to just just the actual error message.=C2=A0 The guest-exec<br=
>
example becomes<br>
<br>
=C2=A0 =C2=A0 Failed to execute child process =E2=80=9C/bin/invalid-cmd42=
=EF=BF=BD=E2=82=AC? (No such file or directory)<br>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-win32.c | 24 ++++++++----------------<br>
=C2=A0qga/commands.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5 ++---<br>
=C2=A02 files changed, 10 insertions(+), 19 deletions(-)<br>
<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index ed31077457..0d1b836e87 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -278,8 +278,7 @@ static void acquire_privilege(const char *name, Error *=
*errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY, &a=
mp;token))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!LookupPrivilegeValue(NULL, name, &am=
p;priv.Privileges[0].Luid)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, QERR_QGA_COMMAN=
D_FAILED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;no luid for requested privilege&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;no luid f=
or requested privilege&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -287,14 +286,12 @@ static void acquire_privilege(const char *name, Error=
 **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0priv.Privileges[0].Attributes =3D SE_PRIV=
ILEGE_ENABLED;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!AdjustTokenPrivileges(token, FALSE, =
&amp;priv, 0, NULL, 0)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, QERR_QGA_COMMAN=
D_FAILED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;unable to acquire requested privilege&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;unable to=
 acquire requested privilege&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, QERR_QGA_COMMAND_FAILED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;failed to open privilege token&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;failed to open privileg=
e token&quot;);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0out:<br>
@@ -308,8 +305,7 @@ static void execute_async(DWORD WINAPI (*func)(LPVOID),=
 LPVOID opaque,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0HANDLE thread =3D CreateThread(NULL, 0, func, opaque, 0=
, NULL);<br>
=C2=A0 =C2=A0 =C2=A0if (!thread) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, QERR_QGA_COMMAND_FAILED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;failed to dispatch asynchronous command&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;failed to dispatch asyn=
chronous command&quot;);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
@@ -1418,22 +1414,19 @@ static void check_suspend_mode(GuestSuspendMode mod=
e, Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0ZeroMemory(&amp;sys_pwr_caps, sizeof(sys_pwr_caps));<br=
>
=C2=A0 =C2=A0 =C2=A0if (!GetPwrCapabilities(&amp;sys_pwr_caps)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, QERR_QGA_COMMAND_FAILED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;failed to determine guest suspend capabilities&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;failed to determine gue=
st suspend capabilities&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (mode) {<br>
=C2=A0 =C2=A0 =C2=A0case GUEST_SUSPEND_MODE_DISK:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!sys_pwr_caps.SystemS4) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, QERR_QGA_COMMAN=
D_FAILED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;suspend-to-disk not supported by OS&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;suspend-t=
o-disk not supported by OS&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case GUEST_SUSPEND_MODE_RAM:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!sys_pwr_caps.SystemS3) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, QERR_QGA_COMMAN=
D_FAILED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;suspend-to-ram not supported by OS&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;suspend-t=
o-ram not supported by OS&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
@@ -2175,8 +2168,7 @@ static void ga_get_win_version(RTL_OSVERSIONINFOEXW *=
info, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0HMODULE module =3D GetModuleHandle(&quot;ntdll&quot;);<=
br>
=C2=A0 =C2=A0 =C2=A0PVOID fun =3D GetProcAddress(module, &quot;RtlGetVersio=
n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0if (fun =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, QERR_QGA_COMMAND_FAILED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Failed to get address of R=
tlGetVersion&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to get address o=
f RtlGetVersion&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
diff --git a/qga/commands.c b/qga/commands.c<br>
index 88c1c99fe5..27b16313ea 100644<br>
--- a/qga/commands.c<br>
+++ b/qga/commands.c<br>
@@ -475,7 +475,7 @@ GuestExec *qmp_guest_exec(const char *path,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0guest_exec_task_setup, &amp=
;has_merge, &amp;pid, input_data ? &amp;in_fd : NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0has_output ? &amp;out_fd : =
NULL, has_output ? &amp;err_fd : NULL, &amp;gerr);<br>
=C2=A0 =C2=A0 =C2=A0if (!ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, QERR_QGA_COMMAND_FAILED, gerr=
-&gt;message);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;%s&quot;, gerr-&gt;mess=
age);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_error_free(gerr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto done;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -586,8 +586,7 @@ GuestTimezone *qmp_guest_get_timezone(Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0info =3D g_new0(GuestTimezone, 1);<br>
=C2=A0 =C2=A0 =C2=A0tz =3D g_time_zone_new_local();<br>
=C2=A0 =C2=A0 =C2=A0if (tz =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, QERR_QGA_COMMAND_FAILED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;Couldn&#39;t retrieve local timezone&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Couldn&#39;t retrieve l=
ocal timezone&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
2.45.0<br>
<br>
</blockquote></div>

--00000000000094796806186d7c86--


