Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51423C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 11:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUQ9d-0004IS-RM; Mon, 29 Jan 2024 06:50:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rUQ9a-0004Go-0j
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 06:50:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rUQ9X-0005EO-BX
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 06:50:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706529014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pGdUsUnbEy3JNxMMv0OslAob2ajcoIuhX9HMXPICg98=;
 b=MHftfld70SAGaESJwYrZIylCcjAJEGHJF79+Tc6MTVNxic/VhyGKIaMWnSl3ZqoFjJ86Io
 f8MR/qAitHRRWuzXrBH6O11s63zqxDWYAYiwlEQ3LflyCX/Quq+u5e69wYHH0mo9rqBz+i
 oKf6TMAph/UdSMX5RWq7SLlzmX2FQDo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-DRuzPmNzOvq7BsQD5qM2Fw-1; Mon, 29 Jan 2024 06:50:10 -0500
X-MC-Unique: DRuzPmNzOvq7BsQD5qM2Fw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A35F286EB23;
 Mon, 29 Jan 2024 11:50:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 84110111E9;
 Mon, 29 Jan 2024 11:50:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8C26821E66F2; Mon, 29 Jan 2024 12:50:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 michael.roth@amd.com, kkostiuk@redhat.com, qemu-block@nongnu.org
Subject: [PATCH 2/5] qapi: Drop redundant documentation of conditional
Date: Mon, 29 Jan 2024 12:50:05 +0100
Message-ID: <20240129115008.674248-3-armbru@redhat.com>
In-Reply-To: <20240129115008.674248-1-armbru@redhat.com>
References: <20240129115008.674248-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Documentation generated for dump-skeys contains

    This command is only supported on s390 architecture.

and

    If
    ~~

    "TARGET_S390X"

The former became redundant in commit 901a34a400a (qapi: add 'If:'
section to generated documentation) added the latter.  Drop the
former.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/misc-target.json | 2 --
 1 file changed, 2 deletions(-)

diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 9195e7d26b..03e83c053f 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -237,8 +237,6 @@
 #
 # @filename: the path to the file to dump to
 #
-# This command is only supported on s390 architecture.
-#
 # Since: 2.5
 #
 # Example:
-- 
2.43.0


