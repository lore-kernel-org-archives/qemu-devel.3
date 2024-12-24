Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F134E7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 14:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ5pa-0006d2-QD; Tue, 24 Dec 2024 09:24:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQ5pU-0006cQ-Fm
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 09:24:12 -0500
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQ5pT-0005LS-2Z
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 09:24:12 -0500
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 3B1A4254015A;
 Tue, 24 Dec 2024 09:24:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Tue, 24 Dec 2024 09:24:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735050250;
 x=1735136650; bh=SaPuX7Cz9/OgI2m94j3k/tRF3jgedJYajcJ7jGWKldw=; b=
 p23D/1IcTBo0zZLGNrE/Dlk62dzAdjlG/CALe0w2G6qZmAf1WjbjyFOfUXEwYKxQ
 LPo5/pObCzRc09APaxDzea2KVV0M0JmN7n6F/6wY6nuQT2X5gsisOAho6smTHhxn
 hM4hsBwOSqSYLegPNQYunScaIXrfofAqM29//oCtAyv/gR56CKYp6kpvr3mxBcGt
 KVd9sxYF5pgyE5G5GXc7eWH/mqQ9gN/q7yTdkJhZKQX5FoQyq8ZzNo2QrQNC6+/o
 f9kwaHTis8L9L/rGCaPGTuIPjaSn+FFp6g9LPdJaRDiuQV/YAs67s9nwHVuD8yV+
 3rqDC23Z+BWgPT8ojJLc9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735050250; x=
 1735136650; bh=SaPuX7Cz9/OgI2m94j3k/tRF3jgedJYajcJ7jGWKldw=; b=W
 /I+JZqmRg1fjqOOZxFkidYbZ83NzLGbe93vhlcHcKLOYR5kfogA4iIFqoBATQwr2
 yp/oeeLoXBq6HY/DH/QfTVySNwHXJhRzDWxThXSy4vgooYv8jHGMvNeoMSZDruPA
 G0C7tQLfMB+600TISKmSTCEPXHt+FfoJOhmEvkDkA3mqqxm6rTnYACmwv0P46H3l
 rQit9dG1myEBY2PsTWk1W4mCd3leBiNgsnoyxcqyOq5wOovc8/9YwnQXCE38pI53
 tQtlM6HyMnVYRF/aKrgM1voN9PKmrYUbTGLgTW3cb/RBXO6Z+1FEYuLT/hc6mkf6
 POVw6yFicnSZkoNxlQYtQ==
X-ME-Sender: <xms:CcRqZ4WLP7jA1K3aBO5IBlV9yk-0d_Z_xFj0JkEdByiAejBxgHr0qw>
 <xme:CcRqZ8kB-sY4qHqxecrV7SQxadLhbuuV-DjkTFd-gM_AExMltzkwkJnLYHfz5Ixov
 xWuUCW3zUOk-rpFKQc>
X-ME-Received: <xmr:CcRqZ8awuUD-Azf9sHhOa83lDy1cEEXrxk22xllFj3Xjk20x8h5Y78hm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugedgiedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
 necuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhi
 hgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffek
 gedugefhtdduudeghfeuveegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdr
 tghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 epghgrohhsohhngheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehqvghmuhdquggv
 vhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepjhhirgiguhhnrdihrghnghesfh
 hlhihgohgrthdrtghomhdprhgtphhtthhopehmrghosghisghosehlohhonhhgshhonhdr
 tghn
X-ME-Proxy: <xmx:CcRqZ3WUTVNEs6XfJrnLFzT_kwzoyBkArMy2HLsi9ZrlR-xie5dCJQ>
 <xmx:CcRqZykYibk4PpXSr2b5AJI6Z787YN46Lba8ZB97iSOZLPcNd7jtdQ>
 <xmx:CcRqZ8e7xn--DdR9UUUvwJmVUDAjX5-lVdccqv6IsjzW0EkqFoIeWQ>
 <xmx:CcRqZ0FPZBQ8X9UGqn6Xi40HYbgVERv4g7cewJ_t9DfCDU6TDLEvng>
 <xmx:CsRqZzAlfhaJgG_76nZLNrnyJTDdc9edlkxOKr8H7OK3sj6MjEGDqNZF>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Dec 2024 09:24:09 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 24 Dec 2024 14:24:02 +0000
