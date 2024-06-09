Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2871AC27C53
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 16:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGLqP-0002uD-HE; Sun, 09 Jun 2024 12:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sGLqO-0002tr-93
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 12:56:36 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sGLqM-0000vQ-1a
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 12:56:36 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3759a6423a6so3981145ab.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 09:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1717952192; x=1718556992;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tZ41jQOZIrAJPpWZ/KQuq7bouGxwk1FqF78+aO7+wdo=;
 b=pzkAiMdd4uCmXs5Qkm/Gy0NwnwJRyuduEycE8Xa9nv/PM38SehdoUhAHT+W9Iw7KxI
 vsUHCglDAXi1clXOln47pNrkP1jyzd888KKDrJD2XZN0jqvc5rAbn9A9P94pkrnXLQ02
 UnM7fiy2wGicOF693TaYANy7MH63ReC3T/laeSWwFOG8pm7FhpZ5BPY4zxgbYjJ3ka/f
 FKQyfmWDk13baSdIsR15C7wSfiEWmX6hzAy4QWnQkoQigMRKzP032otYVUWNjgY6Ccpj
 kPtbCXBmYfHSsZISSkwFQqsl257jukyuLgDHu+T1jzW2eOVptnFv4DLWAzHLt2/eo7PP
 IYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717952192; x=1718556992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tZ41jQOZIrAJPpWZ/KQuq7bouGxwk1FqF78+aO7+wdo=;
 b=LUN/CiA7Y29p/21HzLDfgvGyn0y0NnugSr584Kd/0E3KS+4l5rUrdCjB5qpvinjWvh
 VJWLQ0ojlO2dwcgP8d+fEfrX2QrdVvFuB9nwY1Y57UWoDHrpbk1XYu8DM57WWzgIWL0d
 d6a36BO1a+xsULWIe69TboeYtTFwLbZTTPX8oaThUlkTWNPdvwwDir3LnQVmjLzQfu0b
 vvw01v10dP9ADxMPCZ2xkb2Yv8deHPfkb7Xb0AdQ863FuVNfu02S8eEpbrBxmFbZhVJx
 HIiJk9xMIe8E9yBY2C7PkGpVx5JOv7l+EtRluI8UF9FUQc60kTH7FORhvqQwqrgDbCTy
 5PgA==
X-Gm-Message-State: AOJu0YyoK9uBVX0GAt6p+eRnxJ2WhNz5SDFlRAqRnKZ4emwUTUvJNOoj
 rYDaBh/jrcN0ZBXyvUXcYh2uOOsYloEkR1Audg4UnwpYffGFEtaqMaUzB1ijmodcdSfRvNE5agM
 RrX0=
X-Google-Smtp-Source: AGHT+IG37uBZW3PpabHaHDmI97lPKkCBR4534TOf/myvIf6uFhBU8ABkn8Ik0H1p8zgZL+wkEZYWjA==
X-Received: by 2002:a05:6e02:b27:b0:374:aa87:bcaa with SMTP id
 e9e14a558f8ab-37580314d52mr91161615ab.14.1717952191884; 
 Sun, 09 Jun 2024 09:56:31 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-374bc1c82d4sm18891715ab.80.2024.06.09.09.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 09:56:31 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>
Subject: [PULL 1/3] linux-user: Adjust comment to reflect the code.
Date: Sun,  9 Jun 2024 10:55:55 -0600
Message-ID: <20240609165557.52555-2-imp@bsdimp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240609165557.52555-1-imp@bsdimp.com>
References: <20240609165557.52555-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::136;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x136.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

If the user didn't specify reserved_va, there's an else for 64-bit host
32-bit (or fewer) target to reserve 32-bits of address space. Update the
comments to reflect this, and rejustify comment to 80 columns.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 94e4c47f052..94c99a1366f 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -814,10 +814,10 @@ int main(int argc, char **argv, char **envp)
     thread_cpu = cpu;
 
     /*
-     * Reserving too much vm space via mmap can run into problems
-     * with rlimits, oom due to page table creation, etc.  We will
-     * still try it, if directed by the command-line option, but
-     * not by default.
+     * Reserving too much vm space via mmap can run into problems with rlimits,
+     * oom due to page table creation, etc.  We will still try it, if directed
+     * by the command-line option, but not by default. Unless we're running a
+     * target address space of 32 or fewer bits on a host with 64 bits.
      */
     max_reserved_va = MAX_RESERVED_VA(cpu);
     if (reserved_va != 0) {
-- 
2.43.0


