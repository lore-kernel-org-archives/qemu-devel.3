Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93001C79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4mKP-0001Bt-Ln; Thu, 10 Sep 2026 17:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lMK-00038J-Dn
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:27:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lM8-0000We-Ta
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S24e5KZkbgytsFsTZMikkKLncaEvmAfRYA/x9bDr/iM=;
 b=dZEd15AcRuMVcGSNkGQWWK7zXKjUpERtW/68Wne00BuDCBNHNSr0DbPpOuW5GPKYlTv2h+
 wwVKHC6+QnaX0arte949k1720ouJ7EjtA23NB4sZqcfFFyUyELfzrRuBBreu1uQiZo4ynL
 cvVgVVDBxR7zIlJO4HxfMcVs1KJOM14=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-LLgk5h9JM_yE2kAvEpv8ww-1; Thu, 10 Sep 2026 16:13:26 -0400
X-MC-Unique: LLgk5h9JM_yE2kAvEpv8ww-1
X-Mimecast-MFC-AGG-ID: LLgk5h9JM_yE2kAvEpv8ww_1789071205
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4955e865174so802205e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071205; x=1789676005; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S24e5KZkbgytsFsTZMikkKLncaEvmAfRYA/x9bDr/iM=;
 b=fvzNIOERLyuXvASriJw+4VdjdP7Z1QoutvLriYu2GOOrdbHn8rE6gDbVuxovt1VOvp
 Wxjy9mqOZmKXvFzbh7nm6pcRAbIjU8lrGbAKLuD6ZQSZtuwHBRwtOWY/c/Nhmhu7VbhS
 8P4q3RovVIUYQTiGITXE/ie4WV1+4CND1NXMk30zKtV3mSqghtI0GU3q12ca99EaaF82
 SQYkUS9zFH4yqJ62QmvPrFFsX3WyBo01ANS4ydv6hfTRuP5J28HnI0ah3m7zqECJ8VIz
 QDQCyYKsZ0QsJ2AOsdRKRBn2PPn6dRfPUECpuonjW3Ts+XOExjlFTQ8RHotBnr1fxKcX
 rvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071205; x=1789676005;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S24e5KZkbgytsFsTZMikkKLncaEvmAfRYA/x9bDr/iM=;
 b=RDHbMY4MRdDfLadsv8rn644krq5urbBHBsw1aZOskR+lgqzXhTRRjEunrT25DNAwWf
 bxOeh1Jzrffy8OkBWh/nBYN38fu5CCeycSm54e3Tal5aclpbiJqXCqIQ13R4kR3FiSjK
 KfU5XPxKQTg9WZvpMU/x8naMtCYj/Qz467rDiLQaxf136MZzSh46YL0msm+csaDZhNX5
 OlOj//OyxSCOO6vONSGE/hHF/ebiF+9UPKiiSvezidWDjaZ9zLdd11PEo8gLlYG28Aj3
 Ag3t5W8hpm8pr7VTTH9UtDx0DnQG6qO2YmCu2mOdHEnw1T8yaqNIjxWR0pX0VTxbdpcv
 YnwQ==
X-Gm-Message-State: AFuF++mdiKqKJYHN+9wAQbDZI79h3GlPXb2roB5KLs/HI4RW6PbMWttR
 GvGAy/f+p0fTFkt0Onsz3I3iLe0RSC5DwX+Mpv+SuYvPvzMtYBMvvragY66ipMydXAWBX33vfNh
 WuWoQNKmjHaSx68SvkP+U+bFkkcg8WtEol5/roIfQjdhpRLe2WoAKOHIJnVrD1pcZ9vAamjA4pE
 guS0ImnLYGoA/MqbFXH4yS5QK7wSK2dDyFYA==
X-Gm-Gg: AYBFou23gd3ylDKF9gkKvgtRUIINvhsGAj/yxTPzvDDMyo83NWJLOE3z1gp25eB+Q7D
 IgIlyh7mr1YT5e8DNWLtFgTpZyQ/Rpk1ymWjkZxS7CsEyAwWDstEXfAJR0tTsivkOAfebQWHePX
 0IMlv2JaYvgHRw+2vx3lcaNYFvZICW+OzQXpvYNU8f38G2swjK0w/26mAE36rjaaXJzo3wA242e
 YECjH/OCj1sQieKH4uCTyPfb3gSGE4ieENzqeZknCzfWDPJ7vCM55QuJtNJxtY3vHLBXzYiOrJ/
 aZHpztjzznaOjDLtyu+8cCPQAouOFzgMf0UQRPWMjgd3DHrxQqb33alorYU4NiJez9lXuaOCGyy
 ADWw+atZ2DC77VWF9u5Nz2Lk=
