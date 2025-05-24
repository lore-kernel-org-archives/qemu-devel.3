Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04844C54F30
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 14:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIq7Y-0006hC-3k; Sat, 24 May 2025 10:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uIq7T-0006fG-VJ
 for qemu-devel@nongnu.org; Sat, 24 May 2025 10:45:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uIq7R-00088c-9S
 for qemu-devel@nongnu.org; Sat, 24 May 2025 10:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748097900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0TwItUV09RBBftgwZWAwAp2ne9U5BIVzdGLcYwfsvCg=;
 b=XFEEYPPZNkZOE0hbj/TsFPgTBYDWElhIwU9iCTl6YfVeP38Bl9ME1es0PYEM5UHXTBGcAg
 8n8Yo9VasUUazSHBJ3xMsoLsdtAmIifpJfk43B9epk6tEKa9j33PTNXiN2kLUDNkF64+E3
 sqo7lhbBC8bAHoEJh9taw10NcBFCssc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-ZS88HrNMOPODzUm_jg-_Ew-1; Sat, 24 May 2025 10:44:57 -0400
X-MC-Unique: ZS88HrNMOPODzUm_jg-_Ew-1
X-Mimecast-MFC-AGG-ID: ZS88HrNMOPODzUm_jg-_Ew_1748097897
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-476a44cec4cso11983551cf.2
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 07:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748097897; x=1748702697;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0TwItUV09RBBftgwZWAwAp2ne9U5BIVzdGLcYwfsvCg=;
 b=WecwBYz0DHbbHGSSrMvVBlPRXObjdrGgIHvQahcZEeQr0t+atqn5rHa6MMlcbwyDCD
 ZDcF2jE4KlRKGtKFXrFCbYvR58RpU4A3uyLV0jOjL71smH0xYptNN7l32cdcrr4kZS8C
 67z99CxGDnECIOHK5y+sKuxGchWuKuzHX9dyA8WJXTmgdtu7e8AhNXtPuKHvx7PEtn3q
 ZGMDhNrgJShBnp/eWOsVrar1ncY+Nuy3bvfIRBL13r9OU6jH4OxycL8I1sdSQtS/GJEx
 ZYkz5XWbRywlmzh1RcTOUTENWa93dxjqPfh3kr6eJx0z9wXLQZWzny4Z+YB3xF5/pRdE
 0NHQ==
X-Gm-Message-State: AOJu0YzhZojwz0g06zOWVzdpJi4ozfOvWBpeaEPo5s74LXYI3MhdKYRD
 JSXwCtkqXFBMQiyxC+eMSZsn3iozDQ3jXwZN/thsh+Ge8DT6nwwH4bA/XbrrJYuQVeScdXCavIJ
 jQgIXOEGPLG6Y0qOdAyG3R2bq+HBmW5+mo1i51AX8REKQYcy9hREPApnieUbnqB7fooRRMI6ETr
 RQhIRaZqnC+aY4K4WEDPj5HmT6iV/70wk=
X-Gm-Gg: ASbGncsdd8oQCWczPXZw//42n94Q9B5l0zj0FwkffxdZQ380Db3JJbR7lt7jmNhBooZ
 cAy6vtPX0yopgjzfS39EPE+8d63uIvUjKqgxiOLP2qSicqR1Hs7g7jt6ilZUFGBRQsHrFb+K+h9
 HjydRzS1g/F/+2a9GValUewH8Mhg==
X-Received: by 2002:a05:622a:a0b:b0:48d:8053:d8ee with SMTP id
 d75a77b69052e-49f485aa677mr46967221cf.36.1748097897200; 
 Sat, 24 May 2025 07:44:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrWc+8BeWqPCEdzoW2SW9NltFDBx11Zal5wC2Dokqsg3SPJPxDw07OLhcLrwogwtQ8+rtOpVYF65VnXyEaC78=
X-Received: by 2002:a05:622a:a0b:b0:48d:8053:d8ee with SMTP id
 d75a77b69052e-49f485aa677mr46966891cf.36.1748097896904; Sat, 24 May 2025
 07:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250515024734.758335-1-vivek.kasireddy@intel.com>
 <20250515024734.758335-4-vivek.kasireddy@intel.com>
In-Reply-To: <20250515024734.758335-4-vivek.kasireddy@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 24 May 2025 16:44:45 +0200
X-Gm-Features: AX0GCFsKbr6RR5NJEBG_n7x8kcwWerPa3wrbA7TA8OIHlGIHMsOkNO4Fzsmq_AY
Message-ID: <CAMxuvaxAXVhVXL-h+TorOD5ivyoOrQQH3NpWpgXwngvNFRxZ7Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] ui/spice: Enable gl=on option for non-local or
 remote clients
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Content-Type: multipart/alternative; boundary="0000000000002d8dc10635e2c2c8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.298,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000002d8dc10635e2c2c8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, May 15, 2025 at 4:49=E2=80=AFAM Vivek Kasireddy <vivek.kasireddy@in=
tel.com>
wrote:

> Newer versions of Spice server should be able to accept dmabuf
> fds from Qemu for clients that are connected via the network.
> In other words, when this option is enabled, Qemu would share
> a dmabuf fd with Spice which would encode and send the data
> associated with the fd to a client that could be located on
> a different machine.
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Frediano Ziglio <freddy77@gmail.com>
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>  include/ui/spice-display.h | 1 +
>  ui/spice-core.c            | 4 ++++
>  ui/spice-display.c         | 1 +
>  3 files changed, 6 insertions(+)
>
> diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
> index e1a9b36185..f4922dd74b 100644
> --- a/include/ui/spice-display.h
> +++ b/include/ui/spice-display.h
> @@ -151,6 +151,7 @@ struct SimpleSpiceCursor {
>  };
>
>  extern bool spice_opengl;
> +extern bool remote_client;
>

