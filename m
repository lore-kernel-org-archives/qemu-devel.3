Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143FFC43327
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2026 00:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wddNK-0006UG-Ga; Sat, 27 Jun 2026 20:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alhouseenyousef@gmail.com>)
 id 1wdcrg-0002hl-Kk
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 19:55:12 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alhouseenyousef@gmail.com>)
 id 1wdcrf-0007r9-2A
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 19:55:12 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-664c535f1a0so441446d50.1
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2026 16:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782604509; x=1783209309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L1oasJ1uwrqjIjP3B2dhR4LOo4j09mY2wVNm1F23els=;
 b=GOUuuK5o2ZttO8DYIOZzqJWvvD8jbxX4kfRba7NQ1uvGLRTc07jSaceah8lRT53ibN
 wn5uEpVB7JkezVc6kSsTPczSljdXRqeF8fV/6XRjYhK9egiGYa91h1Id11K2Wv2OQMZ+
 vpAkviK7IlFYgH4f4OO8vHX5QQD7uBnAhrC2OgQItaUa7P0hCDmefsCJce3IBumrOEeU
 joMN+PDk12IgWh+EK3ENiMKhlzngL1rC2/S0BUEvttiuF+AA4zGB3K1qocVFHGoz4373
 18M/IVKhCBGDskR4SYaFF8+DCIsSxSppK9CldSdJI5k9j3gW4tbJvHTwwC7S0sKxC9yB
 bv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782604509; x=1783209309;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L1oasJ1uwrqjIjP3B2dhR4LOo4j09mY2wVNm1F23els=;
 b=GkgYGatcSycwIgAvizY4gwLE/M20OHPyaskPflMfvdEcpsXZ+GwRsotElmbZoUTBqf
 lXFIWpYcGNiNg7BKxIlcx/zjkFuLh2UXKdQXJE8e+3VBkwFnsPGfP/WVj/19qEiTJAcC
 A23pborOtrCxxWDjDqKqAKr/pehoy58yAEKYVdphP8lFfRi38zVuUKSkrePW+yn3uZhY
 21Kagt0lb25vqgp7gyfwfv0BRNr11wN2yp5gO7vPtqKJASB5zdTz5Ub5qGz/CLgEWCSm
 dmyyEiByqsVoUZJYvIJormnJHak6ewE8Hwvsg+XLXUkNdyOTmwptIDjVB9rbuQFCPkA7
 GqrQ==
X-Gm-Message-State: AOJu0Yzct0B4r0UZ0fCcBtGino2QsIs+fQEdtpUGgfd4O9ZORTSjmVNP
 jBquansjqlG6Bz3/Y5pUBfUkiaQayRS1Tfin/YRIZE/TgHrvSgRABKLT
X-Gm-Gg: AfdE7cnuNZ3bBtvPPgXnEblyQMmiawLjQodR7fVD7rnGcN8rBh7aeiDoF1DQnwl3fXE
 zTMIQnWICG0eZh4AED0knfmS6/pynyy9BgNp0iUjayyM/1FGhuGabaf7O0U+X/NOJEDwGmfMrUF
 eGfsTqq+EaCFAfjLT17fLbj7EutJQpvZoZZJHB8kNoJUf9lC7lGF4t1CQwWr85dPmFzx1lKkt17
 EcxArPVSVs5KYebq3c6Qq0zOKda2dK4W1NlWaxkdT1s8rhTTKKvxXm/Iu3eeJW5uENuseQiukm5
 Bmu4tCcB9D/wO0fvqQn42qfgZRgwyenbqZOtjTRPi9oV6wcM2926dHlbVlkvOjYvowJEPYMJSth
 7jbBnvLoqutnLAm9kXFUwlbjjSKO0JGT4plo5gNKVHyNViiVCYgDmN09cFKxQRLgLU3O+BPtLgc
 9euQ0pqoei9wNH1Pj3R4Xxkldutw==
X-Received: by 2002:a53:d985:0:b0:664:ae6a:e9a9 with SMTP id
 956f58d0204a3-664ae6b0ca0mr4092905d50.79.1782604509328; 
 Sat, 27 Jun 2026 16:55:09 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-664c061fda0sm938837d50.9.2026.06.27.16.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 16:55:08 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Gabriel Somlo <somlo@cmu.edu>
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] firmware: qemu_fw_cfg: reject overflowing file directories
Date: Sun, 28 Jun 2026 01:54:28 +0200
Message-ID: <20260627235428.16263-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=alhouseenyousef@gmail.com; helo=mail-yx1-xb12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 27 Jun 2026 20:27:49 -0400
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

The fw_cfg file count is supplied by the VMM. On 32-bit systems,
multiplying a large count by the directory entry size can wrap, resulting
in a short allocation and an out-of-bounds walk of the directory.

Reject counts whose directory size cannot be represented by size_t before
allocating or reading the directory.

Fixes: 75f3e8e47f38 ("firmware: introduce sysfs driver for QEMU's fw_cfg device")

Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/firmware/qemu_fw_cfg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 0c51a9df5..3d5eece35 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/overflow.h>
 #include <uapi/linux/qemu_fw_cfg.h>
 #include <linux/delay.h>
 #include <linux/crash_dump.h>
@@ -642,7 +643,8 @@ static int fw_cfg_register_dir_entries(void)
 		return ret;
 
 	count = be32_to_cpu(files_count);
-	dir_size = count * sizeof(struct fw_cfg_file);
+	if (check_mul_overflow((size_t)count, sizeof(*dir), &dir_size))
+		return -EOVERFLOW;
 
 	dir = kmalloc(dir_size, GFP_KERNEL);
 	if (!dir)
-- 
2.54.0


