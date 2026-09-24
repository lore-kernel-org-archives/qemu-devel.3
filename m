Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322E4C98317
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9jwi-0003hv-J5; Thu, 24 Sep 2026 09:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x9jwO-0003e5-E6
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 09:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x9jwL-00083w-Ql
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 09:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790258202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uYex/vQ3jDbV8L5HdpLi3jtCSIPOqILsHQSzMipdRHs=;
 b=KqXvMXVWI39X96Wd8DDZfi2SgZQZikyyLiM4L1PHHlYCE/tFp6WviiekJC34cHY2E505Ya
 MrbC4dFApeoZ5fMrPrnfoqgQhDbYJKnZG9RiLgxEY66QmUTv/c5k5dgppb362gP7Ij7ynw
 5agybta+1cc9A/ss8zspkpcg6rNDsTs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-eftlL9lsOIiQInRE8D1wrQ-1; Thu,
 24 Sep 2026 09:56:38 -0400
X-MC-Unique: eftlL9lsOIiQInRE8D1wrQ-1
X-Mimecast-MFC-AGG-ID: eftlL9lsOIiQInRE8D1wrQ_1790258197
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D05F3195FD01; Thu, 24 Sep 2026 13:56:36 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E68318004D4; Thu, 24 Sep 2026 13:56:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [qemu-web PATCH] contribute: define clear limits on bug report volume
Date: Thu, 24 Sep 2026 14:56:34 +0100
Message-ID: <20260924135634.2626603-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Recently QEMU has received a denial of service attack on
its bug tracker in the form of 120 reports in 10 minutes,
and now repeated by another reporter in the form of 50
reports in the same day.

Prior to switching security disclosures to the bug tracker,
single reporters have submited 18, 22, and 114 bug reports.

None of this is sustainable. It is an effective denial of
service attack on the project maintainers' time. Every bug
report is a TODO item added to someone's workload.

It is time to put hard limits on how many bugs, discovered
with assitance of automated tools, we are willing to accept
in a givenm time frame.

This patch proposal suggests

 * No more than 5 bugs per week, per reporter
 * No more than 10 bugs are permitted to be open at any
   time, per reporter.

This is explicitly scoped to bugs discovered with the assistance
of automated tools. Bugs where a human puts in exclusively
personal time / effort to discover a problem are not limited.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 contribute/report-a-bug.md | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/contribute/report-a-bug.md b/contribute/report-a-bug.md
index b506f9f..8fb7b0b 100644
--- a/contribute/report-a-bug.md
+++ b/contribute/report-a-bug.md
@@ -32,6 +32,43 @@ on GitLab, taking into account the following guidance.
   triage of their output to validate all findings and reproducer
   scenarios prior to submitting a bug report.
 
+* QEMU policy forbids the bulk filing of large numbers of
+  bug disclosures that were generated with automated tools
+  (AI/LLM, static analysis, fuzers). Such actions are not
+  a benefit to the project, placing an unsustainable burden
+  on maintainers.
+
+  * **No more than 5 bug/security reports, discovered
+    with assistance of automated tools, are permitted
+    to be filed per week, per reporter.**
+  * **No more than 10 bug/security reports, discovered
+    with assistance of automated tools are permitted
+    to be open at any time, per reporter.**
+  * Reporters must refrain from filing any reports
+    that would cause these thresholds to be exceeded
+    without first obtaining explicit prior permission
+    from project maintainers.
+  * Reporters are **required** to respond to triage
+    comments from maintainers on bugs related to
+    automated tools on a timely basis.
+  * If at any time, the project maintainers request
+    the reporter to stop filing bug reports discovered
+    with assistance of automated tools, this must be
+    honoured.
+
+  Ignoring any of the above rules may lead to the bugs being
+  mass closed without further triage, even if valid reports.
+  In cases where the filing limits are grossly exceeded,
+  the reporter's GitLab account may be reported for abuse
+  (spam), potentially leading to termination.
+
+  If intending to file large numbers of bug disclosures
+  in aggregate, reporters are expected to invest their
+  time in writing patches, providing the patches for
+  review, and then further responding to feedback and
+  iterating on the patches until a maintainer accepts
+  them for it.
+
 * Reproduce the problem directly with a QEMU command-line. Avoid
   frontends and management stacks, to ensure that the bug is in
   QEMU itself and not in a frontend and make it easier for
-- 
2.55.0


