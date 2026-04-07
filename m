Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7F7FF5137
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABWC-0007zS-Pg; Tue, 07 Apr 2026 14:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wABTn-0003wR-5p
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:51 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wA3g1-0003MI-RU
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 06:29:02 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82cf96ca071so2121702b3a.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 03:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775557736; x=1776162536; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LcrKp+d0GU/h7BA8cuQ7nXTTc4Guv25nnJ2LbdVZlfw=;
 b=hDalta1baMRrRIhAzO0WoNCPkF1qLguLNemkCbSH0jSIiLiC5UTBCYdkiu4qu99KiV
 mTa8N/SFBkMLvkK+p399q/N5JaOHZYFw/0QcYLdba+SPOGrvAS9I4nEpT8cDp12XUGAb
 k0tWYBSe8u6PCjP7as+D0HTpadJab0A4u6m5WrKyki0sOvflgQNg+B6JyRo8b/ULA50y
 boXP386WyIYw59JTUgPQz3/vLq5p13Moh/OhjMbrX2yQvTEaENIlyeIgg70xpOPxUZcn
 cRDzKSy6cZU9i4EzOv7tRGXJ0fkdUFgeuaV+Wdwhfuq2EPzeOPRAxIYRZEnTBbA6/OCK
 7MHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775557736; x=1776162536;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LcrKp+d0GU/h7BA8cuQ7nXTTc4Guv25nnJ2LbdVZlfw=;
 b=p/TDunIq4YvVecTtKcHrL9Rl7EY4ZeCoxxnvKlVGoG4G0G5ENo4kpqqze1HYYDmBwi
 eUAh2eGP14KvxJwdLt2Mm5m/N+wY4ABfaDDV/clBCSe2afKKPnnsFb3kusrkOBRqU2SP
 RiilXQhQXlDG6w9j6gRed1KIvB1S7YOtxy3X+aAOD/vfZJgqsXKqjfG43pRTXyoT9nf6
 wBeJQA2KFxcAkrQkL5kF/x3B0WS1j+giDJCtEiaS641KP70pxYdCam+m9QH50wbpuusF
 hk0qJo0pxSPobWYlibnf+asl6fI/hzfKW2gd+nm60gxsylO+jYKigIVYRvZMKt/RRxz7
 UlcA==
X-Gm-Message-State: AOJu0YyN0wjlfAV2rVjb1XvVejyTXYw2DfuSeutY4xXELoDGTjLDDfTR
 FU5TvhvtwZ5BpoJACNzUOfeknSaJuszlQMnOhuYzmSR0vpPVlfL27jB05/6TDwguV7cBMg==
X-Gm-Gg: AeBDietO7+8tZ1tj0sqcJJAS4Io+0bw6rl6wqL8F1etQ2foW3P+j+891Zk+gQakG63F
 JBh7UYWs8oK00uJNeqYAgWiLSy/09eMnZ+8XZaQ/mEAGAeTmNJ3PhTIoyPYfZUFFS4gKdVSvhl7
 Bq4PWntkh9kpCssH9Epe+PwElmqcxHg4Cexws8OF8tu0AUwfEFHh5uGnyxutAPivoqphKLlUnTk
 ENiHm6x+iJyfeIk5yLXvyv31qcZ4auJpv5ddrmo0eZplw9rv5bR/I81o1+N1AbEyrbJ8sdsEg9o
 2Ct4S2QV4vRrIQxMgIvfH+goaESrY2pStn8bGssaQaCxzCphiydvmhjwoY5D7NmmsYMT3hk5g62
 4sTA1SUSvKOps90AcDxCRk/0yjXMYFFsUyssYisUBTS6pM8TQbs5bc32i3ydezCBy9o9UG3ZtxF
 I504W8twUjOhh1TQiNbDM6DK7P3D0bmA==
X-Received: by 2002:a05:6a00:3d4f:b0:82c:dc9c:e765 with SMTP id
 d2e1a72fcca58-82d0d749427mr16861865b3a.0.1775557736135; 
 Tue, 07 Apr 2026 03:28:56 -0700 (PDT)
Received: from [172.17.0.5] ([168.126.243.22])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b2714dsm21217324b3a.1.2026.04.07.03.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 03:28:55 -0700 (PDT)
From: Jaemyung Lee <ldc.jml@gmail.com>
X-Google-Original-From: Jaemyung Lee <jaemyung.lee@samsung.com>
Date: Tue, 07 Apr 2026 19:23:41 +0900
Subject: [PATCH v2 3/5] hw/ufs: Add idle operation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-write_booster-v2-3-dd772bb30194@samsung.com>
References: <20260407-write_booster-v2-0-dd772bb30194@samsung.com>
In-Reply-To: <20260407-write_booster-v2-0-dd772bb30194@samsung.com>
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Jaemyung Lee <jaemyung.lee@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775557727; l=3259;
 i=jaemyung.lee@samsung.com; s=20260402; h=from:subject:message-id;
 bh=AwIyJDKLRw8lIAaybVo1E6Wec09c09QCMmjVB0P1SBU=;
 b=iJiCV/zuC0kD1q6dSLyp5oIElM1yrqO+9DgbTCP0Qmxzqcq6acM49YTtNiPFYJE7qYCw61dMk
 EoejGh0XjfeDVEwGJYZ3t9fu8jEhfnv7RPgIhghRG0HGK1JOZBSnlat
