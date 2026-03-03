Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4B3EDA680
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxRL5-00075n-DE; Tue, 03 Mar 2026 10:07:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxRL1-0006u8-2I
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:07:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxRKz-0002As-9f
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772550424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VR8XVtiHpwhfhggW4CuS+Mz92pEJgvPt3ro8FGlcU0w=;
 b=M1ZohkTGdcgIdW4c/SlxNfPDtD8SbxXdOwCzaM6FmswdGyna4KCyyr5hwoPfcaqREXJnG4
 /T/XQh2xMTSMHUBmLdTl5tPmMe1JGnYW0FpPrgtErsJW7OvM3xStCqnwnD6Pyj5KHlF7uN
 L9q082rkYIugcWFjWQBXtNrMs3ewcqM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-9M1hemwENuG3EAGq_06TBA-1; Tue,
 03 Mar 2026 10:07:03 -0500
X-MC-Unique: 9M1hemwENuG3EAGq_06TBA-1
X-Mimecast-MFC-AGG-ID: 9M1hemwENuG3EAGq_06TBA_1772550422
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 647691956061
 for <qemu-devel@nongnu.org>; Tue,  3 Mar 2026 15:07:02 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.45.225.185])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2DBFA1800349; Tue,  3 Mar 2026 15:07:00 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 26/27] scripts/checkpatch: Fix MAINTAINERS update warning with
 --terse
Date: Tue,  3 Mar 2026 15:06:03 +0000
Message-ID: <20260303150604.2402872-27-berrange@redhat.com>
In-Reply-To: <20260303150604.2402872-1-berrange@redhat.com>
References: <20260303150604.2402872-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Markus Armbruster <armbru@redhat.com>

We recently improved the MAINTAINERS update warning to show the files
that trigger it.  Example:

    WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
    #105:
    deleted file mode 100644

improved to

    WARNING: added, moved or deleted file(s):

      migration/threadinfo.h
      migration/threadinfo.c

    Does MAINTAINERS need updating?

Unfortunately, this made things worse with --terse, as only the first
line of each warning is shown then.

    WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

became

    WARNING: added, moved or deleted file(s):

Adjust the warning text to

    WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
      migration/threadinfo.h
      migration/threadinfo.c

so we get the exact same warning as we used to with --terse.

Fixes: 1d745e6d9635 (scripts/checkpatch: use new hook for MAINTAINERS update check)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[DB: fix typo with missing string concat operator]
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/checkpatch.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 45b1153a9c..b77bd69328 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1474,9 +1474,9 @@ sub process_file_list {
 
 	# If we don't see a MAINTAINERS update, prod the user to check
 	if (int(@maybemaintainers) > 0 && !$sawmaintainers) {
-		WARN("added, moved or deleted file(s):\n\n  " .
-		     join("\n  ", @maybemaintainers) .
-		     "\n\nDoes MAINTAINERS need updating?\n");
+                WARN("added, moved or deleted file(s),"
+		     . " does MAINTAINERS need updating?\n  "
+		     . join("\n  ", @maybemaintainers));
 	}
 }
 
-- 
2.53.0


