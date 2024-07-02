Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB61C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjwj-0002Tj-Cq; Tue, 02 Jul 2024 16:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjw2-0007MO-CB
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:17:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjvz-0008PK-Rq
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QuE+o0AC9wdLKXlzVTnODsdNe5/ti8zXK/7OKFfOYUM=;
 b=h2pYxeHEuyxm3z/rCN4QDtCBu2yBsO5yHlIQJ4Txi37lNFP9FMwPDOn2uZs0vIFWuPEFt+
 8X6AZwxa0vr9kZXF7yjxgI4+14EjBDEC+EZSVSFTmjKVHT744NmsjiZjUzqSFEr9/0c1US
 LOqT1mrQ89MEEsJvudyX0syogpYtipE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-JooX8d7vPM2afYhMC3dpEA-1; Tue, 02 Jul 2024 16:17:02 -0400
X-MC-Unique: JooX8d7vPM2afYhMC3dpEA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36710f4d5c9so3174081f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951419; x=1720556219;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QuE+o0AC9wdLKXlzVTnODsdNe5/ti8zXK/7OKFfOYUM=;
 b=gDYQhTNQrLY5SBKd9nvtlUEnzrHVuvDlDdI3IY624YNpD3RjuzHA7lNi5zDSCvG53N
 R/sOjKQxAw/0LKFaMrZYghmDnsk4svNTO1hnhZsUOOo4Ieqf5fUfueHpqVYBCDnf3Ej1
 pL4DrvyJZYsJWBoRJkX4nEoqByeBcCPKQqtU6WCimQOTp60JoznDl1yxHGdbIp3rYwOx
 Ys41ebhEeWhBlKk3+zx4TYABy+H6fiF4+WB7nH8so84GAFLWcdrfFHFXrheA2swT0mbO
 UjReR6GaXG615ITwEYTagtGkKGHU12ZsZCBE0MC7FRtwelVzCBW35umNIf3MGq2M5s8W
 raXQ==
X-Gm-Message-State: AOJu0YymzwflHevU8HGpRoVNWMX163Nx3fORg/nE9Yo2CE+u0kE/fIB5
 7jIVQy1g+DSkH+jWEjoaanoh7Zto2ekIQzHA4tQB9Vg3iOyMksISJFLgkcazRYCIosUT/AEvV/E
 HDAfy0XU7EeewIP7VGxv7XpjM9eKpvegUtGI/yF0G34okj/AgElFFtiN2p+c0j1n8ddHZ1NLS3y
 clmRx6DZ9yOdaPJ/hGkE3/5yVbtFe6hA==
X-Received: by 2002:adf:e94a:0:b0:366:ed80:d064 with SMTP id
 ffacd0b85a97d-367757343a6mr5816224f8f.71.1719951419542; 
 Tue, 02 Jul 2024 13:16:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExl0PcWu6JdYMWtdVP+9yGV7BdRIfFtc3dbDzBFPrmW14g9nbYwmgSnv+/KcKakJc10HTFRw==
X-Received: by 2002:adf:e94a:0:b0:366:ed80:d064 with SMTP id
 ffacd0b85a97d-367757343a6mr5816203f8f.71.1719951418945; 
 Tue, 02 Jul 2024 13:16:58 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a10307bsm14108090f8f.94.2024.07.02.13.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:16:58 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:16:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Svetly Todorov <svetly.todorov@memverge.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PULL v2 28/88] hw/cxl/cxl-mailbox-utils: Add superset extent
 release mailbox support
Message-ID: <3083f018b59fd35b9ee993715694f967c49afeb1.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
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


