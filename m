Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A15FD88C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05IM-0004OT-VG; Tue, 10 Mar 2026 18:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w05I6-0004Fb-6F
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:11:03 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w05I2-0002QI-92
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:11:01 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4852ff06541so36912175e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773180656; x=1773785456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z8Vz/ciWV44A1kCCSsyBSXM8t9CCkvptX5aWX76jOyc=;
 b=omlpStjt2s3WepDfeSy8geX0bU7+wa6mwJHQsQNvdMllYU7riOFefyhmfh5swAAS/I
 vBRCP6tjfFOR++bX+PAonsNZWtXZGayUgXGVt7m5Np77wDClDzcgZPiHv/P5aFqFXElh
 j48BgSrFgHP9BHBdq9TYKrjeElVrzQoYIOHmYHCRg5Egr03CHNatOf0xLX0mJt75WCWG
 u9EnK2RDvXOLFX3yZPAaTbnE5RU7z6YUAYHMP2Udawwt09I9NmOQ0wfZNpTe5NLnJ1Py
 PbcDHalgqJBHU6uSaS4INh5tSMFH1BbTDqbmHjtsDo3GYLssDoBaD2OZEfXZrBycymBw
 S4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773180656; x=1773785456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z8Vz/ciWV44A1kCCSsyBSXM8t9CCkvptX5aWX76jOyc=;
 b=gJDRJSFS3X+8E1x/caFTl4e+1J6OFmq/6PqRT6OX8LlLogq07gIYDFoN9CEjrTZIKt
 2tv2+79T6xg1ljaj5jbm94B0MOgA9gkWe70y+Da/MmzIhdauPj4A0epdX6+8Za2FtJ6f
 AcZCEmLMIlXvlMOmClBg5vGhSyVCY2yAbMT8JlDUTEuOFuuiOp+LjTcuzm0/Xr/TpSnB
 DoItweYVHwMG0OK987Y7kv+/8kDY5eQ+7stBBpxUEGSm8fNRcMqzWEvIe1iHoKZE3uTu
 83tpbmiXDJKSy2J4lvwjUAIIzVdJwVstTdcKSSG8APUooAW5ioIKltesjXkMnkZpP4lu
 OFeg==
X-Gm-Message-State: AOJu0Yx91BGr42iInoUwomIyJwEXdWD+xrGYXsUbFEvjUq5hzJdECnJv
 ji/A8RLWk7GDFY2ZGu7Tb7KbeaUfWg4ca0wzW0p/uqQm2DNLwEKGu/zFsdnfBg0h/crQHauWeTp
 uCTJb18c=
X-Gm-Gg: ATEYQzwfd/zF0GUnNEm+yjcVQYO7kWDteKi8kOnVe8GOZTY+DIxrjWZ1DJfKDrSVq9z
 Ij3aXfOf0HufuBFhbq70FgJR9tEzCFjI8JB9TXIC0pIb5dUAy/w0ty8UpeTWQ1oN+QKeoMFbRQr
 OkqoBQx3IYknhxjB1joS6LyCXUoilkNPGQc4QTmdEWPjkKrdm+g2r5xWzTr/IRpfUQThPcopDNY
 PmDpH5rwzoU9AzXlSyzI1BfiW4CAO4Axjs+g51XIfu6MBTmVjnhDpnbrKdYei1tMO9wGXxQBEDb
 KDMo8N2i86XZrycnO9qeP3JHoLJyarpUijWe2kAr/pHPQXnXCryOVjhUT/QJSuzTUInOX40v7JW
 bssfMCTMzQAEtJjN607vDn5GwnZASmvp4DAHWaktcjakPEtF40bZL9nxgmk0m0xrmnhHEPTIPcW
 au3Gkuj7GHgwgkvRCF8XhQ+xRrSbCK2n5YmwV4Hs64ftxID4glGNdiPD9ihHmV52EGOuDTAEdb
X-Received: by 2002:a05:600c:8483:b0:483:71f7:2782 with SMTP id
 5b1f17b1804b1-4854b0b1f71mr6570145e9.12.1773180655879; 
 Tue, 10 Mar 2026 15:10:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854a30c0fcsm4998075e9.10.2026.03.10.15.10.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 15:10:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v3 10/12] gdbstub: Remove 'gdb-xml/' directory prefix in
 TARGET_XML_FILES
Date: Tue, 10 Mar 2026 22:59:13 +0100
Message-ID: <20260310215916.55815-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310215916.55815-1-philmd@linaro.org>
References: <20260310215916.55815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

