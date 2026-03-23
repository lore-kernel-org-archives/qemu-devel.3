Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE36EF46102
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ev6-0002RS-Av; Mon, 23 Mar 2026 09:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w4etc-00028v-BM; Mon, 23 Mar 2026 09:01:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w4etY-0006bg-4E; Mon, 23 Mar 2026 09:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1774270805; bh=lszQj8cP5FX4TRoi9avKIHzaIuN2mnXDHRv4kpj1eXg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=J5Fvrrt9UqXv1+Vmsy7K959eQUPf77fC9qzsbnFGpvFXw06BlLh1FLBC5I6wJtKX7
 F7xLMJ/Zj1Gpx9PqJ6n+z2z+U1LB8T5BNWyauCJed/HscVFn1GzKK9lq+olQfoUPAb
 H55j2nzF7sqNvddEHegvEcrSLaVl97oG8xfvyggOz/p9sb6sihL5/KMOyqgQz4sQip
 YCSaoh9eDC/kbwVUfbsMqr1QLhT413/Ip6dT7En1n9PaRpNNHxCne6TEIg3WPpfNe/
 eDLzG9D9SoLHxsGFqJWQRyBAuHkrtHDYyE0sia2eDFJjbVH7DRkQor71SN9APeJPiM
 x7gLEWeyhEmCw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5232D196974;
 Mon, 23 Mar 2026 16:00:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2832A385161;
 Mon, 23 Mar 2026 16:00:22 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Stefan Weil via <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 4/4] Fix several typos in documentation (found by codespell)
Date: Mon, 23 Mar 2026 16:00:16 +0300
Message-ID: <20260323130021.376393-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323130021.376393-1-mjt@tls.msk.ru>
References: <20260323130021.376393-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Stefan Weil via <qemu-trivial@nongnu.org>

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
[Mjt: add 2 fixes suggested by Peter: "as a" and "deactivate"]
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 contrib/plugins/traps.c        | 2 +-
 docs/about/emulation.rst       | 2 +-
 docs/devel/code-provenance.rst | 4 ++--
 docs/system/tls.rst            | 8 ++++----
 hw/arm/virt.c                  | 2 +-
 include/hw/arm/virt.h          | 2 +-
 include/plugins/qemu-plugin.h  | 2 +-
 qapi/block-core.json           | 8 ++++----
 qapi/job.json                  | 2 +-
 qapi/uefi.json                 | 2 +-
 qemu-options.hx                | 6 +++---
 11 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/contrib/plugins/traps.c b/contrib/plugins/traps.c
index d5ddc0f3dd..a741580fbf 100644
--- a/contrib/plugins/traps.c
+++ b/contrib/plugins/traps.c
@@ -4,7 +4,7 @@
  *
  * Traps - count traps
  *