X-Developer-Key: i=jaemyung.lee@samsung.com; a=ed25519;
 pk=bZPd7A/kteUO62FfUM6IrI1LuBPe5QrcqfvsitM1ZjE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=ldc.jml@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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

When no I/O occurs, the UFS Device performs various internal operations.
To emulate this, adds a timer that periodically checks the current I/O
status of the device and call the ufs_process_idle() function when idle.

Signed-off-by: Jaemyung Lee <jaemyung.lee@samsung.com>
---
 hw/ufs/ufs.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs.h |  2 ++
 2 files changed, 61 insertions(+)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 69f82ab462d135fe6cda479891f9d8f26d19be9a..5102d9bbab640faded69c93be73cbe319db68646 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1801,6 +1801,59 @@ static void ufs_sendback_req(void *opaque)
     ufs_irq_check(u);
 }
 
+static void ufs_process_idle(UfsHc *u)
+{
+    /* Currently do nothing */
+    return;
+}
+
+static inline bool ufs_check_idle(UfsHc *u)
+{
+    return !u->reg.utrldbr;
+}
+
+static inline bool ufs_mcq_check_idle(UfsHc *u)
+{
+    if (!u->params.mcq) {
+        return true;
+    }
+
+    for (int qid = 0; qid < ARRAY_SIZE(u->sq); qid++) {
+        if (!ufs_mcq_sq_empty(u, qid)) {
+            return false;
+        }
+
+        /* internal ongoing MCQ request check */
+        UfsSq *sq = u->sq[qid];
+        for (int i = 0; i < sq->size; i++) {
+            if (sq->req[i].state != UFS_REQUEST_IDLE) {
+                return false;
+            }
+        }
+    }
+
+    for (int qid = 0; qid < ARRAY_SIZE(u->cq); qid++) {
+        if (!ufs_mcq_cq_empty(u, qid)) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+#define UFS_IDLE_TIMER_TICK 100 /* 0.1s */
+static void ufs_idle_timer_cb(void *opaque)
+{
+    UfsHc *u = opaque;
+    int64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT);
+
+    if (ufs_check_idle(u) && ufs_mcq_check_idle(u)) {
+        ufs_process_idle(u);
+    }
+
+    timer_mod(&u->idle_timer, now + UFS_IDLE_TIMER_TICK);
+}
+
 static bool ufs_check_constraints(UfsHc *u, Error **errp)
 {
     if (u->params.nutrs > UFS_MAX_NUTRS) {
@@ -1863,6 +1916,7 @@ static void ufs_init_hc(UfsHc *u)
     uint32_t cap = 0;
     uint32_t mcqconfig = 0;
     uint32_t mcqcap = 0;
+    int64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT);
 
     u->reg_size = pow2ceil(ufs_reg_size(u));
 
@@ -1959,6 +2013,9 @@ static void ufs_init_hc(UfsHc *u)
      * dynamically
      */
     u->temperature = UFS_TEMPERATURE;
+
+    timer_init_ms(&u->idle_timer, QEMU_CLOCK_VIRTUAL_RT, ufs_idle_timer_cb, u);
+    timer_mod(&u->idle_timer, now + UFS_IDLE_TIMER_TICK);
 }
 
 static void ufs_realize(PCIDevice *pci_dev, Error **errp)
@@ -1986,6 +2043,8 @@ static void ufs_exit(PCIDevice *pci_dev)
 {
     UfsHc *u = UFS(pci_dev);
 
+    timer_del(&u->idle_timer);
+
     qemu_free_irq(u->irq);
 
     qemu_bh_delete(u->doorbell_bh);
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 13d964c5ae5ec430a98b2ef71987cb9279e9a317..b5f040302129f4d02732ddd20ef82eb33c41922a 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -148,6 +148,8 @@ typedef struct UfsHc {
     UfsCq *cq[UFS_MAX_MCQ_QNUM];
 
     uint8_t temperature;
+
+    QEMUTimer idle_timer;
 } UfsHc;
 
 static inline uint32_t ufs_mcq_sq_tail(UfsHc *u, uint32_t qid)

-- 
2.48.1


