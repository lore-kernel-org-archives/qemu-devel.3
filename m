Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E4AC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcsd-0007XF-Eh; Fri, 07 Mar 2025 13:57:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsP-0007Rh-Vz
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:54 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsN-0007lO-0r
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:53 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22401f4d35aso43049595ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741373809; x=1741978609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vo9EUeboH3pwKtes0Z0Mb9EvndFByljrwhTfKec7eDo=;
 b=nhFj/IK3z40Y/5Zd3T6HBeldI4dHNxZ5zTLO8+JBHgoI5X3qWBSkL99mEu45kC5HzC
 jrfw8gB5peqz4IN5eiOm4hx781MsqSm93ejM1Y0vWwT9G4dYcBtVRLhzq4XqPlun6olR
 mRn2mGi947rd8DVsLcP0XvD6kwXFJ1VCSq7T0Ux/0ZE8AjfkqQehTw8fMr4Q/mEMYwhP
 VXA3+NhjbmE9q5OfG2CB3I1sCN5AORcqbqZJk+QCr9B5vuZ4TAIp3XmfMZVsxF0JsM7k
 ald6ePaF5ceL3c3YUU25T7Hl4zRZDiwk0C5134HV7mooGZffu8uynlNvx/KeGpRNz9pi
 cSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741373809; x=1741978609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vo9EUeboH3pwKtes0Z0Mb9EvndFByljrwhTfKec7eDo=;
 b=H0onRnCNrq/Uq8AqtjxGgyzCLpx1V6u7fE1DavMCmJ8Rze4/D6TXCDPqMpQHI70Fex
 bEZBDFbFqjY4CVycPiWhtwH5S3UL1CxdWxAWO2skxIEIpGLFEmx7LKfVJdwgV6WkHkwL
 BY++WPxRzMuASGUxA3YhM7hXZWYr8GRIX0zzFJ1jMpWdGroiCU8lD9Hszj4RTPnNSVGU
 HfSKvxD9g574GJbRw1M1YAYJPufGYXzhiVEtQZXfpfx6MDmIuz419UV/cEEvmaKjVgaz
 Z4DMDpENuqJzKY0JWj4K752cwPWaMpwb2rLaDG7J/KMNzti5dnaqNbxkSmwTWZ4x/Egc
 zWRg==
X-Gm-Message-State: AOJu0YwD/mKGvAsHvaikPJz4WHfNSi1Euc4YXw82vai0KgZXo9SiHMRt
 yQ/tAqpFmKzvRDX4ttr9a6vunjt9pBpDLx/GJH/OVsKDRU/lVWDWjJ2hBlCwc0ZbIsss4l1Prdc
 f
X-Gm-Gg: ASbGncszCLlS6va862daGWg3EZA+1CEhJcvq8Cl1WaOadRHFshzkR3MFCL3PLORUU0V
 jxI7Kxi/ACUKB96vFhkhLpRRxAtRhlNWcSGetEklU6pmOVT5Nhya7j20P4xVD5Z5lWbIaLRsuyZ
 ktD2G7cFsWzFePpRJ6ViDKbrwhZIYCRTDhGazD21x489/LAymNKXsx3vH9CtL2WOio/R5D6Q5hX
 dpusXBI3nqP26TGj6Rk+zIHF0OT/eQ06eNXnGStikR13T72BOHme5n6cbBYfgk+HFpkYA9br3mh
 eTxNqV/t9EFXw5NRSDlJeE91SgSMbM9fSUxBXV/8MV823OfV8zHepibXgwBVoWKz6oLTHUKNEdo
 I
X-Google-Smtp-Source: AGHT+IGz+IGl0p1/KoWRnfRhFVwHK1ZC5+p8HozPLiHkUyNvRY8VHdGXy1/jcUIrhBYmUUHULLtYLA==
X-Received: by 2002:a17:903:8c6:b0:223:47d9:1964 with SMTP id
 d9443c01a7336-22428ac953fmr78709045ad.34.1741373809531; 
 Fri, 07 Mar 2025 10:56:49 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693534f8sm3391917a91.17.2025.03.07.10.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 10:56:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 02/16] accel/tcg: Compile watchpoint.c once
Date: Fri,  7 Mar 2025 10:56:31 -0800
Message-ID: <20250307185645.970034-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307185645.970034-1-richard.henderson@linaro.org>
References: <20250307185645.970034-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Move tb_check_watchpoint declaration from tb-internal.h, which is
still target-specific, to internal-common.h, which isn't.
Otherwise, all that is required to build watchpoint.c once is
to include the new exec/cpu-interrupt.h instead of exec/exec-all.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-common.h | 2 ++
 accel/tcg/tb-internal.h     | 2 --
 accel/tcg/watchpoint.c      | 5 ++---
 accel/tcg/meson.build       | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 7ef620d963..9b6ab3a8cc 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -72,4 +72,6 @@ void tcg_exec_unrealizefn(CPUState *cpu);
 /* current cflags for hashing/comparison */
 uint32_t curr_cflags(CPUState *cpu);
 
+void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
+
 #endif
diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
index abd423fcf5..62a59a5307 100644
--- a/accel/tcg/tb-internal.h
+++ b/accel/tcg/tb-internal.h
@@ -75,6 +75,4 @@ void tb_invalidate_phys_range_fast(ram_addr_t ram_addr,
 
 bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc);
 
-void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
-
 #endif
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index 40112b2b2e..ba8c9859cf 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -19,11 +19,10 @@
 
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
-#include "qemu/error-report.h"
-#include "exec/exec-all.h"
+#include "exec/breakpoint.h"
+#include "exec/cpu-interrupt.h"
 #include "exec/page-protection.h"
 #include "exec/translation-block.h"
-#include "tb-internal.h"
 #include "system/tcg.h"
 #include "system/replay.h"
 #include "accel/tcg/cpu-ops.h"
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 69f4808ac4..979ce90eb0 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -20,7 +20,6 @@ specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
 
 specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'cputlb.c',
-  'watchpoint.c',
   'tcg-accel-ops.c',
   'tcg-accel-ops-mttcg.c',
   'tcg-accel-ops-icount.c',
@@ -30,4 +29,5 @@ specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
 system_ss.add(when: ['CONFIG_TCG'], if_true: files(
   'icount-common.c',
   'monitor.c',
+  'watchpoint.c',
 ))
-- 
2.43.0


