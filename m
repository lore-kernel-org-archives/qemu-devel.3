Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF8AC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wls01-0008DO-89; Mon, 20 Jul 2026 13:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wlrzU-00080d-Dt
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:41:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wlrzR-0002x7-FV
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:41:20 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KHBrWH3442633
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EFswy5eh2Ck
 Nrk+N8UM9hmPqBP0xTdauqnFywLbP7Ck=; b=cto2FXZH2DYC2XwINxLzJzJhoUS
 v+1them0LIR10scZEXETTWyPyHzUBd+AOUduek8ADFedfSAULsIErF8HbKn85ytt
 84j1du9A9SvH2XUs3/Gllj3o1v1wz4yWbOWh0aE1FDwMozmKlxkroq7I/4rg1f9t
 v10TCQhPuf0VUikQWT9HU/g/dIwEgRG+rKUGqyiFdpn9mxsfACDmYKWa9cd0oNq8
 VyrX6rSt8APyLyEBe7LrzXZIq7F1xRP4EOx8sQ9Z7DLTpA9GvV/lu7CXP/8dboFL
 59tvrWndRxUka3PCD+wZs296JM80QQPPSv32n0whSA+GmeKC9bK5zMs9GRw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqv5r46a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:41:16 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cee1ec30f2so95473905ad.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 10:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784569275; x=1785174075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EFswy5eh2CkNrk+N8UM9hmPqBP0xTdauqnFywLbP7Ck=;
 b=P+qAoZHqO9MMckEhapzEIUwlWpoTS8M9H+1bCA+bL0Kt14Nm/WEMGWf6zqf5YgE9vE
 BHuRDekXSVJJqx6YL7/TadUjJ2ANkzd2CirKjXCwVJrX03gw15urr19+qICYNBOAZa2W
 Etnms+d3xwwCXpCLPe+Fa5RaAdAVGZh1GVSNJhKGTpT2LpYrYKI2tlEpyBfn5np/0dfH
 iHj7FUydlFy6I/DpGamjq8Yk917LTtDFPdtQF5reMpuUcqbhjmQEVsWHjSh0K4KZjaxc
 nrieveylae7RcL5YUTSY/D3ujMadJYvv4GboAgw9TZxC0T8/PZDEvWGgl9DyVh7/KWVE
 KccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784569275; x=1785174075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EFswy5eh2CkNrk+N8UM9hmPqBP0xTdauqnFywLbP7Ck=;
 b=J2gUWJ/tfrKM/jg0PAzlg4PpcI7hdLxtfJRKbR+IIiaY0I8sqiZZnKgsUtXMVJeDJa
 zXVMExL2ZMyQrDkVVlmNtiJutzYMf8n1xewi/DfSsW07X+ZG+YPEe6dYj6pkLzve0GYj
 ahKVEpZUcvJgMiPrOijV/pYq7TqPsEEcXg28ms0EkznwU8OA/feU1xhMNc50g33PMHAA
 Q7uGZHgIFYKWmvVIoNEnlkBhHSX1MAZRIjo4F9eCzA9KOoYploM8InkjkbYIFymL+TXo
 l4F6qaTyPq1n4DSiUjQKeNFW1u9/BBHJ2ml7knnU6iRVgLI8322NAYRWxvyqr9WUFkrk
 EBrw==
X-Gm-Message-State: AOJu0YzIq4YKBhr5Qv0MIHvuvMzd0gNh62UAW+oClpSRdgdNHWBoBJaD
 Yh02+dIu7xbMBkRBaKec+txsy0Gw6fCsJ2R0sClVdDtUfir1pfNY8bCL2ri9/Yb/2NknDcjYC6H
 8JPrFRq++RPQjQyQl0qwj9V74lB4tm7THyUSAchzL1vCDBbWDIuhIzYk/fvhplM4nzQ==
X-Gm-Gg: AR+sD13rod4UHrDTudWtPzORtg28GobhDEeBhXKBj02XbYDiRcSJRxDtEtLgFJQqoCQ
 byZmf9HuQCr7/hp+35x5Nybvs10t3ByON5pT+15Em3Kts8qholf5iv1pMeKC8rvUwR8b+/+ZdTW
 Al3868HQIR9QRdfPBoFuvWJs7YvY8zAhrK+osZCZkBNmxFmD9GzgZMQhTijKej76R6QoZROAQTW
 hWiI1DopKm2esY7IWtmWk6H7TysdP8pJhirGgFErCEqxH4M3iJhy/gQnZvRbG/cke2to1jrwZzd
 JWdmt7NQaMi2/Bq8DiuTxBn9uOUV/IrDUfPYK8ZZRwZcRIcUMET0sDgXaqlkQmdWjpq0v/yOeAr
 CMd2XpVKQqzUpenSy5zvZBJuWxIrgh6OjlK2nNvSsEhK8/ozwSTadi0BzK8x5iYs=
