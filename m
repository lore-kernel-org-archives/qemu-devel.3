Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF85EC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5VG-00078D-6U; Tue, 12 Mar 2024 13:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Tp-00053R-Qp; Tue, 12 Mar 2024 13:00:00 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Tn-00081f-34; Tue, 12 Mar 2024 12:59:57 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5e42b4bbfa4so3027921a12.1; 
 Tue, 12 Mar 2024 09:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262793; x=1710867593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JY6w3rpqFyxoTa5NCkYJFl6Arjw1dSCb+uD0G8jkaLo=;
 b=eQ26zxCxGBdaEvadLlfBzUFriZA2776ZHrH2d/owsCFBPg1YmvFRyN5oZQLB+diMNo
 6LJ2ULPmz07/fERmWcaBzAOk1QcNGVUYdaz/KfQ7RG7HcB0rpni+fcHNMiQ/ko8/Exoz
 hiUZbb9QjChZyJmrGAWCws9WHyBR4pG9pM1fJW4GhVl9W3C+ir+0EOtMRzg85xG+EaJE
 pY9P3+qxkozBQrCwIGErLZKdR7Zzfs9ej+aaT6AuHljVkg5PbvV8p8K+PFORmiiEb4m0
 lKJ63x9QeaEjAUB29NMiu0JJhQH4OuGnaNF83BlaAh11s+zLDpQAijHEhDEfqni0GFDu
 0a5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262793; x=1710867593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JY6w3rpqFyxoTa5NCkYJFl6Arjw1dSCb+uD0G8jkaLo=;
 b=UwM/7D7kQuRtSMfWYnm53P7gL0foROkL98puFnwVzVzUHKjhyLn2CNQZ2N8DiWZvc8
 7la0v8B6vKv0zANwhQ3h1OGwzx5+f3qIJ0wr7b7jq16gcmW5Q2LO8LZg0FFR0ytqr1FW
 zrYxrxZunuqYmppm3KDKq7mjT2Au1vUvGNyd7QBsbwSpRrYUew1XVreLAxlvJXnlqJnc
 Vx4xcznY1aScECasJewDg/S+zTS/g3nOtuZhQxLaC++MZroNV7BWswwHurQQ9vgbyeD3
 4Vuygrx3pIMEsWGLdSIAvFhr/F2VVMoOQB2E7iToun9oT4K82aFioR6Q9V0Myn/abQE2
 d24g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9dEhr0vyKO9XkfNQxXDtz9Rukc3mYW1aaPLrD4JOiKZfBn98MmmixDaRkq9CxnTBB0LlXqHtSO/YqR3yTW2lsoVxX
X-Gm-Message-State: AOJu0YyIJ/zm3EYkjRTixPlJfMjGNi8c90+qdDjCrj2C4bSHsOA199Jv
 tht3OoB1cmjLW0v8TULxNqKi1L9fH4z1xrG5+9Tqu3iJWVSFqwnVanQtfuWDOBw=
X-Google-Smtp-Source: AGHT+IGqz+XXbed8souHFSokxReA1YWz6jKymYEJM/JJWWvULQsWhXfF+WLYGlIEJEJz/pbKGsOKyw==
X-Received: by 2002:a05:6a20:94c7:b0:1a3:10d5:688a with SMTP id
 ht7-20020a056a2094c700b001a310d5688amr819076pzb.57.1710262792962; 
 Tue, 12 Mar 2024 09:59:52 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.09.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 09:59:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Bernhard Beschow <shentey@gmail.com>
Subject: [PULL 14/38] docs/system/ppc: Document running Linux on AmigaNG
 machines
Date: Wed, 13 Mar 2024 02:58:25 +1000
Message-ID: <20240312165851.2240242-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Documentation on how to run Linux on the amigaone, pegasos2 and
sam460ex machines is currently buried in the depths of the qemu-devel
mailing list and in the source code. Let's collect the information in
the QEMU handbook for a one stop solution.

