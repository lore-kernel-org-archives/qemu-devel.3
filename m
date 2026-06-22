Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD00FCD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbct6-0000Av-85; Mon, 22 Jun 2026 07:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbcsq-00008s-SR
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 07:32:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbcsl-0003YU-Lc
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 07:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782127923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zw+nUDte9eg8RpQMkkKD6YZDECpaeuGKUOV1I7RuLCc=;
 b=QiHsMhO/BpAfXLSaX28oJHZlIlEQcaMteiy4zMqYgtgdv6j40COZAi2Q+wAFGA/wUXIRET
 W3TUNDdXFxiXt6qIFOh5SQL/LkCzqp1Sksw6EpbPYzlFEzDT/N70aHj8v8aTp3RPXRtrKD
 +ku4UE5KQiQgDJjryp4rRTwyHfoiKPw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-u3j-VrtDOS2J4fiL9FUxEg-1; Mon,
 22 Jun 2026 07:32:00 -0400
X-MC-Unique: u3j-VrtDOS2J4fiL9FUxEg-1
X-Mimecast-MFC-AGG-ID: u3j-VrtDOS2J4fiL9FUxEg_1782127919
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E37B1955F79
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 11:31:59 +0000 (UTC)
Received: from berrange.com (unknown [10.44.33.119])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CFC44195394F; Mon, 22 Jun 2026 11:31:57 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/3] MAINTAINERS: record known Git Lab handles for all
 maintainers
Date: Mon, 22 Jun 2026 12:31:51 +0100
Message-ID: <20260622113152.1710585-3-berrange@redhat.com>
In-Reply-To: <20260622113152.1710585-1-berrange@redhat.com>
References: <20260622113152.1710585-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This updates MAINTAINERS with a "G:" line corresponding to every
"M:" line that can be identified with a match against

  https://gitlab.com/qemu-project/qemu/-/project_members

This update was done using a largely automated process based on
the data extracted with

  $ glab api --paginate /projects/qemu-project%2fqemu/members | jq -c '.[] | {username, name}'
  $ glab api --paginate /groups/qemu-project/members | jq -c '.[] | {username, name}'

Some Git Lab accounts had real names that didn't have an exact
match in MAINTAINERS so the glab api data was manually pre-processed
to change those names.

A Perl script was then used to insert "G:" lines for every "M:"
lines.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 MAINTAINERS | 332 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 332 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93df53d87f..9a62fe0e81 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18,6 +18,13 @@ Descriptions of section entries:
 	   These reviewers should be CCed on patches.
 	   Reviewers are familiar with the subject matter and provide feedback
 	   even though they are not maintainers.
+	G: Git Lab handle to assign issues to: @GitLabHandle
+	   Maintainers must have a Git Lab handle listed. The handle will
+	   be invited to be a member of https://gitlab.com/qemu-project/qemu
+	   with the "Reporter" role. This will enable triage actions, issue
+	   assignment, and visibilityof confidential security disclosures.
+	   Designated reviewers may also be listed at the discretion of the
+	   maintainer.
 	L: Mailing list that is relevant to this area
 	   These lists should be CCed on patches.
 	W: Web-page with status/info
@@ -58,6 +65,7 @@ Descriptions of section entries:
 General Project Administration
 ------------------------------
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 
 All patches CC here
 L: qemu-devel@nongnu.org
@@ -84,13 +92,16 @@ Responsible Disclosure, Reporting Security Issues
 -------------------------------------------------
 W: https://wiki.qemu.org/SecurityProcess
 M: Michael S. Tsirkin <mst@redhat.com>
+G: @mstredhat
 L: qemu-security@nongnu.org
 
 Trivial patches
 ---------------
 Trivial patches
 M: Michael Tokarev <mjt@tls.msk.ru>
+G: @mjt0k
 M: Laurent Vivier <laurent@vivier.eu>
+G: @lvivier
 S: Maintained
 L: qemu-trivial@nongnu.org
 K: ^Subject:.*(?i)trivial
@@ -102,6 +113,7 @@ Architecture support
 --------------------
 S390 general architecture support
 M: Cornelia Huck <cohuck@redhat.com>
+G: @cohuck
 M: Eric Farman <farman@linux.ibm.com>
 M: Matthew Rosato <mjrosato@linux.ibm.com>
 S: Supported
@@ -133,6 +145,7 @@ L: qemu-s390x@nongnu.org
 
 MIPS general architecture support
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Odd Fixes
 K: ^Subject:.*(?i)mips
@@ -142,6 +155,7 @@ F: tests/functional/mips*/meson.build
 
 X86 general architecture support
 M: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 R: Zhao Liu <zhao1.liu@intel.com>
 S: Maintained
 F: configs/devices/i386-softmmu/default.mak
@@ -159,7 +173,9 @@ F: tests/functional/x86_64/
 
 X86 VM file descriptor change on reset test
 M: Ani Sinha <anisinha@redhat.com>
+G: @anisinha
 M: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 S: Maintained
 F: stubs/kvm.c
 F: tests/functional/x86_64/test_rebuild_vmfd.py
@@ -168,6 +184,7 @@ Guest CPU cores (TCG)
 ---------------------
 Overall TCG CPUs
 M: Richard Henderson <richard.henderson@linaro.org>
+G: @rth7680
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: system/watchpoint.c
@@ -194,7 +211,9 @@ F: tests/decode/
 FPU emulation
 M: Aurelien Jarno <aurelien@aurel32.net>
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 M: Alex Bennée <alex.bennee@linaro.org>
+G: @stsquad
 S: Maintained
 F: fpu/
 F: include/fpu/
@@ -202,6 +221,7 @@ F: tests/fp/
 
 Alpha TCG CPUs
 M: Richard Henderson <richard.henderson@linaro.org>
+G: @rth7680
 S: Maintained
 F: target/alpha/
 F: tests/tcg/alpha/
@@ -210,6 +230,7 @@ F: disas/alpha.c
 
 ARM TCG CPUs
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Supported
 F: target/arm/
@@ -247,6 +268,7 @@ F: tests/functional/avr/
 
 Hexagon TCG CPUs
 M: Brian Cain <brian.cain@oss.qualcomm.com>
+G: @brian-cain
 R: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Supported
 F: target/hexagon/
@@ -269,7 +291,9 @@ F: target/hexagon/gen_idef_parser_funcs.py
 
 HPPA (PA-RISC) TCG CPUs
 M: Richard Henderson <richard.henderson@linaro.org>
+G: @rth7680
 M: Helge Deller <deller@gmx.de>
+G: @hdeller
 S: Maintained
 F: target/hppa/
 F: disas/hppa.c
@@ -286,6 +310,7 @@ F: tests/functional/loongarch64/test_virt.py
 
 M68K TCG CPUs
 M: Laurent Vivier <laurent@vivier.eu>
+G: @lvivier
 S: Maintained
 F: target/m68k/
 F: disas/m68k.c
@@ -303,6 +328,7 @@ F: tests/functional/microblaze/
 
 MIPS TCG CPUs
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 R: Aurelien Jarno <aurelien@aurel32.net>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 R: Aleksandar Rikalo <arikalo@gmail.com>
@@ -325,6 +351,7 @@ F: tests/tcg/or1k/
 
 PowerPC TCG CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
+G: @npiggin
 R: Chinmay Rath <rathc@linux.ibm.com>
 R: Glenn Miles <milesg@linux.ibm.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
@@ -346,6 +373,7 @@ F: tests/functional/ppc/test_74xx.py
 RISC-V TCG CPUs
 M: Palmer Dabbelt <palmer@dabbelt.com>
 M: Alistair Francis <alistair.francis@wdc.com>
+G: @alistair23
 R: Weiwei Li <liwei1518@gmail.com>
 R: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
 R: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
@@ -393,6 +421,7 @@ F: tests/functional/rx/meson.build
 
 S390 TCG CPUs
 M: Richard Henderson <richard.henderson@linaro.org>
+G: @rth7680
 M: Ilya Leoshkevich <iii@linux.ibm.com>
 R: David Hildenbrand <david@kernel.org>
 S: Maintained
@@ -414,6 +443,7 @@ F: tests/tcg/sh4/
 
 SPARC TCG CPUs
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
+G: @mcayland
 M: Artyom Tarasenko <atar4qemu@gmail.com>
 S: Maintained
 F: target/sparc/
@@ -426,7 +456,9 @@ F: tests/functional/sparc*/meson.build
 
 X86 TCG CPUs
 M: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 M: Richard Henderson <richard.henderson@linaro.org>
+G: @rth7680
 S: Maintained
 F: target/i386/tcg/
 F: tests/tcg/i386/
@@ -459,6 +491,7 @@ F: tests/tcg/tricore/
 
 Multiarch Linux User Tests
 M: Alex Bennée <alex.bennee@linaro.org>
+G: @stsquad
 S: Maintained
 F: tests/tcg/multiarch/
 
