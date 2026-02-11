Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2A8ECD6D1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 18:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqEW0-0000Wc-Eg; Wed, 11 Feb 2026 13:00:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqEVy-0000TR-8y
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 13:00:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqEVt-0001HE-F8
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 13:00:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770832829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5H33nLi0SoHivrTscJw2N5Ge+Jjpm7kzTnoeygJeNQU=;
 b=MpB3esIoRG/Pk8n7Ey+lMMX9zTymatrfj7NFIq99uDxthnPA2BrxhauKYGhMh+mF3eMbxy
 Ti3khkmfZfHasi5PprcIdAu2Wm3ULYSwz5e8wRnJbL+OBDiNHlUlt2DOdAG2WpQ8LDIhnX
 +UIkBSUCg2dq4X6eibgAiW8ATphnhbk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-Vhc6orHEMJ-LmT6S31ducw-1; Wed,
 11 Feb 2026 13:00:26 -0500
X-MC-Unique: Vhc6orHEMJ-LmT6S31ducw-1
X-Mimecast-MFC-AGG-ID: Vhc6orHEMJ-LmT6S31ducw_1770832825
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30DF7180034D; Wed, 11 Feb 2026 18:00:25 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.45.227.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DFA161956053; Wed, 11 Feb 2026 18:00:22 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] docs: simplify DiamondRapids CPU docs
Date: Wed, 11 Feb 2026 18:00:21 +0000
Message-ID: <20260211180021.1057478-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This aligns the first line of the docs with the style used for previous
CPU models, and simplifies the text in the remaining docs.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/system/cpu-models-x86.rst.inc | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/docs/system/cpu-models-x86.rst.inc b/docs/system/cpu-models-x86.rst.inc
index 3605d05a8c..9d4486c978 100644
--- a/docs/system/cpu-models-x86.rst.inc
+++ b/docs/system/cpu-models-x86.rst.inc
@@ -72,17 +72,13 @@ compatibility is required, use the newest CPU model that is compatible
 across all desired hosts.
 
 ``DiamondRapids``
-    Intel Xeon Processor.
+    Intel Xeon Processor (DiamondRapids, 2025)
 
-    Diamond Rapids product has a topology which differs from previous Xeon
-    products. It does not support SMT, but instead features a dual core
-    module (DCM) architecture. It also has core building blocks (CBB - die
-    level in CPU topology). The cache hierarchy is organized as follows:
-    L1 i/d cache is per thread, L2 cache is per DCM, and L3 cache is per
-    CBB. This cache topology can be emulated for DiamondRapids CPU model
-    using the smp-cache configuration as shown below:
-
-    Example:
+    This does not include SMT but allows the module (dual core module
+    - DCM) and die (core building block - CBB) topology levels. The
+    cache hierarchy is L1 i/d cache per thread, L2 cache per module,
+    and L3 cache per die, which can be emulated using the smp-cache
+    option:
 
         ::
 
-- 
2.53.0


