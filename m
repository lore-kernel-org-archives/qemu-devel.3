Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC00606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 23:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FQtKqJDn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G1MRcBnk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJfVZ-0007RG-BI; Wed, 21 Oct 2026 19:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfVX-0007Qa-U8
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfVV-0004wV-13
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:07 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LN187Q1965390
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/4j4KU9Zz5+
 WmZ8NcRHf9UbKNnEsiYjiuyOU8fX+qEk=; b=FQtKqJDnUbIyYy8tbdIz1w9TTuk
 AO9rDBzRu7xwNakFrqrgTaHtsWsmWMPKsSww3Gyw2S+c2lGCT7/8ITMehVzG4UVq
 9XpdSfZY3PmZUh0pwK8WKMDx/PMjLMHGeDC5JCUzB/bRfImKeEJkH+Bj+NiOLs5z
 7nM73NfJUO/fFHQ+H6IUeV5rBE66lY6XS24YURhqd37eqvdjdyuogezyDECFecC2
 zAAX/avHGEq6f3ltUymBCJJQlZu/tX0BHgSY0Dabuh916XwAKfc+NZFllYK0lnE0
 hJK4uq7DMQXiRPoDG6HxFhCPGqvXjNWw2EaFb/iShvmESM4FlvpOhg0r62Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf2cq0xv3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-53664911d46so39786861cf.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792624443; x=1793229243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/4j4KU9Zz5+WmZ8NcRHf9UbKNnEsiYjiuyOU8fX+qEk=;
 b=G1MRcBnkxQQw6SwaHj/FVchK7to7M/SbPQf5PmDeTYDtZ2euhShsQCrt3A8nZSMPoK
 cqBidov36jod/3gEfufEjT9KNH5mreMc9cMvO3Ps2nCVtz8vsbqjtAoUECUBzcCmu4MP
 1krs3+8xpWLZGenjiBajqNuASKm7T5MDCvsY9OQ0Uyl4WCw75LvRvYQjE3F3z5WGCQcg
 BV+0SeJTmxUuRS0kWM9P2ATn3+QEgEw5kK07RgKV0Dy5oPa64ZKViDrBPAKakR7gSKzj
 koq0oDcb0wFndlsu4A3XNN8W5JJdMPHTJJKYFkAc5+JK8ixMDJTqyrGldXfMYqB1qW70
 740w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792624443; x=1793229243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/4j4KU9Zz5+WmZ8NcRHf9UbKNnEsiYjiuyOU8fX+qEk=;
 b=chRVET2xCitiYPh9Y2LdfZ3kODVwQYJ6KktzoKccAYviQOcoNqacj+Jk8LFdJYMwTf
 UZtvILGGOKKDXGAJOaHjvdWOCGQ58wrA2Oad7NZSIw47aZgMG35etbIXgmoY1fphUV9j
 /HQnBXxfKGI443EyZVSkv3HNliawo5evas34V0pcsd5mUIhlfrjx/WbVFK0VD8E3homX
 XwNZfJZjRAx/OCFF2v8gFAICVjmRPzUgmv5RiGpTZfnurG9Swgt2yiZeCNclUcT41qb3
 8zHIbvvrqcV95rEoJv3zq32pIog6gudljyNz+kvu9fO2niDHv4T6f7u7n4adJqItUG8O
 pnvA==
X-Gm-Message-State: AFq9FYKA8y4lytOt2vE19eHuEA9BFz04W7wRZulSmkBw1Z5oIQXEn9pX
 3+bceRd0qOZreCwKY34AojAREx2almB4JvG1YEWpKL8O5K/2IexuFFKUxhtkhfg3ZC4Oe03PDL1
 4J2J4BfANInLSghHTi5GGKWMqJVMt+oqWxiqxZvH1Oky19ulmuKcvb0iTy7IJYsBQ/g==
X-Gm-Gg: AYBFou2AYLaofaugHvIqelvrhOP/HyT96+3VVQ4AFL0DIhTsYxsYDLeyQMkv7VixUhF
 2XuBnsVwS5XLkOy0l86hEQToZ2zY6V1ZacLSmWjtvidZ13GgQkcQTl2ZjyScOsph0Djphl5w2ZR
 vDRA5/sJ0Dg5+Emm1C6PN7TkGhl/vj4kn93Hx1WwnK/RcDtgLIunWdIP1oagSCO5cxwP3SfktfM
 qs3Hh6jEkVNj6DNA9ZEHq8tUHv6Wef8dSc+FFr3skoGx9WdX8o7WuTgYb+LA/dwbr0jaVc2GwBu
 QAKpS6s9kmeqCWQoL4VcDY2nIqfPvCPwNTcU4RUyaPq3/W5NkGVmHJ8ok5EiGF181pLis1IL1Aj
 c0tXF62XURn6SfKARUs1pl5mg6b08xnj/oMYFrobIMVuFOugzykapeVaHdQ4mQTjbJAyvGspEzw
 ==
