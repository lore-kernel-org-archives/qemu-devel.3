Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5AAE77188
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 00:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPWLl-0007aH-Sv; Sun, 22 Dec 2024 19:31:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPWLj-0007Zj-RE
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 19:31:07 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPWLe-0003Lm-Od
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 19:31:07 -0500
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id CFB5111400E4;
 Sun, 22 Dec 2024 19:31:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Sun, 22 Dec 2024 19:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1734913860; x=1735000260; bh=sF
 kjPM6Ahyu09h+6QhdmM3ZEQFBsk+iSPjww6+WnRxk=; b=QOtsVIjlU7D9MHINoN
 tbIPUK7+7OtAN7wCMfrpu+oWbHW3wNrWiNmiiMzqeibLnWmOqeXz7qJhXOA96yhv
 QlPP2YkpSzS8y9kWcNSWqaeNr2KGeR3ssOXXAlBqfKj6HPFYgiS8I4U0UohsI4WP
 mLo6e4D/yNyU4+6PyqhwKjDouYVvjDCB8CxrzMTUyZIWWsf7UoPagF11gCH6vkE0
 ONT+/eLt6LP9vU4X8EFFEmtpzO+H/2D57LFs3PiONiAbMp88Lil/+qusgqgQDiyi
 G6nyZxhEUjsfYpvse+9gZvbVif5aDJuMVEazJ3xNGIOHe96Klspa5cXrDN055MEW
 mXuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1734913860; x=1735000260; bh=sFkjPM6Ahyu09h+6QhdmM3ZEQFBs
 k+iSPjww6+WnRxk=; b=xzWyLhWyakjJ4LRpW6BwyIfB6K4mOn2EZsqZaw0ufuq4
 JU2ghFzfpyPOxW/FeTGV47McTk8PNOEBVcnSbZMu14w+5Z3wAndd2GjBaVP+KyXC
 KzjSMv/rmZ+rhgI3x9vZEf0UCk1gxaU0rjP/W5ljBld7rKHJMUzo8hZHO/TId9kc
 MZNac7dfyr/lRqz6i30X5k4IlJKnlGoWIkvgMdTiWz/G3ZXYU+pivBQgs5pWrdDV
 BlX0C1DioVhGfRd2/ONMWn2+t1upK4sgy1brhnJA2OR5uXLi21km+FFyvttru2eo
 wnZCAiSHLwNR6itayz32+krhVRcoOc6BES7Dh/YlDw==
X-ME-Sender: <xms:RK9oZ2wdhbfNdQP-g_UbhEGo9TjUY4i-5lBA-dtKcauIdAryEjlrvw>
 <xme:RK9oZySrosvo9jrkkJ35_69v5-c0Xeb4P98_sbieVI-cYvlpdWHXIopTwyZo3L7Sb
 QinpcimPXd60-Wo1Uo>
X-ME-Received: <xmr:RK9oZ4WOlc7YOsVVNtGJAjHvYGUEkUvIOLTI0X-zuI5ORgyfMA3wnmgj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtledgvddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecu
 hfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgoh
 grthdrtghomheqnecuggftrfgrthhtvghrnhepleeigefhveefgeekvdffuddtteegkeek
 ffevffeigedvjeehffdvffffgfeifedvnecuffhomhgrihhnpegvfhhirdhsuhhpphhorh
 htpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
 mhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsg
 gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghosghi
 sghosehlohhonhhgshhonhdrtghnpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnoh
 hnghhnuhdrohhrghdprhgtphhtthhopehjihgrgihunhdrhigrnhhgsehflhihghhorght
 rdgtohhmpdhrtghpthhtohepghgrohhsohhngheslhhoohhnghhsohhnrdgtnh
X-ME-Proxy: <xmx:RK9oZ8iYOFFH0x9Sq4jHC6-RlQM6CTEpeJ9BaMyCdeosE6iKRMvNnA>
 <xmx:RK9oZ4CBAPPUUTmUenoTn8whSOrmjkM2yXXtPK4DlWH32uAJSeIdJw>
 <xmx:RK9oZ9K_ds5Xp6URJEuyc8U0N3jm9Hh_TtJnzh50sir-QgRsd_-V5A>
 <xmx:RK9oZ_DpG_2KElMtbN-2F8M8xPeMQaOWaEHJvRQF1mUoNHMaeheTGA>
 <xmx:RK9oZ7_GhistfvY4aXJzbN-QN8JvdclqecWKse-APyVEHG7yaLapqVtu>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Dec 2024 19:30:59 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 23 Dec 2024 00:30:58 +0000
