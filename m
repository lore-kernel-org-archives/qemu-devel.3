Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A841125852
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0MQ9-000490-CU; Wed, 11 Mar 2026 12:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1w0MPv-0003at-Gp
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:28:20 -0400
Received: from mail-out-4.itc.rwth-aachen.de ([2a00:8a60:1:e501::5:49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1w0MPt-0006QT-Mt
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=rwth-aachen.de; i=@rwth-aachen.de; q=dns/txt;
 s=20240516-RWTH; t=1773246494; x=1804782494;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=l6lweD7h74hVOVRYCejbvTTvCwLFBnbfNjOb2b63QAA=;
 b=d43PNJXqs8c/3BolPRRG1GZOHbmBgzfZLtvwgRbT7X0Ku8xSlQfszSvv
 94X2LV8RR1i3gqzRExNWc1lGVa0OZkIB/aSdGwsjPqu0z7JCQpql0CKot
 GzWOQWFhHd5bZx+D72i0KvvgLMDfQdQgnDuvzIH+qgVQN5J+VI8ZZ7tmY
 Hm1jybXYfQ6+Q6Q1stmbTQ8kE8vkFXTjWoBDD6RMql4NbDEfgEHU3+kG6
 K3brELzHps+oJmyUsdwI69Vg5DlLQzXLxLtR4f/EyRSZYsarJHgATPFvm
 RlnOFVSFuUJ94aroPoQuTtRzaCM3MuJ2/gj/N+eyodIbEA8kH+ETRgWGj w==;
X-CSE-ConnectionGUID: 6H8uM6cUS2S1Z1kwrnGs1Q==
X-CSE-MsgGUID: UXLbhgsbQkSa8nUNlsHXlA==
X-IPAS-Result: =?us-ascii?q?A2C3BwD+lrFp/5oagoZagQmEJ4JbHQEBhDiqM4ddDwEBA?=
 =?us-ascii?q?QEBAQEBAQgBUQQBAYUHAo0iKDgTAQIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBB?=
 =?us-ascii?q?gEBAQEBAQYFgSGGCVOGWwYjDwFGECUCJgICRhAGDgWDAoJ0sQKBMoEBhHzaB?=
 =?us-ascii?q?4EfAQsJAQoBgQouiFQBgXCEBIR6gk+BSoFHdnaFEIMOgmkEgzCHPgaLXwk/g?=
 =?us-ascii?q?QJ4LAFVEw0KCwcFYYEFAzUSKhVuMh2BIz4XM1gbBwWFHg+IcIE7BCOBEYMpA?=
 =?us-ascii?q?wsYDUgRLDcUG0EBbgeNdT2CNIEOggZjlxuvVgeCOIFnoXIBMpdgkwsuh2WQc?=
 =?us-ascii?q?6RZhD0CBAIEBQIYgX+BfnGDNlIXAg+OLRbMHXcCOgIHAQoBAQMJgjmQEQGBH?=
 =?us-ascii?q?AEB?=
IronPort-Data: A9a23:53iVUq8dTsQceR0cowhODrUDpn+TJUtcMsCJ2f8bNWPcYEJGY0x3y
 mUbUD2EaPqMazbxfd0la43l90wFvMLQmoU1SVM5rn1EQiMRo6IpJzg4wmTYYnnOdJ2TFCqLy
 +1EN7Es+ehtFie0Si+Fa+an9T8nk/nUGtIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3Zhn/gFaYDkpOs/jd8Eg25ayr0N8llgVWic5j7Qe2e0Y9Ucp3yZGZdxPQXoRSF+imc
 OfPpJnR1n/Z5RokFuS+mb/9dEAQKpaKVeRZoiMLM0QKqkEqSh0ais7XBtJFAatko2nhc+RK9
 Tl4ncfYpTEBY/eQwrRNC3G0JAklVUFO0OevzXFSKqV/xWWeG5fn660G4E3boeT0984vaVyi+
 8D0JxhTTkCeory9/YnhcbBe38c8Ns/EJ9om7yQIITHxVZ7KQLjZXLnK6M8dx211j4ZUAureI
 sMVLzZiBPjCS0QUZhFOU8p4xrnu3ySjG9FbgAv9Sa4f5mHJ0A13lrv3N9fTe9qFbchSmEuCr
 STc4Hj5RxgTP9ySz3yJ/xpAg8eVwXurBN1MSdVU8NZXsHmZxmMIAiQVblLrp8SfjlWea9Z2f
 hl8Fi0G6PJaGFaQZtD5Ug3+qnOCuBMRc95RFeQg70eK0KW8yx6ZB2wBQhZFadovrshwQiYlv
 neRks/kH3pquayZRHaZ3rOVqzqoPm4SN2BqTTYJSBZA79T9rYUbiBXJQdB+VqmvgbXI9SrY2
 S+WrCUuwq5JyMdNzbqn/RXOj3Sgq/AlUzII2+keZUr9hisRWWJvT9XABYTzhRqYELukcw==
IronPort-HdrOrdr: A9a23:VTEqKKylpyDNuDS+zvvWKrPwLr1zdoMgy1knxilNoH1uA6ulfq
 WV98jzuiWYtN98YhsdcKm7Scq9qCrnhPxICOoqTNOftXfd11dARbsKhbcKpQePJ8TQzI9gPM
 xbH5SWZueRMbCQ4PyKhTWFLw==
X-Talos-CUID: =?us-ascii?q?9a23=3A/l3N+WmjK5rsQhsgnM6RT+977/LXOSP9nGr1fUS?=
 =?us-ascii?q?FMjxSEY/MSkCK/ox/yvM7zg=3D=3D?=
X-Talos-MUID: 9a23:w5qJ0Qtz4yH6ThQH482nuQFGPsdn+K6XC3sEwZM7nc2fFRx0EmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; d="scan'208";a="24084765"
Received: from rwthex-s2-a.rwth-ad.de ([134.130.26.154])
 by mail-in-4.itc.rwth-aachen.de with ESMTP; 11 Mar 2026 17:28:04 +0100
Received: from mkroening-air.local (137.226.124.87) by rwthex-s2-a.rwth-ad.de
 (2a00:8a60:1:e500::26:154) with Microsoft SMTP Server
 (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 11 Mar
 2026 17:28:02 +0100
Date: Wed, 11 Mar 2026 17:27:15 +0100
Subject: [PATCH v3 2/3] include/exec: Provide the cpu_internal_tswap()
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260311-semihosting-cpu-tswap-v3-2-8e239575ec08@eonerc.rwth-aachen.de>
References: <20260311-semihosting-cpu-tswap-v3-0-8e239575ec08@eonerc.rwth-aachen.de>
In-Reply-To: <20260311-semihosting-cpu-tswap-v3-0-8e239575ec08@eonerc.rwth-aachen.de>
To: <qemu-devel@nongnu.org>
CC: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, =?utf-8?q?Martin_Kr=C3=B6ning?=
 <martin.kroening@eonerc.rwth-aachen.de>
X-Mailer: b4 0.14.3
X-Originating-IP: [137.226.124.87]
X-ClientProxiedBy: rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154) To
 rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154)
Received-SPF: pass client-ip=2a00:8a60:1:e501::5:49;
 envelope-from=martin.kroening@eonerc.rwth-aachen.de;
 helo=mail-out-4.itc.rwth-aachen.de
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
index 9e94fa0021..17ac544454 100644
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
+    if (cpu_internal_needs_bswap(cpu)) {
+        return bswap16(s);
+    } else {
+        return s;
+    }
+}
+
+static inline uint32_t cpu_internal_tswap32(CPUState *cpu, uint32_t s)
+{
+    if (cpu_internal_needs_bswap(cpu)) {
+        return bswap32(s);
+    } else {
+        return s;
+    }
+}
+
+static inline uint64_t cpu_internal_tswap64(CPUState *cpu, uint64_t s)
+{
+    if (cpu_internal_needs_bswap(cpu)) {
+        return bswap64(s);
+    } else {
+        return s;
+    }
+}
+
 #endif  /* TSWAP_H */

-- 
Git-155)


