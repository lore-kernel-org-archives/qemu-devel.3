Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA2CCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 12:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRqnF-0006Go-Qj; Tue, 26 May 2026 08:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRqn8-0006C7-6X
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:21:51 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRqn3-0001UU-H4
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:21:48 -0400
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso65918915e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 05:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779798100; x=1780402900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T66DzUxB9G+Y3bF9fajkYzQItq4Sq9LaroUazUR6YLc=;
 b=z0bsywTT2gqn70oT5zOnBumIPAf0bi0gnpdclIERN5v/JBos07cg86+yTnB/TlWmbU
 euSMY2EwBh4aptoPneVHhO/ClEo+OE9Bq9oxcTghCHCYoZqzcfOeY1yJS4bz+0es34Tb
 HQWAPoIUpWRsGIwBPHwsMlyd1T4QA/Wpb7IelrKRpLzK7aO3uGZ1TozHHD1RJWgmGt8i
 4/hxCsaStC+acx1ZcPN/Eo/mb5w+t/qemdtUPjTCiIwtlmQqoO4R/Gav9+qb5cbECPyw
 Z2f2nWgsP0bkTbzdu/bf/DlI2H1Sg3qJElc1f+3mgre4xMdfQNv/dfhn0848QrXVs5rY
 Zmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779798100; x=1780402900;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T66DzUxB9G+Y3bF9fajkYzQItq4Sq9LaroUazUR6YLc=;
 b=EmKmgchTZQaUn173GO6JW/qCkHMa4kEKPsFGg6MCUFLnmqYoiiEXP+iY/jCJ/WeZJY
 Wh9ApYYmldDleQKqJrJK+qoVxrLRPtSGsVnl3b6nIzwK3v7IvKGvXjBY0utlw9JhwTxK
 NEKNwsss1yAU+Rm2u0keMbO6Ii2a/9yNXlZ6XQSa8stwCTwpLEFNskxJbwQH14YjjPpJ
 Rr3nNvXlVi7no19qz/UGJyEkVlAfzfn0mHGc2jT1/H3BsN/2a2UKnKm3CFZKeEGOjo2x
 gb2WXwgnPXqeJYjVjcxAloPjSGySFS5EingBUWuhnytKoYeqOxDouIAEh7Clk2kTRNzc
 SVXA==
X-Gm-Message-State: AOJu0Yzf990Iz+GVPwU6vu8YZWMU2XrCq7QWT2WEOOsJpfUR8oqZuTwg
 y5ULVW+AYZouIcQhaSg54qmR988PihGbxQgt7ausxlJLmFKzYgUR24ua78QU8aPYgKwOzjI9kw8
 JcUPCgLiSHf+v
X-Gm-Gg: Acq92OGTlbpaDiWhAqZ+HyU0qovaiv24QNGySdLS/0V9ZGykNKSaEP1kiBqX2XyEAPC
 LINj1Uu+8465TJThlLWQG9r/PwYKUZFj6gRDx3+GjopV1GPBH59CZrAMrEn0dmyyoY2Jp6pmQRc
 hhvIqkVgF+z17fkkmwDuVwI+MXx3BIndL3Ur2RXyL8Q7dpT1bgdalhA5bct80Vw5p3SyBBOMGKj
 y2h+GAcHrs10Q8C9FC7cGpfQOJ4IfbejCikpaCnVUw4X0g3uOo9y1nUFEx3vwJgRB6rL7rDH+JN
 +a32hEh5PNY41+ISZfUGrqkVdipEoZqGOzT1ZEeuEJ2A7bwAgK62x5sIMIW/nhSGfShVlIiQkIM
 hGvsVCPsJthdkFG/s8eswuIBTID6CyuofLQ+p/jigeG2Zu9ZHs3cM5jC/WY2C4W30ND9slFRcPJ
 UFOp+x356fnsvKa2hvUp/UHFfhbZa2vV3eWjyXx03MFiEkNoN/AikodyU=
