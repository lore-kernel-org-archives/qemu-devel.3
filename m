Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD3CFEFB4D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 12:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvxNn-0001hS-EV; Fri, 27 Feb 2026 07:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1vvxNk-0001h4-UC
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 07:55:48 -0500
Received: from mail-out-2a.itc.rwth-aachen.de ([2a00:8a60:1:e501::5:45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1vvxNi-0002pd-Kx
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 07:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=rwth-aachen.de; i=@rwth-aachen.de; q=dns/txt;
 s=20240516-RWTH; t=1772196946; x=1803732946;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=AMtj2m8SFP9tKZDf3hfhp7mknmV7iDCsUsY+oYzTsx0=;
 b=l7CqAdaoBmuHTZpQC4acCh2IcHBDRcqvk1SJmxFOuqjwhheGQGiFoVPv
 9E18rWl+RKFgPDIPbFHI7IGLhma6BTp2MKU00bPDupP1NYq9E614rNkkH
 py/1/LBUHbqXGrnW2jF+atjqmnmjZKeFecVKIErpd+dZsN81qSCXKEH4j
 VFet0pnhucx84PLDbjcdkby0G0KS0sWUbk8EJ5AZSGhC6ivN88Ih+1sHg
 g6O7e/KxdgjhbZsUd9otEOGw4Mhi0sHYJEYIQmXVYbUbhwsupKp52RdXv
 CfPyv7s9f5SUgeXOBgGRmmIskXxQB8vWQGX+Vnd6WZHA/V4tZuPyhkS/Y A==;
X-CSE-ConnectionGUID: 6Uzz5nkIRbacMT2WvhPL3A==
X-CSE-MsgGUID: mJ3rooWKRpODGQODQ6jlDw==
X-IPAS-Result: =?us-ascii?q?A2BnBgC4k6Fp/5oagoZaHgEBCxIMQIFFC4JXglsdAQGEO?=
 =?us-ascii?q?Kozh10PAQEBAQEBAQEBCAFRBAEBg3OBFAKNHyg3Bg4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBAQELAQEGAQEBAQEBBgWBIYYJU4ZbBiMECwFGECUCJgICRhAGDgWDA?=
 =?us-ascii?q?oJ0qAF/M4EBhHzaB4EfAQsJAQoBgQouiFQBgXCEBIR6gk+BSoFHdnaIHoJpB?=
 =?us-ascii?q?IMwh3QGixwJP4ECeCwBVRMNCgsHBWGBBQM1EioVMjwyHYEjPhczWBsHBYV8D?=
 =?us-ascii?q?4h0gT0EI0pJghwDCxgNSBEsNxQbQQFuB41uP4I0gQ+CaJcbr1YHgjiBZ6FyA?=
 =?us-ascii?q?TKXYJMLLodlkHOkWYQ9AgQCBAUCGIF+gX9xgzZSFwIPji0WHMk3dwI6AgcBC?=
 =?us-ascii?q?gEBAwmCOZARAYEcAQE?=
IronPort-Data: A9a23:soFiTa+iSZuofLKuAem4DrUDoX+TJUtcMsCJ2f8bNWPcYEJGY0x3z
 WYdDDqCO/bcMDP0e9kiOd7k9xsOu5CDytdrTAtu/3xEQiMRo6IpJzg4wmTYYnnOdJ2TFCqLy
 +1EN7Es+ehtFie0Si+Fa+an9T8nk/nUGtIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3Zhn/glaYDkpOs/jd8Ek146yr0N8llgVWic5j7Qe2e0Y9Ucp3yZGZdxPQXoRSF+imc
 OfPpJnR1n/Z5RokFuS+mb/9dEAQKpaKVeRZoiMLM0QKqkEqSh0ais7XBtJFAatko2nhc+RK9
 Tl4ncfYpTEBY/eQwrRNC3G0JAklVUFO0OevzXFSKqV/xWWeG5fn660G4E3boeT0984vaVyi+
 8D0JxhTUwKR2uS14YixQ+JJup4cMsnTGNg27yQIITHxVZ7KQLjZXLnK6M8dx211j4ZUAureI
 sMVLzZiBPjCS0QUZhFOU8p4xrnu3ySjG9FbgAv9Sa4f5mHJ0A13lrv3N9fTe9qFbchSmEuCr
 STc4Hj5RxgTP9ySz3yJ/xpAg8eWwnylANxDTezQGvhChX/I3GsUNz4sTXyXjsCepnfgWdZzN
 BlBksYphe1onKCxdfHlXxy8pXKsuh8aUsBXVeog52ml0qfI7hzfA2EVQjNFbPQitck/Xzts0
 UWG9/vwCDly9bGYV3+Z3rGTqzy0JG4SN2BqTSYAQBtD6dTlpow+phbOSN95F+iylNKdJN3r6
 yqVsCgzl/AI14sCkb+k4VCCij7qqpWhohMJ2zg7l1mNtmtRDLNJraT0gbQHxZ6s9Lqkc2Q=
IronPort-HdrOrdr: A9a23:nH/Snq1AWl1xZcZuoj4b7gqjBIMkLtp133Aq2lEZdPRUGvbo8/
 xG+8576faUslgssR4b9OxoVJPrfZqYz+8W3WBzB9iftWvd2FdARbsKheDfKn/bak7DH4ZmpM
 FdmsNFZOEYY2IK6PoTt2KDYq4dKaG8gceVbLDlvg5QcT0=
X-Talos-CUID: 9a23:67m1EWPn3pIwme5DBhR15hMSGeEfeHTW6UuKHFG4MUIyYejA
X-Talos-MUID: 9a23:uY447Qri/eD6SedhUtoezzRAb91v5JuNMlgqvbo/nOW9ay50FyjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,314,1763420400"; d="scan'208";a="177606919"
Received: from rwthex-s2-a.rwth-ad.de ([134.130.26.154])
 by mail-in-2a.itc.rwth-aachen.de with ESMTP; 27 Feb 2026 13:55:40 +0100
Received: from mkroening-air.local (134.99.235.10) by rwthex-s2-a.rwth-ad.de
 (2a00:8a60:1:e500::26:154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 13:55:40 +0100
Date: Fri, 27 Feb 2026 13:54:30 +0100
Subject: [PATCH v2 1/3] include/hw/core: Rename virtio_is_big_endian to
 internal_is_big_endian
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260227-semihosting-cpu-tswap-v2-1-cbdcdf39dd15@eonerc.rwth-aachen.de>
References: <20260227-semihosting-cpu-tswap-v2-0-cbdcdf39dd15@eonerc.rwth-aachen.de>
In-Reply-To: <20260227-semihosting-cpu-tswap-v2-0-cbdcdf39dd15@eonerc.rwth-aachen.de>
To: <qemu-devel@nongnu.org>
CC: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, =?utf-8?q?Martin_Kr=C3=B6ning?=
 <martin.kroening@eonerc.rwth-aachen.de>
X-Mailer: b4 0.14.3
X-Originating-IP: [134.99.235.10]
X-ClientProxiedBy: rwthex-s1-a.rwth-ad.de (2a00:8a60:1:e500::26:152) To
 rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154)
Received-SPF: pass client-ip=2a00:8a60:1:e501::5:45;
 envelope-from=martin.kroening@eonerc.rwth-aachen.de;
 helo=mail-out-2a.itc.rwth-aachen.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  =?utf-8?q?Martin_Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>
From:  =?utf-8?q?Martin_Kr=C3=B6ning?= via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

These functions are needed to do semihosting on CPUs that support
runtime-configurable endiannes. This commit renames them and allows
using them for semihosting, but makes sure to signal that these
functions should not be used in other circumstances.

Signed-off-by: Martin Kröning <martin.kroening@eonerc.rwth-aachen.de>
---
 hw/core/cpu-system.c             | 6 +++---
 hw/virtio/virtio.c               | 2 +-
 include/hw/core/cpu.h            | 4 ++--
 include/hw/core/sysemu-cpu-ops.h | 6 +++---
 target/arm/cpu.c                 | 4 ++--
 target/ppc/cpu_init.c            | 2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 4a91c3e8ec..273b9b7c22 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -127,10 +127,10 @@ int cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
     return (*cpu->cc->sysemu_ops->write_elf64_note)(f, cpu, cpuid, opaque);
 }
 
-bool cpu_virtio_is_big_endian(CPUState *cpu)
+bool cpu_internal_is_big_endian(CPUState *cpu)
 {
-    if (cpu->cc->sysemu_ops->virtio_is_big_endian) {
-        return cpu->cc->sysemu_ops->virtio_is_big_endian(cpu);
+    if (cpu->cc->sysemu_ops->internal_is_big_endian) {
+        return cpu->cc->sysemu_ops->internal_is_big_endian(cpu);
     }
     return target_big_endian();
 }
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e9d5532952..f6454971ab 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2317,7 +2317,7 @@ static enum virtio_device_endian virtio_default_endian(void)
 
 static enum virtio_device_endian virtio_current_cpu_endian(void)
 {
-    if (cpu_virtio_is_big_endian(current_cpu)) {
+    if (cpu_internal_is_big_endian(current_cpu)) {
         return VIRTIO_DEVICE_ENDIAN_BIG;
     } else {
         return VIRTIO_DEVICE_ENDIAN_LITTLE;
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 7d2f4459d2..04e1f970ca 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -782,13 +782,13 @@ hwaddr cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs);
 
 /**
- * cpu_virtio_is_big_endian:
+ * cpu_internal_is_big_endian:
  * @cpu: CPU
 
  * Returns %true if a CPU which supports runtime configurable endianness
  * is currently big-endian.
  */
-bool cpu_virtio_is_big_endian(CPUState *cpu);
+bool cpu_internal_is_big_endian(CPUState *cpu);
 
 /**
  * cpu_has_work:
diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 877892373f..7b2d2d2610 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -77,13 +77,13 @@ typedef struct SysemuCPUOps {
     int (*write_elf64_qemunote)(WriteCoreDumpFunction f, CPUState *cpu,
                                 DumpState *s);
     /**
-     * @virtio_is_big_endian: Callback to return %true if a CPU which supports
+     * @internal_is_big_endian: Callback to return %true if a CPU which supports
      * runtime configurable endianness is currently big-endian.
      * Non-configurable CPUs can use the default implementation of this method.
      * This method should not be used by any callers other than the pre-1.0
-     * virtio devices.
+     * virtio devices and the semihosting interface.
      */
-    bool (*virtio_is_big_endian)(CPUState *cpu);
+    bool (*internal_is_big_endian)(CPUState *cpu);
 
     /**
      * @legacy_vmsd: Legacy state for migration.
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7e3e84b4bb..98d09ac065 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -756,7 +756,7 @@ static void arm_cpu_set_irq(void *opaque, int irq, int level)
     }
 }
 
-static bool arm_cpu_virtio_is_big_endian(CPUState *cs)
+static bool arm_cpu_internal_is_big_endian(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
@@ -2299,7 +2299,7 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
     .asidx_from_attrs = arm_asidx_from_attrs,
     .write_elf32_note = arm_cpu_write_elf32_note,
     .write_elf64_note = arm_cpu_write_elf64_note,
-    .virtio_is_big_endian = arm_cpu_virtio_is_big_endian,
+    .internal_is_big_endian = arm_cpu_internal_is_big_endian,
     .legacy_vmsd = &vmstate_arm_cpu,
 };
 #endif
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 3d932a5642..191f5726f6 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7480,7 +7480,7 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
     .get_phys_page_debug = ppc_cpu_get_phys_page_debug,
     .write_elf32_note = ppc32_cpu_write_elf32_note,
     .write_elf64_note = ppc64_cpu_write_elf64_note,
-    .virtio_is_big_endian = ppc_cpu_is_big_endian,
+    .internal_is_big_endian = ppc_cpu_is_big_endian,
     .legacy_vmsd = &vmstate_ppc_cpu,
 };
 #endif

-- 
Git-155)