All GDB XML files are in the gdb-xml/ directory. No need to be
so verbose in TARGET_XML_FILES, let meson prepend the directory.

Except meson.build lines, this is a mechanical change done running:

 $ sed -i -e s,gdb-xml/,,g $(git grep -l gdb-xml configs/targets/)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
---
 configs/targets/aarch64-bsd-user.mak        | 2 +-
 configs/targets/aarch64-linux-user.mak      | 2 +-
 configs/targets/aarch64-softmmu.mak         | 2 +-
 configs/targets/aarch64_be-linux-user.mak   | 2 +-
 configs/targets/alpha-linux-user.mak        | 2 +-
 configs/targets/alpha-softmmu.mak           | 2 +-
 configs/targets/arm-bsd-user.mak            | 2 +-
 configs/targets/arm-linux-user.mak          | 2 +-
 configs/targets/arm-softmmu.mak             | 2 +-
 configs/targets/armeb-linux-user.mak        | 2 +-
 configs/targets/avr-softmmu.mak             | 2 +-
 configs/targets/hexagon-linux-user.mak      | 2 +-
 configs/targets/i386-bsd-user.mak           | 2 +-
 configs/targets/i386-linux-user.mak         | 2 +-
 configs/targets/i386-softmmu.mak            | 2 +-
 configs/targets/loongarch64-linux-user.mak  | 2 +-
 configs/targets/loongarch64-softmmu.mak     | 2 +-
 configs/targets/m68k-linux-user.mak         | 2 +-
 configs/targets/m68k-softmmu.mak            | 2 +-
 configs/targets/microblaze-linux-user.mak   | 2 +-
 configs/targets/microblaze-softmmu.mak      | 2 +-
 configs/targets/microblazeel-linux-user.mak | 2 +-
 configs/targets/or1k-linux-user.mak         | 2 +-
 configs/targets/or1k-softmmu.mak            | 2 +-
 configs/targets/ppc-linux-user.mak          | 2 +-
 configs/targets/ppc-softmmu.mak             | 2 +-
 configs/targets/ppc64-linux-user.mak        | 2 +-
 configs/targets/ppc64-softmmu.mak           | 2 +-
 configs/targets/ppc64le-linux-user.mak      | 2 +-
 configs/targets/riscv32-linux-user.mak      | 2 +-
 configs/targets/riscv32-softmmu.mak         | 2 +-
 configs/targets/riscv64-bsd-user.mak        | 2 +-
 configs/targets/riscv64-linux-user.mak      | 2 +-
 configs/targets/riscv64-softmmu.mak         | 2 +-
 configs/targets/rx-softmmu.mak              | 2 +-
 configs/targets/s390x-linux-user.mak        | 2 +-
 configs/targets/s390x-softmmu.mak           | 2 +-
 configs/targets/sparc-linux-user.mak        | 2 +-
 configs/targets/sparc-softmmu.mak           | 2 +-
 configs/targets/sparc32plus-linux-user.mak  | 2 +-
 configs/targets/sparc64-linux-user.mak      | 2 +-
 configs/targets/sparc64-softmmu.mak         | 2 +-
 configs/targets/x86_64-bsd-user.mak         | 2 +-
 configs/targets/x86_64-linux-user.mak       | 2 +-
 configs/targets/x86_64-softmmu.mak          | 2 +-
 meson.build                                 | 6 +++++-
 46 files changed, 50 insertions(+), 46 deletions(-)

diff --git a/configs/targets/aarch64-bsd-user.mak b/configs/targets/aarch64-bsd-user.mak
index 03979d82402..814ed2d8bfe 100644
--- a/configs/targets/aarch64-bsd-user.mak
+++ b/configs/targets/aarch64-bsd-user.mak
@@ -1,4 +1,4 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
-TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml gdb-xml/aarch64-mte.xml gdb-xml/aarch64-sme2.xml
+TARGET_XML_FILES= aarch64-core.xml aarch64-fpu.xml aarch64-pauth.xml aarch64-mte.xml aarch64-sme2.xml
 TARGET_LONG_BITS=64
diff --git a/configs/targets/aarch64-linux-user.mak b/configs/targets/aarch64-linux-user.mak
index bf328b3b80c..ddfacc092dd 100644
--- a/configs/targets/aarch64-linux-user.mak
+++ b/configs/targets/aarch64-linux-user.mak
@@ -1,6 +1,6 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
-TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml gdb-xml/aarch64-mte.xml gdb-xml/aarch64-sme2.xml
+TARGET_XML_FILES= aarch64-core.xml aarch64-fpu.xml aarch64-pauth.xml aarch64-mte.xml aarch64-sme2.xml
 TARGET_HAS_BFLT=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
