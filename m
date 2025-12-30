Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D697EE01F6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagxq-0006Nq-Gq; Tue, 30 Dec 2025 16:09:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagxo-0006Gg-Jk
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:09:08 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagxm-0002Iz-OC
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:09:08 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso43413235e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767128945; x=1767733745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XHuXv7foUWZRnur9mLOEsDXFW8v0pmgg4BIkmsWiURg=;
 b=X/pf2GwtjY7itAtbAd79I/eJMFQISCzdwRV/hLF51Gyrzu19pubJAVp9Kp2Ypc70lR
 LreqkrgqQN/v+1580GZuDjNejyhXyGDkJR3iHHeT1wVpZbFYvMks1EfooHNcy7BrVa9F
 wXGInBFRKG/DgYhVht5Qa3cbYbwU6fETDRlAxaEuETTZbXf0EhSlUenejLHNtMaJqAGD
 xn2sx3nYCiUGjEH4qbzzp5KK/wk7x5WmQWLKfzWNh0nnlHcDUCbQ7XXyaCTlDLYzW4uB
 eQofRc/TxdsmD1AXeScK+NgHvAnBECC/IXCZzRG5dhHsFMxHAlHJYh2//SzA24ABlw1q
 9nIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767128945; x=1767733745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XHuXv7foUWZRnur9mLOEsDXFW8v0pmgg4BIkmsWiURg=;
 b=H1tubCGhMLCbkD8HL7Wh9CfT88aEDqg0Wgn7TogjkLbXdhJSPt9bHm+iJo+0shZ5A+
 7pe91NR4bAKW8RIQhifYJxhZKhiYr/yni2iG7dDXi+ZTYDJLviBiphK7IMx+nFg4G6AP
 3A6zRAnOMvk6FkyUafw/5/jWXzroCm4xjboC5Hg59ijTBZYzPgY6YFiEe52eIrOIwdIO
 8cjsfLCvklFjDnhzNJSlWVBK8vPyWrjK0FJOcISOKcLxFr6y1iGhBEvMpqmitapd4zbL
 h0xAZAriHetLRJ+h6yWaphJEcKBFpRfpcKDEwiK17WFVOSuPGsB5m8ihHyjJrKEbzOiA
 97Qg==
X-Gm-Message-State: AOJu0YwSOoKrK4A3zGG7i6IavV366/976J3b5VKbwCANeSWlPTRVJc7f
 KCpp07fxOAgeOjkdlrevTnDWeHYxKqRPA3hUkAWA02o0KhYtIlIJzvBQcjTNU0tPzPdUgzSryco
 gXyoqras=
X-Gm-Gg: AY/fxX67XCYBFX/qi0JM5yR3HKvIuYnT0Bt4GrwNJnm/Mjg2demdz/0Ect8pPm78t17
 7XUmWW3ZenXBvhv1/+G4N6OTNMUnbcFO0D2AVN0yfSd2mTiyhkMKBynnDVRPwOb26/DmMQUed4z
 Y/q9xlRlD8A0Y8NgTi3QE7OhKlK8iSnfPYrNO29JDwSlk5hUjrMy5D4SLT5cOBMXTpd1CsNKS4J
 HonBZre1b0br1eXuF4eCsILrWRXlHc48uMJupkia65Vtdp22grEdtBN0uYooqClg+j8MqhLD6sG
 pzIdhT0C9qelCMtJIJJ/BKRg8bHltvZi/z3KMVhrU+IzjIXuqY/ihkXEuzSh44xVT9SEg1MMye7
 3y2TcYuaplG3nUi1zVS9mc/u4h+KTngiDDMVARDc1y612pxdJI1ngfEpL8LWV0/QJ9EvuttC6+L
 yKjvw5emp8sjwOTCXaCHMsbXchf5y6S3hK47lgeQ1Qfyb+7HVB09bjATEmisad
X-Google-Smtp-Source: AGHT+IEIEdG05Z5HqHp9iatBDlnQUT43sZdbKYBZG8FZVOMNBnI6GVT+SkgxvZfXqlxMwmEQY1t5Kw==
X-Received: by 2002:a05:600c:8116:b0:477:abea:9028 with SMTP id
 5b1f17b1804b1-47d1953bc47mr354696575e9.6.1767128944747; 
 Tue, 30 Dec 2025 13:09:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193d4e91sm594395325e9.13.2025.12.30.13.09.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:09:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/34] monitor/hmp: Fix coding style in hmp-cmds-target.c
Date: Tue, 30 Dec 2025 22:07:32 +0100
Message-ID: <20251230210757.13803-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