- * Count the number of interrupts (asyncronous events), exceptions (synchronous
+ * Count the number of interrupts (asynchronous events), exceptions (synchronous
  * events) and host calls (e.g. semihosting) per cpu and report those counts on
  * exit.
  */
diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 76c6ea92ca..469f31bab6 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -1043,7 +1043,7 @@ Count traps
 
 ``contrib/plugins/traps.c``
 
-This plugin counts the number of interrupts (asyncronous events), exceptions
+This plugin counts the number of interrupts (asynchronous events), exceptions
 (synchronous events) and host calls (e.g. semihosting) per cpu.
 
 Other emulation features
diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
index 8cdc56f664..4e6a9afe0d 100644
--- a/docs/devel/code-provenance.rst
+++ b/docs/devel/code-provenance.rst
@@ -213,7 +213,7 @@ The general principles when picking up abandoned work are:
  * Indicate where the original patch was obtained from (mailing list, bug
    tracker, author's git repo, etc) when sending it for review
  * Acknowledge the extra work of the new contributor by including their
-   ``Signed-off-by`` in the patch in addition to the orignal author's
+   ``Signed-off-by`` in the patch in addition to the original author's
  * Indicate who is responsible for what parts of the patch. This is typically
    done via a note in the commit message, just prior to the new contributor's
    ``Signed-off-by``::
@@ -259,7 +259,7 @@ process. A non-exhaustive list of examples is:
    container images from a clean git checkout.
 
  * eBPF: QEMU includes some generated eBPF machine code, since the required
-   eBPF compilation tools are not broadly available on all targetted OS
+   eBPF compilation tools are not broadly available on all targeted OS
    distributions. The corresponding eBPF C code for the binary is also
    provided. This is a time-limited exception until the eBPF toolchain is
    sufficiently broadly available in distros.
diff --git a/docs/system/tls.rst b/docs/system/tls.rst
index 03fa1d8166..477ec7dcd1 100644
--- a/docs/system/tls.rst
+++ b/docs/system/tls.rst
@@ -76,10 +76,10 @@ loaded certificate will preferred. IOW file naming can influence
 which certificates are used for a session.
 
 The use of multiple sets of certificates is intended to allow an
-incremental transition to certificates using different crytographic
+incremental transition to certificates using different cryptographic
 algorithms. This allows a newly deployed QEMU to introduce use of
 stronger cryptographic algorithms that will be preferred when talking
-to other newly deployed QEMU instances, while retaining compatbility
+to other newly deployed QEMU instances, while retaining compatibility
 with certificates issued to a historically deployed QEMU. This is
 notably useful to support live migration from an old QEMU deployed
 on older operating system releases, which may support fewer crypto
@@ -350,7 +350,7 @@ TLS certificates for Post-Quantum Cryptography
 
 Given a new enough gnutls release, suitably integrated & configured with the
 operating system crypto policies, QEMU is able to support post-quantum
-crytography on TLS enabled services, either exclusively or in a hybrid mode.
+cryptography on TLS enabled services, either exclusively or in a hybrid mode.
 
 In exclusive mode, only a single set of certificates need to be configured
 for QEMU, with PQC compliant algorithms. Such a QEMU configuration will only
@@ -404,7 +404,7 @@ Force disabling PQC via crypto priority
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 In the OS configuration for system crypto algorithm priorities has
-enabled PQC, this can (optionally) be overriden in QEMU configuration
+enabled PQC, this can (optionally) be overridden in QEMU configuration
 disable use of PQC using the ``priority`` parameter to the ``tls-creds-x509``
 object::
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 06798c6c0f..ec0d8475ca 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2784,7 +2784,7 @@ static void virt_set_msi(Object *obj, const char *value, Error **errp)
     VirtMachineState *vms = VIRT_MACHINE(obj);
 
     if (!strcmp(value, "auto")) {
-        vms->msi_controller = VIRT_MSI_CTRL_AUTO; /* Will be overriden later */
+        vms->msi_controller = VIRT_MSI_CTRL_AUTO; /* Will be overridden later */
     } else if (!strcmp(value, "its")) {
         vms->msi_controller = VIRT_MSI_CTRL_ITS;
     } else if (!strcmp(value, "gicv2m")) {
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index dba8ac7f2f..5fcbd1c76f 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -101,7 +101,7 @@ typedef enum VirtIOMMUType {
 
 typedef enum VirtMSIControllerType {
     VIRT_MSI_CTRL_NONE,
-    /* This value is overriden at runtime.*/
+    /* This value is overridden at runtime.*/
     VIRT_MSI_CTRL_AUTO,
     /* Legacy option: its=off provides a GICv2m when using GICv2 */
     VIRT_MSI_LEGACY_OPT_ITS_OFF,
diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 9e4e40acee..2ce7a7fb6c 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -1125,7 +1125,7 @@ bool qemu_plugin_read_register(struct qemu_plugin_register *handle,
  * Attempting to write a register with @buf smaller than the register size
  * will result in a crash or other undesired behavior.
  *
- * Returns true on sucess, false on failure.
+ * Returns true on success, false on failure.
  */
 QEMU_PLUGIN_API
 bool qemu_plugin_write_register(struct qemu_plugin_register *handle,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index f8d446b3d6..508b081ac1 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3122,7 +3122,7 @@
 # the device to write to the target path only.  Note that drive
 # mirroring includes `drive-mirror`, `blockdev-mirror` and
 # `block-commit` job (only in case of "active commit", when the node
-# being commited is used by the guest).  The ability to complete is
+# being committed is used by the guest).  The ability to complete is
 # signaled with a `BLOCK_JOB_READY` event.
 #
 # This command completes an active background block operation
@@ -5086,14 +5086,14 @@
 ##
 # @blockdev-set-active:
 #
-# Activate or inactivate a block device.  Use this to manage the
+# Activate or deactivate a block device.  Use this to manage the
 # handover of block devices on migration with qemu-storage-daemon.
 #
 # Activating a node automatically activates all of its child nodes
-# first.  Inactivating a node automatically inactivates any of its
+# first.  Deactivating a node automatically deactivates any of its
 # child nodes that are not in use by a still active node.
 #
-# @node-name: Name of the graph node to activate or inactivate.  By
+# @node-name: Name of the graph node to activate or deactivate.  By
 #     default, all nodes are affected by the operation.
 #
 # @active: true if the nodes should be active when the command returns
diff --git a/qapi/job.json b/qapi/job.json
index 0a301fc094..31618e6ebc 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -196,7 +196,7 @@
 # the device to write to the target path only.  Note that drive
 # mirroring includes `drive-mirror`, `blockdev-mirror` and
 # `block-commit` job (only in case of "active commit", when the node
-# being commited is used by the guest).  The ability to complete is
+# being committed is used by the guest).  The ability to complete is
 # signaled with a `BLOCK_JOB_READY` event.
 #
 # This command completes an active background block operation
diff --git a/qapi/uefi.json b/qapi/uefi.json
index a206c2e953..86f33b234b 100644
--- a/qapi/uefi.json
+++ b/qapi/uefi.json
@@ -18,7 +18,7 @@
 ##
 # @UefiVariable:
 #
-# UEFI Variable.  Check the UEFI specifification for more detailed
+# UEFI Variable.  Check the UEFI specification for more detailed
 # information on the fields.
 #
 # @guid: variable namespace GUID
diff --git a/qemu-options.hx b/qemu-options.hx
index 69e5a874c1..dbcb0155ba 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3223,7 +3223,7 @@ SRST
         Enable/disable list in DHCP/DHCPv6/NDP
 
     ``map-host-loopback``
-        Addresse to refer to host
+        Address to refer to host
 
     ``map-guest-addr``
         Addr to translate to guest's address
@@ -3271,8 +3271,8 @@ SRST
         UDP ports to forward
 
     ``param=string``
-         ``string`` will be passed to passt has a command line parameter,
-         we can have multiple occurences of the ``param`` parameter to
+         ``string`` will be passed to passt as a command line parameter,
+         we can have multiple occurrences of the ``param`` parameter to
          pass multiple parameters to passt.
 
          For instance, to pass ``--trace --log=trace.log``:
-- 
2.47.3


