Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D78CEACD5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sveDQ-0002R7-4E; Tue, 01 Oct 2024 10:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adiupina@astralinux.ru>)
 id 1sveCb-0001eW-RH; Tue, 01 Oct 2024 10:50:14 -0400
Received: from mx.astralinux.ru ([89.232.161.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adiupina@astralinux.ru>)
 id 1sveCZ-00058E-O5; Tue, 01 Oct 2024 10:50:13 -0400
Received: from [10.177.185.109] (helo=new-mail.astralinux.ru)
 by mx.astralinux.ru with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <adiupina@astralinux.ru>)
 id 1svZWC-00FsZE-Ma; Tue, 01 Oct 2024 12:50:08 +0300
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.198.11.47])
 by new-mail.astralinux.ru (Postfix) with ESMTPA id 4XHtWK1y8PzkWwW;
 Tue,  1 Oct 2024 12:51:41 +0300 (MSK)
From: Alexandra Diupina <adiupina@astralinux.ru>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alexandra Diupina <adiupina@astralinux.ru>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
Subject: [PATCH 1/3] hw/intc/arm_gicv3: Add cast to match the documentation
Date: Tue,  1 Oct 2024 12:51:23 +0300
Message-Id: <20241001095125.26043-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: 0
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigrnhgurhgrucffihhuphhinhgruceorgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeduleetfeehffekueeuffektefgudfgffeutdefudfghedvieffheehleeuieehteenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedutddrudelkedruddurdegjeenucfrrghrrghmpehhvghloheprhgsthgrqdhmshhkqdhlthdqfedtvdeiledtrdgrshhtrhgrlhhinhhugidrrhhupdhinhgvthepuddtrdduleekrdduuddrgeejmeefleelledvpdhmrghilhhfrhhomheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopeehpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhrtghpthhtohepqhgvmhhuqdgrrhhmsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepshgulhdrqhgvmhhuse
 hlihhnuhigthgvshhtihhnghdrohhrghenucffrhdrhggvsgcutehnthhishhprghmmecunecuvfgrghhsme
X-DrWeb-SpamVersion: Dr.Web Antispam 1.0.7.202406240#1727772118#02
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128,
 SE: 11.1.12.2210241838, Core engine: 7.00.65.05230, Virus records: 12191152,
 Updated: 2024-Oct-01 08:11:54 UTC]
Received-SPF: pass client-ip=89.232.161.68;
 envelope-from=adiupina@astralinux.ru; helo=mx.astralinux.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

The result of 1 << regbit with regbit==31 has a 1 in the 32nd bit.
When cast to uint64_t (for further bitwise OR), the 32 most
significant bits will be filled with 1s. However, the documentation
states that the upper 32 bits of ICH_AP[0/1]R<n>_EL2 are reserved.

Add an explicit cast to match the documentation.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d2c0c6aab6 ("hw/intc/arm_gicv3: Handle icv_nmiar1_read() for icc_nmiar1_read()")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
 hw/intc/arm_gicv3_cpuif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index bdb13b00e9..ebad7aaea1 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -781,7 +781,7 @@ static void icv_activate_irq(GICv3CPUState *cs, int idx, int grp)
     if (nmi) {
         cs->ich_apr[grp][regno] |= ICV_AP1R_EL1_NMI;
     } else {
-        cs->ich_apr[grp][regno] |= (1 << regbit);
+        cs->ich_apr[grp][regno] |= (1U << regbit);
     }
 }
 
-- 
2.30.2


