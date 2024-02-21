Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A62EC5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcrDh-0007uj-2s; Wed, 21 Feb 2024 13:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rcrDe-0007oZ-2F
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:21:22 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rcrDa-0003L1-Cd
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:21:21 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5c6bd3100fcso4062433a12.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 10:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708539677; x=1709144477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eiSoVZJtjOJJ7IGlGmk8cRI2lGtWO4AhdMc312mNoV4=;
 b=YG+8fVm/E44UqIyCWSzozjy4kjxet1xwDUvsUQTpz5Spo2aTSglOXMNoTINqfKCyCZ
 axbgT6Blk+YOPabp2rq0KqVdz/N/wyoL7uxfj91THQjW8yvOmDneE/zJkTOXRqqlzFLF
 WBQoFhtsuzPM9zJwP+18GserGma37frF8DBY2jCpSqCLWOhdjN3yUzYY9CbSQ0VaDlvI
 lPl3fLouujtgLsXJpMRkrPi8D7mjkStzNldYN/Nac/3ztO0FOmr2KSp0/NLlBa7qjqOz
 rvAPkIqzFpR+EwWdvNfgJ/eYtoUJTZ/CZAQsFt586sSPdrXw7dcIH/vfd0htc9OajidZ
 N8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708539677; x=1709144477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eiSoVZJtjOJJ7IGlGmk8cRI2lGtWO4AhdMc312mNoV4=;
 b=C+LntND50bce9vDUHsHFCX9wqC6X0SFTwZa/TKhLOm7oRUtRv9rGzuOjtAcgfzm5dt
 oXcXJEvr72DOJws/AQMePVF8yg/k0wR9fcFZCIrfIbDH8JJ8qvLYNhpBp0v7EnALylAU
 eM8QKyu9FFhFyhSRUfnutWk/hK4kxnA+ebcDskedvm7FdFRuztgMGfsMfKLoT7JTKmdW
 a79brOm0CbUrkW5M5/e/iDTbHAM9apAmGqZF0GFJQnCcggWFRhFPAVY3o1DgiBx/d39H
 9G955GFxlL3C4xjSEKpCxKA0PNAgvbFOE8O3gsoGIKPAg2AlWg9UyKKDvGkzAYsvr3tb
 oCSw==
X-Gm-Message-State: AOJu0YzD/whJODG0QoseR6EvBr9qhw+whyqLlcuyjB/zHxoIA7HwyEbA
 ysr77zOlGFdAy+9f2vRQUKi3dGDU2vupHpUVAIrU3rGoVlt96uo0vRplFYQe
X-Google-Smtp-Source: AGHT+IGAk48olbaYcijRDumKRKOL973AAWX5mM+93KfBcG5wDx9QsekZGw40m+D/x9wD0JEaDPXDfg==
X-Received: by 2002:a17:90a:cc9:b0:297:24da:887e with SMTP id
 9-20020a17090a0cc900b0029724da887emr15889680pjt.18.1708539676735; 
 Wed, 21 Feb 2024 10:21:16 -0800 (PST)
Received: from localhost.localdomain ([2601:641:300:14de:5692:7e41:13a2:69a])
 by smtp.gmail.com with ESMTPSA id
 cs16-20020a17090af51000b002992f49922csm9979009pjb.25.2024.02.21.10.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 10:21:16 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v4 05/10] hw/mem/cxl-type3: Refactor
 ct3_build_cdat_entries_for_mr to take mr size insead of mr as argument
Date: Wed, 21 Feb 2024 10:15:58 -0800
Message-ID: <20240221182020.1086096-6-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221182020.1086096-1-nifan.cxl@gmail.com>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The function ct3_build_cdat_entries_for_mr only uses size of the passed
memory region argument, refactor the function definition to make the passed
arguments more specific.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index c61cd2b5ac..6e5f908fb1 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -43,7 +43,7 @@ enum {
 };
 
 static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
-                                          int dsmad_handle, MemoryRegion *mr,
+                                          int dsmad_handle, uint64_t size,
                                           bool is_pmem, uint64_t dpa_base)
 {
     g_autofree CDATDsmas *dsmas = NULL;
@@ -62,7 +62,7 @@ static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
         .DSMADhandle = dsmad_handle,
         .flags = is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
         .DPA_base = dpa_base,
-        .DPA_length = memory_region_size(mr),
+        .DPA_length = size,
     };
 
     /* For now, no memory side cache, plausiblish numbers */
@@ -131,7 +131,7 @@ static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
          */
         .EFI_memory_type_attr = is_pmem ? 2 : 1,
         .DPA_offset = 0,
-        .DPA_length = memory_region_size(mr),
+        .DPA_length = size,
     };
 
     /* Header always at start of structure */
@@ -148,6 +148,7 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     g_autofree CDATSubHeader **table = NULL;
     CXLType3Dev *ct3d = priv;
     MemoryRegion *volatile_mr = NULL, *nonvolatile_mr = NULL;
+    uint64_t vmr_size = 0, pmr_size = 0;
     int dsmad_handle = 0;
     int cur_ent = 0;
     int len = 0;
@@ -162,6 +163,7 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
             return -EINVAL;
         }
         len += CT3_CDAT_NUM_ENTRIES;
+        vmr_size = memory_region_size(volatile_mr);
     }
 
     if (ct3d->hostpmem) {
@@ -170,21 +172,22 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
             return -EINVAL;
         }
         len += CT3_CDAT_NUM_ENTRIES;
+        pmr_size = memory_region_size(nonvolatile_mr);
     }
 
     table = g_malloc0(len * sizeof(*table));
 
     /* Now fill them in */
     if (volatile_mr) {
-        ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volatile_mr,
+        ct3_build_cdat_entries_for_mr(table, dsmad_handle++, vmr_size,
                                       false, 0);
         cur_ent = CT3_CDAT_NUM_ENTRIES;
     }
 
     if (nonvolatile_mr) {
-        uint64_t base = volatile_mr ? memory_region_size(volatile_mr) : 0;
+        uint64_t base = vmr_size;
         ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
-                                      nonvolatile_mr, true, base);
+                                      pmr_size, true, base);
         cur_ent += CT3_CDAT_NUM_ENTRIES;
     }
     assert(len == cur_ent);
-- 
2.43.0


