Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65044E6689E
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Dec 2025 07:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWrKT-0005xk-Ge; Sat, 20 Dec 2025 02:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vWrKE-0005pw-Ji
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 02:24:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vWrKC-0006S8-0Y
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 02:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766215462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZEphbHpnzz75oeq4sDZC0qNmFi7BmKmEMj1mUqYXlR0=;
 b=PMadV0YrZxF501o2ubRqjDlficpB4ackW3vnc/WXLRAZIN5gztTDa5RnPZPhOybrK4NVCq
 HEALC5N3ej+lqOxLwIJHwqSRP313UBXn2wKBvTUCj+asaKmcr5oKwWTxYtnID6RqzEu37s
 qckXKayytmMEF/zD2dQb5fu5NfCqlbU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-mal-VIZfO5mnilgLj9Nz3Q-1; Sat,
 20 Dec 2025 02:24:20 -0500
X-MC-Unique: mal-VIZfO5mnilgLj9Nz3Q-1
X-Mimecast-MFC-AGG-ID: mal-VIZfO5mnilgLj9Nz3Q_1766215459
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 421BD180060D; Sat, 20 Dec 2025 07:24:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01987180045B; Sat, 20 Dec 2025 07:24:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9055B21E66E2; Sat, 20 Dec 2025 08:24:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, berrange@redhat.com,
 Jackson Donaldson <jackson88044@gmail.com>, qemu-arm@nongnu.org
Subject: [PATCH 4/4] MAINTAINERS: Add MAX78000FTHR section as orphan
Date: Sat, 20 Dec 2025 08:24:16 +0100
Message-ID: <20251220072416.3745923-5-armbru@redhat.com>
In-Reply-To: <20251220072416.3745923-1-armbru@redhat.com>
References: <20251220072416.3745923-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

This machine was contributed by Jackson Donaldson a couple of months
ago.  Its RISC-V core is not implemented.  Unfortunately, Jackson
isn't able to serve as maintainer at this time, so add it as orphan.

Cc: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-arm@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3efc943c9b..c493aceffc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -871,6 +871,15 @@ F: include/hw/misc/arm_integrator_debug.h
 F: tests/functional/arm/test_integratorcp.py
 F: docs/system/arm/integratorcp.rst
 
+MAX78000FTHR
+M: Jackson Donaldson <jackson88044@gmail.com>
+L: qemu-arm@nongnu.org
+S: Odd Fixes
+F: docs/system/arm/max78000.rst
+F: hw/*/max78000*
+F: include/hw/*/max78000*
+F: tests/functional/arm/test_max78000fthr.py
+
 MCIMX6UL EVK / i.MX6ul
 M: Peter Maydell <peter.maydell@linaro.org>
 R: Jean-Christophe Dubois <jcd@tribudubois.net>
-- 
2.49.0


