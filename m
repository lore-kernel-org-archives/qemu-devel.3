Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C610C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 16:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tslak-0003R9-CX; Thu, 13 Mar 2025 12:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslac-0003Lb-S6
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:39:23 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslaZ-0005dI-Uc
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:39:22 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2fee05829edso2501504a91.3
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741883958; x=1742488758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mZcjdDtX1Z7JVvsuWgguTldfqVr7ZBWkV3i9i17ooa8=;
 b=NxR8Vdq+doWrr81XlpFwDxvY2WpP6bS4yCcYlHqEe4nunhIWISQ5Gmtw5TwT92P1sS
 AtjECROxM/lR6nVu3GkKGVfqQzpemgdx7pP/t8ukIf+E8U1ylfdySNVlPst7+huWG2nh
 ZlkdLZvH7l6S+K8hq8bdr06fJF+vSCSXf74QWfDKGmabCiPz5H8T+LztYKm5E8H2egjj
 9MZCY6++zwVrGKY/LQe/wA7h831Po+VdNJk1S9xX55fePsq5g2Er/G37h7gxUffJTN6x
 Mgot+jy0mgelSEPU2s85jmdkL0t/h2lQfcJlU8tqxa1MAbqllnU2su9iMKL1NMuvoQOD
 a9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741883958; x=1742488758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mZcjdDtX1Z7JVvsuWgguTldfqVr7ZBWkV3i9i17ooa8=;
 b=cRHZsfQmPrwQ4BQkT/XON40BAyFR4SpWK7pJoIhn6jGoVkAFzU6SgXItj7NGbpBiM7
 WNNWlTrYck3fHDdprQ+Lc06XVgf9sWQG4u40WOFNmtXwy7VIf66DvI9/5KDkg5LtxjOr
 OYKPFacUOdtcbRUiZRdILYNplcKcH9j4NV+0G8rqVGEmBwqmVnI8w74XSJVycjyMDl+a
 cIha/2LP9wK7CzHusY9b1emSf0b2/ng3Elgo5LEZGQSx7N2vaW0bBif+dmdEYJGtoO4U
 TW8QFGFZPSWYJ7TCtGOeFY5iP5Hsq5bdr0/ExL6B0hK7fMYWzo5PrsciYmLn7dfyNjG1
 gTlg==
X-Gm-Message-State: AOJu0YxuDw8oMuIfQ/1O+mcGbm9xqB0RZvzXhNh8drhECkR442/OC6Qi
 bHl6ykSsLuVxPlJOXIDqxEyKuVrHUE6NJL8QNref8UtHM9tU4RiH4kKGc4ruJ8qDRusLwFgHTib
 FtnY=
X-Gm-Gg: ASbGncvrC7c+DOL38Lv1l83HxdL0ouK23aDBMDn9iiKHlhqIaSWBMRvMdkIWrShGqan
 76NlUEKhRvdUqYJ7cnlHF40rtA+gVCkLtYG+yZUvmOfdIoN9DrxT95iAFOooFrJUvJ25hvAyfyN
 gh6aaZnAXafKULpASvkMcfooYZ6uv8AKkmyOpp43uzt+N61xYJgRtud2YOQtDOvVijAthQZlgNL
 145aHk/mP9+AQkXDxdHPPWj5sn1m/94Gp6vLPsiOySsPvvJnC5LF8/AQ1IV2Wsqp3ajglzNtOTm
 KnAGIbcTIh9RetqxdYg3Xktvu4XW/jMwpG6+En4pvYw+
X-Google-Smtp-Source: AGHT+IG4zIqLxuyjovKp9g3TAXrCpctV1RL6f3536TGUBfN83HoHfbIXNZa1EoQ+qlG58AlBh7g+Ww==
X-Received: by 2002:a17:90b:5403:b0:2ee:fa0c:cebc with SMTP id
 98e67ed59e1d1-3014e861c18mr244498a91.20.1741883958391; 
 Thu, 13 Mar 2025 09:39:18 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30119265938sm4020084a91.39.2025.03.13.09.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 09:39:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, manos.pitsidianakis@linaro.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 06/17] codebase: prepare to remove cpu.h from
 exec/exec-all.h
Date: Thu, 13 Mar 2025 09:38:52 -0700
Message-Id: <20250313163903.1738581-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313163903.1738581-1-pierrick.bouvier@linaro.org>
References: <20250313163903.1738581-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/tcg/tcg-op.h           | 1 +
 target/ppc/helper_regs.h       | 2 ++
 hw/ppc/spapr_nested.c          | 1 +
 hw/sh4/sh7750.c                | 1 +
 page-vary-target.c             | 2 +-
 target/ppc/tcg-excp_helper.c   | 1 +
 target/riscv/bitmanip_helper.c | 2 +-
 7 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index a02850583bd..bc46b5570c4 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -9,6 +9,7 @@
 #define TCG_TCG_OP_H
 
 #include "tcg/tcg-op-common.h"
+#include "exec/target_long.h"
 
 #ifndef TARGET_LONG_BITS
 #error must include QEMU headers
diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
index 8196c1346dc..b928c2c452d 100644
--- a/target/ppc/helper_regs.h
+++ b/target/ppc/helper_regs.h
@@ -20,6 +20,8 @@
 #ifndef HELPER_REGS_H
 #define HELPER_REGS_H
 
+#include "target/ppc/cpu.h"
+
 void hreg_swap_gpr_tgpr(CPUPPCState *env);
 void hreg_compute_hflags(CPUPPCState *env);
 void hreg_update_pmu_hflags(CPUPPCState *env);
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 201f6292033..a79e398c132 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -2,6 +2,7 @@
 #include "qemu/cutils.h"
 #include "exec/exec-all.h"
 #include "exec/cputlb.h"
+#include "exec/target_long.h"
 #include "helper_regs.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/spapr.h"
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 6faf0e3ca8b..41306fb6008 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -29,6 +29,7 @@
 #include "hw/irq.h"
 #include "hw/sh4/sh.h"
 #include "system/system.h"
+#include "target/sh4/cpu.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "sh7750_regs.h"
diff --git a/page-vary-target.c b/page-vary-target.c
index 3f81144cda8..84ddeb7c26a 100644
--- a/page-vary-target.c
+++ b/page-vary-target.c
@@ -21,7 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "exec/page-vary.h"
-#include "exec/exec-all.h"
+#include "exec/target_page.h"
 
 bool set_preferred_target_page_bits(int bits)
 {
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 5a189dc3d70..c422648cfdd 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qemu/log.h"
+#include "target/ppc/cpu.h"
 #include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
diff --git a/target/riscv/bitmanip_helper.c b/target/riscv/bitmanip_helper.c
index b99c4a39a1f..e9c8d7f7780 100644
--- a/target/riscv/bitmanip_helper.c
+++ b/target/riscv/bitmanip_helper.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
-#include "exec/exec-all.h"
+#include "exec/target_long.h"
 #include "exec/helper-proto.h"
 #include "tcg/tcg.h"
 
-- 
2.39.5