@@ -466,6 +499,7 @@ Guest CPU Cores (KVM)
 ---------------------
 Overall KVM CPUs
 M: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 L: kvm@vger.kernel.org
 S: Supported
 F: */*/kvm*
@@ -476,6 +510,7 @@ F: scripts/kvm/kvm_flightrecorder
 
 ARM KVM CPUs
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Supported
 F: target/arm/kvm.c
@@ -483,6 +518,7 @@ F: tests/functional/aarch64/test_kvm.py
 
 PPC KVM CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
+G: @npiggin
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 S: Odd Fixes
 F: target/ppc/kvm.c
@@ -490,6 +526,7 @@ F: target/ppc/kvm.c
 S390 KVM CPUs
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
+G: @cborntra
 R: Eric Farman <farman@linux.ibm.com>
 R: Matthew Rosato <mjrosato@linux.ibm.com>
 S: Supported
@@ -502,6 +539,7 @@ L: qemu-s390x@nongnu.org
 
 X86 KVM CPUs
 M: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 M: Marcelo Tosatti <mtosatti@redhat.com>
 L: kvm@vger.kernel.org
 S: Supported
@@ -518,6 +556,7 @@ F: tests/functional/x86_64/test_hotplug_cpu.py
 
 Xen emulation on X86 KVM CPUs
 M: David Woodhouse <dwmw2@infradead.org>
+G: @dwmw2
 M: Paul Durrant <paul@xen.org>
 S: Supported
 F: include/system/kvm_xen.h
@@ -530,6 +569,7 @@ Guest CPU Cores (other accelerators)
 ------------------------------------
 Overall CPUs other accelerators
 M: Richard Henderson <richard.henderson@linaro.org>
+G: @rth7680
 R: Paolo Bonzini <pbonzini@redhat.com>
 R: Philippe Mathieu-Daudé <philmd@mailo.com>
 S: Maintained
@@ -550,6 +590,7 @@ F: system/cpus.c
 
 Apple Silicon HVF CPUs
 M: Alexander Graf <agraf@csgraf.de>
+G: @agraf
 S: Maintained
 F: target/arm/hvf/
 
@@ -573,6 +614,7 @@ F: include/system/hvf_int.h
 WHPX CPUs
 M: Pedro Barbuda <pbarbuda@microsoft.com>
 M: Mohamed Mediouni <mohamed@unpredictable.fr>
+G: @mediouni-m
 S: Supported
 F: accel/whpx/
 F: target/i386/whpx/
@@ -597,6 +639,7 @@ F: include/hw/hyperv/hvhdk*.h
 
 Nitro Enclaves (native)
 M: Alexander Graf <graf@amazon.com>
+G: @agraf
 S: Maintained
 F: accel/nitro/
 F: include/system/nitro-accel.h
@@ -656,8 +699,11 @@ Hosts
 -----
 LINUX
 M: Michael S. Tsirkin <mst@redhat.com>
+G: @mstredhat
 M: Cornelia Huck <cohuck@redhat.com>
+G: @cohuck
 M: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 S: Maintained
 F: linux-headers/
 F: include/standard-headers/
@@ -665,6 +711,7 @@ F: scripts/update-linux-headers.sh
 
 POSIX
 M: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 S: Maintained
 F: os-posix.c
 F: include/system/os-posix.h
@@ -683,6 +730,7 @@ K: ^Subject:.*(?i)OpenBSD
 
 W32, W64
 M: Stefan Weil <sw@weilnetz.de>
+G: @stweil
 S: Maintained
 F: *win32*
 F: */*win32*
@@ -693,6 +741,7 @@ F: scripts/nsis.py
 
 Darwin (macOS, iOS)
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 S: Odd Fixes
 F: .gitlab-ci.d/macos*
 F: */*.m
@@ -711,6 +760,7 @@ Alpha Machines
 --------------
 Clipper
 M: Richard Henderson <richard.henderson@linaro.org>
+G: @rth7680
 S: Maintained
 F: hw/alpha/
 F: hw/isa/smc37c669-superio.c
@@ -721,6 +771,7 @@ ARM Machines
 ------------
 Allwinner-a10
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 R: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
@@ -744,6 +795,7 @@ F: tests/functional/arm/test_orangepi.py
 
 ARM PrimeCell and CMSDK devices
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/char/pl011.c
@@ -781,6 +833,7 @@ F: include/hw/misc/tz-msc.h
 
 ARM cores
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/intc/arm*
@@ -804,6 +857,7 @@ F: tests/qtest/test-arm-mptimer.c
 
 Bananapi M2U
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: docs/system/arm/bananapi_m2u.rst
@@ -822,6 +876,7 @@ F: tests/qtest/dm163-test.c
 
 Exynos
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/*/exynos*
@@ -832,6 +887,7 @@ F: tests/functional/arm/test_smdkc210.py
 Canon DIGIC
 M: Antony Pavlov <antonynpavlov@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: include/hw/arm/digic.h
@@ -842,6 +898,7 @@ F: docs/system/arm/digic.rst
 
 Goldfish RTC
 M: Alistair Francis <Alistair.Francis@wdc.com>
+G: @alistair23
 L: qemu-riscv@nongnu.org
 S: Maintained
 F: hw/rtc/goldfish_rtc.c
@@ -849,6 +906,7 @@ F: include/hw/rtc/goldfish_rtc.h
 
 i.MX25 PDK
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 R: Jean-Christophe Dubois <jcd@tribudubois.net>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
@@ -863,6 +921,7 @@ F: docs/system/arm/imx25-pdk.rst
 
 i.MX31 (kzm)
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/kzm.c
@@ -874,6 +933,7 @@ F: docs/system/arm/kzm.rst
 
 Integrator CP
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/integratorcp.c
@@ -892,6 +952,7 @@ F: tests/functional/arm/test_max78000fthr.py
 
 MCIMX6UL EVK / i.MX6ul
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 R: Jean-Christophe Dubois <jcd@tribudubois.net>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
@@ -906,6 +967,7 @@ F: docs/system/arm/mcimx6ul-evk.rst
 
 MCIMX7D SABRE / i.MX7
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/mcimx7d-sabre.c
@@ -945,6 +1007,7 @@ F: tests/qtest/rs5c372-test.c
 
 MPS2 / MPS3
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/mps2.c
@@ -975,6 +1038,7 @@ F: docs/system/arm/mps2.rst
 
 Musca
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/musca.c
@@ -983,6 +1047,7 @@ F: docs/system/arm/musca.rst
 Musicpal
 M: Jan Kiszka <jan.kiszka@web.de>
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/musicpal.c
@@ -1008,6 +1073,7 @@ F: tests/functional/arm/test_quanta_gsj.py
 
 Raspberry Pi
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 R: Philippe Mathieu-Daudé <philmd@mailo.com>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
@@ -1021,6 +1087,7 @@ F: tests/functional/aarch64/test_raspi*.py
 
 Real View
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/realview*
@@ -1032,6 +1099,7 @@ F: tests/functional/arm/test_realview.py
 
 SABRELITE / i.MX6
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 R: Jean-Christophe Dubois <jcd@tribudubois.net>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
@@ -1048,6 +1116,7 @@ F: include/hw/ssi/imx_spi.h
 
 SBSA-REF
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 R: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
 L: qemu-arm@nongnu.org
 S: Maintained
@@ -1060,6 +1129,7 @@ F: tests/functional/aarch64/test_*sbsaref*.py
 
 Sharp SL-5500 (Collie) PDA
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/collie.c
@@ -1070,6 +1140,7 @@ F: tests/functional/arm/test_collie.py
 
 Stellaris
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/*/stellaris*
@@ -1101,6 +1172,7 @@ F: docs/system/arm/stm32.rst
 
 Versatile Express
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/vexpress.c
@@ -1110,6 +1182,7 @@ F: tests/functional/arm/test_vexpress.py
 
 Versatile PB
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/*/versatile*
@@ -1121,6 +1194,7 @@ F: docs/system/arm/versatile.rst
 
 Virt
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Supported
 F: hw/arm/virt*
@@ -1134,7 +1208,9 @@ F: tests/functional/arm/test_virt.py
 Xilinx Zynq
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 M: Alistair Francis <alistair@alistair23.me>
+G: @alistair23
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/*/xilinx_*
@@ -1149,8 +1225,10 @@ F: docs/system/arm/xlnx-zynq.rst
 
 Xilinx ZynqMP and Versal
 M: Alistair Francis <alistair@alistair23.me>
+G: @alistair23
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/*/xlnx*.c
@@ -1186,7 +1264,9 @@ F: hw/arm/stm32f100_soc.c
 
 STM32F205
 M: Alistair Francis <alistair@alistair23.me>
+G: @alistair23
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/stm32f205_soc.c
@@ -1199,7 +1279,9 @@ F: include/hw/*/stm32*.h
 
 STM32F405
 M: Alistair Francis <alistair@alistair23.me>
+G: @alistair23
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/stm32f405_soc.c
@@ -1210,14 +1292,18 @@ F: include/hw/misc/stm32_rcc.h
 
 Netduino 2
 M: Alistair Francis <alistair@alistair23.me>
+G: @alistair23
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/netduino2.c
 
 Netduino Plus 2
 M: Alistair Francis <alistair@alistair23.me>
+G: @alistair23
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/netduinoplus2.c
@@ -1231,6 +1317,7 @@ F: hw/arm/olimex-stm32-h405.c
 SmartFusion2
 M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/msf2-soc.c
@@ -1247,6 +1334,7 @@ F: include/hw/net/msf2-emac.h
 Emcraft M2S-FG484
 M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/msf2-som.c
@@ -1255,7 +1343,9 @@ F: tests/functional/arm/test_emcraft_sf2.py
 
 ASPEED BMCs
 M: Cédric Le Goater <clg@kaod.org>
+G: @clegoate
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 R: Steven Lee <steven_lee@aspeedtech.com>
 R: Troy Lee <leetroy@gmail.com>
 R: Jamin Lin <jamin_lin@aspeedtech.com>
@@ -1279,6 +1369,7 @@ F: roms/vbootrom
 NRF51
 M: Joel Stanley <joel@jms.id.au>
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/*/nrf51*.c
@@ -1291,6 +1382,7 @@ F: docs/system/arm/nrf.rst
 
 ARM PL011 Rust device
 M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+G: @epilys
 S: Maintained
 F: rust/hw/char/pl011/
 
