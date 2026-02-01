Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BC7E65293
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 15:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmZK5-0007Q3-JP; Sun, 01 Feb 2026 10:25:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1vmZK1-0007Ps-Po
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 10:25:09 -0500
Received: from jedlik.phy.bme.hu ([152.66.102.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1vmZJz-0007bq-7X
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 10:25:09 -0500
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id F017AA0126; Sun,  1 Feb 2026 16:17:42 +0100 (CET)
Date: Sun, 1 Feb 2026 16:17:42 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Michael Tokarev <mjt@tls.msk.ru>
cc: QEMU Development <qemu-devel@nongnu.org>
Subject: Re: u-boot-sam460ex: can't be built in 10.2 if libfdt-dev is installed
In-Reply-To: <bc5f4a5b-02fe-4cbc-8718-a294f9d3b078@tls.msk.ru>
Message-ID: <alpine.LMD.2.03.2602011556050.13827@eik.bme.hu>
References: <bc5f4a5b-02fe-4cbc-8718-a294f9d3b078@tls.msk.ru>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1117279078-28898780-1769959062=:13827"
Received-SPF: pass client-ip=152.66.102.83;
 envelope-from=balaton@jedlik.phy.bme.hu; helo=jedlik.phy.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--1117279078-28898780-1769959062=:13827
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 24 Dec 2025, Michael Tokarev wrote:
> If <libfdt.h> is installed on the system, u-boot-sam460ex gives
> the following build errors:
>
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -idirafter=20
> /build/pkg/build/b/u-boot-sam460ex/include -idirafter /build/pkg
> /build/b/u-boot-sam460ex/include2 -idirafter=20
> /build/pkg/build/b/u-boot-sam460ex/include -I=20
> /build/pkg/build/b/u-boot-sam460ex/lib/
> libfdt -I /build/pkg/build/b/u-boot-sam460ex/tools -DTEXT_BASE=3D0xFFF800=
00=20
> -DUSE_HOSTCC -D__KERNEL_STRICT_NAMES   -o default_image.
> o default_image.c -c
> In file included from roms/u-boot-sam460ex/include/image.h:55,
>                 from default_image.c:31:
> /usr/include/libfdt.h:122:21: error: redefinition of =E2=80=98fdt_offset_=
ptr_w=E2=80=99
>  122 | static inline void *fdt_offset_ptr_w(void *fdt, int offset, int=20
> checklen)
>      |                     ^~~~~~~~~~~~~~~~
> In file included from fdt_host.h:25,
>                 from mkimage.h:35,
>                 from default_image.c:30:
> ../include/libfdt.h:126:21: note: previous definition of =E2=80=98fdt_off=
set_ptr_w=E2=80=99=20
> with type =E2=80=98void *(void *, int,  int)=E2=80=99
>  126 | static inline void *fdt_offset_ptr_w(void *fdt, int offset, int=20
> checklen)
>      |                     ^~~~~~~~~~~~~~~~
> /usr/include/libfdt.h:266:1: error: redefinition of =E2=80=98fdt_set_magi=
c=E2=80=99
>  266 | fdt_set_hdr_(magic);
>      | ^~~~~~~~~~~~
> ../include/libfdt.h:157:28: note: previous definition of =E2=80=98fdt_set=
_magic=E2=80=99 with=20
> type =E2=80=98void(void *, uint32_t)=E2=80=99 {aka =E2=80=98void(v
> oid *, unsigned int)=E2=80=99}
>
> etc.
>
> This is because roms/u-boot-sam460ex/tools/fdt_host.h includes the
> local ../include/fdt.h &Co.  While the rest of the headers include
> <fdt.h> &Co.  And in version of u-boot-sam460ex in 10.2 has the
> following difference compared to 10.1:
>
> diff -u -r qemu-10.1.0/roms/u-boot-sam460ex/tools/Makefile=20
> qemu-10.2.0/roms/u-boot-sam460ex/tools/Mak>
> --- qemu-10.1.3/roms/u-boot-sam460ex/tools/Makefile
> +++ qemu-10.2.0/roms/u-boot-sam460ex/tools/Makefile
> @@ -133,9 +133,9 @@
> # Use native tools and options
> # Define __KERNEL_STRICT_NAMES to prevent typedef overlaps
> #
> -HOSTCPPFLAGS =3D -isystem $(SRCTREE)/include \
> -               -isystem $(OBJTREE)/include2 \
> -               -isystem $(OBJTREE)/include \
> +HOSTCPPFLAGS =3D -idirafter $(SRCTREE)/include \
> +               -idirafter $(OBJTREE)/include2 \
> +               -idirafter $(OBJTREE)/include \
>                -I $(SRCTREE)/lib/libfdt \
>                -I $(SRCTREE)/tools \
>                -DTEXT_BASE=3D$(TEXT_BASE) -DUSE_HOSTCC \
>
> So in 10.1 and before, local include dir was preferred to
> the system include dir, while now local include dir is checked
> *after* the system one.  So when including <libfdt.h>, the
> system include is found first.
>
> I don't know why -isystem was changed to -idirafter.

This reverts it to how upstream has it. Previously we had a local fix in=20
commit 7fb06b0 as the above but now that no longer works because then you=
=20
get other include mismatches and build fails with:

/usr/bin/ld: errno: TLS definition in /lib64/libc.so.6 section .tbss mismat=
ches non-TLS reference in fit_image.o

so reverted this to what upstream has which unfortunately means that you=20
get conflict with fdt headers. So you get include conflicts either way but=
=20
removing system fdt headers is easier and this matches upstream reducing=20
local patches.

> For now, in order to make it buildable, I copied
> include/*fdt*.h to lib/libfdt/ so the local headers are
> picked up instead of the system ones, just like in qemu 10.1.
>
> But this needs to be addressed upstream, I'd say - either
> in u-boot-sam460ex (where the bug is), or in qemu.

The actual upstream is at https://acube-systems.biz/ and I don't want to=20
diverge from that too much as they still make updates and I want to be=20
able to update in the future without too much porting of local fixes. So=20
try sending patches to them or accept that this is based on and old U-Boot=
=20
from 2010 and only meant to build with contemporary gcc (about version 4=20
or 5) so you may need that old gcc version or a container to build it=20
(like when you build an old Linux kernel version that no longer builds=20
with current tools). We could try to fix it but then if that breaks=20
something it will be hard to find if it's broken upstream or introduced by=
=20
a local fix so best keep as close to upstream as possible.

Regards,
BALATON Zoltan
--1117279078-28898780-1769959062=:13827--