X-Received: by 2002:a05:600c:1393:b0:489:1d74:56d with SMTP id
 5b1f17b1804b1-490428e15e9mr296486065e9.29.1779798100003; 
 Tue, 26 May 2026 05:21:40 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490424974a8sm162926165e9.4.2026.05.26.05.21.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 05:21:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] MAINTAINERS: Update PhilMD's email address
Date: Tue, 26 May 2026 14:21:37 +0200
Message-ID: <20260526122137.64378-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

philmd@linaro.org will stop working starting 2026-06-01,
use my personal email instead.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20260519173014.98967-1-philmd@linaro.org>
Cc: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 58 ++++++++++++++++++++++++++---------------------------
 .mailmap    |  6 +++---
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 172f87ebda9..0808dd49d06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -68,7 +68,7 @@ Project policy and developer guides
 R: Alex Bennée <alex.bennee@linaro.org>
 R: Daniel P. Berrangé <berrange@redhat.com>
 R: Markus Armbruster <armbru@redhat.com>
-R: Philippe Mathieu-Daudé <philmd@linaro.org>
+R: Philippe Mathieu-Daudé <philmd@mailo.com>
 W: https://www.qemu.org/docs/master/devel/index.html
 S: Odd Fixes
 F: docs/devel/build-environment.rst
@@ -132,7 +132,7 @@ T: git https://gitlab.com/cohuck/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
 MIPS general architecture support
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Philippe Mathieu-Daudé <philmd@mailo.com>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Odd Fixes
 K: ^Subject:.*(?i)mips
@@ -302,7 +302,7 @@ F: tests/docker/dockerfiles/debian-microblaze-cross.d/build-toolchain.sh
 F: tests/functional/microblaze/
 
 MIPS TCG CPUs
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Philippe Mathieu-Daudé <philmd@mailo.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 R: Aleksandar Rikalo <arikalo@gmail.com>
@@ -533,7 +533,7 @@ Guest CPU Cores (other accelerators)
 Overall
 M: Richard Henderson <richard.henderson@linaro.org>
 R: Paolo Bonzini <pbonzini@redhat.com>
-R: Philippe Mathieu-Daudé <philmd@linaro.org>
+R: Philippe Mathieu-Daudé <philmd@mailo.com>
 S: Maintained
 F: include/exec/cpu*.h
 F: include/exec/target_long.h
@@ -696,7 +696,7 @@ F: qemu.nsi
 F: scripts/nsis.py
 
 Darwin (macOS, iOS)
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Philippe Mathieu-Daudé <philmd@mailo.com>
 S: Odd Fixes
 F: .gitlab-ci.d/cirrus/macos-*
 F: */*.m
@@ -1012,7 +1012,7 @@ F: tests/functional/arm/test_quanta_gsj.py
 
 Raspberry Pi
 M: Peter Maydell <peter.maydell@linaro.org>
-R: Philippe Mathieu-Daudé <philmd@linaro.org>
+R: Philippe Mathieu-Daudé <philmd@mailo.com>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/raspi.c
@@ -1314,7 +1314,7 @@ F: include/hw/misc/avr_power.h
 F: hw/misc/avr_power.c
 
 Arduino
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Philippe Mathieu-Daudé <philmd@mailo.com>
 S: Maintained
 F: hw/avr/arduino.c
 F: tests/functional/avr/test_uno.py
@@ -1448,7 +1448,7 @@ F: hw/microblaze/petalogix_ml605_mmu.c
 MIPS Machines
 -------------
 Overall MIPS Machines
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Philippe Mathieu-Daudé <philmd@mailo.com>
 S: Odd Fixes
 F: configs/devices/mips*/*
 F: hw/mips/
@@ -1465,7 +1465,7 @@ F: hw/dma/rc4030.c
 F: hw/nvram/ds1225y.c
 
 Malta
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Philippe Mathieu-Daudé <philmd@mailo.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
 S: Odd Fixes
 F: hw/isa/piix.c
