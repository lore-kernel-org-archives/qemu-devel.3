Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56F7C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 15:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7z6q-00051u-E6; Fri, 17 May 2024 11:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7z6o-0004zo-H3
 for qemu-devel@nongnu.org; Fri, 17 May 2024 11:02:58 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7z6b-0005OP-FC
 for qemu-devel@nongnu.org; Fri, 17 May 2024 11:02:58 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56e1f3462caso5177698a12.3
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 08:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715958160; x=1716562960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=prOBORLrKnIubByGiemAya5YeM7dN+tEWn5fMLTmbm4=;
 b=BTAOo7MVw8FmgeeffQ5hpmckUijnZeFsyXxMTUxz6jIZ8+zys4Su+GL5AfLV7hWKRD
 MUrmybui38oMHeug1kb5PawjUPoNOghaZuvCxK1zG1wissDNrwydBIONp8VJg/AxElfG
 3NWtypXutXR5oFzwGiXfntrBdTE/9pAff6/BhtLNz+zbD/sRRVmXh6UIClCDDFV4rfP8
 Diup4kiMbGIw0Gvxv7hUeVWBGOUlOW8psl4JHWLLenB0IjhLzmj+HAVCfcDbNnP8q/aD
 YhJ2MeGlEY/lCe6jnQiN/auZyOghXEh3WEjo5AHilkT0Zzx1Lea6xH9T87QKVOvcRK/N
 CPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715958160; x=1716562960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=prOBORLrKnIubByGiemAya5YeM7dN+tEWn5fMLTmbm4=;
 b=n9d0uCzGDqJsvsglGSpWfVa0mVfgkvbhvcQplGyZ/XNCBEqtRezR/1u8LXETyKq1/C
 ssY+jGxzFYNaR4ABmZGab+6CRln/nt+QkZ2mWtDQxIEinW5sUftOFojwKejMaHw4eKEI
 TJBsZWEuI2K87HGHZXmcWTRhXxRl4rbuYti2UpXZCVsU02bQ+HPqrIU9vH7k1iZgbUJx
 bfZgyk7zbHchbUU2A6SJaajsKqXNixM7wkCZzb7h10eYVVRFj7w+1h44zWV2mhkn13n4
 TL/n3PfU6VCm37KJetz25/TdvpbRbuQHK4CVY8OTAxrZB9yC45Bb+p6mAlrLcHVygyrF
 ynqA==
X-Gm-Message-State: AOJu0YyZKSOSCH2YMjMcA2Gm3hG4h4voRuuSLJrwjrCxnRjiYas2HDqv
 lWOCqQi0ULclXjHb62lNcFRbTb1ak1S85fQiTWv1i0CPvBHAmimrJqf0kMzf1qBf7WxMR4e6uLu
 t
X-Google-Smtp-Source: AGHT+IFWq5uucdNawk9X0TjU9HFvst4iiS3xx9YJtO5/wDWr0sbwoo05FOLa8VSiWC2IIXsB1plt2g==
X-Received: by 2002:a50:d745:0:b0:572:4702:2227 with SMTP id
 4fb4d7f45d1cf-5734d6de22dmr17150495a12.35.1715958160001; 
 Fri, 17 May 2024 08:02:40 -0700 (PDT)
Received: from localhost.localdomain ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733c322c61sm12370190a12.86.2024.05.17.08.02.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 May 2024 08:02:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/5] hw/pflash: fix block write start
Date: Fri, 17 May 2024 17:02:24 +0200
Message-ID: <20240517150227.32205-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240517150227.32205-1-philmd@linaro.org>
References: <20240517150227.32205-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Gerd Hoffmann <kraxel@redhat.com>

Move the pflash_blk_write_start() call.  We need the offset of the
first data write, not the offset for the setup (number-of-bytes)
write.  Without this fix u-boot can do block writes to the first
flash block only.

While being at it drop a leftover FIXME.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2343
Fixes: 284a7ee2e290 ("hw/pflash: implement update buffer for block writes")
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240516121237.534875-1-kraxel@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/block/pflash_cfi01.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 1bda8424b9..c8f1cf5a87 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -518,10 +518,6 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
             break;
         case 0xe8: /* Write to buffer */
             trace_pflash_write(pfl->name, "write to buffer");
-            /* FIXME should save @offset, @width for case 1+ */
-            qemu_log_mask(LOG_UNIMP,
-                          "%s: Write to buffer emulation is flawed\n",
-                          __func__);
             pfl->status |= 0x80; /* Ready! */
             break;
         case 0xf0: /* Probe for AMD flash */
@@ -574,7 +570,6 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
             }
             pfl->counter = value;
             pfl->wcycle++;
-            pflash_blk_write_start(pfl, offset);
             break;
         case 0x60:
             if (cmd == 0xd0) {
@@ -605,6 +600,9 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
         switch (pfl->cmd) {
         case 0xe8: /* Block write */
             /* FIXME check @offset, @width */
+            if (pfl->blk_offset == -1 && pfl->counter) {
+                pflash_blk_write_start(pfl, offset);
+            }
             if (!pfl->ro && (pfl->blk_offset != -1)) {
                 pflash_data_write(pfl, offset, value, width, be);
             } else {
-- 
2.41.0


