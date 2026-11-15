Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCEE606A327
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 00:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LFdmMPPH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSOQ9-0008F9-OP; Sat, 14 Nov 2026 19:48:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xSOQ8-0008Bt-SS
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 19:48:36 -0500
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xSOQ7-00016V-5L
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 19:48:36 -0500
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-1b3acec6677so2983046c88.1
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 16:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794703713; x=1795308513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=06GGkVHQKl8lhgizRBUFbOMNhL7MWupgQXxcYmmuRPg=;
 b=LFdmMPPHpdQCOfoWCGSyhyTJGuYxCIigSQCOipp9NDqHPqtL9fHmXAwTI+lzX7TIHn
 V6eQ6VnL8AwDb0vOm9U79Jp8pQOqOa0HFq2HEUzzdY9qOyN75KkOAnoK7QLOXDYiHlpD
 5QdXuHVEQ9H1WmSazotuPFFATcrFBS8/S9DhUlV5+XckWLZ7t+NYYrYteVFVd1xm0ytL
 lZAgHAawX+nTvhfQdlOmBzHxRCTrnuqMKQHInqrIHjdWUFw8GE0b8UjM2r+cYNnR4Xif
 Fqx0DhhJvuyiZVx9fXYMeAWeRLW1yAKwiFFK2jhuAZ7Bww9KNNO5dr3Q2vyK3poB43Q+
 PzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794703713; x=1795308513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=06GGkVHQKl8lhgizRBUFbOMNhL7MWupgQXxcYmmuRPg=;
 b=IyG0xc41Me6zuhHqxEXx6egKNXA8h1CnzaB+evBvk0ZJouaFzQRs5iGQwXitVXbXG9
 G8qeMIPhWYMHeoFpx0ZSmSyM58q4TLWLbeepqJohkhy1HBhS4hhUZOwjAaSdrWLrwW3J
 +IhNe70VrFcTjYglhyW2ClhNAyM7L5QB/aE8974c57H8+UzIeGHf3io9iqsCT7Nc4Y+N
 P4o2B4NFx1PTvPJG+TfAlzPlSkATWM8OaMK2fkBWHo52OcqR5DfmaaY0ROBuHoN0bFIY
 CvXNanm67s5aGyNEcnW26id6Ibi6fHTGxgpfKQ1Ag1z9H25EcTdLXoeyOo61LLnk/oWJ
 tNqQ==
X-Gm-Message-State: APuU4Z9tXQCK5jaGP0BpVQEqMzPyMApVxuWGJPbZ17K4XhA3d9m2yem7
 33fFY1lCTI52Nd3kXt/CTaRTUXZeEa+aIzh5WagJmY1QGcN/QUCClGAFBsXv9g==
X-Gm-Gg: AYBFou20t2i0FF6jgMmxOw6AKIFAcEe32mhpN+MRmVBfWPMjKo283lguBNsRnZLjHoa
 YipOD8XEiUxfg9YRzYidZVwg3fnTjbcny9miaMav+hwoCm7VTWmBg4DzvU7YV4tojhfkpglsw31
 y+BEyUBr5jZkQprI8dXAHIQIKzUoNl4azCbazrjz6gLY1OTFZOuFGhnyjz0INLxBrdjtFzO+fRm
 bsVltIIvYi9Pyw4RjrCbtDMLGr4yWr7TiQyog/YUZBhIBTWJYhqAU2Ime4BSX+y4HB/NY5haLtQ
 U6Gy5aiVvt+BR/DAiRs2+lqSdiCAmUXfB9iTS82/FBTLySYI/dzG7VQSzlMP/Ncp/+Dd78ZCsmb
 d7vnKsZyav8G411VqbME9xpc4Vx+oz+AbDhgfQmmhF7qP9NbLVL6z9qXC8L68OWOqDBGiMbaLS9
 62Xp2KuXBIuwgVVlddDg9eeez02gCAfKWOQB9LzJJoaDFyOczDu+CRwHyDGMuwWyXr6h3eF88US
 lqTrtSr9cne/aBqAxldx5+4F6Ssvl5TS5kIOl8ETadsls80EpRQtybXsDkkQRJZ17ZowxF4x+Xi
 Z+HhG6C6E7ZBg88+VWHMmNXOahGwNfHGEWAziHRmLOB8vgEWmdDfvCr6N9mJvzzZlt1E
X-Received: by 2002:a05:7300:fd05:b0:35d:4e41:d2c2 with SMTP id
 5a478bee46e88-37968b848d9mr9384417eec.33.1794703713378; 
 Sat, 14 Nov 2026 16:48:33 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379553316f2sm21102926eec.9.2026.11.14.16.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 16:48:32 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Tan Chi <tanchi25@mails.ucas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>
Subject: [PULL 2/8] hw/riscv: Build device-common only for its users
Date: Sun, 15 Nov 2026 10:48:13 +1000
Message-ID: <20261115004819.2586336-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261115004819.2586336-1-alistair.francis@wdc.com>
References: <20261115004819.2586336-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1229;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x1229.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tan Chi <tanchi25@mails.ucas.ac.cn>

hw/riscv/device-common.c is built unconditionally, although its
helpers are only used by the virt and server reference machines.

In minimal builds without these machines, device-common.c can
reference device implementations that are not built, resulting
in an undefined reference to gpex_set_irq_num().

Introduce CONFIG_RISCV_DEVICE_COMMON and select it from the two
machines that use these helpers. Build device-common.c only
when this option is enabled.

Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20261101031547.125591-3-tanchi25@mails.ucas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/Kconfig     | 5 +++++
 hw/riscv/meson.build | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index d89fdfcc8671..f3bf8d159cba 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -7,6 +7,9 @@ config RISCV_NUMA
 config IBEX
     bool
 
+config RISCV_DEVICE_COMMON
+    bool
+
 # RISC-V machines in alphabetical order
 
 config MICROCHIP_PFSOC
@@ -68,6 +71,7 @@ config RISCV_VIRT
     select PLATFORM_BUS
     select ACPI
     select ACPI_PCI
+    select RISCV_DEVICE_COMMON
 
 config RISCV_SERVER_PLATFORM_REF
     bool
@@ -85,6 +89,7 @@ config RISCV_SERVER_PLATFORM_REF
     select RISCV_IOMMU
     select RISCV_NUMA
     select SERIAL_MM
+    select RISCV_DEVICE_COMMON
 
 config SHAKTI_C
     bool
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 957031c07d5c..b60108787dd5 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -2,7 +2,7 @@ riscv_ss = ss.source_set()
 riscv_ss.add(when: ['CONFIG_RISCV_APLIC', 'CONFIG_RISCV_IMSIC'],
              if_true: files('aia.c'))
 riscv_ss.add(files('boot.c'))
-riscv_ss.add(files('device-common.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_DEVICE_COMMON', if_true: files('device-common.c'))
 riscv_ss.add(files('fdt-common.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
 riscv_ss.add(files('riscv_hart.c'))
-- 
2.55.0


