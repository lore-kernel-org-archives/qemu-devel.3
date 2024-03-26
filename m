Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DD8CD11DB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 07:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp1KW-0004kK-V6; Tue, 26 Mar 2024 03:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KU-0004if-9w
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KS-0005OS-MC
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711438480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCcsGDAqTHp3SKBdBhmBLMwgpfp96QPPVeggh7rLPUU=;
 b=ci/A5RE3sRBlCsm9QKmel1cpkO4LDZB4fTWsIMde1pwnhGBuxkt5xJJSgSQ5pkjSzKy0ZG
 Yn0E8Ej/jWZvC9IMT1GYv7YstkBaKl8SKJgMP4XmRD3FavFOETkoC1OmpQVzwLOkcFaU/2
 JPLJfp3VGGHxduDisVWAOQbBUe4bmxs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-IXdpgMGgMnum4t0KVf1dcQ-1; Tue, 26 Mar 2024 03:34:36 -0400
X-MC-Unique: IXdpgMGgMnum4t0KVf1dcQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D439D101A526;
 Tue, 26 Mar 2024 07:34:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3E0F200B3BF;
 Tue, 26 Mar 2024 07:34:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BA7A621E5D38; Tue, 26 Mar 2024 08:34:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 18/20] qapi: document leftover members in qapi/stats.json
Date: Tue, 26 Mar 2024 08:34:18 +0100
Message-ID: <20240326073420.738016-19-armbru@redhat.com>
In-Reply-To: <20240326073420.738016-1-armbru@redhat.com>
References: <20240326073420.738016-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20240325104504.1358734-1-pbonzini@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Update qapi/pragma.json]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/pragma.json |  5 +----
 qapi/stats.json  | 14 +++++++++-----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/qapi/pragma.json b/qapi/pragma.json
index 1a302981c1..99e4052ab3 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -75,8 +75,6 @@
         'Qcow2OverlapCheckFlags',
         'RbdAuthMode',
         'RbdImageEncryptionFormat',
-        'StatsFilter',
-        'StatsValue',
         'String',
         'StringWrapper',
         'SysEmuTarget',
@@ -91,8 +89,7 @@
         'query-cpu-model-comparison',
         'query-cpu-model-expansion',
         'query-rocker',
-        'query-rocker-ports',
-        'query-stats-schemas' ],
+        'query-rocker-ports' ],
     # Externally visible types whose member names may use uppercase
     'member-name-exceptions': [     # visible in:
         'ACPISlotType',             # query-acpi-ospm-status
diff --git a/qapi/stats.json b/qapi/stats.json
index ce9d8161ec..578b52c7ef 100644
--- a/qapi/stats.json
+++ b/qapi/stats.json
@@ -114,13 +114,13 @@
 #
 # The arguments to the query-stats command; specifies a target for
 # which to request statistics and optionally the required subset of
-# information for that target:
+# information for that target.
 #
-# - which vCPUs to request statistics for
-# - which providers to request statistics from
-# - which named values to return within each provider
+# @target: the kind of objects to query.  Note that each possible
+#          target may enable additional filtering options
 #
-# @target: the kind of objects to query
+# @providers: which providers to request statistics from, and optionally
+#             which named values to return within each provider
 #
 # Since: 7.1
 ##
@@ -136,6 +136,8 @@
 #
 # @scalar: single unsigned 64-bit integers.
 #
+# @boolean: single boolean value.
+#
 # @list: list of unsigned 64-bit integers (used for histograms).
 #
 # Since: 7.1
@@ -254,6 +256,8 @@
 #
 # Return the schema for all available runtime-collected statistics.
 #
+# @provider: a provider to restrict the query to.
+#
 # Note: runtime-collected statistics and their names fall outside
 #     QEMU's usual deprecation policies.  QEMU will try to keep the
 #     set of available data stable, together with their names, but
-- 
2.44.0


