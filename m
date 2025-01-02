Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C3FE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 22:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTTyf-0007WL-Ua; Thu, 02 Jan 2025 17:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tTTyZ-0007Pg-Kd; Thu, 02 Jan 2025 17:47:38 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tTTyX-0004Ba-P2; Thu, 02 Jan 2025 17:47:35 -0500
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 13E641380213;
 Thu,  2 Jan 2025 17:47:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 02 Jan 2025 17:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735858052;
 x=1735944452; bh=TUTgiDO5F3IrwBDulY3H6uAg/dv2N57ssbEq1q6uYkw=; b=
 t7eHMHQ1ihcpzUa/XnVgBjyTY0hGeq6ybOtPmOKOaFwWDLiHCFh0PraYTTxzPsmE
 nvsI+uGd5TZXd1QuMut9J+MTCYio9nin823eGJILlYoCeoZP7tLDjZxWbzFD74u5
 HDSRdbWtManoKUvWi/roDow3ZlPnKZcunp2lV4gyjYDl1byA0Nkz/c6iy5z7eRSf
 Cy8kNnP766aN4ta60466SAAaLao6zD6vUC1EbldN87GlXGmJKRza+belozuXp8pY
 frboy1iFe5hwY5wORZH0zvIlp9aWYHK8UFlnjNvgGv2HdObLBb/HDhADmjnNlZyp
 6HsvbPeqbpgkIaSJ+lIIkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735858052; x=
 1735944452; bh=TUTgiDO5F3IrwBDulY3H6uAg/dv2N57ssbEq1q6uYkw=; b=F
 Cg0GF9fwURnIBLfF9OBcWN9cLcGzOi6CiW+cGDTgDSJbklOJhWUHsVQWRkstjoOB
 Bhnoc3kDRGYs+7ZLZZG2Xnjz1+TS9mdI3d1L3JI+I5FQjvKLxibfgkqcGaep5BL+
 Jmg3fxT69aNmTmMXZ8z6C+reZO6XL24DVZjVwvl8UXTLxsyACbJilJgP2u9Kyx93
 eZyjXCbWCVduJXQamfn2Pt6nT7VWl3daa4aoAsAjgSm/tNpiBt/KpuMzskCA+YcO
 fNMQQrcHRkI4Th/jIpG8T+ynC1ykbq/5K1mLMOCKZ9KALknQd/kJqVjicqItrUSm
 A4QGZN5xLmbUfLNarkdqg==
X-ME-Sender: <xms:gxd3Z9gaY-Jzi44wU_VSMqi2eSTGrialF_AlAqDrMXLtuQ_xjiGfGw>
 <xme:gxd3ZyCaZsUfmXtLXEUHOvZGLOptaIvdbHVgyP4Q1y6QwICPSE-S9boOgV3t6Tz2I
 sb4hEvcJOjrzg4Wta4>
X-ME-Received: <xmr:gxd3Z9G3CAg_AtdyjXAkDeN2Yi2K6gAuIUQtgWUvT7ru4p5AV9Tt6B2K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeffedgtdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
 necuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhi
 hgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvedujefhfffhveekhfffkeetvefg
 teejkeeutdduieehieegfeejtdelveejtedunecuffhomhgrihhnpehkvghrnhgvlhdroh
 hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehj
 ihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhopeejpd
 hmohguvgepshhmthhpohhuthdprhgtphhtthhopehrihgthhgrrhgurdhhvghnuggvrhhs
 ohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehgrghoshhonhhgsehlohhonhhgsh
 honhdrtghnpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdp
 rhgtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdprhgtph
 htthhopehmrghosghisghosehlohhonhhgshhonhdrtghnpdhrtghpthhtohepjhhirgig
 uhhnrdihrghnghesfhhlhihgohgrthdrtghomhdprhgtphhtthhopehqvghmuhdqrghrmh
 esnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:gxd3ZyR2azi6xOy5F4DOjvcNRcW1zXr4JV4bLEP8EhXzkvp_0izYXw>
 <xmx:gxd3Z6xpWe9qV-qhKpTda6nt2PPagH1FYkKbnv0rjptmQUvj4ZDqUQ>
 <xmx:gxd3Z44ieVE24MGoWR5Ufw3bJjveuBGas2Sc8SyZZqQO8kQ5DivS1Q>
 <xmx:gxd3Z_zbJPd_eYZfYOkkXW_sIBGYy3nRaMdY88vv0ZRs0hQGGz4KXA>
 <xmx:hBd3Z1zsKrV1alMylUwoxmetdnMy7I0aN4IJAG12MCTExfN_Eg0qb2dH>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jan 2025 17:47:30 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 02 Jan 2025 22:47:22 +0000
