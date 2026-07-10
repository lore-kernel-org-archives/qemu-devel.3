Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F741C4450B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAEb-0006V2-QG; Fri, 10 Jul 2026 08:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi6ml-0000Y2-9S
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 04:40:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi6mg-0001rX-Ci
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 04:40:39 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A7dW2E235369
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 08:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7u2Voyzruce
 aNtDJJe1B506UztsOTzRZXv5pWRhnX2U=; b=dn3n1xhydT1Li+e52/k26Prgzd5
 H5C6R8PxpZiFpQ/KvyMVeuY6/2VUZq9HHv8PVlgv52Z/2I9g84enMcLCvwLvOhmq
 aESNyceEA8j44HUyUn2t7YtBiJc7CqGnYKjF7ALeR78XulM0ClzlNGe6yG8i0mGB
 VHoxl2qUrNjHtYgHjvCGtgiBXdlevB59Vo1cWJGDjOZYbl8PoN2X/p6tvVnPTyBd
 tiOCWAKnhZ02Psk7RYYPWWbEyyIzPEcqfAB98DQASD4fzKB+5N3R2RbCpdRSqw/S
 KqoTJaoqrGbTOcIbDhAm2udHHx+rzZ0/irVpqqOph5MsXx69+JmDSA999sw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg3km5f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 08:40:22 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-384d033f7f5so191805a91.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 01:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783672822; x=1784277622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7u2VoyzruceaNtDJJe1B506UztsOTzRZXv5pWRhnX2U=;
 b=MQ3CzVrec1ZUOJfariw+ClUQKuKbhG5NHuCO+sogM2cHqw5Q8md4UDthzqWn3hQcts
 26qvut1Hl2qM2YurtkCLDGb97zlqV+8TlzdKHuZBYScC/oQFnBX1Me10fy7KzmHnvy6s
 HpAhL2uZl5g37btqEHJA4YMh6wNG+eA6Fpp/CyUs1yuwaFVHkYpe/XEP5ZdkMNA2M50P
 hGJm7N7cr5Tq+TyvPywgyYuvHL8SASNIPh1fvzX6Furv1npnpfaqQ4qkS98jM5oIgu7N
 35w2dcIpXEzjHIcIHBnuC2PhCEp7muAfujyghsws4fqNTZjgjNbCkoh2iIiUsoj5BL00
 7xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783672822; x=1784277622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7u2VoyzruceaNtDJJe1B506UztsOTzRZXv5pWRhnX2U=;
 b=fiIyaxlr2z8aE/A56jHr6S475pIxtZRaUetNR71EysaVqeSZlBdncjXVzr71aMG1Fc
 JElw2OHbFVxOmzjskRwleMtwRbHfg8j4pD4R3yMdPtzmJ4DY36d07rN8cA8J+x+DKmth
 bGENsrDGZnbnuzj3SBWegXqywW6OMb16FjCsa2As4FQQl122n19UeL+IxNFIqHdFBZdL
 COgQwjgZ1YDmP5kKIm9OBx36MRgW3Tk9Tcz9vFB4QUU43/GK90Nq1uY8fmW1x0j59357
 v3bse0a/N/E0J6kY+Q2rAPfKzPUng0jCfR+6b9HZKu0cuECHe7Vzr2RHzGdn7AU28J/0
 Wj4w==
X-Gm-Message-State: AOJu0YyfX0EaRHJVgTM9uVZljCvO6i+SxakE/RN8nX+savo/cwqOERHY
 oM1LfVGtfh/cBS4oLAvhXLLwbNh5JaKhgqh5ykWp879G2/Cstnt0/37xPEqORuDOf6CGFsibB78
 Nr9D/+mm8uWUpnFhY6iB81dJ98cAUdqsGQWOa+qAaOwJWO9dPgX5iONMDLmNEhahMqg==
