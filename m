Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563CED59D6A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfFL-0005FZ-EL; Mon, 25 Nov 2024 14:59:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFB-00054b-PC
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:37 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfF4-0004mQ-Lr
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:37 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-382325b0508so3216491f8f.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732564769; x=1733169569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JcJPrbjMCLmh0eNMSHwL1G2MB7wFRr0T2Y0cUgmEayE=;
 b=eMo1bxiMPDGqZSG/Uw39HPRSZ7h8wREm/Jgxf1+iA6btKsaE/DknIuKkuE/wM8DZDf
 vZfuwpm8UrgemmaDDl3C05i/gV5yO62hjK/vYVLzcuXP3vV1PDkcJHz7+yK5CAHd3VCl
 eXh7NAtrYx28y7+FlGvINpn+FZcQd6vzfCeTviWzG3Q2Ox1Ttr4I91CPqviKkutVZaE1
 omod1SMRGE85FzDdO6dyavzEZcrD24b9TPTHfzM+QvoLy4YnssiWgHg7SgmRv5r3SMIO
 nwex9ZlLeK1/alCQ7ZvA89JrI3Y3esd+6OqPdtAHNzg8Dm+DtYmC2nD/RQu0F20TxViE
 fu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732564769; x=1733169569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JcJPrbjMCLmh0eNMSHwL1G2MB7wFRr0T2Y0cUgmEayE=;
 b=e+B14OJ/izMgxvZNgwRaSk2c9iETbkkadrJ/0R/B1tYGD//sFDjgp7sxpAtUk78a4X
 4y/Ia7fXCnsHTdXo20xIsCnM2VMsNj7rLETs1+Mt727CjocZ+IkWZVbk/xUd/9ShH1SI
 LuEL6vwmBXD5SIqPFPXkcB8xjOBvHjN/lb89nHigDLlkHXKO/6y2BELSbjkETLJIcFJ5
 sC+m8t2Onb3uRId2Kx7m//YvWS037lYS8bMorGSKAelzVDOjFExqkJ4OZb4thDQHDBNe
 qZkR7jvA4gtdEZNLtS6O7NJ0xOJM9cLF9pZ6+UiuTTtZr38ixlFbbTwGtBNTkEchRtz4
 134Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8Yg6/6EfUhP+I/h4fW1k7q5P9Dl/nPHEA91yRS+U5sLNMjPet/8nDz/HpjdHtVqabms4sSmoiMy2t@nongnu.org
X-Gm-Message-State: AOJu0Yw1mpGR/kW+i6KC/YZEm7qR5RvRZcFZMhZTsbEmey6jYSc6N/0J
 rrQoIcu7U0NA5JecnqfxFtzcHSUNanmy125cOpEim1KLlBZYcfjcoKNSX2Zupnw=
X-Gm-Gg: ASbGncuTpAGQUCGBocMJ69SGzTZfhUZJ8ek9L22vBkGUD5mHAWRQ+R3cw8DRZSOlWX8
 VlBkSl7QAaAeut+tjWNVOkppbbVQr5onB+lYdrL978lwVcVI1nno3o8pOGdHRZ4pBAbS1nqLA0q
 3/VHT961+8U9m5i+D7gDqqHnFZKBACg3b9OC04x7aAG/aXleiv8C6C/yv0JgFI250ualqvw4UID
 iGI8EmehKTvdPzdcWZIrvAxHijN27sGEsIbTx5b9hJxLYKSiSA7+IwBASqOLuAOyMmi
X-Google-Smtp-Source: AGHT+IEg6YuxoILvMPLYuVly61vnvw6FfSnv0Ejz5HnIAwlyt73nF1r2uz5gua2PinPmEU6MzS2shQ==
X-Received: by 2002:a05:6000:1fab:b0:382:4aa0:e728 with SMTP id
 ffacd0b85a97d-38260b46dd6mr12738762f8f.1.1732564769159; 
 Mon, 25 Nov 2024 11:59:29 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm11237971f8f.109.2024.11.25.11.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 11:59:28 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 08/26] hw/core/loader: Add ROM loader notifier
Date: Mon, 25 Nov 2024 19:56:07 +0000
Message-ID: <20241125195626.856992-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125195626.856992-2-jean-philippe@linaro.org>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add a function to register a notifier, that is invoked after a ROM gets
loaded into guest memory.

It will be used by Arm confidential guest support, in order to register
all blobs loaded into memory with KVM, so that their content is moved
into Realm state and measured into the initial VM state.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/hw/loader.h | 15 +++++++++++++++
 hw/core/loader.c    | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/hw/loader.h b/include/hw/loader.h
index 7f6d06b956..0cd9905f97 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -353,6 +353,21 @@ void *rom_ptr_for_as(AddressSpace *as, hwaddr addr, size_t size);
 ssize_t rom_add_vga(const char *file);
 ssize_t rom_add_option(const char *file, int32_t bootindex);
 
+typedef struct RomLoaderNotify {
+    /* Parameters passed to rom_add_blob() */
+    hwaddr addr;
+    size_t len;
+    size_t max_len;
+} RomLoaderNotify;
+
+/**
+ * rom_add_load_notifier - Add a notifier for loaded images
+ *
+ * Add a notifier that will be invoked with a RomLoaderNotify structure for each
+ * blob loaded into guest memory, after the blob is loaded.
+ */
+void rom_add_load_notifier(Notifier *notifier);
+
 /* This is the usual maximum in uboot, so if a uImage overflows this, it would
  * overflow on real hardware too. */
 #define UBOOT_MAX_GUNZIP_BYTES (64 << 20)
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 31593a1171..759a62cf58 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -67,6 +67,8 @@
 #include <zlib.h>
 
 static int roms_loaded;
+static NotifierList rom_loader_notifier =
+    NOTIFIER_LIST_INITIALIZER(rom_loader_notifier);
 
 /* return the size or -1 if error */
 int64_t get_image_size(const char *filename)
@@ -1179,6 +1181,11 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
     return mr;
 }
 
+void rom_add_load_notifier(Notifier *notifier)
+{
+    notifier_list_add(&rom_loader_notifier, notifier);
+}
+
 /* This function is specific for elf program because we don't need to allocate
  * all the rom. We just allocate the first part and the rest is just zeros. This
  * is why romsize and datasize are different. Also, this function takes its own
@@ -1220,6 +1227,7 @@ ssize_t rom_add_option(const char *file, int32_t bootindex)
 static void rom_reset(void *unused)
 {
     Rom *rom;
+    RomLoaderNotify notify;
 
     QTAILQ_FOREACH(rom, &roms, next) {
         if (rom->fw_file) {
@@ -1268,6 +1276,13 @@ static void rom_reset(void *unused)
         cpu_flush_icache_range(rom->addr, rom->datasize);
 
         trace_loader_write_rom(rom->name, rom->addr, rom->datasize, rom->isrom);
+
+        notify = (RomLoaderNotify) {
+            .addr = rom->addr,
+            .len = rom->datasize,
+            .max_len = rom->romsize,
+        };
+        notifier_list_notify(&rom_loader_notifier, &notify);
     }
 }
 
-- 
2.47.0


