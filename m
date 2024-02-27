Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748D9C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 18:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf2Vf-0006ao-CB; Tue, 27 Feb 2024 13:48:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2Vd-0006aD-D7
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:57 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2Vb-0001Vn-LS
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:57 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6e125818649so1982519a34.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 10:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709059733; x=1709664533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HEYpUbYOjLF3aHdvtZVlKWz9YeEEY+0zYSzPOHYy/W8=;
 b=pi2j9o6gBo6MEgj+eyxSTpPgS+q05HwNC4LeS8wRzuLC5k/H+/cgZi0rIbCTxih//j
 nQyadiGio4UqWp4/swxAknKLr+slvGuBm19KTmg3tQ3g9oUlChqRUnm1d1ooZXA2UF+J
 HuMgE22ctaV37rergmKORHigd5v+EJ1+IInhwrUA9kf44Qbez1TbD8QdtWuX32raIaYq
 TdVx/WMItIqUZgG+ArMDllWCHu46eWmvwL0Pkbj01FD6ZYizQfAuZpzFAbGu84QYAAgh
 oxiCeQ+UucDcKpj6bmww4W2jBSB/dUb0X1MB5DPeL8v1PEECsvy3DU977MGib1bUpoRP
 xTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709059733; x=1709664533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HEYpUbYOjLF3aHdvtZVlKWz9YeEEY+0zYSzPOHYy/W8=;
 b=h4zU6Vnk7NEqePkpp900xEGbkeoh8bwDF3nuI2qL47TNqEacb8432klxas4E8pK5F0
 2Qm7I9UP+qTtxIQGkDkst3MMXgw8vqcHcapBnQ32DskfnqYk3jKotcREyrfzl57dx3qC
 0oIElwagE9mbvsxsfxD6Pi8oNikTH5NcrZrWIJmRxdxS4CVjXtB5eg4dfqRbvEyr4a/a
 0Q8LxxwNgHcP5PWUQYwGzj1DyWvyNCjC1Ii/iNDg3l4z6/0UHpiOBEjeII2ydI5jXrYm
 UOcYGdW/TaMFgmrsmwGw1K+szBSODl2ne5IrgCWpadz7+/0b+RkuLPyGS6xpThPWg0DO
 mZZg==
X-Gm-Message-State: AOJu0YzdqDTI7WWuMVU/GyVl/NM9Rlh/wAZYi0lQXTAvE7R51fKzCNnA
 fX6roM1R68b0yO0l82JDlcpHYc/c1R6qVj7p3nxmYqvWxT9lNjtf0E6yhKuTi4ckgWnDE587CL9
 1
X-Google-Smtp-Source: AGHT+IEYIIrjmkyuNlJNxPK0XPCoXOM8odFDCkQtFVb3/tRbCR13FnFR1o0hZZXbScIjPusZF2fa/g==
X-Received: by 2002:a9d:6d8f:0:b0:6e2:e5a3:1732 with SMTP id
 x15-20020a9d6d8f000000b006e2e5a31732mr11607472otp.37.1709059732888; 
 Tue, 27 Feb 2024 10:48:52 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 h26-20020aa786da000000b006e555d40951sm533465pfo.188.2024.02.27.10.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 10:48:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 12/14] linux-user/elfload: Simplify vma_dump_size
Date: Tue, 27 Feb 2024 08:48:31 -1000
Message-Id: <20240227184833.193836-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227184833.193836-1-richard.henderson@linaro.org>
References: <20240227184833.193836-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

Use the flags that we've already saved in order to test
accessibility.  Use g2h_untagged and compare guest memory
directly instead of copy_from_user.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 491e754f72..47b5ce3005 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4166,37 +4166,23 @@ static int vma_get_mapping_count(const struct mm_struct *mm)
  */
 static abi_ulong vma_dump_size(const struct vm_area_struct *vma)
 {
-    /* if we cannot even read the first page, skip it */
-    if (!access_ok_untagged(VERIFY_READ, vma->vma_start, TARGET_PAGE_SIZE))
-        return (0);
+    /* The area must be readable. */
+    if (!(vma->vma_flags & PROT_READ)) {
+        return 0;
+    }
 
     /*
      * Usually we don't dump executable pages as they contain
      * non-writable code that debugger can read directly from
-     * target library etc.  However, thread stacks are marked
-     * also executable so we read in first page of given region
-     * and check whether it contains elf header.  If there is
-     * no elf header, we dump it.
+     * target library etc. If there is no elf header, we dump it.
      */
-    if (vma->vma_flags & PROT_EXEC) {
-        char page[TARGET_PAGE_SIZE];
-
-        if (copy_from_user(page, vma->vma_start, sizeof (page))) {
-            return 0;
-        }
-        if ((page[EI_MAG0] == ELFMAG0) &&
-            (page[EI_MAG1] == ELFMAG1) &&
-            (page[EI_MAG2] == ELFMAG2) &&
-            (page[EI_MAG3] == ELFMAG3)) {
-            /*
-             * Mappings are possibly from ELF binary.  Don't dump
-             * them.
-             */
-            return (0);
-        }
+    if (!(vma->vma_flags & PROT_WRITE) &&
+        (vma->vma_flags & PROT_EXEC) &&
+        memcmp(g2h_untagged(vma->vma_start), ELFMAG, SELFMAG) == 0) {
+        return 0;
     }
 
-    return (vma->vma_end - vma->vma_start);
+    return vma->vma_end - vma->vma_start;
 }
 
 static int vma_walker(void *priv, target_ulong start, target_ulong end,
-- 
2.34.1


