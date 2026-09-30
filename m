Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79BACA5FBE
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrkI-000542-Lk; Wed, 30 Sep 2026 06:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrj4-0001gR-Nl
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrip-0006sJ-Ux
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nr9oHPkMPLPXBXsI50SbeqoQrdpe2QQJ3bjMk0jds3o=;
 b=MxULPebdjZCXYm2OPWBBHGlrrClWjs9LgO2rNwZMpiLQQ9eSWdCIOVnLjAAUyrWLd5EVIP
 nabY493lL+4owdhpNdr4SOugwEsUKEeq2sYMHQMaY0M9wNZ6XJAlLydSWe0JMLGginCo3W
 nuyLrFaMf3yas5vs/g7iTQLU+yFthQo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-0vNJFHt3OsW6SDQldlK4gw-1; Wed,
 30 Sep 2026 06:39:31 -0400
X-MC-Unique: 0vNJFHt3OsW6SDQldlK4gw-1
X-Mimecast-MFC-AGG-ID: 0vNJFHt3OsW6SDQldlK4gw_1790764770
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 951F61955E97; Wed, 30 Sep 2026 10:39:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 181061800593; Wed, 30 Sep 2026 10:39:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4F02B21E5B82; Wed, 30 Sep 2026 12:39:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 105/105] qapi: split intro sections for inlinable structs
Date: Wed, 30 Sep 2026 12:39:10 +0200
Message-ID: <20260930103910.3934848-106-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

This patch splits the intro/details section for structs which are used
in an inlinable context; i.e. structs used either as arguments for a
command/event, or used as a branch of a union. The QAPI documentation
block for these entities will have their intro section left behind
when inlined into other contexts, but will still display the intro
section on standalone documentation for these types.

This patch does not change how the rendered documentation currently
looks, except:

1. MemoryBackendShmProperties and MemoryBackendEpcProperties see their
   member descriptions move upwards to just below their formalized
   introductory sections.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260928192557.509157-11-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-export.json |  5 ++---
 qapi/crypto.json       |  3 +--
 qapi/machine.json      | 11 ++++-------
 qapi/net.json          | 34 +++++++++++++++-------------------
 qapi/qom.json          |  9 +++------
 5 files changed, 25 insertions(+), 37 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 77459f6321..e3cee2fb5c 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -154,9 +154,8 @@
 
 ##
 # @BlockExportOptionsFuse:
-#
-# Options for exporting a block graph node on some (file) mountpoint
-# as a raw image.
+#     Options for exporting a block graph node on some (file)
+#     mountpoint as a raw image.
 #
 # Multi-threading note: The FUSE export supports multi-threading.
 # Currently, requests are distributed across these threads in a
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 7b4c80edae..a8d753d360 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -429,8 +429,7 @@
 
 ##
 # @SecretProperties:
-#
-# Properties for secret objects.
+#     Properties for secret objects.
 #
 # Either @data or @file must be provided, but not both.
 #
diff --git a/qapi/machine.json b/qapi/machine.json
index d09424b870..9b145c635b 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -690,9 +690,8 @@
 
 ##
 # @NumaHmatLBOptions:
-#
-# Set the system locality latency and bandwidth information between
-# Initiator and Target proximity Domains.
+#     Set the system locality latency and bandwidth information
+#     between Initiator and Target proximity Domains.
 #
 # For more information about `NumaHmatLBOptions`, see chapter
 # 5.2.27.4: Table 5-146 of ACPI 6.3 spec.
@@ -766,8 +765,7 @@
 
 ##
 # @NumaHmatCacheOptions:
-#
-# Set the memory side cache information for a given memory domain.
+#     Set the memory side cache information for a given memory domain.
 #
 # For more information of `NumaHmatCacheOptions`, see chapter
 # 5.2.27.5: Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
@@ -932,8 +930,7 @@
 
 ##
 # @CpuInstanceProperties:
-#
-# Properties identifying a CPU.
+#     Properties identifying a CPU.
 #
 # Which members are optional and which mandatory depends on the
 # architecture and board.
diff --git a/qapi/net.json b/qapi/net.json
index 3541dd7cad..f0312dfb71 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -719,11 +719,10 @@
 
 ##
 # @NetdevVhostVDPAOptions:
+#     Vhost-vdpa network backend
 #
-# Vhost-vdpa network backend
-#
-# vDPA device is a device that uses a datapath which complies with the
-# virtio specifications with a vendor specific control path.
+#     vDPA device is a device that uses a datapath which complies with
+#     the virtio specifications with a vendor specific control path.
 #
 # @vhostdev: path of vhost-vdpa device (default:'/dev/vhost-vdpa-0')
 #
@@ -750,11 +749,10 @@
 
 ##
 # @NetdevVmnetHostOptions:
+#     vmnet (host mode) network backend.
 #
-# vmnet (host mode) network backend.
-#
-# Allows the vmnet interface to communicate with other vmnet
-# interfaces that are in host mode and also with the host.
+#     Allows the vmnet interface to communicate with other vmnet
+#     interfaces that are in host mode and also with the host.
 #
 # @start-address: The starting IPv4 address to use for the interface.
 #     Must be in the private IP range (RFC 1918).  Must be specified
@@ -793,15 +791,14 @@
 
 ##
 # @NetdevVmnetSharedOptions:
+#     vmnet (shared mode) network backend.
 #
-# vmnet (shared mode) network backend.
-#
-# Allows traffic originating from the vmnet interface to reach the
-# Internet through a network address translator (NAT).  The vmnet
-# interface can communicate with the host and with other shared mode
-# interfaces on the same subnet.  If no DHCP settings, subnet mask and
-# IPv6 prefix specified, the interface can communicate with any of
-# other interfaces in shared mode.
+#     Allows traffic originating from the vmnet interface to reach the
+#     Internet through a network address translator (NAT).  The vmnet
+#     interface can communicate with the host and with other shared
+#     mode interfaces on the same subnet.  If no DHCP settings, subnet
+#     mask and IPv6 prefix specified, the interface can communicate
+#     with any of other interfaces in shared mode.
 #
 # @start-address: The starting IPv4 address to use for the interface.
 #     Must be in the private IP range (RFC 1918).  Must be specified
@@ -838,10 +835,9 @@
 
 ##
 # @NetdevVmnetBridgedOptions:
+#     vmnet (bridged mode) network backend.
 #
-# vmnet (bridged mode) network backend.
-#
-# Bridges the vmnet interface with a physical network interface.
+#     Bridges the vmnet interface with a physical network interface.
 #
 # @ifname: The name of the physical interface to be bridged.
 #
diff --git a/qapi/qom.json b/qapi/qom.json
index 59e523e3bf..e03ede3442 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -465,8 +465,7 @@
 
 ##
 # @FilterRedirectorProperties:
-#
-# Properties for filter-redirector objects.
+#     Properties for filter-redirector objects.
 #
 # At least one of @indev or @outdev must be present.  If both are
 # present, they must not refer to the same character device backend.
@@ -765,8 +764,7 @@
 
 ##
 # @MemoryBackendShmProperties:
-#
-# Properties for memory-backend-shm objects.
+#     Properties for memory-backend-shm objects.
 #
 # This memory backend supports only shared memory, which is the
 # default.
@@ -780,8 +778,7 @@
 
 ##
 # @MemoryBackendEpcProperties:
-#
-# Properties for memory-backend-epc objects.
+#     Properties for memory-backend-epc objects.
 #
 # The @merge boolean option is false by default with epc
 #
-- 
2.55.0


