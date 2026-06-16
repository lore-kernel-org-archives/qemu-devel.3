Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCA1CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZVqH-0004Z6-5Q; Tue, 16 Jun 2026 11:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZVqE-0004Ya-2X
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:36:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZVqA-0005kL-7z
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:36:41 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GDxdaK3920643
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=BIKu2yGSdaB87mMAD0pz6i
 NaLAyGYl8BD75dm9mHZWM=; b=jtWM26oIM8IURic5SMNB/pG8B68aRvyrWLuGul
 qBOxiMIx+r2NC4X0L1xg0/mWPagA/rRwVlj7L2uZEQ1XvGFOf07c71w/p91XyFz7
 61Z0nU0DHuY6NeZ3ZS5HLtptmkhA8E82zYXy/Udzmfgjui2NXjxBxAxk3sQnB7YX
 aOkl+zyRlDYroYqmUqw88sfoayDeImlDYSNF8arjnSh6FQ2llFrzQ27C9UcsmukS
 li5qTKALHyt9gdGMTjoS9wXq4IMT5FMCEifEdnN4mR3K4O2fQ+8XX9CT9mN8BykM
 xh9MjHCCqXB0VkiapptKHYyjfPE+qCLFNR+J3nHDqHIS9YFw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu09ganpc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:36:36 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-6cfd65ab97aso5682232137.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 08:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781624196; x=1782228996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BIKu2yGSdaB87mMAD0pz6iNaLAyGYl8BD75dm9mHZWM=;
 b=gGnsEbIz+2IJgb7WhImil0eLYlNLel/w39ZRsJx7tGYavkjPlsgjNJnVRemlG/kqWs
 iomF5JZqoTDMj5OCsB6XOvYi0w8IJoXcr2xsiRNUn3BiMh95GGeOTgSpzqALRX8WyLi1
 o+KIKRktfRr3z/IITRuKk7kWIcKI+ZrfXnkhW3viCw6iTgYTFt03QJs41nl38qnHpTEq
 kVCsLmryGj+ZCUlOs5OHNFxWT64cyrNOrgTKXYzcdKynRV0PbWiHbhvkHyX9cMgR+4OQ
 H6mMyPluQmQPxQ6gGNPxSkaOWbUvBzCNqBCsy/4I/70af1YOsv1sIijJfa7N6czy281h
 Aixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781624196; x=1782228996;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BIKu2yGSdaB87mMAD0pz6iNaLAyGYl8BD75dm9mHZWM=;
 b=LSGfwlOy2kpPDMoxQ9LFg0b0ka6to+9V6wtgH6Lc8nIjPzZ/viTYqCpphcNguV2v1U
 tyswcpp9ngPiWHPz+EJFPrFaSKpoOit9YZK+5lO3gT1sw4SYRbKZavM/UlQbc7GtQk3q
 NPsHp8dkBoF0jYOlUMA6Y7wAF2esv+gTtue1G4M4rcJTkFtNxQZCBLVfDkmSlgv/R/SG
 FFILqKLUiDT9gH3kAUK7kk0BDie/TUbV3Nt34gSXmKfl+rHsRI27Uu46hTg38SGLzfaf
 3HlPwZb2YMlN9dcJbP9SH/ExB4sgz3zfWC+nnlGsua2FKJGwmShZhJYA2PUKenu+Trhh
 F6mA==
X-Gm-Message-State: AOJu0Yz6GdHkVuy/7XYQ8N4Nh5j8JrcF/CoTrdhYT7UX77+wzEfP4OIa
 j5Add7sQxH+LU1naZXHCk/tYRshcQQ61xjCEOta60QwBhI4E+Pofs0TV3NE+GIUuo7kLtfSmBWP
 KpZi5J6PgjdMZzDZXBTCnH+5JgoDpP4XW+oBo/plKYI7gvPVapW/te+Ih3d/vi5a9Uw==
X-Gm-Gg: Acq92OGm2dP+zVpLb0YAkJKlQRLzeIfB9JRJVW9JPxbyr/pRamI2zDMUsBLb/rqOEBu
 UEawu1I9/qIFPch9cab7JVs62iw2Omr+R/p2QoQTqVIPoNZJsndV4SqkNtU1ZAxFBTRpetT7FwV
 ivuUc03h3yf5JPtAvMXSWFhadtzj18RHujnPpZVBrGR8vNMcPfd3isbUB0ImIBS2NjSXaDCt/x6
 YEyFVxYn0pSXopWH584NGC5If5BGL7L5tn/cubAf8f8CJMRjqMWgD04HWlmZQHfO2jyNVVmw9+C
 r90sxKjNa4tJ6x+f6RAIYEpoTc5ch6QTvbGNcnro6g7sMswy4WMcorXbEgAr0QoeKs6eCJ2+NRU
 Do1MzhHH9woYxSzEuoOc2m62z2+JuyVP9juZqTtV/MfzStKl8ftPD7Rvryk/Flw+GQLPxhs/8uz
 zXMac=