X-Received: by 2002:a05:622a:303:b0:535:e0d5:f3ac with SMTP id
 d75a77b69052e-5369b84cd4cmr56902681cf.54.1792624443103; 
 Wed, 21 Oct 2026 16:14:03 -0700 (PDT)
X-Received: by 2002:a05:622a:303:b0:535:e0d5:f3ac with SMTP id
 d75a77b69052e-5369b84cd4cmr56902041cf.54.1792624442376; 
 Wed, 21 Oct 2026 16:14:02 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com
 (200-204-190-237.dsl.telesp.net.br. [200.204.190.237])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536ab6cd0dcsm11995651cf.6.2026.10.21.16.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 16:14:01 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 antikostya2@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 01/18] hw/riscv: Trace Encoder initial impl
Date: Wed, 21 Oct 2026 20:13:28 -0300
Message-ID: <20261021231346.2452179-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HLhWhYtv c=1 sm=1 tr=0 ts=6ad9473b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=V1jnuoLLAAAA:20
 a=EUspDBNiAAAA:8 a=-aNep1E3OyYegnQbF9QA:9 a=dawVfQjAaf238kedN5IG:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: oUBHG-ehW4MnhCIhFjvsHB2CR6wexXpw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX8KwOB8fqxdYh
 Vf5+xAsR9EGN4MTgEfSsCp/FnHBfhsHqKp4pkW1A/gmpqUVgSBd2lzwBvqdR/Y8paArh2P6AciL
 oHmIgNPWEGVblu9Rk8cFzFLtVQooYKI=
X-Proofpoint-ORIG-GUID: oUBHG-ehW4MnhCIhFjvsHB2CR6wexXpw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX6eid1bcJVuRf
 LUHq7Kjcvo56qWYV7WIsyvLMzM+0ekrOrDcvDzi0Q/sYwpnpaXoKnldcphjtRtzVUXsB+YGxbVZ
 hvx43O5czJfX9pPZ0u4a1L0qJxbujlZRK3n8Me9xM4HhvcfLvXXYbZsPWB++PgKTKEOBrsmJTDo
 RD4mqcb4mjk9cFcFRAxYGKdeyrw7kHb4DDhoQ1yNLSjD4cd/Mwb1oVpVoaT7xy1oJZQZgcGIow/
 grwDMGql1nHXeEYBV5BvKdKrc5oGMnXpEkMFqRSWFAO1GjvmbdhLNFFHedoaHqhbQfWQyjGwY+w
 z1uQz27tWNTOMNm04Ipv9nKnjeiW53C253DkqZ1LMNMotoXSxTJyObYdUYnextTzsuOWqog5eIm
 nmdJ1ral1Tpgz/KJ9hj9P7v3gHawnyuG3mZKPNwPy7m+nanA/mGE0zhNPEDz6OAZQySdSL+CCtz
 SJbXVu9jLmX+/Ya5V0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
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

The Trace Encoder is a hardware module that interacts with a CPU,
gathering execution information (a.k.a instruction delta trace), and
send it downstream to other storage components such as a RAM Sink (a RAM
storage). This trace info can then be read via software (e.g. perf) to
reproduce the behavior of a given binary that ran in the CPU.

This implementation is based on the Efficient Trace for RISC-V [1] and
RISC-V Trace Control Interface Specification [2]. It's not intended to
implement all spec features: the idea is to provide a base where we can
add extra features on demand.

We'll get back to the instruction delta trace and how we'll instrument
TCG to produce it later. For now we'll set the minimal components to get
the basic framework running.

This Trace Encoder impl has just the minimal bits specified in [2],
section "Minimal Implementation". RO and RSVP bits are taken verbatim
from [2] without considering what we're actually going to support. The
base impl is heavily inspired by the XLNZ-ZDMA device w.r.t the usage of
the RegisterInfo and register.h framework.