diff --git a/configs/targets/aarch64-softmmu.mak b/configs/targets/aarch64-softmmu.mak
index d14bcfc4900..9a20187e2c1 100644
--- a/configs/targets/aarch64-softmmu.mak
+++ b/configs/targets/aarch64-softmmu.mak
@@ -1,7 +1,7 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
 TARGET_KVM_HAVE_GUEST_DEBUG=y
-TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml gdb-xml/aarch64-pauth.xml gdb-xml/aarch64-sme2.xml
+TARGET_XML_FILES= aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vfp.xml arm-vfp3.xml arm-vfp-sysregs.xml arm-neon.xml arm-m-profile.xml arm-m-profile-mve.xml aarch64-pauth.xml aarch64-sme2.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=64
diff --git a/configs/targets/aarch64_be-linux-user.mak b/configs/targets/aarch64_be-linux-user.mak
index 284430add7b..83209fa2ae5 100644
--- a/configs/targets/aarch64_be-linux-user.mak
+++ b/configs/targets/aarch64_be-linux-user.mak
@@ -1,7 +1,7 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
 TARGET_BIG_ENDIAN=y
-TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml gdb-xml/aarch64-mte.xml gdb-xml/aarch64-sme2.xml
+TARGET_XML_FILES= aarch64-core.xml aarch64-fpu.xml aarch64-pauth.xml aarch64-mte.xml aarch64-sme2.xml
 TARGET_HAS_BFLT=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
diff --git a/configs/targets/alpha-linux-user.mak b/configs/targets/alpha-linux-user.mak
index 2f1312f0362..fbb9c680915 100644
--- a/configs/targets/alpha-linux-user.mak
+++ b/configs/targets/alpha-linux-user.mak
@@ -2,6 +2,6 @@ TARGET_ARCH=alpha
 TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_LONG_BITS=64
-TARGET_XML_FILES= gdb-xml/alpha-core.xml
+TARGET_XML_FILES= alpha-core.xml
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/alpha-softmmu.mak b/configs/targets/alpha-softmmu.mak
index 5c6af0eafc1..fb412d1b53f 100644
--- a/configs/targets/alpha-softmmu.mak
+++ b/configs/targets/alpha-softmmu.mak
@@ -1,5 +1,5 @@
 TARGET_ARCH=alpha
 TARGET_LONG_BITS=64
-TARGET_XML_FILES= gdb-xml/alpha-core.xml
+TARGET_XML_FILES= alpha-core.xml
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/arm-bsd-user.mak b/configs/targets/arm-bsd-user.mak
index 472a4f9fb11..b520819e776 100644
--- a/configs/targets/arm-bsd-user.mak
+++ b/configs/targets/arm-bsd-user.mak
@@ -1,3 +1,3 @@
 TARGET_ARCH=arm
-TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml
+TARGET_XML_FILES= arm-core.xml arm-vfp.xml arm-vfp3.xml arm-vfp-sysregs.xml arm-neon.xml arm-m-profile.xml arm-m-profile-mve.xml
 TARGET_LONG_BITS=32
diff --git a/configs/targets/arm-linux-user.mak b/configs/targets/arm-linux-user.mak
index bf35ded7fea..3793782d067 100644
--- a/configs/targets/arm-linux-user.mak
+++ b/configs/targets/arm-linux-user.mak
@@ -1,7 +1,7 @@
 TARGET_ARCH=arm
 TARGET_SYSTBL_ABI=common,oabi
 TARGET_SYSTBL=syscall.tbl
-TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml
+TARGET_XML_FILES= arm-core.xml arm-vfp.xml arm-vfp3.xml arm-vfp-sysregs.xml arm-neon.xml arm-m-profile.xml arm-m-profile-mve.xml
 TARGET_HAS_BFLT=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
diff --git a/configs/targets/arm-softmmu.mak b/configs/targets/arm-softmmu.mak
index 6a5a8eda949..35af7da79f2 100644
--- a/configs/targets/arm-softmmu.mak
+++ b/configs/targets/arm-softmmu.mak
@@ -1,5 +1,5 @@
 TARGET_ARCH=arm
-TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml
+TARGET_XML_FILES= arm-core.xml arm-vfp.xml arm-vfp3.xml arm-vfp-sysregs.xml arm-neon.xml arm-m-profile.xml arm-m-profile-mve.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/armeb-linux-user.mak b/configs/targets/armeb-linux-user.mak
index 35fa4d91b3c..536bc95af71 100644
--- a/configs/targets/armeb-linux-user.mak
+++ b/configs/targets/armeb-linux-user.mak
@@ -2,7 +2,7 @@ TARGET_ARCH=arm
 TARGET_SYSTBL_ABI=common,oabi
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
-TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml
+TARGET_XML_FILES= arm-core.xml arm-vfp.xml arm-vfp3.xml arm-vfp-sysregs.xml arm-neon.xml arm-m-profile.xml arm-m-profile-mve.xml
 TARGET_HAS_BFLT=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
diff --git a/configs/targets/avr-softmmu.mak b/configs/targets/avr-softmmu.mak
index baf20fb7f2f..0a00f128749 100644
--- a/configs/targets/avr-softmmu.mak
+++ b/configs/targets/avr-softmmu.mak
@@ -1,4 +1,4 @@
 TARGET_ARCH=avr
-TARGET_XML_FILES= gdb-xml/avr-cpu.xml
+TARGET_XML_FILES= avr-cpu.xml
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/hexagon-linux-user.mak b/configs/targets/hexagon-linux-user.mak
index 6763e2111d5..51fde5d60e6 100644
--- a/configs/targets/hexagon-linux-user.mak
+++ b/configs/targets/hexagon-linux-user.mak
@@ -1,5 +1,5 @@
 TARGET_ARCH=hexagon
-TARGET_XML_FILES=gdb-xml/hexagon-core.xml gdb-xml/hexagon-hvx.xml
+TARGET_XML_FILES=hexagon-core.xml hexagon-hvx.xml
 TARGET_SYSTBL=syscall.tbl
 TARGET_SYSTBL_ABI=common,32,hexagon,time32,stat64,rlimit,renameat
 TARGET_LONG_BITS=32
diff --git a/configs/targets/i386-bsd-user.mak b/configs/targets/i386-bsd-user.mak
index 70e098da491..485f571cb6c 100644
--- a/configs/targets/i386-bsd-user.mak
+++ b/configs/targets/i386-bsd-user.mak
@@ -1,3 +1,3 @@
 TARGET_ARCH=i386
-TARGET_XML_FILES= gdb-xml/i386-32bit.xml
+TARGET_XML_FILES= i386-32bit.xml
 TARGET_LONG_BITS=32
diff --git a/configs/targets/i386-linux-user.mak b/configs/targets/i386-linux-user.mak
index ea68a266fce..a3ea4c39c52 100644
--- a/configs/targets/i386-linux-user.mak
+++ b/configs/targets/i386-linux-user.mak
@@ -1,5 +1,5 @@
 TARGET_ARCH=i386
 TARGET_SYSTBL_ABI=i386
 TARGET_SYSTBL=syscall_32.tbl
-TARGET_XML_FILES= gdb-xml/i386-32bit.xml gdb-xml/i386-32bit-linux.xml
+TARGET_XML_FILES= i386-32bit.xml i386-32bit-linux.xml
 TARGET_LONG_BITS=32
diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-softmmu.mak
index 19ef4a6690d..38a8f85201f 100644
--- a/configs/targets/i386-softmmu.mak
+++ b/configs/targets/i386-softmmu.mak
@@ -1,6 +1,6 @@
 TARGET_ARCH=i386
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
-TARGET_XML_FILES= gdb-xml/i386-32bit.xml
+TARGET_XML_FILES= i386-32bit.xml
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/loongarch64-linux-user.mak b/configs/targets/loongarch64-linux-user.mak
index 4ea12794705..63b0bfc07b8 100644
--- a/configs/targets/loongarch64-linux-user.mak
+++ b/configs/targets/loongarch64-linux-user.mak
@@ -1,7 +1,7 @@
 # Default configuration for loongarch64-linux-user
 TARGET_ARCH=loongarch64
 TARGET_BASE_ARCH=loongarch
-TARGET_XML_FILES=gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml gdb-xml/loongarch-lsx.xml gdb-xml/loongarch-lasx.xml
+TARGET_XML_FILES=loongarch-base64.xml loongarch-fpu.xml loongarch-lsx.xml loongarch-lasx.xml
 TARGET_SYSTBL=syscall.tbl
 TARGET_SYSTBL_ABI=common,64
 TARGET_LONG_BITS=64
diff --git a/configs/targets/loongarch64-softmmu.mak b/configs/targets/loongarch64-softmmu.mak
index 38c0f68ddbc..476407f9413 100644
--- a/configs/targets/loongarch64-softmmu.mak
+++ b/configs/targets/loongarch64-softmmu.mak
@@ -1,7 +1,7 @@
 TARGET_ARCH=loongarch64
 TARGET_BASE_ARCH=loongarch
 TARGET_KVM_HAVE_GUEST_DEBUG=y