Subject: [PATCH v3 3/3] hw/loongarch/boot: Support 32bit boot code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-la-booting-v3-3-a15bee060a43@flygoat.com>
References: <20241224-la-booting-v3-0-a15bee060a43@flygoat.com>
In-Reply-To: <20241224-la-booting-v3-0-a15bee060a43@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2526;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=ggos8KxnCEkX4dJrh0H4vnXnArwrCkYHe5wYIMmNqeE=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvSsI6yBoms+/vw3e4OyTM2ZsMiTzbU/s85FV1helsz7P
 U9s33u7jlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZjIp1iGv6LZjK0OZoUswnuc
 awVL2azP3XxnfLdzPuPsaROet53UPs/IcH/h1a2l03Le9rw/OTH9t2wdg2h+kuFbhu7sz7nMs3f
 JswIA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=202.12.124.155;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-b4-smtp.messagingengine.com
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

Replace mailbox read/write on LoongArch32 systems with 32bit IOCSR
instructions to prevent illegal instructions.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/loongarch/boot.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 9cb13c1f154cb15373d6fdcbcbac883e05472e62..0046ad3e424bdcc488db709945d7059749e0cdc3 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -22,7 +22,7 @@ unsigned memmap_entries;
 ram_addr_t initrd_offset;
 uint64_t initrd_size;
 
-static void generate_secondary_boot_code(void *boot_code)
+static void generate_secondary_boot_code(void *boot_code, bool  is_64bit)
 {
     uint32_t *p = boot_code;
 
@@ -36,7 +36,11 @@ static void generate_secondary_boot_code(void *boot_code)
     /* Clear mailbox. */
     stl_p(p++, 0x1400002d); /* lu12i.w    $t1, 1(0x1)                */
     stl_p(p++, 0x038081ad); /* ori        $t1, $t1, CORE_BUF_20      */
-    stl_p(p++, 0x06481da0); /* iocsrwr.d  $zero, $t1                 */
+    if (is_64bit) {
+        stl_p(p++, 0x06481da0); /* iocsrwr.d  $zero, $t1             */
+    } else {
+        stl_p(p++, 0x064819a0); /* iocsrwr.w  $zero, $t1             */
+    }
 
     /* Enable IPI interrupt. */
     stl_p(p++, 0x1400002c); /* lu12i.w    $t0, 1(0x1)                */
@@ -68,7 +72,11 @@ static void generate_secondary_boot_code(void *boot_code)
     /* Read mail buf and jump to specified entry. */
     stl_p(p++, 0x1400002d); /* lu12i.w    $t1, 1(0x1)                */
     stl_p(p++, 0x038081ad); /* ori        $t1, $t1, CORE_BUF_20      */
-    stl_p(p++, 0x06480dac); /* iocsrrd.d  $t0, $t1                   */
+    if (is_64bit) {
+        stl_p(p++, 0x06480dac); /* iocsrrd.d  $t0, $t1               */
+    } else {
+        stl_p(p++, 0x064809ac); /* iocsrrd.w  $t0, $t1               */
+    }
     stl_p(p++, 0x00150181); /* move       $ra, $t0                   */
     stl_p(p++, 0x4c000020); /* jirl       $zero, $ra, 0              */
 }
@@ -383,7 +391,7 @@ static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
 
     /* Load slave boot code at pflash0 . */
     void *boot_code = g_malloc0(VIRT_FLASH0_SIZE);
-    generate_secondary_boot_code(boot_code);
+    generate_secondary_boot_code(boot_code, is_la64(&lacpu->env));
     rom_add_blob_fixed("boot_code", boot_code, VIRT_FLASH0_SIZE, VIRT_FLASH0_BASE);
 
     CPU_FOREACH(cs) {

-- 
2.43.0


