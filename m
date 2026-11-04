Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB38606A326
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LDx1uPW6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOat3-00071v-6E; Wed, 04 Nov 2026 08:18:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xOat1-00071f-A1
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 08:18:43 -0500
Received: from out-24.mta1.migadu.com ([95.215.58.24] helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xOasz-0002zN-Iv
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 08:18:43 -0500
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=rFkLa2hwtClX0tRdpRTMgG9vYi1puXw9y1dqS4KrQRg=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793798319; v=1; x=1794403119;
 b=LDx1uPW6cO/5CDcRLHo1g1BfwDtp5Je112UFYi3tclaHI3rDgSNEu06K5iNWFuFd66rrPcWE
 OmsvxCpC6XQy/JI0hrIjMPgFmXssvyRsIeDY0577AZ5GgFkFsROXcyzJLmxs9KJMPFVib+JlswK
 sOKripfLdrhT5sOadLseVkIc=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id a93b4613600de1b4;
 Wed, 04 Nov 2026 13:18:39 +0000
X-Mizu-Trace-ID: a93b4613600de1b4
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 zhao1.liu@intel.com, richard.henderson@linaro.org, farosas@suse.de,
 lvivier@redhat.com, pierrick.bouvier@oss.qualcomm.com, thuth@redhat.com,
 peter.maydell@linaro.org, kraxel@redhat.com, berrange@redhat.com,
 marcandre.lureau@redhat.com, deller@gmx.de, clg@redhat.com,
 jamin_lin@aspeedtech.com, junjie.cao@linux.dev
Subject: [RFC PATCH 4/4] docs/system/devices/usb: describe -usb after the
 qemu-xhci switch
Date: Wed,  4 Nov 2026 07:18:10 -0600
Message-ID: <20261104131810.2063834-5-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104131810.2063834-1-junjie.cao@linux.dev>
References: <20261104131810.2063834-1-junjie.cao@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.215.58.24; envelope-from=junjie.cao@linux.dev;
 helo=mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Say which machine types still get UHCI or EHCI from -usb, and point
guests without an xHCI driver at them. The two examples that used
-usb for a UHCI next to an EHCI now create it with -device, so they
keep showing separate UHCI and EHCI buses.

Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
---
 docs/system/devices/usb.rst | 23 ++++++++++++++---------
 qemu-options.hx             |  9 ++++++---
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/docs/system/devices/usb.rst b/docs/system/devices/usb.rst
index dc694d23c2..b3cde7fc8e 100644
--- a/docs/system/devices/usb.rst
+++ b/docs/system/devices/usb.rst
@@ -20,6 +20,11 @@ released around 2010 or later) we recommend using it:
 
     |qemu_system| -device qemu-xhci
 
+From the 12.0 machine types on, ``-usb`` creates a ``qemu-xhci`` on
+the ``pc`` and ``q35`` machines.  Guests without an XHCI driver, such
+as Windows 7, need an older machine type or an explicit
+``-device piix3-usb-uhci`` or ``-device usb-ehci``.
+
 XHCI supports USB 1.1, USB 2.0 and USB 3.0 devices, so this is the
 only controller you need.  With only a single USB controller (and
 therefore only a single USB bus) present in the system there is no
@@ -42,9 +47,9 @@ bus though, so there are two completely separate USB buses: One USB
 the EHCI controller.  Devices must be attached to the correct
 controller manually.
 
-The easiest way to add a UHCI controller to a ``pc`` machine is the
-``-usb`` switch.  QEMU will create the UHCI controller as function of
-the PIIX3 chipset.  The USB 1.1 bus will carry the name ``usb-bus.0``.
+On ``pc`` machine types up to 11.2 the ``-usb`` switch creates the
+UHCI controller as function of the PIIX3 chipset.  The USB 1.1 bus
+will carry the name ``usb-bus.0``.
 
 You can use the standard ``-device`` switch to add a EHCI controller to
 your virtual machine.  It is strongly recommended to specify an ID for
@@ -59,9 +64,9 @@ bus they should be attached to.  Here is a complete example:
 
     |qemu_system| -M pc ${otheroptions}                        \\
         -drive if=none,id=usbstick,format=raw,file=/path/to/image   \\
-        -usb                                                        \\
+        -device piix3-usb-uhci,id=uhci                              \\
         -device usb-ehci,id=ehci                                    \\
-        -device usb-tablet,bus=usb-bus.0                            \\
+        -device usb-tablet,bus=uhci.0                               \\
         -device usb-storage,bus=ehci.0,drive=usbstick
 
 This attaches a USB tablet to the UHCI adapter and a USB mass storage
@@ -88,8 +93,8 @@ you, which you can use like this:
 
 Then use ``bus=ehci.0`` to assign your USB devices to that bus.
 
-Using the ``-usb`` switch for ``q35`` machines will create a similar
-USB controller configuration.
+On ``q35`` machine types up to 11.2 the ``-usb`` switch creates this
+configuration.
 
 
 .. _Connecting USB devices:
@@ -359,9 +364,9 @@ and also assign it to the correct USB bus in QEMU like this:
 .. parsed-literal::
 
    |qemu_system| -M pc [...]                            \\
-        -usb                                                 \\
+        -device piix3-usb-uhci,id=uhci                       \\
         -device usb-ehci,id=ehci                             \\
-        -device usb-host,bus=usb-bus.0,hostbus=3,hostport=1  \\
+        -device usb-host,bus=uhci.0,hostbus=3,hostport=1     \\
         -device usb-host,bus=ehci.0,hostbus=1,hostport=1
 
 ``usb-host`` properties for reset behavior
diff --git a/qemu-options.hx b/qemu-options.hx
index 5fe9d73eaa..2429461350 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2193,9 +2193,12 @@ DEF("usb", 0, QEMU_OPTION_usb,
 SRST
 ``-usb``
     Enable USB emulation on machine types with an on-board USB host
-    controller (if not enabled by default). Note that on-board USB host
-    controllers may not support USB 3.0. In this case
-    ``-device qemu-xhci`` can be used instead on machines with PCI.
+    controller (if not enabled by default). On the ``pc`` and ``q35``
+    machines this is a ``qemu-xhci`` from the 12.0 machine types on;
+    older types get the chipset's UHCI (``pc``) or EHCI with UHCI
+    companions (``q35``). Other on-board USB host controllers may not
+    support USB 3.0. In this case ``-device qemu-xhci`` can be used
+    instead on machines with PCI.
 ERST
 
 DEF("usbdevice", HAS_ARG, QEMU_OPTION_usbdevice,
-- 
2.43.0


