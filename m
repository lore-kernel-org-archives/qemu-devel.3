Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C15E65D2F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 07:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEOWg-0008FR-2w; Fri, 22 Nov 2024 02:56:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tEOWe-0008Es-6C
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 02:56:24 -0500
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tEOWX-0004MK-Ok
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 02:56:23 -0500
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-514bb6953f4so607570e0c.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 23:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1732262176; x=1732866976;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b9A0TXzMP4/8EgQE4C/rD10uqDacySgVF6TAacPAnXs=;
 b=S+/FOOonwfRRO58XsiJTGXJn6xAEH3NU7nH5io1Wy1YHUEhOZyk+oE+EVPkNqcHc/K
 9k7rQuAfs74BF9Y4/1c1m8O7LR0v07me1JTCAZ8JdZlcliKR825pq6hvjS45HgcJaj8P
 7jk41xKbvSGyyDiClGGsA1UinhPrw1wmcZWRX9VQvCA7MPV9QUMbGLSgHmLjn4GlJrMo
 AotslfK+NoO+P6sJcKB1nhWV89yHhoOhFqTc4Pa+n/uk9rz7aI0sumZNhcCLDrFe4Ckm
 fM/nH/YlA1q8FNkMiEx4cRhfgdBE990iWk7al9yd9AhOAIXZS31G1jPnK3gIdo2fplfL
 GWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732262176; x=1732866976;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b9A0TXzMP4/8EgQE4C/rD10uqDacySgVF6TAacPAnXs=;
 b=YfPTf1pdkdZeNj2yfkSNbd8vYbUPVBQsKCTMCO9HeEMrAf12Q/4Zbl4lVcWYQQqSgz
 goOTeJRM2zzZviYcmxEiwZ1jHaqN5OyiKizzaDje4sz5ii4IhSuqBh/RUtcF3/z30Vpl
 ONECxZoZd/zGPSxQvm6X3IXubpsbNe68HuqOuUI9Tr6SMH3QN2kW2NHJGIJv+4Ate+M+
 zrVgQizxUZsFPaCAE0QtY8YAKE2D00mjEjYXQaSickz54d3YwDgErjRi1jJJrAGv+sHe
 0Uvcf4Z/87q/DLABpzmUBKciPRradU7eMJulZMnEmP3gdO5ZWNRBKPBJQMBmgCkaLNWd
 RuHQ==
X-Gm-Message-State: AOJu0YznG6/nRRfhIZJLRaJXhZ3Za/WmN5qTyeksokzJzruI5WGh1dnE
 axFKcW8x0qA+3+fqP6HPy9uBJ9PQPJoYTxr7L+PU2Sw7T3xvQK1e24SzU5A79tu7tm5ICBWKPYo
 2m6UiWUcb+dYDE/sYcYuoKpvBhQYQOpxeorXK
X-Gm-Gg: ASbGncvDx0KTGW2MTLC8224bJy8BO/utMz/GZ3/kpJaVEKwSf0G6DQk7VB18nMMCt6d
 kBmlg7/TxvNKjK2U1EukZdhUZp9tz6TuF
X-Google-Smtp-Source: AGHT+IHeszHzZxN6YjuZtjIOClYNH85ZlyBcfL2ac3FFC3tvNcxprtNdx8eL6XKlARNKaqjgyOnit7Z8lQt+5lK5xYI=
X-Received: by 2002:a05:6122:6088:b0:50d:57df:1522 with SMTP id
 71dfb90a1353d-515004dfda8mr2115289e0c.6.1732262175954; Thu, 21 Nov 2024
 23:56:15 -0800 (PST)
MIME-Version: 1.0
References: <20241113142343.40832-1-phil@philjordan.eu>
 <20241113142343.40832-2-phil@philjordan.eu>
 <4ff6f75f-eece-4c78-9701-fc190e483f4e@daynix.com>
In-Reply-To: <4ff6f75f-eece-4c78-9701-fc190e483f4e@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Fri, 22 Nov 2024 08:56:05 +0100
Message-ID: <CAAibmn39y+jk3FECAx5q0PrWrcvc=wXQ5dttztYyaWNVyL4jMQ@mail.gmail.com>
Subject: Re: [PATCH v10 01/15] ui & main loop: Redesign of system-specific
 main thread event handling
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 gaosong@loongson.cn, jiaxun.yang@flygoat.com, chenhuacai@kernel.org, 
 kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, 
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org, 
 balaton@eik.bme.hu
