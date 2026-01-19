Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7EBCCF2DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 10:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhm9E-0003pl-Fu; Mon, 19 Jan 2026 05:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vhm8t-0003ce-Pq
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 05:05:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vhm8n-0005dj-Fm
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 05:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768817144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E9ezPTkuno68t073cbreQfsbOdVSPFPE3iqBuNyL/UU=;
 b=N5MY9R45otSwEYbWmPY6I+3bb5vTZqRnss6RbOjj3NbAFgpe3NQaxl8lyaxCyp/HCkjOmb
 qPHhNvrNo+gEe2pjZ3bUS48EYKVWq6uiAiGArPaNLkxI9+Oq98Yj2QDlxG8qQNpBJ8YEjC
 egM4uMgTWOo/P+SIafAh8xQrPU4Tby8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-cnTNDs30NzyuxWt4KBxP9Q-1; Mon,
 19 Jan 2026 05:05:41 -0500
X-MC-Unique: cnTNDs30NzyuxWt4KBxP9Q-1
X-Mimecast-MFC-AGG-ID: cnTNDs30NzyuxWt4KBxP9Q_1768817141
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E42E6180136B
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 10:05:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C9331955F67
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 10:05:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8239021E6933; Mon, 19 Jan 2026 11:05:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] Clean up ill-advised or unusual header guards
Date: Mon, 19 Jan 2026 11:05:35 +0100
Message-ID: <20260119100537.463312-4-armbru@redhat.com>
In-Reply-To: <20260119100537.463312-1-armbru@redhat.com>
References: <20260119100537.463312-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Leading underscores are ill-advised because such identifiers are
reserved.  Trailing underscores are merely ugly.  Strip both.

Our header guards commonly end in _H.  Normalize the exceptions.

Macros should be ALL_CAPS.  Normalize the exception.

Done with scripts/clean-header-guards.pl.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 backends/tpm/tpm_ioctl.h             | 7 ++++---
 bsd-user/bsd-proc.h                  | 6 +++---
 hw/net/igb_regs.h                    | 4 ++--
 include/exec/target_long.h           | 6 +++---
 include/exec/tb-flush.h              | 7 ++++---
 include/gdbstub/helpers.h            | 6 +++---
 include/gdbstub/syscalls.h           | 6 +++---
 include/hw/arm/raspberrypi-fw-defs.h | 7 +++----
 include/hw/arm/stm32l4x5_soc.h       | 4 ++--
 include/hw/gpio/pcf8574.h            | 6 +++---
 include/hw/virtio/vhost-user-gpio.h  | 6 +++---
 include/hw/virtio/vhost-user-scmi.h  | 6 +++---
 include/hw/xen/xen-pvh-common.h      | 4 ++--
 include/tcg/insn-start-words.h       | 6 +++---
 qga/cutils.h                         | 6 +++---
 15 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/backends/tpm/tpm_ioctl.h b/backends/tpm/tpm_ioctl.h
index ee2dd15d35..e1e858c4bc 100644
--- a/backends/tpm/tpm_ioctl.h
+++ b/backends/tpm/tpm_ioctl.h
@@ -5,8 +5,9 @@
  *
  * This file is licensed under the terms of the 3-clause BSD license
  */
-#ifndef _TPM_IOCTL_H_
-#define _TPM_IOCTL_H_
+
+#ifndef TPM_IOCTL_H
+#define TPM_IOCTL_H
 
 #if defined(__CYGWIN__)
 # define __USE_LINUX_IOCTL_DEFS
@@ -341,4 +342,4 @@ enum {
     CMD_LOCK_STORAGE,         /* 0x13 */
 };
 
-#endif /* _TPM_IOCTL_H_ */
+#endif /* TPM_IOCTL_H */
diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 8b1c2deea3..8b7bd492ba 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -17,8 +17,8 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef BSD_PROC_H_
-#define BSD_PROC_H_
+#ifndef BSD_PROC_H
+#define BSD_PROC_H
 
 #include <sys/resource.h>
 
@@ -411,4 +411,4 @@ static inline abi_long do_bsd_setpriority(abi_long which, abi_long who,
     return get_errno(setpriority(which, who, prio));
 }
 
-#endif /* !BSD_PROC_H_ */
+#endif /* BSD_PROC_H */
diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
index 4dc4c31da2..3b135feef2 100644
--- a/hw/net/igb_regs.h
+++ b/hw/net/igb_regs.h
@@ -4,8 +4,8 @@
  * drivers/net/ethernet/intel/igb
  */
 