@@ -1311,6 +1403,7 @@ F: hw/misc/avr_power.c
 
 Arduino
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 S: Maintained
 F: hw/avr/arduino.c
 F: tests/functional/avr/test_uno.py
@@ -1319,7 +1412,9 @@ HP-PARISC Machines
 ------------------
 HP B160L, HP C3700
 M: Richard Henderson <richard.henderson@linaro.org>
+G: @rth7680
 M: Helge Deller <deller@gmx.de>
+G: @hdeller
 S: Maintained
 F: configs/devices/hppa-softmmu/default.mak
 F: hw/char/diva-gsp.c
@@ -1364,12 +1459,14 @@ M68K Machines
 -------------
 an5206
 M: Thomas Huth <th.huth+qemu@posteo.eu>
+G: @thuth
 S: Odd Fixes
 F: hw/m68k/an5206.c
 F: hw/m68k/mcf5206.c
 
 mcf5208
 M: Thomas Huth <th.huth+qemu@posteo.eu>
+G: @thuth
 S: Odd Fixes
 F: hw/m68k/mcf5208.c
 F: hw/m68k/mcf_intc.c
@@ -1380,6 +1477,7 @@ F: tests/functional/m68k/test_mcf5208evb.py
 
 NeXTcube
 M: Thomas Huth <th.huth+qemu@posteo.eu>
+G: @thuth
 S: Odd Fixes
 F: hw/m68k/next-*.c
 F: hw/display/next-fb.c
@@ -1388,6 +1486,7 @@ F: tests/functional/m68k/test_nextcube.py
 
 q800
 M: Laurent Vivier <laurent@vivier.eu>
+G: @lvivier
 S: Maintained
 F: hw/m68k/q800.c
 F: hw/m68k/q800-glue.c
@@ -1414,6 +1513,7 @@ F: tests/functional/m68k/test_q800.py
 
 virt
 M: Laurent Vivier <laurent@vivier.eu>
+G: @lvivier
 S: Maintained
 F: hw/m68k/virt.c
 F: hw/char/goldfish_tty.c
@@ -1445,6 +1545,7 @@ MIPS Machines
 -------------
 Overall MIPS Machines
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 S: Odd Fixes
 F: configs/devices/mips*/*
 F: hw/mips/
@@ -1462,6 +1563,7 @@ F: hw/nvram/ds1225y.c
 
 Malta
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 R: Aurelien Jarno <aurelien@aurel32.net>
 S: Odd Fixes
 F: hw/isa/piix.c
@@ -1476,6 +1578,7 @@ F: tests/functional/mips*/test_tuxrun.py
 Fuloong 2E
 M: Huacai Chen <chenhuacai@kernel.org>
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Odd Fixes
 F: hw/mips/fuloong2e.c
@@ -1500,6 +1603,7 @@ F: tests/functional/mips64el/test_loongson3v.py
 
 Boston
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 R: Aleksandar Rikalo <arikalo@gmail.com>
 S: Odd Fixes
 F: hw/core/loader-fit.c
@@ -1561,6 +1665,7 @@ F: tests/functional/ppc/test_mpc8544ds.py
 
 New World (mac99)
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
+G: @mcayland
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: docs/system/ppc/powermac.rst
@@ -1583,6 +1688,7 @@ F: tests/functional/ppc64/test_mac99.py
 
 Old World (g3beige)
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
+G: @mcayland
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: docs/system/ppc/powermac.rst
@@ -1623,7 +1729,9 @@ F: tests/functional/ppc/test_40p.py
 
 sPAPR (pseries)
 M: Nicholas Piggin <npiggin@gmail.com>
+G: @npiggin
 M: Harsh Prateek Bora <harshpb@linux.ibm.com>
+G: @harshpb
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/*/spapr*
@@ -1646,6 +1754,7 @@ F: tests/functional/ppc64/test_tuxrun.py
 
 PowerNV (Non-Virtualized)
 M: Nicholas Piggin <npiggin@gmail.com>
+G: @npiggin
 R: Aditya Gupta <adityag@linux.ibm.com>
 R: Glenn Miles <milesg@linux.ibm.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
@@ -1729,6 +1838,7 @@ RISC-V Machines
 ---------------
 OpenTitan
 M: Alistair Francis <Alistair.Francis@wdc.com>
+G: @alistair23
 L: qemu-riscv@nongnu.org
 S: Supported
 F: hw/riscv/opentitan.c
@@ -1765,6 +1875,7 @@ F: include/hw/char/shakti_uart.h
 
 SiFive Machines
 M: Alistair Francis <Alistair.Francis@wdc.com>
+G: @alistair23
 M: Palmer Dabbelt <palmer@dabbelt.com>
 L: qemu-riscv@nongnu.org
 S: Supported
@@ -1825,6 +1936,7 @@ SPARC Machines
 --------------
 Sun4m
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
+G: @mcayland
 S: Maintained
 F: hw/sparc/sun4m.c
 F: hw/sparc/sun4m_iommu.c
@@ -1841,6 +1953,7 @@ F: tests/functional/sparc/test_sun4m.py
 
 Sun4u
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
+G: @mcayland
 S: Maintained
 F: hw/sparc64/sun4u.c
 F: hw/sparc64/sun4u_iommu.c
@@ -1873,6 +1986,7 @@ S390 Machines
 S390 Virtio-ccw
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
+G: @cborntra
 M: Eric Farman <farman@linux.ibm.com>
 R: Matthew Rosato <mjrosato@linux.ibm.com>
 S: Supported
@@ -1909,6 +2023,7 @@ L: qemu-s390x@nongnu.org
 S390 channel subsystem
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
+G: @cborntra
 M: Eric Farman <farman@linux.ibm.com>
 R: Farhan Ali <alifm@linux.ibm.com>
 S: Supported
@@ -1932,6 +2047,7 @@ L: qemu-s390x@nongnu.org
 S390 SCLP-backed devices
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
+G: @cborntra
 R: Jason Herne <jjherne@linux.ibm.com>
 S: Supported
 F: include/hw/s390x/event-facility.h
@@ -1955,6 +2071,7 @@ X86 Machines
 ------------
 PC
 M: Michael S. Tsirkin <mst@redhat.com>
+G: @mstredhat
 S: Supported
 F: include/hw/i386/
 F: hw/i386/
@@ -1985,7 +2102,9 @@ F: tests/functional/x86_64/test_cpu_model_versions.py
 
 PC Chipset
 M: Michael S. Tsirkin <mst@redhat.com>
+G: @mstredhat
 M: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 S: Supported
 F: hw/char/debugcon.c
 F: hw/char/parallel*
@@ -2020,6 +2139,7 @@ F: include/hw/rtc/mc146818rtc*
 microvm
 M: Sergio Lopez <slp@redhat.com>
 M: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 S: Maintained
 F: docs/system/i386/microvm.rst
 F: hw/i386/microvm.c
@@ -2028,6 +2148,7 @@ F: pc-bios/bios-microvm.bin
 
 nitro-enclave
 M: Alexander Graf <graf@amazon.com>
+G: @agraf
 M: Dorjoy Chowdhury <dorjoychy111@gmail.com>
 S: Maintained
 F: hw/core/eif.c
@@ -2038,6 +2159,7 @@ F: docs/system/i386/nitro-enclave.rst
 
 Machine core
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 R: Zhao Liu <zhao1.liu@intel.com>
 S: Maintained
 F: hw/core/cpu-common.c
@@ -2060,7 +2182,9 @@ F: tests/unit/test-smp-parse.c
 
 TargetInfo API
 M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
+G: @pierrick.bouvier
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 S: Supported
 F: include/qemu/target-info*.h
 F: target-info*.c
@@ -2090,6 +2214,7 @@ Devices
 -------
 Overall Audio frontends
 M: Gerd Hoffmann <kraxel@redhat.com>
+G: @kraxel
 S: Odd Fixes
 F: hw/audio/
 F: include/hw/audio/
@@ -2114,6 +2239,7 @@ F: docs/specs/edu.rst
 
 IDE
 M: John Snow <jsnow@redhat.com>
+G: @jsnow
 L: qemu-block@nongnu.org
 S: Odd Fixes
 F: include/hw/ide/
@@ -2138,6 +2264,7 @@ T: git https://github.com/cminyard/qemu.git master-ipmi-rebase
 
 Floppy
 M: John Snow <jsnow@redhat.com>
+G: @jsnow
 L: qemu-block@nongnu.org
 S: Odd Fixes
 F: hw/block/fdc.c
@@ -2156,6 +2283,7 @@ F: include/hw/hyperv/vmbus*.h
 
 OMAP
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/*/omap*
@@ -2171,6 +2299,7 @@ F: hw/ipack/
 
 PCI
 M: Michael S. Tsirkin <mst@redhat.com>
