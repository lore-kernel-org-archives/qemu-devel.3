Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53805606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 05:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=J3bURhhm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKUfs-0007Br-WC; Sat, 24 Oct 2026 01:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xKUfl-0007B7-KJ
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 01:52:06 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xKUfi-0002k9-Md
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 01:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792821117; bh=KHAyM9NCoeJvdlm1NZrUUY5fDEGS6cRceGmriqDQDEI=;
 h=Date:To:Cc:From:Subject;
 b=J3bURhhmu70bsda5Wz5ILwF6j6IM9j1xM3qjVl5OwLjYpLDjh3nU9eusyLI+GN4eP
 imNEsykUtBtFddJ8zh8kpHjABl3BJhOeiThOGiCI/ADVAL6a5LdVZqNL1ejc/uNbCc
 kT9VA/GGQfe/Jq+JFRr1ZPGbjO/p2aM7hw8LKLMGpDPzfko2/h5XaZ596xp52LfR9w
 b28UAKsD+xpb5NR8iw/EK+fO9pNaFZLGXXs6rlbpjjQ5U+Yl5i4tOPF3eI3WKnMReC
 3ZcOlwqD+pPInjc1/w4D6EkHRcoaKmyXgx9GMlfnN7oT9JW68OqnU2V5t8oKHfPK2c
 hcptfdKNxXatw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D7E9D1E0975;
 Sat, 24 Oct 2026 08:51:57 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CB187449AEC;
 Sat, 24 Oct 2026 08:51:57 +0300 (MSK)
Message-ID: <c9bcda59-f2f9-4036-8aeb-1e36e1b68498@tls.msk.ru>
Date: Sat, 24 Oct 2026 08:51:57 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, ru-RU
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: linux-user/vdso: reproducible?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi!

Once again I'm trying to fix a long-standing issue in debian & ubuntu with
vdso files build.

One of the requirements here is to build everything from source, ensuring
the things can be rebuild and are reproducible (that is, the shipped binaries
can actually be produced from the provided source and not something else
with a hidden backdoor).

It'd be nice to just build the vdso.so files during regular package build.
But this does not work correctly neither in debian nor in ubuntu infrastructure
due to several reasons.  The main problem is that to build all vdso files,
one need to have cross-compilers for all architectures on every host
architecture for which qemu-user packages are produced, which is problematic
(especially for lower-power, or "small", architectures).

Additionally, llvm/clang, which can produce binaries for multiple architectures
and is available on all host architectures on debian, does not handle sh4 and
hpps which are currently needed to rebuild vdso files in qemu, so it is also
not an option, at least not yet (sh4 support hopefully will be available soon).

I'm using tricks to build vdso files on one architecture and use the result
when building linux-user packages on all architectures.  But this does not
work correctly neither in debian nor in ubuntu.

An alternative is to actually use the binaries provided in qemu source
tarball.  However in order to do that, I have to actually verify if the
binaries are produced from the actual source shipped with these binaries.
It doesn't seem to be a difficult task because of the similicity of the
sources - it is a simple assembler-language file which - in theory -
should be trivially reproducible.

However, when I build a vdso file locally with the same compiler options
and compare it with the binary shipped with qemu, I see this:

linux-user/aarch64 $ diffoscope vdso-be.so*
2026-10-23 18:59:46 E: diffoscope.comparators.elf: Command '['objdump --line-numbers --disassemble --demangle --reloc --no-show-raw-insn 
--section=.text {}']' returned non-zero exit status 1.
2026-10-23 18:59:46 E: diffoscope.comparators.elf: Command '['objdump --disassemble --demangle --no-show-raw-insn --section=.text {}']' returned 
non-zero exit status 1.
--- vdso-be.so
+++ vdso-be.so.mjt
├── readelf --wide --symbols {}
│ @@ -19,15 +19,15 @@
│       6: 0000000000000380     0 SECTION LOCAL  DEFAULT    6 .gnu.hash
│       7: 00000000000003b8     0 SECTION LOCAL  DEFAULT    7 .dynstr
│       8: 0000000000000430     0 SECTION LOCAL  DEFAULT    8 .gnu.version
│       9: 0000000000000440     0 SECTION LOCAL  DEFAULT    9 .gnu.version_d
│      10: 0000000000000478     0 SECTION LOCAL  DEFAULT   10 .eh_frame_hdr
│      11: 0000000000000490     0 SECTION LOCAL  DEFAULT   11 .eh_frame
│      12: 00000000000004b8     0 SECTION LOCAL  DEFAULT   12 .text
│ -    13: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS cc0Lcfxq.o
│ +    13: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS ccuckKYd.o
│      14: 0000000000000158     0 NOTYPE  LOCAL  DEFAULT    1 $d
│      15: 00000000000004b8     0 NOTYPE  LOCAL  DEFAULT   12 $x
│      16: 00000000000004f0     0 NOTYPE  LOCAL  DEFAULT   12 sigreturn_region_start
│      17: 00000000000004f4     0 NOTYPE  LOCAL  DEFAULT   12 sigreturn_region_end
│      18: 00000000000004a4     0 NOTYPE  LOCAL  DEFAULT   11 $d
│      19: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS
│      20: 00000000000001a0     0 OBJECT  LOCAL  DEFAULT  ABS _DYNAMIC
├── strings --all --bytes=8 {}
│ @@ -1,14 +1,14 @@
│  __kernel_gettimeofday
│  __kernel_clock_gettime
│  __kernel_clock_getres
│  __kernel_rt_sigreturn
│  linux-vdso.so.1
│  LINUX_2.6.39
│ -cc0Lcfxq.o
│ +ccuckKYd.o
│  sigreturn_region_start
│  sigreturn_region_end
│  _DYNAMIC
│  __GNU_EH_FRAME_HDR
│  _GLOBAL_OFFSET_TABLE_
│  LINUX_2.6.39
│  __kernel_clock_getres
├── readelf --wide --decompress --hex-dump=.strtab {}
│ @@ -1,10 +1,10 @@
│
│  Hex dump of section '.strtab':
│ -  0x00000000 00636330 4c636678 712e6f00 24640024 .cc0Lcfxq.o.$d.$
│ +  0x00000000 00636375 636b4b59 642e6f00 24640024 .ccuckKYd.o.$d.$
│    0x00000010 78007369 67726574 75726e5f 72656769 x.sigreturn_regi
│    0x00000020 6f6e5f73 74617274 00736967 72657475 on_start.sigretu
│    0x00000030 726e5f72 6567696f 6e5f656e 64005f44 rn_region_end._D
│    0x00000040 594e414d 4943005f 5f474e55 5f45485f YNAMIC.__GNU_EH_
│    0x00000050 4652414d 455f4844 52005f47 4c4f4241 FRAME_HDR._GLOBA
│    0x00000060 4c5f4f46 46534554 5f544142 4c455f00 L_OFFSET_TABLE_.
│    0x00000070 4c494e55 585f322e 362e3339 005f5f6b LINUX_2.6.39.__k

