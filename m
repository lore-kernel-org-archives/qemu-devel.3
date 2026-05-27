Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0196CD5BC9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBal-0001EE-Uw; Wed, 27 May 2026 06:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBah-0000qa-KQ
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:34:24 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBad-0001fO-TW
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:34:23 -0400
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-44a5174670eso6444064f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779878058; x=1780482858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RlcCfBWYoAC7TsrOi3tJoY9ajjCNZ9l5SfcUTdGZRKM=;
 b=gmreIPyNlZLzU28qUGh6yC8XPorWqP/XsXCo7MMDMCh/XLZiC2l8FlkmqCxojI7vIU
 /UhftgwFkBnGY5yzskce7BVyJMWAbwqIh18n840f7aGQ8NL9UPgFixF4zas6/iDjeLHH
 07OEd5pULi6Xbw7bEphoni8B9IwmPp4OciSHSAKG/PpTpzr9s707VpZd8OnfHcPlv+9v
 zvDb1OAgR1ZIkzmXHcxAgE8boJjGRXMLfeH8kfH/nP0w3EX7bt+A6oDpTdQxl0ypWWdu
 3veHenUAymsJ6M7LUzXvJsGW0UGIDR+C3Ieb/q5ujYMdJ3yO+aGO0LDcYUq8BFogTyts
 m8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779878058; x=1780482858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RlcCfBWYoAC7TsrOi3tJoY9ajjCNZ9l5SfcUTdGZRKM=;
 b=FLmTL1nnARa78dlDZwM6d9pjEH3ZAPwJAYIBZZ3CIkCrApMkaEWtlnRDICaCKNK1Av
 kh0B+6+ii2VMfj9Yz6H+FlL2LZ/FZzuh2h3BmyVMWjHFQLi7bOcQr6Jwnzz4Lu5R9Lgx
 8xzmpwKX7yqfymSus8G1UvyXRUBd3/JxsLx2/J/AK4HNH0jC9cQddenJI/i23V+zN5oM
 eP6fXd6TexTipuqe84k7OWx27xjRKb7AhNxwAUsbwSHdxWUcj75dVfJ6rqkIAeOWWmKI
 pL9a1psuljo7OPA+5Z4GXc61QN5uGkqdMHsmngY2xKwkB9qLI6lDFiKesu76BEoIKQB3
 BC3A==
X-Gm-Message-State: AOJu0YwB9GDaGV7p3c/LQgkyYxtzwBTvdJGZ/9OIz0ydvNA8thZ9sLqK
 qjophUNKRPQVGvR3qVLQhWGIW7h9u8KvYwe0t5Gh0zZPRK3E3IORgQCWNeCiGe01AJiHLh2hTC2
 h558FklTJlXsj
X-Gm-Gg: Acq92OGvvRBOKuX1rZSq2+QeggPU7O5Ex5kWJ7KC3oIwqFhwRB/NEQ9EH1T1G9zfSak
 m0gyV4NNk6Ksf+cQyH/L8sXzo+yHXHGFE4oaNTkshIhlWMrh7yAxCVFG33SBkyJLSnZ0qs1M9V1
 mlGT59nOWrbPwOKiT43VDtIvcJ9yitDuYo4nI5IrGgurG7u4cD70jDXjxN+4MBH1YUrtacD5jMi
 /7qYfQotWSTOAfgjP2v1/y86GiO2qBkcq2KKR00OvJ/hMoFSbPgHwnXATpBZg9GTh37IvaI2E1X
 anjSktXM/jo2eccLlpCwFTTvMDMeZ80ub381gFtQwN8TzfdXxNvOmB9QswrvJeNlAdTSl7TZ90T
 nEdqmR7YG50hjrHnsc2Kl0msDGJPJGrcnpR4IGqDmh4n6gs+dAWTr6OxA6qM7ZZcIrqEkmNBZ5i
 HMup4DqgiQpHusNBoMSViJgZqUYpF1L5Y+E1lwvzX5DJYauWeYTCXR1+v5G0cJ4Q/hjsZClaXaH
 Mb+
X-Received: by 2002:a05:6000:2007:b0:44a:247e:67b4 with SMTP id
 ffacd0b85a97d-45eb3689031mr37482444f8f.18.1779878058123; 
 Wed, 27 May 2026 03:34:18 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5a2a07sm4593353f8f.19.2026.05.27.03.34.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:34:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/32] MAINTAINERS: Update PhilMD's email address
Date: Wed, 27 May 2026 12:30:36 +0200
Message-ID: <20260527103037.4461-33-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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
use my personal email instead. Update mailmap and gitdm
accordingly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20260527065943.92554-1-philmd@linaro.org>
---
 MAINTAINERS                         | 58 ++++++++++++++---------------
 .mailmap                            |  7 ++--
 contrib/gitdm/group-map-individuals |  1 +
 3 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 35ab2b458a4..892380a6d51 100644
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
index ce569d83f4a..273661c758e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -104,9 +104,10 @@ Paul Burton <paulburton@kernel.org> <paul.burton@mips.com>
 Paul Burton <paulburton@kernel.org> <paul.burton@imgtec.com>
 Paul Burton <paulburton@kernel.org> <paul@archlinuxmips.org>
 Paul Burton <paulburton@kernel.org> <pburton@wavecomp.com>
-Philippe Mathieu-Daudé <philmd@linaro.org> <f4bug@amsat.org>
-Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@redhat.com>
-Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@fungible.com>
+Philippe Mathieu-Daudé <philmd@mailo.com> <f4bug@amsat.org>
+Philippe Mathieu-Daudé <philmd@mailo.com> <philmd@redhat.com>
+Philippe Mathieu-Daudé <philmd@mailo.com> <philmd@fungible.com>
+Philippe Mathieu-Daudé <philmd@mailo.com> <philmd@linaro.org>
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> <pierrick.bouvier@linaro.org>
 Roman Bolshakov <rbolshakov@ddn.com> <r.bolshakov@yadro.com>
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> <sriram.yagnaraman@est.tech>
diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
index 4f4645a84cb..178b393b8c3 100644
--- a/contrib/gitdm/group-map-individuals
+++ b/contrib/gitdm/group-map-individuals
@@ -45,3 +45,4 @@ Jason@zx2c4.com
 amarjargal16@gmail.com
 me@sean.taipei
 kosasihwilliam4@gmail.com
+philmd@mailo.com
-- 
2.53.0


