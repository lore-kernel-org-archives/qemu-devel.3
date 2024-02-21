Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A02C5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcrDg-0007t1-B7; Wed, 21 Feb 2024 13:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rcrDY-0007ft-Qt
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:21:16 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rcrDW-0003J1-8c
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:21:16 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-29026523507so5241576a91.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 10:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708539672; x=1709144472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AkPmI8FuszQzNKc/W7C7bH++18bz1caF1vBxyxTADMI=;
 b=bcWptzMSWKntLYZZJ525r6JVGX9N1dCimKy8I6N69cAt3ZHgxpPgX+5DPSwCn1L3sV
 WkYVlq82dMTJy4Xhuxgi6xuxcETqBNDbg85ql6qplBAzRIJjP0STei9o8Y8I545r+jhx
 OesGa1rUfScC5e/ni5sqC7TRMyl4zdi1eQbhqzCfUTAdVNtj8s2BFpgAztT+XznhKqIS
 h7I7GLm8+JhKkopRnpv1PUt7eUcCjpMTsINCooI7IuPBQqBtV+CTKeSYrBXgErza/aU/
 JuVMb+tfNEM2kXWHej1mTCdZzyL+UEFwR5aM2GloKW8Kzu8COGAK8G6Ah61w8kmT7LVE
 eoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708539672; x=1709144472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AkPmI8FuszQzNKc/W7C7bH++18bz1caF1vBxyxTADMI=;
 b=tLr75g4//UECRsWJuTNZg3Qnsi4L9RcfPTCa8BYhlIDLaNRZJI5L4wBQk9kYsXr3T4
 xF23qVmjAjS87IkoOcyWViJNe7NysCs2kv6+yxiV9b6FRIsGsYOfuOtC8OcZ8lf4irpz
 Btow3wmUTILfv5T5TRI2o9vEBTYjuA7A0Pbf5mw7hFSPKLt4cqwT4FI4Nm44wJXnC25f
 RvDyZXeFS5gT+A87Oy2fno3D78Lzt/mK9KOuJeDsg4FI5PAihLu3Cr0vi3Kzrwedcbw2
 qJLPmIgyQJOAMCkcD63521nYAeRydNFTPirsYqMbhQJM+6Dmk724VxzH3uGdZ6FnI/lp
 aHIQ==
X-Gm-Message-State: AOJu0YwF0oKgb2Z5Crut1rwc12yolt2N/w8wMz9iZ7ZY+LJ4SHl7X2D1
 PFHxZGkUxfF3j0PDO+7xMaDVGiD3FlZoL68TFcigN+6mzozOxH53RcKnmj2p
X-Google-Smtp-Source: AGHT+IFMcnQh5f80Wkda3K0vH+ueICO5TJY8WkNFGkF0tVy5RzTaPhNg7QC/g2xsj8usX4PLltMs+Q==
X-Received: by 2002:a17:90b:1e47:b0:299:2241:820b with SMTP id
 pi7-20020a17090b1e4700b002992241820bmr14945559pjb.37.1708539672173; 
 Wed, 21 Feb 2024 10:21:12 -0800 (PST)
Received: from localhost.localdomain ([2601:641:300:14de:5692:7e41:13a2:69a])
 by smtp.gmail.com with ESMTPSA id
 cs16-20020a17090af51000b002992f49922csm9979009pjb.25.2024.02.21.10.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 10:21:11 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v4 01/10] hw/cxl/cxl-mailbox-utils: Add dc_event_log_size
 field to output payload of identify memory device command
Date: Wed, 21 Feb 2024 10:15:54 -0800
Message-ID: <20240221182020.1086096-2-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221182020.1086096-1-nifan.cxl@gmail.com>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pj1-x1029.google.com
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

Based on CXL spec r3.1 Table 8-127 (Identify Memory Device Output
Payload), dynamic capacity event log size should be part of
output of the Identify command.
Add dc_event_log_size to the output payload for the host to get the info.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 4bcd727f4c..ba1d9901df 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -21,6 +21,7 @@
 #include "sysemu/hostmem.h"
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
+#define CXL_DC_EVENT_LOG_SIZE 8
 
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
@@ -780,8 +781,9 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
         uint16_t inject_poison_limit;
         uint8_t poison_caps;
         uint8_t qos_telemetry_caps;
+        uint16_t dc_event_log_size;
     } QEMU_PACKED *id;
-    QEMU_BUILD_BUG_ON(sizeof(*id) != 0x43);
+    QEMU_BUILD_BUG_ON(sizeof(*id) != 0x45);
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
@@ -807,6 +809,7 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
     st24_le_p(id->poison_list_max_mer, 256);
     /* No limit - so limited by main poison record limit */
     stw_le_p(&id->inject_poison_limit, 0);
+    stw_le_p(&id->dc_event_log_size, CXL_DC_EVENT_LOG_SIZE);
 
     *len_out = sizeof(*id);
     return CXL_MBOX_SUCCESS;
-- 
2.43.0


