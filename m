Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E11ED12689
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 23:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQZT3-0005Qw-R6; Tue, 02 Dec 2025 18:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asb@igalia.com>) id 1vQZSw-0005Pi-OT
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 18:07:26 -0500
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asb@igalia.com>) id 1vQZSu-0005a2-Iz
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 18:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lqiYRejEYBLv6Tq9eu8J7y3F8sRHZgkSQrLLqz3fkRQ=; b=JdKCpWw9HW1pA34H/ayx1HwE0V
 Psxf/PYJZ6/a6waHF1EwBLURnZJotLo6bWQr6hsakHUTfW3+m6ez11hhjjP8iFb1LhVlgvac+d1Oa
 UC9hxdguQDR5X5Mi3bp5AB75ecfFPVYCwm0oV6BsOk0h7A+wMiTCisZ/qI/0yeqcpQpvRHjZ3OkqG
 wMY/a1AktwCYD6MD0XN2WTTN2gVUeomIpAw6ORUsD32NWUKTMcwgFEZEqIQidWS9Pc3/eBQcJ5fbA
 uGgECNXOFNg07Xlbi8YAbRayXaF0HiPYjdhEeRzFvJBdymWpA0/PCMQAS5pNCkDEZDt3j4Xv3gxqs
 YEPS6tvw==;
Received: from 82-69-92-151.dsl.in-addr.zen.co.uk ([82.69.92.151]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vQZSs-0082ga-55; Wed, 03 Dec 2025 00:07:22 +0100
From: Alex Bradbury <asb@igalia.com>
To: qemu-devel@nongnu.org
Cc: Alex Bradbury <asb@igalia.com>, alex.bennee@linaro.org, erdnaxe@crans.org,
 ma.mandourr@gmail.com, pierrick.bouvier@linaro.org
Subject: [PATCH v2 4/5] docs/about/emulation: Add documentation for hotblocks
 plugin arguments
Date: Tue,  2 Dec 2025 23:05:57 +0000
Message-ID: <60f1ad20663f7e5c6cb00dd83fe0f1f5aa6ca4de.1764716538.git.asb@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764716538.git.asb@igalia.com>
References: <cover.1764716538.git.asb@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.97.179.56; envelope-from=asb@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Currently just 'inline'.

Signed-off-by: Alex Bradbury <asb@igalia.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/about/emulation.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 4a7d1f4178..543efc4d7d 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -463,6 +463,16 @@ Example::
   0x000000004002b0, 1, 4, 66087
   ...
 
+Behaviour can be tweaked with the following arguments:
+
+.. list-table:: Hot Blocks plugin arguments
+  :widths: 20 80
+  :header-rows: 1
+
+  * - Option
+    - Description
+  * - inline=true|false
+    - Use faster inline addition of a single counter.
 
 Hot Pages
 .........
-- 
2.52.0


