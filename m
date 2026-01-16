Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD743D489A3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 12:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgjPh-0003i0-8Q; Fri, 16 Jan 2026 07:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgjPV-0003fj-ON
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:58:41 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgjPU-0000AM-04
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:58:41 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47ee3da7447so11849955e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 04:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768568317; x=1769173117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+RqHQeniNxEgx1KoTf/hdjWw4joxNDfaDyoWRJZKuw=;
 b=blX0J7kusfGAaXNhI6HW7qmsNN/Wyq8Pp3rOQRBVZ2lE7PBkdHNOx5U7UWkCc8H9cW
 YxeWNFZpyAeC9Gch5Itqs3wD5z0DcHRWKbGeDaFXZ0FenEjQF4i69PHd8k9CbXJjPWW2
 ghuspBXYTBIIuw4Mh9w4GzkM817is/0du8erIGUZnUncovY6jfaVhPzpD35/lXINkJax
 2DH6BNQdSIZ1Hshkbsu1UCMmcFz87xAPyazFcIP3xrJgRTbCWANNlPeeBb+IX0FTw4PR
 CsGoFOOPAsRqJpfVLfPb3YHdzvNGkuufsECSokspMmgD4pj6i5+1C0KKTw4P9rdO1UxV
 7gCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768568317; x=1769173117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h+RqHQeniNxEgx1KoTf/hdjWw4joxNDfaDyoWRJZKuw=;
 b=iRQFWJYSyByoCn1BNw8YLZyyuOzlaoaZ0AQYqxULuGIGCyYMvv2nltLayjQOCOy/Tg
 x541LGJ5TiHCk+gCjY/EEWyf5DNVx++y1rrLOdLExrJWIjYyMmuo60eADGuT0jO9QbSp
 V2jMIwU6i0AAULM0ZlSH4EqKZJRU63ofIzP+qEV9IQo2CZui2OVu62VvICdGpblSORLE
 hNcEQ69uhBVuviHUYI3L+SoTFKT4BeUDHf++wMkH7+uY6jDRvLSiaLyXrX9kq7dQ7p21
 fv5xYNP561mXycon86RqjgIHc4S0mNJfIx39UliT5SPJEI6UzE4R4xwf8wpkDvi4n1Da
 brtA==
X-Gm-Message-State: AOJu0Yyk5dUTTzimIKQ4gP+cJ34geEznnffAvc2vhPu+7R+eNZuXQrTW
 16wkSivSWWFCOwiKAkHxGZh8bDC248tzmOLpxz1eWS5UkGT7BqK8KiQ7PbeO9LaQ5r5oKEOIAwQ
 S5xub
X-Gm-Gg: AY/fxX4qhUN1V/jtVYw2DyTPYYElhitgMOVQX0O88asnGC6XJSSymuBGU6NNi1BscjE
 b+2YYsRy3QWxnXcjY8UwufDQBrKJ5Q+q6avMb7AMpre52AajNCk1n26EVMbcHE1eg+v8o6filSy
 1Yq0/SxrjwtGYVQoQ0pG2J8WwQMCRrrjrWFsi2RWlS8xay03nL9yqf0iEoTsdVhS8sPudp4lJm8
 uNdINDLrX5Awr04DriPUMnqOmYhS56oCQvwMnpmhiJCKCnlvAXzm+i9yRtWMV7TXGjXtCqBSrzN
 zU+tp1+fyhnV2uoshrvxFJPb3Aqued/DdvbVj1+SLr/OAyDRAleu7tVAFrQghMsqKGpsbCxvTZ1
 xx75S08J7QJM30cx2MAMFtylEJAoUaN0d7K6qNY5TJNJ2UOrYjK/KorYskRkNunclbjzksxx0Mn
 onbCPQ3Tv5pdshG/ynJgCFj+5j28xez789kPMpdAadp5ImpzHEB3FWYtakN8nyBgwK8isKYz6Zw
 a0UFDoYo64UQcxGJVBxS6UxwMHlOUIKxiSL6cD1iaIArA==
X-Received: by 2002:a05:600c:4e43:b0:477:c71:1fc1 with SMTP id
 5b1f17b1804b1-4801e3342eemr35605065e9.19.1768568316715; 
 Fri, 16 Jan 2026 04:58:36 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe67780sm15387565e9.16.2026.01.16.04.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 04:58:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 4/4] all: Clean up includes
Date: Fri, 16 Jan 2026 12:58:30 +0000
Message-ID: <20260116125830.926296-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116125830.926296-1-peter.maydell@linaro.org>
References: <20260116125830.926296-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This commit was created with scripts/clean-includes:
 ./scripts/clean-includes '--git' 'all' '--all'

and manually edited to remove one change to hw/virtio/cbor-helpers.c.
All these changes are header files that include osdep.h or some
system header that osdep.h pulls in; they don't need to do this.

All .c should include qemu/osdep.h first.  The script performs three
related cleanups:

* Ensure .c files include qemu/osdep.h first.
* Including it in a .h is redundant, since the .c  already includes
  it.  Drop such inclusions.
* Likewise, including headers qemu/osdep.h includes is redundant.
  Drop these, too.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/scsi/lasi_ncr710.h          | 1 -
 hw/scsi/ncr53c710.h            | 1 -
 include/hw/core/loader.h       | 1 -
 include/hw/i386/tdvf.h         | 1 -
 include/hw/ppc/spapr_fadump.h  | 1 -
 include/hw/riscv/iommu.h       | 1 -
 include/system/accel-irq.h     | 1 -
 linux-user/alpha/target_proc.h | 1 -
 qga/commands-windows-ssh.h     | 1 -
 qga/vss-win32/vss-debug.h      | 1 -
 target/i386/kvm/vmsr_energy.h  | 2 --
 11 files changed, 12 deletions(-)

