Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C0DF4644A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25PG-0001CP-LE; Mon, 16 Mar 2026 06:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PE-00018e-Rz
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:40 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PD-0003eT-A2
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:40 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4852e09e23dso37053975e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 03:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773657758; x=1774262558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FyYo7TUCoOnQrJXCspYnQwSv39jJvi+iPpwNTD7BrMo=;
 b=x63SkMqYm8xTciIHz+Iw+33EBvjhDWBetnMyrRwOglGtci1tcUPFFPfb732rd9CGXZ
 /ePPgp0z0IpORrlYG8TDwuk/Cznm0bGzA4YkZOEnaeqJ0XdrM2+hQi/0YQWLOAjRh0Ub
 zXM5+y650azF9C+Nr9TaSUiznn7CKL+ooWLcJzXh/DmiG6FUpROlxb4hZOfhqqawcNws
 7UMA5mRFLRdzlXfFJtDKQ74cORSibzhB7s6jRhA2z2GKpMpgpYDIWthgLkZ2NYqm+Yaf
 kioD71o7nSNiR8ICsbGL9fg2e/gSLimeDN6uP7KJ73dn3uPjlqy75do7ze1qOgr0THKL
 O2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773657758; x=1774262558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FyYo7TUCoOnQrJXCspYnQwSv39jJvi+iPpwNTD7BrMo=;
 b=j601oR9sC5SwAmH5kOp7MrYrZdBisMbYcezvGMyTGrp1CnT9um4mk34h9ULEI3dhFJ
 lPKw9Jpb03Gp8ja4RiUXL27mMXfjyBORtVFlCDAKLs0t7l+yjXFue07RsVGzuWc/d1EK
 3IZE7KUHAEFTEuGSjPKVXk087o4DomYsVc9Op7cghdsqSjQF5h+hibvjuqW5re7ShDdt
 0SozgoQRILER/+2dikzmv1eFT9DF4+Jmf0pcSc7nmt77LkoEqUWkbWJtDsDYTbBcTxp3
 r2SxeMeFA+4yLxElqhurTwBcNdHUC2R3eqYI6W9Wd4FDLxz/nPgmGETwgaH4dd3CMKpc
 KRQg==
X-Gm-Message-State: AOJu0Yx4azMHotn0DW83o3+TBDnjcpKPulfAeyhAtOcfCuKWKpnQh2r6
 pwqwmqcqP3rEJv6UZGgfXBLGAfyWrq+hxOZBwp0vC/noMOeT4KgikXem2VCrUjRPHcSukyhxQ+w
 XwOQK
X-Gm-Gg: ATEYQzzoRlueyU3Ebo3jrMJVMJhZo+zxBhXsRoz8wpiw5BYlk7jws9414xSWOVxH+Su
 WeFmfBhPZCUiiH1lk1+Vz3xO0SviIzp7ACwrp4QNGG40nZ0QXaVz3+wDJm/9bHglvG5jLGpMu1x
 M0+62l/hK6yvoIReeefGhb7CctNGUC7OWP5dSwCE/gWNwwlJE1UnDOFiWx2/n64/7bu6Bb7KlAw
 1u2CGHvT/OA8u7/nQ6lk8dvpVMhfsbYfsMAonpy+q4mPfwRkjMa35WTZ4YEPgouQ0IAG5Fi+4WW
 T5Jbq7FNSUahMivY+z0qhqQtc63/cm/twzT/cVLf1qJgUnwcTHU9RuYfK09wTlV09VHFla1XQrh
 1Qe3bO9PJwOy2maIubND89FtnfiOvcDOIbQybqP1vDMpdZSqaneWtUa/bufHDdAt0RRzZX5AVBM
 agZhQ3lwFg5H59USmh/LcSi4jLcS5sHfbARq4nBwbzQOxRT9RoRx3PYNW76it5z05DEYIfinXX7
 6MEgtbyicg=
X-Received: by 2002:a05:600c:a4b:b0:485:3e20:4013 with SMTP id
 5b1f17b1804b1-48556705290mr204890565e9.28.1773657757609; 
 Mon, 16 Mar 2026 03:42:37 -0700 (PDT)
Received: from lanath.. ([81.2.115.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557a74266sm85519135e9.17.2026.03.16.03.42.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 03:42:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/17] include/exec: Provide the cpu_internal_tswap() functions
Date: Mon, 16 Mar 2026 10:42:16 +0000
Message-ID: <20260316104230.836962-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316104230.836962-1-peter.maydell@linaro.org>
References: <20260316104230.836962-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Martin Kröning <martin.kroening@eonerc.rwth-aachen.de>

These functions are needed to support semihosting on CPUs that support
runtime-configurable endianness. They should not be used in other contexts.

Signed-off-by: Martin Kröning <martin.kroening@eonerc.rwth-aachen.de>
Message-id: 20260311-semihosting-cpu-tswap-v3-2-8e239575ec08@eonerc.rwth-aachen.de
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.43.0


