Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67174C54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 16:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sizI8-00020N-W4; Tue, 27 Aug 2024 12:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sizI6-0001z0-5n
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 12:43:34 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sizI4-0002bA-Ob
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 12:43:33 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-69483a97848so55295467b3.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 09:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724777011; x=1725381811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SwvM3S9SiHQZGwR6Xphu333GyFIzsUCvHKvo/gM3elM=;
 b=D+r6bASty3JSqkizulYox+0NlZKXkWWnW+N953amK8DjoOyLrcI2/gP+8nL32uKTRf
 dEumlN5wPtcJGr1K6x3rxCih4b9SxuJUhyCBZteCFCVLL4iVKCPpmTzUbM9TySSvMh9W
 Q6WZ9cyLF4bk4D1ikiOtK5fE8ZZC9EmtbtuxdkZBvc7gBFQCS5bEnTa5P5ot3DcUfGtF
 C+pBkz7wVcCSWvmiVWtmY6UR1lk4BmftpKVCUwW38RJzsUmDyUlBuhuzOOBs2+wS0dHn
 NnmY+YuIo6CdhhcuCrtDrppZGpHuM9vHiy8X+FUM76CBSOkZ50EU5Ak/yGuC4c9fW5ns
 9krA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724777011; x=1725381811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SwvM3S9SiHQZGwR6Xphu333GyFIzsUCvHKvo/gM3elM=;
 b=hig581t2UfHsk0OQPKGANW1ElCz6jD6qXxrBUz3+jVZROiA2KSqeNnluykJfHXRxpq
 4whVwvlwb2xVxugh6lC8AupFkUlE5zCRm7UlfdOQBPRHH9ueEES5B6qNspnawIlwXC3X
 rs8V0bdEDHv4xaY0bF322ALaVVF+7vyrShbZlYLnPQu2QDgpSyf0e8QqSj2FQuL2yjEd
 ihgXowPJV4V+LxuXy9s97BqGcsodxrQZrMgREAG8duFbnAj1McFabxcBYWxQ0mS5inWM
 MsNfE9hSP3/k2temEAqcxoowlNFc6UcdFEmEfxx4f5+yi/n0bX2WwmLRn2sqjPpi8Uq4
 8CfA==
X-Gm-Message-State: AOJu0YwbF/vbr91hTAbgNHxI8CSa3y0P2D7UF6IMh8v1yFF16fy/YYpM
 PDAa85tTNuaGoUBoDjm3j46OdGvtFAl8oPNfeoe+CjDQbVpx9XzY4e5I8g==
X-Google-Smtp-Source: AGHT+IEQC25v7IZbO2OCFRpYtIyH6n2S/Ki0r5sn8cq1TjaJ4jl9KoxzebkxMgz4IGMf6hByZNYfxg==
X-Received: by 2002:a05:690c:38b:b0:6c7:a120:e10f with SMTP id
 00721157ae682-6cfbbbd4c68mr36358247b3.29.1724777011572; 
 Tue, 27 Aug 2024 09:43:31 -0700 (PDT)
Received: from fan.. ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6c39a753427sm19658677b3.53.2024.08.27.09.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 09:43:31 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 ira.weiny@intel.com, dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com, nifan.cxl@gmail.com,
 Fan Ni <fan.ni@samsung.com>
Subject: [PATCH 1/2] hw/mem/cxl_type3: Fix More flag setting for dynamic
 capacity event records
Date: Tue, 27 Aug 2024 09:40:04 -0700
Message-ID: <20240827164304.88876-2-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827164304.88876-1-nifan.cxl@gmail.com>
References: <20240827164304.88876-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yw1-x1132.google.com
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

Per cxl spec r3.1, for multiple dynamic capacity event records grouped via
the More flag, the last record in the sequence should clear the More flag.

Before the change, the More flag of the event record is cleared before
the loop of inserting records into the event log, which will leave the flag
always set once it is set in the loop.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index d648192ab9..e616801c81 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2060,11 +2060,11 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
     stw_le_p(&dCap.host_id, hid);
     /* only valid for DC_REGION_CONFIG_UPDATED event */
     dCap.updated_region_id = 0;
-    dCap.flags = 0;
     for (i = 0; i < num_extents; i++) {
         memcpy(&dCap.dynamic_capacity_extent, &extents[i],
                sizeof(CXLDCExtentRaw));
 
+        dCap.flags = 0;
         if (i < num_extents - 1) {
             /* Set "More" flag */
             dCap.flags |= BIT(0);
-- 
2.43.0


