Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A18C10F15
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 20:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryzw1-0007SH-OP; Mon, 22 Apr 2024 16:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1ryzw0-0007Rt-9E
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 16:06:40 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1ryzvy-0004h9-6E
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 16:06:40 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-51ae2e37a87so3349729e87.2
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 13:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713816395; x=1714421195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PchXtO8ad4BByoR+U+nzto09/ZkQHiG8u94aXCkO74U=;
 b=N8Um8+2ZtZS2lKm4CKe8dqrEt9AAQey4Glrs5Ma3BSnWiZn93fJ+av6hZjLzLCsik/
 hU03LzfpsHxbPMA55Tq4SazEUZc+fLTxzByx9lGpro+/bdWihqiOmygz0u5YCM8T7+BZ
 nt981XYWBaDWBoYuYyPZiL792ryk1YVGnu8ZTao7a1aHtq81yzn7EFGDmgiws7qATJ+I
 EHtqUrqFa8MjA37YQR8/cVoWG3/gzMoSX2dQG+pymtQf65FUpEPeT1QIkhbZDGVYFlcE
 2ZmIqUV10HcjQU0BQHhQT/FCgAlVP+PppyGZ+dkQu1ElDVml0QKzhSYofu0F3oF50VES
 ymBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713816395; x=1714421195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PchXtO8ad4BByoR+U+nzto09/ZkQHiG8u94aXCkO74U=;
 b=ZYzIwtgTPQeYk5+n9rrG2is5HWBmEvWdpwBeRAkBhnareQ0aCx8nMKiUUOoMPCz+GJ
 6mmYvdsQlOT2mCtA9yb5wztC+fKvQutUZITESMYuwlwlTXeHaiVG7nX9ybx891hgyhPz
 0m/pARbKx1jI4E1ha89q4p4LmRkvHoGRM7GBAGJ9w7JVW6WXO/UN2/cQznWWOpS/PUTV
 P65GprSzcp001Pyymld1SHOPv39skOnsO9XaX5LAVWgSuUbJpFFrcUlJKMe8l60885UF
 p9BmJC5xHPLN6LS2OCuaaH1zoMBelUXhxxHcGTmMg1w1Bsm1SX2FaVLg6rAXIUT6VBuc
 EJlw==
X-Gm-Message-State: AOJu0YxUmwAP8NumyV5IeH8eDactdKxuy2Z3mL0w6OtvfDWh1Xcoc5bP
 3LsZC4/cIUX5yneGmyCADDKhQPT7ILW4iU7Bc3hXfRuVUlud2ihwvkK69A==
X-Google-Smtp-Source: AGHT+IHmxnLq8JtJQdoTuWNwb51WI8eX14I4q/TTWOJlR+gnJXZ2LpJe4XdzMGaquhqw9WNDgCRzRQ==
X-Received: by 2002:a19:5f41:0:b0:516:cd83:a96a with SMTP id
 a1-20020a195f41000000b00516cd83a96amr4014626lfj.37.1713816394816; 
 Mon, 22 Apr 2024 13:06:34 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-188-098-082.77.188.pool.telefonica.de. [77.188.98.82])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a17090665c200b00a55bbc4fd16sm1209230ejn.48.2024.04.22.13.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 13:06:34 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 1/4] hw/i386/pc_sysfw: Remove unused parameter from
 pc_isa_bios_init()
Date: Mon, 22 Apr 2024 22:06:22 +0200
Message-ID: <20240422200625.2768-2-shentey@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422200625.2768-1-shentey@gmail.com>
References: <20240422200625.2768-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x133.google.com
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/pc_sysfw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 3efabbbab2..87b5bf59d6 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -41,8 +41,7 @@
 #define FLASH_SECTOR_SIZE 4096
 
 static void pc_isa_bios_init(MemoryRegion *rom_memory,
-                             MemoryRegion *flash_mem,
-                             int ram_size)
+                             MemoryRegion *flash_mem)
 {
     int isa_bios_size;
     MemoryRegion *isa_bios;
@@ -186,7 +185,7 @@ static void pc_system_flash_map(PCMachineState *pcms,
 
         if (i == 0) {
             flash_mem = pflash_cfi01_get_memory(system_flash);
-            pc_isa_bios_init(rom_memory, flash_mem, size);
+            pc_isa_bios_init(rom_memory, flash_mem);
 
             /* Encrypt the pflash boot ROM */
             if (sev_enabled()) {
-- 
2.44.0


