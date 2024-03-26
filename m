Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350DAC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 07:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp1KW-0004jb-9n; Tue, 26 Mar 2024 03:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KT-0004he-35
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KQ-0005Nn-Ny
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711438478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pHZmUsjp5/CvjIYa17otqFwOMfhaQB0gc4rWACRm1gA=;
 b=d6IBSE8cYJxKKFo5W03viD7xbptPiPcrhiyl/sMh+T6pvKovE2I6uJuCljNwvv74B92BO8
 964s56l8vRtdA5cj37HeGJKM2cspqzdiWmt2+EKJFuLAOLt3e4gmBCh8hOcgsPJ5xk33+w
 Iq12Y1Aoqrp/hWKhX6ASV+QgIQU5ZGI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-QN8nq9KlOKmeT5IWrsHEDQ-1; Tue, 26 Mar 2024 03:34:36 -0400
X-MC-Unique: QN8nq9KlOKmeT5IWrsHEDQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4C9185A58B;
 Tue, 26 Mar 2024 07:34:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3F46492BD3;
 Tue, 26 Mar 2024 07:34:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B221821E5D35; Tue, 26 Mar 2024 08:34:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 15/20] qga/qapi-schema: Refill doc comments to conform to
 current conventions
Date: Tue, 26 Mar 2024 08:34:15 +0100
Message-ID: <20240326073420.738016-16-armbru@redhat.com>
In-Reply-To: <20240326073420.738016-1-armbru@redhat.com>
References: <20240326073420.738016-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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

For legibility, wrap text paragraphs so every line is at most 70
characters long.

To check the generated documentation does not change, I compared the
generated HTML before and after this commit with "wdiff -3".  Finds no
differences.  Comparing with diff is not useful, as the refilled
paragraphs are visible there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240322140910.328840-13-armbru@redhat.com>
---
 qga/qapi-schema.json | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 9554b566a7..d5af155007 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1220,13 +1220,13 @@
 # @signal: signal number (linux) or unhandled exception code (windows)
 #     if the process was abnormally terminated.
 #
-# @out-data: base64-encoded stdout of the process. This field will only
-#     be populated after the process exits.
+# @out-data: base64-encoded stdout of the process.  This field will
+#     only be populated after the process exits.
 #
-# @err-data: base64-encoded stderr of the process. Note: @out-data and
-#     @err-data are present only if 'capture-output' was specified for
-#     'guest-exec'. This field will only be populated after the process
-#     exits.
+# @err-data: base64-encoded stderr of the process.  Note: @out-data
+#     and @err-data are present only if 'capture-output' was specified
+#     for 'guest-exec'.  This field will only be populated after the
+#     process exits.
 #
 # @out-truncated: true if stdout was not fully captured due to size
 #     limitation.
@@ -1273,12 +1273,16 @@
 # An enumeration of guest-exec capture modes.
 #
 # @none: do not capture any output
+#
 # @stdout: only capture stdout
+#
 # @stderr: only capture stderr
+#
 # @separated: capture both stdout and stderr, but separated into
-#             GuestExecStatus out-data and err-data, respectively
-# @merged: capture both stdout and stderr, but merge together
-#          into out-data. not effective on windows guests.
+#     GuestExecStatus out-data and err-data, respectively
+#
+# @merged: capture both stdout and stderr, but merge together into
+#     out-data.  Not effective on windows guests.
 #
 # Since: 8.0
 ##
@@ -1291,8 +1295,9 @@
 #
 # Controls what guest-exec output gets captures.
 #
-# @flag: captures both stdout and stderr if true. Equivalent
-#        to GuestExecCaptureOutputMode::all. (since 2.5)
+# @flag: captures both stdout and stderr if true.  Equivalent to
+#     GuestExecCaptureOutputMode::all.  (since 2.5)
+#
 # @mode: capture mode; preferred interface
 #
 # Since: 8.0
@@ -1315,7 +1320,7 @@
 # @input-data: data to be passed to process stdin (base64 encoded)
 #
 # @capture-output: bool flag to enable capture of stdout/stderr of
-#     running process.  defaults to false.
+#     running process.  Defaults to false.
 #
 # Returns: PID
 #
-- 
2.44.0