-TARGET_XML_FILES= gdb-xml/loongarch-base32.xml gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml gdb-xml/loongarch-lsx.xml gdb-xml/loongarch-lasx.xml
+TARGET_XML_FILES= loongarch-base32.xml loongarch-base64.xml loongarch-fpu.xml loongarch-lsx.xml loongarch-lasx.xml
 # all boards require libfdt
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=64
diff --git a/configs/targets/m68k-linux-user.mak b/configs/targets/m68k-linux-user.mak
index 2d9bae22707..b64f33e759a 100644
--- a/configs/targets/m68k-linux-user.mak
+++ b/configs/targets/m68k-linux-user.mak
@@ -2,6 +2,6 @@ TARGET_ARCH=m68k
 TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
-TARGET_XML_FILES= gdb-xml/cf-core.xml gdb-xml/cf-fp.xml gdb-xml/m68k-core.xml gdb-xml/m68k-fp.xml
+TARGET_XML_FILES= cf-core.xml cf-fp.xml m68k-core.xml m68k-fp.xml
 TARGET_HAS_BFLT=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/m68k-softmmu.mak b/configs/targets/m68k-softmmu.mak
index bacc52e96a9..0bc889f326e 100644
--- a/configs/targets/m68k-softmmu.mak
+++ b/configs/targets/m68k-softmmu.mak
@@ -1,4 +1,4 @@
 TARGET_ARCH=m68k
 TARGET_BIG_ENDIAN=y
-TARGET_XML_FILES= gdb-xml/cf-core.xml gdb-xml/cf-fp.xml gdb-xml/m68k-core.xml gdb-xml/m68k-fp.xml
+TARGET_XML_FILES= cf-core.xml cf-fp.xml m68k-core.xml m68k-fp.xml
 TARGET_LONG_BITS=32
diff --git a/configs/targets/microblaze-linux-user.mak b/configs/targets/microblaze-linux-user.mak
index 37727797695..31150f980c8 100644
--- a/configs/targets/microblaze-linux-user.mak
+++ b/configs/targets/microblaze-linux-user.mak
@@ -3,5 +3,5 @@ TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_HAS_BFLT=y
-TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
+TARGET_XML_FILES=microblaze-core.xml microblaze-stack-protect.xml
 TARGET_LONG_BITS=32
diff --git a/configs/targets/microblaze-softmmu.mak b/configs/targets/microblaze-softmmu.mak
index cf635798c90..f2b6ab93fbe 100644
--- a/configs/targets/microblaze-softmmu.mak
+++ b/configs/targets/microblaze-softmmu.mak
@@ -2,6 +2,6 @@ TARGET_ARCH=microblaze
 TARGET_BIG_ENDIAN=y
 # needed by boot.c
 TARGET_NEED_FDT=y
-TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
+TARGET_XML_FILES=microblaze-core.xml microblaze-stack-protect.xml
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/microblazeel-linux-user.mak b/configs/targets/microblazeel-linux-user.mak
index a51a05488d3..5dcd4b5b183 100644
--- a/configs/targets/microblazeel-linux-user.mak
+++ b/configs/targets/microblazeel-linux-user.mak
@@ -2,5 +2,5 @@ TARGET_ARCH=microblaze
 TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_HAS_BFLT=y
-TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
+TARGET_XML_FILES=microblaze-core.xml microblaze-stack-protect.xml
 TARGET_LONG_BITS=32
diff --git a/configs/targets/or1k-linux-user.mak b/configs/targets/or1k-linux-user.mak
index 9f8c178ef10..ecb95253680 100644
--- a/configs/targets/or1k-linux-user.mak
+++ b/configs/targets/or1k-linux-user.mak
@@ -2,6 +2,6 @@ TARGET_ARCH=or1k
 TARGET_BIG_ENDIAN=y
 TARGET_SYSTBL_ABI=common,32,or1k,time32,stat64,rlimit,renameat
 TARGET_SYSTBL=syscall.tbl
-TARGET_XML_FILES= gdb-xml/or1k-core.xml
+TARGET_XML_FILES= or1k-core.xml
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/or1k-softmmu.mak b/configs/targets/or1k-softmmu.mak
index 24d89bc3e65..c3ca0a2c6ba 100644
--- a/configs/targets/or1k-softmmu.mak
+++ b/configs/targets/or1k-softmmu.mak
@@ -2,7 +2,7 @@ TARGET_ARCH=or1k
 TARGET_BIG_ENDIAN=y
 # needed by boot.c and all boards
 TARGET_NEED_FDT=y
