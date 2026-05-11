Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E872ACD484C
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 16:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMTXf-0005kf-9O; Mon, 11 May 2026 12:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wMTXN-0005i2-6e
 for qemu-devel@nongnu.org; Mon, 11 May 2026 12:31:27 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wMTXK-0005Ez-M1
 for qemu-devel@nongnu.org; Mon, 11 May 2026 12:31:20 -0400
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-8ec9f099fc6so509412085a.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 09:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778517078; x=1779121878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gu7KF0/6BJ3oRJ+jusTPOi55mY6tASxiicEBVsS9SIo=;
 b=KgxoP6SYerVcirzXgF/Y2IGO9H33I0cMQwfOPgq74OuXoHA0oQpPFileV+RugcANe7
 rQf7yBLMorhBBRSM7aU8yGL1wnYgNdFbq2rayToGc6niW3aQzDrWLoudLPDtXcO9wZoh
 K5Xt1rGiWtiwDB/dBCAt6+wRd+59udZaepG0WIJp2NzA2hEMEy3j+LfN+/NkS1VS6WsR
 WLJVcKC/6xK8k8giXMr/W6jtw/Djy6EchYm1wlPK7rmtBSvfeT5vVe69yfHY3W+4kaCU
 +Rsb0/6jRK7eumUzwBrm6sTu3DhNkgaPvJO6QjZp+Z3h1KsGT5EHh99l01k5guKrZ/eG
 NprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778517078; x=1779121878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gu7KF0/6BJ3oRJ+jusTPOi55mY6tASxiicEBVsS9SIo=;
 b=ZGloABWlZe6ogvv99Z3D/Zw9x4uDVBlDZvg40YoiqQS36q1FCWPmWQ5u7n77CL2WQJ
 I98l6mNLsKJ3a1mMZnpyHW3mTMrdiJd3iB6t/1qYUqx6V6hf/23KRTKBUOjPa78XMsJy
 jw5h+kCQHLmRyt71cvLhafvG0XA/m/PMlhKXRIQfCMGd2qYGmKAnspnCPsAAsKS0XfXq
 dX2mvQc6YGfvU/VCKJ0V/Rwe5jxub2r/XTouM+ET4zIcXvjm88C9BzV/Yth9o2GroPUm
 RWvu8ZepNP3J3LQB7MHg3TRzVcddBwCE672CaPP+mVQgSydvnF2lM/lZeK/8Ymps5+WR
 Zyuw==
X-Gm-Message-State: AOJu0YyQbxk4xPraTV+wiBWfzpiEXZvf0rCPQwjrOu3VKNmZ1MfGCNfz
 rTGrD+TzcRrkdems1SlXJ9Nw1leR0TrivuDW8i7HlMc+AXWtfWniN1Om
X-Gm-Gg: Acq92OFLtrJjeNbqZxmROGOwBugmqYJeIV+0MI0tThmPHfZps1INnix/h3L9+60SDR4
 gXBY78U9aCxa4+yaVTyQYRQJ98M2U2JV1+ycRQhualXu6+BR/K8JWCYD91TSLvRohiicud5JgE5
 i8vAR4aX+RhLBQ5pB+Q7Jbp9xY9bwpEkW664nq8RvumUL4VoGUJXUnu6AE2BZ+CLmCQyIlpNbKY
 iNI3YD5WD7a9/0I1HZz917dPT3lXQXmkACEnmaksmbfK6rcBowHRMZ/fnzh+fH6AyrJNGHQmT0N
 SBoE/NZQ/p6L4jO1ibDhsvTzEsnOinRmlUIsYzTaCkOs9RbUPTd8aHbDcuxbHb5sMMP5HvZqUX2
 cOgR65a6nFSuN6h4TG0lZpeZl+x0iLLYc4+10+hMrEoQzyU4RdWl4Zqogikcrn0qpBWoLAvtLfK
 ThfKVhRXeDSan/p2uFObsWL+VtWEad1C1vuvArgOazL3+BJ0JaeMgnjRaTf5+1UCPKeu09
