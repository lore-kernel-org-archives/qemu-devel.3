Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3F1C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 13:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPL30-0003MJ-EA; Wed, 11 Jun 2025 08:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPL2w-0003Kx-Nr
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:59:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPL2t-0004P4-BP
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749646750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P3Fjc8Y9Fm3yq6VaAxbIc44aXoIS18Wm8eYf0Hwq88c=;
 b=EUAUa5Uv0xhCIF+gkv563Ff+JGlajnk5ndlTLS+RXDtxFmu4KL0WCwKMABgDZSgqExucWq
 1NX3x73H6wQzYQ1dzB+KsDzrOkNpWWCyA5IVwuoQGMyxu0eCudE3JtHZeaiOBRUItZu5yN
 ZWNJCphxY0cY8nRSW5jrBUje40rJV5g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-TlXfuhX1MYu3PpugUsdvLA-1; Wed,
 11 Jun 2025 08:59:06 -0400
X-MC-Unique: TlXfuhX1MYu3PpugUsdvLA-1
X-Mimecast-MFC-AGG-ID: TlXfuhX1MYu3PpugUsdvLA_1749646745
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEE771800343; Wed, 11 Jun 2025 12:59:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.174])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D4C0819560A3; Wed, 11 Jun 2025 12:59:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Haseung Bong <hasueng@gmail.com>
Subject: [PULL 07/10] tests/vm/README: fix documentation path in
 tests/vm/README
Date: Wed, 11 Jun 2025 14:58:43 +0200
Message-ID: <20250611125846.125918-8-thuth@redhat.com>
In-Reply-To: <20250611125846.125918-1-thuth@redhat.com>
References: <20250611125846.125918-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Haseung Bong <hasueng@gmail.com>

The README file in tests/vm/ points to a non-existent file,
docs/devel/testing.rst. Update the README to point to
docs/devel/testing/main.rst, which now contains information
about VM testing.

Signed-off-by: Haseung Bong <hasueng@gmail.com>
Fixes: ff41da50308 ("docs/devel: Split testing docs from the build docs and  move to separate folder")
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250607060456.28902-1-hasueng@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/vm/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/README b/tests/vm/README
index f9c04cc0e75..14ac323309e 100644
--- a/tests/vm/README
+++ b/tests/vm/README
@@ -1 +1 @@
-See docs/devel/testing.rst for help.
+See docs/devel/testing/main.rst for help.
-- 
2.49.0


