Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5E4F417EE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbv7-0001e7-Cp; Mon, 09 Mar 2026 10:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbv2-0001Po-Ph
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbv0-0005JD-8d
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:16 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629EXqxP830393
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e7dB0VJHYF9dygD6xMW1qLGZRHJ91/vei7amNo9XKao=; b=QEnZO/ONVH0UpNd6
 g5n2U4iixYoxdekwiYOxUTg0WTkl76h1Xj9NAnz2g3It0PHi78/sxlIoCLkcT5+g
 NwT4HjdPImYmU8/pmr/v/E6H1rTAEFqL+wjZEUqK/f5cvVpBRpPOSYAFb33ELV0l
 R043fBx9aDGqXaeUjjzB0by1J2HR12ZJCiBE6XJFuTDS5Ll5C449z/trtfFpUn0R
 oOA+NrDkpV9sUvaHwQmoMdGPgnXzxVjf3yM2WMfhLoptu291R1SsyGMWO+I1QtEu
 lzpWMAibARHTPMCSmBu3sJ9i6sD6WNkbekTsVkExeQ3MJT9t8aSWa6DEqpTHCIK3
 eWNY+g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct03282d5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:49:02 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2be21146933so10002590eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067742; x=1773672542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e7dB0VJHYF9dygD6xMW1qLGZRHJ91/vei7amNo9XKao=;
 b=AGdBu4QRoKpYctDEEDvfz66gMVkLLauc0UBUrNEbr7s4Sf8G2TdRK0mzAFUZTCwXMG
 Td+K8m1xf+RSlTEoPXUh47ALBUqd+fFiYFnoMb/lH98CEyEEhxwXrGi/xmNYRI18yNcq
 2UPx2xWAK22Aw264tVW6Cbg1kXZJsnyaVG3hisGODHgLMzj3bYhhQ2xES7tcaTBljxEc
 oREveknzCGN36qJN4uTq4Gr7jQEaWeFlvc2Qb1uddb1MhKS0z/LNY2ePAeYmAWlbdkGM
 8fplv6k4Otz4vky7GlLKqn3hi48792duCtkCkKyT/jy2P3HiOqNlXs0AdBHS7th0rZRu
 Oeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067742; x=1773672542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e7dB0VJHYF9dygD6xMW1qLGZRHJ91/vei7amNo9XKao=;
 b=Sf91ehws9OTIr+KyRSbp8FMVANYbPrLPSsXWDcC2RbzRvXgjMi73++VU8gVIaFVH+3
 kp+rJhcM/PMQdUgeyRBO38a1IGTUvMCtCcyDAGjCoLkLQczhcjnMli6YnUxxqbqxe6bo
 8FqetH9y9B377ZYJ180TY7MvFhKBrL0RkGWnGjDITg+0+fdS/R5LXuPQY/3bVq4nCnlz
 GBnODPwRY3bajLLuDtfR+0lw7wDrP3c0GeTpEReIAP1aoqV0USH48szIW198xN+5YnlY
 WEK9EM2lh8W7OSoO0G/zzB+ItWISN2yNwho752qR079yuRc1fRH3bAw1rSsZQM6m8hzs
 wrRQ==
X-Gm-Message-State: AOJu0YzVDuyHELQYltCX/z5oqrEvGv2jCtBF8Z9/r35QN01IZl63dxhz
 9K74dPZIGuySd6lCNEcCXxUGRUIKO5uBX1IGQpQvLcQt2Cyv8g+nOMHdkOIJZjO2ZMT6OryhgSX
 PXxIx553CT+hrm2T3acCVrsKsVkprLLX7eIL1NGWTFGmuKRc8zNtrEyDJmaQ2nV4xIw==
