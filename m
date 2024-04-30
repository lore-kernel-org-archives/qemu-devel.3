Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E919BC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 12:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1mbK-0006GU-4Y; Tue, 30 Apr 2024 08:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mbH-0006GD-Nc
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:28:48 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mbG-0001mS-6S
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:28:47 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5727dc6d3edso2754482a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 05:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714480124; x=1715084924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ooSUJZwGp/lYPuvOeREBaY5/HVZbZHNsZQAPgbRFeRs=;
 b=YJ7v3Ij15YFcA+DiK+i84nn65P9Pp89OdONRCOmzlIt2U6XOV2n4rAjlEL1WaAE4G2
 XnDMs82p4KjUJpgsNLM5i3gs2U67LbiR0YBidiFdJDy6PgTXH6UR/VfvwFB8l758FkO2
 6bjYJF3sOA2c0TX4EtB+uo2V+7wYnUnWzIaS4IquhnoisYmWnJn3hWD0xZ1Jx17S3AU8
 OvuEw9ctVYHKbRbF7nsIzw1izAl/Wzk+6LLFHZQyoDASzficwhy8NTtlfpVW45oqjk9q
 rC4Yy9x/Plm9Y7/RSPalw3EnKHpLTJ8EAM1AHNOpUl92kiNOUt9faGTeTLF1vnwu2R6F
 CYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714480124; x=1715084924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ooSUJZwGp/lYPuvOeREBaY5/HVZbZHNsZQAPgbRFeRs=;
 b=cehYG6GrndI2sX1MkDYxhbr0nooaD2TS5y0q/L9BWepbDJxuGO19/RA1c8JN4WEi/L
 7ElSX/gEsQ9tGHnMOHm/+OIpYWxB55+NttuZJWm38JZbOjZkXEOg4DQ2KfE6BStTkcKJ
 R0hwp1ZtCVLhvbZw2kz6LDpbZtaWsUSvTSeE4bBr2dktI5QvuL581KWlDH8GNyorryln
 uQwL3CKBToSAT03PKb6rdr0OB8lb+6hJGqxUyGi2reJe8F0jPXyYLDydnLeuxCiiEq9a
 CDHs//+qaYcBLbiHVgVr4eONDV17mGN1Fo2bksCkA8xbt71PWbCNUSQxhvc7toRhOYf8
 JiIg==
X-Gm-Message-State: AOJu0YxOpVzhPSb6mBXZ9ciaoJLLORPTnRxDS1b3aKUwxqeQYyDALbmT
 ZZUtzmzZudQzm0GxvHXMs7WgJg/lKf8VvOFiibGFNMullV95bR8d0S44liXGBsH25przOevCKgt
 J
X-Google-Smtp-Source: AGHT+IE0NrAH5HwXpziXFPJDlw7JEGkOXLNE/qHTOAccOfuuI4GCbax6sC2Z9hCRPuLB7u4cAGiGOA==
X-Received: by 2002:a17:906:cec7:b0:a55:358f:783c with SMTP id
 si7-20020a170906cec700b00a55358f783cmr1726082ejb.24.1714480124581; 
 Tue, 30 Apr 2024 05:28:44 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 fw5-20020a170906c94500b00a5908cb01b4sm1803720ejb.17.2024.04.30.05.28.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 05:28:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 06/13] accel/tcg: Restrict IcountDecr / can_do_io / CPUTLB
 to TCG
Date: Tue, 30 Apr 2024 14:28:00 +0200
Message-ID: <20240430122808.72025-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240430122808.72025-1-philmd@linaro.org>
References: <20240430122808.72025-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

IcountDecr union, the can_do_io field, the CPUTLB* structures
and the "exec/tlb-common.h" header are only required for TCG.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240428221450.26460-16-philmd@linaro.org>
---
 include/exec/tlb-common.h | 4 ++++
 include/hw/core/cpu.h     | 9 ++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/exec/tlb-common.h b/include/exec/tlb-common.h
index dc5a5faa0b..a529c9f056 100644
--- a/include/exec/tlb-common.h
+++ b/include/exec/tlb-common.h
@@ -19,6 +19,10 @@
 #ifndef EXEC_TLB_COMMON_H
 #define EXEC_TLB_COMMON_H 1
 
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
 #define CPU_TLB_ENTRY_BITS 5
 
 /* Minimalized TLB entry for use by TCG fast path. */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 91e793e590..47b499f9f1 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -27,7 +27,6 @@
 #include "exec/vaddr.h"
 #include "exec/memattrs.h"
 #include "exec/mmu-access-type.h"
-#include "exec/tlb-common.h"
 #include "qapi/qapi-types-run-state.h"
 #include "qemu/bitmap.h"
 #include "qemu/rcu_queue.h"
@@ -256,6 +255,9 @@ typedef struct CPUTLBEntryFull {
     } extra;
 } CPUTLBEntryFull;
 
+#ifdef CONFIG_TCG
+#include "exec/tlb-common.h"
+
 /*
  * Data elements that are per MMU mode, minus the bits accessed by
  * the TCG fast path.
@@ -311,11 +313,9 @@ typedef struct CPUTLBCommon {
  * negative offsets are at the end of the struct.
  */
 typedef struct CPUTLB {
-#ifdef CONFIG_TCG
     CPUTLBCommon c;
     CPUTLBDesc d[NB_MMU_MODES];
     CPUTLBDescFast f[NB_MMU_MODES];
-#endif
 } CPUTLB;
 
 /*
@@ -337,6 +337,7 @@ typedef union IcountDecr {
 #endif
     } u16;
 } IcountDecr;
+#endif
 
 /**
  * CPUNegativeOffsetState: Elements of CPUState most efficiently accessed
@@ -345,6 +346,7 @@ typedef union IcountDecr {
  * @plugin_mem_cbs: active plugin memory callbacks
  */
 typedef struct CPUNegativeOffsetState {
+#ifdef CONFIG_TCG
     CPUTLB tlb;
 #ifdef CONFIG_PLUGIN
     /*
@@ -354,6 +356,7 @@ typedef struct CPUNegativeOffsetState {
 #endif
     IcountDecr icount_decr;
     bool can_do_io;
+#endif
 } CPUNegativeOffsetState;
 
 struct KVMState;
-- 
2.41.0


