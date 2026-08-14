Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D77C5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 04:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wujvO-0008PY-6V; Fri, 14 Aug 2026 00:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wujvM-0008P1-Dw
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 00:53:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wujvJ-0005KT-Mj
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 00:53:44 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67E4Qehv3614505
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 04:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=xtNT7tVLBZM
 qT255s7C5LAFGKltAfMUZiU6Eqrzd82c=; b=B3k00dXR/4qobYEUHfwyzHs2kmd
 R86bRWepBLYXfi8WIVnD7Lm+G1R1jjOMhCkx4JQK1+NSJZewgJ2p5VjsCIkN0gOg
 aSHZm8nW/eUTM057QASN772eIBPMJnedi514uv3luMaUbxWu+RDGaL3Ou8keAEc2
 Kl9xRuWf2t5etETq1nFjWin+QIlPNR36nvIE09HGEeUu2ewm2elolucAyru1P2AN
 2aKQ9+cVdWn91J6dOAHQQ/FYNmGe6IrYI6e3NBjKdGko6Vpq4HiV+mokuWPbaanm
 sis50J/aYRhlklQSa7LPdklEM+9h59YhejFtg3VmZI/5ITWTiVi1vqFiMOA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1hgy2fh2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 04:53:40 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-384d033f7f5so119295a91.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 21:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786683220; x=1787288020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xtNT7tVLBZMqT255s7C5LAFGKltAfMUZiU6Eqrzd82c=;
 b=J7KV00N6tGXHWsO3CzidKc9VntzXbjhOkZ79F7+/9FGvGFpzmRJH2rqiOXOlKQ9zc4
 H7NBG9D0V/pRS0sYgGoP4zE8HdrSbQ0Kbl8NvbzljN+rpDB7/Kn9Ks8RqbgdDdaoqQ1z
 tEbRdgn8iSKH7HIVlAJfa4pTrg+02a3ZyF+oplvqhSeW6YqLLEDmWtfiL0bV+IHVY7hu
 5qmywI4VKDzCYAyUJ/k+XtuuPkMf4uFbKD2nMkXFvUnwLHFKoGfbrru59+IkpyNVUwFz
 vi4k80a2Lmki8kWJKaOVZsrcXa0V59UjjuvDtvTwL9vclqGDXHRcziyx8gN88vkETjle
 KiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786683220; x=1787288020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xtNT7tVLBZMqT255s7C5LAFGKltAfMUZiU6Eqrzd82c=;
 b=ARVuU+HaQBEArPRLrK/m2xf1weviVupZcmtDniiWQZ/MYKPRYKjv/f+M3JWZDClSgT
 aN0zQBRuvBg9IykhQrU1r+G2jxc/9jhETd8VRXlcAkizkl7BcWB4JWfZiN978d4NhNG+
 PUp2TmIVnbEXp1QGZLOor2uHkBWpuouJ4oUBNODJQiVB6a/nbljNMsUlkZTs2twVtDFf
 tVaDP8U3iO4pCeJel69w35m4gvG1352yoV+A615sznAqxjcAl8i4c0JERRkz0eAm9KpG
 b0v4Wr1n5eEkg0/AWYpaGCQUoxq/OOdFKv0wnP5VORORMVrcEOlApQpth0Ud43oDADk7
 XrTg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJGcVfo8WpMTuRk8l7Z6MIGzJGeLiD1TamkqeHuw+jWlIWBmBz7GWffbTtkBDueB5GQm4VygjIGl8W@nongnu.org
X-Gm-Message-State: AOJu0Yx8Vibr4NaBxhRFuXfYlAu/U86a3p0CHnWFWlkiUajMmVTisdwd
 m5ENBsoryw3g0w/6cvPpe6+0ejQZNrhi/knU7fW2+hhht1jX2cds8sFW2q2Wd6T/soXLBNqD4Pt
 6yhQ5HM77gIAXALJb1qN6q84T8m571LZd7L9qYTXk5twDe4q33gx7OqMr/w==
