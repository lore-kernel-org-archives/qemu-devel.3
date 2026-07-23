Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A753DC531D2
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 12:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmshQ-0000i2-WC; Thu, 23 Jul 2026 08:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhouyanjing@open-hieco.net>)
 id 1wms5w-0004bb-W6
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:00:09 -0400
Received: from [115.124.28.113] (helo=out28-113.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhouyanjing@open-hieco.net>)
 id 1wms5n-00024s-BC
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:00:08 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.09242918|-1;
 BR=01201311R901S49rulernew998_84748_2000303; CH=blue; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0103836-0.00598067-0.983636;
 FP=7486460455884130774|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033037071049;
 MF=zhouyanjing@open-hieco.net; NM=1; PH=DS; RN=2; RT=2; SR=0;
 TI=SMTPD_---.iTBeEln_1784807548; 
Received: from hygon.hygon.cn(mailfrom:zhouyanjing@open-hieco.net
 fp:SMTPD_---.iTBeEln_1784807548 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 23 Jul 2026 19:52:31 +0800
From: Yanjing Zhou <zhouyanjing@open-hieco.net>
To: qemu-devel@nongnu.org
Cc: Yanjing Zhou <zhouyanjing@open-hieco.net>
Subject: [PATCH 1/2] target/i386: Add missing cpu feature bits in Dhyana model
Date: Thu, 23 Jul 2026 11:52:19 +0000
Message-Id: <20260723115220.258924-2-zhouyanjing@open-hieco.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723115220.258924-1-zhouyanjing@open-hieco.net>
References: <20260723115220.258924-1-zhouyanjing@open-hieco.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.113 (deferred)
Received-SPF: pass client-ip=115.124.28.113;
 envelope-from=zhouyanjing@open-hieco.net; helo=out28-113.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Jul 2026 08:38:50 -0400
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

Add the missing features(perfctr-core, clzero, xsaveerptr, aes,
pclmulqdq, sha-ni) for Dhyana model

Signed-off-by: Yanjing Zhou <zhouyanjing@open-hieco.net>
---
 target/i386/cpu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5805d33ab9..0ce5bdad38 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6754,6 +6754,19 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                   { /* end of list */ }
               },
             },
+            { .version = 3,
+              .props = (PropValue[]) {
+                  { "perfctr-core", "on" },
+                  { "clzero", "on" },
+                  { "xsaveerptr", "on" },
+                  { "aes", "on" },
+                  { "pclmulqdq", "on" },
+                  { "sha-ni", "on" },
+                  { "model-id",
+                      "Hygon Dhyana-v3 processor" },
+                  { /* end of list */ }
+              },
+            },
             { /* end of list */ }
         }
     },
-- 
2.34.1


