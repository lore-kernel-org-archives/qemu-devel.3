Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D12C35FFF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 12:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvFFD-0002FQ-AG; Thu, 20 Mar 2025 08:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvFF3-0002Ek-Rx
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:43:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvFF1-0005hL-Rh
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742474598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RbdytaKQ23dTTwsiebcK7kqOQwF4p0uR0mRc1nL4Ub0=;
 b=CPvw3N5zXyUQNHFvQuNPFliT6duyD3gSyg5wSYL/WH7TcDTnZSUO2mj76ZdPsVrTVOrBWg
 gZM/pmmRHDQ0ZmcT8JSWvj0Vg9fWBBhOO0iNmiPU9K/WnNXm6SMkGrerizqnKzZvf9w0vg
 oOd68zyIRQpsv+Q2uPNMZSU4tge/zAs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-A-oY4BZyMMOo_XMLZOPwmg-1; Thu, 20 Mar 2025 08:43:16 -0400
X-MC-Unique: A-oY4BZyMMOo_XMLZOPwmg-1
X-Mimecast-MFC-AGG-ID: A-oY4BZyMMOo_XMLZOPwmg_1742474595
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-391345e3aa3so423451f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 05:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742474595; x=1743079395;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RbdytaKQ23dTTwsiebcK7kqOQwF4p0uR0mRc1nL4Ub0=;
 b=enJWzRznmMM1yhILeb12N5aHsuG3w9fcVAnnV1x2NumXOAI0Dze4SSY/4sZR9aq69G
 tagHzj7QQRybIGYvws+XsHwIHQA+I7mB5c9fOsV9M6Ap2g7Nd37GW1rcUE9SWg9Pp/OP
 YUZbEnmhQMRgOwFFn0AXsjy5Vp8UUG1Xxa8CzX061zKPeoUgInAZGHbHpZY77d3ZnA7U
 7IxaMiEXBwDnML3XvPzUrullZexNnK6Y5BCwTlO+9UZt1ii5wb51U0u5TzItKCvTMCCH
 7XKOD7R9SA+mXFwOKP5gR70AB7RCkt8A7BCRy50NJ/Hzlo7ZfFmO7uoasAlcWdYnw2yQ
 vSPA==
X-Gm-Message-State: AOJu0YxtO0X3uOtlWtegx6JIdqVgkR3NgbUgH4YCKT5DhE5otfoXD4c2
 JL+I1EqyKWk4vHf+Qavg3aVpAYeLJSLls4qrshltNHEV+LyxMA4IT7agn/M2tXYJUniQ+kpD1e2
 V4gOWVOpOa5H6/YOZBIdb9uXTVPNxNDVVIaJcmKT4bvm9AVSs9meun0VM2aSSZgit+bWANMd6YC
 py8Od/RbEH8JiDun+cL3oupFJVb6mMzKShFDSh
X-Gm-Gg: ASbGnctAglwSJq/XJ2EFImsb7/rIIyG3zB6qASoqR1ZqCmhPRFfhJ7l8tLO8QCEGegS
 QrA+xNS0ZxMnbS2m9xZ3N/Um7eGR6J3NMlBNGHTv1cSB/3aIzXrgFF2KgpKanYZN9nVWC+zayZj
 737qDleNWY/jhH0oEMihERSMPNUOstbAzediN34ZSdwOm8UajB2NCw/sL4HATKmBbHg/XRxC3bi
 ymLK8+qfOhZ3RU4ch7HSPgyhR7d/4NMi/wU0r4gljOkbowmNbrVn1Oj/PoVgD6xPqR0LvTIjQRi
 ymUXbezB5XTJWQgmDKAB
X-Received: by 2002:a05:6000:2b10:b0:391:39bd:a381 with SMTP id
 ffacd0b85a97d-399739de2eemr3816450f8f.30.1742474594810; 
 Thu, 20 Mar 2025 05:43:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOkSvTH/wlpJH8pNDOTfONqRzuN4KTPDl3W+b5fHHpOmtADTN4ERLUyrMjjd47wPDD080ZXA==
X-Received: by 2002:a05:6000:2b10:b0:391:39bd:a381 with SMTP id
 ffacd0b85a97d-399739de2eemr3816436f8f.30.1742474594278; 
 Thu, 20 Mar 2025 05:43:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d3ba44e63sm51875675e9.1.2025.03.20.05.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 05:43:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH] load_aout: replace bswap_needed with big_endian
Date: Thu, 20 Mar 2025 13:43:13 +0100
Message-ID: <20250320124313.819222-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Targets know whether they are big-endian more than they know if
the endianness is different from the host: the former is mostly
a constant, at least in machine creation code, while the latter
has to be computed with TARGET_BIG_ENDIAN != HOST_BIG_ENDIAN or
something like that.

load_aout, however, takes a "bswap_needed" argument.  Replace
it with a "big_endian" argument; even though all users are
big-endian, it is cheap enough to keep the optional swapping
functionality even for little-endian boards.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/loader.h   | 2 +-
 hw/core/loader.c      | 4 ++--
 hw/ppc/mac_newworld.c | 7 +------
 hw/ppc/mac_oldworld.c | 7 +------
 hw/sparc/sun4m.c      | 9 +--------
 hw/sparc64/sun4u.c    | 9 +--------
 6 files changed, 7 insertions(+), 31 deletions(-)

