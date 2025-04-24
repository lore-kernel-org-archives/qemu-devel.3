Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 847A4C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 21:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u83ov-0005vj-3X; Thu, 24 Apr 2025 17:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1u83os-0005uv-If
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 17:09:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1u83oq-0001Ju-V1
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 17:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745528956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f2Gd4l5OJt8E6olS/WX2slCeQRVOJ0F0HIGale2vGgE=;
 b=Yz3AGDJbNyDdDS8OVmqowxuW3jDMqE3Zpf4A04SI4C9EqK3RwQeEXLVLL5Qvr20RTELJbr
 3zATlMr9gpRgx5XYUrw051LPA5SaZGt4O1wmNWRHFvOBZcPhL6WBiAtVDSw7r5i/tIASAK
 Zaw4TAEXUbAxvydJ68Upo39bwshbw5M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-RAIt_D-jMnujdv1tTEZKdA-1; Thu,
 24 Apr 2025 17:09:14 -0400
X-MC-Unique: RAIt_D-jMnujdv1tTEZKdA-1
X-Mimecast-MFC-AGG-ID: RAIt_D-jMnujdv1tTEZKdA_1745528953
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE5EC180087C; Thu, 24 Apr 2025 21:09:13 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.13])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B868630001A2; Thu, 24 Apr 2025 21:09:11 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 3/6] python: update missing dependencies from minreqs
Date: Thu, 24 Apr 2025 17:09:01 -0400
Message-ID: <20250424210904.2505114-4-jsnow@redhat.com>
In-Reply-To: <20250424210904.2505114-1-jsnow@redhat.com>
References: <20250424210904.2505114-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We pin all dependencies for the "check-minreqs" test because pip lacks a
dependency resolver that installs "the oldest possible package that
meets dependency criteria". So, in order to test our stated minimum
requirements, we pin all of our dependencies (and their dependencies,
transitively) at the oldest possible versions that still work and pass
tests; proving that our minimum requirements are correct.

(It also ensures no new features accidentally sneak in from developers
on newer platforms.)

A few transitive dependencies were omitted from the pinned dependency
file by accident; as a result, pip's dependency solver can pull in newer
dependencies, which we don't want. This patch corrects the previous
oversight and pins the missing dependencies.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/tests/minreqs.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
index a3f423efd84..19c0f5e4c50 100644
--- a/python/tests/minreqs.txt
+++ b/python/tests/minreqs.txt
@@ -38,10 +38,14 @@ pyflakes==2.5.0
 
 # Transitive mypy dependencies
 mypy-extensions==1.0.0
+tomli==1.1.0
 typing-extensions==4.7.1
 
 # Transitive pylint dependencies
 astroid==2.15.4
+dill==0.2
 lazy-object-proxy==1.4.0
+platformdirs==2.2.0
 toml==0.10.0
+tomlkit==0.10.1
 wrapt==1.14.0
-- 
2.48.1