-TARGET_XML_FILES= gdb-xml/or1k-core.xml
+TARGET_XML_FILES= or1k-core.xml
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/ppc-linux-user.mak b/configs/targets/ppc-linux-user.mak
index 970d04a5ba1..5ddec598760 100644
--- a/configs/targets/ppc-linux-user.mak
+++ b/configs/targets/ppc-linux-user.mak
@@ -2,5 +2,5 @@ TARGET_ARCH=ppc
 TARGET_SYSTBL_ABI=common,nospu,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
-TARGET_XML_FILES= gdb-xml/power-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml
+TARGET_XML_FILES= power-core.xml power-fpu.xml power-altivec.xml power-spe.xml
 TARGET_LONG_BITS=32
diff --git a/configs/targets/ppc-softmmu.mak b/configs/targets/ppc-softmmu.mak
index 9bfa7df6c36..867898bd47c 100644
--- a/configs/targets/ppc-softmmu.mak
+++ b/configs/targets/ppc-softmmu.mak
@@ -1,5 +1,5 @@
 TARGET_ARCH=ppc
 TARGET_BIG_ENDIAN=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
-TARGET_XML_FILES= gdb-xml/power-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml
+TARGET_XML_FILES= power-core.xml power-fpu.xml power-altivec.xml power-spe.xml
 TARGET_LONG_BITS=32
diff --git a/configs/targets/ppc64-linux-user.mak b/configs/targets/ppc64-linux-user.mak
index 461f1c67d15..fcedce1b4e0 100644
--- a/configs/targets/ppc64-linux-user.mak
+++ b/configs/targets/ppc64-linux-user.mak
@@ -4,5 +4,5 @@ TARGET_ABI_DIR=ppc
 TARGET_SYSTBL_ABI=common,nospu,64
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
-TARGET_XML_FILES= gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
+TARGET_XML_FILES= power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml
 TARGET_LONG_BITS=64
diff --git a/configs/targets/ppc64-softmmu.mak b/configs/targets/ppc64-softmmu.mak
index 74572864b36..10d7a2681e7 100644
--- a/configs/targets/ppc64-softmmu.mak
+++ b/configs/targets/ppc64-softmmu.mak
@@ -2,7 +2,7 @@ TARGET_ARCH=ppc64
 TARGET_BASE_ARCH=ppc
 TARGET_BIG_ENDIAN=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
-TARGET_XML_FILES= gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
+TARGET_XML_FILES= power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml
 # all boards require libfdt
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=64
diff --git a/configs/targets/ppc64le-linux-user.mak b/configs/targets/ppc64le-linux-user.mak
index cf9d8a400d9..b5a81b58868 100644
--- a/configs/targets/ppc64le-linux-user.mak
+++ b/configs/targets/ppc64le-linux-user.mak
@@ -3,5 +3,5 @@ TARGET_BASE_ARCH=ppc
 TARGET_ABI_DIR=ppc
 TARGET_SYSTBL_ABI=common,nospu,64
 TARGET_SYSTBL=syscall.tbl
-TARGET_XML_FILES= gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
+TARGET_XML_FILES= power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml
 TARGET_LONG_BITS=64
diff --git a/configs/targets/riscv32-linux-user.mak b/configs/targets/riscv32-linux-user.mak
index a0ef03c0c3f..f069ab9a0f9 100644
--- a/configs/targets/riscv32-linux-user.mak
+++ b/configs/targets/riscv32-linux-user.mak
@@ -1,7 +1,7 @@
 TARGET_ARCH=riscv32
 TARGET_BASE_ARCH=riscv
 TARGET_ABI_DIR=riscv
-TARGET_XML_FILES= gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-32bit-virtual.xml
+TARGET_XML_FILES= riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-32bit-virtual.xml
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
 TARGET_SYSTBL_ABI=32
diff --git a/configs/targets/riscv32-softmmu.mak b/configs/targets/riscv32-softmmu.mak
index 7476e596082..26080599be7 100644
--- a/configs/targets/riscv32-softmmu.mak
+++ b/configs/targets/riscv32-softmmu.mak
@@ -1,6 +1,6 @@
 TARGET_ARCH=riscv32
 TARGET_BASE_ARCH=riscv
