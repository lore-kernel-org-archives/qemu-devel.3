Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F3CD3CCAE
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 04:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgFNk-00022U-EJ; Wed, 14 Jan 2026 23:54:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vgFNi-0001zP-Jx
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:54:50 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vgFNg-00076R-Ra
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:54:50 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-81f3b4ae67bso261295b3a.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 20:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768452887; x=1769057687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1HcDaCEOBouUMxSZzU9eT7F74w1l/7SCZiWk9i+TCm0=;
 b=Kj1JV+8dL5t0WM4eksyRVbS041dkN6J6GAxyehhpH8dpg+9Ln0bnpR5I3YobJNiwUk
 gDH+9+SQerrNxviy569qxzbvLpYyTqoA/5B/NFAYq1x+zc+d7C7UFtIER92wD/+qLNqw
 5TsCpogrNDPpXriar4RZcmsKoIaHk0HUyOu9bTn2uX4Gue27PTUiXA5ayIrE41Rmopxt
 z1ZR0ALO76q6BVQGJUBfd8zkBO4jbF/0Wfee6fJCYKLDc/4teEwzq3yoLf2YaZfNqqGd
 qutkbSjB3p+8RyDtJe+LIBEYrhQa2i+bwJDgOqpb4UXzWDlH3DfjczCJ8qpL3gqwpuEa
 Pcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768452887; x=1769057687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1HcDaCEOBouUMxSZzU9eT7F74w1l/7SCZiWk9i+TCm0=;
 b=FkScAzNivcCnHMJd/5xSavEbrsywIsB1Y/5T1CXAS3zJHtid0aeKDumpb5hSWDHw6Z
 WojXhekRC0r6WzGJZqfKVm/GPmBPEALSpVwt2tC4eJ5XQlxxACibCpf6KqK9cYxURo8L
 2UmHovfxa5Ap1iGFDfMbWiuwHwFKmMwU+wSuM2VQTSJBID6C6evgwCo0yAANI/swBcni
 5wzOx5W+cfT5L6+m/V2hNw1IDoU6QyTUpV4tNA0zA9LrHmZpVZ1vYGvf3IRfrFdBogoK
 OPSATqqapEA57fNVuqvwL9n0+m6+OFtmOuADsZ703l0MOj8s9iMok1Q+eipUXie4RMb4
 4rKw==
X-Gm-Message-State: AOJu0YxkVKRc+ZK8/hISNvvxJY/cPyiqPH3uXwk1b+kDL9rRsPi2P/ti
 fhi2BOQ7kYjhmvfvYlYZsOCxXgWvZr7KG+XmH9kvL4IiMQJidkqYkw8GIjf9ag==
X-Gm-Gg: AY/fxX4BSd6ZlbRnWjrVSoe83aC9j7SnnOSZ43WGy2dPhWswdvSzE+WbfiX5rx5ei/E
 sHej6HSrE5aCB05kG4yj9HidTEBuek7FFyV51SBsg3CxhIK5mlVCiT4IYgbcEd4vS3GSBcSQ2Uv
 DIGRB7SjrQyE6pvltJqfwgTiLGYe+HFkYcwJCO1szc98Spg2Ovp7g9uRW374md3+fIh9FznXDhu
 g2cbFcxR9Pz24kWpQrHvKabvlyiilW9x4lNWovGzgXrsk/y1CoxBweStAFA8DALjvJdVDNM6+wW
 Ti7VXgsNAJEsx/rg0YYAnz8gC0ZcD9fFfkSihTyW3Aqbr3d7+OnTfvWC0p4UynrId8FiVl2N76Q
 giNQRsGif1uvfEYPGtTrqU+VMNeA6zYcKg/cPAo8rPzS+xSgGtUhvlNQafVMCoImgF0KtRsGlXE
 pyxahtkJJcfTNqwg==
