Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5843C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 20:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryzw7-0007TS-Bx; Mon, 22 Apr 2024 16:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1ryzw3-0007Se-08
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 16:06:43 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1ryzw1-0004he-Ay
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 16:06:42 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a5544fd07easo539900666b.0
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 13:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713816398; x=1714421198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B3mpE8mPOXIfCN0iys//quAbHTgXlOuPmee5Oc6B/Lo=;
 b=ZP7jFYbjMim/YjgmzvIyhGM7uqbS32dVqkgqdQfX15TkLJdnzFIZev5OeZ5/au6VdX
 vyL2TSmpRP2YF7/HqfreAgKFo1g8qo5OIVzikuDF8bwpS4G9GgQ67E1drme/i0q5MG1Y
 nLzxd1J0j8FHmmcXwX8cHrjO2uEsTpJKDLgRFg4aCPdZNWwFcHlF/fwhMqXgypsFnGEM
 0Nz2UMUh/65JW0DrXBzoUAUdL9hRlW+A9EaEk2UQY/68nkC/9znBuA+l4qpkocF4XkQ3
 Eafiyln7dNmG7j0jJIe2UzjRXSSSgNiTUEUNvoTb0biUdX3zFU1+9M/ReDxfnf2kB6P4
 MpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713816398; x=1714421198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B3mpE8mPOXIfCN0iys//quAbHTgXlOuPmee5Oc6B/Lo=;
 b=o+2Qu3tzr5DjtW4nDiKld49vW/cfYjBvG6WYAtWXgoNz1d98KDWG23jvRq0QNF/ukg
 1te3LX5t+UvwFTrDwF5ZGce7d+RCXoyOQHlbq6RDL4CuW7uaLJJ5KdanHi4PJq4dWIwn
 zGGDyev3gzlgqWDJjXUC0ZUkAGlmoJyWJg6uwGdZNpaAIcd+J5EIze45dU9vXPYhHG/H
 Bib5P0FXtOTuqKTr/mLYoDjgah12WoAB91MGmD/hZfP0QC1ABRGXXbsgu8mUb/tlfgh0
 z/WwkuC9PPaTI/CA8BZ3Bi84HixetsrAe6oa8ghlo05E1i6YccCJRVbWHUJcnZQ+nKCj
 Qyxw==
X-Gm-Message-State: AOJu0YwTmqVl4rdWkb/WZUU6t54NACDgmGIWqF+3GX8iTZPRhIugXnVY
 n8al95zlC4KxrMLEdwVNKT4DdIom+8PqRSzQcRVnnET7eJAhdq4DWz6LwQ==
X-Google-Smtp-Source: AGHT+IG+1veOecIW/1kYH99vzn3ZTgbrGUQam27XQWVISaczGxRYJS4L9R0vrvLGGMJVWPDQElVlmw==
X-Received: by 2002:a17:906:2491:b0:a52:6fcb:564a with SMTP id
 e17-20020a170906249100b00a526fcb564amr6270998ejb.9.1713816398422; 
 Mon, 22 Apr 2024 13:06:38 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-188-098-082.77.188.pool.telefonica.de. [77.188.98.82])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a17090665c200b00a55bbc4fd16sm1209230ejn.48.2024.04.22.13.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 13:06:37 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 3/4] hw/i386/x86: Eliminate two if statements in
 x86_bios_rom_init()
Date: Mon, 22 Apr 2024 22:06:24 +0200
Message-ID: <20240422200625.2768-4-shentey@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422200625.2768-1-shentey@gmail.com>
References: <20240422200625.2768-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62d.google.com
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

Given that memory_region_set_readonly() is a no-op when the readonlyness is
already as requested it is possible to simplify the pattern

  if (condition) {
    foo(true);
  }

to

  foo(condition);

which is shorter and allows to see the invariant of the code more easily.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/x86.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index ffbda48917..32cd22a4a8 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1171,9 +1171,7 @@ void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
         load_image_size(filename, ptr, bios_size);
         x86_firmware_configure(ptr, bios_size);
     } else {
-        if (!isapc_ram_fw) {
-            memory_region_set_readonly(bios, true);
-        }
+        memory_region_set_readonly(bios, !isapc_ram_fw);
         ret = rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1);
         if (ret != 0) {
             goto bios_error;
@@ -1190,9 +1188,7 @@ void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
                                         0x100000 - isa_bios_size,
                                         isa_bios,
                                         1);
-    if (!isapc_ram_fw) {
-        memory_region_set_readonly(isa_bios, true);
-    }
+    memory_region_set_readonly(isa_bios, !isapc_ram_fw);
 
     /* map all the bios at the top of memory */
     memory_region_add_subregion(rom_memory,
-- 
2.44.0


