Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578F1C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeBP-0003aW-TJ; Tue, 02 Jul 2024 10:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeBO-0003OW-9t
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:08:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeBM-0008Ae-Ht
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QuE+o0AC9wdLKXlzVTnODsdNe5/ti8zXK/7OKFfOYUM=;
 b=DiOFenw6p4NCmQ1ZXNmSBQ3DWjFuNA+Vv5fMbYUBkajuVFjXWD0ux7tTWclOyhnpitej5+
 Qd+rlQ6gsxBWOmAy1AaDvfyeHr+jfGnrIYRbm364nqdy01ltm2pJmw9JeOicW25oIdq9wz
 rS9pxwoXAgJyJiBm0YzdGJtI6CmdEDM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-Bdfjy7BhO-KJCUZqdKaNdA-1; Tue, 02 Jul 2024 10:08:30 -0400
X-MC-Unique: Bdfjy7BhO-KJCUZqdKaNdA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ee45dea727so43498571fa.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929308; x=1720534108;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QuE+o0AC9wdLKXlzVTnODsdNe5/ti8zXK/7OKFfOYUM=;
 b=g1h8iWs80kx+ZZ76gGxV95rgIn6Nu+q+E7ADvgZFTSJAXr6bSIchWGsyMSuEr+ul+O
 n0FDf3TWWeS5mq4bMMXuO+1k/pAxhebuk7SsoZKvDw+laNfOmRH2+90V+IPMQ58QKH0b
 XmZN85eLRQ9JRt5tuIfEuyMwjiW4T3+iS/be1Ey/oXcA/W/6xg4XT6xhtrFh5Jtud75+
 /67nlI5xcktus2A3F2HmcuEJCNsuBXdy0vGu984E4Ve5TkemYEpcIdRwh0cCuMovO6tJ
 mMWjdMxrcH2TpYIxxoUszwN+MGqRm9+zeGimWB2tgisLKrSFIhYY0XBA2u8BccTCRH/l
 OFEg==
X-Gm-Message-State: AOJu0Yw3xMFDu8+Q1Q8U6MWTtufZlAy+pn+XsmFk8z+rvgo+E/rvgmGC
 UPP2VxXYAx5Dkt/ZzyFPe5e3ZZNui7ofJr7JDiDJW+9O7sVz42OjLyKlkfprZnqAl7BiXazjkjw
 wRCeeZ9+8iPCxwBYFEpX1Y08PzJZNhRK7q6RTmqHr+r5W/nbuASrcazsZCFKikeLH4oTP9TAMYT
 ZTVavf/TKmNDJS4xbjDYoA3oDBN+FWIw==
X-Received: by 2002:a2e:a80c:0:b0:2ee:6254:f9f1 with SMTP id
 38308e7fff4ca-2ee6254fb37mr71784921fa.6.1719929308521; 
 Tue, 02 Jul 2024 07:08:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB7VMSAe5RZrg8sr1ujo7YRzCLDLvgQFHZNzW1YvKgmeNf6Z/zI39IVAcf8AOQDWz6P+uU5w==
X-Received: by 2002:a2e:a80c:0:b0:2ee:6254:f9f1 with SMTP id
 38308e7fff4ca-2ee6254fb37mr71783931fa.6.1719929306902; 
 Tue, 02 Jul 2024 07:08:26 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af376f5sm200519545e9.6.2024.07.02.07.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:08:26 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:08:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Svetly Todorov <svetly.todorov@memverge.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PULL 28/91] hw/cxl/cxl-mailbox-utils: Add superset extent release
 mailbox support
Message-ID: <3083f018b59fd35b9ee993715694f967c49afeb1.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fan Ni <fan.ni@samsung.com>

With the change, we extend the extent release mailbox command processing
to allow more flexible release. As long as the DPA range of the extent to
release is covered by accepted extent(s) in the device, the release can be
performed.

Tested-by: Svetly Todorov <svetly.todorov@memverge.com>
Reviewed-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
Message-Id: <20240523174651.1089554-14-nifan.cxl@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c4852112fe..74eeb6fde7 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1704,6 +1704,13 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
         dpa = in->updated_entries[i].start_dpa;
         len = in->updated_entries[i].len;
 
+        /* Check if the DPA range is not fully backed with valid extents */
+        if (!ct3_test_region_block_backed(ct3d, dpa, len)) {
+            ret = CXL_MBOX_INVALID_PA;
+            goto free_and_exit;
+        }
+
+        /* After this point, extent overflow is the only error can happen */
         while (len > 0) {
             QTAILQ_FOREACH(ent, updated_list, node) {
                 range_init_nofail(&range, ent->start_dpa, ent->len);
@@ -1718,14 +1725,7 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
                     if (range_contains(&range, dpa + len - 1)) {
                         len2 = ent_start_dpa + ent_len - dpa - len;
                     } else {
-                        /*
-                         * TODO: we reject the attempt to remove an extent
-                         * that overlaps with multiple extents in the device
-                         * for now. We will allow it once superset release
-                         * support is added.
-                         */
-                        ret = CXL_MBOX_INVALID_PA;
-                        goto free_and_exit;
+                        dpa = ent_start_dpa + ent_len;
                     }
                     len_done = ent_len - len1 - len2;
 
@@ -1752,14 +1752,9 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
                     }
 
                     len -= len_done;
-                    /* len == 0 here until superset release is added */
                     break;
                 }
             }
-            if (len) {
-                ret = CXL_MBOX_INVALID_PA;
-                goto free_and_exit;
-            }
         }
     }
 free_and_exit:
-- 
MST


