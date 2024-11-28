Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BFCD70DED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 19:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGkQg-00039A-MQ; Thu, 28 Nov 2024 14:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tGkQd-000389-Rg
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 14:43:55 -0500
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tGkQZ-0004hx-NI
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 14:43:55 -0500
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-85b47f0ec68so253804241.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 11:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1732823030; x=1733427830;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cqkCWUBOc7tnBONmY16AKJp3O7dG3StDbu/gnzqDuCQ=;
 b=E0uEpkQOWucdwCzBIVmfbJOBnCpNc1KZmFayGvfQkkw+rYL+3h3xZ1sCgsyV+v+MQ3
 TShsmLceFXHfTVp2mEPbDLDp8fIsUreEJZ2J2nrvLbjAuHOVn4550aje1sy6w/EJyxuP
 /7UCsIacKkAtFxqN635zHbJ3UAQ8qh15Oo66NH2nYnGmv7W+RKJqAZFNLYlBmFADv/+h
 CRrR35OU7/WcRqO2GjWu5kLkxN0MZs+pBYCaSD+xBztt9uZMFVAsPC4UTxLhi1baTXqg
 Sxf2ofWrU7J8L0w6bYDKJ/dHfNibVAZvgisCmQ7o/1zUQiLeCMbbNPEWVVHMAJrkMZR0
 FPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732823030; x=1733427830;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cqkCWUBOc7tnBONmY16AKJp3O7dG3StDbu/gnzqDuCQ=;
 b=U7VXnRyY344o2WryGsPwxdgIG2otIj9/w7Oz3+kBXCcspx8KgSdLcbcPRaTaB2/2Oz
 EH3xM3ZtSrRL9c0P2OnBbCXBglIjZiKyFRq71I93zbibgn7+iH4k8kynqQQMt6XGOfzu
 BPuJSR5v4BP0lTp1NI2JDy5qBhHgM29Evykbe1BKALLMmoRHhWSuJ0LArKUNdk9qKo8J
 6Cys0ysuzjavF9J2OfvEZB3U8Lf1R/n2PD4VeZDmc2U5QRPdm5d3eSu3akFXSimUIWXZ
 xuK/L361TePusCCpnsm1Ep23BST8zdOL9EAyfZdbVlLwE+A0rXfvay5OjYIbRM6RomUn
 sDFQ==
X-Gm-Message-State: AOJu0YybeYxdIpBOGnNcRMIcST1grQWkZTRfLJbfN+w9OwK1Q2dIdgae
 v16zFugAvrx6urqBy7GzZFSX+9OWg1EQIKIJJDo5pL6GmiJ7H7wee4w5CIPLlNHa1vWDvmgTHcc
 QBUCvRPa3HsjqT97JSLGjSndaqYJDx95ak470
X-Gm-Gg: ASbGncvNVpkZ50U2+V999K/G0yOztu9zvqCg0wQ6a4ABVAyyVk/VWdo+3xlaS3bwTTV
 lXfxcgSVkk0StwK1mb/dDXYPq7dPtWGE=
X-Google-Smtp-Source: AGHT+IHMXwBemjM2U2FCrzLph8WYhyxOTmsE3FZChwF+Sqq6GfoXtj3hFdYXtpZd+CWDOGGmWcSO9FSMctfEELYK1bs=
X-Received: by 2002:a05:6102:3585:b0:4ad:4fc1:5783 with SMTP id
 ada2fe7eead31-4af44850c88mr10176920137.10.1732823030224; Thu, 28 Nov 2024
 11:43:50 -0800 (PST)
MIME-Version: 1.0
References: <20241127150249.50767-1-phil@philjordan.eu>
 <20241127150249.50767-2-phil@philjordan.eu>
 <0533bb69-6f3a-4ebf-ae0c-99b569e61ba3@daynix.com>
In-Reply-To: <0533bb69-6f3a-4ebf-ae0c-99b569e61ba3@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Thu, 28 Nov 2024 20:43:39 +0100
Message-ID: <CAAibmn26tZneZHytkYCgd4oT8Yx465i=3wu8cYXTwu3Ki8pAJw@mail.gmail.com>
Subject: Re: [PATCH v11 01/15] ui & main loop: Redesign of system-specific
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
Content-Type: multipart/alternative; boundary="0000000000002cf31f0627fe4d60"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::92f;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x92f.google.com
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

