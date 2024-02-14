Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAE9C48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDFL-0005Y6-Jg; Wed, 14 Feb 2024 06:16:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEZ-00045y-7i
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEX-0007Dc-3n
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0BqA9eVzG1Xkbf5+yaBkWiX1PEZkTb1figaBuHZ4bdw=;
 b=DX1g3RD274lCMog3k0Rn59cqrgFo54lofITPZof8xT0D92jT829dyvOttz1YCkPFCDyLeb
 z6/tn4tCUTgDfwsQuWdTXcsmU1QY5b1ieQNCBhkZjt2+y2BCrLhl9cqt1O+tae7GjoSPGF
 9rSAiGigbsxR0a5a2rWxodNIhVT+Y50=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-As1qIUyQO_yArAJM5GL5bQ-1; Wed, 14 Feb 2024 06:15:18 -0500
X-MC-Unique: As1qIUyQO_yArAJM5GL5bQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a3c3f477eb7so186335466b.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:15:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909316; x=1708514116;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0BqA9eVzG1Xkbf5+yaBkWiX1PEZkTb1figaBuHZ4bdw=;
 b=PEAzAWIunbKynyLHgIfTWGTKR9yDIUh4s7SyWt+libFQkGG4PfN2K11cRs2OK2vjdh
 h2Wb699fUK9l5sUuIZTBwb4Brk2yxcSpYDels7+HHZTFZ92qV56znphnhlyF/Z9/F2N2
 7bgI2ivoS9YbHt9BZjAx/Gpi4zZ/BDw+M8iJrcQBPG03K6GC+0D0Gfziv0ZhI+C5tub4
 DAARB1XL65MTYS/VC5Gx/g2MFKHvswaecqmDwH6MDKM4xEwqwJCswKWNucCEc6qugzHH
 /M03A0b2nel97cM6CK6w9ZfcNkUIgEm5CsOfiXZW8xqKNlkakEfsonZGmSiXgypSDB7M
 yzUg==
X-Gm-Message-State: AOJu0Yx7moXpQcjtR8xkBo2BjGfujOlkoDZRNJSiQQoo2KhtTUdDH/AP
 k0YQwxbao+hBDNVB0eggMtG5N+2PcDdu1rQ3HRmGi3Ve3CEXWRfU9RN3ZWAAyDIYxwoWiKplDKv
 sGwjqTUH8xAmKC8IKhS4aokkFm+6QlR5i/XFJsycf91+7CV5BrgeKfhWUyEntVk73D+CSyOI0Nj
 IWOXys+mlJ1OfVgxfgzDB5GKGNj+NVBQ==
X-Received: by 2002:a17:906:374a:b0:a3d:2637:b713 with SMTP id
 e10-20020a170906374a00b00a3d2637b713mr1776481ejc.54.1707909316224; 
 Wed, 14 Feb 2024 03:15:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEg06sXqD5nwQvc3dSZ5KvqlW8ZAzu7nOBsNTYs+thJjIcP8XoFHlQhyGB5iiEJARiz3DUKSg==
X-Received: by 2002:a17:906:374a:b0:a3d:2637:b713 with SMTP id
 e10-20020a170906374a00b00a3d2637b713mr1776465ejc.54.1707909315943; 
 Wed, 14 Feb 2024 03:15:15 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWBE1DUo6l7tRnad2agKVEalLFoCR/WAO8+miM9Eth4zslkepjY7bsAmGGHOYRoZp+NJqGddC0i3dOWnLhOfrDyXwgo0q9xlOSJjAS6TGaKO/NaGDw0PoM82wbiYJTYqQ==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 vh2-20020a170907d38200b00a3d08f3283fsm1468213ejc.104.2024.02.14.03.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:15:15 -0800 (PST)
Date: Wed, 14 Feb 2024 06:15:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 38/60] hw/mem/cxl_type3: Drop handling of failure of
 g_malloc0() and g_malloc()
Message-ID: <0dbcc0ce2f7b7a98a11224add69b2f2f2b8125da.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

As g_malloc0/g_malloc() will just exit QEMU on failure there is no
point in checking for it failing.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240126120132.24248-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/mem/cxl_type3.c | 52 +++++++---------------------------------------
 1 file changed, 7 insertions(+), 45 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 52647b4ac7..1b92a065a3 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -42,9 +42,9 @@ enum {
     CT3_CDAT_NUM_ENTRIES
 };
 
