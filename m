Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6A1C52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 15:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbLsW-0005J7-AZ; Tue, 06 Aug 2024 11:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sbLsU-0005Cd-Kz; Tue, 06 Aug 2024 11:13:34 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sbLsT-0003sH-0E; Tue, 06 Aug 2024 11:13:34 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70eaf5874ddso566814b3a.3; 
 Tue, 06 Aug 2024 08:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722957211; x=1723562011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MgqUijDt5lCxtSfQBPWj/ozXTT40tlDp9fWeVzHLEqc=;
 b=QywTLnR7A65nV1blhO7bj4h0kTqX87SLETu54h5PtFMEvUMnlBTrnrh/wDIHthnw7s
 CYzbxDVCpieH2sKgh7Gw3zYmKhDlPgzjLMgPPK9YEVTqFMHm0ucBiVfG23XL9+aH9e7q
 FD7ileaGTfMXVBjw0PLLCG+FMWGbzmL0mSGil0m7/OsN1uzlwY0RrMOgOMniBZag1WuZ
 7tHfCFD6/fWSPkx6i3q7x9fBxsOsEtVS6hAqKUT6YxF4t/fvzahCXPnPUchDf/yHkvwN
 ycCbNaVp0D7X4BCAzTk50RZrhaBLfAWsQARA5zX4CVgBpVVsKuZisNFaHSpct2w6iAld
 jJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722957211; x=1723562011;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MgqUijDt5lCxtSfQBPWj/ozXTT40tlDp9fWeVzHLEqc=;
 b=EqSsK2eYMljK6OWNQvSNVmlVASAQ4MMaYHdcYnttt8WyyiMyRSLR8u0LgCFtd9KzeZ
 Yi0xutkVSASkeqnmW1JYdnb1ykHeWQcqKmseLF6GtgkVqZcNue/Kt9qFHXmH5pX3yHae
 Q49k6smc6ATlgj8N9D0jmHsEXlTYHPNQcC4E/PV4qAnkOl0MFnF+6iF3YFcQ5fzNYo4E
 e6lMDqatVUppO19SR/P4yTm5SykrttHT8epREcvhUKfWhDIPAnDOSojAZuGCZXWMh/tH
 pgL4yg5dAgpJc9s75ZAuehryAtlJTfuC+UOBiFk7STrtLRQLXoUOYbAWsfR/gwoGeB0u
 aung==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgrLg8JfD/EttVqqp0+oMAGvq6W83EsqO5tl0lGaaHcs6KpnaJ113UUJDV2YI01aMk/ykhfMvJIxIozAS68mqI2xBk6AA=
X-Gm-Message-State: AOJu0Yxz6JlxcGE63OcVUFuteFzJZiAER7hFSQnqT03mb0wHbwaUcO+s
 wFozvulcSEqh/AvfPlZ/DkQj/YEy8DwUl4eCEaZkecffN/8seS+KfyOccg==
X-Google-Smtp-Source: AGHT+IGf2njVI9r6HiWSsRGOOl695hF0GgAIXbvQtTwpOkrNMumP7aFMHfLxAENIfW/TBtU2kYobuQ==
X-Received: by 2002:a05:6a00:22d6:b0:710:5825:5ba0 with SMTP id
 d2e1a72fcca58-7106cf8fc5dmr15956406b3a.3.1722957210583; 
 Tue, 06 Aug 2024 08:13:30 -0700 (PDT)
Received: from wheely.local0.net ([1.145.149.136])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ece493esm7093067b3a.110.2024.08.06.08.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 08:13:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] ppc/pnv: ADU fix possible buffer overrun with invalid size
Date: Wed,  7 Aug 2024 01:13:21 +1000
Message-ID: <20240806151322.284431-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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

The ADU LPC transfer-size field is 7 bits, but the supported sizes for
LPC access via ADU appear to be 1, 2, 4, 8. The data buffer could
overrun if firmware set an invalid size field, so add checks to reject
them with a message.

Reported-by: Cédric Le Goater <clg@redhat.com>
Resolves: Coverity CID 1558830
Fixes: 24bd283bccb33 ("ppc/pnv: Implement ADU access to LPC space")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_adu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ppc/pnv_adu.c b/hw/ppc/pnv_adu.c
index 81b7d6e526..f636dedf79 100644
--- a/hw/ppc/pnv_adu.c
+++ b/hw/ppc/pnv_adu.c
@@ -116,6 +116,12 @@ static void pnv_adu_xscom_write(void *opaque, hwaddr addr, uint64_t val,
             uint32_t lpc_size = lpc_cmd_size(adu);
             uint64_t data = 0;
 
+            if (!is_power_of_2(lpc_size) || lpc_size > sizeof(data)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "ADU: Unsupported LPC access "
+                                               "size:%" PRId32 "\n", lpc_size);
+                break;
+            }
+
             pnv_lpc_opb_read(adu->lpc, lpc_addr, (void *)&data, lpc_size);
 
             /*
@@ -135,6 +141,12 @@ static void pnv_adu_xscom_write(void *opaque, hwaddr addr, uint64_t val,
             uint32_t lpc_size = lpc_cmd_size(adu);
             uint64_t data;
 
+            if (!is_power_of_2(lpc_size) || lpc_size > sizeof(data)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "ADU: Unsupported LPC access "
+                                               "size:%" PRId32 "\n", lpc_size);
+                break;
+            }
+
             data = cpu_to_be64(val) >> ((lpc_addr & 7) * 8); /* See above */
             pnv_lpc_opb_write(adu->lpc, lpc_addr, (void *)&data, lpc_size);
         }
-- 
2.45.2