X-Gm-Gg: ATEYQzxWC7b1ePHofmjysXp4Fmu1E52TNobYAXkBhVvUd/olnBoJdWAFgtwtwY9v4yj
 fVRNy7WkncTHGXs6I6x8pfV1jl2UBdoGwWB4T5xs3pOupvjWhWobUgN9rJPY4jb8KZGqkW4ipyG
 O/NLCjcqSArcSbdjC6CB30Bg/BPWNZXAZRygcGAIKccl1cOmAa2z/Pv3JC224ao6amH3KxT4mhh
 BW9UVJ0umiiiEKgK0rKLqnOdX3zknN/sSQg60qy14KY78BdylPVKDX+Zq1YK8vgeeTC2gL7aqI2
 rUDugkNgB/6TpsgiohtwffR2WpDuRU8XlfboyGUsU8hKwUHvZwnnsh2JJ3zWNO8bBJSZxIooeJi
 fOj6EE32DqhEC2lHlSIIC/cE96SsJlHkr/uGK2QIK5eqel4sTcfZIsAKukf8IYy/VIZZ3xA==
X-Received: by 2002:a05:7300:a985:b0:2be:10a6:647e with SMTP id
 5a478bee46e88-2be4e055786mr4196755eec.19.1773067741536; 
 Mon, 09 Mar 2026 07:49:01 -0700 (PDT)
X-Received: by 2002:a05:7300:a985:b0:2be:10a6:647e with SMTP id
 5a478bee46e88-2be4e055786mr4196723eec.19.1773067740750; 
 Mon, 09 Mar 2026 07:49:00 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:49:00 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v4 31/35] hw/hexagon: Introduce hexagon TLB device
Date: Mon,  9 Mar 2026 07:48:18 -0700
Message-Id: <20260309144822.877695-32-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfXzHvO/QpKzofF
 Bo6P6ARW0wUMj3TxvLXg/0wUFaz/xPWnn18VepmEsboKuAZmsjvndw40o6Qgs4K/TQeMjYBTuRt
 tMnXhq1cZMnG/+JDHP9RIb60nxsbqC07u+ms9PoRuLHnSiFjoZCrqe2CkCJ1dA0TOYifAh9dtU0
 KhAYk9YXSpAsik7fHo/4NfhjwHHaZuxqpeLrJr4ZA2nGQR3rTpCMSiMS85BGLiuQUHJBuazfanI
 sdNucaDWlMeKtbG2/5eM+5MXDgvwn55rwRgPAZz3ijAjfeY+V/VK+Epo5V7jMvTX1dO3vpWJj+I
 FiGFnjQB9ZjDlnPGnuJQC4LAWJXchreAby13pp8aTzRojhmQ2uHvxMo1hFw16s1lViLaGQ+qTM+
 QZEdeUqxdI+Uj01p2AulDVlzkz1jpodEZzoKOdenjcdDjY7NTEKaAwDtkYb9bU5NyIC7NKaeHvc
 6VA4aV7OehPDpSuwmoA==
X-Proofpoint-ORIG-GUID: FHEDVsjjXAsvWJD_Er_e83hI_7xs1Nea
X-Proofpoint-GUID: FHEDVsjjXAsvWJD_Er_e83hI_7xs1Nea
X-Authority-Analysis: v=2.4 cv=WtEm8Nfv c=1 sm=1 tr=0 ts=69aeddde cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=sP_loDDXlKxngBex9BIA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add the hexagon TLB QOM device model.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 include/hw/hexagon/hexagon_tlb.h |  45 +++
 target/hexagon/cpu.h             |   4 +
 hw/hexagon/hexagon_tlb.c         | 463 +++++++++++++++++++++++++++++++
 target/hexagon/cpu.c             |   5 +
 4 files changed, 517 insertions(+)
 create mode 100644 include/hw/hexagon/hexagon_tlb.h
 create mode 100644 hw/hexagon/hexagon_tlb.c

