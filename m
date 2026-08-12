Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A12BC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuClE-0000uh-2i; Wed, 12 Aug 2026 13:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wuCl6-0000u0-U5
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 13:28:58 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wuCl3-0003OF-9u
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 13:28:56 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4954d29264cso6323805e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 10:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786555730; x=1787160530; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MV9jdcMeG4DQnkTjP/0nc0LX0bYx/zqTOT8Sa3tH2rU=;
 b=eZu8cjLZRKdx5+krKAEIKbWJCn7TdWS4eisY2kt0PceXa9Q8ZTovio7C0jZU6h+LR5
 y/svntPm4bC6SiZrjEb5QvlyWebI/WfofsZZAfftUH66iYxfBLz4BNz7+Csqc67X5knd
 c9izodGs3iei2GAthntBsW8cXEliEHggPvqEFJTX9M6sRA1tg0KeQ0oicxr79DeEsjyq
 j90DR7OgictOlgD1PGWm6e72V6HoiRP0xvBKhDKESwuLNs1SeTJmML6ImMX2J1yqPz3n
 VGYdRtkkuTQA5mclT7uc53vr+tLrNScdyxbFFxUbe4jFXx5XI2PcA1jCQpUnLptO2ugH
 /zxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786555730; x=1787160530;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MV9jdcMeG4DQnkTjP/0nc0LX0bYx/zqTOT8Sa3tH2rU=;
 b=K8lrogO5FVOLZG1g84BkhdbIZsGjJeJNHrdEZbc46Zz13l+/unfqqL9Fzbzdq3BNnx
 XQmDGg7k0AsvVVndrKEgApsPdBKHdvucH4aZAPyXPx8Riy4HT4A9Bxmm+KKVU9dTL+n5
 ApOCxd5w5Kfaq3qPFJ2bVC6CqTbhDte6wS3eXvVakH13vN09lXj/JCo4TGpT8jO48zz1
 9xFZAzr7faQ/oFVsmjzq7ByB9SeK1draHYhz5JZEd0nODPq32LJXFMVwqvW8+J52pNAg
 1UHB99kZHCGmLtgpGMHEOg0d1hGtmuiBPW0fuy9/G+tkQO6CIUQYnzqCUHUO4cvC1Nhw
 Qm+Q==
X-Gm-Message-State: AOJu0YzPI7r7KffSfvE0Po7EJsHpZHtSRJk9lznyQcNDJkw2Y40QyySQ
 mu/ckFUfAshI/qjPVNkPMDOIs1370ez1y/4w1d6rIwx4lpu4rYgtR8p/4v/1iWudJwI=
X-Gm-Gg: AR+sD13XPkjuy8oVLR2tD/fkmyBsl5BhJIrMVbC8R71q2OPh4kd21o+wSBqNO9NNtwX
 T+ZGALBQFpK8JjZY1NpMqDzaYyimMOZ8eoHCjlJ6CLa6KhZ9CX3OuROSABHykKqmfJwTAydYcnv
 SGMKx8RTH7+bNfzJXJyOqOeXiNPmKdgtsYDGwqKr5BSmsn9A15IHdm41URhEgZyVmx903Ct5vjY
 H3aK94iBsLAb9URYoab7jeyS3SqyHjTYxt7ZSU2Bsr9WTcC50yeBrlseycouZHBBtafA6Pd8dzd
 aaSCpspPnXAjGNkP6wBXVz7EM3Nx9foCTknk2IO2vUBRQ2WJB35XmwhXMIYjD0lj+Bh2UFTQpcH
 /FnBqnuW+TUb0MOlimohYoBzC8q1xsj4trSL+mssTJlOWnIygVAlwkDc3JPwKLrJFU8wxVR/RKJ
 CCN8ROrwMFhyZz1bG/TnVNsSz1NLPlzJdqwUAtlWXCSA0myWFb+jGO0Sio/eCAu4XNvZTLbm8=
X-Received: by 2002:a05:600c:1d0c:b0:495:7a5a:d96c with SMTP id
 5b1f17b1804b1-4997c163b3fmr84958145e9.18.1786555730077; 
 Wed, 12 Aug 2026 10:28:50 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm47516365e9.3.2026.08.12.10.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 10:28:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3237E5F886;
 Wed, 12 Aug 2026 18:28:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org (open list:Floppy)
