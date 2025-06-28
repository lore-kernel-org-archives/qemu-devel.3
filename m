Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DE8C7EE39
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 20:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVbgV-0003GJ-BE; Sat, 28 Jun 2025 15:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uVbgM-0003EU-4Q
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 15:57:51 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uVbgJ-0000Id-Kk
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 15:57:49 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7d44e3a0169so40496885a.0
 for <qemu-devel@nongnu.org>; Sat, 28 Jun 2025 12:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751140666; x=1751745466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uTp8cYLG6UEglvnDlfAVLBZ5UreW7WM/U27Ywrb2bxw=;
 b=tF7RHhC/RS8hnD+6+xt0/uOPS0rKwICUPEPmWsvLMLskMWj38MRdoaWho3bxbjmSTB
 x5igAi4BGHyL+r6C2S1yOsDZ0T9WsV9LF0D15wvbXQC5sWiiDExIYHAelOjYriRQ7MQT
 8m4SX0+5T4VONW8Pgt90V1e6DsCjl1SnVJyrteLqo1XclxcKftV1y3x9jDFLXGidgA+e
 +3x8rTezY7dXl+MdgvH5DuwfI5uEcZ7fDHPzzI6N8e5ypi7jNq4D//KuJw0lOQ+SwVQI
 um4Ir7XAfz5eyiCBr5yU8vcTGvbrBd7Kv9TEwyBCmwwgcwOKqXNtu1WahzIW/OI0g7WB
 ma4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751140666; x=1751745466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uTp8cYLG6UEglvnDlfAVLBZ5UreW7WM/U27Ywrb2bxw=;
 b=Dx8nTSGjtSXl8HWWfySLY5vsMuVE44YEXhU0KZfNpsZAmPjZgBvewNVsT+lNy4X4je
 vpP/ewBoQ63QMr92GEfKlF3syygkeDoCSQzvS4tGhW9NcCa96VBP9jTxxjKOAnb8F31A
 fuzHp4HdUw4mCVYwPXg05T4fFET5iXx8+TnGjwyDlZVv+zbAKSzstSDdupjRiE4q4Klq
 L8Ucvnm4/D9oq8EBSMz3ZRKjmZa655Oi6M5pE0U8/3ljRIXolBFOiUIhAfKR6+1/u3fJ
 xTD4vHtRW6XPc3S/4uKDRHtEcQrbd3FGDbzrh70Anl5uU+hUjBAu4hUmqby5b0s3qUJR
 f4Iw==
X-Gm-Message-State: AOJu0YxMi7hE6UKxKwwMYVjcCYTCCmn4yl9vR0ZHKr7SEtUiKiWvy9Qs
 1aUUJYq0OU9okppMlfIqLzDhgLpnFaVUclLmZ7o8ofsmNILyXPdv6leaw7bLuijAeOS3ZmUmiBE
 fRPiY
X-Gm-Gg: ASbGncsBgAB4KBbhE3DkBi/6y/9DyuJUfUniCxb6kyf0mFXzIckxVsBWL15p9YNjjKC
 rz9DWZPZzcKactIfc3BrweGNFzJ7CdVhg663Z7bgOsxa8mvLxOg8F4WXDlQR0c+ZTsyETQsDahM
 Chy6g5eT191xyIAjaA3BiLq4E1/2B/NMDW+2LMh4HBSCJ//YsYy8zLMLcPEXKyGUCIjW4YNilrA
 a9EaltcQyU7JDN66L/vUtQyo0/KQm2ciru9pfPnlG0dCSnd+/vHQ1odfthZc3zrRp3gWGhr/S6B
 XozpzR9BwCHgQvkWAnVJTDOsNJtZRI5NSTbg2Xj7q7iFQJ2xkzYngFLNyOhUscwlkD8=
