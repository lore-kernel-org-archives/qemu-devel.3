Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47693C48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 07:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWtj1-0004nl-QN; Mon, 05 Feb 2024 02:49:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWthP-000364-EN
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 02:47:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWthM-00066R-QN
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 02:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707119239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJ/iFqjc6913VV02EMMyJyjWFx+82MWX8wjAg2ffje4=;
 b=QgtYhxshOM8eBdDE+Zs5aCrbe4gH2wnXORepXTPe0lp1YvbQY64j7L8okTlJw07hE5Vw5F
 kHH9jsXVzHIYFacOsmwkpXN+A/RsPFd0diOVSi1yYyEVySRs/OC36B+0rFqGjAQHtII0p5
 ROYKrc0JHnHeQsugAd1h+Nmp19L44t0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586--dZWXJp7M-C7kSrQXn_bPg-1; Mon, 05 Feb 2024 02:47:12 -0500
X-MC-Unique: -dZWXJp7M-C7kSrQXn_bPg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A1AE86890A;
 Mon,  5 Feb 2024 07:47:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9C021C060B2;
 Mon,  5 Feb 2024 07:47:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 53FFC21E60F3; Mon,  5 Feb 2024 08:47:09 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, armbru@redhat.com, berrange@redhat.com,
 eblake@redhat.com, eduardo@habkost.net, fan.ni@samsung.com,
 farosas@suse.de, hreitz@redhat.com, jasowang@redhat.com, jiri@resnulli.us,
 jonathan.cameron@huawei.com, kkostiuk@redhat.com, kraxel@redhat.com,
 kwolf@redhat.com, lukasstraub2@web.de, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 philmd@linaro.org, pizhenwei@bytedance.com, qemu-block@nongnu.org,
 stefanb@linux.ibm.com, wangyanan55@huawei.com
Subject: [PATCH 07/15] qga/qapi-schema: Clean up documentation of
 guest-set-memory-blocks
Date: Mon,  5 Feb 2024 08:47:01 +0100
Message-ID: <20240205074709.3613229-8-armbru@redhat.com>
In-Reply-To: <20240205074709.3613229-1-armbru@redhat.com>
References: <20240205074709.3613229-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 qga/qapi-schema.json | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index b9501c8c81..35bde36a1f 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -43,7 +43,6 @@
         'GuestDiskSmart',
         'GuestDiskStatsInfo',
         'GuestNVMeSmart',
-        'guest-set-memory-blocks',
         'guest-set-vcpus' ] } }
 
 ##
@@ -1174,14 +1173,16 @@
 # Attempt to reconfigure (currently: enable/disable) state of memory
 # blocks inside the guest.
 #
-# The input list is processed node by node in order.  In each node
-# @phys-index is used to look up the guest MEMORY BLOCK, for which
-# @online specifies the requested state.  The set of distinct
-# @phys-index's is only required to be a subset of the guest-supported
-# identifiers.  There's no restriction on list length or on repeating
-# the same @phys-index (with possibly different @online field).
-# Preferably the input list should describe a modified subset of
-# @guest-get-memory-blocks' return value.
+# @mem-blks: The memory blocks to be reconfigured.  This list is
+#     processed node by node in order.  In each node @phys-index is
+#     used to look up the guest MEMORY BLOCK, for which @online
+#     specifies the requested state.  The set of distinct
+#     @phys-index's is only required to be a subset of the
+#     guest-supported identifiers.  There's no restriction on list
+#     length or on repeating the same @phys-index (with possibly
+#     different @online field).  Preferably the input list should
+#     describe a modified subset of @guest-get-memory-blocks' return
+#     value.
 #
 # Returns: The operation results, it is a list of
 #     @GuestMemoryBlockResponse, which is corresponding to the input
-- 
2.43.0


