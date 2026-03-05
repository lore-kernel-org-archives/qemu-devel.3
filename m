Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57182F513E6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyHXk-0007oy-J4; Thu, 05 Mar 2026 17:51:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vyHXf-0007fX-0E
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:51:39 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vyHXc-0008QV-It
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=cJkhyjiWpWMxMF51u+W6mfp6UZiJV2EEdEaks0cP9cA=; b=b4qbUy9oYgZX4z3
 HRisfcBKIRp0/uzYoaQsAR9eqSLv1LZoKxdnjYGt1WpKVyGlGszIU/0gdj0LMtL9uKWwDVuhKiuzL
 3+nKGYn62KVnKMkCZgMzlPd7iuV1tK0kKJ59K1JG4Gudj7J2Pck/yXbrD5dCcapkoJUGcdMOmCH2d
 4g=;
Date: Thu, 05 Mar 2026 23:54:22 +0100
Subject: [PATCH v6 3/3] hppa: Use 44 bit physical addresses for PA-8700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-hppa-c3600-v6-3-d51526e5269c@rev.ng>
References: <20260305-hppa-c3600-v6-0-d51526e5269c@rev.ng>
In-Reply-To: <20260305-hppa-c3600-v6-0-d51526e5269c@rev.ng>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772751314; l=1705;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=QhCmR++fNiHVlaTqSGM+ku4d4Y2pUsErpEmJbt3vCb4=;
 b=IuhgzSqIkKDqRH6zgxaq4eqbTspGBdtPGGGG4aIOZXViPyo4DWZNj7LjnmfOMAY8gmHymbv0i
 CaLybnkcnXUBMTRpt850COyMiwdOqqLXKKXslRtS3Vj9GLMMeb6f/sn
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is in line with the PA-8700 specification which demands 44 bits.

However, this change breaks the SeaBIOS functional tests as the firmware
assumes 40 bit physical addresses.  Therefore, change the functional
tests to instead run on an A400 which has the expected physical address
space size.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hppa/cpu.c                     | 2 +-
 tests/functional/hppa/test_seabios.py | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 5895b9d7c0..92027d129a 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -349,7 +349,7 @@ static const TypeInfo hppa_cpu_type_infos[] = {
         .name = TYPE_HPPA_CPU_PA_8700,
         .parent = TYPE_HPPA_CPU,
         .class_data = &(const HPPACPUDef) {
-            .phys_addr_bits = 40,
+            .phys_addr_bits = 44,
             .is_pa20 = true,
         },
     },
diff --git a/tests/functional/hppa/test_seabios.py b/tests/functional/hppa/test_seabios.py
index 661b2464e1..bdb9d534ef 100755
--- a/tests/functional/hppa/test_seabios.py
+++ b/tests/functional/hppa/test_seabios.py
@@ -12,7 +12,7 @@
 class HppaSeabios(QemuSystemTest):
 
     timeout = 5
-    MACH_BITS = {'B160L': 32, 'C3700': 64}
+    MACH_BITS = {'B160L': 32, 'A400': 64}
 
     def boot_seabios(self):
         mach = self.machine
@@ -28,7 +28,7 @@ def test_hppa_32(self):
         self.boot_seabios()
 
     def test_hppa_64(self):
-        self.set_machine('C3700')
+        self.set_machine('A400')
         self.boot_seabios()
 
 if __name__ == '__main__':

-- 
2.52.0


