Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AA1CFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 09:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxjb6-00052v-8Q; Mon, 07 Oct 2024 05:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sxjb3-00051H-Vx
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 05:00:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sxjaz-0000Yw-1k
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 05:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728291599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C8yXL4Vp0ndCfQLOzsIKC+wThiMCWKXz4qqeHhot2P8=;
 b=Zur+jp4r4fPqcvmvFJ74lEneNf+pEdrzcFdIEWMg/TCFOJN7ci/gMu2esdcnOXc+Zqap6v
 mLf+qD+tnrPEjDzwSCY5cG3R1OytEHNmS6f5Y5h5F/V1dpHVh+9sWq3W4TfXhurUzI2Fpw
 geVBx9qgXsqP08lsifihY9CF6yZ5xoo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-7Mf80E-9MHaecAp49SYx7w-1; Mon, 07 Oct 2024 04:59:57 -0400
X-MC-Unique: 7Mf80E-9MHaecAp49SYx7w-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a9a85e4a85so968145785a.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 01:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728291597; x=1728896397;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C8yXL4Vp0ndCfQLOzsIKC+wThiMCWKXz4qqeHhot2P8=;
 b=jilENpAn5manCIfJr6BiR0zpdXfZSCt53Z5h7Y8DMbaQU4Y51hz5ozEc0xPtRUo+tt
 Nn6/uWqI27aaTyURn9Hg531wDB3peYj2yorZATwWpH5NdEU26BrCgrJQtFGyjSAP6JoX
 5ovuAksICt2jbvOEkyHFSU5SpLYT2ZTiZladEB/V4nsN4HWilMTD7vnQuuyvn1XlV7O8
 Gm+JwhPPIBraJj+rX8TbSy3wHIF5jFTsBo6rrRhlUg3wMOzFYn7TOMtih7tBDJ3qcn41
 TDpcz4df1gz7EpraZDZSE5JsC0jrEA5Cd8qCdAnhqXxLD4KYbRJcJjXk5zQt415UE1jh
 Cy6g==
X-Gm-Message-State: AOJu0Yys719yc36iUruqtxZqhi7Lk2BIPOv2nmsPayaJ4DT1+oXEejm3
 1jTt06IWWe6j0Sw7uImRYJdQrYISpuQMpGL0SaRp0AxFRqgqjrtOgSklYJmFMQ6O+JEmxLiqmzq
 WGddlkNJuw+dOVGaryQ40HI5uehLUnqZMxZnXUbDxdXln+SR3hTBg+ohVpFlMlLKSCsmQ0vDEwE
 k3X5gi6U7m7bNzK9Unal1GROqBfyY=
X-Received: by 2002:a05:620a:4713:b0:7ac:d673:205a with SMTP id
 af79cd13be357-7ae6f44dbd1mr1866345385a.38.1728291596861; 
 Mon, 07 Oct 2024 01:59:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo/MFCfM9a/Eaj0EUit7EJ4IEqUJdz/rW3apv50URU/pSBff3uXfE9zMirE0mBTTVYTQjxdc5fIQm2GbXjp2w=
X-Received: by 2002:a05:620a:4713:b0:7ac:d673:205a with SMTP id
 af79cd13be357-7ae6f44dbd1mr1866342185a.38.1728291596566; Mon, 07 Oct 2024
 01:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
 <20241003112244.3340697-6-marcandre.lureau@redhat.com>
 <26319860-7118-4cc8-b1f5-cbdf4df69245@daynix.com>
In-Reply-To: <26319860-7118-4cc8-b1f5-cbdf4df69245@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 7 Oct 2024 12:59:44 +0400
Message-ID: <CAMxuvaw59zdUa2mxEyzG3tVzCgY-y_m-rvGqRpEhCWM9B_3JyQ@mail.gmail.com>
Subject: Re: [PATCH 05/16] ui/dbus: fix filtering all update messages
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 belmouss@redhat.com, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Akihiko

