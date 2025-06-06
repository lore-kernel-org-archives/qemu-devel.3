Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF198C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 09:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNTpu-0004hz-B0; Fri, 06 Jun 2025 05:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1uNTpr-0004hn-4p
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:58:03 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1uNTpo-0005wn-1P
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:58:02 -0400
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
 by Atcsqr.andestech.com with ESMTPS id 5569vhDH058237
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Jun 2025 17:57:43 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from atcpcw16.andestech.com (10.0.1.106) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 6 Jun 2025
 17:57:43 +0800
To: <qemu-devel@nongnu.org>
CC: <qemu-trivial@nongnu.org>, <richard.henderson@linaro.org>,
 <pbonzini@redhat.com>, Ethan Chen <ethan84@andestech.com>
Subject: [PATCH] qemu-options.hx: Fix reversed description of icount sleep
 behavior
Date: Fri, 6 Jun 2025 17:57:28 +0800
Message-ID: <20250606095728.3672832-1-ethan84@andestech.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.1.106]
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 5569vhDH058237
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, PDS_RDNS_DYNAMIC_FP=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The documentation for the -icount option incorrectly describes the behavior
of the sleep suboption. Based on the actual implementation and system
behavior, the effects of sleep=on and sleep=off were inadvertently reversed.
This commit updates the description to reflect their intended functionality.

Signed-off-by: Ethan Chen <ethan84@andestech.com>
---
 qemu-options.hx | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 7eb8e02b4b..1f862b19a6 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4936,13 +4936,13 @@ SRST
     with actual performance.
 
     When the virtual cpu is sleeping, the virtual time will advance at
-    default speed unless ``sleep=on`` is specified. With
-    ``sleep=on``, the virtual time will jump to the next timer
+    default speed unless ``sleep=off`` is specified. With
+    ``sleep=off``, the virtual time will jump to the next timer
     deadline instantly whenever the virtual cpu goes to sleep mode and
     will not advance if no timer is enabled. This behavior gives
     deterministic execution times from the guest point of view.
-    The default if icount is enabled is ``sleep=off``.
-    ``sleep=on`` cannot be used together with either ``shift=auto``
+    The default if icount is enabled is ``sleep=on``.
+    ``sleep=off`` cannot be used together with either ``shift=auto``
     or ``align=on``.
 
     ``align=on`` will activate the delay algorithm which will try to
-- 
2.34.1


