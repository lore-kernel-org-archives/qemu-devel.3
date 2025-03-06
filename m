Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2ECAC282D0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 07:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqS7h-0002wi-64; Fri, 07 Mar 2025 02:27:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tqS7f-0002wN-5a
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:27:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tqS7d-0002Br-E8
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:27:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741332471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=R9IukfbzAvGZFZsNiO8OdJRISK3AikXymEbMouc2hZs=;
 b=SI0t9Dg8EYTceHFA3bjB+Eo0T58ZitmnquID0tDeJP5EneHZCcadCqWy2hovqxp31Gq4qa
 SUeqwdsURtGapXYPfwLM1rApgTIHUDlPYmlclKM1fjRY5FIhTiR5gODyjkSj9IJzsFEkOr
 N/XKDcBfJuPqpSbAsMY68Tmh8iyfD14=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-f3aPkZUaOWewr2rRtXWPYQ-1; Fri,
 07 Mar 2025 02:27:45 -0500
X-MC-Unique: f3aPkZUaOWewr2rRtXWPYQ-1
X-Mimecast-MFC-AGG-ID: f3aPkZUaOWewr2rRtXWPYQ_1741332464
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F1DE19560B7
 for <qemu-devel@nongnu.org>; Fri,  7 Mar 2025 07:27:44 +0000 (UTC)
Received: from localhost (unknown [10.2.16.2])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C3261955DCE; Fri,  7 Mar 2025 07:27:42 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [qemu-web PATCH] Announce Google Summer of Code 2025
Date: Thu,  6 Mar 2025 20:46:39 +0800
Message-ID: <20250306124639.346864-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Let people know that QEMU is participating in Google Summer of Code so
that they can apply for an internship this summer.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 _posts/2025-03-06-gsoc-2025.md | 40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 _posts/2025-03-06-gsoc-2025.md

diff --git a/_posts/2025-03-06-gsoc-2025.md b/_posts/2025-03-06-gsoc-2025.md
new file mode 100644
index 0000000..5c7352f
--- /dev/null
+++ b/_posts/2025-03-06-gsoc-2025.md
@@ -0,0 +1,40 @@
+---
+layout: post
+title:  "Announcing QEMU Google Summer of Code 2025 internships"
+date:   2025-03-06 07:00:00 +0000
+categories: [internships, gsoc]
+---
+QEMU is participating in [Google Summer of
+Code](https://summerofcode.withgoogle.com/) again this year! Google Summer of Code
+is an open source internship program that offers paid remote work
+opportunities for contributing to open source. Internships run May through
+August, so if you have time and want to experience open source development,
+read on to find out how you can apply.
+
+Each intern is paired with one or more mentors, experienced QEMU contributors
+who support them during the internship. Code developed by the intern is
+submitted through the same open source development process that all QEMU
+contributions follow. This gives interns experience with contributing to open
+source software. Some interns then choose to pursue a career in open source
+software after completing their internship.
+
+## Find out if you are eligible
+Information on who can apply for Google Summer of Code is
+[here](https://developers.google.com/open-source/gsoc/faq#what_are_the_eligibility_requirements_for_participation).
+
+## Select a project idea
+Look through the the [list of QEMU project
+ideas](https://wiki.qemu.org/Google_Summer_of_Code_2025) and see if there is
+something you are interested in working on. Once you have found a project idea
+you want to apply for, email the mentor for that project idea to ask any
+questions you may have and discuss the idea further.
+
+## Submit your application
+You can [apply for Google Summer of Code](https://summerofcode.withgoogle.com/)
+from March 24th to April 8th.
+
+Good luck with your applications!
+
+If you have questions about applying for QEMU GSoC, please email
+[Stefan Hajnoczi](mailto:stefanha@gmail.com) or ask on the [#qemu-gsoc IRC
+channel](https://webchat.oftc.net/?channels=qemu-gsoc).
-- 
2.48.1


