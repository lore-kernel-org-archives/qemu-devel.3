Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43518C44524
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmnRV-00024s-Nh; Thu, 23 Jul 2026 03:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmnRL-0001xi-1O
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:01:57 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmnRJ-00043h-Fv
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:01:54 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso1803285e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 00:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784790110; x=1785394910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZQzdmXPKS/GCfPOIlcxRtVIw5smE1l62zCnawYTu9wM=;
 b=fPx8JMC1Q5rWnof/5IQIAx/b94ljAJQNZ7sjZe4V5gecz7B5eCJhf4i4dxcNHHNs6C
 JqobpU3h0dUMUKRgeo5aWOZ+3kiEa4PLpaBx0kygSzSvkp92/oYYLtsgbfi3UNvn+645
 1JzCrFIJxZrhytz/WRNVv7VGOc4aMHvkJskd4eU6TbyudOHCLMzOFci2CjfAmwKpGyOE
 NNt036QbD4pwEBVnVtYnN0p6KcLnYUjzzkbd7RbOKHD2xCwLW3jBP7yzv/OqX0W7JQIW
 xr8qihmBNUIKNmgesmj6waChbTXXrCU2J90X/XqxlW5znzNlaxiIfOBTN4yvt/Pcf9oI
 Zarg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784790110; x=1785394910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZQzdmXPKS/GCfPOIlcxRtVIw5smE1l62zCnawYTu9wM=;
 b=h9YkUcJgM893u1uyv6Ua0gy37P1tUQ75xmWpAYOw6x/78UbOPt6yo1+qdBenv7E+II
 bOeJGDzqYuLRZQETV8QG1n14YxLnoMAIex6GdX2szbjaYE+crtwCYBqox010pwuNVHqI
 R4Gtvf09GGOqQnIBeBtmmykGFmFa3M8nCriFAGZKrQqlPZkJ6e88xJVGH7IikIZ1WtvI
 ewH9XhZVlDPfWB3cTp3Psqhv6PbMyMorSjd1HJoGPigD2JWapJQQk8i3ZqfrQZiHmUHS
 RzDwHsQ2WoWfSQU5+9SLnx5mL7SrD79Kt/1yoVzo2AY/VBLWxy8r6RaebmaYvtnavAkH
 +rZQ==
X-Gm-Message-State: AOJu0YxXyqjwDAwsBP2Lb4725BXUsxcf3BX3Cvl3q1xiuMrXrfWAtkJx
 4e/3tFKMDO6F9KdBUbFIQn5X+5ZWp26xbGvrouArQLh9GBIo3MmPRq0MINHeMCui
X-Gm-Gg: AR+sD12tD3y22BZDZQl5FT2fPbq3G4arqDz8H8PF/0H2st824gwiIlPkUbrLCJj5QRG
 o1f/c2CiMOXSTkfmTOmQJhRPuDUma1tgL2QnfGaYgdGDLzfto2txdXjLNlsSxOC8JV8lzFpba1h
 9talyGNMa/OWRGK2emU/Es8H36qrLWOgBvV5jPJxboR9+RTOUG+9RxsnK1zm59ZgcgIP7B2vf+0
 N9K5oNe/L+luzSu7sWn6veimGEkhhHda4X2496pF5nGoyY2axTM8sNV7+t1BwCKG0BUomoPUCfY
 4hDVs6etBErJmw0k5whAr6zMHLSVQPeIU3Q+2tyTv7CKS9J9MtN+2C9sR95U4kepl9D02rP9VkY
 X9fauRqBegfMZ7ZKxRlwa1RBzDkGt2IX+Ln27s4Qe7M9bS4yKSH1uwLov52bQtleFebOMNmswpv
 jg2cZa+Jy2hSGQ9fEocVDCmR3IsImhTiNWEhkk1dbHsoJZcx6aEV2pjzbbWk2iFmv+pLKH1SxZC
 F3tyFNAxivSnXUum78W+DNGypkrn1A5ltz9
X-Received: by 2002:a05:600c:4747:b0:495:737a:7afe with SMTP id
 5b1f17b1804b1-49573cd3fa3mr23151215e9.15.1784790109832; 
 Thu, 23 Jul 2026 00:01:49 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-29ed-6000-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:29ed:6000:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6dc25sm13293923f8f.33.2026.07.23.00.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 00:01:49 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Matyas Bobek <matyas.bobek@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 7/9] hw/net/flexcan: Drop oversized 'mb[]' mailbox view
Date: Thu, 23 Jul 2026 09:00:57 +0200
Message-ID: <20260723070059.6332-8-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723070059.6332-1-shentey@gmail.com>
References: <20260723070059.6332-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

As indicated in the comments, the `mb[]` a.k.a. `mbs []` views should
cover 0x400 (1024) bytes. However, the `mb[]` array covers four times
the size since `sizeof(FlexcanRegsMessageBuffer)` returns the size in
bytes instead of counting the number of uint32_t fields. This shifts the
subsequent register offsets by 0xc00 which is not intended. Fix the size
and thus the offsets by dropping the now unused `mb[]` view.

Note that the different size changes the migration layout. Since the device
model is new, no change in the version fields is needed.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/net/flexcan.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/hw/net/flexcan.h b/include/hw/net/flexcan.h
index d8159475e0..9affdff837 100644
--- a/include/hw/net/flexcan.h
+++ b/include/hw/net/flexcan.h
@@ -65,10 +65,8 @@ typedef struct FlexcanRegs {
     uint32_t dbg1;               /* 0x58, unused */
     uint32_t dbg2;               /* 0x5C, unused */
     uint32_t _reserved3[8];      /* 0x60 */
-    union {                      /* 0x80 - not affected by soft reset */
-        uint32_t mb[sizeof(FlexcanRegsMessageBuffer) * FLEXCAN_MAILBOX_COUNT];
-        FlexcanRegsMessageBuffer mbs[FLEXCAN_MAILBOX_COUNT];
-    };
+    /* 0x80 - not affected by soft reset */
+    FlexcanRegsMessageBuffer mbs[FLEXCAN_MAILBOX_COUNT];
     uint32_t _reserved4[256];    /* 0x480 */
     uint32_t rximr[64];          /* 0x880 - not affected by soft reset */
     uint32_t _reserved5[24];     /* 0x980 */
-- 
2.55.0


