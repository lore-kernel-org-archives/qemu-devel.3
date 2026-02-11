Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7C0ECD6C3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 16:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqCke-0002pl-So; Wed, 11 Feb 2026 11:07:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1vqCXl-0007DC-6H
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:54:21 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1vqCXj-0003Pk-1F
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:54:20 -0500
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.59])
 by linux.microsoft.com (Postfix) with ESMTPSA id F266C20B7168;
 Wed, 11 Feb 2026 07:54:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F266C20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1770825257;
 bh=Vs8TfYEFZWl0Kw+1FaZkTbpkVSYR/jFdpRr5z4bKU6o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SEADzxsr5ex2AT9kb2p1Hi+OzePBSDhTqYCmiXcfMxH0VnUCXsZ2ZAAEFDeAOf2Cc
 oTM19kF8NcqFKxMGvHRt8Cx9Km3Xhs69zcTRyzXa0I7o5zyN0Na433/7yyKOqs5em0
 FzTSE3di64/gXhE9yEv3bUtXYldvJFBDlmf20V5o=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>
Subject: [PATCH 01/10] MAINTAINERS: fix magnuskulke email-address
Date: Wed, 11 Feb 2026 16:54:01 +0100
Message-Id: <20260211155410.203883-2-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
References: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Feb 2026 11:07:29 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Consolidating email aliases.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 29f88d48f3..6272d32ed4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -569,7 +569,7 @@ F: accel/stubs/whpx-stub.c
 F: include/system/whpx.h
 
 MSHV
-M: Magnus Kulke <magnus.kulke@linux.microsoft.com>
+M: Magnus Kulke <magnuskulke@linux.microsoft.com>
 R: Wei Liu <wei.liu@kernel.org>
 S: Supported
 F: accel/mshv/
@@ -578,7 +578,7 @@ F: include/hw/hyperv/hvgdk*.h
 F: include/hw/hyperv/hvhdk*.h
 
 X86 MSHV CPUs
-M: Magnus Kulke <magnus.kulke@linux.microsoft.com>
+M: Magnus Kulke <magnuskulke@linux.microsoft.com>
 R: Wei Liu <wei.liu@kernel.org>
 S: Supported
 F: target/i386/mshv/
-- 
2.34.1


