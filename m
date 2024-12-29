Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995E1E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 10:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRqts-0006eN-Oi; Sun, 29 Dec 2024 05:52:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tRqtr-0006eB-Ct; Sun, 29 Dec 2024 05:51:59 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tRqtp-0006QF-I0; Sun, 29 Dec 2024 05:51:59 -0500
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 2561813801DF;
 Sun, 29 Dec 2024 05:51:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Sun, 29 Dec 2024 05:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1735469516; x=1735555916; bh=lA
 +lTMH9Oard6euYIiKDcVpojDs24JntMN83hdsQ7BI=; b=PuOJ8TIVGf638Msx5N
 9HldeBHp7EJ6qP0pMAHLdGGShlJjfM9HGNtPZkc/Td3hevs7kGXux2+6Gv66CPvH
 29X4jpRR8yLmTELE6ZcQ6fftsrl8HKswsLlpe7S+c5cv73Wg4HV46bA0atqFV5IA
 Nrb2nMozAq1faxwH/KEns51IZbwPU3J5we4qon9IazKIN4Txfv2BW+CMEU03b1kj
 4CiggperigtC4gG3w0ZAhnc5ZaTJUayPKTv6YDo8n6AfZWrhrdkq05+h1dzMgb9Z
 lTEADovV/+OcXkvX94Gca2dLiW0vPUrEP1gmC7DqquNrfFrPNPT30wlkvdsggPiP
 G46w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1735469516; x=1735555916; bh=lA+lTMH9Oard6euYIiKDcVpojDs2
 4JntMN83hdsQ7BI=; b=tJ11O3p2av598Nuldxlf3sXBroq0S4Vb/rILl9UP3cns
 CDZETVTRlbHK7hTD0FIPyjCaWQWQA9dTjLCGOzy8bkzzatJxJvinFdfFY6YLadhq
 ngq2ojfBhkXUaJUY39r7f6k0cIdSJipdU3L3Y+mv4Y96JbFYPtOXgba36QGLK5bk
 CcvxLVAKpQ7LRgpIQtr100qKTp6Z1eGfdMXWvZXKKunhiJ9CnRgn07pahbIi1Ru9
 9uppk8sqPa4RwaqGgZRMvv/cvq3ZJsVAiPBo9B+5Yg9xeqsq/VXSRrq3bLPGdN9m
 ORpeIEF7QCJ7Ya6Wmdj59RKHnZw01ywFDGrV28MyrA==
X-ME-Sender: <xms:yylxZ1Y80PTzusHdtSkYZT2WFdadTJY0COPHXsvfMVjlugJxscFY0g>
 <xme:yylxZ8YQHc4LqPn39i4YF42-pN2k_l_n2i68wUNKJBTxnPv15lvDdAawuJ5ZoWp_8
 b2MAreVyxYaLtZmQdg>
X-ME-Received: <xmr:yylxZ39gWgG1lU4cPC9KtZb0ZjQ74XTZDK7XTwriWUP5BTqXDoj8m11M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgedgvddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecu
 hfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgoh
 grthdrtghomheqnecuggftrfgrthhtvghrnhephfffgeejgfejieeugffgudegvdekffev
 geeuteetgeejveeiteeivedvffehlefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
 enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgr
 gihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
 guvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhu
 rdhorhhgpdhrtghpthhtoheplhgruhhrvghnthesvhhivhhivghrrdgvuhdprhgtphhtth
 hopehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhrtghpthhtoheprhhi
 tghhrghrugdrhhgvnhguvghrshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtohepqh
 gvmhhuqdhsthgrsghlvgesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:yylxZzqcJCKUc4SmCBEXcuiFB9BVr31jLQmVRuxRAFqoSdaR3VRg8Q>
 <xmx:yylxZwplrvsT1VVnD2u2hBRw16Mp64XkeGztRXEINZEm8YOBhI_i1A>
 <xmx:yylxZ5SdJiqvv7phmjWQ5moWIaed4i6tADOXqKSpuOpHWLzOd43iwg>
 <xmx:yylxZ4qhEbOf0xEb_jkY8lE7HLjRvgcaTRESe84I3ECGfAdbQ3iXJQ>
 <xmx:zClxZ1B4OB7_qF6ETGLK8gueLggwCZM94qHP72lblGUWX7hfK2YYqF-h>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Dec 2024 05:51:54 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 29 Dec 2024 10:51:54 +0000
Subject: [PATCH v2] target/m68k: Handle EXCP_SEMIHOSTING for m68k class CPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241229-m68k-semihosting-v2-1-8a08b2d199a5@flygoat.com>
X-B4-Tracking: v=1; b=H4sIAMkpcWcC/32NQQ6CMBBFr0JmbY0zRQKuvIdhAWWgEy01LWkkh
 LtbOYDL95L//gaRg3CEW7FB4CRR/JyBTgUY280TKxkyA12oRKJGuap+qshOrI+LzJMiUzamrgb
 N2kCevQOP8jmSjzazlbj4sB4PCX/2TyyhQjX0qJGpvxLSfXytk++Ws/EO2n3fv3f/r6yyAAAA
X-Change-ID: 20241229-m68k-semihosting-2c49c86d3e3c
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1902;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=6/7auNXlC38Th9tx0PeuJ+H4vruFPeAeFr5ygMCAadw=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvRCzdNCh5P1+T8unenrfT9N/fGZE66c8rPfnC+IEzoxM
 02oR6Wzo5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACYS2MjwV+b9H24BizfWKwKs
 XyVvj580v/7sudOt3XxfstJfXQ56LsTIcKbx4NbEq89fKcYu0irr/ZR3uqNxgwKXavidnfU/L1j
 94AcA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.150;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-a7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

EXCP_SEMIHOSTING can be generated by m68k class CPU with
HALT instruction, but it is never handled properly and cause
guest fall into deadlock.

Moving EXCE_SEMIHOSTING handling code to common do_interrupt_all
routine to ensure it's handled for both CPU classes.

Fixes: f161e723fdfd ("target/m68k: Perform the semihosting test during translate")
Cc: qemu-stable@nongnu.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Changes in v2:
- hoist both calls to do_interrupt_all (Richard)
- Link to v1: https://lore.kernel.org/r/20241229-m68k-semihosting-v1-1-db131e2b5212@flygoat.com
---
 target/m68k/op_helper.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 15bad5dd46518c6e86b6273d4a2b26b3b6f991de..9dd76f540b4871d3d0ab0e95747c85434e5d677d 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -202,9 +202,6 @@ static void cf_interrupt_all(CPUM68KState *env, int is_hw)
             /* Return from an exception.  */
             cf_rte(env);
             return;
-        case EXCP_SEMIHOSTING:
-            do_m68k_semihosting(env, env->dregs[0]);
-            return;
         }
     }
 
@@ -422,6 +419,15 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
 
 static void do_interrupt_all(CPUM68KState *env, int is_hw)
 {
+    CPUState *cs = env_cpu(env);
+
+    if (!is_hw) {
+        switch (cs->exception_index) {
+        case EXCP_SEMIHOSTING:
+            do_m68k_semihosting(env, env->dregs[0]);
+            return;
+        }
+    }
     if (m68k_feature(env, M68K_FEATURE_M68K)) {
         m68k_interrupt_all(env, is_hw);
         return;

---
base-commit: 2b7a80e07a29074530a0ebc8005a418ee07b1faf
change-id: 20241229-m68k-semihosting-2c49c86d3e3c

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


