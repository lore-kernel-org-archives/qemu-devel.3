Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68A2CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDju-0005gi-W6; Mon, 12 Oct 2026 06:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xGDjq-0005eZ-Mr
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:58:40 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xGDjm-0000x8-Ef
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:58:37 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2e8662d5e95so9237525ad.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 03:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791802712; x=1792407512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bb/f9KYrBOEB+uAscivhZYsDn6rA989y0DzG/mE0dNM=;
 b=ZUP4q+iHARN5MbSBX/eMZCJdXCdPFaytrU94Y9UygExtdecneMLqnQNY1Isz3CR9sn
 2qdqV/awaGXY1PKOM85LurfvtxiDwp0Klx8fUVXfOjkbghoEeeufgE+iilywt5ggGTFO
 RLogm3y6Py1473FJJeplVx8udqd4RS1RPfuiz6/UM9p2WDJCi4S1Rzw3Kbq2grYocDYx
 hT1PMgSgar0LKKlnYo5Qi8iAFJA3RJAkSQBQTc0CRRI8RJipJkWdM/mgLd1DbFO3qikv
 So7FnCAYEXBFanhk+YdkzEH0bWHGEnmpXMheqq+JPIWP7MjUmx5MNtzZffBgG68P08fp
 SmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791802712; x=1792407512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bb/f9KYrBOEB+uAscivhZYsDn6rA989y0DzG/mE0dNM=;
 b=dDhoCDptUSazUTL12PQwNoCfrF/8BouDN1EeyKFS2Vis95wQSNJsrmjTRw3AhHEWj9
 4SXX6NwLGUWv46YOlpVKDKf3zTRc5u6YRIwzz15J5/nTcDYIIs1xC7S2pXw7oevBKSON
 x2dMQDfdUh9BV439T68dvEuZYeEM6ahkNWJv3oDcyNhaXyHsb++c56GDm3E8F36uqmyh
 CmhbRyyuJ78A8HOafH9H2c44/4g83DZsrM1v4GyFGlJkLxZvQnmOzeE/W1KF3LrbxJ9c
 6Z+BwmTswW76uk6aT6tM1TI4efJ5H3fPtlAmlyUFBYmkGpNdCzZ9zcshZ9ZfkmqRWOkY
 Ha8A==
X-Gm-Message-State: AFq9FYKByZAQ8gUbj4MB2dOhh8nK8YWo7yWeV2SCDUWJJ6BQ8ySI8VOH
 IW6Md+LFbvI7QLR5+gITHuRQbclb/tJjJK/gf2Bg6Td/g6nDD24JqTWqpdQTeA==
X-Gm-Gg: AYBFou1vAIJmXDvp37DjmIUK7c0GqJPFVvVqeHJcvysEpm1PgqrRYKNg6scOksZaMeN
 Fcq0oxvOm/pWaxn8oAXWvRZIV8SXllRBiJlNJAYVUlIbUfJQNjh82xC0GPFs5KPEOgnd96aoAbH
 RWTHecIr+Zarlcdc0lW45OSQualmPCWxQEIGZQbaaI982u7NoJ4QyewoRLLi2xdq4CHAUg6H1LE
 g3oG1ixyVXC/HJKCN+OLBCLyTlpURix4WJy9iNJxG+uydbdCrk38BvpIt+qiLyMHN7uEjBaTwX9
 zNVS5/w8rv2BGlKNJmNcDkthmtwwL4eMTL13ZJk0QpQXttS3YPkrc0/ev5busXf50U+WRmvWuUh
 sp3tJtlDV0Zr7l5PIt9zq18cflRfFapxAozWokgveAVrcY5YKmIHNoqsmVbMRfIPWco/xGAT3dJ
 4kOk6yTl572pd7sii8x3QgHdm3SmWSCZMXf/+tKQRW+awbkCqbl9n/noDJrr2NZHu264QI3C/eq
 rU=
