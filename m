Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578BFC47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 14:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnfaO-00038K-Et; Fri, 22 Mar 2024 10:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfaN-00034D-Dy
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:09:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfaH-0003ZC-M1
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711116565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S4C55i6IAIl4qPCE77V/yWVbt/+VSC8lBH0rGwhYOs4=;
 b=gvQ0rXXNgv1dCWuNTdRCUgtzOG0/xiljRhl+qccBTz42mPEskSfeMLtwfayDh6oSomq2IQ
 5Q/PmsUWo8tGMU60mJGNPxwap70Zmk8lhbll2dtRS30AZVWxTCR+yhM9enGPO9kMymJEAY
 PWmyj0FhmZaUlifXIMRkLjuS7J6CX5g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-wuxf7zdxN4ix8PjcEiKnKQ-1; Fri,
 22 Mar 2024 10:09:21 -0400
X-MC-Unique: wuxf7zdxN4ix8PjcEiKnKQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED4FE282D3CF;
 Fri, 22 Mar 2024 14:09:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCE5D492BD3;
 Fri, 22 Mar 2024 14:09:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E08DE21E5D32; Fri, 22 Mar 2024 15:09:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com,
	michael.roth@amd.com,
	kkostiuk@redhat.com
Subject: [PATCH 12/12] qga/qapi-schema: Refill doc comments to conform to
 current conventions
Date: Fri, 22 Mar 2024 15:09:10 +0100
Message-ID: <20240322140910.328840-13-armbru@redhat.com>
In-Reply-To: <20240322140910.328840-1-armbru@redhat.com>
References: <20240322140910.328840-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