Subject: [PATCH v3 2/2] hw/loongarch/boot: Support Linux raw boot image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250102-la-direct-kernel-boot-v3-2-40dbc45d633a@flygoat.com>
References: <20250102-la-direct-kernel-boot-v3-0-40dbc45d633a@flygoat.com>
In-Reply-To: <20250102-la-direct-kernel-boot-v3-0-40dbc45d633a@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3593;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=wYocujj8x+KlkkZalToDfgfPzdw4XBgk+g4HI9CRNB4=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvRy8XrOvpQTV4zn3DI46FKXPbVEycmgarNVXW3F4bJG/
 1U8Hzd2lLIwiHExyIopsoQIKPVtaLy44PqDrD8wc1iZQIYwcHEKwEQ2yTEyPI5L43ffeuddX8IW
 hbSY5Q1l7ervpCsW9Vgt0T/03M/ejuF/5n3zqxPXbm/tVj1vFH0t2lI8zjaL6ZL8k5vv1y3zYWL
 lAwA=
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

Support booting such image by parsing header as per Linux's
specification [1].

This enabled booting vmlinux.efi/vmlinuz.efi shipped by
distros without supplying BIOS.

[1]: https://docs.kernel.org/arch/loongarch/booting.html

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/loongarch/boot.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 93847b0eaf8e50ce1a990b91267780e6785e1c2f..38c19bffa3475d61ffab27a26af9c4c821769dca 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -16,6 +16,26 @@
 #include "sysemu/reset.h"
 #include "sysemu/qtest.h"
 
+/*
+ * Linux Image Format
+ * https://docs.kernel.org/arch/loongarch/booting.html
+ */
+#define LINUX_PE_MAGIC  0x818223cd
+#define MZ_MAGIC        0x5a4d /* "MZ" */
+
+struct loongarch_linux_hdr {
+    uint32_t mz_magic;
+    uint32_t res0;
+    uint64_t kernel_entry;
+    uint64_t kernel_size;
+    uint64_t load_offset;
+    uint64_t res1;
+    uint64_t res2;
+    uint64_t res3;
+    uint32_t linux_pe_magic;
+    uint32_t pe_header_offset;
+} QEMU_PACKED;
+
 struct memmap_entry *memmap_table;
 unsigned memmap_entries;
 
@@ -260,6 +280,50 @@ static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
     return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
 }
 
+static int64_t load_loongarch_linux_image(const char *filename,
+                                          uint64_t *kernel_entry,
+                                          uint64_t *kernel_low,
+                                          uint64_t *kernel_high)
+{
+    gsize len;
+    ssize_t size;
+    uint8_t *buffer;
+    struct loongarch_linux_hdr *hdr;
+
+    /* Load as raw file otherwise */
+    if (!g_file_get_contents(filename, (char **)&buffer, &len, NULL)) {
+        return -1;
+    }
+    size = len;
+
+    /* Unpack the image if it is a EFI zboot image */
+    if (unpack_efi_zboot_image(&buffer, &size) < 0) {
+        g_free(buffer);
+        return -1;
+    }
+
+    hdr = (struct loongarch_linux_hdr *)buffer;
+
+    if (extract32(le32_to_cpu(hdr->mz_magic), 0, 16) != MZ_MAGIC ||
+        le32_to_cpu(hdr->linux_pe_magic) != LINUX_PE_MAGIC) {
+        g_free(buffer);
+        return -1;
+    }
+
+    /* Early kernel versions may have those fields in virtual address */
+    *kernel_entry = extract64(le64_to_cpu(hdr->kernel_entry),
+                              0, TARGET_PHYS_ADDR_SPACE_BITS);
+    *kernel_low = extract64(le64_to_cpu(hdr->load_offset),
+                            0, TARGET_PHYS_ADDR_SPACE_BITS);
+    *kernel_high = *kernel_low + size;
+
+    rom_add_blob_fixed(filename, buffer, size, *kernel_low);
+
+    g_free(buffer);
+
+    return size;
+}
+
 static int64_t load_kernel_info(struct loongarch_boot_info *info)
 {
     uint64_t kernel_entry, kernel_low, kernel_high;
@@ -270,6 +334,11 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
                            &kernel_entry, &kernel_low,
                            &kernel_high, NULL, 0,
                            EM_LOONGARCH, 1, 0);
+    if (kernel_size < 0) {
+        kernel_size = load_loongarch_linux_image(info->kernel_filename,
+                                                 &kernel_entry, &kernel_low,
+                                                 &kernel_high);
+    }
 
     if (kernel_size < 0) {
         error_report("could not load kernel '%s': %s",

-- 
2.43.0


