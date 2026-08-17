Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2828EC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvv0d-0003QV-Vu; Mon, 17 Aug 2026 06:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wvv0L-0003F3-91
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 06:55:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wvv0I-00067k-0F
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 06:55:44 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67H9dePB2470460
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 10:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=FMTKFazjVrE
 wkbtcHeZPUAz0wxDGcSPg1sRjvG78XMI=; b=Uw3RoNfhk0w2CfZ8EZc1+kgd1OF
 x0FsBsInzPa+0g3/G8VN4BnNRcBeqS3HU4csiAaQ+U1n+YDIKYD/4lpcUGFxLmjX
 XHgXj+9f7Kznry+aGB8MIzZp9/ntN06RkBUkmCkKp+Dz0g6yqRl0xi+3c1DAhuMi
 pvAIH9Qg5wgXI36Ec4u2aCYbpMC5ZdSKHErUz1fMVP0wdhg6D0mJngGgdKjrAEJr
 VcP+NJF4mKgO8+15c+Gp2YTGORBT64W4nAunv5/lty+8rKaIAbvPNAku76cEGdiB
 BXF2ZsKOUCp8KypZQ1FdeL9tICG9ev3HCFnjdva2cU+8hhxa3jeIwmsZz6w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3wm7ruh6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 10:55:39 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cfd13d6d50so7031665ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 03:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786964139; x=1787568939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FMTKFazjVrEwkbtcHeZPUAz0wxDGcSPg1sRjvG78XMI=;
 b=Yq27Pg+J2Q+BhPSzVrUTYUMlJUVptfgtYTPyawsJUDDgWY3Dm7BxMDuPBr5DzRnhLh
 QlgRa/e+7BkzUhmRsyxEOYxUYwtDV3kUtoVR9Zp4cvw5pOxhPrR/iOQDfgypZ9aR5yG1
 tQaNEikvuNvDzjqm6k8/orMciBPp2Bcz9GXyMoFHLb++FxbSIsQtNm6GF9gKIfJU86kB
 teYPLc9NTFeNWPRtrfTO0cCJdnY+WpyPBJRgypKWeIOrlM+ZW9eU/9evWO0oUQ+JoZM1
 sq9Y6++DeAdyuTeWpykv1BDb5GTJGISdhr6MkBsOsRqTuG3u4tCscFKZ8ZJV0DsyXvkJ
 hg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786964139; x=1787568939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FMTKFazjVrEwkbtcHeZPUAz0wxDGcSPg1sRjvG78XMI=;
 b=lWShJkBqa7p5iE1HUeLTk7qjtFw86bihxmujDTXNT8FobPw8hfBSk3IOw6JZEid37O
 FjDgjaOZ1X55mF5iw32a0Csp6BQZLbqCxdzkOZDq1SdBiu8OMf/xfjhV8oft2C9E+s4F
 HCNDACBn2Xx4FVTXc+D5vW3sttP4CCItbMOxwBG8t0oURDG4NicHPx5aUmhXmVGLt6Bx
 IkLBATqBdMxnInrFPtHR6pc8H+/iuykHg9NDSewLZuhjhUA4rhXtXFluHH+SJFPpfSu4
 nDaO1ku7sf6DhX+FwH9Ka+3XhMXVrqLKqbjg+XWD/yfQ7NQBnPg1a9ptAcEnJorMvXmS
 2jXQ==
X-Gm-Message-State: AOJu0YyOuiPRARBOWYjY8wviKF3aEHXfwyX1zTmmYsXm1YtBqRtD0mF2
 SGnzUe0JOD79OiHRTPVmuDPNm8ZgdHCtDeW3hRA3eUyMdPOmX+Aw69l4ivo6Z0gOStkeaMILbRn
 ndWt8sN1GVdXHLjq+HwVhdhfMaQ0v4uO+6ioWEMY39iLATTYocW9f1rA6p+dBEA4gDIwD
X-Gm-Gg: AR+sD102nvlB1gNDihZmymsgFJ//fD9tISpkxLg+2hhFB+UQ/An14tT2dglPFgjJzXw
 UxfNAyN/RR6uls3DMwoVgtX6pNpDEVGygFq8JgiCEw5b2Oxnslni0nRCZD6q4Nhf6T3QYzd8Ckp
 GvuyG5IJUF0HCMoIUt+zzfwOO364CH9gJWVDbLw4shH2/rqSnAZ1EFXxqsoDuCrEOVEen97gpds
 45F+ps0cyjv7YwR5cBqaBRxdAxFvwTieiHMLS9i+WeKdBd1g/KVNXHVM+LMThfH1eH+8vJfBa1q
 1HuOvkLH446DAMdV/JdGxvl7v4L9l4VP82fg6tFJUgYu1NQUpSpat9g4PUyaiPz0pqoSLPHao1P
 2j2u3F96GdRlzeU4Wcnnn91nXzB6RSD9mznvs0FPRxuYSa8L5KTR93fHhECitn6gl11rSNsx7O5
 D5U9Q/YY2p3En59EyHWSW2K2rSQQp6qEQ=
