Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DD1C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjMwC-0005gW-Ld; Mon, 13 Jul 2026 16:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMwA-0005fi-Kf
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMw8-0006Pa-Pm
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:34 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9Y1U2356001
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8xGofNjm/bn
 pWgg3lP/oqijw7mdLM5SH/24RznCSq3I=; b=UZa8nEJlTg1zhxb3W5byiu0tt/K
 KayTAB4eN8TlYlD+vp+4i6/TL/N2E2xcSrnHoS90zsZV2eNXXvSaBbqg6cu5dMTb
 3soN+ZsneD2EpwflZsSLzQ4koHOmQDkuzqMLImgj6usY+/8U9XPxBeNSeK4dSy5c
 gu8xDT+tlORnbrS4SY5cwfSpcpw7xnYwWt3TB22CLnADzyF2KEDWzcAno0mAuNdX
 vVLumPaCsE74LXvz8+EMawIx6ntk2TTcG/xB15qsiq26pCtFDwXTzX4zbH8sLJP3
 eo654wKJg/4nuaqWwIUQYLkdy/wTP2XzK50KDJGYarO9xwlsSvA6v/a5llg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwu4tcqv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:31 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38dbf293831so490646a91.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 13:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783973251; x=1784578051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8xGofNjm/bnpWgg3lP/oqijw7mdLM5SH/24RznCSq3I=;
 b=WF3Pvo/8AmTfNDhBSYxGOzGPdyTvQfOm/fDJtiM40ceJZC80tCgDatemvgVYWrsv8h
 CGauXw2xT8mKAazSF9+bxiiOJBGvUEItWkYTRLLgdlF9SmVrMf3+PVqrS1Ej0CUPVlB7
 7Bl947Z7ykOd8H36bp2D1yLZxAnkw79QxRieOjvqPJf0oCSZghH8B4yiKqXXRYbyFpTu
 6GsPSkBw+e8w0AWp9lbLIbnc00otD8w1yX/d9tlFvLtANIzkWbEJpSjVeDyLYgFY4r33
 ERwrzq+yee0ZBRI2vtJPntnA44oG1aoTT7qke75PbNXWf24TXvNQ+JqbfacvgA/7dfog
 351g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783973251; x=1784578051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8xGofNjm/bnpWgg3lP/oqijw7mdLM5SH/24RznCSq3I=;
 b=A9sJURmpCZUP91ZJencARYRuV4bIg4a4YLjyF9uPshH3GmiMNs4hfupM/cvhY9Lvs7
 cU7mlZ3pRl7a9A0IEmxRQ+myDblEMMXXxOIFCaL59hDm6HSGXElufSW4/CZGXqZRGwaI
 OxejOXaXJgi1PiVehGYZvr89H/T+CqHIAobMet/SVGbWTOFvIi82tbsene5nZ3KAa+qL
 e9SH2l5WTWH/SmUcwAjEdPDlPR89quuEE2Nwu4TjJ/SHVZSqvb39MaGIBtLZLjiiorSY
 ps+/JgH+MNutPRAKk/ugZFJ2i1l/5rk0pWuCN8FhwaQNHaXwcCKhy3sl7bxDFn1b5sOD
 VYMg==
X-Gm-Message-State: AOJu0YyTJ1mYi3oo+dGfiTYCEc3RmivxXd7ee2R0tvOugc9nU+7a+DlO
 ee3ATTMl8WVfUk7GPpxmxbB6kHjVn2Q0frIhBMPPXhWE44piIsBnaRqZzZdkt7L48nAI5fwDSna
 kFtsCHKO1mYBygXI3Zlhs0LblbjqFPScMygL5D+FoQEVJ93kRREVs5hH6chh0xKwZSHVt
X-Gm-Gg: AfdE7cnwlIZOc7byUDJZ2yJD8qBgtN4YD9AnbH4hLfvOYz82fEwAhkQiJpuvaMqjW5S
 LtrLVTbmbpmy6AUJqrY6FG4xNiTF/siH02q0Vo0AjkD3U8tdzoCIN1MAPrCyHDTEoCQ1V0Fkjli
 PHUaQYcamshWES41ryfzSpqgJ/GrV2JaXRndZ1QpQKSNJ7kIkQe5F6qMKZxQGCjkpYtZnFo3ptY
 weCVJncStSJKyOwCrFu9LcT+EwIZvgRm616C5nj4U7ayj4HhkiQIGZdJxIsgCsV07v2V77Q/r2+
 k+cM/l2Axy8FNfTgm89MxGHpCIwPf4jYB+RcbXdcpVz5GYIDThfq8AXAYNF0YIsHycIc9vncVXG
 CtzvJ2Hi/yzYEwkNbekjvk1SblG8fWPryxHmu7Qsruil+YGV1u/1AvrDuHuXtBJ8TR00SesDwZg
 ==
