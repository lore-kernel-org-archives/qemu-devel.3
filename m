Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F790CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Sep 2025 00:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2IhV-0006fQ-CM; Fri, 26 Sep 2025 20:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1v2IhT-0006fB-JX
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 20:22:07 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1v2IhE-0006Qx-NC
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 20:22:06 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-77716518125so1439702b3a.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 17:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758932505; x=1759537305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WgBS8TXXh/PJHvsCbZXkp2wZ9PaKkzgJFyRLqDXciTQ=;
 b=I6gDyngm4JlXHf2/0Jmt89bm1LVyx7hvRca3PMb5T/7ge9pgl6f55E3Zh7n3kh5Saz
 FCQHewEyEttNgqhLUrBj9nenez+UlFH6cUIFhIaD5nBd01Sc9GdPb0uY9DNrJ99lWM9c
 wyYCjGjNak06JFILJFh6ijZOtW52+0W11UUnnuQrji4y9Z3AghfBEob+34L/YvkSBwYA
 /9hhutuqi66WKieGJPzqAxASjTsJfcTmkfgikmRAQMBFXywoDUbC0r5pJj+MbIVaZVEn
 395Q/qZgCc3YaEVR4SHIlkTHX69Ql+Dc2EzNwoO2bSDDIznVSexuCP/KTBVvo5nmtHWt
 d2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758932505; x=1759537305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WgBS8TXXh/PJHvsCbZXkp2wZ9PaKkzgJFyRLqDXciTQ=;
 b=pHlt33Av4PRlPhLIU50WtgKEd/sv+5lV+VBpVlPIcyIzTMKfEOia+GNN5x/mG58d85
 zg8dl98lHNFkmZKlgyYcrU4yXxSZXmyW2ao0rLVYA8E1QeTOq5UP5IbUHHKUbg/z4w7t
 t/Pl89gyDm24zZ9B9qd3W9yirsWRoumcscoADaZ0UUnX/LpgcjJ2frwVEnIP4Aq/oTil
 GwED8xQETEEAJ6hKoenQgk2E6euScsgwIw9TWSNhioTt9Yc4eybNCVIgixHeGpbWaWt6
 z5PwY2uX0zhSeAHxujZ1KUlAxif624zLBDxG0gfG6iNAQ7gEZrVto+Lf2lRuyy2dGnGg
 BkMA==
X-Gm-Message-State: AOJu0Yx7feEijiraZvD9VK+7FjjCPhY1D8gn1w7zjbGzCTcCSQoHCBny
 kjpoNZKyJ4CnGID7VHKVgIfAbAoQmoTNoh82AokgIP2FwmKAX0A7P4Bmvdmmrg==
X-Gm-Gg: ASbGncvJYbqtq5tXgo6CR+G7jG0bDTYRDzReKmQPa9yZtnU/ttVDJxemqgO3d2S9Pba
 +PsJDw2id/oerV/REciemo5Qxpf9TDS7TBmar2f7oRUdvAOPGSHnAVp7wvLpXupxDOoSOKAjnDz
 wcrq56o0ynWOgFgsqvzGdaXqmSh7ORVXCA7GBgOA9zYTuK2+stmLrkT2P8qgtZz6Xn94Ide+kws
 Do2RS51pXg0fFJ51BvK0OMJJXx6h1U0/zHiphd9yH2hFBnyD2UdBl2u/y19mh/xgf4Dm03rBLbS
 EYP/r05S+E+YD5ZFkGhU91Bq9wROg4nd12tuo+KFbSZGgrSZI4ohDhGT5ab5PT2UL//qZHNZmA6
 DiUwUOfjnrPMQQ4nrmIkKGcTCjj7v9Fu3woerPdc6Gac=
X-Google-Smtp-Source: AGHT+IEiVK/GMzpOhOc6Ms3m/uHtgMeXjMFirWPawAmkGC16ttcIQ4tMR5IRpWvj2pdHvtjFvsYukA==
X-Received: by 2002:a05:6a00:189a:b0:77f:472b:bc72 with SMTP id
 d2e1a72fcca58-780fcdc5b13mr8824571b3a.3.1758932504626; 
 Fri, 26 Sep 2025 17:21:44 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7810238ca29sm5350489b3a.6.2025.09.26.17.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 17:21:44 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, dave@stgolabs.net, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>
Subject: [QEMU PATCH 1/1] hw/cxl/cxl-mailbox-utils: Enable FMAPI Initiate Add
 for MHSLD
Date: Sat, 27 Sep 2025 00:18:07 +0000
Message-ID: <20250927002125.860668-2-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250927002125.860668-1-anisa.su887@gmail.com>
References: <20250927002125.860668-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Anisa Su <anisa.su@samsung.com>

Call mhd_reserve_extents in FMAPI Init Add (5604h)to enable sending
FMAPI Add command to MHSLD.

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c5177dfd92..9ac60db4e1 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -24,6 +24,7 @@
 #include "system/hostmem.h"
 #include "qemu/range.h"
 #include "qapi/qapi-types-cxl.h"
+#include "hw/cxl/mhsld/mhsld.h"
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 #define CXL_DC_EVENT_LOG_SIZE 8
@@ -4163,6 +4164,8 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
         CXLDCExtentRaw extents[];
     } QEMU_PACKED *in = (void *)payload_in;
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
+    CXLDCRegion *region = &ct3d->dc.regions[in->reg_num];
     int i, rc;
 
     switch (in->selection_policy) {
@@ -4201,6 +4204,28 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
                 return rc;
             }
 
+            /* If this is an MHD, attempt to reserve the extents */
+            if (cvc->mhd_reserve_extents) {
+                g_autofree CxlDynamicCapacityExtentList *records =
+                    g_malloc0(in->ext_count * sizeof(*records));
+                g_autofree CxlDynamicCapacityExtent *dc_exts =
+                    g_malloc0(in->ext_count * sizeof(*dc_exts));
+
+                for (i = 0; i < in->ext_count; i++) {
+                    CxlDynamicCapacityExtent *value = &dc_exts[i];
+                    value->offset =
+                        in->extents[i].start_dpa - region->base;
+                    value->len = in->extents[i].len;
+
+                    records[i].value = value;
+                    records[i].next = &records[i + 1];
+                }
+                records[in->ext_count - 1].next = NULL;
+                if (!cvc->mhd_reserve_extents(&ct3d->parent_obj, records, in->reg_num)) {
+                    return CXL_MBOX_INVALID_INPUT;
+                }
+            }
+
             CXLDCExtentGroup *group = NULL;
             for (i = 0; i < in->ext_count; i++) {
                 CXLDCExtentRaw *ext = &in->extents[i];
-- 
2.51.0


