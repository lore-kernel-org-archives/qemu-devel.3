Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A3BC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1PG-0007QA-L6; Thu, 09 Jul 2026 22:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1PF-0007P8-Bv
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:01 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1PD-0008MN-KD
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:01 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-8487088510aso431668b3a.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652158; x=1784256958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c0Rmm8H0ifNCPwKkY8jD4mT4Cr4tn33kFq/sJguVyx4=;
 b=OPQO1MqOsx3eAGTphN87PvyuzsmbuYNEMcgMC8Sm94kxrE3W85c86ntjHCziq2fNmD
 AD7DE586yYr/JKEsxAZKww1UPc+1KrPILIBKJane4+N+QJgTArmVCXJmaxF1Yi9cTMzh
 OnAP3ejqUcutvt0PAkqusrAJYCyOAyHQk/pHodfMJPvUGfrRcMZQFbMqfkuaWpjG8vMn
 gP1D8Rl6kENyKbayc8roObW6sUezL12avEasJxpbKjahb077MVw33BkHKMMqIlwnNKOH
 GJsjlCiU96kT0WOYC2Y7y6RKT0/+pB3g073ewz/htCqcqD+/4Xl718GGdlAzFRU+Hw9f
 7v2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652158; x=1784256958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c0Rmm8H0ifNCPwKkY8jD4mT4Cr4tn33kFq/sJguVyx4=;
 b=giDkdCnqBUpOCT3wSi8FFiWb1mUUshcud3fA1mgjpakqMolv6XOJqKn2798wlscwRi
 sxJfJkl4SZp7MAtYA5YGg9qeSN6xkzAYyWn+6zHrWxss8EOshouZwFvasL6+NAC4VW7k
 0CcqJMNO7hxHLPrp3cXJv3l70+gOhRe0pgSZmuxz/0HHJIqoSxJ3qIln+UoXn1AIHmWt
 1juhXjGYeSs5uWTiHfbc9jB4GfSCi+TQc+isjzka44xZHJ3hUyJhCzh9f70Cu4UHgoSj
 XOYPbUvzUhhvHIWb+nR/kGbRJp1mlhvNNSZ5uaFqGB3wV28ZueuRE4MEGtdvc9JhP8Cl
 fFgw==
X-Gm-Message-State: AOJu0YxAze7nbSzb14UcLZPWAjR63pv4PNL2Z3hqPTz//dsR9Dyr2hMY
 Ps73zv0ugBEV0btJu3xcakxVSsmHAdmUfX3FuaH9qQPum8OqWYkWw3HeSr4wMw==
X-Gm-Gg: AfdE7cndtk88Tl1uGh/jTgGvY9K3d05vz6ffHK9fHWkB9BhWrfQvNLVM1RVB554Ruuk
 9pL/nrxLWJPCuVHkBDyWiTXjkI/h7PuojNaTl9jGRNH6G8ccu/yCmiMovhIhxt7HVClpEOVUsPL
 ENXsFXvxAcfJI7Zk69Hbj9201AL1BfiSy8PnelQ0G+6uYcRcVgrEO7MYBAtf5M0XAd77PXXowk6
 iBu5jVPy/qXkWkzWPGhn8AopXPy75b5s3nQiGJZgml1RoA7pP0q/ZO17Rijc5NKVQBVsDyUncvy
 XDYbNH1PxivMAKePDaTmqsBRPxqxKCQGdJT9eHCsXoYEqnNypeUcvoaCcaMyUNY/CqEncudakNP
 GabsbRfCMDmPfBHcbAhWAZ7Hm8QUObpWQRjMibG0HEfZ2qmnXcMkMPE+O4YY+PCnRe5Y+YqqLR/
 V0AXiCQ3jSIuiaXaaxcQiozhCvBzp5eZ4=
X-Received: by 2002:a05:6a00:8f0b:b0:847:9e62:24b with SMTP id
 d2e1a72fcca58-84842fdf92cmr9038779b3a.9.1783652158171; 
 Thu, 09 Jul 2026 19:55:58 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:55:57 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/40] hw/riscv/riscv-iommu-sys.c: record fault on
 IOMMU-generated MSI write
Date: Fri, 10 Jul 2026 12:54:51 +1000
Message-ID: <20260710025525.1704417-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

The riscv-iommu spec requires that the IOMMU records its own generated
MSI write faults.

Fixes: 01c1caa9d1 ("hw/riscv/virt.c, riscv-iommu-sys.c: add MSIx support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3572
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20260629165954.1018123-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.h     |  1 +
 hw/riscv/riscv-iommu-sys.c | 16 +++++++++++++++-
 hw/riscv/riscv-iommu.c     |  3 +--
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index a778e86fb7..da70e8bfa8 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -103,6 +103,7 @@ void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
 void riscv_iommu_set_cap_igs(RISCVIOMMUState *s, riscv_iommu_igs_mode mode);
 void riscv_iommu_reset(RISCVIOMMUState *s);
 void riscv_iommu_notify(RISCVIOMMUState *s, int vec_type);
+void riscv_iommu_fault(RISCVIOMMUState *s, struct riscv_iommu_fq_record *ev);
 
 typedef struct RISCVIOMMUContext RISCVIOMMUContext;
 /* Device translation context state. */
diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
index bf87b0b4ea..3314adeed2 100644
--- a/hw/riscv/riscv-iommu-sys.c
+++ b/hw/riscv/riscv-iommu-sys.c
@@ -26,6 +26,7 @@
 #include "qemu/host-utils.h"
 #include "qemu/module.h"
 #include "qom/object.h"
+#include "target/riscv/cpu_bits.h"
 #include "trace.h"
 
 #include "riscv-iommu.h"
@@ -143,7 +144,20 @@ static void riscv_iommu_sysdev_send_MSI(RISCVIOMMUStateSys *s,
 
     address_space_stl_le(&address_space_memory, msi_addr,
                          msi_data, MEMTXATTRS_UNSPECIFIED, &result);
-    trace_riscv_iommu_sys_msi_sent(vector, msi_addr, msi_data, result);
+
+    if (result == MEMTX_OK) {
+        trace_riscv_iommu_sys_msi_sent(vector, msi_addr, msi_data, result);
+    } else {
+        /* Record an access fault error in the fault queue */
+        struct riscv_iommu_fq_record ev = { 0 };
+        RISCVIOMMUState *iommu = &s->iommu;
+
+        ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_CAUSE,
+                           RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT);
+        ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_TTYPE,
+                           RISCV_IOMMU_FQ_TTYPE_UADDR_WR);
+        riscv_iommu_fault(iommu, &ev);
+    }
 }
 
 static void riscv_iommu_sysdev_notify(RISCVIOMMUState *iommu,
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index c3f9f052ae..12f20fa4bd 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -118,8 +118,7 @@ void riscv_iommu_notify(RISCVIOMMUState *s, int vec_type)
     }
 }
 
-static void riscv_iommu_fault(RISCVIOMMUState *s,
-                              struct riscv_iommu_fq_record *ev)
+void riscv_iommu_fault(RISCVIOMMUState *s, struct riscv_iommu_fq_record *ev)
 {
     uint32_t ctrl = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQCSR);
     uint32_t head = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQH) & s->fq_mask;
-- 
2.54.0


