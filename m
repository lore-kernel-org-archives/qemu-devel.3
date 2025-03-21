Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E75C36007
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 22:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvkmd-0002Ja-FI; Fri, 21 Mar 2025 18:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tvkmb-0002J6-El
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 18:24:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tvkma-0004Pm-1I
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 18:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742595843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+3n1Wdr5voD8QqE86NyEV8Txx93IIuxjGvYLZnSxS1U=;
 b=Ksk2UKk0AZOOqBAJ6ZInNq8Rsz2wDQWIrgenyNhz9RQGMl2gul/aq0Qm3oLmlUlWv2m7jm
 3u0HJN2805smeNNRstHXj6JyQvURa5QGd0yabZguT+Y3ihqr2exyOqIVtKZ7I18Joz5jO+
 kbAH5USYUII4ZJdBqkQQaMnRrPzHUpA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-yy0-D-8kPxm5N_tGCJkiQA-1; Fri,
 21 Mar 2025 18:24:01 -0400
X-MC-Unique: yy0-D-8kPxm5N_tGCJkiQA-1
X-Mimecast-MFC-AGG-ID: yy0-D-8kPxm5N_tGCJkiQA_1742595841
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6BEC1800EC5; Fri, 21 Mar 2025 22:24:00 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.31])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5ED683001D23; Fri, 21 Mar 2025 22:23:58 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 3/5] python: update missing dependencies from minreqs
Date: Fri, 21 Mar 2025 18:23:45 -0400
Message-ID: <20250321222347.299121-4-jsnow@redhat.com>
In-Reply-To: <20250321222347.299121-1-jsnow@redhat.com>
References: <20250321222347.299121-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

A few transitive dependencies were left floating; as a result, pip's
dependency solver can pull in newer dependencies, which we don't
want. Pin them down.

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


