Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EC1C43602
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 21:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUqf-00043p-2p; Sun, 05 Jul 2026 17:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUqd-00041Z-BB
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:57:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUqb-0008MH-0X
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:57:59 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665HiFiu2315313
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 21:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 risRiSv+UEPHcL2LbSldgAbZS/KE/1C0HcsdRJ7pmvw=; b=LUf3Xhd9VvVi9JCl
 fzA8d8W5V57g8jcfIbzhYe58EVednaA1HPhmVrAZAjOK902ehHIWQQeoH4XQrOth
 1iUMFxJ5se0YlNDGOtHBeYB57jjBsUi4MfR6MpMfp+FIkAr22xLTm19jZJvSyXPF
 wJ76uosOvBkJ7gMe2AnTRh0BD34EMoEpmXxibIJz9IoOw3hGi6Ncmy2m1sGG7PCt
 nTfU/Nx8BtWf58L68WFU23cW7Qmkb1LIH5CDaoR28Z1ZcrmAfRGGXi0gp7xTgZ7Q
 v78/Gdb9SMOmfyGnnaWxMDQ2Gf+nADk4HVJvZtQ0JzhQolk1c3fqOg+ejec7/QNh
 48EQCw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6t8ukg54-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 21:57:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so212608885a.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 14:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288675; x=1783893475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=risRiSv+UEPHcL2LbSldgAbZS/KE/1C0HcsdRJ7pmvw=;
 b=GkigZ8LzeV0lzyVKO6J9NPEmbndoLrq7H+qrGyKXgvTg26/nWRPuodSpc0awymedq1
 KWzr91bP85GvOpqDYs3G6rhQ8mJY4eIDYC25WFjiYRHct7Eym00WSw8TwYfcPcCs5ytu
 gg7T7AoJ0leftMVbFFtEpIpNWx0m+C4SPG8TfR3HC0o5pvGpDtXR8KvHrYM9bIvRc1FD
 PFyT2YwH7sjG/JhWG+Z5mgXW70PhHYy2qyua7qKhQa05COqRtQ2GSGS+srL1/R3mEvVY
 dkgtpcU8IOwKoKqcu1eNZWMsdn7acv9VSAlwtuxwW9pXnzumvKj7wp4pQBqRuDrVsC3H
 mm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288675; x=1783893475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=risRiSv+UEPHcL2LbSldgAbZS/KE/1C0HcsdRJ7pmvw=;
 b=NSoxle4rUtL9OK3DYxsal8b+ewbWiu47BbGpAxeWp9WZYBSvU6+4Fm2s4AJZFyapjV
 MDpkcJromb7XHk9GFp2UMVcBeGIW+sUSU4YNaPBznUN056+TBjxcedMLYNJ2h4GOhkJb
 K3RVqtw3pO2D789GdNdkDDxnXSSfJVJoeCEq2JBgeCLvS/5471B7br7uqLLb13YjXUMh
 8YZMfOVpytIDlYYitt5HNg5MqVC5j5kzy875rRO8qVwnYfy91ERZwNbjZ3W2zzdAJhH1
 GPOddddBCOF1i4buMjn7ealnX/neR/woEy83YG6z7FH387TwUcxLVXGA5S7Y5x857Z0B
 RmCA==
X-Gm-Message-State: AOJu0YzPB64/7wYA7ArrjYkvWN3KQ3sWFg08n2zCDJBX5th7JT1LW2dY
 Tjxq09EPbXPm/qikYtxWoN6vfnJFVFDqAzXlrkmEpCsLSMiP0ltdtfcdnbTfmcesb1QLThKy1W2
 wsD9dNXoE1tDnlsM/HWd3EgicrNEbMQ49u9Z+idR43FfVf/NSZMWoks4ZmirJm0cdxQ==
X-Gm-Gg: AfdE7cmROY+k/g81Z/qU36f35X/CgSUvBVdzXbewLPQ+6sgvuK85UAX1+K5aTpJEmfC
 3CGVrnPmw5gqQ2jfgx5BSj4RSCaTtn1SFu2eyXZt6z0ywFc9edWZde+OfjAbge2tC6fF0gBK5F5
 uEMsUEbMMM6BE+mTRu9j15IhzYNhFz3d9n6+l4fWNMHJqKok41cbK7r9kM+34J6bumZJnlmxLaK
 CzuEr18o/ggej7hNq8ogL6WRTFg0k6YHOhBHaReKckPrxeY914I88p2AoiomUDkIL/wB8C9vIxd
 nzyQsbyqXo+WacM+oRihzE+QjTAWgkjfcRVlEsQyolAJ4/4QTCVDoFeNsQyOEorKKNMfXMNrusB
 9oc7TbY/1o1VqayU5d4yJHklwb/q6Ie+i4js7RnF6zROyEI5bzMQtjQ==
X-Received: by 2002:a05:620a:4012:b0:92e:7b45:7690 with SMTP id
 af79cd13be357-92e9a51a4b4mr1168613785a.69.1783288675060; 
 Sun, 05 Jul 2026 14:57:55 -0700 (PDT)
