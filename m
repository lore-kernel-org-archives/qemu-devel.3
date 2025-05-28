Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB523C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 18:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKLZp-0002e8-1D; Wed, 28 May 2025 14:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLZV-0002MG-V4
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:32:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLZR-00071z-4p
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748457120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UB8ETDHmmoQh00Pe7x92CUMzrVVXt65rNAQ64klNv5k=;
 b=E6YqjH6s97PhEfd9JmxcNUvPBsV+cwXvfClVxmE0k94nqenSllBDKu8SvTtaVUKbI1LQLK
 AFjLZ4VAHJzRyb499b2LKEdA9lCZmtxkJXzEYY5oDING5EE8Qt0e0W/ZMg4bfT5YKBsx+p
 ru8q9AVyTGAc9Wnu5zs70DiMjY38VL8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-s7GVlLECM7OW69vH1GT_NA-1; Wed,
 28 May 2025 14:31:59 -0400
X-MC-Unique: s7GVlLECM7OW69vH1GT_NA-1
X-Mimecast-MFC-AGG-ID: s7GVlLECM7OW69vH1GT_NA_1748457118
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 482B7180034E; Wed, 28 May 2025 18:31:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4D581956096; Wed, 28 May 2025 18:31:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C130221E6540; Wed, 28 May 2025 20:31:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 13/13] qapi: use imperative style in documentation
Date: Wed, 28 May 2025 20:31:51 +0200
Message-ID: <20250528183151.2839034-14-armbru@redhat.com>
In-Reply-To: <20250528183151.2839034-1-armbru@redhat.com>
References: <20250528183151.2839034-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

As requested by Markus:
> We prefer imperative mood "Return" over "Returns".

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250522190542.588267-14-pierrick.bouvier@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Change several more]
---
 qapi/audio.json     |  2 +-
 qapi/block.json     |  2 +-
 qapi/char.json      |  4 ++--
 qapi/control.json   |  2 +-
 qapi/cryptodev.json |  2 +-
 qapi/dump.json      |  2 +-
 qapi/machine.json   |  8 ++++----
 qapi/migration.json | 10 +++++-----
 qapi/misc-i386.json |  6 +++---
 qapi/misc.json      |  2 +-
 qapi/ui.json        | 10 +++++-----
 qapi/virtio.json    |  2 +-
 12 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/qapi/audio.json b/qapi/audio.json
index 49633cf317..8de4430578 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -533,7 +533,7 @@
 ##
 # @query-audiodevs:
 #
-# Returns information about audiodev configuration
+# Return information about audiodev configuration
 #
 # Returns: array of @Audiodev
 #
diff --git a/qapi/block.json b/qapi/block.json
index e66666f5c6..f5374bd86c 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -83,7 +83,7 @@
 ##
 # @query-pr-managers:
 #
-# Returns a list of information about each persistent reservation
+# Return a list of information about each persistent reservation
 # manager.
 #
 # Returns: a list of @PRManagerInfo for each persistent reservation
diff --git a/qapi/char.json b/qapi/char.json
index dde2f9538f..447c10b91a 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -34,7 +34,7 @@
 ##
 # @query-chardev:
 #
-# Returns information about current character devices.
+# Return information about current character devices.
 #
 # Returns: a list of @ChardevInfo
 #
@@ -80,7 +80,7 @@
 ##
 # @query-chardev-backends:
 #
-# Returns information about character device backends.
+# Return information about character device backends.
 #
 # Returns: a list of @ChardevBackendInfo
 #
diff --git a/qapi/control.json b/qapi/control.json
index 336386f79e..34b733f63b 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -91,7 +91,7 @@
 ##
 # @query-version:
 #
-# Returns the current version of QEMU.
+# Return the current version of QEMU.
 #
 # Returns: A @VersionInfo object describing the current version of
 #     QEMU.
diff --git a/qapi/cryptodev.json b/qapi/cryptodev.json
index 04d0e21d20..28b97eb3da 100644
--- a/qapi/cryptodev.json
+++ b/qapi/cryptodev.json
@@ -94,7 +94,7 @@
 ##
 # @query-cryptodev:
 #
-# Returns information about current crypto devices.
+# Return information about current crypto devices.
 #
 # Returns: a list of @QCryptodevInfo
 #
diff --git a/qapi/dump.json b/qapi/dump.json
index d7826c0e32..f2835c0b47 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -195,7 +195,7 @@
 ##
 # @query-dump-guest-memory-capability:
 #
-# Returns the available formats for dump-guest-memory
+# Return the available formats for dump-guest-memory
 #
 # Returns: A @DumpGuestMemoryCapability object listing available
 #     formats for dump-guest-memory
diff --git a/qapi/machine.json b/qapi/machine.json
index e6b4b2dfef..5373e1368c 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -99,7 +99,7 @@
 ##
 # @query-cpus-fast:
 #
