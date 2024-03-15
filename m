Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF4CC54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7L9-0000fW-Pw; Fri, 15 Mar 2024 09:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1rl7KQ-00070o-D7
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:10:30 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1rl7KI-00081L-BL
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:10:29 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-29c71c6e20cso1745848a91.2
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 06:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710508220; x=1711113020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nbTQO2KVoRaBqcKgnkMGplR/jUAxDF5U80st6L4ph7Q=;
 b=RJLAhd1ciGwCfaHXQbkYjJhG5vynmk3us1blbeJpdtRyeYPcDG+M7ciY3Gk6y8yBCU
 0hSaHe3NvXum8ZJoD3KEKQO1iUiY21Rq5JIsrFUmaB+RBV1cjXW0gAjvQcX2dUPqU+B6
 X89TwWd0M+A6fTIJZ/uNHpLiHdFhkDKhq54jdkB1r2xLAAv4R9nm3OELEVkuc6yfKwmH
 8EDmpq+SG2RppdPotqRLyGYS2ISanCo1+U2g5I0GCwxGll3foL0NOKJK4uZ+NiJpDHTE
 Z9LWDScGWsVjL/eOaSA+s0Wh9rFL9ORrCGX4eXZ59zVS5+S4scUUN0L3Rj4WUNxy6kRP
 rhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710508220; x=1711113020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nbTQO2KVoRaBqcKgnkMGplR/jUAxDF5U80st6L4ph7Q=;
 b=FEUs04wsXuUT6x1yujyFanZI/aNbvrwPRS3dUqFLABaKi137UdKF+wYaTZ75oJ2r+D
 zLEr1GUhye+c2KrozVSEP7TNnjnV6PDV/4hG6ddaRbszlXQcOrY1G3KbQkAwsY/4ry4i
 kJm7hM/Zji30R67CgLWKucQnf3mNpcE18/9jh8L0/DD6Uh5tpcQObisNMB5bw//XF4F/
 mn6vkgGm5AjMv2vE/J/zb8Ut8NOJ0hGS+Uw+juMp0QmGIjnxwxq4z/VGMhoaxYZ06vGN
 7bLTm14L0WAyPp2qXhhE/jTO3O68lrSkGDMF+51DqON7aPfOV94X6UalVq/FNrmxr2Xr
 3maQ==
X-Gm-Message-State: AOJu0YyqnctQsyTzInySgMOqQbd75VmnlY1WhN6/y+oSxAwLi+Mat4Zj
 /aHc9koo5XBqT5KUaNyIlv9GhkGv/vtzv6mo9+GAyk/7LLqzAcaxnPa05b17jnW+YsHC55EnfF5
 U
X-Google-Smtp-Source: AGHT+IFbKFMKzp3PnsashRb8m5vhoqv9/1zNOpgtQHm6eK4uKz8EmZPd2f6gZpXqceUoCkcx3/NRxQ==
X-Received: by 2002:a17:90a:be18:b0:29e:781:25dc with SMTP id
 a24-20020a17090abe1800b0029e078125dcmr383552pjs.19.1710508219750; 
 Fri, 15 Mar 2024 06:10:19 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.184.12])
 by smtp.gmail.com with ESMTPSA id
 r3-20020a17090ad40300b0029c68206e2bsm2886663pju.0.2024.03.15.06.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 06:10:19 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair23@gmail.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>, Haibo1 Xu <haibo1.xu@intel.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 12/12] tests/qtest/bios-tables-test.c: Enable basic testing
 for RISC-V
Date: Fri, 15 Mar 2024 18:39:24 +0530
Message-Id: <20240315130924.2378849-10-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240315130924.2378849-1-sunilvl@ventanamicro.com>
References: <20240315130924.2378849-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Add basic ACPI table testing for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 tests/qtest/bios-tables-test.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index c492438ced..033acc8958 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1923,6 +1923,30 @@ static void test_acpi_microvm_acpi_erst(void)
 }
 #endif /* CONFIG_POSIX */
 
+static void test_acpi_riscv64_virt_tcg(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "riscv64",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-riscv-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-riscv-vars.fd",
+        .ram_start = 0x80000000ULL,
+        .scan_len = 128ULL * 1024 * 1024,
+    };
+
+    /*
+     * RHCT will have ISA string encoded. To reduce the effort
+     * of updating expected AML file for any new default ISA extension,
+     * use the profile rva22s64. Once profile is ratified, there may
+     * not be new extension possible.
+     */
+    test_acpi_one("-cpu rva22s64 -device virtio-blk-device,drive=hd0 "
+                  "-drive file=tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2,id=hd0",
+                  &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_aarch64_virt_tcg(void)
 {
     test_data data = {
@@ -2342,6 +2366,10 @@ int main(int argc, char *argv[])
                 qtest_add_func("acpi/virt/viot", test_acpi_aarch64_virt_viot);
             }
         }
+    } else if (strcmp(arch, "riscv64") == 0) {
+        if (has_tcg && qtest_has_device("virtio-blk-pci")) {
+            qtest_add_func("acpi/virt", test_acpi_riscv64_virt_tcg);
+        }
     }
     ret = g_test_run();
     boot_sector_cleanup(disk);
-- 
2.40.1


