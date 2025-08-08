Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CBFC87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 08:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukIHR-0004rv-EC; Fri, 08 Aug 2025 04:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ukIHF-0004pS-F5
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:16:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ukIHD-0007pA-ND
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754640994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1KGzXk0uwO0j8Y3uo1n9TznX/GhqMaJcnMpbo5o4vbQ=;
 b=U821EYAfq8Fu+qyp9SokNzLu1fg0QaASXMdmLH0+OsDpX1oniSNxSGZW7LGm/OdPqJzWsf
 glHFGQg6uBHW7OojskgNJjVqILnMlGpIoIDi51oaKO/4MQ4zksHbKVKgZD10q2z8A5mKDT
 h5EQnUD/GxqohcedvC395vzVgbjxF/w=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-Vr861STTNBidejc5vumJLw-1; Fri, 08 Aug 2025 04:16:32 -0400
X-MC-Unique: Vr861STTNBidejc5vumJLw-1
X-Mimecast-MFC-AGG-ID: Vr861STTNBidejc5vumJLw_1754640992
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31f322718faso1520522a91.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 01:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754640991; x=1755245791;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1KGzXk0uwO0j8Y3uo1n9TznX/GhqMaJcnMpbo5o4vbQ=;
 b=MiuoEq7Z+HNxHU2HcM86TsOumYhrvY1+BiGmUnrNtFltZMO02r6y81HFAEBHDgJ5y2
 3PkrxUDd1PzvKrbTOhBL2swFwsgsBvE7vhIH7/eJ9MY32Pck9U3VZ70V3+7QxKeE2i1R
 8ITh5W+28muZivp4c7DZu4889x/S29hZ/xMa+ri+SvXqYrzjRooYCwJsbEKC/Kt+U5ZA
 uyuK/55A57A8rRwYi+D4lTqlSw1j9+Y6BE5NUkkk/hlRgCw40NksQE9iM+aNKt93dkq6
 NZ0mm9EKxSysWId252sB9nlhlQDsk/HfVydF5/P89JuJkeAgJQmk9peM9jkOIQ6dZOyU
 lMLw==
X-Gm-Message-State: AOJu0YzfyftuXvFs2ifiMxA9QkYwdQsRSY4FmOVIYv5tLykme7t0JpAr
 ax+xWtKq5F6ejYUzrXzFbJGuUKelGNKZK3whrTgl3OV7Jomsm5ArNrEdDTaHqz/Ueh2ou4a0p7b
 NabbDgunQYxoqkIACWzV3P1drEzrqISilQ0w7oG2xLtZSDXAesPZBKtHZLq+VkwCmsFqRRqTI27
 9SmYxGPjgtBGD/51Ypq/fpBsW1GB7ZIRKn3ywKjPr6bLUL
X-Gm-Gg: ASbGnct4RyzCxjY0a2xE33ODZGuwg0GDCxfIlfMubOOCJtRcVBktM/eezzuhGfE6jZ/
 bqE3z2t/Un/I/RL3c833BPcUn8qKeobGeEeZa8KKNewaeaWP+6Si38K96ctKriEHA6f3QYH+o/+
 as3atEvkwpg+IhCT/DAejFhw==
X-Received: by 2002:a17:90a:d40c:b0:31e:e88b:ee0d with SMTP id
 98e67ed59e1d1-321839e01cfmr3294749a91.9.1754640991398; 
 Fri, 08 Aug 2025 01:16:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYP8tMlSI4iQqtXRbPgyjkMC18BgsJa8Kc4nf19gBcIEDCR3b/ixQLvummx5PJ168Mh7c7NDwA9Csf3vDCE+o=
X-Received: by 2002:a17:90a:d40c:b0:31e:e88b:ee0d with SMTP id
 98e67ed59e1d1-321839e01cfmr3294719a91.9.1754640990937; Fri, 08 Aug 2025
 01:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-10-armbru@redhat.com>
In-Reply-To: <20250808080823.2638861-10-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 8 Aug 2025 12:16:18 +0400
X-Gm-Features: Ac12FXw3Z94REmT5Gi2jyRaQ8UvWWlDpYAKcomASd750Tt4t80YEnfYxqOteAQ0
Message-ID: <CAMxuvawfaJ+hcgtPdHdArPZ5vmjsbMqC+GwtByC5uw6=LvGDRA@mail.gmail.com>
Subject: Re: [PATCH 09/12] ui/pixman: Consistent error handling in
 qemu_pixman_shareable_free()
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp
Content-Type: multipart/alternative; boundary="000000000000f938f9063bd6306a"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000f938f9063bd6306a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Aug 8, 2025 at 12:08=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> qemu_pixman_shareable_free() wraps around either qemu_memfd_free() or
> qemu_win32_map_free().  The former reports trouble as error, with
> error_report(), then succeeds.  The latter reports it as warning (we
> pass it &error_warn), then succeeds.
>
> Change the latter to report as error, too.
>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

lgtm, thanks

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  ui/qemu-pixman.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
> index ef4e71da11..e46c6232cf 100644
> --- a/ui/qemu-pixman.c
> +++ b/ui/qemu-pixman.c
> @@ -288,7 +288,10 @@ qemu_pixman_shareable_free(qemu_pixman_shareable
> handle,
>                             void *ptr, size_t size)
>  {
>  #ifdef WIN32
> -    qemu_win32_map_free(ptr, handle, &error_warn);
> +    Error *err =3D NULL;
> +
> +    qemu_win32_map_free(ptr, handle, &err);
> +    error_report_err(err);
>  #else
>      qemu_memfd_free(ptr, size, handle);
>  #endif
> --
> 2.49.0
>
>

--000000000000f938f9063bd6306a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 8, 20=
25 at 12:08=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redha=
t.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">qemu_pixman_shareable_free() wraps around either qe=
mu_memfd_free() or<br>
qemu_win32_map_free().=C2=A0 The former reports trouble as error, with<br>
error_report(), then succeeds.=C2=A0 The latter reports it as warning (we<b=
r>
pass it &amp;error_warn), then succeeds.<br>
<br>
Change the latter to report as error, too.<br>
<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br></blockquote><div><br></div><=
div><div>lgtm, thanks</div><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9=
 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau=
@redhat.com</a>&gt;</div><div><br></div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
---<br>
=C2=A0ui/qemu-pixman.c | 5 ++++-<br>
=C2=A01 file changed, 4 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c<br>
index ef4e71da11..e46c6232cf 100644<br>
--- a/ui/qemu-pixman.c<br>
+++ b/ui/qemu-pixman.c<br>
@@ -288,7 +288,10 @@ qemu_pixman_shareable_free(qemu_pixman_shareable handl=
e,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 void *ptr, size_t size)<br>
=C2=A0{<br>
=C2=A0#ifdef WIN32<br>
-=C2=A0 =C2=A0 qemu_win32_map_free(ptr, handle, &amp;error_warn);<br>
+=C2=A0 =C2=A0 Error *err =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 qemu_win32_map_free(ptr, handle, &amp;err);<br>
+=C2=A0 =C2=A0 error_report_err(err);<br>
=C2=A0#else<br>
=C2=A0 =C2=A0 =C2=A0qemu_memfd_free(ptr, size, handle);<br>
=C2=A0#endif<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div></div>

--000000000000f938f9063bd6306a--