X-Received: by 2002:a05:620a:4486:b0:8cf:d804:4557 with SMTP id
 af79cd13be357-904d4a61accmr3791571085a.19.1778517045936; 
 Mon, 11 May 2026 09:30:45 -0700 (PDT)
Received: from ZEVORN-PC.bbrouter ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-907b9c542cdsm1097160785a.0.2026.05.11.09.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 09:30:45 -0700 (PDT)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Chao Liu <chao.liu.zevorn@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v7 5/5] docs/system/riscv: add documentation for k230 machine
Date: Tue, 12 May 2026 00:29:49 +0800
Message-ID: <b3dc23332a8a6f02a15012308fe79f5a172a3837.1778516731.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1778516731.git.chao.liu.zevorn@gmail.com>
References: <cover.1778516731.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qk1-x742.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 MAINTAINERS                  |   1 +
 docs/system/riscv/k230.rst   | 113 +++++++++++++++++++++++++++++++++++
 docs/system/target-riscv.rst |   1 +
 3 files changed, 115 insertions(+)
 create mode 100644 docs/system/riscv/k230.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index e7e3ed0c5c..6a752b1a0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1784,6 +1784,7 @@ K230 Machines
 M: Chao Liu <chao.liu.zevorn@gmail.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
+F: docs/system/riscv/k230.rst
 F: hw/riscv/k230.c
 F: hw/watchdog/k230_wdt.c
 F: include/hw/riscv/k230.h
diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
new file mode 100644
index 0000000000..cea8202e55
--- /dev/null
+++ b/docs/system/riscv/k230.rst
@@ -0,0 +1,113 @@
+Kendryte K230 virt reference platform (``k230``)
+==========================================================================
+The ``k230`` machine is compatible with the Kendryte K230 SDK.
+
+The K230 is a chip from the AIoT SoC series made by Kendryte ® — a part of
+Canaan Inc. It uses a brand-new multi-heterogeneous unit accelerated computing
+structure.
+
+This chip has 2 RISC-V computing cores and a new-generation KPU (Knowledge
+Process Unit) smart computing unit.
+
+For more information, see <https://www.kendryte.com/en/proDetail/230>
+
+Supported devices
+-----------------
+The ``k230`` machine supports the following devices:
+
+* 1 c908 cores (little core)
+* Core Local Interruptor (CLINT)
+* Platform-Level Interrupt Controller (PLIC)
+* 2 K230 Watchdog Timer
+* 5 UART
+
+Boot options
+------------
+The ``k230`` machine supports K230 SDK boot through M-mode U-Boot, which then
+starts OpenSBI/Linux with ``bootm``. It also supports direct Linux boot.
+
+K230 SDK Linux kernels use T-HEAD C9xx private MAEE page table attributes. QEMU
+does not implement MAEE in the generic RISC-V MMU, so such kernels need to be
+built with standard RISC-V PTE bits before they can boot under QEMU.
+
+Running
+-------
+
+Direct Linux boot
+~~~~~~~~~~~~~~~~~
+
+This flow lets QEMU load OpenSBI, Linux, initrd, and DTB directly, without
+running SDK U-Boot. The Linux Image must be rebuilt with standard RISC-V PTE
+bits before running under QEMU.
+
+.. code-block:: bash
+
+   $ SDK=k230_sdk/output/k230_canmv_defconfig
+   $ qemu-system-riscv64 -machine k230 \
+      -kernel "$SDK/images/little-core/Image" \
+      -dtb "/tmp/user-k230-qemu.dtb" \
+      -initrd "$SDK/images/little-core/rootfs.cpio.gz" \
+      -append "console=ttyS0,115200 earlycon=sbi cma=0" \
+      -nographic
+
+Direct boot uses the SDK little-core RAM layout for OpenSBI at
+``0x08000000``, Linux at ``0x08200000``, and the DTB at ``0x0a000000``. The
+initrd is placed by QEMU's generic RISC-V boot helper, and QEMU writes the
+initrd range and kernel command line into ``/chosen``. The DTB passed with
+``-dtb`` should be derived from ``$SDK/images/little-core/k230.dtb`` and must
+describe that initrd location as usable memory and disable any devices that are
+not emulated by this machine.
+
+U-Boot boot
+~~~~~~~~~~~
+
+This flow starts SDK U-Boot in M-mode with ``-bios``. Until the SDK storage
+path is modeled, place OpenSBI, Linux, initrd, and DTB in RAM with loader
+devices and run ``bootm`` manually. The Linux Image must be rebuilt with
+standard RISC-V PTE bits before running under QEMU.
+
+.. code-block:: bash
+
+   $ SDK=k230_sdk/output/k230_canmv_defconfig
+   $ IMAGE=$SDK/images/little-core/Image
+   $ INITRD=$SDK/images/little-core/rootfs.cpio.gz
+   $ DTB=$SDK/images/little-core/k230.dtb
+   $ FWJUMP_UIMAGE=/tmp/k230-fw-jump.uImage
+   $ INITRD_END=$(printf "0x%x" $((0x0a100000 + $(stat -c %s "$INITRD"))))
+   $ "$SDK/little/buildroot-ext/host/bin/mkimage" \
+      -A riscv -O linux -T kernel -C none \
+      -a 0x8000000 -e 0x8000000 -n opensbi \
+      -d "$SDK/images/little-core/fw_jump.bin" "$FWJUMP_UIMAGE"
+   $ qemu-system-riscv64 -machine k230 \
+      -bios "$SDK/little/uboot/u-boot" \
+      -device loader,file="$FWJUMP_UIMAGE",addr=0xc100000,force-raw=on \
+      -device loader,file="$IMAGE",addr=0x8200000,force-raw=on \
+      -device loader,file="$INITRD",addr=0xa100000,force-raw=on \
+      -device loader,file="$DTB",addr=0xa000000,force-raw=on \
+      -nographic
+
+The loader addresses mirror the SDK ``k230_canmv_defconfig`` output. Read the
+U-Boot addresses from the generated environment, and read the Linux RAM base
+from the generated ``hw/k230.dts.txt``. This replaces the SDK storage and
+decompression steps.
+
+Press Enter to stop autoboot. At the U-Boot prompt, run these commands:
+
+.. code-block:: bash
+
+   K230# setenv bootargs console=ttyS0,115200 earlycon=sbi cma=0
+   K230# fdt addr 0xa000000
+   K230# fdt resize 8192
+   K230# fdt set /chosen linux,initrd-start <0x0 0xa100000>
+   K230# fdt set /chosen linux,initrd-end <0x0 ${INITRD_END}>
+   K230# fdt set /soc/sdhci0@91580000 status disabled
+   K230# fdt set /soc/sdhci1@91581000 status disabled
+   K230# bootm 0xc100000 - 0xa000000
+
+Use ``setenv`` so ``bootm`` writes the kernel command line into
+``/chosen/bootargs``. The ``fdt`` commands select the loaded DTB, add space for
+edits, describe the initrd range in ``/chosen``, and disable SDHCI nodes because
+this machine does not emulate those controllers yet. Replace ``${INITRD_END}``
+with the host-calculated value above when typing the command. ``cma=0`` avoids
+the SDK kernel reserving too much of the little-core memory window for initramfs
+boot.
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 3ad5d1ddaf..b0b2f9584f 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -66,6 +66,7 @@ undocumented; you can get a complete list by running
 .. toctree::
    :maxdepth: 1
 
+   riscv/k230
    riscv/microblaze-v-generic
    riscv/microchip-icicle-kit
    riscv/mips

