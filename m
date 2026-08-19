Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98F7C5DF87
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 10:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwdry-0002N8-Lf; Wed, 19 Aug 2026 06:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1wwdrw-0002IR-VV
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 06:50:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1wwdrv-0004uw-3n
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 06:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787136601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qgo57/Il+UgxwZygT6uwTYu3OZi93UGk/45SdzHH+3I=;
 b=RT6yHV/qFYcp3JhhKfbYK1yekMl3aWvLLtm5B/4xaX75tY1vxmNWWirsPRqX5yfnBMb4GQ
 OT1GjbVzdqzyzi5ldt7x6pSikNa/WUGBjBABrv25aXBac6miSUYj155JozDwjy0DbhdyeG
 KMAWJWgqZFRKvqY8HcLHVSD7T+nO5Hk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-hvp0BgjPPvSJ7_bHPiP1gA-1; Wed,
 19 Aug 2026 06:48:07 -0400
X-MC-Unique: hvp0BgjPPvSJ7_bHPiP1gA-1
X-Mimecast-MFC-AGG-ID: hvp0BgjPPvSJ7_bHPiP1gA_1787136487
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4EA018005B3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 10:48:06 +0000 (UTC)
Received: from f44vm (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E9510180034C; Wed, 19 Aug 2026 10:48:05 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Cc: Sergio Lopez <slp@redhat.com>
Subject: [PATCH] MAINTAINERS: remove Sergio Lopez from microvm
Date: Wed, 19 Aug 2026 12:47:59 +0200
Message-ID: <20260819104759.1946-1-slp@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=slp@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Remove myself from the microvm section since I haven't been actively
working on QEMU since quite a while.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b51f5c3e60..d2fae5d5bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2071,7 +2071,6 @@ F: include/hw/timer/i8254*
 F: include/hw/rtc/mc146818rtc*
 
 microvm
-M: Sergio Lopez <slp@redhat.com>
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: docs/system/i386/microvm.rst
-- 
2.55.0