X-Received: by 2002:a05:6a00:a248:b0:81c:5694:c544 with SMTP id
 d2e1a72fcca58-81f81f80beamr4679691b3a.56.1768452887068; 
 Wed, 14 Jan 2026 20:54:47 -0800 (PST)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81f8e4b4110sm1141426b3a.10.2026.01.14.20.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 20:54:46 -0800 (PST)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com, Ilia Levi <ilia.levi@intel.com>
Subject: [PULL 2/3] hw/ufs: Fix mcq completion queue wraparound
Date: Thu, 15 Jan 2026 13:54:00 +0900
Message-ID: <6833aae1cfbbc83d8458ee1bba33ca4f71f71e55.1768452598.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1768452598.git.jeuk20.kim@samsung.com>
References: <cover.1768452598.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x432.google.com
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

From: Ilia Levi <ilia.levi@intel.com>

Currently, ufs_mcq_process_cq() writes to the CQ without checking whether
there is available space. This can cause CQ entries to be discarded and
overwritten. The solution is to stop writing when CQ is full and exert
backpressure on the affected SQs. This is similar to how NVMe CQs operate.

Signed-off-by: Ilia Levi <ilia.levi@intel.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c | 20 +++++++++++++++++++-
 hw/ufs/ufs.h |  9 +++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 4ee6755d82..b41eec0b7e 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -447,6 +447,10 @@ static void ufs_mcq_process_cq(void *opaque)
 
     QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next)
     {
+        if (ufs_mcq_cq_full(u, cq->cqid)) {
+            break;
+        }
+
         ufs_dma_write_rsp_upiu(req);
 
         req->cqe.utp_addr =
@@ -469,6 +473,12 @@ static void ufs_mcq_process_cq(void *opaque)
         tail = (tail + sizeof(req->cqe)) % (cq->size * sizeof(req->cqe));
         ufs_mcq_update_cq_tail(u, cq->cqid, tail);
 
+        if (QTAILQ_EMPTY(&req->sq->req_list) &&
+            !ufs_mcq_sq_empty(u, req->sq->sqid)) {
+            /* Dequeueing from SQ was blocked due to lack of free requests */
+            qemu_bh_schedule(req->sq->bh);
+        }
+
         ufs_clear_req(req);
         QTAILQ_INSERT_TAIL(&req->sq->req_list, req, entry);
     }
@@ -778,10 +788,18 @@ static void ufs_write_mcq_op_reg(UfsHc *u, hwaddr offset, uint32_t data,
         }
         opr->sq.tp = data;
         break;
-    case offsetof(UfsMcqOpReg, cq.hp):
+    case offsetof(UfsMcqOpReg, cq.hp): {
+        UfsCq *cq = u->cq[qid];
+
+        if (ufs_mcq_cq_full(u, qid) && !QTAILQ_EMPTY(&cq->req_list)) {
+            /* Enqueueing to CQ was blocked because it was full */
+            qemu_bh_schedule(cq->bh);
+        }
+
         opr->cq.hp = data;
         ufs_mcq_update_cq_head(u, qid, data);
         break;
+    }
     case offsetof(UfsMcqOpReg, cq_int.is):
         opr->cq_int.is &= ~data;
         break;
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 3799d97f30..13d964c5ae 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -200,6 +200,15 @@ static inline bool ufs_mcq_cq_empty(UfsHc *u, uint32_t qid)
     return ufs_mcq_cq_tail(u, qid) == ufs_mcq_cq_head(u, qid);
 }
 
+static inline bool ufs_mcq_cq_full(UfsHc *u, uint32_t qid)
+{
+    uint32_t tail = ufs_mcq_cq_tail(u, qid);
+    uint16_t cq_size = u->cq[qid]->size;
+
+    tail = (tail + sizeof(UfsCqEntry)) % (sizeof(UfsCqEntry) * cq_size);
+    return tail == ufs_mcq_cq_head(u, qid);
+}
+
 #define TYPE_UFS "ufs"
 #define UFS(obj) OBJECT_CHECK(UfsHc, (obj), TYPE_UFS)
 
-- 
2.43.0


