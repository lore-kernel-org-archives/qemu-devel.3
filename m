Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B45E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 08:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQjEN-0002zb-5u; Thu, 26 Dec 2024 03:28:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3nxNtZwgKCrwywjcqvujiqqing.eqosgow-fgxgnpqpipw.qti@flex--wuhaotsh.bounces.google.com>)
 id 1tQjEA-0002G1-Q9
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:28:21 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3nxNtZwgKCrwywjcqvujiqqing.eqosgow-fgxgnpqpipw.qti@flex--wuhaotsh.bounces.google.com>)
 id 1tQjE9-00019t-26
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:28:18 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-21631cbf87dso68327815ad.3
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 00:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1735201695; x=1735806495; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=xfNC9ogz1de0wuLdHYiHiqwKVT4pFZIRykyJquvWBMg=;
 b=Nzm5BA0nmIij/AJC5kQRZZw8fN3cXXmB/iKhKe3NKsWISux206DJnelpJeiMUelrfR
 Q01d86u66Ax9ubAy1hVCfGroSpNF2vjVFUpMmvWda8GvGWOkq53HJJo3xWF3A2kK7O36
 2kD00TpO2JpGbMkta292rHgNgSGzNbNWJzCQczUudJ4IBtY8pNYSN9kpwBI6dUeQ2Zdd
 6UAqE4GYBRdLkNB4/0eMj48sZmE/bkOPQvqllEsc9P6Gwmm7rBJlCD+mD7Z9jmdYJdP0
 JIt02NYMado3ymUIOkEv6oHW8oZoRqHJBSswf666gERmylQrnMdm3mbVOXt7g1aOg+XN
 XTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735201695; x=1735806495;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xfNC9ogz1de0wuLdHYiHiqwKVT4pFZIRykyJquvWBMg=;
 b=s6Ngjwn8EAY253SKb2MLDoxK2BUh/+TCh/X44zJcztg0L/6wjlaUrTTXUVGb92BVXX
 v1a1753v+9/hqPebPcdX5UBwtrgyfghOdNODeaK96FI0GpyasiKp/S8Xmui09acC6FSH
 DjLgY9qbWJ2fE37P3VNDd7xR5eDj8Pc8gvRbl253W5HCkWKI8TgmiYlhm8U42m5MTmgU
 YZeCUGiq6R7EGNTyeV0b8tDv/A/D1o8nfsgRlHdXvrlVYSzAgJUjRNAQ+Kja5fNUQT/W
 WphuDN/ME0H2Fow4Req4Dg/jstEjjybuXRBKhEtraJwrWvj4zRC9/j+lFnxw5brW6hAD
 +PhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbnjl0/al+fH8eIicUS+YBk3R3PyBjcJu8Glgr4wNeY+5fQUOmuQDfjNJxNhUtQTN388nKgBTdBwy6@nongnu.org
X-Gm-Message-State: AOJu0YzYTyg6lUstUByogYEilu+ZhxSfz7ytHoNFp+mmbWd/jIEI0pGr
 0vzjA5/5YuunPAH/3xXyh9XdPEYQ+pCX/s94mP+UMRrO1QUu6QxbydE04IwqgDekHnR4O8ktxOf
 kdTEKqG/lxQ==
X-Google-Smtp-Source: AGHT+IESZ7Y3INb23OkoSCkS3wnytVIo9w3OKUtwFRMRVEfAsw9KRqLvBGSctyfhIY8VeVGgWdbKdy32aHz4dQ==
X-Received: from pgpu12.prod.google.com ([2002:a65:40cc:0:b0:867:6a40:fe56])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3181:b0:1e1:b062:f409 with SMTP id
 adf61e73a8af0-1e5e081db95mr33803839637.43.1735201695256; 
 Thu, 26 Dec 2024 00:28:15 -0800 (PST)
Date: Thu, 26 Dec 2024 08:27:46 +0000
In-Reply-To: <20241226082800.2887689-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20241226082800.2887689-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241226082800.2887689-4-wuhaotsh@google.com>
Subject: [PATCH v2 03/17] pc-bios: Add NPCM8XX vBootrom
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, mimik-dev@google.com, 
 hskinnemoen@google.com, venture@google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3nxNtZwgKCrwywjcqvujiqqing.eqosgow-fgxgnpqpipw.qti@flex--wuhaotsh.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

The bootrom is a minimal bootrom used to load an NPCM8XX image.
The source code is located in the same repo as the NPCM7XX one:
github.com/google/vbootrom/tree/master/npcm8xx.

Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 MAINTAINERS                 |   1 +
 pc-bios/README              |   8 ++++----
 pc-bios/meson.build         |   1 +
 pc-bios/npcm8xx_bootrom.bin | Bin 0 -> 608 bytes
 roms/Makefile               |   6 ++++++
 5 files changed, 12 insertions(+), 4 deletions(-)
 create mode 100644 pc-bios/npcm8xx_bootrom.bin