-static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
-                                         int dsmad_handle, MemoryRegion *mr,
-                                         bool is_pmem, uint64_t dpa_base)
+static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
+                                          int dsmad_handle, MemoryRegion *mr,
+                                          bool is_pmem, uint64_t dpa_base)
 {
     g_autofree CDATDsmas *dsmas = NULL;
     g_autofree CDATDslbis *dslbis0 = NULL;
@@ -54,9 +54,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
     g_autofree CDATDsemts *dsemts = NULL;
 
     dsmas = g_malloc(sizeof(*dsmas));
-    if (!dsmas) {
-        return -ENOMEM;
-    }
     *dsmas = (CDATDsmas) {
         .header = {
             .type = CDAT_TYPE_DSMAS,
@@ -70,9 +67,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
 
     /* For now, no memory side cache, plausiblish numbers */
     dslbis0 = g_malloc(sizeof(*dslbis0));
-    if (!dslbis0) {
-        return -ENOMEM;
-    }
     *dslbis0 = (CDATDslbis) {
         .header = {
             .type = CDAT_TYPE_DSLBIS,
@@ -86,9 +80,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
     };
 
     dslbis1 = g_malloc(sizeof(*dslbis1));
-    if (!dslbis1) {
-        return -ENOMEM;
-    }
     *dslbis1 = (CDATDslbis) {
         .header = {
             .type = CDAT_TYPE_DSLBIS,
@@ -102,9 +93,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
     };
 
     dslbis2 = g_malloc(sizeof(*dslbis2));
-    if (!dslbis2) {
-        return -ENOMEM;
-    }
     *dslbis2 = (CDATDslbis) {
         .header = {
             .type = CDAT_TYPE_DSLBIS,
@@ -118,9 +106,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
     };
 
     dslbis3 = g_malloc(sizeof(*dslbis3));
-    if (!dslbis3) {
-        return -ENOMEM;
-    }
     *dslbis3 = (CDATDslbis) {
         .header = {
             .type = CDAT_TYPE_DSLBIS,
@@ -134,9 +119,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
     };
 
     dsemts = g_malloc(sizeof(*dsemts));
-    if (!dsemts) {
-        return -ENOMEM;
-    }
     *dsemts = (CDATDsemts) {
         .header = {
             .type = CDAT_TYPE_DSEMTS,
@@ -159,8 +141,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
     cdat_table[CT3_CDAT_DSLBIS2] = g_steal_pointer(&dslbis2);
     cdat_table[CT3_CDAT_DSLBIS3] = g_steal_pointer(&dslbis3);
     cdat_table[CT3_CDAT_DSEMTS] = g_steal_pointer(&dsemts);
-
-    return 0;
 }
 
 static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
@@ -171,7 +151,6 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     int dsmad_handle = 0;
     int cur_ent = 0;
     int len = 0;
-    int rc, i;
 
     if (!ct3d->hostpmem && !ct3d->hostvmem) {
         return 0;
@@ -194,27 +173,18 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     }
 
     table = g_malloc0(len * sizeof(*table));
-    if (!table) {
-        return -ENOMEM;
-    }
 
     /* Now fill them in */
     if (volatile_mr) {
-        rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volatile_mr,
-                                           false, 0);
-        if (rc < 0) {
-            return rc;
-        }
+        ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volatile_mr,
+                                      false, 0);
         cur_ent = CT3_CDAT_NUM_ENTRIES;
     }
 
     if (nonvolatile_mr) {
         uint64_t base = volatile_mr ? memory_region_size(volatile_mr) : 0;
-        rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
-                                           nonvolatile_mr, true, base);
-        if (rc < 0) {
-            goto error_cleanup;
-        }
+        ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
+                                      nonvolatile_mr, true, base);
         cur_ent += CT3_CDAT_NUM_ENTRIES;
     }
     assert(len == cur_ent);
@@ -222,11 +192,6 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     *cdat_table = g_steal_pointer(&table);
 
     return len;
-error_cleanup:
-    for (i = 0; i < cur_ent; i++) {
-        g_free(table[i]);
-    }
-    return rc;
 }
 
 static void ct3_free_cdat_table(CDATSubHeader **cdat_table, int num, void *priv)
@@ -1168,9 +1133,6 @@ void qmp_cxl_inject_uncorrectable_errors(const char *path,
         }
 
         cxl_err = g_malloc0(sizeof(*cxl_err));
-        if (!cxl_err) {
-            return;
-        }
 
         cxl_err->type = cxl_err_code;
         while (header && header_count < 32) {
-- 
MST


