Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81582C02191
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcQ1F-0007Xa-Nz; Mon, 27 Jan 2025 09:23:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcQ1D-0007LO-Pm; Mon, 27 Jan 2025 09:23:15 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcQ1B-0002uK-Od; Mon, 27 Jan 2025 09:23:15 -0500
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by isrv.corpit.ru (Postfix) with ESMTP id D9A7DE0F51;
 Mon, 27 Jan 2025 17:22:47 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 7E2C651D82; Mon, 27 Jan 2025 17:18:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Han Han <hhan@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.1 15/41] target/i386/cpu: Fix notes for CPU models
Date: Mon, 27 Jan 2025 17:17:29 +0300
Message-Id: <20250127141803.3514882-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
References: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Han Han <hhan@redhat.com>

Fixes: 644e3c5d812 ("missing vmx features for Skylake-Server and Cascadelake-Server")
Signed-off-by: Han Han <hhan@redhat.com>
Reviewed-by: Chenyi Qiang <chenyi.qiang@intel.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit 93dcc9390e5ad0696ae7e9b7b3a5b08c2d1b6de6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3725dbbc4b..aff5e917db 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3691,6 +3691,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 4,
+                .note = "IBRS, EPT switching, no TSX",
                 .props = (PropValue[]) {
                     { "vmx-eptp-switching", "on" },
                     { /* end of list */ }
@@ -3825,7 +3826,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
               },
             },
             { .version = 4,
-              .note = "ARCH_CAPABILITIES, no TSX",
+              .note = "ARCH_CAPABILITIES, EPT switching, no TSX",
               .props = (PropValue[]) {
                   { "vmx-eptp-switching", "on" },
                   { /* end of list */ }
-- 
2.39.5


