Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C018C44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQUf-0000tr-So; Thu, 16 Jul 2026 14:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUe-0000t4-5s
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUc-0001UM-7B
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:31 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GHZQhl385147
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=r1f4hb6Kd8h
 BTIEo4PyGmASCC8aKN4PC9ZUadxyxhNE=; b=VimfATsVXyEiFnSvJFoskdDAHiE
 6r3+Yb3zrm0B4A3ZI1dnUjQKVW0BLM+A6MS8lUoSS0lCkz26HwTe5PlQbKMlcKB7
 ZzL9Gk5ho++wqcG7oQIsKmFxND2nYQSkrlf4/Z5mBKOhS0LrErMbBvhKKOlM1QNb
 ZJQuFaVnNg9tLPdMhy3fI7Hx4k96jzr69nvQE5XM9WpAFC9uIjKi1ZhFeiZPWF8U
 0xWURv/7mfNlNn1sblK55Yom8FrQjbU7zo7flRZyz1RRjcZhviXAmqFuZXEw7wlh
 2HW606ky2JqJsRvYIvL3FPADHaPUKgfWypfym4RbWufGyaDK8yyjZzN0yXw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u6g3v6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-380b630c505so8457267a91.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 11:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784225248; x=1784830048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r1f4hb6Kd8hBTIEo4PyGmASCC8aKN4PC9ZUadxyxhNE=;
 b=PhqjB+1Ja6QfokDDCA0/x7oMRYtI/w9oCD/Wc6PGJc9l8QjxvToQS0HFBbwd944oQd
 vb17YUzvPwwALxm4934VGpCKu/jijPzpGau8zwJEe34gMCrneSs9Mx3cpivP4Gjv0WSr
 PKg8bNSISRWHLlZqziN134vvA2Y3MXwM8jKwxyHY7Ke7SLKvkDFQUP1WorQplIfzdsPH
 6iLgPdb15zO3nLhpVjUu+NTp3ASnNkoNLm4FEa5zmVhQJ53c9ipHpzDlZ95ooE7GTubG
 Nzg42WsuKV9PEhxWT6FwDPX6vO+fNzP1KweKAguNVEB4pFjR5Hxa9q3OYhzFRuNVFfy+
 Cw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784225248; x=1784830048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=r1f4hb6Kd8hBTIEo4PyGmASCC8aKN4PC9ZUadxyxhNE=;
 b=kOPiFImDvllcrLtutFEGk/stzLabtsX++njXZ9j4/tdxFSjWu+rvFZ1Vbiml+MJ0Bt
 ZSfNTzZe9uq58a+VdGk2V8E7qC6eN/ovProRO6WLOuwg9mrvMOLjsqIGkiqLtaC9JI67
 HwFgTZBUP5gi04RVlf904jDGQs6xOSLlEG48ULpJmWw0QCI+pC2XCl3/RdYHJQE9TMxD
 ppHXSzEgx1BgRUKPiNfEbFDabunU8aydhw5tudkuwEEVuSOVeEeOEssBxedUR5OjV4lh
 3wLxl8PAKnXDH0M3fkS10ziyQW4fRqK+JlQe9CSgDtMA6R9wjuHATdw62q1rwIuV9i6x
 RKoQ==
X-Gm-Message-State: AOJu0YwOdDudHQSJGUqyTy482tFKOBxUpP3IZFXU4qbMSo9AF3i2bSNK
 WZHbZVnqI7DYs01XwsB2Z4w7dzl63gRL2dSQKLFBPr8fRGZR8SKx4LRbwaF/4EgqzUNqIzoOJ4f
 P5A02Eg7QUBHd52b9W5oRA0Iuuj5fM5nffMaRQ3fym8ozUsEZ7mz5UUHOp5aa+zfRHw==
X-Gm-Gg: AfdE7cmg6vUi7JedxwFU2ylH83tlBWrquMdk9JZgXkv3Y9UvegEbqK1NIXXzfKyguqq
 UiY+tpjTbdyj+SXPOCgVBKcA6nGb6RpvM32N52iFWY6QsP310APLRTYSkleBoD1gwwPx0CoGCYa
 l7n6JCfEnN2OipUGm6hAJcFcUjA78s+inW7I+vYc1kwFkQ1aW5MESx5SwmmOCVnjn0+y9XSr8VZ
 F6Jm8ZO45dALv2txeBrflfDgOlf4cmrmA1d/k3xpVkNb/l05DBAI6fwXCBNeylsoRsyPnI8yf9L
 bhvyigqMrJ8Tpf/UROygL0pmDPU+xQMPaMl0fdcGwVKyZJN734HyJMHT1fnfR3tMyJiNB5YpPim
 Uvkr6c7feZZGLPKIeW6QIxjaKBruJ1/D1BO2Lx/76HY+NcJhQWUAxasytoB8ZZzg=
X-Received: by 2002:a17:90b:180d:b0:37f:9ce1:736a with SMTP id
 98e67ed59e1d1-38e1af3481amr11870369a91.32.1784225248096; 
 Thu, 16 Jul 2026 11:07:28 -0700 (PDT)
X-Received: by 2002:a17:90b:180d:b0:37f:9ce1:736a with SMTP id
 98e67ed59e1d1-38e1af3481amr11870315a91.32.1784225247394; 
 Thu, 16 Jul 2026 11:07:27 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm17131184eec.11.2026.07.16.11.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 11:07:26 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v2 04/14] target/hexagon: add aux functions for guest mem
 load/store
Date: Thu, 16 Jul 2026 11:06:48 -0700
Message-Id: <b0f794c467ad70581d91ef441c6d64a99735d086.1784225209.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfX0lI71N4x3mXu
 1ypPTRRURFl4i8aucnKtjp1Fqddyee81lU047dH1ucqFG9ir0kAD/Jk6KOLjHP+rXrvYKOlOHFO
 i3gDSzkaykECKHrz9MNLOrMxrkxJlL1bw0tZgtimfbmw4nZSneCVvv/Hz2/Pev9oiS85jr5sGGu
 cf7rEp9NjWB1mAgvURQSiGE8wyZH+81GpKxMV0MCTRWu7KZqNnDF1OZ+5ETZTCRlXiJD6lHhTRg
 DoftwEb4PP2v6qc68yn5xSPM11qSns1plZ9UdPzA+rf43pKcZdgNITLbMag+aCloKksRgA/zorG
 DBWPQRcWivn/SVnGhcplBAN5Au7mqc0Lqj/utmPUUWId/LCn0pvxXw349UoKKhFFY1CPn/GlKyT
 FxCkhCeH1sv7ozNOIwLHvgJ/1pCFEomvoji+5M6VgIFewItIS3zShp6nPFgpjRfzsHbANPnhHU+
 DCkAuxCda2939153b8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfX1fhLbgCKmE1H
 J7gTGSD4JcGgQlsEgpP7CpJCJiww8x5eKwDOLic/FWKsb8RDNjnTAZMLEGmcUcRxeRNbhN0x/tp
 43IQcM/vATRLKK4To6BcKdZIhJVLrtY=
X-Authority-Analysis: v=2.4 cv=DYMnbPtW c=1 sm=1 tr=0 ts=6a591de0 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=f3xLiZNeclign1bWSxgA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: gV4_cBvqWZ8Bgtx9LPNox-8E10yw12jz
X-Proofpoint-ORIG-GUID: gV4_cBvqWZ8Bgtx9LPNox-8E10yw12jz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160185
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

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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


