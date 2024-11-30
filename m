Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93287D735F2
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2024 05:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHGNS-0000ly-9b; Sat, 30 Nov 2024 00:50:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tHGNQ-0000l3-96
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 00:50:44 -0500
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tHGNK-0002zB-Eq
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 00:50:44 -0500
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-296b567bc30so591067fac.2
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 21:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1732945836; x=1733550636;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JLd5CR7EaWHT8IFqBj/6ICdviHp9JIPCKLheUpMRpJ4=;
 b=XbF4omGWUxfhbwXMJEXkrOVARk9dQM41HEpANa2gqGKMqG0yG/PYLczPabnysR04Mg
 U3jmdxOOy0MYOgLzB/51NSHAscbaE8rU08LMoe0nDrZ7fGBwBoO0fcQlp++yfQOB8mIG
 ClyaTXEezveE70JgyGDZuYUl1vw5zsROGY2Wkxrok78O8a7iOmLmhidmz605rXCjtH6E
 7IDPcivfK7ROmxhQGAMFjkJ1gucvjHykM2vsnqecrkwr03R9P0YQR8PnH8a0yRCKy8wz
 DCozh27cq4Maw4m+V6FPPdRg9G/c0pNllX/2pF+wxDDpFCDbFAZ7QleAVRq7j8YXBHic
 jUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732945836; x=1733550636;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JLd5CR7EaWHT8IFqBj/6ICdviHp9JIPCKLheUpMRpJ4=;
 b=v8radqCwHIJOLlJFamGtXTNm62C9LZyyFmbFHL/SkMd835/VWADVVJsjsP1Yjr2mbr
 GNXDxgVsYaR6+TliA57doiUnJAi87mIqh6eNGbDhsELH8NVMMw1H/JyEKMwNqxS6ndP/
 CugVdu/S5zarSwPeb9AcxyMODfjGdMfnZAhoj+aP86GjeoPu5weHE8JEOeRKll01UIcK
 CZDrOPOcLlKVxsjKWlI0qxnysE7OEVM99qVnW/YZLRni2kpuXluSAcAaOEVDlBwxZFH/
 RSW61CyplGwPP8b8+KdvFG61o1Zp2sjhM5Qx5b/WObE2MQ+ciH64V7cX/Q17KOPHQyFZ
 0c9A==
X-Gm-Message-State: AOJu0YzDSIFp3R3RFxL4pfTwnGzo9BIzlscj4duUCIBkox6nqU8oVJz3
 WTMdcUtXXaLD3PbsOip282Y3xHKkzBomIOqVgTl7yBEMYcUrn+hAafUdLKi6psU=
X-Gm-Gg: ASbGncuo3mrysXVEgte80PZJF/v/5hVCo7TqaLQ63wrYTZ1QU0+1265+Uu0ed3Q5TZ6
 RiJHY1vFd5gaeI49Y7tOMGWr1InDMQJO8kmhXJNtOfhtFmnaP/+K9qwCDBl1w/BxevfVabdC5gn
 R7lCo8ipfpjI7H5w7YQDMJYwLTtU4oEh6RQhO/NkRdCAnAVM2UeA/w/qdUEjqk2pAORwsPNhFA5
 dZXOSShdbuO4NkcOew5HK8iloSaJweZJOHfasETpnuZITgzWXmt18w1sJYrh/k=
X-Google-Smtp-Source: AGHT+IEzw56gmroVhgPIqMpr6DsLu3VvX4LNQPLBW5zi5mpm9Fu5RM+3F/6UyZKuI9cynsSC1kBBiw==
X-Received: by 2002:a05:6870:aa0d:b0:277:cc6e:15de with SMTP id
 586e51a60fabf-29dc3fb925amr11259342fac.4.1732945836555; 
 Fri, 29 Nov 2024 21:50:36 -0800 (PST)
