Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6F0F436B4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 15:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDksJ-0006hL-0D; Fri, 17 Apr 2026 11:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wDksF-0006dd-Q5
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 11:12:52 -0400
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wDksD-0007iB-Qj
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 11:12:51 -0400
Received: by mail-ua1-x943.google.com with SMTP id
 a1e0cc1a2514c-956995b5bb6so232459241.3
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776438769; x=1777043569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=niViTiN4UUhKA/L5JTEVZM3cKnAYnN4iOAXv8j4cjzc=;
 b=NNyp+aMEklYNdPrVEjywKOVENEm2H/BvLD15CkPatZ2cslx6rrcwmTSY8xTO/CB8P4
 ELm54zNOTlyvj0jkaggYksVmZmR7rrVQKixddOWPfHPhqk0ZPN6GlYywOKh2Ld4KuJAI
 8gklpSsMj3cwGhpP03RYEREa8Rny/gg3m7/8Bi64QVXIrjvX3A3dMEjbeXLhL+fOWoTI
 UGH8I6ykzA3wn+tqB9Wp2dG7vt1+sb4dduu2GhN0uwYe/vB+Yqp8iOWveUXB1KkRqK57
 2WL7cITIxZbfq2fbe2EAi64tDO8oKF4ruZQoCvW/n+VpaoAbmiMagWROde1FHh/+EjE3
 PFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776438769; x=1777043569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=niViTiN4UUhKA/L5JTEVZM3cKnAYnN4iOAXv8j4cjzc=;
 b=hynoY402GPXYSnxzNBTNV3e9wxdvtEykiq+secreK6ZPzsUWNAmSH9xbvXZLmEO3HF
 2vYlJkclcPQYldXFVNTdZS1XuiGBJrL2x9+fU7CgTCRB9s1E8MeIZ1ZlO+FvlaUGXFrJ
 TWpg1B3dqLBG/MwC3lem79mYngYHYrDy7oxSoCchj4PpzvxT9HEd9ykZePrnJ2FUqq5a
 C0u8huXIA2KYZq+MoVMmYG7tRHBJ/gXcJ3tecA2D96EJtyN2vZJyxQQzcIaA5gUEhwHN
 LRos9EiNc+f0VtJvUwevrIRSGMNKMfUzBL2RL9xtxKyq+6C/wGKgLSYBF+G3qtUm/pvN
 sCtA==
X-Gm-Message-State: AOJu0YwqVQ7Prazia9xVvJp/dnEgosjne7Kc0SUYfnqeE+gHbNU4ZTF7
 1l0xKXt2WrGVxUIEoHN7o4T3wZlreZz3YfRurXd7PH3ZJRZTfeT9RsvB
X-Gm-Gg: AeBDieuAmYieWXXhrvxgiTaSOWuDDj7DTRPPVpIXpLEyHOWSDTvBv/QxW5oBLosUPdG
 nshXb08EUyPvXt8F1Rfy76vNy0BkFBtK/3+2li/xHzQ2QI7RlBdecgo20VARNJfoa26ngVdG10K
 PxC583ZK2e9nrF0b71sB9kkNcCgrifPr89YpreeE/TAojx6uNzbPMmx5cvXh29+fdl8i0GcVDMQ
 NexoYPu6Srs7s8zA0G2FhETEQNuhQjWA1tAxuzHhS0vVJEM3CiAh7c0CwbpNP5ch3An1eYJkXCb
 KEeAGabBI0gDj1zEjy6zy2rd2f+OuJjHdzJBnbUL7LZf007bFNqMRtHR9Bk+HB93rzxUjeajSJ5
 xIfj+6jf9xJoxtzwoAp+kFnLGT0WTcR4zRp2+rjwgjGa968jLJKTi4wGpsKfLpWmWFhpXgGDrSv
 JebM5bj44AFc7pxVIOKRt5JfjHcXuI4xUnAKtJAKs5hkZeFotbz5zzahA1vSlb3SibKN4+0N6Sc
 Mlu+sdACHDZ4uMynw==
X-Received: by 2002:a05:6102:5493:b0:5ff:cee8:660c with SMTP id
 ada2fe7eead31-616f88bac7fmr1642111137.31.1776438768640; 
 Fri, 17 Apr 2026 08:12:48 -0700 (PDT)
Received: from ZEVORN-PC.bbrouter ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-61747cb501asm788923137.7.2026.04.17.08.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 08:12:48 -0700 (PDT)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Chao Liu <chao.liu.zevorn@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Chao Liu <chao.liu@zevorn.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 5/5] docs/system/riscv: add documentation for k230 machine
Date: Fri, 17 Apr 2026 23:11:29 +0800
Message-ID: <3340676ead334e862b9eaf33297c87da158c0437.1776438369.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1776438369.git.chao.liu.zevorn@gmail.com>
References: <cover.1776438369.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::943;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-ua1-x943.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index b5b4acf6bd..d8d68cc123 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1776,6 +1776,7 @@ F: include/hw/riscv/xiangshan_kmh.h
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
2.53.0