Subject: [PATCH] hw/loongarch/boot: Support Linux raw boot image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241223-la-direct-kernel-boot-v1-1-a79995d8b15e@flygoat.com>
X-B4-Tracking: v=1; b=H4sIAEGvaGcC/x3MQQqDMBBG4avIrB0wg9bqVcSFjX/bQUlkIlIQ7
 27o8lu8d1KCKRL1xUmGQ5PGkOHKgvx3Ch+wztkkldRORHideFaD33mBBaz8inFn33RPedStq9B
 SbjfDW3//7zBe1w2+vD+4ZwAAAA==
X-Change-ID: 20241222-la-direct-kernel-boot-c598264710e7
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3980;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=7oK8b7rq/fD2GXyUApOzLkS1TwZEcDUnO5vv8AAlL0g=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvSM9c6bdimYJ2c1ft4Q+MuNkSHK4WitwqRNpc73eANf6
 R9LT/zfUcrCIMbFICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABNZ1MjIsC+qpWnDhDwBu8w3
 icZ6nkkfjvedeDl/T6lo5/Pl3n0zljEyPL9iz/JuywELmUw/6cM5Uuav5p/xCn9WW6td27fQfsp
 MXgA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=202.12.124.147;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-b4-smtp.messagingengine.com
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

Many distros are shipping raw kernel images (i.e. vmlinux.efi).

Support booting such image by parsing header as per Linux's
specification [1].

[1]: https://docs.kernel.org/arch/loongarch/booting.html

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
It is based on my previous booting protocol patch
---
 hw/loongarch/boot.c         | 45 +++++++++++++++++++++++++++++++++++++++++++++
 include/hw/loongarch/boot.h | 17 +++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 93847b0eaf8e50ce1a990b91267780e6785e1c2f..5bc889c51fafa9c6d37426b9bee9709c12183927 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -260,6 +260,43 @@ static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
     return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
 }
 
+static int64_t get_linux_image_info(struct loongarch_boot_info *info,
+                                    uint64_t *kernel_entry,
+                                    uint64_t *kernel_low,
+                                    uint64_t *kernel_high)
+{
+    int fd;
+    struct loongarch_linux_hdr hdr;
+    int64_t kernel_size = -1;
+
+    fd = open(info->kernel_filename, O_RDONLY | O_BINARY);
+    if (fd < 0) {
+        return -1;
+    }
+
+    if (read(fd, &hdr, sizeof(hdr)) != sizeof(hdr)) {
+        close(fd);
+        return -1;
+    }
+
+    if ((le32_to_cpu(hdr.mz_magic) & 0xffff) != MZ_MAGIC ||
+        le32_to_cpu(hdr.linux_pe_magic) != LINUX_PE_MAGIC) {
+        close(fd);
+        return -1;
+    }
+
+    *kernel_entry = le64_to_cpu(hdr.kernel_entry);
+    /* Early kernel versions may have those fields in virtual address */
+    *kernel_entry &= MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
+    *kernel_low = le64_to_cpu(hdr.load_offset);
+    *kernel_low &= MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
+    kernel_size = le64_to_cpu(hdr.kernel_size);
+    *kernel_high = *kernel_low + kernel_size;
+
+    close(fd);
+    return kernel_size;
+}
+
 static int64_t load_kernel_info(struct loongarch_boot_info *info)
 {
     uint64_t kernel_entry, kernel_low, kernel_high;
@@ -270,6 +307,14 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
                            &kernel_entry, &kernel_low,
                            &kernel_high, NULL, 0,
                            EM_LOONGARCH, 1, 0);
+    if (kernel_size < 0) {
+        kernel_size = get_linux_image_info(info, &kernel_entry,
+                                           &kernel_low, &kernel_high);
+        if (kernel_size >= 0) {
+            kernel_size = load_image_targphys(info->kernel_filename,
+                                              kernel_low, kernel_size);
+        }
+    }
 
     if (kernel_size < 0) {
         error_report("could not load kernel '%s': %s",
diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
index 96ec15016a314499acf65c6c47e0c4932aa99d01..5e8bd4dd73bbb27abccfa1fa577df52aed15b6a2 100644
--- a/include/hw/loongarch/boot.h
+++ b/include/hw/loongarch/boot.h
@@ -8,6 +8,23 @@
 #ifndef HW_LOONGARCH_BOOT_H
 #define HW_LOONGARCH_BOOT_H
 
+/* Linux Image Format */
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
 /* UEFI 2.10 */
 #define EFI_SYSTEM_TABLE_SIGNATURE       0x5453595320494249
 #define EFI_2_100_SYSTEM_TABLE_REVISION  ((2<<16) | (100))

---
base-commit: c69612063e1844b76ac01e3a781b979548c3585c
change-id: 20241222-la-direct-kernel-boot-c598264710e7

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


