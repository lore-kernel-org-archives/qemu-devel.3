Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845EFCFD317
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 12:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNVpT-0001Tb-6n; Mon, 24 Nov 2025 07:38:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1vNVnT-0004Zd-0e
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:36:00 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1vNVnO-0007JO-RF
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:35:57 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42bb288c1bfso2469648f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 04:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763987739; x=1764592539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3+qEsQEA/CfckaiigN0jZROnstk9a/IX7Pb4PVkmi6U=;
 b=NwqYaveuiTxDdJVVeTmW4qn43q9BnXmTlrMEnETnXyk4G95nS1af2TSsHZb8RJJO6i
 +7ymlExH8GiV8RcaIdmrSufjxViOLp3poalt3Cfx1ggJPf4AQL9LnSHxfRHQ0Fv4HS/f
 topFdA/Pc81vn2Ajk87wGxnOYAAaLmrrzrn03jcEoB0LejfR8WTkygP5f/o74mIbnMlQ
 VeDZ97gT5Gpl7SHi64tQLahT3TpeC6pxs2+pv/9nBHlTZYsH61Vge6PlzJfEU1GOijqX
 GKptkVtfD8juaq/uYhwXYEaW6cFmiA/P9U96s3iDGnXcCcZL++aFu/PqYbSVWqEFW28n
 z6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763987739; x=1764592539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3+qEsQEA/CfckaiigN0jZROnstk9a/IX7Pb4PVkmi6U=;
 b=lM4rJ4m5JheWBu6EPMce4aTsV2D4dfU8D1fqOyEkd2soREfVmRIvu1AVzYGP3pOAHE
 SyKkXySSiAyQeQmMCuxVbOfqjbMsUg+x46RdIZtgXWHI2hKfiNWxm+wzC6Qq8YoWXxMh
 RRtlaKFqpM0Fr2YxeqN6TfWGmmaHVhgYqCh8xtpUGCmQFzS24zaUdsKVx4jHA4lj+S5a
 UJ5BayQS1g7QRFbILjMKLzhYZ3gXnHkmV65mtmwRaaWi4/W+2MFTkwTVeOvrvYzXYkLd
 BZ9/d+FusuJMPCijhzKYuGdwujmPlzLvJFe25vm8ombljwRP/HRRhXpqBEZhPGnbIovQ
 DYrg==
X-Gm-Message-State: AOJu0YyKTt9lLnnkdmaht6Y+1RYlcHqFSiJ2Znugr+E5/DkhRX36YO2V
 l9RBxqvePTOf3CylvmyYV5LvRzsPHvy5lvrtZBxke9yRHUwWQwtTgRImbvJ4iB4/
X-Gm-Gg: ASbGncs1AUMZH7ZJzdB6CkW7eKTKQ5NeKVoJlq0TjHsq254URb2lM5wx60Sfv5rXpUZ
 2CT8XxKD/RHRxvzb1L1EilycqqfMb4DnCGkfwgUSZb6r1pv3EOs+4HRyTqQORv0UNZLCVothqfe
 COQPu2LQ9QW+dfNsDMj4GBPxB5d5K4/k2Dqkol3IxboS1FH1qG/G4Tkd1gX81+UPvhBvg502etZ
 3RU3gR5Jondm+Hlj64eAoizaLkwplzFfwRSGSFRGwpxEufLzDv6tdaxHYmK/tF778d24w3B8e+x
 Lc4QWAP1RzlMENAoRMjYEsI+8zoWTIkuebTBzM2luqxyz223SfdcAV2uZ2q7THlKaBTngEs9h8w
 Yfn1EGx+kiIOnJYzxtH3wD5yaN6KP7A5x/bss/EDQyB5MPv9TAz5UO+hhUYRjjsYqsMoi2hftoc
 B9EovwIMwJJKqymsPu09eHEfVVBqGRd8Dzn/IJ/r3ShUYtE29BxB1WxoPAE8GbDBYP7w==
X-Google-Smtp-Source: AGHT+IHZiwZyu+s6uxta//QkEHCbQyEDPEiNPl/7vZStApz9Y6NpEqWa/4eA6g5aQSpWe9AMVj9frg==
X-Received: by 2002:a5d:5c84:0:b0:42b:3ab7:b8a4 with SMTP id
 ffacd0b85a97d-42cc1d0e42cmr12599618f8f.33.1763987738993; 
 Mon, 24 Nov 2025 04:35:38 -0800 (PST)
Received: from daandemeyer-fedora-PC1EV17T (d54C349CA.access.telenet.be.
 [84.195.73.202]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd8c47sm29398449f8f.38.2025.11.24.04.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 04:35:38 -0800 (PST)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>, Paul Burton <paulburton@kernel.org>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daan De Meyer <daan.j.demeyer@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 3/4] Use g_autofree in unpack_efi_zboot_image()
Date: Mon, 24 Nov 2025 13:35:20 +0100
Message-ID: <20251124123521.1058183-4-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251124123521.1058183-1-daan.j.demeyer@gmail.com>
References: <20251124123521.1058183-1-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=daan.j.demeyer@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 hw/core/loader.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 090af59df2..d74e33ceb6 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -882,7 +882,7 @@ struct linux_efi_zboot_header {
 ssize_t unpack_efi_zboot_image(uint8_t **buffer, ssize_t *size)
 {
     const struct linux_efi_zboot_header *header;
-    uint8_t *data = NULL;
+    g_autofree uint8_t *data = NULL;
     ssize_t ploff, plsize;
     ssize_t bytes;
     size_t max_bytes = LOAD_IMAGE_MAX_DECOMPRESSED_BYTES;
@@ -921,12 +921,11 @@ ssize_t unpack_efi_zboot_image(uint8_t **buffer, ssize_t *size)
     bytes = gunzip(data, max_bytes, *buffer + ploff, plsize);
     if (bytes < 0) {
         fprintf(stderr, "failed to decompress EFI zboot image\n");
-        g_free(data);
         return -1;
     }
 
     g_free(*buffer);
-    *buffer = g_realloc(data, bytes);
+    *buffer = g_realloc(g_steal_pointer(&data), bytes);
     *size = bytes;
     return bytes;
 }
-- 
2.51.1