diff --git a/MAINTAINERS b/MAINTAINERS
index 38a290e9c2..14bfadabbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -872,6 +872,7 @@ F: include/hw/*/npcm*
 F: tests/qtest/npcm*
 F: tests/qtest/adm1266-test.c
 F: pc-bios/npcm7xx_bootrom.bin
+F: pc-bios/npcm8xx_bootrom.bin
 F: roms/vbootrom
 F: docs/system/arm/nuvoton.rst
 F: tests/functional/test_arm_quanta_gsj.py
diff --git a/pc-bios/README b/pc-bios/README
index 7ffb2f43a4..700dcaab52 100644
--- a/pc-bios/README
+++ b/pc-bios/README
@@ -70,10 +70,10 @@
   source code also contains code reused from other projects described here:
   https://github.com/riscv/opensbi/blob/master/ThirdPartyNotices.md.
 
-- npcm7xx_bootrom.bin is a simplified, free (Apache 2.0) boot ROM for Nuvoton
-  NPCM7xx BMC devices. It currently implements the bare minimum to load, parse,
-  initialize and run boot images stored in SPI flash, but may grow more
-  features over time as needed. The source code is available at:
+- npcm{7xx,8xx}_bootrom.bin is a simplified, free (Apache 2.0) boot ROM for
+  Nuvoton NPCM7xx/8xx BMC devices. It currently implements the bare minimum to
+  load, parse, initialize and run boot images stored in SPI flash, but may grow
+  more features over time as needed. The source code is available at:
   https://github.com/google/vbootrom
 
 - hppa-firmware.img (32-bit) and hppa-firmware64.img (64-bit) are firmware
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 4823dff189..d282c43658 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -80,6 +80,7 @@ blobs = [
   'opensbi-riscv32-generic-fw_dynamic.bin',
   'opensbi-riscv64-generic-fw_dynamic.bin',
   'npcm7xx_bootrom.bin',
+  'npcm8xx_bootrom.bin',
   'vof.bin',
   'vof-nvram.bin',
 ]
diff --git a/pc-bios/npcm8xx_bootrom.bin b/pc-bios/npcm8xx_bootrom.bin
new file mode 100644
index 0000000000000000000000000000000000000000..6370d6475635c4d445d2b927311edcd591949c82
GIT binary patch
literal 608
zcmdUrKTE?<6vfX=0{*3B5ET?nwWA^;qEk()n=Xb9-4dxoSBrz#p|QJQL~zokn{Eyc
z?PBXUkU+aB?k?IbNQftG5ej|*FC2c{bKkr7zLy3jhNxj`gc_y5h&V=Ru)PgZC)Y`f
zTqA9Am28qL<U6@cMtA>Hlr*^&hT#;re-)dpxT0U42|O+cWOcx=B;{6xXH04vx?cjm
z+%U{oFx!aPpV3>ZKz0i$XA-yq{f}<H?{MHBq+VwIvR9WmcL(xr1vuIRGELcRC-S+P
zl3%RlR5(6+1;xg_<~xR#bPItDN1*Hp^{JyNs7o*BMq0Q9q1#>x4;|pb<NWIbQ8wb1
zTac^<ebj^E^Ig<?U?(PO-w>w;l#@9zGd|z-rs*H@V-o%PEV)D-)8n2%DyH5@w_^Y8
LH5R3RMV#gjxYTW}

literal 0
HcmV?d00001

diff --git a/roms/Makefile b/roms/Makefile
index 31e4b97c98..beff58d9d5 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -34,6 +34,7 @@ find-cross-gcc = $(firstword $(wildcard $(patsubst %ld,%gcc,$(call find-cross-ld
 # finally strip off path + toolname so we get the prefix
 find-cross-prefix = $(subst gcc,,$(notdir $(call find-cross-gcc,$(1))))
 
+aarch64_cross_prefix := $(call find-cross-prefix,aarch64)
 arm_cross_prefix := $(call find-cross-prefix,arm)
 powerpc64_cross_prefix := $(call find-cross-prefix,powerpc64)
 powerpc_cross_prefix := $(call find-cross-prefix,powerpc)
@@ -66,6 +67,7 @@ default help:
 	@echo "  u-boot.e500        -- update u-boot.e500"
 	@echo "  u-boot.sam460      -- update u-boot.sam460"
 	@echo "  npcm7xx_bootrom    -- update vbootrom for npcm7xx"
+	@echo "  npcm8xx_bootrom    -- update vbootrom for npcm8xx"
 	@echo "  efi                -- update UEFI (edk2) platform firmware"
 	@echo "  opensbi32-generic  -- update OpenSBI for 32-bit generic machine"
 	@echo "  opensbi64-generic  -- update OpenSBI for 64-bit generic machine"
@@ -194,6 +196,10 @@ npcm7xx_bootrom:
 	$(MAKE) -C vbootrom CROSS_COMPILE=$(arm_cross_prefix)
 	cp vbootrom/npcm7xx_bootrom.bin ../pc-bios/npcm7xx_bootrom.bin
 
+npcm8xx_bootrom:
+	$(MAKE) -C vbootrom CROSS_COMPILE=$(aarch64_cross_prefix)
+	cp vbootrom/npcm8xx_bootrom.bin ../pc-bios/npcm8xx_bootrom.bin
+
 hppa-firmware:
 	$(MAKE) -C seabios-hppa parisc
 	cp seabios-hppa/out/hppa-firmware.img      ../pc-bios/
-- 
2.47.1.613.gc27f4b7a9f-goog


