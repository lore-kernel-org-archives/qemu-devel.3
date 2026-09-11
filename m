Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703ABC88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xzg-0008Mj-3u; Fri, 11 Sep 2026 05:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4xxH-0005mf-Pf
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:54:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4xxG-00028s-DD
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789120437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yDhtyS45HZx1Ywrfz6zY+BH9lH9qIacmZrasU50TPDM=;
 b=YmteLm+Ju6Os45du7IJnO9aYtkYt52W4GoRTiqEleNYhPzHH6zc+4AAxi24gUf8Cwspg1k
 /7c3+MQX0rTCdnlfag6XMX8HLzWQspPIwxvz6Gkz6NLoZd89EiswzKbw4XrR1RNOKUyZ4l
 RjFQECK2Vuazjqr6/cr9+FKMzhT8rQc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-Hj0EYa-_MKuTj8Ynmul26Q-1; Fri,
 11 Sep 2026 05:53:54 -0400
X-MC-Unique: Hj0EYa-_MKuTj8Ynmul26Q-1
X-Mimecast-MFC-AGG-ID: Hj0EYa-_MKuTj8Ynmul26Q_1789120433
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE957195423B; Fri, 11 Sep 2026 09:53:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90D63180029C; Fri, 11 Sep 2026 09:53:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2EC6721E6880; Fri, 11 Sep 2026 11:53:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, philmd@oss.qualcomm.com,
 zhao1.liu@intel.com
Subject: [PATCH 2/2] qapi/compat: Belatedly update description of CompatPolicy
Date: Fri, 11 Sep 2026 11:53:50 +0200
Message-ID: <20260911095350.2020964-3-armbru@redhat.com>
In-Reply-To: <20260911095350.2020964-1-armbru@redhat.com>
References: <20260911095350.2020964-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Fixes: 57df0dff1a (qapi: Extend -compat to set policy for unstable
interfaces)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/compat.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/compat.json b/qapi/compat.json
index 90b8d51cf2..e4728424de 100644
--- a/qapi/compat.json
+++ b/qapi/compat.json
@@ -40,7 +40,7 @@
 ##
 # @CompatPolicy:
 #
-# Policy for handling deprecated management interfaces.
+# Policy for handling deprecated and unstable management interfaces.
 #
 # This is intended for testing users of the management interfaces.
 #
-- 
2.55.0


