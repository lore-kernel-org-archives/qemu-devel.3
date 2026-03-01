Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B61FD006A
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 15:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwiMm-0004wm-Dz; Sun, 01 Mar 2026 10:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vwiMj-0004um-Hz
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 10:05:53 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vwiMe-0000N6-Py
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 10:05:51 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B4F2B597308;
 Sun, 01 Mar 2026 16:05:44 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id MTsejwJ2BfDx; Sun,  1 Mar 2026 16:05:42 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 880015969F0; Sun, 01 Mar 2026 16:05:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 82A625969E4;
 Sun, 01 Mar 2026 16:05:42 +0100 (CET)
Date: Sun, 1 Mar 2026 16:05:42 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Lukas Straub <lukasstraub2@web.de>
cc: Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Subject: Re: qemu master compile error in hw/net/rtl8139.c with --enable-asan
In-Reply-To: <20260301121347.797dc9f4@penguin>
Message-ID: <b3dec664-f6d4-76a4-a2cc-edc653ef60e7@eik.bme.hu>
References: <20260301121347.797dc9f4@penguin>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-527611642-1772377323=:46381"
Content-ID: <43de0924-bdb1-170e-12ae-cd5549248702@eik.bme.hu>
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-527611642-1772377323=:46381
Content-Type: text/plain; CHARSET=ISO-8859-7; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <9a9435dc-b435-3cce-1737-b76e772aaaba@eik.bme.hu>

On Sun, 1 Mar 2026, Lukas Straub wrote:
> On Ubuntu 24.04:
>
> lukas@build_colo:~/qemu$ cc --version
> cc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0
> Copyright (C) 2023 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> lukas@build_colo:~/qemu$ ./configure --target-list=x86_64-softmmu --enable-replication --enable-docs --enable-asan
> lukas@build_colo:~/qemu$ ninja -C build qemu-system-x86_64 qemu-img tests/qtest/migration-test
> ninja: Entering directory `build'
> [24/564] Compiling C object libsystem.a.p/hw_net_rtl8139.c.o
> FAILED: libsystem.a.p/hw_net_rtl8139.c.o
> cc -m64 -Ilibsystem.a.p -I. -I.. -Isubprojects/dtc/libfdt -I../subprojects/dtc/libfdt -Isubprojects/libvduse -I../subprojects/libvduse -Iui -Iqapi -Itrace -Iui/shader -I/usr/include/p11-kit-1 -I/usr/include/pixman-1 -I/usr/include/libpng16 -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/gio-unix-2.0 -I/usr/include/slirp -fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11 -O2 -g -mcx16 -msse2 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=zero -fzero-call-used-regs=used-gpr -fsanitize=address -fstack-protector-strong -Wempty-body -Wendif-labels -Wexpansion-to-defined -Wformat-security -Wformat-y2k -Wignored-qualifiers -Wimplicit-fallthrough=2 -Winit-self -Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wold-style-definition -Wredundant-decls -Wshadow=local -Wstrict-prototypes -
 Wtype-limits -Wundef -Wvla -Wwrite-strings -Wno-missing-include-dirs -Wno-psabi -Wno-shift-negative-value -isystem /home/lukas/qemu/linux-headers -isystem linux-headers -iquote . -iquote /home/lukas/qemu -iquote /home/lukas/qemu/include -iquote /home/lukas/qemu/host/include/x86_64 -iquote /home/lukas/qemu/host/include/generic -iquote /home/lukas/qemu/tcg/x86_64 -pthread -fPIE -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=600 -DNCURSES_WIDECHAR=1 -DCONFIG_SOFTMMU -DCOMPILING_SYSTEM_VS_USER -MD -MQ libsystem.a.p/hw_net_rtl8139.c.o -MF libsystem.a.p/hw_net_rtl8139.c.o.d -o libsystem.a.p/hw_net_rtl8139.c.o -c ../hw/net/rtl8139.c
> ../hw/net/rtl8139.c: In function ¡rtl8139_io_writeb¢:
> ../hw/net/rtl8139.c:2264:17: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
> 2264 |                 memcpy(data_to_checksum, saved_ip_header + 12, 8);
>      |                 ^
> In file included from ../hw/net/rtl8139.c:62:
> /home/lukas/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into destination object ¡ip_ver_len¢ of size 1
>   50 |     uint8_t  ip_ver_len;     /* version and header length */
>      |              ^~~~~~~~~~
> ../hw/net/rtl8139.c:2192:21: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
> 2192 |                     memcpy(data_to_checksum, saved_ip_header + 12, 8);
>      |                     ^
> /home/lukas/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into destination object ¡ip_ver_len¢ of size 1
>   50 |     uint8_t  ip_ver_len;     /* version and header length */
>      |              ^~~~~~~~~~
> ../hw/net/rtl8139.c:2192:21: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
> 2192 |                     memcpy(data_to_checksum, saved_ip_header + 12, 8);
>      |                     ^
> /home/lukas/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into destination object ¡ip_ver_len¢ of size 1
>   50 |     uint8_t  ip_ver_len;     /* version and header length */
>      |              ^~~~~~~~~~
> In file included from /home/lukas/qemu/include/system/memory.h:21,
>                 from /home/lukas/qemu/include/hw/pci/pci.h:4,
>                 from /home/lukas/qemu/include/hw/pci/pci_device.h:4,
>                 from ../hw/net/rtl8139.c:54:
> In function ¡stl_he_p¢,
>    inlined from ¡stl_be_p¢ at /home/lukas/qemu/include/qemu/bswap.h:371:5,
>    inlined from ¡rtl8139_cplus_transmit_one¢ at ../hw/net/rtl8139.c:2244:21,
>    inlined from ¡rtl8139_cplus_transmit¢ at ../hw/net/rtl8139.c:2345:28,
>    inlined from ¡rtl8139_io_writeb¢ at ../hw/net/rtl8139.c:2728:17:
> /home/lukas/qemu/include/qemu/bswap.h:284:5: error: writing 4 bytes into a region of size 0 [-Werror=stringop-overflow=]
>  284 |     __builtin_memcpy(ptr, &v, sizeof(v));
>      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /home/lukas/qemu/include/net/eth.h: In function ¡rtl8139_io_writeb¢:
> /home/lukas/qemu/include/net/eth.h:50:14: note: at offset [24, 64] into destination object ¡ip_ver_len¢ of size 1
>   50 |     uint8_t  ip_ver_len;     /* version and header length */
>      |              ^~~~~~~~~~
> cc1: all warnings being treated as errors
> [37/564] Compiling C object libsystem.a.p/hw_pci_pci.c.o
> ninja: build stopped: subcommand failed.

I don't know but it does not seem related to my recent patch. Maybe 
something with f8b94b4c52 (net: mark struct ip_header as QEMU_PACKED) but 
that's quite a long time ago or some other changes somewhere else? Adding 
some people who might have a better guess.

Regards,
BALATON Zoltan
--3866299591-527611642-1772377323=:46381--