X-Received: by 2002:a17:902:ecd0:b0:2e4:4eed:5cc5 with SMTP id
 d9443c01a7336-2e842cd23b1mr82446595ad.38.1791802712560; 
 Mon, 12 Oct 2026 03:58:32 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e84219e6aasm41220305ad.18.2026.10.12.03.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 03:58:32 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: stanleyjhu@google.com, pierrick.bouvier@oss.qualcomm.com, kwolf@redhat.com,
 hreitz@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com
Subject: [PULL 4/5] hw/ufs: Skip nullified MCQ submission queue entries with
 OCS_ABORTED
Date: Mon, 12 Oct 2026 19:58:06 +0900
Message-ID: <92d01b9ee2bc95771e8b9348b111a10083ff64e2.1791802312.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791802312.git.jeuk20.kim@samsung.com>
References: <cover.1791802312.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x633.google.com
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

From: Stanley Jhu <stanleyjhu@google.com>

Per JEDEC UFSHCI (JESD223G Section 6.1.1 and Section 4.4.6 Step 2B),
host software in MCQ mode may stop a Submission Queue and nullify an
unfetched SQE by setting its UTRD Command Type (DW0 bits 31:28) to
0xF. When the Submission Queue is resumed, the host controller shall
skip execution of the nullified transfer request and post a Completion
Queue Entry (CQE) to the Completion Queue with OCS = ABORTED (0x06).

In ufs_mcq_process_sq(), check for UFS_UTP_CMD_TYPE_NULL (0xF), read
the Request UPIU header on a best-effort basis via
ufs_dma_read_req_upiu() to populate cqe.task_tag and cqe.lun for
UFSHCI 4.1+ completion decoding, and unconditionally post a CQE with
UFS_OCS_ABORTED without executing the command or writing a Response
UPIU for the nullified entry.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c        | 17 ++++++++++++++++-
 include/block/ufs.h |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 4c505e0bffe..f008af7467e 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -36,6 +36,7 @@
 
 static void ufs_exec_req(UfsRequest *req);
 static void ufs_clear_req(UfsRequest *req);
+static void ufs_mcq_process_cq(void *opaque);
 
 static inline uint64_t ufs_mcq_reg_addr(UfsHc *u, int qid)
 {
@@ -474,6 +475,17 @@ static void ufs_mcq_process_sq(void *opaque)
         ufs_mcq_init_req(sq->u, req, sq);
         memcpy(&req->utrd, &sqe, sizeof(req->utrd));
 
+        if ((le32_to_cpu(sqe.header.dword_0) >> 28) == UFS_UTP_CMD_TYPE_NULL) {
+            ufs_dma_read_req_upiu(req);
+            req->utrd.header.dword_2 = cpu_to_le32(
+                (le32_to_cpu(req->utrd.header.dword_2) & ~UFS_MASK_OCS) |
+                UFS_OCS_ABORTED);
+            req->state = UFS_REQUEST_COMPLETE;
+            QTAILQ_INSERT_TAIL(&sq->cq->req_list, req, entry);
+            ufs_mcq_process_cq(sq->cq);
+            continue;
+        }
+
         req->state = UFS_REQUEST_RUNNING;
         ufs_exec_req(req);
     }
@@ -493,7 +505,10 @@ static void ufs_mcq_process_cq(void *opaque)
             break;
         }
 
-        ufs_dma_write_rsp_upiu(req);
+        if ((le32_to_cpu(req->utrd.header.dword_0) >> 28) !=
+            UFS_UTP_CMD_TYPE_NULL) {
+            ufs_dma_write_rsp_upiu(req);
+        }
 
         /* UTRD/CQE are LE; round-trip through host to keep BE correct. */
         uint64_t ucdba =
diff --git a/include/block/ufs.h b/include/block/ufs.h
index b0515325f92..4a614fbe526 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -665,6 +665,7 @@ enum {
     UFS_UTP_CMD_TYPE_SCSI = 0x0,
     UFS_UTP_CMD_TYPE_UFS = 0x1,
     UFS_UTP_CMD_TYPE_DEV_MANAGE = 0x2,
+    UFS_UTP_CMD_TYPE_NULL = 0xf,
 };
 
 /* To accommodate UFS2.0 required Command type */
-- 
2.43.0


