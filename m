Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F48AC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 13:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdUl3-0004v2-2N; Mon, 12 Aug 2024 09:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sdUkw-0004UW-2q
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 09:06:38 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sdUkq-00047L-6B
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 09:06:34 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52f04b4abdcso6139668e87.2
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 06:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723467989; x=1724072789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nhh0TpUXfvKDYo1bINWU88Yt0WNYvGv2suBFZ023AEo=;
 b=G2lbuzbam7tX6vYa+0ZCX/4EvfB5G5PgZCkTBGXJHTxx0ozA0LpOvzD34uokSxtNuc
 K3ZlUzLVM8kb2/16fGACw9H/v4lHA50sr5liGWDKEpaI2SomL92YePVSboN4eCuYLzAD
 qqNYgzFLmbU9ZRQLia7IfLf5SGmIbiIvBG14ph/O1Zf4WrXFh4y+KRJd8HqUiZFrs7gP
 Y+Cz0tqzOv5wxvaVD7iwFROwlcNoF6yRS/H/OQrW1zjObbpICdR2dWiNyL7jeXjNrZAR
 Q3pCNq+7HUTQHwDcWXEb9T2AWaqqPpvbDeZ50Fs60wDeOXYO4AXcbuxNxfd4rXYpZVKX
 cYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723467989; x=1724072789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nhh0TpUXfvKDYo1bINWU88Yt0WNYvGv2suBFZ023AEo=;
 b=L/bV3WrqzSZp+sCaf4q/POqfIA6XYDrJZ9QbKHyFecTJBmc7YafSiEs+uDtGJl2qEZ
 R9b7doPJxR1wYewjDggRLSace25bq+sfdoHZsCqcgCviGpSylGbcwJZOBn7Icfo00hJd
 cF3IJ/+l+Nxet9EFQRlU6pn6SZJxIDT9MiAZ3Yotecg0ju2YXc4sPwkti5e1W2ZkjJTO
 Xsx/2RgftRydfBged3/+gJHfhJAaMsL09wyJRuepivyupcYNgXGE5t/dLHUS3b2kL4i9
 Z4Gb6c6lsJj6Sea8T1zK9vD9hUPBKL8e+SzdMKWQRa/l+UEnI5okrepKadU2Di7rvIi2
 XXnQ==
X-Gm-Message-State: AOJu0Yxsoej8uYM+DZcL7dPyQpViT5ATpevyh755OGMC68UQT7V2Tuqm
 DCxMLKpf42BREU8t4foYx5F7UNlR5upYVbrVv4bMvOxAn+vCUgn5eKu+CP+u
X-Google-Smtp-Source: AGHT+IHSkZQghDr6Glb8JEvdreF6qFC+N2jFtbTRBNglrKRLKqDk7xPj3u/onfFEY6yEqggs5c2vsg==
X-Received: by 2002:a05:6512:1296:b0:52c:dfa0:dca0 with SMTP id
 2adb3069b0e04-53213693c31mr31960e87.43.1723467988154; 
 Mon, 12 Aug 2024 06:06:28 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53200f1ac89sm734534e87.184.2024.08.12.06.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 06:06:25 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v1 07/10] hw/arm: xenpvh: Reverse virtio-mmio creation order
Date: Mon, 12 Aug 2024 15:06:02 +0200
Message-ID: <20240812130606.90410-8-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812130606.90410-1-edgar.iglesias@gmail.com>
References: <20240812130606.90410-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x134.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

We've been creating the virtio-mmio devices in forwards order
but since the qbus lists prepend (rather than append) entries,
the virtio busses end up with decreasing base address order.

Xen enables virtio-mmio nodes in forwards order so there's been
a missmatch. So far, we've been working around this with an
out-of-tree patch to Xen.

This reverses the order making sure the virtio busses end up
ordered with increasing base addresses avoiding the need to
patch Xen.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/xen/xen-pvh-common.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index 0d368398d0..69a2dbdb6d 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -73,7 +73,18 @@ static void xen_create_virtio_mmio_devices(XenPVHCommonState *s)
 {
     int i;
 
-    for (i = 0; i < s->cfg.virtio_mmio_num; i++) {
+    /*
+     * We create the transports in reverse order. Since qbus_realize()
+     * prepends (not appends) new child buses, the decrementing loop below will
+     * create a list of virtio-mmio buses with increasing base addresses.
+     *
+     * When a -device option is processed from the command line,
+     * qbus_find_recursive() picks the next free virtio-mmio bus in forwards
+     * order.
+     *
+     * This is what the Xen tools expect.
+     */
+    for (i = s->cfg.virtio_mmio_num - 1; i >= 0; i--) {
         hwaddr base = s->cfg.virtio_mmio.base + i * s->cfg.virtio_mmio.size;
         qemu_irq irq = qemu_allocate_irq(xen_set_irq, NULL,
                                          s->cfg.virtio_mmio_irq_base + i);
-- 
2.43.0


