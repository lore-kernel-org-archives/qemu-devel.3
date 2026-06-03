Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7190CCD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 06:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfHs-0003js-MS; Wed, 03 Jun 2026 02:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUfHa-0003RY-DZ
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:40:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUfHT-0000qS-5Z
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780468846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gdm1AB6hU5F2pUQ3bbTkOc8zEmXu211yyuI6FUrhdTM=;
 b=AG7/8K3tfS5jT/jBdzNPBJ9vZRFfVup5urDEv65GoXbmtDhO6twlIiU1F0eWlsmJGDcvuR
 uloCMiwYbWUfhCpim4il4YDadaUkbAu25Fte/ZfYlxY4zN1v4VTXnbKiLsACSxWJOEXlRm
 DYHDYvQyzftaeQEKcjrAvx0Owh52c1Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-fNrS8h1PNDSKSBIletnhwg-1; Wed,
 03 Jun 2026 02:40:42 -0400
X-MC-Unique: fNrS8h1PNDSKSBIletnhwg-1
X-Mimecast-MFC-AGG-ID: fNrS8h1PNDSKSBIletnhwg_1780468841
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A2141956046; Wed,  3 Jun 2026 06:40:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1800B30001A1; Wed,  3 Jun 2026 06:40:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A4B4321E649D; Wed, 03 Jun 2026 08:40:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@mailo.com, pierrick.bouvier@oss.qualcomm.com,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v2 28/38] MAINTAINERS: Drop stale F: from "Human Monitor (HMP)"
Date: Wed,  3 Jun 2026 08:40:22 +0200
Message-ID: <20260603064032.3733394-29-armbru@redhat.com>
In-Reply-To: <20260603064032.3733394-1-armbru@redhat.com>
References: <20260603064032.3733394-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

We neglected to update MAINTAINERS when we moved hmp.h to
include/monitor/.  Commit 17dc3ae3e1 (monitor: Extract completion
declarations to 'monitor/hmp-completion.h', 2026-03-20) added the
missing entry without deleting the stale one.  Do that now.

Fixes: 275307aaab (hmp: Move hmp.h to include/monitor/, 2019-06-19)
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57510a323f..4d7f7196bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3414,7 +3414,6 @@ S: Maintained
 F: monitor/monitor-internal.h
 F: monitor/monitor.c
 F: monitor/hmp*
-F: hmp.h
 F: hmp-commands*.hx
 F: include/monitor/hmp.h
 F: include/monitor/hmp-completion.h
-- 
2.54.0


