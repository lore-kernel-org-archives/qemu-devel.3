Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F035CC6B10
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcsZ-00070R-Pw; Tue, 13 Oct 2026 09:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGcsT-0006xU-07
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:49:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGcsR-0007ep-FI
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791899349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C33bFGbe6vFhuTIZ9gj1+OdHvbAlbcs7VvvVRD65qyY=;
 b=JNg2hR/WP2WzYjQuM05Loff3iHMFHKs0/AsP9XWT40J6iNFH/JyGuv2dFC4dGGzsQBMeof
 Y6JdIiGpSd+5Dep20HWomWxRp7tCA+zVu26YF227pj+Z2Hc9GRnYM25wUfsdXDY3pLAHe7
 /il3MlAQtCxoIbzK+F5+cRTtkGwYqDs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-XV2WTY-zPR-Jk4N_UxxaeQ-1; Tue,
 13 Oct 2026 13:49:08 +0000
X-MC-Unique: XV2WTY-zPR-Jk4N_UxxaeQ-1
X-Mimecast-MFC-AGG-ID: XV2WTY-zPR-Jk4N_UxxaeQ_1791899347
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32586195C278; Tue, 13 Oct 2026 13:49:07 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 06DDA1956086; Tue, 13 Oct 2026 13:49:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] .skills: fix broken links from .claude/.gemini dirs
Date: Tue, 13 Oct 2026 14:49:04 +0100
Message-ID: <20261013134904.1012071-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

The symlinks were not traversing up to the parent dir.

Fixes: 3e9fe057ae (agents: Add a skill for finding your way around QEMU)
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .claude/skills | 2 +-
 .gemini/skills | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.claude/skills b/.claude/skills
index a7540c24423..2b7a412b8fa 120000
--- a/.claude/skills
+++ b/.claude/skills
@@ -1 +1 @@
-.agents/skills/
\ No newline at end of file
+../.agents/skills
\ No newline at end of file
diff --git a/.gemini/skills b/.gemini/skills
index a7540c24423..2b7a412b8fa 120000
--- a/.gemini/skills
+++ b/.gemini/skills
@@ -1 +1 @@
-.agents/skills/
\ No newline at end of file
+../.agents/skills
\ No newline at end of file
-- 
2.56.0


