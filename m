Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551B8606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 23:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QhUDKTU2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Qy4pDUDJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJfVb-0007SJ-EP; Wed, 21 Oct 2026 19:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfVa-0007Ro-Jf
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfVY-0004x8-17
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:10 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LM3bQh2413754
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=F8fzM/MLJbA
 3M0h/1l4bdlJeCchnaMmie0EkXDAcnzo=; b=QhUDKTU2rdipf+PqOJbkN2i8X38
 F1xPS0ldnclGx350onj1NbNSGyDYN0BL/zEWTqVB2VdsCADFM/HIbWdJsayIOAU4
 tImQTocU2O5Q5+6E+WZcJRmMoOA48h8XnQ2EXvRAvf0Zj7pMNoDejzxZQ8WJ7K3X
 Z7TUMjLoumLLYjhqv64whmCIsdob5hwjB63mgJ9XiAJdnMuBb3unlKkrYMgDKCtd
 jln7BiXTL+y1lGniOL7inL/VFLiPMQ1E7ivmT20trxIAoeO9E3T8JnjlI0aW0mDK
 paJPtNk7blOLurV40+BJ/8T/351GDHSjMVxuTtH87qarheXF08P6XYZ/IiA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0v89ctc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:06 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5338ff2cf14so26767791cf.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792624446; x=1793229246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F8fzM/MLJbA3M0h/1l4bdlJeCchnaMmie0EkXDAcnzo=;
 b=Qy4pDUDJAW3vKqhloLdZx9curvmzQ0K85VfYAqoVJZcTlrCX8xCMSW39LSB1B8Z9j/
 i1kLdtIPiN2dOJdCaCmWWKI6gIXab6+DkRhrSzg25+FJR33lQw5a0o968DxHiLtNEkus
 LlsBrw0sKA+A9JRG3j2DrhdF8Wx2ctDiY0iA4KqI+/wbWbPLSu06d/sRXZMKrWrh2uLI
 mXpc0b2JRXtkMb+ohakrssRRSns96HUK6HplelpRuuQNs0BLdi7RuFMRQXJobBqxfCio
 gpr4dmaKlNd2ImdyyoLSRjW9lq+cOip/jnC1FQbnBUBttNBxivbWfxVbY20/oYSXKO1E
 EejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792624446; x=1793229246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F8fzM/MLJbA3M0h/1l4bdlJeCchnaMmie0EkXDAcnzo=;
 b=dSSuZLjq/p/TmoOG4jOBPJsC2ARByDoJ2PcUfbqWCxEOiSiBgEErdMCdVJMckJg/63
 mF++vzbQnddnFH1ZwSymQPJ1fEXkRWKer6UGOUfma+Mng43oD2JyifszIGvlIa3Ci6TC
 dFSVqutgyuyRO98ENRjLKG+YdWaPVoQOZlShx2nbNC45hHNsoDTepKNcylRLZvF5eVyG
 tdOR+0aRwKxwJsJ7ySH9/y0YidU+F3v4TRVGL7V5XdHBXkXRs/nw2mL+IuILA5YtRT8I
 hHeCCqSmij0ysXe1JRKCe77WnPKfMAiFWuvEZQe6fzEvqYRLOEpqzuFDARPWJrwnJYN8
 8Qpg==
X-Gm-Message-State: AFq9FYIleIGP8rW2lHNi047cdEARmXtsMe58WWRLYmd2qZSURaxRh171
 hXZf5L/ZMbNFCLNYkphTfz9u/9LIixN9AzOOmK6AKriiZ6HhyNPv1A1YALg12heOFb7YXl7hmtl
 /uMznVVedfN/lY0HZNKpYzKaWu4NIUk/7eOC513XKb1YgHvMwxU95t/yRPsU1nelyxg==
