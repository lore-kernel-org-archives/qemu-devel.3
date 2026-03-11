Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E9DFD88D8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 01:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w08XW-00043O-8i; Tue, 10 Mar 2026 21:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XS-00041g-SJ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:39:06 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XP-0004sZ-Qw
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:39:06 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ad9a9be502so88193055ad.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 18:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773193142; x=1773797942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hBOqSa1r8WJ9Kn5oraKJkRksFDgpShnw3SyjmD/FkTY=;
 b=swftMPpcuECQhdnmV6KLeBlR+oT/F+Plf/xwXlHZRVuhqgmU1KjUADdN3c5ncx+USb
 gQ1N2fgj42V1m443xRyxui/sU2pG6ynxwvj48/sHwz1tzhkqLNsL6D2dhbycf9SbpGHd
 6OrpgmFDmD1piX2lTVdNTwj+XrKE1+nopZ//UDrLDZdlj9Q9J+fAty/N8qgKrjYzlbGn
 PKO8kK4t9tCToDTiTZgP55v8beTzvKqXRso8fqYvqHpXA5jM5SZR0ZnrOxBsl3F5J4Kt
 65Qw/wk6lgrV+SoniqWJPkLjk5ry6cQB1rwZ1U7oje8bEqeKvkRoUOPS6h0krZY49THn
 rE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773193142; x=1773797942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hBOqSa1r8WJ9Kn5oraKJkRksFDgpShnw3SyjmD/FkTY=;
 b=o+lZy5LPJO6DIKDfmuyyg6KVd8eI1JtsbrsRXV6/a09wijvL3Pl+C4F9ge4Fj9xB2H
 eIQUBNbGZvyjNTNtjtg5h/aFDE7X29IXkBBONyP2lfoB0MpGgkHbvkyGPfhx0dbp/ry2
 /NrgnufTYYMMb3CtDRFooRyX9zqFDHtmFfoFhC6kMMrwQGNeOseVZK0ZADRnJhh88io0
 sxBYNTAqutqJnMfBmsHYRd1aOpnw3xgztD+PQZPlQXxEkv6ssd7lLtepl1a0nTiKdWRr
 Uv6f+nCFbRdKIJjRKUveNn/G0gIy3ydY6mm5WpwFbE5dpRT1Ftq2eLQjZDDcetIMwnr9
 Qwdg==
X-Gm-Message-State: AOJu0YzLO6lcZLFoNFdBbXIc2IMo8+UUbviRFnR7OcP5tXYMW6oUGNx0
 WfQM0RnPp5aAMYPIpqy/xEdtVu875+AUSLK2GXETzhecH00h4u48PLatVCQUT21gxyiax8k5usO
 DqVmT
X-Gm-Gg: ATEYQzwJ+ixU05tq3piM3VLMapreVSGkO+Z4GEmKZ2r2t2CDU0GJW5MhmvgEWcFKvAS
 oAjMhfV+hphA2r4Y2/H5gzeBahil3XO1n/kVdV+Ircc3QpvKH60oioSJzgEzt/mGsqhBbhui6Py
 b4KDx7RqubamX4E/3tE5Ie0rP5nyr45SWbOivYwloyb5deQKdQtoVPS3nKiHn4+rAtuHNRh43Co
 z4lzq2o2QwJfmsr81a1WIJdmAceB0cyZsUs08KncBQAEAN1TM2d1/N0ESZSavo4KVtGxvr6hsp2
 UU0Lf3yyJyYBcm7Sg1yXS85jK5GN2jPafNBBuPqijhmageaVzg2E+BO1n/0k0F7R2O9Pr/HDVe0
 YWGCKcNiTRRnwWHDWRog2EfB/wexUZ7KWRNUt+hSmbEcyKp27nBmaebk5hpwjY0Q2rA8dUcDpDO
 OQ/FsGtQXV8Z6FyzpEgzWKO9n0aVwSjRRfS5zM2X+Do7sEkxL+nSU6rYdOfnEqdo01sRwZVgB5e
 t+5
