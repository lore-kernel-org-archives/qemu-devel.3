Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CB1C83F20
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 16:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaGEB-0007Ws-R9; Fri, 11 Jul 2025 12:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <unisono@quyllur.org>)
 id 1uaG3G-0003Y5-6O
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 11:52:42 -0400
Received: from quyllur.org ([185.247.226.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <unisono@quyllur.org>)
 id 1uaG3D-0001q0-Fk
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 11:52:41 -0400
Received: from quyllur.org (localhost [127.0.0.1])
 by quyllur.org (OpenSMTPD) with ESMTP id 9037e408;
 Fri, 11 Jul 2025 18:52:15 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=quyllur.org; h=from:to:cc
 :subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding; s=dkimselector; bh=0rawVHz7ga8LGrdwJ
 RcO9DN7tng=; b=vKFQdxY+9IYSgJ7VPHKeu0jfGZMLHaCJFk/yI3W7tDrm0XlC0
 ruO5JWR+LwfNQZXXB2iaKsiK+Zl8VsGcM1MCCrhMQGPThDUFJ1+TzLghsvDPEBX0
 QQ3GpZ0zevJDIu554oi8FbyOZyZ+ZfaAhT8szfKOBJ/rmWM/z/B2VoDJ5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=quyllur.org; h=from:to:cc
 :subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding; q=dns; s=dkimselector; b=uea7rACLzhq
 ZW8/ECpmNmpo9AsiTlJWzhAKCxboXjS6h9j5i/c+i//2vc10A7c96t0uKROmeI6+
 XejJ0jrZztFuTUhnCuai4hAhxAzPllEEQOwhobkNKy023jpnC0yvqxh3UlDJDJDX
 UCB3sWDMWbtSI2v153q7jPJEfr5DGClY=
Received: from Rizin (<unknown> [194.127.199.111])
 by quyllur.org (OpenSMTPD) with ESMTPSA id 7b408f74
 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO); 
 Fri, 11 Jul 2025 18:52:11 +0300 (EEST)
From: unisono@quyllur.org
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, atar4qemu@gmail.com, laurent@vivier.eu,
 mark.cave-ayland@ilande.co.uk, philmd@linaro.org,
 Rot127 <unisono@quyllur.org>
Subject: [PATCH v2 1/3] Adds the GDB register XML files for Sparc64.
Date: Fri, 11 Jul 2025 10:51:39 -0500
Message-ID: <20250711155141.62916-2-unisono@quyllur.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711155141.62916-1-unisono@quyllur.org>
References: <20250711155141.62916-1-unisono@quyllur.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.247.226.42; envelope-from=unisono@quyllur.org;
 helo=quyllur.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Rot127 <unisono@quyllur.org>

Commit 1/3

Signed-off-by: Rot127 <unisono@quyllur.org>
---
 configs/targets/sparc64-linux-user.mak |  1 +
 configs/targets/sparc64-softmmu.mak    |  1 +
 gdb-xml/sparc64-core.xml               | 99 ++++++++++++++++++++++++++
 target/sparc/cpu.c                     |  1 +
 4 files changed, 102 insertions(+)
 create mode 100644 gdb-xml/sparc64-core.xml

diff --git a/configs/targets/sparc64-linux-user.mak b/configs/targets/sparc64-linux-user.mak
index 64ea04e3e2..7c2ecb7be0 100644
--- a/configs/targets/sparc64-linux-user.mak
+++ b/configs/targets/sparc64-linux-user.mak
@@ -4,4 +4,5 @@ TARGET_ABI_DIR=sparc
 TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
+TARGET_XML_FILES=gdb-xml/sparc64-core.xml
 TARGET_LONG_BITS=64
diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc64-softmmu.mak
index 2504e31ae3..d9d51d21e5 100644
--- a/configs/targets/sparc64-softmmu.mak
+++ b/configs/targets/sparc64-softmmu.mak
@@ -1,4 +1,5 @@
 TARGET_ARCH=sparc64
 TARGET_BASE_ARCH=sparc
 TARGET_BIG_ENDIAN=y