X-Gm-Gg: AR+sD12gAYSkU+s2rqDBi/b7X/XxgotIZeGirjPHXZeryUaVQ/u93ACJB/3QIXJozHQ
 3GNRbdrj1qwJUOeMHrmSHUThjLGM7575DVlqUZDfvaP1XNP2f2cq4OFTIbwSab3ERMbGdQZ/Fi4
 iNpxtaDM61V+5Vfcnu/lIGNVtswNLbmfLhvAketVPg1CEjJFRNDSPZg6vYa6/O0ZZgCj7T7O9pE
 /gGEhQZvGmrtM+RoT6CHjOS9kVnEEy6k6ADJ6jQhn24l8XjQG+eDZZnsQ2Ha+vN9RNK+SQ/5lMV
 NwQ8q+u+C+Qjn0oxl6P1iIN+6rQ85M4wcghzh0xn2YFobHniV1eieor/ZCEWah6PfSHtB9VSjFf
 iTKsku4lzBy8+T5xLaSrd0hK9JIfZQMru+BcbGepNInXdhd+qOATT0CQb+jKx7XuUXxdHVE9ll8
 hAmfC3ZyfgzTzMyUd7xjw7xkpyB/12GPQ=
X-Received: by 2002:a17:90b:3142:b0:390:af7c:fe5e with SMTP id
 98e67ed59e1d1-3933e5e1b69mr2250168a91.2.1786683219330; 
 Thu, 13 Aug 2026 21:53:39 -0700 (PDT)
X-Received: by 2002:a17:90b:3142:b0:390:af7c:fe5e with SMTP id
 98e67ed59e1d1-3933e5e1b69mr2250132a91.2.1786683218743; 
 Thu, 13 Aug 2026 21:53:38 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31f15063cd8sm10625665eec.9.2026.08.13.21.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 21:53:38 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v8 02/10] hw/misc: add RISC-V RPMI transport and Base support
Date: Fri, 14 Aug 2026 10:23:06 +0530
Message-ID: <20260814045315.3416169-3-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814045315.3416169-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260814045315.3416169-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDAzNiBTYWx0ZWRfX7zRfBIuoeH/v
 wLGzr4QUkoDMcLAs1ySrRrx1f16ClL3s7DIA3A3DBGdjuo0fwfkgBIopjoUHlw6XoF4UTUwARqW
 WHjcD2ibV87rQzuA0jtUu3VmRCLm67mikjoELHFjEx06A05jzt+JosrNKvi9arIHIz3J2N+ecG1
 ZkwVYG1LxloKiFIkeY16/44CvHVC+FNhwhkmMCNI3b5yC+ggEa57CwocyTa4H6mp7RyMJryKohX
 R7KGExV4XxMPGHQpG55tP6ljfQntC7yAhksUGick4UF9cwynK/FBR8pWU6LpRB1xEZVeMaY234E
 lychBu2BWVOnmJQgV/MQCUE6XDCuCkjIqtRpyUJJX3pvGIl5LMgEHYxn+EWmt66yzHhMEUuMLGv
 IWIXBjniWqcUsluof4XVpd11w97qf/EO9iKxNOmofA/qn5mzRDiNe+aWzZaQ0WMZxfElGPufKpZ
 k6sKhhk3SG9doI2fKAA==
X-Authority-Analysis: v=2.4 cv=AaSB2XXG c=1 sm=1 tr=0 ts=6a7e9f54 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=V1jnuoLLAAAA:20
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=nbwKsA5dBi2aoCUYr7oA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: 0cS8kwxcR5RY0TJsfEB49esZuW6eDDuD
X-Proofpoint-GUID: 0cS8kwxcR5RY0TJsfEB49esZuW6eDDuD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDAzNiBTYWx0ZWRfX9DOY1MAR6y9R
 mhKCgxgzfpj8VnpC8TL1pfuBVhNRewAXe6fjtHuAuXi9bih09dVeVA6GEuorMfxanAak2+SF1L4
 ZE+r8nYo81sUv13uN4bZh1mE0ule0ME=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140036
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
 hw/misc/riscv_rpmi.c          | 477 ++++++++++++++++++++++++++++++++++
 hw/misc/riscv_rpmi_internal.h |  24 ++
 include/hw/misc/riscv_rpmi.h  |  90 +++++++
 6 files changed, 600 insertions(+)
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
index 0000000000..54a790fc7c
--- /dev/null
+++ b/hw/misc/riscv_rpmi.c
@@ -0,0 +1,477 @@
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
+static void riscv_rpmi_reset_hold(Object *obj, ResetType type)
+{
+    RiscvRpmiState *s = RISCV_RPMI(obj);
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
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = riscv_rpmi_realize;
+    dc->unrealize = riscv_rpmi_unrealize;
+    dc->vmsd = &riscv_rpmi_vmstate;
+    rc->phases.hold = riscv_rpmi_reset_hold;
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
index 0000000000..c263033634
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
index 0000000000..f5fd1ee8c7
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


