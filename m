Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE8ED58CC9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 12:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w50yS-0005Zq-M6; Tue, 24 Mar 2026 08:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1w50yQ-0005Xt-0Z
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:35:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1w50yO-0000Iy-9n
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774355703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vcMk7+yLRQf0CwqtOW96CX9FXhexy8qcKv4c9zmtwPw=;
 b=eWe8f3L8jvJIAie2BM5EJLJR4TGsDwvKg6HT/rEJMufN0gwRPr4ifoUXxYOzxKW4zQILuJ
 0J7GvAHf1hAEtiMnlrDA2Jx3ozutbheTlYbB5c2cV/NiT0COWuWGE1lAiBOpJyxQzBJb9X
 mYc9Yts67zrBQ1RE3j2ld0mQMtWJ8xI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-R0iTf_ElMeaOkCJnMzX6Og-1; Tue,
 24 Mar 2026 08:35:00 -0400
X-MC-Unique: R0iTf_ElMeaOkCJnMzX6Og-1
X-Mimecast-MFC-AGG-ID: R0iTf_ElMeaOkCJnMzX6Og_1774355699
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EC4B1956089; Tue, 24 Mar 2026 12:34:59 +0000 (UTC)
Received: from gondolin.str.redhat.com (dhcp-192-210.str.redhat.com
 [10.33.192.210])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D33FC180075D; Tue, 24 Mar 2026 12:34:57 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Gautam Gala <ggala@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PULL for-11.0 1/2] MAINTAINERS: S390 CPU topology: Change maintainer
Date: Tue, 24 Mar 2026 13:34:43 +0100
Message-ID: <20260324123444.131118-2-cohuck@redhat.com>
In-Reply-To: <20260324123444.131118-1-cohuck@redhat.com>
References: <20260324123444.131118-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Gautam Gala <ggala@linux.ibm.com>

Replace Nina with me as the maintainer for s390 CPU topology.

Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Acked-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Message-ID: <20260319094835.80329-1-ggala@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 25fb621c30a4..e29ddeb611fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1917,7 +1917,7 @@ F: hw/s390x/sclp*.c
 L: qemu-s390x@nongnu.org
 
 S390 CPU topology
-M: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
+M: Gautam Gala <ggala@linux.ibm.com>
 S: Supported
 F: include/hw/s390x/cpu-topology.h
 F: hw/s390x/cpu-topology.c
-- 
2.53.0