All the globals you introduce here should have a spice_ prefix, for
readability and consistency.


>
>  int qemu_spice_rect_is_empty(const QXLRect* r);
>  void qemu_spice_rect_union(QXLRect *dest, const QXLRect *r);
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index 907b0e9a81..6c3bfe1d0f 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -848,9 +848,13 @@ static void qemu_spice_init(void)
>  #ifdef HAVE_SPICE_GL
>      if (qemu_opt_get_bool(opts, "gl", 0)) {
>          if ((port !=3D 0) || (tls_port !=3D 0)) {
> +#if SPICE_SERVER_VERSION >=3D 0x000f03 /* release 0.15.3 */
> +            remote_client =3D 1;
> +#else
>              error_report("SPICE GL support is local-only for now and "
>                           "incompatible with -spice port/tls-port");
>              exit(1);
> +#endif
>          }
>          egl_init(qemu_opt_get(opts, "rendernode"), DISPLAY_GL_MODE_ON,
> &error_fatal);
>          spice_opengl =3D 1;
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index 9c39d2c5c8..9140169015 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -31,6 +31,7 @@
>  #include "standard-headers/drm/drm_fourcc.h"
>
>  bool spice_opengl;
> +bool remote_client;
>
>  int qemu_spice_rect_is_empty(const QXLRect* r)
>  {
> --
> 2.49.0
>
>

--0000000000002d8dc10635e2c2c8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 15, 2=
025 at 4:49=E2=80=AFAM Vivek Kasireddy &lt;<a href=3D"mailto:vivek.kasiredd=
y@intel.com">vivek.kasireddy@intel.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">Newer versions of Spice server should=
 be able to accept dmabuf<br>
fds from Qemu for clients that are connected via the network.<br>
In other words, when this option is enabled, Qemu would share<br>
a dmabuf fd with Spice which would encode and send the data<br>
associated with the fd to a client that could be located on<br>
a different machine.<br>
<br>
Cc: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank=
">kraxel@redhat.com</a>&gt;<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: Dmitry Osipenko &lt;<a href=3D"mailto:dmitry.osipenko@collabora.com" ta=
rget=3D"_blank">dmitry.osipenko@collabora.com</a>&gt;<br>
Cc: Frediano Ziglio &lt;<a href=3D"mailto:freddy77@gmail.com" target=3D"_bl=
ank">freddy77@gmail.com</a>&gt;<br>
Cc: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_bla=
nk">dongwon.kim@intel.com</a>&gt;<br>
Signed-off-by: Vivek Kasireddy &lt;<a href=3D"mailto:vivek.kasireddy@intel.=
com" target=3D"_blank">vivek.kasireddy@intel.com</a>&gt;<br>
---<br>
=C2=A0include/ui/spice-display.h | 1 +<br>
=C2=A0ui/spice-core.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 4 ++++<br>
=C2=A0ui/spice-display.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 +<br>
=C2=A03 files changed, 6 insertions(+)<br>
<br>
diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h<br>
index e1a9b36185..f4922dd74b 100644<br>
--- a/include/ui/spice-display.h<br>
+++ b/include/ui/spice-display.h<br>
@@ -151,6 +151,7 @@ struct SimpleSpiceCursor {<br>
=C2=A0};<br>
<br>
=C2=A0extern bool spice_opengl;<br>
+extern bool remote_client;<br></blockquote><div><br></div><div>All the glo=
bals you introduce here should have a spice_ prefix, for readability and co=
nsistency.</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
<br>
=C2=A0int qemu_spice_rect_is_empty(const QXLRect* r);<br>
=C2=A0void qemu_spice_rect_union(QXLRect *dest, const QXLRect *r);<br>
diff --git a/ui/spice-core.c b/ui/spice-core.c<br>
index 907b0e9a81..6c3bfe1d0f 100644<br>
--- a/ui/spice-core.c<br>
+++ b/ui/spice-core.c<br>
@@ -848,9 +848,13 @@ static void qemu_spice_init(void)<br>
=C2=A0#ifdef HAVE_SPICE_GL<br>
=C2=A0 =C2=A0 =C2=A0if (qemu_opt_get_bool(opts, &quot;gl&quot;, 0)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((port !=3D 0) || (tls_port !=3D 0)) {=
<br>
+#if SPICE_SERVER_VERSION &gt;=3D 0x000f03 /* release 0.15.3 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remote_client =3D 1;<br>
+#else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;SPICE GL=
 support is local-only for now and &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;incompatible with -spice port/tls-port&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0egl_init(qemu_opt_get(opts, &quot;rendern=
ode&quot;), DISPLAY_GL_MODE_ON, &amp;error_fatal);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spice_opengl =3D 1;<br>
diff --git a/ui/spice-display.c b/ui/spice-display.c<br>
index 9c39d2c5c8..9140169015 100644<br>
--- a/ui/spice-display.c<br>
+++ b/ui/spice-display.c<br>
@@ -31,6 +31,7 @@<br>
=C2=A0#include &quot;standard-headers/drm/drm_fourcc.h&quot;<br>
<br>
=C2=A0bool spice_opengl;<br>
+bool remote_client;<br>
<br>
=C2=A0int qemu_spice_rect_is_empty(const QXLRect* r)<br>
=C2=A0{<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div></div>

--0000000000002d8dc10635e2c2c8--


