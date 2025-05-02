Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B18FC3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 16:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAtSX-0007ji-9D; Fri, 02 May 2025 12:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSV-0007gL-LR
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:41:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtST-0006RZ-Ug
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746204113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W/uc90W1ZOpsuuSkhOtgbizEm4VdHuE1qRbVF1rMbXw=;
 b=N8fnE0TeAqsKklvE06heR/qegGnJeDk0plmLWDLh7/1h9a7gWAG2vNKlmvH9UaMxowz6r/
 f0uAoJO7qz6EgC1Hdrj4mYXcamKtlRHn2gw/+Lr80fyNf5sXHnE3pf4qHsJFkZ3l2aB6Hw
 vAhnFlOeiAEHtQvNMAH881MajdF1bo8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-1rUQA3y2MWam9lfPXZo_Ww-1; Fri, 02 May 2025 12:41:52 -0400
X-MC-Unique: 1rUQA3y2MWam9lfPXZo_Ww-1
X-Mimecast-MFC-AGG-ID: 1rUQA3y2MWam9lfPXZo_Ww_1746204112
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c955be751aso384372885a.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 09:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746204111; x=1746808911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W/uc90W1ZOpsuuSkhOtgbizEm4VdHuE1qRbVF1rMbXw=;
 b=Vu6OGCpGFm+M0S2FQl0LY37cSeKjiDOushc1GB2AQWN09K2DOOy6sMwRHKRshpnZUX
 gBxCfOOUYASbtsb6WhgX/eyQhqItar6FubbcoH2SWebYyaniI42e55+05kD+zKHwN5IQ
 KPl39zvOirk0Q2eFOfwt8RatJRU21ybO7qLxsacl1x2pqFo+nyIByacdEFZLSsmyWH22
 hlnqYL45MGOcqJwKqQEDefVYbRhkmFct3Bt1OZ1V9MFOqHT9uGFUuftxDibPsFo0kIvm
 0CGjSepZQIVxzFRWD9GFx7RBrb9n29gFUjsJ55nUqU9iqudDFQn8kto2hLrezyN94AX+
 5fCw==
X-Gm-Message-State: AOJu0YwPL3Mm2FePLtw+YYUwvKf2r7UrWohe3rFeoLz7h8y8x0ltT0yJ
 8sYsKUJGFdnRXOKVdWxxXJE91Q7fO5lkV4etf0OHYzb1U8twe++Dzna7KUA6oX0M/8f527sHKed
 O47NsBqS6iyV3Jj0RamWQLH+o9CZRrySsI/Bl/UXIOraU0y8RabAGAITTdit1HOyJqX3FmZDPdQ
 OwuMb53xBq0jfmotlnO1CMaq7clPg6a/pjtw==
X-Gm-Gg: ASbGncve8HII6wObv5lsc1Qz7xQP4Rh28bknnvj9DZvNi/w/XX1F8r0SqEtVE13A06o
 Xp6JhWZWxOwagSDhRA2IZn8/qYWYldYU2UogsJmTFXw098PuExlSKFvbHNXTeq2ptWTuzCTHpLC
 Bpk6HkGrYm6JjEhWUdR3j0sFQYLXXMOxvaPDHTyPge2NLXHLBaP3ymTc45YtlSDA4YpM7Oaf8dm
 FUiRyzJ7MPXKrTShGk7VK181sFuRt+PSpcZs2C5f77orYgP2uF8G+Zar1VwOyERbcWGzmR94FY4
X-Received: by 2002:a05:620a:298d:b0:7c9:1335:633e with SMTP id
 af79cd13be357-7cad5b207f1mr564693585a.1.1746204111420; 
 Fri, 02 May 2025 09:41:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdVjNTrsVg/SSGiIlfRGbkN/TRTZ6uH8WnIpfir49uoYTt7qJIzCY9WxX5j6ts+DRCHoBMlw==
