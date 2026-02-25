Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A31FD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO8t-0003jG-3I; Wed, 25 Feb 2026 18:18:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO8S-0003PL-Mk
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:17:44 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO8Q-00035n-Dk
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:17:40 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso2331935e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061456; x=1772666256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PjE4E2zb8Ovhf0XH2ErfRByBQjQ33Su6saJMtd2PGNk=;
 b=vKscC7mwOEvUYeZZJUt0qIs/5OUPlHgrTPi4pSD3LHQPZcdbd3PF6VoCuAZ68DTINA
 wL0Z4oI3va4EgdDE/TcskIuFHUoq6lOCjF0YBV5s82fUKewlDc6ql7KbIXwbHAUkkBM1
 HwH/Kz28kh3SfXrIu0xWl+4EeMcKZc8B19JElCmU+omx/NYKcrn/+bpEf266kHBsvmaj
 lwEMoYfalGzO9L7EbY5H82GIcpVp9wT9k1dt1YLPAidahhnIALZvlYaluI51+lDXK9xB
 l+enmHNGoyRgtfA4OyIgWUc+EinB2pve1+3Cfr/jqmxyT2KeZxEZUqc0Nf02Ncm+npIW
 icTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061456; x=1772666256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PjE4E2zb8Ovhf0XH2ErfRByBQjQ33Su6saJMtd2PGNk=;
 b=Zr3UVGvwbwFoqGnag3C+kjTiXS/q5P4/x0VfCRbE5AA2i383uJHvIPWsYUTqX575NL
 A6fyas5r/P6bVW4TnyGc2+bejdVA8XH8lQsEvqXcLK4gGY6tg+uMnGA6EHvJuHumRbPa
 0aLBuCUUSaaMVHVG/uaVOYBzFXX/c9H344PzpG6kxJ7Onx/CccDRwgWN+6LICilt4+0t
 /ZSJgiqh7nPVMo4J2MWPN5m6+2r2qgoqRdHC+elCigK/RKa9Uq5GKihG/ihMZYq7Xnrl
 W0csnKkQVPI+2BIOxCWnSq8HmSqRtsjlDgHT92OMjkVIxwgICauJaAVNqSZ/1JcEeF64
 RooQ==
X-Gm-Message-State: AOJu0YzImdKYyanMH2kB3kMZ7HRl1UmE3/zDVDTTNtQ1ytVhccG/G5xS
 KDTx03KVoD19L2yqdkWRrZgDZKyS9Te4GsxjnhrSJ/nYPMIFgX6qvUbGPnSEaG4/xuCpAuOvHGc
 ZT/ehguww3Q==
X-Gm-Gg: ATEYQzz/4NjzlWC9kp7G8yDdSYti5yQ7HYiFXyH44+5PBkp/ZSD++iB0ooyw7ALfeXc
 r8hAkpw/FjYMv0gIeayymk2Hi+W8P/gOA9HGInYB8bChC42fukYJaOwzzreAyFygAMiVFPDHgw4
 VCh1/JILBGZXtY/RnP5gvLN+cenPafJwFwPzduC8k2yVYbvyTyeSupWuyqC+KRd9TTq8ctz7Z8l
 nXAfmzC8MJxVr6+XzGqPO08orJgN7xNiiggikaenuP93FjTXSzzrysWck4lRjCJV6753czEZV8s
 uDY9G7ADfSTXJlGifMqL3CrcfSR8JgSexw26dRfalMBHZxpJWEBdV7nT6KWEvbVGV3zMCX408bx
 zVCz09+J7vE3lTe7SwEk9QodHTun5swYza/BUF4K/Ma5QB0MGLR2Ij7hjO3MyR4mHGIp6zRk2Te
 i0M1beNn8LxzaWZnfpbJHiLINUH4SPt0juAsISSbqrdSeTrbfJA65ladhhH/c9OchAI3uYcikt
X-Received: by 2002:a05:600c:1381:b0:483:7783:5373 with SMTP id
 5b1f17b1804b1-483c21a5835mr36852675e9.23.1772061455906; 
 Wed, 25 Feb 2026 15:17:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb776b0sm22755795e9.1.2026.02.25.15.17.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:17:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/70] target/or1k: Use XML register definitions from GDB
Date: Thu, 26 Feb 2026 00:13:30 +0100
Message-ID: <20260225231411.96482-31-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

Import gdb-xml/or1k-fpu.xml from mainstream binutils, tag
'binutils-2_46' [*]. Register as CPUClass::gdb_core_xml_file.

[*] https://sourceware.org/git/?p=binutils-gdb.git;a=blob_plain;f=gdb/features/or1k-core.xml;h=0d13f355f5296ae426794eb3003dcc18fbbd49d5;hb=refs/tags/binutils-2_46

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-23-philmd@linaro.org>
---
 MAINTAINERS                         |  1 +
 configs/targets/or1k-linux-user.mak |  1 +
 configs/targets/or1k-softmmu.mak    |  1 +
 target/or1k/cpu.c                   |  2 +-
 gdb-xml/or1k-core.xml               | 65 +++++++++++++++++++++++++++++
 5 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100644 gdb-xml/or1k-core.xml

diff --git a/MAINTAINERS b/MAINTAINERS
index 693b51166f5..8da0b357fbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -304,6 +304,7 @@ M: Stafford Horne <shorne@gmail.com>
 S: Odd Fixes
 F: docs/system/or1k/cpu-features.rst
 F: target/or1k/
+F: gdb-xml/or1k-core.xml
 F: hw/or1k/
 F: include/hw/or1k/
 F: tests/functional/or1k/meson.build
