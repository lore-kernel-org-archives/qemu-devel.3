Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802F6C5DF88
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 02:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwspx-0001qt-4s; Wed, 19 Aug 2026 22:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwspn-0001pe-FI
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:48:51 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwspk-0000Ku-W9
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:48:51 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-66c7264d87dso972217d50.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 19:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787194128; x=1787798928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d5SVMajj/RGhbWhyTg0fZ5+uybixj+KzUI/M0GlTUuI=;
 b=H35JT8kN+lhcxMUr+LvHwvkBlPCaWtIj5Wi3t9shlTlu9wEGya9Ck8Fo/FWfwjcemN
 a6Xm+Qe8g1d4WmJCtnPc4NCcZsK9uimmrXHkhX5j6odyhgYCveRh3EWBuk+o+2jiGmlG
 Zc+E9st+QXIvTVPyaSlGhXITyps8h4sWunXxXKkGmQB5yoYmBNJRZ5jblx15C8ee4evo
 7LDrsaPrRiUct2QKxwBBUA4YdAlDc3Dp+L0KGoxy+39ENAQEPfYkUEuXdpOOC/YRlLoi
 0C8mAPR21sEXV8rHhjIWAfTTG3KbpO7dW8BvwJK8zAqt8AIIWXYLibGYZg7xPdlNs7Cg
 dzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787194128; x=1787798928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d5SVMajj/RGhbWhyTg0fZ5+uybixj+KzUI/M0GlTUuI=;
 b=bw35P+AtgrjLsBELnTJubwBqdGe5AT3uxMdsK5OQ0+jRcQs4hnRP9RPIHSae1ybGgU
 Ooyz18LtaA7HYKbaNT2f8TUdxkcJcofAWe9JtJ5XedDp4ZXtYLdF9vgoG6+ccv7eKiI3
 t6bTHIqzdYXFvJYEnH3d3vYlUuYoxMV5gJoGKtxHgpAfO03SuIZ3eRCSx9/X0OQ0JDGa
 kk6cH6VpMr3hSO8lvg+PgnU7/IxICZYOCihkZDUmruWAeBzayk35fRe7j3a9WJAhGjze
 HM+3uXAy9AOEYbcIskrZ15axSd1Fz5u/inFhsFE54Kt5fxq/0adVj44NjitM0I44oRzQ
 rCGQ==
X-Gm-Message-State: AFuF++kMPKPJ1/5Q7wLT9Yu/PJ+e+xVlfT2eJzxVce3kGkQXl5dMPqB6
 Vu1/et4j/lBxhpl0V3qY39HXL+LcHmg08siLsimAfH70X1xZduXjSk5GmSLjPQ==
X-Gm-Gg: AR+sD13sxGxh7VDFEbrT9bi/pf5VFC3VZVQTb8FUHuUZuYXtRCY0xbXpqwzcIrf0CGG
 lAv2YMO84/okYE7Bw0vwg1+NnqkmOP030CsZDHkUDzJ+KsQ3NFYnGSz4MwpCf0Dm6QFZtN4mdoF
 x3A5TYFX7xKj/N9aOT5F7DBqB6J3UNmMQII5ir5DDORIxjsE7ztPmJqSHYInp9/+MNH6csqreJR
 cabIM1tKpszrYmKCF0UR5Vj59HD+hetADYtaCZcpl/r1D+JMWv0Sjjtp3QuHxYEnr72jExcxxiM
 kYr4EhEFs1xaQfqAH1I6MkXVM558R5LIz28JDgaT1mZafve6PuSr8cvd0+7oVv4BT8zUp4Kb2uI
 3dE8pmVYlh0hAytUxf33ArQjQI7ZPkyYiG5WUsKjwwzxFU3m23nKMVP4OOXyfh1Jwjr/vGx/f7e
 E0r+PGTDB/FbIWE6eYD1t/MVwmp8OlTfJtzmNWWPWQrzRTcq4Rl8KK6rFL1BLCchGXB1w5QAeBd
 nDUe+BCPX5Pd70rUi0DfpJ2Xu/DRfSzHqmI/U8KdQSrwEHXmgMiHQ==
X-Received: by 2002:a53:c411:0:b0:668:b2a7:a1f1 with SMTP id
 956f58d0204a3-66cd699c797mr937084d50.22.1787194127903; 
 Wed, 19 Aug 2026 19:48:47 -0700 (PDT)
Received: from skippy.localdomain (99-61-67-1.lightspeed.austtx.sbcglobal.net.
 [99.61.67.1]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66ccafd03basm1986454d50.1.2026.08.19.19.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 19:48:47 -0700 (PDT)
From: Kyle Fox <kylefoxaustin.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kyle Fox <kylefoxaustin.github@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH 02/16] hw/arm/boot: let a board preset initrd_start
Date: Wed, 19 Aug 2026 21:48:20 -0500
Message-Id: <20260820024834.3286721-3-kylefoxaustin.github@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
References: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=kylefoxaustin.github@gmail.com; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Allow a board to place the initrd itself (honour a pre-set
info->initrd_start) so a board with a reserved-memory carveout can keep
the initrd clear of it.

Signed-off-by: Kyle Fox <kylefoxaustin.github@gmail.com>
---
 hw/arm/boot.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 9b7553dde5e..4bfb0d8264b 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -997,8 +997,16 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
      * don't tell us their exact size (eg self-decompressing 32-bit kernels)
      * we might still make a bad choice here.
      */
-    info->initrd_start = info->loader_start +
-        MIN(info->ram_size / 2, 128 * MiB);
+    /*
+     * Boards may preset info->initrd_start to force a placement (e.g. to
+     * dodge a guest reserved-memory carveout that happens to sit where the
+     * default heuristic would land the initrd). Only compute a default when
+     * the board left it unset.
+     */
+    if (!info->initrd_start) {
+        info->initrd_start = info->loader_start +
+            MIN(info->ram_size / 2, 128 * MiB);
+    }
     if (image_high_addr) {
         info->initrd_start = MAX(info->initrd_start, image_high_addr);
     }
-- 
2.34.1


