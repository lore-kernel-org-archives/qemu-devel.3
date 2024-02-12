Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C506C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 09:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZSP9-0006cM-9T; Mon, 12 Feb 2024 04:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZSOm-0006NO-Mf
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:14:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZSOi-0003d7-2E
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707729282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m6r2F1e5itjjWzMBMpDYu49lQMV3nNA6dqlK7xooGGw=;
 b=fACrShYkt6S9tCI0N4pyvPkO7a230TUeyzbW1FxIlSw1Di3HKPooMCiQs3sKg9B+JZ1rTL
 HPNAWUNE1nwahF9KseBc0JASiRb9Y4W7v/OVpzfGzR+NBoBWyvhcR8ETl31k+YY5+PZ4MN
 Nxuw61jazRhK6+4bAqIubawfUTTdxig=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-Zq2h4lV6MeieCGzYKNXAaA-1; Mon, 12 Feb 2024 04:14:39 -0500
X-MC-Unique: Zq2h4lV6MeieCGzYKNXAaA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1495E831016;
 Mon, 12 Feb 2024 09:14:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4F33C4CA00;
 Mon, 12 Feb 2024 09:14:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8DC0321E66D0; Mon, 12 Feb 2024 10:14:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 08/18] qga/qapi-schema: Clean up documentation of
 guest-set-vcpus
Date: Mon, 12 Feb 2024 10:14:26 +0100
Message-ID: <20240212091436.688598-9-armbru@redhat.com>
In-Reply-To: <20240212091436.688598-1-armbru@redhat.com>
References: <20240212091436.688598-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The command's doc comment describes the argument, but it's not marked
up as such.  Easy enough to fix.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240205074709.3613229-9-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/qapi-schema.json | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 35bde36a1f..f3d168d542 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -42,8 +42,7 @@
         'GuestDeviceType',
         'GuestDiskSmart',
         'GuestDiskStatsInfo',
-        'GuestNVMeSmart',
-        'guest-set-vcpus' ] } }
+        'GuestNVMeSmart' ] } }
 
 ##
 # @guest-sync-delimited:
@@ -786,14 +785,15 @@
 # Attempt to reconfigure (currently: enable/disable) logical
 # processors inside the guest.
 #
-# The input list is processed node by node in order.  In each node
-# @logical-id is used to look up the guest VCPU, for which @online
-# specifies the requested state.  The set of distinct @logical-id's is
-# only required to be a subset of the guest-supported identifiers.
-# There's no restriction on list length or on repeating the same
-# @logical-id (with possibly different @online field). Preferably the
-# input list should describe a modified subset of @guest-get-vcpus'
-# return value.
+# @vcpus: The logical processors to be reconfigured.  This list is
+#     processed node by node in order.  In each node @logical-id is
+#     used to look up the guest VCPU, for which @online specifies the
+#     requested state.  The set of distinct @logical-id's is only
+#     required to be a subset of the guest-supported identifiers.
+#     There's no restriction on list length or on repeating the same
+#     @logical-id (with possibly different @online field).  Preferably
+#     the input list should describe a modified subset of
+#     @guest-get-vcpus' return value.
 #
 # Returns: The length of the initial sublist that has been
 #     successfully processed.  The guest agent maximizes this value.
-- 
2.43.0


