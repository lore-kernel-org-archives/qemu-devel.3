Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAFDE9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Mm-0007Ni-5u; Thu, 19 Feb 2026 05:34:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Mh-0007JS-DC
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:35 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Mf-00067g-9n
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:35 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48371119eacso7373325e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497267; x=1772102067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nvkJw8J3vcrGd+UNFhdHmV00xd3PQCgWpwerEwPNR8o=;
 b=jhaXaSTvVEsQXRaaIyM5a7zABK1c1/MkVtHqQKtXSphKZgHBilYgvorsC44rBi4rbI
 fhKXUeZiRMXFTmdrI26a19NXZMRbJQnCHT7jWLjzmZaVzlLDg+XF3jgWQsNEb311qBSe
 cLCYEnmhrzD6ABxeU6aE3KT1fhheedK/JZwXJyMpoeWvKdR1y5+B8l7CqNJ1IS4Jrr+e
 k26aMUwxsptVfKD0Adjbfc1q5ZWoROKfibh+34YQmUhEdnmeSHhZH50ECH32l7/x2dZU
 tS/AzVHZYrsSTNJL917gGD7QSaTguH6KmxE58WjmlkSB52ga80nZX4wIUy9gFp4pcKdB
 h4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497267; x=1772102067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nvkJw8J3vcrGd+UNFhdHmV00xd3PQCgWpwerEwPNR8o=;
 b=UfR0BVYpmAuOvqbk9TW4mS1WTHCzJy0T2ovFOWZrbifW1ULMHeeE3e8eXyWrrkhNZr
 /oZ6walmcyU0y+4cn5tA4aBdsBakB8t3qnVoFLvvI54/JpILOWKly+K0+JX6kjCW8d9P
 25OiW806fgiknTV7ITB+BRtbOhGvs4dn3QtQKrItlMluZHvo4x600EMTX5aqTCR8Wcvn
 9wLFmZYvupl4u2qqJsdmcE89FNKD21yH1STPZwfAyTTvkPHfhhdq6nEPdDmNqWr23mJ1
 9nhqLoRBysllK7VNBAhY7LPVyr+EneCby1hbnRf4OeAG7eQMp6MWOLLDID1zp0i2+Kxy
 F2RA==
X-Gm-Message-State: AOJu0YxiiG5CRgORH8Pt+o5YFGXMQdtZu0UCSPcIjOH+jLdYiONBxX6Z
 eRCv9d+h4N9WSxxh0u9KXAm06f97uVywkgweHs+MqRWRZVrCgRizoEhdO1PNK5ciNFIUKtkQ/r9
 lucAH
X-Gm-Gg: AZuq6aLbs5s4S7lM2Pu7HETGmdICso0kfYQHElnORL8wDbR9ZF/t8kybqJKHPd8NOCp
 eBand+LujL6AZvm8eM8HR+U4C7TmaShqd+pa1y4dfnTR6eK6Vl4ccdIZQaHk8lo5h3tXyf2AkiV
 VG8M08khAbuqAUvQJebPZPtM/VlBHxJ5T+Oc7BDJIGr7jOK4US8EEAcANYr3iIoywAE1CKjEDAm
 Du5VtiDl0s4FkEY2eBbmR3alRRYQFi/6pbO6YV5RKpUp4x6e6ZzxSIsVmZJpohWnG0XiR1gkR+2
 xBb07oHe0ZwjqOdel5uygh9JKB7AP7fZRViOZ7JSMfYuyF7NxSDHn632HXcTUs7f0/Ee3ufvDiS
 LOVoNJyiVhU8X6413GMuORgIwVZa0cdX0kbvcdmpqjDB6WVpu/rTqpzLSelfr02S79ymTSCZn8X
 eVY+lZ9+yq66BpvNgZVyhD5WGgzpa3pHiOvsxFAsTGmTrPb7upiYQiRbkZccLKREjNKyXyESLAI
 RJ1rxkPG/J8r0var6dXvnBD5gyE4cA=
X-Received: by 2002:a05:600c:3b01:b0:477:a36f:1a57 with SMTP id
 5b1f17b1804b1-48398a678e6mr80611615e9.3.1771497266828; 
 Thu, 19 Feb 2026 02:34:26 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/32] target/arm: extract helper-a64.h from helper.h
Date: Thu, 19 Feb 2026 10:33:55 +0000
Message-ID: <20260219103405.3793357-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260219040150.2098396-5-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-a64.h                            | 14 ++++++++++++++
 target/arm/helper.h                                |  1 -
 target/arm/tcg/{helper-a64.h => helper-a64-defs.h} |  0
 target/arm/tcg/helper-a64.c                        |  4 ++++
 target/arm/tcg/mte_helper.c                        |  1 +
 target/arm/tcg/pauth_helper.c                      |  1 +
 target/arm/tcg/sve_helper.c                        |  1 +
 target/arm/tcg/translate-a64.c                     |  1 +
 target/arm/tcg/vec_helper.c                        |  1 +
 9 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 target/arm/helper-a64.h
 rename target/arm/tcg/{helper-a64.h => helper-a64-defs.h} (100%)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
new file mode 100644
index 0000000000..cda7e039b7
--- /dev/null
+++ b/target/arm/helper-a64.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef HELPER_A64_H
+#define HELPER_A64_H
+
+#include "exec/helper-proto-common.h"
+#include "exec/helper-gen-common.h"
+
+#define HELPER_H "tcg/helper-a64-defs.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef HELPER_H
+
+#endif /* HELPER_A64_H */
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 44c7f3ed75..79f8de1e16 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -3,7 +3,6 @@
 #include "tcg/helper.h"
 
 #ifdef TARGET_AARCH64
-#include "tcg/helper-a64.h"
 #include "tcg/helper-sve.h"
 #include "tcg/helper-sme.h"
 #endif
diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64-defs.h
similarity index 100%
rename from target/arm/tcg/helper-a64.h
rename to target/arm/tcg/helper-a64-defs.h
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index e4d2c2e392..07ddfb895d 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "gdbstub/helpers.h"
 #include "exec/helper-proto.h"
+#include "helper-a64.h"
 #include "qemu/host-utils.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
@@ -43,6 +44,9 @@
 #endif
 #include "vec_internal.h"
 
+#define HELPER_H "tcg/helper-a64-defs.h"
+#include "exec/helper-info.c.inc"
+
 /* C2.4.7 Multiply and divide */
 /* special cases for 0 and LLONG_MIN are mandated by the standard */
 uint64_t HELPER(udiv64)(uint64_t num, uint64_t den)
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 08b8e7176a..01b7f099f4 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -31,6 +31,7 @@
 #endif
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
+#include "helper-a64.h"
 #include "exec/helper-proto.h"
 #include "exec/tlb-flags.h"
 #include "accel/tcg/cpu-ops.h"
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index c591c3052c..5a20117ae8 100644
--- a/target/arm/tcg/pauth_helper.c
+++ b/target/arm/tcg/pauth_helper.c
@@ -22,6 +22,7 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "helper-a64.h"
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "qemu/xxhash.h"
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index c442fcb540..0600eea47c 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -24,6 +24,7 @@
 #include "exec/helper-proto.h"
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
+#include "helper-a64.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "tcg/tcg.h"
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 7a8cd99e00..1a54337b6a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "exec/target_page.h"
+#include "helper-a64.h"
 #include "translate.h"
 #include "translate-a64.h"
 #include "qemu/log.h"
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 33a136b90a..7451a283ef 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
+#include "helper-a64.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "qemu/int128.h"
-- 
2.43.0


