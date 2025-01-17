Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094A1C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 10:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYja6-0001lF-OS; Fri, 17 Jan 2025 05:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYja4-0001l1-IV
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:28:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYja2-0004Dw-Pj
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737109676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kXREVQWRfWvPG+1pz3PjgO6y13c3igHha+JKYFKoeCg=;
 b=Ynzz4YS6GsFQcoMfb9cKW+oD9z8LdKPGVUESdCyMBeXHXLk1oSCiWNOMBLfpODO+nnbcLk
 kYBICqK29qZtvy6uSXIrePfeN4407xhOAVM9NPrTYe5P4yDxLPOvPl5WH8s/aEVMTc9AkQ
 IoEfHmqw/KYu666PDUyBhdb+HO3zC1w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-AgBjaq2tNZyOi8X1i12QiQ-1; Fri,
 17 Jan 2025 05:27:55 -0500
X-MC-Unique: AgBjaq2tNZyOi8X1i12QiQ-1
X-Mimecast-MFC-AGG-ID: AgBjaq2tNZyOi8X1i12QiQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FB5D1955DCC; Fri, 17 Jan 2025 10:27:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.246])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 28389195E3D9; Fri, 17 Jan 2025 10:27:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 2/3] hw/i386/pc_piix: Remove pc-i440fx-2.4 up to pc-i440fx-2.12
Date: Fri, 17 Jan 2025 11:27:37 +0100
Message-ID: <20250117102738.59714-3-thuth@redhat.com>
In-Reply-To: <20250117102738.59714-1-thuth@redhat.com>
References: <20250117102738.59714-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

These machines have explicitly been marked as deprecated in
QEMU 9.1, so it should be fine to remove these antique versioned
machine types two releases later in 10.0.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst       |  7 ---
 docs/about/removed-features.rst |  4 +-
 docs/interop/firmware.json      |  2 +-
 hw/i386/pc_piix.c               | 95 ---------------------------------
 qemu-options.hx                 | 10 ++--
 5 files changed, 8 insertions(+), 110 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 4a3c302962..7b42d6eecc 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -236,13 +236,6 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
-``pc-i440fx-2.4`` up to ``pc-i440fx-2.12`` (since 9.1)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-These old machine types are quite neglected nowadays and thus might have
-various pitfalls with regards to live migration. Use a newer machine type
-instead.
-
 PPC 405 ``ref405ep`` machine (since 9.1)
 ''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index c6616ce05e..936846ed7b 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1006,8 +1006,8 @@ mips ``fulong2e`` machine alias (removed in 6.0)
 
 This machine has been renamed ``fuloong2e``.
 