diff --git a/include/hw/loader.h b/include/hw/loader.h
index 784a93d6c17..d280dc33e96 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -190,7 +190,7 @@ ssize_t load_elf(const char *filename,
 void load_elf_hdr(const char *filename, void *hdr, bool *is64, Error **errp);
 
 ssize_t load_aout(const char *filename, hwaddr addr, int max_sz,
-                  int bswap_needed, hwaddr target_page_size);
+                  bool big_endian, hwaddr target_page_size);
 
 #define LOAD_UIMAGE_LOADADDR_INVALID (-1)
 
diff --git a/hw/core/loader.c b/hw/core/loader.c
index ce6ff1b52e3..2e35f0aa905 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -226,7 +226,7 @@ static void bswap_ahdr(struct exec *e)
 
 
 ssize_t load_aout(const char *filename, hwaddr addr, int max_sz,
-                  int bswap_needed, hwaddr target_page_size)
+                  bool big_endian, hwaddr target_page_size)
 {
     int fd;
     ssize_t size, ret;
@@ -241,7 +241,7 @@ ssize_t load_aout(const char *filename, hwaddr addr, int max_sz,
     if (size < 0)
         goto fail;
 
-    if (bswap_needed) {
+    if (big_endian != HOST_BIG_ENDIAN) {
         bswap_ahdr(&e);
     }
 
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index cb3dc3ab482..2d5309d6f55 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -197,11 +197,6 @@ static void ppc_core99_init(MachineState *machine)
     }
 
     if (machine->kernel_filename) {
-        int bswap_needed = 0;
-
-#ifdef BSWAP_NEEDED
-        bswap_needed = 1;
-#endif
         kernel_base = KERNEL_LOAD_ADDR;
         kernel_size = load_elf(machine->kernel_filename, NULL,
                                translate_kernel_address, NULL, NULL, NULL,
@@ -209,7 +204,7 @@ static void ppc_core99_init(MachineState *machine)
         if (kernel_size < 0) {
             kernel_size = load_aout(machine->kernel_filename, kernel_base,
                                     machine->ram_size - kernel_base,
-                                    bswap_needed, TARGET_PAGE_SIZE);
+                                    true, TARGET_PAGE_SIZE);
         }
         if (kernel_size < 0) {
             kernel_size = load_image_targphys(machine->kernel_filename,
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 0dbcea035c3..b5814690f5a 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -153,11 +153,6 @@ static void ppc_heathrow_init(MachineState *machine)
     }
 
     if (machine->kernel_filename) {
-        int bswap_needed = 0;
-
-#ifdef BSWAP_NEEDED
-        bswap_needed = 1;
-#endif
         kernel_base = KERNEL_LOAD_ADDR;
         kernel_size = load_elf(machine->kernel_filename, NULL,
                                translate_kernel_address, NULL, NULL, NULL,
@@ -165,7 +160,7 @@ static void ppc_heathrow_init(MachineState *machine)
         if (kernel_size < 0) {
             kernel_size = load_aout(machine->kernel_filename, kernel_base,
                                     machine->ram_size - kernel_base,
-                                    bswap_needed, TARGET_PAGE_SIZE);
+                                    true, TARGET_PAGE_SIZE);
         }
         if (kernel_size < 0) {
             kernel_size = load_image_targphys(machine->kernel_filename,
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index a48d3622c5a..5aaafb40dac 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -233,20 +233,13 @@ static unsigned long sun4m_load_kernel(const char *kernel_filename,
 
     kernel_size = 0;
     if (linux_boot) {
-        int bswap_needed;
-
-#ifdef BSWAP_NEEDED
-        bswap_needed = 1;
-#else
-        bswap_needed = 0;
-#endif
         kernel_size = load_elf(kernel_filename, NULL,
                                translate_kernel_address, NULL,
                                NULL, NULL, NULL, NULL,
                                ELFDATA2MSB, EM_SPARC, 0, 0);
         if (kernel_size < 0)
             kernel_size = load_aout(kernel_filename, KERNEL_LOAD_ADDR,
-                                    RAM_size - KERNEL_LOAD_ADDR, bswap_needed,
+                                    RAM_size - KERNEL_LOAD_ADDR, true,
                                     TARGET_PAGE_SIZE);
         if (kernel_size < 0)
             kernel_size = load_image_targphys(kernel_filename,
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 8ab5cf0461f..d3cb7270ff5 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -168,13 +168,6 @@ static uint64_t sun4u_load_kernel(const char *kernel_filename,
 
     kernel_size = 0;
     if (linux_boot) {
-        int bswap_needed;
-
-#ifdef BSWAP_NEEDED
-        bswap_needed = 1;
-#else
-        bswap_needed = 0;
-#endif
         kernel_size = load_elf(kernel_filename, NULL, NULL, NULL, kernel_entry,
                                kernel_addr, &kernel_top, NULL,
                                ELFDATA2MSB, EM_SPARCV9, 0, 0);
@@ -182,7 +175,7 @@ static uint64_t sun4u_load_kernel(const char *kernel_filename,
             *kernel_addr = KERNEL_LOAD_ADDR;
             *kernel_entry = KERNEL_LOAD_ADDR;
             kernel_size = load_aout(kernel_filename, KERNEL_LOAD_ADDR,
-                                    RAM_size - KERNEL_LOAD_ADDR, bswap_needed,
+                                    RAM_size - KERNEL_LOAD_ADDR, true,
                                     TARGET_PAGE_SIZE);
         }
         if (kernel_size < 0) {
-- 
2.48.1


