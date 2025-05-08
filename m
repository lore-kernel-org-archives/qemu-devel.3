Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF22C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 07:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCvf5-0000vz-8y; Thu, 08 May 2025 03:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCvf3-0000vZ-Me
 for qemu-devel@nongnu.org; Thu, 08 May 2025 03:27:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCvf2-0000Lo-7S
 for qemu-devel@nongnu.org; Thu, 08 May 2025 03:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746689233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=v04j7YqujNbPMmV3Bc20oW5CcoKXOkDE1n9fxUbwpgo=;
 b=LNF+8USA8nbCtcH6LXAkiSGJSosJYhVrSXmzl8gPysilaEtA74srKnz9d33bYHxy0p5cRL
 kkSPvaIXZBHOkLJJduFZFVPVxdXVSELzPWnA+IJDikEJQq22wci0ffAsMe418/qGaZamhc
 fqMrx2FHeEmKtDVdQa0+lj291299RdI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-3rq90zNjOg-6tVyeztBU8Q-1; Thu,
 08 May 2025 03:27:12 -0400
X-MC-Unique: 3rq90zNjOg-6tVyeztBU8Q-1
X-Mimecast-MFC-AGG-ID: 3rq90zNjOg-6tVyeztBU8Q_1746689231
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DA70180045B; Thu,  8 May 2025 07:27:10 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.200])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E64919560B3; Thu,  8 May 2025 07:27:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qianfan Zhao <qianfanguijin@163.com>
Subject: [RFC PATCH] MAINTAINERS: Add an entry for the Bananapi machine
Date: Thu,  8 May 2025 09:27:06 +0200
Message-ID: <20250508072706.114278-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

This machine was still missing from the MAINTAINERS file. Since there
is likely no active maintainer around for this machine (I didn't spot
any contributions from Qianfan Zhao in the git log after 2023), I'm
suggesting Peter as maintainer with status set to "Odd fixes".

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c2b9e69add..934e5f08ae7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -722,6 +722,16 @@ F: include/hw/timer/armv7m_systick.h
 F: include/hw/misc/armv7m_ras.h
 F: tests/qtest/test-arm-mptimer.c
 
+Bananapi M2U
+M: Peter Maydell <peter.maydell@linaro.org>
+L: qemu-arm@nongnu.org
+S: Odd Fixes
+F: docs/system/arm/bananapi_m2u.rst
+F: hw/*/allwinner-r40*.c
+F: hw/arm/bananapi_m2u.c
+F: include/hw/*/allwinner-r40*.h
+F: tests/functional/test_arm_bpim2u.py
+
 B-L475E-IOT01A IoT Node
 M: Samuel Tardieu <sam@rfc1149.net>
 L: qemu-arm@nongnu.org
-- 
2.49.0