X-Received: by 2002:a05:6102:80a0:b0:634:eb91:695 with SMTP id
 ada2fe7eead31-71f5e0fa7f2mr9348202137.5.1781624195851; 
 Tue, 16 Jun 2026 08:36:35 -0700 (PDT)
X-Received: by 2002:a05:6102:80a0:b0:634:eb91:695 with SMTP id
 ada2fe7eead31-71f5e0fa7f2mr9348178137.5.1781624195472; 
 Tue, 16 Jun 2026 08:36:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa8b423sm86394755e9.11.2026.06.16.08.36.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 08:36:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v3] accel/tcg: Restrict IOMMU declarations
Date: Tue, 16 Jun 2026 17:36:33 +0200
Message-ID: <20260616153633.93267-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE1OSBTYWx0ZWRfX+zVVkRbxpIGp
 xSgZR1STqIlyo66AXHQWlYeHWUFgNyj9v1em2UHqyLRrRyNd1StfRSAxPpfjWK8tqL/cNOUykVr
 xar+uw4vMfV7nMy5YQn3Y45FsFzlWkCKdsHyikiBirUKidja33A7WLizip9u2xmKPGOjsOGl1M8
 Tcs/zb8sFMREbFPpWAIHz37EJ+6DJOxw8QJueCEn5DT5qfxHmkQmfzk5imk/0nZYNEbIKohcDtw
 +8c4sTKQ1gLFJfhKif9uQLQd2S1Q2JjaDLA34zCftAnW14vCALDbKylFguLJyZjJW7jmn+h3g4L
 K/DmgE+HRL8ltbejVC1NNoOsuyShu88MWrClvI1TkG+OcI/7QqS40XPUcd9WLSsIG0ufYpX1Ygh
 1Zvw37FekIae4UDXEakVx6XHI+qNGJ9jTfhhSoRZiyJwgWlYMaye7gf9Ydy/HaZJ2e7j8qM6f32
 bqL3nzzzdxZFUh/FIWw==
X-Proofpoint-ORIG-GUID: 8FbBp6Uzi1qzowYQBPnyCUR_XS-GejCi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE1OSBTYWx0ZWRfX4OHcnPKj8scZ
 A0QPBSj8X7To9Ln5X8i+u0cFO9wuUK0Kdef8GO/novoZWu8c1svtzi8Ul1Nx+iV8/LLAMhTqJR7
 XTV3p7P41+tGjtQqc7Rf+jEvUerB5Ec=
X-Authority-Analysis: v=2.4 cv=DLa/JSNb c=1 sm=1 tr=0 ts=6a316d84 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=ZM0OCxVWYM25puObUq8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: 8FbBp6Uzi1qzowYQBPnyCUR_XS-GejCi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160159
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Move the two TCG-specific IOMMU method declarations from the
generic "exec/cpu-common.h" header to "accel/tcg/iommu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/accel/tcg/iommu.h | 7 +++++++
 include/exec/cpu-common.h | 3 ---
 accel/tcg/cpu-exec.c      | 4 +++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/accel/tcg/iommu.h b/include/accel/tcg/iommu.h
index 547f8ea0ef0..a4032a292e5 100644
--- a/include/accel/tcg/iommu.h
+++ b/include/accel/tcg/iommu.h
@@ -7,6 +7,10 @@
 #ifndef ACCEL_TCG_IOMMU_H
 #define ACCEL_TCG_IOMMU_H
 
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
 #ifdef CONFIG_USER_ONLY
 #error Cannot include accel/tcg/iommu.h from user emulation
 #endif
@@ -14,6 +18,9 @@
 #include "exec/hwaddr.h"
 #include "exec/memattrs.h"
 
+void tcg_iommu_init_notifier_list(CPUState *cpu);
+void tcg_iommu_free_notifier_list(CPUState *cpu);
+
 MemoryRegionSection *address_space_translate_for_iotlb(CPUState *cpu,
                                                        int asidx,
                                                        hwaddr addr,
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 24e3eb500bb..6fe821b9a1d 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -35,9 +35,6 @@ unsigned int cpu_list_generation_id_get(void);
 
 int cpu_get_free_index(void);
 
-void tcg_iommu_init_notifier_list(CPUState *cpu);
-void tcg_iommu_free_notifier_list(CPUState *cpu);
-
 /**
  * cpu_address_space_init:
  * @cpu: CPU to add this address space to
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ad94f96b252..7292ff15060 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -26,7 +26,6 @@
 #include "accel/tcg/helper-retaddr.h"
 #include "trace.h"
 #include "disas/disas.h"
-#include "exec/cpu-common.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
@@ -46,6 +45,9 @@
 #include "tb-context.h"
 #include "tb-internal.h"
 #include "internal-common.h"
+#if !defined(CONFIG_USER_ONLY)
+#include "accel/tcg/iommu.h"
+#endif
 
 /* -icount align implementation. */
 
-- 
2.53.0