Received: from [157.82.207.167] ([157.82.207.167])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e20a1e6efsm842170fac.24.2024.11.29.21.50.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 21:50:35 -0800 (PST)
Message-ID: <307aee04-9019-4108-b99c-a187215ccf0b@daynix.com>
Date: Sat, 30 Nov 2024 14:50:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 01/15] ui & main loop: Redesign of system-specific
 main thread event handling
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, balaton@eik.bme.hu
References: <20241127150249.50767-1-phil@philjordan.eu>
 <20241127150249.50767-2-phil@philjordan.eu>
 <0533bb69-6f3a-4ebf-ae0c-99b569e61ba3@daynix.com>
 <CAAibmn26tZneZHytkYCgd4oT8Yx465i=3wu8cYXTwu3Ki8pAJw@mail.gmail.com>
 <6dc2b6a9-d7b4-43f8-95fd-4fc8699db68a@daynix.com>
 <CAAibmn3X7e5MAQWKEm7u8yAntL2HVBavRFKxFE5sizFpqFqeaQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAAibmn3X7e5MAQWKEm7u8yAntL2HVBavRFKxFE5sizFpqFqeaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x34.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2024/11/29 23:12, Phil Dennis-Jordan wrote:
> 
> 
> On Fri, 29 Nov 2024 at 11:07, Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> wrote:
> 
>     On 2024/11/29 4:43, Phil Dennis-Jordan wrote:
>      >
>      >
>      > On Thu, 28 Nov 2024 at 12:17, Akihiko Odaki
>     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
>      > <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>> wrote:
>      >
>      >     On 2024/11/28 0:02, Phil Dennis-Jordan wrote:
>      >      > macOS's Cocoa event handling must be done on the initial
>     (main)
>      >     thread
>      >      > of the process. Furthermore, if library or application
>     code uses
>      >      > libdispatch, the main dispatch queue must be handling
>     events on
>      >     the main
>      >      > thread as well.
>      >      >
>      >      > So far, this has affected Qemu in both the Cocoa and SDL UIs,
>      >     although
>      >      > in different ways: the Cocoa UI replaces the default qemu_main
>      >     function
>      >      > with one that spins Qemu's internal main event loop off onto a
>      >      > background thread. SDL (which uses Cocoa internally) on
>     the other
>      >     hand
>      >      > uses a polling approach within Qemu's main event loop.
>     Events are
>      >      > polled during the SDL UI's dpy_refresh callback, which
>     happens to run
>      >      > on the main thread by default.
>      >      >
>      >      > As UIs are mutually exclusive, this works OK as long as
>     nothing else
>      >      > needs platform-native event handling. In the next patch, a new
>      >     device is
>      >      > introduced based on the ParavirtualizedGraphics.framework
>     in macOS.
>      >      > This uses libdispatch internally, and only works when
>     events are
>      >     being
>      >      > handled on the main runloop. With the current system, it
>     works when
>      >      > using either the Cocoa or the SDL UI. However, it does not
>     when
>      >     running
>      >      > headless. Moreover, any attempt to install a similar
>     scheme to the
>      >      > Cocoa UI's main thread replacement fails when combined
>     with the SDL
>      >      > UI.
>      >      >
>      >      > This change tidies up main thread management to be more
>     flexible.
>      >      >
>      >      >   * The qemu_main global function pointer is a custom function
>      >     for the
>      >      >     main thread, and it may now be NULL. When it is, the
>     main thread
>      >      >     runs the main Qemu loop. This represents the
>     traditional setup.
>      >      >   * When non-null, spawning the main Qemu event loop on a
>     separate
>      >      >     thread is now done centrally rather than inside the
>     Cocoa UI
>      >     code.
>      >      >   * For most platforms, qemu_main is indeed NULL by
>     default, but on
>      >      >     Darwin, it defaults to a function that runs the CFRunLoop.
>      >      >   * The Cocoa UI sets qemu_main to a function which runs the
>      >      >     NSApplication event handling runloop, as is usual for
>     a Cocoa
>      >     app.
>      >      >   * The SDL UI overrides the qemu_main function to NULL, thus
>      >      >     specifying that Qemu's main loop must run on the main
>      >      >     thread.
>      >      >   * The GTK UI also overrides the qemu_main function to NULL.
>      >      >   * For other UIs, or in the absence of UIs, the
>     platform's default
>      >      >     behaviour is followed.
>      >      >
>      >      > This means that on macOS, the platform's runloop events
>     are always
>      >      > handled, regardless of chosen UI. The new PV graphics
>     device will
>      >      > thus work in all configurations. There is no functional
>     change on
>      >     other
>      >      > operating systems.
>      >      >
>      >      > Implementing this via a global function pointer variable
>     is a bit
>      >      > ugly, but it's probably worth investigating the existing UI
>      >     thread rule
>      >      > violations in the SDL (e.g. #2537) and GTK+ back-ends.
>     Fixing those
>      >      > issues might precipitate requirements similar but not
>     identical
>      >     to those
>      >      > of the Cocoa UI; hopefully we'll see some kind of pattern
>     emerge,
>      >     which
>      >      > can then be used as a basis for an overhaul. (In fact, it
>     may turn
>      >      > out to be simplest to split the UI/native platform event
>     thread
>      >     from the
>      >      > QEMU main event loop on all platforms, with any UI or even
>     none
>      >     at all.)
>      >      >
>      >      > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu
>     <mailto:phil@philjordan.eu>
>      >     <mailto:phil@philjordan.eu <mailto:phil@philjordan.eu>>>
>      >      > ---
>      >      >
>      >      > v5:
>      >      >
>      >      >   * Simplified the way of setting/clearing the main loop
>     by going
>      >     back
>      >      >     to setting qemu_main directly, but narrowing the scope
>     of what it
>      >      >     needs to do, and it can now be NULL.
>      >      >
>      >      > v6:
>      >      >
>      >      >   * Folded function qemu_run_default_main_on_new_thread's
>     code into
>      >      >     main()
>      >      >   * Removed whitespace changes left over on lines near
>     code removed
>      >      >     between v4 and v5
>      >      >
>      >      > v9:
>      >      >
>      >      >   * Set qemu_main to NULL for GTK UI as well.
>      >      >
>      >      > v10:
>      >      >
>      >      >   * Added comments clarifying the functionality and purpose of
>      >     qemu_main.
>      >      >
>      >      > v11:
>      >      >
>      >      >   * Removed the qemu_main_fn typedef again.
>      >      >   * Consolidation of main, qemu_default_main, and
>      >     call_qemu_default_main
>      >      >     so that the latter has been eliminated altogether.
>      >      >   * Reinstated the #include <SDL.h> directive, added
>     comment saying
>      >      >     why it's needed.
>      >      >   * Improved the comment on the qemu_main global variable.
>      >      >   * Expanded the commit message.
>      >      >
>      >      >   include/qemu-main.h | 14 +++++++++++-
>      >      >   system/main.c       | 37 +++++++++++++++++++++++++++----
>      >      >   ui/cocoa.m          | 54 ++++++++++
>      >     +----------------------------------
>      >      >   ui/gtk.c            |  8 +++++++
>      >      >   ui/sdl2.c           |  4 ++++
>      >      >   5 files changed, 71 insertions(+), 46 deletions(-)
>      >      >
>      >      > diff --git a/include/qemu-main.h b/include/qemu-main.h
>      >      > index 940960a7dbc..a926def7526 100644
>      >      > --- a/include/qemu-main.h
>      >      > +++ b/include/qemu-main.h
>      >      > @@ -5,7 +5,19 @@
>      >      >   #ifndef QEMU_MAIN_H
>      >      >   #define QEMU_MAIN_H
>      >      >
>      >      > -int qemu_default_main(void);
>      >      > +/*
>      >      > + * The function to run on the main (initial) thread of
>     the process.
>      >      > + * NULL means QEMU's main event loop.
>      >      > + * When non-NULL, QEMU's main event loop will run on a
>     purposely
>      >     created
>      >      > + * thread, after which the provided function pointer will be
>      >     invoked on
>      >      > + * the initial thread.
>      >      > + * This is useful on platforms which treat the main thread as
>      >     special
>      >      > + * (macOS/Darwin) and/or require all UI API calls to
>     occur from a
>      >      > + * specific thread. Those platforms can initialise it to a
>      >     specific function,
>      >
>      >     Although the change from v10 looks good, I have a few comments:
>      >
>      >     Here, it says "require all UI API calls to occur from a specific
>      >     thread", but it is clearer to say "require all UI API calls
>     to occur
>      >     from *the main thread*". If we only need to ensure all UI API
>     calls to
>      >     occur from one thread, arranging all calls to happen in the
>     thread
>      >     running QEMU's main loop is sufficient. This variable is
>     necessary only
>      >     when the thread is the one that called main().
>      >
>      >
>      > Is there a simple way to reliably run a block of code on the thread
>      > running QEMU's main loop? (*) BHs will run on any thread that's
>     blocked
>      > in AIO_WAIT_WHILE(NULL, …) or similar, so those are not suitable.
>      > Apparently GTK+ on Win32 requires all API calls to originate from
>     one
>      > thread, but it doesn't need to be the main thread, which is why I
>     chose
>      > that phrasing. But I suppose if that's the only restriction, the
>     UI can
>      > spawn its own thread and leave the main thread alone.
> 
>     Setting qemu_main does not help in such a case because BHs may still
>     run
>     on other threads so it needs another approach.
> 
>     I think iohandler_get_aio_context() does what we want, but it is not
>     intended to be used to identify the thread to run the UI so using it is
>     like a hack. Spawning a thread dedicated for UI is more appropriate.
> 
> 
> Ultimately, it may make sense to put the whole display and UI subsystem 
> on its own dedicated AioContext and thread (main thread on macOS)… But 
> that might require some tweaks to the AioContext system - I really don't 
> know it (or the SDL and GTK code base) well enough to say with any 
> certainty what the best approach would be right now.

SDL has its own event mechanism so having AioContext makes duplication 
of work. We can use SDL_PushEvent() for that platform to avoid that. The 
situation of GTK is no different except it will involve 
g_main_context_invoke() instead of SDL_PushEvent().

> 
>      > (*) This would be good to know for fixing this bug https://
>     gitlab.com/ <https://gitlab.com/>
>      > qemu-project/qemu/-/issues/2537 <https://gitlab.com/qemu-project/
>     qemu/-/ <https://gitlab.com/qemu-project/qemu/-/>
>      > issues/2537> where the SDL UI code causes a hang by calling into
>      > SDL_SetWindowSize() from a CPU thread. My current thinking on
>     that one
>      > is to use SDL_PushEvent() with a custom event type generated by
>      > SDL_RegisterEvents(), which then will be handled via the standard
>     SDL
>      > event polling mechanism; but that seems awkward.
>     I think it's totally fine. If SDL (backed by Cocoa) insists to own the
>     main thread, let it do so.
> 
>      >
>      >      > + * while UI implementations may reset it to NULL during their
>      >     init if they
>      >      > + * will handle system and UI events on the main thread via
>      >     QEMU's own main
>      >      > + * event loop.> + */
>      >      >   extern int (*qemu_main)(void);
>      >      >
>      >      >   #endif /* QEMU_MAIN_H */
>      >      > diff --git a/system/main.c b/system/main.c
>      >      > index 9b91d21ea8c..668d0ecfe8c 100644
>      >      > --- a/system/main.c
>      >      > +++ b/system/main.c
>      >      > @@ -24,26 +24,55 @@
>      >      >
>      >      >   #include "qemu/osdep.h"
>      >      >   #include "qemu-main.h"
>      >      > +#include "qemu/main-loop.h"
>      >      >   #include "sysemu/sysemu.h"
>      >      >
>      >      >   #ifdef CONFIG_SDL
>      >      > +/*
>      >      > + * SDL insists on wrapping the main() function with its own
>      >     implementation on
>      >      > + * some platforms; it does so via a macro that renames
>     our main
>      >     function, so
>      >      > + * <SDL.h> must be #included here even with no SDL code
>     called
>      >     from this file.
>      >      > + */
>      >      >   #include <SDL.h>
>      >      >   #endif
>      >      >
>      >      > -int qemu_default_main(void)
>      >      > +#ifdef CONFIG_DARWIN
>      >      > +#include <CoreFoundation/CoreFoundation.h>
>      >      > +#endif
>      >      > +
>      >      > +static void *qemu_default_main(void *opaque)
>      >      >   {
>      >      >       int status;
>      >      >
>      >      > +    bql_lock();
>      >      >       status = qemu_main_loop();
>      >      >       qemu_cleanup(status);
>      >      > +    bql_unlock();
>      >      >
>      >      > -    return status;
>      >      > +    exit(status);
>      >      >   }
>      >      >
>      >      > -int (*qemu_main)(void) = qemu_default_main;
>      >      > +int (*qemu_main)(void);
>      >      > +
>      >      > +#ifdef CONFIG_DARWIN
>      >      > +static int os_darwin_cfrunloop_main(void)
>      >      > +{
>      >      > +    CFRunLoopRun();
>      >      > +    g_assert_not_reached();
>      >      > +}
>      >      > +int (*qemu_main)(void) = os_darwin_cfrunloop_main;
>      >      > +#endif
>      >      >
>      >      >   int main(int argc, char **argv)
>      >      >   {
>      >      >       qemu_init(argc, argv);
>      >      > -    return qemu_main();
>      >      > +    bql_unlock();
>      >      > +    if (qemu_main) {
>      >      > +        QemuThread main_loop_thread;
>      >      > +        qemu_thread_create(&main_loop_thread, "qemu_main",
>      >      > +                           qemu_default_main, NULL,
>      >     QEMU_THREAD_DETACHED);
>      >      > +        return qemu_main();
>      >      > +    } else {
>      >      > +        qemu_default_main(NULL);
>      >      > +    }
>      >      >   }
>      >      > diff --git a/ui/cocoa.m b/ui/cocoa.m
>      >      > index 4c2dd335323..30b8920d929 100644
>      >      > --- a/ui/cocoa.m
>      >      > +++ b/ui/cocoa.m
>      >      > @@ -73,6 +73,8 @@
>      >      >       int height;
>      >      >   } QEMUScreen;
>      >      >
>      >      > +@class QemuCocoaPasteboardTypeOwner;
>      >      > +
>      >      >   static void cocoa_update(DisplayChangeListener *dcl,
>      >      >                            int x, int y, int w, int h);
>      >      >
>      >      > @@ -107,6 +109,7 @@ static void
>      >     cocoa_switch(DisplayChangeListener *dcl,
>      >      >   static NSInteger cbchangecount = -1;
>      >      >   static QemuClipboardInfo *cbinfo;
>      >      >   static QemuEvent cbevent;
>      >      > +static QemuCocoaPasteboardTypeOwner *cbowner;
>      >      >
>      >      >   // Utility functions to run specified code block with
>     the BQL held
>      >      >   typedef void (^CodeBlock)(void);
>      >      > @@ -1321,8 +1324,10 @@ - (void) dealloc
>      >      >   {
>      >      >       COCOA_DEBUG("QemuCocoaAppController: dealloc\n");
>      >      >
>      >      > -    if (cocoaView)
>      >      > -        [cocoaView release];
>      >      > +    [cocoaView release];
>      >      > +    [cbowner release];
>      >      > +    cbowner = nil;
>      >      > +
>      >      >       [super dealloc];
>      >      >   }
>      >      >
>      >      > @@ -1938,8 +1943,6 @@ - (void)pasteboard:(NSPasteboard
>     *)sender
>      >     provideDataForType:(NSPasteboardType)t
>      >      >
>      >      >   @end
>      >      >
>      >      > -static QemuCocoaPasteboardTypeOwner *cbowner;
>      >      > -
>      >      >   static void cocoa_clipboard_notify(Notifier *notifier,
>     void *data);
>      >      >   static void cocoa_clipboard_request(QemuClipboardInfo *info,
>      >      >                                       QemuClipboardType type);
>      >      > @@ -2002,43 +2005,8 @@ static void
>      >     cocoa_clipboard_request(QemuClipboardInfo *info,
>      >      >       }
>      >      >   }
>      >      >
>      >      > -/*
>      >      > - * The startup process for the OSX/Cocoa UI is
>     complicated, because
>      >      > - * OSX insists that the UI runs on the initial main
>     thread, and
>      >     so we
>      >      > - * need to start a second thread which runs the
>     qemu_default_main():
>      >      > - * in main():
>      >      > - *  in cocoa_display_init():
>      >      > - *   assign cocoa_main to qemu_main
>      >      > - *   create application, menus, etc
>      >      > - *  in cocoa_main():
>      >      > - *   create qemu-main thread
>      >      > - *   enter OSX run loop
>      >      > - */
>      >      > -
>      >      > -static void *call_qemu_main(void *opaque)
>      >      > -{
>      >      > -    int status;
>      >      > -
>      >      > -    COCOA_DEBUG("Second thread: calling
>     qemu_default_main()\n");
>      >      > -    bql_lock();
>      >      > -    status = qemu_default_main();
>      >      > -    bql_unlock();
>      >      > -    COCOA_DEBUG("Second thread: qemu_default_main() returned,
>      >     exiting\n");
>      >      > -    [cbowner release];
>      >      > -    exit(status);
>      >      > -}
>      >      > -
>      >      >   static int cocoa_main(void)
>      >      >   {
>      >      > -    QemuThread thread;
>      >      > -
>      >      > -    COCOA_DEBUG("Entered %s()\n", __func__);
>      >      > -
>      >      > -    bql_unlock();
>      >      > -    qemu_thread_create(&thread, "qemu_main", call_qemu_main,
>      >      > -                       NULL, QEMU_THREAD_DETACHED);
>      >      > -
>      >      > -    // Start the main event loop
>      >      >       COCOA_DEBUG("Main thread: entering OSX run loop\n");
>      >      >       [NSApp run];
>      >      >       COCOA_DEBUG("Main thread: left OSX run loop, which
>     should
>      >     never happen\n");
>      >      > @@ -2120,8 +2088,6 @@ static void
>     cocoa_display_init(DisplayState
>      >     *ds, DisplayOptions *opts)
>      >      >
>      >      >       COCOA_DEBUG("qemu_cocoa: cocoa_display_init\n");
>      >      >
>      >      > -    qemu_main = cocoa_main;
>      >      > -
>      >      >       // Pull this console process up to being a fully-fledged
>      >     graphical
>      >      >       // app with a menubar and Dock icon
>      >      >       ProcessSerialNumber psn = { 0, kCurrentProcess };
>      >      > @@ -2185,6 +2151,12 @@ static void
>      >     cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
>      >      >       qemu_clipboard_peer_register(&cbpeer);
>      >      >
>      >      >       [pool release];
>      >      > +
>      >      > +    /*
>      >      > +     * The Cocoa UI will run the NSApplication runloop on the
>      >     main thread
>      >      > +     * rather than the default Core Foundation one.
>      >      > +     */
>      >      > +    qemu_main = cocoa_main;
>      >      >   }
>      >      >
>      >      >   static QemuDisplay qemu_display_cocoa = {
>      >      > diff --git a/ui/gtk.c b/ui/gtk.c
>      >      > index bf9d3dd679a..5e6ee5c12a2 100644
>      >      > --- a/ui/gtk.c
>      >      > +++ b/ui/gtk.c
>      >      > @@ -38,6 +38,7 @@
>      >      >   #include "qemu/cutils.h"
>      >      >   #include "qemu/error-report.h"
>      >      >   #include "qemu/main-loop.h"
>      >      > +#include "qemu-main.h"
>      >      >
>      >      >   #include "ui/console.h"
>      >      >   #include "ui/gtk.h"
>      >      > @@ -2485,6 +2486,13 @@ static void
>     gtk_display_init(DisplayState
>      >     *ds, DisplayOptions *opts)
>      >      >   #ifdef CONFIG_GTK_CLIPBOARD
>      >      >       gd_clipboard_init(s);
>      >      >   #endif /* CONFIG_GTK_CLIPBOARD */
>      >      > +
>      >      > +    /*
>      >      > +     * GTK+ calls must happen on the main thread at least on
>      >     some platforms,
>      >      > +     * and on macOS the main runloop is polled via GTK+'s
>     event
>      >     handling.
>      >      > +     * Don't allow QEMU's event loop to be moved off the main
>      >     thread.
>      >      > +     */
>      >      > +    qemu_main = NULL;
>      >      >   }
>      >      >
>      >      >   static void early_gtk_display_init(DisplayOptions *opts)
>      >      > diff --git a/ui/sdl2.c b/ui/sdl2.c
>      >      > index bd4f5a9da14..44ab2762262 100644
>      >      > --- a/ui/sdl2.c
>      >      > +++ b/ui/sdl2.c
>      >      > @@ -34,6 +34,7 @@
>      >      >   #include "sysemu/sysemu.h"
>      >      >   #include "ui/win32-kbd-hook.h"
>      >      >   #include "qemu/log.h"
>      >      > +#include "qemu-main.h"
>      >      >
>      >      >   static int sdl2_num_outputs;
>      >      >   static struct sdl2_console *sdl2_console;
>      >      > @@ -965,6 +966,9 @@ static void sdl2_display_init(DisplayState
>      >     *ds, DisplayOptions *o)
>      >      >       }
>      >      >
>      >      >       atexit(sdl_cleanup);
>      >      > +
>      >      > +    /* SDL's event polling (in dpy_refresh) must happen
>     on the
>      >     main thread. */
>      >
>      >     ui/gtk.c and ui/sdl2.c have the same background so the
>     comments should
>      >     also be identical except names.
>      >
>      >
>      > Well, GTK doesn't currently do this, which is why it doesn't work on
>      > macOS, but hopefully this patch will be merged in some form, at
>     which
>      > point it will:
>      >
>      > https://patchew.org/QEMU/20241121162146.53643-1-
>     charmitro@posteo.net/ <https://patchew.org/
>     QEMU/20241121162146.53643-1-charmitro@posteo.net/>
>      > <https://patchew.org/QEMU/20241121162146.53643-1-
>     charmitro@posteo.net/ <https://patchew.org/
>     QEMU/20241121162146.53643-1-charmitro@posteo.net/>>
>      >
>      > But yeah, thanks to this patch we know that's a solution for GTK as
>      > well, and I can update the comment.
> 
>     I only meant that SDL is not different from GTK in terms that its call
>     and event handling needs to be done in the main thread.
> 
>     I was not paying attention to the mention of dpy_refresh(). It is
>     another topic whether dpy_refresh() is the best place for event
>     handling, and I don't think so. dpy_refresh() is triggered when
>     refreshing the display output, but event handling is not specific to
>     the
>     display output so it is awkward to handle events there.
> 
>     The best approach is to do the same with ui/cocoa; override
>     qemu_main to
>     dedicate the main thread for the UI and decouple the UI from the BQL by
>     calling GTK with g_main_context_invoke(), which corresponds to
>     SDL_RegisterEvents() in SDL.
> 
> 
> It seems like a cleaner approach it theory, but QEMU's modified 
> reimplementation of the GLib event loop could complicate matters, so I'm 
> not sure it would be a quick or easy change to make. It's probably worth 
> accepting the conceptually uglier fix via dpy_refresh() or an explicit 
> timer for the moment, in preference to GTK not working at all on macOS. 
> That is especially considering the SDL UI currently successfully does 
> the exact same thing on all platforms at the moment. In any case, all of 
> these considerations are beyond the scope of this immediate patch. I 
> think the patch as is (with the proposed tweaks to the wording of 
> comments) is a step in the right direction by pulling the main thread 
> replacement logic out of the Cocoa UI code and making it generally 
> available. The qemu_main = NULL; assignments can easily be amended in 
> future.

I think we can rule out the possible complication due to the event loop 
reimplementation if a thread is dedicated for GTK.

SDL's success is somewhat imperfect due to the lack of guarantee that 
its code runs in the main thread, but certainly the imperfect is better 
than the complete breakage.

> 
>      >
>      >      > +    qemu_main = NULL;
>      >      >   }
>      >      >
>      >      >   static QemuDisplay qemu_display_sdl2 = {
>      >
> 


