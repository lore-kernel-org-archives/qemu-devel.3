Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA200C0218E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 10:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taBw7-0006gb-Ep; Tue, 21 Jan 2025 05:56:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taBvx-0006ee-Sf
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:56:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taBvo-00056D-Fi
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:56:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737456987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hIzs1BT0oZ+F3DAu1fJpjRzBZnDPHScPQ9wFqs3gnGo=;
 b=HycJaE6vNymuC/GlWQTmIGewsfuier1DCWZWCAK720mWiAuOsbUskvETlueifTWc7mZz1S
 Qlt2a4JEMRl3MZw7EVI7zysucG0Gg3Gcbn1Zai+fer75RTOKEV6iJMGDt6licO6mech9CV
 cYoPi6V1j1zGV+xzLvNtbHt84H5aziw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-yqhswBA1MqCuQ4r2UgvWIQ-1; Tue,
 21 Jan 2025 05:56:24 -0500
X-MC-Unique: yqhswBA1MqCuQ4r2UgvWIQ-1
X-Mimecast-MFC-AGG-ID: yqhswBA1MqCuQ4r2UgvWIQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67BE219560BD; Tue, 21 Jan 2025 10:56:22 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.56])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ACCB119560B0; Tue, 21 Jan 2025 10:56:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/9] MAINTAINERS: Remove myself as Avocado Framework reviewer
Date: Tue, 21 Jan 2025 11:56:04 +0100
Message-ID: <20250121105613.1286672-3-thuth@redhat.com>
In-Reply-To: <20250121105613.1286672-1-thuth@redhat.com>
References: <20250121105613.1286672-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.036,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

While I was very enthusiastic when Avocado was presented to
the QEMU community and pushed forward to have it integrated,
time passed and I lost interest. Be honest, remove my R: tag
to not give fake expectation I'd review patches related to
Avocado anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250106055024.70139-1-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 94834b7876..7be3d8f431 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4207,7 +4207,6 @@ F: tests/tcg/Makefile.target
 Integration Testing with the Avocado framework
 W: https://trello.com/b/6Qi1pxVn/avocado-qemu
 R: Cleber Rosa <crosa@redhat.com>
-R: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Odd Fixes
 F: tests/avocado/
 
-- 
2.48.1


