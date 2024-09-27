Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9593CDD1AE
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 13:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suAym-0003k8-73; Fri, 27 Sep 2024 09:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <trdthg47@gmail.com>)
 id 1su6Tu-0006zb-7L; Fri, 27 Sep 2024 04:37:42 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <trdthg47@gmail.com>)
 id 1su6Ts-0004Qx-8i; Fri, 27 Sep 2024 04:37:41 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20696938f86so16264505ad.3; 
 Fri, 27 Sep 2024 01:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727426258; x=1728031058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TvI9qw5LAWNZpYaJ0urC7M+CoFwaemgKRzivOqo/UZc=;
 b=RuySMNzSCULeDuzJhCUXpyfxMaVVp+7VRUr4U/dpiZj31M2V4LY+xW7RPdHRrwyH/I
 MIJOz0NztMYTQeyQGcfzyX+JDj4TIduCuoay77+D8+usjN3vaVUwG0uHuWh0C6UhT6CL
 yTrT3+w2nrbnu66HeSxLHPmQHbn8Psa2EIwPjLB9t9IKPanv5mG+g4uW8spvdehUCCe6
 zEIwpep1gLqiYJMjGyCT4CwHTbBL4Q3UijZoEFMg+Fomlua613CYph40VTjImpBMCoSm
 wn0KuMf5c/AT8xlk1nOAwunebgCdMwdM3bVNQbF+pBaEVWHQoqoCsgoBF5F2W3Z/XhuB
 o/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727426258; x=1728031058;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TvI9qw5LAWNZpYaJ0urC7M+CoFwaemgKRzivOqo/UZc=;
 b=fmpmdzIa9gg2sNiReG015B50dlj0r+idIMpcK1vJyNGWh7YhQjQPtE+1NOzUk+YMiJ
 cBmBfabNsdJ3CeG53htZ62SFod5GEdItu8e4SP8giO9php6MCxKEx20mQpre3ksgltO1
 tolNh6MzGCe/72/f4zTUkZtSZmDm3HrnzRMopsuMjLZ6tKwMPV4XkkJjgt8fUljOtclf
 0HExf0JI+94TyFbHWw+J8+weosIs9FHk4tEGJZRwbpR0Jj6TLz1cksXVW7NWCcVBeDfR
 uF2b/O6x2DZSNX2SUJ1izK9waRfRTHtnjiLioFajv8zv00KcGFHH2kLmu10R+xiS8+Q/
 06WQ==
X-Gm-Message-State: AOJu0Yw1w3mQKu9Q2eiQ53Gxk/tIYDbwxid8n8rG/Lo89hAvRfgzaQDO
 uTRK/N0LIc26mRG18aQDZ2w9Jz55DZc0PyhbvpsJ0XyEvIBqSGuyjmkYMYxrl3k=
X-Google-Smtp-Source: AGHT+IFnm5oR7IV1sQMDsP1Q2JcStDzUjrASaGP94WoNm7+BWZxTXXssx5s4zTwfaXD9y36dT1B3sA==
X-Received: by 2002:a17:902:c948:b0:20b:43f8:d764 with SMTP id
 d9443c01a7336-20b43f8d994mr13041225ad.8.1727426257557; 
 Fri, 27 Sep 2024 01:37:37 -0700 (PDT)
Received: from localhost.localdomain ([124.16.141.247])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e0d64asm9401245ad.178.2024.09.27.01.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2024 01:37:37 -0700 (PDT)
From: MingZhu Yan <trdthg47@gmail.com>
X-Google-Original-From: MingZhu Yan <yanmingzhu@iscas.ac.cn>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, trdthg47@gmail.com,
 MingZhu Yan <yanmingzhu@iscas.ac.cn>
Subject: [PATCH] hw/char/riscv_htif: Fix htif_mm_write that causes infinite
 loop in ACT.
Date: Fri, 27 Sep 2024 16:35:08 +0800
Message-Id: <20240927083508.59483-1-yanmingzhu@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=trdthg47@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 27 Sep 2024 09:25:50 -0400
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

Applications sometimes only write the lower 32-bit payload bytes, this is used
in ACT tests. As a workaround, this refers to the solution of sail-riscv.
if the payload is written a few times with the same value, we process the whole
htif command anyway.

Signed-off-by: MingZhu Yan <yanmingzhu@iscas.ac.cn>
---
 hw/char/riscv_htif.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index 9bef60def1..d74cce3bef 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -65,16 +65,8 @@ void htif_symbol_callback(const char *st_name, int st_info, uint64_t st_value,
 {
     if (strcmp("fromhost", st_name) == 0) {
         fromhost_addr = st_value;
-        if (st_size != 8) {
-            error_report("HTIF fromhost must be 8 bytes");
-            exit(1);
-        }
     } else if (strcmp("tohost", st_name) == 0) {
         tohost_addr = st_value;
-        if (st_size != 8) {
-            error_report("HTIF tohost must be 8 bytes");
-            exit(1);
-        }
     } else if (strcmp("begin_signature", st_name) == 0) {
         begin_sig_addr = st_value;
     } else if (strcmp("end_signature", st_name) == 0) {
@@ -290,18 +282,26 @@ static void htif_mm_write(void *opaque, hwaddr addr,
                           uint64_t value, unsigned size)
 {
     HTIFState *s = opaque;
-    if (addr == TOHOST_OFFSET1) {
-        if (s->tohost == 0x0) {
-            s->allow_tohost = 1;
-            s->tohost = value & 0xFFFFFFFF;
+    int htif_cmd_write = 0;
+    if (size == 8 && addr == TOHOST_OFFSET1) {
+        htif_cmd_write = 1;
+        s->tohost = value;
+        htif_handle_tohost_write(s, s->tohost);
+    } else if (size == 4 && addr == TOHOST_OFFSET1) {
+        if ((value) == (s->tohost & 0xFFFF)) {
+            s->allow_tohost = s->allow_tohost + 1;
         } else {
             s->allow_tohost = 0;
         }
-    } else if (addr == TOHOST_OFFSET2) {
-        if (s->allow_tohost) {
-            s->tohost |= value << 32;
-            htif_handle_tohost_write(s, s->tohost);
+        s->tohost = deposit64(s->tohost, 0, 32, value);
+    } else if (size == 4 && addr == TOHOST_OFFSET2) {
+        if ((value & 0xFF) == (s->tohost & 0xFF00)) {
+            s->allow_tohost = s->allow_tohost + 1;
+        } else {
+            s->allow_tohost = 1;
         }
+        htif_cmd_write = 1;
+        s->tohost = deposit64(s->tohost, 32, 32, value);
     } else if (addr == FROMHOST_OFFSET1) {
         s->fromhost_inprogress = 1;
         s->fromhost = value & 0xFFFFFFFF;
@@ -312,6 +312,9 @@ static void htif_mm_write(void *opaque, hwaddr addr,
         qemu_log("Invalid htif write: address %016" PRIx64 "\n",
             (uint64_t)addr);
     }
+    if ((s->tohost == 1 && htif_cmd_write) || s->allow_tohost > 2) {
+        htif_handle_tohost_write(s, s->tohost);
+    }
 }
 
 static const MemoryRegionOps htif_mm_ops = {
-- 
2.34.1