-# Returns information about all virtual CPUs.
+# Return information about all virtual CPUs.
 #
 # Returns: list of @CpuInfoFast
 #
@@ -467,7 +467,7 @@
 ##
 # @query-kvm:
 #
-# Returns information about KVM acceleration
+# Return information about KVM acceleration
 #
 # Returns: @KvmInfo
 #
@@ -930,7 +930,7 @@
 ##
 # @query-memdev:
 #
-# Returns information for all memory backends.
+# Return information for all memory backends.
 #
 # Returns: a list of @Memdev.
 #
@@ -1235,7 +1235,7 @@
 ##
 # @query-hv-balloon-status-report:
 #
-# Returns the hv-balloon driver data contained in the last received
+# Return the hv-balloon driver data contained in the last received
 # "STATUS" message from the guest.
 #
 # Returns:
diff --git a/qapi/migration.json b/qapi/migration.json
index 8b9c53595c..ce8d1663d8 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -282,7 +282,7 @@
 ##
 # @query-migrate:
 #
-# Returns information about current migration process.  If migration
+# Return information about current migration process.  If migration
 # is active there will be another json-object with RAM migration
 # status.
 #
@@ -535,7 +535,7 @@
 ##
 # @query-migrate-capabilities:
 #
-# Returns information about the current migration capabilities status
+# Return information about the current migration capabilities status
 #
 # Returns: @MigrationCapabilityStatus
 #
@@ -1320,7 +1320,7 @@
 ##
 # @query-migrate-parameters:
 #
-# Returns information about the current migration parameters
+# Return information about the current migration parameters
 #
 # Returns: @MigrationParameters
 #
@@ -2294,7 +2294,7 @@
 ##
 # @query-vcpu-dirty-limit:
 #
-# Returns information about virtual CPU dirty page rate limits, if
+# Return information about virtual CPU dirty page rate limits, if
 # any.
 #
 # Since: 7.1
@@ -2327,7 +2327,7 @@
 ##
 # @query-migrationthreads:
 #
-# Returns information of migration threads
+# Return information of migration threads
 #
 # Features:
 #
diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index 3f88a5b28e..3b5346425a 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -126,7 +126,7 @@
 ##
 # @query-sev:
 #
-# Returns information about SEV/SEV-ES/SEV-SNP.
+# Return information about SEV/SEV-ES/SEV-SNP.
 #
 # If unavailable due to an incompatible configuration the returned
 # @enabled field is set to 'false' and the state of all other fields
@@ -343,7 +343,7 @@
 ##
 # @query-sgx:
 #
-# Returns information about configured SGX capabilities of guest
+# Return information about configured SGX capabilities of guest
 #
 # Returns: @SgxInfo
 #
@@ -362,7 +362,7 @@
 ##
 # @query-sgx-capabilities:
 #
-# Returns information about SGX capabilities of host
+# Return information about SGX capabilities of host
 #
 # Returns: @SgxInfo
 #
diff --git a/qapi/misc.json b/qapi/misc.json
index 559b66f201..dcf9f7df5b 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -101,7 +101,7 @@
 ##
 # @query-iothreads:
 #
-# Returns a list of information about each iothread.
+# Return a list of information about each iothread.
 #
 # .. note:: This list excludes the QEMU main loop thread, which is not
 #    declared using the ``-object iothread`` command-line option.  It
diff --git a/qapi/ui.json b/qapi/ui.json
index c536d4e524..3d0c853c9a 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -323,7 +323,7 @@
 ##
 # @query-spice:
 #
-# Returns information about the current SPICE server
+# Return information about the current SPICE server
 #
 # Returns: @SpiceInfo
 #
@@ -654,7 +654,7 @@
 ##
 # @query-vnc:
 #
-# Returns information about the current VNC server
+# Return information about the current VNC server
 #
 # Returns: @VncInfo
 #
@@ -685,7 +685,7 @@
 ##
 # @query-vnc-servers:
 #
-# Returns a list of vnc servers.  The list can be empty.
+# Return a list of vnc servers.  The list can be empty.
 #
 # Returns: a list of @VncInfo2
 #
@@ -820,7 +820,7 @@
 ##
 # @query-mice:
 #
-# Returns information about each active mouse device
+# Return information about each active mouse device
 #
 # Returns: a list of @MouseInfo for each device
 #
@@ -1562,7 +1562,7 @@
 ##
 # @query-display-options:
 #
-# Returns information about display configuration
+# Return information about display configuration
 #
 # Returns: @DisplayOptions
 #
diff --git a/qapi/virtio.json b/qapi/virtio.json
index d351d2166e..73df718a26 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -24,7 +24,7 @@
 ##
 # @x-query-virtio:
 #
-# Returns a list of all realized VirtIODevices
+# Return a list of all realized VirtIODevices
 #
 # Features:
 #
-- 
2.48.1


