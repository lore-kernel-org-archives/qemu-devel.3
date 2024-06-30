Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39275C30659
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 03:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNlcQ-0003Ec-3L; Sat, 29 Jun 2024 23:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sNlcP-0003EN-Ah; Sat, 29 Jun 2024 23:52:49 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sNlcN-0004oy-A1; Sat, 29 Jun 2024 23:52:49 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f9aeb96b93so12531495ad.3; 
 Sat, 29 Jun 2024 20:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719719564; x=1720324364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tdNmNH5L6svAjEsp/JVaLmqNjVd3IkV2buQnJu9xxvQ=;
 b=m2dsvyme+ueV/nipemP5WLReJXWecFgceut0V9fH1x88nrmRnoakSAy6NgHG2m89qJ
 w56Ant+EiRRXWiIG2PFVBcrkdbU6sGNS4WOauvg6ebq42j4+cNxmSYHQmtezleXz6AIW
 s/tb8GRVJJmvf24lLiBNXp8PxR+k2eKCI4n9ZugNEPigi+zm4M5/V/3OVRf66wSjbuFw
 nWxbIudkTYopXXniGD4FEZw1fM0crPdnQ7Xz9xY0mtiRdVJWb5bL4eSTnBy7OpVMzWgU
 vjRGN1dUaxPchGBsspSRV/n+Vk0qQnrU3eXmQFi6zZypDcWYFa3607J/6bj5GcNaqdL1
 7HSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719719564; x=1720324364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tdNmNH5L6svAjEsp/JVaLmqNjVd3IkV2buQnJu9xxvQ=;
 b=SLIXr2uXJ0ISzgrcYs9Lzu5u1j1gcs3Ychww7dr6f5IHw4OhBotv0vFnHk5A7Ohzv3
 KHoxAKKOhUynGu2Tq3CxJxEI793haQQTTUTwjHZJErNmMQjOctuUEOB/Lv666KeD09V3
 sWssjp7W/GvIZ0OcdKHo+1DA88+bj2uwbCC55qHNtQ0cDPZtx1yhSFITKWqtz8sO7Cz6
 RCByYOH994WM1mIeRTX8dd9oC/QBKtfRZzkQ2TC+ItQ6JQe33pnu1GJ0GR5ARAxotrgs
 qv+RhG7NUJkgot45BMcJTWbnACu1dKzI5P+m8oCd3g/qeXgBbIrPa4IJs07wCotqHJQv
 z7mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8jv2PsH55lLz81TG0ntqM+5ORjp/Ak7u9guGQ9LngElfdeFVc7xlQMJ1NW7eWl0AHEL0W6lQx6mS5PHwUGab6DTKnXTg=
X-Gm-Message-State: AOJu0YwUso6x/Re9ZHC0D126BlCmnt+h/lwdPIeOBNd2Ny4N2CyGxqia
 Q5agEE5xsFSrJKOHAcDlaJmnGLDXlYQYRxIC2/86XBOrw9qMMWgdv4x5dCaa
X-Google-Smtp-Source: AGHT+IHbnMP6a4c+toCtnMMRpiJ5RUeA+WLmPbWstr78VMDBj6sofEMAjJR3TCnu1QJVLc2FaEpxvQ==
X-Received: by 2002:a17:902:d492:b0:1f7:c56:58a3 with SMTP id
 d9443c01a7336-1fadbc8ad4dmr21726395ad.26.1719719563995; 
 Sat, 29 Jun 2024 20:52:43 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1538f5bsm39213055ad.152.2024.06.29.20.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Jun 2024 20:52:43 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com,
 Minwoo Im <minwoo.im.dev@gmail.com>, Jeuk Kim <jeuk20.kim@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/1] hw/ufs: Fix potential bugs in MMIO read|write
Date: Sun, 30 Jun 2024 12:52:21 +0900
Message-Id: <e12b11f6f29272ee31ccde6b0db1a10139e87083.1719719120.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1719719120.git.jeuk20.kim@samsung.com>
References: <cover.1719719120.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x62a.google.com
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

From: Minwoo Im <minwoo.im.dev@gmail.com>

This patch fixes two points reported in coverity scan report [1].  Check
the MMIO access address with (addr + size), not just with the start offset
addr to make sure that the requested memory access not to exceed the
actual register region.  We also updated (uint8_t *) to (uint32_t *) to
represent we are accessing the MMIO registers by dword-sized only.

