Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F02FCAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 13:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvym6-0000sP-Lt; Tue, 09 Sep 2025 09:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvylp-0000o8-L4
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:52:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvyll-0005H6-1Y
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757425942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I0IqzZK14jeX65kzayZ/rZmFtMxD4AkFHcxWVoN4zyE=;
 b=Q4Hn7f18R4y2wXa5Kl1sHwIlzL3Y0k1uWlP6zS4yx4WqwETUFm7YNNJSrDDX62LWPAUtNF
 Jaz1POVayYeH80UnhvTIWWUJyCsFpYIVRIFLiKiZaFJYoROUWyGmZAE5Vni2oN5ZW4as53
 21trIumr9XjZqn29bJm4AGU3mg2Zsrw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-UEFAj_qEOraykifObx1XLQ-1; Tue,
 09 Sep 2025 09:52:18 -0400
X-MC-Unique: UEFAj_qEOraykifObx1XLQ-1
X-Mimecast-MFC-AGG-ID: UEFAj_qEOraykifObx1XLQ_1757425937
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EA7419560A0; Tue,  9 Sep 2025 13:52:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.46])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C2B201800446; Tue,  9 Sep 2025 13:52:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Kane-Chen-AS <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/23] tests/functional/arm: Update test ASPEED SDK v09.07 for
 AST2600
Date: Tue,  9 Sep 2025 15:51:36 +0200
Message-ID: <20250909135147.612345-13-thuth@redhat.com>
In-Reply-To: <20250909135147.612345-1-thuth@redhat.com>
References: <20250909135147.612345-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20250904100556.1729604-4-kane_chen@aspeedtech.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/arm/test_aspeed_ast2600.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_ast2600.py b/tests/functional/arm/test_aspeed_ast2600.py
index fdae4c939d8..129695ca4ec 100755
--- a/tests/functional/arm/test_aspeed_ast2600.py
+++ b/tests/functional/arm/test_aspeed_ast2600.py
@@ -97,14 +97,14 @@ def test_arm_ast2600_evb_buildroot_tpm(self):
 
         self.do_test_arm_aspeed_buildroot_poweroff()
 
-    ASSET_SDK_V906_AST2600 = Asset(
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.06/ast2600-default-obmc.tar.gz',
-        '768d76e247896ad78c154b9cff4f766da2ce65f217d620b286a4a03a8a4f68f5')
+    ASSET_SDK_V907_AST2600 = Asset(
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.07/ast2600-default-obmc.tar.gz',
+        'cb6c08595bcbba1672ce716b068ba4e48eda1ed9abe78a07b30392ba2278feba')
 
     def test_arm_ast2600_evb_sdk(self):
         self.set_machine('ast2600-evb')
 
-        self.archive_extract(self.ASSET_SDK_V906_AST2600)
+        self.archive_extract(self.ASSET_SDK_V907_AST2600)
 
         self.vm.add_args('-device',
             'tmp105,bus=aspeed.i2c.bus.5,address=0x4d,id=tmp-test')
-- 
2.51.0


