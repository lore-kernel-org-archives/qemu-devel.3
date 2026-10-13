Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556DCCC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGctE-00077N-MC; Tue, 13 Oct 2026 09:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGct6-000776-43
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:49:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGcsw-0007hq-Th
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791899381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=344bfXsTirExeIIKDAvkJ73JggZDfSUgnKzKrIHpnrg=;
 b=A42vRdiJ2gcQkf9pQQJpODVtqQACdQ5JHw/e04wUCu0kEWOPpgJiFsWoaX3CqdEHaiPMNj
 w9tiY3O4xEOLm10wrRAHRBa2rhzf4tGJ2wSB5P4IU+yw0acGcuEBvInuIoR05sccEr+xUO
 nWQimVYP4Ldsr9BX4hejy0z7otWa4PQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-QVadmnG8N-SDDhsDIegUUQ-1; Tue,
 13 Oct 2026 13:49:40 +0000
X-MC-Unique: QVadmnG8N-SDDhsDIegUUQ-1
X-Mimecast-MFC-AGG-ID: QVadmnG8N-SDDhsDIegUUQ_1791899378
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 188191956041
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 13:49:38 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2571E427; Tue, 13 Oct 2026 13:49:36 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3] .claude: delete obsolete/redundant link to AGENTS.md
Date: Tue, 13 Oct 2026 14:49:36 +0100
Message-ID: <20261013134936.1012354-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

From the release notes for Claude Code 2.1.277:

  https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md

  "Added AGENTS.md support: in a project with no CLAUDE.md,
   Claude Code reads AGENTS.md instead"

Version 2.1.281 fixed a few further bugs

  "Changed AGENTS.md support to also work on Amazon Bedrock,
   Google Vertex AI, Microsoft Foundry, LLM gateways, and sessions
   with telemetry disabled"

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
2.56.0


