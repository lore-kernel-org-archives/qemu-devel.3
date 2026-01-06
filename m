Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A1AC47BFD
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 14:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd810-0000VZ-6l; Tue, 06 Jan 2026 09:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1vd7LK-0001Bo-Fq
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 08:43:26 -0500
Received: from mail-out-1a.itc.rwth-aachen.de ([2a00:8a60:1:e501::5:44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1vd7LH-0006Qb-DS
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 08:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=rwth-aachen.de; i=@rwth-aachen.de; q=dns/txt;
 s=20240516-RWTH; t=1767707004; x=1799243004;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=73vdagFbM4n4jkzeLYOfs3VbsPjQUH/AUGdhSoTmT20=;
 b=rrMSFNSODa5EoT6KkDyYyuAkRdat4f16Wuscax/H5DJq/Hbc/tqaeyQE
 fVtOd/PgyI0Empp1eJwyUbUYRjdUKi6AOliSsqT5HZkW+9D/jaaMaD9/V
 gwdildNqAgC5IRMzVrUsJjTO5i21VmQNAYw8CmnNRdewxKXRVAdJRAUn/
 9aeJVxifYcHDDYY/ek9es9wv5cZg8nESgmGYL8Zx0CTOyY5mjW8ua/oWI
 OgksR96BqkIStxdaNbTET4972TLJNKZefK7rdxkKfFT4v2DORMNNWbGrH
 BY6LOkD4Qn8usU8bhUYpgNSyfbGJYHQWtM2O8vxgosJELJf4q3QVvpMST A==;
X-CSE-ConnectionGUID: UOMlYq4fQK+PghE2fu9AtA==
X-CSE-MsgGUID: SCv7MWGnSuWukpVkt2OgSg==
X-IPAS-Result: =?us-ascii?q?A2BNAwByEF1p/5oagoZagQmEJ4JbhFeyEA8BAQEBAQEBA?=
 =?us-ascii?q?QEIAVEEAQGFBwKMbCg4EwECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQYBAQEBA?=
 =?us-ascii?q?QEGBYEhhglThlsGIw8BRhAlAiYCAkYQBg4FgwKCdLBOgTKBAYR82gSBHwELC?=
 =?us-ascii?q?QEKAYEKLohTAYFvhACEeIJPgUqCPXaFEIMOgmkEgzCLRwaJQwk/gQJ4LAFVE?=
 =?us-ascii?q?w0KCwcFYYEFAzUSKhVuMh2BIz4XPmMhCQWCbAaJAA+JWoEVAwsYDUgRLDcUG?=
 =?us-ascii?q?0MBbgeQCoJ3gQ6CBmOXG69WB4I4gWehcgEyl2CTCy6YWKRZhD0CBAIEBQIYg?=
 =?us-ascii?q?X+BfnGDNlIXAg+OLRbGdXcCOgIHAQoBAQMJgjmRLgEB?=
IronPort-Data: A9a23:xPvMNKx80DjcFYzOGVx6t+dFxyrEfRIJ4+MujC+fZmUNrF6WrkVUy
 WIWDG+CP6qPNzP9eNFyboS3oxgG6sXcxoNnSVdupFhgHilAwSbn6XV1DW+tZX/Ifp2bJK5Dx
 59DAjUVBJlsFhcwnj/0bP656yI6jf3ULlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWBfgX8s9JIGjhMsfzb8Usx5K2aVA4w5zTSW9ga5DcyqFFIVPrzFYnpR1PkT49dGPKNR
 uqr5NmR4mPD8h4xPcium7D9f1diaua60d+m0yc+twCK23CulwRqukoJHKN0hXR/111lq+tMJ
 OBl7vRcfy90ZPGWyLRFO/VvO3oW0aVuoNcrKJUk2CCZ5xWun3DEm52CAKyqVGEV0r4fPI1Ay
 RAXAA0qSxSynr64+ZH4cuZsq54tMZjCIKpK7xmMzRmBZRonaYrcX6XH9ZpDhnI5wNpRAfabb
 sZfZTcHgBboOkYTfA5MUNRkwqHx2yWXnz5w8Tp5oYIy6nLPzQo306LqPdzUfNOiSMJTk1yT4
 HjZ42S8CxgRNNGZjzaImp6prraRzXOnA99LTNVU8NZRq0PM41M8DiYLaka4uce6lhSZVOlQf
 hl8Fi0G6PJaGFaQZsDwWgD9rHOasxo0Xd1WHOsnrgaXxcL86gKUFi4OQzhHZdEOsM4wTCYtk
 FiTkLvU6SdHqqKJSX+Ns6zO6Dr0IzcJLSoLaWkIQGPp/uXenW36tTqXJv4LLUJ/poSd9e3Yq
 9xSkBUDug==
IronPort-HdrOrdr: A9a23:k/U2q6sBPXWjhZIQDNbV39Pl7skDgNV00zEX/kB9WHVpm5Sj5q
 STdYcgpHjJYVcqKQwdcL+7WJVoLUmwyXcx2/h1AV7AZnibhILLFvAA0WKK+VSJcEfDH6xmpM
 VdmsNFZ+EYeGIasS+M2meF+rgbrOVvu5rY49s2h00dND2DQMlbnn9EIxfeFlczSBhNBJI/Gp
 bZ/MtOvDasfXwWa8+8Fz0fWfTfp9rEnJzrZgNDHgUg4gWVlz+kgYSKaSRw8C1uKA9y/Q==
X-Talos-CUID: 9a23:2Rr6cW+Uqi4S8qhgKjqVv3MzP8QUayHT9VSTG0C4JDxnVey8VXbFrQ==
X-Talos-MUID: 9a23:6pX6nwk2oNBWDEAUinM7dnpZH9k3xpuBDnsQrogFo/eHKXZXNAyS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,204,1763420400"; d="scan'208";a="168843510"
Received: from rwthex-s2-a.rwth-ad.de ([134.130.26.154])
 by mail-in-1a.itc.rwth-aachen.de with ESMTP; 06 Jan 2026 14:43:18 +0100
Received: from mkroening-ud22.fritz.box (2a0a:a54a:c75:0:1df6:38e8:59e6:777c)
 by rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154) with Microsoft
 SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 6 Jan 2026 14:43:17 +0100
Date: Tue, 6 Jan 2026 14:43:05 +0100
Subject: [PATCH 1/2] include/exec: Provide the cpu_tswap() functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260106-semihosting-cpu-tswap-v1-1-646576c25f56@eonerc.rwth-aachen.de>
References: <20260106-semihosting-cpu-tswap-v1-0-646576c25f56@eonerc.rwth-aachen.de>
In-Reply-To: <20260106-semihosting-cpu-tswap-v1-0-646576c25f56@eonerc.rwth-aachen.de>
To: <qemu-devel@nongnu.org>
CC: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?q?Martin_Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>
X-Mailer: b4 0.14.3
X-Originating-IP: [2a0a:a54a:c75:0:1df6:38e8:59e6:777c]
X-ClientProxiedBy: RWTHEX-W2-A.rwth-ad.de (2a00:8a60:1:e500::26:158) To
 rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154)