X-Gm-Gg: AfdE7cl6LgKd5/uvdkkhuz8afJvy1mApI/rwYNPNZmwugNJ6rlEXlLQF9W8MB970Mwh
 2Su5OQZ/zE22yuF4fUQsl2QyCUUj1X6SalJfu+ZIDP0UQp3MfX/MokMMAthypXHPTr/xU0wXepT
 FqIdIbOaVszP6sq8TcJ4sqDGaI45s95gX2GDY7KHprEYeTmucj3wh3tV4NNFlmPOOuQZHlT/XPO
 Mkw02ZuxUM1KplzbI4aPipaZtTpfI/JUVXeOK4XUjLZkeCMgqGwOXCee/NPhjJe7hSblANI+jiC
 eJnuITyEZO8GmU8OJjmcFmpegeemzfapeS8HbU0YSij76Y6pp+3xEj4cIAd/A+IRH/8+/ftDcNt
 qi2UchJmiI5vmJvJdrCspDs4hYJVMgr/UQngkqgx8VgIP/7l+map/Ppe4nPnR7gy3nIqvHtZIso
 X2WAf4edZlHzCbl7HtgvNlGu2A2en5IkDv/3HXDWbnPw==
X-Received: by 2002:a17:90b:3fc8:b0:37f:df57:2ddf with SMTP id
 98e67ed59e1d1-3893f97f9acmr8979943a91.1.1783672821623; 
 Fri, 10 Jul 2026 01:40:21 -0700 (PDT)
X-Received: by 2002:a17:90b:3fc8:b0:37f:df57:2ddf with SMTP id
 98e67ed59e1d1-3893f97f9acmr8979916a91.1.1783672821037; 
 Fri, 10 Jul 2026 01:40:21 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118389d9bcsm29164925eec.20.2026.07.10.01.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 01:40:20 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, daniel.barboza@oss.qualcomm.com,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Subject: [PATCH v2 02/10] hw/misc: add RISC-V RPMI transport and Base support
Date: Fri, 10 Jul 2026 14:09:44 +0530
Message-ID: <37eeb3754b10d5310c62169e72211c65114e21bc.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
References: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA4MyBTYWx0ZWRfX8Q0Ro+0JIgNN
 swu9cfV6WeC4lwwzLv7DSsdhVeRNMXn/lGtmSlONnS76iQUofgNRI+UnZUnDb7GzauGs4MHGNTm
 bUDHf/tuLKoi5SM4QCL7XHuIFSO+V91C3lat5VwfL1jmVz93iPxMaF3HgIKFNSgEIcsyl8HGdl9
 KdpIkOk55xQCUJ4T5Bm32C8UhbuR2zoXbCv5EBOt2xFINtuNO666MM0qa1IBGlfGovHS999oMgE
 Jm6SQJ6aMNpoKWYTiGGctwxtU+8tP9rbwzyLp9zBzX6SK9dpPb5gR+TwReJWpbMLNS7+VNA+sFG
 TvguzkT5ANNgOPKytUyLMsWJtbpdsMoI+Hg3z1CTY/JIMjhR0lo9nKbgfa2Q1PruJ04hKFV7Tfm
 bqxQ49p/DNrcx5btaQe6F4QQU3wYovPLh0sEYsKswHCYnw3WhyDonFpTxIyRBzkC1H+AmvPBMma
 fPSwADI5Q8Ak3R9612A==
X-Authority-Analysis: v=2.4 cv=ZcMt8MVA c=1 sm=1 tr=0 ts=6a50aff6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=V1jnuoLLAAAA:20
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=nbwKsA5dBi2aoCUYr7oA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA4MyBTYWx0ZWRfXznIbMUi4G6ni
 u6WhE2FMpK5nbiKjI+lIfUgN6dRFuIh3rQ+Fao423qWbPPNNEvwKe6cCHUded7eYbXt6Oz+efS7
 hFDEFTzdBfj+bvKUnsxKsezllgZ7CRc=
X-Proofpoint-GUID: 47mcw1b8hoJ8svkoEDybQzxRz_S7dQX5
X-Proofpoint-ORIG-GUID: 47mcw1b8hoJ8svkoEDybQzxRz_S7dQX5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100083
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2026 08:21:34 -0400
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
Message-ID: <20260710083944.QhM_Dd5oJfrFr9sVtcuH2h5Xdk8RYtdzJIU62bc23AQ@z>

From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>

RPMI (RISC-V Platform Management Interface) is the RISC-V non-ISA
platform management specification. It defines a shared-memory transport,
message protocol, and service groups for platform management.

Add the QEMU transport backend and Base service plumbing for virt using
librpmi.

This implementation targets the RISC-V Platform Management Interface
(RPMI) Specification v1.0 Ratified:

https://github.com/riscv-non-isa/riscv-rpmi/releases/download/v1.0/riscv-rpmi.pdf

