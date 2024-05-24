Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D311FC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 06:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAODZ-00034H-0h; Fri, 24 May 2024 02:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sAOD7-0002Xs-Cl
 for qemu-devel@nongnu.org; Fri, 24 May 2024 02:15:28 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sAOD3-0001LO-2j
 for qemu-devel@nongnu.org; Fri, 24 May 2024 02:15:24 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6f4ed9dc7beso2167157b3a.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 23:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716531318; x=1717136118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RcfoEn0r+dUFaV9tSzSbjgDAo5LS0QTZp+0mzHs9Iww=;
 b=am7n+mBRmMHwm/C+V3LMfQsj6tFcV1EdFD5QSGSB9dQppzPzwF06oBDdRiwWTFKiYq
 UbonILHERSqJXWOgAHsy9wuKJafGdxprmWgnIIFnQp2h0JHeZPuXna7TyMg3UMSWwDVF
 5UxlSFgyMFuHmg6v2GfpdckZOkOY851tcdtawrpY1DToQzUzYZp7Tyzmz9wOLl8q2Emq
 RPkHT6tAz5JEDTderXJLtcvF4cuFs+ABGKGqFcsQsXgxJNWouB5DYyTNGzjMUMUhvMNv
 //dZPpVxgIrZcHMbcENf0A8Bo8nxjL8TTaGRdG3GUodYgYDWWidPjAA5Ak2dbaEdsp1k
 zPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716531318; x=1717136118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RcfoEn0r+dUFaV9tSzSbjgDAo5LS0QTZp+0mzHs9Iww=;
 b=WeBBUSMpARcRq9cgNqQDWhL4/Fe25wT5NMVm/OjycFlk4RO+PxybM7QjXoPTltxmzq
 iWR3d6z6yuGs3jc0X5DIT/Y2cM5GFh8heRqbHhvUN7v9zaFaEDvfPJxEPBAFDgiRDsyT
 V3HlvSf6KwDKq+O/TDqcIQPeEabwXjpVREEoMAxvYDAUG+kBKYx2z1Spj9hqeef0NkwZ
 I+IKpGz/Telm/EiMPSF1BWfeiyLKyBCcMNg8cVkO59gkScNCQl1nNBZqR/uTencNCKkH
 ZWE9W3RlxlXBnXYugQwLU/L2q7eJ1LTAVemQIBX45TjajpV4QpQrmDt9zjT9CcrTgZpR
 im6Q==
X-Gm-Message-State: AOJu0YxAPpXQDLpv0LHbmD+NvAy6xekNPC8PZfWLoosI9ul2W1q/PVdw
 7qGF6pubtLah52XpUuWwXbkwKNQDafDv2baz74hJ4lxG3TVlqPK0vtIERbiZXD3aW0dqA8gRUHj
 HJ7M=
X-Google-Smtp-Source: AGHT+IFaIOupCbt8MyP9ePDtzaerPbsz9zDtWPggqGs5RxU6OK+nfgyPpagVfZAdNncHI6359WtA/g==
X-Received: by 2002:a05:6a00:301c:b0:6f3:eb71:af90 with SMTP id
 d2e1a72fcca58-6f8e924aa5amr2060584b3a.4.1716531317800; 
 Thu, 23 May 2024 23:15:17 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.31])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fcbea487sm516106b3a.107.2024.05.23.23.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 23:15:17 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alistair Francis <alistair23@gmail.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Haibo1 Xu <haibo1.xu@intel.com>, Anup Patel <apatel@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 08/12] pc-bios/meson.build: Add support for RISC-V in
 unpack_edk2_blobs
Date: Fri, 24 May 2024 11:44:07 +0530
Message-Id: <20240524061411.341599-9-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240524061411.341599-1-sunilvl@ventanamicro.com>
References: <20240524061411.341599-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x430.google.com
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

Update list of images supported in unpack_edk2_blobs to enable RISC-V
ACPI table testing.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 pc-bios/meson.build     | 2 ++
 tests/qtest/meson.build | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 0760612bea..8602b45b9b 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -4,6 +4,8 @@ if unpack_edk2_blobs
     'edk2-aarch64-code.fd',
     'edk2-arm-code.fd',
     'edk2-arm-vars.fd',
+    'edk2-riscv-code.fd',
+    'edk2-riscv-vars.fd',
     'edk2-i386-code.fd',
     'edk2-i386-secure-code.fd',
     'edk2-i386-vars.fd',
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 86293051dc..2f60f6aed8 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -259,6 +259,9 @@ qtests_s390x = \
 qtests_riscv32 = \
   (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
 
+qtests_riscv64 = \
+  (unpack_edk2_blobs ? ['bios-tables-test'] : [])
+
 qos_test_ss = ss.source_set()
 qos_test_ss.add(
   'ac97-test.c',
-- 
2.40.1


