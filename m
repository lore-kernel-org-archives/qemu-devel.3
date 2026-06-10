Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD80CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 08:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXDvy-00012j-9r; Wed, 10 Jun 2026 04:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wXDvu-0000y7-O1
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:05:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wXDvq-0000bn-05
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781078701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XCf+HtUi+ni7rNyQB3Ln9kS1RVNNXc7GxZRANILaE/U=;
 b=CHPCN0dfkv0UmH3U0PeZmlMAZ6gMPahcFZ7SgYRW8BIfq/MD1+/wrJn5703rvfc4vyuHMq
 m228/Zn9/jCJZJX/nnG9fDtZOsl6vh5SUpcJCCwVtGyv+ciX+FxaptpGCcUQBKBe5ZFIGw
 r5Tq1wyyWEgMAM20qwDGqU51ZuCWskw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-wvxrMZPQN0yxl7bzaD3bpg-1; Wed,
 10 Jun 2026 04:04:57 -0400
X-MC-Unique: wvxrMZPQN0yxl7bzaD3bpg-1
X-Mimecast-MFC-AGG-ID: wvxrMZPQN0yxl7bzaD3bpg_1781078696
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8056F18001F0; Wed, 10 Jun 2026 08:04:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B68C1800595; Wed, 10 Jun 2026 08:04:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1AEFC21E64A7; Wed, 10 Jun 2026 10:04:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PULL 32/42] MAINTAINERS: Drop stale F: from "Human Monitor (HMP)"
Date: Wed, 10 Jun 2026 10:04:37 +0200
Message-ID: <20260610080447.1156502-33-armbru@redhat.com>
In-Reply-To: <20260610080447.1156502-1-armbru@redhat.com>
References: <20260610080447.1156502-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

We neglected to update MAINTAINERS when we moved hmp.h to
include/monitor/.  Commit 17dc3ae3e1 (monitor: Extract completion
declarations to 'monitor/hmp-completion.h', 2026-03-20) added the
missing entry without deleting the stale one.  Do that now.

Fixes: 275307aaab (hmp: Move hmp.h to include/monitor/, 2019-06-19)
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Message-ID: <20260603064032.3733394-29-armbru@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a8420c77a3..4830c24d9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3416,7 +3416,6 @@ S: Maintained
 F: monitor/monitor-internal.h
 F: monitor/monitor.c
 F: monitor/hmp*
-F: hmp.h
 F: hmp-commands*.hx
 F: include/monitor/hmp.h
 F: include/monitor/hmp-completion.h
-- 
2.54.0


