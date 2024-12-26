Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E5AE7718E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvHX-0003xW-JN; Thu, 26 Dec 2024 16:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvHQ-0003ue-0x
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:28 -0500
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvHO-0003EP-Iv
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:27 -0500
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 281291140191;
 Thu, 26 Dec 2024 16:20:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 26 Dec 2024 16:20:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735248026;
 x=1735334426; bh=xe9BuqPS0CARoFfo8D7AEtwCqEeGIBNkINPPVMFXfNw=; b=
 ZkR2jAO+pZznP+W0jFlYSvqBoiu5Xu7RP6djZcuGeXHYS5dVTV9QT0RHgfRdC5GE
 1iBU/jkCLIw3HAznkY4vgJfn3OK2lM44ICgAQ00xj1jBXqo8rlbik3RCpQ1qL1JG
 QeCkAetnZbWbAQBFDqV7ePrK6AScO4GDRl5yM6j102a3rHuoY+cYDhcArhNEebrB
 xqZp3sCgTUW3R+YJczMX1dedyL8aAvJIfzVMWOw4Fg5l/TXxPNWAMf3DN/1q3xoL
 bLM+XeqY/eP1r84zRx11e5Uz/SsTT+syv0I4i9CW2zQNtSVR5IMLOrclnoSk+cft
 RfnsgR0AXLZmIEnciJcrQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735248026; x=
 1735334426; bh=xe9BuqPS0CARoFfo8D7AEtwCqEeGIBNkINPPVMFXfNw=; b=N
 0YGZlWjgJY0SSPMsddjMa6xRkvZio9FxA82IEZTL91qWWYUNAtwW2j0ulosl10yT
 cjMQEmo/rTVzDOFvKuodsdO1ac2qebdNhCBwlplSKB8R5z+1jaYm3acNYoN0BuPl
 JdnZ9lN78YOIyspDrwdyrUig1zTrUlHFNq8n9RsUNTX/oWDaIAxSM9EnHDl5yETs
 d8UEYaRy4++2bg65Pz5u3rSdrbdeBGTS/OCe9+hF33V2eT+5j4iew3S7qMgj1Vbu
 VV8vgePAHS1p8Mx7aRpvdKHlJFcq9Eh74n9O1RrDeytkKNTQ9fMf9Wi+Mu16ttR0
 U4nk+e4CR0AeN++AmyIyQ==
X-ME-Sender: <xms:mshtZ6AT2Y-hm2gJBSMHig4VUwRfexdJVdhviRNTrxD1C7hO9Lr2Ow>
 <xme:mshtZ0g3hWadIVD-IMtmX9rsndSbc6k873qIHS_yuevWxMR6kCH5Grdv6GKYSJsGO
 hSKFg_aM3oBCXlJbbA>
X-ME-Received: <xmr:mshtZ9mRI7Qq_letCyAcq5GvYIN4nWqOb0SRwz_se-TN6XQLLf51sik8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudegjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
 jeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleff
 keegudeghfdtuddugefhueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpeegne
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
X-ME-Proxy: <xmx:mshtZ4x7HY_1AWLK-aCdlKEySzzboEDCz8jFo4AHl--K0Ny9X0ycUg>
 <xmx:mshtZ_Qm4fUSMymRpPMonKYXAIiRERrhHKf_FXaMhZzRaSRxkD5Grg>
 <xmx:mshtZzZqs_tGQyAUpL9CTJ9VE9ZNJ03z0jomT54gfzGk6kEecvN45w>
 <xmx:mshtZ4RONo0Vo3r9XwrnuA5NmAikj49xtxhk_nmr11LHePzDqOKjog>
 <xmx:mshtZ-L34gFNMDW0LWazkQdwvErAA7E-MSOyrN_DdspdJrg7G7SE8ZeJ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:20:24 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 26 Dec 2024 21:19:52 +0000
Subject: [PATCH v2 21/23] qapi/machine: Replace TARGET_LOONGARCH64 with
 TARGET_LOONGARCH
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241226-la32-fixes1-v2-21-0414594f8cb5@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1616;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=iYUi8NSJen0z2KRIyUqEbFujGU6IWLS1XfkvXr0NRPs=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvTcE9lPxb0PPj4TkZA+saslaU1V/1+jIJ5c3m8rhZZ3N
 QeKbZjfUcrCIMbFICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABP56sfwV2LyqhKVZzdep8ct
 KJW7etA28+jsqZd8RFy9Pba72n9LuMfwV4zdUEV4k5H23A1cpfL3DIPXX3tpt+oXq0Ci+jPZxxK
 3OAE=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.155;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-a4-smtp.messagingengine.com
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

All TARGET_LOONGARCH64 qapis are also available for LoongArch32 as we
are reusing the same CPU backend implemenation.

Use TARGET_LOONGARCH to identify LoongArch.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 qapi/machine-target.json | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 541f93eeb78f67c7eac83d8a2722000976e38a33..b00c3f59b6a5f6e3ad9d7197d462e928ffc4c152 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -260,7 +260,7 @@
   'if': { 'any': [ 'TARGET_S390X',
                    'TARGET_I386',
                    'TARGET_ARM',
-                   'TARGET_LOONGARCH64',
+                   'TARGET_LOONGARCH',
                    'TARGET_RISCV' ] } }
 
 ##
@@ -314,7 +314,7 @@
   'if': { 'any': [ 'TARGET_S390X',
                    'TARGET_I386',
                    'TARGET_ARM',
-                   'TARGET_LOONGARCH64',
+                   'TARGET_LOONGARCH',
                    'TARGET_RISCV' ] } }
 
 ##
@@ -383,7 +383,7 @@
                    'TARGET_I386',
                    'TARGET_S390X',
                    'TARGET_MIPS',
-                   'TARGET_LOONGARCH64',
+                   'TARGET_LOONGARCH',
                    'TARGET_RISCV' ] } }
 
 ##
@@ -401,7 +401,7 @@
                    'TARGET_I386',
                    'TARGET_S390X',
                    'TARGET_MIPS',
-                   'TARGET_LOONGARCH64',
+                   'TARGET_LOONGARCH',
                    'TARGET_RISCV' ] } }
 
 ##

-- 
2.43.0


