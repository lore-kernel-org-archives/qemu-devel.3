Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A0FE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 14:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTj70-0002yq-KV; Fri, 03 Jan 2025 09:57:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTj6y-0002yK-VM
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:57:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTj6w-0001bN-At
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:57:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735916232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4fm99VWae0ATbDo3ay8bHhNE5ulfguEtt6NDfcQ2Rk8=;
 b=IHPLwBV3L6bvP3OLYQeFiQuML3pFd+VCa/pmJ662xGS3fZIll7NlCs6BK3Uni+L1Au9aSk
 ZpO2q+FUB+0dw3bT0LY/Yu6DFwVgKJOWpSsbzJzJQTr5TOC8hlCV9/xfdpM+WUOG4/vmZU
 1/SSX2CZLrhy3ulwpTvY3v5XFEbacLg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-mBjBn5P-NH2t7Phhvh8KAg-1; Fri,
 03 Jan 2025 09:57:07 -0500
X-MC-Unique: mBjBn5P-NH2t7Phhvh8KAg-1
X-Mimecast-MFC-AGG-ID: mBjBn5P-NH2t7Phhvh8KAg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 837D71956095; Fri,  3 Jan 2025 14:57:06 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.148])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 72B16300F9B5; Fri,  3 Jan 2025 14:57:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] docs/about/deprecated: Remove paragraph about initial
 deprecation in 2.10
Date: Fri,  3 Jan 2025 15:57:02 +0100
Message-ID: <20250103145702.597139-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

When we introduced the deprecation rule of keeping deprecated features
for two more releases, we had to state that we would not remove features
by surprise that had already been marked as deprecated before. Nowadays,
this paragraph is not needed anymore, so we can remove it now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index d6809f94ea..25653889bd 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -24,12 +24,6 @@ should exclusively use a non-deprecated machine type, with use of the most
 recent version highly recommended. Non-versioned machine types follow the
 general feature deprecation policy.
 
-Prior to the 2.10.0 release there was no official policy on how
-long features would be deprecated prior to their removal, nor
-any documented list of which features were deprecated. Thus
-any features deprecated prior to 2.10.0 will be treated as if
-they were first deprecated in the 2.10.0 release.
-
 What follows is a list of all features currently marked as
 deprecated.
 
-- 
2.47.1