--0000000000002cf31f0627fe4d60
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Nov 2024 at 12:17, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> On 2024/11/28 0:02, Phil Dennis-Jordan wrote:
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
> > Implementing this via a global function pointer variable is a bit
> > ugly, but it's probably worth investigating the existing UI thread rule
> > violations in the SDL (e.g. #2537) and GTK+ back-ends. Fixing those
> > issues might precipitate requirements similar but not identical to thos=
e
> > of the Cocoa UI; hopefully we'll see some kind of pattern emerge, which
> > can then be used as a basis for an overhaul. (In fact, it may turn
> > out to be simplest to split the UI/native platform event thread from th=
e
> > QEMU main event loop on all platforms, with any UI or even none at all.=
)
> >
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
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
> > v11:
> >
> >   * Removed the qemu_main_fn typedef again.
> >   * Consolidation of main, qemu_default_main, and call_qemu_default_mai=
n
> >     so that the latter has been eliminated altogether.
> >   * Reinstated the #include <SDL.h> directive, added comment saying
> >     why it's needed.
> >   * Improved the comment on the qemu_main global variable.
> >   * Expanded the commit message.
> >
> >   include/qemu-main.h | 14 +++++++++++-
> >   system/main.c       | 37 +++++++++++++++++++++++++++----
> >   ui/cocoa.m          | 54 +++++++++++---------------------------------=
-
> >   ui/gtk.c            |  8 +++++++
> >   ui/sdl2.c           |  4 ++++
> >   5 files changed, 71 insertions(+), 46 deletions(-)
> >
> > diff --git a/include/qemu-main.h b/include/qemu-main.h
> > index 940960a7dbc..a926def7526 100644
> > --- a/include/qemu-main.h
> > +++ b/include/qemu-main.h
> > @@ -5,7 +5,19 @@
> >   #ifndef QEMU_MAIN_H
> >   #define QEMU_MAIN_H
> >
> > -int qemu_default_main(void);
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
> > + * specific thread. Those platforms can initialise it to a specific
> function,
>
> Although the change from v10 looks good, I have a few comments:
>
> Here, it says "require all UI API calls to occur from a specific
> thread", but it is clearer to say "require all UI API calls to occur
> from *the main thread*". If we only need to ensure all UI API calls to
> occur from one thread, arranging all calls to happen in the thread
> running QEMU's main loop is sufficient. This variable is necessary only
> when the thread is the one that called main().
>

Is there a simple way to reliably run a block of code on the thread running
QEMU's main loop? (*) BHs will run on any thread that's blocked in
AIO_WAIT_WHILE(NULL, =E2=80=A6) or similar, so those are not suitable. Appa=
rently
GTK+ on Win32 requires all API calls to originate from one thread, but it
doesn't need to be the main thread, which is why I chose that phrasing. But
I suppose if that's the only restriction, the UI can spawn its own thread
and leave the main thread alone.

(*) This would be good to know for fixing this bug
https://gitlab.com/qemu-project/qemu/-/issues/2537 where the SDL UI
code causes a hang by calling into SDL_SetWindowSize() from a CPU thread.
My current thinking on that one is to use SDL_PushEvent() with a custom
event type generated by SDL_RegisterEvents(), which then will be handled
via the standard SDL event polling mechanism; but that seems awkward.

> + * while UI implementations may reset it to NULL during their init if
> they
> > + * will handle system and UI events on the main thread via QEMU's own
> main
> > + * event loop.> + */
> >   extern int (*qemu_main)(void);
> >
> >   #endif /* QEMU_MAIN_H */
> > diff --git a/system/main.c b/system/main.c
> > index 9b91d21ea8c..668d0ecfe8c 100644
> > --- a/system/main.c
> > +++ b/system/main.c
> > @@ -24,26 +24,55 @@
> >
> >   #include "qemu/osdep.h"
> >   #include "qemu-main.h"
> > +#include "qemu/main-loop.h"
> >   #include "sysemu/sysemu.h"
> >
> >   #ifdef CONFIG_SDL
> > +/*
> > + * SDL insists on wrapping the main() function with its own
> implementation on
> > + * some platforms; it does so via a macro that renames our main
> function, so
> > + * <SDL.h> must be #included here even with no SDL code called from
> this file.
> > + */
> >   #include <SDL.h>
> >   #endif
> >
> > -int qemu_default_main(void)
> > +#ifdef CONFIG_DARWIN
> > +#include <CoreFoundation/CoreFoundation.h>
> > +#endif
> > +
> > +static void *qemu_default_main(void *opaque)
> >   {
> >       int status;
> >
> > +    bql_lock();
> >       status =3D qemu_main_loop();
> >       qemu_cleanup(status);
> > +    bql_unlock();
> >
> > -    return status;
> > +    exit(status);
> >   }
> >
> > -int (*qemu_main)(void) =3D qemu_default_main;
> > +int (*qemu_main)(void);
> > +
> > +#ifdef CONFIG_DARWIN
> > +static int os_darwin_cfrunloop_main(void)
> > +{
> > +    CFRunLoopRun();
> > +    g_assert_not_reached();
> > +}
> > +int (*qemu_main)(void) =3D os_darwin_cfrunloop_main;
> > +#endif
> >
> >   int main(int argc, char **argv)
> >   {
> >       qemu_init(argc, argv);
> > -    return qemu_main();
> > +    bql_unlock();
> > +    if (qemu_main) {
> > +        QemuThread main_loop_thread;
> > +        qemu_thread_create(&main_loop_thread, "qemu_main",
> > +                           qemu_default_main, NULL,
> QEMU_THREAD_DETACHED);
> > +        return qemu_main();
> > +    } else {
> > +        qemu_default_main(NULL);
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
> > index bf9d3dd679a..5e6ee5c12a2 100644
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
>
> ui/gtk.c and ui/sdl2.c have the same background so the comments should
> also be identical except names.
>

Well, GTK doesn't currently do this, which is why it doesn't work on macOS,
but hopefully this patch will be merged in some form, at which point it
will:

https://patchew.org/QEMU/20241121162146.53643-1-charmitro@posteo.net/

But yeah, thanks to this patch we know that's a solution for GTK as well,
and I can update the comment.


> > +    qemu_main =3D NULL;
> >   }
> >
> >   static QemuDisplay qemu_display_sdl2 =3D {
>
>

--0000000000002cf31f0627fe4d60
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, 28 Nov 2024 at 12:17, Akihiko=
 Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On 2024/11/28 0:02, Phil Dennis-Jordan wrote:<br>
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
&gt; Implementing this via a global function pointer variable is a bit<br>
&gt; ugly, but it&#39;s probably worth investigating the existing UI thread=
 rule<br>
&gt; violations in the SDL (e.g. #2537) and GTK+ back-ends. Fixing those<br=
>
&gt; issues might precipitate requirements similar but not identical to tho=
se<br>
&gt; of the Cocoa UI; hopefully we&#39;ll see some kind of pattern emerge, =
which<br>
&gt; can then be used as a basis for an overhaul. (In fact, it may turn<br>
&gt; out to be simplest to split the UI/native platform event thread from t=
he<br>
&gt; QEMU main event loop on all platforms, with any UI or even none at all=
.)<br>
&gt; <br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
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
&gt; v11:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Removed the qemu_main_fn typedef again.<br>
&gt;=C2=A0 =C2=A0* Consolidation of main, qemu_default_main, and call_qemu_=
default_main<br>
&gt;=C2=A0 =C2=A0 =C2=A0so that the latter has been eliminated altogether.<=
br>
&gt;=C2=A0 =C2=A0* Reinstated the #include &lt;SDL.h&gt; directive, added c=
omment saying<br>
&gt;=C2=A0 =C2=A0 =C2=A0why it&#39;s needed.<br>
&gt;=C2=A0 =C2=A0* Improved the comment on the qemu_main global variable.<b=
r>
&gt;=C2=A0 =C2=A0* Expanded the commit message.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0include/qemu-main.h | 14 +++++++++++-<br>
&gt;=C2=A0 =C2=A0system/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 37 +++++++++++++=
++++++++++++++----<br>
&gt;=C2=A0 =C2=A0ui/cocoa.m=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 54 ++++++++=
+++----------------------------------<br>
&gt;=C2=A0 =C2=A0ui/gtk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
8 +++++++<br>
&gt;=C2=A0 =C2=A0ui/sdl2.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
4 ++++<br>
&gt;=C2=A0 =C2=A05 files changed, 71 insertions(+), 46 deletions(-)<br>
&gt; <br>
&gt; diff --git a/include/qemu-main.h b/include/qemu-main.h<br>
&gt; index 940960a7dbc..a926def7526 100644<br>
&gt; --- a/include/qemu-main.h<br>
&gt; +++ b/include/qemu-main.h<br>
&gt; @@ -5,7 +5,19 @@<br>
&gt;=C2=A0 =C2=A0#ifndef QEMU_MAIN_H<br>
&gt;=C2=A0 =C2=A0#define QEMU_MAIN_H<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -int qemu_default_main(void);<br>
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
&gt; + * specific thread. Those platforms can initialise it to a specific f=
unction,<br>
<br>
Although the change from v10 looks good, I have a few comments:<br>
<br>
Here, it says &quot;require all UI API calls to occur from a specific <br>
thread&quot;, but it is clearer to say &quot;require all UI API calls to oc=
cur <br>
from *the main thread*&quot;. If we only need to ensure all UI API calls to=
 <br>
occur from one thread, arranging all calls to happen in the thread <br>
running QEMU&#39;s main loop is sufficient. This variable is necessary only=
 <br>
when the thread is the one that called main().<br></blockquote><div><br></d=
iv><div>Is there a simple way to reliably run a block of code on the thread=
 running QEMU&#39;s main loop? (*) BHs will run on any thread that&#39;s bl=
ocked in AIO_WAIT_WHILE(NULL, =E2=80=A6) or similar, so those are not suita=
ble. Apparently GTK+ on Win32 requires all API calls to originate from one =
thread, but it doesn&#39;t need to be the main thread, which is why I chose=
 that phrasing. But I suppose if that&#39;s the only restriction, the UI ca=
n spawn its own thread and leave the main thread alone.<br></div><div><br><=
/div><div>(*) This would be good to know for fixing this bug <a href=3D"htt=
ps://gitlab.com/qemu-project/qemu/-/issues/2537">https://gitlab.com/qemu-pr=
oject/qemu/-/issues/2537</a> where the SDL UI code=C2=A0causes a hang by ca=
lling into SDL_SetWindowSize() from a CPU thread. My current thinking on th=
at one is to use SDL_PushEvent() with a custom event type generated by SDL_=
RegisterEvents(), which then will be handled via the standard SDL event pol=
ling mechanism; but that seems awkward.<br></div><div><br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
&gt; + * while UI implementations may reset it to NULL during their init if=
 they<br>
&gt; + * will handle system and UI events on the main thread via QEMU&#39;s=
 own main<br>
&gt; + * event loop.&gt; + */<br>
&gt;=C2=A0 =C2=A0extern int (*qemu_main)(void);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#endif /* QEMU_MAIN_H */<br>
&gt; diff --git a/system/main.c b/system/main.c<br>
&gt; index 9b91d21ea8c..668d0ecfe8c 100644<br>
&gt; --- a/system/main.c<br>
&gt; +++ b/system/main.c<br>
&gt; @@ -24,26 +24,55 @@<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu-main.h&quot;<br>
&gt; +#include &quot;qemu/main-loop.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;sysemu/sysemu.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#ifdef CONFIG_SDL<br>
&gt; +/*<br>
&gt; + * SDL insists on wrapping the main() function with its own implement=
ation on<br>
&gt; + * some platforms; it does so via a macro that renames our main funct=
ion, so<br>
&gt; + * &lt;SDL.h&gt; must be #included here even with no SDL code called =
from this file.<br>
&gt; + */<br>
&gt;=C2=A0 =C2=A0#include &lt;SDL.h&gt;<br>
&gt;=C2=A0 =C2=A0#endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -int qemu_default_main(void)<br>
&gt; +#ifdef CONFIG_DARWIN<br>
&gt; +#include &lt;CoreFoundation/CoreFoundation.h&gt;<br>
&gt; +#endif<br>
&gt; +<br>
&gt; +static void *qemu_default_main(void *opaque)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int status;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 bql_lock();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D qemu_main_loop();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_cleanup(status);<br>
&gt; +=C2=A0 =C2=A0 bql_unlock();<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 return status;<br>
&gt; +=C2=A0 =C2=A0 exit(status);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -int (*qemu_main)(void) =3D qemu_default_main;<br>
&gt; +int (*qemu_main)(void);<br>
&gt; +<br>
&gt; +#ifdef CONFIG_DARWIN<br>
&gt; +static int os_darwin_cfrunloop_main(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 CFRunLoopRun();<br>
&gt; +=C2=A0 =C2=A0 g_assert_not_reached();<br>
&gt; +}<br>
&gt; +int (*qemu_main)(void) =3D os_darwin_cfrunloop_main;<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_init(argc, argv);<br>
&gt; -=C2=A0 =C2=A0 return qemu_main();<br>
&gt; +=C2=A0 =C2=A0 bql_unlock();<br>
&gt; +=C2=A0 =C2=A0 if (qemu_main) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 QemuThread main_loop_thread;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_thread_create(&amp;main_loop_thread,=
 &quot;qemu_main&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_default_main, NULL, QEMU_THREAD_DETACHED);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return qemu_main();<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_default_main(NULL);<br>
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
&gt; index bf9d3dd679a..5e6ee5c12a2 100644<br>
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
<br>
ui/gtk.c and ui/sdl2.c have the same background so the comments should <br>
also be identical except names.<br></blockquote><div><br></div><div>Well, G=
TK doesn&#39;t currently do this, which is why it doesn&#39;t work on macOS=
, but hopefully this patch will be merged in some form, at which point it w=
ill:</div><div><br></div><div><a href=3D"https://patchew.org/QEMU/202411211=
62146.53643-1-charmitro@posteo.net/">https://patchew.org/QEMU/2024112116214=
6.53643-1-charmitro@posteo.net/</a></div><div><br></div><div>But yeah, than=
ks to this patch we know that&#39;s a solution for GTK as well, and I can u=
pdate the comment.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 qemu_main =3D NULL;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static QemuDisplay qemu_display_sdl2 =3D {<br>
<br>
</blockquote></div></div>

--0000000000002cf31f0627fe4d60--

