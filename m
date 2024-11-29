Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D53CD6EC0E
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 14:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH1js-0007FB-SJ; Fri, 29 Nov 2024 09:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tH1jp-0007Ei-Qf
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 09:12:54 -0500
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tH1jl-0003ev-Dy
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 09:12:53 -0500
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-85b0a934a17so1328347241.1
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 06:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1732889568; x=1733494368;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mi/YAS4UiPQwOfIo3PWeRihHHR7ryOwdx2JE1kyIXgg=;
 b=lUSXgc7cKQ+SyuxELJLGxGztCk0zXe7eH3SJKUTQVniW29CsARTSbHB+0BeE4PYm9a
 diMepeloVIwNz8lEyfP1Ex5RVuiRdilZipo8lzblVh02PYThyioHiMWF7PK15r+tDkNh
 Rq0htwo/0bYGXL9pDI2eqcZ0lmtaqlvlFPQ+dLXYq3dkxBJojTxX8ZRmRqNPw2cfPKfh
 Mtw0ri3C4jHTEEnqVRp1zFwQO+ni52YRmhfEGKoKPDq3kfGqzS+2yG7hIHi8sG5IND/I
 tBooWc0KD5axlxermNW+UeM+9wQT9sCG1epETbLWvauzXiFRzIUCFSrKcMVwjSCxKes0
 RMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732889568; x=1733494368;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mi/YAS4UiPQwOfIo3PWeRihHHR7ryOwdx2JE1kyIXgg=;
 b=DcAd2vzV+mxDMJWN5TT7NNV+wq18qHRJN+sq0QEiKTJ9dKFWipm6LdYx7351IVtaw+
 U21hsEfGqr3tawiwCv69YLKS4x/2q6dLnEs8/UedNCHaCTAxkjYniMKS+sW31nfsiVA3
 LLeA93+dwbjXjbHAv1q0q0NHj28h5oBkoEvAwx6B+3KjLaQiuiHjuRxyEnYTtvb+MXjl
 CGrllHgRMXgttH4XjCJeDD0OGFhB1iLR2eWbcvPiYnQ4gjDXaL/gaNFuDu1inUksjZuk
 Nag+xSVKbiMCBh9oajEtXks0HLx0yJNG2B0RN+hnL9mL/sxEuCZqVBUZl2s+oOoawGyk
 1kDQ==
X-Gm-Message-State: AOJu0YwC/IaoE74GlOD/CO5M1vVDc7SAN8ax3V3gOIGSA/1m4kUHJ4ek
 bAokVwnGQeLa5UvNRVSdrQp2FYNyRuJ6iHVqhR+BA8SXvJy8Y1rtNXxHMM+98u99XgqPlKHjO+m
 Ox7cdUtxsDpEhMjfKgcKA1V9kf6khgxTTpQpl
X-Gm-Gg: ASbGnctWzoKcGnVZtsQwDqNMZPZRSufC6H4DsayrERGU4lzXVYc+PfajVK5eu8MN0yQ
 NxZacF6BwG+98TAPoychW9UmRdxBvygI=
X-Google-Smtp-Source: AGHT+IFRQHSfZrmbfmtSEn0J4C26h0V1MDk5fr+QA3apcWvPVmt7EUsPfPrmE0jKjmdHODytWAte6UXZT8ohMRFOLt4=
X-Received: by 2002:a05:6122:1d44:b0:510:6b24:c2ca with SMTP id
 71dfb90a1353d-5156a84d345mr7999045e0c.3.1732889567921; Fri, 29 Nov 2024
 06:12:47 -0800 (PST)
MIME-Version: 1.0
References: <20241127150249.50767-1-phil@philjordan.eu>
 <20241127150249.50767-2-phil@philjordan.eu>
 <0533bb69-6f3a-4ebf-ae0c-99b569e61ba3@daynix.com>
 <CAAibmn26tZneZHytkYCgd4oT8Yx465i=3wu8cYXTwu3Ki8pAJw@mail.gmail.com>
 <6dc2b6a9-d7b4-43f8-95fd-4fc8699db68a@daynix.com>
In-Reply-To: <6dc2b6a9-d7b4-43f8-95fd-4fc8699db68a@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Fri, 29 Nov 2024 15:12:37 +0100
Message-ID: <CAAibmn3X7e5MAQWKEm7u8yAntL2HVBavRFKxFE5sizFpqFqeaQ@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="00000000000021a31906280dcb32"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::936;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x936.google.com
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