-TARGET_XML_FILES= gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-32bit-virtual.xml
+TARGET_XML_FILES= riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-32bit-virtual.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/riscv64-bsd-user.mak b/configs/targets/riscv64-bsd-user.mak
index c6348a79629..bc85d9ed04e 100644
--- a/configs/targets/riscv64-bsd-user.mak
+++ b/configs/targets/riscv64-bsd-user.mak
@@ -1,5 +1,5 @@
 TARGET_ARCH=riscv64
 TARGET_BASE_ARCH=riscv
 TARGET_ABI_DIR=riscv
-TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml
+TARGET_XML_FILES= riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-virtual.xml
 TARGET_LONG_BITS=64
diff --git a/configs/targets/riscv64-linux-user.mak b/configs/targets/riscv64-linux-user.mak
index aac7568305d..bca08645124 100644
--- a/configs/targets/riscv64-linux-user.mak
+++ b/configs/targets/riscv64-linux-user.mak
@@ -1,7 +1,7 @@
 TARGET_ARCH=riscv64
 TARGET_BASE_ARCH=riscv
 TARGET_ABI_DIR=riscv
-TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml
+TARGET_XML_FILES= riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-virtual.xml
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
 TARGET_SYSTBL_ABI=64
diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv64-softmmu.mak
index f836f08c5b9..5059c550480 100644
--- a/configs/targets/riscv64-softmmu.mak
+++ b/configs/targets/riscv64-softmmu.mak
@@ -1,7 +1,7 @@
 TARGET_ARCH=riscv64
 TARGET_BASE_ARCH=riscv
 TARGET_KVM_HAVE_GUEST_DEBUG=y
-TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-virtual.xml
+TARGET_XML_FILES= riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-virtual.xml riscv-32bit-cpu.xml riscv-32bit-virtual.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=64
diff --git a/configs/targets/rx-softmmu.mak b/configs/targets/rx-softmmu.mak
index 281a165873a..1959d1b4ccc 100644
--- a/configs/targets/rx-softmmu.mak
+++ b/configs/targets/rx-softmmu.mak
@@ -1,5 +1,5 @@
 TARGET_ARCH=rx
-TARGET_XML_FILES= gdb-xml/rx-core.xml
+TARGET_XML_FILES= rx-core.xml
 # all boards require libfdt
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/s390x-linux-user.mak b/configs/targets/s390x-linux-user.mak
index e3723f5dc54..2dbcae0a6e2 100644
--- a/configs/targets/s390x-linux-user.mak
+++ b/configs/targets/s390x-linux-user.mak
@@ -2,6 +2,6 @@ TARGET_ARCH=s390x
 TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
-TARGET_XML_FILES= gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xml/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xml gdb-xml/s390-virt-kvm.xml gdb-xml/s390-gs.xml
+TARGET_XML_FILES= s390x-core64.xml s390-acr.xml s390-fpr.xml s390-vx.xml s390-cr.xml s390-virt.xml s390-virt-kvm.xml s390-gs.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/s390x-softmmu.mak b/configs/targets/s390x-softmmu.mak
index 544657cfe2d..e273075f1a9 100644
--- a/configs/targets/s390x-softmmu.mak
+++ b/configs/targets/s390x-softmmu.mak
@@ -1,6 +1,6 @@
 TARGET_ARCH=s390x
 TARGET_BIG_ENDIAN=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
-TARGET_XML_FILES= gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xml/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xml gdb-xml/s390-virt-kvm.xml gdb-xml/s390-gs.xml
+TARGET_XML_FILES= s390x-core64.xml s390-acr.xml s390-fpr.xml s390-vx.xml s390-cr.xml s390-virt.xml s390-virt-kvm.xml s390-gs.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc-linux-user.mak b/configs/targets/sparc-linux-user.mak
index 01446e28783..2b6f8077399 100644
--- a/configs/targets/sparc-linux-user.mak
+++ b/configs/targets/sparc-linux-user.mak
@@ -2,6 +2,6 @@ TARGET_ARCH=sparc
 TARGET_SYSTBL_ABI=common,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
-TARGET_XML_FILES=gdb-xml/sparc32-cpu.xml gdb-xml/sparc32-fpu.xml gdb-xml/sparc32-cp0.xml
+TARGET_XML_FILES=sparc32-cpu.xml sparc32-fpu.xml sparc32-cp0.xml
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc-softmmu.mak b/configs/targets/sparc-softmmu.mak
index ed846735f41..126ce12abb0 100644
--- a/configs/targets/sparc-softmmu.mak
+++ b/configs/targets/sparc-softmmu.mak
@@ -1,6 +1,6 @@
 TARGET_ARCH=sparc
 TARGET_BIG_ENDIAN=y
