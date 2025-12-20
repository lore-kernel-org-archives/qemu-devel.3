Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70A0E6689E
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Dec 2025 07:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWrKP-0005s4-Ij; Sat, 20 Dec 2025 02:24:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vWrKE-0005px-R7
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 02:24:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vWrKB-0006S6-S1
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 02:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766215461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i2I7FTNAKZ0oH8a6pQ3+PVpYyiKeajoOBeFFfw0GuKs=;
 b=iMIqPlxPTJAl8B7hJU+Xb9LP7Jkjht5YR/kz+35nfJyedMsfXjRC5+P+Vu+RBMsiSH4GsS
 jtib12fmAc45OOMRLN6ngpSFULPJH6m+vg2phNvjYpAJbFBW5KKFdX96laMz18mltmCKNM
 fuNIx2LLDR0UAwnh02X31dYucCqmwwQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-3disJT0_NB-aPVKVrUBuYg-1; Sat,
 20 Dec 2025 02:24:20 -0500
X-MC-Unique: 3disJT0_NB-aPVKVrUBuYg-1
X-Mimecast-MFC-AGG-ID: 3disJT0_NB-aPVKVrUBuYg_1766215459
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CC6118005B0
 for <qemu-devel@nongnu.org>; Sat, 20 Dec 2025 07:24:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F03611955F1A
 for <qemu-devel@nongnu.org>; Sat, 20 Dec 2025 07:24:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 886BA21E66C2; Sat, 20 Dec 2025 08:24:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	berrange@redhat.com
Subject: [PATCH 2/4] MAINTAINERS: Fix coverage of meson.build in
 tests/functional
Date: Sat, 20 Dec 2025 08:24:14 +0100
Message-ID: <20251220072416.3745923-3-armbru@redhat.com>
In-Reply-To: <20251220072416.3745923-1-armbru@redhat.com>
References: <20251220072416.3745923-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Of the 29 meson.build wihin tests/functional, only 8 are covered.  Add
the architecture-independent ones to "Functional testing framework",
and the remainder to "$arcg general architecture support" when
available, else to "$arch TCG CPUs".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fcb60c0c02..746cca7ae9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -133,6 +133,7 @@ S: Odd Fixes
 K: ^Subject:.*(?i)mips
 F: docs/system/target-mips.rst
 F: configs/targets/mips*
+F: tests/functional/mips*/meson.build
 
 X86 general architecture support
 M: Paolo Bonzini <pbonzini@redhat.com>
@@ -200,6 +201,8 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: target/arm/
 F: target/arm/tcg/
+F: tests/functional/aarch64/meson.build
+F: tests/functional/arm/meson.build
 F: tests/tcg/arm/
 F: tests/tcg/aarch64/
 F: tests/qtest/arm-cpu-features.c
@@ -261,6 +264,7 @@ M: Song Gao <gaosong@loongson.cn>
 S: Maintained
 F: target/loongarch/
 F: tests/tcg/loongarch64/
+F: tests/functional/loongarch64/meson.build
 F: tests/functional/loongarch64/test_virt.py
 
 M68K TCG CPUs
@@ -268,6 +272,7 @@ M: Laurent Vivier <laurent@vivier.eu>
 S: Maintained
 F: target/m68k/
 F: disas/m68k.c
+F: tests/functional/m68k/meson.build
 F: tests/tcg/m68k/
 
 MicroBlaze TCG CPUs
@@ -277,6 +282,7 @@ F: target/microblaze/
 F: hw/microblaze/
 F: disas/microblaze.c
 F: tests/docker/dockerfiles/debian-microblaze-cross.d/build-toolchain.sh
+F: tests/functional/microblaze*/meson.build
 
 MIPS TCG CPUs
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
@@ -296,6 +302,7 @@ F: docs/system/openrisc/cpu-features.rst
 F: target/openrisc/
 F: hw/openrisc/
 F: include/hw/openrisc/
+F: tests/functional/or1k/meson.build
 F: tests/tcg/openrisc/
 
 PowerPC TCG CPUs
@@ -313,6 +320,7 @@ F: configs/devices/ppc*
 F: docs/system/ppc/embedded.rst
 F: docs/system/target-ppc.rst
 F: tests/tcg/ppc*/*
+F: tests/functional/ppc*/meson.build
 F: tests/functional/ppc/test_74xx.py
 
 RISC-V TCG CPUs
@@ -361,6 +369,7 @@ RENESAS RX CPUs
 R: Yoshinori Sato <yoshinori.sato@nifty.com>
 S: Orphan
 F: target/rx/
+F: tests/functional/rx/meson.build
 
 S390 TCG CPUs
 M: Richard Henderson <richard.henderson@linaro.org>
@@ -380,6 +389,7 @@ F: target/sh4/
 F: hw/sh4/
 F: disas/sh4.c
 F: include/hw/sh4/
+F: tests/functional/sh4*/meson.build
 F: tests/tcg/sh4/
 
 SPARC TCG CPUs
@@ -391,6 +401,7 @@ F: hw/sparc/
 F: hw/sparc64/
 F: include/hw/sparc/sparc64.h
 F: disas/sparc.c
+F: tests/functional/sparc*/meson.build
 F: tests/tcg/sparc64/
 
 X86 TCG CPUs
@@ -412,6 +423,7 @@ W: http://wiki.osll.ru/doku.php?id=etc:users:jcmvbkbc:qemu-target-xtensa
 S: Maintained
 F: target/xtensa/
 F: hw/xtensa/
+F: tests/functional/xtensa/meson.build
 F: tests/tcg/xtensa/
 F: tests/tcg/xtensaeb/
 F: disas/xtensa.c
@@ -4431,6 +4443,8 @@ R: Daniel P. Berrange <berrange@redhat.com>
 S: Maintained
 F: docs/devel/testing/functional.rst
 F: scripts/clean_functional_cache.py
+F: tests/functional/meson.build
+F: tests/functional/generic/meson.build
 F: tests/functional/qemu_test/
 
 Windows Hosted Continuous Integration
-- 
2.49.0