diff --git a/configs/targets/or1k-linux-user.mak b/configs/targets/or1k-linux-user.mak
index 0ee3a05884d..9f8c178ef10 100644
--- a/configs/targets/or1k-linux-user.mak
+++ b/configs/targets/or1k-linux-user.mak
@@ -2,5 +2,6 @@ TARGET_ARCH=or1k
 TARGET_BIG_ENDIAN=y
 TARGET_SYSTBL_ABI=common,32,or1k,time32,stat64,rlimit,renameat
 TARGET_SYSTBL=syscall.tbl
+TARGET_XML_FILES= gdb-xml/or1k-core.xml
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/or1k-softmmu.mak b/configs/targets/or1k-softmmu.mak
index 204283d604f..24d89bc3e65 100644
--- a/configs/targets/or1k-softmmu.mak
+++ b/configs/targets/or1k-softmmu.mak
@@ -2,6 +2,7 @@ TARGET_ARCH=or1k
 TARGET_BIG_ENDIAN=y
 # needed by boot.c and all boards
 TARGET_NEED_FDT=y
+TARGET_XML_FILES= gdb-xml/or1k-core.xml
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/target/or1k/cpu.c b/target/or1k/cpu.c
index c64542a59a2..3d1c22bf75d 100644
--- a/target/or1k/cpu.c
+++ b/target/or1k/cpu.c
@@ -288,13 +288,13 @@ static void openrisc_cpu_class_init(ObjectClass *oc, const void *data)
     cc->dump_state = openrisc_cpu_dump_state;
     cc->set_pc = openrisc_cpu_set_pc;
     cc->get_pc = openrisc_cpu_get_pc;
+    cc->gdb_core_xml_file = "or1k-core.xml";
     cc->gdb_read_register = openrisc_cpu_gdb_read_register;
     cc->gdb_write_register = openrisc_cpu_gdb_write_register;
 #ifndef CONFIG_USER_ONLY
     dc->vmsd = &vmstate_openrisc_cpu;
     cc->sysemu_ops = &openrisc_sysemu_ops;
 #endif
-    cc->gdb_num_core_regs = 32 + 3;
     cc->disas_set_info = openrisc_disas_set_info;
     cc->tcg_ops = &openrisc_tcg_ops;
 }
diff --git a/gdb-xml/or1k-core.xml b/gdb-xml/or1k-core.xml
new file mode 100644
index 00000000000..0d13f355f52
--- /dev/null
+++ b/gdb-xml/or1k-core.xml
@@ -0,0 +1,65 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2017-2026 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.or1k.group0">
+  <reg name="r0" bitsize="32" type="int"/>
+  <reg name="r1" bitsize="32" type="data_ptr"/>
+  <reg name="r2" bitsize="32" type="data_ptr"/>
+  <reg name="r3" bitsize="32" type="int"/>
+  <reg name="r4" bitsize="32" type="int"/>
+  <reg name="r5" bitsize="32" type="int"/>
+  <reg name="r6" bitsize="32" type="int"/>
+  <reg name="r7" bitsize="32" type="int"/>
+  <reg name="r8" bitsize="32" type="int"/>
+  <reg name="r9" bitsize="32" type="code_ptr"/>
+  <reg name="r10" bitsize="32" type="int"/>
+  <reg name="r11" bitsize="32" type="int"/>
+  <reg name="r12" bitsize="32" type="int"/>
+  <reg name="r13" bitsize="32" type="int"/>
+  <reg name="r14" bitsize="32" type="int"/>
+  <reg name="r15" bitsize="32" type="int"/>
+  <reg name="r16" bitsize="32" type="int"/>
+  <reg name="r17" bitsize="32" type="int"/>
+  <reg name="r18" bitsize="32" type="int"/>
+  <reg name="r19" bitsize="32" type="int"/>
+  <reg name="r20" bitsize="32" type="int"/>
+  <reg name="r21" bitsize="32" type="int"/>
+  <reg name="r22" bitsize="32" type="int"/>
+  <reg name="r23" bitsize="32" type="int"/>
+  <reg name="r24" bitsize="32" type="int"/>
+  <reg name="r25" bitsize="32" type="int"/>
+  <reg name="r26" bitsize="32" type="int"/>
+  <reg name="r27" bitsize="32" type="int"/>
+  <reg name="r28" bitsize="32" type="int"/>
+  <reg name="r29" bitsize="32" type="int"/>
+  <reg name="r30" bitsize="32" type="int"/>
+  <reg name="r31" bitsize="32" type="int"/>
+  <reg name="ppc" bitsize="32" type="code_ptr"/>
+  <reg name="npc" bitsize="32" type="code_ptr"/>
+  <flags id="sr_flags" size="4">
+    <field name="SM" start="0" end="0"/>
+    <field name="TEE" start="1" end="1"/>
+    <field name="IEE" start="2" end="2"/>
+    <field name="DCE" start="3" end="3"/>
+    <field name="ICE" start="4" end="4"/>
+    <field name="DME" start="5" end="5"/>
+    <field name="IME" start="6" end="6"/>
+    <field name="LEE" start="7" end="7"/>
+    <field name="CE" start="8" end="8"/>
+    <field name="F" start="9" end="9"/>
+    <field name="CY" start="10" end="10"/>
+    <field name="OV" start="11" end="11"/>
+    <field name="OVE" start="12" end="12"/>
+    <field name="DSX" start="13" end="13"/>
+    <field name="EPH" start="14" end="14"/>
+    <field name="FO" start="15" end="15"/>
+    <field name="SUMRA" start="16" end="16"/>
+    <field name="CID" start="28" end="31"/>
+  </flags>
+  <reg name="sr" bitsize="32" type="sr_flags"/>
+</feature>
-- 
2.52.0