diff --git a/include/hw/hexagon/hexagon_tlb.h b/include/hw/hexagon/hexagon_tlb.h
new file mode 100644
index 00000000000..bcb387aa24d
--- /dev/null
+++ b/include/hw/hexagon/hexagon_tlb.h
@@ -0,0 +1,45 @@
+/*
+ * Hexagon TLB QOM Device
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_HEXAGON_TLB_H
+#define HW_HEXAGON_TLB_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+#include "exec/hwaddr.h"
+#include "exec/mmu-access-type.h"
+#define TYPE_HEXAGON_TLB "hexagon-tlb"
+OBJECT_DECLARE_SIMPLE_TYPE(HexagonTLBState, HEXAGON_TLB)
+
+struct HexagonTLBState {
+    SysBusDevice parent_obj;
+
+    uint32_t num_entries;
+    uint64_t *entries;
+};
+
+uint64_t hexagon_tlb_read(HexagonTLBState *tlb, uint32_t index);
+void hexagon_tlb_write(HexagonTLBState *tlb, uint32_t index, uint64_t value);
+
+bool hexagon_tlb_find_match(HexagonTLBState *tlb, uint32_t asid,
+                            uint32_t VA, MMUAccessType access_type,
+                            hwaddr *PA, int *prot, uint64_t *size,
+                            int32_t *excp, int *cause_code, int mmu_idx);
+
+uint32_t hexagon_tlb_lookup(HexagonTLBState *tlb, uint32_t asid,
+                            uint32_t VA, int *cause_code);
+
+int hexagon_tlb_check_overlap(HexagonTLBState *tlb, uint64_t entry,
+                              uint64_t index);
+
+void hexagon_tlb_dump(HexagonTLBState *tlb);
+
+bool hexagon_tlb_dump_entry(FILE *f, uint64_t entry);
+
+uint32_t hexagon_tlb_get_num_entries(HexagonTLBState *tlb);
+
+#endif /* HW_HEXAGON_TLB_H */
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index b40a1c96eae..0c00feb0469 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -46,6 +46,7 @@
 #define REG_WRITES_MAX 32
 #define PRED_WRITES_MAX 5                   /* 4 insns + endloop */
 #define VSTORES_MAX 2
+#define MAX_TLB_ENTRIES 1024
 
 #define CPU_RESOLVING_TYPE TYPE_HEXAGON_CPU
 #ifndef CONFIG_USER_ONLY
@@ -186,6 +187,9 @@ struct ArchCPU {
     bool lldb_compat;
     target_ulong lldb_stack_adjust;
     bool short_circuit;
+#ifndef CONFIG_USER_ONLY
+    struct HexagonTLBState *tlb;
+#endif
 };
 
 #include "cpu_bits.h"