The librpmi backend is maintained at:

https://github.com/riscv-software-src/librpmi

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 MAINTAINERS                   |   2 +
 hw/misc/Kconfig               |   4 +
 hw/misc/meson.build           |   3 +
 hw/misc/riscv_rpmi.c          | 476 ++++++++++++++++++++++++++++++++++
 hw/misc/riscv_rpmi_internal.h |  24 ++
 include/hw/misc/riscv_rpmi.h  |  90 +++++++
 6 files changed, 599 insertions(+)
 create mode 100644 hw/misc/riscv_rpmi.c
 create mode 100644 hw/misc/riscv_rpmi_internal.h
 create mode 100644 include/hw/misc/riscv_rpmi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 93df53d87f..8e91a31757 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -359,6 +359,8 @@ F: target/riscv/
 F: hw/char/riscv_htif.c
 F: hw/riscv/
 F: hw/intc/riscv*
+F: hw/misc/riscv_rpmi*
+F: include/hw/misc/riscv_rpmi.h
 F: include/hw/char/riscv_htif.h
 F: include/hw/riscv/
 F: common-user/host/riscv*
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1543ee6653..998944c342 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -258,3 +258,7 @@ config XLNX_ZYNQ_DDRC
     bool
 
 source macio/Kconfig
+
+config RISCV_RPMI
+    bool
+    depends on LIBRPMI
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 23265f6035..e7c2ebe28f 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -168,3 +168,6 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 
 # HPPA devices
 system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