X-Google-Smtp-Source: AGHT+IHCWt0MySBOW4/eJZhAhJfGUH28azA8GKy0+5uc6bNcCs5wVCA/bZ7gMZcibFl5b6UaTvifHQ==
X-Received: by 2002:a05:620a:bd4:b0:7d0:9ffd:423e with SMTP id
 af79cd13be357-7d44398da20mr1062133685a.13.1751140666380; 
 Sat, 28 Jun 2025 12:57:46 -0700 (PDT)
Received: from gromero0.. ([186.215.58.88]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d443136907sm334395585a.14.2025.06.28.12.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Jun 2025 12:57:45 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, eric.auger@redhat.com, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org,
 udo@hypervisor.org, ajones@ventanamicro.com, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 1/9] hw/intc/gicv3_its: Do not check its_class_name()
Date: Sat, 28 Jun 2025 19:57:14 +0000
Message-Id: <20250628195722.977078-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250628195722.977078-1-gustavo.romero@linaro.org>
References: <20250628195722.977078-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qk1-x736.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since commit cc5e719e2c8 ("kvm: require KVM_CAP_SIGNAL_MSI"), the single
implementation of its_class_name() no longer returns NULL (it now always
returns a valid char pointer). Hence, update the prototype docstring and
remove the tautological checks that use the its_class_name() returned
value.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt-acpi-build.c               | 32 +++++++++++---------------
 include/hw/intc/arm_gicv3_its_common.h |  2 +-
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 7e8e0f0298..9eee284c80 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -737,20 +737,18 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                                           memmap[VIRT_HIGH_GIC_REDIST2].size);
         }
 
-        if (its_class_name()) {
-            /*
-             * ACPI spec, Revision 6.0 Errata A
-             * (original 6.0 definition has invalid Length)
-             * 5.2.12.18 GIC ITS Structure
-             */
-            build_append_int_noprefix(table_data, 0xF, 1);  /* Type */
-            build_append_int_noprefix(table_data, 20, 1);   /* Length */
-            build_append_int_noprefix(table_data, 0, 2);    /* Reserved */
-            build_append_int_noprefix(table_data, 0, 4);    /* GIC ITS ID */
-            /* Physical Base Address */
-            build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
-            build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
-        }
+        /*
+         * ACPI spec, Revision 6.0 Errata A
+         * (original 6.0 definition has invalid Length)
+         * 5.2.12.18 GIC ITS Structure
+         */
+        build_append_int_noprefix(table_data, 0xF, 1);  /* Type */
+        build_append_int_noprefix(table_data, 20, 1);   /* Length */
+        build_append_int_noprefix(table_data, 0, 2);    /* Reserved */
+        build_append_int_noprefix(table_data, 0, 4);    /* GIC ITS ID */
+        /* Physical Base Address */
+        build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
+        build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
     } else {
         const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
 
@@ -969,10 +967,8 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
                           vms->oem_table_id);
     }
 
-    if (its_class_name()) {
-        acpi_add_table(table_offsets, tables_blob);
-        build_iort(tables_blob, tables->linker, vms);
-    }
+    acpi_add_table(table_offsets, tables_blob);
+    build_iort(tables_blob, tables->linker, vms);
 
 #ifdef CONFIG_TPM
     if (tpm_get_version(tpm_find()) == TPM_VERSION_2_0) {
diff --git a/include/hw/intc/arm_gicv3_its_common.h b/include/hw/intc/arm_gicv3_its_common.h
index 7dc712b38d..3c7b543b01 100644
--- a/include/hw/intc/arm_gicv3_its_common.h
+++ b/include/hw/intc/arm_gicv3_its_common.h
@@ -128,7 +128,7 @@ struct GICv3ITSCommonClass {
  * Return the ITS class name to use depending on whether KVM acceleration
  * and KVM CAP_SIGNAL_MSI are supported
  *
- * Returns: class name to use or NULL
+ * Returns: class name to use
  */
 const char *its_class_name(void);
 
-- 
2.34.1


