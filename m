Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03C4E95372
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vna27-0005QH-Rg; Wed, 04 Feb 2026 05:22:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1vna25-0005PO-Ih; Wed, 04 Feb 2026 05:22:49 -0500
Received: from mxhk.zte.com.cn ([160.30.148.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1vna22-0001BO-3w; Wed, 04 Feb 2026 05:22:49 -0500
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4f5byP2r48z8Xs6y;
 Wed, 04 Feb 2026 18:22:37 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
 by mse-fl1.zte.com.cn with SMTP id 614AMPgM060083;
 Wed, 4 Feb 2026 18:22:25 +0800 (+08)
 (envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp02[null]) by mapi (Zmail) with MAPI id mid32;
 Wed, 4 Feb 2026 18:22:28 +0800 (CST)
X-Zmail-TransId: 2afa69831de4815-8d8c3
X-Mailer: Zmail v1.0
Message-ID: <202602041822284131BM90xnixL5L-cl6Z0HHj@zte.com.cn>
In-Reply-To: <20260204182041057hohVHgmaAJborE1DrghXH@zte.com.cn>
References: 20260204182041057hohVHgmaAJborE1DrghXH@zte.com.cn
Date: Wed, 4 Feb 2026 18:22:28 +0800 (CST)
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <imammedo@redhat.com>, <alistair.francis@wdc.com>,
 <dbarboza@ventanamicro.com>, <sunilvl@ventanamicro.com>,
 <anisinha@redhat.com>
Cc: <pbonzini@redhat.com>, <palmer@dabbelt.com>, <liwei1518@gmail.com>,
 <zhiwei_liu@linux.alibaba.com>, <mst@redhat.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>, <liu.xuemei1@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHY1IDEvNF0gdGVzdHMvYWNwaTogdmlydDogYWxsb3cgRFNEVCBhY3BpIHRhYmxlIGNoYW5nZXM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 614AMPgM060083
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: liu.xuemei1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Wed, 04 Feb 2026 18:22:37 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69831DED.000/4f5byP2r48z8Xs6y
Received-SPF: pass client-ip=160.30.148.35;
 envelope-from=liu.xuemei1@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: Xuemei Liu <liu.xuemei1@zte.com.cn>

Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..8e85fcdee9 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/riscv64/virt/DSDT",
-- 
2.27.0

