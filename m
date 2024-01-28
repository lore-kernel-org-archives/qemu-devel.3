Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A3BC47DDB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx0H-0004jE-5z; Sat, 27 Jan 2024 23:42:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0G-0004it-4p
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:44 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0E-0004Is-JU
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:43 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2906dffd8ddso1350739a91.3
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706416961; x=1707021761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b//53eqNBjSFpOfVle7vTtty4ZHIEf38Wv0KnQlUNkk=;
 b=MmtVTpvtDxcbcobH5GUe3J/pBqYp66zXh69JcCoVzSq4aJKLnWxrNkwgaH0MYObcJl
 9rv8H9/v8+k6gGO6yjH+Gm7Dg/DA7ppJGyS2O1Fst0wY4H2NrVrXRAcedrTztO+dG/gm
 v+mX2YbAYgPRC9GMn0qJmezmJuswZx8Ao93VLormZWHF3js67tcmrcxxg6LWUa2jzKWY
 Ag55kz/0sABoq+Glap81JqWeqyVqX/yNP6V5Cr+0yPMocPWcQcvdpp7EAhcNQvJ4aMUI
 T/ylokk59oz6TxJbiFd8jlJR2Ux5KOfxubXWJUwduDZyVDwvq0KxeY/lJ+P/gAfddw19
 rDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706416961; x=1707021761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b//53eqNBjSFpOfVle7vTtty4ZHIEf38Wv0KnQlUNkk=;
 b=RP5uSACYuzjuUWGjQYeTwyhQxnVufiI0Tk/aJdzg+eDOPxvyz+sihwaGnAmwXyUsu0
 TOd6mQJcKFoPY3Ocx2USqRwk5kI8XNlgxqfvozcq3dijn5rklZ46A5p3sCpwNlE69DGx
 kPMxA1fo7AwrpqSPymGon8Hv6hbY0ugs5DKZsKQQUjC+5xaLL1+yv2PVBMNXSkYRa7t4
 JVfvrvMgU6s44HOxcFFRvUbc9FCoZXAnBQmwJR8O+yFVZgnT3FWNkMxLjGOuOyancu9y
 GTSexaeOxoACRzeCHlOnD3SaEngCUbJ/VCvFEeXtGKcDNcdlKRGA7N3HCy/7jqRHPYf0
 nHgA==
X-Gm-Message-State: AOJu0YxMHjnpZ2MQYiePWmUH9sNCu/Qk1S+St35RHT24QeHB2YEjUTq3
 5II8cjuJG0Bb/05VLFVlsGRfZlRvl2qL7L41DDl0DeQgq7hAEIgNBdWZtq/hVmh3GQaGT17lsRk
 oGUedDA==
X-Google-Smtp-Source: AGHT+IEDzNoVLsrSlyIQolz0PJtuRawBP2dV4OJISgIxJ8gJKLPsVQP10W7Y/PMYiRkjcjxVA18vbg==
X-Received: by 2002:a17:90b:1207:b0:28e:7a18:4e4a with SMTP id
 gl7-20020a17090b120700b0028e7a184e4amr1514464pjb.81.1706416961361; 
 Sat, 27 Jan 2024 20:42:41 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:42:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PATCH 09/33] include/exec: Move PAGE_* macros to common header
Date: Sun, 28 Jan 2024 14:41:49 +1000
Message-Id: <20240128044213.316480-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Anton Johansson <anjo@rev.ng>

These don't vary across targets and are used in soon-to-be common code
(cputlb.c).

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240119144024.14289-15-anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h    | 24 ------------------------
 include/exec/cpu-common.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 5340907cfd..edee87d3f4 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -171,34 +171,10 @@ extern const TargetPageBits target_page;
 
 #define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
 
-/* same as PROT_xxx */
-#define PAGE_READ      0x0001
-#define PAGE_WRITE     0x0002
-#define PAGE_EXEC      0x0004
-#define PAGE_BITS      (PAGE_READ | PAGE_WRITE | PAGE_EXEC)
-#define PAGE_VALID     0x0008
-/*
- * Original state of the write flag (used when tracking self-modifying code)
- */
-#define PAGE_WRITE_ORG 0x0010
-/*
- * Invalidate the TLB entry immediately, helpful for s390x
- * Low-Address-Protection. Used with PAGE_WRITE in tlb_set_page_with_attrs()
- */
-#define PAGE_WRITE_INV 0x0020
-/* For use with page_set_flags: page is being replaced; target_data cleared. */
-#define PAGE_RESET     0x0040
-/* For linux-user, indicates that the page is MAP_ANON. */
-#define PAGE_ANON      0x0080
-
 #if defined(CONFIG_BSD) && defined(CONFIG_USER_ONLY)
 /* FIXME: Code that sets/uses this is broken and needs to go away.  */
 #define PAGE_RESERVED  0x0100
 #endif
-/* Target-specific bits that will be used via page_get_flags().  */
-#define PAGE_TARGET_1  0x0200
-#define PAGE_TARGET_2  0x0400
-
 /*
  * For linux-user, indicates that the page is mapped with the same semantics
  * in both guest and host.
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 1a8fad9222..ba10351576 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -219,4 +219,34 @@ G_NORETURN void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc);
 G_NORETURN void cpu_loop_exit(CPUState *cpu);
 G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
 
+/* same as PROT_xxx */
+#define PAGE_READ      0x0001
+#define PAGE_WRITE     0x0002
+#define PAGE_EXEC      0x0004
+#define PAGE_BITS      (PAGE_READ | PAGE_WRITE | PAGE_EXEC)
+#define PAGE_VALID     0x0008
+/*
+ * Original state of the write flag (used when tracking self-modifying code)
+ */
+#define PAGE_WRITE_ORG 0x0010
+/*
+ * Invalidate the TLB entry immediately, helpful for s390x
+ * Low-Address-Protection. Used with PAGE_WRITE in tlb_set_page_with_attrs()
+ */
+#define PAGE_WRITE_INV 0x0020
+/* For use with page_set_flags: page is being replaced; target_data cleared. */
+#define PAGE_RESET     0x0040
+/* For linux-user, indicates that the page is MAP_ANON. */
+#define PAGE_ANON      0x0080
+
+/* Target-specific bits that will be used via page_get_flags().  */
+#define PAGE_TARGET_1  0x0200
+#define PAGE_TARGET_2  0x0400
+
+/*
+ * For linux-user, indicates that the page is mapped with the same semantics
+ * in both guest and host.
+ */
+#define PAGE_PASSTHROUGH 0x0800
+
 #endif /* CPU_COMMON_H */
-- 
2.34.1


