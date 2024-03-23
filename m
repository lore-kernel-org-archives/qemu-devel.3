Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7C6C54E67
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Mar 2024 09:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnxqT-0001oa-Ni; Sat, 23 Mar 2024 05:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rnxqR-0001nY-Ht
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 05:39:19 -0400
Received: from todd.t-8ch.de ([159.69.126.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rnxqO-0006wK-Lk
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 05:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1711186751; bh=fMsU+/qeHEJsWGtnvX3wRLIgPDqabVyVlyBbSHyCcpg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=m7CO9D2yeAAoErp1A7NPZbfReq6T7iqclEAblvMPESpD+6S8Z989AQTnnqxusIRgZ
 pHKNMqbwxRzlXq0Zz4yPE8hF1/pPDFWmK5AlZx9/oIwIoVOiLB+HgPdUaHL74jSvBV
 /fGBLn7tQEug34vZrlN5Xx1fv5EefWydaENZORys=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Date: Sat, 23 Mar 2024 10:39:08 +0100
Subject: [PATCH v7 3/7] hw/misc/pvpanic: add local definition for
 PVPANIC_SHUTDOWN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240323-pvpanic-shutdown-v7-3-4ac1fd546d6f@t-8ch.de>
References: <20240323-pvpanic-shutdown-v7-0-4ac1fd546d6f@t-8ch.de>
In-Reply-To: <20240323-pvpanic-shutdown-v7-0-4ac1fd546d6f@t-8ch.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711186751; l=1026;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=fMsU+/qeHEJsWGtnvX3wRLIgPDqabVyVlyBbSHyCcpg=;
 b=SyMh2GJ0akgrK4hK9M08UQmS2qmIv8fNyVaZNszYU0zsBcdsn4hd6YxRydVbfeNla+Smgm0VN
 rtXw3pHbsm1BWbbC0Xb/4HQc+/AzCg9+f0NhalYSD/zowtzMyWyIV0b
X-Developer-Key: i=thomas@t-8ch.de; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Received-SPF: pass client-ip=159.69.126.157; envelope-from=thomas@t-8ch.de;
 helo=todd.t-8ch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

PVPANIC_* defines are imported from the kernel via
standard-header/pvpanic.h.
For that the kernel needs to pick up the changes from
qemu docs/specs/pvpanic.rst which takes time.

The actual value of the define is known as the authoritative source
comes from the qemu tree in docs/specs/pvpanic.rst, where it was added
in commit 73279cecca03 ("docs/specs/pvpanic: document shutdown event").

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
 include/hw/misc/pvpanic.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index 947468b81b1a..926aa64838f9 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -20,6 +20,11 @@
 
 #include "standard-headers/linux/pvpanic.h"
 
+#ifdef PVPANIC_SHUTDOWN
+#error PVPANIC_SHUTDOWN is already defined
+#endif
+#define PVPANIC_SHUTDOWN	(1 << 2)
+
 #define PVPANIC_EVENTS (PVPANIC_PANICKED | PVPANIC_CRASH_LOADED)
 
 #define TYPE_PVPANIC_ISA_DEVICE "pvpanic"

-- 
2.44.0


