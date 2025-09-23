Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4965FCAC5AE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 14:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1487-000366-DY; Tue, 23 Sep 2025 10:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1v147y-00033X-Ka
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 10:36:24 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1v147v-0002nN-Uo
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 10:36:21 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D9659442E3;
 Tue, 23 Sep 2025 14:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EDCC113CF;
 Tue, 23 Sep 2025 14:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758638175;
 bh=9auIKoebOATipv+LsapWaUr2Od/3MQw86GYQvAsRfh4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E/3vCWxr7uejcoOsxW1Q9uqGaSvz61f4cEr9doTWms+t/Z4KRkOYQkrPVaF/PYwXX
 8P5xd1LxExIig+mQh8mHLUzJXmp4Jmikr8+oXOaaXEJKLWRYeIHT2jcn9QoUWZErlU
 Y062kTQDLgqnvBmWjjvXHJghkUUPiTlCSiVV9ubD8/x7MqMwU9xff2rMz8+ryjF0aZ
 1QyRI5xGGforADJU7ftU78B1YblU39ll2CWLTfFdQTppOenyWBJQsJ5HQLz6Nn0p4q
 JVr+hxJ3EEQO0AkXIsKVfsJM3pFtABi2sylPy/11QTPlpT8n1AivzKj8/HCosiwbYv
 HMEoD4eZmshcQ==
From: Huacai Chen <chenhuacai@kernel.org>
To: Bibo Mao <maobibo@loongson.cn>,
	Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, WANG Xuerui <git@xen0n.name>,
 qemu-devel@nongnu.org, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH 1/3] bios-tables-test-allowed-diff.h: Allow LoongArch DSDT.*
Date: Tue, 23 Sep 2025 22:35:40 +0800
Message-ID: <20250923143542.2391576-2-chenhuacai@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923143542.2391576-1-chenhuacai@kernel.org>
References: <20250923143542.2391576-1-chenhuacai@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=chenhuacai@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

Signed-off-by: Huacai Chen <chenhuacai@kernel.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..2ed837faee 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,5 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/loongarch64/virt/DSDT",
+"tests/data/acpi/loongarch64/virt/DSDT.memhp",
+"tests/data/acpi/loongarch64/virt/DSDT.numamem",
+"tests/data/acpi/loongarch64/virt/DSDT.topology",
-- 
2.47.3