Previous to moving code contained in hmp-cmds-target.c,
fix the coding style. Otherwise the checkpatch.pl script
would report:

  ERROR: space required before the open parenthesis '('
  #134: FILE: monitor/hmp-cmds-target.c:152:
  +    switch(format) {

  ERROR: braces {} are necessary for all arms of this statement
  #154: FILE: monitor/hmp-cmds-target.c:172:
  +        if (l > line_size)
  [...]

  ERROR: space required before the open parenthesis '('
  #172: FILE: monitor/hmp-cmds-target.c:190:
  +            switch(wsize) {

  ERROR: space required before the open parenthesis '('
  #188: FILE: monitor/hmp-cmds-target.c:206:
  +            switch(format) {

  ERROR: Don't use '#' flag of printf format ('%#') in format strings, use '0x' prefix instead
  #190: FILE: monitor/hmp-cmds-target.c:208:
  +                monitor_printf(mon, "%#*" PRIo64, max_digits, v);

  WARNING: line over 80 characters
  #240: FILE: monitor/hmp-cmds-target.c:258:
  +        error_setg(errp, "No memory is mapped at address 0x%" HWADDR_PRIx, addr);

  WARNING: line over 80 characters
  #245: FILE: monitor/hmp-cmds-target.c:263:
  +        error_setg(errp, "Memory at address 0x%" HWADDR_PRIx " is not RAM", addr);

  ERROR: Don't use '#' flag of printf format ('%#') in format strings, use '0x' prefix instead
  #297: FILE: monitor/hmp-cmds-target.c:315:
  +        monitor_printf(mon, "gpa: %#" HWADDR_PRIx "\n",

  WARNING: line over 80 characters
  #329: FILE: monitor/hmp-cmds-target.c:347:
  +    ret = ((pinfo & 0x007fffffffffffffull) * pagesize) | (addr & (pagesize - 1));

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Message-Id: <20251229231546.50604-7-philmd@linaro.org>
---
 monitor/hmp-cmds-target.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index e782259c3e6..b4360f1f807 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -149,7 +149,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
     }
     max_digits = 0;
 
-    switch(format) {
+    switch (format) {
     case 'o':
         max_digits = DIV_ROUND_UP(wsize * 8, 3);
         break;
@@ -169,8 +169,9 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
     while (len > 0) {
         monitor_printf(mon, "%0*" PRIx64 ":", addr_width, addr);
         l = len;
-        if (l > line_size)
+        if (l > line_size) {
             l = line_size;
+        }
         if (is_physical) {
             AddressSpace *as = cs ? cs->as : &address_space_memory;
             MemTxResult r = address_space_read(as, addr,
@@ -187,7 +188,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
         }
         i = 0;
         while (i < l) {
-            switch(wsize) {
+            switch (wsize) {
             default:
             case 1:
                 v = ldub_p(buf + i);
@@ -203,9 +204,9 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
                 break;
             }
             monitor_printf(mon, " ");
-            switch(format) {
+            switch (format) {
             case 'o':
-                monitor_printf(mon, "%#*" PRIo64, max_digits, v);
+                monitor_printf(mon, "0%*" PRIo64, max_digits, v);
                 break;
             case 'x':
                 monitor_printf(mon, "0x%0*" PRIx64, max_digits, v);
@@ -255,12 +256,14 @@ void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp)
                                                  addr, size);
 
     if (!mrs.mr) {
-        error_setg(errp, "No memory is mapped at address 0x%" HWADDR_PRIx, addr);
+        error_setg(errp,
+                   "No memory is mapped at address 0x%" HWADDR_PRIx, addr);
         return NULL;
     }
 
     if (!memory_region_is_ram(mrs.mr) && !memory_region_is_romd(mrs.mr)) {
-        error_setg(errp, "Memory at address 0x%" HWADDR_PRIx " is not RAM", addr);
+        error_setg(errp,
+                   "Memory at address 0x%" HWADDR_PRIx " is not RAM", addr);
         memory_region_unref(mrs.mr);
         return NULL;
     }
@@ -312,7 +315,7 @@ void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
     if (gpa == -1) {
         monitor_printf(mon, "Unmapped\n");
     } else {
-        monitor_printf(mon, "gpa: %#" HWADDR_PRIx "\n",
+        monitor_printf(mon, "gpa: 0x%" HWADDR_PRIx "\n",
                        gpa + (addr & ~TARGET_PAGE_MASK));
     }
 }
@@ -344,7 +347,8 @@ static uint64_t vtop(void *ptr, Error **errp)
         error_setg(errp, "Page not present");
         goto out;
     }
-    ret = ((pinfo & 0x007fffffffffffffull) * pagesize) | (addr & (pagesize - 1));
+    ret = (pinfo & 0x007fffffffffffffull) * pagesize;
+    ret |= addr & (pagesize - 1);
 
 out:
     close(fd);
-- 
2.52.0