@@ -1479,7 +1479,7 @@ F: tests/functional/mips*/test_tuxrun.py
 
 Fuloong 2E
 M: Huacai Chen <chenhuacai@kernel.org>
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Philippe Mathieu-Daudé <philmd@mailo.com>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Odd Fixes
 F: hw/mips/fuloong2e.c
@@ -1503,7 +1503,7 @@ F: include/hw/intc/loongson_liointc.h
 F: tests/functional/mips64el/test_loongson3v.py
 
 Boston
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Philippe Mathieu-Daudé <philmd@mailo.com>
 R: Aleksandar Rikalo <arikalo@gmail.com>
 S: Odd Fixes
 F: hw/core/loader-fit.c
@@ -2032,7 +2032,7 @@ F: include/hw/i386/nitro_enclave.h
 F: docs/system/i386/nitro-enclave.rst
 
 Machine core
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Philippe Mathieu-Daudé <philmd@mailo.com>
 R: Zhao Liu <zhao1.liu@intel.com>
 S: Maintained
 F: hw/core/cpu-common.c
@@ -2055,7 +2055,7 @@ F: tests/unit/test-smp-parse.c
 
 TargetInfo API
 M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Philippe Mathieu-Daudé <philmd@mailo.com>
 S: Supported
 F: include/qemu/target-info*.h
 F: target-info*.c
@@ -2279,7 +2279,7 @@ F: docs/system/virtio-net-failover.rst
 T: git https://github.com/jasowang/qemu.git net
 
 Parallel NOR Flash devices
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Philippe Mathieu-Daudé <philmd@mailo.com>
 S: Maintained
 F: hw/block/pflash_cfi*.c
 F: include/hw/block/flash.h
@@ -2311,7 +2311,7 @@ S: Maintained
 F: hw/ssi/xilinx_*
 
 SD (Secure Card)
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Philippe Mathieu-Daudé <philmd@mailo.com>
 M: Bin Meng <bmeng.cn@gmail.com>
 L: qemu-block@nongnu.org
 S: Odd Fixes
@@ -2765,14 +2765,14 @@ F: docs/specs/vmgenid.rst
 F: tests/qtest/vmgenid-test.c
 
 LED
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Philippe Mathieu-Daudé <philmd@mailo.com>
 S: Maintained
 F: include/hw/misc/led.h
 F: hw/misc/led.c
 
 Unimplemented device
 M: Peter Maydell <peter.maydell@linaro.org>
-R: Philippe Mathieu-Daudé <philmd@linaro.org>
+R: Philippe Mathieu-Daudé <philmd@mailo.com>
 R: Ani Sinha <ani@anisinha.ca>
 S: Maintained
 F: include/hw/misc/unimp.h
@@ -2780,7 +2780,7 @@ F: hw/misc/unimp.c
 
 Empty slot
 M: Artyom Tarasenko <atar4qemu@gmail.com>
-R: Philippe Mathieu-Daudé <philmd@linaro.org>
+R: Philippe Mathieu-Daudé <philmd@mailo.com>
 R: Ani Sinha <ani@anisinha.ca>
 S: Maintained
 F: include/hw/misc/empty_slot.h
@@ -2859,14 +2859,14 @@ F: hw/display/apple-gfx*
 
 PIIX4 South Bridge (i82371AB)
 M: Hervé Poussineau <hpoussin@reactos.org>
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Philippe Mathieu-Daudé <philmd@mailo.com>
 S: Maintained
 F: hw/isa/piix.c
 F: include/hw/southbridge/piix.h
 
 VIA South Bridges (VT82C686B, VT8231)
 M: BALATON Zoltan <balaton@eik.bme.hu>
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Philippe Mathieu-Daudé <philmd@mailo.com>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Maintained
 F: hw/isa/vt82c686.c
@@ -2931,13 +2931,13 @@ F: hw/intc/openpic.c
 F: include/hw/ppc/openpic.h
 
 MIPS CPS
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Philippe Mathieu-Daudé <philmd@mailo.com>
 S: Odd Fixes
 F: hw/misc/mips_*
 F: include/hw/misc/mips_*
 
 MIPS GIC
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Philippe Mathieu-Daudé <philmd@mailo.com>
 S: Odd Fixes
 F: hw/intc/mips_gic.c
 F: hw/timer/mips_gictimer.c