Tested-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Co-authored-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 MAINTAINERS                 |   1 +
 docs/system/ppc/amigang.rst | 161 ++++++++++++++++++++++++++++++++++++
 docs/system/target-ppc.rst  |   1 +
 3 files changed, 163 insertions(+)
 create mode 100644 docs/system/ppc/amigang.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index fe8a7454ba..1f89e274d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1572,6 +1572,7 @@ F: hw/rtc/m41t80.c
 F: pc-bios/canyonlands.dt[sb]
 F: pc-bios/u-boot-sam460ex-20100605.bin
 F: roms/u-boot-sam460ex
+F: docs/system/ppc/amigang.rst
 
 pegasos2
 M: BALATON Zoltan <balaton@eik.bme.hu>
diff --git a/docs/system/ppc/amigang.rst b/docs/system/ppc/amigang.rst
new file mode 100644
index 0000000000..ba1a3d80b9
--- /dev/null
+++ b/docs/system/ppc/amigang.rst
@@ -0,0 +1,161 @@
+=========================================================
+AmigaNG boards (``amigaone``, ``pegasos2``, ``sam460ex``)
+=========================================================
+
+These PowerPC machines emulate boards that are primarily used for
+running Amiga like OSes (AmigaOS 4, MorphOS and AROS) but these can
+also run Linux which is what this section documents.
+
+Eyetech AmigaOne/Mai Logic Teron (``amigaone``)
+===============================================
+
+The ``amigaone`` machine emulates an AmigaOne XE mainboard by Eyetech
+which is a rebranded Mai Logic Teron board with modified U-Boot
+firmware to support AmigaOS 4.
+
+Emulated devices
+----------------
+
+ * PowerPC 7457 CPU (can also use``-cpu g3, 750cxe, 750fx`` or ``750gx``)
+ * Articia S north bridge
+ * VIA VT82C686B south bridge
+ * PCI VGA compatible card (guests may need other card instead)
+ * PS/2 keyboard and mouse
+
+Firmware
+--------
+
+A firmware binary is necessary for the boot process. It is a modified
+U-Boot under GPL but its source is lost so it cannot be included in
+QEMU. A binary is available at
+https://www.hyperion-entertainment.com/index.php/downloads?view=files&parent=28.
+The ROM image is in the last 512kB which can be extracted with the
+following command:
+
+.. code-block:: bash
+
+  $ tail -c 524288 updater.image > u-boot-amigaone.bin
+
+The BIOS emulator in the firmware is unable to run QEMU‘s standard
+vgabios so ``VGABIOS-lgpl-latest.bin`` is needed instead which can be
+downloaded from http://www.nongnu.org/vgabios.
+
+Running Linux
+-------------
+
+There are some Linux images under the following link that work on the
+``amigaone`` machine:
+https://sourceforge.net/projects/amigaone-linux/files/debian-installer/.
+To boot the system run:
+
+.. code-block:: bash
+
+  $ qemu-system-ppc -machine amigaone -bios u-boot-amigaone.bin \
+                    -cdrom "A1 Linux Net Installer.iso" \
+                    -device ati-vga,model=rv100,romfile=VGABIOS-lgpl-latest.bin
+
+From the firmware menu that appears select ``Boot sequence`` →
+``Amiga Multiboot Options`` and set ``Boot device 1`` to
+``Onboard VIA IDE CDROM``. Then hit escape until the main screen appears again,
+hit escape once more and from the exit menu that appears select either
+``Save settings and exit`` or ``Use settings for this session only``. It may
+take a long time loading the kernel into memory but eventually it boots and the
+installer becomes visible. The ``ati-vga`` RV100 emulation is not
+complete yet so only frame buffer works, DRM and 3D is not available.
+
+Genesi/bPlan Pegasos II (``pegasos2``)
+======================================
+
+The ``pegasos2`` machine emulates the Pegasos II sold by Genesi and
+designed by bPlan. Its schematics are available at
+https://www.powerdeveloper.org/platforms/pegasos/schematics.
+
+Emulated devices
+----------------
+
+ * PowerPC 7457 CPU (can also use``-cpu g3`` or ``750cxe``)
+ * Marvell MV64361 Discovery II north bridge
+ * VIA VT8231 south bridge
+ * PCI VGA compatible card (guests may need other card instead)
+ * PS/2 keyboard and mouse
+
+Firmware
+--------
+
+The Pegasos II board has an Open Firmware compliant ROM based on
+SmartFirmware with some changes that are not open-sourced therefore
+the ROM binary cannot be included in QEMU. An updater was available
+from bPlan, it can be found in the `Internet Archive
+<http://web.archive.org/web/20071021223056/http://www.bplan-gmbh.de/up050404/up050404>`_.
+The ROM image can be extracted from it with the following command:
+
+.. code-block:: bash
+
+  $ tail -c +85581 up050404 | head -c 524288 > pegasos2.rom
+
+Running Linux
+-------------
+
+The PowerPC version of Debian 8.11 supported Pegasos II. The BIOS
+emulator in the firmware binary is unable to run QEMU‘s standard
+vgabios so it needs to be disabled. To boot the system run:
+
+.. code-block:: bash
+
+  $ qemu-system-ppc -machine pegasos2 -bios pegasos2.rom \
+                    -cdrom debian-8.11.0-powerpc-netinst.iso \
+                    -device VGA,romfile="" -serial stdio
+
+At the firmware ``ok`` prompt enter ``boot cd install/pegasos``.
+
+Alternatively, it is possible to boot the kernel directly without
+firmware ROM using the QEMU built-in minimal Virtual Open Firmware
+(VOF) emulation which is also supported on ``pegasos2``. For this,
+extract the kernel ``install/powerpc/vmlinuz-chrp.initrd`` from the CD
+image, then run:
+
+.. code-block:: bash
+
+  $ qemu-system-ppc -machine pegasos2 -serial stdio \
+                    -kernel vmlinuz-chrp.initrd -append "---" \
+                    -cdrom debian-8.11.0-powerpc-netinst.iso
+
+aCube Sam460ex (``sam460ex``)
+=============================
+
+The ``sam460ex`` machine emulates the Sam460ex board by aCube which is
+based on the AMCC PowerPC 460EX SoC (that despite its name has a
+PPC440 CPU core).
+
+Firmware
+--------
+
+The board has a firmware based on an older U-Boot version with
+modifications to support booting AmigaOS 4. The firmware ROM is
+included with QEMU.
+
+Emulated devices
+----------------
+
+ * PowerPC 460EX SoC
+ * M41T80 serial RTC chip
+ * Silicon Motion SM501 display parts (identical to SM502 on real board)
+ * Silicon Image SiI3112 2 port SATA controller
+ * USB keyboard and mouse
+
+Running Linux
+-------------
+
+The only Linux distro that supported Sam460ex out of box was CruxPPC
+2.x. It can be booted by running:
+
+.. code-block:: bash
+
+  $ qemu-system-ppc -machine sam460ex -serial stdio \
+                    -drive if=none,id=cd,format=raw,file=crux-ppc-2.7a.iso \
+                    -device ide-cd,drive=cd,bus=ide.1
+
+There are some other kernels and instructions for booting other
+distros on aCube's product page at
+https://www.acube-systems.biz/index.php?page=hardware&pid=5
+but those are untested.
diff --git a/docs/system/target-ppc.rst b/docs/system/target-ppc.rst
index 4f6eb93b17..87bf412ce5 100644
--- a/docs/system/target-ppc.rst
+++ b/docs/system/target-ppc.rst
@@ -17,6 +17,7 @@ help``.
 .. toctree::
    :maxdepth: 1
 
+   ppc/amigang
    ppc/embedded
    ppc/powermac
    ppc/powernv
-- 
2.42.0