Content-Type: multipart/alternative; boundary="000000000000a7ef7d06277bb764"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=phil@philjordan.eu; helo=mail-vk1-xa2c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000a7ef7d06277bb764
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri 22. Nov 2024 at 06:02, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> On 2024/11/13 23:23, Phil Dennis-Jordan wrote:
> > macOS's Cocoa event handling must be done on the initial (main) thread
> > of the process. Furthermore, if library or application code uses
> > libdispatch, the main dispatch queue must be handling events on the mai=
n
> > thread as well.
> >
> > So far, this has affected Qemu in both the Cocoa and SDL UIs, although
> > in different ways: the Cocoa UI replaces the default qemu_main function
> > with one that spins Qemu's internal main event loop off onto a
> > background thread. SDL (which uses Cocoa internally) on the other hand
> > uses a polling approach within Qemu's main event loop. Events are
> > polled during the SDL UI's dpy_refresh callback, which happens to run
> > on the main thread by default.
> >
> > As UIs are mutually exclusive, this works OK as long as nothing else
> > needs platform-native event handling. In the next patch, a new device i=
s
> > introduced based on the ParavirtualizedGraphics.framework in macOS.
> > This uses libdispatch internally, and only works when events are being
> > handled on the main runloop. With the current system, it works when
> > using either the Cocoa or the SDL UI. However, it does not when running
> > headless. Moreover, any attempt to install a similar scheme to the
> > Cocoa UI's main thread replacement fails when combined with the SDL
> > UI.
> >
> > This change tidies up main thread management to be more flexible.
> >
> >   * The qemu_main global function pointer is a custom function for the
> >     main thread, and it may now be NULL. When it is, the main thread
> >     runs the main Qemu loop. This represents the traditional setup.
> >   * When non-null, spawning the main Qemu event loop on a separate
> >     thread is now done centrally rather than inside the Cocoa UI code.
> >   * For most platforms, qemu_main is indeed NULL by default, but on
> >     Darwin, it defaults to a function that runs the CFRunLoop.
> >   * The Cocoa UI sets qemu_main to a function which runs the
> >     NSApplication event handling runloop, as is usual for a Cocoa app.
> >   * The SDL UI overrides the qemu_main function to NULL, thus
> >     specifying that Qemu's main loop must run on the main
> >     thread.
> >   * The GTK UI also overrides the qemu_main function to NULL.
> >   * For other UIs, or in the absence of UIs, the platform's default
> >     behaviour is followed.
> >
> > This means that on macOS, the platform's runloop events are always
> > handled, regardless of chosen UI. The new PV graphics device will
> > thus work in all configurations. There is no functional change on other
> > operating systems.
> >
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> >
> > v5:
> >
> >   * Simplified the way of setting/clearing the main loop by going back
> >     to setting qemu_main directly, but narrowing the scope of what it
> >     needs to do, and it can now be NULL.
> >
> > v6:
> >
> >   * Folded function qemu_run_default_main_on_new_thread's code into
> >     main()
> >   * Removed whitespace changes left over on lines near code removed
> >     between v4 and v5
> >
> > v9:
> >
> >   * Set qemu_main to NULL for GTK UI as well.
> >
> > v10:
> >
> >   * Added comments clarifying the functionality and purpose of qemu_mai=
n.
> >
> >   include/qemu-main.h     | 21 ++++++++++++++--
> >   include/qemu/typedefs.h |  1 +
> >   system/main.c           | 50 ++++++++++++++++++++++++++++++++++----
> >   ui/cocoa.m              | 54 ++++++++++------------------------------=
-
> >   ui/gtk.c                |  8 ++++++
> >   ui/sdl2.c               |  4 +++
> >   6 files changed, 90 insertions(+), 48 deletions(-)
> >
> > diff --git a/include/qemu-main.h b/include/qemu-main.h
> > index 940960a7dbc..fc70681c8b5 100644
> > --- a/include/qemu-main.h
> > +++ b/include/qemu-main.h
> > @@ -5,7 +5,24 @@
> >   #ifndef QEMU_MAIN_H
> >   #define QEMU_MAIN_H
> >
> > -int qemu_default_main(void);
> > -extern int (*qemu_main)(void);
> > +/*
> > + * The function to run on the main (initial) thread of the process.
> > + * NULL means QEMU's main event loop.
> > + * When non-NULL, QEMU's main event loop will run on a purposely creat=
ed
> > + * thread, after which the provided function pointer will be invoked o=
n
> > + * the initial thread.
> > + * This is useful on platforms which treat the main thread as special
> > + * (macOS/Darwin) and/or require all UI API calls to occur from a
> > + * specific thread.
> > + * Implementing this via a global function pointer variable is a bit
> > + * ugly, but it's probably worth investigating the existing UI thread
> rule
> > + * violations in the SDL (e.g. #2537) and GTK+ back-ends. Fixing those
> > + * issues might precipitate requirements similar but not identical to
> those
> > + * of the Cocoa UI; hopefully we'll see some kind of pattern emerge,
> which
> > + * can then be used as a basis for an overhaul. (In fact, it may turn
> > + * out to be simplest to split the UI/native platform event thread fro=
m
> the
> > + * QEMU main event loop on all platforms, with any UI or even none at
> all.)
> > + */
> > +extern qemu_main_fn qemu_main;
> >
> >   #endif /* QEMU_MAIN_H */
> > diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> > index 3d84efcac47..b02cfe1f328 100644
> > --- a/include/qemu/typedefs.h
> > +++ b/include/qemu/typedefs.h
> > @@ -131,5 +131,6 @@ typedef struct IRQState *qemu_irq;
> >    * Function types
> >    */
> >   typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
> > +typedef int (*qemu_main_fn)(void);
> >
> >   #endif /* QEMU_TYPEDEFS_H */
> > diff --git a/system/main.c b/system/main.c
> > index 9b91d21ea8c..d9397a6d5d0 100644
> > --- a/system/main.c
> > +++ b/system/main.c
> > @@ -24,13 +24,14 @@
> >
> >   #include "qemu/osdep.h"
> >   #include "qemu-main.h"
> > +#include "qemu/main-loop.h"
> >   #include "sysemu/sysemu.h"
> >
> > -#ifdef CONFIG_SDL
> > -#include <SDL.h>
>
> I found dropping these lines prevent building for Windows. This is
> because pkg-config of sdl2 redefines main() as SDL_main(), and GCC
> complains
> -Wmissing-prototypes for SDL_main(). Here is a link to the relevant code
> in SDL2:
> https://github.com/libsdl-org/SDL/blob/release-2.30.9/CMakeLists.txt#L206=
1
>

