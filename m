Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6861FFEFB47
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 12:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvxNp-0001iR-Tx; Fri, 27 Feb 2026 07:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1vvxNo-0001hY-D0
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 07:55:52 -0500
Received: from mail-out-3.itc.rwth-aachen.de ([2a00:8a60:1:e501::5:48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1vvxNm-0002pc-Ns
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 07:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=rwth-aachen.de; i=@rwth-aachen.de; q=dns/txt;
 s=20240516-RWTH; t=1772196951; x=1803732951;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=2e6NsKFQE3edH9/dTQns73nLn17oxzJMf/bQqPOr0+U=;
 b=oGA1rw0THD07s4Hpg+SRmjxvrGkQxZjGrpBnSSIsFzTGbxdhIR/RBwlw
 0uEq4MRwLmQEk6uhZqMCPUpQ53jkrdgxNzIQecKBCl4q8ttPTZw5vVmgi
 ziVEwepbdZ2SOLhrINhBu926q7khWXPN2hPGnTMoGPTh0XQHuTGVzufJ4
 Zu97cpO/ys0NYLdDoh0t1S648Jxwgu1zkaCSZVNU8X8MM+KhnI9YIgbwV
 VxCSNcUiwLyxXuX+glAGkp36ObxNTORoQ8w0lgZMwysmLNRUiMMXG/VXC
 FKneFjn4/MrTtbFdpELSygQ/0flLTL9ZIbLmLrjyr0ruT8LysIjhjiRAz g==;
X-CSE-ConnectionGUID: ZX9uB+4zSS+UtbyMJd0I4w==
X-CSE-MsgGUID: 6DaV4k/bSjyjr44pFTXQTQ==
X-IPAS-Result: =?us-ascii?q?A2AcBwA9k6Fp/5oagoZagQmEJ4JbHQEBhDiqM4ddDwEBA?=
 =?us-ascii?q?QEBAQEBAQgBUQQBAYUHAo0fKDgTAQIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBB?=
 =?us-ascii?q?gEBAQEBAQYFgSGGCVOGWwYjDwFGECUCJgICRhAGDgWDAoJ0qAOBMoEBhHzaB?=
 =?us-ascii?q?4EfAQsJAQoBgQouiFQBgXCEBIR6gk+BSoFHdnaFEIMOgmkEgzCHdAaLHAk/g?=
 =?us-ascii?q?QJ4LAFVEw0KCwcFYYEFAzUSKhVuMh2BIz4XM1gbBwWFfA+IdIE9BCOBE4IcA?=
 =?us-ascii?q?wsYDUgRLDcUG0EBbgeNbj+CNIEOggZjlxuvVgeCOIFnoXIBMpdgkwsuh2WQc?=
 =?us-ascii?q?6RZhD0CBAIEBQIYgX+BfnGDNlIXAg+OLRbJU3cCOgIHAQoBAQMJgjmQEQGBH?=
 =?us-ascii?q?AEB?=
IronPort-Data: A9a23:JOHnE66W0dHKRkSxRBRxygxRtBnGchMFZxGqfqrLsTDasY5as4F+v
 moWWmHVPf3ca2P1KN1+O9yx9EkE6MLRm9MxSAttqihmZn8b8sCt6fZ1j6vTF37IcpeTHBoPA
 +E2MISowBUcFyeEzvuVGuG/6yE6jufQGuaU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjgWcc3l48sfrZ9ks15quq4Vv0g3RnDRx1lA6G/5UqJM9HTU2BByOQapVZGOe8W
 9HCwNmRlkvF/w0gA8+Sib3ydEsHWNb6ZWBiXVIPBsBOKjAbzsAD+v5T2Mg0MC+7uB3V9zxF8
 +ihgLTrIesfFvCWxL5NA0Ew/xZWZsWq8JefSZS2XFf6I0fuKxMAyN02ZK060BFxFutfWQlzG
 fIkxD8lXCDSmsj1nKCAcapRms4yCevnZKJDpSQ1pd3ZJa5OrZHrWbrW5dJImSxqw8kIB+nCZ
 48QZXxjYXwsYTUWYQtRUclm2r32wCCiL1W0q3rMzUYzy23a1hBw1v7uKt3YfN2MSu1YmUCVv
 GmA5XvlAlQTPdefxDzD/n/EaurnxnqmAdhMSOfhnhJsqAO/z1JPC1ocblmqo+Pl1laQZ+JmF
 3VBr0LCqoB3riRHVOLVRx25pHuIlhodXdNKFKs98g7l4rLZ/wuDQG0NXzJMbNgOsM4wTCYtk
 FiTkLvBHDFqrfiZRGyQ8p+SqjW9PzVTKnUNDQcNSQYVpdPupoc+gzrLT9BqCqnzicf6cQwc2
 BiQszQ+iqVWlpRO3uOh4kzHxjug4JTEJuIo2jjqsquexlsRTOaYi0aAtTA3Md4owF6lc2S8
IronPort-HdrOrdr: A9a23:cBYMJaCUF716HTjlHemP55DYdb4zR+YMi2TDtnoBKiC9F/bzqy
 nAppgmPGDP+U4ssR0b9+xoQZPwOE80rKQFh7X5Xo3DYOCFggaVxehZhOOI/9SKIULDH4BmtJ
 uJzcVFebjN5eQWt7ec3OEGfuxQpOWv4eSyi6PGyW1xSQlsL7xx9gsRMHf4LnFL
X-Talos-CUID: =?us-ascii?q?9a23=3AqCvOKmudgcYE18/yBb2FvoeU6IsXQizA5jSMMXS?=
 =?us-ascii?q?DSlt1Qqywa1PI2f97xp8=3D?=
X-Talos-MUID: 9a23:fXcmrgh+yflZ11JjlTwmLcMpauth3fitT0o2k4QEoZXYLQJMCw6htWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,314,1763420400"; d="scan'208";a="315126421"
Received: from rwthex-s2-a.rwth-ad.de ([134.130.26.154])
 by mail-in-3.itc.rwth-aachen.de with ESMTP; 27 Feb 2026 13:55:41 +0100
Received: from mkroening-air.local (134.99.235.10) by rwthex-s2-a.rwth-ad.de
 (2a00:8a60:1:e500::26:154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 13:55:40 +0100
Date: Fri, 27 Feb 2026 13:54:31 +0100
Subject: [PATCH v2 2/3] include/exec: Provide the cpu_internal_tswap()
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260227-semihosting-cpu-tswap-v2-2-cbdcdf39dd15@eonerc.rwth-aachen.de>
References: <20260227-semihosting-cpu-tswap-v2-0-cbdcdf39dd15@eonerc.rwth-aachen.de>
In-Reply-To: <20260227-semihosting-cpu-tswap-v2-0-cbdcdf39dd15@eonerc.rwth-aachen.de>
To: <qemu-devel@nongnu.org>
CC: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, =?utf-8?q?Martin_Kr=C3=B6ning?=
 <martin.kroening@eonerc.rwth-aachen.de>
X-Mailer: b4 0.14.3
X-Originating-IP: [134.99.235.10]
X-ClientProxiedBy: rwthex-s1-a.rwth-ad.de (2a00:8a60:1:e500::26:152) To
 rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154)
Received-SPF: pass client-ip=2a00:8a60:1:e501::5:48;
 envelope-from=martin.kroening@eonerc.rwth-aachen.de;
 helo=mail-out-3.itc.rwth-aachen.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  =?utf-8?q?Martin_Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>
From:  =?utf-8?q?Martin_Kr=C3=B6ning?= via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

These functions are needed to support semihosting on CPUs that support
runtime-configurable endianness. They should not be used in other contexts.

Signed-off-by: Martin Kröning <martin.kroening@eonerc.rwth-aachen.de>
---
 include/exec/tswap.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index 9e94fa0021..6d9301129d 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -10,6 +10,7 @@
 
 #include "qemu/bswap.h"
 #include "qemu/target-info.h"
+#include "hw/core/cpu.h"
 
 /*
  * If we're in target-specific code, we can hard-code the swapping
@@ -72,4 +73,39 @@ static inline void tswap64s(uint64_t *s)
 }
 #endif
 
+/*
+ * If we're in semihosting code, have to swap depending on the currently
+ * configured endianness of the CPU. These functions should not be used in
+ * other contexts.
+ */
+#define cpu_internal_needs_bswap(cpu) \
+    (HOST_BIG_ENDIAN != cpu_internal_is_big_endian(cpu))
+
+static inline uint16_t cpu_internal_tswap16(CPUState *cpu, uint16_t s)
+{
+    if (target_needs_bswap() || cpu_internal_needs_bswap(cpu)) {
+        return bswap16(s);
+    } else {
+        return s;
+    }
+}
+
+static inline uint32_t cpu_internal_tswap32(CPUState *cpu, uint32_t s)
+{
+    if (target_needs_bswap() || cpu_internal_needs_bswap(cpu)) {
+        return bswap32(s);
+    } else {
+        return s;
+    }
+}
+
+static inline uint64_t cpu_internal_tswap64(CPUState *cpu, uint64_t s)
+{
+    if (target_needs_bswap() || cpu_internal_needs_bswap(cpu)) {
+        return bswap64(s);
+    } else {
+        return s;
+    }
+}
+
 #endif  /* TSWAP_H */

-- 
Git-155)