X-Received: by 2002:a17:903:1aa4:b0:2bf:27b2:4b80 with SMTP id
 d9443c01a7336-2cf34873e2dmr157903325ad.14.1784569275092; 
 Mon, 20 Jul 2026 10:41:15 -0700 (PDT)
X-Received: by 2002:a17:903:1aa4:b0:2bf:27b2:4b80 with SMTP id
 d9443c01a7336-2cf34873e2dmr157902905ad.14.1784569274430; 
 Mon, 20 Jul 2026 10:41:14 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1dde81sm66281257eec.21.2026.07.20.10.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 10:41:14 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v3 03/13] target/hexagon: add aux functions for guest mem
 load/store
Date: Mon, 20 Jul 2026 10:40:59 -0700
Message-Id: <db1ec7611b774093ea57c60dc18be61bfbb87bbf.1784568922.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MyBTYWx0ZWRfX22MhPiEtpvPf
 LVFFrmpyy7WmYeElH2yT+aZ+MDfwOkaXVcfIBNhCJVklR1aNd9wcIR+Fd9chWue/qpmLiMh3V3E
 NCxt76UAZZXC+oYxBN53wScS8SxSvYMF8i0isjnu5d+4NNg8ke4xzliiQDKZrew2g8NMFJjtk8f
 hpTOurA0Nod7v3/2tW4TdpCOzr9kUCnTguyfd04rE4VuxeX8XoQ/2u5lEKJ/SBYwOshaCzl/0eP
 8lXEkoI+WqmmTagQ9qQ4BuW2oXu0CdeKrydFzsQHxKSSqS2wrAOAFK6MOYayYsRhlKxma9UJqPy
 bgYdVHvWWCcZaByJTiqJI0ubPx8LSZ7ScEGYrMdFsB1Sq7asXCBHiLwC8cvP01onx8Gt0CfRs7w
 ZSE0ZK63QFCooKX/HjoRbmIx7wbEUb4dhoCsmM1Fhb2LWxewjoXGsZaSCmkj05jkoPoagJiU0zL
 CgaaxAGFBy/xa7PyekA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MyBTYWx0ZWRfX4U2iQXFtJLj1
 YlYo1f3/G9asXqqaKLKqQ8e+9EqGe9b8hgSzWk7VgwG4F9tURWviygWorFObZ3umZFWoHM5A25b
 IBE5Bmm66S9akpR4l09hTa2l9eMGznA=
X-Authority-Analysis: v=2.4 cv=WNpPmHsR c=1 sm=1 tr=0 ts=6a5e5dbc cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=f3xLiZNeclign1bWSxgA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: U6ppvrJ0Fl2zTupiFY0fZlshIQ1TUJdT
X-Proofpoint-ORIG-GUID: U6ppvrJ0Fl2zTupiFY0fZlshIQ1TUJdT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200193
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

Will be used for semihosting.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/cpu_helper.h |   6 ++
 target/hexagon/cpu_helper.c | 133 ++++++++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+)

diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
index d1767503156..ca2e13ab1d1 100644
--- a/target/hexagon/cpu_helper.h
+++ b/target/hexagon/cpu_helper.h
@@ -7,6 +7,12 @@
 #ifndef HEXAGON_CPU_HELPER_H
 #define HEXAGON_CPU_HELPER_H
 
+void hexagon_read_memory(CPUHexagonState *env, target_ulong vaddr, int size,
+                         void *retptr, uintptr_t retaddr);
+void hexagon_write_memory(CPUHexagonState *env, target_ulong vaddr,
+                          int size, uint64_t data, uintptr_t retaddr);
+void hexagon_peek_memory_range(CPUHexagonState *env, uint32_t start_addr,
+                               uint32_t length, uintptr_t retaddr);
 uint32_t hexagon_get_pmu_counter(CPUHexagonState *cur_env, int index);
 void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t old);
 int get_cpu_mode(CPUHexagonState *env);
diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
index 64c5746c6d9..e981e11a35d 100644
--- a/target/hexagon/cpu_helper.c
+++ b/target/hexagon/cpu_helper.c
@@ -25,6 +25,139 @@
 #include "sys_macros.h"
 #include "arch.h"
 
