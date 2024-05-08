Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A9BC25B74
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 07:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4c5j-00072k-4P; Wed, 08 May 2024 03:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4c5H-0006r3-Il
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:51:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4c5E-0003eK-LX
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715154682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MIrdhYYSEjHQf62aM9cNEMsXn+yUWKJciAkldDNdnXg=;
 b=Z852JXGeUIqxR7H3zXuCxbBBmqXClONRhpkOeZyy7AFB2I+JeMNx//cNsOIzo3XXE2P5en
 G7SHgkEY5v315PfPRBilxh8XuNbKJaHyo4dtEooDYCkhC2Yo2ooqR+tVakWHOIFFdckW4e
 +Df6cvfgNXHez22BjsByWgOteA3SH1U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-SLZYD8WWO7iI0q4No-MNNA-1; Wed, 08 May 2024 03:51:21 -0400
X-MC-Unique: SLZYD8WWO7iI0q4No-MNNA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a599b55056bso229311066b.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 00:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715154679; x=1715759479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MIrdhYYSEjHQf62aM9cNEMsXn+yUWKJciAkldDNdnXg=;
 b=Ncevx2p6wzZOqhPMSrXSwWT+hbq5/J1s2PsSX8/G9XCPIGmdRv6+j3lQvyh2I+Uoq7
 YTO5Jhxo7AXSX0svT/v5yyLLvewSZb7Dosh4RbG7/Nv4amCQrAJl3XqbJAvbgibHWq/D
 2S7ktUXdDv88+39qHpXH+dZMgbMiY/AMVTcMb2gr9VWyDvED0Xr1sjqZ2HMmQ3bgxlAe
 tj3toF/ZbdISEV6emzVY5+KHKSoUrJbFgcrzxW+E+d1KISwqZljxFjjnlukaCyi3F2oS
 JBAb2fL+wzQaioXHluZguMw13cNxlCCrcutWeaxjI4ILuPg+jv+RCV3HZdYSxT/905xN
 EmIA==
X-Gm-Message-State: AOJu0Yy7AGb18mACxA/Gkn1OQCzMpS+CqTZw3k4qsdBfvPEdUNrZ9b4u
 34KdwYhi3F89wGUVYuzDBvBvIZ86+7nSDXC8oiJlVZaN62ADcg6SlGqe09EhlPTMJ58Yo1mKn44
 zl6QWj2K064j5l22z41PUWE8zSDcSjdBAMwRtSRiG7texL9Gc5XXv6TctYuFILcZ91Yr5T68gKZ
 i6UGFUD0Pd7U3ICrj7HZxCvpIwe9qAOs01ZHvs
X-Received: by 2002:a17:906:3544:b0:a59:c319:f1de with SMTP id
 a640c23a62f3a-a59fb92142cmr99529466b.15.1715154679285; 
 Wed, 08 May 2024 00:51:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9qtpm71ABB/KR77HCLxnkvEHENcI++3tppPDHb8nbif/m/fxSSMUMWvL2P/K/ZrzspD1Dog==
X-Received: by 2002:a17:906:3544:b0:a59:c319:f1de with SMTP id
 a640c23a62f3a-a59fb92142cmr99528566b.15.1715154678891; 
 Wed, 08 May 2024 00:51:18 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 gc21-20020a170906c8d500b00a59a7bac0easm5175452ejb.164.2024.05.08.00.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 00:51:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 5/6] hw/xtensa: require libfdt
Date: Wed,  8 May 2024 09:51:04 +0200
Message-ID: <20240508075105.15510-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240508075105.15510-1-pbonzini@redhat.com>
References: <20240508075105.15510-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

All other boards require libfdt if it can be used (including for example
i386/x86_64), so change the "imply" to "select" and always allow -dtb
in qemu-system-xtensa.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/xtensa/xtfpga.c | 9 ---------
 hw/xtensa/Kconfig  | 4 ++--
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index f49e6591dc2..955e8867a36 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -356,7 +356,6 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
             cur_tagptr = put_tag(cur_tagptr, BP_TAG_COMMAND_LINE,
                                  strlen(kernel_cmdline) + 1, kernel_cmdline);
         }
-#ifdef CONFIG_FDT
         if (dtb_filename) {
             int fdt_size;
             void *fdt = load_device_tree(dtb_filename, &fdt_size);
@@ -373,14 +372,6 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
             cur_lowmem = QEMU_ALIGN_UP(cur_lowmem + fdt_size, 4 * KiB);
             g_free(fdt);
         }
-#else
-        if (dtb_filename) {
-            error_report("could not load DTB '%s': "
-                         "FDT support is not configured in QEMU",
-                         dtb_filename);
-            exit(EXIT_FAILURE);
-        }
-#endif
         if (initrd_filename) {
             BpMemInfo initrd_location = { 0 };
             int initrd_size = load_ramdisk(initrd_filename, cur_lowmem,
diff --git a/hw/xtensa/Kconfig b/hw/xtensa/Kconfig
index 8ea283a7a3b..fc5c785cfac 100644
--- a/hw/xtensa/Kconfig
+++ b/hw/xtensa/Kconfig
@@ -14,8 +14,8 @@ config XTENSA_VIRT
 config XTENSA_XTFPGA
     bool
     default y
-    depends on XTENSA
-    imply DEVICE_TREE
+    depends on XTENSA && FDT
+    select DEVICE_TREE
     select OPENCORES_ETH
     select PFLASH_CFI01
     select SERIAL
-- 
2.45.0


