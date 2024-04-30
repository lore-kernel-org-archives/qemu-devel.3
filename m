Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6042C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 15:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1p4q-00018l-9B; Tue, 30 Apr 2024 11:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s1p4R-0000zI-5h
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:07:03 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s1p4M-00009q-9T
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:07:02 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-572669fd9f9so5013193a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 08:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714489616; x=1715094416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BnnlXuw4VnJp8XUprbE2Rl/GS20bsAEHdcUkL5+ANKg=;
 b=N5h5QNbOaM+oFrQOTnt0ODiygJc9UfvVeqexuFWuhHiPa9V+y6SAf8wqSl8Oj0/7wF
 sF0/BMtFWWbrEWjtQsrjWYWb2ECqrUhrgmLLDPb8hfgnZ/W/t2wKYItnnPeYiftLv1Wx
 5TZxIZLA3jGTtfB4wDOgQwuBJPur55oyxToMXXMtwm25N4rlom5Lnhm6jyBBaX+M3kQc
 g7ytKXtEnDyO2qIzaweQY66f6LWEb+/qjp3m8ybw1ZFEx48o2pVTc11KL4hrmUZqep21
 KRsSceXDXBFmQn3SGYxygrADfdOK5kL/ENkJIXswd8CiT19jBT0qEaKyHlfwwLkZvXhB
 Oj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714489616; x=1715094416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BnnlXuw4VnJp8XUprbE2Rl/GS20bsAEHdcUkL5+ANKg=;
 b=rM4tsN17+LUQGS8ZzuTnkHS+pWx6e/b8O1V/AVrdfT6fuaZcZJ0WYSbjv3v1tVyfBd
 vYYlP3OL0JHFqHmFvdkblDanKWgsZsywDKCnrhSzvVAC0Du6YeE1r68nK+ad1veyMNd6
 j9/pVyzK+CaSEUjZnqx52MN7+fyDGDLyg1nXRjpG2GuloE1OeSXhVY1rH3eRrzvVlTPu
 LsUDZurojxpaj+6Psw9gXlmZ90RlybH3oI6zC1LqKiqFgQPYTpFemTFDND+bwpMZW1Ic
 I/zSDoR6xVaIL0n4CU47GCIQLYqvZPmTitt4ooaE1lO/5aDyVBfZis1vB7sp7vzEt7Xw
 VLUg==
X-Gm-Message-State: AOJu0YzIiRz+4Od/nlzMfL6ZaAcFiPYTenkNeiYN4+ki4cLq3aXz5dcf
 X2FHomqr3TlxpFt/23dg4Qx+KtE9VWn2celIjhNznEYAr9Lz6snwEkLRXw==
X-Google-Smtp-Source: AGHT+IFwKy/oiOn/Be23vNB88dTvABXg+7CTYMa2IEAKdlBCRk5mXYP9KE3Icrx9+U8trAPn+Hz6+g==
X-Received: by 2002:a50:d4d6:0:b0:572:6698:7d25 with SMTP id
 e22-20020a50d4d6000000b0057266987d25mr42672edj.26.1714489616219; 
 Tue, 30 Apr 2024 08:06:56 -0700 (PDT)
Received: from archlinux.. (pd9ed788d.dip0.t-ipconnect.de. [217.237.120.141])
 by smtp.gmail.com with ESMTPSA id
 11-20020a0564021f4b00b005727e826977sm2345741edz.19.2024.04.30.08.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 08:06:55 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 4/6] hw/i386/x86: Don't leak "pc.bios" memory region
Date: Tue, 30 Apr 2024 17:06:41 +0200
Message-ID: <20240430150643.111976-5-shentey@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240430150643.111976-1-shentey@gmail.com>
References: <20240430150643.111976-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x533.google.com
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

Fix the leaking in x86_bios_rom_init() by adding a "bios" attribute to
X86MachineState. Note that it is only used in the -bios case.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/i386/x86.h |  1 +
 hw/i386/x86.c         | 13 ++++++-------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 271ad50470..fb41263b9d 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -52,6 +52,7 @@ struct X86MachineState {
     DeviceState *ioapic2;
     GMappedFile *initrd_mapped_file;
     HotplugHandler *acpi_dev;
+    MemoryRegion bios;
     MemoryRegion isa_bios;
 
     /* RAM information (sizes, addresses, configuration): */
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 457e8a34a5..29167de97d 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1133,7 +1133,6 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
 {
     const char *bios_name;
     char *filename;
-    MemoryRegion *bios;
     int bios_size, isa_bios_size;
     ssize_t ret;
 
@@ -1149,8 +1148,8 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
         (bios_size % 65536) != 0) {
         goto bios_error;
     }
-    bios = g_malloc(sizeof(*bios));
-    memory_region_init_ram(bios, NULL, "pc.bios", bios_size, &error_fatal);
+    memory_region_init_ram(&x86ms->bios, NULL, "pc.bios", bios_size,
+                           &error_fatal);
     if (sev_enabled()) {
         /*
          * The concept of a "reset" simply doesn't exist for
@@ -1159,11 +1158,11 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
          * the firmware as rom to properly re-initialize on reset.
          * Just go for a straight file load instead.
          */
-        void *ptr = memory_region_get_ram_ptr(bios);
+        void *ptr = memory_region_get_ram_ptr(&x86ms->bios);
         load_image_size(filename, ptr, bios_size);
         x86_firmware_configure(ptr, bios_size);
     } else {
-        memory_region_set_readonly(bios, !isapc_ram_fw);
+        memory_region_set_readonly(&x86ms->bios, !isapc_ram_fw);
         ret = rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1);
         if (ret != 0) {
             goto bios_error;
@@ -1173,7 +1172,7 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
 
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = MIN(bios_size, 128 * KiB);
-    memory_region_init_alias(&x86ms->isa_bios, NULL, "isa-bios", bios,
+    memory_region_init_alias(&x86ms->isa_bios, NULL, "isa-bios", &x86ms->bios,
                              bios_size - isa_bios_size, isa_bios_size);
     memory_region_add_subregion_overlap(rom_memory,
                                         0x100000 - isa_bios_size,
@@ -1184,7 +1183,7 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
     /* map all the bios at the top of memory */
     memory_region_add_subregion(rom_memory,
                                 (uint32_t)(-bios_size),
-                                bios);
+                                &x86ms->bios);
     return;
 
 bios_error:
-- 
2.45.0


