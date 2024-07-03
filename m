Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63DCC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8kL-0008IL-EG; Wed, 03 Jul 2024 18:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8kI-0007sJ-2P
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:46:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8kG-0001Tq-Br
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QuE+o0AC9wdLKXlzVTnODsdNe5/ti8zXK/7OKFfOYUM=;
 b=AVSEF8+zEympD4adq/49z6PndipH/bK2ShYW90HyCz0FZ1AH9vGcOhxaB94FhX6VqT5Uqx
 +lFtyXoRQxum/LAuVpbQrVbo6hC9+kcr8STT2JFveHn8zbrHbxEwMglIfF34zM333yF11C
 Pnkd3hMKfWmtsH4Zzt1YKm1cyXmY1K0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-J7qPAOdRPrCgyekVBHlzQA-1; Wed, 03 Jul 2024 18:46:32 -0400
X-MC-Unique: J7qPAOdRPrCgyekVBHlzQA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a72af18f571so1315566b.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046790; x=1720651590;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QuE+o0AC9wdLKXlzVTnODsdNe5/ti8zXK/7OKFfOYUM=;
 b=QT3IxG+kiS8dO0eVkMLxy+25Qd0zGyMQVSIiUtS96zxCdjgNKkHZC3skwe89znA27B
 DjoZLuVzwp1rUv9pnsyZaU6biLcT90ww/0mwiP+Ikh7ZT/V23mfGTyrShuLYgYZ2GJrS
 51xFDHU3frpQBQk0cDvWD/xuNe6qnh9M5yC8sRlmxSSwgFXjy6/unki5qhPD1Xprvu/L
 AxJ8h5pQKwR04gwQ63FDCxnhcoXMBAwsHehjrdgjB+Q1syFLvzwKVyuK5sr2DM4trjNZ
 dFjqT00HKOTLyM3ZfcltyjVf0admApNl45j3Ebqxy9KTL2dPA09laCjsQPW/2cs3TmnX
 S3Gw==
X-Gm-Message-State: AOJu0YxIXCWckOebS/vRKUlrNZso3WQIU+fbA9t8zXe8e3IHKYbpCYNu
 IcU65CL3RZ054ZLvy17SPmxxW0Q5qONhEXiGeSgyCmC0nlMgG1q+zrThtwe5C3S56AZchFcoSTA
 ILqxHxxkGncrbObbwQKR74p7DAptU+SObZ0SLcofYyguY/pKMzHKJeYneQ0Osk1M7ZC7gH3x3sw
 Uxj7oRPHLRpLBRk7/Mw5t17CUU2GCwKg==
X-Received: by 2002:a17:907:a0b:b0:a72:676a:7d7b with SMTP id
 a640c23a62f3a-a751441efeamr955844366b.9.1720046790505; 
 Wed, 03 Jul 2024 15:46:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEyKXP6bb6bD/iXdL1BwzS94SOjMemi5MP7Q0Hg31DFAZ3L2cfv5s1yJQwcHez6O3fQsLXfg==
X-Received: by 2002:a17:907:a0b:b0:a72:676a:7d7b with SMTP id
 a640c23a62f3a-a751441efeamr955841966b.9.1720046789432; 
 Wed, 03 Jul 2024 15:46:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77b784de44sm3449966b.56.2024.07.03.15.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:46:29 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:46:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Svetly Todorov <svetly.todorov@memverge.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PULL v3 28/85] hw/cxl/cxl-mailbox-utils: Add superset extent
 release mailbox support
Message-ID: <3083f018b59fd35b9ee993715694f967c49afeb1.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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


