Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B20C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlxr-0008OT-E0; Thu, 27 Jun 2024 06:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlxp-00085K-D5
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:49 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlxn-0002jk-AK
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:48 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7066a4a611dso3747936b3a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482566; x=1720087366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2ySpE5U7zE2XXo/BjdiRlPjhvKqenUQik4nMBEH7xQ=;
 b=fsFSMm6qA7MUGs3xDfmNOfyFSemvUHopQzGEwKrxx1YgiWaldbw0+6bH5QE2zQU9tA
 oDGw9BlgUk30n9p0hHa6mCknCLt6/C+efVtuWwBq57poOS9R2KL42ZDMZDANYsnTonsf
 YDJrMrna3JTKf+SP/VpEQ70EfcMkrYXs3Ra4k+jPjrgFQe4UUX8UAcrNLOC1cI1E73d0
 P9w7284+gMsA4+JYIiK/7+wLIN81buptlRYUG8wq9U2mAu7jRL4bccrEr1qRjZDcQEv+
 A3SEuB/tc8aRkUdKXRUTaUqUxg83IbMsrUVRCxmMKTvm6P2MNGU0usVxEMBCMpqJVvkV
 S1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482566; x=1720087366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R2ySpE5U7zE2XXo/BjdiRlPjhvKqenUQik4nMBEH7xQ=;
 b=sFyxnp6DYGvfib1kZhx35XyatX8g+4OoiudI9y1xFCyplMHx/L+49fFXkcYAUTfoBU
 C/JkrNKV/6p0f0mv3zYI2PL8YqFntb74DjMwAY7hMW65uwyeZi95Sn6pfPvd/uon+buQ
 ADoZuahBEPxk3ps43tZqHGLZLHADKkkFsD6islP0Uxk34YFh4x9lqtqUgrWYPHudmo6D
 isdPnPMDcLBNVvaa/euBCIzyWfR6tac9NNskW6OxH5Hn9+dKc15nTHLmSbTZM79DdIE+
 edKs8VYYSItl8vPjyVNGqNaHVpDsB0YlBA5rgs2LD+daFn+X3Z/wJ1U7yBGUpcwd4mmZ
 qqhQ==
X-Gm-Message-State: AOJu0Yy+aF44K8uhlFMRsea/PTN1qYTO9EItq3rbvgKT2Xxzq8SJAKRi
 whfoQLql7M/p0G1nT9erZtnaLICnVT0cUQ129aD7f7ZHOCYYMitwe6ChfwoA
X-Google-Smtp-Source: AGHT+IF3B6v82GALcn8dTX5L8YxkKs51s5fCTOPBZvyWyQjDweO1JF0/t5JzVKSFu+AjrNvUBy6I4g==
X-Received: by 2002:aa7:8a53:0:b0:706:29e6:2edf with SMTP id
 d2e1a72fcca58-70674548ef7mr11921175b3a.4.1719482565544; 
 Thu, 27 Jun 2024 03:02:45 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:02:45 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 31/32] target/riscv: Apply modularized matching conditions for
 watchpoint
Date: Thu, 27 Jun 2024 20:00:52 +1000
Message-ID: <20240627100053.150937-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Alvin Chang <alvinga@andestech.com>

We have implemented trigger_common_match(), which checks if the enabled
privilege levels of the trigger match CPU's current privilege level.
Remove the related code in riscv_cpu_debug_check_watchpoint() and invoke
trigger_common_match() to check the privilege levels of the type 2 and
type 6 triggers for the watchpoints.

This commit also changes the behavior of looping the triggers. In
previous implementation, if we have a type 2 trigger and
env->virt_enabled is true, we directly return false to stop the loop.
Now we keep looping all the triggers until we find a matched trigger.

Only load/store bits and loaded/stored address should be further checked
in riscv_cpu_debug_check_watchpoint().

Signed-off-by: Alvin Chang <alvinga@andestech.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240626132247.2761286-3-alvinga@andestech.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/debug.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 11125f333b..c290d6002e 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -901,13 +901,12 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
     for (i = 0; i < RV_MAX_TRIGGERS; i++) {
         trigger_type = get_trigger_type(env, i);
 
+        if (!trigger_common_match(env, trigger_type, i)) {
+            continue;
+        }
+
         switch (trigger_type) {
         case TRIGGER_TYPE_AD_MATCH:
-            /* type 2 trigger cannot be fired in VU/VS mode */
-            if (env->virt_enabled) {
-                return false;
-            }
-
             ctrl = env->tdata1[i];
             addr = env->tdata2[i];
             flags = 0;
@@ -920,10 +919,7 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
             }
 
             if ((wp->flags & flags) && (wp->vaddr == addr)) {
-                /* check U/S/M bit against current privilege level */
-                if ((ctrl >> 3) & BIT(env->priv)) {
-                    return true;
-                }
+                return true;
             }
             break;
         case TRIGGER_TYPE_AD_MATCH6:
@@ -939,17 +935,7 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
             }
 
             if ((wp->flags & flags) && (wp->vaddr == addr)) {
-                if (env->virt_enabled) {
-                    /* check VU/VS bit against current privilege level */
-                    if ((ctrl >> 23) & BIT(env->priv)) {
-                        return true;
-                    }
-                } else {
-                    /* check U/S/M bit against current privilege level */
-                    if ((ctrl >> 3) & BIT(env->priv)) {
-                        return true;
-                    }
-                }
+                return true;
             }
             break;
         default:
-- 
2.45.2