X-Gm-Gg: AYBFou2+JZzxTy6DRBeappc9dyTtcZE0KhM8XqTbtktwxyiz0S+en5bcly3lXvMkjQW
 6qpovX2vkx/98JfBG3k7N2pqT1ObwWSv7VMtyOwD7dE4Z+q+FkhenI7rfw22qe9kteHRc/TchFb
 uf7tB0ORGn/6o5or1z34rOXlarrFrn2nE+eZDgCzUz5nzKvuCzAk8KIN3J+/Zdoiil81XeznWAX
 yjadjwJWpnpDNpX+OTGOgkgomrG/g2wFhZFpeA493HCtfPkaXyCXLOkMw7bxbLfW7yBGt90OX6C
 O5y/eHjoR1VGCmA4hYl4Qj59BLJLu3NmPBwpt9L49xgZcbR3pdu8ZhEWZAvzYXq/UHIOUYMisMW
 13JyuidL1jaMlKxJf1sE62glFe0IE+oDoqDEkm6qUch1vfb4rNDAf/4bVRGGyzPL1c13NMiY7Ug
 ==
X-Received: by 2002:ac8:7f45:0:b0:536:6ff1:7568 with SMTP id
 d75a77b69052e-5369b889a2emr55189921cf.60.1792624445633; 
 Wed, 21 Oct 2026 16:14:05 -0700 (PDT)
X-Received: by 2002:ac8:7f45:0:b0:536:6ff1:7568 with SMTP id
 d75a77b69052e-5369b889a2emr55189481cf.60.1792624445112; 
 Wed, 21 Oct 2026 16:14:05 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com
 (200-204-190-237.dsl.telesp.net.br. [200.204.190.237])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536ab6cd0dcsm11995651cf.6.2026.10.21.16.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 16:14:04 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 antikostya2@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 02/18] hw/riscv: Trace RAM Sink initial impl
Date: Wed, 21 Oct 2026 20:13:29 -0300
Message-ID: <20261021231346.2452179-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=C9Z8WgP+ c=1 sm=1 tr=0 ts=6ad9473e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=V1jnuoLLAAAA:20
 a=EUspDBNiAAAA:8 a=aqjgF2fw9fj3PC3FA9IA:9 a=uxP6HrT_eTzRwkO_Te1X:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX+xitMlnUkO/+
 JfYlQmkWwX5cxrfQELhTxJ1fwNSVGGDBaZbhxOTovPbFuv3E+QCNIFa9tXqWRgQ6CkA8O+dVaXX
 yXemzUFkzxfgEbZoqEjgL9OPKJyMk+0=
X-Proofpoint-GUID: IiAGTcxIuaCMYTOaXCVAhckI4MH8E4rp
X-Proofpoint-ORIG-GUID: IiAGTcxIuaCMYTOaXCVAhckI4MH8E4rp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX0/trRIHirbMn
 H4XsheSICbosYxs4YpZzuBWzeHkA/iHQRk4AknPUtnjFqPLl5lI7UU9hj91UsLQJEAqHJt5QI2n
 vbVCzy85ZUn3dRxFoNtbcjQgVSeua/OcvPrw7npdCuQ0EH2aZ00P7zmyciVbU69x0JXuUTY6hvr
 iiX9JvfgPoVqAHU1e6o1aTUC1FGcnEp5nfIkw5tiDg/MjEgSxEy08dwnGJxi8j85NZ/0CiYgU4y
 aE6qzL40HHbpzDjOJcbR5Dys8n4Ncq/xhUKn5XSckp4lGHKwN7G3j0CZIWORSmtbqEbyhrpI5u8
 Jw6kJTUq4podpIhVt0G8sp3k300Yt/d1BnwA6ezR8XYpuT9pf08YZsnmm2dED83FSBRyuK0goCv
 hYmBHzpTa855Tbpr7MJRryY4jXociQjYVyTpMfVN9w6B2R6Wz0bBh4UV7Pq8MHEKLiBvSD6r/st
 DfKNdBDkGHzAJtbFXSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210092
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Following the effort to implement the basic support for Efficient Trace
(e-trace) in QEMU we'll add a Trace RAM Sink implementation.

Similar to the Trace Encoder, this is inspired in both the Efficient
Trace for RISC-V [1] and  RISC-V Trace Control Interface Specification
[2] specs. It implements a minimal set of features to get started - only
SMEM will be supported for now.

We'll implement the RAM sink logic in the next patches, although most of
the work will be done by the trace encoder.