X-Received: by 2002:a17:902:d482:b0:2ae:4fc7:8053 with SMTP id
 d9443c01a7336-2aeae8b42f5mr7838585ad.46.1773193142177; 
 Tue, 10 Mar 2026 18:39:02 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae2466d3sm5390175ad.22.2026.03.10.18.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 18:39:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 15/16] gdbstub: Move gdb-xml/ within gdbstub/
Date: Tue, 10 Mar 2026 18:38:36 -0700
Message-ID: <20260311013837.69945-16-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
References: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

gdb-xml/ files are only consumed by gdbstub API.
No need for a top-level entry, move them to gdbstub/.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260310232045.58440-16-philmd@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 MAINTAINERS                                   | 19 +++++++++----------
 docs/devel/codebase.rst                       |  2 --
 meson.build                                   |  2 +-
 {gdb-xml => gdbstub/gdb-xml}/aarch64-core.xml |  0
 {gdb-xml => gdbstub/gdb-xml}/aarch64-fpu.xml  |  0
 {gdb-xml => gdbstub/gdb-xml}/aarch64-mte.xml  |  0
 .../gdb-xml}/aarch64-pauth.xml                |  0
 {gdb-xml => gdbstub/gdb-xml}/aarch64-sme2.xml |  0
 {gdb-xml => gdbstub/gdb-xml}/alpha-core.xml   |  0
 {gdb-xml => gdbstub/gdb-xml}/arm-core.xml     |  0
 .../gdb-xml}/arm-m-profile-mve.xml            |  0
 .../gdb-xml}/arm-m-profile.xml                |  0
 {gdb-xml => gdbstub/gdb-xml}/arm-neon.xml     |  0
 .../gdb-xml}/arm-vfp-sysregs.xml              |  0
 {gdb-xml => gdbstub/gdb-xml}/arm-vfp.xml      |  0
 {gdb-xml => gdbstub/gdb-xml}/arm-vfp3.xml     |  0
 {gdb-xml => gdbstub/gdb-xml}/avr-cpu.xml      |  0
 {gdb-xml => gdbstub/gdb-xml}/cf-core.xml      |  0
 {gdb-xml => gdbstub/gdb-xml}/cf-fp.xml        |  0
 {gdb-xml => gdbstub/gdb-xml}/hexagon-core.xml |  0
 {gdb-xml => gdbstub/gdb-xml}/hexagon-hvx.xml  |  0
 .../gdb-xml}/i386-32bit-linux.xml             |  0
 {gdb-xml => gdbstub/gdb-xml}/i386-32bit.xml   |  0
 .../gdb-xml}/i386-64bit-apx.xml               |  0
 .../gdb-xml}/i386-64bit-linux.xml             |  0
 {gdb-xml => gdbstub/gdb-xml}/i386-64bit.xml   |  0
 .../gdb-xml}/loongarch-base32.xml             |  0
 .../gdb-xml}/loongarch-base64.xml             |  0
 .../gdb-xml}/loongarch-fpu.xml                |  0
 .../gdb-xml}/loongarch-lasx.xml               |  0
 .../gdb-xml}/loongarch-lsx.xml                |  0
 {gdb-xml => gdbstub/gdb-xml}/m68k-core.xml    |  0
 {gdb-xml => gdbstub/gdb-xml}/m68k-fp.xml      |  0
 .../gdb-xml}/microblaze-core.xml              |  0
 .../gdb-xml}/microblaze-stack-protect.xml     |  0
 {gdb-xml => gdbstub/gdb-xml}/or1k-core.xml    |  0
 .../gdb-xml}/power-altivec.xml                |  0
 {gdb-xml => gdbstub/gdb-xml}/power-core.xml   |  0
 {gdb-xml => gdbstub/gdb-xml}/power-fpu.xml    |  0
 {gdb-xml => gdbstub/gdb-xml}/power-spe.xml    |  0
 {gdb-xml => gdbstub/gdb-xml}/power-vsx.xml    |  0
 {gdb-xml => gdbstub/gdb-xml}/power64-core.xml |  0
 .../gdb-xml}/riscv-32bit-cpu.xml              |  0
 .../gdb-xml}/riscv-32bit-fpu.xml              |  0
 .../gdb-xml}/riscv-32bit-virtual.xml          |  0
 .../gdb-xml}/riscv-64bit-cpu.xml              |  0
 .../gdb-xml}/riscv-64bit-fpu.xml              |  0
 .../gdb-xml}/riscv-64bit-virtual.xml          |  0
 {gdb-xml => gdbstub/gdb-xml}/rx-core.xml      |  0
 {gdb-xml => gdbstub/gdb-xml}/s390-acr.xml     |  0
 {gdb-xml => gdbstub/gdb-xml}/s390-cr.xml      |  0
 {gdb-xml => gdbstub/gdb-xml}/s390-fpr.xml     |  0
 {gdb-xml => gdbstub/gdb-xml}/s390-gs.xml      |  0
 .../gdb-xml}/s390-virt-kvm.xml                |  0
 {gdb-xml => gdbstub/gdb-xml}/s390-virt.xml    |  0
 {gdb-xml => gdbstub/gdb-xml}/s390-vx.xml      |  0
 {gdb-xml => gdbstub/gdb-xml}/s390x-core64.xml |  0
 {gdb-xml => gdbstub/gdb-xml}/sparc32-cp0.xml  |  0
 {gdb-xml => gdbstub/gdb-xml}/sparc32-cpu.xml  |  0
 {gdb-xml => gdbstub/gdb-xml}/sparc32-fpu.xml  |  0
 {gdb-xml => gdbstub/gdb-xml}/sparc64-cp0.xml  |  0
 {gdb-xml => gdbstub/gdb-xml}/sparc64-cpu.xml  |  0
 {gdb-xml => gdbstub/gdb-xml}/sparc64-fpu.xml  |  0
 63 files changed, 10 insertions(+), 13 deletions(-)
 rename {gdb-xml => gdbstub/gdb-xml}/aarch64-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/aarch64-fpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/aarch64-mte.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/aarch64-pauth.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/aarch64-sme2.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/alpha-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-m-profile-mve.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-m-profile.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-neon.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-vfp-sysregs.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-vfp.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-vfp3.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/avr-cpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/cf-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/cf-fp.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/hexagon-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/hexagon-hvx.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/i386-32bit-linux.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/i386-32bit.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/i386-64bit-apx.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/i386-64bit-linux.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/i386-64bit.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/loongarch-base32.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/loongarch-base64.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/loongarch-fpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/loongarch-lasx.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/loongarch-lsx.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/m68k-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/m68k-fp.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/microblaze-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/microblaze-stack-protect.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/or1k-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/power-altivec.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/power-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/power-fpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/power-spe.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/power-vsx.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/power64-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/riscv-32bit-cpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/riscv-32bit-fpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/riscv-32bit-virtual.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/riscv-64bit-cpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/riscv-64bit-fpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/riscv-64bit-virtual.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/rx-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-acr.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-cr.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-fpr.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-gs.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-virt-kvm.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-virt.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-vx.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390x-core64.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/sparc32-cp0.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/sparc32-cpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/sparc32-fpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/sparc64-cp0.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/sparc64-cpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/sparc64-fpu.xml (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d1614fd7e9..247799c817c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -106,7 +106,7 @@ M: Thomas Huth <thuth@redhat.com>
 S: Supported
 F: configs/devices/s390x-softmmu/default.mak
 F: configs/targets/s390x-softmmu.mak
-F: gdb-xml/s390*.xml
+F: gdbstub/gdb-xml/s390*.xml
 F: hw/char/sclp*.[hc]
 F: hw/char/terminal3270.c
 F: hw/intc/s390_flic.c
@@ -221,8 +221,8 @@ F: include/hw/cpu/a*mpcore.h
 F: docs/system/target-arm.rst
 F: docs/system/arm/cpu-features.rst
 F: docs/system/arm/emulation.rst
-F: gdb-xml/arm*.xml
-F: gdb-xml/aarch64*.xml
+F: gdbstub/gdb-xml/arm*.xml
+F: gdbstub/gdb-xml/aarch64*.xml
 
 ARM SMMU
 M: Eric Auger <eric.auger@redhat.com>
@@ -237,7 +237,7 @@ AVR TCG CPUs
 M: Michael Rolnik <mrolnik@gmail.com>
 S: Maintained
 F: docs/system/target-avr.rst
-F: gdb-xml/avr-cpu.xml
+F: gdbstub/gdb-xml/avr-cpu.xml
 F: target/avr/
 F: tests/functional/avr/
 
@@ -252,7 +252,7 @@ F: tests/tcg/hexagon/
 F: disas/hexagon.c
 F: configs/targets/hexagon-linux-user/default.mak
 F: docker/dockerfiles/debian-hexagon-cross.docker
-F: gdb-xml/hexagon*.xml
+F: gdbstub/gdb-xml/hexagon*.xml
 T: git https://github.com/quic/qemu.git hex-next
 
 Hexagon idef-parser
@@ -311,7 +311,7 @@ M: Stafford Horne <shorne@gmail.com>
 S: Odd Fixes
 F: docs/system/or1k/cpu-features.rst
 F: target/or1k/
-F: gdb-xml/or1k-core.xml
+F: gdbstub/gdb-xml/or1k-core.xml
 F: hw/or1k/
 F: include/hw/or1k/
 F: tests/functional/or1k/meson.build
@@ -411,7 +411,7 @@ M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
 M: Artyom Tarasenko <atar4qemu@gmail.com>
 S: Maintained
 F: target/sparc/
-F: gdb-xml/sparc*.xml
+F: gdbstub/gdb-xml/sparc*.xml
 F: hw/sparc/
 F: hw/sparc64/
 F: include/hw/sparc/sparc64.h
@@ -499,7 +499,7 @@ S: Supported
 F: target/s390x/kvm/
 F: target/s390x/machine.c
 F: target/s390x/sigp.c
-F: gdb-xml/s390*.xml
+F: gdbstub/gdb-xml/s390*.xml
 T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
@@ -1352,7 +1352,7 @@ F: include/hw/intc/loongson_ipi_common.h
 F: hw/intc/loongarch_*.c
 F: hw/intc/loongson_ipi_common.c
 F: hw/rtc/ls7a_rtc.c
-F: gdb-xml/loongarch*.xml
+F: gdbstub/gdb-xml/loongarch*.xml
 
 M68K Machines
 -------------
@@ -3311,7 +3311,6 @@ F: docs/system/gdb.rst
 F: gdbstub/*
 F: include/exec/gdbstub.h
 F: include/gdbstub/*
-F: gdb-xml/
 F: tests/tcg/multiarch/gdbstub/*
 F: scripts/feature_to_c.py
 F: scripts/probe-gdb-support.py
diff --git a/docs/devel/codebase.rst b/docs/devel/codebase.rst
index 69d88271178..f09307b8971 100644
--- a/docs/devel/codebase.rst
+++ b/docs/devel/codebase.rst
@@ -88,8 +88,6 @@ yet, so sometimes the source code is all you have.
   `VirtFS <https://www.linux-kvm.org/page/VirtFS>`_ support.
 * `gdbstub <https://gitlab.com/qemu-project/qemu/-/tree/master/gdbstub>`_:
   `GDB <GDB usage>` support.
-* `gdb-xml <https://gitlab.com/qemu-project/qemu/-/tree/master/gdb-xml>`_:
-  Set of XML files describing architectures and used by `gdbstub <GDB usage>`.
 * `host <https://gitlab.com/qemu-project/qemu/-/tree/master/host>`_:
   Various architecture specific header files (crypto, atomic, memory
   operations).
diff --git a/meson.build b/meson.build
index 8e8440941c0..503cde5ea90 100644
--- a/meson.build
+++ b/meson.build
@@ -4331,7 +4331,7 @@ foreach target : target_dirs
   if 'TARGET_XML_FILES' in config_target
     gdbstub_xml_files = []
     foreach gdbstub_xml : config_target['TARGET_XML_FILES'].split()
-      gdbstub_xml_files += 'gdb-xml/' + gdbstub_xml
+      gdbstub_xml_files += 'gdbstub/gdb-xml/' + gdbstub_xml
     endforeach
     gdbstub_xml = custom_target(target + '-gdbstub-xml.c',
                                 output: target + '-gdbstub-xml.c',
diff --git a/gdb-xml/aarch64-core.xml b/gdbstub/gdb-xml/aarch64-core.xml
similarity index 100%
rename from gdb-xml/aarch64-core.xml
rename to gdbstub/gdb-xml/aarch64-core.xml
diff --git a/gdb-xml/aarch64-fpu.xml b/gdbstub/gdb-xml/aarch64-fpu.xml
similarity index 100%
rename from gdb-xml/aarch64-fpu.xml
rename to gdbstub/gdb-xml/aarch64-fpu.xml
diff --git a/gdb-xml/aarch64-mte.xml b/gdbstub/gdb-xml/aarch64-mte.xml
similarity index 100%
rename from gdb-xml/aarch64-mte.xml
rename to gdbstub/gdb-xml/aarch64-mte.xml
diff --git a/gdb-xml/aarch64-pauth.xml b/gdbstub/gdb-xml/aarch64-pauth.xml
similarity index 100%
rename from gdb-xml/aarch64-pauth.xml
rename to gdbstub/gdb-xml/aarch64-pauth.xml
diff --git a/gdb-xml/aarch64-sme2.xml b/gdbstub/gdb-xml/aarch64-sme2.xml
similarity index 100%
rename from gdb-xml/aarch64-sme2.xml
rename to gdbstub/gdb-xml/aarch64-sme2.xml
diff --git a/gdb-xml/alpha-core.xml b/gdbstub/gdb-xml/alpha-core.xml
similarity index 100%
rename from gdb-xml/alpha-core.xml
rename to gdbstub/gdb-xml/alpha-core.xml
diff --git a/gdb-xml/arm-core.xml b/gdbstub/gdb-xml/arm-core.xml
similarity index 100%
rename from gdb-xml/arm-core.xml
rename to gdbstub/gdb-xml/arm-core.xml
diff --git a/gdb-xml/arm-m-profile-mve.xml b/gdbstub/gdb-xml/arm-m-profile-mve.xml
similarity index 100%
rename from gdb-xml/arm-m-profile-mve.xml
rename to gdbstub/gdb-xml/arm-m-profile-mve.xml
diff --git a/gdb-xml/arm-m-profile.xml b/gdbstub/gdb-xml/arm-m-profile.xml
similarity index 100%
rename from gdb-xml/arm-m-profile.xml
rename to gdbstub/gdb-xml/arm-m-profile.xml
diff --git a/gdb-xml/arm-neon.xml b/gdbstub/gdb-xml/arm-neon.xml
similarity index 100%
rename from gdb-xml/arm-neon.xml
rename to gdbstub/gdb-xml/arm-neon.xml
diff --git a/gdb-xml/arm-vfp-sysregs.xml b/gdbstub/gdb-xml/arm-vfp-sysregs.xml
similarity index 100%
rename from gdb-xml/arm-vfp-sysregs.xml
rename to gdbstub/gdb-xml/arm-vfp-sysregs.xml
diff --git a/gdb-xml/arm-vfp.xml b/gdbstub/gdb-xml/arm-vfp.xml
similarity index 100%
rename from gdb-xml/arm-vfp.xml
rename to gdbstub/gdb-xml/arm-vfp.xml
diff --git a/gdb-xml/arm-vfp3.xml b/gdbstub/gdb-xml/arm-vfp3.xml
similarity index 100%
rename from gdb-xml/arm-vfp3.xml
rename to gdbstub/gdb-xml/arm-vfp3.xml
diff --git a/gdb-xml/avr-cpu.xml b/gdbstub/gdb-xml/avr-cpu.xml
similarity index 100%
rename from gdb-xml/avr-cpu.xml
rename to gdbstub/gdb-xml/avr-cpu.xml
diff --git a/gdb-xml/cf-core.xml b/gdbstub/gdb-xml/cf-core.xml
similarity index 100%
rename from gdb-xml/cf-core.xml
rename to gdbstub/gdb-xml/cf-core.xml
diff --git a/gdb-xml/cf-fp.xml b/gdbstub/gdb-xml/cf-fp.xml
similarity index 100%
rename from gdb-xml/cf-fp.xml
rename to gdbstub/gdb-xml/cf-fp.xml
diff --git a/gdb-xml/hexagon-core.xml b/gdbstub/gdb-xml/hexagon-core.xml
similarity index 100%
rename from gdb-xml/hexagon-core.xml
rename to gdbstub/gdb-xml/hexagon-core.xml
diff --git a/gdb-xml/hexagon-hvx.xml b/gdbstub/gdb-xml/hexagon-hvx.xml
similarity index 100%
rename from gdb-xml/hexagon-hvx.xml
rename to gdbstub/gdb-xml/hexagon-hvx.xml
diff --git a/gdb-xml/i386-32bit-linux.xml b/gdbstub/gdb-xml/i386-32bit-linux.xml
similarity index 100%
rename from gdb-xml/i386-32bit-linux.xml
rename to gdbstub/gdb-xml/i386-32bit-linux.xml
diff --git a/gdb-xml/i386-32bit.xml b/gdbstub/gdb-xml/i386-32bit.xml
similarity index 100%
rename from gdb-xml/i386-32bit.xml
rename to gdbstub/gdb-xml/i386-32bit.xml
diff --git a/gdb-xml/i386-64bit-apx.xml b/gdbstub/gdb-xml/i386-64bit-apx.xml
similarity index 100%
rename from gdb-xml/i386-64bit-apx.xml
rename to gdbstub/gdb-xml/i386-64bit-apx.xml
diff --git a/gdb-xml/i386-64bit-linux.xml b/gdbstub/gdb-xml/i386-64bit-linux.xml
similarity index 100%
rename from gdb-xml/i386-64bit-linux.xml
rename to gdbstub/gdb-xml/i386-64bit-linux.xml
diff --git a/gdb-xml/i386-64bit.xml b/gdbstub/gdb-xml/i386-64bit.xml
similarity index 100%
rename from gdb-xml/i386-64bit.xml
rename to gdbstub/gdb-xml/i386-64bit.xml
diff --git a/gdb-xml/loongarch-base32.xml b/gdbstub/gdb-xml/loongarch-base32.xml
similarity index 100%
rename from gdb-xml/loongarch-base32.xml
rename to gdbstub/gdb-xml/loongarch-base32.xml
diff --git a/gdb-xml/loongarch-base64.xml b/gdbstub/gdb-xml/loongarch-base64.xml
similarity index 100%
rename from gdb-xml/loongarch-base64.xml
rename to gdbstub/gdb-xml/loongarch-base64.xml
diff --git a/gdb-xml/loongarch-fpu.xml b/gdbstub/gdb-xml/loongarch-fpu.xml
similarity index 100%
rename from gdb-xml/loongarch-fpu.xml
rename to gdbstub/gdb-xml/loongarch-fpu.xml
diff --git a/gdb-xml/loongarch-lasx.xml b/gdbstub/gdb-xml/loongarch-lasx.xml
similarity index 100%
rename from gdb-xml/loongarch-lasx.xml
rename to gdbstub/gdb-xml/loongarch-lasx.xml
diff --git a/gdb-xml/loongarch-lsx.xml b/gdbstub/gdb-xml/loongarch-lsx.xml
similarity index 100%
rename from gdb-xml/loongarch-lsx.xml
rename to gdbstub/gdb-xml/loongarch-lsx.xml
diff --git a/gdb-xml/m68k-core.xml b/gdbstub/gdb-xml/m68k-core.xml
similarity index 100%
rename from gdb-xml/m68k-core.xml
rename to gdbstub/gdb-xml/m68k-core.xml
diff --git a/gdb-xml/m68k-fp.xml b/gdbstub/gdb-xml/m68k-fp.xml
similarity index 100%
rename from gdb-xml/m68k-fp.xml
rename to gdbstub/gdb-xml/m68k-fp.xml
diff --git a/gdb-xml/microblaze-core.xml b/gdbstub/gdb-xml/microblaze-core.xml
similarity index 100%
rename from gdb-xml/microblaze-core.xml
rename to gdbstub/gdb-xml/microblaze-core.xml
diff --git a/gdb-xml/microblaze-stack-protect.xml b/gdbstub/gdb-xml/microblaze-stack-protect.xml
similarity index 100%
rename from gdb-xml/microblaze-stack-protect.xml
rename to gdbstub/gdb-xml/microblaze-stack-protect.xml
diff --git a/gdb-xml/or1k-core.xml b/gdbstub/gdb-xml/or1k-core.xml
similarity index 100%
rename from gdb-xml/or1k-core.xml
rename to gdbstub/gdb-xml/or1k-core.xml
diff --git a/gdb-xml/power-altivec.xml b/gdbstub/gdb-xml/power-altivec.xml
similarity index 100%
rename from gdb-xml/power-altivec.xml
rename to gdbstub/gdb-xml/power-altivec.xml
diff --git a/gdb-xml/power-core.xml b/gdbstub/gdb-xml/power-core.xml
similarity index 100%
rename from gdb-xml/power-core.xml
rename to gdbstub/gdb-xml/power-core.xml
diff --git a/gdb-xml/power-fpu.xml b/gdbstub/gdb-xml/power-fpu.xml
similarity index 100%
rename from gdb-xml/power-fpu.xml
rename to gdbstub/gdb-xml/power-fpu.xml
diff --git a/gdb-xml/power-spe.xml b/gdbstub/gdb-xml/power-spe.xml
similarity index 100%
rename from gdb-xml/power-spe.xml
rename to gdbstub/gdb-xml/power-spe.xml
diff --git a/gdb-xml/power-vsx.xml b/gdbstub/gdb-xml/power-vsx.xml
similarity index 100%
rename from gdb-xml/power-vsx.xml
rename to gdbstub/gdb-xml/power-vsx.xml
diff --git a/gdb-xml/power64-core.xml b/gdbstub/gdb-xml/power64-core.xml
similarity index 100%
rename from gdb-xml/power64-core.xml
rename to gdbstub/gdb-xml/power64-core.xml
diff --git a/gdb-xml/riscv-32bit-cpu.xml b/gdbstub/gdb-xml/riscv-32bit-cpu.xml
similarity index 100%
rename from gdb-xml/riscv-32bit-cpu.xml
rename to gdbstub/gdb-xml/riscv-32bit-cpu.xml
diff --git a/gdb-xml/riscv-32bit-fpu.xml b/gdbstub/gdb-xml/riscv-32bit-fpu.xml
similarity index 100%
rename from gdb-xml/riscv-32bit-fpu.xml
rename to gdbstub/gdb-xml/riscv-32bit-fpu.xml
diff --git a/gdb-xml/riscv-32bit-virtual.xml b/gdbstub/gdb-xml/riscv-32bit-virtual.xml
similarity index 100%
rename from gdb-xml/riscv-32bit-virtual.xml
rename to gdbstub/gdb-xml/riscv-32bit-virtual.xml
diff --git a/gdb-xml/riscv-64bit-cpu.xml b/gdbstub/gdb-xml/riscv-64bit-cpu.xml
similarity index 100%
rename from gdb-xml/riscv-64bit-cpu.xml
rename to gdbstub/gdb-xml/riscv-64bit-cpu.xml
diff --git a/gdb-xml/riscv-64bit-fpu.xml b/gdbstub/gdb-xml/riscv-64bit-fpu.xml
similarity index 100%
rename from gdb-xml/riscv-64bit-fpu.xml
rename to gdbstub/gdb-xml/riscv-64bit-fpu.xml
diff --git a/gdb-xml/riscv-64bit-virtual.xml b/gdbstub/gdb-xml/riscv-64bit-virtual.xml
similarity index 100%
rename from gdb-xml/riscv-64bit-virtual.xml
rename to gdbstub/gdb-xml/riscv-64bit-virtual.xml
diff --git a/gdb-xml/rx-core.xml b/gdbstub/gdb-xml/rx-core.xml
similarity index 100%
rename from gdb-xml/rx-core.xml
rename to gdbstub/gdb-xml/rx-core.xml
diff --git a/gdb-xml/s390-acr.xml b/gdbstub/gdb-xml/s390-acr.xml
similarity index 100%
rename from gdb-xml/s390-acr.xml
rename to gdbstub/gdb-xml/s390-acr.xml
diff --git a/gdb-xml/s390-cr.xml b/gdbstub/gdb-xml/s390-cr.xml
similarity index 100%
rename from gdb-xml/s390-cr.xml
rename to gdbstub/gdb-xml/s390-cr.xml
diff --git a/gdb-xml/s390-fpr.xml b/gdbstub/gdb-xml/s390-fpr.xml
similarity index 100%
rename from gdb-xml/s390-fpr.xml
rename to gdbstub/gdb-xml/s390-fpr.xml
diff --git a/gdb-xml/s390-gs.xml b/gdbstub/gdb-xml/s390-gs.xml
similarity index 100%
rename from gdb-xml/s390-gs.xml
rename to gdbstub/gdb-xml/s390-gs.xml
diff --git a/gdb-xml/s390-virt-kvm.xml b/gdbstub/gdb-xml/s390-virt-kvm.xml
similarity index 100%
rename from gdb-xml/s390-virt-kvm.xml
rename to gdbstub/gdb-xml/s390-virt-kvm.xml
diff --git a/gdb-xml/s390-virt.xml b/gdbstub/gdb-xml/s390-virt.xml
similarity index 100%
rename from gdb-xml/s390-virt.xml
rename to gdbstub/gdb-xml/s390-virt.xml
diff --git a/gdb-xml/s390-vx.xml b/gdbstub/gdb-xml/s390-vx.xml
similarity index 100%
rename from gdb-xml/s390-vx.xml
rename to gdbstub/gdb-xml/s390-vx.xml
diff --git a/gdb-xml/s390x-core64.xml b/gdbstub/gdb-xml/s390x-core64.xml
similarity index 100%
rename from gdb-xml/s390x-core64.xml
rename to gdbstub/gdb-xml/s390x-core64.xml
diff --git a/gdb-xml/sparc32-cp0.xml b/gdbstub/gdb-xml/sparc32-cp0.xml
similarity index 100%
rename from gdb-xml/sparc32-cp0.xml
rename to gdbstub/gdb-xml/sparc32-cp0.xml
diff --git a/gdb-xml/sparc32-cpu.xml b/gdbstub/gdb-xml/sparc32-cpu.xml
similarity index 100%
rename from gdb-xml/sparc32-cpu.xml
rename to gdbstub/gdb-xml/sparc32-cpu.xml
diff --git a/gdb-xml/sparc32-fpu.xml b/gdbstub/gdb-xml/sparc32-fpu.xml
similarity index 100%
rename from gdb-xml/sparc32-fpu.xml
rename to gdbstub/gdb-xml/sparc32-fpu.xml
diff --git a/gdb-xml/sparc64-cp0.xml b/gdbstub/gdb-xml/sparc64-cp0.xml
similarity index 100%
rename from gdb-xml/sparc64-cp0.xml
rename to gdbstub/gdb-xml/sparc64-cp0.xml
diff --git a/gdb-xml/sparc64-cpu.xml b/gdbstub/gdb-xml/sparc64-cpu.xml
similarity index 100%
rename from gdb-xml/sparc64-cpu.xml
rename to gdbstub/gdb-xml/sparc64-cpu.xml
diff --git a/gdb-xml/sparc64-fpu.xml b/gdbstub/gdb-xml/sparc64-fpu.xml
similarity index 100%
rename from gdb-xml/sparc64-fpu.xml
rename to gdbstub/gdb-xml/sparc64-fpu.xml
-- 
2.47.3


