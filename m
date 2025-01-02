Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129DFE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 22:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTTyg-0007X4-AW; Thu, 02 Jan 2025 17:47:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tTTyY-0007Nz-6p; Thu, 02 Jan 2025 17:47:38 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tTTyW-00049u-6M; Thu, 02 Jan 2025 17:47:33 -0500
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id 919681380235;
 Thu,  2 Jan 2025 17:47:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Thu, 02 Jan 2025 17:47:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735858050;
 x=1735944450; bh=XPWws51Y2N23qrEc5nM4CaJcvPjhLeOxKaf8wN3qGso=; b=
 qTblShVRiff31JsAarPaZ1LMVVeIAFU0ZP4Nh7t+OaFUQ3KHzmSeISoaFx/GK4fw
 V2vAN+xC9tqL6oESONNZK2GicPHflnvAfafI6FMgpLPMXwFrf8u1kYWuGsr4leO7
 nSUw1/zA/pmY2lityJAGF7FJknaAMaefCYKBVNZ2jpoxVMVlA7U/3PTq+dUPW3XW
 QeX5hs40/MSBO8WzMdqPiyiHJNye5LmnK1CYBLXmy/UDTNBFAy9RplAMIcqfrZdI
 OYsHit/Hwf2FZ6DUxFgd96ySsWppGmSbDlOmoinA++1NRAeaFb4te0q6DBBkGdHI
 JaJC7ozbIPUBlewHaUQfTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735858050; x=
 1735944450; bh=XPWws51Y2N23qrEc5nM4CaJcvPjhLeOxKaf8wN3qGso=; b=Q
 xrW5KJiMp+id1+DnS3mh97D8dDfxkO5OyvzbWFvUX83/76L+lbXCvwYf7D88K7b4
 UZKWa2mcASdQSfjDLv4cbxkA+OnconTC2xz1J8AsOQ/rNI8o6xqmCgvTj+eTJ9md
 lZ3xaUdRQXKcj5+E4QoT7HpSAyXctI5ENp/mv7fyRAXqYdkvA3oZvy2R0MJDjiou
 w0cHJ1nKvRRFcP1TGSqUuQh4gJT6X8M8T10jYNLwErSMtr1thy2nxt2zYGrlqlSv
 L9vWsl+KA9WUleNWN6HRdlMfLI7FNI0679OYKA9mhLypiJxD3+YMV5pqrIwxLOzS
 OwvC+QrNVeR0LgFjlyRvg==
X-ME-Sender: <xms:ghd3Z4MPE9b0It0r-yIhf2vnwg_QzOGKi7vztmFMdsJyN_B_E8jA6w>
 <xme:ghd3Z-9ox3QEROFp_n4b8aEqM_SFUl6-AsdUW3VvToc3vySeR3CC92LimL344xNzl
 C3elw8K_Gv1ustWLXI>
X-ME-Received: <xmr:ghd3Z_S_4tZvfSCP214_6_2538Uf5oPmOwFzeljcBjVzeatFlXtShSDr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeffedgtdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
 necuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhi
 hgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffek
 gedugefhtdduudeghfeuveegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdr
 tghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 eprhhitghhrghrugdrhhgvnhguvghrshhonheslhhinhgrrhhordhorhhgpdhrtghpthht
 ohepghgrohhsohhngheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehqvghmuhdqug
 gvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghl
 lheslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhgrohgsihgsoheslhhoohhnghhsoh
 hnrdgtnhdprhgtphhtthhopehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
 pdhrtghpthhtohepqhgvmhhuqdgrrhhmsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:ghd3Zwtf1AgL8FsFqPDAqbKzvHIsFVaxfbLWhokCEuuvyng3Z73SNA>
 <xmx:ghd3ZwceOPQl9E_fZdR0cb_QbIYvz3FCljGwA9PWzGozMwJEN4FkuA>
 <xmx:ghd3Z02vOagmg9-hz-aE_FyeVcMc5a9CvBybDs9TLf_apx6D35jf_A>
 <xmx:ghd3Z09jqEfRE_BmuMujDMmyrzRMX-vgSP5G-7dRTZVvq03lGtytfQ>
 <xmx:ghd3Z-sMKVQA7-PYFaRNsmyCuZmQx8_vOe06-MUGscGLWLorrtO9WJzC>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jan 2025 17:47:29 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 02 Jan 2025 22:47:21 +0000
Subject: [PATCH v3 1/2] hw/core/loader: Use ssize_t for efi zboot unpacker
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250102-la-direct-kernel-boot-v3-1-40dbc45d633a@flygoat.com>
References: <20250102-la-direct-kernel-boot-v3-0-40dbc45d633a@flygoat.com>
In-Reply-To: <20250102-la-direct-kernel-boot-v3-0-40dbc45d633a@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2264;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=L7Kv7iL9S2a0FpqPR5+0ndbfiBb8lNBMtOX4sdUtfNg=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvRy8Xr3U+84FmlzOZ3Z29d7r1tt2y9WoRam+Sp/7oXz3
 Dj2OvB8RykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEzkfz0jw8LGKWtjl69mNn3W
 1FX8ba9+cNmneScf31U+mxXNPaXMZTXD/6zGjDXudg76Ryo0GnOvrP7odmrPtF6um5OvW4cVHnS
 pYwAA
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

Convert to use sszie_t to represent size internally to avoid
large image overflowing the size.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/arm/boot.c       | 2 +-
 hw/core/loader.c    | 4 ++--
 include/hw/loader.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 5301d8d318cabae63be5f58c3179b49b187f2512..d780c36c47378aebf4e7484c895085e25dd640e6 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -857,7 +857,7 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
     hwaddr kernel_load_offset = KERNEL64_LOAD_ADDR;
     uint64_t kernel_size = 0;
     uint8_t *buffer;
-    int size;
+    ssize_t size;
 
     /* On aarch64, it's the bootloader's job to uncompress the kernel. */
     size = load_image_gzipped_buffer(filename, LOAD_IMAGE_MAX_GUNZIP_BYTES,
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 31593a117171a30dec68c2b8141ba99834e5363d..11b5813f4664f0a825147bb637a0b9fef21625e4 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -886,11 +886,11 @@ struct linux_efi_zboot_header {
  *
  * If the image is not a Linux EFI zboot image, do nothing and return success.
  */
-ssize_t unpack_efi_zboot_image(uint8_t **buffer, int *size)
+ssize_t unpack_efi_zboot_image(uint8_t **buffer, ssize_t *size)
 {
     const struct linux_efi_zboot_header *header;
     uint8_t *data = NULL;
-    int ploff, plsize;
+    ssize_t ploff, plsize;
     ssize_t bytes;
 
     /* ignore if this is too small to be a EFI zboot image */
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 7f6d06b956fa9291e89a1d8b4e0ac44355dc12eb..8985046be40fc43741369a8431cd8e3590d1d72a 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -101,7 +101,7 @@ ssize_t load_image_gzipped_buffer(const char *filename, uint64_t max_sz,
  * Returns the size of the decompressed payload if decompression was performed
  * successfully.
  */
-ssize_t unpack_efi_zboot_image(uint8_t **buffer, int *size);
+ssize_t unpack_efi_zboot_image(uint8_t **buffer, ssize_t *size);
 
 #define ELF_LOAD_FAILED       -1
 #define ELF_LOAD_NOT_ELF      -2

-- 
2.43.0