--00000000000021a31906280dcb32
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 29 Nov 2024 at 11:07, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> On 2024/11/29 4:43, Phil Dennis-Jordan wrote:
> >
> >
> > On Thu, 28 Nov 2024 at 12:17, Akihiko Odaki <akihiko.odaki@daynix.com
> > <mailto:akihiko.odaki@daynix.com>> wrote:
> >
> >     On 2024/11/28 0:02, Phil Dennis-Jordan wrote:
> >      > macOS's Cocoa event handling must be done on the initial (main)
> >     thread
> >      > of the process. Furthermore, if library or application code uses
> >      > libdispatch, the main dispatch queue must be handling events on
> >     the main
> >      > thread as well.
> >      >
> >      > So far, this has affected Qemu in both the Cocoa and SDL UIs,
> >     although
> >      > in different ways: the Cocoa UI replaces the default qemu_main
> >     function
> >      > with one that spins Qemu's internal main event loop off onto a
> >      > background thread. SDL (which uses Cocoa internally) on the othe=
r
> >     hand
> >      > uses a polling approach within Qemu's main event loop. Events ar=
e
> >      > polled during the SDL UI's dpy_refresh callback, which happens t=
o
> run
> >      > on the main thread by default.
> >      >
> >      > As UIs are mutually exclusive, this works OK as long as nothing
> else
> >      > needs platform-native event handling. In the next patch, a new
> >     device is
> >      > introduced based on the ParavirtualizedGraphics.framework in
> macOS.
> >      > This uses libdispatch internally, and only works when events are
> >     being
> >      > handled on the main runloop. With the current system, it works
> when
> >      > using either the Cocoa or the SDL UI. However, it does not when
> >     running
> >      > headless. Moreover, any attempt to install a similar scheme to t=
he
> >      > Cocoa UI's main thread replacement fails when combined with the
> SDL
> >      > UI.
> >      >
> >      > This change tidies up main thread management to be more flexible=
.
> >      >
> >      >   * The qemu_main global function pointer is a custom function
> >     for the
> >      >     main thread, and it may now be NULL. When it is, the main
> thread
> >      >     runs the main Qemu loop. This represents the traditional
> setup.
> >      >   * When non-null, spawning the main Qemu event loop on a separa=
te
> >      >     thread is now done centrally rather than inside the Cocoa UI
> >     code.
> >      >   * For most platforms, qemu_main is indeed NULL by default, but
> on
> >      >     Darwin, it defaults to a function that runs the CFRunLoop.
> >      >   * The Cocoa UI sets qemu_main to a function which runs the
> >      >     NSApplication event handling runloop, as is usual for a Coco=
a
> >     app.
> >      >   * The SDL UI overrides the qemu_main function to NULL, thus
> >      >     specifying that Qemu's main loop must run on the main
> >      >     thread.
> >      >   * The GTK UI also overrides the qemu_main function to NULL.
> >      >   * For other UIs, or in the absence of UIs, the platform's
> default
> >      >     behaviour is followed.
> >      >
> >      > This means that on macOS, the platform's runloop events are alwa=
ys
> >      > handled, regardless of chosen UI. The new PV graphics device wil=
l
> >      > thus work in all configurations. There is no functional change o=
n
> >     other
> >      > operating systems.
> >      >
> >      > Implementing this via a global function pointer variable is a bi=
t
> >      > ugly, but it's probably worth investigating the existing UI
> >     thread rule
> >      > violations in the SDL (e.g. #2537) and GTK+ back-ends. Fixing
> those
> >      > issues might precipitate requirements similar but not identical
> >     to those
> >      > of the Cocoa UI; hopefully we'll see some kind of pattern emerge=
,
> >     which
> >      > can then be used as a basis for an overhaul. (In fact, it may tu=
rn
> >      > out to be simplest to split the UI/native platform event thread
> >     from the
> >      > QEMU main event loop on all platforms, with any UI or even none
> >     at all.)
> >      >
> >      > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu
> >     <mailto:phil@philjordan.eu>>
> >      > ---
> >      >
> >      > v5:
> >      >
> >      >   * Simplified the way of setting/clearing the main loop by goin=
g
> >     back
> >      >     to setting qemu_main directly, but narrowing the scope of
> what it
> >      >     needs to do, and it can now be NULL.
> >      >
> >      > v6:
> >      >
> >      >   * Folded function qemu_run_default_main_on_new_thread's code
> into
> >      >     main()
> >      >   * Removed whitespace changes left over on lines near code
> removed
> >      >     between v4 and v5
> >      >
> >      > v9:
> >      >
> >      >   * Set qemu_main to NULL for GTK UI as well.
> >      >
> >      > v10:
> >      >
> >      >   * Added comments clarifying the functionality and purpose of
> >     qemu_main.
> >      >
> >      > v11:
> >      >
> >      >   * Removed the qemu_main_fn typedef again.
> >      >   * Consolidation of main, qemu_default_main, and
> >     call_qemu_default_main
> >      >     so that the latter has been eliminated altogether.
> >      >   * Reinstated the #include <SDL.h> directive, added comment
> saying
> >      >     why it's needed.
> >      >   * Improved the comment on the qemu_main global variable.
> >      >   * Expanded the commit message.
> >      >
> >      >   include/qemu-main.h | 14 +++++++++++-
> >      >   system/main.c       | 37 +++++++++++++++++++++++++++----
> >      >   ui/cocoa.m          | 54 ++++++++++
> >     +----------------------------------
> >      >   ui/gtk.c            |  8 +++++++
> >      >   ui/sdl2.c           |  4 ++++
> >      >   5 files changed, 71 insertions(+), 46 deletions(-)
> >      >
> >      > diff --git a/include/qemu-main.h b/include/qemu-main.h
> >      > index 940960a7dbc..a926def7526 100644
> >      > --- a/include/qemu-main.h
> >      > +++ b/include/qemu-main.h
> >      > @@ -5,7 +5,19 @@
> >      >   #ifndef QEMU_MAIN_H
> >      >   #define QEMU_MAIN_H
> >      >
> >      > -int qemu_default_main(void);
> >      > +/*
> >      > + * The function to run on the main (initial) thread of the
> process.
> >      > + * NULL means QEMU's main event loop.
> >      > + * When non-NULL, QEMU's main event loop will run on a purposel=
y
> >     created
> >      > + * thread, after which the provided function pointer will be
> >     invoked on
> >      > + * the initial thread.
> >      > + * This is useful on platforms which treat the main thread as
> >     special
> >      > + * (macOS/Darwin) and/or require all UI API calls to occur from=
 a
> >      > + * specific thread. Those platforms can initialise it to a
> >     specific function,
> >
> >     Although the change from v10 looks good, I have a few comments:
> >
> >     Here, it says "require all UI API calls to occur from a specific
> >     thread", but it is clearer to say "require all UI API calls to occu=
r
> >     from *the main thread*". If we only need to ensure all UI API calls
> to
> >     occur from one thread, arranging all calls to happen in the thread
> >     running QEMU's main loop is sufficient. This variable is necessary
> only
> >     when the thread is the one that called main().
> >
> >
> > Is there a simple way to reliably run a block of code on the thread
> > running QEMU's main loop? (*) BHs will run on any thread that's blocked
> > in AIO_WAIT_WHILE(NULL, =E2=80=A6) or similar, so those are not suitabl=
e.
> > Apparently GTK+ on Win32 requires all API calls to originate from one
> > thread, but it doesn't need to be the main thread, which is why I chose
> > that phrasing. But I suppose if that's the only restriction, the UI can
> > spawn its own thread and leave the main thread alone.
>
> Setting qemu_main does not help in such a case because BHs may still run
> on other threads so it needs another approach.
>
> I think iohandler_get_aio_context() does what we want, but it is not
> intended to be used to identify the thread to run the UI so using it is
> like a hack. Spawning a thread dedicated for UI is more appropriate.
>

Ultimately, it may make sense to put the whole display and UI subsystem on
its own dedicated AioContext and thread (main thread on macOS)=E2=80=A6 But=
 that
might require some tweaks to the AioContext system - I really don't know it
(or the SDL and GTK code base) well enough to say with any certainty what
the best approach would be right now.

> (*) This would be good to know for fixing this bug https://gitlab.com/
> > qemu-project/qemu/-/issues/2537 <https://gitlab.com/qemu-project/qemu/-=
/
> > issues/2537> where the SDL UI code causes a hang by calling into
> > SDL_SetWindowSize() from a CPU thread. My current thinking on that one
> > is to use SDL_PushEvent() with a custom event type generated by
> > SDL_RegisterEvents(), which then will be handled via the standard SDL
> > event polling mechanism; but that seems awkward.
> I think it's totally fine. If SDL (backed by Cocoa) insists to own the
> main thread, let it do so.
>
> >
> >      > + * while UI implementations may reset it to NULL during their
> >     init if they
> >      > + * will handle system and UI events on the main thread via
> >     QEMU's own main
> >      > + * event loop.> + */
> >      >   extern int (*qemu_main)(void);
> >      >
> >      >   #endif /* QEMU_MAIN_H */
> >      > diff --git a/system/main.c b/system/main.c
> >      > index 9b91d21ea8c..668d0ecfe8c 100644
> >      > --- a/system/main.c
> >      > +++ b/system/main.c
> >      > @@ -24,26 +24,55 @@
> >      >
> >      >   #include "qemu/osdep.h"
> >      >   #include "qemu-main.h"
> >      > +#include "qemu/main-loop.h"
> >      >   #include "sysemu/sysemu.h"
> >      >
> >      >   #ifdef CONFIG_SDL
> >      > +/*
> >      > + * SDL insists on wrapping the main() function with its own
> >     implementation on
> >      > + * some platforms; it does so via a macro that renames our main
> >     function, so
> >      > + * <SDL.h> must be #included here even with no SDL code called
> >     from this file.
> >      > + */
> >      >   #include <SDL.h>
> >      >   #endif
> >      >
> >      > -int qemu_default_main(void)
> >      > +#ifdef CONFIG_DARWIN
> >      > +#include <CoreFoundation/CoreFoundation.h>
> >      > +#endif
> >      > +
> >      > +static void *qemu_default_main(void *opaque)
> >      >   {
> >      >       int status;
> >      >
> >      > +    bql_lock();
> >      >       status =3D qemu_main_loop();
> >      >       qemu_cleanup(status);
> >      > +    bql_unlock();
> >      >
> >      > -    return status;
> >      > +    exit(status);
> >      >   }
> >      >
> >      > -int (*qemu_main)(void) =3D qemu_default_main;
> >      > +int (*qemu_main)(void);
> >      > +
> >      > +#ifdef CONFIG_DARWIN
> >      > +static int os_darwin_cfrunloop_main(void)
> >      > +{
> >      > +    CFRunLoopRun();
> >      > +    g_assert_not_reached();
> >      > +}
> >      > +int (*qemu_main)(void) =3D os_darwin_cfrunloop_main;
> >      > +#endif
> >      >
> >      >   int main(int argc, char **argv)
> >      >   {
> >      >       qemu_init(argc, argv);
> >      > -    return qemu_main();
> >      > +    bql_unlock();
> >      > +    if (qemu_main) {
> >      > +        QemuThread main_loop_thread;
> >      > +        qemu_thread_create(&main_loop_thread, "qemu_main",
> >      > +                           qemu_default_main, NULL,
> >     QEMU_THREAD_DETACHED);
> >      > +        return qemu_main();
> >      > +    } else {
> >      > +        qemu_default_main(NULL);
> >      > +    }
> >      >   }
> >      > diff --git a/ui/cocoa.m b/ui/cocoa.m
> >      > index 4c2dd335323..30b8920d929 100644
> >      > --- a/ui/cocoa.m
> >      > +++ b/ui/cocoa.m
> >      > @@ -73,6 +73,8 @@
> >      >       int height;
> >      >   } QEMUScreen;
> >      >
> >      > +@class QemuCocoaPasteboardTypeOwner;
> >      > +
> >      >   static void cocoa_update(DisplayChangeListener *dcl,
> >      >                            int x, int y, int w, int h);
> >      >
> >      > @@ -107,6 +109,7 @@ static void
> >     cocoa_switch(DisplayChangeListener *dcl,
> >      >   static NSInteger cbchangecount =3D -1;
> >      >   static QemuClipboardInfo *cbinfo;
> >      >   static QemuEvent cbevent;
> >      > +static QemuCocoaPasteboardTypeOwner *cbowner;
> >      >
> >      >   // Utility functions to run specified code block with the BQL
> held
> >      >   typedef void (^CodeBlock)(void);
> >      > @@ -1321,8 +1324,10 @@ - (void) dealloc
> >      >   {
> >      >       COCOA_DEBUG("QemuCocoaAppController: dealloc\n");
> >      >
> >      > -    if (cocoaView)
> >      > -        [cocoaView release];
> >      > +    [cocoaView release];
> >      > +    [cbowner release];
> >      > +    cbowner =3D nil;
> >      > +
> >      >       [super dealloc];
> >      >   }
> >      >
> >      > @@ -1938,8 +1943,6 @@ - (void)pasteboard:(NSPasteboard *)sender
> >     provideDataForType:(NSPasteboardType)t
> >      >
> >      >   @end
> >      >
> >      > -static QemuCocoaPasteboardTypeOwner *cbowner;
> >      > -
> >      >   static void cocoa_clipboard_notify(Notifier *notifier, void
> *data);
> >      >   static void cocoa_clipboard_request(QemuClipboardInfo *info,
> >      >                                       QemuClipboardType type);
> >      > @@ -2002,43 +2005,8 @@ static void
> >     cocoa_clipboard_request(QemuClipboardInfo *info,
> >      >       }
> >      >   }
> >      >
> >      > -/*
> >      > - * The startup process for the OSX/Cocoa UI is complicated,
> because
> >      > - * OSX insists that the UI runs on the initial main thread, and
> >     so we
> >      > - * need to start a second thread which runs the
> qemu_default_main():
> >      > - * in main():
> >      > - *  in cocoa_display_init():
> >      > - *   assign cocoa_main to qemu_main
> >      > - *   create application, menus, etc
> >      > - *  in cocoa_main():
> >      > - *   create qemu-main thread
> >      > - *   enter OSX run loop
> >      > - */
> >      > -
> >      > -static void *call_qemu_main(void *opaque)
> >      > -{
> >      > -    int status;
> >      > -
> >      > -    COCOA_DEBUG("Second thread: calling qemu_default_main()\n")=
;
> >      > -    bql_lock();
> >      > -    status =3D qemu_default_main();
> >      > -    bql_unlock();
> >      > -    COCOA_DEBUG("Second thread: qemu_default_main() returned,
> >     exiting\n");
> >      > -    [cbowner release];
> >      > -    exit(status);
> >      > -}
> >      > -
> >      >   static int cocoa_main(void)
> >      >   {
> >      > -    QemuThread thread;
> >      > -
> >      > -    COCOA_DEBUG("Entered %s()\n", __func__);
> >      > -
> >      > -    bql_unlock();
> >      > -    qemu_thread_create(&thread, "qemu_main", call_qemu_main,
> >      > -                       NULL, QEMU_THREAD_DETACHED);
> >      > -
> >      > -    // Start the main event loop
> >      >       COCOA_DEBUG("Main thread: entering OSX run loop\n");
> >      >       [NSApp run];
> >      >       COCOA_DEBUG("Main thread: left OSX run loop, which should
> >     never happen\n");
> >      > @@ -2120,8 +2088,6 @@ static void cocoa_display_init(DisplayStat=
e
> >     *ds, DisplayOptions *opts)
> >      >
> >      >       COCOA_DEBUG("qemu_cocoa: cocoa_display_init\n");
> >      >
> >      > -    qemu_main =3D cocoa_main;
> >      > -
> >      >       // Pull this console process up to being a fully-fledged
> >     graphical
> >      >       // app with a menubar and Dock icon
> >      >       ProcessSerialNumber psn =3D { 0, kCurrentProcess };
> >      > @@ -2185,6 +2151,12 @@ static void
> >     cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
> >      >       qemu_clipboard_peer_register(&cbpeer);
> >      >
> >      >       [pool release];
> >      > +
> >      > +    /*
> >      > +     * The Cocoa UI will run the NSApplication runloop on the
> >     main thread
> >      > +     * rather than the default Core Foundation one.
> >      > +     */
> >      > +    qemu_main =3D cocoa_main;
> >      >   }
> >      >
> >      >   static QemuDisplay qemu_display_cocoa =3D {
> >      > diff --git a/ui/gtk.c b/ui/gtk.c
> >      > index bf9d3dd679a..5e6ee5c12a2 100644
> >      > --- a/ui/gtk.c
> >      > +++ b/ui/gtk.c
> >      > @@ -38,6 +38,7 @@
> >      >   #include "qemu/cutils.h"
> >      >   #include "qemu/error-report.h"
> >      >   #include "qemu/main-loop.h"
> >      > +#include "qemu-main.h"
> >      >
> >      >   #include "ui/console.h"
> >      >   #include "ui/gtk.h"
> >      > @@ -2485,6 +2486,13 @@ static void gtk_display_init(DisplayState
> >     *ds, DisplayOptions *opts)
> >      >   #ifdef CONFIG_GTK_CLIPBOARD
> >      >       gd_clipboard_init(s);
> >      >   #endif /* CONFIG_GTK_CLIPBOARD */
> >      > +
> >      > +    /*
> >      > +     * GTK+ calls must happen on the main thread at least on
> >     some platforms,
> >      > +     * and on macOS the main runloop is polled via GTK+'s event
> >     handling.
> >      > +     * Don't allow QEMU's event loop to be moved off the main
> >     thread.
> >      > +     */
> >      > +    qemu_main =3D NULL;
> >      >   }
> >      >
> >      >   static void early_gtk_display_init(DisplayOptions *opts)
> >      > diff --git a/ui/sdl2.c b/ui/sdl2.c
> >      > index bd4f5a9da14..44ab2762262 100644
> >      > --- a/ui/sdl2.c
> >      > +++ b/ui/sdl2.c
> >      > @@ -34,6 +34,7 @@
> >      >   #include "sysemu/sysemu.h"
> >      >   #include "ui/win32-kbd-hook.h"
> >      >   #include "qemu/log.h"
> >      > +#include "qemu-main.h"
> >      >
> >      >   static int sdl2_num_outputs;
> >      >   static struct sdl2_console *sdl2_console;
> >      > @@ -965,6 +966,9 @@ static void sdl2_display_init(DisplayState
> >     *ds, DisplayOptions *o)
> >      >       }
> >      >
> >      >       atexit(sdl_cleanup);
> >      > +
> >      > +    /* SDL's event polling (in dpy_refresh) must happen on the
> >     main thread. */
> >
> >     ui/gtk.c and ui/sdl2.c have the same background so the comments
> should
> >     also be identical except names.
> >
> >
> > Well, GTK doesn't currently do this, which is why it doesn't work on
> > macOS, but hopefully this patch will be merged in some form, at which
> > point it will:
> >
> > https://patchew.org/QEMU/20241121162146.53643-1-charmitro@posteo.net/
> > <https://patchew.org/QEMU/20241121162146.53643-1-charmitro@posteo.net/>
> >
> > But yeah, thanks to this patch we know that's a solution for GTK as
> > well, and I can update the comment.
>
> I only meant that SDL is not different from GTK in terms that its call
> and event handling needs to be done in the main thread.
>
> I was not paying attention to the mention of dpy_refresh(). It is
> another topic whether dpy_refresh() is the best place for event
> handling, and I don't think so. dpy_refresh() is triggered when
> refreshing the display output, but event handling is not specific to the
> display output so it is awkward to handle events there.
>
> The best approach is to do the same with ui/cocoa; override qemu_main to
> dedicate the main thread for the UI and decouple the UI from the BQL by
> calling GTK with g_main_context_invoke(), which corresponds to
> SDL_RegisterEvents() in SDL.
>

It seems like a cleaner approach it theory, but QEMU's modified
reimplementation of the GLib event loop could complicate matters, so I'm
not sure it would be a quick or easy change to make. It's probably worth
accepting the conceptually uglier fix via dpy_refresh() or an explicit
timer for the moment, in preference to GTK not working at all on macOS.
That is especially considering the SDL UI currently successfully does the
exact same thing on all platforms at the moment. In any case, all of these
considerations are beyond the scope of this immediate patch. I think the
patch as is (with the proposed tweaks to the wording of comments) is a step
in the right direction by pulling the main thread replacement logic out of
the Cocoa UI code and making it generally available. The qemu_main =3D NULL=
;
assignments can easily be amended in future.


> >
> >      > +    qemu_main =3D NULL;
> >      >   }
> >      >
> >      >   static QemuDisplay qemu_display_sdl2 =3D {
> >
>
>

--00000000000021a31906280dcb32
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, 29 Nov 2024 at 11:07, Akihiko=
 Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On 2024/11/29 4:43, Phil Dennis-Jordan wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Thu, 28 Nov 2024 at 12:17, Akihiko Odaki &lt;<a href=3D"mailto:akih=
iko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blan=
k">akihiko.odaki@daynix.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 2024/11/28 0:02, Phil Dennis-Jordan wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; macOS&#39;s Cocoa event handling must be done=
 on the initial (main)<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; of the process. Furthermore, if library or ap=
plication code uses<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libdispatch, the main dispatch queue must be =
handling events on<br>
&gt;=C2=A0 =C2=A0 =C2=A0the main<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thread as well.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; So far, this has affected Qemu in both the Co=
coa and SDL UIs,<br>
&gt;=C2=A0 =C2=A0 =C2=A0although<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; in different ways: the Cocoa UI replaces the =
default qemu_main<br>
&gt;=C2=A0 =C2=A0 =C2=A0function<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; with one that spins Qemu&#39;s internal main =
event loop off onto a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; background thread. SDL (which uses Cocoa inte=
rnally) on the other<br>
&gt;=C2=A0 =C2=A0 =C2=A0hand<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; uses a polling approach within Qemu&#39;s mai=
n event loop. Events are<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; polled during the SDL UI&#39;s dpy_refresh ca=
llback, which happens to run<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; on the main thread by default.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; As UIs are mutually exclusive, this works OK =
as long as nothing else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; needs platform-native event handling. In the =
next patch, a new<br>
&gt;=C2=A0 =C2=A0 =C2=A0device is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; introduced based on the ParavirtualizedGraphi=
cs.framework in macOS.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; This uses libdispatch internally, and only wo=
rks when events are<br>
&gt;=C2=A0 =C2=A0 =C2=A0being<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; handled on the main runloop. With the current=
 system, it works when<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; using either the Cocoa or the SDL UI. However=
, it does not when<br>
&gt;=C2=A0 =C2=A0 =C2=A0running<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; headless. Moreover, any attempt to install a =
similar scheme to the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Cocoa UI&#39;s main thread replacement fails =
when combined with the SDL<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; UI.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; This change tidies up main thread management =
to be more flexible.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* The qemu_main global function p=
ointer is a custom function<br>
&gt;=C2=A0 =C2=A0 =C2=A0for the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0main thread, and it may no=
w be NULL. When it is, the main thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0runs the main Qemu loop. T=
his represents the traditional setup.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* When non-null, spawning the mai=
n Qemu event loop on a separate<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0thread is now done central=
ly rather than inside the Cocoa UI<br>
&gt;=C2=A0 =C2=A0 =C2=A0code.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* For most platforms, qemu_main i=
s indeed NULL by default, but on<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Darwin, it defaults to a f=
unction that runs the CFRunLoop.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* The Cocoa UI sets qemu_main to =
a function which runs the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0NSApplication event handli=
ng runloop, as is usual for a Cocoa<br>
&gt;=C2=A0 =C2=A0 =C2=A0app.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* The SDL UI overrides the qemu_m=
ain function to NULL, thus<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0specifying that Qemu&#39;s=
 main loop must run on the main<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0thread.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* The GTK UI also overrides the q=
emu_main function to NULL.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* For other UIs, or in the absenc=
e of UIs, the platform&#39;s default<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0behaviour is followed.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; This means that on macOS, the platform&#39;s =
runloop events are always<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; handled, regardless of chosen UI. The new PV =
graphics device will<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thus work in all configurations. There is no =
functional change on<br>
&gt;=C2=A0 =C2=A0 =C2=A0other<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; operating systems.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Implementing this via a global function point=
er variable is a bit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ugly, but it&#39;s probably worth investigati=
ng the existing UI<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread rule<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; violations in the SDL (e.g. #2537) and GTK+ b=
ack-ends. Fixing those<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; issues might precipitate requirements similar=
 but not identical<br>
&gt;=C2=A0 =C2=A0 =C2=A0to those<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; of the Cocoa UI; hopefully we&#39;ll see some=
 kind of pattern emerge,<br>
&gt;=C2=A0 =C2=A0 =C2=A0which<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; can then be used as a basis for an overhaul. =
(In fact, it may turn<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; out to be simplest to split the UI/native pla=
tform event thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0from the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; QEMU main event loop on all platforms, with a=
ny UI or even none<br>
&gt;=C2=A0 =C2=A0 =C2=A0at all.)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=
=3D"mailto:phil@philjordan.eu" target=3D"_blank">phil@philjordan.eu</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:phil@philjordan.eu" ta=
rget=3D"_blank">phil@philjordan.eu</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; v5:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Simplified the way of setting/c=
learing the main loop by going<br>
&gt;=C2=A0 =C2=A0 =C2=A0back<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0to setting qemu_main direc=
tly, but narrowing the scope of what it<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0needs to do, and it can no=
w be NULL.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; v6:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Folded function qemu_run_defaul=
t_main_on_new_thread&#39;s code into<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0main()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Removed whitespace changes left=
 over on lines near code removed<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0between v4 and v5<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; v9:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Set qemu_main to NULL for GTK U=
I as well.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; v10:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Added comments clarifying the f=
unctionality and purpose of<br>
&gt;=C2=A0 =C2=A0 =C2=A0qemu_main.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; v11:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Removed the qemu_main_fn typede=
f again.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Consolidation of main, qemu_def=
ault_main, and<br>
&gt;=C2=A0 =C2=A0 =C2=A0call_qemu_default_main<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0so that the latter has bee=
n eliminated altogether.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Reinstated the #include &lt;SDL=
.h&gt; directive, added comment saying<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0why it&#39;s needed.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Improved the comment on the qem=
u_main global variable.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Expanded the commit message.<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0include/qemu-main.h | 14 ++++++++=
+++-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0system/main.c=C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 37 +++++++++++++++++++++++++++----<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0ui/cocoa.m=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 54 ++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0+----------------------------------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0ui/gtk.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 8 +++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0ui/sdl2.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 4 ++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A05 files changed, 71 insertions(+)=
, 46 deletions(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/include/qemu-main.h b/include/qe=
mu-main.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 940960a7dbc..a926def7526 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/include/qemu-main.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/include/qemu-main.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -5,7 +5,19 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#ifndef QEMU_MAIN_H<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#define QEMU_MAIN_H<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -int qemu_default_main(void);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * The function to run on the main (initial)=
 thread of the process.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * NULL means QEMU&#39;s main event loop.<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * When non-NULL, QEMU&#39;s main event loop=
 will run on a purposely<br>
&gt;=C2=A0 =C2=A0 =C2=A0created<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * thread, after which the provided function=
 pointer will be<br>
&gt;=C2=A0 =C2=A0 =C2=A0invoked on<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * the initial thread.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * This is useful on platforms which treat t=
he main thread as<br>
&gt;=C2=A0 =C2=A0 =C2=A0special<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * (macOS/Darwin) and/or require all UI API =
calls to occur from a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * specific thread. Those platforms can init=
ialise it to a<br>
&gt;=C2=A0 =C2=A0 =C2=A0specific function,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Although the change from v10 looks good, I have a f=
ew comments:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Here, it says &quot;require all UI API calls to occ=
ur from a specific<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread&quot;, but it is clearer to say &quot;requir=
e all UI API calls to occur<br>
&gt;=C2=A0 =C2=A0 =C2=A0from *the main thread*&quot;. If we only need to en=
sure all UI API calls to<br>
&gt;=C2=A0 =C2=A0 =C2=A0occur from one thread, arranging all calls to happe=
n in the thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0running QEMU&#39;s main loop is sufficient. This va=
riable is necessary only<br>
&gt;=C2=A0 =C2=A0 =C2=A0when the thread is the one that called main().<br>
&gt; <br>
&gt; <br>
&gt; Is there a simple way to reliably run a block of code on the thread <b=
r>
&gt; running QEMU&#39;s main loop? (*) BHs will run on any thread that&#39;=
s blocked <br>
&gt; in AIO_WAIT_WHILE(NULL, =E2=80=A6) or similar, so those are not suitab=
le. <br>
&gt; Apparently GTK+ on Win32 requires all API calls to originate from one =
<br>
&gt; thread, but it doesn&#39;t need to be the main thread, which is why I =
chose <br>
&gt; that phrasing. But I suppose if that&#39;s the only restriction, the U=
I can <br>
&gt; spawn its own thread and leave the main thread alone.<br>
<br>
Setting qemu_main does not help in such a case because BHs may still run <b=
r>
on other threads so it needs another approach.<br>
<br>
I think iohandler_get_aio_context() does what we want, but it is not <br>
intended to be used to identify the thread to run the UI so using it is <br=
>
like a hack. Spawning a thread dedicated for UI is more appropriate.<br></b=
lockquote><div><br></div><div>Ultimately, it may make sense to put the whol=
e display and UI subsystem on its own dedicated AioContext and  thread (mai=
n thread on macOS)=E2=80=A6 But that might require some tweaks to the AioCo=
ntext system - I really don&#39;t know it (or the SDL and GTK code base) we=
ll enough to say with any certainty what the best approach would be right n=
ow.<br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
&gt; (*) This would be good to know for fixing this bug <a href=3D"https://=
gitlab.com/" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/</a> <=
br>
&gt; qemu-project/qemu/-/issues/2537 &lt;<a href=3D"https://gitlab.com/qemu=
-project/qemu/-/" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/q=
emu-project/qemu/-/</a> <br>
&gt; issues/2537&gt; where the SDL UI code=C2=A0causes a hang by calling in=
to <br>
&gt; SDL_SetWindowSize() from a CPU thread. My current thinking on that one=
 <br>
&gt; is to use SDL_PushEvent() with a custom event type generated by <br>
&gt; SDL_RegisterEvents(), which then will be handled via the standard SDL =
<br>
&gt; event polling mechanism; but that seems awkward.<br>
I think it&#39;s totally fine. If SDL (backed by Cocoa) insists to own the =
<br>
main thread, let it do so.<br>
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * while UI implementations may reset it to =
NULL during their<br>
&gt;=C2=A0 =C2=A0 =C2=A0init if they<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * will handle system and UI events on the m=
ain thread via<br>
&gt;=C2=A0 =C2=A0 =C2=A0QEMU&#39;s own main<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * event loop.&gt; + */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0extern int (*qemu_main)(void);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#endif /* QEMU_MAIN_H */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/system/main.c b/system/main.c<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 9b91d21ea8c..668d0ecfe8c 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/system/main.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/system/main.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -24,26 +24,55 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#include &quot;qemu/osdep.h&quot;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#include &quot;qemu-main.h&quot;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/main-loop.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#include &quot;sysemu/sysemu.h&qu=
ot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#ifdef CONFIG_SDL<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * SDL insists on wrapping the main() functi=
on with its own<br>
&gt;=C2=A0 =C2=A0 =C2=A0implementation on<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * some platforms; it does so via a macro th=
at renames our main<br>
&gt;=C2=A0 =C2=A0 =C2=A0function, so<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * &lt;SDL.h&gt; must be #included here even=
 with no SDL code called<br>
&gt;=C2=A0 =C2=A0 =C2=A0from this file.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#include &lt;SDL.h&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -int qemu_default_main(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#ifdef CONFIG_DARWIN<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &lt;CoreFoundation/CoreFoundation.h=
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void *qemu_default_main(void *opaque)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int status;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 bql_lock();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D qemu_mai=
n_loop();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_cleanup(status=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 bql_unlock();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 return status;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 exit(status);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -int (*qemu_main)(void) =3D qemu_default_main=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +int (*qemu_main)(void);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#ifdef CONFIG_DARWIN<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static int os_darwin_cfrunloop_main(void)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 CFRunLoopRun();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 g_assert_not_reached();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +int (*qemu_main)(void) =3D os_darwin_cfrunlo=
op_main;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0int main(int argc, char **argv)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_init(argc, arg=
v);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 return qemu_main();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 bql_unlock();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (qemu_main) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 QemuThread main_=
loop_thread;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_thread_crea=
te(&amp;main_loop_thread, &quot;qemu_main&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_default_main, N=
ULL,<br>
&gt;=C2=A0 =C2=A0 =C2=A0QEMU_THREAD_DETACHED);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return qemu_main=
();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_default_mai=
n(NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/ui/cocoa.m b/ui/cocoa.m<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 4c2dd335323..30b8920d929 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/ui/cocoa.m<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/ui/cocoa.m<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -73,6 +73,8 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int height;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0} QEMUScreen;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +@class QemuCocoaPasteboardTypeOwner;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0static void cocoa_update(DisplayC=
hangeListener *dcl,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int x, int y, int w, i=
nt h);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -107,6 +109,7 @@ static void<br>
&gt;=C2=A0 =C2=A0 =C2=A0cocoa_switch(DisplayChangeListener *dcl,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0static NSInteger cbchangecount =
=3D -1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0static QemuClipboardInfo *cbinfo;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0static QemuEvent cbevent;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static QemuCocoaPasteboardTypeOwner *cbowner=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0// Utility functions to run speci=
fied code block with the BQL held<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0typedef void (^CodeBlock)(void);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -1321,8 +1324,10 @@ - (void) dealloc<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0COCOA_DEBUG(&quot;Q=
emuCocoaAppController: dealloc\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 if (cocoaView)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 [cocoaView relea=
se];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [cocoaView release];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [cbowner release];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 cbowner =3D nil;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[super dealloc];<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -1938,8 +1943,6 @@ - (void)pasteboard:(NSP=
asteboard *)sender<br>
&gt;=C2=A0 =C2=A0 =C2=A0provideDataForType:(NSPasteboardType)t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0@end<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -static QemuCocoaPasteboardTypeOwner *cbowner=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0static void cocoa_clipboard_notif=
y(Notifier *notifier, void *data);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0static void cocoa_clipboard_reque=
st(QemuClipboardInfo *info,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0QemuClipboardType type);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -2002,43 +2005,8 @@ static void<br>
&gt;=C2=A0 =C2=A0 =C2=A0cocoa_clipboard_request(QemuClipboardInfo *info,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - * The startup process for the OSX/Cocoa UI =
is complicated, because<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - * OSX insists that the UI runs on the initi=
al main thread, and<br>
&gt;=C2=A0 =C2=A0 =C2=A0so we<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - * need to start a second thread which runs =
the qemu_default_main():<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - * in main():<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - *=C2=A0 in cocoa_display_init():<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - *=C2=A0 =C2=A0assign cocoa_main to qemu_mai=
n<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - *=C2=A0 =C2=A0create application, menus, et=
c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - *=C2=A0 in cocoa_main():<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - *=C2=A0 =C2=A0create qemu-main thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - *=C2=A0 =C2=A0enter OSX run loop<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -static void *call_qemu_main(void *opaque)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 int status;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 COCOA_DEBUG(&quot;Second threa=
d: calling qemu_default_main()\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 bql_lock();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 status =3D qemu_default_main()=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 bql_unlock();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 COCOA_DEBUG(&quot;Second threa=
d: qemu_default_main() returned,<br>
&gt;=C2=A0 =C2=A0 =C2=A0exiting\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 [cbowner release];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 exit(status);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0static int cocoa_main(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 QemuThread thread;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 COCOA_DEBUG(&quot;Entered %s()=
\n&quot;, __func__);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 bql_unlock();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 qemu_thread_create(&amp;thread=
, &quot;qemu_main&quot;, call_qemu_main,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, QEMU_THREAD_DETACHED);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 // Start the main event loop<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0COCOA_DEBUG(&quot;M=
ain thread: entering OSX run loop\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[NSApp run];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0COCOA_DEBUG(&quot;M=
ain thread: left OSX run loop, which should<br>
&gt;=C2=A0 =C2=A0 =C2=A0never happen\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -2120,8 +2088,6 @@ static void cocoa_displ=
ay_init(DisplayState<br>
&gt;=C2=A0 =C2=A0 =C2=A0*ds, DisplayOptions *opts)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0COCOA_DEBUG(&quot;q=
emu_cocoa: cocoa_display_init\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 qemu_main =3D cocoa_main;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0// Pull this consol=
e process up to being a fully-fledged<br>
&gt;=C2=A0 =C2=A0 =C2=A0graphical<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0// app with a menub=
ar and Dock icon<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ProcessSerialNumber=
 psn =3D { 0, kCurrentProcess };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -2185,6 +2151,12 @@ static void<br>
&gt;=C2=A0 =C2=A0 =C2=A0cocoa_display_init(DisplayState *ds, DisplayOptions=
 *opts)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_clipboard_peer=
_register(&amp;cbpeer);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[pool release];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* The Cocoa UI will run =
the NSApplication runloop on the<br>
&gt;=C2=A0 =C2=A0 =C2=A0main thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* rather than the defaul=
t Core Foundation one.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qemu_main =3D cocoa_main;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0static QemuDisplay qemu_display_c=
ocoa =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/ui/gtk.c b/ui/gtk.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index bf9d3dd679a..5e6ee5c12a2 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/ui/gtk.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/ui/gtk.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -38,6 +38,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#include &quot;qemu/cutils.h&quot=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#include &quot;qemu/error-report.=
h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#include &quot;qemu/main-loop.h&q=
uot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu-main.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#include &quot;ui/console.h&quot;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#include &quot;ui/gtk.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -2485,6 +2486,13 @@ static void gtk_displa=
y_init(DisplayState<br>
&gt;=C2=A0 =C2=A0 =C2=A0*ds, DisplayOptions *opts)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#ifdef CONFIG_GTK_CLIPBOARD<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0gd_clipboard_init(s=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#endif /* CONFIG_GTK_CLIPBOARD */=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* GTK+ calls must happen=
 on the main thread at least on<br>
&gt;=C2=A0 =C2=A0 =C2=A0some platforms,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* and on macOS the main =
runloop is polled via GTK+&#39;s event<br>
&gt;=C2=A0 =C2=A0 =C2=A0handling.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* Don&#39;t allow QEMU&#=
39;s event loop to be moved off the main<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qemu_main =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0static void early_gtk_display_ini=
t(DisplayOptions *opts)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/ui/sdl2.c b/ui/sdl2.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index bd4f5a9da14..44ab2762262 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/ui/sdl2.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/ui/sdl2.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -34,6 +34,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#include &quot;sysemu/sysemu.h&qu=
ot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#include &quot;ui/win32-kbd-hook.=
h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#include &quot;qemu/log.h&quot;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu-main.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0static int sdl2_num_outputs;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0static struct sdl2_console *sdl2_=
console;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -965,6 +966,9 @@ static void sdl2_display_=
init(DisplayState<br>
&gt;=C2=A0 =C2=A0 =C2=A0*ds, DisplayOptions *o)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0atexit(sdl_cleanup)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* SDL&#39;s event polling (in=
 dpy_refresh) must happen on the<br>
&gt;=C2=A0 =C2=A0 =C2=A0main thread. */<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0ui/gtk.c and ui/sdl2.c have the same background so =
the comments should<br>
&gt;=C2=A0 =C2=A0 =C2=A0also be identical except names.<br>
&gt; <br>
&gt; <br>
&gt; Well, GTK doesn&#39;t currently do this, which is why it doesn&#39;t w=
ork on <br>
&gt; macOS, but hopefully this patch will be merged in some form, at which =
<br>
&gt; point it will:<br>
&gt; <br>
&gt; <a href=3D"https://patchew.org/QEMU/20241121162146.53643-1-charmitro@p=
osteo.net/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/QEMU/2=
0241121162146.53643-1-charmitro@posteo.net/</a> <br>
&gt; &lt;<a href=3D"https://patchew.org/QEMU/20241121162146.53643-1-charmit=
ro@posteo.net/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/QE=
MU/20241121162146.53643-1-charmitro@posteo.net/</a>&gt;<br>
&gt; <br>
&gt; But yeah, thanks to this patch we know that&#39;s a solution for GTK a=
s <br>
&gt; well, and I can update the comment.<br>
<br>
I only meant that SDL is not different from GTK in terms that its call <br>
and event handling needs to be done in the main thread.<br>
<br>
I was not paying attention to the mention of dpy_refresh(). It is <br>
another topic whether dpy_refresh() is the best place for event <br>
handling, and I don&#39;t think so. dpy_refresh() is triggered when <br>
refreshing the display output, but event handling is not specific to the <b=
r>
display output so it is awkward to handle events there.<br>
<br>
The best approach is to do the same with ui/cocoa; override qemu_main to <b=
r>
dedicate the main thread for the UI and decouple the UI from the BQL by <br=
>
calling GTK with g_main_context_invoke(), which corresponds to <br>
SDL_RegisterEvents() in SDL.<br></blockquote><div><br></div><div>It seems l=
ike a cleaner approach it theory, but QEMU&#39;s modified reimplementation =
of the GLib event loop could complicate matters, so I&#39;m not sure it wou=
ld be a quick or easy change to make. It&#39;s probably worth accepting the=
 conceptually uglier fix via dpy_refresh() or an explicit timer for the mom=
ent, in preference to GTK not working at all on macOS. That is especially c=
onsidering the SDL UI currently successfully does the exact same thing on a=
ll platforms at the moment. In any case, all of these considerations are be=
yond the scope of this immediate patch. I think the patch as is (with the p=
roposed tweaks to the wording of comments) is a step in the right direction=
 by pulling the main thread replacement logic out of the Cocoa UI code and =
making it generally available. The qemu_main =3D NULL; assignments can easi=
ly be amended in future.<br></div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qemu_main =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0static QemuDisplay qemu_display_s=
dl2 =3D {<br>
&gt; <br>
<br>
</blockquote></div></div>

--00000000000021a31906280dcb32--

