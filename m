Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D752BCF6D2C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 14:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svzvv-00026w-CY; Wed, 02 Oct 2024 10:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svzvt-00026i-Qr
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 10:02:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svzvr-0004Cu-T0
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 10:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727877741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tFxh2VhNAi4ytg54s53HDlDncclHDC3jlrKkVli28nY=;
 b=K1pn3ulq1FqJPacyO70Wh7LHy8/WA+POHv+pY2/j/yPh6wUCNnEuJEOOrwIz8j3Hf7KyZH
 z8aZEPCQR8RG67u+ruoEsECr4xPzSDGvFqKc/R+nI3fAIzIRCwmQE5ak2pSqrOzINoBGyQ
 WAvVoVwVVv5rWL5bDhFxh32nlz6siY0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-LOM_0HvfNniCYKpoCTCopQ-1; Wed,
 02 Oct 2024 10:02:18 -0400
X-MC-Unique: LOM_0HvfNniCYKpoCTCopQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C8681955EAB; Wed,  2 Oct 2024 14:02:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.239])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB9EB3000198; Wed,  2 Oct 2024 14:02:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] tests/functional: Bump timeout of some tests
Date: Wed,  2 Oct 2024 16:02:12 +0200
Message-ID: <20241002140212.350467-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

These tests occasionally time out when the host system is under heavy
load. Increase the timeout setting to allow for more headroom here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 7713f8eb55..c90c02517a 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -11,15 +11,18 @@ endif
 
 # Timeouts for individual tests that can be slow e.g. with debugging enabled
 test_timeouts = {
+  'aarch64_raspi4' : 120,
   'aarch64_sbsaref' : 600,
   'aarch64_virt' : 360,
   'acpi_bits' : 240,
+  'arm_raspi2' : 120,
+  'mips_malta' : 120,
   'netdev_ethtool' : 180,
   'ppc_40p' : 240,
   'ppc64_hv' : 1000,
-  'ppc64_powernv' : 120,
-  'ppc64_pseries' : 120,
-  's390x_ccw_virtio' : 180,
+  'ppc64_powernv' : 240,
+  'ppc64_pseries' : 240,
+  's390x_ccw_virtio' : 240,
 }
 
 tests_generic_system = [
-- 
2.46.1


