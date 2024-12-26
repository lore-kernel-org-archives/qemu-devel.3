Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3691EE7718E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvHI-0003pn-V2; Thu, 26 Dec 2024 16:20:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvHF-0003p7-RQ
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:17 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvHE-0003Ca-GD
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:17 -0500
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 100EB13801E9;
 Thu, 26 Dec 2024 16:20:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 26 Dec 2024 16:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735248016;
 x=1735334416; bh=AhnS5xcIEHt3sg+hD9qiLsPw6/y/gPWY/teXoXiJ66s=; b=
 ScVZNN6p4pBj/uJ1h+SKXlwalQgm+Hp1YDIn1hK5WcIVO1rA7Ub585cZ80OnvVSa
 HgHma6JBp027p1kRImnyN8ZDfP+f6DIN1QwRupjTZU4pekJ8hTcKi9tAIaCDhm5K
 o3ROENfDUD8PFOscAI4KjSRsTDlGeyv9rOcqz21ZGy3bsbu9ivwxcCUfLDW4WZbZ
 XSlvz3Tf8fPM4lU8kOULvoofJ7a35dWggF9wkLbfNVHgVIi27U5fzDV9wE/8OBeD
 F/0jEOlvT3vkVUQebHCC9wWeOzVBkFjyIDpWNlR7/G2F0NrIeBYyw3RkNogwNsf+
 updDpRjyxDmdqG4e24dJbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735248016; x=
 1735334416; bh=AhnS5xcIEHt3sg+hD9qiLsPw6/y/gPWY/teXoXiJ66s=; b=I
 7SScYZl7UEHPL4uGg/VxgYJCDBg7rTOSEGck73xMbrc3B/YZu95GRbjtIMYJOy0c
 dV+sM45KcDkVCEABkNGabMvLH+mK2Z8rBpooXx7Ho5JQXr6pndFTYsIjq87jeRb1
 n/Jc3wzOn95m2i9CIhLZl2GUatOTMrGqz0lctslVRGUwUjdhQz9cdz6peRKII0Wu
 +mnNpAnT0VGdhFSOdxOMhM2YSchlnKNSGjGKzDus1yo+gUvPA49LGJ36ehfGuGjG
 fumEa+LE6TUGtPOzof9llZ4XR0HCHqQlvwOFpke0uA9Cygf/qNwExE6aFONxPW8y
 0t8SS25dYuefg/v33YdAw==
X-ME-Sender: <xms:j8htZ9PbyWdyjyl2ZdHY1Qj9HPmYDc6P8jjD0E2JNlZfsl3BdqLE9w>
 <xme:j8htZ_9G7HRDu9pdS_9dB4lEQnWQnPWRYfKvBqbyAJicu7Z3yWg9eqq_0ezbobnv4
 chbG5FPH320jj91JHU>
X-ME-Received: <xmr:j8htZ8Ss15w3OtLkGPzflqfuPwUI5E9qtTL0zDY4GGS4kyjjNzzoGpMh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudegjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
 jeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleff
 keegudeghfdtuddugefhueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedune
 curfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorght
 rdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
 htohepmhgrohgsihgsoheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehmrghrtggv
 lhdrrghpfhgvlhgsrghumhesghhmrghilhdrtghomhdprhgtphhtthhopehpsghonhiiih
 hnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepghgrohhsohhngheslhhoohhnghhs
 ohhnrdgtnhdprhgtphhtthhopegvsghlrghkvgesrhgvughhrghtrdgtohhmpdhrtghpth
 htohepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdprhgtphhtthhopehq
 vghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepfigrnhhghigrnh
 grnhehheeshhhurgifvghirdgtohhmpdhrtghpthhtohepiihhrghouddrlhhiuhesihhn
 thgvlhdrtghomh
X-ME-Proxy: <xmx:j8htZ5sToA7Inf7uxwExZKE4Mb8KhSpr3CuqCqJ3haUCQZo0ajN5dA>
 <xmx:j8htZ1df7cTbVWDvxnXz040UFv4UYpw-BiyOkpu4CcLKaZyHUeXzJw>
 <xmx:j8htZ11e1PP6FdcVgN8ref_OVKN9qtj2fqC1OMiK4fmgt_DNFcjxiQ>
 <xmx:j8htZx9NjbTPUO2CgdpEJyVyegtb9zra6smYBPzH9Xv-g0iPM-2rww>
 <xmx:kMhtZz3TMisqa1MeGbm2J37fcfSpbqfHYd2ZUEl_rnhx4UfySSSOqqpt>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:20:14 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 26 Dec 2024 21:19:47 +0000
Subject: [PATCH v2 16/23] target/loongarch: Define address space
 information for LoongArch32
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241226-la32-fixes1-v2-16-0414594f8cb5@flygoat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
In-Reply-To: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1046;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=Z9HPXaAj3Emaei2yrxiSNSaeHVLQ6AGl79stCMSes2I=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvTcE9m5PgVMBZIpcaoneF+Jck1cLP/bNeBHH5O0SHmH3
 yEGoxkdpSwMYlwMsmKKLCECSn0bGi8uuP4g6w/MHFYmkCEMXJwCMBHlXYwMCzSL1sZwfsyYdHeL
 tPaL/0dNdinVJZ8+/3Wt7DSlhKwpDxn+Cm6QOVH5a6F6rXCvQGfddX8pa81pEs9m3XiwUHvmxlJ
 /BgA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.144;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-a1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

LoongArch32 have 32 bit vaddr and 36 bit paddr as per architecture
specification.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/cpu-param.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
index db5ad1c69fafaf368ad7f0c960afecb5a96ddcf2..48512883e550c80570eb2bf02c802f4979151008 100644
--- a/target/loongarch/cpu-param.h
+++ b/target/loongarch/cpu-param.h
@@ -8,9 +8,15 @@
 #ifndef LOONGARCH_CPU_PARAM_H
 #define LOONGARCH_CPU_PARAM_H
 
-#define TARGET_LONG_BITS 64
-#define TARGET_PHYS_ADDR_SPACE_BITS 48
-#define TARGET_VIRT_ADDR_SPACE_BITS 48
+#if defined(TARGET_LOONGARCH64)
+# define TARGET_LONG_BITS 64
+# define TARGET_PHYS_ADDR_SPACE_BITS 48
+# define TARGET_VIRT_ADDR_SPACE_BITS 48
+#elif defined(TARGET_LOONGARCH32)
+# define TARGET_LONG_BITS 32
+# define TARGET_PHYS_ADDR_SPACE_BITS 36
+# define TARGET_VIRT_ADDR_SPACE_BITS 32
+#endif
 
 #define TARGET_PAGE_BITS 12
 

-- 
2.43.0


