Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D17F36BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 05:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB4s7-0004rk-MC; Fri, 10 Apr 2026 01:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wB4s6-0004r5-9y
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 01:57:38 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wB4s4-0007yJ-Qw
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 01:57:38 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c736261ee8dso686710a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 22:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775800655; x=1776405455; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s7rduMfdSHBv6Dm+D3nhuA8gVs+ENlu+IzPYpxEzuEI=;
 b=nVwzyxZlQvwRIVA+kgibucTsoo9px2EivKfE8/IcKP4EHjcswWyVjRzYvyzviU0X7d
 GqTDlhHVBokOCCPOiLwS644uYowWyCC+AkeeEPpI9Kh3+NX0IjNn05cgNJ08ldcrNnjP
 +fDuO5RYid/hqrfSD+Ey3C1uuQiEsYqOMWWXNUnVjGUtrpDCHFpHVyetbmpx9i5eeQri
 Y++d8zgwADlFrfy8vnx/tOVliJ2UsMDjnumi3ZBb/EqUQuWkZy3XKjeCGfFk+KJgqRq9
 uupNJgOaAIbnWYWx1/WcE5DE7Qu5K0aGFmv9Oim81Fn6c2xE/Pq+lFpVoaqIYQ2EfJU8
 8Kdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775800655; x=1776405455;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s7rduMfdSHBv6Dm+D3nhuA8gVs+ENlu+IzPYpxEzuEI=;
 b=Coc5BvSEYZB4waKr30OzAOw1ObAI+BEtY8TikOny0tVQCSDah5vDq5L2nV4FZ2SgML
 nH3BWdtVUGijmjw3Q1xwwcCuzq2b5kE7ly1DR0gKelj3Ps3xqi8nMNbiZS52pw6MKU/t
 NJyLOIKqzj5K41SbiLYA4e5KWS7vWm6D3ORoybeqEqZeSFKU4iVlwyxUhNnN311CTEiR
 5c8U+khOG8m3CCwXqMmfESEFuBgywUp436Xa0YCDN9P0tJzSv+vPX4sQoNtAuMotGCf6
 WfE1aENT4f/RhwLIRR9EymeLytNwfqiR4kODRdxNPBecBTGfLCZ9T3C8hcbtrKRpEToj
 C1vQ==
X-Gm-Message-State: AOJu0YxCu6lwC0Wf7xwOJz5VATMyiDNAEFDBh+HFkzMd2upoZkO4V/PO
 cgPNfJ+vwTkyWIRV6oGkV01i0tCMPkMwxdWITvdex50xPM0XcQcVfSZr
X-Gm-Gg: AeBDiesn2doynK3oZCWyhAFTIF5p75yGy9WeVnEKtZU4N2WLSmd1poJbmNe/BSzpb+7
 NKLmMA4EDP24+Ql2fVua1VKhMVTrvdGZh7aswvMk4UAI1fA1pBB63P2DX3qTVZDwqQ0MiCUHmB7
 MHVdfHtaytEheV/PBHGlDyzQAL5tETnZCt27daodvhn2UvjPoVuuxGzorYEKtkWcof5mH1SRfb2
 VCLPqCUAlRN+SUIMPK5F1hBxftwHL92u6OcPVmyMLDtbQ/KRRoNcO/VXuRU0b7/0dN/DgLURq+3
 Kxtk56giw4V7NvkOj4FIsh34PpB8h4DcTw9DSBqW7O62mgYA7ZIWZWBW1l9yHe9XwflWvI91utG
 w72wAODRV7SgxOmQMjdw4/nOpqUZ2oHgq3mUZkCGM+Yeqeb5d9LZLrPaytkI1YRtXLCAtwY/GfB
 FvPMHCxWgQcia8xCQ8Ik/j1iCT2dfRTQ==
X-Received: by 2002:a05:6a20:729b:b0:39c:4c23:a175 with SMTP id
 adf61e73a8af0-39fe40026a7mr2115115637.45.1775800655436; 
 Thu, 09 Apr 2026 22:57:35 -0700 (PDT)
Received: from [172.17.0.5] ([168.126.243.22])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c79218fc8d9sm1225965a12.12.2026.04.09.22.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 22:57:35 -0700 (PDT)
From: Jaemyung Lee <ldc.jml@gmail.com>
X-Google-Original-From: Jaemyung Lee <jaemyung.lee@samsung.com>
Date: Fri, 10 Apr 2026 14:57:16 +0900
Subject: [PATCH v5 3/5] hw/ufs: Add idle operation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-write_booster-v5-3-d44e1a0e191c@samsung.com>
References: <20260410-write_booster-v5-0-d44e1a0e191c@samsung.com>
In-Reply-To: <20260410-write_booster-v5-0-d44e1a0e191c@samsung.com>
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Jaemyung Lee <jaemyung.lee@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775800645; l=3493;
 i=jaemyung.lee@samsung.com; s=20260402; h=from:subject:message-id;
 bh=U1I7iR9KAXBx24tNL1R8hKu0trzHrSPwvB+dS7OpoRs=;
 b=W8jthARYna/2LYMfh5ouMy3fTqaKr56qNjQpI3MDkq1KG6PHSxqLrTCuE0fmO3kCcnNe1/YO4
 0oMMu/eNkKyAHrd4Zr8acIECW6J0C+VXIx1CHVPc9fI1kssWX7ULzxr
X-Developer-Key: i=jaemyung.lee@samsung.com; a=ed25519;
 pk=bZPd7A/kteUO62FfUM6IrI1LuBPe5QrcqfvsitM1ZjE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=ldc.jml@gmail.com; helo=mail-pg1-x52b.google.com
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
 hw/ufs/ufs.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs.h |  2 ++
 2 files changed, 73 insertions(+)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 69f82ab462d135fe6cda479891f9d8f26d19be9a..c504a0d7e3fb89eb5558cfd9c410cda9396bc3b4 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1801,6 +1801,71 @@ static void ufs_sendback_req(void *opaque)
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
+        if (!u->sq[qid]) {
+            continue;
+        }
+
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
+        if (!u->cq[qid]) {
+            continue;
+        }
+
+        if (!ufs_mcq_cq_empty(u, qid)) {
+            return false;
+        }
+
+        if (!QTAILQ_EMPTY(&u->cq[qid]->req_list)) {
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
@@ -1863,6 +1928,7 @@ static void ufs_init_hc(UfsHc *u)
     uint32_t cap = 0;
     uint32_t mcqconfig = 0;
     uint32_t mcqcap = 0;
+    int64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT);
 
     u->reg_size = pow2ceil(ufs_reg_size(u));
 
@@ -1959,6 +2025,9 @@ static void ufs_init_hc(UfsHc *u)
      * dynamically
      */
     u->temperature = UFS_TEMPERATURE;
+
+    timer_init_ms(&u->idle_timer, QEMU_CLOCK_VIRTUAL_RT, ufs_idle_timer_cb, u);
+    timer_mod(&u->idle_timer, now + UFS_IDLE_TIMER_TICK);
 }
 
 static void ufs_realize(PCIDevice *pci_dev, Error **errp)
@@ -1986,6 +2055,8 @@ static void ufs_exit(PCIDevice *pci_dev)
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


