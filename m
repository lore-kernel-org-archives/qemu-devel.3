Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F3FC0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyEQ-0001Rh-Vp; Fri, 31 Jan 2025 16:07:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyEL-0001CW-2q
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:13 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyEG-0007vW-Jg
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:11 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38a34e8410bso1264407f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357627; x=1738962427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j8FUzDdCW0bQyWxAQmrQ+3uNWdzAhUBa/G3VnWeo8GM=;
 b=lI2fLE6imWo5IQxv19UGTtisE8RrMo8DMUse1AFjOCalUwnS9VR79KLgqIIAwDYMJg
 OWBy72apQyx2VjmgfmrM63pnevWnqpT6vPC9aOWNUsN8eHOYMLvj1a6eVlVI4isRhxl1
 8zvdeu+tmsrLcJaD38SopkapEz274VHTbNTVmvUNUFiJD5UFr3xMTRq6SIDYtlsAPiMl
 W1YO2ZMcrdDwuL7zfhfTWgtL8Xjd7MiNbUG9oWY/Uc9Gvr9qs8KSV9Wd796Hf+mNr8hv
 Uqlrq6xeTy7GZNaBb1p0Q9y32M79tncc2IeWkZxD2NTtmqZcmC6gIuXC8VQgR9Nogg4i
 eFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357627; x=1738962427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j8FUzDdCW0bQyWxAQmrQ+3uNWdzAhUBa/G3VnWeo8GM=;
 b=bRzYi+nC+w+jOhvPjKSxX8vXpNEGexRZJFLIRgsFD6Kp1KKemvPoKVvUaaQCwYtkVv
 IdSFPxoQ/8BBrxG7Z8AOsH4rnW23IwvsuWCzfs5Y8HCsV0cy3ygia6OisRxPliTVOQlb
 E0GfyLjP4HVbJYEP9J1HQ/3VeuDwQ0rS5ZnmGeY0ewzZT3atF1DRtGFcPfkcjBh9MNzx
 Ta/9gYIiKSaGxex9FuYLZoPw+TpG+JOMjN9F32aQh709/lJp1ieF3F9r0fx+xmUVVjJd
 SkV7o+uOkGNkJUyJvXJryCZGgDarDVtHDaECVgiaV4hPjsPuBclho/pRe/MIZL6jWvX+
 1oJg==
X-Gm-Message-State: AOJu0YzWhDLC7D7dCXILAcxpSDR+ZeYTl8XncFl3BihyD3A/qen+nffz
 AQS6CI6gc3Wqfp/z/a4OQpQBC3jUO80O40pxI+2/fRVzRbn0dtqemq7SgYtW9IVStcGHweZ6dUV
 yjs4=
X-Gm-Gg: ASbGnct3xy8+X4CKzlQ4uaUHnM8CZVU8Wz/JQF02GFmAlriT6a4w9BrA59IagoFLsnK
 F/X1d7FWL/L6l337GmWCea4KYxRiy4SjfRX03quHOxKOyuNPCtV4FkpKm6B+K+O0NbKCrw79XEx
 6S4kmcOq3Nap+yEgipUkfjXVeL4NTV8fK1JD74hitzFLxJBnVBwwoGzNwYvwEACWJtCUWVrn11s
 8oRk+cOo9IEzdxHRPuV4XtvJK3e8PR02F6iukZe/17MSwWab8CmUDliMBJ/diAZiVjdw+LFX85x
 8P9K1lyaISiAu4ZiQ5Jdfp7cNombmDdnDdB/B+LsNNculo/qtxrWBigMafVXfCJKPA==
X-Google-Smtp-Source: AGHT+IHWPdbXS7/NH8WW+enBRboTRIjcjp8E08g9wjVCFS/dyGgXL7eWJMoYRgQ3BPYW3lzB7piung==
X-Received: by 2002:adf:cf06:0:b0:38b:dc3d:e4be with SMTP id
 ffacd0b85a97d-38c520beb5dmr9219813f8f.51.1738357626761; 
 Fri, 31 Jan 2025 13:07:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc13139sm101495425e9.3.2025.01.31.13.07.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:07:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 21/36] hw/loader: Remove unused load_elf_ram()
Date: Fri, 31 Jan 2025 22:05:04 +0100
Message-ID: <20250131210520.85874-22-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Last use of load_elf_ram() was removed in commit 188e255bf8e
("hw/s390x: Remove the possibility to load the s390-netboot.img
binary"), remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20250127113824.50177-3-philmd@linaro.org>
---
 include/hw/loader.h | 14 +-------------
 hw/core/loader.c    | 16 +---------------
 2 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/include/hw/loader.h b/include/hw/loader.h
index 8985046be40..9bb34e6f062 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -155,20 +155,8 @@ ssize_t load_elf_ram_sym(const char *filename,
                          int clear_lsb, int data_swab,
                          AddressSpace *as, bool load_rom, symbol_fn_t sym_cb);
 
-/** load_elf_ram:
- * Same as load_elf_ram_sym(), but doesn't allow the caller to specify a
- * symbol callback function
- */
-ssize_t load_elf_ram(const char *filename,
-                     uint64_t (*elf_note_fn)(void *, void *, bool),
-                     uint64_t (*translate_fn)(void *, uint64_t),
-                     void *translate_opaque, uint64_t *pentry,
-                     uint64_t *lowaddr, uint64_t *highaddr, uint32_t *pflags,
-                     int big_endian, int elf_machine, int clear_lsb,
-                     int data_swab, AddressSpace *as, bool load_rom);
-
 /** load_elf_as:
- * Same as load_elf_ram(), but always loads the elf as ROM
+ * Same as load_elf_ram_sym(), but always loads the elf as ROM
  */
 ssize_t load_elf_as(const char *filename,
                     uint64_t (*elf_note_fn)(void *, void *, bool),
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 4dfdb027eee..ead10fb6cb5 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -425,26 +425,12 @@ ssize_t load_elf_as(const char *filename,
                     uint64_t *highaddr, uint32_t *pflags, int big_endian,
                     int elf_machine, int clear_lsb, int data_swab,
                     AddressSpace *as)
-{
-    return load_elf_ram(filename, elf_note_fn, translate_fn, translate_opaque,
-                        pentry, lowaddr, highaddr, pflags, big_endian,
-                        elf_machine, clear_lsb, data_swab, as, true);
-}
-
-/* return < 0 if error, otherwise the number of bytes loaded in memory */
-ssize_t load_elf_ram(const char *filename,
-                     uint64_t (*elf_note_fn)(void *, void *, bool),
-                     uint64_t (*translate_fn)(void *, uint64_t),
-                     void *translate_opaque, uint64_t *pentry,
-                     uint64_t *lowaddr, uint64_t *highaddr, uint32_t *pflags,
-                     int big_endian, int elf_machine, int clear_lsb,
-                     int data_swab, AddressSpace *as, bool load_rom)
 {
     return load_elf_ram_sym(filename, elf_note_fn,
                             translate_fn, translate_opaque,
                             pentry, lowaddr, highaddr, pflags, big_endian,
                             elf_machine, clear_lsb, data_swab, as,
-                            load_rom, NULL);
+                            true, NULL);
 }
 
 /* return < 0 if error, otherwise the number of bytes loaded in memory */
-- 
2.47.1


