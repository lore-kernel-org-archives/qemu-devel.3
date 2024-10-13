Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BD8CF258E
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 22:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t06pw-0007Ff-B7; Sun, 13 Oct 2024 18:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pa-0007Aw-VQ
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:55 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pZ-0000vo-Ey
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:54 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e1c91fe739so2833622a91.2
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 15:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728857572; x=1729462372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8E2Z9ZSy95UZsg9Y2N2fIiaRxpU5aj12TR1V9ijHxjM=;
 b=E5L/rcVoQ2kC+KBc45Wp5IJ6j/8uSOfMR/nepeeRbYAbuVxyp66ZVy2CmqBRCmFRDJ
 fdUbDf8RQhgzRbAr3f30KgYd4SExq571QD1tiLgHIubD3Sk/8/4ZSgdKVDaISjTp3toB
 e2xuSMCUc6J/RvE4imHbS1BySroNbiwvhHjOxZvMdHMSv8e/wKOo4uajdolmULrOKUK2
 14mlTwWPZn86ZPdNhPAcEVYx2K/+lR5TGRFkJqrKfnmecfdF28F2uVhqHGgosByC+GQz
 4N0B+LoZv7KyQ2tRm3lXugNMh/AUNQuf4qL6uC2NqE5xpu4UrGka9eLiIXELlT6IZA7R
 shJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728857572; x=1729462372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8E2Z9ZSy95UZsg9Y2N2fIiaRxpU5aj12TR1V9ijHxjM=;
 b=ojRo/55gAZwskesAexCpQYvMC/DWMiOX0mFWfgMxmCZj6JMhNi1b8pYfrMHGHBnJ7y
 aXkeHcLf2ZUjPJGCO8wSwGZBgbp7WhAzguZVqLaNtWONJ50lYhK8KOQ+z6fa2HCKt6B/
 oXZXB9PtfEtAMi0NgoF9SVOG+veGz6K+9mWgx9bDhMCkxncm+j051JpNJD+3PECszIAc
 iAfvEewIPBmVdXOAvhB3DjodsfeFNip7tcjobhLvt/Q8GReipw52lp1cu7Z9CD0GjIEl
 nI8fkmKCblIJou7eqM9t9qmhMHLf6WDjVhXLvebt83IboHSYEo/9teK+pGsea3J+UbOj
 4NuA==
X-Gm-Message-State: AOJu0Yxbl/SVZePqbtP5jfvyZF7A66zZzntSDw6FvgtPNzEgHB7sCBKx
 gIJTW5nrgKUm2vkUcTERNtnNnX7v+xs9QpU9G+BSkWQwGed6Id+emlOztsb95Ufd5Rl5TF+/juB
 z
X-Google-Smtp-Source: AGHT+IEKxwEcWzmGsX/uP7Uq8DU08eQyVTTwfIk0h4URZUZzje7CFBA6yZkxG9wQrgFcugmom1ylKg==
X-Received: by 2002:a17:90a:8c9:b0:2e2:8f39:98d9 with SMTP id
 98e67ed59e1d1-2e2f0afd945mr11575250a91.18.1728857572135; 
 Sun, 13 Oct 2024 15:12:52 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5df1eebsm7271958a91.17.2024.10.13.15.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 15:12:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/27] target/hppa: Fix priority of T, D, and B page faults
Date: Sun, 13 Oct 2024 15:12:24 -0700
Message-ID: <20241013221235.1585193-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013221235.1585193-1-richard.henderson@linaro.org>
References: <20241013221235.1585193-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Drop the 'else' so that ret is overridden with the
highest priority fault.

Fixes: d8bc1381250 ("target/hppa: Implement PSW_X")
Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index f027c494e2..f71cedd7a9 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -288,7 +288,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
     }
 
     /*
-     * In priority order, check for conditions which raise faults.
+     * In reverse priority order, check for conditions which raise faults.
      * Remove PROT bits that cover the condition we want to check,
      * so that the resulting PROT will force a re-check of the
      * architectural TLB entry for the next access.
@@ -299,13 +299,15 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
             /* The T bit is set -- Page Reference Fault.  */
             ret = EXCP_PAGE_REF;
         }
-    } else if (!ent->d) {
+    }
+    if (unlikely(!ent->d)) {
         prot &= PAGE_READ | PAGE_EXEC;
         if (type & PAGE_WRITE) {
             /* The D bit is not set -- TLB Dirty Bit Fault.  */
             ret = EXCP_TLB_DIRTY;
         }
-    } else if (unlikely(ent->b)) {
+    }
+    if (unlikely(ent->b)) {
         prot &= PAGE_READ | PAGE_EXEC;
         if (type & PAGE_WRITE) {
             /*
-- 
2.43.0


