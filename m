Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D922C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjeX-0006Vq-IY; Mon, 06 Jul 2026 09:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgje8-0006Lw-Hb
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:46:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgje6-0006B4-IO
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:46:04 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxHXU395393
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ce1sLUDroG8UkuFIYnhKQTJrjdvF9gdtq70M46Gkvxc=; b=nIe/h8m7VluzKqAl
 Q5sWQy+6LwLoSqwDdEiQ7d52UX5TErxWb7oUde6l3wsDZeJaQXtpck1GWxmTf2f7
 ScAigQEMufCCqw8+QgT8149lsReaZMXtISopSZ9LSDv5SP8oc3zJRxQl+jO5lOml
 Gf2vrsBlT6QWY0O9JwRBJ5yIuHhOXlaFrx08u5U53p3mPGUJJKcGiOEA+hLph0RN
 RKbfNuK6HuoWnyStXoFt+x7MMCndwTzVaiuriolhg3p8K9rU21JPIt48oZnvt0Lz
 u9qhmSsd47x0zSyRztzyOX/GotWNemWAjBpV1jD3ANLQd2aZa/PcFMrQ410EVX8q
 fRh08Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qph07v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:46:01 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so333029885a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345561; x=1783950361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ce1sLUDroG8UkuFIYnhKQTJrjdvF9gdtq70M46Gkvxc=;
 b=C6efEAB4EHvGaesn5/fOXXu8LIKcB9aVX6immTnrt5QWonENRNW5OqMiv1pHRHk/Xu
 qAxvmtqnA4zKHMxY3OFBIUZz2vZFivVJZByTAQv3mj2VjI72zRNiV+YD3ihq194OHfx0
 UOu63xqyJladwHlA1BrAd0/5bDUttUNlGQCQeciVTxMW663TE+1nWv6Cf1bj/RnBYmpJ
 02W1Yh8UJqP2fuW+IGp3G5aQQrCdoI43aUt+njLpT5v8pm+JXHZ4VLT7JmMkzs9d6taj
 PAsPRHb0VpsO3qSTBk4cUfI1HeX9nNtmBXEH931dXm8zwW/Qkk9/PkHbqeNjTyppUROV
 kB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345561; x=1783950361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ce1sLUDroG8UkuFIYnhKQTJrjdvF9gdtq70M46Gkvxc=;
 b=cg8ZCN3uPwJLCw34kDHGQYdg6mnqvwjpQ8YW9HX3N/eQ3/pW7EiaVrR85LpJz36XDK
 oM6vzkEH7S52zrX7sidWY4oVHUoeW7nyPCrJRM5qMDxjuO7aOXj/ceUgE6alQUNbYd+n
 TFgBZFJKI8bGvlrWWWJfv0kck9SGSR3efB66tJuQ60m4Pfr92jBDjhhHbEh1OFo5uGNl
 9IouOsvkTjAZbrQ/zbiTSsyKZLtJVHd1cA1QwJPiOEbKjcCXuuCXliDuSMyP8ct4KkDv
 HStYocSUFIJPZ01OBwSEcQfC+/2ovocoyY0D/1bTILUevL9f6myxAO0kDF/W+CWrHRK4
 JYOQ==
X-Gm-Message-State: AOJu0YzuVl1ITiStdrxUb6V/afsdsYtyqOV9ybE2JXvI7+v0yyfIh2lj
 dhvD5g5bJrIZ+Pa3PT0rUSnpNuTGrZw6mzmUI9tKEGz+yeS47CHiK43sf3nNSBQF01haqaOSMR5
 WZvEPaMoQmJh9g5DKHgQObqae6ASmmGJwOOhS4YZgk4PQclqg/Z1XAvYxckEZ4CGBKw==
X-Gm-Gg: AfdE7cmAqnX8Jc3bSZFO+OfiT0QxMYIXQPtxMWRSrt9B0H+0EbD4v8sZyeumD5v76zo
 5zXI5c0ZnF0FeQPtRZ4SyRtduVBIFHZFeZFhuMAhvZ/UcIKnUKocKTVXAB1WVzdgAx82bW6CoOz
 T3kS+4dMdrQ2lU59jdyS1ePH4RJyreQw0T4NB58oIsCcLMRxI5BsS2EELwOpjQpG6LD4ZxU7tqp
 t2I9MmiZTbP5qEZpthG4WRxKV45wO4ONZ94nqgYRcfScrV1JO/OXytjt2krb+oTXltH4LEavaU/
 OOcmaFlf0fnqmPKCy2GNI0yW3f1XuDQxLlHIM7CuFa8X5jY73Zt5YKanzCcyhqUJoJ/zAf0aBcH
 sPuvLIEIKki1Z3WGWGTmKg+4XMg0ljUKysOZ+L/cE8Iol60P4buRdB95NRw==
X-Received: by 2002:a05:620a:4693:b0:92e:73bf:e920 with SMTP id
 af79cd13be357-92ebb5f5b35mr80522485a.50.1783345560810; 
 Mon, 06 Jul 2026 06:46:00 -0700 (PDT)
X-Received: by 2002:a05:620a:4693:b0:92e:73bf:e920 with SMTP id
 af79cd13be357-92ebb5f5b35mr80517985a.50.1783345560255; 
 Mon, 06 Jul 2026 06:46:00 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef248b7sm290298735e9.2.2026.07.06.06.45.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:45:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/32] accel/tcg: Restrict tlb_protect/unprotect_code() to TCG
Date: Mon,  6 Jul 2026 15:44:58 +0200
Message-ID: <20260706134527.84808-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4bb199 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=glojBnVPa3CR4aLdIrwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: c_pkW0J2QHTrVNtCoo_ERWxX_A8pSQqC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX2M8fy5bi8szi
 YTPA05yQzlO1AQTW8eKlYjd/eRUknz6OcyAJJMUfCvt1IwrNpGbs+o0BTwAMYJiKd35LBB8dCEb
 86wLx1PoVTe2DUjnTMrhXybOqhWvCvfj6TaA31n3/WHCrIgO6Mv3ZlV9GnybBItlphUwvg+MukU
 qvqOhJlIFxAqtQBmKECVZn3pAWDD0VR2L9AcVwE2JJ5/qzkaTTcQXfOEPQTCDJ6qu/2t21zkCOY
 u7rXvpxTYks91GZ3PGRleSmeGTzxJ2PLUkeggjLPcaisffeCGV5Tfg1pq1Hfv+ibd9A6QWPKCbN
 LzbYxnW+32Tc2Z/wrysPNxR/JrEAWVn3BzWCGLpHOtkzTphT3q/xpYPHejEjINkwwkfNeOJVmGz
 n2ApZgBOE73Kjjj6+QgjndHbtToEZJ64cotIolPfb4DyRmwBfvNOoMlALpEdxWAxb0ZMXyqDPnF
 yGrVT0CMxKh20A38rYQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX5nHSJrl2XlFo
 YkRoslLiUdbCR1IV7RBPbdJdTUP0OQ+Jq15wBHiKqTPIYHXg3swn6zkxRWbQ2X5l59Wfb+DJLVw
 qFcfGyCjaU7GowVSpwMo7194TsnvQhE=
X-Proofpoint-GUID: c_pkW0J2QHTrVNtCoo_ERWxX_A8pSQqC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060140
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

Both tlb_protect() and tlb_unprotect_code() are only used
within accel/tcg/. Avoid exposing them to the whole code base,
declare them in a new "system-page-protection.h" local header
(maintaining the previous LGPL-2.1-or-later license).

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260705215729.62196-4-philmd@oss.qualcomm.com>
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


