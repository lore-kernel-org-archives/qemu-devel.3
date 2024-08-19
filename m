Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7E6C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 16:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg5Bg-0008TP-9F; Mon, 19 Aug 2024 12:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sg5Be-0008N8-Ut
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 12:24:54 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sg5Bd-0000UH-3H
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 12:24:54 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5bed83489c3so2975260a12.3
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 09:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724084691; x=1724689491; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=g3yzJ/Uh+Ss9qeZ/rfifb0nfuY+22VYUgWrT+qgRPNk=;
 b=ErVnGi7UN3fGZ/Cn4zzh5clzOVHlsgbDhfAyquooVYDF/+dvjxVLhd127Gr2EFH6mQ
 ziJb4m5mtDoA0AX3W7+jPh1FEeaU82FFmUJDQF6XTBaPrjbd+cL0QqOt7PXUFPyvSmgW
 Ur+ZLurSEODpdRC5bejPA/0Ebd8ulVFvmTC7NPfaGzqNUfiqNkSPaBNtInKdISPtPomK
 2oRlBnto2zDU/X5f2c5o+2H0mzVqWMlW8mZHJ0u2IfJFC1dHtfeic2tM1aqLBXRtJExC
 /+EKQkquyjwRYOo94QtXL157LYxulk/yOg1xKcH9Le8QS+AEnNOOht5gTFbhiwHhsAq2
 niCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724084691; x=1724689491;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g3yzJ/Uh+Ss9qeZ/rfifb0nfuY+22VYUgWrT+qgRPNk=;
 b=rLy8WtFwt2z+Jw5BMZLJWgNaXLpKhO4rQEIqAZuHffE+u2xs2IbmDWvtfz/GrHnVIG
 CbSrRwmyIxG/6uz2vPm0vzRDfed9w8zPLPka9wBfjrOLxZpGQyw5BXPLljBDAogt929O
 8mSm6tWYLuPFEORytg7asNc+IE/vTg8yPSjm7zbyS8hpvZNUy4SH1OcFNK7mWg8PRHfm
 Zc334dSUIw1DuJYAs/MYAY3iEyca0IqJtgMa0ug5oFJ5Skdgo//STGXgJVBYyj0KbMJX
 q2aXokbmOc0oi4+Q6MzLgk0Tzo9QMzTHtKKGfdwBtVBxb/vTgJx2gAXC6uNET5JQk6tP
 M2xw==
X-Gm-Message-State: AOJu0YxhSijMJ3s2dhXeA7+ViOV049lItoXcfrTT7QvmP8Nn1L/P/5Dm
 wEiOBX+557ll3L9eMGVv0T0lKY64Uchp+PeRE0SUvOSBeyjYTfHjSY0Ra+TBc7/n8m4FRgtY2iM
 dcGV1qcB5kGOuD05QArRYMdXecAFhd0kR0uCpXpMRmWeSRGr+
X-Google-Smtp-Source: AGHT+IFnmThmQOsqobcheQ8DSdZ2IyQuJ13OWNYnLy/7D7bFA2AktGS750LkgnggXrRRsIv0s5JXQQnS92UDlkdXxaw=
X-Received: by 2002:a05:6402:354e:b0:5be:e01c:6b5e with SMTP id
 4fb4d7f45d1cf-5bee01c6dd9mr4695200a12.35.1724084691073; Mon, 19 Aug 2024
 09:24:51 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Aug 2024 17:24:39 +0100
Message-ID: <CAFEAcA-k7a+VObGAfCFNygQNfCKL=AfX6A4kScq=VSSK0peqPg@mail.gmail.com>
Subject: apparent memory leak from object-add+object-del of memory-backend-ram
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi; I'm looking at a memory leak apparently in the host memory backend
code that you can see from the qmp-cmd-test. Repro instructions:

(1) build QEMU with '--cc=clang' '--cxx=clang++' '--enable-debug'
'--target-list=x86_64-softmmu' '--enable-sanitizers'
(2) run 'make check'. More specifically, to get just this
failure ('make check' on current head-of-tree produces some
other unrelated leak errors) you can run the relevant single test:

