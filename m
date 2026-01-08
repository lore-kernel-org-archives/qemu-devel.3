Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EC3CF6A86
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 08:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdlrB-0004I2-QY; Thu, 08 Jan 2026 03:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdlr9-0004ED-R8
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 03:58:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdlr8-0008FI-EI
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 03:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767862737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ofuVHAo7EQylnwcnPneQfKRaNNLgb1GFMDbwoVyFgQ=;
 b=CbGkbYQ6360oBYyOzidTMTQSaJZnv4xyyaY6kiIyPLAApAz//Qfuj8hHKnVqCXUj2mZw0D
 mxdobTlpCgRc/9rLNWezpMVNm7cpqaDNyj5cG/EmsFAnHuKR5C2O5ffyrTmUt1lez3cv2F
 SkX1RfRMd2rIzuZd1JZ2w2uHY+8cbJE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-TX5qWH_BOJWtuDsB1WvNxw-1; Thu,
 08 Jan 2026 03:58:54 -0500
X-MC-Unique: TX5qWH_BOJWtuDsB1WvNxw-1
X-Mimecast-MFC-AGG-ID: TX5qWH_BOJWtuDsB1WvNxw_1767862733
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 760821800370; Thu,  8 Jan 2026 08:58:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D989F18008FF; Thu,  8 Jan 2026 08:58:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 853CE21E61A9; Thu, 08 Jan 2026 09:58:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Stefan Weil <sw@weilnetz.de>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 3/4] MAINTAINERS: Add EEPROM 93xx section
Date: Thu,  8 Jan 2026 09:58:49 +0100
Message-ID: <20260108085850.1790958-4-armbru@redhat.com>
In-Reply-To: <20260108085850.1790958-1-armbru@redhat.com>
References: <20260108085850.1790958-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Stefan Weil volunteered to serve as maintainer.  Thanks!

Cc: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Stefan Weil <sw@weilnetz.de>
Message-ID: <20251220173336.3781377-4-armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c8084e4453..dc58155419 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2708,6 +2708,12 @@ F: hw/nvram/chrp_nvram.c
 F: include/hw/nvram/chrp_nvram.h
 F: tests/qtest/prom-env-test.c
 
+EEPROM 93xx
+M: Stefan Weil <sw@weilnetz.de>
+S: Maintained
+F: hw/nvram/eeprom93xx.c
+F: include/hw/nvram/eeprom93xx.h
+
 VM Generation ID
 S: Orphan
 R: Ani Sinha <ani@anisinha.ca>
-- 
2.52.0