-#ifndef HW_IGB_REGS_H_
-#define HW_IGB_REGS_H_
+#ifndef HW_IGB_REGS_H
+#define HW_IGB_REGS_H
 
 #include "e1000x_regs.h"
 
diff --git a/include/exec/target_long.h b/include/exec/target_long.h
index 3cd8e26a23..db335ebb0b 100644
--- a/include/exec/target_long.h
+++ b/include/exec/target_long.h
@@ -7,8 +7,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef _TARGET_LONG_H_
-#define _TARGET_LONG_H_
+#ifndef TARGET_LONG_H
+#define TARGET_LONG_H
 
 /*
  * Usually this should only be included via cpu-defs.h however for
@@ -41,4 +41,4 @@ typedef uint64_t target_ulong;
 #error TARGET_LONG_SIZE undefined
 #endif
 
-#endif /* _TARGET_LONG_H_ */
+#endif /* TARGET_LONG_H */
diff --git a/include/exec/tb-flush.h b/include/exec/tb-flush.h
index e971d4ba6d..76f51094e6 100644
--- a/include/exec/tb-flush.h
+++ b/include/exec/tb-flush.h
@@ -5,8 +5,9 @@
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
-#ifndef _TB_FLUSH_H_
-#define _TB_FLUSH_H_
+
+#ifndef TB_FLUSH_H
+#define TB_FLUSH_H
 
 /**
  * tb_flush__exclusive_or_serial()
@@ -35,4 +36,4 @@ void queue_tb_flush(CPUState *cs);
 
 void tcg_flush_jmp_cache(CPUState *cs);
 
-#endif /* _TB_FLUSH_H_ */
+#endif /* TB_FLUSH_H */
diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index 197592036b..806195458f 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -9,8 +9,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef _GDBSTUB_HELPERS_H_
-#define _GDBSTUB_HELPERS_H_
+#ifndef GDBSTUB_HELPERS_H
+#define GDBSTUB_HELPERS_H
 
 #include "qemu/bswap.h"
 #include "qemu/target-info.h"
@@ -115,4 +115,4 @@ static inline uint8_t *gdb_get_reg_ptr(GByteArray *buf, int len)
 #endif
 #endif /* COMPILING_PER_TARGET */
 
-#endif /* _GDBSTUB_HELPERS_H_ */
+#endif /* GDBSTUB_HELPERS_H */
diff --git a/include/gdbstub/syscalls.h b/include/gdbstub/syscalls.h
index d63228e96b..070b165b42 100644
--- a/include/gdbstub/syscalls.h
+++ b/include/gdbstub/syscalls.h
@@ -6,8 +6,8 @@
  * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
-#ifndef _SYSCALLS_H_
-#define _SYSCALLS_H_
+#ifndef SYSCALLS_H
+#define SYSCALLS_H
 
 /* For gdb file i/o remote protocol open flags. */
 #define GDB_O_RDONLY  0
@@ -119,4 +119,4 @@ void gdb_exit(int code);
  */
 void gdb_qemu_exit(int code);
 