X-Received: by 2002:a05:6300:2290:b0:3c0:9c1b:d0c1 with SMTP id
 adf61e73a8af0-3c110a535a4mr10458314637.76.1783973250771; 
 Mon, 13 Jul 2026 13:07:30 -0700 (PDT)
X-Received: by 2002:a05:6300:2290:b0:3c0:9c1b:d0c1 with SMTP id
 adf61e73a8af0-3c110a535a4mr10458290637.76.1783973250313; 
 Mon, 13 Jul 2026 13:07:30 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313cb804197sm24106543eec.13.2026.07.13.13.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 13:07:29 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Subject: [PATCH 03/14] target/hexagon: add aux functions for guest mem
 load/store
Date: Mon, 13 Jul 2026 13:07:11 -0700
Message-Id: <9cdc7c7f27a70257276119e485a55674bf5f2551.1783973054.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FMErAeos c=1 sm=1 tr=0 ts=6a554583 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=f3xLiZNeclign1bWSxgA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfXy3bkwKi6ZyAB
 e4yCdWrv0Uf5Aj9RYNUBjMqeHxHCynfMebagSWfhYFzibckRehXnD9W+jvC48iQq2mtbjIE7hyO
 k2OtAtZWeu36ZtOHq+8jWI//pBTJxxA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfX+/5p539FMO9t
 uxxQVAFginPRjcXX59oi5lb6MwUcdUuk6ZQ/syoRT+m1YK+LZQHjYO1vrYZRk1KDOWRXmtp1kxJ
 QRVbUPvtNoApvSH5+cjLC8nsdiaJVNtCexz8S1BfgxhrjU8xwkvz3qOkzfuf1+GMQWb+pXBSqxk
 2n3GfExSp7PDrmoHedief2OFYdKTv07qoZ9c/BEmsn0y+KR29EQ6cBmGJcf+I0lWW9HVMj+y1OE
 3lBW97TxVYbtaWgdhefQ/Sqf0f+h5/hRx9WinxDu4NEI4OCcloKnXLFHDx2eDUhFrX816W7x1L5
 +YFQEhKr/HyC2DcBpN7QwKOFrneLtWGdNeNV1T6J/jY3Tj+N2HMPBeuefhI7AzL+czMHoz8Iyuf
 i4MTQjnHiWpwMNSElsfJbwlXfpokngohqtSwXVBvy0o2Al4EpRiIQCVaFtGtoZ2fPdMkPREekjG
 YbA+js6+fEjby1bKzjw==
X-Proofpoint-ORIG-GUID: t3oAN8iYSdNy15a8PqK69p4sppclorKy
X-Proofpoint-GUID: t3oAN8iYSdNy15a8PqK69p4sppclorKy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130208
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>

Will be used for semihosting.

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu_helper.h |   6 ++
 target/hexagon/cpu_helper.c | 133 ++++++++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+)

diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
index d1767503156..f6a31ecbab0 100644
--- a/target/hexagon/cpu_helper.h
+++ b/target/hexagon/cpu_helper.h
@@ -7,6 +7,12 @@
 #ifndef HEXAGON_CPU_HELPER_H
 #define HEXAGON_CPU_HELPER_H
 
+void hexagon_read_memory(CPUHexagonState *env, target_ulong vaddr, int size,
+                         void *retptr, uintptr_t retaddr);
+void hexagon_write_memory(CPUHexagonState *env, target_ulong vaddr,
+                          int size, uint64_t data, uintptr_t retaddr);
+void hexagon_touch_memory(CPUHexagonState *env, uint32_t start_addr,
+                          uint32_t length, uintptr_t retaddr);
 uint32_t hexagon_get_pmu_counter(CPUHexagonState *cur_env, int index);
 void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t old);
 int get_cpu_mode(CPUHexagonState *env);
diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
index 64c5746c6d9..1ab2564e3dc 100644
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
+void hexagon_touch_memory(CPUHexagonState *env, uint32_t start_addr,
+                          uint32_t length, uintptr_t retaddr)
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