+#ifndef CONFIG_USER_ONLY
+
+static bool hexagon_read_memory_small(CPUHexagonState *env, target_ulong addr,
+                                      int byte_count, unsigned char *dstbuf,
+                                      int mmu_idx, uintptr_t retaddr)
+ {
+    /* handle small sizes */
+    switch (byte_count) {
+    case 1:
+        *dstbuf = cpu_ldub_mmuidx_ra(env, addr, mmu_idx, retaddr);
+        return true;
+
+    case 2:
+        if (QEMU_IS_ALIGNED(addr, 2)) {
+            *(unsigned short *)dstbuf =
+                cpu_lduw_le_mmuidx_ra(env, addr, mmu_idx, retaddr);
+            return true;
+        }
+        break;
+
+    case 4:
+        if (QEMU_IS_ALIGNED(addr, 4)) {
+            *(uint32_t *)dstbuf =
+                cpu_ldl_le_mmuidx_ra(env, addr, mmu_idx, retaddr);
+            return true;
+        }
+        break;
+
+    case 8:
+        if (QEMU_IS_ALIGNED(addr, 8)) {
+            *(uint64_t *)dstbuf =
+                cpu_ldq_le_mmuidx_ra(env, addr, mmu_idx, retaddr);
+            return true;
+        }
+        break;
+
+    default:
+        /* larger request, handle elsewhere */
+        return false;
+    }
+
+    /* not aligned, copy bytes */
+    for (int i = 0; i < byte_count; ++i) {
+        *dstbuf++ = cpu_ldub_mmuidx_ra(env, addr++, mmu_idx, retaddr);
+    }
+    return true;
+}
+
+void hexagon_read_memory(CPUHexagonState *env, target_ulong vaddr, int size,
+                         void *retptr, uintptr_t retaddr)
+{
+    BQL_LOCK_GUARD();
+    CPUState *cs = env_cpu(env);
+    unsigned mmu_idx = cpu_mmu_index(cs, false);
+    if (!hexagon_read_memory_small(env, vaddr, size, retptr, mmu_idx,
+                                   retaddr)) {
+        cpu_abort(cs, "%s: ERROR: bad size = %d!\n", __func__, size);
+    }
+}
+
+static bool hexagon_write_memory_small(CPUHexagonState *env, target_ulong addr,
+                                       int byte_count, unsigned char *srcbuf,
+                                       int mmu_idx, uintptr_t retaddr)
+{
+    /* handle small sizes */
+    switch (byte_count) {
+    case 1:
+        cpu_stb_mmuidx_ra(env, addr, *srcbuf, mmu_idx, retaddr);
+        return true;
+
+    case 2:
+        if (QEMU_IS_ALIGNED(addr, 2)) {
+            cpu_stw_le_mmuidx_ra(env, addr, *(uint16_t *)srcbuf, mmu_idx, retaddr);
+            return true;
+        }
+        break;
+
+    case 4:
+        if (QEMU_IS_ALIGNED(addr, 4)) {
+            cpu_stl_le_mmuidx_ra(env, addr, *(uint32_t *)srcbuf, mmu_idx, retaddr);
+            return true;
+        }
+        break;
+
+    case 8:
+        if (QEMU_IS_ALIGNED(addr, 8)) {
+            cpu_stq_le_mmuidx_ra(env, addr, *(uint64_t *)srcbuf, mmu_idx, retaddr);
+            return true;
+        }
+        break;
+
+    default:
+        /* larger request, handle elsewhere */
+        return false;
+    }
+
+    /* not aligned, copy bytes */
+    for (int i = 0; i < byte_count; ++i) {
+        cpu_stb_mmuidx_ra(env, addr++, *srcbuf++, mmu_idx, retaddr);
+    }
+
+    return true;
+}
+
+void hexagon_write_memory(CPUHexagonState *env, target_ulong vaddr,
+                          int size, uint64_t data, uintptr_t retaddr)
+{
+    CPUState *cs = env_cpu(env);
+    unsigned mmu_idx = cpu_mmu_index(cs, false);
+    if (!hexagon_write_memory_small(env, vaddr, size, (unsigned char *)&data,
+                                   mmu_idx, retaddr)) {
+        cpu_abort(cs, "%s: ERROR: bad size = %d!\n", __func__, size);
+    }
+}
+
+static inline uint32_t page_start(uint32_t addr)
+{
+    uint32_t page_align = ~(TARGET_PAGE_SIZE - 1);
+    return addr & page_align;
+}
+
+void hexagon_peek_memory_range(CPUHexagonState *env, uint32_t start_addr,
+                               uint32_t length, uintptr_t retaddr)
+{
+    unsigned int warm;
+    uint32_t first = page_start(start_addr);
+    uint32_t last = page_start(start_addr + length - 1);
+    for (uint32_t page = first; page <= last; page += TARGET_PAGE_SIZE) {
+        hexagon_read_memory(env, page, 1, &warm, retaddr);
+    }
+}
+
+#endif
 
 uint32_t hexagon_get_pmu_counter(CPUHexagonState *cur_env, int index)
 {
-- 
2.37.2