X-Received: by 2002:a05:620a:4012:b0:92e:7b45:7690 with SMTP id
 af79cd13be357-92e9a51a4b4mr1168611385a.69.1783288674575; 
 Sun, 05 Jul 2026 14:57:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63bfba1sm364871875e9.15.2026.07.05.14.57.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 14:57:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 03/32] accel/tcg: Restrict tlb_protect/unprotect_code() to
 TCG
Date: Sun,  5 Jul 2026 23:56:59 +0200
Message-ID: <20260705215729.62196-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: EMIZ9RfbCv8K8u4dST9U590GndzPjYHx
X-Proofpoint-GUID: EMIZ9RfbCv8K8u4dST9U590GndzPjYHx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfX1QDPpRFQztS3
 Sr1EyInv1377xs7jsSkNlwdlhqv9tf2MHp2Il45uvL6C0OHoEEtdBP4et3HEitJK2ZzZV/dYdkh
 VUirEGROvLS/tXQTSoLroyWFE4Tl6b4=
X-Authority-Analysis: v=2.4 cv=MZxcfZ/f c=1 sm=1 tr=0 ts=6a4ad363 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=glojBnVPa3CR4aLdIrwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfX1jT6fQC26k5I
 kK2EeKL4UYqK8WY/FxUywvxNTDGqjtLSJvBsSlFfgBvMSj3ctfRp4+rAiwXXLMZ3SLqPd3yLWpw
 T3Ud/XiqmSF0apW503P1mnfOOES9wDjFjBWXuJ6JGv80pqI9zwFKeUAx2XgWrtUrkq//pwa11GA
 yKSQv932xh7xFtV+UiaRyJm+ghdVWqAbLJMldnQ2qY0NaEGbsbOmM2j+2BtST9gWhksM0R2m3Ph
 6pDVBvqgktkaga+FgsARUqap0Js5E116XTeeL+4BViWCmI9Hp22fbFGDXNdu1mXm3QpCX8VUcRo
 xHp4yJv5Wmcvhb9jalmQcKtI7C1vZoAaOhC2mnLWB0M2MAMr9pJA6s0AEjz7bbS5j1mLeeGlPgL
 lp7MM4/k6LFMZKni+/ekPaXBbb/5JE8+swKfbss7w3m57M6z4X2kag7d/inIBYUipVUZMwCwZsi
 Zr6LHzNbeys7eGIg2Jw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050237
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Both tlb_protect() and tlb_unprotect_code() are only used
within accel/tcg/. Avoid exposing them to the whole code base,
declare them in a new "system-page-protection.h" local header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 accel/tcg/system-page-protection.h | 17 +++++++++++++++++
 include/exec/cputlb.h              |  8 ++------
 accel/tcg/cputlb.c                 |  3 ++-
 accel/tcg/tb-maint.c               |  1 +
 4 files changed, 22 insertions(+), 7 deletions(-)
 create mode 100644 accel/tcg/system-page-protection.h

diff --git a/accel/tcg/system-page-protection.h b/accel/tcg/system-page-protection.h
new file mode 100644
index 00000000000..52896c6d24a
--- /dev/null
+++ b/accel/tcg/system-page-protection.h
@@ -0,0 +1,17 @@
+/*
+ * QEMU page protection (system emulation)
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+#ifndef SYSTEM_PAGE_PROTECTION_H
+#define SYSTEM_PAGE_PROTECTION_H
+
+#include "system/ram_addr.h"
+
+void tlb_protect_code(ram_addr_t ram_addr);
+void tlb_unprotect_code(ram_addr_t ram_addr);
+
+#endif
+
diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 3a9603a6965..f7f7020382d 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -24,14 +24,10 @@
 #include "exec/hwaddr.h"
 #include "exec/memattrs.h"
 #include "exec/vaddr.h"
-#include "system/ram_addr.h"
-
-#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
-void tlb_protect_code(ram_addr_t ram_addr);
-void tlb_unprotect_code(ram_addr_t ram_addr);
-#endif
 
 #ifndef CONFIG_USER_ONLY
+#include "system/ram_addr.h"
+
 void tlb_reset_dirty(CPUState *cpu, uintptr_t start, uintptr_t length);
 void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
 #endif
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6e66f3c6e93..7f7c208ba12 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1,5 +1,5 @@
 /*
- *  Common CPU TLB handling
+ *  Common CPU TLB handling (system emulation)
  *
  *  Copyright (c) 2003 Fabrice Bellard
  *
@@ -47,6 +47,7 @@
 #include "tb-hash.h"
 #include "tlb-bounds.h"
 #include "internal-common.h"
+#include "system-page-protection.h"
 #ifdef CONFIG_PLUGIN
 #include "qemu/plugin-memory.h"
 #endif
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index c33dbf65e7f..4313864d2c5 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -38,6 +38,7 @@
 #include "user/page-protection.h"
 #define runstate_is_running()  true
 #else
+#include "system-page-protection.h"
 #include "system/runstate.h"
 #endif
 #include "trace.h"
-- 
2.53.0