X-Received: by 2002:a17:902:854c:b0:2d5:3f09:4126 with SMTP id
 d9443c01a7336-2d53f094341mr95985345ad.4.1786964138815; 
 Mon, 17 Aug 2026 03:55:38 -0700 (PDT)
X-Received: by 2002:a17:902:854c:b0:2d5:3f09:4126 with SMTP id
 d9443c01a7336-2d53f094341mr95984835ad.4.1786964138155; 
 Mon, 17 Aug 2026 03:55:38 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c389363sm5431136eec.23.2026.08.17.03.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 03:55:37 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v9 02/10] hw/misc: add RISC-V RPMI transport and Base support
Date: Mon, 17 Aug 2026 16:24:56 +0530
Message-ID: <20260817105505.2607506-3-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817105505.2607506-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260817105505.2607506-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2-sQyWeMEe3xhZMwM8sBvxEPECG0DrpO
X-Proofpoint-ORIG-GUID: 2-sQyWeMEe3xhZMwM8sBvxEPECG0DrpO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA4MSBTYWx0ZWRfX58DYK60w1C8X
 sYvhZain/7jjMNo7AUpr7coe+DlVwsk1sEZWuMLXExxTdf1VhF3qYoMx7LZsqoszMKhzf/S4XpI
 YVzld2ApcbEN7KxPK0vJ5J39oEm5L/JBBgPH5HT9fiMelc0z1LPcTyHKjhndxCe1wcNQ3KdJRtN
 O2vjp1MC/E5lbAX3yz+mAd+kDq0O/7+YHJWKwYTgrCmwW/v9R9EDRdJY2+FfwEQpvBmbwaeb6Q6
 lbs2HGpeyGL9NCMgeRBHt2f9z5Rv7vDu7tRUsPO3qga7dEg3WDw4GU7P5hjMsmrGgK0lYJC/Yf1
 QtTYB9986IDz3uLVTtyL34LUoHgp7BM8MJvlVTJuN6ISu9u2IlbB8wp5QKR2C+KTbTuNsvdY2jn
 UHsDMdHg0l/kXreBZDx/B+ckNtBZ9VuK8PDGHr8wScrcKy4nrX/F5FdNICPairBesBKZ80FxLXO
 VjpXHD1xCphz3ZnTlhQ==
X-Authority-Analysis: v=2.4 cv=YqM/gYYX c=1 sm=1 tr=0 ts=6a82e8ab cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=V1jnuoLLAAAA:20
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=DmI9vCv-aQFBvt5XpaMA:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA4MSBTYWx0ZWRfXwzUbhkaPuh6i
 BgKtaLeZ4fIttY4WMhR4cQy2LXuZbiIRp4ERuS7Fn4ZtpJ2FAshL4drTn1oI2Z+oQVGa7J7r95L
 GDrH5NV+61y5gXRDZtiHUy2c1cmbuTc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170081
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
index f249be744e..c742a71ee6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -372,6 +372,8 @@ F: target/riscv/
 F: hw/char/riscv_htif.c
 F: hw/riscv/
 F: hw/intc/riscv*
+F: hw/misc/riscv_rpmi*
+F: include/hw/misc/riscv_rpmi.h
 F: include/hw/char/riscv_htif.h
 F: include/hw/riscv/
 F: common-user/host/riscv*
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index b8860dd3e7..dd2e876ba5 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -261,3 +261,7 @@ config AXIADO_CLK
     bool
 
 source macio/Kconfig
+
+config RISCV_RPMI
+    bool
+    depends on LIBRPMI
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index e86d9ad6b3..6a19fe443c 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -171,3 +171,6 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
 
 system_ss.add(when: 'CONFIG_AXIADO_CLK', if_true: files('axiado_clk.c'))
+system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
+  'riscv_rpmi.c',
+), librpmi])
diff --git a/hw/misc/riscv_rpmi.c b/hw/misc/riscv_rpmi.c
new file mode 100644
index 0000000000..8598a3f133
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
+#include "hw/core/qdev-properties.h"
+#include "hw/misc/riscv_rpmi.h"
+#include "hw/misc/riscv_rpmi_internal.h"
+#include "migration/vmstate.h"
+#include "system/address-spaces.h"
+#include "system/physmem.h"
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
+    physical_memory_write(addr, &val, sizeof(val));
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
+    physical_memory_read(addr, buf, len);
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
+    physical_memory_write(addr, buf, len);
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


