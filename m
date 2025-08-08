Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C11C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 08:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukIFv-00032C-NA; Fri, 08 Aug 2025 04:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ukIFf-0002yl-IW
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:14:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ukIFd-0007TM-NZ
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754640893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XY8xR+4rjf5fQBfn4u7mxPHSoW24UMHU7NfO082vQfg=;
 b=ShQ82rMq0IJO7IoxoWvpKCkKIwMlFHE3WMZ9suhPjfZPf7Fk53u26jZVQ22oRphWqnLpO2
 DDA5btDknexvLnbdpo8OtP+TBTA3zIU3o856Q/9wi3DxsAb3He7Gf3q6dlLJXlGq3CAj7t
 13uEoxfchPsZHhJEwC4ASfSsPgmH6v4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-3JOZX_CkN3-z-A92-00GEA-1; Fri, 08 Aug 2025 04:14:51 -0400
X-MC-Unique: 3JOZX_CkN3-z-A92-00GEA-1
X-Mimecast-MFC-AGG-ID: 3JOZX_CkN3-z-A92-00GEA_1754640890
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-31f729bf733so3558373a91.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 01:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754640890; x=1755245690;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XY8xR+4rjf5fQBfn4u7mxPHSoW24UMHU7NfO082vQfg=;
 b=hzhfj8I+3PaB5hEqxB4jabHhM+EdmFXQa6NfWSuS5U7OpFZ8xWWdPFlBjRauPgVTua
 cy4iDNPqO6RdxHHJUW5n3lwHytpCmEzj0SOWZNBJtFhTWULozEbADPl2455iIUpIYaRj
 zIiMdbTRhYJgYIkqI9+yLAgNQmYJOURUCefWxqhPuRu60gr0ANvSFiFtWGntV52A5dLb
 SGtb1cGA6TxKc1ZZMLk6QxgQen7q1hnY4P+fy4Sr7vASeP5G4pFOpBYWZLZvCPA4NWbp
 wTTcNk0x8X6D3qN5pQ9xRmDbbkH9BfvBMyQXPJqUkoEwXcX8+gGhLEMWR4Vu+DqU4Rv7
 IPog==
X-Gm-Message-State: AOJu0YwCDOsD14tB92IB4tIj7jUM83U57qy6Fb6Hud9Qjk3ko2XgGXnz
 oFKBB3cmsy/UJaMvZxmFjVJY3VdjEALRcbmk6Ychk26L1FX4ut1jGCMRVTXctx416PDtCZoxcEN
 3jpTltcrrthZhE+hZOeMLadrJX/P929akEzGK24jr0nMjIynzfpGtDVcAsTVz3JGXNxJ1feW4rq
 qhxUvbkrAGmN4UZxabaJgq5rXra1UQnx04T576kZ3qpeI0
X-Gm-Gg: ASbGnctbFObMAJYV8kG8ifyq2H79vLnklTMxnX34DNb8rUCMjyw9+ToeXGUpypanWFs
 5cpgx45aXWxdSxKREPYDHsdkS7m4wRNYyiopKJkKFDvSUzOp+vP+dQ98bE/dzhlC9joAKic/gw9
 R3jM3OkmEDgoOtQOWOm0ddYA==
X-Received: by 2002:a17:90b:3910:b0:313:176b:3d4b with SMTP id
 98e67ed59e1d1-32183b4343cmr2695548a91.22.1754640889878; 
 Fri, 08 Aug 2025 01:14:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpxyfangAA9VBE4l6eGubP+ZWCIOT8J1DWZjJWQn99eOolsNGkr1KuxVnfG+RLQij9GCHKBI3yNBPnKYEhRSU=
X-Received: by 2002:a17:90b:3910:b0:313:176b:3d4b with SMTP id
 98e67ed59e1d1-32183b4343cmr2695529a91.22.1754640889535; Fri, 08 Aug 2025
 01:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-11-armbru@redhat.com>
In-Reply-To: <20250808080823.2638861-11-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 8 Aug 2025 12:14:37 +0400
X-Gm-Features: Ac12FXxha-aPm2mfPDH-4B-FVaZc7VgjDZSb_B6w_MfWZlWA5kBQRGo9wJRq2W4
Message-ID: <CAMxuvayKoFZaitK8dkSMiJzRU3O0NQzOMrg5qgutvy=ZzvbE=A@mail.gmail.com>
Subject: Re: [PATCH 10/12] ui/dbus: Clean up dbus_update_gl_cb() error checking
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp
Content-Type: multipart/alternative; boundary="000000000000edf93e063bd62aa4"
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

