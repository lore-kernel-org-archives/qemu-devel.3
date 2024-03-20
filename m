Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8862ED0C604
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2024 00:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4r6u-0004QA-AF; Sat, 26 Oct 2024 20:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1t4r6q-0004Pj-85; Sat, 26 Oct 2024 20:26:20 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1t4r6i-0000Qi-Ri; Sat, 26 Oct 2024 20:26:18 -0400
DKIM-Signature: a=rsa-sha256; bh=95Oh/9TpmbwSPW17BHYDufz1qjnqaX1OBSnZ7k01J98=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1729988769; v=1;
 b=k/XMewttdvTeclYPz1lgVsANWMOTj+AhufBob119cWLpcLxvb85aIKwsWXRpKGAeHMY1g0n4
 hUXVLIVbPJZiE+Sg4VZk8Y9aZz7PYTaqJWr7nXE0wv0P8Iq2YRzUsGJjBQo1H3nDWt9vHIqkpsc
 grF0FpRlP5JyzOcIXuZQI4X1/ty0048zAmFFQXqxklhStPwWQFIJcxGMDZzpBzf4u5v2PqLgxWj
 p4zdq2GHg1QsGTa/+kyxu7tcLOMGvYi109efv3sugMXWsRTSt9JRHJRNoUCkfEpgEViVOEpVFT5
 XOjrI8mcah9Ii6hGPD1nQ7JNuhKCZx9n52F9SwRR8Pkpg==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 0261C200D2;
 Sun, 27 Oct 2024 00:26:09 +0000 (UTC)
From: ~axelheider <axelheider@git.sr.ht>
Date: Wed, 20 Mar 2024 09:31:40 +0000
Subject: [PATCH qemu.git 1/1] hw/intc/sifive_plic: add const qualifier to
 signature
Message-ID: <172998876893.15131.3277963343932581039-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <172998876893.15131.3277963343932581039-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 38
X-Spam_score: 3.8
X-Spam_bar: +++
X-Spam_report: (3.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, FREEMAIL_FORGED_REPLYTO=2.095,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~axelheider <axelheider@gmx.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Axel Heider <axel.heider@codasip.com>

Signed-off-by: Axel Heider <axel.heider@codasip.com>
---
 hw/intc/sifive_plic.c         | 2 +-
 include/hw/intc/sifive_plic.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index 7f43e96310..3e9e4b40e5 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -467,7 +467,7 @@ type_init(sifive_plic_register_types)
 /*
  * Create PLIC device.
  */
-DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
+DeviceState *sifive_plic_create(hwaddr addr, const char *hart_config,
     uint32_t num_harts,
     uint32_t hartid_base, uint32_t num_sources,
     uint32_t num_priorities, uint32_t priority_base,
diff --git a/include/hw/intc/sifive_plic.h b/include/hw/intc/sifive_plic.h
index d3f45ec248..d79b70e602 100644
--- a/include/hw/intc/sifive_plic.h
+++ b/include/hw/intc/sifive_plic.h
@@ -76,7 +76,7 @@ struct SiFivePLICState {
     qemu_irq *s_external_irqs;
 };
 
-DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
+DeviceState *sifive_plic_create(hwaddr addr, const char *hart_config,
     uint32_t num_harts,
     uint32_t hartid_base, uint32_t num_sources,
     uint32_t num_priorities, uint32_t priority_base,
-- 
2.45.2

