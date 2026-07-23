Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E34C531CF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 12:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmshQ-0000gm-E2; Thu, 23 Jul 2026 08:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhouyanjing@open-hieco.net>)
 id 1wms5u-0004b8-NW
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:00:06 -0400
Received: from [115.124.28.134] (helo=out28-134.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhouyanjing@open-hieco.net>)
 id 1wms5m-00025r-Kg
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:00:06 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.09881236|-1;
 BR=01201311R151S79rulernew998_84748_2000303; CH=blue; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.00101707-0.000509398-0.998474;
 FP=7472399827131411921|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033045213054;
 MF=zhouyanjing@open-hieco.net; NM=1; PH=DS; RN=2; RT=2; SR=0;
 TI=SMTPD_---.iTBeEg-_1784807542; 
Received: from hygon.hygon.cn(mailfrom:zhouyanjing@open-hieco.net
 fp:SMTPD_---.iTBeEg-_1784807542 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 23 Jul 2026 19:52:28 +0800
From: Yanjing Zhou <zhouyanjing@open-hieco.net>
To: qemu-devel@nongnu.org
Cc: Yanjing Zhou <zhouyanjing@open-hieco.net>
Subject: [PATCH 0/2] target/i386: Add missing features for Hygon Dhyana and
 support for Dharma
Date: Thu, 23 Jul 2026 11:52:18 +0000
Message-Id: <20260723115220.258924-1-zhouyanjing@open-hieco.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.134 (deferred)
Received-SPF: pass client-ip=115.124.28.134;
 envelope-from=zhouyanjing@open-hieco.net; helo=out28-134.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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

This series adds missing CPU feature bits for the Hygon Dhyana model and
introduces support for the new Hygon Dharma CPU model.

Patch 1 adds several features that were previously missing on the Dhyana
model:
  - perfctr-core, clzero, xsaveerptr, aes, pclmulqdq, sha-ni

Patch 2 adds the Dharma CPU model (2nd Gen Hygon Processor) with the
following additional features compared to Dhyana:
  - stibp, ibrs, umip, ssbd
  - Full cache information (L1/L2/L3) and proper CPUID topology

Yanjing Zhou (2):
  target/i386: Add missing cpu feature bits in Dhyana model
  target/i386: Add support for Hygon Dharma CPU model

 target/i386/cpu.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

-- 
2.34.1