-``pc-0.10`` up to ``pc-i440fx-2.3`` (removed in 4.0 up to 9.0)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+``pc-0.10`` up to ``pc-i440fx-2.12`` (removed in 4.0 up to 10.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These machine types were very old and likely could not be used for live
 migration from old QEMU versions anymore. Use a newer machine type instead.
diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 57f55f6c54..f1e74318ff 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -97,7 +97,7 @@
 #            machine types, not aliases. Glob patterns are understood,
 #            which is especially useful for versioned machine types.
 #            (For example, the glob pattern "pc-i440fx-*" matches
-#            "pc-i440fx-2.12".) On the QEMU command line, "-machine
+#            "pc-i440fx-9.1".) On the QEMU command line, "-machine
 #            type=..." specifies the requested machine type (but that
 #            option does not accept glob patterns).
 #
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 04d2957adc..b821c32b38 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -698,101 +698,6 @@ static void pc_i440fx_machine_3_0_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(3, 0);
 
-static void pc_i440fx_machine_2_12_options(MachineClass *m)
-{
-    pc_i440fx_machine_3_0_options(m);
-    compat_props_add(m->compat_props, hw_compat_2_12, hw_compat_2_12_len);
-    compat_props_add(m->compat_props, pc_compat_2_12, pc_compat_2_12_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 12);
-
-static void pc_i440fx_machine_2_11_options(MachineClass *m)
-{
-    pc_i440fx_machine_2_12_options(m);
-    compat_props_add(m->compat_props, hw_compat_2_11, hw_compat_2_11_len);
-    compat_props_add(m->compat_props, pc_compat_2_11, pc_compat_2_11_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 11);
-
-static void pc_i440fx_machine_2_10_options(MachineClass *m)
-{
-    pc_i440fx_machine_2_11_options(m);
-    compat_props_add(m->compat_props, hw_compat_2_10, hw_compat_2_10_len);
-    compat_props_add(m->compat_props, pc_compat_2_10, pc_compat_2_10_len);
-    m->auto_enable_numa_with_memhp = false;
-}
-
-DEFINE_I440FX_MACHINE(2, 10);
-
-static void pc_i440fx_machine_2_9_options(MachineClass *m)
-{
-    pc_i440fx_machine_2_10_options(m);
-    compat_props_add(m->compat_props, hw_compat_2_9, hw_compat_2_9_len);
-    compat_props_add(m->compat_props, pc_compat_2_9, pc_compat_2_9_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 9);
-
-static void pc_i440fx_machine_2_8_options(MachineClass *m)
-{
-    pc_i440fx_machine_2_9_options(m);
-    compat_props_add(m->compat_props, hw_compat_2_8, hw_compat_2_8_len);
-    compat_props_add(m->compat_props, pc_compat_2_8, pc_compat_2_8_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 8);
-
-static void pc_i440fx_machine_2_7_options(MachineClass *m)
-{
-    pc_i440fx_machine_2_8_options(m);
-    compat_props_add(m->compat_props, hw_compat_2_7, hw_compat_2_7_len);
-    compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 7);
-
-static void pc_i440fx_machine_2_6_options(MachineClass *m)
-{
-    X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_i440fx_machine_2_7_options(m);
-    pcmc->legacy_cpu_hotplug = true;
-    x86mc->fwcfg_dma_enabled = false;
-    compat_props_add(m->compat_props, hw_compat_2_6, hw_compat_2_6_len);
-    compat_props_add(m->compat_props, pc_compat_2_6, pc_compat_2_6_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 6);
-
-static void pc_i440fx_machine_2_5_options(MachineClass *m)
-{
-    X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
-
-    pc_i440fx_machine_2_6_options(m);
-    x86mc->save_tsc_khz = false;
-    m->legacy_fw_cfg_order = 1;
-    compat_props_add(m->compat_props, hw_compat_2_5, hw_compat_2_5_len);
-    compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 5);
-
-static void pc_i440fx_machine_2_4_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_i440fx_machine_2_5_options(m);
-    m->hw_version = "2.4.0";
-    pcmc->broken_reserved_end = true;
-    compat_props_add(m->compat_props, hw_compat_2_4, hw_compat_2_4_len);
-    compat_props_add(m->compat_props, pc_compat_2_4, pc_compat_2_4_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 4);
-
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
diff --git a/qemu-options.hx b/qemu-options.hx
index 7090d59f6f..a7cc4894f6 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -48,12 +48,12 @@ SRST
 
     For architectures which aim to support live migration compatibility
     across releases, each release will introduce a new versioned machine
-    type. For example, the 2.8.0 release introduced machine types
-    "pc-i440fx-2.8" and "pc-q35-2.8" for the x86\_64/i686 architectures.
+    type. For example, the 9.1.0 release introduced machine types
+    "pc-i440fx-9.1" and "pc-q35-9.1" for the x86\_64/i686 architectures.
 
-    To allow live migration of guests from QEMU version 2.8.0, to QEMU
-    version 2.9.0, the 2.9.0 version must support the "pc-i440fx-2.8"
-    and "pc-q35-2.8" machines too. To allow users live migrating VMs to
+    To allow live migration of guests from QEMU version 9.1.0 to QEMU
+    version 9.2.0, the 9.2.0 version must support the "pc-i440fx-9.1"
+    and "pc-q35-9.1" machines too. To allow users live migrating VMs to
     skip multiple intermediate releases when upgrading, new releases of
     QEMU will support machine types from many previous versions.
 
-- 
2.47.1


