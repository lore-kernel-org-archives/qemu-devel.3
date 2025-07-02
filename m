Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC9AC83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 08:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWsjA-0001KM-7C; Wed, 02 Jul 2025 04:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uWsj7-0001Jt-FN
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 04:21:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uWsiz-00049h-BZ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 04:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751444505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xk424RQ1ZwDMTwBH2RMNfL83+gFiQj0dMd6/NPEnP58=;
 b=RKOAp8PlSxlCIP8HdA0AlBSym2VPgU8h73ORJx0CJRAHClDXP2z2IuQWtWGpLKme7Dv2Du
 oG7sYHgONYfxKDmZXfRvVk+ybLRQQynGZGcUhDK20wfta7+ozJbPXeRAlhOWEF6Wi108k5
 6lJRGa+SIL7OzNiCYhZGzRrqlfXdQcc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-KUySrqKSMB6OER04QCH8Lw-1; Wed,
 02 Jul 2025 04:21:43 -0400
X-MC-Unique: KUySrqKSMB6OER04QCH8Lw-1
X-Mimecast-MFC-AGG-ID: KUySrqKSMB6OER04QCH8Lw_1751444502
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3CD01944AA9; Wed,  2 Jul 2025 08:21:42 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.120])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9591019560AB; Wed,  2 Jul 2025 08:21:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	qemu-trivial@nongnu.org
Subject: [PATCH] docs/system/target-i386: Remove the sentence about RHEL 7
 being supported
Date: Wed,  2 Jul 2025 10:21:38 +0200
Message-ID: <20250702082138.23109-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

According to our "Supported build platforms" policy, RHEL 7 is not
supported anymore, so let's remove the related sentence from the x86
documentation.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/system/target-i386.rst | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/docs/system/target-i386.rst b/docs/system/target-i386.rst
index 43b09c79d6b..2374391397c 100644
--- a/docs/system/target-i386.rst
+++ b/docs/system/target-i386.rst
@@ -37,6 +37,4 @@ OS requirements
 ~~~~~~~~~~~~~~~
 
 On x86_64 hosts, the default set of CPU features enabled by the KVM
-accelerator require the host to be running Linux v4.5 or newer. Red Hat
-Enterprise Linux 7 is also supported, since the required
-functionality was backported.
+accelerator require the host to be running Linux v4.5 or newer.
-- 
2.50.0