@@ -3063,7 +3063,7 @@ F: audio/alsaaudio.c
 
 Core Audio framework backend
 M: Gerd Hoffmann <kraxel@redhat.com>
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Philippe Mathieu-Daudé <philmd@mailo.com>
 R: Christian Schoenebeck <qemu_oss@crudebyte.com>
 R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Odd Fixes
@@ -3318,7 +3318,7 @@ F: tests/functional/ppc64/test_fadump.py
 
 GDB stub
 M: Alex Bennée <alex.bennee@linaro.org>
-R: Philippe Mathieu-Daudé <philmd@linaro.org>
+R: Philippe Mathieu-Daudé <philmd@mailo.com>
 S: Maintained
 F: docs/system/gdb.rst
 F: gdbstub/*
@@ -3332,7 +3332,7 @@ T: git https://gitlab.com/stsquad/qemu gdbstub/next
 Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
 M: Peter Xu <peterx@redhat.com>
-R: Philippe Mathieu-Daudé <philmd@linaro.org>
+R: Philippe Mathieu-Daudé <philmd@mailo.com>
 S: Supported
 F: include/system/ioport.h
 F: include/exec/memop.h
@@ -3387,7 +3387,7 @@ F: tests/functional/generic/test_vnc.py
 
 Cocoa graphics
 M: Peter Maydell <peter.maydell@linaro.org>
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Philippe Mathieu-Daudé <philmd@mailo.com>
 R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Odd Fixes
 F: ui/cocoa.m
@@ -3950,7 +3950,7 @@ S: Maintained
 F: contrib/elf2dmp/
 
 Overall sensors
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Philippe Mathieu-Daudé <philmd@mailo.com>
 S: Odd Fixes
 F: hw/sensor
 F: include/hw/sensor
@@ -4511,7 +4511,7 @@ W: https://cirrus-ci.com/github/qemu/qemu
 
 Functional testing framework
 M: Thomas Huth <th.huth+qemu@posteo.eu>
-R: Philippe Mathieu-Daudé <philmd@linaro.org>
+R: Philippe Mathieu-Daudé <philmd@mailo.com>
 R: Daniel P. Berrange <berrange@redhat.com>
 S: Odd Fixes
 F: docs/devel/testing/functional.rst
@@ -4567,7 +4567,7 @@ Meson
 M: Paolo Bonzini <pbonzini@redhat.com>
 R: Marc-André Lureau <marcandre.lureau@redhat.com>
 R: Daniel P. Berrange <berrange@redhat.com>
-R: Philippe Mathieu-Daudé <philmd@linaro.org>
+R: Philippe Mathieu-Daudé <philmd@mailo.com>
 R: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Maintained
 F: meson.build
diff --git a/.mailmap b/.mailmap
index ce569d83f4a..ab6796090fe 100644
--- a/.mailmap
+++ b/.mailmap
@@ -104,9 +104,9 @@ Paul Burton <paulburton@kernel.org> <paul.burton@mips.com>
 Paul Burton <paulburton@kernel.org> <paul.burton@imgtec.com>
 Paul Burton <paulburton@kernel.org> <paul@archlinuxmips.org>
 Paul Burton <paulburton@kernel.org> <pburton@wavecomp.com>
-Philippe Mathieu-Daudé <philmd@linaro.org> <f4bug@amsat.org>
-Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@redhat.com>
-Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@fungible.com>
+Philippe Mathieu-Daudé <philmd@mailo.com> <f4bug@amsat.org>
+Philippe Mathieu-Daudé <philmd@mailo.com> <philmd@redhat.com>
+Philippe Mathieu-Daudé <philmd@mailo.com> <philmd@fungible.com>
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> <pierrick.bouvier@linaro.org>
 Roman Bolshakov <rbolshakov@ddn.com> <r.bolshakov@yadro.com>
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> <sriram.yagnaraman@est.tech>
-- 
2.53.0


