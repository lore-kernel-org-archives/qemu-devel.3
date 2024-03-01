Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1499C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgBxu-0004wR-Uv; Fri, 01 Mar 2024 18:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxk-0004tQ-Bl
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:45 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxh-0004Et-M5
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:43 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e5eaf5bb3eso42129b3a.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334400; x=1709939200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2XrEdDvQ88jaxWmSDzzj/y67fD3f8yoeJckZhxITx78=;
 b=QTT4bmeE7P/lrVIF0X06t1YN6uyGHWaVG2wQfeTXzhpbapEFKuZVmMxBSMNvpYeXH4
 8tspBwkln3Mrw5p3New126xroPB2t70UjJa/2Ar054egJy5tH4jMMLnyWxneePPVCcQR
 4fWHDTIPno9QHuiEDfn1F7vGX5+lRETtuUgey3hXQaOJtRQOLCEMKnt3JE6uNhYwvAyu
 WYuivQNtelccOQj3OA0Q5nG1uWGn7VkfznDXj08SCk+M4bTklJAMApQiwNsD7l/m8AEd
 aU0Vdcj83T3TP1t1qFKwnzzm2B/+oV0WJqd8+x2/kuLlPGdEc9cg4e8cxzlSzqxs/Wko
 0yIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334400; x=1709939200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2XrEdDvQ88jaxWmSDzzj/y67fD3f8yoeJckZhxITx78=;
 b=HAYfkdjP6ZhrpqJ9Np9ccw32GDOruRuPZeDNNqO1jXtNUzlDjGrb3EEBd7ncTLYgEJ
 QXWS2iE6Uy9BskZCrvhvYg3j/7OItQ8PdiCwrtUG/a8YOfQU8hqQkwbhFhxV8l9a0Dzu
 EJc0hUoAVcvmsAACTQuBsWMEGr4zxkT2L5Y7JS8ooTvp3bUJlRO0UHn1PzcDzdkqycnP
 6dKFMQoJVHORzgsu50dtc9qdi7Azr4RdTxHBTDcIvCP4r2YA77qYEN/48UwnNgnx+y56
 QrOoeT0eF+OYtnYNOyAxXyLuebCo7jiAkT5zL5Q1pgQoqP4Gs9pVZWJHIHzVlbW/3idG
 mIAw==
X-Gm-Message-State: AOJu0Yz6qw1ZQDwg4ddkJzAjVzf49ZIjGp0Vgr02/7ffRZxPrPLGBPO3
 w/4B3PBuVodj8RL0h+oCoJot+a7/ch1KHhN/U8pBRLu1TbTOxjRa+w9OOy7rf+TUqlAvHpCGxV2
 P
X-Google-Smtp-Source: AGHT+IFQjmSfM9DNGg0kATjfmrodWq0GA+gKeflI8W3HYfCrP8obLmCLCrZCc1Q1Jj9ICGMQ+mZSig==
X-Received: by 2002:a17:902:d3c4:b0:1dc:5d9d:6eb3 with SMTP id
 w4-20020a170902d3c400b001dc5d9d6eb3mr2833150plb.21.1709334400245; 
 Fri, 01 Mar 2024 15:06:40 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.06.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:06:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/60] linux-user/elfload: Unprotect regions before core dump
Date: Fri,  1 Mar 2024 13:05:33 -1000
Message-Id: <20240301230619.661008-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

By unprotecting regions, we re-instate writability and
unify regions that have been split, which may reduce
the total number of regions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ae0abc4931..38bfc9ac67 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3963,6 +3963,8 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
 }
 
 #ifdef USE_ELF_CORE_DUMP
+#include "exec/translate-all.h"
+
 /*
  * Definitions to generate Intel SVR4-like core files.
  * These mostly have the same names as the SVR4 types with "target_elf_"
@@ -4280,6 +4282,23 @@ static int dump_write(int fd, const void *ptr, size_t size)
     return (0);
 }
 
+static int wmr_page_unprotect_regions(void *opaque, target_ulong start,
+                                      target_ulong end, unsigned long flags)
+{
+    if ((flags & (PAGE_WRITE | PAGE_WRITE_ORG)) == PAGE_WRITE_ORG) {
+        size_t step = MAX(TARGET_PAGE_SIZE, qemu_host_page_size);
+
+        while (1) {
+            page_unprotect(start, 0);
+            if (end - start <= step) {
+                break;
+            }
+            start += step;
+        }
+    }
+    return 0;
+}
+
 typedef struct {
     unsigned count;
     size_t size;
@@ -4401,6 +4420,9 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     cpu_list_lock();
     mmap_lock();
 
+    /* By unprotecting, we merge vmas that might be split. */
+    walk_memory_regions(NULL, wmr_page_unprotect_regions);
+
     /*
      * Walk through target process memory mappings and
      * set up structure containing this information.
-- 
2.34.1


