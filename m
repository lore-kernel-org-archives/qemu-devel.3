Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045A9606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=o+NsjKJq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLCh-00081t-Ip; Mon, 26 Oct 2026 09:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLC7-0007Fx-C8; Mon, 26 Oct 2026 09:57:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLC5-0000Ik-4c; Mon, 26 Oct 2026 09:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793022904; bh=Ks4INCfovyo8JCOr5doLNd/IZ2/6vw9Xf8ywnfyq2Go=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=o+NsjKJqDMuaDkpEiMMfjvF5RNnrb24aRDfi5g5IEtfnmm6HILn75gVSa5yHeFY+G
 oJjMCzwa0Rxjb1OSn+IQ9QbX6bUDGZu4y0vtr1EYy1xDX1PUh6ZTpSANmI3863g+oO
 rdsmCgfzSa17iAWwuKSXPAEghd+kSUKjAl/APAMG5T6t3ZQfwgXwz0PMGOA2iICCBW
 doMAv4ZWRNMiSH9C1dFbHNDJNVFtuym+NNxe6ZvXY6ZzBBsAbXMyoDtlzeMbhjtRkR
 EhwGu1CN9ZDKAw7bkQBPeu3TKFqzSgv5mic07H1oZ+sozSAWx2pCSeDDDMkKMT7pq8
 LdjrZrqCetPgg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 044451E1291;
 Mon, 26 Oct 2026 16:55:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0222444B8E0;
 Mon, 26 Oct 2026 16:55:04 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C6D95934B1; Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 v2 91/91] target/ppc: Name the EBB exceptions
Date: Mon, 26 Oct 2026 16:54:34 +0300
Message-ID: <20261026135441.1019505-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

POWERPC_EXCP_PERFM_EBB and POWERPC_EXCP_EXTERNAL_EBB are raised on
POWER8+. With '-d int', powerpc_excp() logs them through
powerpc_excp_name(), which has no entry for them and reaches
g_assert_not_reached(), aborting QEMU. Add their names.

Cc: qemu-stable@nongnu.org
Fixes: cb76bbc43fda ("target/ppc: add PPC_INTERRUPT_EBB and EBB exceptions")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022215115.19680-21-philmd@oss.qualcomm.com>
(cherry picked from commit fe0f4a5a57279c53b57384d402b3ec9f2d51c6c2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index c941c89806e..e6da7fefc5b 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -99,6 +99,8 @@ static const char *powerpc_excp_name(int excp)
     case POWERPC_EXCP_SDOOR_HV: return "SDOOR_HV";
     case POWERPC_EXCP_HVIRT:    return "HVIRT";
     case POWERPC_EXCP_SYSCALL_VECTORED: return "SYSCALL_VECTORED";
+    case POWERPC_EXCP_PERFM_EBB: return "PERFM_EBB";
+    case POWERPC_EXCP_EXTERNAL_EBB: return "EXTERNAL_EBB";
     default:
         g_assert_not_reached();
     }
-- 
2.47.3