(cd build/asan && ASAN_OPTIONS="fast_unwind_on_malloc=0"
QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/qmp-cmd-test
--tap -k -p /x86_64/qmp/object-add-failure-modes)

The test case is doing a variety of object-add then object-del
of the "memory-backend-ram" object, and this add-del cycle seems
to result in a fairly large leak:

Direct leak of 1572864 byte(s) in 6 object(s) allocated from:
    #0 0x555c1336efd8 in __interceptor_calloc
(/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-x86_64+0x218efd8)
(BuildId: fc7566a39db1253aed91d500b5b1784e0c438397)
    #1 0x7f5bf3472c50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
    #2 0x555c155bb134 in bitmap_new
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/qemu/bitmap.h:102:12
    #3 0x555c155ba4ee in dirty_memory_extend system/physmem.c:1831:37
    #4 0x555c15585a2b in ram_block_add system/physmem.c:1907:9
    #5 0x555c15589e50 in qemu_ram_alloc_internal system/physmem.c:2109:5
    #6 0x555c1558a096 in qemu_ram_alloc system/physmem.c:2129:12
    #7 0x555c15518b69 in memory_region_init_ram_flags_nomigrate
system/memory.c:1571:21
    #8 0x555c1464fd27 in ram_backend_memory_alloc backends/hostmem-ram.c:34:12
    #9 0x555c146510ac in host_memory_backend_memory_complete
backends/hostmem.c:345:10
    #10 0x555c1580bc90 in user_creatable_complete qom/object_interfaces.c:28:9
    #11 0x555c1580c6f8 in user_creatable_add_type qom/object_interfaces.c:125:10
    #12 0x555c1580ccc4 in user_creatable_add_qapi qom/object_interfaces.c:157:11
    #13 0x555c15ff0e2c in qmp_object_add qom/qom-qmp-cmds.c:227:5
    #14 0x555c161ce508 in qmp_marshal_object_add
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qapi/qapi-commands-qom.c:337:5
    #15 0x555c162a7139 in do_qmp_dispatch_bh qapi/qmp-dispatch.c:128:5
    #16 0x555c16387921 in aio_bh_call util/async.c:171:5
    #17 0x555c163887fc in aio_bh_poll util/async.c:218:13
    #18 0x555c162e1288 in aio_dispatch util/aio-posix.c:423:5
    #19 0x555c1638f7be in aio_ctx_dispatch util/async.c:360:5
    #20 0x7f5bf3469d3a in g_main_dispatch
debian/build/deb/../../../glib/gmain.c:3419:28
    #21 0x7f5bf3469d3a in g_main_context_dispatch
debian/build/deb/../../../glib/gmain.c:4137:7
    #22 0x555c163935c9 in glib_pollfds_poll util/main-loop.c:287:9
    #23 0x555c16391f03 in os_host_main_loop_wait util/main-loop.c:310:5
    #24 0x555c16391acc in main_loop_wait util/main-loop.c:589:11
    #25 0x555c14614917 in qemu_main_loop system/runstate.c:801:9
    #26 0x555c16008b8c in qemu_default_main system/main.c:37:14
    #27 0x555c16008bd7 in main system/main.c:48:12
    #28 0x7f5bf12fbd8f in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16

My initial suspicion here is that the problem is that
TYPE_MEMORY_BACKEND has a UserCreatableClass::complete method which
calls HostMemoryBackend::alloc, but there is no corresponding
"now free this" in instance_finalize. So ram_backend_memory_alloc()
calls memory_region_init_ram_flags_nomigrate(), which allocates
RAM, dirty blocks, etc, but nothing ever destroys the MR and the
memory is leaked when the TYPE_MEMORY_BACKEND object is finalized.

But there isn't a "free" method in HostMemoryBackendClass,
only an "alloc", so this looks like an API with "leaks memory"
baked into it. How is the freeing of the memory on object
deletion intended to work?

thanks
-- PMM

