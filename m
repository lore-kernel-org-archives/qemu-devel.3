Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65AEC19F4F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 21:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Yb8-0007Nw-R1; Mon, 29 Apr 2024 17:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Yav-0007FJ-Gh
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:31:31 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Yan-0003KY-Ck
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:31:26 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41b794510cdso31088925e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 14:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714426279; x=1715031079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ooSUJZwGp/lYPuvOeREBaY5/HVZbZHNsZQAPgbRFeRs=;
 b=sue0DB3EgTzl20AX6XeR/+Phuwu0oeEcA3WSiG4XAyedjldl+4//gVrXYFzzpN6GZ+
 zPKNDjb0RhBxMFJ+o5UEg1W/RUJhM7t8z/K8lvQHcC2wlkUTYFsxCSjWfEBUEX8oEw1Y
 dD7Gzf2cGO3fd+Rpo5m2cZfXHmco1WevvBKvC97fQy+CoLbUAIT4xJkK/YxGq2JT++RI
 h86Ha52FMRLKaCJFl9sAdXlHEvSV+MKVD9EvZBUnCARg/eMuTG+QL1KMWhXXJKhp9sGf
 WP5mjkO95PegmNquM2xyM9VnVX7TNUQXMppT0F+/3QlSZcvfq9xVzvrkqgFL0ZL9YMJj
 wgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714426279; x=1715031079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ooSUJZwGp/lYPuvOeREBaY5/HVZbZHNsZQAPgbRFeRs=;
 b=G1nGsfHlkB1S5HYVIS17R6rzA42/oCB8TqsSAgNq3tpvWI+DL2NVTWOrXcXSByUudH
 UIMnD6zyXof6HRldrWGyic4Yhfq6u5Xig21k1+CUNsvN2D1Fjlhk5VsCd7D0xfl9Xc3B
 Bc1/awxPIkKb/fkxY7i/Wbq06PmFu3lSNvHdKL0pUUOhvM9JIk/suPtmwKJnVwMPsDAk
 pB4+1UVvt8IrPsMaa0ZTwnomYeF/Bfd/V3iy9/1yfTP6SV+3wVOC9r7V4XSQdfp+75jy
 pZ65Dcihi4fosmg1bQjvZsn/DLkyC2uMVFUmTK/eB36xbiYY8okzSbiFpGiOgxV02QrI
 0yeA==
X-Gm-Message-State: AOJu0YyIhhHeytOORS7akbya+/WT8MsdxOiuC7nC9Wv7VeNVCcj/ZSWU
 T6aAJzqdpxaqpbOmr7UhGY6KaRQvqCxUwO/EVrt3h4MdWXAUh7m/rDkf3hY8v+yvkmw0qZ0Pdyj
 uLtA=
X-Google-Smtp-Source: AGHT+IHTLhnzJgdX1MLF377SlYnpHOf53mblCsNumTl6t3g4OYyZUac6+HbghKjLZ+dOElKl32HaIA==
X-Received: by 2002:a05:600c:5025:b0:41a:a4d1:a896 with SMTP id
 n37-20020a05600c502500b0041aa4d1a896mr752165wmr.16.1714426279546; 
 Mon, 29 Apr 2024 14:31:19 -0700 (PDT)
Received: from m1x-phil.lan (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 p8-20020a5d48c8000000b0034af40b2efdsm22308632wrs.108.2024.04.29.14.31.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Apr 2024 14:31:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/13] accel/tcg: Restrict IcountDecr / can_do_io / CPUTLB
 to TCG
Date: Mon, 29 Apr 2024 23:30:42 +0200
Message-ID: <20240429213050.55177-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240429213050.55177-1-philmd@linaro.org>
References: <20240429213050.55177-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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