So basically, the difference is just in the temporary .o filename
used during the build process, and that name is random.

After stripping both files from debug info (aarch64-linux-gnu-strip),
things becomes exactly the same.

Can't we strip them during build anyway?

(I'm not an expert with these reproducible build thing, maybe they
have more ways to handle differences like this, and maybe more
suggestions to further improve the situation besides stripping -
asked them too).

It's interesting that adding -s switch to gcc produces slightly different
binary than not using -s and stripping after the link explicitly.

linux-user/aarch64$ diffoscope --tool-prefix-binutils=aarch64-linux-gnu-  vdso-be.so*
2026-10-23 19:06:01 E: diffoscope.comparators.elf: Command '['objdump --line-numbers --disassemble --demangle --reloc --no-show-raw-insn 
--section=.text {}']' returned non-zero exit status 1.
2026-10-23 19:06:01 E: diffoscope.comparators.elf: Command '['objdump --disassemble --demangle --no-show-raw-insn --section=.text {}']' returned 
non-zero exit status 1.
--- vdso-be.so
+++ vdso-be.so.mjt
│┄ xxd not available in path. Falling back to Python hexlify.
│┄ Format-specific differences are supported for ELF binaries but no file-specific differences were detected; falling back to a binary diff. file(1) 
reports: ELF 64-bit MSB shared object, ARM aarch64, version 1 (SYSV), dynamically linked, BuildID[sha1]=ba5dd46a2ef8dde79536f81dd8126e0ee2f3df39, stripped
@@ -6,15 +6,15 @@
  00000000000004f40000000000001000000000020000000400000000000001a0
  00000000000001a000000000000001a000000000000001000000000000000100
  00000000000000086474e5500000000400000000000004780000000000000478
  0000000000000478000000000000001400000000000000140000000000000004
  0000000400000004000000000000015800000000000001580000000000000158
  0000000000000044000000000000004400000000000000080000000400000010
  00000005474e5500c00000000000000400000003000000000000000400000014
-00000003474e5500ba5dd46a2ef8dde79536f81dd8126e0ee2f3df3900000000
+00000003474e550047654bef50c6d25c99110c67c0eddb8e67b78bab00000000
  000000000000000e000000000000005a00000000000000040000000000000350
  000000006ffffef50000000000000380000000000000000500000000000003b8
  000000000000000600000000000002a0000000000000000a0000000000000077
  000000000000000b0000000000000018000000006ffffffc0000000000000440
  000000006ffffffd0000000000000002000000006ffffff00000000000000430
  0000000000000000000000000000000000000000000000000000000000000000
  0000000000000000000000000000000000000000000000000000000000000000

So, can we at least strip the files?

Something like this (for all files):

diff --git a/linux-user/aarch64/Makefile.vdso b/linux-user/aarch64/Makefile.vdso
index 82ed2011087..e5655888eb4 100644
--- a/linux-user/aarch64/Makefile.vdso
+++ b/linux-user/aarch64/Makefile.vdso
@@ -10,7 +10,9 @@ LDFLAGS = -nostdlib -shared -Wl,-h,linux-vdso.so.1 \
           -Wl,-z,max-page-size=4096 -Wl,-T,$(SUBDIR)/vdso.ld

  $(SUBDIR)/vdso-be.so: vdso.S vdso.ld
-       $(CC) -o $@ $(LDFLAGS) -mbig-endian $<
+       $(CC) -o $@.tmp $(LDFLAGS) -mbig-endian $<
+       $(STRIP) $@.tmp && mv -f $@.tmp $@

  $(SUBDIR)/vdso-le.so: vdso.S vdso.ld
-       $(CC) -o $@ $(LDFLAGS) -mlittle-endian $<
+       $(CC) -o $@.tmp $(LDFLAGS) -mlittle-endian $<
+       $(STRIP) $@.tmp && mv -f $@.tmp $@

Or maybe we can use something else to make this "more reproducible".

Thanks,

/mjt

