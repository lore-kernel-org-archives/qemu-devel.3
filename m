Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2ADD49C64
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 07:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlj1k-0004RJ-Iw; Fri, 30 Jan 2026 02:34:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vlj1W-0004Oz-Kr
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 02:34:35 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vlj1U-00024g-EN
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 02:34:34 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-823081bb15fso1006933b3a.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 23:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769758471; x=1770363271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wwjpnh3SSe9ZDRXLkUoFB5mrzRvGq2n17ONNBgx2lCs=;
 b=F2YkjF2h2PvdZXR1z1HNBQTT2LWC3U7gARbMz+8B8vRtzBHKhRl5u6r32jdmEDlPv/
 fwhbRO9QBbitKygsMSHFYYn0dL97o1vSJJLa3iJWzFSRhOpvI5LcsGcDI9PaGHkLkAHM
 tsjxgmh4qiD1UdN9EXglO+yHb1YFcr5sbFhcZGS/NDQBqs0STtrZNUCmHqupkzhabsDx
 KQsovq0Kif7cip7roG8xumAKy6mI5WMojwunqqEH6OhtLuKqqj6GMBmBOwwYPioK/WYe
 Gs9gaZsSBrU1lKBF31bEiDPytYaMJKujWP1qdpw/hkJIbmwhn8hQ1uT6ag/0pxk46CUt
 UVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769758471; x=1770363271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wwjpnh3SSe9ZDRXLkUoFB5mrzRvGq2n17ONNBgx2lCs=;
 b=LtaEs2dtRj07szeq3j/+8L9BGeZrq8d9sE+ElieD/LrGA40qWjDw0hhEmZnXNpAs9n
 ERmg1OvCSg/yPs0LwYNBeKtrMV18f5VGEqF7QyVF91TZ2S86SWzMXfJ2VdLuEaBmpx7N
 ieHu0HrEjWYLfcKV0AjXfFwn/1IUdNbPlVOCcB75pk65eCL+PykUKfvbumX1XOCfH6JQ
 ZhaTzf/BOWC/Ls09YSEW/MJZ5fAANODk+SAQI6r0NmkC0QOu7+zRO8iY3VHx7MEnrWwR
 ceREWVKKUtJOEH1oQ7m6YFvoj5cUnMr5f6mndpNz4IKfAyGkcO+hF6RpPD9tGnx9/U0D
 KKCg==
X-Gm-Message-State: AOJu0YxN5MAXhxSzq401YCkrCLw3s5kE0OKYxvzzCAOcOvyF/9Qtvqd9
 yC+UaI4w3ndktwRwIGo78Q2s9UH2Ab8M4MCrhA3XsppQM5TVh37opU07
X-Gm-Gg: AZuq6aKkJOvyOQxtK3x1azM8f47pRVCQmFMSlSrKrtNpDRDsrrBIu+WEBT/l30XWscc
 6j3ROlQZx77ArlKP8XXH03UDESSAvVG4Ngo1MjmWDKkNIX4L9Tx2nLzb13KvwldQmcons/sQtOU
 TI3JwXstmpAEcFf/4qRHGaS1jZpX4bGvV/wSIKD/DY6AzO7wfHLZYLjOzuAX2D2/O7UmWgGcQW3
 YoNYKIS3KTieJY6mtl8nmuYMHK8iUeND3Wn9Qa7u6VR1zHYQGHNunJ/3weS6Md6S5LjPk6OjDT7
 uc8uyiMojl2d1PkzTiJJOmeVk/9Z5vPoAnkiLWR94P4w2fMsGcfeZJc7LbZ8POoi5htnitp/BNM
 Yw6voPbrk9glgtJbBfb8+MaQkSowVmiW3utx1AnJtXFMhdUI9tVrRY6jsQPsTXCfFgWx1s3/cFp
 xgA6st1b1ukvSHzczzm7urXjxg754F641H0nAXW5a6VOUuKtgxAlUNm9OQsKLcmAkY1Spkcg==
X-Received: by 2002:a05:6a00:3903:b0:823:edd:20c1 with SMTP id
 d2e1a72fcca58-823aa9407a8mr1802863b3a.67.1769758470875; 
 Thu, 29 Jan 2026 23:34:30 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.20.181])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379c54febsm8598956b3a.59.2026.01.29.23.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 23:34:30 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, Chao Liu <chao.liu@zevorn.cn>
Subject: [PATCH v5 5/5] docs/system/riscv: add documentation for k230 machine
Date: Fri, 30 Jan 2026 15:33:37 +0800
Message-ID: <9dd8e511a896e42bebfc6c42a88d265a4c95f485.1769757064.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769757064.git.chao.liu.zevorn@gmail.com>
References: <cover.1769757064.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pf1-x441.google.com
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

From: Chao Liu <chao.liu@zevorn.cn>

Add documentation for k230 virt reference platform.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 MAINTAINERS                  |  1 +
 docs/system/riscv/k230.rst   | 48 ++++++++++++++++++++++++++++++++++++
 docs/system/target-riscv.rst |  1 +
 3 files changed, 50 insertions(+)
 create mode 100644 docs/system/riscv/k230.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 84c980d252..876aafe9f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1761,6 +1761,7 @@ F: include/hw/riscv/xiangshan_kmh.h
 K230 Machines
 M: Chao Liu <chao.liu.zevorn@gmail.com>
 S: Maintained
+F: docs/system/riscv/k230.rst
 F: hw/riscv/k230.c
 F: hw/watchdog/k230_wdt.c
 F: include/hw/riscv/k230.h
diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
new file mode 100644
index 0000000000..3e6ca295df
--- /dev/null
+++ b/docs/system/riscv/k230.rst
@@ -0,0 +1,48 @@
+Kendryte K230 virt reference platform (``k230``)
+==========================================================================
+The ``k230`` machine is compatible with with Kendryte K230 SDK.
+
+The K230 is a chip from the AIoT SoC series made by Kendryte ® — a part of
+Canaan Inc. It uses a brand-new multi-heterogeneous unit accelerated computing
+structure.
+
+This chip has 2 RISC-V computing cores and a new-generation KPU (Knowledge
+Process Unit) smart computing unit.
+
+It has multi-precision AI computing ability, works with many common AI computing
+frameworks, and for some typical networks, its usage rate is over 70%. Besides,
+the K230 chip supports many peripheral connections and has several special
+hardware acceleration units (like 2D and 2.5D accelerators). It can speed up
+different tasks (such as image processing, video processing, audio processing
+and AI computing). It also has many good features: low delay, high performance,
+low power use and fast start-up.
+
+For more information, see <https://www.kendryte.com/en/proDetail/230>
+
+Supported devices
+-----------------
+The ``k230`` machine supports the following devices:
+
+* 1 c908 cores
+* Core Local Interruptor (CLINT)
+* Incoming MSI Controller (IMSIC)
+* 2 K230 Watchdog Timer
+* 4 UART
+
+Boot options
+------------
+The ``k230`` machine can start using the standard ``-bios``
+functionality for loading the boot image. You need to compile and link
+the firmware, kernel, and Device Tree (FDT) into a single binary file with
+K230 SDK(k230_canmv_defconfig), such as ``uboot``.
+
+Running
+-------
+Below is an example command line for running the ``k230``
+machine:
+
+.. code-block:: bash
+
+   $ qemu-system-riscv64 -machine k230 \
+      -bios k230_sdk/output/k230_canmv_defconfig/little/uboot/u-boot \
+      -nographic
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
-- 
2.52.0


