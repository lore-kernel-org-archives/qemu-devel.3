Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CAAC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 20:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryzw4-0007Sp-8v; Mon, 22 Apr 2024 16:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1ryzw1-0007S9-2b
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 16:06:41 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1ryzvz-0004hN-GF
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 16:06:40 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a55911bff66so357185766b.0
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 13:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713816397; x=1714421197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZG/ndfe8xsvdvVaLhadRrtKayU/SCqRwtgihcJ0dO/Y=;
 b=Oo9FUbyoPWuztsGt1U5p3/T9ag+DtQuIzPpTiyQMv1qG1wgkfBPEoy4Dw+jzcvH3oz
 2FCpI7AiSkPp4iwE60j5ZTU6+/+F5azyFZ7WDYuVobb1xv5taPeWmw1dJQbuchImnAkX
 ADPwTscJjBG1/kMePEjwcGFdX5fzFV+9V4LSwlzBdM/0ka0Y51n9pDAHBtwdsfFMZ7Mf
 uqnyfNdFE7n0N/R572pJ6TQfMwmBbRrHZdYKkcnnqpnJCjieVs185DamiA4CfwPFDtaN
 Boh3oYIzlCANj/3B0cbrPzHBbPDwmnLKh4xj/Hu5ocjX+0jfPpXTMp8mB/hmxBGguKdK
 lV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713816397; x=1714421197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZG/ndfe8xsvdvVaLhadRrtKayU/SCqRwtgihcJ0dO/Y=;
 b=PB42QqktVw+rqxHc68v0yD+XVuyORPMaJi1IbyC0KsVGPWzMnzUg/ULI1SrfFY7oFJ
 2w/H2+LdN86gWWi/0HycmfgV8CzdEmA+WaRdff3ixhUgl4KDYNhPqiBD0bukS7KotTHr
 xyOfnQlDYKD/3PJCurEdX9mV1oFT6oXnb/uxusppHL6F/eHvQBi6Qk+X2K5F32Bg5lW0
 BGHRP6UPPWh1HmOoF/c/zteZxVv9toaTO7Sjklx2mculSCqc02lQZrrbYw8sZ4GswLev
 d3uZUd4q/Z72Z7VjczU1ykNpYUUWzsm0GCFbeOo8JVaxKRHnAFgd4EU/QquY5wSAhaHe
 fFaA==
X-Gm-Message-State: AOJu0YwuHXaaGmlqNfjtfS4LB2KfHRHLbWAGG9TYcoj5t1HPNhlZb5jA
 FA8Ww7Lw3kgjN1SnR3V+jdxTZZp+FFCA5noXKXyKFKTVgVeaFcD2VidOdw==
X-Google-Smtp-Source: AGHT+IGwQeOjmolOLnPLCvf+xKdfiluk7k2+Xo1bCo26I6LCGGWFC3qn9AwjYtfJl25ru0eMLNIR9Q==
X-Received: by 2002:a17:907:e8d:b0:a55:b9c6:bd99 with SMTP id
 ho13-20020a1709070e8d00b00a55b9c6bd99mr2562175ejc.56.1713816396956; 
 Mon, 22 Apr 2024 13:06:36 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-188-098-082.77.188.pool.telefonica.de. [77.188.98.82])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a17090665c200b00a55bbc4fd16sm1209230ejn.48.2024.04.22.13.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 13:06:35 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 2/4] hw/i386/pc_sysfw: Alias rather than copy isa-bios region
Date: Mon, 22 Apr 2024 22:06:23 +0200
Message-ID: <20240422200625.2768-3-shentey@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422200625.2768-1-shentey@gmail.com>
References: <20240422200625.2768-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
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

In the -bios case the "isa-bios" memory region is an alias to the BIOS mapped
to the top of the 4G memory boundary. Do the same in the -pflash case to have
common behavior. This also makes pflash commands work in the "isa-bios" region
which some real-world legacy bioses rely on.

Note that in the sev_enabled() case, the "isa-bios" memory region in the -pflash
case will now also point to encrypted memory, just like it already does in the
-bios case.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/pc_sysfw.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 87b5bf59d6..6e89671c26 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -46,27 +46,18 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
     int isa_bios_size;
     MemoryRegion *isa_bios;
     uint64_t flash_size;
-    void *flash_ptr, *isa_bios_ptr;
 
     flash_size = memory_region_size(flash_mem);
 
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = MIN(flash_size, 128 * KiB);
     isa_bios = g_malloc(sizeof(*isa_bios));
-    memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
-                           &error_fatal);
+    memory_region_init_alias(isa_bios, NULL, "isa-bios", flash_mem,
+                             flash_size - isa_bios_size, isa_bios_size);
     memory_region_add_subregion_overlap(rom_memory,
                                         0x100000 - isa_bios_size,
                                         isa_bios,
                                         1);
-
-    /* copy ISA rom image from top of flash memory */
-    flash_ptr = memory_region_get_ram_ptr(flash_mem);
-    isa_bios_ptr = memory_region_get_ram_ptr(isa_bios);
-    memcpy(isa_bios_ptr,
-           ((uint8_t*)flash_ptr) + (flash_size - isa_bios_size),
-           isa_bios_size);
-
     memory_region_set_readonly(isa_bios, true);
 }
 
-- 
2.44.0


