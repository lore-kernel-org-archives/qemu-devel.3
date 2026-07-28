Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEDCC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogyL-0005Te-4b; Tue, 28 Jul 2026 08:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyG-0005Rc-2L
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:44 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyE-00036f-GV
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:43 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so3814890f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 05:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785241901; x=1785846701; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a4dcbC3gNnlrbmKHPiL3tt+ekuDPbeGi+rxaeJ4+ROU=;
 b=pCu87mtY/cnjEJBtX7zfqElKzTmXKJ1n/ORPdLJCLyLWGV/txo6ruDT7irfCPKdG7h
 dX4U8pc/49bCseqnrpLNDYgkpfOlgKKq4Srj8matG3tDGEKXQUG190dhYPJFBnK58b41
 cgznHwN8pMtTrhPeSGdbcP8ODsawwh4+sQg9aOPRbsVOE/cTNztnr3R69p+/N5G4imRf
 jubkfwC73c7jmIpZ89S/mEMDSKsM3nVxHdY+I9G57tpVD22o8DSX9xqN3nVDzk2tVXIq
 8WCtmdyGGafCud8yBwRZJULMHQAkN14IC5NIkwIWSykOR5uocyH3IDXlwaQm4DmlxeZo
 YKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241901; x=1785846701;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a4dcbC3gNnlrbmKHPiL3tt+ekuDPbeGi+rxaeJ4+ROU=;
 b=QdgmWywA3J9xRj09Bn5s3dtJdEKfA+1gOJGjzE4Vl968MZfgjPqqaxz0ImPLLJo2S1
 YV/0RKqlA0VLKFeSsdz0Jk26ozHQtXG6fNsdq1xx4bL/j1oKhlgQat0iyUXEfbyk57om
 gTiF3mdyTx1kykuElJ0WVcTX0l7dh8d78v4M6UEqS+LdKQ4J696PEmxG0mAfiTCeusl6
 mPoFyYriZWO/HCCSWnE2FPIrRAgPxb31j936oDcbBlgkVkFHJCGUG1Xep1ECxFuoRyVJ
 twVSvvdff3RS7pjAajnwS4tJYk9jFwQMkVuzcpstimE4TYRYccBCUfwQJ5jVINDfsSr2
 46kQ==
X-Gm-Message-State: AOJu0YxWRSKj17Q8Y4pkcwW/5uIF1NdGzV5o9BgLpKMMjbIpguJ948/l
 supHQtBFzwJZznXuSrxI7QzSIBlG/qO5Tza5CjJrTEbx3lGhroZxjQIBVEjoMPL9rOHGuecl0Iv
 0LPdy
X-Gm-Gg: AR+sD121ReY9UOMqpbod4gsD+QbQ7RxZ8H/f5VdL/N702sz2URiVJudQbJZRdzrorJS
 dbzhrtgRMc4CufY3exZ9OBtw5k7OX3qeghlKVy1i1MiDl16nFZPt9M8JnPDTAIFrQ8t1q0uGnkO
 zcxRBIl9JVsUP5fz0acCrS4H5s2Ss6wKEUIIAPfbp39r1Od0ycMOauaKOj6a5ivKkW14tHZfHOG
 i0dT+SsL2B5Md62AdOX0w//xQfv4WA6JeeUyK5ayjEdK4QUwwbAy8qtc3AqsleHNjRVvhxe93v9
 k3AvedoARmINgMTaXU0GXFfPUTBHXhQn8X2cWi1TLIv0FGcIqJe3iNs+aTwnrcdTCN+dRzD/nqU
 ymmg014IDF5NZnFgLt1c5iJa9ccxXo44g8mtHBVQUvmV1zU44RT4BJek3rdgwsFTPxKX9xPlktw
 JcFobmcMU5T8G3Et9gvDbLuk22QhdO5PRV0FAcUuJNDuj4i7+BRDH6MKRtWJaC9c1kl7cE3hlwK
 dnRO+MWgnY=
X-Received: by 2002:a05:6000:240d:b0:47f:928e:21f7 with SMTP id
 ffacd0b85a97d-47fb1ef25a6mr2766787f8f.55.1785241900853; 
 Tue, 28 Jul 2026 05:31:40 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6f076sm58499039f8f.34.2026.07.28.05.31.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:31:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/20] hw/net/flexcan: Drop oversized 'mb[]' mailbox view
Date: Tue, 28 Jul 2026 13:31:18 +0100
Message-ID: <20260728123127.1711653-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728123127.1711653-1-peter.maydell@linaro.org>
References: <20260728123127.1711653-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Bernhard Beschow <shentey@gmail.com>

As indicated in the comments, the `mb[]` a.k.a. `mbs []` views should
cover 0x400 (1024) bytes. However, the `mb[]` array covers four times
the size since `sizeof(FlexcanRegsMessageBuffer)` returns the size in
bytes instead of counting the number of uint32_t fields. This shifts the
subsequent register offsets by 0xc00 which is not intended. Fix the size
and thus the offsets by dropping the now unused `mb[]` view.

Note that the different size changes the migration layout. Since the device
model is new, no change in the version fields is needed.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260723070059.6332-8-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/flexcan.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/hw/net/flexcan.h b/include/hw/net/flexcan.h
index d8159475e04..9affdff8372 100644
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
2.43.0


