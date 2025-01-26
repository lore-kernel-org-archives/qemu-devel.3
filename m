Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFDCC02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 11:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc13g-0006qh-Ms; Sun, 26 Jan 2025 06:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tc13M-0006il-Kp; Sun, 26 Jan 2025 06:43:49 -0500
Received: from out203-205-221-233.mail.qq.com ([203.205.221.233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tc13J-0000rL-St; Sun, 26 Jan 2025 06:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1737891796; bh=SGuCtHP2wIGnIRB/ebsPc462WzrpPSsQAk6sUNIN27U=;
 h=From:To:Cc:Subject:Date;
 b=G7UYaZFx/NnOfXsJ3MWt7zUOpwSqAfr7Lmnf5FIbH7RreVCe5oFZjtLrVyz8mnN41
 bV9MHcB/P4lDPN1MZVhsVverstqhnyVk2eMO8fCZ+5aCXbKt1aPTDgGMopVPMaskQU
 ZuF8SzSUOf4uD7YlNGcXk4PXepg23feoAK+SZ2fY=
Received: from qq.com ([171.213.183.53])
 by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
 id ACDB2857; Sun, 26 Jan 2025 19:43:13 +0800
X-QQ-mid: xmsmtpt1737891793thhs5g8ew
Message-ID: <tencent_033217F7900714A999352724A7790C3F0007@qq.com>
X-QQ-XMAILINFO: MZtEYADUG4Ag1NtHGjbzsiOPOGZ4dUoJ/D39B8U0Yr5wNdi23JkzaenR+f94mr
 ifqN/l5F7lMxAxJl7u3MKdsR2qhMmDGdpTS0dbcbWC/h9YJQkj/W+mYSz1ofeXijUy+g1XulYNB/
 02kENn/hFsfLB3U6b6Ia8dF/+Pe3AzMUGB/0Yy/GmcqzXxf4WQzpxi9GsGT/FokRzTSYnhF3xj6e
 mrk7THKYPuqFO1ZQXMW/IUSTT4l0U5ShdZbcZUjBxTlOqdrylVyiqWEZbbErbZnFi2aM12ZIrS+f
 KE1SR0kzsByALXqBjqMjm/pT6xvat8T0YW0S2WIpcdu1nvyvsXUCk/6y2+6TSg1RKthYPboomqtW
 7Il+LTHTV5dnvACKLo4fOjy+zrEVaYUczKr8DLdkFE5yvG8PmSW/DBeMVf24BpUPxd3Z10rw02CS
 ej5N/0CVaw5HwzGB7hPwIm96RiLJCg1vmTfUx9obkmngGrn8BIb1ccSceU4It6R50PPHc9Rs0hI5
 7D0AIR6W4JkYCaHdc626KNj8Dxq6y3G8C5cZKGVRXlumWq3Lzf3OG4uY+a7Cutd86aMXgqgxD6Z8
 oEn+rTDbFQSpVLWAsbdfGVhFkCsM4snPQjHkMHAOz6+f5xQtlY2B25WeeKEsFO6VTTy5lT/gv3B5
 SQ1vUo2lnCUYpsEIgFy1mWm5K7WcwgcW9LRVV0udUI2QUDVpgYJCqvQi3XggJfCjm+midIB3IXGp
 egyuvpPv4TRbkVpBemxpf5hwKA3J96b6Qa6CfJaag9BfQ022XX6yt0aJjv+aYVkj5mD1z/2CPtZh
 HBos6rwlwBQ+tdLgHLd/0cbZJ6SnoZQvwFyOAWf80sFfHE9oA4+RTc8AgJe0CeN4JtYrujIFC+WY
 rLJx19IvVEI38xyTe+COUI1jUPMOgYlUxl/j4yPBzkRCbRZELrX1XgWdlxLBHwZCiB5SKii3s8eX
 FNahekw08zJDlo2F3Y8EIxzm8ZYoMJYzL7QI8DTBhgOL6qeYitIu9IeRFK8cM6
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Yanfeng Liu <yfliu2008@qq.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, alistair.francis@wdc.com,
 Yanfeng Liu <p-liuyanfeng9@xiaomi.com>, Yanfeng Liu <yfliu2008@qq.com>
Subject: [PATCH] arm/cpu: revises cortex-r5
Date: Sun, 26 Jan 2025 19:43:03 +0800
X-OQ-MSGID: <20250126114303.3488-1-yfliu2008@qq.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.233; envelope-from=yfliu2008@qq.com;
 helo=out203-205-221-233.mail.qq.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Yanfeng Liu <p-liuyanfeng9@xiaomi.com>

This enables generic timer feature for Cortex-R5 so that to support guests
like NuttX RTOS.

Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
---
 target/arm/tcg/cpu32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 2ad2182525..5d68d515b4 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -590,9 +590,10 @@ static void cortex_r5_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V7MP);
     set_feature(&cpu->env, ARM_FEATURE_PMSA);
     set_feature(&cpu->env, ARM_FEATURE_PMU);
+    set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     cpu->midr = 0x411fc153; /* r1p3 */
     cpu->isar.id_pfr0 = 0x0131;
-    cpu->isar.id_pfr1 = 0x001;
+    cpu->isar.id_pfr1 = 0x10001;
     cpu->isar.id_dfr0 = 0x010400;
     cpu->id_afr0 = 0x0;
     cpu->isar.id_mmfr0 = 0x0210030;
-- 
2.34.1


