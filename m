Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC57CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 12:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4fl-000238-Im; Thu, 21 Aug 2025 08:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1up4fi-00022I-TC
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 08:45:38 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1up4ff-0000lb-JK
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 08:45:38 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e951246fcb6so398124276.0
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 05:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755780333; x=1756385133; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jz4FMD1aVj+U5oQMEJ3YkPAYB8piy4gVu2ZHqCBrVsU=;
 b=H5o9lGhG1ac6nGwSZ1pvSyEniMzg3yf/y+SWXKLRpmYtawqqOODB+0nAGpbPHrfV7O
 VRMQL1wUFdQUUda0TirXuzzOMOpiQD/LDNismzA1iUODCZZKmrq7gIblkSrwDF7/KnZa
 cSZPrZ15EptxIdd5UJwCEoWKvpes8pVtB7g3aWw79AWTnMlDuZqxzJ/+FdxAjZEodjt4
 6h8P8TY9Y0hUbRsdqqJNX/lhrK4lqWmHbf/783sn2Nh59DYROE2I2SK9OfSdTr41nHxy
 heTPCtx8WXbbp24DJuVk0CtnR3J3jLXqOnKVcq7Kl2qu3YujwoLVE+AVHkIrby1tNGiV
 leRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755780333; x=1756385133;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jz4FMD1aVj+U5oQMEJ3YkPAYB8piy4gVu2ZHqCBrVsU=;
 b=RtFCk+K02CH10dyyFOMBfwlI+4NVkElJ+i3Znn5w8JkPEuIVBhLjXj/3GfVneEf7zg
 Of9REI7u+j6wD3jPH8Sw2TZ7g0jXctD5f1Sq6hHp2iUYfsDophd/S3nL8eZOycJHKRka
 EENIaFt4qpTeOyIdhkfO5H6z4oX5IroDLHzRolOQ7PsC/Zk9lCFEOOz6n0+vM/6klnlp
 /rGppVHJQqZXGT4id5Z9n8kA7ZxkTTMn+upEOmpZcwAY96csYHo+4APmwSONGl7G9HJM
 bKC8RPj8YT61+OtPSRc/rv3UvcyWC3Th74sj5u85qt9WN2GUQDoHJFgQ+K6cxqzh+z8g
 eP+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxoY/zmltKKFR5joSqcRGhu93/wgkLGbC0GB6UJQDdeg48TeIA7e1eLZHBnQnt0JEwklamdUEV2rYT@nongnu.org
X-Gm-Message-State: AOJu0YwBuNlxG1dXECosyprO9Zlb1vc5iAmwQy0vc3qPS9ZbNSy+oxmq
 rFTLmp+y3qMeK+3VqrpAkJuYrrKr0VOApvK1EZTmwqA4w+JEnDCZmNlWCfn9fBdbH0InJL0AoXM
 aSMzUaqLQd3WTgrnSJb5rpI3cqWi3HEU8zwQH5sl9ow==
X-Gm-Gg: ASbGncv0yB4sptIez6skzp28u0e32nPV7BD3vkeSwKeJIGt56POHpoo8I2hnurjHdNU
 K1bl8gDFHU4NXfgq000JaOj3Yoj/EoLnd1dWQgfYSNXe41efMp28lyIiZu8zsAhOKoSDoKHMQdu
 3UcdLF1ZQlsrKBkIadnefuvljiJ6J+8BhSwv7EhCXnEFU5r6mt1csGlhtL+gJ9/2ksa1sC37fpT
 9VSISY6feFXdYPaewA=
X-Google-Smtp-Source: AGHT+IHEb22zcgSFniClYbZZ6fDWRs5/Ivjtc4JUGbYWK6+swrU7ATS1A5caVsokpyXeCaamwoy9OcPJLt4gMosBU2M=
X-Received: by 2002:a05:6902:1083:b0:e8f:e04f:ef9d with SMTP id
 3f1490d57ef6-e950bfc65bcmr1897429276.0.1755780332423; Thu, 21 Aug 2025
 05:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250110-san-v8-0-57a5a1be1bcf@daynix.com>
 <20250110-san-v8-2-57a5a1be1bcf@daynix.com>
 <CAFEAcA-aTYebu-5s4AeBfE3oLQfxTwCpeosoj0TU8E_XPu_ZDg@mail.gmail.com>
In-Reply-To: <CAFEAcA-aTYebu-5s4AeBfE3oLQfxTwCpeosoj0TU8E_XPu_ZDg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Aug 2025 13:45:20 +0100
X-Gm-Features: Ac12FXzKeSl64QUUKgV61RescMekwxcFuQUxVvbXnIiG7X2Mag5tnQzx8W-pStk
Message-ID: <CAFEAcA-ygHuA5BH+oftCGDKZOh8CHbiUKE4v=-iXvCaKzG4kHQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] memory: Do not create circular reference with
 subregion
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

