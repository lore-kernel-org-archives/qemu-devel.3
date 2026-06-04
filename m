Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9C5CD6E77
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 16:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVBHh-0004H3-KI; Thu, 04 Jun 2026 12:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wVBHf-0004GB-Oh
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 12:51:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wVBHd-0000kK-SJ
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 12:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780591864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=STby0QuBkc+Vmuw0G5a4XWwhUsqCQeSe1oJbAwCl8wc=;
 b=GnzL9yQ3QEE6fQje/TtEQ7lOLbTgNn+39QuJAwGgpPdQUVoGfvv/ZlGAgZk38NaMAFbvDt
 pJcLg087TNfKGRT5UEco7hYw2geEIQ8JU3vmwamC38L+jueKQ5zjYBFdliRtrL4bJf+bR5
 UGMIkd5Cw1Cl2b3LBxXwMVYal/yEsE4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-0v5h212KMuWl99eaDMpwaA-1; Thu,
 04 Jun 2026 12:51:01 -0400
X-MC-Unique: 0v5h212KMuWl99eaDMpwaA-1
X-Mimecast-MFC-AGG-ID: 0v5h212KMuWl99eaDMpwaA_1780591859
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9E1E195608B; Thu,  4 Jun 2026 16:50:58 +0000 (UTC)
Received: from berrange.com (unknown [10.44.50.34])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 259B1180049F; Thu,  4 Jun 2026 16:50:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [qemu-web RFC 1/3] contribute: reformat/restructure bug report
 guidance
Date: Thu,  4 Jun 2026 17:50:46 +0100
Message-ID: <20260604165048.457860-2-berrange@redhat.com>
In-Reply-To: <20260604165048.457860-1-berrange@redhat.com>
References: <20260604165048.457860-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The current bug report bullet points are duplicating an
arbitrary subset of what is already requested in the gitlab
issue template. Rewrite the guidance such that it refers to
the issue template fields being required, where applicable.
Restructure the text in general so that it is all a bullet
point list rather than a strange mix of list items and
separate paragraphs.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 contribute/report-a-bug.md | 55 +++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/contribute/report-a-bug.md b/contribute/report-a-bug.md
index 8a7c782..6071837 100644
--- a/contribute/report-a-bug.md
+++ b/contribute/report-a-bug.md
@@ -3,26 +3,37 @@ title: Reporting a bug
 permalink: /contribute/report-a-bug/
 ---
 
-Bugs can be filed at our
+Bugs affecting upstream QEMU releases should be filed at our
 [bug tracker](https://gitlab.com/qemu-project/qemu/-/issues), which is hosted
-on GitLab. Note: If you've got a problem with how your Linux distribution
-packages QEMU, please use the bug tracker from your distro instead.
-
-When submitting a bug report, please try to do the following:
-
-* Include the QEMU release version or the git commit hash into the description, so that it is later still clear in which version you have found the bug.  Reports against the [latest release](/download/#source) or even the latest development tree are usually acted upon faster.
-
-* Include the full command line used to launch the QEMU guest.
-
-* Reproduce the problem directly with a QEMU command-line.  Avoid frontends and management stacks, to ensure that the bug is in QEMU itself and not in a frontend.
-
-* Include information about the host and guest (operating system, version, 32/64-bit).
-
-QEMU does not use GitLab merge requests; patches are sent to the mailing list according to QEMU's [patch submissions guidelines](../submit-a-patch/).
-
-Do NOT report security issues (or other bugs, too) as "confidential" bugs in the
-bug tracker.  QEMU has a [security process](../security-process) for issues
-that should be reported in a non-public way instead.
-
-For problems with KVM in the kernel, use the kernel bug tracker instead;
-the [KVM wiki](https://www.linux-kvm.org/page/Bugs) has the details.
+on GitLab, taking into account the following guidance.
+
+* Use the provided GitLab issue template, filling in all
+  requested pieces of information that are relevant to the
+  discovered bug.
+
+* Reproduce the problem with the latest upstream QEMU release.
+  Reports against older versions may not be acted upon with
+  with the same priority.
+
+* Problems that have only been demonstrated with an release
+  packaged by an OS distribution vendor must be either reported
+  to the vendor's own bug tracker instead, or reproduced with
+  an upstream QEMU build prior to submission.
+
+* Reproduce the problem directly with a QEMU command-line. Avoid
+  frontends and management stacks, to ensure that the bug is in
+  QEMU itself and not in a frontend and make it easier for
+  maintainers to understand the problematic scenario.
+
+* If patches are available for an issue, they should be sent to
+  the mailing list according to QEMU's [patch submissions
+  guidelines](../submit-a-patch/). QEMU does not use a merge
+  request workflow for contribution.
+
+* Do NOT report security issues (or other bugs, too) as "confidential"
+  bugs in the bug tracker.  QEMU has a [security process](../security-process)
+  for issues that should be reported in a non-public way instead.
+
+* If the problem is believed to lie in the KVM kernel module,
+  following the [KVM wiki bug report](https://www.linux-kvm.org/page/Bugs)
+  guidance to submit an issue to the kernel bug tracker.
-- 
2.54.0