Oof, good catch, thanks! I will add a comment for this because that=E2=80=
=99s
extremely non-obvious behaviour.


> > +#ifdef CONFIG_DARWIN
> > +#include <CoreFoundation/CoreFoundation.h>
> >   #endif
> >
> > -int qemu_default_main(void)
> > +static int qemu_default_main(void)
> >   {
> >       int status;
> >
> > @@ -40,10 +41,49 @@ int qemu_default_main(void)
> >       return status;
> >   }
> >
> > -int (*qemu_main)(void) =3D qemu_default_main;
> > +/*
> > + * Various macOS system libraries, including the Cocoa UI and anything
> using
> > + * libdispatch, such as ParavirtualizedGraphics.framework, requires
> that the
> > + * main runloop, on the main (initial) thread be running or at least
> regularly
> > + * polled for events. A special mode is therefore supported, where the
> QEMU
> > + * main loop runs on a separate thread and the main thread handles the
> > + * CF/Cocoa runloop.
> > + */
> > +
> > +static void *call_qemu_default_main(void *opaque)
> > +{
> > +    int status;
> > +
> > +    bql_lock();
> > +    status =3D qemu_default_main();
> > +    bql_unlock();
> > +
> > +    exit(status);
> > +}
> > +
> > +#ifdef CONFIG_DARWIN
> > +static int os_darwin_cfrunloop_main(void)
> > +{
> > +    CFRunLoopRun();
> > +    abort();
> > +}
> > +
> > +qemu_main_fn qemu_main =3D os_darwin_cfrunloop_main;
> > +#else
> > +qemu_main_fn qemu_main;
> > +#endif
> >
> >   int main(int argc, char **argv)
> >   {
> > +    QemuThread main_loop_thread;
> > +
> >       qemu_init(argc, argv);
> > -    return qemu_main();
> > +    if (qemu_main) {
> > +        qemu_thread_create(&main_loop_thread, "qemu_main",
> > +                           call_qemu_default_main, NULL,
> QEMU_THREAD_DETACHED);
> > +        bql_unlock();
> > +        return qemu_main();
> > +    } else {
> > +        qemu_default_main();
> > +    }
> >   }
> > diff --git a/ui/cocoa.m b/ui/cocoa.m
> > index 4c2dd335323..30b8920d929 100644
> > --- a/ui/cocoa.m
> > +++ b/ui/cocoa.m
> > @@ -73,6 +73,8 @@
> >       int height;
> >   } QEMUScreen;
> >
> > +@class QemuCocoaPasteboardTypeOwner;
> > +
> >   static void cocoa_update(DisplayChangeListener *dcl,
> >                            int x, int y, int w, int h);
> >
> > @@ -107,6 +109,7 @@ static void cocoa_switch(DisplayChangeListener *dcl=
,
> >   static NSInteger cbchangecount =3D -1;
> >   static QemuClipboardInfo *cbinfo;
> >   static QemuEvent cbevent;
> > +static QemuCocoaPasteboardTypeOwner *cbowner;
> >
> >   // Utility functions to run specified code block with the BQL held
> >   typedef void (^CodeBlock)(void);
> > @@ -1321,8 +1324,10 @@ - (void) dealloc
> >   {
> >       COCOA_DEBUG("QemuCocoaAppController: dealloc\n");
> >
> > -    if (cocoaView)
> > -        [cocoaView release];
> > +    [cocoaView release];
> > +    [cbowner release];
> > +    cbowner =3D nil;
> > +
> >       [super dealloc];
> >   }
> >
> > @@ -1938,8 +1943,6 @@ - (void)pasteboard:(NSPasteboard *)sender
> provideDataForType:(NSPasteboardType)t
> >
> >   @end
> >
> > -static QemuCocoaPasteboardTypeOwner *cbowner;
> > -
> >   static void cocoa_clipboard_notify(Notifier *notifier, void *data);
> >   static void cocoa_clipboard_request(QemuClipboardInfo *info,
> >                                       QemuClipboardType type);
> > @@ -2002,43 +2005,8 @@ static void
> cocoa_clipboard_request(QemuClipboardInfo *info,
> >       }
> >   }
> >
> > -/*
> > - * The startup process for the OSX/Cocoa UI is complicated, because
> > - * OSX insists that the UI runs on the initial main thread, and so we
> > - * need to start a second thread which runs the qemu_default_main():
> > - * in main():
> > - *  in cocoa_display_init():
> > - *   assign cocoa_main to qemu_main
> > - *   create application, menus, etc
> > - *  in cocoa_main():
> > - *   create qemu-main thread
> > - *   enter OSX run loop
> > - */
> > -
> > -static void *call_qemu_main(void *opaque)
> > -{
> > -    int status;
> > -
> > -    COCOA_DEBUG("Second thread: calling qemu_default_main()\n");
> > -    bql_lock();
> > -    status =3D qemu_default_main();
> > -    bql_unlock();
> > -    COCOA_DEBUG("Second thread: qemu_default_main() returned,
> exiting\n");
> > -    [cbowner release];
> > -    exit(status);
> > -}
> > -
> >   static int cocoa_main(void)
> >   {
> > -    QemuThread thread;
> > -
> > -    COCOA_DEBUG("Entered %s()\n", __func__);
> > -
> > -    bql_unlock();
> > -    qemu_thread_create(&thread, "qemu_main", call_qemu_main,
> > -                       NULL, QEMU_THREAD_DETACHED);
> > -
> > -    // Start the main event loop
> >       COCOA_DEBUG("Main thread: entering OSX run loop\n");
> >       [NSApp run];
> >       COCOA_DEBUG("Main thread: left OSX run loop, which should never
> happen\n");
> > @@ -2120,8 +2088,6 @@ static void cocoa_display_init(DisplayState *ds,
> DisplayOptions *opts)
> >
> >       COCOA_DEBUG("qemu_cocoa: cocoa_display_init\n");
> >
> > -    qemu_main =3D cocoa_main;
> > -
> >       // Pull this console process up to being a fully-fledged graphica=
l
> >       // app with a menubar and Dock icon
> >       ProcessSerialNumber psn =3D { 0, kCurrentProcess };
> > @@ -2185,6 +2151,12 @@ static void cocoa_display_init(DisplayState *ds,
> DisplayOptions *opts)
> >       qemu_clipboard_peer_register(&cbpeer);
> >
> >       [pool release];
> > +
> > +    /*
> > +     * The Cocoa UI will run the NSApplication runloop on the main
> thread
> > +     * rather than the default Core Foundation one.
> > +     */
> > +    qemu_main =3D cocoa_main;
> >   }
> >
> >   static QemuDisplay qemu_display_cocoa =3D {
> > diff --git a/ui/gtk.c b/ui/gtk.c
> > index bf9d3dd679a..fbf20161f36 100644
> > --- a/ui/gtk.c
> > +++ b/ui/gtk.c
> > @@ -38,6 +38,7 @@
> >   #include "qemu/cutils.h"
> >   #include "qemu/error-report.h"
> >   #include "qemu/main-loop.h"
> > +#include "qemu-main.h"
> >
> >   #include "ui/console.h"
> >   #include "ui/gtk.h"
> > @@ -2485,6 +2486,13 @@ static void gtk_display_init(DisplayState *ds,
> DisplayOptions *opts)
> >   #ifdef CONFIG_GTK_CLIPBOARD
> >       gd_clipboard_init(s);
> >   #endif /* CONFIG_GTK_CLIPBOARD */
> > +
> > +    /*
> > +     * GTK+ calls must happen on the main thread at least on some
> platforms,
> > +     * and on macOS the main runloop is polled via GTK+'s event
> handling.
> > +     * Don't allow QEMU's event loop to be moved off the main thread.
> > +     */
> > +    qemu_main =3D NULL;
> >   }
> >
> >   static void early_gtk_display_init(DisplayOptions *opts)
> > diff --git a/ui/sdl2.c b/ui/sdl2.c
> > index bd4f5a9da14..44ab2762262 100644
> > --- a/ui/sdl2.c
> > +++ b/ui/sdl2.c
> > @@ -34,6 +34,7 @@
> >   #include "sysemu/sysemu.h"
> >   #include "ui/win32-kbd-hook.h"
> >   #include "qemu/log.h"
> > +#include "qemu-main.h"
> >
> >   static int sdl2_num_outputs;
> >   static struct sdl2_console *sdl2_console;
> > @@ -965,6 +966,9 @@ static void sdl2_display_init(DisplayState *ds,
> DisplayOptions *o)
> >       }
> >
> >       atexit(sdl_cleanup);
> > +
> > +    /* SDL's event polling (in dpy_refresh) must happen on the main
> thread. */
> > +    qemu_main =3D NULL;
> >   }
> >
> >   static QemuDisplay qemu_display_sdl2 =3D {
>
>

--000000000000a7ef7d06277bb764
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Fri 22. Nov 2024 at 06:02, Akihiko Odaki &lt;<a href=3D"=
mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">On 2024/11/13 23:23, Phil Dennis-Jord=
an wrote:<br>
&gt; macOS&#39;s Cocoa event handling must be done on the initial (main) th=
read<br>
&gt; of the process. Furthermore, if library or application code uses<br>
&gt; libdispatch, the main dispatch queue must be handling events on the ma=
in<br>
&gt; thread as well.<br>
&gt; <br>
&gt; So far, this has affected Qemu in both the Cocoa and SDL UIs, although=
<br>
&gt; in different ways: the Cocoa UI replaces the default qemu_main functio=
n<br>
&gt; with one that spins Qemu&#39;s internal main event loop off onto a<br>
&gt; background thread. SDL (which uses Cocoa internally) on the other hand=
<br>
&gt; uses a polling approach within Qemu&#39;s main event loop. Events are<=
br>
&gt; polled during the SDL UI&#39;s dpy_refresh callback, which happens to =
run<br>
&gt; on the main thread by default.<br>
&gt; <br>
&gt; As UIs are mutually exclusive, this works OK as long as nothing else<b=
r>
&gt; needs platform-native event handling. In the next patch, a new device =
is<br>
&gt; introduced based on the ParavirtualizedGraphics.framework in macOS.<br=
>
&gt; This uses libdispatch internally, and only works when events are being=
<br>
&gt; handled on the main runloop. With the current system, it works when<br=
>
&gt; using either the Cocoa or the SDL UI. However, it does not when runnin=
g<br>
&gt; headless. Moreover, any attempt to install a similar scheme to the<br>
&gt; Cocoa UI&#39;s main thread replacement fails when combined with the SD=
L<br>
&gt; UI.<br>
&gt; <br>
&gt; This change tidies up main thread management to be more flexible.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* The qemu_main global function pointer is a custom functi=
on for the<br>
&gt;=C2=A0 =C2=A0 =C2=A0main thread, and it may now be NULL. When it is, th=
e main thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0runs the main Qemu loop. This represents the tradit=
ional setup.<br>
&gt;=C2=A0 =C2=A0* When non-null, spawning the main Qemu event loop on a se=
parate<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread is now done centrally rather than inside the=
 Cocoa UI code.<br>
&gt;=C2=A0 =C2=A0* For most platforms, qemu_main is indeed NULL by default,=
 but on<br>
&gt;=C2=A0 =C2=A0 =C2=A0Darwin, it defaults to a function that runs the CFR=
unLoop.<br>
&gt;=C2=A0 =C2=A0* The Cocoa UI sets qemu_main to a function which runs the=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0NSApplication event handling runloop, as is usual f=
or a Cocoa app.<br>
&gt;=C2=A0 =C2=A0* The SDL UI overrides the qemu_main function to NULL, thu=
s<br>
&gt;=C2=A0 =C2=A0 =C2=A0specifying that Qemu&#39;s main loop must run on th=
e main<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread.<br>
&gt;=C2=A0 =C2=A0* The GTK UI also overrides the qemu_main function to NULL=
.<br>
&gt;=C2=A0 =C2=A0* For other UIs, or in the absence of UIs, the platform&#3=
9;s default<br>
&gt;=C2=A0 =C2=A0 =C2=A0behaviour is followed.<br>
&gt; <br>
&gt; This means that on macOS, the platform&#39;s runloop events are always=
<br>
&gt; handled, regardless of chosen UI. The new PV graphics device will<br>
&gt; thus work in all configurations. There is no functional change on othe=
r<br>
&gt; operating systems.<br>
&gt; <br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; Reviewed-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.=
com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
&gt; ---<br>
&gt; <br>
&gt; v5:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Simplified the way of setting/clearing the main loop by =
going back<br>
&gt;=C2=A0 =C2=A0 =C2=A0to setting qemu_main directly, but narrowing the sc=
ope of what it<br>
&gt;=C2=A0 =C2=A0 =C2=A0needs to do, and it can now be NULL.<br>
&gt; <br>
&gt; v6:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Folded function qemu_run_default_main_on_new_thread&#39;=
s code into<br>
&gt;=C2=A0 =C2=A0 =C2=A0main()<br>
&gt;=C2=A0 =C2=A0* Removed whitespace changes left over on lines near code =
removed<br>
&gt;=C2=A0 =C2=A0 =C2=A0between v4 and v5<br>
&gt; <br>
&gt; v9:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Set qemu_main to NULL for GTK UI as well.<br>
&gt; <br>
&gt; v10:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Added comments clarifying the functionality and purpose =
of qemu_main.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0include/qemu-main.h=C2=A0 =C2=A0 =C2=A0| 21 ++++++++++++++=
--<br>
&gt;=C2=A0 =C2=A0include/qemu/typedefs.h |=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0system/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 50=
 ++++++++++++++++++++++++++++++++++----<br>
&gt;=C2=A0 =C2=A0ui/cocoa.m=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | 54 ++++++++++-------------------------------<br>
&gt;=C2=A0 =C2=A0ui/gtk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 8 ++++++<br>
&gt;=C2=A0 =C2=A0ui/sdl2.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 4 +++<br>
&gt;=C2=A0 =C2=A06 files changed, 90 insertions(+), 48 deletions(-)<br>
&gt; <br>
&gt; diff --git a/include/qemu-main.h b/include/qemu-main.h<br>
&gt; index 940960a7dbc..fc70681c8b5 100644<br>
&gt; --- a/include/qemu-main.h<br>
&gt; +++ b/include/qemu-main.h<br>
&gt; @@ -5,7 +5,24 @@<br>
&gt;=C2=A0 =C2=A0#ifndef QEMU_MAIN_H<br>
&gt;=C2=A0 =C2=A0#define QEMU_MAIN_H<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -int qemu_default_main(void);<br>
&gt; -extern int (*qemu_main)(void);<br>
&gt; +/*<br>
&gt; + * The function to run on the main (initial) thread of the process.<b=
r>
&gt; + * NULL means QEMU&#39;s main event loop.<br>
&gt; + * When non-NULL, QEMU&#39;s main event loop will run on a purposely =
created<br>
&gt; + * thread, after which the provided function pointer will be invoked =
on<br>
&gt; + * the initial thread.<br>
&gt; + * This is useful on platforms which treat the main thread as special=
<br>
&gt; + * (macOS/Darwin) and/or require all UI API calls to occur from a<br>
&gt; + * specific thread.<br>
&gt; + * Implementing this via a global function pointer variable is a bit<=
br>
&gt; + * ugly, but it&#39;s probably worth investigating the existing UI th=
read rule<br>
&gt; + * violations in the SDL (e.g. #2537) and GTK+ back-ends. Fixing thos=
e<br>
&gt; + * issues might precipitate requirements similar but not identical to=
 those<br>
&gt; + * of the Cocoa UI; hopefully we&#39;ll see some kind of pattern emer=
ge, which<br>
&gt; + * can then be used as a basis for an overhaul. (In fact, it may turn=
<br>
&gt; + * out to be simplest to split the UI/native platform event thread fr=
om the<br>
&gt; + * QEMU main event loop on all platforms, with any UI or even none at=
 all.)<br>
&gt; + */<br>
&gt; +extern qemu_main_fn qemu_main;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#endif /* QEMU_MAIN_H */<br>
&gt; diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h<br>
&gt; index 3d84efcac47..b02cfe1f328 100644<br>
&gt; --- a/include/qemu/typedefs.h<br>
&gt; +++ b/include/qemu/typedefs.h<br>
&gt; @@ -131,5 +131,6 @@ typedef struct IRQState *qemu_irq;<br>
&gt;=C2=A0 =C2=A0 * Function types<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0typedef void (*qemu_irq_handler)(void *opaque, int n, int =
level);<br>
&gt; +typedef int (*qemu_main_fn)(void);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#endif /* QEMU_TYPEDEFS_H */<br>
&gt; diff --git a/system/main.c b/system/main.c<br>
&gt; index 9b91d21ea8c..d9397a6d5d0 100644<br>
&gt; --- a/system/main.c<br>
&gt; +++ b/system/main.c<br>
&gt; @@ -24,13 +24,14 @@<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu-main.h&quot;<br>
&gt; +#include &quot;qemu/main-loop.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;sysemu/sysemu.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -#ifdef CONFIG_SDL<br>
&gt; -#include &lt;SDL.h&gt;<br>
<br>
I found dropping these lines prevent building for Windows. This is <br>
because pkg-config of sdl2 redefines main() as SDL_main(), and GCC complain=
s<br>
-Wmissing-prototypes for SDL_main(). Here is a link to the relevant code <b=
r>
in SDL2:<br>
<a href=3D"https://github.com/libsdl-org/SDL/blob/release-2.30.9/CMakeLists=
.txt#L2061" rel=3D"noreferrer" target=3D"_blank">https://github.com/libsdl-=
org/SDL/blob/release-2.30.9/CMakeLists.txt#L2061</a><br>
</blockquote><div dir=3D"auto"><br></div><div dir=3D"auto">Oof, good catch,=
 thanks! I will add a comment for this because that=E2=80=99s extremely non=
-obvious behaviour.=C2=A0</div><div dir=3D"auto"><br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><br>
&gt; +#ifdef CONFIG_DARWIN<br>
&gt; +#include &lt;CoreFoundation/CoreFoundation.h&gt;<br>
&gt;=C2=A0 =C2=A0#endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -int qemu_default_main(void)<br>
&gt; +static int qemu_default_main(void)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int status;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -40,10 +41,49 @@ int qemu_default_main(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return status;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -int (*qemu_main)(void) =3D qemu_default_main;<br>
&gt; +/*<br>
&gt; + * Various macOS system libraries, including the Cocoa UI and anythin=
g using<br>
&gt; + * libdispatch, such as ParavirtualizedGraphics.framework, requires t=
hat the<br>
&gt; + * main runloop, on the main (initial) thread be running or at least =
regularly<br>
&gt; + * polled for events. A special mode is therefore supported, where th=
e QEMU<br>
&gt; + * main loop runs on a separate thread and the main thread handles th=
e<br>
&gt; + * CF/Cocoa runloop.<br>
&gt; + */<br>
&gt; +<br>
&gt; +static void *call_qemu_default_main(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int status;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 bql_lock();<br>
&gt; +=C2=A0 =C2=A0 status =3D qemu_default_main();<br>
&gt; +=C2=A0 =C2=A0 bql_unlock();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 exit(status);<br>
&gt; +}<br>
&gt; +<br>
&gt; +#ifdef CONFIG_DARWIN<br>
&gt; +static int os_darwin_cfrunloop_main(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 CFRunLoopRun();<br>
&gt; +=C2=A0 =C2=A0 abort();<br>
&gt; +}<br>
&gt; +<br>
&gt; +qemu_main_fn qemu_main =3D os_darwin_cfrunloop_main;<br>
&gt; +#else<br>
&gt; +qemu_main_fn qemu_main;<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; +=C2=A0 =C2=A0 QemuThread main_loop_thread;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_init(argc, argv);<br>
&gt; -=C2=A0 =C2=A0 return qemu_main();<br>
&gt; +=C2=A0 =C2=A0 if (qemu_main) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_thread_create(&amp;main_loop_thread,=
 &quot;qemu_main&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0call_qemu_default_main, NULL, QEMU_THREAD_DETAC=
HED);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bql_unlock();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return qemu_main();<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_default_main();<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; diff --git a/ui/cocoa.m b/ui/cocoa.m<br>
&gt; index 4c2dd335323..30b8920d929 100644<br>
&gt; --- a/ui/cocoa.m<br>
&gt; +++ b/ui/cocoa.m<br>
&gt; @@ -73,6 +73,8 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int height;<br>
&gt;=C2=A0 =C2=A0} QEMUScreen;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +@class QemuCocoaPasteboardTypeOwner;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static void cocoa_update(DisplayChangeListener *dcl,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int x, int y, int w, int h);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -107,6 +109,7 @@ static void cocoa_switch(DisplayChangeListener *dc=
l,<br>
&gt;=C2=A0 =C2=A0static NSInteger cbchangecount =3D -1;<br>
&gt;=C2=A0 =C2=A0static QemuClipboardInfo *cbinfo;<br>
&gt;=C2=A0 =C2=A0static QemuEvent cbevent;<br>
&gt; +static QemuCocoaPasteboardTypeOwner *cbowner;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0// Utility functions to run specified code block with the =
BQL held<br>
&gt;=C2=A0 =C2=A0typedef void (^CodeBlock)(void);<br>
&gt; @@ -1321,8 +1324,10 @@ - (void) dealloc<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0COCOA_DEBUG(&quot;QemuCocoaAppController: de=
alloc\n&quot;);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 if (cocoaView)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 [cocoaView release];<br>
&gt; +=C2=A0 =C2=A0 [cocoaView release];<br>
&gt; +=C2=A0 =C2=A0 [cbowner release];<br>
&gt; +=C2=A0 =C2=A0 cbowner =3D nil;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[super dealloc];<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -1938,8 +1943,6 @@ - (void)pasteboard:(NSPasteboard *)sender provid=
eDataForType:(NSPasteboardType)t<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0@end<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -static QemuCocoaPasteboardTypeOwner *cbowner;<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0static void cocoa_clipboard_notify(Notifier *notifier, voi=
d *data);<br>
&gt;=C2=A0 =C2=A0static void cocoa_clipboard_request(QemuClipboardInfo *inf=
o,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QemuCl=
ipboardType type);<br>
&gt; @@ -2002,43 +2005,8 @@ static void cocoa_clipboard_request(QemuClipboa=
rdInfo *info,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -/*<br>
&gt; - * The startup process for the OSX/Cocoa UI is complicated, because<b=
r>
&gt; - * OSX insists that the UI runs on the initial main thread, and so we=
<br>
&gt; - * need to start a second thread which runs the qemu_default_main():<=
br>
&gt; - * in main():<br>
&gt; - *=C2=A0 in cocoa_display_init():<br>
&gt; - *=C2=A0 =C2=A0assign cocoa_main to qemu_main<br>
&gt; - *=C2=A0 =C2=A0create application, menus, etc<br>
&gt; - *=C2=A0 in cocoa_main():<br>
&gt; - *=C2=A0 =C2=A0create qemu-main thread<br>
&gt; - *=C2=A0 =C2=A0enter OSX run loop<br>
&gt; - */<br>
&gt; -<br>
&gt; -static void *call_qemu_main(void *opaque)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 int status;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 COCOA_DEBUG(&quot;Second thread: calling qemu_default_m=
ain()\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 bql_lock();<br>
&gt; -=C2=A0 =C2=A0 status =3D qemu_default_main();<br>
&gt; -=C2=A0 =C2=A0 bql_unlock();<br>
&gt; -=C2=A0 =C2=A0 COCOA_DEBUG(&quot;Second thread: qemu_default_main() re=
turned, exiting\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 [cbowner release];<br>
&gt; -=C2=A0 =C2=A0 exit(status);<br>
&gt; -}<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0static int cocoa_main(void)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 QemuThread thread;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 COCOA_DEBUG(&quot;Entered %s()\n&quot;, __func__);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 bql_unlock();<br>
&gt; -=C2=A0 =C2=A0 qemu_thread_create(&amp;thread, &quot;qemu_main&quot;, =
call_qemu_main,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0NULL, QEMU_THREAD_DETACHED);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 // Start the main event loop<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0COCOA_DEBUG(&quot;Main thread: entering OSX =
run loop\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[NSApp run];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0COCOA_DEBUG(&quot;Main thread: left OSX run =
loop, which should never happen\n&quot;);<br>
&gt; @@ -2120,8 +2088,6 @@ static void cocoa_display_init(DisplayState *ds,=
 DisplayOptions *opts)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0COCOA_DEBUG(&quot;qemu_cocoa: cocoa_display_=
init\n&quot;);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 qemu_main =3D cocoa_main;<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0// Pull this console process up to being a f=
ully-fledged graphical<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0// app with a menubar and Dock icon<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ProcessSerialNumber psn =3D { 0, kCurrentPro=
cess };<br>
&gt; @@ -2185,6 +2151,12 @@ static void cocoa_display_init(DisplayState *ds=
, DisplayOptions *opts)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_clipboard_peer_register(&amp;cbpeer);<b=
r>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[pool release];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* The Cocoa UI will run the NSApplication runloop=
 on the main thread<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* rather than the default Core Foundation one.<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 qemu_main =3D cocoa_main;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static QemuDisplay qemu_display_cocoa =3D {<br>
&gt; diff --git a/ui/gtk.c b/ui/gtk.c<br>
&gt; index bf9d3dd679a..fbf20161f36 100644<br>
&gt; --- a/ui/gtk.c<br>
&gt; +++ b/ui/gtk.c<br>
&gt; @@ -38,6 +38,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu/cutils.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu/error-report.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu/main-loop.h&quot;<br>
&gt; +#include &quot;qemu-main.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#include &quot;ui/console.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;ui/gtk.h&quot;<br>
&gt; @@ -2485,6 +2486,13 @@ static void gtk_display_init(DisplayState *ds, =
DisplayOptions *opts)<br>
&gt;=C2=A0 =C2=A0#ifdef CONFIG_GTK_CLIPBOARD<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0gd_clipboard_init(s);<br>
&gt;=C2=A0 =C2=A0#endif /* CONFIG_GTK_CLIPBOARD */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* GTK+ calls must happen on the main thread at le=
ast on some platforms,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* and on macOS the main runloop is polled via GTK=
+&#39;s event handling.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Don&#39;t allow QEMU&#39;s event loop to be mov=
ed off the main thread.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 qemu_main =3D NULL;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void early_gtk_display_init(DisplayOptions *opts)<b=
r>
&gt; diff --git a/ui/sdl2.c b/ui/sdl2.c<br>
&gt; index bd4f5a9da14..44ab2762262 100644<br>
&gt; --- a/ui/sdl2.c<br>
&gt; +++ b/ui/sdl2.c<br>
&gt; @@ -34,6 +34,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;sysemu/sysemu.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;ui/win32-kbd-hook.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu/log.h&quot;<br>
&gt; +#include &quot;qemu-main.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static int sdl2_num_outputs;<br>
&gt;=C2=A0 =C2=A0static struct sdl2_console *sdl2_console;<br>
&gt; @@ -965,6 +966,9 @@ static void sdl2_display_init(DisplayState *ds, Di=
splayOptions *o)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0atexit(sdl_cleanup);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* SDL&#39;s event polling (in dpy_refresh) must happen=
 on the main thread. */<br>
&gt; +=C2=A0 =C2=A0 qemu_main =3D NULL;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static QemuDisplay qemu_display_sdl2 =3D {<br>
<br>
</blockquote></div></div>

--000000000000a7ef7d06277bb764--

