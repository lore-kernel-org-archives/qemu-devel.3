Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B602C25B7A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QR4-0005BA-19; Mon, 13 May 2024 03:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPY-0002zD-0d
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:53 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPW-0001SQ-BH
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:51 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-420180b5897so2670395e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586467; x=1716191267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IqZwbuhaC0QOpVi9GDZS/pvS08Z41AQGVLa7yPdeApE=;
 b=W/yVSJkdd4pOZXCBB66qD+P3sy2ewlkiWvpbFuj42Vy9pymIPkvLVV01OvxL0tptWq
 2RH8uuMjmFZDp9UzhgMEcMGE/Yn+G2+fiOZnMlSivdNR26/z11c1DOvLVbMJhjreXfKM
 l/piu708vqnDsYrtGfWOkMsrSrQOCDApcAQlyRBEowsXnLhnBT5TyAfSEMmKbTeXj2b7
 ywe0/autNEq9c4YqfkNK2iIJo++PdvtpcY9mbt+wzuskS7PZhHcyh5xkD8vKxpPXSz6h
 T1vQKGa0GLmBrMeTkloKTWAIYmGygYZ1gaN9He01+I1T+02FhOqjmxJU9tDKBaBwwFN5
 +SDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586467; x=1716191267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IqZwbuhaC0QOpVi9GDZS/pvS08Z41AQGVLa7yPdeApE=;
 b=w5MHok/3Wkt/IgPp/nF/qJvLBvXTy6QNqO59RqdHyrzqFwQ97B4CpkC2jeEJKACh+h
 EV2CIZo2HlIaJDWtOPNrXWGE6sxrEnHnniWtQrVcSjymYLu10tYwY7H/g7K1QNy+pivK
 X9rlL5rjJA/La0VFrREBWlRiFFLtSbirVuP0h1ZyB7Vg9Psv1HzPEGA1ZBIHmziFRN0i
 aMRSEFce+qDyF5oqqr4e6oUgBE3k9j1TufUZS7XRoMqYqsOqtfPLchEH4Oo3MzrcufAj
 UffrxNBpJ7BxmGveeMsX+jvzDa9Py9b/P9zd+N+mZOX3aY6rTlg29LroSP4h1sbl9Fp2
 uVcg==
X-Gm-Message-State: AOJu0YyDYFDEaVPiN8bW3AilNKTRIL8GdOicEy0wezVFMIQHHkd7KDPq
 p5XHkZPu+8dbuYxBtIwtFspg19mwLOeKyhTvta3FaFaq6HNtbtCDQq/bOUnuKeHg2Z9ZHfhrZlN
 okwc=
X-Google-Smtp-Source: AGHT+IGXLwsD3p+T/YA61TZd8uvEMY2ULcZGeBqSKWKhyQWff7q2FM+L4k8QLt7CdlDjDeYt3tqZ3A==
X-Received: by 2002:a05:600c:434a:b0:41b:e55c:8e14 with SMTP id
 5b1f17b1804b1-41feaa38a5cmr67252675e9.14.1715586467647; 
 Mon, 13 May 2024 00:47:47 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 38/45] target/hppa: Implement PSW_X
Date: Mon, 13 May 2024 09:47:10 +0200
Message-Id: <20240513074717.130949-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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

Use PAGE_WRITE_INV to temporarily enable write permission
on for a given page, driven by PSW_X being set.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 46 +++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index d09877afd7..ca7bbe0a7c 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -296,30 +296,38 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
         goto egress;
     }
 
-    /* In reverse priority order, check for conditions which raise faults.
-       As we go, remove PROT bits that cover the condition we want to check.
-       In this way, the resulting PROT will force a re-check of the
-       architectural TLB entry for the next access.  */
-    if (unlikely(!ent->d)) {
-        if (type & PAGE_WRITE) {
-            /* The D bit is not set -- TLB Dirty Bit Fault.  */
-            ret = EXCP_TLB_DIRTY;
-        }
-        prot &= PAGE_READ | PAGE_EXEC;
-    }
-    if (unlikely(ent->b)) {
-        if (type & PAGE_WRITE) {
-            /* The B bit is set -- Data Memory Break Fault.  */
-            ret = EXCP_DMB;
-        }
-        prot &= PAGE_READ | PAGE_EXEC;
-    }
+    /*
+     * In priority order, check for conditions which raise faults.
+     * Remove PROT bits that cover the condition we want to check,
+     * so that the resulting PROT will force a re-check of the
+     * architectural TLB entry for the next access.
+     */
     if (unlikely(ent->t)) {
+        prot &= PAGE_EXEC;
         if (!(type & PAGE_EXEC)) {
             /* The T bit is set -- Page Reference Fault.  */
             ret = EXCP_PAGE_REF;
         }
-        prot &= PAGE_EXEC;
+    } else if (!ent->d) {
+        prot &= PAGE_READ | PAGE_EXEC;
+        if (type & PAGE_WRITE) {
+            /* The D bit is not set -- TLB Dirty Bit Fault.  */
+            ret = EXCP_TLB_DIRTY;
+        }
+    } else if (unlikely(ent->b)) {
+        prot &= PAGE_READ | PAGE_EXEC;
+        if (type & PAGE_WRITE) {
+            /*
+             * The B bit is set -- Data Memory Break Fault.
+             * Except when PSW_X is set, allow this single access to succeed.
+             * The write bit will be invalidated for subsequent accesses.
+             */
+            if (env->psw_xb & PSW_X) {
+                prot |= PAGE_WRITE_INV;
+            } else {
+                ret = EXCP_DMB;
+            }
+        }
     }
 
  egress:
-- 
2.34.1