Subject: [RFC PATCH] hw/block: validate the fdc sector position fits within
 bounds
Date: Wed, 12 Aug 2026 18:28:42 +0100
Message-ID: <20260812172842.60524-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Previously the guest controlled the value of last_sec and wasn't
particularly careful to check it didn't exceed the media size. We
can't re-use drv->last_sec as that changes as we do operations so we
set media_last_sect when the geometry is probed.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3800
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/block/fdc-internal.h |  1 +
 hw/block/fdc.c          | 28 ++++++++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/hw/block/fdc-internal.h b/hw/block/fdc-internal.h
index e219623dc7a..81775fe55aa 100644
--- a/hw/block/fdc-internal.h
+++ b/hw/block/fdc-internal.h
@@ -83,6 +83,7 @@ typedef struct FDrive {
     uint8_t max_track;        /* Nb of tracks           */
     uint16_t bps;             /* Bytes per sector       */
     uint8_t ro;               /* Is read-only           */
+    uint8_t media_last_sect;  /* last sector of current track according to media */
     uint8_t media_changed;    /* Is media changed       */
     uint8_t media_rate;       /* Data rate of medium    */
 
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 1178b959a64..18a61f5ce87 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -192,6 +192,7 @@ static void fd_init(FDrive *drv)
     drv->max_track = 0;
     drv->ro = true;
     drv->media_changed = 1;
+    drv->media_last_sect = 0;
 }
 
 #define NUM_SIDES(drv) ((drv)->flags & FDISK_DBL_SIDES ? 2 : 1)
@@ -373,6 +374,7 @@ static int pick_geometry(FDrive *drv)
     }
     drv->max_track = parse->max_track;
     drv->last_sect = parse->last_sect;
+    drv->media_last_sect = parse->last_sect;
     drv->disk = parse->drive;
     drv->media_rate = parse->rate;
     return 0;
@@ -1905,6 +1907,17 @@ static void fdctrl_handle_partid(FDCtrl *fdctrl, int direction)
     fdctrl_to_result_phase(fdctrl, 1);
 }
 
+static bool fd_validate_last_sect(FDrive *drv, uint8_t new_last_sect_val)
+{
+    if (drv->media_validated && new_last_sect_val > drv->media_last_sect) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "FDC: Guest attempted to set last_sect to %u, exceeding valid media max of %u\n",
+                      new_last_sect_val, drv->media_last_sect);
+        return false;
+    }
+    return true;
+}
+
 static void fdctrl_handle_restore(FDCtrl *fdctrl, int direction)
 {
     FDrive *cur_drv = get_cur_drv(fdctrl);
@@ -1919,6 +1932,10 @@ static void fdctrl_handle_restore(FDCtrl *fdctrl, int direction)
     /* timers */
     fdctrl->timer0 = fdctrl->fifo[7];
     fdctrl->timer1 = fdctrl->fifo[8];
+    if (!fd_validate_last_sect(cur_drv, fdctrl->fifo[9])) {
+        fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM, FD_SR1_EC, 0x00);
+        return;
+    }
     cur_drv->last_sect = fdctrl->fifo[9];
     fdctrl->lock = fdctrl->fifo[10] >> 7;
     cur_drv->perpendicular = (fdctrl->fifo[10] >> 2) & 0xF;
@@ -1983,13 +2000,12 @@ static void fdctrl_handle_format_track(FDCtrl *fdctrl, int direction)
         fdctrl->data_state &= ~FD_STATE_MULTI;
     cur_drv->bps =
         fdctrl->fifo[2] > 7 ? 16384 : 128 << fdctrl->fifo[2];
-#if 0
-    cur_drv->last_sect =
-        cur_drv->flags & FDISK_DBL_SIDES ? fdctrl->fifo[3] :
-        fdctrl->fifo[3] / 2;
-#else
+
+    if (!fd_validate_last_sect(cur_drv, fdctrl->fifo[3])) {
+        fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM, FD_SR1_EC, 0x00);
+        return;
+    }
     cur_drv->last_sect = fdctrl->fifo[3];
-#endif
     /* TODO: implement format using DMA expected by the Bochs BIOS
      * and Linux fdformat (read 3 bytes per sector via DMA and fill
      * the sector with the specified fill byte
-- 
2.47.3


