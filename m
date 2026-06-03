Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FDBCD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 06:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfHq-0003if-WD; Wed, 03 Jun 2026 02:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUfHT-0003Oh-JU
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:40:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUfHQ-0000ou-Jd
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780468843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xCorJ48K3QD4tm8nOwg1b8pcG9Ke8qW6n3USM0Dx4L8=;
 b=QZk48ZRwZZw8NDO70U7BWeAUGlS4l4RDWstAwGHXbj1ymkTk7tO/ZBN0HSG2groEr/AkOP
 NhwJL7M613rIB2paTUnfsDsxJ8STQQNitWfGFi+sRLASy9bJlm186qdwnt5u/qPxqUNFZD
 nG8Rl+Tg9N8nhws8pTOn8GCO7WB0X/A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-Fhb4fJE1O1GP40G3cgBx0Q-1; Wed,
 03 Jun 2026 02:40:42 -0400
X-MC-Unique: Fhb4fJE1O1GP40G3cgBx0Q-1
X-Mimecast-MFC-AGG-ID: Fhb4fJE1O1GP40G3cgBx0Q_1780468841
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 789171800350; Wed,  3 Jun 2026 06:40:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 34537180058C; Wed,  3 Jun 2026 06:40:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ACCBB21E64A3; Wed, 03 Jun 2026 08:40:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@mailo.com,
	pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH v2 30/38] MAINTAINERS: Fix F: in "QMP"
Date: Wed,  3 Jun 2026 08:40:24 +0200
Message-ID: <20260603064032.3733394-31-armbru@redhat.com>
In-Reply-To: <20260603064032.3733394-1-armbru@redhat.com>
References: <20260603064032.3733394-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

We neglected to update MAINTAINERS when we renamed
docs/devel/writing-monitor-commands.rst, and when we renamed
monitor/misc.c.  The latter file no longer exists, so simply drop the
line.  Update the other one.

Fixes: 0e33e3d2c4 (docs/devel: rename file for writing monitor commands, 2021-09-09)
Fixes: 864a3fa439 (monitor: Rename misc.c to hmp-target.c, 2023-01-24)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d87426c255..175f32fbfc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3587,12 +3587,11 @@ M: Markus Armbruster <armbru@redhat.com>
 S: Supported
 F: monitor/monitor-internal.h
 F: monitor/qmp*
-F: monitor/misc.c
 F: monitor/monitor.c
 F: qapi/control.json
 F: qapi/error.json
 F: qapi/introspect.json
-F: docs/devel/*qmp-*
+F: docs/devel/writing-monitor-commands.rst
 F: docs/interop/*qmp-*
 F: scripts/qmp/
 F: tests/qtest/qmp-test.c
-- 
2.54.0


