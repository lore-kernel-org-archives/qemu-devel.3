Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67616C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 07:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp1KZ-0004kw-5Z; Tue, 26 Mar 2024 03:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KX-0004kV-HA
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KW-0005SG-7b
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711438483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IeOASrwuWAwYhd0qDYIiUYNmKXMfHcrmEKI/tZVEFQ4=;
 b=AFZq2pxBS+oU2I0qnLZNGatVtM5FcZ62xS7GwgzoIq8bKAJ7ZxJLjEBesevTMx4Fpq4hnt
 kZX4RueUeVV7MboO8mxcqlLeRhj6EjM/quiXZltj4L2Sf9yJLdhOga6fDpo/GFWDX2G0kJ
 nUeEid2X/IYIBs64j7DWzPeeKJDPWHE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-ABlbJmR1O6ej1R_KimKQeg-1; Tue, 26 Mar 2024 03:34:42 -0400
X-MC-Unique: ABlbJmR1O6ej1R_KimKQeg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA760185A786;
 Tue, 26 Mar 2024 07:34:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B08B5828;
 Tue, 26 Mar 2024 07:34:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 935CE21E60CF; Tue, 26 Mar 2024 08:34:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 04/20] qapi: Drop stray Arguments: line from qmp_capabilities
 docs
Date: Tue, 26 Mar 2024 08:34:04 +0100
Message-ID: <20240326073420.738016-5-armbru@redhat.com>
In-Reply-To: <20240326073420.738016-1-armbru@redhat.com>
References: <20240326073420.738016-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reported-by: John Snow <jsnow@redhat.com>
Fixes: 119ebac1feb2 (qapi-schema: use generated marshaller for 'qmp_capabilities')
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240322140910.328840-2-armbru@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 qapi/control.json | 2 --
 1 file changed, 2 deletions(-)

diff --git a/qapi/control.json b/qapi/control.json
index f404daef60..6bdbf077c2 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -11,8 +11,6 @@
 #
 # Enable QMP capabilities.
 #
-# Arguments:
-#
 # @enable: An optional list of QMPCapability values to enable.  The
 #     client must not enable any capability that is not mentioned in
 #     the QMP greeting message.  If the field is not provided, it
-- 
2.44.0


