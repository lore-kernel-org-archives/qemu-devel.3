Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB56606A339
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CsEr/TDS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVtbg-0000Wm-Ow; Tue, 24 Nov 2026 11:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xVtbH-0000UF-LZ
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 11:42:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xVtbF-0006y7-67
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 11:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795538551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G5Rj4J+LiWWal0GNd6ZntwRuFZYiNjVrYXmpC+bx/C4=;
 b=CsEr/TDSVFEyzQYPO9QrlUm5IMx3nEBhHYdOBCFrz7wYlRa0c3AE9xkbeV+OoVD2Ac+3gV
 D8LQW3aT0unfYOHtKxNRw3cfBNZ+qzMk5bMVGL3mZvm80OyDe0VUMv2uy5Mpz9nClKINYk
 4pm3l7A+CZ9kv7lrCwIFj3XktFAPjNY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-arxDNfenP3qjAVnkcTejNQ-1; Tue,
 24 Nov 2026 16:42:29 +0000
X-MC-Unique: arxDNfenP3qjAVnkcTejNQ-1
X-Mimecast-MFC-AGG-ID: arxDNfenP3qjAVnkcTejNQ_1795538548
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BF2B1955F0C; Tue, 24 Nov 2026 16:42:28 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F36C30001A2; Tue, 24 Nov 2026 16:42:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, peter.maydell@linaro.org, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, alex.bennee@linaro.org
Subject: [PATCH 3/3] AGENTS.md: make the human part of the design process
Date: Tue, 24 Nov 2026 17:42:17 +0100
Message-ID: <20261124164217.1768040-4-pbonzini@redhat.com>
In-Reply-To: <20261124164217.1768040-1-pbonzini@redhat.com>
References: <20261124164217.1768040-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Include further changes to improve the behavior of the agent and steer
it towards discussion with the user.

Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 AGENTS.md | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/AGENTS.md b/AGENTS.md
index d646d548535..31a5c27f542 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -59,6 +59,9 @@ QEMU's policy for AI-assisted work requires the human to develop in-depth
 familiarity with contributions and disclose use of agents to write parts
 of the code.
 
+The golden rule: **The human should know the alternatives before
+implementation. ASK instead of choosing for them**.
+
 ### Human must demonstrate understanding
 
 Staying familiar with what's going on requires constant effort on part of
@@ -79,6 +82,26 @@ In order to protect the project's scarcest resource, which is review time:
 - You must **tell humans about these expectations** at handover.  Even
   when they are engaging actively, remind them about the parts of the
   work they have not examined.
+- When handing over text that the maintainers may see, remind the human
+  that it is a draft and name any design choices that are still open.
+
+### Make the human part of the design process
+
+In order to guide the design rather than providing an all-encompassing
+solution:
+
+- You must **discuss design choices in the main conversation**.  Delegate
+  research to sub-agents but not judgment, and do not treat your own
+  reasoning as a substitute for the conversation.
+- When you consult a subagent, **report what it recommended**, and ask
+  the human to choose between applicable alternatives instead of
+  presenting a single outcome.
+- Report everything you notice that is relevant, for example behavior
+  changes outside the scenario being discussed, and leave the decision to
+  the human.
+- Reinstate as visible text any design decision made while thinking.
+  Design decisions hidden within thinking blocks prevent the human
+  from building familiarity with the contribution.
 
 ### AI usage must be disclosed and/or pre-arranged
 
-- 
2.56.1


