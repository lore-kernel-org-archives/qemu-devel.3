Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E766C54E92
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 06:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHdCe-00081E-29; Wed, 21 May 2025 02:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHdCc-00080m-1C
 for qemu-devel@nongnu.org; Wed, 21 May 2025 02:45:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHdCY-0002tV-K9
 for qemu-devel@nongnu.org; Wed, 21 May 2025 02:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747809916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mHhT9S4K1+02q2Ywqd5e0WcxwVvSkP/FFPQW+c64P6g=;
 b=Cr2u1Uq2ODWbzu526m20wT2K1NdTsqS+r60uwlPewXRQ6ySp42A18wQhGb7IYPjlA6dDNl
 F5wT37acJCseETlyHzfl0b708fMEVwzAQqn81bcw1T96haO08Ykh9WsVZhcHCm51RTzG6P
 NRDNEcUw2hhUXvZ26Qy9DQIiOxqOOc4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-XHla4wP-PjiXJvadeU80kA-1; Wed,
 21 May 2025 02:45:14 -0400
X-MC-Unique: XHla4wP-PjiXJvadeU80kA-1
X-Mimecast-MFC-AGG-ID: XHla4wP-PjiXJvadeU80kA_1747809914
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5B161954236; Wed, 21 May 2025 06:45:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 022FD19560A3; Wed, 21 May 2025 06:45:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A2D4B21E65DA; Wed, 21 May 2025 08:37:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org
Subject: [PATCH 4/4] docs/about/removed-features: Move removal notes to tidy
 up order
Date: Wed, 21 May 2025 08:37:11 +0200
Message-ID: <20250521063711.29840-5-armbru@redhat.com>
In-Reply-To: <20250521063711.29840-1-armbru@redhat.com>
References: <20250521063711.29840-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The removal notes within a section are mostly in version order.  Move
the few that aren't so they are.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/about/removed-features.rst | 60 ++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 92b5ba6218..4819cb4665 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -162,6 +162,12 @@ specified with ``-mem-path`` can actually provide the guest RAM configured with
 The ``name`` parameter of the ``-net`` option was a synonym
 for the ``id`` parameter, which should now be used instead.
 
+RISC-V firmware not booted by default (removed in 5.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+QEMU 5.1 changes the default behaviour from ``-bios none`` to ``-bios default``
+for the RISC-V ``virt`` machine and ``sifive_u`` machine.
+
 ``-numa node,mem=...`` (removed in 5.1)
 '''''''''''''''''''''''''''''''''''''''
 
@@ -324,12 +330,6 @@ devices.  Drives the board doesn't pick up can no longer be used with
 This option was undocumented and not used in the field.
 Use ``-device usb-ccid`` instead.
 
-RISC-V firmware not booted by default (removed in 5.1)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-QEMU 5.1 changes the default behaviour from ``-bios none`` to ``-bios default``
-for the RISC-V ``virt`` machine and ``sifive_u`` machine.
-
 ``-no-quit`` (removed in 7.0)
 '''''''''''''''''''''''''''''
 
@@ -911,14 +911,6 @@ The RISC-V no MMU cpus have been removed. The two CPUs: ``rv32imacu-nommu`` and
 ``rv64imacu-nommu`` can no longer be used. Instead the MMU status can be specified
 via the CPU ``mmu`` option when using the ``rv32`` or ``rv64`` CPUs.
 
-RISC-V 'any' CPU type ``-cpu any`` (removed in 9.2)
-'''''''''''''''''''''''''''''''''''''''''''''''''''
-
-The 'any' CPU type was introduced back in 2018 and was around since the
-initial RISC-V QEMU port. Its usage was always been unclear: users don't know
-what to expect from a CPU called 'any', and in fact the CPU does not do anything
-special that isn't already done by the default CPUs rv32/rv64.
-
 ``compat`` property of server class POWER CPUs (removed in 6.0)
 '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
@@ -965,6 +957,14 @@ The CRIS architecture was pulled from Linux in 4.17 and the compiler
 was no longer packaged in any distro making it harder to run the
 ``check-tcg`` tests.
 
+RISC-V 'any' CPU type ``-cpu any`` (removed in 9.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The 'any' CPU type was introduced back in 2018 and was around since the
+initial RISC-V QEMU port. Its usage was always been unclear: users don't know
+what to expect from a CPU called 'any', and in fact the CPU does not do anything
+special that isn't already done by the default CPUs rv32/rv64.
+
 System accelerators
 -------------------
 
@@ -975,18 +975,18 @@ Userspace local APIC with KVM (x86, removed in 8.0)
 a local APIC.  The ``split`` setting is supported, as is using ``-M
 kernel-irqchip=off`` when the CPU does not have a local APIC.
 
-HAXM (``-accel hax``) (removed in 8.2)
-''''''''''''''''''''''''''''''''''''''
-
-The HAXM project has been retired (see https://github.com/intel/haxm#status).
-Use "whpx" (on Windows) or "hvf" (on macOS) instead.
-
 MIPS "Trap-and-Emulate" KVM support (removed in 8.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 The MIPS "Trap-and-Emulate" KVM host and guest support was removed
 from Linux in 2021, and is not supported anymore by QEMU either.
 
+HAXM (``-accel hax``) (removed in 8.2)
+''''''''''''''''''''''''''''''''''''''
+
+The HAXM project has been retired (see https://github.com/intel/haxm#status).
+Use "whpx" (on Windows) or "hvf" (on macOS) instead.
+
 System emulator machines
 ------------------------
 
@@ -1044,16 +1044,6 @@ Aspeed ``swift-bmc`` machine (removed in 7.0)
 This machine was removed because it was unused. Alternative AST2500 based
 OpenPOWER machines are ``witherspoon-bmc`` and ``romulus-bmc``.
 
-Aspeed ``tacoma-bmc`` machine (removed in 10.0)
-'''''''''''''''''''''''''''''''''''''''''''''''
-
-The ``tacoma-bmc`` machine was removed because it didn't bring much
-compared to the ``rainier-bmc`` machine. Also, the ``tacoma-bmc`` was
-a board used for bring up of the AST2600 SoC that never left the
-labs. It can be easily replaced by the ``rainier-bmc`` machine, which
-was the actual final product, or by the ``ast2600-evb`` with some
-tweaks.
-
 ppc ``taihu`` machine (removed in 7.2)
 '''''''''''''''''''''''''''''''''''''''''''''
 
@@ -1084,6 +1074,16 @@ for all machine types using the PXA2xx and OMAP2 SoCs. We are also
 dropping the ``cheetah`` OMAP1 board, because we don't have any
 test images for it and don't know of anybody who does.
 
+Aspeed ``tacoma-bmc`` machine (removed in 10.0)
+'''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``tacoma-bmc`` machine was removed because it didn't bring much
+compared to the ``rainier-bmc`` machine. Also, the ``tacoma-bmc`` was
+a board used for bring up of the AST2600 SoC that never left the
+labs. It can be easily replaced by the ``rainier-bmc`` machine, which
+was the actual final product, or by the ``ast2600-evb`` with some
+tweaks.
+
 ppc ``ref405ep`` machine (removed in 10.0)
 ''''''''''''''''''''''''''''''''''''''''''
 
-- 
2.48.1