diff --git a/hw/hexagon/hexagon_tlb.c b/hw/hexagon/hexagon_tlb.c
new file mode 100644
index 00000000000..90f319f56d3
--- /dev/null
+++ b/hw/hexagon/hexagon_tlb.c
@@ -0,0 +1,463 @@
+/*
+ * Hexagon TLB QOM Device
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/hexagon/hexagon_tlb.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/resettable.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "target/hexagon/cpu.h"
+#include "target/hexagon/cpu_bits.h"
+
+/* PTE (TLB entry) field extraction */
+#define GET_PTE_PPD(entry)   extract64((entry),  0, 24)
+#define GET_PTE_C(entry)     extract64((entry), 24,  4)
+#define GET_PTE_U(entry)     extract64((entry), 28,  1)
+#define GET_PTE_R(entry)     extract64((entry), 29,  1)
+#define GET_PTE_W(entry)     extract64((entry), 30,  1)
+#define GET_PTE_X(entry)     extract64((entry), 31,  1)
+#define GET_PTE_VPN(entry)   extract64((entry), 32, 20)
+#define GET_PTE_ASID(entry)  extract64((entry), 52,  7)
+#define GET_PTE_ATR0(entry)  extract64((entry), 59,  1)
+#define GET_PTE_ATR1(entry)  extract64((entry), 60,  1)
+#define GET_PTE_PA35(entry)  extract64((entry), 61,  1)
+#define GET_PTE_G(entry)     extract64((entry), 62,  1)
+#define GET_PTE_V(entry)     extract64((entry), 63,  1)
+
+/* PPD (physical page descriptor) */
+static inline uint64_t GET_PPD(uint64_t entry)
+{
+    return GET_PTE_PPD(entry) | (GET_PTE_PA35(entry) << 24);
+}
+
+#define NO_ASID      (1 << 8)
+
+typedef enum {
+    PGSIZE_4K,
+    PGSIZE_16K,
+    PGSIZE_64K,
+    PGSIZE_256K,
+    PGSIZE_1M,
+    PGSIZE_4M,
+    PGSIZE_16M,
+    PGSIZE_64M,
+    PGSIZE_256M,
+    PGSIZE_1G,
+    NUM_PGSIZE_TYPES
+} tlb_pgsize_t;
+
+static const char *pgsize_str[NUM_PGSIZE_TYPES] = {
+    "4K",
+    "16K",
+    "64K",
+    "256K",
+    "1M",
+    "4M",
+    "16M",
+    "64M",
+    "256M",
+    "1G",
+};
+
+#define INVALID_MASK 0xffffffffLL
+
+static const uint64_t encmask_2_mask[] = {
+    0x0fffLL,                           /* 4k,   0000 */
+    0x3fffLL,                           /* 16k,  0001 */
+    0xffffLL,                           /* 64k,  0010 */
+    0x3ffffLL,                          /* 256k, 0011 */
+    0xfffffLL,                          /* 1m,   0100 */
+    0x3fffffLL,                         /* 4m,   0101 */
+    0xffffffLL,                         /* 16m,  0110 */
+    0x3ffffffLL,                        /* 64m,  0111 */
+    0xfffffffLL,                        /* 256m, 1000 */
+    0x3fffffffLL,                       /* 1g,   1001 */
+    INVALID_MASK,                       /* RSVD, 0111 */
+};
+
+static inline tlb_pgsize_t hex_tlb_pgsize_type(uint64_t entry)
+{
+    if (entry == 0) {
+        qemu_log_mask(CPU_LOG_MMU, "%s: Supplied TLB entry was 0!\n",
+                      __func__);
+        return 0;
+    }
+    tlb_pgsize_t size = ctz64(entry);
+    g_assert(size < NUM_PGSIZE_TYPES);
+    return size;
+}
+
+static inline uint64_t hex_tlb_page_size_bytes(uint64_t entry)
+{
+    return 1ull << (TARGET_PAGE_BITS + 2 * hex_tlb_pgsize_type(entry));
+}
+
+static inline uint64_t hex_tlb_phys_page_num(uint64_t entry)
+{
+    uint32_t ppd = GET_PPD(entry);
+    return ppd >> 1;
+}
+
+static inline uint64_t hex_tlb_phys_addr(uint64_t entry)
+{
+    uint64_t pagemask = encmask_2_mask[hex_tlb_pgsize_type(entry)];
+    uint64_t pagenum = hex_tlb_phys_page_num(entry);
+    uint64_t PA = (pagenum << TARGET_PAGE_BITS) & (~pagemask);
+    return PA;
+}
+
+static inline uint64_t hex_tlb_virt_addr(uint64_t entry)
+{
+    return (uint64_t)GET_PTE_VPN(entry) << TARGET_PAGE_BITS;
+}
+
+bool hexagon_tlb_dump_entry(FILE *f, uint64_t entry)
+{
+    if (GET_PTE_V(entry)) {
+        fprintf(f, "0x%016" PRIx64 ": ", entry);
+        uint64_t PA = hex_tlb_phys_addr(entry);
+        uint64_t VA = hex_tlb_virt_addr(entry);
+        fprintf(f, "V:%" PRId64 " G:%" PRId64
+                " A1:%" PRId64 " A0:%" PRId64,
+                GET_PTE_V(entry),
+                GET_PTE_G(entry),
+                GET_PTE_ATR1(entry),
+                GET_PTE_ATR0(entry));
+        fprintf(f, " ASID:0x%02" PRIx64 " VA:0x%08" PRIx64,
+                GET_PTE_ASID(entry), VA);
+        fprintf(f,
+                " X:%" PRId64 " W:%" PRId64 " R:%" PRId64
+                " U:%" PRId64 " C:%" PRId64,
+                GET_PTE_X(entry),
+                GET_PTE_W(entry),
+                GET_PTE_R(entry),
+                GET_PTE_U(entry),
+                GET_PTE_C(entry));
+        fprintf(f, " PA:0x%09" PRIx64 " SZ:%s (0x%" PRIx64 ")", PA,
+                pgsize_str[hex_tlb_pgsize_type(entry)],
+                hex_tlb_page_size_bytes(entry));
+        fprintf(f, "\n");
+        return true;
+    }
+
+    /* Not valid */
+    return false;
+}
+
+static inline bool hex_tlb_entry_match_noperm(uint64_t entry, uint32_t asid,
+                                              uint64_t VA)
+{
+    if (GET_PTE_V(entry)) {
+        if (GET_PTE_G(entry)) {
+            /* Global entry - ignore ASID */
+        } else if (asid != NO_ASID) {
+            uint32_t tlb_asid = GET_PTE_ASID(entry);
+            if (tlb_asid != asid) {
+                return false;
+            }
+        }
+
+        uint64_t page_size = hex_tlb_page_size_bytes(entry);
+        uint64_t page_start =
+            ROUND_DOWN(hex_tlb_virt_addr(entry), page_size);
+        if (page_start <= VA && VA < page_start + page_size) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static inline void hex_tlb_entry_get_perm(uint64_t entry,
+                                          MMUAccessType access_type,
+                                          int mmu_idx, int *prot,
+                                          int32_t *excp, int *cause_code)
+{
+    bool perm_x = GET_PTE_X(entry);
+    bool perm_w = GET_PTE_W(entry);
+    bool perm_r = GET_PTE_R(entry);
+    bool perm_u = GET_PTE_U(entry);
+    bool user_idx = mmu_idx == MMU_USER_IDX;
+
+    if (mmu_idx == MMU_KERNEL_IDX) {
+        *prot = PAGE_VALID | PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+        return;
+    }
+
+    *prot = PAGE_VALID;
+    switch (access_type) {
+    case MMU_INST_FETCH:
+        if (user_idx && !perm_u) {
+            *excp = HEX_EVENT_PRECISE;
+            *cause_code = HEX_CAUSE_FETCH_NO_UPAGE;
+        } else if (!perm_x) {
+            *excp = HEX_EVENT_PRECISE;
+            *cause_code = HEX_CAUSE_FETCH_NO_XPAGE;
+        }
+        break;
+    case MMU_DATA_LOAD:
+        if (user_idx && !perm_u) {
+            *excp = HEX_EVENT_PRECISE;
+            *cause_code = HEX_CAUSE_PRIV_NO_UREAD;
+        } else if (!perm_r) {
+            *excp = HEX_EVENT_PRECISE;
+            *cause_code = HEX_CAUSE_PRIV_NO_READ;
+        }
+        break;
+    case MMU_DATA_STORE:
+        if (user_idx && !perm_u) {
+            *excp = HEX_EVENT_PRECISE;
+            *cause_code = HEX_CAUSE_PRIV_NO_UWRITE;
+        } else if (!perm_w) {
+            *excp = HEX_EVENT_PRECISE;
+            *cause_code = HEX_CAUSE_PRIV_NO_WRITE;
+        }
+        break;
+    }
+
+    if (!user_idx || perm_u) {
+        if (perm_x) {
+            *prot |= PAGE_EXEC;
+        }
+        if (perm_r) {
+            *prot |= PAGE_READ;
+        }
+        if (perm_w) {
+            *prot |= PAGE_WRITE;
+        }
+    }
+}
+
+static inline bool hex_tlb_entry_match(uint64_t entry, uint8_t asid,
+                                       uint32_t VA,
+                                       MMUAccessType access_type, hwaddr *PA,
+                                       int *prot, uint64_t *size,
+                                       int32_t *excp, int *cause_code,
+                                       int mmu_idx)
+{
+    if (hex_tlb_entry_match_noperm(entry, asid, VA)) {
+        hex_tlb_entry_get_perm(entry, access_type, mmu_idx, prot, excp,
+                               cause_code);
+        *PA = hex_tlb_phys_addr(entry);
+        *size = hex_tlb_page_size_bytes(entry);
+        return true;
+    }
+    return false;
+}
+
+static bool hex_tlb_is_match(uint64_t entry1, uint64_t entry2,
+                             bool consider_gbit)
+{
+    bool valid1 = GET_PTE_V(entry1);
+    bool valid2 = GET_PTE_V(entry2);
+    uint64_t size1 = hex_tlb_page_size_bytes(entry1);
+    uint64_t vaddr1 = ROUND_DOWN(hex_tlb_virt_addr(entry1), size1);
+    uint64_t size2 = hex_tlb_page_size_bytes(entry2);
+    uint64_t vaddr2 = ROUND_DOWN(hex_tlb_virt_addr(entry2), size2);
+    int asid1 = GET_PTE_ASID(entry1);
+    int asid2 = GET_PTE_ASID(entry2);
+    bool gbit1 = GET_PTE_G(entry1);
+    bool gbit2 = GET_PTE_G(entry2);
+
+    if (!valid1 || !valid2) {
+        return false;
+    }
+
+    if (((vaddr1 <= vaddr2) && (vaddr2 < (vaddr1 + size1))) ||
+        ((vaddr2 <= vaddr1) && (vaddr1 < (vaddr2 + size2)))) {
+        if (asid1 == asid2) {
+            return true;
+        }
+        if ((consider_gbit && gbit1) || gbit2) {
+            return true;
+        }
+    }
+    return false;
+}
+
+/* Public API */
+
+uint64_t hexagon_tlb_read(HexagonTLBState *tlb, uint32_t index)
+{
+    g_assert(index < tlb->num_entries);
+    return tlb->entries[index];
+}
+
+void hexagon_tlb_write(HexagonTLBState *tlb, uint32_t index, uint64_t value)
+{
+    g_assert(index < tlb->num_entries);
+    tlb->entries[index] = value;
+}
+
+bool hexagon_tlb_find_match(HexagonTLBState *tlb, uint32_t asid,
+                            uint32_t VA, MMUAccessType access_type,
+                            hwaddr *PA, int *prot, uint64_t *size,
+                            int32_t *excp, int *cause_code, int mmu_idx)
+{
+    *PA = 0;
+    *prot = 0;
+    *size = 0;
+    *excp = 0;
+    *cause_code = 0;
+
+    for (uint32_t i = 0; i < tlb->num_entries; i++) {
+        if (hex_tlb_entry_match(tlb->entries[i], asid, VA, access_type,
+                                PA, prot, size, excp, cause_code, mmu_idx)) {
+            return true;
+        }
+    }
+    return false;
+}
+
+uint32_t hexagon_tlb_lookup(HexagonTLBState *tlb, uint32_t asid,
+                            uint32_t VA, int *cause_code)
+{
+    uint32_t not_found = 0x80000000;
+    uint32_t idx = not_found;
+
+    for (uint32_t i = 0; i < tlb->num_entries; i++) {
+        uint64_t entry = tlb->entries[i];
+        if (hex_tlb_entry_match_noperm(entry, asid, VA)) {
+            if (idx != not_found) {
+                *cause_code = HEX_CAUSE_IMPRECISE_MULTI_TLB_MATCH;
+                break;
+            }
+            idx = i;
+        }
+    }
+
+    if (idx == not_found) {
+        qemu_log_mask(CPU_LOG_MMU,
+                      "%s: 0x%" PRIx32 ", 0x%08" PRIx32 " => NOT FOUND\n",
+                      __func__, asid, VA);
+    } else {
+        qemu_log_mask(CPU_LOG_MMU,
+                      "%s: 0x%" PRIx32 ", 0x%08" PRIx32 " => %d\n",
+                      __func__, asid, VA, idx);
+    }
+
+    return idx;
+}
+
+/*
+ * Return codes:
+ * 0 or positive             index of match
+ * -1                        multiple matches
+ * -2                        no match
+ */
+int hexagon_tlb_check_overlap(HexagonTLBState *tlb, uint64_t entry,
+                              uint64_t index)
+{
+    int matches = 0;
+    int last_match = 0;
+
+    for (uint32_t i = 0; i < tlb->num_entries; i++) {
+        if (hex_tlb_is_match(entry, tlb->entries[i], false)) {
+            matches++;
+            last_match = i;
+        }
+    }
+
+    if (matches == 1) {
+        return last_match;
+    }
+    if (matches == 0) {
+        return -2;
+    }
+    return -1;
+}
+
+void hexagon_tlb_dump(HexagonTLBState *tlb)
+{
+    for (uint32_t i = 0; i < tlb->num_entries; i++) {
+        hexagon_tlb_dump_entry(stdout, tlb->entries[i]);
+    }
+}
+
+uint32_t hexagon_tlb_get_num_entries(HexagonTLBState *tlb)
+{
+    return tlb->num_entries;
+}
+
+/* QOM lifecycle */
+
+static void hexagon_tlb_init(Object *obj)
+{
+}
+
+static void hexagon_tlb_realize(DeviceState *dev, Error **errp)
+{
+    HexagonTLBState *s = HEXAGON_TLB(dev);
+
+    if (s->num_entries == 0 || s->num_entries > MAX_TLB_ENTRIES) {
+        error_setg(errp, "Invalid TLB num-entries: %" PRIu32,
+                   s->num_entries);
+        return;
+    }
+    s->entries = g_new0(uint64_t, s->num_entries);
+}
+
+static void hexagon_tlb_finalize(Object *obj)
+{
+    HexagonTLBState *s = HEXAGON_TLB(obj);
+    g_free(s->entries);
+    s->entries = NULL;
+}
+
+static void hexagon_tlb_reset_hold(Object *obj, ResetType type)
+{
+    HexagonTLBState *s = HEXAGON_TLB(obj);
+    if (s->entries) {
+        memset(s->entries, 0, sizeof(uint64_t) * s->num_entries);
+    }
+}
+
+static const VMStateDescription vmstate_hexagon_tlb = {
+    .name = "hexagon-tlb",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(num_entries, HexagonTLBState),
+        VMSTATE_VARRAY_UINT32_ALLOC(entries, HexagonTLBState, num_entries,
+                                    0, vmstate_info_uint64, uint64_t),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property hexagon_tlb_properties[] = {
+    DEFINE_PROP_UINT32("num-entries", HexagonTLBState, num_entries,
+                       MAX_TLB_ENTRIES),
+};
+
+static void hexagon_tlb_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = hexagon_tlb_realize;
+    rc->phases.hold = hexagon_tlb_reset_hold;
+    dc->vmsd = &vmstate_hexagon_tlb;
+    dc->user_creatable = false;
+    device_class_set_props(dc, hexagon_tlb_properties);
+}
+
+static const TypeInfo hexagon_tlb_info = {
+    .name = TYPE_HEXAGON_TLB,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(HexagonTLBState),
+    .instance_init = hexagon_tlb_init,
+    .instance_finalize = hexagon_tlb_finalize,
+    .class_init = hexagon_tlb_class_init,
+};
+
+static void hexagon_tlb_register_types(void)
+{
+    type_register_static(&hexagon_tlb_info);
+}
+
+type_init(hexagon_tlb_register_types)
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 2a061d70540..640369329dc 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -23,6 +23,7 @@
 #include "qapi/error.h"
 #include "hw/core/qdev-properties.h"
 #include "fpu/softfloat-helpers.h"
+#include "hw/hexagon/hexagon_tlb.h"
 #include "tcg/tcg.h"
 #include "exec/gdbstub.h"
 #include "accel/tcg/cpu-ops.h"
@@ -50,6 +51,10 @@ static ObjectClass *hexagon_cpu_class_by_name(const char *cpu_model)
 }
 
 static const Property hexagon_cpu_properties[] = {
+#if !defined(CONFIG_USER_ONLY)
+    DEFINE_PROP_LINK("tlb", HexagonCPU, tlb, TYPE_HEXAGON_TLB,
+                     HexagonTLBState *),
+#endif
     DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, lldb_compat, false),
     DEFINE_PROP_UNSIGNED("lldb-stack-adjust", HexagonCPU, lldb_stack_adjust, 0,
                          qdev_prop_uint32, target_ulong),
-- 
2.34.1


