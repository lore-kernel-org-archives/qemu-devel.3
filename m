Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416FBC25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 07:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4F7U-0007hg-2m; Tue, 07 May 2024 03:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4F7R-0007gi-Ph
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:20:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4F7N-0004a8-9v
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715066404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GZeSHTEIZaZ87Q0+qmszQgyShcSW78CNFvo2DL7feAs=;
 b=O4bLUTitn4UzvVs9su3+yYdrS+9GROLAaA2WXisgKuHu9iwAkFV+0y/RVgOPRfDuyq1F8s
 RXHhg/KI/zaGvGoefIJDLbk74h/gYSUpzvnsP16zc6CFH1lF4ouE0xD9/kSVH6ay+VD6Y6
 12+lRYmKK0GrndcLSL4GRaWSG2bg60k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-QGGvBxpFNUeqRQCG5MYnSw-1; Tue, 07 May 2024 03:20:01 -0400
X-MC-Unique: QGGvBxpFNUeqRQCG5MYnSw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a51fdbd06c8so197536566b.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 00:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715066400; x=1715671200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GZeSHTEIZaZ87Q0+qmszQgyShcSW78CNFvo2DL7feAs=;
 b=BiS/qdCH+cC8DHPR4QwPI8+kImfP7c/6Br0pAXFxkqU7fYCXLLvk7AC+uURW55k2Xr
 6EEAjvWq55vFy99y8ksXbH3D0+ACYAMJzweL4mhLCiYuRIdz2di3UW2evFqtH5Gl6BDP
 UDDZylUXHwKu9PHPJjNPg5B1wv7Oo/AAW1jNQ1v1zpSY2T2I2ymjjyXVEwcYHPlKiS8B
 E7HGSJ0iCLh5S+4Ujk0C6n5TYN0VZ27fmw7SjNuTFtP4ICzmDPlwbqZEyTnWJ8eWIuVA
 oLpvxP9t4qYq85ES1VxcZwDTGkJKDxQmf/p3XLBX2lYU1fnVc2m70DyuL9x7N7eyTFnt
 XD9g==
X-Gm-Message-State: AOJu0YwZOIUdkUHgSr8h0NXdqbDxYdcVdsNiA3PZKDsB17uR3HhEk2Vj
 AXngzOzwtRGNoPUcALLHBdcqcl/tIbN0MfNvhrMKQpa7HD4GzQZGY8GhqZWu8BN835xND9eq082
 qUsuG09C9RAcreI9j7AHoAh3orfiA66OmOjFZtJ5z8xgdLq21AduXhJzTD9mw5xquOI1GN03Hv1
 Tx+qR80t6osihBYqQkfOIvgLaIqjoC1RqKhD4F
X-Received: by 2002:a17:907:995a:b0:a55:a895:46ae with SMTP id
 kl26-20020a170907995a00b00a55a89546aemr7619845ejc.63.1715066400253; 
 Tue, 07 May 2024 00:20:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfgcQ2QzRZyabGjXNYriQB4I1ZKzQuKLU8xfAOA7j+Ydtm5U2PfrWrCTTgzmffW90AFQAKmw==
X-Received: by 2002:a17:907:995a:b0:a55:a895:46ae with SMTP id
 kl26-20020a170907995a00b00a55a89546aemr7619831ejc.63.1715066399893; 
 Tue, 07 May 2024 00:19:59 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 la6-20020a170906ad8600b00a59aa18c685sm3806434ejb.173.2024.05.07.00.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 00:19:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 3/4] hw/xtensa: require libfdt
Date: Tue,  7 May 2024 09:19:47 +0200
Message-ID: <20240507071948.105022-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240507071948.105022-1-pbonzini@redhat.com>
References: <20240507071948.105022-1-pbonzini@redhat.com>
MIME-Version: 1.0
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


