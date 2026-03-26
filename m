Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6188210A88E0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 16:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5nA8-0005WV-C4; Thu, 26 Mar 2026 12:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chan9yan9@gmail.com>)
 id 1w5mcb-0002tF-Ev
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 11:27:45 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chan9yan9@gmail.com>)
 id 1w5mcY-0005wd-Ux
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 11:27:45 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-829a9d08644so594209b3a.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 08:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774538861; x=1775143661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L/XOeeZJbH562gwsN3ZvedpHu8ETHOSgikP+7Qk+gTY=;
 b=mt8scnIwOqXzAh2Yl8IunTQnTcjlLVqS8PgXIzRHjvVONrPnutijGjRUbPtzQCzB9A
 1vjBF59nwTqx3bsstZmMG5jougl0r+kGMDTx6gGGX3i8KBEuEQP5Q6CyCDCdgLiNzDJ6
 yrPzexo/Me2mponq6ZSM3hljX0hzIMcRqwe5LVeTNwQVL2+Lg66VZqWhRJ7ZJppCaeNZ
 sqIPTgrXJpy/CHu5P3f3DcSjGAL8LtCKUbg4gfx7EK3O78TU3Wa23yJQYiexCotgswsV
 JjzDnDdDv8MpnWeirIZjr5U8UycDfMwzNOxvi8eVV8LBgDMAB1LHagJ3QeLqZ1+7fHmi
 PtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774538861; x=1775143661;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L/XOeeZJbH562gwsN3ZvedpHu8ETHOSgikP+7Qk+gTY=;
 b=UoRHLErYXCyrrYy2OeJj8c/nUYOPjzhYZpn8sBIwu523ziIqG9KplsGglI9akc/s53
 iN36l9PGB1lI4SJQ4+2AXYQ3GBmWjV8z77yZ4P7kvk0LxyHL5LT3YyV96pq1rkbQ8eZQ
 e+ljfYNFKVGhq0cklwBcEMSwG0Bp+RvvExK4gm58iP/4jHvMHq8ZIxiSpopP7XEUYHzJ
 M3FFd78Vre3Rc86R4PbynjoAj9UZTnG5xNPrVspxL2hO3WG2OOaxEvS8MRQlK4euHy//
 MTZowVDZdOiB12OQVS5cXZOyeAiBCJ2SmpkdVrwmgjDU0YXCjt72ziR9itXvCV11Si34
 bekA==
X-Gm-Message-State: AOJu0YzPnoQpFhNEjnWziL1Q3HWp1mtHwYJz+Zfo69OO0lXEV7zrquaM
 QeDRJAOmw60XCQ9zQIHzFGo+CgbSo4z2q8C2FeeivfyeP0TybBGr4xeVcwtn26sQOrmQSw==
X-Gm-Gg: ATEYQzzgfuy+L0X56R587jDzlVM72t5ncwjR2EMxHwLStalC/ClijfiNBqhFIDDV/HS
 oSgoN5I68UxQNY9h5BFQtzhQjB3SvBdEu++yUE/zT/5d0Nmnnk7/rL8NcZYMduVCc9c8qhkxaJ/
 taZjBEm/lgMm18UaeiHs+rwZuamqsKugEAf2SxNWWvv+9pZTG7tNlG1FpqRwlPbXxqr3LlOkGwJ
 hQQJfjVDcQj4ey/il8IyA0bMUTFEhb/EoB0BLNYoRvnm98l8xvWesGkcU084iwcOJJNxIERNBxz
 jhSy9FY4fvYQwNRZa/vI+YIXKqcfmY6F0Q9tcB/V5JJqyofH8TKGh9e96gdVf46YBj6UQBxrp1T
 eqE/908cvJPLAsJuNCiPjZA2gjf28RO5LQOi02Y3H66cj4JrTDyO/+uANvNcNObJXtV8a0AwDXw
 FjDsO7XiThcr+gaZ4TcArga+EwrRNNGBFXblLZ7Zm8
X-Received: by 2002:a05:6a00:a21e:b0:82c:249d:d84f with SMTP id
 d2e1a72fcca58-82c6df87c4bmr7286991b3a.37.1774538861326; 
 Thu, 26 Mar 2026 08:27:41 -0700 (PDT)
Received: from localhost.localdomain ([36.33.26.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7d3f76e3sm3136924b3a.52.2026.03.26.08.27.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 08:27:40 -0700 (PDT)
From: Zexiang Zhang <chan9yan9@gmail.com>
To: qemu-devel@nongnu.org
Cc: adityag@linux.ibm.com, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-ppc@nongnu.org (open list:sPAPR (pseries)),
 kiki <Chan9Yan9@gmail.com>, Zexiang Zhang <chan9yan9@gmail.com>
Subject: [PATCH] As reported in qemu-project/qemu#3324
Date: Thu, 26 Mar 2026 23:27:33 +0800
Message-Id: <20260326152733.344926-1-chan9yan9@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=chan9yan9@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 26 Mar 2026 12:02:08 -0400
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

From: kiki <Chan9Yan9@gmail.com>

A malformed IVE value can result in an invalid server field being
passed to icp_irq(). The function assumes the server id is valid and
may access invalid state otherwise, potentially leading to a crash.

Fix this by validating the server id before using it and ignoring
invalid values.

Reported-by: Zexiang Zhang <chan9yan9@gmail.com>
Signed-off-by: Zexiang Zhang <chan9yan9@gmail.com>
---
 hw/intc/xics.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 1d40c4386d..25c7b0c8a5 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -222,6 +222,13 @@ void icp_irq(ICSState *ics, int server, int nr, uint8_t priority)
 
     trace_xics_icp_irq(server, nr, priority);
 
+    if (!icp) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XICS: invalid server %d for IRQ 0x%x\n",
+                      server, nr);
+        ics_reject(ics, nr);
+        return;
+    }
+
     if ((priority >= CPPR(icp))
         || (XISR(icp) && (icp->pending_priority <= priority))) {
         ics_reject(ics, nr);
-- 
2.34.1


