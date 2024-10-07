Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E774CFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 12:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxn4X-0000xd-LI; Mon, 07 Oct 2024 08:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sxn4V-0000xJ-Nk
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 08:42:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sxn4T-0004A0-7W
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 08:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728304959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YLPfZsUmeir2Gw/JHpTz0iq7mm4RMbXmCSPckI7Mm/g=;
 b=ERGd9DSgo9ulB8weKjy3nRHNMEa20rH22WTD9AE9OE3N9PxK4I3aapjEt/i6wIcfryN1UL
 Dl9hjxxrPXuHlDM3u1QqOWnmFaGpFxBmotsZyUb+bKoatNXTB+jJQuuoiBCVEFiL/9dijx
 gG49WShYuEyyoJ8uQlg3PrWhXCnj4lY=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-r6-az8AZNHCnMRoNnaLAkQ-1; Mon, 07 Oct 2024 08:42:38 -0400
X-MC-Unique: r6-az8AZNHCnMRoNnaLAkQ-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-2871891ca9cso3629350fac.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 05:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728304957; x=1728909757;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YLPfZsUmeir2Gw/JHpTz0iq7mm4RMbXmCSPckI7Mm/g=;
 b=DGlisqWxDRxR9oBmce9hom1+vFE2j6bI+AnKQAQ6yn537mzcIcsE8VYbldRa5Tp4gA
 wHRbynzIw9vGyYdjM4UraBgI+QJM1CR+YCrnUoYpkwWou6LO8UuDB+HPKb5jdOmlfKmC
 YXIM8uR5NwD6rk38ilaweHzZB43+b8YfLUqZrj4doo+vKMJU6Nxv0TtlHVm6O6Me7nXH
 2VjNsYGeiIcRk2qIZgw4fR3QR3Whz3mOtu3vPN7L7a+wtUWFmMoi84uyLKHUy/qwvffE
 v35bmNyiCmNcnw0cvrTPa6QrBO8JFLHAK+UKn7x9Ob3UZ7EUk+us0mH8/h7e4by9mYDd
 Se+w==
X-Gm-Message-State: AOJu0YwygjAKfcrFC7SHHGtzlWn8MfLKfBGypGkqQAli1tBQkINs9/nq
 CKHmXccSZgQsiikg8Q58YpdMoOJaVL3NA2pUR2M9Lyh0lURbXrMqhoihWx+FU1FzEDHEKEV3tWp
 pcz95SGO7rGCii66KeluU81Q/gnvBaDN0yXNdBmebFQaH+coXgs70ZCcx6kK1sApdzMOT0Jclie
 Fjm/VHNKdQhzonTpm5LZe6qLPygak=
X-Received: by 2002:a05:6870:34a:b0:277:d195:ab88 with SMTP id
 586e51a60fabf-287c1fbc2e6mr7518998fac.32.1728304957324; 
 Mon, 07 Oct 2024 05:42:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBa/gZEKJx8QevhPZbp6wTPymkerlKmKJy2gtPyqAra41/hKT3qD/QdsBu7O9voWj9isNj4I9I3ySwu0MUR8s=
X-Received: by 2002:a05:6870:34a:b0:277:d195:ab88 with SMTP id
 586e51a60fabf-287c1fbc2e6mr7518973fac.32.1728304956968; Mon, 07 Oct 2024
 05:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
 <20241003112244.3340697-17-marcandre.lureau@redhat.com>
 <f0c03b18-387f-450c-b1c5-33cf51b83445@daynix.com>
