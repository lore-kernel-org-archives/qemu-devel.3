Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E26C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 17:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6w71-0002XJ-4R; Tue, 14 May 2024 13:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s6w6x-0002Wn-Fm
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:38:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s6w6u-00044M-Gf
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715708322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4C3nQ/k1YqrP55CjptBfGmzvs5E/juUYV5qQ6bWHDCM=;
 b=hkBUc5N+WhlxokzqK084CNjspmQmErYsJJJvh6PSxHjsKx9lGFROMxPvFaAfUTh4rSx+CU
 ccNJLSwQ3DehM/Y+J+U0QvMfNBSumP0Gvp4qdI/UGE8LlJryTCaOL5JzQPJKtz7D3lMzZK
 RVLDER8mt3/OUGblcsnlyXXfZZR2VJ8=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-2MG_z8y2Pfylgp339XlCiA-1; Tue, 14 May 2024 13:38:41 -0400
X-MC-Unique: 2MG_z8y2Pfylgp339XlCiA-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-de54be7066bso10335511276.0
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 10:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715708320; x=1716313120;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4C3nQ/k1YqrP55CjptBfGmzvs5E/juUYV5qQ6bWHDCM=;
 b=oeDE1UnRlY1tFlbZ6iuIB5F0vSbW5J0wq2Vj7ZHcgJyGdweBin15Loyj9nENxCNPwF
 m5vSLnUZGQBNAYEJ6SYI5jLhPYpSoUMm1AMK4frYIPavAyahbpJt9RAYPnS1TNuymXeg
 JW3tmy7/hz09v1OtTk397lowIf+0pwMTbyjdB7gbCe7shrGX2tdvGyRELV9ILkLxDJiZ
 dlRptKxlRou28PCHSWtdcD80iQ7D/sHj1Oo13l0nmwW3vXsoBu7CTTBVDFCnykYl8qxx
 9nff00WXnnfiFp3cy3WS2pFhWfUVnoucE//LoqRuFBnGvo9VmGMkq846dg8gala8YrxH
 k+sg==
X-Gm-Message-State: AOJu0Yyq7LiU/npyof/TqcmjpFEMiDphduVrok4yeVffyAv5UYw3C9uJ
 fEhG+gK27dRts1w+cw71YuFf4OepMam31QN3CIn544JXXhbPnmnMGuzvlzbZ4BPKw87nu59GVRR
 k4tzFisTiluqUU46vEfovmql/+DCcm9i03pCPSQhC2sZg7xiUtWR7R/8jsmAYd2Yfg+dRZyZ8Ir
 Bi4PSitqvTCx36YyUiYod6LWjMo64=
X-Received: by 2002:a05:6902:4:b0:de5:705d:9373 with SMTP id
 3f1490d57ef6-dee4f1b7848mr11517690276.12.1715708320450; 
 Tue, 14 May 2024 10:38:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETamkn9Ca98cQERP/e6TfSPJ6woEERCbLRWtu6U/he6eV/yevQ4o8qRv9EkxJRDy3Hyw1yIOGSEtlpv1litig=
X-Received: by 2002:a05:6902:4:b0:de5:705d:9373 with SMTP id
 3f1490d57ef6-dee4f1b7848mr11517674276.12.1715708320197; Tue, 14 May 2024
 10:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240514105829.729342-1-armbru@redhat.com>
 <20240514105829.729342-2-armbru@redhat.com>
In-Reply-To: <20240514105829.729342-2-armbru@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Tue, 14 May 2024 20:38:29 +0300
Message-ID: <CAPMcbCqKiG60inp9-c2sr3jL2xwBfJyzCgEc5erZUfs7WaYi_w@mail.gmail.com>
Subject: Re: [PATCH 1/3] qga-win32: Improve guest-set-user-password,
 guest-file-open errors
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, michael.roth@amd.com
Content-Type: multipart/alternative; boundary="000000000000f6c24f06186d78f9"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
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

--000000000000f6c24f06186d78f9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>



