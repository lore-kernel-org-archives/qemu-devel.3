Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6638EC02192
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2024 12:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spRbS-00054n-TV; Sat, 14 Sep 2024 08:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1spRbP-0004v6-NT
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 08:10:11 -0400
Received: from fhigh4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1spRbM-000175-V3
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 08:10:11 -0400
Received: from phl-compute-08.internal (phl-compute-08.phl.internal
 [10.202.2.48])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 24AC1114030B;
 Sat, 14 Sep 2024 08:10:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Sat, 14 Sep 2024 08:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1726315807;
 x=1726402207; bh=OAtfobS7ue1MGtycMBRMt8ae7AQkM+8PzKI/3HFaepQ=; b=
 yrEjN5C1Sfjlsnu84vOGT6XNfZAj/uECy5m6XsyydhUgVAS+vujlfAxOHQ7V3l2I
 2DAUUhRRgTzhzoOdgtCdj+lIvj9ZNmxspdLihjARkMkDDJpVu7HV2KjesDvjBDxb
 Y1BL1ko6dIfg2wWVJQZvAaxfCa+Wt6YVwdEAVxA+2k2W57VZ8tXfYwIAx2Z3kjtA
 UZJT+hhlpSnFy1AhRAjuQbQVLixkOd5l1bMqUmT9nDN/2YcpQeM3KL+SNAYptozh
 S8FQgwldBThWBwF4n+zOifFXpYmHPN1/FtDGsnG1exQoTAxeiC64j1MB/EsIS6Hi
 ZC+1cNDcuZWbhzUIudva0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726315807; x=
 1726402207; bh=OAtfobS7ue1MGtycMBRMt8ae7AQkM+8PzKI/3HFaepQ=; b=f
 oGjloH4VncvGJjwXYX6cQsjnaYY4WAPj4OGwFgON7umSWINUsBmjQ6dORxEnVZK2
 pZy7/M5hG4u/vmnINW2k/BSZ9ad01q0Py+g15qRElQ72HqNJT9LLJcBvAs8galeC
 qdt9LDsK35S/n3H/R0KcOTX1T+O5PbHQVT4lJlmPOSRt6fzhgN79WFkDB+DXL1R9
 ND4pOTHTHx32scuRop66MYHfRMdFqRmpJEwvrCk7Ev27M1tLRDSr3Vif8qZXdKCN
 9pGGO38vMOyQaIoBbugXXyrmWdwBjeZZCu2UES7C1JRof6qtRuBNNEgiOOuR4rO+
 l7rELuQLUdWkyWx2BI5NA==
X-ME-Sender: <xms:Hn3lZkoCblbrGcEFEVhYz_7E2pmJgIEYs-f7rCpc84uNhpVhnVWHZA>
 <xme:Hn3lZqqREzMkVhXCpzmF2JUDgKsf9rBeebriT8_jrIPDZEEW-X_OXG-XfSzQ4rauW
 zI_i5JrPvklSfvS_hw>
X-ME-Received: <xmr:Hn3lZpMZTACulY3I1HOjZzW4GMjZ0PB9unLl9CHl81p1nFpgoJBDCsie3GZsVQr4FmI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudektddggeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
 necuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhi
 hgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffek
 gedugefhtdduudeghfeuveegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdr
 tghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 epqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehjihgrgihu
 nhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhrtghpthhtohepghgrohhsohhngheslh
 hoohhnghhsohhnrdgtnh
X-ME-Proxy: <xmx:Hn3lZr5hyNF05GjW6WQc-uEqD6hX01hKVJfx1G7gUVDOfqkHGStZgA>
 <xmx:H33lZj4WjnV26ZuB0YtUyxqKVrNa0SCT59qHhvdfAoJw852_YYdSQw>
 <xmx:H33lZrjIiXvBDwJR_KcqstFvpuGcNjdCUuHPgQF0uOv8I9jp3p0WNA>
 <xmx:H33lZt5XPXBuA6jsVZ0711nvDddMs7Bwh7fKj7gVsJCcRp-5SpjKBg>
 <xmx:H33lZlmNrbDuC1mRAKeYXZn4Ad4ShPxc67Wesss-L8uv68FUe0132WQ0>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Sep 2024 08:10:06 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sat, 14 Sep 2024 13:10:03 +0100
Subject: [PATCH 2/2] hw/loongarch/boot: Rework boot code generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240914-loongarch-booting-v1-2-1517cae11c10@flygoat.com>
References: <20240914-loongarch-booting-v1-0-1517cae11c10@flygoat.com>
In-Reply-To: <20240914-loongarch-booting-v1-0-1517cae11c10@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6742;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=LW0Cx/PLuEFhw+V0yg5fwl1MDczr4LkAV73g4buM2k8=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSntTKW6Tfc701WP9Ro6jmxYv4brtJFC9qFOg4l7dtp+
 E3k4JWkjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZjI3mKG/wG2d36+2uX731Ll
 9IqTt3h8bhy9G33n9aVACdVEn/mB938yMpxUXCBx/KHoFpl0i6cHi3Mde3ZNzHXk0GM8kLA50Fv
 Nnh8A
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.155;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/loongarch/boot.c | 107 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 59 insertions(+), 48 deletions(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 4d01c01594e2..5a1cc5b79b41 100644
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
-    0x038081ad,   /* ori        $t1, $t1, CORE_BUF_20          */
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
+    stl_p(p++, 0x0380100c); /* ori        $t0, $zero,0x4             */
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
@@ -379,7 +390,7 @@ static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
 
     /* Load slave boot code at pflash0 . */
     void *boot_code = g_malloc0(VIRT_FLASH0_SIZE);
-    memcpy(boot_code, &slave_boot_code, sizeof(slave_boot_code));
+    generate_secondary_boot_code(boot_code, is_la64(&lacpu->env));
     rom_add_blob_fixed("boot_code", boot_code, VIRT_FLASH0_SIZE, VIRT_FLASH0_BASE);
 
     CPU_FOREACH(cs) {

-- 
2.46.0


