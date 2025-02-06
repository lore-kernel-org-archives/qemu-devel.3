Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58B6C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 01:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfqk5-0005FX-Dk; Wed, 05 Feb 2025 20:31:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <34hCkZwgKCtcPNA3HMLA9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--wuhaotsh.bounces.google.com>)
 id 1tfqjk-0005C4-Hy
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 20:31:24 -0500
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <34hCkZwgKCtcPNA3HMLA9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--wuhaotsh.bounces.google.com>)
 id 1tfqjf-0006sy-76
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 20:31:21 -0500
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2f9f90051a2so717088a91.2
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 17:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1738805474; x=1739410274; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=JGq/NCRPeL22eLhkL37mD6vo4KePc8psLH0Fx7CR06c=;
 b=k78m9n84dnkH0EmevjEYE/z8ghvcDkPYzehpw5JgyE4OJZXZQ5iiCxMqxr5dW7l//t
 G6id4HE7iQ7eyBP+0EmhrDouqVZuyy0rSAxH+yzsTSyeRHGW56+hJsb6T+EXPBX5IMQP
 WOA7Ofh5/UBJczStNbcLJXsLYnlNSwJyR5UtrHBNwjKwd7HGtH4go/RHW2G5qVpTuncB
 JJzHsf7hZ4Wc+U7LGkVieHmN9loXFais+BXPQPwCic6dqIvPq959PDIm3Fq6v5dsf7Dq
 rotRFwU2HtxPKcMgcJIz8C1ZAzO+WIYigaWOmUyYjUJ6ciFGQuHJ0+DVoSA7C+IiGcrE
 Q+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738805474; x=1739410274;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JGq/NCRPeL22eLhkL37mD6vo4KePc8psLH0Fx7CR06c=;
 b=Fmh3jCr/yJNt67H+rPtGbs/hhUohM+l5iTk29VJDHzJv7r/rUx26AKA6OG7z972ma4
 p4XIZD0Vw68OZ8nLMnIgfS9+vl0huadLqa6QozgaRF+4xIrV36NyrdTvzm3kj7aNXAA/
 LlsZWeifeyqqNpLMY/4c1ZM8vNyKCawHSiaAg4qiabs4I+Wx2wrPAU/MFs94986EneqC
 fh4pur+gSUDzmiRDty0BFThExJQf3xElIEfK0hUWn2YFno48Xzi1IpZKq/taYmUc5+Md
 1jg0IanebPeiG32Ba4wBXL5emd3ItWZBGSUGHW6OnGOPea8BxeQIb7ZnoOYJbgt6Y5Wy
 mmog==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO8DFZOaKbyLmEZY6YLbDqJAPpjNRdmKp9AubzPyUVcu8NHbH0N4ivlyHCzNczexL33uQbfuo3C9uc@nongnu.org
X-Gm-Message-State: AOJu0Yz1DljDij8Uoq5N5yNf6b+3hVz5qZoXNo2oYqlYHTy+tXE360Tn
 Wf/Qw9sXjND4JVgssm48pgmR48zMfDHzPgWLgBnCLXI1k9tloQEIYKqQSADw/L/cTAjLT3wLC/Y
 9Pn3S3JFCRg==
X-Google-Smtp-Source: AGHT+IFn5wbU6zHAbYrZOchtMK4UhkkIcn5URo3EYAgM59xHDrgghSyTW4vBf8gOc5PrE3oNaOw6UCtP3EhTqg==
X-Received: from pjm5.prod.google.com ([2002:a17:90b:2fc5:b0:2ee:4b69:50e1])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3557:b0:2f4:434d:c7f0 with SMTP id
 98e67ed59e1d1-2f9e076271fmr9378463a91.12.1738805474524; 
 Wed, 05 Feb 2025 17:31:14 -0800 (PST)
Date: Wed,  5 Feb 2025 17:30:50 -0800
In-Reply-To: <20250206013105.3228344-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20250206013105.3228344-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250206013105.3228344-3-wuhaotsh@google.com>
Subject: [PATCH v3 02/17] pc-bios: Add NPCM8XX vBootrom
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=34hCkZwgKCtcPNA3HMLA9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--wuhaotsh.bounces.google.com;
 helo=mail-pj1-x1049.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
index 0cf37fce7b..d0245febd7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -878,6 +878,7 @@ F: include/hw/*/npcm*
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
index b68b29cc7d..51e95cc903 100644
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
2.48.1.362.g079036d154-goog