diff --git a/hw/scsi/lasi_ncr710.h b/hw/scsi/lasi_ncr710.h
index 99be001fc3..450fb7e1c3 100644
--- a/hw/scsi/lasi_ncr710.h
+++ b/hw/scsi/lasi_ncr710.h
@@ -15,7 +15,6 @@
 #define HW_LASI_NCR710_H
 
 #include "hw/core/sysbus.h"
-#include "qemu/osdep.h"
 #include "exec/memattrs.h"
 #include "hw/scsi/scsi.h"
 #include "hw/scsi/ncr53c710.h"
diff --git a/hw/scsi/ncr53c710.h b/hw/scsi/ncr53c710.h
index a8dc92f4ef..00b6a01577 100644
--- a/hw/scsi/ncr53c710.h
+++ b/hw/scsi/ncr53c710.h
@@ -15,7 +15,6 @@
 #ifndef HW_NCR53C710_H
 #define HW_NCR53C710_H
 
-#include "qemu/osdep.h"
 #include "hw/core/sysbus.h"
 #include "hw/scsi/scsi.h"
 #include "qemu/fifo8.h"
diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
index 6f91703503..4abd55a64b 100644
--- a/include/hw/core/loader.h
+++ b/include/hw/core/loader.h
@@ -1,7 +1,6 @@
 #ifndef LOADER_H
 #define LOADER_H
 #include "hw/nvram/fw_cfg.h"
-#include "qemu/typedefs.h"
 
 /* loader.c */
 /**
diff --git a/include/hw/i386/tdvf.h b/include/hw/i386/tdvf.h
index e75c8d1acc..4d7362ad65 100644
--- a/include/hw/i386/tdvf.h
+++ b/include/hw/i386/tdvf.h
@@ -9,7 +9,6 @@
 #ifndef HW_I386_TDVF_H
 #define HW_I386_TDVF_H
 
-#include "qemu/osdep.h"
 
 #define TDVF_SECTION_TYPE_BFV               0
 #define TDVF_SECTION_TYPE_CFV               1
diff --git a/include/hw/ppc/spapr_fadump.h b/include/hw/ppc/spapr_fadump.h
index fde2830e94..82681fb9a6 100644
--- a/include/hw/ppc/spapr_fadump.h
+++ b/include/hw/ppc/spapr_fadump.h
@@ -6,7 +6,6 @@
 #ifndef PPC_SPAPR_FADUMP_H
 #define PPC_SPAPR_FADUMP_H
 
-#include "qemu/osdep.h"
 #include "cpu.h"
 
 /* Fadump commands */
diff --git a/include/hw/riscv/iommu.h b/include/hw/riscv/iommu.h
index 25f1a8b159..999384fc89 100644
--- a/include/hw/riscv/iommu.h
+++ b/include/hw/riscv/iommu.h
@@ -19,7 +19,6 @@
 #ifndef HW_RISCV_IOMMU_H
 #define HW_RISCV_IOMMU_H
 
-#include "qemu/osdep.h"
 #include "qom/object.h"
 
 #define TYPE_RISCV_IOMMU "riscv-iommu"
diff --git a/include/system/accel-irq.h b/include/system/accel-irq.h
index 671fb7dfdb..a2caa06f54 100644
--- a/include/system/accel-irq.h
+++ b/include/system/accel-irq.h
@@ -12,7 +12,6 @@
 #ifndef SYSTEM_ACCEL_IRQ_H
 #define SYSTEM_ACCEL_IRQ_H
 #include "hw/pci/msi.h"
-#include "qemu/osdep.h"
 #include "system/kvm.h"
 #include "system/mshv.h"
 
diff --git a/linux-user/alpha/target_proc.h b/linux-user/alpha/target_proc.h
index 6b491ffa3a..71949d380d 100644
--- a/linux-user/alpha/target_proc.h
+++ b/linux-user/alpha/target_proc.h
@@ -6,7 +6,6 @@
 #ifndef ALPHA_TARGET_PROC_H
 #define ALPHA_TARGET_PROC_H
 
-#include "qemu/osdep.h"
 #include "target/alpha/cpu.h"
 
 static uint8_t alpha_phys_addr_space_bits(CPUAlphaState *env)
diff --git a/qga/commands-windows-ssh.h b/qga/commands-windows-ssh.h
index 40ac67c4d9..c35d945a89 100644
--- a/qga/commands-windows-ssh.h
+++ b/qga/commands-windows-ssh.h
@@ -11,7 +11,6 @@
  */
 
 #include <glib/gstrfuncs.h>
-#include <stdbool.h>
 typedef struct WindowsUserInfo {
     char *sshDirectory;
     char *authorizedKeyFile;
diff --git a/qga/vss-win32/vss-debug.h b/qga/vss-win32/vss-debug.h
index 7800457392..506cee6698 100644
--- a/qga/vss-win32/vss-debug.h
+++ b/qga/vss-win32/vss-debug.h
@@ -10,7 +10,6 @@
  * See the COPYING file in the top-level directory.
  */
 
-#include "qemu/osdep.h"
 #include <vss-handles.h>
 
 #ifndef VSS_DEBUG_H
diff --git a/target/i386/kvm/vmsr_energy.h b/target/i386/kvm/vmsr_energy.h
index 151bcbd642..415d64f51c 100644
--- a/target/i386/kvm/vmsr_energy.h
+++ b/target/i386/kvm/vmsr_energy.h
@@ -14,8 +14,6 @@
 #ifndef VMSR_ENERGY_H
 #define VMSR_ENERGY_H
 
-#include <stdint.h>
-#include "qemu/osdep.h"
 #include "io/channel-socket.h"
 #include "hw/i386/topology.h"
 
-- 
2.47.3


