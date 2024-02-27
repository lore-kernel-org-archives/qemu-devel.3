Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC8FC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 11:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1revoI-0000CD-4o; Tue, 27 Feb 2024 06:39:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1revo7-0008WE-6P
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 06:39:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1revnz-0005Uj-Vn
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 06:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709033967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hTSIV2PnHuSPoa1C+gFm8bCyXTRYgB8cCk6z5RHAu/o=;
 b=SNVOGZgeQSeTNHNA6c6VIlIB3DLHum2krsgN2kpKqTQYVkAgL90VN75pk7gv8/hJXFRCDu
 IL73K814HqrOy0W4y71KtwtINJLa4Cj7hdE+xVWp4Zrdaasw5Z0tnjjVQsHlIstfHnYvQk
 A6jkVqonDcnO0VDhy2uy4D189bTt2S4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-QktF-KDpO1-ayMNQhr_pCg-1; Tue,
 27 Feb 2024 06:39:23 -0500
X-MC-Unique: QktF-KDpO1-ayMNQhr_pCg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95A8528B6982;
 Tue, 27 Feb 2024 11:39:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7368814EF;
 Tue, 27 Feb 2024 11:39:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 49F3521E66D0; Tue, 27 Feb 2024 12:39:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, jsnow@redhat.com, eblake@redhat.com,
 kkostiuk@redhat.com
Subject: [PATCH 11/13] qga/qapi-schema: Tweak documentation of fsfreeze
 commands
Date: Tue, 27 Feb 2024 12:39:19 +0100
Message-ID: <20240227113921.236097-12-armbru@redhat.com>
In-Reply-To: <20240227113921.236097-1-armbru@redhat.com>
References: <20240227113921.236097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
2.43.0


