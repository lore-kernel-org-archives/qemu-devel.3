Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195A7C87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 19:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugpcb-0002q5-Qn; Tue, 29 Jul 2025 15:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugnoT-0005xU-6S
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 13:08:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugnoR-0008In-0H
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 13:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753808906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BgflgkX9VKtHHMFIygeASyiUZqCh7ZdB7fPKCeSw0rM=;
 b=ToD/DjS6ndiplWUH0vWHt3lpH9s/JtJ6gNl5fMMzVbX6wcyBotxYvNwOrizYLx6gLR5u4U
 hTTbzmXbobYSM72E2qJH63xopjVhGnK9OOzJN2j+YoNkWdUE3sOskQsjGJghuBxnaBhpiz
 oENnHvnMdZkkgTwwJberZNSaoyx2GSs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-vC076dz5NrGyLC-u-GX17Q-1; Tue,
 29 Jul 2025 13:08:22 -0400
X-MC-Unique: vC076dz5NrGyLC-u-GX17Q-1
X-Mimecast-MFC-AGG-ID: vC076dz5NrGyLC-u-GX17Q_1753808900
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BFE4180034C; Tue, 29 Jul 2025 17:08:19 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.29])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E85C118001DD; Tue, 29 Jul 2025 17:08:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>,
 Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 1/3] roms/vbootrom: update to 7b1eb5f7fe6a
Date: Tue, 29 Jul 2025 19:07:58 +0200
Message-ID: <20250729170800.678363-2-clg@redhat.com>
In-Reply-To: <20250729170800.678363-1-clg@redhat.com>
References: <20250729170800.678363-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Michael Tokarev <mjt@tls.msk.ru>

Changes:

7b1eb5f ast27x0: Fix Makefile to unconditionally set CC to support correct cross-compilation
601d410 ast27x0: Fix missing SCU module reset for SSP and TSP initialization
80768e4 ast27x0: Initialize and enable SSP/TSP using SCU with reserved-memory from DTB
f8ab635 ast27x0: Show build date and git version
53294f5 Add initial support for AST27x0
b1c2803 Dynamically detects NPCM8XX UBOOT destination and size.
4f54dfc Automatically search for UBOOT location for NPCM8xx images.

The actual bootroms are not updated yet.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Link: https://lore.kernel.org/qemu-devel/2a89ad4c8f5665d07952a4f1749caa6ec0cd3d9c.1753654515.git.mjt@tls.msk.ru
[ clg: Update to latest vbootrom ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 roms/vbootrom | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/roms/vbootrom b/roms/vbootrom
index 1287b6e42e83..183c9ff8056b 160000
--- a/roms/vbootrom
+++ b/roms/vbootrom
@@ -1 +1 @@
-Subproject commit 1287b6e42e839ba2ab0f06268c5b53ae60df3537
+Subproject commit 183c9ff8056b7946db1ae49cc23e8980ac413174
-- 
2.50.1