+system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
+  'riscv_rpmi.c',
+), librpmi])
diff --git a/hw/misc/riscv_rpmi.c b/hw/misc/riscv_rpmi.c
new file mode 100644
index 0000000000..c4b115b659
--- /dev/null
+++ b/hw/misc/riscv_rpmi.c
@@ -0,0 +1,476 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * RISC-V RPMI transport device.
+ *
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ * Author:
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "exec/cpu-common.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/misc/riscv_rpmi.h"
+#include "hw/misc/riscv_rpmi_internal.h"
+#include "migration/vmstate.h"
+#include "system/address-spaces.h"
+#include "system/runstate.h"
+#include "librpmi.h"
+#include "librpmi_env.h"
+
+void *rpmi_env_zalloc(rpmi_size_t size)
+{
+    return g_malloc0(size);
+}
+
+void rpmi_env_free(void *ptr)
+{
+    g_free(ptr);
+}
+
+void rpmi_env_writel(rpmi_uint64_t addr, rpmi_uint32_t val)
+{
+    cpu_physical_memory_write(addr, &val, sizeof(val));
+}
+
+static bool riscv_rpmi_addr_in_range(uint64_t addr, uint32_t len,
+                                     uint64_t base, uint64_t size)
+{
+    return len && size >= len && addr >= base && addr - base <= size - len;
+}
+
+static enum rpmi_error shmem_qemu_read(void *priv, rpmi_uint64_t addr,
+                                       void *buf, rpmi_uint32_t len)
+{
+    RiscvRpmiState *s = RISCV_RPMI(priv);
+
+    if (!riscv_rpmi_addr_in_range(addr, len, s->shmem_base, s->shmem_size) ||
+        addr != (rpmi_uint64_t)addr || len != (rpmi_uint32_t)len) {
+        return RPMI_ERR_INVALID_ADDR;
+    }
+
+    cpu_physical_memory_read(addr, buf, len);
+    return RPMI_SUCCESS;
+}
+
+static enum rpmi_error shmem_qemu_write(void *priv, rpmi_uint64_t addr,
+                                       const void *buf, rpmi_uint32_t len)
+{
+    RiscvRpmiState *s = RISCV_RPMI(priv);
+
+    if (!riscv_rpmi_addr_in_range(addr, len, s->shmem_base, s->shmem_size) ||
+        addr != (rpmi_uint64_t)addr || len != (rpmi_uint32_t)len) {
+        return RPMI_ERR_INVALID_ADDR;
+    }
+
+    cpu_physical_memory_write(addr, buf, len);
+    return RPMI_SUCCESS;
+}
+
+static enum rpmi_error shmem_qemu_fill(void *priv, rpmi_uint64_t addr,
+                                       char ch, rpmi_uint32_t len)
+{
+    while (len--) {
+        shmem_qemu_write(priv, addr++, &ch, sizeof(ch));
+    }
+
+    return RPMI_SUCCESS;
+}
+
+const struct rpmi_shmem_platform_ops rpmi_shmem_qemu_ops = {
+    .read = shmem_qemu_read,
+    .write = shmem_qemu_write,
+    .fill = shmem_qemu_fill,
+};
+
+static uint64_t riscv_rpmi_read(void *opaque, hwaddr offset, unsigned int size)
+{
+    RiscvRpmiState *s = opaque;
+
+    if (offset != 0 || size != 4) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid read at 0x%" HWADDR_PRIx " size %u\n",
+                      __func__, offset, size);
+        return 0;
+    }
+
+    return s->doorbell;
+}
+
+static bool riscv_rpmi_transport_indices_valid(RiscvRpmiState *s);
+
+static void riscv_rpmi_write(void *opaque, hwaddr offset, uint64_t value,
+                             unsigned int size)
+{
+    RiscvRpmiState *s = opaque;
+
+    if (offset != 0 || size != 4) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid write at 0x%" HWADDR_PRIx " size %u\n",
+                      __func__, offset, size);
+        return;
+    }
+
+    s->doorbell = value;
+
+    if (value == 1) {
+        if (s->context && riscv_rpmi_transport_indices_valid(s)) {
+            rpmi_context_process_a2p_request(s->context);
+            rpmi_context_process_all_events(s->context);
+        }
+        s->doorbell = 0;
+    }
+}
+
+static const MemoryRegionOps riscv_rpmi_ops = {
+    .read = riscv_rpmi_read,
+    .write = riscv_rpmi_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static bool riscv_rpmi_queue_indices_valid(RiscvRpmiState *s,
+                                           uint64_t queue_base,
+                                           uint32_t queue_size)
+{
+    uint8_t *shmem = memory_region_get_ram_ptr(&s->shmem);
+    uint32_t data_slots = queue_size / RPMI_QUEUE_SLOT_SIZE - 2;
+    uint32_t head;
+    uint32_t tail;
+
+    head = ldl_le_p(shmem + queue_base);
+    tail = ldl_le_p(shmem + queue_base + RPMI_QUEUE_SLOT_SIZE);
+    if (head >= data_slots || tail >= data_slots) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid queue indices head %u tail %u slots %u\n",
+                      __func__, head, tail, data_slots);
+        return false;
+    }
+
+    return true;
+}
+
+static bool riscv_rpmi_transport_indices_valid(RiscvRpmiState *s)
+{
+    if (!s->has_shmem || !s->a2p_req_size) {
+        return false;
+    }
+
+    if (!riscv_rpmi_queue_indices_valid(s, 0, s->a2p_req_size)) {
+        return false;
+    }
+
+    return riscv_rpmi_queue_indices_valid(s, s->a2p_req_size,
+                                          s->a2p_req_size);
+}
+
+static void riscv_rpmi_configure_base(RiscvRpmiState *s,
+                                      const RiscvRpmiConfig *cfg)
+{
+    s->platform_info = g_strdup(cfg->platform_info);
+    s->services = cfg->services;
+    s->service_count = cfg->service_count;
+
+    if (cfg->hart_count) {
+        s->hart_count = cfg->hart_count;
+        if (cfg->hart_ids) {
+            s->hart_ids = g_memdup2(cfg->hart_ids,
+                                    cfg->hart_count * sizeof(*cfg->hart_ids));
+        }
+    }
+}
+
+static void riscv_rpmi_init(Object *obj)
+{
+    RiscvRpmiState *s = RISCV_RPMI(obj);
+
+    memory_region_init_io(&s->mmio, obj, &riscv_rpmi_ops, s,
+                          TYPE_RISCV_RPMI, RPMI_DBREG_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static void riscv_rpmi_reset(DeviceState *dev)
+{
+    RiscvRpmiState *s = RISCV_RPMI(dev);
+
+    s->doorbell = 0;
+
+    if (s->has_shmem) {
+        memset(memory_region_get_ram_ptr(&s->shmem), 0, s->shmem_size);
+        memory_region_set_dirty(&s->shmem, 0, s->shmem_size);
+    }
+
+}
+
+static void riscv_rpmi_cleanup(RiscvRpmiState *s)
+{
+
+
+    if (s->context) {
+        rpmi_context_destroy(s->context);
+        s->context = NULL;
+    }
+
+    if (s->transport) {
+        rpmi_transport_shmem_destroy(s->transport);
+        s->transport = NULL;
+    }
+
+    if (s->rpmi_shmem) {
+        rpmi_shmem_destroy(s->rpmi_shmem);
+        s->rpmi_shmem = NULL;
+    }
+
+    if (s->has_shmem) {
+        memory_region_del_subregion(get_system_memory(), &s->shmem);
+        s->has_shmem = false;
+    }
+}
+
+bool riscv_rpmi_service_enabled(RiscvRpmiState *s, RiscvRpmiServiceKind kind)
+{
+    uint32_t i;
+
+    for (i = 0; i < s->service_count; i++) {
+        if (s->services[i].kind == kind) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static bool riscv_rpmi_validate_config(RiscvRpmiState *s, Error **errp)
+{
+    uint64_t queue_bytes;
+
+    if (!s->shmem_size) {
+        error_setg(errp, "RPMI shared memory size must be non-zero");
+        return false;
+    }
+
+    if (s->shmem_base & (RPMI_QUEUE_SLOT_SIZE - 1)) {
+        error_setg(errp, "RPMI shared memory base must be %u-byte aligned",
+                   RPMI_QUEUE_SLOT_SIZE);
+        return false;
+    }
+
+    if (!s->a2p_req_size) {
+        error_setg(errp, "RPMI A2P request queue size must be non-zero");
+        return false;
+    }
+
+    if (!s->hart_count || !s->hart_ids) {
+        error_setg(errp, "RPMI transport requires hart IDs");
+        return false;
+    }
+
+    for (uint32_t i = 0; i < s->hart_count; i++) {
+        for (uint32_t j = i + 1; j < s->hart_count; j++) {
+            if (s->hart_ids[i] == s->hart_ids[j]) {
+                error_setg(errp, "RPMI hart ID %u is duplicated",
+                           s->hart_ids[i]);
+                return false;
+            }
+        }
+    }
+
+    if (s->service_count && !s->services) {
+        error_setg(errp, "RPMI service count requires service descriptors");
+        return false;
+    }
+
+    if (s->a2p_req_size % RPMI_QUEUE_SLOT_SIZE) {
+        error_setg(errp,
+                   "RPMI A2P request queue size must be a multiple of %u",
+                   RPMI_QUEUE_SLOT_SIZE);
+        return false;
+    }
+
+    if (s->p2a_req_size % RPMI_QUEUE_SLOT_SIZE) {
+        error_setg(errp,
+                   "RPMI P2A request queue size must be a multiple of %u",
+                   RPMI_QUEUE_SLOT_SIZE);
+        return false;
+    }
+
+    queue_bytes = 2 * (uint64_t)s->a2p_req_size +
+                  2 * (uint64_t)s->p2a_req_size;
+    if (queue_bytes > s->shmem_size) {
+        error_setg(errp,
+                   "RPMI shared memory size 0x%" PRIx64
+                   " is too small for queues 0x%" PRIx64,
+                   s->shmem_size, queue_bytes);
+        return false;
+    }
+
+    return true;
+}
+
+static bool riscv_rpmi_add_service_group(RiscvRpmiState *s,
+                                         const RiscvRpmiServiceConfig *service,
+                                         Error **errp)
+{
+    switch (service->kind) {
+    default:
+        error_setg(errp, "unsupported RPMI service kind %d", service->kind);
+        return false;
+    }
+}
+
+static bool riscv_rpmi_init_services(RiscvRpmiState *s, Error **errp)
+{
+    uint32_t i;
+
+    for (i = 0; i < s->service_count; i++) {
+        if (!riscv_rpmi_add_service_group(s, &s->services[i], errp)) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+static bool riscv_rpmi_init_context(RiscvRpmiState *s, Error **errp)
+{
+    const char *platform_info = s->platform_info ?: RPMI_PLAT_INFO;
+
+    s->rpmi_shmem = rpmi_shmem_create("rpmi-shmem", s->shmem_base,
+                                      s->shmem_size,
+                                      &rpmi_shmem_qemu_ops, s);
+    if (!s->rpmi_shmem) {
+        error_setg(errp, "failed to create RPMI shared memory backend");
+        return false;
+    }
+
+    s->transport = rpmi_transport_shmem_create("rpmi-shmem-transport",
+                                               RPMI_QUEUE_SLOT_SIZE,
+                                               s->a2p_req_size,
+                                               s->p2a_req_size,
+                                               s->rpmi_shmem);
+    if (!s->transport) {
+        error_setg(errp, "failed to create RPMI shared memory transport");
+        return false;
+    }
+
+    s->context = rpmi_context_create("rpmi-virt", s->transport,
+                                     RPMI_SRVGRP_ID_MAX_COUNT,
+                                     RPMI_PRIVILEGE_M_MODE,
+                                     strlen(platform_info) + 1,
+                                     platform_info);
+    if (!s->context) {
+        error_setg(errp, "failed to create RPMI context");
+        return false;
+    }
+
+    return riscv_rpmi_init_services(s, errp);
+}
+
+static void riscv_rpmi_realize(DeviceState *dev, Error **errp)
+{
+    RiscvRpmiState *s = RISCV_RPMI(dev);
+    g_autofree char *name = NULL;
+
+    if (!riscv_rpmi_validate_config(s, errp)) {
+        return;
+    }
+
+    name = g_strdup_printf("rpmi-shmem@%" PRIx64, s->shmem_base);
+    if (!memory_region_init_ram(&s->shmem, OBJECT(dev), name, s->shmem_size,
+                                errp)) {
+        return;
+    }
+
+    memory_region_add_subregion(get_system_memory(), s->shmem_base, &s->shmem);
+    s->has_shmem = true;
+
+    if (!riscv_rpmi_init_context(s, errp)) {
+        riscv_rpmi_cleanup(s);
+    }
+}
+
+static void riscv_rpmi_unrealize(DeviceState *dev)
+{
+    riscv_rpmi_cleanup(RISCV_RPMI(dev));
+}
+
+static const VMStateDescription riscv_rpmi_vmstate = {
+    .name = TYPE_RISCV_RPMI,
+    .unmigratable = 1,
+};
+
+static const Property riscv_rpmi_properties[] = {
+    DEFINE_PROP_UINT64("shmem-base", RiscvRpmiState, shmem_base, 0),
+    DEFINE_PROP_UINT64("shmem-size", RiscvRpmiState, shmem_size, 0),
+    DEFINE_PROP_UINT32("a2p-req-size", RiscvRpmiState, a2p_req_size, 0),
+    DEFINE_PROP_UINT32("p2a-req-size", RiscvRpmiState, p2a_req_size, 0),
+};
+
+static void riscv_rpmi_finalize(Object *obj)
+{
+    RiscvRpmiState *s = RISCV_RPMI(obj);
+
+    g_free(s->platform_info);
+    g_free(s->hart_ids);
+}
+
+static void riscv_rpmi_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = riscv_rpmi_realize;
+    dc->unrealize = riscv_rpmi_unrealize;
+    dc->vmsd = &riscv_rpmi_vmstate;
+    device_class_set_legacy_reset(dc, riscv_rpmi_reset);
+    device_class_set_props(dc, riscv_rpmi_properties);
+}
+
+static const TypeInfo riscv_rpmi_info = {
+    .name          = TYPE_RISCV_RPMI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RiscvRpmiState),
+    .instance_init = riscv_rpmi_init,
+    .instance_finalize = riscv_rpmi_finalize,
+    .class_init    = riscv_rpmi_class_init,
+};
+
+static void riscv_rpmi_register_types(void)
+{
+    type_register_static(&riscv_rpmi_info);
+}
+
+type_init(riscv_rpmi_register_types)
+
+DeviceState *riscv_rpmi_create(const RiscvRpmiConfig *cfg, Error **errp)
+{
+    DeviceState *dev;
+    RiscvRpmiState *s;
+
+    if (!cfg) {
+        error_setg(errp, "missing RPMI configuration");
+        return NULL;
+    }
+
+    dev = qdev_new(TYPE_RISCV_RPMI);
+    qdev_prop_set_uint64(dev, "shmem-base", cfg->shmem_base);
+    qdev_prop_set_uint64(dev, "shmem-size", cfg->shmem_size);
+    qdev_prop_set_uint32(dev, "a2p-req-size", cfg->a2p_req_size);
+    qdev_prop_set_uint32(dev, "p2a-req-size", cfg->p2a_req_size);
+
+    s = RISCV_RPMI(dev);
+    riscv_rpmi_configure_base(s, cfg);
+
+    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp)) {
+        return NULL;
+    }
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, cfg->doorbell_base);
+    return dev;
+}
diff --git a/hw/misc/riscv_rpmi_internal.h b/hw/misc/riscv_rpmi_internal.h
new file mode 100644
index 0000000000..447c0acb55
--- /dev/null
+++ b/hw/misc/riscv_rpmi_internal.h
@@ -0,0 +1,24 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * RISC-V RPMI internal service helpers.
+ *
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ * Author:
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
+ */
+
+#ifndef HW_MISC_RISCV_RPMI_INTERNAL_H
+#define HW_MISC_RISCV_RPMI_INTERNAL_H
+
+#include "qapi/error.h"
+#include "hw/misc/riscv_rpmi.h"
+#include "librpmi.h"
+
+#define RPMI_PLAT_INFO "QEMU RISC-V RPMI"
+
+extern const struct rpmi_shmem_platform_ops rpmi_shmem_qemu_ops;
+bool riscv_rpmi_service_enabled(RiscvRpmiState *s,
+                                RiscvRpmiServiceKind kind);
+
+#endif
diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.h
new file mode 100644
index 0000000000..cb2658e57e
--- /dev/null
+++ b/include/hw/misc/riscv_rpmi.h
@@ -0,0 +1,90 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * RISC-V RPMI definitions shared by RPMI transport and FDT helpers.
+ *
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ * Author:
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
+ */
+
+#ifndef HW_MISC_RISCV_RPMI_H
+#define HW_MISC_RISCV_RPMI_H
+
+#include "exec/hwaddr.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+#include "qemu/notify.h"
+
+#define RPMI_QUEUE_SLOT_SIZE 64
+#define RPMI_DBREG_SIZE      0x1000
+
+#define RPMI_ALL_NUM_QUEUES 4
+#define RPMI_A2P_NUM_QUEUES 2
+#define RPMI_ALL_NUM_REGS   (RPMI_ALL_NUM_QUEUES + 1)
+#define RPMI_A2P_NUM_REGS   (RPMI_A2P_NUM_QUEUES + 1)
+
+#define VIRT_RPMI_A2P_REQ_SIZE (16 * RPMI_QUEUE_SLOT_SIZE)
+#define VIRT_RPMI_P2A_REQ_SIZE 0
+
+
+#define TYPE_RISCV_RPMI "riscv-rpmi"
+OBJECT_DECLARE_SIMPLE_TYPE(RiscvRpmiState, RISCV_RPMI)
+
+struct rpmi_context;
+struct rpmi_service_group;
+struct rpmi_shmem;
+struct rpmi_transport;
+
+typedef enum RiscvRpmiServiceKind {
+    RISCV_RPMI_SERVICE_INVALID = 0,
+} RiscvRpmiServiceKind;
+
+typedef struct RiscvRpmiServiceConfig {
+    RiscvRpmiServiceKind kind;
+    const char *node_name;
+    const char *compatible;
+    uint32_t service_group;
+    bool has_mpxy_channel;
+    uint32_t mpxy_channel;
+} RiscvRpmiServiceConfig;
+
+typedef struct RiscvRpmiConfig {
+    hwaddr doorbell_base;
+    hwaddr shmem_base;
+    hwaddr shmem_size;
+    uint32_t a2p_req_size;
+    uint32_t p2a_req_size;
+    const char *platform_info;
+
+    const uint32_t *hart_ids;
+    uint32_t hart_count;
+    const RiscvRpmiServiceConfig *services;
+    uint32_t service_count;
+} RiscvRpmiConfig;
+
+struct RiscvRpmiState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    MemoryRegion shmem;
+    uint64_t shmem_base;
+    uint64_t shmem_size;
+    uint32_t a2p_req_size;
+    uint32_t p2a_req_size;
+    char *platform_info;
+
+    uint32_t *hart_ids;
+    uint32_t hart_count;
+    const RiscvRpmiServiceConfig *services;
+    uint32_t service_count;
+    uint32_t doorbell;
+    struct rpmi_shmem *rpmi_shmem;
+    struct rpmi_transport *transport;
+    struct rpmi_context *context;
+    bool has_shmem;
+};
+
+DeviceState *riscv_rpmi_create(const RiscvRpmiConfig *cfg, Error **errp);
+
+#endif
-- 
2.43.0