+G: @mstredhat
 S: Supported
 F: include/hw/pci/*
 F: hw/misc/pci-testdev.c
@@ -2183,13 +2312,16 @@ F: docs/system/sriov.rst
 
 ARM PCI Hotplug
 M: Gustavo Romero <gustavo.romero@linaro.org>
+G: @gusbromero
 L: qemu-arm@nongnu.org
 S: Supported
 F: tests/functional/aarch64/test_hotplug_pci.py
 
 ACPI/SMBIOS
 M: Michael S. Tsirkin <mst@redhat.com>
+G: @mstredhat
 M: Igor Mammedov <imammedo@redhat.com>
+G: @imammedo
 R: Ani Sinha <anisinha@redhat.com>
 S: Supported
 F: include/hw/acpi/*
@@ -2227,7 +2359,9 @@ F: hw/acpi/viot.h
 
 ACPI/FUNCTIONAL/BIOSBITS
 M: Ani Sinha <anisinha@redhat.com>
+G: @anisinha
 M: Michael S. Tsirkin <mst@redhat.com>
+G: @mstredhat
 S: Supported
 F: tests/functional/acpi-bits/
 F: tests/functional/x86_64/test_acpi_bits.py
@@ -2268,6 +2402,7 @@ F: include/hw/intc/ppc-uic.h
 
 Character devices
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
+G: @marcandre.lureau-rh
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Odd Fixes
 F: hw/char/
@@ -2275,6 +2410,7 @@ F: include/hw/char/
 
 Network devices
 M: Jason Wang <jasowang@redhat.com>
+G: @jasowang
 S: Odd Fixes
 F: hw/net/
 F: include/hw/net/
@@ -2285,12 +2421,14 @@ T: git https://github.com/jasowang/qemu.git net
 
 Parallel NOR Flash devices
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 S: Maintained
 F: hw/block/pflash_cfi*.c
 F: include/hw/block/flash.h
 
 SCSI
 M: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 R: Fam Zheng <fam@euphon.net>
 S: Supported
 F: include/hw/scsi/*
@@ -2303,6 +2441,7 @@ T: git https://github.com/bonzini/qemu.git scsi-next
 
 SSI
 M: Alistair Francis <alistair@alistair23.me>
+G: @alistair23
 S: Maintained
 F: hw/ssi/*
 F: hw/block/m25p80*
@@ -2312,12 +2451,15 @@ F: tests/qtest/aspeed_smc-test.c
 
 Xilinx SPI
 M: Alistair Francis <alistair@alistair23.me>
+G: @alistair23
 S: Maintained
 F: hw/ssi/xilinx_*
 
 SD (Secure Card)
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 M: Bin Meng <bmeng.cn@gmail.com>
+G: @lbmeng
 L: qemu-block@nongnu.org
 S: Odd Fixes
 F: include/hw/sd/sd*
@@ -2342,7 +2484,9 @@ F: hw/usb/dev-serial.c
 
 VFIO
 M: Alex Williamson <alex@shazbot.org>
+G: @alex.williamson
 M: Cédric Le Goater <clg@redhat.com>
+G: @clegoate
 S: Supported
 F: hw/vfio/*
 F: util/vfio-helpers.c
@@ -2354,7 +2498,9 @@ F: tests/functional/aarch64/test_device_passthrough.py
 
 vfio-igd
 M: Alex Williamson <alex@shazbot.org>
+G: @alex.williamson
 M: Cédric Le Goater <clg@redhat.com>
+G: @clegoate
 M: Tomita Moeko <tomitamoeko@gmail.com>
 S: Supported
 F: hw/vfio/igd.c
@@ -2406,6 +2552,7 @@ F: docs/specs/iommu-testdev.rst
 
 vhost
 M: Michael S. Tsirkin <mst@redhat.com>
+G: @mstredhat
 R: Stefano Garzarella <sgarzare@redhat.com>
 S: Supported
 F: hw/*/*vhost*
@@ -2428,6 +2575,7 @@ F: hw/virtio/vhost-shadow-virtqueue.*
 
 virtio
 M: Michael S. Tsirkin <mst@redhat.com>
