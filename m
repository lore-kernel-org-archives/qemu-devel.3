Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E0AEA4FBA
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 14:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuWoE-0004I9-DL; Mon, 23 Feb 2026 09:21:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vuWnq-00049c-S3
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 09:20:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vuWnl-0005WT-Cc
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 09:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771856442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Scm4DSpvW+xw8gpGKx93IH1GhSzVYPfAKpbLsLz6tuQ=;
 b=InEprPjWKbX/s98k57+SDC70UBEmeAsMr3qYPWANQ8te2rpQFC3VAqLkibQbzXoKHz6x/v
 AfLK1RqzgEM9a4njp6VoMKItEw5gaha9Y+h0zIClXxHEUfJM/A1jYrRCnhFhHHkHD7i++C
 XvQNoYf/2pspHNcZIeqJz3k9FR93VW8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-eqahkoVVPjSpEHo2_ocQEg-1; Mon,
 23 Feb 2026 09:20:40 -0500
X-MC-Unique: eqahkoVVPjSpEHo2_ocQEg-1
X-Mimecast-MFC-AGG-ID: eqahkoVVPjSpEHo2_ocQEg_1771856440
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23E4618002C1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 14:20:40 +0000 (UTC)
Received: from localhost (unknown [10.2.16.160])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4DB421800669; Mon, 23 Feb 2026 14:20:38 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [qemu-web PATCH] Announce Google Summer of Code 2026
Date: Fri, 20 Feb 2026 16:20:12 -0500
Message-ID: <20260220212012.1061595-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Let people know that QEMU is participating in Google Summer of Code so
that they can apply for an internship this summer.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 _posts/2026-02-20-gsoc-2026.md | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 _posts/2026-02-20-gsoc-2026.md

diff --git a/_posts/2026-02-20-gsoc-2026.md b/_posts/2026-02-20-gsoc-2026.md
new file mode 100644
index 0000000..a5df237
--- /dev/null
+++ b/_posts/2026-02-20-gsoc-2026.md
@@ -0,0 +1,37 @@
+---
+layout: post
+title:  "Announcing QEMU Google Summer of Code 2026 internships"
+date:   2026-02-20 07:00:00 +0000
+categories: [internships, gsoc]
+---
+QEMU is participating in [Google Summer of
+Code](https://summerofcode.withgoogle.com/) once again! Google Summer of Code
+is an open source internship program with internships running May through
+August. Would you like to experience contributing to an open source project?
+This paid remote work internship opportunity is a great way to get involved!
+
+Interns work with experienced QEMU developers who mentor them during the
+internship. Code is submitted through the same open source process that all
+QEMU developers follow. This gives interns experience with contributing to open
+source software.
+
+## Find out if you are eligible
+Information on who can apply for Google Summer of Code is
+[here](https://developers.google.com/open-source/gsoc/faq#what_are_the_eligibility_requirements_for_participation).
+
+## Select a project idea
+Look through the the [list of QEMU project
+ideas](https://wiki.qemu.org/Google_Summer_of_Code_2026) and see if there is
+something you are interested in working on. Once you have found a project idea
+you want to apply for, email the mentor for that project idea to ask any
+questions you may have and discuss the idea further.
+
+## Submit your application
+You can [apply for Google Summer of Code](https://summerofcode.withgoogle.com/)
+from March 16th to 31st.
+
+Good luck with your applications!
+
+If you have questions about applying for QEMU GSoC, please email
+[Stefan Hajnoczi](mailto:stefanha@gmail.com) or ask on the [#qemu-gsoc IRC
+channel](https://webchat.oftc.net/?channels=qemu-gsoc).
-- 
2.53.0


