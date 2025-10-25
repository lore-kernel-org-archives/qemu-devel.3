Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E6ACCF9E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 16:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCgzM-0004qr-FP; Sat, 25 Oct 2025 12:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vCgzJ-0004pz-PY
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:19:29 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vCgzI-0004Dd-9l
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:19:29 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 92AE76062F;
 Sat, 25 Oct 2025 16:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B814C4CEFB;
 Sat, 25 Oct 2025 16:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761409167;
 bh=GPTk92lJwbojCe8hBLFK6GeymG8+vX2OkUA6Ug6fO/c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jVQVe37vXbvX6sPDUqiiOSAZegSGPn0Ipbh2wUW2LLWv7JGEdnQsXq8cBc+yU2Kxm
 9RTz1BMNtRSG491jpgFy3Tov6RjdhEbRk26luBmOQ1X7n7DRtYY+PXGEj9qBkZkj8/
 52v5bw35LqhNJOjkA2ZXILh7+2nhg47qj9K1gAEk4OncMNI6y3vnRbMM9fd7FUAWhr
 MCByKjtCLSNh2SmhvgeUXKAILPNLQgSVAtqk5obSv/uOwkUzt6mfoDs7Smgf7/LxyW
 NZShEu/P3qmq7/kp2DrgCSFWpqWDk1kOX0I+F8yr+Xb79AFzq8WNzyn+i+G1IyXrGE
 oS9tN/nd0WbKw==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 10/11] hw/hppa: Require SeaBIOS version 19 for 715 machine
Date: Sat, 25 Oct 2025 18:19:00 +0200
Message-ID: <20251025161901.32710-11-deller@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025161901.32710-1-deller@kernel.org>
References: <20251025161901.32710-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Require at least SeaBIOS version 19 before adding the 715 machine.  This is
required, because the machine inventory of the 715 is provided by the SeaBIOS
firmware.

Signed-off-by: Helge Deller <deller@gmx.de>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/hppa/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 31eeba72b4..81ed050b5e 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -43,7 +43,7 @@ struct HppaMachineState {
     MachineState parent_obj;
 };
 
-#define MIN_SEABIOS_HPPA_VERSION 12 /* require at least this fw version */
+#define MIN_SEABIOS_HPPA_VERSION 19 /* require at least this fw version */
 
 #define HPA_POWER_BUTTON        (FIRMWARE_END - 0x10)
 static hwaddr soft_power_reg;
-- 
2.51.0


