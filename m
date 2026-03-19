Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A89109190D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 18:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ID1-0006di-HV; Thu, 19 Mar 2026 14:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1w3ICz-0006cC-0g; Thu, 19 Mar 2026 14:35:01 -0400
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1w3ICw-0003TD-KS; Thu, 19 Mar 2026 14:35:00 -0400
Received: from qemu.weilnetz.de (qemu.weilnetz.de [188.68.58.204])
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTP id EEEBEDA03EE;
 Thu, 19 Mar 2026 19:34:53 +0100 (CET)
Authentication-Results: mail.v2201612906741603.powersrv.de; dkim=none;
 spf=temperror (mail.v2201612906741603.powersrv.de: error in processing during
 lookup of stefan@weilnetz.de: DNS error) smtp.mailfrom=stefan@weilnetz.de
Received: by qemu.weilnetz.de (Postfix, from userid 1000)
 id C5F23460028; Thu, 19 Mar 2026 19:34:53 +0100 (CET)
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>
Subject: [PATCH for-11.0] Fix several typos in documentation (found by
 codespell)
Date: Thu, 19 Mar 2026 19:34:53 +0100
Message-ID: <20260319183453.100545-1-sw@weilnetz.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: v2201612906741603
X-Rspamd-Queue-Id: EEEBEDA03EE
X-Spamd-Bar: /
X-Spamd-Result: default: False [0.50 / 12.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 FORGED_SENDER(0.30)[sw@weilnetz.de,stefan@weilnetz.de];
 ONCE_RECEIVED(0.20)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_NO_TLS_LAST(0.10)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_COUNT_ONE(0.00)[1]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWELVE(0.00)[15];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 R_SPF_DNSFAIL(0.00)[DNS failed]; R_DKIM_NA(0.00)[];
 FROM_NEQ_ENVFROM(0.00)[sw@weilnetz.de,stefan@weilnetz.de];
 TO_DN_SOME(0.00)[]; TAGGED_RCPT(0.00)[];
 FREEMAIL_TO(0.00)[linaro.org,crans.org,gmail.com,redhat.com]
X-Rspamd-Action: no action
Received-SPF: pass client-ip=37.120.169.71; envelope-from=stefan@weilnetz.de;
 helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Stefan Weil <sw@weilnetz.de>
From:  Stefan Weil via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Stefan Weil <sw@weilnetz.de>

These typos are part of the generated documentation.
Therefore they should be fixed in the new release.

More typos can be found in the remaining code, mostly in comments.

Regards,
Stefan

---
 contrib/plugins/traps.c        | 2 +-
 docs/about/emulation.rst       | 2 +-
 docs/devel/code-provenance.rst | 4 ++--
 docs/system/tls.rst            | 8 ++++----
 hw/arm/virt.c                  | 2 +-
 include/hw/arm/virt.h          | 2 +-
 include/plugins/qemu-plugin.h  | 2 +-
 qapi/block-core.json           | 6 +++---
 qapi/job.json                  | 2 +-
 qapi/uefi.json                 | 2 +-
 qemu-options.hx                | 4 ++--
 11 files changed, 18 insertions(+), 18 deletions(-)

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
index 7456614d05..26fef92158 100644
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
index f8d446b3d6..e8adaaea34 100644
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
 # first.  Inactivating a node automatically inactivates any of its
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
index 69e5a874c1..b58097d864 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3223,7 +3223,7 @@ SRST
         Enable/disable list in DHCP/DHCPv6/NDP
 
     ``map-host-loopback``
-        Addresse to refer to host
+        Address to refer to host
 
     ``map-guest-addr``
         Addr to translate to guest's address
@@ -3272,7 +3272,7 @@ SRST
 
     ``param=string``
          ``string`` will be passed to passt has a command line parameter,
-         we can have multiple occurences of the ``param`` parameter to
+         we can have multiple occurrences of the ``param`` parameter to
          pass multiple parameters to passt.
 
          For instance, to pass ``--trace --log=trace.log``:
-- 
2.47.3


