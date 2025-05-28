Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BCCC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 11:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKFOh-0001LD-P7; Wed, 28 May 2025 07:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7BZW=YM=cmp.felk.cvut.cz=pisa@fel.cvut.cz>)
 id 1uKFOf-0001KI-G0
 for qemu-devel@nongnu.org; Wed, 28 May 2025 07:56:37 -0400
Received: from smtpx1.feld.cvut.cz ([147.32.210.191])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7BZW=YM=cmp.felk.cvut.cz=pisa@fel.cvut.cz>)
 id 1uKFOW-0000ZL-1Q
 for qemu-devel@nongnu.org; Wed, 28 May 2025 07:56:37 -0400
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtpx1.feld.cvut.cz (Postfix) with ESMTPS id 58C2E267D0;
 Wed, 28 May 2025 13:50:50 +0200 (CEST)
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id 4FE012D51A;
 Wed, 28 May 2025 13:50:50 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id enCUi0by8Tzj; Wed, 28 May 2025 13:50:48 +0200 (CEST)
Received: from fel.cvut.cz (unknown [147.32.86.213])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 1392B2D1D3;
 Wed, 28 May 2025 13:39:11 +0200 (CEST)
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Ondrej Ille <ondrej.ille@gmail.com>, Jiri Novak <jnovak@fel.cvut.cz>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: [PATCH v1 2/3] hw/net/can: CTU CAN FD IP platform bus mapping enabled
 for Xilinx Zynq
Date: Wed, 28 May 2025 13:39:29 +0200
Message-Id: <bf8501a8e1165de70e2adb50cf79947b24e9cbf3.1748432169.git.pisa@cmp.felk.cvut.cz>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1748432169.git.pisa@cmp.felk.cvut.cz>
References: <cover.1748432169.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.32.210.191;
 envelope-from=SRS0=7BZW=YM=cmp.felk.cvut.cz=pisa@fel.cvut.cz;
 helo=smtpx1.feld.cvut.cz
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-to:  Pavel Pisa <pisa@cmp.felk.cvut.cz>
From:  Pavel Pisa via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
---
 hw/arm/xilinx_zynq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 0372cd0ac4..e3b4bf6104 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -473,6 +473,7 @@ static void zynq_machine_class_init(ObjectClass *oc, const void *data)
                                           "Supported boot modes:"
                                           " jtag qspi sd nor");
     object_property_set_default_str(prop, "qspi");
+    machine_class_allow_dynamic_sysbus_dev(mc, "ctucan_mm");
 }
 
 static const TypeInfo zynq_machine_type = {
-- 
2.39.5


