Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1780FC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kra-00053q-Qy; Wed, 23 Apr 2025 20:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqX-00015f-Mx
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:46 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqG-0004kE-M7
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:30 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736aaeed234so340041b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456007; x=1746060807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FNsYq0CLsO6lFu+oOVVyImJDoiCdKLFU/pHo4cHTdc0=;
 b=s/haL0KPcA6LsOe6TjsLJ9UKkGXCC6kTHIiGigpk5E8/1r3KfZJQawYmoxC0+edGvt
 o4B98tqGhauEGbRsAI75QXb02xcWiCasotJRGHbgxHFLOBMksJbKwTjEBluc0E5wfIWN
 AtjpYu7s+a6W12bVwbmJ84J9b02fXRBF2S7lCgRrRlxE9sxv1QHCaeBO/nCt8dKv3+2g
 tFwLtlzgtnqANrGcsM5/e2JhrKGJJwz1DmMigYXlGBP6D+6o4p8J1Ll7eWG7d7ryaA+N
 b1fdsFFp5TZigPE4SSGYTza3m4+PfyFYNUzEEBlvb3oJ2t65gaXRnTXbXSRP3o4irDpk
 yfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456007; x=1746060807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FNsYq0CLsO6lFu+oOVVyImJDoiCdKLFU/pHo4cHTdc0=;
 b=tYpuZEKlQvxluDSAlOCuL44XezL1b+2kP+bwWf9QL5rSjH1Xv2fDsO/ceS+KYZBcMP
 IEplPnkGQEnROgBagjq9V3FLvJpWuM5MgEGLVJoy2wJPdHmcRKtGEXAR3XD23V/TMCkg
 d7rNWstb3fsvuUNiVO8v/uZtUT3mRiQ3DaTUshyPkfhkP2zzDHg/0snC2jQfVZ0kwtFo
 0aw+0jsg4/7vCEvuKfc18ssHAi4dZeSpbySj+e2Hjcmiihotn5SQUYTDMf6t+udHLQj7
 SE/hg95G50D1rFeHvd4Y9IGMbXAFdh/14vgFXv4DfEX+06pD5HhwokMGJwtNVeI1a/mk
 yfTw==
X-Gm-Message-State: AOJu0YypgxYtSrF3AsbYoh3rLNrnxBAIoAfhS5htj4hKz9qmFo1YrNer
 t2F7KaQ2SGMiPKoUcidjl8jIWdvuAra96OBOFMq1PWPzQSsYW38ddHs9Vtq1TukB+y+vs4hLC5M
 S
X-Gm-Gg: ASbGnctuG1LaucNgtGCFrPWaFP74wlgsC2aRTGaBuxw79w/+QTQ5vigDIIut8O3MgTx
 EgGQ9ZJTDNfgTtOCpWEhD4xJjV29H8NAXRsSAcKGelM1jHLa52n07o9rjv6gwI0VhuXF85CIRZa
 hgVmVm3AIoiqT+9f1jBpkb+B8ddkSbpL5f+7Cvta8mNroYHNxRtMV49ppCzZg9ejEOdkCHbWH4h
 0xjLO19qpDU0dqre0PyJ9N2ZaYGu7dwT5ikaa/Aql7HKHZYrOkIf3Zn+NQh9EcG/xjMvZhbK9/g
 WoLd5jlpbCCNbMf+mI/4LpPxkIHLSgZTKqFxh8o1XAzaCY6y39uDQEnAtU8Ex3o6R6r4zFQsvHs
 =
X-Google-Smtp-Source: AGHT+IEHyh4qQxrDLotVuEQF73AGI4VwleaiF5djJV1gm6p1lT+40HoPzhxg07ej8G3fNK7iaxB5fQ==
X-Received: by 2002:a05:6a20:6f89:b0:1f5:86ce:126a with SMTP id
 adf61e73a8af0-20444fdbf4dmr926372637.40.1745456007089; 
 Wed, 23 Apr 2025 17:53:27 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 069/148] accel/tcg: Remove page_protect
Date: Wed, 23 Apr 2025 17:48:14 -0700
Message-ID: <20250424004934.598783-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Merge the user-only page_protect function with the user-only
implementation of tb_lock_page0.  This avoids pulling
page-protection.h into tb-internal.h.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-internal.h        | 11 +++--------
 include/user/page-protection.h |  1 -
 accel/tcg/user-exec.c          |  2 +-
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
index 68aa8d17f4..f7c2073e29 100644
--- a/accel/tcg/tb-internal.h
+++ b/accel/tcg/tb-internal.h
@@ -51,28 +51,23 @@
 
 #endif /* CONFIG_SOFTMMU */
 
+void tb_lock_page0(tb_page_addr_t);
+
 #ifdef CONFIG_USER_ONLY
-#include "user/page-protection.h"
 /*
  * For user-only, page_protect sets the page read-only.
  * Since most execution is already on read-only pages, and we'd need to
  * account for other TBs on the same page, defer undoing any page protection
  * until we receive the write fault.
  */
-static inline void tb_lock_page0(tb_page_addr_t p0)
-{
-    page_protect(p0);
-}
-
 static inline void tb_lock_page1(tb_page_addr_t p0, tb_page_addr_t p1)
 {
-    page_protect(p1);
+    tb_lock_page0(p1);
 }
 
 static inline void tb_unlock_page1(tb_page_addr_t p0, tb_page_addr_t p1) { }
 static inline void tb_unlock_pages(TranslationBlock *tb) { }
 #else
-void tb_lock_page0(tb_page_addr_t);
 void tb_lock_page1(tb_page_addr_t, tb_page_addr_t);
 void tb_unlock_page1(tb_page_addr_t, tb_page_addr_t);
 void tb_unlock_pages(TranslationBlock *);
diff --git a/include/user/page-protection.h b/include/user/page-protection.h
index 51daa18648..d5c8748d49 100644
--- a/include/user/page-protection.h
+++ b/include/user/page-protection.h
@@ -16,7 +16,6 @@
 #include "exec/target_long.h"
 #include "exec/translation-block.h"
 
-void page_protect(tb_page_addr_t page_addr);
 int page_unprotect(tb_page_addr_t address, uintptr_t pc);
 
 int page_get_flags(target_ulong address);
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 667c5e0354..72a9809c2d 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -657,7 +657,7 @@ target_ulong page_find_range_empty(target_ulong min, target_ulong max,
     }
 }
 
-void page_protect(tb_page_addr_t address)
+void tb_lock_page0(tb_page_addr_t address)
 {
     PageFlagsNode *p;
     target_ulong start, last;
-- 
2.43.0


