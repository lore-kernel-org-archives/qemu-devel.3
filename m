Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CA91125851
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0MQ7-000401-Rm; Wed, 11 Mar 2026 12:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1w0MPt-0003Wx-S3
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:28:14 -0400
Received: from mail-out-3.itc.rwth-aachen.de ([2a00:8a60:1:e501::5:48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1w0MPp-0006R0-43
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=rwth-aachen.de; i=@rwth-aachen.de; q=dns/txt;
 s=20240516-RWTH; t=1773246489; x=1804782489;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=5SUlJtXBHyC2/mLKaRQMFjkp5YbpgrsvJ2WefT8MClk=;
 b=FDkXUwVssWEZisn5iTyfFC4B31mcK+SkteKjqpTaMSq01+ihHBcCI6TC
 hRSMTfox3N6mS60DbzhJm9gNYqQCwvXGAmLB36TJ72/vRJ/8a1j3MeEii
 CxLDiiWcB8GWIpSrpD8Gi7fRBN231E/0r0kgfFtoCTTz5KqOCzyvkZtON
 cM7gtwOFPIfpMUSvIQCS/j5V0G1DVOAOQ8845pHeq3G8fRxiPJJhvCBnE
 s+2g1t4v1W/3gydLsrPnAg2kPoh/r+Tb19MM4lblh8bRYhpoFsNk0EegH
 BidyvrgSzK6rrbsGwusY/hkIv3y43u1lyNf0/q6QPujbjtOb5rOvmA/rq Q==;
X-CSE-ConnectionGUID: 0WnGgY9cQFS4XSuzOkxP/Q==
X-CSE-MsgGUID: DuWgytu0S+2s23Z5XI/WDQ==
X-IPAS-Result: =?us-ascii?q?A2C6BwD+lrFp/5oagoZaHgEBCxIMQIQnglsdAQGEOKozh?=
 =?us-ascii?q?10PAQEBAQEBAQEBCAFRBAEBg3OBFAKNIig4EwECBAEBAQEDAgMBAQEBAQEBA?=
 =?us-ascii?q?QEBAQsBAQYBAQEBAQEGBYEhhglThlsGIwQLAUYQJQImAgJGEAYOBYMCgnSxA?=
 =?us-ascii?q?n8zgQGEfNoHgR8BCwkBCgGBCi6IVAGBcIQEhHqCT4FKgUd2dogegmkEgzCHP?=
 =?us-ascii?q?gaLXwk/gQJ4LAFVEw0KCwcFYYEFAzUSKhUyPDIdgSM+FzNYGwcFhR4PiHCBO?=
 =?us-ascii?q?wQjgRGDKQMLGA1IESw3FBtBAW4HjXU9gjSBD4I/KZcbr1YHgjiBZ6FyATKXY?=
 =?us-ascii?q?JMLLodlkHOkWYQ9AgQCBAUCGIF/gX5xgzZSFwIPji0WHMwBdwI6AgcBCgEBA?=
 =?us-ascii?q?wmCOZARAYEcAQE?=
IronPort-Data: A9a23:OOeNxK1K5rY3E2aD4/bD5fJwkn2cJEfYwER7XKvMYLTBsI5bpzcCy
 2YaXGHTPqyLZGDxKdEladnn9kJT7MCAydZnQAM93Hw8FHgiRegppDi6BhqqY3nCfpWroGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9j8kif3gqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvU0
 T/Ji5OZYgTNNwJcaDpOtfrY8Uo35ZwehRtB1rAATaET1LPhvyRNZH4vDfnZB2f1RIBSAtm7S
 47rpJml/nnU9gsaEdislLD2aCUiGtY+6iDX1xK684D76vRzjnRaPpQTbZLwWm8L49m9pO2d/
 f0W3XCGYVpzYvecyLx1vy5wSEmSNYUekFPOzOPWXca7lyUqeFO0qxli4d1f0YAwoo5K7W9yG
 fMwcA8LQR+y1umP7onnetJxlOMgPPGsBdZK0p1g5Wmx4fcOW4/fQ6jaoMQCmT52nN9SHbPXa
 4wVZFKDbjyZOEEJYwxPTshg2r712hETcBUBwL6Rja8++XTSykpyyr/gNtvTdfSHQsNYhE3ev
 H3a/yHwCxoaOdrZxTftHneE3baRwXKlCN9KfFG+3tJ3v1KC2nFLM15MTgHgk6SJqwmBd+sKf
 iT4/QJr98De7neDR93wT1uyrXiCsxM0X9tWGvc9rgaXxcL8+waYAm0IZjpAbtU8s4kxXzNC/
 keEg97zQzlmobGYTXa18raSpCm1fy8PIgcqfCIBUE4J7sfupKk1iRTASMslF7S65uAZAhnq3
 CyKoTh7nO9WhIgRyLm7uFnLxT6hznTUcjMICszsdjrNxmtEiESNPuRENXCzAS58Ebuk
IronPort-HdrOrdr: A9a23:ZfkSa64p5ZjR4T8ZdAPXwMvXdLJyesId70hD6qkRc3xom6mj/K
 qTdZsguCMc9wxhPU3I9ertBIClYVfxsaFY2rMwG5DKZniEhILLFvAB0WKK+VSJJ8SZzIBgPM
 xbEpSWZueeMbFyt7ef3DWF
X-Talos-CUID: =?us-ascii?q?9a23=3A55qUlGkiWK7yxfMEvYA6FHQRRjnXOSXiyljfEh6?=
 =?us-ascii?q?zMEhSFI2uVE23+7Nc1PM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ANNVTbw6GJ7mYTeJ3SHHufxoAxoxE/puhGVwQya5?=
 =?us-ascii?q?F4dLebh4tCxbasxiOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; d="scan'208";a="316496850"
Received: from rwthex-s2-a.rwth-ad.de ([134.130.26.154])
 by mail-in-3.itc.rwth-aachen.de with ESMTP; 11 Mar 2026 17:28:02 +0100
Received: from mkroening-air.local (137.226.124.87) by rwthex-s2-a.rwth-ad.de
 (2a00:8a60:1:e500::26:154) with Microsoft SMTP Server
 (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 11 Mar
 2026 17:28:02 +0100
Date: Wed, 11 Mar 2026 17:27:14 +0100
Subject: [PATCH v3 1/3] include/hw/core: Rename virtio_is_big_endian to
 internal_is_big_endian
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260311-semihosting-cpu-tswap-v3-1-8e239575ec08@eonerc.rwth-aachen.de>
References: <20260311-semihosting-cpu-tswap-v3-0-8e239575ec08@eonerc.rwth-aachen.de>
In-Reply-To: <20260311-semihosting-cpu-tswap-v3-0-8e239575ec08@eonerc.rwth-aachen.de>
To: <qemu-devel@nongnu.org>
CC: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, =?utf-8?q?Martin_Kr=C3=B6ning?=
 <martin.kroening@eonerc.rwth-aachen.de>
X-Mailer: b4 0.14.3
X-Originating-IP: [137.226.124.87]
X-ClientProxiedBy: rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154) To
 rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154)
Received-SPF: pass client-ip=2a00:8a60:1:e501::5:48;
 envelope-from=martin.kroening@eonerc.rwth-aachen.de;
 helo=mail-out-3.itc.rwth-aachen.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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
Reply-to:  =?utf-8?q?Martin_Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>
From:  =?utf-8?q?Martin_Kr=C3=B6ning?= via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

These functions are needed to do semihosting on CPUs that support
runtime-configurable endiannes. This commit renames them and allows
using them for semihosting, but makes sure to signal that these
functions should not be used in other circumstances.

Signed-off-by: Martin Kröning <martin.kroening@eonerc.rwth-aachen.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
index 0ba734d0bc..8fcf6cfd0b 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2323,7 +2323,7 @@ static enum virtio_device_endian virtio_default_endian(void)
 
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


