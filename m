Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904C4CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIUE5-0000rl-B3; Mon, 10 Nov 2025 10:54:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1vIUDy-0000Hi-RA
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:54:38 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1vIUDx-00021V-BU
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:54:34 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42b3c965df5so544701f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762790071; x=1763394871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wTnGp1jvQuXBRM2IqgXRLBZUh5DJl1myfERLxTHh/j8=;
 b=hVyTOTX+O7+DwqT5RTDWmp6KDmE6wdprvxd4d3xyjFsD7nqdAcwFOx1WzrugKL6BU4
 /iQiDHdZyzR6LiKSP0MNbtaemwlyFlptPJcmIN/zJhiP/7m85vxwb9o9Zasm/MP+MjFK
 Y2iUtAyque2XQzrgRU4UIpWaBu7LxiR79oYg+WRK0CGDVC8bzn6OWuqIBPOETlwmJ1Jg
 vGXWbjnG1z4phPBOzmkAfnWD2a+3rMMg6keAw+5LsqKqN8l/BMMQZwf91KP9IiP5DjNm
 ohUrgoRjOsjhR+dFI42f7KdptP3pJJTbJrHIKabR4MGbKZkauUBAsEFLyRx8py8jBdeX
 tvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762790071; x=1763394871;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wTnGp1jvQuXBRM2IqgXRLBZUh5DJl1myfERLxTHh/j8=;
 b=VMpGz/GeQaw83HVggdyImKrqAiLibGAcSzvjhGYOmTES1gCvO0+0LgSBRjnXSjeIFQ
 DDoHxgKLDi955V8vzOLtGAC5aA5TVriFHqiukuUhlomkW2r9cG3oKunBNzzV12yJZCvF
 ZwuXMGsSuPJXKAu6DLOvLnsa62zMrkjdT4RRagLAYPu4OWxy6Wgkz7tLjdkIxODxCV0b
 qQFYXh5Nz0jZgA+3bL3HZFT5yAAppiTfxcZ5FWdu8SxV8n4Bv+u3kKomQMO7z60lZG+T
 +g0QxZodj7SlBR8lGnKP2ckEK56bTVUn2juMHSR0PiePyn4dcKAgmav4e7GeN/w2LjW9
 xhIA==
X-Gm-Message-State: AOJu0YwuJpj9OE/5YQictnKuHZzPF1K4sbbgOvqFcbnN2PWskaAxnejg
 FSiLpnEWJPQvGWWURPlSaJY7zthvAsspojE1NJXIYS9ytD8jyyxZqHhNwZEN3A==
X-Gm-Gg: ASbGncvi8/UgZuLT1+Zpmw7QY8ApWsxRevhHz76FJVjcFwj2Kipzly9wG7RaSyfYG0p
 mSY++4e4jMBrnuLmglBxGZJPRS+1GpRpMk6gIm9JSvifGFpeMaB/PHU9wp4VM8G8KU+HvosoIO7
 bkZAdZqVVcHC+qTi2wpSGVhQtGdvaFeHjh63nSD1BLqH7MZXxWQymMdO8wuQGZC+1GIYgrolK3l
 gXn6r96DKHIDc57ptzeUd65fnJC3sG+M+PD2EM8hLpS/tku6csVCmmwTLDUeMDztg8CgB7Dws0f
 WHEd9KsriH352N+DxU10StWcB/tXAiB+T1ewR9izXBDH8MpxpD31gjnsaKtJgqKbWP3JvirLd97
 4XDZ6L2Nytf2XUj3WeaJ1kFVjBMlxQp7Dr2ZtTFc6hILBikWGs3SC+jb0FiwlVLCHa/aA7Ve/LI
 ilmGYeyCGpqePPQNM=
X-Google-Smtp-Source: AGHT+IHsjpecOLNQvPZRiKcKwG2cBS9b9bme/nup3Jym1PBn6tNgTnCGkqi1jjn+TgLtYQH12uNe8A==
X-Received: by 2002:a05:600c:46c6:b0:477:7b30:a6fc with SMTP id
 5b1f17b1804b1-4777b30a823mr48967305e9.30.1762790071071; 
 Mon, 10 Nov 2025 07:54:31 -0800 (PST)
Received: from osama.. ([156.223.120.220]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4776bcd521fsm241020695e9.6.2025.11.10.07.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 07:54:30 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: qemu-devel@nongnu.org,
	qemu_oss@crudebyte.com,
	groug@kaod.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] hw/9pfs: Drop unused print_sg helper
Date: Mon, 10 Nov 2025 17:54:24 +0200
Message-ID: <20251110155424.694664-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=osama.abdelkader@gmail.com; helo=mail-wr1-x42b.google.com
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

Remove the print_sg() debug helper and its always-disabled call sites
in v9fs_read() and v9fs_write(). The function was only reachable via
if (0) blocks, so it has been dead code for a long time.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 hw/9pfs/9p.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index bc4a016ee3..a8de894f4c 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1389,20 +1389,6 @@ static int stat_to_v9stat_dotl(V9fsPDU *pdu, const struct stat *stbuf,
     return stat_to_qid(pdu, stbuf, &v9lstat->qid);
 }
 
-static void print_sg(struct iovec *sg, int cnt)
-{
-    int i;
-
-    printf("sg[%d]: {", cnt);
-    for (i = 0; i < cnt; i++) {
-        if (i) {
-            printf(", ");
-        }
-        printf("(%p, %zd)", sg[i].iov_base, sg[i].iov_len);
-    }
-    printf("}\n");
-}
-
 /* Will call this only for path name based fid */
 static void v9fs_fix_path(V9fsPath *dst, V9fsPath *src, int len)
 {
@@ -2468,9 +2454,6 @@ static void coroutine_fn v9fs_read(void *opaque)
         do {
             qemu_iovec_reset(&qiov);
             qemu_iovec_concat(&qiov, &qiov_full, count, qiov_full.size - count);
-            if (0) {
-                print_sg(qiov.iov, qiov.niov);
-            }
             /* Loop in case of EINTR */
             do {
                 len = v9fs_co_preadv(pdu, fidp, qiov.iov, qiov.niov, off);
@@ -2785,9 +2768,6 @@ static void coroutine_fn v9fs_write(void *opaque)
     do {
         qemu_iovec_reset(&qiov);
         qemu_iovec_concat(&qiov, &qiov_full, total, qiov_full.size - total);
-        if (0) {
-            print_sg(qiov.iov, qiov.niov);
-        }
         /* Loop in case of EINTR */
         do {
             len = v9fs_co_pwritev(pdu, fidp, qiov.iov, qiov.niov, off);
-- 
2.43.0


