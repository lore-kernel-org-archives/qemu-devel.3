Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE45C3DA42
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 08:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSuX3-0000B6-Jv; Sun, 14 Jul 2024 04:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sSuX2-0008WM-1J; Sun, 14 Jul 2024 04:24:32 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sSuX0-00038p-G1; Sun, 14 Jul 2024 04:24:31 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-75ee39f1ffbso2293048a12.2; 
 Sun, 14 Jul 2024 01:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720945467; x=1721550267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+mlhbqk20RxK7AHwT9MoUCKqjXkQEO9E9xZQNy9TdV0=;
 b=QNwRCmW3j+FboK30Lk8jBzhhU9I2Wd6INbMSCV+/vXv8MavBnpabcva2irF8+ujxTH
 KZ/dyD3jOHlP6FXBAsIr6aExpBvx7dE1WOt53wNsK6I4agCdhgjf+/SBGLcQijlB+nMA
 mlbBSJULCt+UuTYHptHJfCnL9vw0r2ofskonVc3EDLK4/1LXKq7d6rV2UcXw3/xnwmUE
 NEnQLknZUIzJZRaC8ehBuxqhpAy4cYn/4PTj33TSYZe4Z5Hrt0Eyae4vj3VOomS84vVs
 lC7PGm89jrwneCbBChaDFrnhPCTZwBy9uq49ChQCPMbKpkGjHWgNGByQ8waSXYIFEeFt
 0W8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720945467; x=1721550267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+mlhbqk20RxK7AHwT9MoUCKqjXkQEO9E9xZQNy9TdV0=;
 b=o/Ic/IekRqiplLjqhSsuzM7JtoC0t46mxljIK9ANJQpmTIAppXnuF2EK6dVnXKj9mh
 r7eZM7QUtIa4+/X+LewHviG3JLjn5274jVAru2yj7Y/nnRisJtDFvF++SkSWVhl5JPR6
 PTGmNBStEedaEWPnKFB1O1FloLXOQQMLdZF2YnjxfF16P1Ah6hEVj53lHdqWhtFYsp+B
 KHci4UvMFJGgv5xoqUvpKDuXoKrbYywKbklPZupLgGBUg/miKhkYChbwxKrXPjhxpFLr
 WGvY/6oGhGjYua/kSY1Zg6qnEMZYazTplc5ED//snI+Pna9tKAxewFp5EjBkSfA2e/Du
 fm+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV9l8hB9GN2wElvbh/sJc+4Le72R2M75P7WAq4NP3qwEtekvpfPcdi/kXsEJYu86BDqFmhFmCeso5rXwjXpOlm5gmOwuo=
X-Gm-Message-State: AOJu0YwUzRMCF3lyMXsvS6DEj3K0WFrqpfZTPXlwSDBmuwcQvGab1fOi
 IqeksmCZCSDFA+1IA80o7Ot/UsFh41FIzaKJgFzW9kGSZN7hd4QVO2qXTf9J
X-Google-Smtp-Source: AGHT+IGz9XY8b1S3QGf17OfftQZfXlPGZWFqkU1F/xq13lbLuQPUIWdqaqvD6GZ7ZIQw04qrxLjuUQ==
X-Received: by 2002:a05:6a21:78a9:b0:1bd:a048:7fcc with SMTP id
 adf61e73a8af0-1c2984c9eb4mr21040508637.46.1720945467129; 
 Sun, 14 Jul 2024 01:24:27 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca7886sm2301390b3a.170.2024.07.14.01.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jul 2024 01:24:26 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com, thuth@redhat.com,
 Zheyu Ma <zheyuma97@gmail.com>, Minwoo Im <minwoo.im@samsung.com>
Subject: [PULL v2 1/1] hw/ufs: Fix mcq register range check logic
Date: Sun, 14 Jul 2024 17:24:16 +0900
Message-Id: <50475f1511964775ff73c2b07239c3ff571f75cd.1720944812.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1720944812.git.jeuk20.kim@samsung.com>
References: <cover.1720944812.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

The function ufs_is_mcq_reg() and ufs_is_mcq_op_reg() only evaluated
the range of the mcq_reg and mcq_op_reg offset, which is defined as
a constant. Therefore, it was possible for them to return true
even though the ufs device is configured to not support the mcq.
This could cause ufs_mmio_read()/ufs_mmio_write() to result in
Null-pointer-dereference.
So fix it.

Resolves: #2428
Fixes: 5c079578d2e4 ("hw/ufs: Add support MCQ of UFSHCI 4.0")
Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
Reviewed-by: Minwoo Im <minwoo.im@samsung.com>
---
 hw/ufs/ufs.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 683fff5840..945a0ea127 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -57,14 +57,26 @@ static inline uint64_t ufs_reg_size(UfsHc *u)
 
 static inline bool ufs_is_mcq_reg(UfsHc *u, uint64_t addr, unsigned size)
 {
-    uint64_t mcq_reg_addr = ufs_mcq_reg_addr(u, 0);
+    uint64_t mcq_reg_addr;
+
+    if (!u->params.mcq) {
+        return false;
+    }
+
+    mcq_reg_addr = ufs_mcq_reg_addr(u, 0);
     return (addr >= mcq_reg_addr &&
             addr + size <= mcq_reg_addr + sizeof(u->mcq_reg));
 }
 
 static inline bool ufs_is_mcq_op_reg(UfsHc *u, uint64_t addr, unsigned size)
 {
-    uint64_t mcq_op_reg_addr = ufs_mcq_op_reg_addr(u, 0);
+    uint64_t mcq_op_reg_addr;
+
+    if (!u->params.mcq) {
+        return false;
+    }
+
+    mcq_op_reg_addr = ufs_mcq_op_reg_addr(u, 0);
     return (addr >= mcq_op_reg_addr &&
             addr + size <= mcq_op_reg_addr + sizeof(u->mcq_op_reg));
 }
-- 
2.34.1


