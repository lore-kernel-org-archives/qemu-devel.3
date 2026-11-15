Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C4E606A323
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 00:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dZRJppa7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSOQ8-0008Aq-3W; Sat, 14 Nov 2026 19:48:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xSOQ5-00085v-MI
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 19:48:33 -0500
Received: from mail-dy1-x132d.google.com ([2607:f8b0:4864:20::132d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xSOQ3-00016B-VS
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 19:48:33 -0500
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-3282db206d3so6706944eec.0
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 16:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794703711; x=1795308511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9laLI1EifxNkXv3D7kotOclZPrE4Ev980+M7V9NnYEA=;
 b=dZRJppa7oAYcaYlfIOY/UAqi/ezz8Tnjk5h3mBuiJse1Q8AyuucpcJDs40xLlLvCvM
 5Cx68LAa1i+Q//bPAuyCiWiYNZX/Fq1+i3IYDqPetU3QD84sff4Ltyz+piKPdx6HhvuF
 O32C6NJ3nXoSjmzMYHwvzW/S/zY6BDMQfPhG0kxubLnbFgC7Ubzwp1De/KCBGB0Vd4Oe
 fvxbDi7U2BkD/N9ZKrxmCbS/Eha7jaGp6Ne19uv4K5BpiVolgW1BkilTvXFu46H7s4Y3
 C/e/3nJ/4DJy8GCtbMYOAqMgtT62848sX2yjd6b+x+i7oFYPoZjOhJSnrJ9vQC7xTqkn
 RmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794703711; x=1795308511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9laLI1EifxNkXv3D7kotOclZPrE4Ev980+M7V9NnYEA=;
 b=luA+veQPNqNRr/M6dV2gj7bGJS+ejwv8aPDK8AkAipOxUr1ptjU0f1WLEc9h3kVrCS
 ZraCEw9SHSZrHz6ihgijvWBg3EdJgA+QKuKSnsq/mqXEdGU0sSaydvNJLcHYiSSJ3+bw
 pSXIBPqbg9qt14+erfGrtz0JSA36gSVf8ixhgoQXwpUdKgWGVzCgpRKQPTbC97ipW2Fv
 tc4CbD24XEmIxTqeey32ZCiFdLQB2KIX06IIgO+e+QnYIG/GSxRSLTFWL9ObpEYat4DX
 2d3H7eqmsiMzS0FIRvGPZK2XUzH2qV0DbODSPWUgfHMfoJ0DYowQy2qSZKNYZzvnQvHJ
 AmCg==
X-Gm-Message-State: APuU4Z8Yr6iaWafHDyTZI7bVAJdOxl1XhB6fvbVrAGS0+69FQKiY/FxI
 z8tT9qHQ2OtFPYktQMIMmY5XzpALiRB+lZDIbNmQbNvGy2fp3lhc4ca52/rZVg==
X-Gm-Gg: AYBFou1M5mivCjp7ztewl/d5OdHNC3M329QNHXF/VFWJoz3EeeDszSJtP/FQLzFxCSY
 UAatl/DoFIglVy5dXv0Wk6MNBDgBTQDTcnRf9AydQjaQ3syYaPspLgDtATTRdkfshcqyaqi276N
 xV2K7Qh5ocuYr/XW8JKvkxb6CFdizpX32h4lIwrU68rqPheQa2hMy0OxR8DTyvlZkA8kV2pkBnD
 X9Fh6oZpkHzNOvDbZc5YnHfA3fe/GUNAeq+51Q6hd2WdbPmiUbt8cShphKLYyGUemIc1zWyrqer
 k1HlAMaE+WuMvBGggN7NkVTh/a9ZCKzcgBiSmi0AEgImavWuRpdtt2HbNCCmb1A02aQWGuz8h6A
 /OWlNtwVMF9NJqqDYYGV6eogRjtNDdAOC/jCtmwrDYkJejuQ0x61yGlA6IZhKPQHbRAxV9ETDe/
 XwfYeZ+EzHT3d4z5GFIjDT1+1boC9Fuk5aWgsgYN5Ym5OGQ4118aG8+gwS0IN8odN3wrD4Q35vJ
 E3Mgsp+G04vwdNstEjN6MdIzbnDThAIwMKuxm7l649/LBe6q5ol1rRLTlnTQCuK/TMAXH8t/mkM
 i0V4NF9rcPJ4iM0VbMZrf7/tmmBXYk17/o9hiMgNhiC8THM3
X-Received: by 2002:a05:7300:680e:b0:369:21a:dcca with SMTP id
 5a478bee46e88-37966387e53mr6805284eec.10.1794703710444; 
 Sat, 14 Nov 2026 16:48:30 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379553316f2sm21102926eec.9.2026.11.14.16.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 16:48:29 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Tan Chi <tanchi25@mails.ucas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>
Subject: [PULL 1/8] hw/riscv: Build AIA glue only with APLIC and IMSIC
Date: Sun, 15 Nov 2026 10:48:12 +1000
Message-ID: <20261115004819.2586336-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261115004819.2586336-1-alistair.francis@wdc.com>
References: <20261115004819.2586336-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132d;
 envelope-from=alistair23@gmail.com; helo=mail-dy1-x132d.google.com
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

hw/riscv/aia.c is built unconditionally, but riscv_create_aia()
references the APLIC and IMSIC device implementations, which are
only built when their respective Kconfig options are enabled.

This causes undefined references to riscv_aplic_create() in
minimal RISC-V builds that do not include APLIC.

Build aia.c only when both CONFIG_RISCV_APLIC and
CONFIG_RISCV_IMSIC are enabled. Move imsic_num_bits() to aia.h
as a static inline helper, since it is also used by FDT and
ACPI code independently of the AIA device creation helper.

Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20261101031547.125591-2-tanchi25@mails.ucas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/aia.h       | 12 +++++++++++-
 hw/riscv/aia.c       | 11 -----------
 hw/riscv/meson.build |  3 ++-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
index 5df3292610e9..e4dcc5aae09c 100644
--- a/hw/riscv/aia.h
+++ b/hw/riscv/aia.h
@@ -10,8 +10,18 @@
 #define HW_RISCV_AIA_H
 
 #include "exec/hwaddr.h"
+#include "qemu/bitops.h"
 
-uint32_t imsic_num_bits(uint32_t count);
+static inline uint32_t imsic_num_bits(uint32_t count)
+{
+    uint32_t ret = 0;
+
+    while (BIT(ret) < count) {
+        ret++;
+    }
+
+    return ret;
+}
 
 DeviceState *riscv_create_aia(MemoryRegion *container,
                              bool msimode, int aia_guests,
diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
index 56fc06453321..4463ea2be887 100644
--- a/hw/riscv/aia.c
+++ b/hw/riscv/aia.c
@@ -13,17 +13,6 @@
 
 #include "aia.h"
 
-uint32_t imsic_num_bits(uint32_t count)
-{
-    uint32_t ret = 0;
-
-    while (BIT(ret) < count) {
-        ret++;
-    }
-
-    return ret;
-}
-
 DeviceState *riscv_create_aia(MemoryRegion *container,
                              bool msimode, int aia_guests,
                              uint32_t m_imsic_stride,
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 6bdabb954473..957031c07d5c 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -1,5 +1,6 @@
 riscv_ss = ss.source_set()
-riscv_ss.add(files('aia.c'))
+riscv_ss.add(when: ['CONFIG_RISCV_APLIC', 'CONFIG_RISCV_IMSIC'],
+             if_true: files('aia.c'))
 riscv_ss.add(files('boot.c'))
 riscv_ss.add(files('device-common.c'))
 riscv_ss.add(files('fdt-common.c'))
-- 
2.55.0


