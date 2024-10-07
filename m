Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBC4CFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 11:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxlVa-0000uS-IM; Mon, 07 Oct 2024 07:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sxlVY-0000tz-TU
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:02:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sxlVV-00068A-W1
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728298948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GgPqqb4SXPyiYwIuH3Q5rOkHuhPDOHjfBA7k0hDGpbs=;
 b=TUaxGZ2E7Q5+f5nWyGdQp8Mu8znmGZ/yA/Emfgjr0L4wzHJnoA0oTtaZRXloUYMGv2xwBS
 X/UBEqRz9wYYOqjHk0Fzmh70+cLRzN8zr/Zy5NH8kwZBZeUqrmJhpWuUcRpD9zbla1o5wt
 Cq5GVWrElj0HG0nmvADThhwyOIt92m8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-NQqUD_JANyStRYdzia07sQ-1; Mon, 07 Oct 2024 07:02:27 -0400
X-MC-Unique: NQqUD_JANyStRYdzia07sQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6cb317cd72eso96585896d6.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 04:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728298947; x=1728903747;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GgPqqb4SXPyiYwIuH3Q5rOkHuhPDOHjfBA7k0hDGpbs=;
 b=XyzT4K37PtK2r0YJBen7Mvj5KR/8eRTPAPkeUwL3td/wZZIxSjW6tepgu9vVp1+yAp
 68amj1Zceh4DL3uBRV2qSQTs+GPJq1cFR1LNbcGHqcti930DW63/x43r55hpEuT2F8gc
 8XajuaFGF58HH4/9EAKMNsfq/idQ9lF4R8WJ2LfXex20jsLIznFSbm3dLrlC/PmW/hG/
 NA8Vok5qFqrOpg8znmaL5PkIRI2Rl1velvVAzqlQ4zyk3calq6R1Bt3GL7VCVIr/MXMP
 Nf5t2+owl6IfDD18I7oiSHzt+oMy7WRQn5GVSPW3+2zXZ1q7PCLHHi0GpiRmMf5CNXBY
 ISkg==
X-Gm-Message-State: AOJu0YzhXTnmpimsyPpEB/3zwx8aQ3hhG5l5jLW3AQIInxOzmF6mUxKi
 34fQPgXLxIXQdxMP/e/aJlnlxPMkwCMkZuDYAPbNICteF5fYjBz5By4lSp4Rn2+O0AC++gf+G0g
 QlAz6xKeKF70cF1NmvaXMotDejSNtox/thMkuUdSossJeArVarzeNBXIpLfksAIvHpjDFmba7oi
 BqmKTU/Rofd7xvHHafiiFyUDO+a7E=
X-Received: by 2002:a05:6214:4602:b0:6cb:4c23:6573 with SMTP id
 6a1803df08f44-6cb9a3096c8mr193602906d6.21.1728298947099; 
 Mon, 07 Oct 2024 04:02:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn9K2LYsBPMGuk81rCrMz00qryMyGxFt5o7H5FnGK09CoVbzLXWyvdFcpYcoPyYee/DrOUJZqjqhgFySeaBsg=
X-Received: by 2002:a05:6214:4602:b0:6cb:4c23:6573 with SMTP id
 6a1803df08f44-6cb9a3096c8mr193602586d6.21.1728298946798; Mon, 07 Oct 2024
 04:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
 <20241003112244.3340697-8-marcandre.lureau@redhat.com>
 <db9f3849-adce-4362-afaa-b580829e8934@daynix.com>
In-Reply-To: <db9f3849-adce-4362-afaa-b580829e8934@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 7 Oct 2024 15:02:15 +0400
Message-ID: <CAMxuvaxgBqr4+U7CY8po4ZsBv_weAbvR5sE-X-YsUUb36=y9zw@mail.gmail.com>
Subject: Re: [PATCH 07/16] ui/dbus: discard pending CursorDefine on new one
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

Hi

On Sat, Oct 5, 2024 at 12:45=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2024/10/03 20:22, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Similar to scanout updates, let's discard pending cursor changes.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   ui/dbus-listener.c | 23 +++++++++++++++++++++++
> >   roms/openbios      |  2 +-
> >   2 files changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> > index 23a4633fa4..020c05198b 100644
> > --- a/ui/dbus-listener.c
> > +++ b/ui/dbus-listener.c
> > @@ -87,6 +87,7 @@ struct _DBusDisplayListener {
> >
> >       guint dbus_filter;
> >       guint32 display_serial_to_discard;
> > +    guint32 cursor_serial_to_discard;
> >   };
> >
> >   G_DEFINE_TYPE(DBusDisplayListener, dbus_display_listener, G_TYPE_OBJE=
CT)
> > @@ -102,6 +103,14 @@ static void ddl_discard_display_messages(DBusDispl=
ayListener *ddl)
> >       g_atomic_int_set(&ddl->display_serial_to_discard, serial);
> >   }
> >
> > +static void ddl_discard_cursor_messages(DBusDisplayListener *ddl)
> > +{
> > +    guint32 serial =3D g_dbus_connection_get_last_serial(
> > +        g_dbus_proxy_get_connection(G_DBUS_PROXY(ddl->proxy)));
> > +
> > +    g_atomic_int_set(&ddl->cursor_serial_to_discard, serial);
> > +}
> > +
> >   #ifdef CONFIG_OPENGL
> >   static void dbus_scanout_disable(DisplayChangeListener *dcl)
> >   {
> > @@ -502,6 +511,8 @@ static void dbus_cursor_dmabuf(DisplayChangeListene=
r *dcl,
> >           return;
> >       }
> >
> > +    ddl_discard_cursor_messages(ddl);
> > +
> >       egl_dmabuf_import_texture(dmabuf);
> >       texture =3D qemu_dmabuf_get_texture(dmabuf);
> >       if (!texture) {
> > @@ -745,6 +756,8 @@ static void dbus_cursor_define(DisplayChangeListene=
r *dcl,
> >       DBusDisplayListener *ddl =3D container_of(dcl, DBusDisplayListene=
r, dcl);
> >       GVariant *v_data =3D NULL;
> >
> > +    ddl_discard_cursor_messages(ddl);
> > +
> >       v_data =3D g_variant_new_from_data(
> >           G_VARIANT_TYPE("ay"),
> >           c->data,
> > @@ -1027,6 +1040,16 @@ dbus_filter(GDBusConnection *connection,
> >           }
> >       }
> >
> > +    discard_serial =3D g_atomic_int_get(&ddl->cursor_serial_to_discard=
);
> > +    if (serial <=3D discard_serial) {
> > +        member =3D g_dbus_message_get_member(message);
> > +        if (g_strv_contains((const gchar *[]) { "CursorDefine", NULL }=
, member)) {
> > +            trace_dbus_filter(serial, discard_serial);
> > +            g_object_unref(message);
> > +            return NULL;
> > +        }
> > +    }
> > +
> >       return message;
> >   }
> >
> > diff --git a/roms/openbios b/roms/openbios
> > index c3a19c1e54..af97fd7af5 160000
> > --- a/roms/openbios
> > +++ b/roms/openbios
> > @@ -1 +1 @@
> > -Subproject commit c3a19c1e54977a53027d6232050e1e3e39a98a1b
> > +Subproject commit af97fd7af5e7c18f591a7b987291d3db4ffb28b5
>
> An accidental change of roms/openbios.

good catch.. thanks