In-Reply-To: <f0c03b18-387f-450c-b1c5-33cf51b83445@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 7 Oct 2024 16:42:25 +0400
Message-ID: <CAMxuvaz0VneZHRmDnmJNZvaNoS9V28ZDLNWt33WYgXVpO9NDHw@mail.gmail.com>
Subject: Re: [PATCH 16/16] tests: add basic -display dbus Map.Unix test
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 belmouss@redhat.com, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Oct 5, 2024 at 12:32=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2024/10/03 20:22, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Only check we eventually get a shared memory scanout.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   tests/qtest/dbus-display-test.c | 64 ++++++++++++++++++++++++++++++--=
-
> >   1 file changed, 59 insertions(+), 5 deletions(-)
> >
> > diff --git a/tests/qtest/dbus-display-test.c b/tests/qtest/dbus-display=
-test.c
> > index 0390bdcb41..ac92cb00d4 100644
> > --- a/tests/qtest/dbus-display-test.c
> > +++ b/tests/qtest/dbus-display-test.c
> > @@ -2,9 +2,12 @@
> >   #include "qemu/sockets.h"
> >   #include "qemu/dbus.h"
> >   #include "qemu/sockets.h"
> > +#include "glib.h"
> > +#include "glibconfig.h"
> >   #include <gio/gio.h>
> >   #include <gio/gunixfdlist.h>
> >   #include "libqtest.h"
> > +#include <sys/mman.h>
> >   #include "ui/dbus-display1.h"
> >
> >   static GDBusConnection*
> > @@ -82,6 +85,7 @@ typedef struct TestDBusConsoleRegister {
> >       GThread *thread;
> >       GDBusConnection *listener_conn;
> >       GDBusObjectManagerServer *server;
> > +    bool with_map;
> >   } TestDBusConsoleRegister;
> >
> >   static gboolean listener_handle_scanout(
> > @@ -94,13 +98,48 @@ static gboolean listener_handle_scanout(
> >       GVariant *arg_data,
> >       TestDBusConsoleRegister *test)
> >   {
> > +    if (!test->with_map) {
> > +        g_main_loop_quit(test->loop);
> > +    }
> > +
> > +    return DBUS_METHOD_INVOCATION_HANDLED;
> > +}
> > +
> > +static gboolean listener_handle_scanout_map(
> > +    QemuDBusDisplay1ListenerUnixMap *object,
> > +    GDBusMethodInvocation *invocation,
> > +    GUnixFDList *fd_list,
> > +    GVariant *arg_handle,
> > +    guint arg_offset,
> > +    guint arg_width,
> > +    guint arg_height,
> > +    guint arg_stride,
> > +    guint arg_pixman_format,
> > +    TestDBusConsoleRegister *test)
> > +{
> > +    int fd =3D -1;
> > +    gint32 handle =3D g_variant_get_handle(arg_handle);
> > +    g_autoptr(GError) error =3D NULL;
> > +    void *addr =3D NULL;
> > +    size_t len =3D arg_height * arg_stride;
> > +
> > +    g_assert_cmpuint(g_unix_fd_list_get_length(fd_list), =3D=3D, 1);
> > +    fd =3D g_unix_fd_list_get(fd_list, handle, &error);
> > +    g_assert_no_error(error);
> > +
> > +    addr =3D mmap(NULL, len, PROT_READ, MAP_PRIVATE, fd, arg_offset);
> > +    g_assert_no_errno(GPOINTER_TO_INT(addr));
>
> Strictly speaking, this construct is not safe. When void * is 64-bit and
> int is 32-bit, this assetion will fail if the lower 32 bits of addr are
> in [0x80000000, 0xffffffff] though addr may still be a valid address.
> This is because GPOINTER_TO_INT() results in a negative value for such
> an address, and g_assert_no_errno() asserts that the given value is
> non-negative.
>
> Using g_mapped_file_new_from_fd() and will simplify this function as whol=
e.

I thought about that, but g_mapped_file_new_from_fd() doesn't take a
len, and it fstat() the fd. This is ok for memfd apparently, and
appears to work, but it isn't really compliant with the dbus
interface.

>
> > +    g_assert_nonnull(addr);
> > +    g_assert_no_errno(munmap(addr, len));
> > +
> >       g_main_loop_quit(test->loop);
> >
> > +    close(fd);
> >       return DBUS_METHOD_INVOCATION_HANDLED;
> >   }
> >
> >   static void
> > -test_dbus_console_setup_listener(TestDBusConsoleRegister *test)
> > +test_dbus_console_setup_listener(TestDBusConsoleRegister *test, bool w=
ith_map)
> >   {
> >       g_autoptr(GDBusObjectSkeleton) listener =3D NULL;
> >       g_autoptr(QemuDBusDisplay1ListenerSkeleton) iface =3D NULL;
> > @@ -114,6 +153,20 @@ test_dbus_console_setup_listener(TestDBusConsoleRe=
gister *test)
> >                        NULL);
> >       g_dbus_object_skeleton_add_interface(listener,
> >                                            G_DBUS_INTERFACE_SKELETON(if=
ace));
> > +    if (with_map) {
> > +        g_autoptr(QemuDBusDisplay1ListenerUnixMapSkeleton) iface_map =
=3D
> > +            QEMU_DBUS_DISPLAY1_LISTENER_UNIX_MAP_SKELETON(
> > +                qemu_dbus_display1_listener_unix_map_skeleton_new());
> > +
> > +        g_object_connect(iface_map,
> > +                         "signal::handle-scanout-map", listener_handle=
_scanout_map, test,
> > +                         NULL);
> > +        g_dbus_object_skeleton_add_interface(listener,
> > +                                             G_DBUS_INTERFACE_SKELETON=
(iface_map));
> > +        g_object_set(iface, "interfaces",
> > +            (const gchar *[]) { "org.qemu.Display1.Listener.Unix.Map",=
 NULL },
> > +            NULL);
> > +    }
> >       g_dbus_object_manager_server_export(test->server, listener);
> >       g_dbus_object_manager_server_set_connection(test->server,
> >                                                   test->listener_conn);
> > @@ -145,7 +198,7 @@ test_dbus_console_registered(GObject *source_object=
,
> >       g_assert_no_error(err);
> >
> >       test->listener_conn =3D g_thread_join(test->thread);
> > -    test_dbus_console_setup_listener(test);
> > +    test_dbus_console_setup_listener(test, test->with_map);
> >   }
> >
> >   static gpointer
> > @@ -155,7 +208,7 @@ test_dbus_p2p_server_setup_thread(gpointer data)
> >   }
> >
> >   static void
> > -test_dbus_display_console(void)
> > +test_dbus_display_console(const void* data)
> >   {
> >       g_autoptr(GError) err =3D NULL;
> >       g_autoptr(GDBusConnection) conn =3D NULL;
> > @@ -163,7 +216,7 @@ test_dbus_display_console(void)
> >       g_autoptr(GMainLoop) loop =3D NULL;
> >       QTestState *qts =3D NULL;
> >       int pair[2];
> > -    TestDBusConsoleRegister test =3D { 0, };
> > +    TestDBusConsoleRegister test =3D { 0, .with_map =3D GPOINTER_TO_IN=
T(data) };
> >   #ifdef WIN32
> >       WSAPROTOCOL_INFOW info;
> >       g_autoptr(GVariant) listener =3D NULL;
> > @@ -299,7 +352,8 @@ main(int argc, char **argv)
> >       g_test_init(&argc, &argv, NULL);
> >
> >       qtest_add_func("/dbus-display/vm", test_dbus_display_vm);
> > -    qtest_add_func("/dbus-display/console", test_dbus_display_console)=
;
> > +    qtest_add_data_func("/dbus-display/console", GINT_TO_POINTER(false=
), test_dbus_display_console);
> > +    qtest_add_data_func("/dbus-display/console/map", GINT_TO_POINTER(t=
rue), test_dbus_display_console);
> >       qtest_add_func("/dbus-display/keyboard", test_dbus_display_keyboa=
rd);
> >
> >       return g_test_run();
>


