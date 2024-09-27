Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07A0CDD1AF
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 13:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suAz8-0005BJ-0A; Fri, 27 Sep 2024 09:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <trdthg47@gmail.com>)
 id 1su50L-0000OU-QD; Fri, 27 Sep 2024 03:03:05 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <trdthg47@gmail.com>)
 id 1su50J-0000oQ-Jb; Fri, 27 Sep 2024 03:03:04 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-710e910dd7dso1191699a34.2; 
 Fri, 27 Sep 2024 00:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727420581; x=1728025381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TvI9qw5LAWNZpYaJ0urC7M+CoFwaemgKRzivOqo/UZc=;
 b=fGENAApT+U9uADkTUQHazMOud22EOm4HR/JfEJoKc175jOTPkKN+Q53eqPfz9y4Gag
 GTQIBqaWeZWISZuXS28BubRGDCiY/Mrh6F2rUg3waqJR7IfrtzN7v1Z+iL7gSugO9zHX
 +MSxyq2yWG1BRZnqDr5eYYWU89uO1Ry/TsXp/UJ4ycEJbDkjMjD0ai6RhuZ9hKWJXTXQ
 MQKJiCwHOfRTa4NKeuykBLHQbUAIIj9KLVsnDSkrHwDdmaS0ES/e4vVHGv3bsqVicqvJ
 fe5eaZ4AMDAckRc3E2yljclUmdcHhsIkp2NAN+RMNgtnvzdRn3FOw8uHYUQ5FUx5lHX9
 BRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727420581; x=1728025381;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TvI9qw5LAWNZpYaJ0urC7M+CoFwaemgKRzivOqo/UZc=;
 b=LgoshaDjgc7HPTLoxIWNzC09vYhCmrjOwuuiBe6m73Tgc1XU+tWD05f+zpQNlYTZhv
 HgHxfX5e4oAHcrYRyL2d6owGUOyOHv9kAfdLnmENDWhgtoN7AhAfnKOYcll4G57QLfwI
 gJTbONSJ37z4mjLeO6GQDMPJQxfg13sc1SyqJvqfIWMt0U4hWEoI6C6zl3pddEQkx2qE
 JR9x/T6uf1W75XlfZnJKdus3c7REBcQLqteFnM5KJxHSIOwDXgDG1YXPx5n9HM2up1Sc
 5vaIvJWaju20D3/UiblQRVh41yeFVZhtmxbHLvEZuFy/Yr7nIe09lJDIHbFTpiY7yZB6
 S5tA==
X-Gm-Message-State: AOJu0YzjWZAhTceUTEB70yR30pc7ZvYEmS1AcEPFxFLxFboZbHkbmQTS
 LBrxyAZqRr8+6zz1lX+uDG5gh/2yM4Wskfq46J126Er8LcjBuQpdKfHBf4AbJbk=
X-Google-Smtp-Source: AGHT+IGdrX7rjZgBcko51d9fxy+GqiQi2O7d1vBrLdA3tBEqGISwObz+mT2hZ8/tj36n4jpNzuyu7Q==
X-Received: by 2002:a05:6358:784:b0:1b1:acd5:dd98 with SMTP id
 e5c5f4694b2df-1becbc4b5f1mr164103755d.7.1727420580871; 
 Fri, 27 Sep 2024 00:03:00 -0700 (PDT)
Received: from localhost.localdomain ([124.16.141.247])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e6db294ebdsm947830a12.19.2024.09.27.00.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2024 00:03:00 -0700 (PDT)
From: MingZhu Yan <trdthg47@gmail.com>
X-Google-Original-From: MingZhu Yan <yanmingzhu@iscas.ac.cn>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, trdthg47@gmail.com,
 MingZhu Yan <yanmingzhu@iscas.ac.cn>
Subject: [PATCH] hw/char/riscv_htif: Fix htif_mm_write that causes infinite
 loop in ACT.
Date: Fri, 27 Sep 2024 15:00:18 +0800
Message-Id: <20240927070018.10121-1-yanmingzhu@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=trdthg47@gmail.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 27 Sep 2024 09:25:49 -0400
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


