Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A40E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 14:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ5pd-0006dT-1Z; Tue, 24 Dec 2024 09:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQ5pT-0006cG-UP
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 09:24:12 -0500
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQ5pR-0005LE-K2
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 09:24:11 -0500
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id D11DF11401A1;
 Tue, 24 Dec 2024 09:24:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 24 Dec 2024 09:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735050248;
 x=1735136648; bh=3qYAndq7s0eBH/drwPl9cVRryaUciC46E2g6bJ91r28=; b=
 T7wE2M3vjPOiTEzGj4Yco2ickKsJI14L4dtuE4QFZJM58I/J54/5SCOcIJWuHY5r
 EuxLQzWaykZ/VUsyDOetPcRXUKIv+VkfyirXsdMgqdkwrNU26HdqiYdcJ8y0wDTt
 Hb4/oHmboc+TKlKJ0uP8r5C0b2aO1QWrkPfZ8OR+1E1oZibKK9GVNWZB+eS2fVPy
 sAdFOmzagb2y4hZ1pKIxwl7YQPoP1WIK4BJy8C1k9MoRE4aeIkxL4cuA58/0I6et
 we0H+IEytyjoX55WFAiKSrvNo0fKcrgesGgQqvN683RanGqh6fRsz+LXpmrk3zPH
 OpqLbpzbSSj+qH1wEEarbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735050248; x=
 1735136648; bh=3qYAndq7s0eBH/drwPl9cVRryaUciC46E2g6bJ91r28=; b=C
 tNIYbcF5LUmJpteeYfkmBcnrf8caImtLSonvTeP8P3a+DZVSN314NgWU06DnHLk1
 l26/6nNhyMldRb/FmszVahv40wM+yBDEsQJwHB7j73MRIl2S1ZubDRBqUGEio2Wo
 sW66j9akMRxzR8UxPJDtWtUQDfJ2KLpT5StNSgrkBbiy5IbmGdsehSM1JGy8vvf1
 +L9EeAnY6VGSm1qeFCt++PlwpAehQaAz1WRXZQjYewgPiGqkyeoDfx6hiXX5ezkR
 SulezZ67d4uCPd52oHxIj/dbJ8nuypf7GKot4jmTErdHdxCZN7LtFKfFJr76+ZNw
 x/4YSIc9q1cd1siUAO4zg==
X-ME-Sender: <xms:CMRqZ7w5yXQ8NTUKcIQ6uh0pI1mYeiQNb726DPwQcaPJAHqy8drUnQ>
 <xme:CMRqZzSZ0gy9YL8ponY6sEN3D7PF-8dVUB7Ax6ry8HK0QkplsI9CzJjg4DRAc0u3t
 RuOvSR-lZ0_dPI2kTU>
X-ME-Received: <xmr:CMRqZ1VLoPbXJoUUtiZP3CWsfmAhkrF6-Z1_cLGpknDr6qmIWZeVQihz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugedgieduucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:CMRqZ1jdLXPBPn2TZ6JM69o_arayWL2Rs3rfgVjBMzWe7mBeYG4NSw>
 <xmx:CMRqZ9ASyNh6u8fmgGYXQV50W62LHTKLX273c7gzkV1wBYJxsW50vQ>
 <xmx:CMRqZ-J-vUZli-sYSOKIF2NPYnS7wLcQLhp4n0fH4huS8eu9ep9CeQ>
 <xmx:CMRqZ8Cjo8W-4t4iofvpFAT-DXe4OOpqIF7PTMlzgjI8-XO1ecfNxQ>
 <xmx:CMRqZ4_qfVwTxamFPS97B1v7iqqKEP3dpJTsgaNOl98cZDpaSgIcPKLF>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Dec 2024 09:24:07 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 24 Dec 2024 14:24:01 +0000
Subject: [PATCH v3 2/3] hw/loongarch/boot: Take care of host endian for
 boot code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-la-booting-v3-2-a15bee060a43@flygoat.com>
References: <20241224-la-booting-v3-0-a15bee060a43@flygoat.com>
In-Reply-To: <20241224-la-booting-v3-0-a15bee060a43@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6398;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=qX07bZYD/4hNJTJbuHKhMWse2Akd/h7UJjV6MYQVytQ=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvSsI6yP3tYczpzdF3Zr+qP9v3R9uf5pO+/nPpbX/j9l8
 jyJezImHaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCRytOMDP0rZwqV/J5eWzy1
 8eVar0PmGifntGXJXmr8zRI/56+BmS4jQ0fdO68TTrf3b0lSKvjlLbqf//66uy6HSu9PulK1bqv
 5cT4A
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=202.12.124.146;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-b3-smtp.messagingengine.com
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

Use stl_p to store instructions so that host endian conversion
will be performed.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/loongarch/boot.c | 99 +++++++++++++++++++++++++++--------------------------
 1 file changed, 51 insertions(+), 48 deletions(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 477c40ccb49d45d4d5026d37db0e79f5f2d89d8e..9cb13c1f154cb15373d6fdcbcbac883e05472e62 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -22,53 +22,56 @@ unsigned memmap_entries;
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
+static void generate_secondary_boot_code(void *boot_code)
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
+    stl_p(p++, 0x06481da0); /* iocsrwr.d  $zero, $t1                 */
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
+    stl_p(p++, 0x06480dac); /* iocsrrd.d  $t0, $t1                   */
+    stl_p(p++, 0x00150181); /* move       $ra, $t0                   */
+    stl_p(p++, 0x4c000020); /* jirl       $zero, $ra, 0              */
+}
 
 static inline void *guidcpy(void *dst, const void *src)
 {
@@ -380,7 +383,7 @@ static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
 
     /* Load slave boot code at pflash0 . */
     void *boot_code = g_malloc0(VIRT_FLASH0_SIZE);
-    memcpy(boot_code, &slave_boot_code, sizeof(slave_boot_code));
+    generate_secondary_boot_code(boot_code);
     rom_add_blob_fixed("boot_code", boot_code, VIRT_FLASH0_SIZE, VIRT_FLASH0_BASE);
 
     CPU_FOREACH(cs) {

-- 
2.43.0


