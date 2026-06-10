Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9EDCD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 08:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXDwL-0001Jr-2W; Wed, 10 Jun 2026 04:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wXDvz-00015M-Be
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:05:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wXDvs-0000e5-J8
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781078703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fpxOyM2y3KBF/qMO/Nxghb6hDs/fsYHYXa0yub9caz4=;
 b=Y5p7sGCLwjClR1DkNfrGDcbOcZyDVCecD3nvpd1TxmiWqwYMBZ9jk2NMRunHAPycnO9fa9
 jTkdG6O2PBC3WOah7YVNCfoD5EPO522yo898lJwqksUGJaVO/CJoBKWTZ5/lViLqc/nP/A
 1NA3bd1yrpbl0rw4RZQ/pc2YU7MB/vg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-RhyUeKmpP9y_iLBqMAodzg-1; Wed,
 10 Jun 2026 04:05:00 -0400
X-MC-Unique: RhyUeKmpP9y_iLBqMAodzg-1
X-Mimecast-MFC-AGG-ID: RhyUeKmpP9y_iLBqMAodzg_1781078699
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EC551800A36; Wed, 10 Jun 2026 08:04:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFE303000203; Wed, 10 Jun 2026 08:04:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3FEFA21E64B1; Wed, 10 Jun 2026 10:04:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PULL 41/42] MAINTAINERS: Drop stale F: from "Sphinx documentation
 configuration ..."
Date: Wed, 10 Jun 2026 10:04:46 +0200
Message-ID: <20260610080447.1156502-42-armbru@redhat.com>
In-Reply-To: <20260610080447.1156502-1-armbru@redhat.com>
References: <20260610080447.1156502-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We neglected to update MAINTAINERS when we fused the conf.py into one,
and when we deleted the kernel-doc script.  Update it now.

Fixes: b93f4fbdc4 (docs: Build and install all the docs in a single manual, 2021-01-15)
Fixes: 619d5f0211 (scripts/kernel-doc: Delete the old Perl kernel-doc script, 2025-08-14)
Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20260603064032.3733394-38-armbru@redhat.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8acf8319ad..07ab566d09 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4594,13 +4594,11 @@ M: Peter Maydell <peter.maydell@linaro.org>
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


