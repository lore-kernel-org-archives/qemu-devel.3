Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1C41091924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 21:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Kfv-0001X2-64; Thu, 19 Mar 2026 17:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w3Kfo-0001W9-CF
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 17:12:56 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w3Kfm-0003gD-99
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 17:12:56 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AC59D60130;
 Thu, 19 Mar 2026 21:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242C3C19424;
 Thu, 19 Mar 2026 21:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773954766;
 bh=h4p1+ICryI3QqNt5JAMaRMNdkMQaQ1wkNFFSdqKKzlY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tU4Co8sVrhpk/7dgE+JWZRBzwG6EHZGy90WDDosHM2BoBGLG1qK4BUgMz6ZqducBs
 tJUdvqfEzJ4h2amHYFaJ+7pMMoDzN0UILu7q4J9H55X48+xCV+X9fEH6d+K9kKT4at
 q2f39iH3Q1vsAndyKi+En5GcAYGoQamBZakEqk9vgpS+M7EaiDe5MQHOflfrrDSBHe
 VNOIRNML8cA242F8kiPVP6UotqJ9NZYtLy4Z2PqWJ3UrSzpg5uL/G+2R4S9HqBjA6/
 cXQQKDx/vgUK9YB3/o89VymTrvULoB3J6evryLEiSDkN+tZgn4YFN7IT5OdRoFxhGW
 5Jj033+hqTnQg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 2/6] hw/hppa: Adjust physical addresses of Astro and Elroy
Date: Thu, 19 Mar 2026 22:12:35 +0100
Message-ID: <20260319211239.7902-3-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319211239.7902-1-deller@kernel.org>
References: <20260319211239.7902-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Adjust the addresses of the Astro and Elroy PCI chips to a
44-bit physical address space when running a PA8700 CPU.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 hw/hppa/hppa_hardware.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
index 0a89c3ed52..006aae63b9 100644
--- a/hw/hppa/hppa_hardware.h
+++ b/hw/hppa/hppa_hardware.h
@@ -61,8 +61,8 @@
 #define ASTRO_BUS_MODULE        0x0a            /* C3700: 0x0a, others maybe 0 ? */
 
 /* ASTRO Memory and I/O regions */
-#define ASTRO_BASE_HPA            0xfffed00000
-#define ELROY0_BASE_HPA           0xfffed30000  /* ELROY0_HPA */
+#define ASTRO_BASE_HPA            0xffffed00000
+#define ELROY0_BASE_HPA           0xffffed30000  /* ELROY0_HPA */
 
 #define ROPES_PER_IOC           8       /* per Ike half or Pluto/Astro */
 
-- 
2.53.0


