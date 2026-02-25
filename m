Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19547FD3773
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 16:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvI9c-0005DH-Sz; Wed, 25 Feb 2026 11:54:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvI9Y-0005Cn-Gh
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:54:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvI9U-0004L4-Sd
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772038457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JG91Nxy22Hi6wFYqugvHph9J0CVx2lk4fv1iQ5kwL1w=;
 b=JipkpKuUNZKJe3Y+/7ScaquzWflJTjcxFXhowRTX1ba9idU1GamxxhDChYhz0j0TmjbvsL
 Y/b2POskKEpTznnd1FjfZ39w8cbRhD9cszbYLngzMs/ZlpEZ2LwHs6c8SkPRicsz5Pv4cb
 VgIB57JLdF+WtVYBQf8l6WJt6QfVnr8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-7tiERrHyMaun-GbTbeqBhQ-1; Wed,
 25 Feb 2026 11:54:10 -0500
X-MC-Unique: 7tiERrHyMaun-GbTbeqBhQ-1
X-Mimecast-MFC-AGG-ID: 7tiERrHyMaun-GbTbeqBhQ_1772038445
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 591571800259; Wed, 25 Feb 2026 16:54:05 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.45.225.165])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF88C1800348; Wed, 25 Feb 2026 16:54:02 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] hw/i386: drop unused PC_CPU_MODEL_IDS macro
Date: Wed, 25 Feb 2026 16:54:00 +0000
Message-ID: <20260225165400.605941-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is redundant since the 2.4 machine types were dropped.

Fixes: 4c82e7b34b1bf35d97e026196f5bf10ea916512c
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/i386/pc.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 0dd3fd01d9..2066181b65 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -73,15 +73,6 @@
 #include "hw/xen/xen-bus.h"
 #endif
 
-/*
- * Helper for setting model-id for CPU models that changed model-id
- * depending on QEMU versions up to QEMU 2.4.
- */
-#define PC_CPU_MODEL_IDS(v) \
-    { "qemu32-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
-    { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
-    { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
-
 GlobalProperty pc_compat_10_2[] = {};
 const size_t pc_compat_10_2_len = G_N_ELEMENTS(pc_compat_10_2);
 
-- 
2.53.0


