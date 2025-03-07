Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E24EC282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqgMV-0006Ei-T0; Fri, 07 Mar 2025 17:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqgMT-0006Dt-DZ
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:40:09 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqgMR-0003aF-PL
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:40:09 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43bcf9612f4so19962185e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 14:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741387206; x=1741992006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VODePOvWuMJyhRGr2deCbWysjZeVNWE2sWKn1Ustt/s=;
 b=Lzsh4w94hF1W6hZV/qyS6g/OOMLJgRxQ1CcZwfjFvkR9gsDc0LpxDxRU44Nw0pLB71
 YCzbMXunLMkrxipNxLuLi87wQKLGSSzYQOr36tbopug3o8h+ux6+omENInjAScgy1nNL
 8RZf3GIBq+QR+bEeKC95+LXf8Y/S0wNDXFYQRFuS4CUX4knt+aXDU/GgL7dlFrTP0SMZ
 tnOHvXe04nETfNA//ALMlY7wyXu1wYIva2i0ruukQSruYV3CViWvfR1j7TBlxGrPg9pC
 44fomUExuK1ZqubgnSXshKcaGWqYSnD9sqEXfTn6pc0Lu15HdRxuq6oSkYDZmL7zd3Ob
 cTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741387206; x=1741992006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VODePOvWuMJyhRGr2deCbWysjZeVNWE2sWKn1Ustt/s=;
 b=lEw8tHXPsr9BNbL+dZdwqWazEIV/2OwM17ZwQoqDb98GojEoVx4tzRScJDijkzSbyt
 n4C40Zlwb7nmPpoIb0gRJEg1NVyHi23mDrPzMulmf/8zK/zGTjySzWIJpB7/3QMT7cRP
 t9HFvdfAQmkSLYbdEUv7V/wLqJ3bD1OfcaONLqCC1+45f76+SAWu7KmAI+6wJwG8T85g
 QMmwjuyYFjPnTxB08w6Fu50FpbVTEbIoCq2Oe+kKjajRMLU4qoVRRj+rnSRgn3BPu2VH
 5T4+Z2wlVDsHlGLOLtOPWg/EGJsKTKUhNE+OFSK3bLAKH7PfQLvkaPVBD4VABNeuIMBW
 O2Cw==
X-Gm-Message-State: AOJu0YwF4wbT7KxRq6FfMgub/oYaLPswsTy8Bxp63YjTqunLeQVfNl6D
 wd6CRmTDxv2TXk7HcGSCLfx8YKEU+oixHP/4/QPyQ2g9oryMENX98t6TgqiPj4Z4y59UmBlP9UK
 wmPU=
X-Gm-Gg: ASbGncvCORToVTWWlI2B3uBlHalu7JqmLcPY/1mNtwssef6q3YkDQH4L0Qds9KlySr0
 Uxtrlq4ZLyuUvOmnA+g6GtHOeP0eN8BW1yA+FMzEaQDqIC3L1+nW+9kvzhR1Ng8B1LBDmCo1Pyo
 5zJw5Tgu/vHwdKkd/lDa72HiVfcTMCV0kGMSbRa+ytY51XAVd4URKR9RCQv2SdVWar0SCvbaCZC
 Y0zkbGvAyE+noTA4tgSAHEznzn8VnbrxZ/9uV9vDznCGj44751QdARS/Oeihfc9LDASRh8gFUkw
 DgfpqmNpRdLeHTeDKbLffDGfPlhZo9CZQDkHr81eKoj54H7rUnpUk00EiR4nORtNX8zHAsZ/fKc
 BBITzDtynjAlHrQmHKt4=
X-Google-Smtp-Source: AGHT+IFOS7lMHNCltqN1TL+3zvSadAxaTMZc8XzihdMZr3TWPoOd+sYBeWN+dfOrZ+E5qHvJnGqMoQ==
X-Received: by 2002:a05:600c:190f:b0:439:a1f2:50a3 with SMTP id
 5b1f17b1804b1-43ce246ffabmr14923365e9.4.1741387205744; 
 Fri, 07 Mar 2025 14:40:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bcc186de4sm63546565e9.1.2025.03.07.14.40.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 14:40:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/7] hw/i386/fw_cfg: Check ACPI availability with
 acpi_builtin()
Date: Fri,  7 Mar 2025 23:39:45 +0100
Message-ID: <20250307223949.54040-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307223949.54040-1-philmd@linaro.org>
References: <20250307223949.54040-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Replace the compile-time CONFIG_ACPI check by a runtime one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/fw_cfg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index d08aefa0291..a7f1b60b98c 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -145,10 +145,10 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
      */
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, apic_id_limit);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, ms->ram_size);
-#ifdef CONFIG_ACPI
-    fw_cfg_add_bytes(fw_cfg, FW_CFG_ACPI_TABLES,
-                     acpi_tables, acpi_tables_len);
-#endif
+    if (acpi_builtin()) {
+        fw_cfg_add_bytes(fw_cfg, FW_CFG_ACPI_TABLES,
+                         acpi_tables, acpi_tables_len);
+    }
     fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, 1);
 
     fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_fw_cfg, sizeof(hpet_fw_cfg));
-- 
2.47.1


