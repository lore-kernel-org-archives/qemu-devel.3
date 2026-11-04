Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ABD606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=W9BRdxF8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOasl-0006z3-JA; Wed, 04 Nov 2026 08:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xOasj-0006yV-RL
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 08:18:25 -0500
Received: from out-231.mta1.migadu.com ([95.215.58.231] helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xOash-0002wv-Ne
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 08:18:25 -0500
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=/Zbc206y+Wwx6FSLQLyyZoAsYFqMOX7ooxL5fONOWAU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793798301; v=1; x=1794403101;
 b=W9BRdxF8q2yEjKxFQiTNr7NIwjxgYDvqurPfiersFnSTXM+dXRxV2YBPbfFzmTX64ChU0YVI
 0oD4FCVKJe1cvC+fNmOzradD74zUWn5DnIwsWS9h0X2xz9AEct23gXqvsOkDqCLDVJOw75zQ0iu
 Q0X3TH5UWvlXvA1k100OB2TQ=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id ca093861ca1722df;
 Wed, 04 Nov 2026 13:18:21 +0000
X-Mizu-Trace-ID: ca093861ca1722df
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 zhao1.liu@intel.com, richard.henderson@linaro.org, farosas@suse.de,
 lvivier@redhat.com, pierrick.bouvier@oss.qualcomm.com, thuth@redhat.com,
 peter.maydell@linaro.org, kraxel@redhat.com, berrange@redhat.com,
 marcandre.lureau@redhat.com, deller@gmx.de, clg@redhat.com,
 jamin_lin@aspeedtech.com, junjie.cao@linux.dev
Subject: [RFC PATCH 1/4] hw/i386: add 12.0 machine types (NOT FOR MERGE)
Date: Wed,  4 Nov 2026 07:18:07 -0600
Message-ID: <20261104131810.2063834-2-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104131810.2063834-1-junjie.cao@linux.dev>
References: <20261104131810.2063834-1-junjie.cao@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.215.58.231; envelope-from=junjie.cao@linux.dev;
 helo=mta1.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Placeholder for the rest of the series, which changes a default on
the next machine version. The real "hw: add compat machines for 12.0"
covers every versioned board; this only adds pc-i440fx-12.0 and
pc-q35-12.0. Drop it once that commit lands.

Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
---
 hw/core/machine.c        |  3 +++
 hw/i386/pc.c             |  3 +++
 hw/i386/pc_piix.c        | 13 +++++++++++--
 hw/i386/pc_q35.c         | 13 +++++++++++--
 include/hw/core/boards.h |  3 +++
 include/hw/i386/pc.h     |  3 +++
 6 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index ed9bf8f500..5305521ac5 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -41,6 +41,9 @@
 #include "qemu/audio.h"
 #include "hw/arm/smmuv3.h"
 
+GlobalProperty hw_compat_11_2[] = {};
+const size_t hw_compat_11_2_len = G_N_ELEMENTS(hw_compat_11_2);
+
 GlobalProperty hw_compat_11_1[] = {
     { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
     { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4737eb471c..8a6b7978cc 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -75,6 +75,9 @@
 #include "hw/xen/xen-bus.h"
 #endif
 
+GlobalProperty pc_compat_11_2[] = {};
+const size_t pc_compat_11_2_len = G_N_ELEMENTS(pc_compat_11_2);
+
 GlobalProperty pc_compat_11_1[] = {};
 const size_t pc_compat_11_1_len = G_N_ELEMENTS(pc_compat_11_1);
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 446590e4e5..c0ddf6011f 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -397,12 +397,21 @@ static void pc_i440fx_machine_options(MachineClass *m)
                      pc_piix_compat_defaults, pc_piix_compat_defaults_len);
 }
 
-static void pc_i440fx_machine_11_2_options(MachineClass *m)
+static void pc_i440fx_machine_12_0_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
 }
 
-DEFINE_I440FX_MACHINE_AS_LATEST(11, 2);
+DEFINE_I440FX_MACHINE_AS_LATEST(12, 0);
+
+static void pc_i440fx_machine_11_2_options(MachineClass *m)
+{
+    pc_i440fx_machine_12_0_options(m);
+    compat_props_add(m->compat_props, hw_compat_11_2, hw_compat_11_2_len);
+    compat_props_add(m->compat_props, pc_compat_11_2, pc_compat_11_2_len);
+}
+
+DEFINE_I440FX_MACHINE(11, 2);
 
 static void pc_i440fx_machine_11_1_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index c3ce9c5649..e302ff283c 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -378,12 +378,21 @@ static void pc_q35_machine_options(MachineClass *m)
                      pc_q35_compat_defaults, pc_q35_compat_defaults_len);
 }
 
-static void pc_q35_machine_11_2_options(MachineClass *m)
+static void pc_q35_machine_12_0_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
 }
 
-DEFINE_Q35_MACHINE_AS_LATEST(11, 2);
+DEFINE_Q35_MACHINE_AS_LATEST(12, 0);
+
+static void pc_q35_machine_11_2_options(MachineClass *m)
+{
+    pc_q35_machine_12_0_options(m);
+    compat_props_add(m->compat_props, hw_compat_11_2, hw_compat_11_2_len);
+    compat_props_add(m->compat_props, pc_compat_11_2, pc_compat_11_2_len);
+}
+
+DEFINE_Q35_MACHINE(11, 2);
 
 static void pc_q35_machine_11_1_options(MachineClass *m)
 {
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index d0e4ad9820..2f2327079c 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -830,6 +830,9 @@ compat_props_add(GPtrArray *arr,
     }
 }
 
+extern GlobalProperty hw_compat_11_2[];
+extern const size_t hw_compat_11_2_len;
+
 extern GlobalProperty hw_compat_11_1[];
 extern const size_t hw_compat_11_1_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 844ae83578..caceddc74b 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -214,6 +214,9 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
 /* sgx.c */
 void pc_machine_init_sgx_epc(PCMachineState *pcms);
 
+extern GlobalProperty pc_compat_11_2[];
+extern const size_t pc_compat_11_2_len;
+
 extern GlobalProperty pc_compat_11_1[];
 extern const size_t pc_compat_11_1_len;
 
-- 
2.43.0


