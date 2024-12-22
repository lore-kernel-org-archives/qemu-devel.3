Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88BBE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPP3y-0000Ij-8Q; Sun, 22 Dec 2024 11:44:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPP3t-0000IU-HY
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:44:13 -0500
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPP3n-0005B5-9h
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:44:08 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 762D5254011D;
 Sun, 22 Dec 2024 11:44:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Sun, 22 Dec 2024 11:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1734885845;
 x=1734972245; bh=hgKNpuqSzW2O6+p0gRiuodXZuf7iu/BHLzURKXRVV58=; b=
 umCFSpFoiM1w0XaIu8ebUKGvby6FUvT81alexrsPTF5qayHKhQWRsT7Iydrt3hqk
 LGQu/nIgFGkMfrq0To+0XeMNwDLrPyQNpzdV8IEbsCsMfqmAfweXmf1+2jvnqj0y
 s95EkhPKRGXfLdwr6aaf69aDtFOBPCCQv6kg4ENd8evL8LzvdT89m3HmEBFCxDoQ
 5t8EW6R5JCKd+covEYDRLG3ke8S5n0fRUWYCqiASgNA62r5yJh274hYA/D8G6iF1
 2UcsFyOE/cRhdwxwhR482W0Mrab/qFPXmYJ4z/K4JJeHOX1kd9k2anIkC9SI6Q24
 dJFEqzpZY5d3sAcAuh5Tuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734885845; x=
 1734972245; bh=hgKNpuqSzW2O6+p0gRiuodXZuf7iu/BHLzURKXRVV58=; b=N
 FCxfVZSCVFcrdYKKeFkamycs+pMUIISkGvEoNRQGJT0B4A5gyIj91u3ttrYKAIQ6
 TCdt70TqtgjOrZCGqOddEFMLqKG0FQWR8JgicoojjmFhXk8HYFSpjnDwBq9+yzNy
 LgUwc8xq83jr+SrnHziOzdJni7wfXIb5XORNZjiOfuXLIwXvXhcb+wBuLiaPF1bn
 zUgOXE4cp5LkO5YD4UV/YlBtQwE6iHzy0IWk45YTG/TXWrHkBUFU/9rA3tVRAF0z
 ROQ8LO995akVVQesIVIl1WusxW1XzaLq1p+SSb1AF0kp/r4Qv8zqQ5A2AZJAhcs5
 8u1zRb6ox1JcHI7nEvmWg==
X-ME-Sender: <xms:1UFoZ4Ou5YuHI1BaYmCd73o61SANduZSMD2PvYZ0qwdaYaZGJc17VA>
 <xme:1UFoZ-8bT66m8PIk82pZ-C9-Solnc_D6YpK0JAbPGJgTPgytBpcuteSrqdvMVgRB9
 Lit7_T5cq5bAFIr3hk>
X-ME-Received: <xmr:1UFoZ_T2e0SnzLvy58PT5MZlQBiZSDuGZwYAie7rFD-tC0ubuwk0oA58>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtkedgleduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
 necuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhi
 hgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffek
 gedugefhtdduudeghfeuveegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdr
 tghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 epmhgrohgsihgsoheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehqvghmuhdquggv
 vhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepjhhirgiguhhnrdihrghnghesfh
 hlhihgohgrthdrtghomhdprhgtphhtthhopehgrghoshhonhhgsehlohhonhhgshhonhdr
 tghn
X-ME-Proxy: <xmx:1UFoZwvKeg4Q1ZgqkIkysk1T4LrRgHm8J_XiYE9NG8kCIJ4_100GnA>
 <xmx:1UFoZwetNYQs6MamBmKlQyUBB6eK8tTSGU6TBkEqERttUWgLB-Ldpw>
 <xmx:1UFoZ02SqZnMAHyjNxZCiMFxVsblHdRzDPIAxlkMDNP4_NwnylkzFw>
 <xmx:1UFoZ08KPt6O38GHVFd5tpbpOCZRC7GRik78GUE_Ha5Xs4V2f1_m8w>
 <xmx:1UFoZ_7zwhF4149XJv32YnyWPLnxZuDMh1Jk19R8WYmMBi2Qf8YzcJ9M>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Dec 2024 11:44:04 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 22 Dec 2024 16:44:00 +0000
