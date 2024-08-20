Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD92C5321E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgPt5-0002mZ-7i; Tue, 20 Aug 2024 10:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sgPsN-00022U-Oe
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:30:27 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sgPsF-0001th-6x
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:30:20 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52f04c29588so7503457e87.3
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 07:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724164211; x=1724769011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nn/Mzsj0J8g/Mphb+PXQ5WHUtYUEk9GjObY40SBe48s=;
 b=Z2y1vSo1A6E0u2OOPo+l4R5TknKNT8PwHNF4rW9kKh9uEIzVkzDXA6Zx3aJz5qFgj1
 qFl2koRwTv2CAfVYzNqgKFMwuUgvdWQVsgiQrrQ41NIC9IGeXstBm7oi8KLXXwgo6Cqj
 q78zrXHRgP4VUj8CBLesMwTbbNvtQBtREFHDroZmdBzZvsY0tezPuKzrjz3nToIJsqMh
 QJpavwbnIPmwqKqOt4ziYYNUtVGL8uY1pktycmG2vXqruUlLZCjv23uJDMPl0ITLoNfM
 XmRL4cA9eKv0S3/iR0z8JOFaMYofL1MKY52G8XhesqheyivQk0exBnYdGX8MTRTQh0Nr
 6c7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724164211; x=1724769011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nn/Mzsj0J8g/Mphb+PXQ5WHUtYUEk9GjObY40SBe48s=;
 b=AgoS/NYUSqNTf7V/LpMNJsUHVjvscKIjnN84hDkUZYoMgh3ifTZItlfoArHT1TTLi7
 lzSs53lScB/gK0AMFnlHAmjwlStaFjxyuJHMXwk2Fp7K5c53Rva91ikNPc7FR5gFNjix
 P9e3GLDOl/7WeS7HiFRJ0He8MHE6cimS3oHLTdBK7tbWvN7MNM0DGRzSZPpRkveNBGAm
 qzZ8Sv+Bg2+pdhMyKveZFu2eMnJEg5qNiLPt5g6QiTWDzko7gdLtbwOmSmyYIyNBUyVq
 rMsNZKREh0lvgncRmXuSn7AGdv2E7lVX3HBBa+fBD6HfyM3r7hPUWbQQ4GvwiGu1ldlE
 wPyg==
X-Gm-Message-State: AOJu0YzmSBIS24IHuULB4TKmz+BhBZNhg19yZ7CCeijwRmZh84gTT59Z
 qunUW/w9vOV/tmO+wyTJf92C9fqmkmQOnajixcsjA2TH2LdGd+aVsW9li7Nn
X-Google-Smtp-Source: AGHT+IFotZ4Ec+2t7CYxqYEsIJgRWw4/u9z0FOKI55M7uGGokh/ts3s1WXBedzrQkXbLGgZ+ZDCasA==
X-Received: by 2002:a05:6512:3a90:b0:52f:d15f:d46b with SMTP id
 2adb3069b0e04-5331c696aefmr9419582e87.14.1724164210397; 
 Tue, 20 Aug 2024 07:30:10 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5330d420bc6sm1791128e87.241.2024.08.20.07.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 07:30:09 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v2 09/12] hw/arm: xenpvh: Reverse virtio-mmio creation order
Date: Tue, 20 Aug 2024 16:29:46 +0200
Message-ID: <20240820142949.533381-10-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820142949.533381-1-edgar.iglesias@gmail.com>
References: <20240820142949.533381-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/xen/xen-pvh-common.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index 880e8143d7..295f920442 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -75,7 +75,18 @@ static void xen_create_virtio_mmio_devices(XenPVHMachineState *s)
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


