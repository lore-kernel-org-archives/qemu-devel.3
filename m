Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C420BCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKckG-0002AI-6r; Wed, 06 May 2026 09:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKckA-0001xb-FN
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:56:54 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKck7-00081y-Ef
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:56:54 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso62619445e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075802; x=1778680602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=phCWfde/k3PwpmEaLj8YUM0UGcdWotmvtNXZKUWY8Jo=;
 b=cVe+pDO138sx5ZPrWp+ySuQsc1ONsYl6B1R8+SLpP4SyIGRbRXRZdLZ903od6Sy0++
 /vRfGH6eUyKuI8yDxohDXM3HALtuNS35+R3LJt5EV+TJaFqDs2JImUiWUtyHvuE/UsJW
 MHX0oroeaTD4GL2aTflm5NsmUL+20Z9s3bnoyPFCyHHySwKeXRpvZ7kXcvit4TMFl4w5
 G6Xc6t2PUSnkPN2FB7/FrKGvmP2+zGJ3MBTgdkRHULqL7LQRuQRtJ26aRPDwhE9PvTAu
 A5pS7IJOFNR68jUW53hWdpkh6KKIFbkNnuwS7kXG/Y6Tg1PpnzYD1UVP+jqllvqtNiiI
 Jo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075802; x=1778680602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=phCWfde/k3PwpmEaLj8YUM0UGcdWotmvtNXZKUWY8Jo=;
 b=CiYhM4xtbTzp7XE1Yi+Rwyyr7rZX5OJrKThQ+eCLDzMCqeIAL/TYrAKyhIQxD3hPps
 AR5mnQ8KJVGZkVDRGC4MGBRgTP5nu1amJdir34G6HRiGiSwjvnzewWo+OIpJJIODQZ06
 J/WU+eMVYRoGzPpVIXXbN1RptyNPxJWdqiP8Y4kAxeqij9700iFegvMFoOI7o3rZfV16
 zzYptHvM90ZXoDy/qN8xkR8jrvcuVyGug6eDtZnkqM1k/nVhUG1yd6kP8c5ySlYjNkTy
 yq5rHwEPH8vM2sUxUGGI4clvo3dsVv1FNTVbrDYkGVLp39/3AHRI7jQwBpfigjETqhvg
 DANA==
X-Gm-Message-State: AOJu0Yzq/N4VuQ2RdUDaItm58YqDlpxg8vxNTWbgzR6OiZu+S1o2hA3w
 2+XKtF7pDl1dRqGNWxlQjXi1rxka2UHCxIFXQ3f4Vpk+gj02k/XL7zW9qM2wR+j9ZXYfTClZAkt
 zzVNu86k=
X-Gm-Gg: AeBDiev2Jji7owym02a3DdigKr67iHzBv1dyeSIGZMLXgaie9k4pH4fkacGsiIgocbk
 tsWfssncsO8FBieLxZNDGOCXhyJKskqgMFM2ov8nG8LWqZMNYNIMMJK273mkwLkbc/AteZfuiHw
 TjfH7QJS+px565bmnLehCWAQePXfZLIkyreQX0OZ3MiURxs0Q7uvqWPG60AaME0fC6Uk1xY6iJ5
 /rcBIBAN8dBk8zTVSlz8S4UYgBox9b3EZubJ/lnQ+88RhxmtUQFjhP1hJuub6S50jJKTW1sjOBV
 /u6NUM5I8xBml8UYpjgyRwOKJP4LkyVKNp/FEwSQ77K3EAksfQy2M9M57+mhxe4zcJlP8/6LCv7
 /2jPPXfuxlMyk3wf+heLcX1KuUNpKwweG1TRWy2gskfCewb8ST6x4eNppx8erE1JHWIXUIUturm
 ILsoper8PH9P+Eg9xvdBhPUzDJo+uUxgz/DPSbhfKnfhGJNQ87LKByIjuhyzEqlMEuZie2b+Y/R
 2rkQhAnvEo=
X-Received: by 2002:a05:600c:3b17:b0:488:ffb1:494c with SMTP id
 5b1f17b1804b1-48e51e1f0b2mr58972045e9.12.1778075801579; 
 Wed, 06 May 2026 06:56:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5382a327sm90417895e9.0.2026.05.06.06.56.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:56:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 010/110] target/riscv: Include missing 'exec/target_long.h'
 header
Date: Wed,  6 May 2026 15:53:42 +0200
Message-ID: <20260506135524.20617-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

The "exec/target_long.h" header is indirectly included, pulled
via "exec/cpu-defs.h". Include it explicitly otherwise we'd get
when removing the latter:

  ../target/riscv/cpu.h:605:1: error: unknown type name ‘target_ulong’
    605 | target_ulong riscv_cpu_get_geilen(CPURISCVState *env);
        | ^~~~~~~~~~~~
  ../target/riscv/pmp.h:73:1: error: unknown type name 'target_ulong'
     73 | target_ulong mseccfg_csr_read(CPURISCVState *env);
        | ^
  ../target/riscv/debug.h:139:1: error: unknown type name 'target_ulong'
    139 | target_ulong tselect_csr_read(CPURISCVState *env);
        | ^
  ../hw/misc/riscv_cmgcr.c:112:15: error: unknown type name 'target_ulong'
    112 | static inline target_ulong get_exception_base(RISCVGCRVPState *vps)
        |               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-14-philmd@linaro.org>
---
 target/riscv/cpu.h    | 1 +
 target/riscv/debug.h  | 1 +
 target/riscv/pmp.h    | 1 +
 hw/misc/riscv_cmgcr.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 81c41e34296..df55a77c403 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -27,6 +27,7 @@
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/gdbstub.h"
+#include "exec/target_long.h"
 #include "qemu/cpu-float.h"
 #include "qom/object.h"
 #include "qemu/int128.h"
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index f76b8f944a2..066e9c585f1 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -23,6 +23,7 @@
 #define RISCV_DEBUG_H
 
 #include "exec/breakpoint.h"
+#include "exec/target_long.h"
 
 #define RV_MAX_TRIGGERS         2
 
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index 467fb6b4b1c..17307ef88af 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -22,6 +22,7 @@
 #ifndef RISCV_PMP_H
 #define RISCV_PMP_H
 
+#include "exec/target_long.h"
 #include "cpu.h"
 
 typedef enum {
diff --git a/hw/misc/riscv_cmgcr.c b/hw/misc/riscv_cmgcr.c
index ab9b6c7d878..0390996f78b 100644
--- a/hw/misc/riscv_cmgcr.c
+++ b/hw/misc/riscv_cmgcr.c
@@ -19,6 +19,7 @@
 #include "migration/vmstate.h"
 #include "hw/misc/riscv_cmgcr.h"
 #include "hw/core/qdev-properties.h"
+#include "exec/target_page.h"
 
 #include "target/riscv/cpu.h"
 
-- 
2.53.0