--000000000000edf93e063bd62aa4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Aug 8, 2025 at 12:08=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> From GLib "Rules for use of GError":
>
>     A GError* must be initialized to NULL before passing its address
>     to a function that can report errors.
>
> dbus_update_gl_cb() seemingly violates this rule: it passes &err to
> qemu_dbus_display1_listener_call_update_dmabuf_finish() and to
> qemu_dbus_display1_listener_win32_d3d11_call_update_texture2d_finish()
> without clearing it in between.  Harmless, because the first call is
> guarded by #ifdef CONFIG_GBM, the second by #ifdef WIN32, and the two
> are mutually exclusive.  I think.
>
> Clean this up to be obviously correct.
>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

lgtm, thanks

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  ui/dbus-listener.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> index 42875b8eed..09d7a319b1 100644
> --- a/ui/dbus-listener.c
> +++ b/ui/dbus-listener.c
> @@ -221,18 +221,21 @@ static void dbus_update_gl_cb(GObject *source_objec=
t,
>  #ifdef CONFIG_GBM
>      success =3D qemu_dbus_display1_listener_call_update_dmabuf_finish(
>          ddl->proxy, res, &err);
> +    if (!success) {
> +        error_report("Failed to call update: %s", err->message);
> +    }
>  #endif
>
>  #ifdef WIN32
>      success =3D
> qemu_dbus_display1_listener_win32_d3d11_call_update_texture2d_finish(
>          ddl->d3d11_proxy, res, &err);
> -    d3d_texture2d_acquire0(ddl->d3d_texture, &error_warn);
> -#endif
> -
>      if (!success) {
>          error_report("Failed to call update: %s", err->message);
>      }
>
> +    d3d_texture2d_acquire0(ddl->d3d_texture, &error_warn);
> +#endif
> +
>      graphic_hw_gl_block(ddl->dcl.con, false);
>      g_object_unref(ddl);
>  }
> --
> 2.49.0
>
>

--000000000000edf93e063bd62aa4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 8, 2025 at 12:08=
=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armb=
ru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">From GLib &quot;Rules for use of GError&quot;:<br>
<br>
=C2=A0 =C2=A0 A GError* must be initialized to NULL before passing its addr=
ess<br>
=C2=A0 =C2=A0 to a function that can report errors.<br>
<br>
dbus_update_gl_cb() seemingly violates this rule: it passes &amp;err to<br>
qemu_dbus_display1_listener_call_update_dmabuf_finish() and to<br>
qemu_dbus_display1_listener_win32_d3d11_call_update_texture2d_finish()<br>
without clearing it in between.=C2=A0 Harmless, because the first call is<b=
r>
guarded by #ifdef CONFIG_GBM, the second by #ifdef WIN32, and the two<br>
are mutually exclusive.=C2=A0 I think.<br>
<br>
Clean this up to be obviously correct.<br>
<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br></blockquote><div><br></div><=
div>lgtm, thanks</div><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lure=
au &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redh=
at.com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
---<br>
=C2=A0ui/dbus-listener.c | 9 ++++++---<br>
=C2=A01 file changed, 6 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c<br>
index 42875b8eed..09d7a319b1 100644<br>
--- a/ui/dbus-listener.c<br>
+++ b/ui/dbus-listener.c<br>
@@ -221,18 +221,21 @@ static void dbus_update_gl_cb(GObject *source_object,=
<br>
=C2=A0#ifdef CONFIG_GBM<br>
=C2=A0 =C2=A0 =C2=A0success =3D qemu_dbus_display1_listener_call_update_dma=
buf_finish(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ddl-&gt;proxy, res, &amp;err);<br>
+=C2=A0 =C2=A0 if (!success) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed to call update: %s&q=
uot;, err-&gt;message);<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0#endif<br>
<br>
=C2=A0#ifdef WIN32<br>
=C2=A0 =C2=A0 =C2=A0success =3D qemu_dbus_display1_listener_win32_d3d11_cal=
l_update_texture2d_finish(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ddl-&gt;d3d11_proxy, res, &amp;err);<br>
-=C2=A0 =C2=A0 d3d_texture2d_acquire0(ddl-&gt;d3d_texture, &amp;error_warn)=
;<br>
-#endif<br>
-<br>
=C2=A0 =C2=A0 =C2=A0if (!success) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;Failed to call update:=
 %s&quot;, err-&gt;message);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 d3d_texture2d_acquire0(ddl-&gt;d3d_texture, &amp;error_warn)=
;<br>
+#endif<br>
+<br>
=C2=A0 =C2=A0 =C2=A0graphic_hw_gl_block(ddl-&gt;dcl.con, false);<br>
=C2=A0 =C2=A0 =C2=A0g_object_unref(ddl);<br>
=C2=A0}<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div></div>

--000000000000edf93e063bd62aa4--