-TARGET_XML_FILES=gdb-xml/sparc32-cpu.xml gdb-xml/sparc32-fpu.xml gdb-xml/sparc32-cp0.xml
+TARGET_XML_FILES=sparc32-cpu.xml sparc32-fpu.xml sparc32-cp0.xml
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc32plus-linux-user.mak b/configs/targets/sparc32plus-linux-user.mak
index cf49c53ce44..a1d8530ecfd 100644
--- a/configs/targets/sparc32plus-linux-user.mak
+++ b/configs/targets/sparc32plus-linux-user.mak
@@ -5,6 +5,6 @@ TARGET_ABI_DIR=sparc
 TARGET_SYSTBL_ABI=common,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
-TARGET_XML_FILES=gdb-xml/sparc64-cpu.xml gdb-xml/sparc64-fpu.xml gdb-xml/sparc64-cp0.xml
+TARGET_XML_FILES=sparc64-cpu.xml sparc64-fpu.xml sparc64-cp0.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc64-linux-user.mak b/configs/targets/sparc64-linux-user.mak
index 81d18fcc85b..c48a03aeb9e 100644
--- a/configs/targets/sparc64-linux-user.mak
+++ b/configs/targets/sparc64-linux-user.mak
@@ -4,6 +4,6 @@ TARGET_ABI_DIR=sparc
 TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
-TARGET_XML_FILES=gdb-xml/sparc64-cpu.xml gdb-xml/sparc64-fpu.xml gdb-xml/sparc64-cp0.xml
+TARGET_XML_FILES=sparc64-cpu.xml sparc64-fpu.xml sparc64-cp0.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc64-softmmu.mak
index 602783ef0f6..4e621fb8e39 100644
--- a/configs/targets/sparc64-softmmu.mak
+++ b/configs/targets/sparc64-softmmu.mak
@@ -1,7 +1,7 @@
 TARGET_ARCH=sparc64
 TARGET_BASE_ARCH=sparc
 TARGET_BIG_ENDIAN=y
-TARGET_XML_FILES=gdb-xml/sparc64-cpu.xml gdb-xml/sparc64-fpu.xml gdb-xml/sparc64-cp0.xml
+TARGET_XML_FILES=sparc64-cpu.xml sparc64-fpu.xml sparc64-cp0.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/x86_64-bsd-user.mak b/configs/targets/x86_64-bsd-user.mak
index d62d656f2c6..d754186347f 100644
--- a/configs/targets/x86_64-bsd-user.mak
+++ b/configs/targets/x86_64-bsd-user.mak
@@ -1,4 +1,4 @@
 TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
-TARGET_XML_FILES= gdb-xml/i386-64bit.xml
+TARGET_XML_FILES= i386-64bit.xml
 TARGET_LONG_BITS=64
diff --git a/configs/targets/x86_64-linux-user.mak b/configs/targets/x86_64-linux-user.mak
index b093ab5a167..7f9527fd1de 100644
--- a/configs/targets/x86_64-linux-user.mak
+++ b/configs/targets/x86_64-linux-user.mak
@@ -2,5 +2,5 @@ TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall_64.tbl
-TARGET_XML_FILES= gdb-xml/i386-64bit.xml gdb-xml/i386-64bit-linux.xml
+TARGET_XML_FILES= i386-64bit.xml i386-64bit-linux.xml
 TARGET_LONG_BITS=64
diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-softmmu.mak
index 151862158c7..c7f8746b4f5 100644
--- a/configs/targets/x86_64-softmmu.mak
+++ b/configs/targets/x86_64-softmmu.mak
@@ -2,6 +2,6 @@ TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
-TARGET_XML_FILES= gdb-xml/i386-64bit.xml gdb-xml/i386-64bit-apx.xml
+TARGET_XML_FILES= i386-64bit.xml i386-64bit-apx.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/meson.build b/meson.build
index db8918dd303..8e8440941c0 100644
--- a/meson.build
+++ b/meson.build
@@ -4329,9 +4329,13 @@ foreach target : target_dirs
   endif
 
   if 'TARGET_XML_FILES' in config_target
+    gdbstub_xml_files = []
+    foreach gdbstub_xml : config_target['TARGET_XML_FILES'].split()
+      gdbstub_xml_files += 'gdb-xml/' + gdbstub_xml
+    endforeach
     gdbstub_xml = custom_target(target + '-gdbstub-xml.c',
                                 output: target + '-gdbstub-xml.c',
-                                input: files(config_target['TARGET_XML_FILES'].split()),
+                                input: files(gdbstub_xml_files),
                                 command: [feature_to_c, '@INPUT@'],
                                 capture: true)
     arch_srcs += gdbstub_xml
-- 
2.53.0


