Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220FCCA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 11:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDgTm-0002dZ-5q; Mon, 05 Oct 2026 07:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3_IPDagoKCm8fgNaYRlWUhTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--stanleyjhu.bounces.google.com>)
 id 1xDgTh-0002al-Fm
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:03:30 -0400
Received: from mail-pg1-x545.google.com ([2607:f8b0:4864:20::545])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3_IPDagoKCm8fgNaYRlWUhTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--stanleyjhu.bounces.google.com>)
 id 1xDgTf-0005Re-2k
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:03:28 -0400
Received: by mail-pg1-x545.google.com with SMTP id
 41be03b00d2f7-cc7695f6a30so2146553a12.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 04:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791198205; x=1791803005; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KmtpQWUw98ulbJ4Apgs/zzyDTH2jGHwieHZEIkyAWR8=;
 b=tm6FcR2cBNygNe/taJPiLQf+0v8Its+umcwZnbSkN+KmHIf34TkW3wEobfajkK+jWA
 /TQsN+RQlti5wvcnRjIpYlfn+DvSURNzf45o363pObLJMC0gm/Ga6SEgsCZWQq2H80yc
 uPhOu+5eo87rFGBU2gE1y5n905jFx4a9bFLlXfj1eqi7IN8lEwetfAYM0aJXSH0s+DAR
 bvqfbpmaHAJ1KpgjzWCpbAnR14D4If1eTG9RYDvQ1mGiEJnMU5H/BTmf4TMKe0sS0ZLs
 tDxDvbg8Mp6dPg3hTRu/dKD5tuCXmTmrN/4N1MRbfCBpe9ZUcSVZ9DlbO7O5DCeKf3ij
 XpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791198205; x=1791803005;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KmtpQWUw98ulbJ4Apgs/zzyDTH2jGHwieHZEIkyAWR8=;
 b=bsS2MBgMoJPIhWgaYddu9wJvdFzbCfkpe+y/BFNEhewj30AdP/45aqLeBUla9ZFSFi
 YDXWIf8L0vyES3udWrW3EojdoECBh13TwJ69iYkFco0m1Nfz/Wv1VNcZLnxvOWU3dEqG
 faFGj3E4ZzGjjzq9+hnfeAyOaI0j9hpsAt2WpsjFDoOPLaAfNyfGKiyHjTaPlCG5HTW2
 xw0D//o1PExbte0Q0H7TJCvZGXgcuDb4/L8VtDTi5KOsqFaUx/9t8TQ6PgSJhJwS/q3j
 aiE8I8PllWtq78K0GJH+QP6OJklEGHwVNF9l6TUdbF48sylcpyHWwP2i3QTywfNTEPdl
 7HLw==
X-Forwarded-Encrypted: i=1;
 AKwUvByhgoCz3Cl02fTIR5GcOTY+zvfmRO+Wv8SyM0gar8/QvCpCoy544u6jj7ZUS0GptopPUAlN9K8YXcrX@nongnu.org
X-Gm-Message-State: AFuF++nnugzcF40547CvUeVrYDCiy3bgB7p5SF5myZht8Ari6JHAaygu
 wOC1+Y1zmtWkmyGoz7XbicNzC28dk9TTVHIWVlNrrtC9wEkwWXJTbaHsdTq0mviVncBew+pboSU
 EfW+qE60zzQLMmeviuJ7i2w==
X-Received: from pgcv27.prod.google.com ([2002:a05:6a02:531b:b0:cc7:a1dc:d7e4])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:734c:b0:3d3:aec2:4dcd with SMTP id
 adf61e73a8af0-3e0bced1f06mr9322012637.25.1791198204911; 
 Mon, 05 Oct 2026 04:03:24 -0700 (PDT)
Date: Mon,  5 Oct 2026 19:03:15 +0800
In-Reply-To: <20261005110315.3327418-1-stanleyjhu@google.com>
Mime-Version: 1.0
References: <20261005110315.3327418-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005110315.3327418-5-stanleyjhu@google.com>
Subject: [PATCH v4 4/4] hw/ufs: Skip nullified MCQ submission queue entries
 with OCS_ABORTED
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::545;
 envelope-from=3_IPDagoKCm8fgNaYRlWUhTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--stanleyjhu.bounces.google.com;
 helo=mail-pg1-x545.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
---
 hw/ufs/ufs.c        | 17 ++++++++++++++++-
 include/block/ufs.h |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 4c505e0bf..f008af746 100644
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
index b0515325f..4a614fbe5 100644
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
2.56.0.rc1.315.gc6ed9934b7-goog


