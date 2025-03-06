Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6935BC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 17:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqFDu-0003EX-Ok; Thu, 06 Mar 2025 12:41:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tqFDs-0003Dz-Nb
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 12:41:28 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tqFDq-0005ZK-OA
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 12:41:28 -0500
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-CgaHey1RNpCnVRYRl6O-sQ-1; Thu,
 06 Mar 2025 12:41:18 -0500
X-MC-Unique: CgaHey1RNpCnVRYRl6O-sQ-1
X-Mimecast-MFC-AGG-ID: CgaHey1RNpCnVRYRl6O-sQ_1741282877
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AB0E180049D; Thu,  6 Mar 2025 17:41:17 +0000 (UTC)
Received: from bahia.redhat.com (unknown [10.45.224.221])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3A2351956095; Thu,  6 Mar 2025 17:41:14 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>
Subject: [PATCH] docs: Rename default-configs to configs
Date: Thu,  6 Mar 2025 18:41:13 +0100
Message-ID: <20250306174113.427116-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: softfail client-ip=205.139.111.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

This was missed at the time.

Fixes: 812b31d3f91 ("configs: rename default-configs to configs and reorganise")
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 docs/devel/build-system.rst | 10 +++++-----
 docs/devel/kconfig.rst      | 16 ++++++++--------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index d42045a23250..a759982f45c4 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -260,7 +260,7 @@ Target-dependent emulator sourcesets:
   Each emulator also includes sources for files in the ``hw/`` and ``target/``
   subdirectories.  The subdirectory used for each emulator comes
   from the target's definition of ``TARGET_BASE_ARCH`` or (if missing)
-  ``TARGET_ARCH``, as found in ``default-configs/targets/*.mak``.
+  ``TARGET_ARCH``, as found in ``configs/targets/*.mak``.
 
   Each subdirectory in ``hw/`` adds one sourceset to the ``hw_arch`` dictionary,
   for example::
@@ -317,8 +317,8 @@ Utility sourcesets:
 The following files concur in the definition of which files are linked
 into each emulator:
 
-``default-configs/devices/*.mak``
-  The files under ``default-configs/devices/`` control the boards and devices
+``configs/devices/*.mak``
+  The files under ``configs/devices/`` control the boards and devices
   that are built into each QEMU system emulation targets. They merely contain
   a list of config variable definitions such as::
 
@@ -327,11 +327,11 @@ into each emulator:
     CONFIG_XLNX_VERSAL=y
 
 ``*/Kconfig``
-  These files are processed together with ``default-configs/devices/*.mak`` and
+  These files are processed together with ``configs/devices/*.mak`` and
   describe the dependencies between various features, subsystems and
   device models.  They are described in :ref:`kconfig`
 
-``default-configs/targets/*.mak``
+``configs/targets/*.mak``
   These files mostly define symbols that appear in the ``*-config-target.h``
   file for each emulator\ [#cfgtarget]_.  However, the ``TARGET_ARCH``
   and ``TARGET_BASE_ARCH`` will also be used to select the ``hw/`` and
diff --git a/docs/devel/kconfig.rst b/docs/devel/kconfig.rst
index 52d4b905f675..493b76c4fbf7 100644
--- a/docs/devel/kconfig.rst
+++ b/docs/devel/kconfig.rst
@@ -38,7 +38,7 @@ originated in the Linux kernel, though it was heavily simplified and
 the handling of dependencies is stricter in QEMU.
 
 Unlike Linux, there is no user interface to edit the configuration, which
-is instead specified in per-target files under the ``default-configs/``
+is instead specified in per-target files under the ``configs/``
 directory of the QEMU source tree.  This is because, unlike Linux,
 configuration and dependencies can be treated as a black box when building
 QEMU; the default configuration that QEMU ships with should be okay in
@@ -103,7 +103,7 @@ directives can be included:
 **default value**: ``default <value> [if <expr>]``
 
   Default values are assigned to the config symbol if no other value was
-  set by the user via ``default-configs/*.mak`` files, and only if
+  set by the user via ``configs/*.mak`` files, and only if
   ``select`` or ``depends on`` directives do not force the value to true
   or false respectively.  ``<value>`` can be ``y`` or ``n``; it cannot
   be an arbitrary Boolean expression.  However, a condition for applying
@@ -119,7 +119,7 @@ directives can be included:
   This is similar to ``select`` as it applies a lower limit of ``y``
   to another symbol.  However, the lower limit is only a default
   and the "implied" symbol's value may still be set to ``n`` from a
-  ``default-configs/*.mak`` files.  The following two examples are
+  ``configs/*.mak`` files.  The following two examples are
   equivalent::
 
     config FOO
@@ -146,7 +146,7 @@ declares its dependencies in different ways:
       bool
 
   Subsystems always default to false (they have no ``default`` directive)
-  and are never visible in ``default-configs/*.mak`` files.  It's
+  and are never visible in ``configs/*.mak`` files.  It's
   up to other symbols to ``select`` whatever subsystems they require.
 
   They sometimes have ``select`` directives to bring in other required
@@ -238,7 +238,7 @@ declares its dependencies in different ways:
   include libraries (such as ``FDT``) or ``TARGET_BIG_ENDIAN``
   (possibly negated).
 
-  Boards are listed for convenience in the ``default-configs/*.mak``
+  Boards are listed for convenience in the ``configs/*.mak``
   for the target they apply to.
 
 **internal elements**
@@ -251,18 +251,18 @@ declares its dependencies in different ways:
 
   Internal elements group code that is useful in several boards or
   devices.  They are usually enabled with ``select`` and in turn select
-  other elements; they are never visible in ``default-configs/*.mak``
+  other elements; they are never visible in ``configs/*.mak``
   files, and often not even in the Makefile.
 
 Writing and modifying default configurations
 --------------------------------------------
 
 In addition to the Kconfig files under hw/, each target also includes
-a file called ``default-configs/TARGETNAME-softmmu.mak``.  These files
+a file called ``configs/TARGETNAME-softmmu.mak``.  These files
 initialize some Kconfig variables to non-default values and provide the
 starting point to turn on devices and subsystems.
 
-A file in ``default-configs/`` looks like the following example::
+A file in ``configs/`` looks like the following example::
 
     # Default configuration for alpha-softmmu
 
-- 
2.48.1


