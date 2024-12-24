Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81241E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 15:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ6V4-0002kd-4k; Tue, 24 Dec 2024 10:07:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQ6Uw-0002k3-Tf
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:07:04 -0500
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQ6Ut-0002zO-2U
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:07:01 -0500
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id E4B47254016E;
 Tue, 24 Dec 2024 10:06:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 24 Dec 2024 10:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1735052817; x=1735139217; bh=If
 AoCEPCIH+7LCl8mQHaFIP8H0JfFSn0D9Gysx9Sh10=; b=qiCx+fkOI4vzAzpKZj
 +NxZhV3ZZ8EjiTgrLgOlyxoyMGmBv4GNC3IXNJhUlWPWsr1rG15NARJnRDmS0/tp
 AzFERSvBkUnEZpNB4EU/0tGTMGL7NbCDmRhBGiilLziomqL6S4+N5mNq2l/CVJdy
 xvMvSKzNQDPSx2158lgvN0shsoGN+ykbwBbyDnZjIs7JjCoBmZbP8giumPbpYBMf
 qP6iMVk/3YZN62ytUfe2J45E9fW6I9lKNRYwJEGDEpHIgTI9eDq91lR3zIVcjszO
 RAzCSf7zHg22AciLSTaz+UMqCiJeyj27nuImPrkRlOUMQ+Cb6gxugXQFJ81/tpVq
 lRFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1735052817; x=1735139217; bh=IfAoCEPCIH+7LCl8mQHaFIP8H0Jf
 FSn0D9Gysx9Sh10=; b=BOnavD2wzUpk1bjaWIdEtTlm3IpZOoQ73LZiNixpqtDj
 2n3Mntcg6tSLKJooXcz5XaMnA8Wo04bZSgXqC+6gXScQW1p+FGASl/gtuONCBtNG
 pdoBUQwppiyrOSJ2tDtXN+3j9nqvHOpijASUGiNKP/908EIn6fKi4BtchBCU8KxN
 OehyUHS3SHknJC655GUTw8q57PAd/1JK2fp1Xjrm2syqSEOyAU7aPSzUbHa7MxMD
 OZFI0nBZYsgVsTuqj3ErK66d6JWkNOvDzFOWSKijAyXupiVjyDz2ZnS9lIxAKkG3
 KKzilwN9p4P341iCNc3MRoZfpgqs8IkK2ipn2Mo0lw==
X-ME-Sender: <xms:Ec5qZxAYLD2qcC7KOdceoTF-2JAS0_iiW5SoI9Bu7oCh-3RkO7Bx-g>
 <xme:Ec5qZ_i6GgAyGgCCGJaPibyebpw75Ke0hWStXA7uiiBsMmmutp6pqxPfp0sQHH2Td
 b1byd9H3QhIce0Dy90>
X-ME-Received: <xmr:Ec5qZ8nDXHOpQTg1gU4sKQDSrRTtOzCtWciuW6apEDFLl-h8I8vy-wO4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugedgieekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecu
 hfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgoh
 grthdrtghomheqnecuggftrfgrthhtvghrnhephfffgeejgfejieeugffgudegvdekffev
 geeuteetgeejveeiteeivedvffehlefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
 enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgr
 gihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
 guvgepshhmthhpohhuthdprhgtphhtthhopehgrghoshhonhhgsehlohhonhhgshhonhdr
 tghnpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtph
 htthhopehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhrtghpthhtohep
 mhgrohgsihgsoheslhhoohhnghhsohhnrdgtnh
X-ME-Proxy: <xmx:Ec5qZ7xelYboNz_2i8BhFbhtmqcqynfxhvWvn3hLNvamwQTVEIoCuw>
 <xmx:Ec5qZ2QCShoqWX-0SjSRQEF4Nf6jCz5nkYf9z6fc72fpiUCcP6hccA>
 <xmx:Ec5qZ-Z4vxwQahi3lJHDfX6HeOWEptI6VD4CRwLKWKq4nA2oUQZbXA>
 <xmx:Ec5qZ3Svyp4xs7e2bFS1HQGqa-i1QjIsIuEfbL-fzTtsq0vxINuvZQ>
 <xmx:Ec5qZ8M4zxfOGHxAyzi9s0vK-FLWU756D_5kahYT5AwwxN_y8smAbPXw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Dec 2024 10:06:56 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 24 Dec 2024 15:06:51 +0000
Subject: [PATCH v2] hw/loongarch/boot: Support Linux raw boot image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-la-direct-kernel-boot-v2-1-3e8336c54c60@flygoat.com>
X-B4-Tracking: v=1; b=H4sIAArOamcC/3WNQQ6CMBBFr2Jm7Rg6glBX3sOwKGWAiUhN2xAJ4
 e5WEpcu30v++ysE9sIBrocVPM8SxE0J6HgAO5ipZ5Q2MVBGuSIiHA224tlGfLCfeMTGuYi20BV
 d8lJlXELavjx38t679zrxICE6v+w3s/raX/H8pzgrVGhKrXXRVo0q+NaNS+9MPFn3hHrbtg8rO
 w62vAAAAA==
X-Change-ID: 20241222-la-direct-kernel-boot-c598264710e7
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3983;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=oh+rpEvWT8M+CLdPYIB34/urfVHHJAGBmtzazwJxRUA=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvSsc4IG1Zo1ss8OXJrHaFPLxfZaXHiKSGS3SLfqvA6WL
 SvfGmztKGFhEONikBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgIlcOM7w4zNzuvH6mIkvN+ZG
 mXCcSXTcwufps+Ho5hUC4kvL9D6JMjJcyj9pLRI+q03x/CwOy5j/v+2PLaq54DxPqTreb4fOn50
 8AA==
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

Support booting such image by parsing header as per Linux's
specification [1].

This enabled booting vmlinux.efi/vmlinuz.efi shipped by
distros without supplying BIOS.

[1]: https://docs.kernel.org/arch/loongarch/booting.html

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Changes in v2:
- Use extract API for getting bit fields (philmd)
- Mimic arm's load_aarch64_image to handle vmlinuz.efi
- Link to v1: https://lore.kernel.org/r/20241223-la-direct-kernel-boot-v1-1-a79995d8b15e@flygoat.com
---
 hw/loongarch/boot.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 93847b0eaf8e50ce1a990b91267780e6785e1c2f..8b3fa35695a5226535fe160eeb3707955f44d9ec 100644
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
+    int size;
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

---
base-commit: c69612063e1844b76ac01e3a781b979548c3585c
change-id: 20241222-la-direct-kernel-boot-c598264710e7

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


