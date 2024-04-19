Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB520C071FD
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqgR-0002Ky-Vr; Fri, 19 Apr 2024 12:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqef-0001Dj-Qf
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:02 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqeZ-00017E-O5
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:01 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-34a32ba1962so1148564f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 08:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713542394; x=1714147194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=blRxAD//qWk7awT/WiqSSIKjaOzzlNxFM9Csitf6cJ0=;
 b=EXUi66CPIKd4xJAss7y15jFi5UVbWQIRHS4EGuT/yY7V8XIL++i4zPlrgytOg63ajW
 saccqyxKcK56vWdVi8jCFvCqNRId4/pz6bTJw9kevivzMl5WiJS0u+Rgw2FGEzMPeGNk
 cp1q5UjYLI9Y1GsX22XbVAp8kqX4hKT1lyaUU+VNW5fE3q9ZVBeG8OliER9PH2+bgm1k
 7NDqrTdQNXW2UE1zW99i74cCpA9qY6dEHL6m55D/8T5/Fi28eePEGOldxsMYVHo5exVR
 6cXxr0YGcCR63aLiryqdBjiNuyNB8zyThA9ayO9ZAqWZrAH2dGM7Bs2vhMhfjSWHaxiv
 2tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713542394; x=1714147194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=blRxAD//qWk7awT/WiqSSIKjaOzzlNxFM9Csitf6cJ0=;
 b=KW0g93BmRxPBA2VQ4+cj08nL5DceU3MK4sG6zEYbY7MqN9QzyGjar6sWJxZ3VTmPRR
 Yvn6fLU5MawdKxEcXwfqsHn942M6zZOU/KVice/TfyagyDe5DdJn3hSubanzUZwwMz77
 kCyYJnBtrJDyBvWUHM8IQLngptaGVprkkeF4d+mmOrkRIFgySrWXHb2nA9wsPCRBggqe
 gB4KeBhJM+uSzpud3SXVqZhwbaIyM3LJEhe0FCxMVnJMcYwEaSjuwbp50JjyH6L/vk9j
 +WXiHjUCeTMlOba4AsCYxNYsKd9D3hGyr8mi0CLwxoEWaOpadypP55kGVkC9JwbsCVDn
 xKtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtG7yl/E/w+ZFEuGpKdm2TcVPthCtDDEqWX5oMT1pvua5y1KFIWPuSPjT/6yUlOzFbprXIKFYaA3G9vYzl+ImQVqype5c=
X-Gm-Message-State: AOJu0Yz3lWGSDpdh5s3cI3GWqlVP1Hw3LOnFxAJ6EOyf83g0QtI2SXLt
 SH8sOzYFadN5wBf50TIOoGeJG+lt7HRA0ot/ofTZiitv37EKbni41dG+ifA2gNc=
X-Google-Smtp-Source: AGHT+IHzG9aZ9yLn4f5iy1UKnAuX/xeyHRxk/T1DgICVc15UBelbDjjnn3z1bs1ndgp8yIOgSrqAjQ==
X-Received: by 2002:a5d:4a81:0:b0:343:8d1b:b12d with SMTP id
 o1-20020a5d4a81000000b003438d1bb12dmr1452401wrq.46.1713542394163; 
 Fri, 19 Apr 2024 08:59:54 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 p13-20020adfe60d000000b00349b73143e7sm4793089wrm.75.2024.04.19.08.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 08:59:53 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: philmd@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 11/22] hw/core/loader: Add ROM loader notifier
Date: Fri, 19 Apr 2024 16:56:59 +0100
Message-ID: <20240419155709.318866-13-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419155709.318866-2-jean-philippe@linaro.org>
References: <20240419155709.318866-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x429.google.com
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
all blobs loaded into memory with KVM, so that their content is part of
the initial VM measurement and contribute to the guest attestation.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v1->v2: new
---
 include/hw/loader.h | 15 +++++++++++++++
 hw/core/loader.c    | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/hw/loader.h b/include/hw/loader.h
index 8685e27334..79fab25dd9 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -356,6 +356,21 @@ void hmp_info_roms(Monitor *mon, const QDict *qdict);
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
index b8e52f3fb0..4bd236cf89 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -67,6 +67,8 @@
 #include <zlib.h>
 
 static int roms_loaded;
+static NotifierList rom_loader_notifier =
+    NOTIFIER_LIST_INITIALIZER(rom_loader_notifier);
 
 /* return the size or -1 if error */
 int64_t get_image_size(const char *filename)
@@ -1209,6 +1211,11 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
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
@@ -1250,6 +1257,7 @@ ssize_t rom_add_option(const char *file, int32_t bootindex)
 static void rom_reset(void *unused)
 {
     Rom *rom;
+    RomLoaderNotify notify;
 
     QTAILQ_FOREACH(rom, &roms, next) {
         if (rom->fw_file) {
@@ -1298,6 +1306,13 @@ static void rom_reset(void *unused)
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
2.44.0