(updated cc list with Akihiko's new email address)

On Thu, 21 Aug 2025 at 13:40, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 10 Jan 2025 at 09:20, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >
> > memory_region_update_container_subregions() used to call
> > memory_region_ref(), which creates a reference to the owner of the
> > subregion, on behalf of the owner of the container. This results in a
> > circular reference if the subregion and container have the same owner.
> >
> > memory_region_ref() creates a reference to the owner instead of the
> > memory region to match the lifetime of the owner and memory region. We
> > do not need such a hack if the subregion and container have the same
> > owner because the owner will be alive as long as the container is.
> > Therefore, create a reference to the subregion itself instead ot its
> > owner in such a case; the reference to the subregion is still necessary
> > to ensure that the subregion gets finalized after the container.
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
>
> Hi; I came back to this patchset because it was never applied,
> and so we still have various leaks of MemoryRegion objects
> in devices which use the "device owns a container MemoryRegion C
> and puts another MemoryRegion X which it owns into that container"
> pattern.
>
> Unfortunately, with this patch applied, I see a segfault when running
> the device-introspect-test for Arm:
>
> $ (cd build/x86 && QTEST_QEMU_BINARY=./qemu-system-arm
> ./tests/qtest/device-introspect-test -p
> /arm/device/introspect/concrete/defaults/none)
> [...]
> # Testing device 'imx7.analog'
> Broken pipe
> ../../tests/qtest/libqtest.c:208: kill_qemu() detected QEMU death from
> signal 11 (Segmentation fault) (core dumped)
>
> Here's a backtrace collected with gdb:
>
> $ (cd build/x86 && QTEST_QEMU_BINARY="xterm -e gdb --tty $(tty) --args
> ./qemu-system-arm" ./tests/qtest/device-introspect-test -p
> /arm/device/introspect/concrete/defaults/none)
> [hit 'r' in the gdb prompt in the new window]
>
> Thread 1 "qemu-system-arm" received signal SIGSEGV, Segmentation fault.
> memory_region_unref_subregion (subregion=0x555557d58370) at
> ../../system/memory.c:1862
> 1862        if (subregion->container->owner == subregion->owner) {
> (gdb) bt
> #0  memory_region_unref_subregion (subregion=0x555557d58370) at
> ../../system/memory.c:1862
> #1  0x0000555555d5f97b in memory_region_del_subregion
> (mr=0x555557d58150, subregion=0x555557d58370)
>     at ../../system/memory.c:2705
> #2  0x0000555555d5cc1c in memory_region_finalize (obj=0x555557d58150)
> at ../../system/memory.c:1811
> #3  0x0000555556197595 in object_deinit (obj=0x555557d58150,
> type=0x5555579d2ea0) at ../../qom/object.c:715
> #4  0x0000555556197613 in object_finalize (data=0x555557d58150) at
> ../../qom/object.c:729
> #5  0x00005555561988f9 in object_unref (objptr=0x555557d58150) at
> ../../qom/object.c:1232
> #6  0x000055555619a3d6 in object_finalize_child_property
>     (obj=0x555557d57e20, name=0x555557c59810 "imx7.analog[0]",
> opaque=0x555557d58150) at ../../qom/object.c:1818
> #7  0x0000555556197344 in object_property_del_all (obj=0x555557d57e20)
> at ../../qom/object.c:667
> #8  0x0000555556197600 in object_finalize (data=0x555557d57e20) at
> ../../qom/object.c:728
> #9  0x00005555561988f9 in object_unref (objptr=0x555557d57e20) at
> ../../qom/object.c:1232
> #10 0x00005555562f4600 in qmp_device_list_properties
> (typename=0x555557d3ee70 "imx7.analog", errp=0x7fffffffdc00)
>     at ../../qom/qom-qmp-cmds.c:237
> #11 0x00005555563981ba in qmp_marshal_device_list_properties
> (args=0x7fffe00031f0, ret=0x7fffef6afda8, errp=0x7fffef6afda0)
>     at qapi/qapi-commands-qdev.c:65
> #12 0x00005555563bcb53 in do_qmp_dispatch_bh (opaque=0x7fffef6afe40)
> at ../../qapi/qmp-dispatch.c:128
> #13 0x00005555563ed87f in aio_bh_call (bh=0x555557d3f540) at
> ../../util/async.c:172
> #14 0x00005555563ed9cb in aio_bh_poll (ctx=0x555557a00770) at
> ../../util/async.c:219
> #15 0x00005555563cd517 in aio_dispatch (ctx=0x555557a00770) at
> ../../util/aio-posix.c:436
> #16 0x00005555563edebe in aio_ctx_dispatch (source=0x555557a00770,
> callback=0x0, user_data=0x0) at ../../util/async.c:361
> #17 0x00007ffff6e965c5 in ??? () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #18 0x00007ffff6e96710 in g_main_context_dispatch () at
> /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #19 0x00005555563ef89e in glib_pollfds_poll () at ../../util/main-loop.c:287
> #20 0x00005555563ef930 in os_host_main_loop_wait (timeout=0) at
> ../../util/main-loop.c:310
> #21 0x00005555563efa6b in main_loop_wait (nonblocking=0) at
> ../../util/main-loop.c:589
> #22 0x0000555555d7d181 in qemu_main_loop () at ../../system/runstate.c:905
> #23 0x00005555562f94c7 in qemu_default_main (opaque=0x0) at
> ../../system/main.c:50
> #24 0x00005555562f9585 in main (argc=18, argv=0x7fffffffe078) at
> ../../system/main.c:93
>
>
> In memory_region_unref_subregion(), subregion->container is NULL.
>
> This is because in memory_region_del_subregion() we do:
>
>     subregion->container = NULL;
>
> and then after that we call
>     memory_region_unref_subregion(subregion);
> which dereferences subregion->container.
>
> Won't this always SEGV ?
>
> thanks
> -- PMM

