Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07148C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 09:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZSOq-0006Ob-1q; Mon, 12 Feb 2024 04:14:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZSOl-0006Mw-PY
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:14:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZSOi-0003dC-17
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707729282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tS0T8Ort7LSZBJj6vGHcwvlEyt34MpHoHoNdO6Jau7g=;
 b=BHjz9U7iNqxBqaS2h15Cl8Su/Tp7/bFoPDW7ukZjIIimakX2mCbmOFGUpE9tcKwwAYJlDo
 lkU2VfzPqDrMoq/gqgWI1etwGV468toxXO6zEvOQDLbARlt74xNHR2g2IYC/nEJY3LnVF4
 7shGigqwdLjVCW8Jb6awRjdHPTl3RC4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-FAo2zZ_0POa0MkBjdlZj4A-1; Mon,
 12 Feb 2024 04:14:39 -0500
X-MC-Unique: FAo2zZ_0POa0MkBjdlZj4A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13D741C068DB;
 Mon, 12 Feb 2024 09:14:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4EF2105489A;
 Mon, 12 Feb 2024 09:14:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8AF9A21E60F3; Mon, 12 Feb 2024 10:14:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 07/18] qga/qapi-schema: Clean up documentation of
 guest-set-memory-blocks
Date: Mon, 12 Feb 2024 10:14:25 +0100
Message-ID: <20240212091436.688598-8-armbru@redhat.com>
In-Reply-To: <20240212091436.688598-1-armbru@redhat.com>
References: <20240212091436.688598-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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
Message-ID: <20240205074709.3613229-8-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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


