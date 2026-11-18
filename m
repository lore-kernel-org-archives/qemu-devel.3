Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626CF606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 10:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N6unQP8f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTd7L-00024r-J6; Wed, 18 Nov 2026 05:42:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTd7I-000246-3J
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 05:42:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTd7G-00007d-8i
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 05:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794998533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HTbOy2YsWn6Yog4KK3m8SNiiIs5+e/DFrqSXAofroIo=;
 b=N6unQP8fNY5ZMwu8u3yd6JIBCFQrcbIL1dflpKvEgQvK2U1cctwuaycnYza3iBHhACuH+p
 MJv5Kp2pn7JtCmxDRDbYSxPLNhkiWg/ko57aEAe2PMWpPXX1QZpD5+9GiteX9j2lXoBovp
 pVl3LDeqqDJs2eV/78C8/UKx1oHck4U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-7R8w2HSSME6jBHqVfQtCuw-1; Wed,
 18 Nov 2026 05:42:09 -0500
X-MC-Unique: 7R8w2HSSME6jBHqVfQtCuw-1
X-Mimecast-MFC-AGG-ID: 7R8w2HSSME6jBHqVfQtCuw_1794998528
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87C2F18004F6; Wed, 18 Nov 2026 10:42:07 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D0A96195B3C2; Wed, 18 Nov 2026 10:42:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 3/4] AGENTS.md: make the human part of the design process
Date: Wed, 18 Nov 2026 11:41:49 +0100
Message-ID: <20261118104150.599535-4-pbonzini@redhat.com>
In-Reply-To: <20261118104150.599535-1-pbonzini@redhat.com>
References: <20261118104150.599535-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This came out of the experiment with the first version of the AGENTS.md
file.  This addition improved the behavior of the agent from the very
beginning.  The very first answer to the same prompt was "I'll orient
in the codebase first, then we should talk about design choices before
I write anything".

In fact, after thinking it pointed out from the start that this requires
pre-arrangement and asked two questions (how to represent the pressure and
temperature in the QOM properties, how much of the behavior to implement).
Even with a single data point it seems worth trying.

When asked to commit autonomously, the LLM also clarified that it
wouldn't add S-o-b trailers and that pre-arrangement was on me.
It included "Message written by an AI and to be rewritten by hand; not
for submission as is" in the commit message, a "handover notes"
section about design choices that were made without the user input,
and the umpteenth reminder that the work may only be posted if a
maintainer has agreed beforehand to review them.

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
2.56.0



