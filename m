Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97CAC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 03:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5HF1-0005oe-1W; Thu, 09 May 2024 23:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <inspiremenow@murena.io>)
 id 1s5HEv-0005mh-HY
 for qemu-devel@nongnu.org; Thu, 09 May 2024 23:48:11 -0400
Received: from mail2.ecloud.global ([135.181.6.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <inspiremenow@murena.io>)
 id 1s5HEn-0000H8-De
 for qemu-devel@nongnu.org; Thu, 09 May 2024 23:48:04 -0400
Received: from authenticated-user (mail2.ecloud.global [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail2.ecloud.global (Postfix) with ESMTPSA id BC2E77209E6;
 Fri, 10 May 2024 03:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io; s=mail2;
 t=1715312874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z65wjwDgprkqeJhsXJkstYfG5OFuHaoHMGv1y04PTA0=;
 b=P6LNaq8M00d60vfZZvBygUCZ5uBiIl0m5pvvIvBnGa5wyHonoLQH8P0bCvHGhxbdu91dYD
 IB1Td5aFPtccc7cpbOinkJrN7op+MXPiJ45FT8rdefXEKP1t7uG6b7kzybcS017Es9QWT4
 EqUk+ACoo1I74cN//1xVqnNP/he5Zq4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io;
 s=mail2; t=1715312874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z65wjwDgprkqeJhsXJkstYfG5OFuHaoHMGv1y04PTA0=;
 b=uB8GPsre7U9XywFgachXUxz/FVxXaUGUf77SP24PYds/cfOuN94xJTxyxJaJbl3xnmdYPi
 d4qGjS9hGB5gmEXRoEprFmGowIQ1SbinK5uW/q6lLXR2hpBGtRJHRrnf8hTor8H/nhRT3X
 wmtjpM93kei9BEljXiTZmjs4epl5KJs=
ARC-Authentication-Results: i=1; mail2.ecloud.global;
 auth=pass smtp.mailfrom=inspiremenow@murena.io
ARC-Seal: i=1; s=mail2; d=murena.io; t=1715312874; a=rsa-sha256; cv=none;
 b=P9SbaieDWcKJnyBzqFfrhWzw/isOuGghrHjlfwHGGGPNXOEesuLZ3AlmVX/iYSdoCG/6GI
 i/mHJwauhPunK2LNQIJBuRNmeLf41kdQK2zMBbVjgbeSk1LYnCF2L8uMJJ8d3J+aeYKM3v
 EXx7qzBxvDUdP2QUfPPymvonVgPnu4A=
From: inspireMeNow <inspiremenow@murena.io>
To: qemu-devel@nongnu.org
Cc: inspireMeNow <inspiremenow@murena.io>
Subject: [PATCH] fix: correct typo in ext_zvkb configuration variable
 Signed-off-by: Kaiyao Duan <inspiremenow@murena.io>
Date: Fri, 10 May 2024 11:47:42 +0800
Message-ID: <20240510034747.116408-1-inspiremenow@murena.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=135.181.6.248;
 envelope-from=inspiremenow@murena.io; helo=mail2.ecloud.global
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

---
 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index eb1a2e7d6d..13cd34adbd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1535,7 +1535,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Vector cryptography extensions */
     MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
     MULTI_EXT_CFG_BOOL("zvbc", ext_zvbc, false),
-    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkg, false),
+    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkb, false),
     MULTI_EXT_CFG_BOOL("zvkg", ext_zvkg, false),
     MULTI_EXT_CFG_BOOL("zvkned", ext_zvkned, false),
     MULTI_EXT_CFG_BOOL("zvknha", ext_zvknha, false),
-- 
2.45.0