X-Received: by 2002:a05:620a:298d:b0:7c9:1335:633e with SMTP id
 af79cd13be357-7cad5b207f1mr564689485a.1.1746204111052; 
 Fri, 02 May 2025 09:41:51 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cad23d1c8dsm203108385a.60.2025.05.02.09.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 09:41:50 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PULL 04/14] migration: Unfold control_save_page()
Date: Fri,  2 May 2025 12:41:31 -0400
Message-ID: <20250502164141.747202-5-peterx@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250502164141.747202-1-peterx@redhat.com>
References: <20250502164141.747202-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Li Zhijian <lizhijian@fujitsu.com>

control_save_page() is for RDMA only, unfold it to make the code more
clear.
In addition:
 - Similar to other branches style in ram_save_target_page(), involve RDMA
   only if the condition 'migrate_rdma()' is true.
 - Further simplify the code by removing the RAM_SAVE_CONTROL_NOT_SUPP.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Message-ID: <20250305062825.772629-6-lizhijian@fujitsu.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/rdma.h |  3 +--
 migration/ram.c  | 34 +++++++---------------------------
 migration/rdma.c |  7 ++-----
 3 files changed, 10 insertions(+), 34 deletions(-)

diff --git a/migration/rdma.h b/migration/rdma.h
index 4d3386b84a..f74f16a459 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -33,7 +33,6 @@ void rdma_start_incoming_migration(InetSocketAddress *host_port, Error **errp);
 #define RAM_CONTROL_ROUND     1
 #define RAM_CONTROL_FINISH    3
 
-#define RAM_SAVE_CONTROL_NOT_SUPP -1000
 #define RAM_SAVE_CONTROL_DELAYED  -2000
 
 #ifdef CONFIG_RDMA
@@ -56,7 +55,7 @@ static inline
 int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
                            ram_addr_t offset, size_t size)
 {
-    return RAM_SAVE_CONTROL_NOT_SUPP;
+    g_assert_not_reached();
 }
 #endif
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index cb8b2ed493..1181a99cf6 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1143,32 +1143,6 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
     return len;
 }
 
-/*
- * @pages: the number of pages written by the control path,
- *        < 0 - error
- *        > 0 - number of pages written
- *
- * Return true if the pages has been saved, otherwise false is returned.
- */
-static bool control_save_page(PageSearchStatus *pss,
-                              ram_addr_t offset, int *pages)
-{
-    int ret;
-
-    ret = rdma_control_save_page(pss->pss_channel, pss->block->offset, offset,
-                                 TARGET_PAGE_SIZE);
-    if (ret == RAM_SAVE_CONTROL_NOT_SUPP) {
-        return false;
-    }
-
-    if (ret == RAM_SAVE_CONTROL_DELAYED) {
-        *pages = 1;
-        return true;
-    }
-    *pages = ret;
-    return true;
-}
-
 /*
  * directly send the page to the stream
  *
@@ -1965,7 +1939,13 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
     int res;
 
     /* Hand over to RDMA first */
-    if (control_save_page(pss, offset, &res)) {
+    if (migrate_rdma()) {
+        res = rdma_control_save_page(pss->pss_channel, pss->block->offset,
+                                     offset, TARGET_PAGE_SIZE);
+
+        if (res == RAM_SAVE_CONTROL_DELAYED) {
+            res = 1;
+        }
         return res;
     }
 
diff --git a/migration/rdma.c b/migration/rdma.c
index a3c3b432d1..4875ca1987 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3284,14 +3284,11 @@ err:
 int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
                            ram_addr_t offset, size_t size)
 {
-    if (!migrate_rdma()) {
-        return RAM_SAVE_CONTROL_NOT_SUPP;
-    }
+    assert(migrate_rdma());
 
     int ret = qemu_rdma_save_page(f, block_offset, offset, size);
 
-    if (ret != RAM_SAVE_CONTROL_DELAYED &&
-        ret != RAM_SAVE_CONTROL_NOT_SUPP) {
+    if (ret != RAM_SAVE_CONTROL_DELAYED) {
         if (ret < 0) {
             qemu_file_set_error(f, ret);
         }
-- 
2.48.1


