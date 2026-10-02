Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6800ACA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 11:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCbdX-0004Hp-9R; Fri, 02 Oct 2026 07:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCbdV-0004Hg-N5
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:41:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCbdU-0005bF-1k
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790941266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=byQ7l79WxApR6v6tsR75pblqh7ujLCd1ikO5V7TH2CE=;
 b=IVYUhEie1mRDa6Ya53B8QRYkm800zuZRxn42WteSwFNWJ6/4/FVI11Ea1KLFmwtwwJ58o8
 su9Vm4ND9P5UNI/iauzPf0jngssWCN5FNRLl1efc+UPyNgUk9hziabNkGh0OFqtp2xU3vl
 ebWeDb/lfWcqSN5jSufruJ8HsmOhAqo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-nb13q_VsNVyI_-clOpzrUA-1; Fri,
 02 Oct 2026 07:41:03 -0400
X-MC-Unique: nb13q_VsNVyI_-clOpzrUA-1
X-Mimecast-MFC-AGG-ID: nb13q_VsNVyI_-clOpzrUA_1790941262
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5FE7183092E
 for <qemu-devel@nongnu.org>; Fri,  2 Oct 2026 11:41:02 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B69D71956047; Fri,  2 Oct 2026 11:41:01 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2] .claude: delete obsolete/redundant link to AGENTS.md
Date: Fri,  2 Oct 2026 12:41:00 +0100
Message-ID: <20261002114100.3714102-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From the release notes for Claude Code 2.1.77:

  https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md

  "Added AGENTS.md support: in a project with no CLAUDE.md,
   Claude Code reads AGENTS.md instead"

If we assume people will keep their Claude Code updated, then the
.claude rules we added to link to AGENTS.md are now redundant, or
very soon will be.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .claude/rules/agents-md.md | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 .claude/rules/agents-md.md

diff --git a/.claude/rules/agents-md.md b/.claude/rules/agents-md.md
deleted file mode 100644
index 43c994c2d36..00000000000
--- a/.claude/rules/agents-md.md
+++ /dev/null
@@ -1 +0,0 @@
-@AGENTS.md
-- 
2.55.0


