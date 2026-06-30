Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4490C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegY7-0003Tv-0S; Tue, 30 Jun 2026 18:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegWM-0002Wk-CF
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:01:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegWK-0003d9-DM
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:01:34 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDdih2948564
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PozYVmyS+sQUTBp7M+ZfA7G6EVpxfWO8Hrg4LZ11D3s=; b=gc7l7wipIMAai75X
 HkbsO20y1N/qW9uQm0fPX7KnfK7+9K4oOE/nMeSthPw9I9YHiWPfDS47K9h/aVN+
 EBOrRtN0+euVZlwego8uigeNQQYZLWnEzlyuBcaq3F6B6usTzhak7OS5gjrvyvlF
 +2UGDTAhxS0RdgmqVH+0DKeUswWpFLcpHp+GhrbjY9i5wXdpNz/hvLpGIl1WfSDR
 2diBuEqXtKoKPD8FRJp3N0eOmNWHuwuSRx/WawK6Iww1ZTLUd968iZTOmwcJ36t6
 l6wAIB7kSzhZw1QJv3B/YGCulJ43dsht6Ck1m7P2Uvw4d3uu6TPFrJE1FCvk52VI
 rk5NMQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4kgw0ps9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:01:29 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-737d352d3b0so3299816137.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782856889; x=1783461689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PozYVmyS+sQUTBp7M+ZfA7G6EVpxfWO8Hrg4LZ11D3s=;
 b=GWnXGRGBGCcd0GupbosRkvmCopKOKqCGpHbTrj6yHU8MX9rcYpJqlRmvSGCDX8t9p+
 /F5j3xWL285qrPCQmofwXA9iqLNn3mIG/nfWyuAdQTwspTEFcC9SWeXMW5Xet2Rr13NV
 +Q8NTc7qDImSVmoD44u3xKZpXViirXY2Q76x5uhd2/jQi++KlqrhO5eAwgvf32p8aawv
 +qASPZtfaIe5AcMgYuYa7zuzplClOpXkH/74qjgTeW2NGxiKR5bweHy2HomypOj+xOxZ
 8LkBtJ+6/keiaNjSRHp854CdudM7UEX4KuGopDlQPWgQONl7fN335lLpwDK1/XbDuy1z
 CfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782856889; x=1783461689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PozYVmyS+sQUTBp7M+ZfA7G6EVpxfWO8Hrg4LZ11D3s=;
 b=nS1WH0XOEZg6m/zhvEwAtTVlfcmM+tKd7JNiL2GOBSe50PKU8Av4IlLpDCo3mO242A
 SiUcf9uifRlYxQA0U+eIzPejkmfHIDT/eJC9bQm2b4E7lJLT7fqPXTBpxvIVsp+6Ax+4
 mh82fcwwI0/d35zpB0u34k7NwBoRI8m0K9H4GpbGixmHdhuA7b83nwIFMXGmeh6LzbqC
 331qBvUXP6Qga9AwYiXDEUovI16K72N/Lh/IA2onhGNFdyk6eJ3mFf769RzfB/wc9pi7
 tl4fOv/P4AIiC2fZyDJMgfhzCowkTch2vC6i5AFPzSGVSKHBF1uzM0KleSj6sOgdjum5
 /9zA==
X-Gm-Message-State: AOJu0Ywz6Kby/LldSrRV8ZkQg96yh+tK+h7uc4t+sbI12YBcBJb0rxLY
 FwToS3TeYA6La+LNeogVwkBWd7wx3hH2cHKr40rI123uIGANdR5g8MfvJDa13OS6qsNlhBf4adQ
 Zo2WcZJjtSvexeCQ0ZRiqeGjCen6GJxvlmfHPGrLadnpHJfzuQXnBQ8Lf/EPsh4kavg==
X-Gm-Gg: AfdE7cl4x4IkpS96KmumJlWiUvrbdbHFfT9wWZ3PBchDKdJixM6ry8N1pAEI8OnQLTN
 09ANUc0Ii/lU6A6a4HC8wZuKYdCCPFsal/nOEcfFLF969HHVdSNbk9Z1Anm0bjNwYrDwH8hzDPF
 06Ig1cGhcWm5LLMXJDTl0rTYwpnD4aJ3sXf0+wRIPAZGoMan8jYx1p+Wb9AvbL8wceVbpVp1kce
 vGGDl14WytfNaQ634XgKbq3SFtSMZZaCnJCmxLVMpnnJqR4CVKjQHxbQIcmpgHIwlm9Q41Vm8Fq
 hPNYSHfcBGhV1Prc3K/y+gB68wrTgEW3LUz1NQqWU37SXJGuOEL1UvdeY52b26Gxvi2IVIOYJy3
 CeDOKOvlpZftfLwMNiEE6D0LYCiAZsuUIASMfVnQW+LrHYa/lMwLR7XzqyYcyfvF5Qx3K
X-Received: by 2002:a05:6102:5805:b0:738:472f:2ca9 with SMTP id
 ada2fe7eead31-73a369ec1bcmr2811977137.7.1782856888533; 
 Tue, 30 Jun 2026 15:01:28 -0700 (PDT)
X-Received: by 2002:a05:6102:5805:b0:738:472f:2ca9 with SMTP id
 ada2fe7eead31-73a369ec1bcmr2811776137.7.1782856886629; 
 Tue, 30 Jun 2026 15:01:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4756797a8besm11884706f8f.35.2026.06.30.15.01.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:01:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 03/33] accel/tcg: Restrict tlb_protect/unprotect_code() to TCG
Date: Wed,  1 Jul 2026 00:00:30 +0200
Message-ID: <20260630220100.1289-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Co2PtH4D c=1 sm=1 tr=0 ts=6a443cb9 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=MO-ljkwS13Xngjg1mVIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: YMVkDWfjaiBMTKbQIkwZ5oznq6rb3cCd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX6YQz/yUk3lGf
 9jyFVTAii6PjSPcnLBzlcS/IN09VVD8hyQB1TcEBLW9sE4BlZz2kZc7hZ7hqhgVJWRAHhR4qMLj
 piNRAfMIUYgH8ij0DN3rhOZ2CWA6T8M=
X-Proofpoint-GUID: YMVkDWfjaiBMTKbQIkwZ5oznq6rb3cCd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX2NwgmepoK20Y
 7D/fw+2WjPH4E0ZdF6nYjyp8515SYwO1bLaus6Zroba6M0I2dAoGADo1T0LWiy8EOU112qVW2lU
 It8dfMaqQHM3TGW73dmRMvG0KZ2E9NpH5MnGr8M+fDdaTK+wb744wuEknumJe6gMydX7eROyrFC
 3rQOajyUnn2qLtO+NlZjxYF5KkyHyNGrwA9hSxTnsN3V2SakhlvZsJqxy+eSwFPdL4ST2Ya8bd5
 3vbOeG5ADJIGG+kSi6hxDLvLWWKOFwV66duQMdhunWw3XGPZEqjUHJNoRI2Yvy8cQhUKGBKo9wL
 JqYrls6/RiiigHZd5r+7R7RVcLHVYylKCUTrXzrh9u8gWe94V5qQAsLS9tWqDHs+mYuPiE/wdmA
 2sOLCcUNUStCBzNVHNmxhUrVObaloTzdA2duYvdRKwmdYq+pySwJd82t+QGzOvk78XcZszqPmJD
 w7IwdWny7qbHbm19+kQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300214
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