Received-SPF: pass client-ip=2a00:8a60:1:e501::5:44;
 envelope-from=martin.kroening@eonerc.rwth-aachen.de;
 helo=mail-out-1a.itc.rwth-aachen.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 06 Jan 2026 09:26:27 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  =?utf-8?q?Martin_Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>
From:  =?utf-8?q?Martin_Kr=C3=B6ning?= via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

These functions are needed for CPUs that support runtime-configurable endianness.
In those cases, components such as semihosting need to perform
runtime-dependent byte swaps.

Signed-off-by: Martin Kröning <martin.kroening@eonerc.rwth-aachen.de>
---
 include/exec/tswap.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index 72219e2c43..9aaafb12f3 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -10,6 +10,7 @@
 
 #include "qemu/bswap.h"
 #include "qemu/target-info.h"
+#include "hw/core/cpu.h"
 
 /*
  * If we're in target-specific code, we can hard-code the swapping
@@ -21,6 +22,8 @@
 #define target_needs_bswap()  (HOST_BIG_ENDIAN != target_big_endian())
 #endif /* COMPILING_PER_TARGET */
 
+#define cpu_needs_bswap(cpu)  (HOST_BIG_ENDIAN != cpu_virtio_is_big_endian(cpu))
+
 static inline uint16_t tswap16(uint16_t s)
 {
     if (target_needs_bswap()) {
@@ -48,6 +51,33 @@ static inline uint64_t tswap64(uint64_t s)
     }
 }
 
+static inline uint16_t cpu_tswap16(CPUState *cpu, uint16_t s)
+{
+    if (target_needs_bswap() || cpu_needs_bswap(cpu)) {
+        return bswap16(s);
+    } else {
+        return s;
+    }
+}
+
+static inline uint32_t cpu_tswap32(CPUState *cpu, uint32_t s)
+{
+    if (target_needs_bswap() || cpu_needs_bswap(cpu)) {
+        return bswap32(s);
+    } else {
+        return s;
+    }
+}
+
+static inline uint64_t cpu_tswap64(CPUState *cpu, uint64_t s)
+{
+    if (target_needs_bswap() || cpu_needs_bswap(cpu)) {
+        return bswap64(s);
+    } else {
+        return s;
+    }
+}
+
 static inline void tswap16s(uint16_t *s)
 {
     if (target_needs_bswap()) {

-- 
Git-155)


