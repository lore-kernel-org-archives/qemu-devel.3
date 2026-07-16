Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727C4C44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkOJ1-0004FF-11; Thu, 16 Jul 2026 11:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wkOIT-00048c-Ri; Thu, 16 Jul 2026 11:47:07 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wkOIK-0002MH-6M; Thu, 16 Jul 2026 11:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1784216797;
 bh=jSuRj9IRW0QigeZa4bLZgDPiu+5R/Vid2SH/Mkyex04=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QBbb6R7rj4pRAe9pMvBbtat+nTXaVfL9ezqVDFpUYWv25a5vlJNpo/yjvZqifV3TT
 l+4Wk31HTNkJuHUr+9FNOhIdz7PCzwrCYGhU39kGSacT5in8DvAaakua63bfqQ9Bmd
 QhdZUs0nB0fJ4gNZoN/XIHwxwUGxfSElMT5ZzsCvg6wkx3Z/I3r97EySoALalxJVWE
 dnuJvG5oho0Nk9ucezm5S8ZCeWInsLm05eGn5oCgVFlJU9NV8PNM684TW5utfQezhD
 W4f6WrMd51pKaEf3vFbXf5TBVX9IOGo9k8zWhF1sSQlHzbce4381eRk2UKp3f9kZbN
 BmCY+k+SkwA+g==
Received: from mailhub-1.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id CC3104028E;
 Thu, 16 Jul 2026 17:46:37 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub-1.u-ga.fr (Postfix) with ESMTP id C7C78FF85D;
 Thu, 16 Jul 2026 17:46:37 +0200 (CEST)
Received: from naga.tima.u-ga.fr (naga.tima.u-ga.fr [147.171.132.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 9CCBC400E7;
 Thu, 16 Jul 2026 17:46:37 +0200 (CEST)
From: frederic.petrot@univ-grenoble-alpes.fr
To: daniel.barboza@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: julien.thillard@univ-grenoble-alpes.fr,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH v2 1/3] disas/riscv.c: Correct indent for checkpatch
Date: Thu, 16 Jul 2026 17:46:13 +0200
Message-ID: <20260716154615.1545145-2-frederic.petrot@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716154615.1545145-1-frederic.petrot@univ-grenoble-alpes.fr>
References: <20260716154615.1545145-1-frederic.petrot@univ-grenoble-alpes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UGA SMTP Authentifie (petrotf@univ-grenoble-alpes.fr)
 via submission-587 ACL (41)
Received-SPF: pass client-ip=152.77.200.56;
 envelope-from=frederic.petrot@univ-grenoble-alpes.fr;
 helo=zm-mta-out-3.u-ga.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>

Trival indentation patch on the cbo/lq relevant code, in preparation
for modifications in that part.

Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
---
 disas/riscv.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 7f1b262773..689502f083 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2887,25 +2887,25 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 0: op = rv_op_fence; break;
             case 1: op = rv_op_fence_i; break;
             case 2:
-               /*
-                * 'lq' shares the "(...) 010 ..... 0001111" opcode space
-                * with 'cbo' insns.  Check the next 5 bits to select
-                * what we want:
-                *
-                * cbo_inval  0000000 00000 ..... 010 00000 0001111
-                * cbo_clean  0000000 00001 ..... 010 00000 0001111
-                * cbo_flush  0000000 00010 ..... 010 00000 0001111
-                * cbo_zero   0000000 00100 ..... 010 00000 0001111
-                *
-                * Anything that doesn't match these will default to 'lq'.
-                */
-               switch ((inst >> 17) & 0b11111) {
-               case 0: op = rv_op_cbo_inval; break;
-               case 1: op = rv_op_cbo_clean; break;
-               case 2: op = rv_op_cbo_flush; break;
-               case 4: op = rv_op_cbo_zero; break;
-               default: op = rv_op_lq; break;
-               }
+                /*
+                 * 'lq' shares the "(...) 010 ..... 0001111" opcode space
+                 * with 'cbo' insns.  Check the next 5 bits to select
+                 * what we want:
+                 *
+                 * cbo_inval  0000000 00000 ..... 010 00000 0001111
+                 * cbo_clean  0000000 00001 ..... 010 00000 0001111
+                 * cbo_flush  0000000 00010 ..... 010 00000 0001111
+                 * cbo_zero   0000000 00100 ..... 010 00000 0001111
+                 *
+                 * Anything that doesn't match these will default to 'lq'.
+                 */
+                switch ((inst >> 17) & 0b11111) {
+                case 0: op = rv_op_cbo_inval; break;
+                case 1: op = rv_op_cbo_clean; break;
+                case 2: op = rv_op_cbo_flush; break;
+                case 4: op = rv_op_cbo_zero; break;
+                default: op = rv_op_lq; break;
+                }
             }
             break;
         case 4:
-- 
2.43.0


