Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A774CC54F30
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 09:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJ7uU-00016p-8K; Sun, 25 May 2025 05:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJ7uA-0000s4-Bc; Sun, 25 May 2025 05:44:30 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJ7u8-0004lX-DT; Sun, 25 May 2025 05:44:30 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DBEDB124DEC;
 Sun, 25 May 2025 12:42:47 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C0844215F14;
 Sun, 25 May 2025 12:42:48 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.4 58/62] qapi/misc-target: Fix the doc to distinguish
 query-sgx and query-sgx-capabilities
Date: Sun, 25 May 2025 12:42:41 +0300
Message-Id: <20250525094246.174612-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.4-20250525112803@cover.tls.msk.ru>
References: <qemu-stable-9.2.4-20250525112803@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Zhao Liu <zhao1.liu@intel.com>

There're 2 QMP commands: query-sgx and query-sgx-capabilities, but
their outputs are very similar and the documentation lacks clear
differentiation.

From the codes, query-sgx is used to gather guest's SGX capabilities
(including SGX related CPUIDs and EPC sections' size, in SGXInfo), and
if guest doesn't have SGX, then QEMU will report the error message.

On the other hand, query-sgx-capabilities is used to gather host's SGX
capabilities (descripted by SGXInfo as well). And if host doesn't
support SGX, then QEMU will also report the error message.

Considering that SGXInfo is already documented and both these 2 commands
have enough error messages (for the exception case in their codes).

Therefore the QAPI documentation for these two commands only needs to
emphasize that one of them applies to the guest and the other to the
host.

Fix their documentation to reflect this difference.

Reported-by: Markus Armbruster <armbru@redhat.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/r/20250513143131.2008078-3-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 7f2131c35c1781ca41c62dc26fd93282e1351323)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 8d70bd24d8..827515c363 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -380,7 +380,7 @@
 ##
 # @query-sgx:
 #
-# Returns information about SGX
+# Returns information about configured SGX capabilities of guest
 #
 # Returns: @SGXInfo
 #
@@ -399,7 +399,7 @@
 ##
 # @query-sgx-capabilities:
 #
-# Returns information from host SGX capabilities
+# Returns information about SGX capabilities of host
 #
 # Returns: @SGXInfo
 #
-- 
2.39.5


