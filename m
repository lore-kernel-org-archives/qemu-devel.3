Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63069C28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 08:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsdVs-00047L-WB; Thu, 13 Mar 2025 04:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsdVm-00045d-DX
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 04:01:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsdVk-0007hO-9I
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 04:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741852907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6s0AcuAuc9im8kEUIg8jGkALu6iigzUHJf4QyJT4in4=;
 b=DMC1IktrgxqsB7mNwiy4Ni13Dspz+QkXfGldLiVATEGXJlpUiJAp0xz1DLg5bsWvbPkEEg
 bfR+gV+gqL3gDv2X/9lTj2F6zIxp0eKGRSMgE1taVw/T6qLaGIG5WqK7DG8+L5HgSqx/Tz
 3IqFlrYsjZC5o3sHhz9gyHBlWpPNph8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-Kw1D2ayTPs6CUiIKOPG-SA-1; Thu,
 13 Mar 2025 04:01:43 -0400
X-MC-Unique: Kw1D2ayTPs6CUiIKOPG-SA-1
X-Mimecast-MFC-AGG-ID: Kw1D2ayTPs6CUiIKOPG-SA_1741852902
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21923180035C; Thu, 13 Mar 2025 08:01:41 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E4E11955F2D; Thu, 13 Mar 2025 08:01:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/8] docs: Rename default-configs to configs
Date: Thu, 13 Mar 2025 09:01:25 +0100
Message-ID: <20250313080132.1467625-2-thuth@redhat.com>
In-Reply-To: <20250313080132.1467625-1-thuth@redhat.com>
References: <20250313080132.1467625-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Greg Kurz <groug@kaod.org>

This was missed at the time.

Fixes: 812b31d3f91 ("configs: rename default-configs to configs and reorganise")
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250306174113.427116-1-groug@kaod.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/build-system.rst | 10 +++++-----
 docs/devel/kconfig.rst      | 16 ++++++++--------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index d42045a2325..a759982f45c 100644
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
index 52d4b905f67..493b76c4fbf 100644
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