Subject: [PATCH v2 2/2] hw/loongarch/boot: Rework boot code generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241222-la-booting-v2-2-bef2ea7d3b32@flygoat.com>
References: <20241222-la-booting-v2-0-bef2ea7d3b32@flygoat.com>
In-Reply-To: <20241222-la-booting-v2-0-bef2ea7d3b32@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6835;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=DJregaJS6xL/JGo+hiyZplBoCSmb5EebxbU0rsB8yhw=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvQMx4tSPWdY152Zvf3Cjk9V/hdFtlQ+EAjzM0j+UnJw5
 We9CWWTOkpZGMS4GGTFFFlCBJT6NjReXHD9QdYfmDmsTCBDGLg4BWAiBnMZ/qfrb+HUSZfT+vIh
 omCT4h+rk1r8MUvYOU+dTdFn6uo8/pvhv4tG/NKeB+llV8R0WL45F4j49ggYbPyqOfPDnHcuvtf
 FWAA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=202.12.124.158;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-b7-smtp.messagingengine.com
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

Use stl_p to write instructions so that host endian conversion
will be performed.

Replace mailbox read/write on LoongArch32 systems with 32bit IOCSR
instructions to prevent illegal instructions.

Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/loongarch/boot.c | 107 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 59 insertions(+), 48 deletions(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 477c40ccb49d45d4d5026d37db0e79f5f2d89d8e..93847b0eaf8e50ce1a990b91267780e6785e1c2f 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -22,53 +22,64 @@ unsigned memmap_entries;
 ram_addr_t initrd_offset;
 uint64_t initrd_size;
 
-static const unsigned int slave_boot_code[] = {
-                  /* Configure reset ebase.                    */
-    0x0400302c,   /* csrwr      $t0, LOONGARCH_CSR_EENTRY      */
-
-                  /* Disable interrupt.                        */
-    0x0380100c,   /* ori        $t0, $zero,0x4                 */
-    0x04000180,   /* csrxchg    $zero, $t0, LOONGARCH_CSR_CRMD */
-
-                  /* Clear mailbox.                            */
-    0x1400002d,   /* lu12i.w    $t1, 1(0x1)                    */
-    0x038081ad,   /* ori        $t1, $t1, CORE_BUF_20  */
-    0x06481da0,   /* iocsrwr.d  $zero, $t1                     */
-
-                  /* Enable IPI interrupt.                     */
-    0x1400002c,   /* lu12i.w    $t0, 1(0x1)                    */
-    0x0400118c,   /* csrxchg    $t0, $t0, LOONGARCH_CSR_ECFG   */
-    0x02fffc0c,   /* addi.d     $t0, $r0,-1(0xfff)             */
-    0x1400002d,   /* lu12i.w    $t1, 1(0x1)                    */
-    0x038011ad,   /* ori        $t1, $t1, CORE_EN_OFF          */
-    0x064819ac,   /* iocsrwr.w  $t0, $t1                       */
-    0x1400002d,   /* lu12i.w    $t1, 1(0x1)                    */
-    0x038081ad,   /* ori        $t1, $t1, CORE_BUF_20          */
-
-                  /* Wait for wakeup  <.L11>:                  */
-    0x06488000,   /* idle       0x0                            */
-    0x03400000,   /* andi       $zero, $zero, 0x0              */
-    0x064809ac,   /* iocsrrd.w  $t0, $t1                       */
-    0x43fff59f,   /* beqz       $t0, -12(0x7ffff4) # 48 <.L11> */
-
-                  /* Read and clear IPI interrupt.             */
-    0x1400002d,   /* lu12i.w    $t1, 1(0x1)                    */
-    0x064809ac,   /* iocsrrd.w  $t0, $t1                       */
-    0x1400002d,   /* lu12i.w    $t1, 1(0x1)                    */
-    0x038031ad,   /* ori        $t1, $t1, CORE_CLEAR_OFF       */
-    0x064819ac,   /* iocsrwr.w  $t0, $t1                       */
-
-                  /* Disable  IPI interrupt.                   */
-    0x1400002c,   /* lu12i.w    $t0, 1(0x1)                    */
-    0x04001180,   /* csrxchg    $zero, $t0, LOONGARCH_CSR_ECFG */
-
-                  /* Read mail buf and jump to specified entry */
-    0x1400002d,   /* lu12i.w    $t1, 1(0x1)                    */
-    0x038081ad,   /* ori        $t1, $t1, CORE_BUF_20          */
-    0x06480dac,   /* iocsrrd.d  $t0, $t1                       */
-    0x00150181,   /* move       $ra, $t0                       */
-    0x4c000020,   /* jirl       $zero, $ra,0                   */
-};
+static void generate_secondary_boot_code(void *boot_code, bool is_64bit)
+{
+    uint32_t *p = boot_code;
+
+    /* Configure reset ebase. */
+    stl_p(p++, 0x0400302c); /* csrwr      $t0, LOONGARCH_CSR_EENTRY  */
+
+    /* Disable interrupt. */
+    stl_p(p++, 0x0380100c); /* ori        $t0, $zero, 0x4            */
+    stl_p(p++, 0x04000180); /* csrxchg    $zero, $t0, LOONGARCH_CSR_CRMD */
+
+    /* Clear mailbox. */
+    stl_p(p++, 0x1400002d); /* lu12i.w    $t1, 1(0x1)                */
+    stl_p(p++, 0x038081ad); /* ori        $t1, $t1, CORE_BUF_20      */
+    if (is_64bit) {
+        stl_p(p++, 0x06481da0); /* iocsrwr.d  $zero, $t1             */
+    } else {
+        stl_p(p++, 0x064819a0); /* iocsrwr.w  $zero, $t1             */
+    }
+
+    /* Enable IPI interrupt. */
+    stl_p(p++, 0x1400002c); /* lu12i.w    $t0, 1(0x1)                */
+    stl_p(p++, 0x0400118c); /* csrxchg    $t0, $t0, LOONGARCH_CSR_ECFG */
+    stl_p(p++, 0x02fffc0c); /* addi.d     $t0, $r0, -1(0xfff)        */
+    stl_p(p++, 0x1400002d); /* lu12i.w    $t1, 1(0x1)                */
+    stl_p(p++, 0x038011ad); /* ori        $t1, $t1, CORE_EN_OFF      */
+    stl_p(p++, 0x064819ac); /* iocsrwr.w  $t0, $t1                   */
+    stl_p(p++, 0x1400002d); /* lu12i.w    $t1, 1(0x1)                */
+    stl_p(p++, 0x038081ad); /* ori        $t1, $t1, CORE_BUF_20      */
+
+    /* Wait for wakeup <.L11>: */
+    stl_p(p++, 0x06488000); /* idle       0x0                        */
+    stl_p(p++, 0x03400000); /* andi       $zero, $zero, 0x0          */
+    stl_p(p++, 0x064809ac); /* iocsrrd.w  $t0, $t1                   */
+    stl_p(p++, 0x43fff59f); /* beqz       $t0, -12(0x7ffff4) # 48 <.L11> */
+
+    /* Read and clear IPI interrupt. */
+    stl_p(p++, 0x1400002d); /* lu12i.w    $t1, 1(0x1)                */
+    stl_p(p++, 0x064809ac); /* iocsrrd.w  $t0, $t1                   */
+    stl_p(p++, 0x1400002d); /* lu12i.w    $t1, 1(0x1)                */
+    stl_p(p++, 0x038031ad); /* ori        $t1, $t1, CORE_CLEAR_OFF   */
+    stl_p(p++, 0x064819ac); /* iocsrwr.w  $t0, $t1                   */
+
+    /* Disable IPI interrupt. */
+    stl_p(p++, 0x1400002c); /* lu12i.w    $t0, 1(0x1)                */
+    stl_p(p++, 0x04001180); /* csrxchg    $zero, $t0, LOONGARCH_CSR_ECFG */
+
+    /* Read mail buf and jump to specified entry. */
+    stl_p(p++, 0x1400002d); /* lu12i.w    $t1, 1(0x1)                */
+    stl_p(p++, 0x038081ad); /* ori        $t1, $t1, CORE_BUF_20      */
+    if (is_64bit) {
+        stl_p(p++, 0x06480dac); /* iocsrrd.d  $t0, $t1               */
+    } else {
+        stl_p(p++, 0x064809ac); /* iocsrrd.w  $t0, $t1               */
+    }
+    stl_p(p++, 0x00150181); /* move       $ra, $t0                   */
+    stl_p(p++, 0x4c000020); /* jirl       $zero, $ra, 0              */
+}
 
 static inline void *guidcpy(void *dst, const void *src)
 {
@@ -380,7 +391,7 @@ static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
 
     /* Load slave boot code at pflash0 . */
     void *boot_code = g_malloc0(VIRT_FLASH0_SIZE);
-    memcpy(boot_code, &slave_boot_code, sizeof(slave_boot_code));
+    generate_secondary_boot_code(boot_code, is_la64(&lacpu->env));
     rom_add_blob_fixed("boot_code", boot_code, VIRT_FLASH0_SIZE, VIRT_FLASH0_BASE);
 
     CPU_FOREACH(cs) {

-- 
2.43.0


