Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAE7D74ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 13:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjHKF-0007Rm-63; Fri, 23 Jan 2026 08:35:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHKA-0007Pk-Rn
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:35:42 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHK9-0004bq-5o
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:35:42 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 625EA439B0;
 Fri, 23 Jan 2026 13:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBF9C4CEF1;
 Fri, 23 Jan 2026 13:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769175339;
 bh=sd653Y2rU5G+bYEE/aPjX1oO73LmrPWtAi5iMJ7NkWg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=onV0A+kfCPRbkw39BzPJQTl44HmOKoJsxxOq9TLmjxSu+oSsZsqY+YZ8E0iIkwj27
 jbRNTMerLvIlZTMtXFko9dnf26uUXcio7EQfFTEkeI7tUh15v3eVYiD8KpB+O08mNi
 hHjknTDDW3OlSMxEEBPx8Na3psVd9BPf8x6KZdHE1VjF2+l1B3kYdZspfKSrBDzUHy
 Boj+wBd1UxAMDN+6lal9y/Zf+ljz6rK1j1y6qgOhn8+8VibVuJgDG+F/4YZ7z+gbjL
 NVwQ8Nm8p6TZlYotvxMbX5yOMs7Gf5beeFiPajfCi15nFgZC9sh/q+ZpUEvSaUFH2q
 b5L3pQXd/EIbA==
Received: from localhost ([::1]) by mail.kernel.org with esmtp (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHK5-000000063Jc-0f8V; Fri, 23 Jan 2026 14:35:37 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 02/13] scripts/qmp_helper: add missing CXL UEFI GUID
Date: Fri, 23 Jan 2026 14:35:16 +0100
Message-ID: <a1dde4d9549539af805ac171a5ed76c8fd859acf.1769175069.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769175069.git.mchehab+huawei@kernel.org>
References: <cover.1769175069.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

The UEFI 2.11 - N.2.14. CXL Component Events Section states that
CXL events are described at CXL specification 3.2:
        8.2.10.2.1 Event Records
	Table 8-55. Common Event Record Format

Add the GUIDs defined here to fuzzy logic error injection code.

It should be noticed that, while the section states that:

	"This section defines the standard event record format
	 that all CXL devices shall use when reporting events
	 to the host."

And the field at byte offset 0 has all the GUIDs below, in practice,
not all those events will reach the OSPM, as some are fabric
management events and OS management flows for dynamic capacity.

Yet, it is easier to keep the table in sync with the specs than to
filter them out and justify why they won't need within CPER scope.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/qmp_helper.py | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
index 249a8c7187d1..46b85d68b793 100755
--- a/scripts/qmp_helper.py
+++ b/scripts/qmp_helper.py
@@ -711,3 +711,33 @@ class cper_guid:
     CPER_CXL_PROT_ERR = guid(0x80B9EFB4, 0x52B5, 0x4DE3,
                              [0xA7, 0x77, 0x68, 0x78,
                               0x4B, 0x77, 0x10, 0x48])
+
+    # CXL GUIDs, as defined at CXL specification 3.2: 8.2.10.2.1 Event Records
+    # on Table 8-55. Common Event Record Format
+    #
+    # Please notice that, in practice, not all those events will be passed
+    # to OSPM. Some may be consumed internally
+    CPER_CXL_EVT_GEN_MEDIA = guid(0xFBCD0A77, 0xC260, 0x417F,
+                                  [0x85, 0xA9, 0x08, 0x8B,
+                                   0x16, 0x21, 0xEB, 0xA6])
+    CPER_CXL_EVT_DRAM = guid(0x601DCBB3, 0x9C06, 0x4EAB,
+                             [0xB8, 0xAF, 0x4E, 0x9B,
+                              0xFB, 0x5C, 0x96, 0x24])
+    CPER_CXL_EVT_MEM_MODULE = guid(0xFE927475, 0xDD59, 0x4339,
+                                   [0xA5, 0x86, 0x79, 0xBA,
+                                    0xB1, 0x13, 0xBC, 0x74])
+    CPER_CXL_EVT_MEM_SPARING = guid(0xE71F3A40, 0x2D29, 0x4092,
+                                    [0x8A, 0x39, 0x4D, 0x1C,
+                                     0x96, 0x6C, 0x7C, 0x65])
+    CPER_CXL_EVT_PHY_SW = guid(0x77CF9271, 0x9C02, 0x470B,
+                               [0x9F, 0xE4, 0xBC, 0x7B,
+                                0x75, 0xF2, 0xDA, 0x97])
+    CPER_CXL_EVT_VIRT_SW = guid(0x40D26425, 0x3396, 0x4C4D,
+                                [0xA5, 0xDA, 0x3D, 0x47,
+                                  0x2A, 0x63, 0xAF, 0x25])
+    CPER_CXL_EVT_MLD_PORT = guid(0x8DC44363, 0x0C96, 0x4710,
+                                 [0xB7, 0xBF, 0x04, 0xBB,
+                                  0x99, 0x53, 0x4C, 0x3F])
+    CPER_CXL_EVT_DYNA_CAP = guid(0xCA95AFA7, 0xF183, 0x4018,
+                                 [0x8C, 0x2F, 0x95, 0x26,
+                                  0x8E, 0x10, 0x1A, 0x2A])
-- 
2.52.0


