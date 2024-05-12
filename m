Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C36C10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66nR-0004Cr-Nv; Sun, 12 May 2024 06:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66nQ-0004Bn-0I
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:51:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66nE-0006Aq-EW
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715511056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MIrdhYYSEjHQf62aM9cNEMsXn+yUWKJciAkldDNdnXg=;
 b=IM1+jbA81Qv6Qv8jZWi0EXQxiv3vPRhHw389f05fQu2OfitrzyJtfyDrdoUtE3buxsXPvf
 3QHcRC1CyulPt9017GRs02oEfIfh0ykqwcgtNXivBDNqzusEsXl2lfvMkmSCNrB+PcQ9uT
 03aSlHxPMsDn54kFvhpiceWS8LHQw/I=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-m3WgMekANAmiWv9dHwgbDA-1; Sun, 12 May 2024 06:50:54 -0400
X-MC-Unique: m3WgMekANAmiWv9dHwgbDA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-56e645a8762so2351817a12.3
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715511053; x=1716115853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MIrdhYYSEjHQf62aM9cNEMsXn+yUWKJciAkldDNdnXg=;
 b=RcbyKJuBsSd/xuggs16RMPfSacxEcR3uMYNjsoA9xPGv2cnW6KItA3pv60AtsPfSay
 qnNmifT6VJcgDbmyJnULaYMfNl9b6qknwu2tsNQM9Wr8fvr5R6+qZACc+u3v3c78EF9/
 6G3acsdGYugPtaFz65zyigW0HVPXxLIwOhRCR596RR3KxszvuzUPV5c94PcqA9wVGxHs
 6RiS6tFzhwRiFAd5vaa7/ZnLaU7iqmyh9OkjOmf1vMbfYMlQMNSRwU7jHBkAC8WZhauh
 GQWkrly+O0UJujhTBvMklNok2oDsPrqGF9GWYOlUUBGH6BNOCBTJ3l5SNSQ9eAZwCsxM
 uRkw==
X-Gm-Message-State: AOJu0YwP3/YNjXGk8Q9oBiiqrFrCIbKIY2x/01p9CNSS08ymhBx1EtUG
 nzcM4D1PC3r6MOizi9VD8mfpUi3esXyfY4ztEDmZZZrfTOh9KJQVBX+OtX0kOQWRQf2K7nFUg88
 bfgScKUwiIb98omfRF9Hc1ShxJCY4zla3bst7qSWL81o8dIZq7/tmmdswMF0QIISbt7n9ugQrJu
 gALTJdZvLky6yN+cbZ8+ARl0qkxTrROm7u36PM
X-Received: by 2002:a50:cdd0:0:b0:56e:2464:7c4b with SMTP id
 4fb4d7f45d1cf-5734d5bd481mr4905368a12.10.1715511053104; 
 Sun, 12 May 2024 03:50:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElTGjNK34B0NMUvNyYz2Et0Lyy0+inItzTNnZPgWq7B8I+xuEPo7xTnE4992jpF38qybNA7g==
X-Received: by 2002:a50:cdd0:0:b0:56e:2464:7c4b with SMTP id
 4fb4d7f45d1cf-5734d5bd481mr4905361a12.10.1715511052711; 
 Sun, 12 May 2024 03:50:52 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733becfcb5sm4684497a12.47.2024.05.12.03.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 03:50:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/27] hw/xtensa: require libfdt
Date: Sun, 12 May 2024 12:49:44 +0200
Message-ID: <20240512104945.130198-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512104945.130198-1-pbonzini@redhat.com>
References: <20240512104945.130198-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


