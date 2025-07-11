Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25C1C83F22
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua97G-0004Sm-1T; Fri, 11 Jul 2025 04:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8yd-0006TE-OQ; Fri, 11 Jul 2025 04:19:28 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8yb-0004IW-AC; Fri, 11 Jul 2025 04:19:26 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 780C01356DE;
 Fri, 11 Jul 2025 11:17:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6456623FA53;
 Fri, 11 Jul 2025 11:17:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Xin Li (Intel)" <xin@zytor.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 19/39] target/i386: Remove FRED dependency on WRMSRNS
Date: Fri, 11 Jul 2025 11:16:15 +0300
Message-ID: <20250711081745.1785806-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: "Xin Li (Intel)" <xin@zytor.com>

WRMSRNS doesn't become a required feature for FERD, and Linux has
removed the dependency, as such remove it from Qemu.

Cc: qemu-stable@nongnu.org
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250103084827.1820007-2-xin@zytor.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 0b901459a87a7fdbed36e574aae33e0635a3e9af)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5e12cba1b8..2c9517f56d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1774,10 +1774,6 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_LKGS },
         .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
     },
-    {
-        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_WRMSRNS },
-        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
-    },
     {
         .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_SGX },
         .to = { FEAT_7_0_ECX,               CPUID_7_0_ECX_SGX_LC },
-- 
2.47.2


