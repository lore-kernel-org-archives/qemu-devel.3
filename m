Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F92C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 06:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh1t8-0005ku-Fb; Mon, 04 Mar 2024 01:33:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sY-0005YM-6g
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sR-00008T-Js
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709533962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PodDuA9Z2AzM6J1ckpRmgJtCGOPIO57g00FZEAHTzbM=;
 b=An9/Fv5hIQnUNsRvwNDtBg5QuZfebSXqCavd9vnT+z1r30A0vDRKsOsM4TFGys0kubzacU
 sWPawHl7y2Tcx9L/uB7Z5Q5hkA9VQ4FADsSKpisehda+Ym3o7oMCTaJxRFJaWX9TvNvWuQ
 Q0lEGvjCV9uG2TD5fP1+xevOlzCSSn4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-PPTQw3LLOoGbYssaMvHg0w-1; Mon, 04 Mar 2024 01:32:39 -0500
X-MC-Unique: PPTQw3LLOoGbYssaMvHg0w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31836811E79;
 Mon,  4 Mar 2024 06:32:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EA5B492BE2;
 Mon,  4 Mar 2024 06:32:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8989C21E6829; Mon,  4 Mar 2024 07:32:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 11/18] qga/qapi-schema: Tweak documentation of fsfreeze commands
Date: Mon,  4 Mar 2024 07:32:29 +0100
Message-ID: <20240304063236.213955-12-armbru@redhat.com>
In-Reply-To: <20240304063236.213955-1-armbru@redhat.com>
References: <20240304063236.213955-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

"Returns:" sections of guest-fsfreeze-freeze and
guest-fsfreeze-freeze-list describe both command behavior and success
response.  Move behavior out, so "Returns:" is only about success
response.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240227113921.236097-12-armbru@redhat.com>
---
 qga/qapi-schema.json | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 326d324901..2ea1022092 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -437,15 +437,16 @@
 # command succeeded, you may call @guest-fsfreeze-thaw later to
 # unfreeze.
 #
+# On error, all filesystems will be thawed.  If no filesystems are
+# frozen as a result of this call, then @guest-fsfreeze-status will
+# remain "thawed" and calling @guest-fsfreeze-thaw is not necessary.
+#
+# Returns: Number of file systems currently frozen.
+#
 # Note: On Windows, the command is implemented with the help of a
 #     Volume Shadow-copy Service DLL helper.  The frozen state is
 #     limited for up to 10 seconds by VSS.
 #
-# Returns: Number of file systems currently frozen.  On error, all
-#     filesystems will be thawed.  If no filesystems are frozen as a
-#     result of this call, then @guest-fsfreeze-status will remain
-#     "thawed" and calling @guest-fsfreeze-thaw is not necessary.
-#
 # Since: 0.15.0
 ##
 { 'command': 'guest-fsfreeze-freeze',
@@ -457,12 +458,13 @@
 # Sync and freeze specified guest filesystems.  See also
 # @guest-fsfreeze-freeze.
 #
+# On error, all filesystems will be thawed.
+#
 # @mountpoints: an array of mountpoints of filesystems to be frozen.
 #     If omitted, every mounted filesystem is frozen.  Invalid mount
 #     points are ignored.
 #
-# Returns: Number of file systems currently frozen.  On error, all
-#     filesystems will be thawed.
+# Returns: Number of file systems currently frozen.
 #
 # Since: 2.2
 ##
-- 
2.44.0


