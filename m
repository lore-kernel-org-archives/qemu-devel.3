Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5DAD17128
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 19:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2xmo-0001Dx-Px; Mon, 21 Oct 2024 15:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2xmm-0001Dp-RI
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 15:09:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2xmk-0006KY-1o
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 15:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729537784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SJV8rRKShLNxKjnu54gcfXVhvQrj2GsZHPoXPbo3Aaw=;
 b=efwU5xwGWinIrUmq/uCmjN2xRW/k3xl9iZKc8I/sz0zQj2yGDpAY3Bg5HDIatR7tnavAko
 RvoHo7F5UdKEmEdwGgKif2dl3cUtR1bTqEiohwY3EAxmd8+VMXpxgY4yKJo+b1pEa/0TTq
 240KnkGT0C3+fkgoGRAw3WFZFWp+gTc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-sKo1rQ-TOe-m0SaH7mlvsg-1; Mon,
 21 Oct 2024 15:09:42 -0400
X-MC-Unique: sKo1rQ-TOe-m0SaH7mlvsg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B20901955DB2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 19:09:41 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B75B61955F30; Mon, 21 Oct 2024 19:09:40 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] docs: explicitly permit a "commonly known identity" with SoB
Date: Mon, 21 Oct 2024 20:09:39 +0100
Message-ID: <20241021190939.1482466-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The docs for submitting a patch describe using your "Real Name" with
the Signed-off-by line. Although somewhat ambiguous, this has often
been interpreted to mean someone's legal name.

In recent times, there's been a general push back[1] against the notion
that use of Signed-off-by in a project automatically requires / implies
the use of legal ("real") names and greater awareness of the downsides.

Full discussion of the problems of such policies is beyond the scope of
this commit message, but at a high level they are liable to marginalize,
disadvantage, and potentially result in harm, to contributors.

TL;DR: there are compelling reasons for a person to choose distinct
identities in different contexts & a decision to override that choice
should not be taken lightly.

A number of key projects have responded to the issues raised by making
it clear that a contributor is free to determine the identity used in
SoB lines:

 * Linux has clarified[2] that they merely expect use of the
   contributor's "known identity", removing the previous explicit
   rejection of pseudonyms.

 * CNCF has clarified[3] that the real name is simply the identity
   the contributor chooses to use in the context of the community
   and does not have to be a legal name, nor birth name, nor appear
   on any government ID.

Since we have no intention of ever routinely checking any form of ID
documents for contributors[4], realistically we have no way of knowing
anything about the name they are using, except through chance, or
through the contributor volunteering the information. IOW, we almost
certainly already have people using pseudonyms for contributions.

This proposes to accept that reality and eliminate unnecessary friction,
by following Linux & the CNCF in merely asking that a contributors'
commonly known identity, of their choosing, be used with the SoB line.

[1] Raised in many contexts at many times, but a decent overall summary
    can be read at https://drewdevault.com/2023/10/31/On-real-names.html
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d4563201f33a022fc0353033d9dfeb1606a88330
[3] https://github.com/cncf/foundation/blob/659fd32c86dc/dco-guidelines.md
[4] Excluding the rare GPG key signing parties for regular maintainers

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/check-dco.py         | 5 ++++-
 docs/devel/submitting-a-patch.rst | 7 ++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/check-dco.py b/.gitlab-ci.d/check-dco.py
index 632c8bcce8..6a06afffe5 100755
--- a/.gitlab-ci.d/check-dco.py
+++ b/.gitlab-ci.d/check-dco.py
@@ -79,7 +79,10 @@
 
 To indicate acceptance of the DCO every commit must have a tag
 
-  Signed-off-by: REAL NAME <EMAIL>
+  Signed-off-by: YOUR NAME <EMAIL>
+
+where "YOUR NAME" is your commonly known identity in the context
+of the community.
 
 This can be achieved by passing the "-s" flag to the "git commit" command.
 
diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index 83e9092b8c..10b062eec2 100644
--- a/docs/devel/submitting-a-patch.rst
+++ b/docs/devel/submitting-a-patch.rst
@@ -18,7 +18,7 @@ one-shot fix, the bare minimum we ask is that:
 
    * - Check
      - Reason
-   * - Patches contain Signed-off-by: Real Name <author@email>
+   * - Patches contain Signed-off-by: Your Name <author@email>
      - States you are legally able to contribute the code. See :ref:`patch_emails_must_include_a_signed_off_by_line`
    * - Sent as patch emails to ``qemu-devel@nongnu.org``
      - The project uses an email list based workflow. See :ref:`submitting_your_patches`
@@ -335,6 +335,11 @@ include a "From:" line in the body of the email (different from your
 envelope From:) that will give credit to the correct author; but again,
 that author's Signed-off-by: line is mandatory, with the same spelling.
 
+The name used with "Signed-off-by" does not need to be your legal name,
+nor birth name, nor appear on any government ID. It is the identity you
+choose to be known by in the community, but should not be anonymous,
+nor misrepresent whom you are.
+
 There are various tooling options for automatically adding these tags
 include using ``git commit -s`` or ``git format-patch -s``. For more
 information see `SubmittingPatches 1.12
-- 
2.46.0