Discovery of the Trace Encoder will be made via fdt, a single entry per
CPU. We'll connect each Trace Encoder to its CPU in the 'virt' board
later.

[1] https://github.com/riscv-non-isa/riscv-trace-spec/releases/download/v2.0-20250616/riscv-trace-spec-asciidoc.pdf
[2] https://github.com/riscv-non-isa/tg-nexus-trace/releases/download/1.0_Ratified/RISC-V-Trace-Control-Interface.pdf

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/Kconfig         |   5 +
 hw/riscv/meson.build     |   2 +-
 hw/riscv/trace-encoder.c | 216 +++++++++++++++++++++++++++++++++++++++
 hw/riscv/trace-encoder.h |  42 ++++++++
 hw/riscv/trace-events    |   4 +
 5 files changed, 268 insertions(+), 1 deletion(-)
 create mode 100644 hw/riscv/trace-encoder.c
 create mode 100644 hw/riscv/trace-encoder.h

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index fb05031228..9f241d1273 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -7,6 +7,10 @@ config RISCV_NUMA
 config IBEX
     bool
 
+config RISCV_TRACE
+    bool
+    select REGISTER
+
 # RISC-V machines in alphabetical order
 
 config MICROCHIP_PFSOC
@@ -68,6 +72,7 @@ config RISCV_VIRT
     select PLATFORM_BUS
     select ACPI
     select ACPI_PCI
+    select RISCV_TRACE
 
 config RISCV_SERVER_PLATFORM_REF
     bool
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 6bdabb9544..1238cb3e1a 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -22,7 +22,7 @@ riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c
 riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
 riscv_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('boston-aia.c'))
 riscv_ss.add(when: 'CONFIG_K230', if_true: files('k230.c'))
-
+riscv_ss.add(when: 'CONFIG_RISCV_TRACE', if_true: files('trace-encoder.c'))
 riscv_ss.add(when: 'CONFIG_SOPHGO_CV1800B', if_true: files('cv1800b.c'))
 riscv_ss.add(when: 'CONFIG_MILKV_DUO', if_true: files('milkv_duo.c'))
 
diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
new file mode 100644
index 0000000000..19ab785334
--- /dev/null
+++ b/hw/riscv/trace-encoder.c
@@ -0,0 +1,216 @@
+/*
+ * Emulation of a RISC-V Trace Encoder
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "trace-encoder.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "trace.h"
+#include "system/device_tree.h"
+#include "hw/core/register.h"
+#include "cpu.h"
+
+/*
+ * trTeControl register fields
+ */
+REG32(TR_TE_CONTROL, 0x0)
+    FIELD(TR_TE_CONTROL, ACTIVE, 0, 1)
+    FIELD(TR_TE_CONTROL, ENABLE, 1, 1)
+    FIELD(TR_TE_CONTROL, INST_TRACING, 2, 1)
+    FIELD(TR_TE_CONTROL, EMPTY, 3, 1)
+    FIELD(TR_TE_CONTROL, INST_MODE, 4, 3)
+    FIELD(TR_TE_CONTROL, INST_SYNC_MODE, 16, 2)
+    FIELD(TR_TE_CONTROL, FORMAT, 24, 3)
+    /* reserved bits */
+    FIELD(TR_TE_CONTROL, RSVP1, 7, 2)
+    FIELD(TR_TE_CONTROL, RSVP2, 10, 1)
+    FIELD(TR_TE_CONTROL, RSVP3, 14, 1)
+    FIELD(TR_TE_CONTROL, RSVP4, 18, 2)
+    FIELD(TR_TE_CONTROL, RSVP5, 27, 4)
+
+#define R_TR_TE_CONTROL_RSVP_BITS (MAKE_64BIT_MASK(32, 32) | \
+                                   R_TR_TE_CONTROL_RSVP1_MASK | \
+                                   R_TR_TE_CONTROL_RSVP2_MASK | \
+                                   R_TR_TE_CONTROL_RSVP3_MASK | \
+                                   R_TR_TE_CONTROL_RSVP4_MASK | \
+                                   R_TR_TE_CONTROL_RSVP5_MASK)
+
+/* trTeControlEmpty is the only RO field and reset value */
+#define R_TR_TE_CONTROL_RESET R_TR_TE_CONTROL_EMPTY_MASK
+#define R_TR_TE_CONTROL_RO_BITS R_TR_TE_CONTROL_EMPTY_MASK
+
+/*
+ * trTeImpl register fields
+ */
+REG32(TR_TE_IMPL, 0x4)
+    FIELD(TR_TE_IMPL, VER_MAJOR, 0, 4)
+    FIELD(TR_TE_IMPL, VER_MINOR, 4, 4)
+    FIELD(TR_TE_IMPL, COMP_TYPE, 8, 4)
+    FIELD(TR_TE_IMPL, PROTOCOL_MAJOR, 16, 4)
+    FIELD(TR_TE_IMPL, PROTOCOL_MINOR, 20, 4)
+    /* reserved bits */
+    FIELD(TR_TE_IMPL, RSVP1, 12, 4)
+    FIELD(TR_TE_IMPL, RSVP2, 24, 8)
+
+#define R_TR_TE_IMPL_RSVP_BITS (MAKE_64BIT_MASK(32, 32) | \
+                                R_TR_TE_IMPL_RSVP1_MASK | \
+                                R_TR_TE_IMPL_RSVP2_MASK)
+
+#define R_TR_TE_IMPL_RO_BITS (R_TR_TE_IMPL_VER_MAJOR_MASK | \
+                              R_TR_TE_IMPL_VER_MINOR_MASK | \
+                              R_TR_TE_IMPL_COMP_TYPE_MASK | \
+                              R_TR_TE_IMPL_PROTOCOL_MAJOR_MASK | \
+                              R_TR_TE_IMPL_PROTOCOL_MINOR_MASK)
+
+#define R_TR_TE_IMPL_RESET (BIT(0) | BIT(8))
+
+static RegisterAccessInfo trencoder_regs_info[] = {
+    {   .name = "TR_TE_CONTROL", .addr = A_TR_TE_CONTROL,
+        .rsvd = R_TR_TE_CONTROL_RSVP_BITS,
+        .reset = R_TR_TE_CONTROL_RESET,
+        .ro = R_TR_TE_CONTROL_RO_BITS,
+    },
+    {   .name = "TR_TE_IMPL", .addr = A_TR_TE_IMPL,
+        .rsvd = R_TR_TE_IMPL_RSVP_BITS,
+        .reset = R_TR_TE_IMPL_RESET,
+        .ro = R_TR_TE_IMPL_RO_BITS,
+    },
+};
+
+static uint64_t trencoder_read(void *opaque, hwaddr addr, unsigned size)
+{
+    TraceEncoder *te = TRACE_ENCODER(opaque);
+    RegisterInfo *r = &te->regs_info[addr / 4];
+
+    if (!r->data) {
+        trace_trencoder_read_error(addr);
+        return 0;
+    }
+
+    return register_read(r, ~0, NULL, false);
+}
+
+static void trencoder_write(void *opaque, hwaddr addr,
+                            uint64_t value, unsigned size)
+{
+    TraceEncoder *te = TRACE_ENCODER(opaque);
+    RegisterInfo *r = &te->regs_info[addr / 4];
+
+    if (!r->data) {
+        trace_trencoder_write_error(addr, value);
+        return;
+    }
+
+    register_write(r, value, ~0, NULL, false);
+}
+
+static const MemoryRegionOps trencoder_ops = {
+    .read = trencoder_read,
+    .write = trencoder_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void trencoder_reset(DeviceState *dev)
+{
+    TraceEncoder *te = TRACE_ENCODER(dev);
+
+    for (int i = 0; i < ARRAY_SIZE(te->regs_info); i++) {
+        register_reset(&te->regs_info[i]);
+    }
+}
+
+static void trencoder_realize(DeviceState *dev, Error **errp)
+{
+    TraceEncoder *te = TRACE_ENCODER(dev);
+
+    memory_region_init_io(&te->reg_mem, OBJECT(dev),
+                          &trencoder_ops, te,
+                          TYPE_TRACE_ENCODER,
+                          te->reg_mem_size);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &te->reg_mem);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, te->baseaddr);
+
+    /* RegisterInfo init taken from hw/dma/xlnx-zdma.c */
+    for (int i = 0; i < ARRAY_SIZE(trencoder_regs_info); i++) {
+        uint32_t reg_idx = trencoder_regs_info[i].addr / 4;
+        RegisterInfo *r = &te->regs_info[reg_idx];
+
+        *r = (RegisterInfo) {
+            .data = (uint8_t *)&te->regs[reg_idx],
+            .data_size = sizeof(uint32_t),
+            .access = &trencoder_regs_info[i],
+            .opaque = te,
+        };
+    }
+}
+
+static const Property trencoder_props[] = {
+    /*
+     * We need a link to the associated CPU to
+     * enable/disable tracing.
+     */
+    DEFINE_PROP_LINK("cpu", TraceEncoder, cpu, TYPE_RISCV_CPU, RISCVCPU *),
+    DEFINE_PROP_UINT64("baseaddr", TraceEncoder, baseaddr, 0),
+    DEFINE_PROP_UINT64("dest-baseaddr", TraceEncoder, dest_baseaddr, 0),
+    DEFINE_PROP_UINT64("ramsink-ramstart", TraceEncoder,
+                       ramsink_ramstart, 0),
+    DEFINE_PROP_UINT64("ramsink-ramlimit", TraceEncoder,
+                       ramsink_ramlimit, 0),
+    DEFINE_PROP_UINT32("reg-mem-size", TraceEncoder,
+                       reg_mem_size, TRACE_R_MAX * 4),
+    DEFINE_PROP_INT32("cpu-id", TraceEncoder, cpu_id, 0),
+};
+
+static const VMStateDescription vmstate_trencoder = {
+    .name = TYPE_TRACE_ENCODER,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, TraceEncoder, TRACE_R_MAX),
+        VMSTATE_UINT64(baseaddr, TraceEncoder),
+        VMSTATE_UINT64(dest_baseaddr, TraceEncoder),
+        VMSTATE_UINT64(ramsink_ramstart, TraceEncoder),
+        VMSTATE_UINT64(ramsink_ramlimit, TraceEncoder),
+        VMSTATE_INT32(cpu_id, TraceEncoder),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
+static void trencoder_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, trencoder_reset);
+    device_class_set_props(dc, trencoder_props);
+    dc->realize = trencoder_realize;
+    dc->vmsd = &vmstate_trencoder;
+}
+
+static const TypeInfo trencoder_info = {
+    .name          = TYPE_TRACE_ENCODER,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TraceEncoder),
+    .class_init    = trencoder_class_init,
+};
+
+static void trencoder_register_types(void)
+{
+    type_register_static(&trencoder_info);
+}
+
+type_init(trencoder_register_types)
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
new file mode 100644
index 0000000000..8978865663
--- /dev/null
+++ b/hw/riscv/trace-encoder.h
@@ -0,0 +1,42 @@
+/*
+ * Emulation of a RISC-V Trace Encoder
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef RISCV_TRACE_ENCODER_H
+#define RISCV_TRACE_ENCODER_H
+
+#include "hw/core/sysbus.h"
+#include "hw/core/register.h"
+#include "system/dma.h"
+#include "qom/object.h"
+#include "cpu.h"
+
+#define TRACE_R_MAX (0xFFF / 4)
+
+struct TraceEncoder {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    RISCVCPU *cpu;
+    int cpu_id;
+
+    MemoryRegion reg_mem;
+    uint32_t reg_mem_size;
+
+    hwaddr baseaddr;
+    hwaddr dest_baseaddr;
+    hwaddr ramsink_ramstart;
+    hwaddr ramsink_ramlimit;
+    uint32_t regs[TRACE_R_MAX];
+    RegisterInfo regs_info[TRACE_R_MAX];
+};
+
+#define TYPE_TRACE_ENCODER "trace-encoder"
+
+OBJECT_DECLARE_SIMPLE_TYPE(TraceEncoder, TRACE_ENCODER)
+
+#endif
diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
index b50b14a654..0cbf6ffcb6 100644
--- a/hw/riscv/trace-events
+++ b/hw/riscv/trace-events
@@ -24,3 +24,7 @@ riscv_iommu_hpm_incr_ctr(uint64_t cntr_val) "cntr_val 0x%"PRIx64
 riscv_iommu_hpm_iocntinh_cy(bool prev_cy_inh) "prev_cy_inh %d"
 riscv_iommu_hpm_cycle_write(uint32_t ovf, uint64_t val) "ovf 0x%x val 0x%"PRIx64
 riscv_iommu_hpm_evt_write(uint32_t ctr_idx, uint32_t ovf, uint64_t val) "ctr_idx 0x%x ovf 0x%x val 0x%"PRIx64
+
+# trace-encoder.c
+trencoder_read_error(uint64_t addr) "addr 0x%" PRIx64
+trencoder_write_error(uint64_t addr, uint64_t value) "addr 0x%" PRIx64 " value 0x%" PRIx64
-- 
2.43.0


