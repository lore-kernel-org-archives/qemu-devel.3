Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF71C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 12:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrk4-00048B-B2; Mon, 22 Jul 2024 08:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sVrjO-0000d7-NR
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:01:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sVrjM-0006bf-8L
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721649687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RKSvqlSONwKCmC1iRk3OxXEAEUTdI3xCiV4ChbjZXlg=;
 b=g2grC7i9aq9W9UrH+61ICAFI61GuPV4aNwEfZUpCQdPJZ9CpoaW6TCSHQXUvisLFC+Buj6
 JXsY+ZBhdJu/A2pVoXys07fQ3M2V052pelymxB9LulbLbHsAzg16jpfJtMmtQH45Ln1LyN
 JHui0HKHqnythCn71DCoSaI44NKouWA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-n6yLDMTNPc2aiHjyWAHGaA-1; Mon,
 22 Jul 2024 08:01:25 -0400
X-MC-Unique: n6yLDMTNPc2aiHjyWAHGaA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9AF1E18B66A6; Mon, 22 Jul 2024 12:01:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.179])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 987CA19349B9; Mon, 22 Jul 2024 12:00:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [PULL 11/12] tests: increase timeout per instance of bios-tables-test
Date: Mon, 22 Jul 2024 14:00:25 +0200
Message-ID: <20240722120026.675449-12-thuth@redhat.com>
In-Reply-To: <20240722120026.675449-1-thuth@redhat.com>
References: <20240722120026.675449-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

From: Igor Mammedov <imammedo@redhat.com>

CI often fails 'cross-i686-tci' job due to runner slowness
Log shows that test almost complete, with a few remaining
when bios-tables-test timeout hits:

  19/270 qemu:qtest+qtest-aarch64 / qtest-aarch64/bios-tables-test
    TIMEOUT        610.02s   killed by signal 15 SIGTERM
  ...
  stderr:
  TAP parsing error: Too few tests run (expected 8, got 7)

At the same time overall job running time is only ~30 out of 1hr allowed.

Increase bios-tables-test instance timeout on 5min as a fix
for slow CI runners.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20240716125930.620861-1-imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 6508bfb1a2..ff9200f882 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -1,6 +1,6 @@
 slow_qtests = {
   'aspeed_smc-test': 360,
-  'bios-tables-test' : 610,
+  'bios-tables-test' : 910,
   'cdrom-test' : 610,
   'device-introspect-test' : 720,
   'migration-test' : 480,
-- 
2.45.2


