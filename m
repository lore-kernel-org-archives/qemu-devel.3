Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B10C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 19:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXQY4-0006HE-7o; Mon, 13 Jan 2025 14:56:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQXq-0006Ez-5c
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:56:18 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQXo-0007Tp-CO
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:56:17 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso2522618f8f.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 11:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736798174; x=1737402974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TyQ/od43vNMa0q6wCQy5fR9/uoB2I9o4Ue/+fqk0SAo=;
 b=ehqSbI4u8qpOqm9Rs2y1bk39pYtzRIOnQeOHb9hopjxZRrSjXaYRjx7yJexBgjPU1h
 S3T5jvOvCGo7BslQfa1saH0Y4/x+So3rztMkdDnjT1zUegAfPChuSJ5A6WpvOj80Q/VO
 LaysfMqKmXxpxkLBocaT9imvAObpsbIpyT/3YnY56nWPoXivIfh2XWag2ceLe3Qxe6jA
 IZoS2FuOJf/7r1f+L7AHKRzuGQ4y4mK0tWCfBmT2GZXz23q9PfahM2GdoFsnTFnHwPpo
 e9GXcU1ItWk9Z69CcUyRves62YLSdWyeaKmAhXRXRljhSBdVTAgxdRu8iAP+GHKLReQN
 NoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736798174; x=1737402974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TyQ/od43vNMa0q6wCQy5fR9/uoB2I9o4Ue/+fqk0SAo=;
 b=u0v0sN+1p7JY05AQcehF7MkuYWrpwYh55G1O9vx3MpmbDvF37M1x79O4ZjgPzE7jiu
 TsvSyvYl7K6IdiNxHVRYyr/1tNSv4b/27uejKkOYaglbH3o8qX0vh7onZVhYefZ2iJyi
 e88H/l6M/ThFswwmK3McLCQEjNKKtQ5WKYWdQsxBYtwmN+rfYjm4c7Cml0JIJjNz4xDI
 bzysWBj94LG68oS+EN0/65UUX88GE1iknY2tWMFbmxftr7sFS7Bvels4raIVqrQqAuz1
 me9YHxoHx9N6MNMFqpl/OA5EjYZpkLwJjVrvR2GHXM1AYdWM2m2D0PP56l02wWPRrhV/
 Vrgg==
X-Gm-Message-State: AOJu0YzSlfrEYwn9K3GXq4cjMFFl2F776hj/RnFFFRBKTdtsl+c+6c4/
 8a39fT3YePwaKtyWoMY7ps5tAA9DzGFcGVLSEo4hY5duheMcJLU9deTUU2yQ5mCGqcA4BMQZRYV
 HjX0=
X-Gm-Gg: ASbGncvsM4PRLlfjUK8Ig/Zz61sStMgaY3uZlSfEtciVhkn/TT62/If3pZgWOouWSh4
 2t+egmfvoXbUoDcfOCkn6TdqcpdtWW0ngu/EP0A0rIxZt+2exbgbRYX6tIlN0ql2Rpx+xHZgJHx
 3gd5Bfj/x8MsvRKTbUXg6Ffgd/wDr9tlqHRXntck1z5TX2ehpxPeW+XFDvUDhZoZZUtUox/8TRt
 TeIY4hwGhNSbFXSe7begqPzltqpbqh9limmqklBGab3naOoU5NIrEycI712gIwf1uwj1D2BWkQt
 CvCb25gHoggVaaUV2MVaacoLqtXc8Bk=
X-Google-Smtp-Source: AGHT+IGNn+UfxLKPZwpG0GXJg7BicQb0Qlx8ReMKL2A0tUelrVIXG7Lm8XvghQvEpOdC5pZZnrnBnw==
X-Received: by 2002:a5d:47c4:0:b0:385:f69a:7e5f with SMTP id
 ffacd0b85a97d-38a87308ae0mr24633188f8f.38.1736798173175; 
 Mon, 13 Jan 2025 11:56:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38d008sm13296048f8f.59.2025.01.13.11.56.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 11:56:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v2 09/19] hw/mips/bootloader: Document public API
Date: Mon, 13 Jan 2025 20:55:15 +0100
Message-ID: <20250113195525.57150-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113195525.57150-1-philmd@linaro.org>
References: <20250113195525.57150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Document bl_gen_write_u[32,64,long]() and bl_gen_jump_[to,kernel]()
prototypes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/mips/bootloader.h | 50 ++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/include/hw/mips/bootloader.h b/include/hw/mips/bootloader.h
index c32f6c28356..8533a16ca62 100644
--- a/include/hw/mips/bootloader.h
+++ b/include/hw/mips/bootloader.h
@@ -11,7 +11,30 @@
 
 #include "exec/cpu-defs.h"
 
+/**
+ * bl_gen_jump_to: Generate bootloader code to jump to an address
+ *
+ * @ptr: Pointer to buffer where to write the bootloader code
+ * @jump_addr: Address to jump to
+ */
 void bl_gen_jump_to(void **ptr, target_ulong jump_addr);
+
+/**
+ * bl_gen_jump_kernel: Generate bootloader code to jump to a Linux kernel
+ *
+ * @ptr: Pointer to buffer where to write the bootloader code
+ * @set_sp: Whether to set $sp register
+ * @set_a0: Whether to set $a0 register
+ * @set_a1: Whether to set $a1 register
+ * @set_a2: Whether to set $a2 register
+ * @set_a3: Whether to set $a3 register
+ * @sp: Value to set $sp to if @set_sp is set
+ * @a0: Value to set $a0 to if @set_a0 is set
+ * @a1: Value to set $a0 to if @set_a1 is set
+ * @a2: Value to set $a0 to if @set_a2 is set
+ * @a3: Value to set $a0 to if @set_a3 is set
+ * @kernel_addr: Start address of the kernel to jump to
+ */
 void bl_gen_jump_kernel(void **ptr,
                         bool set_sp, target_ulong sp,
                         bool set_a0, target_ulong a0,
@@ -19,8 +42,35 @@ void bl_gen_jump_kernel(void **ptr,
                         bool set_a2, target_ulong a2,
                         bool set_a3, target_ulong a3,
                         target_ulong kernel_addr);
+
+/**
+ * bl_gen_write_ulong: Generate bootloader code to write an unsigned long
+ *                     value at an address
+ *
+ * @ptr: Pointer to buffer where to write the bootloader code
+ * @addr: Address to write to
+ * @val: Value to write at @addr
+ */
 void bl_gen_write_ulong(void **ptr, target_ulong addr, target_ulong val);
+
+/**
+ * bl_gen_write_u32: Generate bootloader code to write a 32-bit unsigned
+ *                   value at an address
+ *
+ * @ptr: Pointer to buffer where to write the bootloader code
+ * @addr: Address to write to
+ * @val: Value to write at @addr
+ */
 void bl_gen_write_u32(void **ptr, target_ulong addr, uint32_t val);
+
+/**
+ * bl_gen_write_u64: Generate bootloader code to write a 64-bit unsigned
+ *                   value at an address
+ *
+ * @ptr: Pointer to buffer where to write the bootloader code
+ * @addr: Address to write to
+ * @val: Value to write at @addr
+ */
 void bl_gen_write_u64(void **ptr, target_ulong addr, uint64_t val);
 
 #endif
-- 
2.47.1