-#endif /* _SYSCALLS_H_ */
+#endif /* SYSCALLS_H */
diff --git a/include/hw/arm/raspberrypi-fw-defs.h b/include/hw/arm/raspberrypi-fw-defs.h
index 60b8e5b451..906de53379 100644
--- a/include/hw/arm/raspberrypi-fw-defs.h
+++ b/include/hw/arm/raspberrypi-fw-defs.h
@@ -7,9 +7,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H_
-#define INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H_
-
+#ifndef INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H
+#define INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H
 
 enum rpi_firmware_property_tag {
     RPI_FWREQ_PROPERTY_END =                           0,
@@ -172,4 +171,4 @@ typedef struct rpi_firmware_prop_request {
     uint8_t payload[0];
 } rpi_firmware_prop_request_t;
 
-#endif /* INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H_ */
+#endif /* INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H */
diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_soc.h
index 9c3d662bca..cc61d582cb 100644
--- a/include/hw/arm/stm32l4x5_soc.h
+++ b/include/hw/arm/stm32l4x5_soc.h
@@ -21,8 +21,8 @@
  * https://www.st.com/en/microcontrollers-microprocessors/stm32l4x5/documentation.html
  */
 
-#ifndef HW_ARM_STM32L4x5_SOC_H
-#define HW_ARM_STM32L4x5_SOC_H
+#ifndef HW_ARM_STM32L4X5_SOC_H
+#define HW_ARM_STM32L4X5_SOC_H
 
 #include "system/memory.h"
 #include "hw/arm/armv7m.h"
diff --git a/include/hw/gpio/pcf8574.h b/include/hw/gpio/pcf8574.h
index 3291d7dbbc..9f46cf7167 100644
--- a/include/hw/gpio/pcf8574.h
+++ b/include/hw/gpio/pcf8574.h
@@ -7,9 +7,9 @@
  * Written by Dmitrii Sharikhin <d.sharikhin@yadro.com>
  */
 
-#ifndef _HW_GPIO_PCF8574
-#define _HW_GPIO_PCF8574
+#ifndef HW_GPIO_PCF8574_H
+#define HW_GPIO_PCF8574_H
 
 #define TYPE_PCF8574 "pcf8574"
 
-#endif /* _HW_GPIO_PCF8574 */
+#endif /* HW_GPIO_PCF8574_H */
diff --git a/include/hw/virtio/vhost-user-gpio.h b/include/hw/virtio/vhost-user-gpio.h
index 5814a8400a..4e50f45066 100644
--- a/include/hw/virtio/vhost-user-gpio.h
+++ b/include/hw/virtio/vhost-user-gpio.h
@@ -6,8 +6,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef _QEMU_VHOST_USER_GPIO_H
-#define _QEMU_VHOST_USER_GPIO_H
+#ifndef QEMU_VHOST_USER_GPIO_H
+#define QEMU_VHOST_USER_GPIO_H
 
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/vhost.h"
@@ -21,4 +21,4 @@ struct VHostUserGPIO {
     VHostUserBase parent_obj;
 };
 
-#endif /* _QEMU_VHOST_USER_GPIO_H */
+#endif /* QEMU_VHOST_USER_GPIO_H */
diff --git a/include/hw/virtio/vhost-user-scmi.h b/include/hw/virtio/vhost-user-scmi.h
index 30ab0d7ab7..47bdde17ca 100644
--- a/include/hw/virtio/vhost-user-scmi.h
+++ b/include/hw/virtio/vhost-user-scmi.h
@@ -6,8 +6,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef _QEMU_VHOST_USER_SCMI_H
-#define _QEMU_VHOST_USER_SCMI_H
+#ifndef QEMU_VHOST_USER_SCMI_H
+#define QEMU_VHOST_USER_SCMI_H
 
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/vhost.h"
@@ -28,4 +28,4 @@ struct VHostUserSCMI {
     bool started_vu;
 };
 
-#endif /* _QEMU_VHOST_USER_SCMI_H */
+#endif /* QEMU_VHOST_USER_SCMI_H */
diff --git a/include/hw/xen/xen-pvh-common.h b/include/hw/xen/xen-pvh-common.h
index 0ed07c5694..a1ec505518 100644
--- a/include/hw/xen/xen-pvh-common.h
+++ b/include/hw/xen/xen-pvh-common.h
@@ -6,8 +6,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef XEN_PVH_COMMON_H__
-#define XEN_PVH_COMMON_H__
+#ifndef XEN_PVH_COMMON_H
+#define XEN_PVH_COMMON_H
 
 #include "system/memory.h"
 #include "qom/object.h"
diff --git a/include/tcg/insn-start-words.h b/include/tcg/insn-start-words.h
index c52aec50a7..c2921c24bc 100644
--- a/include/tcg/insn-start-words.h
+++ b/include/tcg/insn-start-words.h
@@ -4,9 +4,9 @@
  * Copyright (c) 2008 Fabrice Bellard
  */
 
-#ifndef TCG_INSN_START_WORDS
-#define TCG_INSN_START_WORDS
+#ifndef TCG_INSN_START_WORDS_H
+#define TCG_INSN_START_WORDS_H
 
 #define INSN_START_WORDS 3
 
-#endif /* TCG_INSN_START_WORDS */
+#endif /* TCG_INSN_START_WORDS_H */
diff --git a/qga/cutils.h b/qga/cutils.h
index c1f2f4b17a..e6c73c8d83 100644
--- a/qga/cutils.h
+++ b/qga/cutils.h
@@ -1,6 +1,6 @@
-#ifndef CUTILS_H_
-#define CUTILS_H_
+#ifndef CUTILS_H
+#define CUTILS_H
 
 int qga_open_cloexec(const char *name, int flags, mode_t mode);
 
-#endif /* CUTILS_H_ */
+#endif /* CUTILS_H */
-- 
2.52.0