[1] https://github.com/riscv-non-isa/riscv-trace-spec/releases/download/v2.0-20250616/riscv-trace-spec-asciidoc.pdf
[2] https://github.com/riscv-non-isa/tg-nexus-trace/releases/download/1.0_Ratified/RISC-V-Trace-Control-Interface.pdf

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/meson.build      |   2 +-
 hw/riscv/trace-events     |   4 +
 hw/riscv/trace-ram-sink.c | 263 ++++++++++++++++++++++++++++++++++++++
 hw/riscv/trace-ram-sink.h |  83 ++++++++++++
 4 files changed, 351 insertions(+), 1 deletion(-)
 create mode 100644 hw/riscv/trace-ram-sink.c
 create mode 100644 hw/riscv/trace-ram-sink.h

diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 1238cb3e1a..97a39f85f9 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -22,7 +22,7 @@ riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c
 riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
 riscv_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('boston-aia.c'))
 riscv_ss.add(when: 'CONFIG_K230', if_true: files('k230.c'))
-riscv_ss.add(when: 'CONFIG_RISCV_TRACE', if_true: files('trace-encoder.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_TRACE', if_true: files('trace-encoder.c', 'trace-ram-sink.c'))
 riscv_ss.add(when: 'CONFIG_SOPHGO_CV1800B', if_true: files('cv1800b.c'))
 riscv_ss.add(when: 'CONFIG_MILKV_DUO', if_true: files('milkv_duo.c'))
 
diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
index 0cbf6ffcb6..14e333fd9e 100644
--- a/hw/riscv/trace-events
+++ b/hw/riscv/trace-events
@@ -28,3 +28,7 @@ riscv_iommu_hpm_evt_write(uint32_t ctr_idx, uint32_t ovf, uint64_t val) "ctr_idx
 # trace-encoder.c
 trencoder_read_error(uint64_t addr) "addr 0x%" PRIx64
 trencoder_write_error(uint64_t addr, uint64_t value) "addr 0x%" PRIx64 " value 0x%" PRIx64
+
+# trace-ram-sink.c
+tr_ramsink_read_error(uint64_t addr) "addr 0x%" PRIx64
+tr_ramsink_write_error(uint64_t addr, uint64_t value) "addr 0x%" PRIx64 " value 0x%" PRIx64
diff --git a/hw/riscv/trace-ram-sink.c b/hw/riscv/trace-ram-sink.c
new file mode 100644
index 0000000000..33d033b72e
--- /dev/null
+++ b/hw/riscv/trace-ram-sink.c
@@ -0,0 +1,263 @@
+/*
+ * Emulation of a RISC-V Trace RAM Sink
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "trace-ram-sink.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "trace.h"
+#include "system/device_tree.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/register.h"
+
+#define R_TR_RAM_CONTROL_RSVP_BITS (MAKE_64BIT_MASK(32, 32) | \
+                                    R_TR_RAM_CONTROL_RSVP1_MASK | \
+                                    R_TR_RAM_CONTROL_RSVP2_MASK | \
+                                    R_TR_RAM_CONTROL_RSVP3_MASK | \
+                                    R_TR_RAM_CONTROL_RSVP4_MASK)
+
+/* trRamEmpty is the only RO field and reset value */
+#define R_TR_RAM_CONTROL_RESET R_TR_RAM_CONTROL_EMPTY_MASK
+#define R_TR_RAM_CONTROL_RO_BITS R_TR_RAM_CONTROL_EMPTY_MASK
+
+#define R_TR_RAM_IMPL_RSVP_BITS (MAKE_64BIT_MASK(32, 32) | \
+                                 R_TR_RAM_IMPL_RSVP1_MASK)
+
+#define R_TR_RAM_IMPL_RO_BITS (R_TR_RAM_IMPL_VER_MAJOR_MASK | \
+                               R_TR_RAM_IMPL_VER_MINOR_MASK | \
+                               R_TR_RAM_IMPL_COMP_TYPE_MASK | \
+                               R_TR_RAM_IMPL_HAS_SRAM_MASK | \
+                               R_TR_RAM_IMPL_HAS_SMEM_MASK)
+
+#define R_TR_RAM_IMPL_RESET (BIT(0) | 0x9 << 8)
+
+static RegisterAccessInfo tr_ramsink_regs_info[] = {
+    {   .name = "TR_RAM_CONTROL", .addr = A_TR_RAM_CONTROL,
+        .rsvd = R_TR_RAM_CONTROL_RSVP_BITS,
+        .reset = R_TR_RAM_CONTROL_RESET,
+        .ro = R_TR_RAM_CONTROL_RO_BITS,
+    },
+    {   .name = "TR_RAM_IMPL", .addr = A_TR_RAM_IMPL,
+        .rsvd = R_TR_RAM_IMPL_RSVP_BITS,
+        .reset = R_TR_RAM_IMPL_RESET,
+        .ro = R_TR_RAM_IMPL_RO_BITS,
+    },
+    {   .name = "TR_RAM_START_LOW", .addr = A_TR_RAM_START_LOW,
+    },
+    {   .name = "TR_RAM_START_HIGH", .addr = A_TR_RAM_START_HIGH,
+    },
+    {   .name = "TR_RAM_LIMIT_LOW", .addr = A_TR_RAM_LIMIT_LOW,
+    },
+    {   .name = "TR_RAM_LIMIT_HIGH", .addr = A_TR_RAM_LIMIT_HIGH,
+    },
+    {   .name = "TR_RAM_WP_LOW", .addr = A_TR_RAM_WP_LOW,
+    },
+    {   .name = "TR_RAM_WP_HIGH", .addr = A_TR_RAM_WP_HIGH,
+    },
+};
+
+static uint64_t tr_ramsink_regread(void *opaque, hwaddr addr, unsigned size)
+{
+    TraceRamSink *tram = TRACE_RAM_SINK(opaque);
+    RegisterInfo *r = &tram->regs_info[addr / 4];
+
+    if (!r->data) {
+        trace_tr_ramsink_read_error(addr);
+        return 0;
+    }
+
+    return register_read(r, ~0, NULL, false);
+}
+
+static void tr_ramsink_regwrite(void *opaque, hwaddr addr,
+                            uint64_t value, unsigned size)
+{
+    TraceRamSink *tram = TRACE_RAM_SINK(opaque);
+    RegisterInfo *r = &tram->regs_info[addr / 4];
+
+    if (!r->data) {
+        trace_tr_ramsink_write_error(addr, value);
+        return;
+    }
+
+    register_write(r, value, ~0, NULL, false);
+}
+
+static const MemoryRegionOps tr_ramsink_regops = {
+    .read = tr_ramsink_regread,
+    .write = tr_ramsink_regwrite,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static uint64_t tr_ramsink_msgread(void *opaque, hwaddr addr, unsigned size)
+{
+    TraceRamSink *tram = TRACE_RAM_SINK(opaque);
+
+    switch (size) {
+    case 1:
+        return tram->msgs[addr];
+    case 2:
+        return (uint16_t)tram->msgs[addr];
+    case 4:
+        return (uint32_t)tram->msgs[addr];
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tr_ramsink_msgwrite(void *opaque, hwaddr addr,
+                                uint64_t value, unsigned size)
+{
+    TraceRamSink *tram = TRACE_RAM_SINK(opaque);
+
+    switch (size) {
+    case 1:
+        tram->msgs[addr] = value;
+        break;
+    case 2:
+        tram->msgs[addr] = extract16(value, 0, 8);
+        tram->msgs[addr + 1] = extract16(value, 8, 8);
+        break;
+    case 4:
+        tram->msgs[addr] = extract32(value, 0, 8);
+        tram->msgs[addr + 1] = extract32(value, 8, 8);
+        tram->msgs[addr + 2] = extract32(value, 16, 8);
+        tram->msgs[addr + 3] = extract32(value, 24, 8);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static const MemoryRegionOps tr_ramsink_smemops = {
+    .read = tr_ramsink_msgread,
+    .write = tr_ramsink_msgwrite,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static void tr_ramsink_setup_regs(TraceRamSink *tram)
+{
+    hwaddr ramlimit = tram->smemaddr + tram->smemsize;
+
+    ARRAY_FIELD_DP32(tram->regs, TR_RAM_START_LOW, ADDR,
+                     extract64(tram->smemaddr, 2, 30));
+    ARRAY_FIELD_DP32(tram->regs, TR_RAM_START_HIGH, ADDR,
+                     extract64(tram->smemaddr, 32, 32));
+
+    ARRAY_FIELD_DP32(tram->regs, TR_RAM_WP_LOW, ADDR,
+                     extract64(tram->smemaddr, 2, 30));
+    ARRAY_FIELD_DP32(tram->regs, TR_RAM_WP_HIGH, ADDR,
+                     extract64(tram->smemaddr, 32, 32));
+
+    ARRAY_FIELD_DP32(tram->regs, TR_RAM_LIMIT_LOW, ADDR,
+                     extract64(ramlimit, 2, 30));
+    ARRAY_FIELD_DP32(tram->regs, TR_RAM_LIMIT_HIGH, ADDR,
+                     extract64(ramlimit, 32, 32));
+}
+
+static void tr_ramsink_reset(DeviceState *dev)
+{
+    TraceRamSink *tram = TRACE_RAM_SINK(dev);
+
+    for (int i = 0; i < ARRAY_SIZE(tram->regs_info); i++) {
+        register_reset(&tram->regs_info[i]);
+    }
+
+    tr_ramsink_setup_regs(tram);
+}
+
+static void tr_ramsink_realize(DeviceState *dev, Error **errp)
+{
+    TraceRamSink *tram = TRACE_RAM_SINK(dev);
+
+    memory_region_init_io(&tram->reg_mem, OBJECT(dev),
+                          &tr_ramsink_regops, tram,
+                          "trace-ram-sink-regs",
+                          tram->reg_mem_size);
+    sysbus_init_mmio(SYS_BUS_DEVICE(tram), &tram->reg_mem);
+    sysbus_mmio_map(SYS_BUS_DEVICE(tram), 0, tram->baseaddr);
+
+    g_assert(tram->smemsize > 0);
+    tram->msgs = g_malloc0(tram->smemsize);
+
+    memory_region_init_io(&tram->smem, OBJECT(dev),
+                          &tr_ramsink_smemops, tram,
+                          "trace-ram-sink-smem",
+                          tram->smemsize);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &tram->smem);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, tram->smemaddr);
+
+    /* RegisterInfo init taken from hw/dma/xlnx-zdma.c */
+    for (int i = 0; i < ARRAY_SIZE(tr_ramsink_regs_info); i++) {
+        uint32_t reg_idx = tr_ramsink_regs_info[i].addr / 4;
+        RegisterInfo *r = &tram->regs_info[reg_idx];
+
+        *r = (RegisterInfo) {
+            .data = (uint8_t *)&tram->regs[reg_idx],
+            .data_size = sizeof(uint32_t),
+            .access = &tr_ramsink_regs_info[i],
+            .opaque = tram,
+        };
+    }
+}
+
+static const Property tr_ramsink_props[] = {
+    DEFINE_PROP_UINT64("baseaddr", TraceRamSink, baseaddr, 0),
+    DEFINE_PROP_UINT64("smemaddr", TraceRamSink, smemaddr, 0),
+    DEFINE_PROP_UINT32("smemsize", TraceRamSink, smemsize, 0),
+    DEFINE_PROP_UINT32("reg-mem-size", TraceRamSink,
+                       reg_mem_size, TR_DEV_REGMAP_SIZE),
+};
+
+static const VMStateDescription vmstate_tr_ramsink = {
+    .name = TYPE_TRACE_RAM_SINK,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, TraceRamSink, TRACE_R_MAX),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
+static void tr_ramsink_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, tr_ramsink_reset);
+    device_class_set_props(dc, tr_ramsink_props);
+    dc->realize = tr_ramsink_realize;
+    dc->vmsd = &vmstate_tr_ramsink;
+}
+
+static const TypeInfo tr_ramsink_info = {
+    .name          = TYPE_TRACE_RAM_SINK,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TraceRamSink),
+    .class_init    = tr_ramsink_class_init,
+};
+
+static void tr_ramsink_register_types(void)
+{
+    type_register_static(&tr_ramsink_info);
+}
+
+type_init(tr_ramsink_register_types)
diff --git a/hw/riscv/trace-ram-sink.h b/hw/riscv/trace-ram-sink.h
new file mode 100644
index 0000000000..99e49496df
--- /dev/null
+++ b/hw/riscv/trace-ram-sink.h
@@ -0,0 +1,83 @@
+/*
+ * Emulation of a RISC-V Trace RAM Sink
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef RISCV_TRACE_RAM_SINK_H
+#define RISCV_TRACE_RAM_SINK_H
+
+#include "hw/core/register.h"
+#include "hw/core/sysbus.h"
+#include "system/dma.h"
+#include "qom/object.h"
+
+#define TRACE_R_MAX (0xFFF / 4)
+#define TR_DEV_REGMAP_SIZE 0x1000
+
+/*
+ * The Trace Encoder will read/write those regs so put their
+ * declaration in this header.
+ */
+REG32(TR_RAM_CONTROL, 0x0)
+    FIELD(TR_RAM_CONTROL, ACTIVE, 0, 1)
+    FIELD(TR_RAM_CONTROL, ENABLE, 1, 1)
+    FIELD(TR_RAM_CONTROL, EMPTY, 3, 1)
+    FIELD(TR_RAM_CONTROL, MODE, 4, 1)
+    FIELD(TR_RAM_CONTROL, STOP_ON_WRAP, 8, 1)
+    FIELD(TR_RAM_CONTROL, MEM_FORMAT, 9, 2)
+    /* reserved bits */
+    FIELD(TR_RAM_CONTROL, RSVP1, 2, 1)
+    FIELD(TR_RAM_CONTROL, RSVP2, 5, 2)
+    FIELD(TR_RAM_CONTROL, RSVP3, 11, 1)
+    FIELD(TR_RAM_CONTROL, RSVP4, 15, 16)
+
+REG32(TR_RAM_IMPL, 0x4)
+    FIELD(TR_RAM_IMPL, VER_MAJOR, 0, 4)
+    FIELD(TR_RAM_IMPL, VER_MINOR, 4, 4)
+    FIELD(TR_RAM_IMPL, COMP_TYPE, 8, 4)
+    FIELD(TR_RAM_IMPL, HAS_SRAM, 12, 1)
+    FIELD(TR_RAM_IMPL, HAS_SMEM, 13, 1)
+    /* reserved bits */
+    FIELD(TR_RAM_IMPL, RSVP1, 14, 18)
+
+REG32(TR_RAM_START_LOW, 0x010)
+    FIELD(TR_RAM_START_LOW, ADDR, 2, 30)
+REG32(TR_RAM_START_HIGH, 0x014)
+    FIELD(TR_RAM_START_HIGH, ADDR, 0, 32)
+
+REG32(TR_RAM_LIMIT_LOW, 0x018)
+    FIELD(TR_RAM_LIMIT_LOW, ADDR, 2, 30)
+REG32(TR_RAM_LIMIT_HIGH, 0x01C)
+    FIELD(TR_RAM_LIMIT_HIGH, ADDR, 0, 32)
+
+REG32(TR_RAM_WP_LOW, 0x020)
+    FIELD(TR_RAM_WP_LOW, WRAP, 0, 1)
+    FIELD(TR_RAM_WP_LOW, ADDR, 2, 30)
+REG32(TR_RAM_WP_HIGH, 0x024)
+    FIELD(TR_RAM_WP_HIGH, ADDR, 0, 32)
+
+struct TraceRamSink {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    MemoryRegion reg_mem;
+    uint32_t reg_mem_size;
+
+    hwaddr baseaddr;
+    uint32_t regs[TRACE_R_MAX];
+    RegisterInfo regs_info[TRACE_R_MAX];
+
+    hwaddr smemaddr;
+    MemoryRegion smem;
+    uint32_t smemsize;
+    uint8_t *msgs;
+};
+
+#define TYPE_TRACE_RAM_SINK "trace-ram-sink"
+
+OBJECT_DECLARE_SIMPLE_TYPE(TraceRamSink, TRACE_RAM_SINK)
+
+#endif
-- 
2.43.0


