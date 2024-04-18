Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61414C04FF8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 23:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxbDg-0003hJ-Vj; Thu, 18 Apr 2024 19:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rxbDM-0003AQ-V0
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 19:30:58 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rxbDI-0005wA-7J
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 19:30:47 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6ed0e9ccca1so1465490b3a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 16:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713483042; x=1714087842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KdtJQ2//BvaL+ED8X5UWARoz6dYMy43pJ3SbcFIRv9I=;
 b=EgH+/cmaSFRkdqukNxTET0//HAFZdb90phY+af7ut5dy8syHxw/gAps1mOEr4tPMOP
 hzmUDnaCTCW4D5V+wc4nHBJKloyyKhhmYukpQdqw0mmAEpwMGT5ZS9OVM+YXgZHpuieU
 2qFISI+StyInxG2uXbvpe0P5wtrl//EkYRyFqWcXZSJFKGI4WBz8TOfwLUKv1QNn6uyr
 Dmra5yDTYz5tnfZoTdiaSkO6dYpahh2qXTRmnwaq+VvkA6GbYXEU5/3epqaWoKgbe+X7
 brHZk/X629B7RzrbDZmhVx6y9EXmAHrVQZSo0WLxxmG+9UA1xvNYN7bvZRdcfqHBtQ6x
 5Cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713483042; x=1714087842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KdtJQ2//BvaL+ED8X5UWARoz6dYMy43pJ3SbcFIRv9I=;
 b=cuNRzSLstxUZ6lqW/Kzv2SGWjE0HR78qeAMnY6C0NhHmwxt3rCXwLnS7jc5kSUJL3G
 srb6MuYVEfOVn6C3ua5zYLUjXcJxjz+e8AU4g71vne452SbX1W6BovA40LN6iC4YDLDS
 JO6MuAzH0XXSS82p6+9mGBp9z3hWKynIxVM16QejhQ0YCl3DY/YHVz6OMet5Gjhor1IQ
 DOxXdfSC57ZLmfGCahNJpWeHJewgPpultdTQCPXOS5P9nWf3Hj6cOYPY1CM3pPKMM9KQ
 +XV8+3mhHaupiLJ//MfTBK35iTYKfiCBRiX3TWleM/e+YXkvhu/UW1RWsrlZt6PP3y+x
 VNbA==
X-Gm-Message-State: AOJu0Yyx80UKbHrbrU99K4EO4Nmug3RuxgPgzooL62iM6TT7RKMVexSA
 Kdw4MgzyppfRHG0GjLFczXXwXPsPxNyGeYVGB7cyA1g9fW09+ELIi+KiCQ==
X-Google-Smtp-Source: AGHT+IHGuUAdd1A/hFHKB74AL5T6aGZ9tFOxeEB/HZhO5eI3UqC99l2TIAslMMUB9EHdcx6813y6bg==
X-Received: by 2002:a62:81c6:0:b0:6f0:c78f:75e1 with SMTP id
 t189-20020a6281c6000000b006f0c78f75e1mr498855pfd.0.1713483041813; 
 Thu, 18 Apr 2024 16:30:41 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:ed8b:f40f:7543:e9ea])
 by smtp.gmail.com with ESMTPSA id
 h3-20020a056a00230300b006e6be006637sm2040783pfh.135.2024.04.18.16.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 16:30:41 -0700 (PDT)
From: nifan.cxl@gmail.com
X-Google-Original-From: fan.ni@samsung.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v7 12/12] hw/mem/cxl_type3: Allow to release extent superset
 in QMP interface
Date: Thu, 18 Apr 2024 16:11:03 -0700
Message-ID: <20240418232902.583744-13-fan.ni@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418232902.583744-1-fan.ni@samsung.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Fan Ni <fan.ni@samsung.com>

Before the change, the QMP interface used for add/release DC extents
only allows to release an extent whose DPA range is contained by a single
accepted extent in the device.

With the change, we relax the constraints.  As long as the DPA range of
the extent is covered by accepted extents, we allow the release.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index a3e1a5de25..9e725647f1 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1941,7 +1941,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
                            "cannot release extent with pending DPA range");
                 return;
             }
-            if (!cxl_extents_contains_dpa_range(&dcd->dc.extents, dpa, len)) {
+            if (!ct3_test_region_block_backed(dcd, dpa, len)) {
                 error_setg(errp,
                            "cannot release extent with non-existing DPA range");
                 return;
-- 
2.43.0