X-Received: by 2002:a05:600c:8712:b0:49c:ee36:10fc with SMTP id
 5b1f17b1804b1-49e619acbfemr7651055e9.8.1789071205383; 
 Thu, 10 Sep 2026 13:13:25 -0700 (PDT)
X-Received: by 2002:a05:600c:8712:b0:49c:ee36:10fc with SMTP id
 5b1f17b1804b1-49e619acbfemr7650595e9.8.1789071204851; 
 Thu, 10 Sep 2026 13:13:24 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c2985dsm162781735e9.6.2026.09.10.13.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:13:24 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:13:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL 47/90] hw/nvme: Fix block accounting in nvme_copy()
Message-ID: <7e18eb15d941e08f4b6f96f876a412269ab25bb3.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Hanna Czenczek <hreitz@redhat.com>

In nvme_copy(), we start accounting for each of the copied ranges, but
only end it once (in nvme_copy_done()). We should end it after each
read/write operation is done instead, so they are properly accounted
for.

We should also actually pass the number of bytes we are reading/writing
(instead of 0), and probably account for the metadata operations also,
as they are block operations we execute.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260724152315.234183-4-hreitz@redhat.com>
---
 hw/nvme/ctrl.c | 53 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index c662d968db..c56725947a 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -2802,8 +2802,6 @@ static const AIOCBInfo nvme_copy_aiocb_info = {
 static void nvme_copy_done(NvmeCopyAIOCB *iocb)
 {
     NvmeRequest *req = iocb->req;
-    NvmeNamespace *ns = req->ns;
-    BlockAcctStats *stats = blk_get_stats(ns->blkconf.blk);
 
     if (iocb->idx != iocb->nr) {
         req->cqe.result = cpu_to_le32(iocb->idx);
@@ -2813,14 +2811,6 @@ static void nvme_copy_done(NvmeCopyAIOCB *iocb)
     g_free(iocb->bounce);
     g_free(iocb->ranges);
 
-    if (iocb->ret < 0) {
-        block_acct_failed(stats, &iocb->acct.read);
-        block_acct_failed(stats, &iocb->acct.write);
-    } else {
-        block_acct_done(stats, &iocb->acct.read);
-        block_acct_done(stats, &iocb->acct.write);
-    }
-
     iocb->common.cb(iocb->common.opaque, iocb->ret);
     qemu_aio_unref(iocb);
 }
@@ -2951,6 +2941,7 @@ static void nvme_copy_out_completed_cb(void *opaque, int ret)
     NvmeCopyAIOCB *iocb = opaque;
     NvmeRequest *req = iocb->req;
     NvmeNamespace *dns = req->ns;
+    BlockAcctStats *stats = blk_get_stats(dns->blkconf.blk);
     uint32_t nlb;
 
     nvme_copy_source_range_parse(iocb->ranges, iocb->idx, iocb->format, NULL,
@@ -2959,10 +2950,12 @@ static void nvme_copy_out_completed_cb(void *opaque, int ret)
     if (ret < 0) {
         iocb->ret = ret;
         req->status = NVME_WRITE_FAULT;
-        goto out;
-    } else if (iocb->ret < 0) {
+    }
+    if (iocb->ret < 0) {
+        block_acct_failed(stats, &iocb->acct.write);
         goto out;
     }
+    block_acct_done(stats, &iocb->acct.write);
 
     if (dns->params.zoned) {
         nvme_advance_zone_wp(dns, iocb->zone, nlb);
@@ -2979,11 +2972,18 @@ static void nvme_copy_out_cb(void *opaque, int ret)
     NvmeCopyAIOCB *iocb = opaque;
     NvmeRequest *req = iocb->req;
     NvmeNamespace *dns = req->ns;
+    BlockAcctStats *stats = blk_get_stats(dns->blkconf.blk);
     uint32_t nlb;
     size_t mlen;
     uint8_t *mbounce;
 
-    if (ret < 0 || iocb->ret < 0 || !dns->lbaf.ms) {
+    if (ret < 0 || iocb->ret < 0) {
+        block_acct_failed(stats, &iocb->acct.write);
+        goto out;
+    }
+    block_acct_done(stats, &iocb->acct.write);
+
+    if (!dns->lbaf.ms) {
         goto out;
     }
 
@@ -2996,6 +2996,7 @@ static void nvme_copy_out_cb(void *opaque, int ret)
     qemu_iovec_reset(&iocb->iov);
     qemu_iovec_add(&iocb->iov, mbounce, mlen);
 
+    block_acct_start(stats, &iocb->acct.write, mlen, BLOCK_ACCT_WRITE);
     iocb->aiocb = blk_aio_pwritev(dns->blkconf.blk, nvme_moff(dns, iocb->slba),
                                   &iocb->iov, 0, nvme_copy_out_completed_cb,
                                   iocb);
@@ -3012,6 +3013,7 @@ static void nvme_copy_in_completed_cb(void *opaque, int ret)
     NvmeRequest *req = iocb->req;
     NvmeNamespace *sns = iocb->sns;
     NvmeNamespace *dns = req->ns;
+    BlockAcctStats *sstats = blk_get_stats(sns->blkconf.blk);
     NvmeCopyCmd *copy = NULL;
     uint8_t *mbounce = NULL;
     uint32_t nlb;
@@ -3024,10 +3026,12 @@ static void nvme_copy_in_completed_cb(void *opaque, int ret)
     if (ret < 0) {
         iocb->ret = ret;
         req->status = NVME_UNRECOVERED_READ;
-        goto out;
-    } else if (iocb->ret < 0) {
+    }
+    if (iocb->ret < 0) {
+        block_acct_failed(sstats, &iocb->acct.read);
         goto out;
     }
+    block_acct_done(sstats, &iocb->acct.read);
 
     nvme_copy_source_range_parse(iocb->ranges, iocb->idx, iocb->format, &slba,
                                  &nlb, NULL, &apptag, &appmask, &reftag);
@@ -3102,7 +3106,7 @@ static void nvme_copy_in_completed_cb(void *opaque, int ret)
     qemu_iovec_reset(&iocb->iov);
     qemu_iovec_add(&iocb->iov, iocb->bounce, len);
 
-    block_acct_start(blk_get_stats(dns->blkconf.blk), &iocb->acct.write, 0,
+    block_acct_start(blk_get_stats(dns->blkconf.blk), &iocb->acct.write, len,
                      BLOCK_ACCT_WRITE);
 
     iocb->aiocb = blk_aio_pwritev(dns->blkconf.blk, nvme_l2b(dns, iocb->slba),
@@ -3121,20 +3125,29 @@ static void nvme_copy_in_cb(void *opaque, int ret)
 {
     NvmeCopyAIOCB *iocb = opaque;
     NvmeNamespace *sns = iocb->sns;
+    BlockAcctStats *stats = blk_get_stats(sns->blkconf.blk);
     uint64_t slba;
     uint32_t nlb;
+    size_t mlen;
 
-    if (ret < 0 || iocb->ret < 0 || !sns->lbaf.ms) {
+    if (ret < 0 || iocb->ret < 0) {
+        block_acct_failed(stats, &iocb->acct.read);
+        goto out;
+    }
+    block_acct_done(stats, &iocb->acct.read);
+
+    if (!sns->lbaf.ms) {
         goto out;
     }
 
     nvme_copy_source_range_parse(iocb->ranges, iocb->idx, iocb->format, &slba,
                                  &nlb, NULL, NULL, NULL, NULL);
 
+    mlen = nvme_m2b(sns, nlb);
     qemu_iovec_reset(&iocb->iov);
-    qemu_iovec_add(&iocb->iov, iocb->bounce + nvme_l2b(sns, nlb),
-                   nvme_m2b(sns, nlb));
+    qemu_iovec_add(&iocb->iov, iocb->bounce + nvme_l2b(sns, nlb), mlen);
 
+    block_acct_start(stats, &iocb->acct.read, mlen, BLOCK_ACCT_READ);
     iocb->aiocb = blk_aio_preadv(sns->blkconf.blk, nvme_moff(sns, slba),
                                  &iocb->iov, 0, nvme_copy_in_completed_cb,
                                  iocb);
@@ -3342,7 +3355,7 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
     assert(len <= blen);
     qemu_iovec_add(&iocb->iov, iocb->bounce, len);
 
-    block_acct_start(blk_get_stats(sns->blkconf.blk), &iocb->acct.read, 0,
+    block_acct_start(blk_get_stats(sns->blkconf.blk), &iocb->acct.read, len,
                      BLOCK_ACCT_READ);
 
     iocb->aiocb = blk_aio_preadv(sns->blkconf.blk, nvme_l2b(sns, slba),
-- 
MST