On Sat, Oct 5, 2024 at 12:44=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2024/10/03 20:22, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Filtering pending messages when a new scanout is given shouldn't discar=
d
> > pending cursor changes, for example.
> >
> > Since filtering happens in a different thread, use atomic set/get.
> >
> > Fixes: fa88b85dea ("ui/dbus: filter out pending messages when scanout")
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   ui/dbus-listener.c | 44 ++++++++++++++++++++++++++++++++------------
> >   1 file changed, 32 insertions(+), 12 deletions(-)
> >
> > diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> > index 434bd608f2..a70cad3a90 100644
> > --- a/ui/dbus-listener.c
> > +++ b/ui/dbus-listener.c
> > @@ -26,6 +26,7 @@
> >   #include "qapi/error.h"
> >   #include "sysemu/sysemu.h"
> >   #include "dbus.h"
> > +#include "glib.h"
> >   #ifdef G_OS_UNIX
> >   #include <gio/gunixfdlist.h>
> >   #endif
> > @@ -85,7 +86,7 @@ struct _DBusDisplayListener {
> >   #endif
> >
> >       guint dbus_filter;
> > -    guint32 out_serial_to_discard;
> > +    guint32 display_serial_to_discard;
> >   };
> >
> >   G_DEFINE_TYPE(DBusDisplayListener, dbus_display_listener, G_TYPE_OBJE=
CT)
> > @@ -93,10 +94,12 @@ G_DEFINE_TYPE(DBusDisplayListener, dbus_display_lis=
tener, G_TYPE_OBJECT)
> >   static void dbus_gfx_update(DisplayChangeListener *dcl,
> >                               int x, int y, int w, int h);
> >
> > -static void ddl_discard_pending_messages(DBusDisplayListener *ddl)
> > +static void ddl_discard_display_messages(DBusDisplayListener *ddl)
> >   {
> > -    ddl->out_serial_to_discard =3D g_dbus_connection_get_last_serial(
> > +    guint32 serial =3D g_dbus_connection_get_last_serial(
> >           g_dbus_proxy_get_connection(G_DBUS_PROXY(ddl->proxy)));
> > +
> > +    g_atomic_int_set(&ddl->display_serial_to_discard, serial);
> >   }
> >
> >   #ifdef CONFIG_OPENGL
> > @@ -290,7 +293,7 @@ static void dbus_scanout_dmabuf(DisplayChangeListen=
er *dcl,
> >           return;
> >       }
> >
> > -    ddl_discard_pending_messages(ddl);
> > +    ddl_discard_display_messages(ddl);
> >
> >       width =3D qemu_dmabuf_get_width(dmabuf);
> >       height =3D qemu_dmabuf_get_height(dmabuf);
> > @@ -338,7 +341,7 @@ static bool dbus_scanout_map(DBusDisplayListener *d=
dl)
> >           return false;
> >       }
> >
> > -    ddl_discard_pending_messages(ddl);
> > +    ddl_discard_display_messages(ddl);
> >
> >       if (!qemu_dbus_display1_listener_win32_map_call_scanout_map_sync(
> >               ddl->map_proxy,
> > @@ -401,7 +404,7 @@ dbus_scanout_share_d3d_texture(
> >           return false;
> >       }
> >
> > -    ddl_discard_pending_messages(ddl);
> > +    ddl_discard_display_messages(ddl);
> >
> >       qemu_dbus_display1_listener_win32_d3d11_call_scanout_texture2d(
> >           ddl->d3d11_proxy,
> > @@ -659,7 +662,7 @@ static void ddl_scanout(DBusDisplayListener *ddl)
> >           surface_stride(ddl->ds) * surface_height(ddl->ds), TRUE,
> >           (GDestroyNotify)pixman_image_unref, pixman_image_ref(ddl->ds-=
>image));
> >
> > -    ddl_discard_pending_messages(ddl);
> > +    ddl_discard_display_messages(ddl);
> >
> >       qemu_dbus_display1_listener_call_scanout(
> >           ddl->proxy, surface_width(ddl->ds), surface_height(ddl->ds),
> > @@ -992,17 +995,34 @@ dbus_filter(GDBusConnection *connection,
> >               gpointer         user_data)
> >   {
> >       DBusDisplayListener *ddl =3D DBUS_DISPLAY_LISTENER(user_data);
> > -    guint32 serial;
> > +    const gchar *member =3D NULL;
>
> I suggest removing the initialization will NULL as it may suppress
> uninitialized variable warning.

ok

>
> > +    guint32 serial, discard_serial;
> >
> >       if (incoming) {
> >           return message;
> >       }
> >
> >       serial =3D g_dbus_message_get_serial(message);
> > -    if (serial <=3D ddl->out_serial_to_discard) {
> > -        trace_dbus_filter(serial, ddl->out_serial_to_discard);
> > -        g_object_unref(message);
> > -        return NULL;
> > +
> > +    discard_serial =3D g_atomic_int_get(&ddl->display_serial_to_discar=
d);
> > +    if (serial <=3D discard_serial) {
> > +        member =3D g_dbus_message_get_member(message);
> > +        if (g_strv_contains((const gchar *[]) {
> > +                "Scanout",
> > +                "Update",
> > +#ifdef CONFIG_GBM
> > +                "ScanoutDMABUF",
> > +                "UpdateDMABUF",
> > +#endif
> > +                "ScanoutMap",
> > +                "UpdateMap",
> > +                "Disable",
> > +                NULL,
> > +            }, member)) {
>
> I prefer to have a static variable for the array. It makes the object
> code simpler and also avoids to have a multi-line condition in the if
> statement.
>

done, thanks

> > +            trace_dbus_filter(serial, discard_serial);
> > +            g_object_unref(message);
> > +            return NULL;
> > +        }
> >       }
> >
> >       return message;
>