On Tue, May 14, 2024 at 2:03=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> When guest-set-user-password's argument @password can't be converted
> from UTF-8 to UTF-16, we report something like
>
>     Guest agent command failed, error was 'Invalid sequence in conversion
> input'
>
> Improve this to
>
>     can't convert 'password' to UTF-16: Invalid sequence in conversion
> input
>
> Likewise for argument @username, and guest-file-open argument @path,
> even though I'm not sure you can actually get invalid input past the
> QMP core there.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qga/commands-win32.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 6fee0e1e6f..ed31077457 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -217,6 +217,9 @@ int64_t qmp_guest_file_open(const char *path, const
> char *mode, Error **errp)
>
>      w_path =3D g_utf8_to_utf16(path, -1, NULL, NULL, &gerr);
>      if (!w_path) {
> +        error_setg(errp, "can't convert 'path' to UTF-16: %s",
> +                   gerr->message);
> +        g_error_free(gerr);
>          goto done;
>      }
>
> @@ -244,10 +247,6 @@ int64_t qmp_guest_file_open(const char *path, const
> char *mode, Error **errp)
>      slog("guest-file-open, handle: % " PRId64, fd);
>
>  done:
> -    if (gerr) {
> -        error_setg(errp, QERR_QGA_COMMAND_FAILED, gerr->message);
> -        g_error_free(gerr);
> -    }
>      g_free(w_path);
>      return fd;
>  }
> @@ -1946,11 +1945,17 @@ void qmp_guest_set_user_password(const char
> *username,
>
>      user =3D g_utf8_to_utf16(username, -1, NULL, NULL, &gerr);
>      if (!user) {
> +        error_setg(errp, "can't convert 'username' to UTF-16: %s",
> +                   gerr->message);
> +        g_error_free(gerr);
>          goto done;
>      }
>
>      wpass =3D g_utf8_to_utf16(rawpasswddata, -1, NULL, NULL, &gerr);
>      if (!wpass) {
> +        error_setg(errp, "can't convert 'password' to UTF-16: %s",
> +                   gerr->message);
> +        g_error_free(gerr);
>          goto done;
>      }
>
> @@ -1966,10 +1971,6 @@ void qmp_guest_set_user_password(const char
> *username,
>      }
>
>  done:
> -    if (gerr) {
> -        error_setg(errp, QERR_QGA_COMMAND_FAILED, gerr->message);
> -        g_error_free(gerr);
> -    }
>      g_free(user);
>      g_free(wpass);
>      g_free(rawpasswddata);
> --
> 2.45.0
>
>

--000000000000f6c24f06186d78f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<div><div dir=
=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div =
dir=3D"ltr"><br></div></div></div><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 14, 2024 at 2:03=E2=80=AF=
PM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">When guest-set-user-password&#39;s argument @password can&#39;t be conv=
erted<br>
from UTF-8 to UTF-16, we report something like<br>
<br>
=C2=A0 =C2=A0 Guest agent command failed, error was &#39;Invalid sequence i=
n conversion input&#39;<br>
<br>
Improve this to<br>
<br>
=C2=A0 =C2=A0 can&#39;t convert &#39;password&#39; to UTF-16: Invalid seque=
nce in conversion input<br>
<br>
Likewise for argument @username, and guest-file-open argument @path,<br>
even though I&#39;m not sure you can actually get invalid input past the<br=
>
QMP core there.<br>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-win32.c | 17 +++++++++--------<br>
=C2=A01 file changed, 9 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index 6fee0e1e6f..ed31077457 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -217,6 +217,9 @@ int64_t qmp_guest_file_open(const char *path, const cha=
r *mode, Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0w_path =3D g_utf8_to_utf16(path, -1, NULL, NULL, &amp;g=
err);<br>
=C2=A0 =C2=A0 =C2=A0if (!w_path) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;can&#39;t convert &#39;=
path&#39; to UTF-16: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gerr-=
&gt;message);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_error_free(gerr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto done;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -244,10 +247,6 @@ int64_t qmp_guest_file_open(const char *path, const ch=
ar *mode, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0slog(&quot;guest-file-open, handle: % &quot; PRId64, fd=
);<br>
<br>
=C2=A0done:<br>
-=C2=A0 =C2=A0 if (gerr) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, QERR_QGA_COMMAND_FAILED, gerr=
-&gt;message);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_error_free(gerr);<br>
-=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0g_free(w_path);<br>
=C2=A0 =C2=A0 =C2=A0return fd;<br>
=C2=A0}<br>
@@ -1946,11 +1945,17 @@ void qmp_guest_set_user_password(const char *userna=
me,<br>
<br>
=C2=A0 =C2=A0 =C2=A0user =3D g_utf8_to_utf16(username, -1, NULL, NULL, &amp=
;gerr);<br>
=C2=A0 =C2=A0 =C2=A0if (!user) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;can&#39;t convert &#39;=
username&#39; to UTF-16: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gerr-=
&gt;message);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_error_free(gerr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto done;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0wpass =3D g_utf8_to_utf16(rawpasswddata, -1, NULL, NULL=
, &amp;gerr);<br>
=C2=A0 =C2=A0 =C2=A0if (!wpass) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;can&#39;t convert &#39;=
password&#39; to UTF-16: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gerr-=
&gt;message);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_error_free(gerr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto done;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -1966,10 +1971,6 @@ void qmp_guest_set_user_password(const char *usernam=
e,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0done:<br>
-=C2=A0 =C2=A0 if (gerr) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, QERR_QGA_COMMAND_FAILED, gerr=
-&gt;message);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_error_free(gerr);<br>
-=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0g_free(user);<br>
=C2=A0 =C2=A0 =C2=A0g_free(wpass);<br>
=C2=A0 =C2=A0 =C2=A0g_free(rawpasswddata);<br>
-- <br>
2.45.0<br>
<br>
</blockquote></div>

--000000000000f6c24f06186d78f9--


