Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F884C79F8B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 13:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vck9r-0004oz-C4; Mon, 05 Jan 2026 07:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck9C-0004Nb-G2
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck9A-00086i-RW
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767617840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUSrHrWXsYiAofCo/hJotjUzkEJ1WydAy1nzr+S3xuQ=;
 b=N/0A5lYBk84BENW0fCDmIKgCE/J70zL+E4Pxivt8E0WSB4KHfXqjnlTLy6Z7QqycQ/KoPI
 LgaprC3ClFu6jqtRDX+mbFL8dkkOMtyKA89qmPqUZQ/ye6JDmppbJu1nxVAXt4/2YIKTjK
 nf/YVNgXea1CV9JRWFaHYOuusj8NCkU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-zt--GEy_OE6aSuSXqb7maQ-1; Mon,
 05 Jan 2026 07:57:19 -0500
X-MC-Unique: zt--GEy_OE6aSuSXqb7maQ-1
X-Mimecast-MFC-AGG-ID: zt--GEy_OE6aSuSXqb7maQ_1767617837
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC238195DE61; Mon,  5 Jan 2026 12:57:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C086A19560A7; Mon,  5 Jan 2026 12:57:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Ed Tanous <etanous@nvidia.com>, Patrick Williams <patrick@stwcx.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 29/36] tests/functional: Fix URL of gb200nvl-bmc image
Date: Mon,  5 Jan 2026 13:56:06 +0100
Message-ID: <20260105125613.622667-30-clg@redhat.com>
In-Reply-To: <20260105125613.622667-1-clg@redhat.com>
References: <20260105125613.622667-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Commit [1] moved the FW image of the gb200nvl-bmc machine and broke
the associated functional test. Fix that.

[1] https://github.com/legoater/qemu-aspeed-boot/commit/52451b2472eeb40aa97e131aeea327e9d4a8a78a

Cc: Ed Tanous <etanous@nvidia.com>
Cc: Patrick Williams <patrick@stwcx.xyz>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20251222073351.166720-1-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/arm/test_aspeed_gb200nvl_bmc.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/arm/test_aspeed_gb200nvl_bmc.py b/tests/functional/arm/test_aspeed_gb200nvl_bmc.py
index 8e8e3f05c1b2..e5f2dce0f569 100755
--- a/tests/functional/arm/test_aspeed_gb200nvl_bmc.py
+++ b/tests/functional/arm/test_aspeed_gb200nvl_bmc.py
@@ -11,7 +11,7 @@
 class GB200Machine(AspeedTest):
 
     ASSET_GB200_FLASH = Asset(
-        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/gb200nvl-obmc/obmc-phosphor-image-gb200nvl-obmc-20250702182348.static.mtd.xz',
+        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/gb200nvl-bmc/openbmc-20250702182348/obmc-phosphor-image-gb200nvl-obmc-20250702182348.static.mtd.xz',
         'b84819317cb3dc762895ad507705978ef000bfc77c50c33a63bdd37921db0dbc')
 
     def test_arm_aspeed_gb200_openbmc(self):
-- 
2.52.0


