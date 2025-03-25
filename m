Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2063AC3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 06:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twyBu-0004OZ-UT; Tue, 25 Mar 2025 02:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twyA2-0007BF-1f; Tue, 25 Mar 2025 02:53:21 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twy9z-0001z0-5H; Tue, 25 Mar 2025 02:53:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F22A7107D80;
 Tue, 25 Mar 2025 09:49:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 94DD11D5E8B;
 Tue, 25 Mar 2025 09:50:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 85FF15705E; Tue, 25 Mar 2025 09:50:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 62/69] ppc/spapr: fix default cpu for pre-9.0 machines.
Date: Tue, 25 Mar 2025 09:50:35 +0300
Message-Id: <20250325065043.3263864-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250325094901@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250325094901@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

When POWER10 CPU was made as default, we missed keeping POWER9 as
default for older pseries releases (pre-9.0) at that time.
This caused breakge in default cpu evaluation for older pseries
machines and hence this fix.

Fixes: 51113013f3 ("ppc/spapr: change pseries machine default to POWER10 CPU")
Cc: qemu-stable@nongnu.org
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250313094705.2361997-1-harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
(cherry picked from commit 1490d0bcdfcb78b4503cae42353d3dd50f4e9d96)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0d4efaa0c0..e11b686625 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4771,6 +4771,7 @@ static void spapr_machine_8_2_class_options(MachineClass *mc)
 {
     spapr_machine_9_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_8_2, hw_compat_8_2_len);
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.2");
 }
 
 DEFINE_SPAPR_MACHINE(8, 2);
-- 
2.39.5


