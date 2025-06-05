Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3385C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 23:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNKEP-0000NY-Il; Thu, 05 Jun 2025 19:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uNKEN-0000N1-Fo
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 19:42:43 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uNKEL-0004gu-Tk
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 19:42:43 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so1636681b3a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 16:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749166960; x=1749771760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dlJ/ihmtY/Bs+6QNasQQE5ci8/VnkGAsX6ch1ZEqQ/Y=;
 b=WrY/svPiQNbfbyJ4iPRBB7r1UTG5xxWHAzUKIlDI/l8bl3PTuUGLQZJ+hXqP5y9+kL
 g24OOWL5fY92eBy9iSBCnFI5J8VYrzZV2t+rpqBl6nL5TdHeUZuAt4K75vjOpejqXIJQ
 zFPUuOGOCidlOoCjlvibVabQosXSdwalmVZWlOicYlIThA9rrTl+WcGsRQcwQ0B1LufC
 VYDpwZIKy2VY46v4DUACeB009YVhSX0q1HNzohV0uW28S9DkWMVI0zlPnjb2ViM/v+gX
 euxQD1YQw5OFEvjiATKsFNuzqiZEEh6kx47zcAIfwKqvqUM9csT8gv//QWiv3MAJWuK0
 kuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749166960; x=1749771760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dlJ/ihmtY/Bs+6QNasQQE5ci8/VnkGAsX6ch1ZEqQ/Y=;
 b=i+kpUNFTkiyZ1q4ab6S/yxGijJfgEEUron9g8ud2oyXOCHGR5lLNndarGdls7eIe4W
 gmZVb652uzXO5YgQReU8ZhAMv3NvHXZGVF7z1wIE6CNcZzi0IdItFeeQlo6dJfJWbtBy
 VLfrmmBNOfnW3A3+JDWo7Mc4vUSS1PbIJrAVitgACwoSegH1osZWNb2LCnrY0BSLJFZF
 6VB9/EmGZvHG6z5mM/KG5PO1RbLqm8rUVl0EsAb2DziX11F78mQCX8GGtYh81hjOtlZa
 pLUvTsbkeHBIYsatx8fg9RiHy0AtVAcYwidOLb4HSfmGNrBTcjyrMi1ju/8gQSWquxvr
 Rfgw==
X-Gm-Message-State: AOJu0Yy7/km5HFqH3+onTl0ycdAy6jb6cx/F/SGcCFgX55B/gD3LC+3W
 jQo5OoCXI1btINaGOgiui9FC5ZmZZn4opLeV/MysVuoK1Z8k0ccSbMNO+gLJ2A==
X-Gm-Gg: ASbGncukvCk9RoOML8uo7evjEmhun4PAoi9tW78YY06PgG5TUUjcRY07/kY5wrAuPxR
 eGS3aIdaXZ12HjbWyEoU47lPzbbi7lDFFz3cWi/oFqHyMe5TOYHc8cS2edU0F/DsFGQEKp15Ufs
 DsRzzT3gOZBTQwi8pMpwZQ6ScpDq4cyqo5TxP7BC6Umc8AfX3EuN5EL+E9ktngo6Mo+Nb0Xm2v9
 Jx9T9jHiRT8rh/jIM3oK3fUzIM4wlBN00h8RroJG4nihUAvVtz1DcsPQxdHlxj7z+krO+J5qL8I
 oPphVisqpzWW7jou3qBUb4YdSD8no5d2AgpXQAxEmbXNsxAbIvle/7/jZYPQ86d5YFS4qMcCYm1
 rbmf2gjg=
X-Google-Smtp-Source: AGHT+IFyjKedcs1IVdYVe/iobdhpu7k14FKeOftOEpSx+HSKmjoGcM6e9GvPLeuTgwROj4K4xaTPug==
X-Received: by 2002:a05:6a00:b85:b0:742:da7c:3f30 with SMTP id
 d2e1a72fcca58-74827f10920mr2042558b3a.19.1749166960438; 
 Thu, 05 Jun 2025 16:42:40 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b0847b9sm213916b3a.104.2025.06.05.16.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 16:42:40 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>,
 Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH v3 4/9] cxl_events.h: Move definition for
 dynamic_capacity_uuid and enum for DC event types
Date: Thu,  5 Jun 2025 23:42:18 +0000
Message-ID: <20250605234227.970187-5-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605234227.970187-1-anisa.su887@gmail.com>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move definition/enum to cxl_events.h for shared use in next patch

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/mem/cxl_type3.c          | 15 ---------------
 include/hw/cxl/cxl_events.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0fccd22800..cdd60079c4 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1876,21 +1876,6 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
     }
 }
 
-/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
-static const QemuUUID dynamic_capacity_uuid = {
-    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
-                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
-};
-
-typedef enum CXLDCEventType {
-    DC_EVENT_ADD_CAPACITY = 0x0,
-    DC_EVENT_RELEASE_CAPACITY = 0x1,
-    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
-    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
-    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
-    DC_EVENT_CAPACITY_RELEASED = 0x5,
-} CXLDCEventType;
-
 /*
  * Check whether the range [dpa, dpa + len - 1] has overlaps with extents in
  * the list.
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 38cadaa0f3..758b075a64 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -184,4 +184,19 @@ typedef struct CXLEventDynamicCapacity {
     uint32_t tags_avail;
 } QEMU_PACKED CXLEventDynamicCapacity;
 
+/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
+static const QemuUUID dynamic_capacity_uuid = {
+    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
+                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
+};
+
+typedef enum CXLDCEventType {
+    DC_EVENT_ADD_CAPACITY = 0x0,
+    DC_EVENT_RELEASE_CAPACITY = 0x1,
+    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
+    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
+    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
+    DC_EVENT_CAPACITY_RELEASED = 0x5,
+} CXLDCEventType;
+
 #endif /* CXL_EVENTS_H */
-- 
2.47.2