+TARGET_XML_FILES=gdb-xml/sparc64-core.xml
 TARGET_LONG_BITS=64
diff --git a/gdb-xml/sparc64-core.xml b/gdb-xml/sparc64-core.xml
new file mode 100644
index 0000000000..375b9bb0cc
--- /dev/null
+++ b/gdb-xml/sparc64-core.xml
@@ -0,0 +1,99 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2013-2025 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.sparc.core">
+  <reg name="g0" bitsize="64" type="uint64" regnum="0"/>
+  <reg name="g1" bitsize="64" type="uint64" regnum="1"/>
+  <reg name="g2" bitsize="64" type="uint64" regnum="2"/>
+  <reg name="g3" bitsize="64" type="uint64" regnum="3"/>
+  <reg name="g4" bitsize="64" type="uint64" regnum="4"/>
+  <reg name="g5" bitsize="64" type="uint64" regnum="5"/>
+  <reg name="g6" bitsize="64" type="uint64" regnum="6"/>
+  <reg name="g7" bitsize="64" type="uint64" regnum="7"/>
+  <reg name="o0" bitsize="64" type="uint64" regnum="8"/>
+  <reg name="o1" bitsize="64" type="uint64" regnum="9"/>
+  <reg name="o2" bitsize="64" type="uint64" regnum="10"/>
+  <reg name="o3" bitsize="64" type="uint64" regnum="11"/>
+  <reg name="o4" bitsize="64" type="uint64" regnum="12"/>
+  <reg name="o5" bitsize="64" type="uint64" regnum="13"/>
+  <reg name="sp" bitsize="64" type="uint64" regnum="14"/>
+  <reg name="o7" bitsize="64" type="uint64" regnum="15"/>
+  <reg name="l0" bitsize="64" type="uint64" regnum="16"/>
+  <reg name="l1" bitsize="64" type="uint64" regnum="17"/>
+  <reg name="l2" bitsize="64" type="uint64" regnum="18"/>
+  <reg name="l3" bitsize="64" type="uint64" regnum="19"/>
+  <reg name="l4" bitsize="64" type="uint64" regnum="20"/>
+  <reg name="l5" bitsize="64" type="uint64" regnum="21"/>
+  <reg name="l6" bitsize="64" type="uint64" regnum="22"/>
+  <reg name="l7" bitsize="64" type="uint64" regnum="23"/>
+  <reg name="i0" bitsize="64" type="uint64" regnum="24"/>
+  <reg name="i1" bitsize="64" type="uint64" regnum="25"/>
+  <reg name="i2" bitsize="64" type="uint64" regnum="26"/>
+  <reg name="i3" bitsize="64" type="uint64" regnum="27"/>
+  <reg name="i4" bitsize="64" type="uint64" regnum="28"/>
+  <reg name="i5" bitsize="64" type="uint64" regnum="29"/>
+  <reg name="fp" bitsize="64" type="uint64" regnum="30"/>
+  <reg name="i7" bitsize="64" type="uint64" regnum="31"/>
+
+  <reg name="f0" bitsize="32" type="ieee_single" regnum="32"/>
+  <reg name="f1" bitsize="32" type="ieee_single" regnum="33"/>
+  <reg name="f2" bitsize="32" type="ieee_single" regnum="34"/>
+  <reg name="f3" bitsize="32" type="ieee_single" regnum="35"/>
+  <reg name="f4" bitsize="32" type="ieee_single" regnum="36"/>
+  <reg name="f5" bitsize="32" type="ieee_single" regnum="37"/>
+  <reg name="f6" bitsize="32" type="ieee_single" regnum="38"/>
+  <reg name="f7" bitsize="32" type="ieee_single" regnum="39"/>
+  <reg name="f8" bitsize="32" type="ieee_single" regnum="40"/>
+  <reg name="f9" bitsize="32" type="ieee_single" regnum="41"/>
+  <reg name="f10" bitsize="32" type="ieee_single" regnum="42"/>
+  <reg name="f11" bitsize="32" type="ieee_single" regnum="43"/>
+  <reg name="f12" bitsize="32" type="ieee_single" regnum="44"/>
+  <reg name="f13" bitsize="32" type="ieee_single" regnum="45"/>
+  <reg name="f14" bitsize="32" type="ieee_single" regnum="46"/>
+  <reg name="f15" bitsize="32" type="ieee_single" regnum="47"/>
+  <reg name="f16" bitsize="32" type="ieee_single" regnum="48"/>
+  <reg name="f17" bitsize="32" type="ieee_single" regnum="49"/>
+  <reg name="f18" bitsize="32" type="ieee_single" regnum="50"/>
+  <reg name="f19" bitsize="32" type="ieee_single" regnum="51"/>
+  <reg name="f20" bitsize="32" type="ieee_single" regnum="52"/>
+  <reg name="f21" bitsize="32" type="ieee_single" regnum="53"/>
+  <reg name="f22" bitsize="32" type="ieee_single" regnum="54"/>
+  <reg name="f23" bitsize="32" type="ieee_single" regnum="55"/>
+  <reg name="f24" bitsize="32" type="ieee_single" regnum="56"/>
+  <reg name="f25" bitsize="32" type="ieee_single" regnum="57"/>
+  <reg name="f26" bitsize="32" type="ieee_single" regnum="58"/>
+  <reg name="f27" bitsize="32" type="ieee_single" regnum="59"/>
+  <reg name="f28" bitsize="32" type="ieee_single" regnum="60"/>
+  <reg name="f29" bitsize="32" type="ieee_single" regnum="61"/>
+  <reg name="f30" bitsize="32" type="ieee_single" regnum="62"/>
+  <reg name="f31" bitsize="32" type="ieee_single" regnum="63"/>
+
+  <reg name="f32" bitsize="64" type="ieee_double" regnum="64"/>
+  <reg name="f34" bitsize="64" type="ieee_double" regnum="65"/>
+  <reg name="f36" bitsize="64" type="ieee_double" regnum="66"/>
+  <reg name="f38" bitsize="64" type="ieee_double" regnum="67"/>
+  <reg name="f40" bitsize="64" type="ieee_double" regnum="68"/>
+  <reg name="f42" bitsize="64" type="ieee_double" regnum="69"/>
+  <reg name="f44" bitsize="64" type="ieee_double" regnum="70"/>
+  <reg name="f46" bitsize="64" type="ieee_double" regnum="71"/>
+  <reg name="f48" bitsize="64" type="ieee_double" regnum="72"/>
+  <reg name="f50" bitsize="64" type="ieee_double" regnum="73"/>
+  <reg name="f52" bitsize="64" type="ieee_double" regnum="74"/>
+  <reg name="f54" bitsize="64" type="ieee_double" regnum="75"/>
+  <reg name="f56" bitsize="64" type="ieee_double" regnum="76"/>
+  <reg name="f58" bitsize="64" type="ieee_double" regnum="77"/>
+  <reg name="f60" bitsize="64" type="ieee_double" regnum="78"/>
+  <reg name="f62" bitsize="64" type="ieee_double" regnum="79"/>
+
+  <reg name="pc" bitsize="64" type="code_ptr" regnum="80"/>
+  <reg name="npc" bitsize="64" type="code_ptr" regnum="81"/>
+  <reg name="state" bitsize="64" type="uint64" regnum="82"/>
+  <reg name="fsr" bitsize="64" type="uint64" regnum="83"/>
+  <reg name="fprs" bitsize="64" type="uint64" regnum="84"/>
+  <reg name="y" bitsize="64" type="uint64" regnum="85"/>
+</feature>
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index ed7701b02f..245caf2de0 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1090,6 +1090,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, const void *data)
     cc->disas_set_info = cpu_sparc_disas_set_info;
 
 #if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
+    cc->gdb_core_xml_file = "sparc64-core.xml";
     cc->gdb_num_core_regs = 86;
 #else
     cc->gdb_num_core_regs = 72;
-- 
2.50.0


