Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931EDC5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 16:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sizIB-000299-5Z; Tue, 27 Aug 2024 12:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sizI9-00020x-3y
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 12:43:37 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sizI7-0002bN-4f
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 12:43:36 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6cf6d1a2148so15385297b3.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 09:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724777013; x=1725381813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SEDmyzzxPb/PUKZBhsRmkSdCWD04Zj/XpJE2z0YZDVM=;
 b=C/GyFW5vm1Bk4Fx4TbURMYQ6S6Hy/P+2FzKfh+UymqEjWIDI7OQxEFK5+dNxRxKo4D
 TF8N9Cduq6IWwpFAdDVI+buNju/wp/Rsr3WYIXm+qC4UTFPItHFTanRrC/6ZccdA875Y
 ISL5gxVUBdGpHQ1SZohAZNaRCzFV7a06Aa/nKtPm30tgt625nRK5BQKQWnw4oWm/c8ZS
 3GWk8uSX1jKS49usMKHFSyZNU5zAdePlSmJyBnIj8rMFA6gMaT5SbKkzLX7mgB2dM3Ox
 a2yqb3uG9MY/RTGxT8edBZgYjI37nIrLN41zSrCkAvXNOvt5l9PFzgBr/KrfWOHH88N+
 7fCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724777013; x=1725381813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SEDmyzzxPb/PUKZBhsRmkSdCWD04Zj/XpJE2z0YZDVM=;
 b=aS/d0/zp8afrdUmfwxne4fFuHRiCLY27FvtzanG3sF0Gq63OYwskFMJSx8OHKyTPS/
 Vn0d8FaqDtIAFNnpjJnrp/AJmvtXUJ6j2gF5SDJV3QID1U0X96C6DbhJpv1K12GR13rl
 XkigMf2qdCTbwDBHkQllHIN4vb4b+otti9jMGSI2CIyHZFtKDgaJb3lVqCN/jWb78a2E
 I93XUsz+loQ9b/1dAnwOISPOBmrbPkdxX8ps1HFgRk4NVUn/KAHhoY5A2k1Nou3ZAueI
 Nr5p4edGYJ05jns5MfCkSSD3ppjxperBEzV/3MNSJ95KMbJMmFllFnvayDjN5lN8lA1A
 5ZZQ==
X-Gm-Message-State: AOJu0YxdZRDZp+5wDrfdtCkQFGjoh0EwqoS092ZCFujU/6t0dU+kIU1K
 I1/aa201jvp+ZvDv61fG5ARHNcFzzDfA54qeHYtWN/Mq8zOFlK+Ljv+9mg==
X-Google-Smtp-Source: AGHT+IE59fdXqmAKT5SobODemnTv9LGfPiVyfZ/eERHVawp27GQyG7XsRqmn6J6DUFuJLAws4UCzQQ==
X-Received: by 2002:a05:690c:7005:b0:64a:5493:e0bd with SMTP id
 00721157ae682-6cfbc1a8a0emr40365047b3.40.1724777012771; 
 Tue, 27 Aug 2024 09:43:32 -0700 (PDT)
Received: from fan.. ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6c39a753427sm19658677b3.53.2024.08.27.09.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 09:43:32 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 ira.weiny@intel.com, dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com, nifan.cxl@gmail.com,
 Fan Ni <fan.ni@samsung.com>
Subject: [PATCH 2/2] hw/cxl/cxl_event: Fix interrupt triggering for dynamic
 capacity events grouped via More flag
Date: Tue, 27 Aug 2024 09:40:05 -0700
Message-ID: <20240827164304.88876-3-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827164304.88876-1-nifan.cxl@gmail.com>
References: <20240827164304.88876-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yw1-x1131.google.com
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

When inserting multiple dynamic capacity event records grouped via More flag,
we should only trigger interrupt after the last record is inserted into the
event log. Achieving the goal by letting cxl_event_insert return true only
for the insertion of the last dynamic capacity event record in the sequence.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-events.c         | 8 ++++++++
 include/hw/cxl/cxl_events.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index 12dee2e467..90536c0e68 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -135,6 +135,14 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
     QSIMPLEQ_INSERT_TAIL(&log->events, entry, node);
     cxl_event_set_status(cxlds, log_type, true);
 
+    /*
+     * For dynamic capacity event records grouped via More flag,
+     * Only raise interrupt after inserting the last record in the log.
+     */
+    if (log_type == CXL_EVENT_TYPE_DYNAMIC_CAP) {
+        CXLEventDynamicCapacity *dCap = (CXLEventDynamicCapacity *)event;
+        return (dCap->flags & MORE_FLAG) ? false : true;
+    }
     /* Count went from 0 to 1 */
     return cxl_event_count(log) == 1;
 }
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 38cadaa0f3..b0e5cc89c0 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -170,6 +170,7 @@ typedef struct CXLEventMemoryModule {
  * CXL r3.1 section Table 8-50: Dynamic Capacity Event Record
  * All fields little endian.
  */
+#define MORE_FLAG BIT_MASK(0)
 typedef struct CXLEventDynamicCapacity {
     CXLEventRecordHdr hdr;
     uint8_t type;
-- 
2.43.0


