Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6454DE9B36D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1qd-00010b-2z; Mon, 02 Mar 2026 06:54:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vx1qV-0000xZ-Ph
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:53:56 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vx1qT-0007jC-DY
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=/jeHttps8DYEaDwl71tkYjKjUU3e/IGSNyYqPsM70Lg=; b=HFSRlaZzrrMih0t
 WOaXD6+UgRd6M8nWJEhZ/skzaeqevzltjrM/p+IV/TqM9N7sdAmie1CAB4m0Pz2MG26PRIHvu6aZu
 22a4M12lrwtJIY0XDu/cYC1busrr1QnNuKeFNXZ1rKewknj6oE8eLaMkfXpj9+iZMQYwvUpVNlJ2+
 +I=;
Date: Mon, 02 Mar 2026 12:56:46 +0100
Subject: [PATCH v4 4/4] hppa: Use 44 bit physical addresses for PA-8700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-hppa-c3600-v4-4-447a800da8cc@rev.ng>
References: <20260302-hppa-c3600-v4-0-447a800da8cc@rev.ng>
In-Reply-To: <20260302-hppa-c3600-v4-0-447a800da8cc@rev.ng>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772452649; l=1553;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=SWZZwLNUpR+m+HlmyyzM//LAKhYk8Mfup25BuKvmefE=;
 b=sXvZYAEceCa+IOs/fMj1oxadHLe/Jm3uHsVTokiDO5+c/KA/p/WK1qfvBgDQVlpOTdomM5EO0
 xnmvI3jhysYBMU9tCC1h1X47K939xvz1CxXFTjw0tRDEJCVoSwCAgw0
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

This is in line with the PA-8700 specification.

As the SeaBIOS functional tests requires a 40 bit physical address space
and now support the A400 machine, update tests to run that instead.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hppa/cpu.c                     | 2 +-
 tests/functional/hppa/test_seabios.py | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index cc755da8be..5ba1045f1f 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -344,7 +344,7 @@ static const TypeInfo hppa_cpu_type_infos[] = {
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


