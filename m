Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60280CD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 06:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfHu-0003v2-CN; Wed, 03 Jun 2026 02:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUfHc-0003TD-1b
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:41:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUfHW-0000sf-DF
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780468848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VSoujaGK0aDzPa6Ri1BPMNFkbSXq7PpweoKwNGeKeqs=;
 b=cCDVgfeFOxiA8Urfg+AoaHDC/Pe3F5RqHHH+wXRFVsMkdadVmAnAPIQa5FM004IBLOUywa
 1YqV1dk1L7/IRIn/1jW2aaX4ZOAwrDg6Y1lUQbJECmoFgsd78asuCTa5HEp8WjmZSpKj9s
 tRZTIHf9XGsJu/6CJUwBzjik3aC6qa4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-A1oTSAILOSuG20J9zAqqhg-1; Wed,
 03 Jun 2026 02:40:45 -0400
X-MC-Unique: A1oTSAILOSuG20J9zAqqhg-1
X-Mimecast-MFC-AGG-ID: A1oTSAILOSuG20J9zAqqhg_1780468844
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 266C31956066; Wed,  3 Jun 2026 06:40:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7393180049F; Wed,  3 Jun 2026 06:40:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CA23821E64AC; Wed, 03 Jun 2026 08:40:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@mailo.com, pierrick.bouvier@oss.qualcomm.com,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v2 37/38] MAINTAINERS: Drop stale F: from "Sphinx
 documentation configuration ..."
Date: Wed,  3 Jun 2026 08:40:31 +0200
Message-ID: <20260603064032.3733394-38-armbru@redhat.com>
In-Reply-To: <20260603064032.3733394-1-armbru@redhat.com>
References: <20260603064032.3733394-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We neglected to update MAINTAINERS when we fused the conf.py into one,
and when we deleted the kernel-doc script.  Update it now.

Fixes: b93f4fbdc4 (docs: Build and install all the docs in a single manual, 2021-01-15)
Fixes: 619d5f0211 (scripts/kernel-doc: Delete the old Perl kernel-doc script, 2025-08-14)
Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f6609dc5f3..2743faa1ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4596,13 +4596,11 @@ M: Peter Maydell <peter.maydell@linaro.org>
 M: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
 S: Maintained
 F: docs/conf.py
-F: docs/*/conf.py
 F: docs/requirements.txt
 F: docs/sphinx/
 F: docs/_templates/
 F: docs/devel/docs.rst
 F: docs/devel/qapi-domain.rst
-F: scripts/kernel-doc
 F: scripts/lib/kdoc/
 
 Rust build system integration
-- 
2.54.0


