Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD011C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonS7-0003D0-5V; Tue, 28 Jul 2026 15:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonS4-0003Ae-FU
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:26:56 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonS2-0001Si-Of
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:26:56 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38e3efab7e0so210545a91.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 12:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785266813; x=1785871613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0POncQiCikAc5guGwIPh9olnmP/V6mz621ilQVpgEaE=;
 b=Voa+mYUgkciLtw/hje8JRyZ+48z/bbRmGUuqJEGr22YxYXIG3U+ddcERfHPjbFRrYQ
 j0xTZLMF7eRKHZ1Albwe1lGRekiBDVGgC6bAb1YJOsGXhWudxJm+hi/m+qJGBBOdk+7X
 Cy+z//so7YtmkrW/VBYj6TJrQj5JFc5r+394oMhgsDQOLN/tD6QhfsuzHo/rBACkb901
 NTezi+hKz63fgTGDvdtLFETM8me9KkHBG/4W9outLjxt5HBCULswqILYDhv5jeyCPBmh
 SoLhCJNNemt1L+zzIU78ZwlbU33Cj712kwant93o05Q9U4BCJw/4Lp0plE0tS3RTRSsY
 7C3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266813; x=1785871613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0POncQiCikAc5guGwIPh9olnmP/V6mz621ilQVpgEaE=;
 b=STgaPIKFYge14AUCazYS/Ek66JUryimzFqG+zOdB1Lg6jIrkM1G+HDORjPQ81K1E02
 P2ZXdvBjBdOA6mtu/B+quJkqlTptKmip/SKdRxTwJPR7T8gga7u0kR7XnGEaytGDRUop
 pyRsaUZLpuRYqjX5HiiNieW2d8B02wjAlaFLl3ZiE8k+/oqbuddVeDv1kHu5xJMzBkAz
 tmkkdzUZ9fvMEA8PnpahyILRHzu2RCUZ4C1zu0EpVPAQp4fPXAZ/HRqJlvMFr3XpKMe6
 DMGsq7OlqRbzMzOLdZ5BA0UAzxGRBaEOGLR7Xjp5rxCmPEb1QhoFFiWTo11qqOD3uyNc
 Y3aA==
X-Gm-Message-State: AOJu0Yy2+z6w++e06B1BYCnxuPB7atVGOSbu3x/7yqbAkTFKnBvH1u9h
 oGYhWczQI/B2LtXCRs6OrKzMe5gXgQVEoJvR1GKm/i5Rwfhb0A8dEOKDy7QZ2F7z0wU=
X-Gm-Gg: AR+sD13a7uTnsCqWqHPVLywlhWZ1rmf97Dw6OZrPm6H0dG7lmeEE5pXtqO0N+2Tehca
 TYN+Q0ZF8HVzKkTACRlnJiyTm1RvtcCvYZRWuhugDPtP+Gh4iEBPKcjlICCqtSuxW34DvYrpkOq
 c2yyo3N3PthDHnkbmt/SLIS5EkE+G+JjGInd2IwxsqTUB5SmGA0/rabuTM5m+MGCU1vM8S3Cot5
 T4594fuUKGOOHRGQ4ueQZdU6mwBshH/2sD5UGfdjGXlucFfZ9DYMm6dzHs1mKnR2jGDhiZUM3XM
 bj4qsVQuBVWvDbwiD/ng9IbTb0xz93Nat4dt4Qk76i47z8VcAv3Dc9lY4NrIIY57vahktfdMry1
 e7zJlLPUqHa9BPz/mkQwgEH1nI0L+n7GOmbApWrkAWojf5SuvoLindcoTYbjiVLKXUVIbIw/H3v
 AVxmxlH84O3O8UdZcbCcFc0v/Zbl503ayB9WGZrW4=
X-Received: by 2002:a17:90b:1b05:b0:384:927f:3db9 with SMTP id
 98e67ed59e1d1-38f6a2069fbmr3543414a91.1.1785266813372; 
 Tue, 28 Jul 2026 12:26:53 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:26:52 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 09/24] hw/core/loader: Add a ROM loader notifier
Date: Tue, 28 Jul 2026 13:26:15 -0600
Message-ID: <20260728192630.240375-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x102d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Add a function to register a notifier that is invoked when ROMs get
loaded into guest memory.

It will be used by Arm confidential guest support, in order to register
all blobs loaded into memory with KVM, so that their content is moved
into Realm state and measured into the initial VM state.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/core/loader.c         | 15 +++++++++++++++
 include/hw/core/loader.h | 17 +++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 5cbfba0a86d2..b3d769bec5cb 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -74,6 +74,8 @@
 #endif
 
 static int roms_loaded;
+static NotifierList rom_loader_notifier =
+    NOTIFIER_LIST_INITIALIZER(rom_loader_notifier);
 
 /* return the size or -1 if error */
 int64_t get_image_size(const char *filename, Error **errp)
@@ -1201,6 +1203,11 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
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
@@ -1242,6 +1249,7 @@ ssize_t rom_add_option(const char *file, int32_t bootindex)
 static void rom_reset(void *unused)
 {
     Rom *rom;
+    RomLoaderNotifyData notify;
 
     QTAILQ_FOREACH(rom, &roms, next) {
         if (rom->fw_file) {
@@ -1290,6 +1298,13 @@ static void rom_reset(void *unused)
         address_space_flush_icache_range(rom->as, rom->addr, rom->datasize);
 
         trace_loader_write_rom(rom->name, rom->addr, rom->datasize, rom->isrom);
+
+        notify = (RomLoaderNotifyData) {
+            .addr = rom->addr,
+            .len = rom->datasize,
+            .as = rom->as,
+        };
+        notifier_list_notify(&rom_loader_notifier, &notify);
     }
 }
 
diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
index d9431e8a8d12..94cf6ad2e26b 100644
--- a/include/hw/core/loader.h
+++ b/include/hw/core/loader.h
@@ -342,6 +342,23 @@ void *rom_ptr_for_as(AddressSpace *as, hwaddr addr, size_t size);
 ssize_t rom_add_vga(const char *file);
 ssize_t rom_add_option(const char *file, int32_t bootindex);
 
+typedef struct RomLoaderNotifyData {
+    /* Address of the blob in guest memory */
+    hwaddr addr;
+    /* Length of the blob */
+    size_t len;
+    /* Address space of the blob */
+    AddressSpace *as;
+} RomLoaderNotifyData;
+
+/**
+ * rom_add_load_notifier - Add a notifier for loaded images
+ *
+ * Add a notifier that will be invoked with a RomLoaderNotifyData structure for
+ * each blob loaded into guest memory, after the blob is loaded.
+ */
+void rom_add_load_notifier(Notifier *notifier);
+
 /* This is the usual maximum in uboot, so if a uImage overflows this, it would
  * overflow on real hardware too. */
 #define UBOOT_MAX_DECOMPRESSED_BYTES (64 << 20)
-- 
2.43.0


