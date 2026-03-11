Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8241049523
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 09:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0GH0-0003aR-6Z; Wed, 11 Mar 2026 05:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>)
 id 1w0GGi-0003VU-Nt; Wed, 11 Mar 2026 05:54:20 -0400
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>)
 id 1w0GGg-0007Ib-9D; Wed, 11 Mar 2026 05:54:19 -0400
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id 25A0DEC053B;
 Wed, 11 Mar 2026 05:54:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Wed, 11 Mar 2026 05:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1773222857; x=1773309257; bh=P4
 OySs5EQSXB5RyhkSiCa+1SDn4AAfaohkRKSbCu8J4=; b=jkicxceWwvtaTg04sl
 lMqWlAYjN8cgbPWwryidN2PltY95C4tSfkK737nalCcUBpmKPLs/Q9Vb5P0ANPZ3
 VmKoJMS2qZbIyP9P6ghkTaj6y6G/uqJVZ4mFNfgTRAD/uOJKlua2Mi6qli6RtxO3
 AYu8Pu0hMBq0FoI+3KAwnFo1CINkcXZx/JAxLdAGfBg8axysoM/8Y5+gpIIHLLii
 jTX6uiWw5Suj9zzBWoTG6nmRnNtyRr5WWLtG9F5Bhy3Da6EHeHOM9Iwt/p0BW9ac
 eyQqg8xqr340hmgPCsQKz99rj9/SQSC0x4OI7KpGG6jFYCKfCRAXyeMwgIOCr+IP
 DPGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1773222857; x=1773309257; bh=P4OySs5EQSXB5RyhkSiCa+1SDn4A
 AfaohkRKSbCu8J4=; b=EQ6RXFCc1/meDHZrlqAFmylPvj36Q/6Ofb1CqvBjtbjJ
 7T8C1QM2XQdC2z2bkbIlXuXjAEjzYP8KBawFzmsuj2Qu95mDk+ti5RREmsO+g7sH
 2TaLq+JXNsldxP/7uJSFdabm2swXFDjMX6sVKhBwLkUq2tt70VaqGBGkPLh+NO8e
 hXu+/rI2Ca5+HYLAR5+RlU3u6vEIuB1wzX3IiQ9iIMg2UB0GK/gGdfiVaAQakzvo
 MwEq2wnLzEv5u9bKQvo7E/KuciO8b9hSYxWObTfeUmlsnLRQ4dtbVOuNZbcoiPSw
 jggyoAb0919yFqxzSxy5j+YWMrljWukDHgrW45Hd4w==
X-ME-Sender: <xms:yDuxaWFNt944ESiQ1eMvQO56r92tpTI9AzMGMHJBOlR16xrPxaHk3g>
 <xme:yDuxaZkcy_Xz6KUxRT7JjxiXmvzjbvb4NNkUNJd_5mWAlzGaR_HkFGHZ8O2ZozSeb
 RIUDOlZovRwk_m4q6673gQrMrakcyBVECeNKQJg5_jVrRsxxs33>
X-ME-Received: <xmr:yDuxaSZ_fBmL34gqlfRwxO2kmfmse-tcawqop11witI7wxnGFCgOo2Xnl5fjevAc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeefheelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeetlhihshhsrgcu
 tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeejfeehff
 ehjeejgfdtffetkedtgfefgfefjeegffekjeejgedtveejleehleelhfenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrd
 hishdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 phgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhrtghpthhtohepqhgvmh
 huqdgrrhhmsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhes
 nhhonhhgnhhurdhorhhgpdhrtghpthhtohepmhhighhuvghlrdhluhhishesohhrrggtlh
 gvrdgtohhmpdhrtghpthhtohepvghrihgtrdgruhhgvghrsehrvgguhhgrthdrtghomhdp
 rhgtphhtthhopehpsghonhiiihhnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkh
 hvmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yDuxaWG19W0Qi6FzeJHs118xgpSzZdyofYj6QKaV77pmVw2tOPf3ZQ>
 <xmx:yDuxabI0tC0S6_436k3qwjTZh0ehlDPym86r4klrPpkaRlVtfczibQ>
 <xmx:yDuxaZO7d58vMG4Unf5bzuRA2wvlXG2zR2ex2rxHkRfr8Lf83CHXNA>
 <xmx:yDuxaTlL31FbJYuCkVVqSJZ9weozYFODYiXcBaPKblrOK3Zc2QDDaQ>
 <xmx:yTuxaSqT2472sOmb4DKlPqs_hxj30VxLrRRGbu60yKHz71oEoiVuuDK3>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 05:54:16 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
 id 4D63C7706B21; Wed, 11 Mar 2026 10:54:14 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Eric Auger <eric.auger@redhat.com>,
	Miguel Luis <miguel.luis@oracle.com>
Subject: [PATCH] target/arm/kvm: fall back if nested unsupported
Date: Wed, 11 Mar 2026 10:54:05 +0100
Message-ID: <20260311095405.26297-1-hi@alyssa.is>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.149; envelope-from=hi@alyssa.is;
 helo=fout-a6-smtp.messagingengine.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

If I create a machine with more CPUs than KVM supports, but specify
multiple accelerator options, QEMU will fall back to the next
accelerator.  This is great, because if I've explicitly specified
multiple accelerators, I've told QEMU I'm fine with any of them being
used to provide the machine I want.

When I create a machine with nested virtualization enabled, though,
this doesn't happen.  KVM often doesn't support it, but TCG always
does.  The nice thing to do would be for QEMU to fall back to TCG if
KVM can't provide, like it does when too many CPUs are requested.
This patch adjusts the behaviour to do that.

This is very helpful for OS development scripts that run an OS in QEMU
— I want everybody to be able to run the script, always with
virtualization enabled because the OS requires it, but for it to take
advantage of KVM acceleration when available.

Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 hw/arm/virt.c    | 6 ------
 target/arm/kvm.c | 8 ++++++++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7456614d05..0b63b2eac3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2372,12 +2372,6 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->virt && kvm_enabled() && !kvm_arm_el2_supported()) {
-        error_report("mach-virt: host kernel KVM does not support providing "
-                     "Virtualization extensions to the guest CPU");
-        exit(1);
-    }
-
     if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "Virtualization extensions to the guest CPU",
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index d4a68874b8..20dcc6a820 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -615,6 +615,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         ret = -EINVAL;
     }
 
+    if (object_property_find(OBJECT(ms), "virtualization") &&
+        object_property_get_bool(OBJECT(ms), "virtualization", NULL) &&
+        !kvm_arm_el2_supported()) {
+        error_report("Using ARM nested virtualization with KVM requires "
+                     "a host kernel with KVM_CAP_ARM_EL2");
+        ret = -EINVAL;
+    }
+
     if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
         if (kvm_vm_enable_cap(s, KVM_CAP_ARM_NISV_TO_USER, 0)) {
             error_report("Failed to enable KVM_CAP_ARM_NISV_TO_USER cap");

base-commit: ae56950eac7b61b1abf42003329ee0f3ce111711
-- 
2.53.0