[1] https://lore.kernel.org/qemu-devel/CAFEAcA82L-WZnHMW0X+Dr40bHM-EVq2ZH4DG4pdqop4xxDP2Og@mail.gmail.com/

Cc: Jeuk Kim <jeuk20.kim@gmail.com>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20240623024555.78697-1-minwoo.im.dev@gmail.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 71a88d221c..683fff5840 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -55,17 +55,18 @@ static inline uint64_t ufs_reg_size(UfsHc *u)
     return ufs_mcq_op_reg_addr(u, 0) + sizeof(u->mcq_op_reg);
 }
 
-static inline bool ufs_is_mcq_reg(UfsHc *u, uint64_t addr)
+static inline bool ufs_is_mcq_reg(UfsHc *u, uint64_t addr, unsigned size)
 {
     uint64_t mcq_reg_addr = ufs_mcq_reg_addr(u, 0);
-    return addr >= mcq_reg_addr && addr < mcq_reg_addr + sizeof(u->mcq_reg);
+    return (addr >= mcq_reg_addr &&
+            addr + size <= mcq_reg_addr + sizeof(u->mcq_reg));
 }
 
-static inline bool ufs_is_mcq_op_reg(UfsHc *u, uint64_t addr)
+static inline bool ufs_is_mcq_op_reg(UfsHc *u, uint64_t addr, unsigned size)
 {
     uint64_t mcq_op_reg_addr = ufs_mcq_op_reg_addr(u, 0);
     return (addr >= mcq_op_reg_addr &&
-            addr < mcq_op_reg_addr + sizeof(u->mcq_op_reg));
+            addr + size <= mcq_op_reg_addr + sizeof(u->mcq_op_reg));
 }
 
 static MemTxResult ufs_addr_read(UfsHc *u, hwaddr addr, void *buf, int size)
@@ -774,25 +775,25 @@ static void ufs_write_mcq_op_reg(UfsHc *u, hwaddr offset, uint32_t data,
 static uint64_t ufs_mmio_read(void *opaque, hwaddr addr, unsigned size)
 {
     UfsHc *u = (UfsHc *)opaque;
-    uint8_t *ptr;
+    uint32_t *ptr;
     uint64_t value;
     uint64_t offset;
 
-    if (addr < sizeof(u->reg)) {
+    if (addr + size <= sizeof(u->reg)) {
         offset = addr;
-        ptr = (uint8_t *)&u->reg;
-    } else if (ufs_is_mcq_reg(u, addr)) {
+        ptr = (uint32_t *)&u->reg;
+    } else if (ufs_is_mcq_reg(u, addr, size)) {
         offset = addr - ufs_mcq_reg_addr(u, 0);
-        ptr = (uint8_t *)&u->mcq_reg;
-    } else if (ufs_is_mcq_op_reg(u, addr)) {
+        ptr = (uint32_t *)&u->mcq_reg;
+    } else if (ufs_is_mcq_op_reg(u, addr, size)) {
         offset = addr - ufs_mcq_op_reg_addr(u, 0);
-        ptr = (uint8_t *)&u->mcq_op_reg;
+        ptr = (uint32_t *)&u->mcq_op_reg;
     } else {
         trace_ufs_err_invalid_register_offset(addr);
         return 0;
     }
 
-    value = *(uint32_t *)(ptr + offset);
+    value = ptr[offset >> 2];
     trace_ufs_mmio_read(addr, value, size);
     return value;
 }
@@ -804,11 +805,11 @@ static void ufs_mmio_write(void *opaque, hwaddr addr, uint64_t data,
 
     trace_ufs_mmio_write(addr, data, size);
 
-    if (addr < sizeof(u->reg)) {
+    if (addr + size <= sizeof(u->reg)) {
         ufs_write_reg(u, addr, data, size);
-    } else if (ufs_is_mcq_reg(u, addr)) {
+    } else if (ufs_is_mcq_reg(u, addr, size)) {
         ufs_write_mcq_reg(u, addr - ufs_mcq_reg_addr(u, 0), data, size);
-    } else if (ufs_is_mcq_op_reg(u, addr)) {
+    } else if (ufs_is_mcq_op_reg(u, addr, size)) {
         ufs_write_mcq_op_reg(u, addr - ufs_mcq_op_reg_addr(u, 0), data, size);
     } else {
         trace_ufs_err_invalid_register_offset(addr);
-- 
2.34.1


