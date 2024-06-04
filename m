Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB5DC41513
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZVh-0003JU-Mt; Tue, 04 Jun 2024 15:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZVf-00038A-J6
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:07:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZVc-0000xN-RM
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717528067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QuE+o0AC9wdLKXlzVTnODsdNe5/ti8zXK/7OKFfOYUM=;
 b=iUXB58ddxQrLbPfIsxzZ1RFuR8gLgm/iBBfe/QeTwjeAnVCopH6pN36dEqrneG6lfr/q9+
 tsHbPzyqb1pWYmmLZdVj1fM6xT08lzNig5LZQPRaNud0U5o0YP1L2SnRF6jA0d9Z/OYGoq
 g/vns8ElI0MvLs4H6PEE1SKiqVx/YqA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-Nk49qZM-PT6Y9Oc_tM6-Hw-1; Tue, 04 Jun 2024 15:07:46 -0400
X-MC-Unique: Nk49qZM-PT6Y9Oc_tM6-Hw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35e83bf3294so109121f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717528064; x=1718132864;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QuE+o0AC9wdLKXlzVTnODsdNe5/ti8zXK/7OKFfOYUM=;
 b=lJFy6l4lXr/Id8b1wQIHw60ODcTU2AgdibpVaX9qevJ0SgdNNfi6vbGGVDV8fDc4x/
 gSiR3KXJi6xCamZfrms9peQp1u7ighKgo3Tsa7BFC3R70lbeAIzpmUY+JE5TwWKYfJ03
 hZ+oFFCkklSPdRg02nHEH2T9vc3DcLSgqxGD3LXaL5D3Eobm2goeKfdVBHEfGJRnWeLF
 if9oz8O2yg4DgYm/AK4o+YFNtZifd1TlOEQj4etakOJpaJvIAyA8CWLhkr8r2WA77kCP
 EvPpOECzyIZilo7zAhETzA1B5vRXgtk13lKUtacrXunMJyKeMtL1hco/GgRJ0X3l0fP8
 yAHA==
X-Gm-Message-State: AOJu0Yw9chj85trDM31bEb3rNRgky89IvPltUMMCUf5zY0W2RBtGnE7d
 ZXT5abIWkCU0Autij3MAG5Pjl+V3Qph+cmZhCk+JbNKZxTNJcTySe8DVEtNRAiB1fu2K5YPu+FS
 tkRXuMn0kQ8w0qcWCB9sFtECcuppbXaAJ0U81ll6ljaOOnTQwK5S8A4CkC8USYfxTBroyNKs9u1
 AYuSmWJ2+cdlwJfrKfHVj1UNf/iSSWvw==
X-Received: by 2002:a5d:5402:0:b0:358:ffe5:dce3 with SMTP id
 ffacd0b85a97d-35e8ef8fea6mr213463f8f.49.1717528064435; 
 Tue, 04 Jun 2024 12:07:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGATLlSHlwkWNmGeRAzWO9VcJJgOUCRml/Ahfdmheos3UF4mb5mBUCEiwLLJ9rG91wT/RnEIQ==
X-Received: by 2002:a5d:5402:0:b0:358:ffe5:dce3 with SMTP id
 ffacd0b85a97d-35e8ef8fea6mr213446f8f.49.1717528063974; 
 Tue, 04 Jun 2024 12:07:43 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd064dfd1sm12517936f8f.108.2024.06.04.12.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:07:43 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:07:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Svetly Todorov <svetly.todorov@memverge.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PULL 29/46] hw/cxl/cxl-mailbox-utils: Add superset extent release
 mailbox support
Message-ID: <1fd233748ea9aeff3b88478cf106ad3bd32a1df2.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


