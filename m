Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10301C07C79
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 14:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryv18-00054Q-K6; Mon, 22 Apr 2024 10:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1rypxf-0000wS-EQ
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 05:27:43 -0400
Received: from out-180.mta1.migadu.com ([2001:41d0:203:375::b4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1rypxc-0000mB-5v
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 05:27:43 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1713778055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Co44Q9mlr4zNsi4wNMbg2xr+Hkh3wz3o/Kg+Jwyh0d4=;
 b=jCfpUiFTGUPXPYsp3pm3Ur6ev6kvmfoiYjjLuoCshXsFTzZ3APSPHDYHcs1KGuvM5BL0iW
 7aAzgJsJ9ebxp9++NZG/L5IrT4RJefIR2W2pZ6UopAdmIvUcqyP7ak3IYCYAWHTf1G0ATZ
 7vOqqujywPWxxJsaA+Zm3RxdJ7Srduk=
From: Zenghui Yu <zenghui.yu@linux.dev>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, wanghaibin.wang@huawei.com,
 Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH] hvf: arm: Remove PL1_WRITE_MASK
Date: Mon, 22 Apr 2024 17:27:15 +0800
Message-Id: <20240422092715.71973-1-zenghui.yu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::b4;
 envelope-from=zenghui.yu@linux.dev; helo=out-180.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 22 Apr 2024 10:51:35 -0400
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

As it had never been used since the first commit a1477da3ddeb ("hvf: Add
Apple Silicon support").

Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
---
 target/arm/hvf/hvf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 65a5601804..015e96a6d3 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -150,7 +150,6 @@ void hvf_arm_init_debug(void)
 
 #define HVF_SYSREG(crn, crm, op0, op1, op2) \
         ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP, crn, crm, op0, op1, op2)
-#define PL1_WRITE_MASK 0x4
 
 #define SYSREG_OP0_SHIFT      20
 #define SYSREG_OP0_MASK       0x3
-- 
2.34.1