+G: @mstredhat
 S: Supported
 F: hw/*/virtio*
 F: hw/virtio/trace-events
@@ -2440,7 +2588,9 @@ F: tests/functional/x86_64/test_virtio_version.py
 
 virtio-balloon
 M: Michael S. Tsirkin <mst@redhat.com>
+G: @mstredhat
 M: David Hildenbrand <david@kernel.org>
+G: @davidhildenbrand
 S: Maintained
 F: docs/interop/virtio-balloon-stats.rst
 F: hw/virtio/virtio-balloon*.c
@@ -2452,6 +2602,7 @@ F: tests/functional/x86_64/test_virtio_balloon.py
 
 virtio-9p
 M: Christian Schoenebeck <qemu_oss@crudebyte.com>
+G: @schoenebeck
 R: Greg Kurz <groug@kaod.org>
 S: Maintained
 W: https://wiki.qemu.org/Documentation/9p
@@ -2464,6 +2615,7 @@ T: git https://github.com/cschoenebeck/qemu.git 9p.next
 
 virtio-blk
 M: Stefan Hajnoczi <stefanha@redhat.com>
+G: @stefanha
 L: qemu-block@nongnu.org
 S: Supported
 F: hw/block/virtio-blk-common.c
@@ -2476,6 +2628,7 @@ T: git https://github.com/stefanha/qemu.git block
 
 virtio-ccw
 M: Cornelia Huck <cohuck@redhat.com>
+G: @cohuck
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Eric Farman <farman@linux.ibm.com>
 S: Supported
@@ -2492,6 +2645,7 @@ F: tests/unit/test-virtio-dmabuf.c
 
 virtiofs
 M: Stefan Hajnoczi <stefanha@redhat.com>
+G: @stefanha
 S: Supported
 F: hw/virtio/vhost-user-fs*
 F: include/hw/virtio/vhost-user-fs.h
@@ -2499,6 +2653,7 @@ L: virtio-fs@lists.linux.dev
 
 virtio-input
 M: Gerd Hoffmann <kraxel@redhat.com>
+G: @kraxel
 S: Odd Fixes
 F: docs/system/devices/virtio/vhost-user-contrib.rst
 F: hw/input/virtio-input*.c
@@ -2514,6 +2669,7 @@ F: include/hw/virtio/virtio-iommu.h
 
 virtio-serial
 M: Laurent Vivier <lvivier@redhat.com>
+G: @lvivier
 R: Amit Shah <amit@kernel.org>
 S: Supported
 F: hw/char/virtio-serial-bus.c
@@ -2523,6 +2679,7 @@ F: tests/qtest/virtio-serial-test.c
 
 virtio-rng
 M: Laurent Vivier <lvivier@redhat.com>
+G: @lvivier
 R: Amit Shah <amit@kernel.org>
 S: Supported
 F: hw/virtio/virtio-rng.c
@@ -2540,6 +2697,7 @@ F: include/hw/virtio/virtio-rtc.h
 
 virtio-nsm
 M: Alexander Graf <graf@amazon.com>
+G: @agraf
 M: Dorjoy Chowdhury <dorjoychy111@gmail.com>
 S: Maintained
 F: hw/virtio/cbor-helpers.c
@@ -2550,6 +2708,7 @@ F: include/hw/virtio/virtio-nsm.h
 
 vhost-user-stubs
 M: Alex Bennée <alex.bennee@linaro.org>
+G: @stsquad
 S: Maintained
 F: hw/virtio/vhost-user-base.c
 F: hw/virtio/vhost-user-test-device*
@@ -2563,6 +2722,7 @@ F: include/hw/virtio/vhost-user-rng.h
 
 vhost-user-gpio
 M: Alex Bennée <alex.bennee@linaro.org>
+G: @stsquad
 R: Viresh Kumar <viresh.kumar@linaro.org>
 S: Maintained
 F: hw/virtio/vhost-user-gpio*
@@ -2571,6 +2731,7 @@ F: tests/qtest/libqos/virtio-gpio.*
 
 vhost-user-snd
 M: Alex Bennée <alex.bennee@linaro.org>
+G: @stsquad
 R: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 S: Maintained
 F: hw/virtio/vhost-user-snd*
@@ -2591,6 +2752,7 @@ F: hw/virtio/vhost-user-spi*
 
 vhost-user-rtc
 M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+G: @epilys
 S: Supported
 F: include/hw/virtio/vhost-user-rtc.h
 F: hw/virtio/vhost-user-rtc*
@@ -2604,6 +2766,7 @@ F: include/hw/virtio/virtio-crypto.h
 
 virtio based memory device
 M: David Hildenbrand <david@kernel.org>
+G: @davidhildenbrand
 S: Supported
 F: hw/s390x/virtio-ccw-md.c
 F: hw/s390x/virtio-ccw-md.h
@@ -2613,6 +2776,7 @@ F: include/hw/virtio/virtio-md-pci.h
 
 virtio-mem
 M: David Hildenbrand <david@kernel.org>
+G: @davidhildenbrand
 S: Supported
 W: https://virtio-mem.gitlab.io/
 F: hw/virtio/virtio-mem.c
@@ -2624,7 +2788,9 @@ F: include/hw/virtio/virtio-mem.h
 
 virtio-snd
 M: Gerd Hoffmann <kraxel@redhat.com>
+G: @kraxel
 M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+G: @epilys
 S: Supported
 F: hw/audio/virtio-snd.c
 F: hw/audio/virtio-snd-pci.c
@@ -2634,6 +2800,7 @@ F: docs/system/devices/virtio/virtio-snd.rst
 nvme
 M: Keith Busch <kbusch@kernel.org>
 M: Klaus Jensen <its@irrelevant.dk>
+G: @birkelund
 R: Jesper Devantier <foss@defmacro.it>
 L: qemu-block@nongnu.org
 S: Supported
@@ -2715,6 +2882,7 @@ F: tests/qtest/libqos/igb.c
 
 eepro100
 M: Stefan Weil <sw@weilnetz.de>
+G: @stweil
 S: Maintained
 F: hw/net/eepro100.c
 
@@ -2737,6 +2905,7 @@ F: include/hw/gpio/pcf8574.h
 
 Generic Loader
 M: Alistair Francis <alistair@alistair23.me>
+G: @alistair23
 S: Maintained
 F: hw/core/generic-loader.c
 F: hw/core/uboot_image.h
@@ -2747,6 +2916,7 @@ F: tests/data/hex-loader/test.hex
 
 Guest Loader
 M: Alex Bennée <alex.bennee@linaro.org>
+G: @stsquad
 S: Maintained
 F: hw/core/guest-loader.c
 F: docs/system/guest-loader.rst
@@ -2754,6 +2924,7 @@ F: tests/functional/aarch64/test_xen.py
 
 CHRP NVRAM
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
+G: @mcayland
 S: Maintained
 F: hw/nvram/chrp_nvram.c
 F: include/hw/nvram/chrp_nvram.h
@@ -2761,6 +2932,7 @@ F: tests/qtest/prom-env-test.c
 
 EEPROM 93xx
 M: Stefan Weil <sw@weilnetz.de>
+G: @stweil
 S: Maintained
 F: hw/nvram/eeprom93xx.c
 F: include/hw/nvram/eeprom93xx.h
@@ -2775,12 +2947,14 @@ F: tests/qtest/vmgenid-test.c
 
 LED
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 S: Maintained
 F: include/hw/misc/led.h
 F: hw/misc/led.c
 
 Unimplemented device
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 R: Philippe Mathieu-Daudé <philmd@mailo.com>
 R: Ani Sinha <ani@anisinha.ca>
 S: Maintained
@@ -2797,6 +2971,7 @@ F: hw/misc/empty_slot.c
 
 Standard VGA
 M: Gerd Hoffmann <kraxel@redhat.com>
+G: @kraxel
 S: Maintained
 F: hw/display/vga*
 F: hw/display/bochs-display.c
@@ -2806,12 +2981,14 @@ F: docs/specs/standard-vga.rst
 
 ramfb
 M: Gerd Hoffmann <kraxel@redhat.com>
+G: @kraxel
 S: Maintained
 F: hw/display/ramfb*.c
 F: include/hw/display/ramfb.h
 
 virtio-gpu
 M: Alex Bennée <alex.bennee@linaro.org>
+G: @stsquad
 R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 R: Dmitry Osipenko <dmitry.osipenko@collabora.com>
 S: Odd Fixes
@@ -2838,6 +3015,7 @@ F: include/hw/virtio/virtio-blk-common.h
 
 vhost-user-gpu
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
+G: @marcandre.lureau-rh
 S: Maintained
 F: docs/interop/vhost-user-gpu.rst
 F: contrib/vhost-user-gpu
@@ -2845,17 +3023,20 @@ F: hw/display/vhost-user-*
 
 qemu-vnc
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
+G: @marcandre.lureau-rh
 S: Maintained
 F: tools/qemu-vnc
 
 Cirrus VGA
 M: Gerd Hoffmann <kraxel@redhat.com>
+G: @kraxel
 S: Odd Fixes
 W: https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful/
 F: hw/display/cirrus*
 
 EDID Generator
 M: Gerd Hoffmann <kraxel@redhat.com>
+G: @kraxel
 S: Maintained
 F: hw/display/edid*
 F: include/hw/display/edid.h
@@ -2869,6 +3050,7 @@ F: hw/display/apple-gfx*
 PIIX4 South Bridge (i82371AB)
 M: Hervé Poussineau <hpoussin@reactos.org>
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 S: Maintained
 F: hw/isa/piix.c
 F: include/hw/southbridge/piix.h
@@ -2876,6 +3058,7 @@ F: include/hw/southbridge/piix.h
 VIA South Bridges (VT82C686B, VT8231)
 M: BALATON Zoltan <balaton@eik.bme.hu>
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Maintained
 F: hw/isa/vt82c686.c
@@ -2935,18 +3118,21 @@ F: docs/system/devices/can.rst
 
 OpenPIC interrupt controller
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
+G: @mcayland
 S: Odd Fixes
 F: hw/intc/openpic.c
 F: include/hw/ppc/openpic.h
 
 MIPS CPS
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 S: Odd Fixes
 F: hw/misc/mips_*
 F: include/hw/misc/mips_*
 
 MIPS GIC
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 S: Odd Fixes
 F: hw/intc/mips_gic.c
 F: hw/timer/mips_gictimer.c
@@ -2956,6 +3142,7 @@ F: include/hw/timer/mips_gictimer.h
 S390 3270 device
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
+G: @cborntra
 R: Collin Walling <walling@linux.ibm.com>
 S: Odd Fixes
 F: include/hw/s390x/3270-ccw.h
@@ -2966,6 +3153,7 @@ L: qemu-s390x@nongnu.org
 S390 diag 288 watchdog
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
+G: @cborntra
 R: Collin Walling <walling@linux.ibm.com>
 S: Supported
 F: hw/watchdog/wdt_diag288.c
@@ -2975,6 +3163,7 @@ L: qemu-s390x@nongnu.org
 S390 storage key device
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
+G: @cborntra
 R: Jason Herne <jjherne@linux.ibm.com>
 S: Supported
 F: include/hw/s390x/storage-keys.h
@@ -2984,6 +3173,7 @@ L: qemu-s390x@nongnu.org
 S390 storage attribute device
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
+G: @cborntra
 R: Jason Herne <jjherne@linux.ibm.com>
 S: Supported
 F: include/hw/s390x/storage-attributes.h
@@ -2993,6 +3183,7 @@ L: qemu-s390x@nongnu.org
 S390 floating interrupt controller
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
+G: @cborntra
 R: David Hildenbrand <david@kernel.org>
 R: Jason Herne <jjherne@linux.ibm.com>
 S: Supported
@@ -3018,6 +3209,7 @@ F: include/hw/hyperv/hv-balloon.h
 
 ivshmem-flat
 M: Gustavo Romero <gustavo.romero@linaro.org>
+G: @gusbromero
 S: Maintained
 F: hw/misc/ivshmem-flat.c
 F: include/hw/misc/ivshmem-flat.h
@@ -3025,12 +3217,14 @@ F: docs/system/devices/ivshmem-flat.rst
 
 UEFI variable service
 M: Gerd Hoffmann <kraxel@redhat.com>
+G: @kraxel
 S: Maintained
 F: hw/uefi/
 F: include/hw/uefi/
 
 VMapple
 M: Alexander Graf <agraf@csgraf.de>
+G: @agraf
 M: Phil Dennis-Jordan <phil@philjordan.eu>
 S: Maintained
 F: hw/vmapple/*
@@ -3039,6 +3233,7 @@ F: docs/system/arm/vmapple.rst
 
 Nitro Enclaves (native)
 M: Alexander Graf <graf@amazon.com>
+G: @agraf
 S: Maintained
 F: hw/nitro/
 F: include/hw/nitro/
@@ -3048,7 +3243,9 @@ Subsystems
 ----------
 Overall Audio backends
 M: Gerd Hoffmann <kraxel@redhat.com>
+G: @kraxel
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
+G: @marcandre.lureau-rh
 S: Odd Fixes
 F: audio/
 X: audio/alsaaudio.c
@@ -3066,13 +3263,16 @@ F: tests/audio/
 
 ALSA Audio backend
 M: Gerd Hoffmann <kraxel@redhat.com>
+G: @kraxel
 R: Christian Schoenebeck <qemu_oss@crudebyte.com>
 S: Odd Fixes
 F: audio/alsaaudio.c
 
 Core Audio framework backend
 M: Gerd Hoffmann <kraxel@redhat.com>
+G: @kraxel
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 R: Christian Schoenebeck <qemu_oss@crudebyte.com>
 R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Odd Fixes
@@ -3080,40 +3280,48 @@ F: audio/coreaudio.m
 
 DSound Audio backend
 M: Gerd Hoffmann <kraxel@redhat.com>
+G: @kraxel
 S: Odd Fixes
 F: audio/dsound*
 
 JACK Audio Connection Kit backend
 M: Gerd Hoffmann <kraxel@redhat.com>
+G: @kraxel
 R: Christian Schoenebeck <qemu_oss@crudebyte.com>
 S: Odd Fixes
 F: audio/jackaudio.c
 
 Open Sound System (OSS) Audio backend
 M: Gerd Hoffmann <kraxel@redhat.com>
+G: @kraxel
 S: Odd Fixes
 F: audio/ossaudio.c
 
 PulseAudio backend
 M: Gerd Hoffmann <kraxel@redhat.com>
+G: @kraxel
 S: Odd Fixes
 F: audio/paaudio.c
 
 SDL Audio backend
 M: Gerd Hoffmann <kraxel@redhat.com>
+G: @kraxel
 R: Thomas Huth <th.huth+qemu@posteo.eu>
 S: Odd Fixes
 F: audio/sdlaudio.c
 
 Sndio Audio backend
 M: Gerd Hoffmann <kraxel@redhat.com>
+G: @kraxel
 R: Alexandre Ratchov <alex@caoua.org>
 S: Odd Fixes
 F: audio/sndioaudio.c
 
 Block layer core
 M: Kevin Wolf <kwolf@redhat.com>
+G: @kmwolf
 M: Hanna Reitz <hreitz@redhat.com>
+G: @hreitz
 L: qemu-block@nongnu.org
 S: Supported
 F: block*
@@ -3134,6 +3342,7 @@ T: git https://repo.or.cz/qemu/kevin.git block
 
 Storage daemon
 M: Kevin Wolf <kwolf@redhat.com>
+G: @kmwolf
 L: qemu-block@nongnu.org
 S: Supported
 F: storage-daemon/
@@ -3143,7 +3352,9 @@ T: git https://repo.or.cz/qemu/kevin.git block
 
 Block I/O path
 M: Stefan Hajnoczi <stefanha@redhat.com>
+G: @stefanha
 M: Fam Zheng <fam@euphon.net>
+G: @famzheng
 L: qemu-block@nongnu.org
 S: Supported
 F: util/async.c
@@ -3160,6 +3371,7 @@ T: git https://github.com/stefanha/qemu.git block
 
 Block SCSI subsystem
 M: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 R: Fam Zheng <fam@euphon.net>
 L: qemu-block@nongnu.org
 S: Supported
@@ -3168,7 +3380,9 @@ F: scsi/*
 
 Block Jobs
 M: John Snow <jsnow@redhat.com>
+G: @jsnow
 M: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
+G: @vsementsov
 L: qemu-block@nongnu.org
 S: Supported
 F: blockjob.c
@@ -3220,7 +3434,9 @@ F: qapi/cxl.json
 
 Dirty Bitmaps
 M: Eric Blake <eblake@redhat.com>
+G: @ebblake
 M: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
+G: @vsementsov
 R: John Snow <jsnow@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
@@ -3238,6 +3454,7 @@ T: git https://gitlab.com/vsementsov/qemu.git block
 
 Character device backends
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
+G: @marcandre.lureau-rh
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: chardev/
@@ -3266,11 +3483,13 @@ F: scripts/coverity-scan/model.c
 
 Coverity Scan integration
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 S: Maintained
 F: scripts/coverity-scan/
 
 Device Tree
 M: Alistair Francis <alistair.francis@wdc.com>
+G: @alistair23
 R: David Gibson <david@gibson.dropbear.id.au>
 S: Maintained
 F: system/device_tree.c
@@ -3279,6 +3498,7 @@ F: include/system/device_tree.h
 Dump
 S: Supported
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
+G: @marcandre.lureau-rh
 R: Ani Sinha <anisinha@redhat.com>
 F: dump/
 F: hw/misc/vmcoreinfo.c
@@ -3326,6 +3546,7 @@ F: tests/functional/ppc64/test_fadump.py
 
 GDB stub
 M: Alex Bennée <alex.bennee@linaro.org>
+G: @stsquad
 R: Philippe Mathieu-Daudé <philmd@mailo.com>
 S: Maintained
 F: docs/system/gdb.rst
@@ -3339,6 +3560,7 @@ T: git https://gitlab.com/stsquad/qemu gdbstub/next
 
 Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 M: Peter Xu <peterx@redhat.com>
 R: Philippe Mathieu-Daudé <philmd@mailo.com>
 S: Supported
@@ -3363,7 +3585,9 @@ F: scripts/coccinelle/memory-region-housekeeping.cocci
 
 Memory devices
 M: David Hildenbrand <david@kernel.org>
+G: @davidhildenbrand
 M: Igor Mammedov <imammedo@redhat.com>
+G: @imammedo
 S: Supported
 F: hw/mem/memory-device*.c
 F: hw/mem/nvdimm.c
@@ -3385,6 +3609,7 @@ F: docs/spice-port-fqdn.txt
 
 Graphics
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
+G: @marcandre.lureau-rh
 S: Odd Fixes
 F: ui/
 F: include/ui/
@@ -3395,13 +3620,16 @@ F: tests/functional/generic/test_vnc.py
 
 Cocoa graphics
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Odd Fixes
 F: ui/cocoa.m
 
 Main loop
 M: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 S: Maintained
 F: include/qemu/main-loop.h
 F: include/system/runstate.h
@@ -3418,6 +3646,7 @@ F: qapi/run-state.json
 
 Read, Copy, Update (RCU)
 M: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 S: Maintained
 F: docs/devel/lockcnt.rst
 F: docs/devel/rcu.rst
@@ -3430,6 +3659,7 @@ F: util/rcu.c
 
 Human Monitor (HMP)
 M: Dr. David Alan Gilbert <dave@treblig.org>
+G: @dagrh
 S: Maintained
 F: monitor/monitor-internal.h
 F: monitor/monitor.c
@@ -3443,6 +3673,7 @@ F: util/qemu-print.c
 
 Network device backends
 M: Jason Wang <jasowang@redhat.com>
+G: @jasowang
 S: Maintained
 F: net/
 F: include/net/
@@ -3463,7 +3694,9 @@ F: net/af-xdp.c
 
 Host Memory Backends
 M: David Hildenbrand <david@kernel.org>
+G: @davidhildenbrand
 M: Igor Mammedov <imammedo@redhat.com>
+G: @imammedo
 S: Maintained
 F: backends/hostmem*.c
 F: include/system/hostmem.h
@@ -3479,7 +3712,9 @@ F: qapi/cryptodev.json
 
 Python library
 M: John Snow <jsnow@redhat.com>
+G: @jsnow
 M: Cleber Rosa <crosa@redhat.com>
+G: @cleber.gnu
 S: Maintained
 F: python/
 F: tests/docker/dockerfiles/python.docker
@@ -3487,19 +3722,23 @@ T: git https://gitlab.com/jsnow/qemu.git python
 
 Python scripts
 M: John Snow <jsnow@redhat.com>
+G: @jsnow
 M: Cleber Rosa <crosa@redhat.com>
+G: @cleber.gnu
 S: Odd Fixes
 F: scripts/*.py
 F: tests/*.py
 
 Benchmark util
 M: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
+G: @vsementsov
 S: Maintained
 F: scripts/simplebench/
 T: git https://gitlab.com/vsementsov/qemu.git simplebench
 
 Transactions helper
 M: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
+G: @vsementsov
 S: Maintained
 F: include/qemu/transactions.h
 F: util/transactions.c
@@ -3508,6 +3747,7 @@ T: git https://gitlab.com/vsementsov/qemu.git block
 QAPI
 M: Markus Armbruster <armbru@redhat.com>
 M: Michael Roth <michael.roth@amd.com>
+G: @mdroth
 S: Supported
 F: qapi/
 X: qapi/*.json
@@ -3525,6 +3765,7 @@ T: git https://repo.or.cz/qemu/armbru.git qapi-next
 
 QAPI Schema
 M: Eric Blake <eblake@redhat.com>
+G: @ebblake
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
 F: qapi/*.json
@@ -3550,7 +3791,9 @@ T: git https://repo.or.cz/qemu/armbru.git qapi-next
 
 QEMU Guest Agent
 M: Michael Roth <michael.roth@amd.com>
+G: @mdroth
 M: Kostiantyn Kostiuk <kkostiuk@redhat.com>
+G: @kostyanf14
 S: Maintained
 F: qga/
 F: contrib/systemd/qemu-guest-agent.service
@@ -3562,6 +3805,7 @@ T: git https://github.com/mdroth/qemu.git qga
 
 QEMU Guest Agent Win32
 M: Kostiantyn Kostiuk <kkostiuk@redhat.com>
+G: @kostyanf14
 S: Maintained
 F: qga/*win32*
 F: qga/vss-win32/
@@ -3570,6 +3814,7 @@ T: git https://github.com/kostyanf14/qemu.git qga-win32
 
 QOM
 M: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 R: Daniel P. Berrange <berrange@redhat.com>
 S: Supported
 F: docs/devel/qom.rst
@@ -3585,6 +3830,7 @@ F: tests/qtest/qom-test.c
 
 QDev
 M: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 R: Daniel P. Berrange <berrange@redhat.com>
 S: Supported
 F: docs/qdev-device-use.txt
@@ -3620,7 +3866,9 @@ T: git https://repo.or.cz/qemu/armbru.git qapi-next
 
 qtest
 M: Fabiano Rosas <farosas@suse.de>
+G: @farosas
 M: Laurent Vivier <lvivier@redhat.com>
+G: @lvivier
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: system/qtest.c
@@ -3642,6 +3890,7 @@ F: tests/qtest/libqos/qos-intel-iommu*
 
 Device Fuzzing
 M: Alexander Bulekov <alxndr@bu.edu>
+G: @a1xndr
 R: Paolo Bonzini <pbonzini@redhat.com>
 R: Stefan Hajnoczi <stefanha@redhat.com>
 R: Fabiano Rosas <farosas@suse.de>
@@ -3656,6 +3905,7 @@ F: docs/devel/testing/fuzzing.rst
 
 Register API
 M: Alistair Francis <alistair@alistair23.me>
+G: @alistair23
 S: Maintained
 F: hw/core/register.c
 F: include/hw/core/register.h
@@ -3663,6 +3913,7 @@ F: include/hw/core/registerfields.h
 
 Rust
 M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+G: @epilys
 S: Maintained
 F: rust/bql/
 F: rust/chardev/
@@ -3703,11 +3954,13 @@ F: include/hw/core/stream.h
 
 Stubs
 M: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 S: Maintained
 F: stubs/
 
 Tracing
 M: Stefan Hajnoczi <stefanha@redhat.com>
+G: @stefanha
 S: Maintained
 F: trace/
 F: trace-events
@@ -3728,6 +3981,7 @@ F: scripts/simpletrace.py
 
 TPM
 M: Stefan Berger <stefanb@linux.ibm.com>
+G: @stefanberger
 S: Maintained
 F: system/tpm*
 F: hw/tpm/*
@@ -3741,6 +3995,7 @@ T: git https://github.com/stefanberger/qemu-tpm.git tpm-next
 
 SPDM, PCIe DOE
 M: Alistair Francis <alistair.francis@wdc.com>
+G: @alistair23
 R: Tao Tang <tangtao1634@phytium.com.cn>
 S: Maintained
 F: backends/spdm-socket.c
@@ -3757,6 +4012,7 @@ F: scripts/checkpatch.pl
 Migration
 M: Peter Xu <peterx@redhat.com>
 M: Fabiano Rosas <farosas@suse.de>
+G: @farosas
 S: Maintained
 F: hw/core/vmstate-if.c
 F: include/hw/core/vmstate-if.h
@@ -3779,6 +4035,7 @@ F: util/userfaultfd.c
 RDMA Migration
 M: Peter Xu <peterx@redhat.com>
 M: Fabiano Rosas <farosas@suse.de>
+G: @farosas
 R: Li Zhijian <lizhijian@fujitsu.com>
 S: Odd Fixes
 F: migration/rdma*
@@ -3802,6 +4059,7 @@ F: docs/devel/luks-detached-header.rst
 
 D-Bus
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
+G: @marcandre.lureau-rh
 S: Maintained
 F: backends/dbus-vmstate.c
 F: ui/dbus*
@@ -3817,6 +4075,7 @@ F: scripts/xml-preprocess*
 
 Seccomp
 M: Daniel P. Berrange <berrange@redhat.com>
+G: @berrange
 S: Odd Fixes
 F: system/qemu-seccomp.c
 F: include/system/seccomp.h
@@ -3824,6 +4083,7 @@ F: tests/unit/test-seccomp.c
 
 Cryptography
 M: Daniel P. Berrange <berrange@redhat.com>
+G: @berrange
 S: Maintained
 F: crypto/
 F: include/crypto/
@@ -3837,7 +4097,9 @@ F: qemu.sasl
 
 Coroutines
 M: Stefan Hajnoczi <stefanha@redhat.com>
+G: @stefanha
 M: Kevin Wolf <kwolf@redhat.com>
+G: @kmwolf
 S: Maintained
 F: util/*coroutine*
 F: include/qemu/coroutine*
@@ -3845,12 +4107,14 @@ F: tests/unit/test-coroutine.c
 
 Buffers
 M: Daniel P. Berrange <berrange@redhat.com>
+G: @berrange
 S: Odd Fixes
 F: util/buffer.c
 F: include/qemu/buffer.h
 
 I/O Channels
 M: Daniel P. Berrange <berrange@redhat.com>
+G: @berrange
 S: Maintained
 F: io/
 F: include/io/
@@ -3858,6 +4122,7 @@ F: tests/unit/test-io-*
 
 User authorization
 M: Daniel P. Berrange <berrange@redhat.com>
+G: @berrange
 S: Maintained
 F: authz/
 F: qapi/authz.json
@@ -3866,6 +4131,7 @@ F: tests/unit/test-authz-*
 
 Sockets
 M: Daniel P. Berrange <berrange@redhat.com>
+G: @berrange
 S: Maintained
 F: include/qemu/sockets.h
 F: util/qemu-sockets.c
@@ -3873,6 +4139,7 @@ F: qapi/sockets.json
 
 File monitor
 M: Daniel P. Berrange <berrange@redhat.com>
+G: @berrange
 S: Odd Fixes
 F: util/filemonitor*.c
 F: include/qemu/filemonitor.h
@@ -3891,6 +4158,7 @@ L: qemu-block@nongnu.org
 
 UUID
 M: Fam Zheng <fam@euphon.net>
+G: @famzheng
 S: Supported
 F: util/uuid.c
 F: include/qemu/uuid.h
@@ -3958,6 +4226,7 @@ F: contrib/elf2dmp/
 
 Overall sensors
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 S: Odd Fixes
 F: hw/sensor
 F: include/hw/sensor
@@ -3977,6 +4246,7 @@ F: include/hw/i2c/smbus_eeprom.h
 I3C
 M: Joe Komlodi <komlodi@google.com>
 M: Cédric Le Goater <clg@kaod.org>
+G: @clegoate
 M: Jamin Lin <jamin_lin@aspeedtech.com>
 R: Nabih Estefan <nabihestefan@google.com>
 S: Maintained
@@ -4017,6 +4287,7 @@ F: docs/interop/firmware.json
 
 EDK2 Firmware
 M: Gerd Hoffmann <kraxel@redhat.com>
+G: @kraxel
 S: Supported
 F: hw/i386/*ovmf*
 F: pc-bios/descriptors/??-edk2-*.json
@@ -4028,7 +4299,9 @@ F: tests/uefi-test-tools/
 
 IGVM Firmware
 M: Gerd Hoffmann <kraxel@redhat.com>
+G: @kraxel
 M: Stefano Garzarella <sgarzare@redhat.com>
+G: @sgarzarella
 R: Ani Sinha <anisinha@redhat.com>
 S: Maintained
 F: backends/igvm*.c
@@ -4039,6 +4312,7 @@ F: target/i386/igvm.c
 
 VT-d Emulation
 M: Michael S. Tsirkin <mst@redhat.com>
+G: @mstredhat
 R: Jason Wang <jasowang@redhat.com>
 R: Yi Liu <yi.l.liu@intel.com>
 R: Clément Mathieu--Drif <clement.mathieu--drif@bull.com>
@@ -4060,6 +4334,7 @@ F: tests/qtest/amd-iommu-test.c
 
 OpenSBI Firmware
 M: Alistair Francis <Alistair.Francis@wdc.com>
+G: @alistair23
 R: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
 L: qemu-riscv@nongnu.org
 S: Supported
@@ -4079,6 +4354,7 @@ F: docs/devel/clocks.rst
 
 Reset framework
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 S: Maintained
 F: include/hw/core/resettable.h
 F: include/hw/core/resetcontainer.h
@@ -4098,6 +4374,7 @@ F: common-user/
 
 BSD user
 M: Warner Losh <imp@bsdimp.com>
+G: @bsdimp
 R: Kyle Evans <kevans@freebsd.org>
 S: Odd Fixes
 F: bsd-user/
@@ -4107,7 +4384,9 @@ T: git https://github.com/qemu-bsd-user/qemu-bsd-user bsd-user-rebase-3.1
 
 Linux user
 M: Laurent Vivier <laurent@vivier.eu>
+G: @lvivier
 M: Helge Deller <deller@gmx.de>
+G: @hdeller
 R: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Odd Fixes
 F: linux-user/
@@ -4121,13 +4400,16 @@ Tiny Code Generator (TCG)
 -------------------------
 Common TCG code
 M: Richard Henderson <richard.henderson@linaro.org>
+G: @rth7680
 S: Maintained
 F: tcg/
 F: include/tcg/
 
 TCG Plugins
 M: Alex Bennée <alex.bennee@linaro.org>
+G: @stsquad
 M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
+G: @pierrick.bouvier
 T: git https://gitlab.com/stsquad/qemu plugins/next
 R: Alexandre Iooss <erdnaxe@crans.org>
 S: Maintained
@@ -4141,12 +4423,14 @@ F: scripts/qemu-plugin-symbols.py
 
 AArch64 TCG target
 M: Richard Henderson <richard.henderson@linaro.org>
+G: @rth7680
 S: Maintained
 L: qemu-arm@nongnu.org
 F: tcg/aarch64/
 
 X86 TCG target
 M: Richard Henderson <richard.henderson@linaro.org>
+G: @rth7680
 S: Maintained
 F: tcg/x86_64/
 
@@ -4157,12 +4441,14 @@ F: tcg/loongarch64/
 
 PPC TCG target
 M: Richard Henderson <richard.henderson@linaro.org>
+G: @rth7680
 S: Odd Fixes
 F: tcg/ppc64/
 
 RISC-V TCG target
 M: Palmer Dabbelt <palmer@dabbelt.com>
 M: Alistair Francis <Alistair.Francis@wdc.com>
+G: @alistair23
 R: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
@@ -4171,6 +4457,7 @@ F: disas/riscv*.[ch]
 
 S390 TCG target
 M: Richard Henderson <richard.henderson@linaro.org>
+G: @rth7680
 S: Maintained
 F: tcg/s390x/
 L: qemu-s390x@nongnu.org
@@ -4182,6 +4469,7 @@ F: disas/sparc.c
 
 TCI TCG target
 M: Stefan Weil <sw@weilnetz.de>
+G: @stweil
 S: Maintained
 F: tcg/tci/
 F: tcg/tci.c
@@ -4190,6 +4478,7 @@ Block drivers
 -------------
 VMDK
 M: Fam Zheng <fam@euphon.net>
+G: @famzheng
 L: qemu-block@nongnu.org
 S: Supported
 F: block/vmdk.c
@@ -4208,18 +4497,21 @@ F: block/vhdx*
 
 VDI
 M: Stefan Weil <sw@weilnetz.de>
+G: @stweil
 L: qemu-block@nongnu.org
 S: Maintained
 F: block/vdi.c
 
 blkio
 M: Stefan Hajnoczi <stefanha@redhat.com>
+G: @stefanha
 L: qemu-block@nongnu.org
 S: Maintained
 F: block/blkio.c
 
 iSCSI
 M: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 M: Peter Lieven <pl@dlhnet.de>
 L: qemu-block@nongnu.org
 S: Odd Fixes
@@ -4228,7 +4520,9 @@ F: block/iscsi-opts.c
 
 Network Block Device (NBD)
 M: Eric Blake <eblake@redhat.com>
+G: @ebblake
 M: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
+G: @vsementsov
 L: qemu-block@nongnu.org
 S: Maintained
 F: block/nbd*
@@ -4261,12 +4555,14 @@ F: block/curl.c
 
 Null Block Driver
 M: Fam Zheng <fam@euphon.net>
+G: @famzheng
 L: qemu-block@nongnu.org
 S: Supported
 F: block/null.c
 
 NVMe Block Driver
 M: Stefan Hajnoczi <stefanha@redhat.com>
+G: @stefanha
 R: Fam Zheng <fam@euphon.net>
 L: qemu-block@nongnu.org
 S: Supported
@@ -4293,6 +4589,7 @@ F: block/blklogwrites.c
 
 blkverify
 M: Stefan Hajnoczi <stefanha@redhat.com>
+G: @stefanha
 L: qemu-block@nongnu.org
 S: Supported
 F: block/blkverify.c
@@ -4300,24 +4597,28 @@ F: docs/devel/testing/blkverify.rst
 
 bochs
 M: Stefan Hajnoczi <stefanha@redhat.com>
+G: @stefanha
 L: qemu-block@nongnu.org
 S: Supported
 F: block/bochs.c
 
 cloop
 M: Stefan Hajnoczi <stefanha@redhat.com>
+G: @stefanha
 L: qemu-block@nongnu.org
 S: Supported
 F: block/cloop.c
 
 dmg
 M: Stefan Hajnoczi <stefanha@redhat.com>
+G: @stefanha
 L: qemu-block@nongnu.org
 S: Supported
 F: block/dmg.c
 
 parallels
 M: Stefan Hajnoczi <stefanha@redhat.com>
+G: @stefanha
 M: Denis V. Lunev <den@openvz.org>
 L: qemu-block@nongnu.org
 S: Supported
@@ -4329,6 +4630,7 @@ T: git https://src.openvz.org/scm/~den/qemu.git parallels
 
 qed
 M: Stefan Hajnoczi <stefanha@redhat.com>
+G: @stefanha
 L: qemu-block@nongnu.org
 S: Supported
 F: block/qed.c
@@ -4336,6 +4638,7 @@ F: docs/interop/qed_spec.rst
 
 raw
 M: Kevin Wolf <kwolf@redhat.com>
+G: @kmwolf
 L: qemu-block@nongnu.org
 S: Supported
 F: block/linux-aio.c
@@ -4347,6 +4650,7 @@ F: block/win32-aio.c
 
 Linux io_uring
 M: Stefan Hajnoczi <stefanha@redhat.com>
+G: @stefanha
 R: Stefano Garzarella <sgarzare@redhat.com>
 L: qemu-block@nongnu.org
 S: Maintained
@@ -4354,7 +4658,9 @@ F: block/io_uring.c
 
 qcow2
 M: Kevin Wolf <kwolf@redhat.com>
+G: @kmwolf
 M: Hanna Reitz <hreitz@redhat.com>
+G: @hreitz
 L: qemu-block@nongnu.org
 S: Supported
 F: block/qcow2*
@@ -4362,13 +4668,16 @@ F: docs/interop/qcow2.rst
 
 qcow
 M: Kevin Wolf <kwolf@redhat.com>
+G: @kmwolf
 L: qemu-block@nongnu.org
 S: Supported
 F: block/qcow.c
 
 blkdebug
 M: Kevin Wolf <kwolf@redhat.com>
+G: @kmwolf
 M: Hanna Reitz <hreitz@redhat.com>
+G: @hreitz
 L: qemu-block@nongnu.org
 S: Supported
 F: block/blkdebug.c
@@ -4376,18 +4685,21 @@ F: docs/devel/testing/blkdebug.rst
 
 vpc
 M: Kevin Wolf <kwolf@redhat.com>
+G: @kmwolf
 L: qemu-block@nongnu.org
 S: Supported
 F: block/vpc.c
 
 vvfat
 M: Kevin Wolf <kwolf@redhat.com>
+G: @kmwolf
 L: qemu-block@nongnu.org
 S: Odd Fixes
 F: block/vvfat.c
 
 Image format fuzzer
 M: Stefan Hajnoczi <stefanha@redhat.com>
+G: @stefanha
 L: qemu-block@nongnu.org
 S: Supported
 F: tests/image-fuzzer/
@@ -4406,6 +4718,7 @@ F: util/vhost-user-server.c
 
 FUSE block device exports
 M: Hanna Reitz <hreitz@redhat.com>
+G: @hreitz
 L: qemu-block@nongnu.org
 S: Supported
 F: block/export/fuse.c
@@ -4427,6 +4740,7 @@ F: docs/block-replication.txt
 
 Semihosting
 M: Alex Bennée <alex.bennee@linaro.org>
+G: @stsquad
 S: Maintained
 F: semihosting/
 F: include/semihosting/
@@ -4466,6 +4780,7 @@ VFIO-USER
 M: John Levon <john.levon@nutanix.com>
 M: Thanos Makatos <thanos.makatos@nutanix.com>
 M: Cédric Le Goater <clg@redhat.com>
+G: @clegoate
 S: Supported
 F: docs/interop/vfio-user.rst
 F: docs/system/devices/vfio-user.rst
@@ -4475,6 +4790,7 @@ F: tests/functional/x86_64/test_vfio_user_client.py
 
 EBPF
 M: Jason Wang <jasowang@redhat.com>
+G: @jasowang
 R: Yuri Benditovich <ybendito@redhat.com>
 S: Maintained
 F: docs/devel/ebpf_rss.rst
@@ -4485,8 +4801,10 @@ Build and test automation
 -------------------------
 Build and test automation, general continuous integration
 M: Alex Bennée <alex.bennee@linaro.org>
+G: @stsquad
 T: git https://gitlab.com/stsquad/qemu testing/next
 M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
+G: @pierrick.bouvier
 S: Maintained
 F: .github/workflows/lockdown.yml
 F: .gitlab-ci.yml
@@ -4511,6 +4829,7 @@ F: tests/vm/freebsd
 
 Functional testing framework
 M: Thomas Huth <th.huth+qemu@posteo.eu>
+G: @thuth
 R: Philippe Mathieu-Daudé <philmd@mailo.com>
 R: Daniel P. Berrange <berrange@redhat.com>
 S: Odd Fixes
@@ -4529,11 +4848,13 @@ F: .gitlab-ci.d/windows.yml
 
 Guest Test Compilation Support
 M: Alex Bennée <alex.bennee@linaro.org>
+G: @stsquad
 S: Maintained
 F: tests/tcg/Makefile.target
 
 GitLab custom runners (HW sponsored by Linaro, OSUOSL and IBM)
 M: Alex Bennée <alex.bennee@linaro.org>
+G: @stsquad
 S: Maintained
 F: .gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
 F: .gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
@@ -4543,11 +4864,13 @@ Documentation
 -------------
 Build system architecture
 M: Daniel P. Berrange <berrange@redhat.com>
+G: @berrange
 S: Odd Fixes
 F: docs/devel/build-system.rst
 
 GIT Data Mining Config
 M: Alex Bennée <alex.bennee@linaro.org>
+G: @stsquad
 S: Odd Fixes
 F: gitdm.config
 F: contrib/gitdm/*
@@ -4558,6 +4881,7 @@ F: docs/about/deprecated.rst
 
 General Documentation
 M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
+G: @pierrick.bouvier
 S: Maintained
 F: docs/
 
@@ -4565,6 +4889,7 @@ Build System
 ------------
 Meson
 M: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 R: Marc-André Lureau <marcandre.lureau@redhat.com>
 R: Daniel P. Berrange <berrange@redhat.com>
 R: Philippe Mathieu-Daudé <philmd@mailo.com>
@@ -4578,6 +4903,7 @@ F: scripts/symlink-install-tree.py
 
 Top Level Makefile and configure
 M: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 R: Alex Bennée <alex.bennee@linaro.org>
 S: Maintained
 F: Makefile
@@ -4590,6 +4916,7 @@ F: tests/Makefile.include
 
 Kconfig
 M: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 S: Maintained
 F: scripts/minikconf.py
 F: docs/devel/kconfig.rst
@@ -4600,6 +4927,7 @@ F: target/*/Kconfig*
 
 GIT submodules
 M: Daniel P. Berrange <berrange@redhat.com>
+G: @berrange
 S: Odd Fixes
 F: scripts/git-submodule.sh
 
@@ -4609,7 +4937,9 @@ F: po/*.po
 
 Sphinx documentation configuration and build machinery
 M: John Snow <jsnow@redhat.com>
+G: @jsnow
 M: Peter Maydell <peter.maydell@linaro.org>
+G: @pm215
 M: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
 S: Maintained
 F: docs/conf.py
@@ -4622,6 +4952,7 @@ F: scripts/lib/kdoc/
 
 Rust build system integration
 M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+G: @epilys
 L: qemu-rust@nongnu.org
 S: Maintained
 F: scripts/rust/
@@ -4638,6 +4969,7 @@ F: scripts/performance/
 
 Code Coverage Tools
 M: Alex Bennée <alex.bennee@linaro.org>
+G: @stsquad
 S: Odd Fixes
 F: scripts/coverage/
 
-- 
2.54.0


