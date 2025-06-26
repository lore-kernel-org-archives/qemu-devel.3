Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C66C77B7F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 05:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUfYw-0003sk-Ob; Thu, 26 Jun 2025 01:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUfYk-0003rX-4l
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 01:54:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUfYh-00015k-6C
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 01:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750917242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aKQbCeQW50tNmFeDtknxhuk7vsTcs3007HhCJhXcJuM=;
 b=awGdKayjXAiUxJ8E1tyAFCEKaK6ZbelKWU/v6/3+7+w8Bpw8irdOWOXWWKk273DgiaPOjp
 RHBeguOCD9oI8ArpOV6vacLOu1ietNNPqY0w4PaNgSBcMkS6PLCve+sHR+MEZyrq/2Z5sN
 i8zUNdSqEJ+ekl+ZNN9VlxCDGWO3vw4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-b4Q4WHRXOnKRn-sSPXJ_PA-1; Thu,
 26 Jun 2025 01:54:00 -0400
X-MC-Unique: b4Q4WHRXOnKRn-sSPXJ_PA-1
X-Mimecast-MFC-AGG-ID: b4Q4WHRXOnKRn-sSPXJ_PA_1750917239
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E831F18011FB; Thu, 26 Jun 2025 05:53:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.129])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 254CF19560A3; Thu, 26 Jun 2025 05:53:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PULL 02/19] MAINTAINERS: Yoshinori Sato email address has been
 updated
Date: Thu, 26 Jun 2025 07:53:33 +0200
Message-ID: <20250626055350.218271-3-thuth@redhat.com>
In-Reply-To: <20250626055350.218271-1-thuth@redhat.com>
References: <20250626055350.218271-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Yoshinori Sato <yoshinori.sato@nifty.com>

The email address <ysato@users.sourceforge.jp> has been suspended.
I have prepared a new email address.

Signed-off-by: Yoshinori Sato <yoshinori.sato@nifty.com>
Message-ID: <20250612131632.137155-1-yoshinori.sato@nifty.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 27f4fe3f259..5b8b314c8c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -352,7 +352,7 @@ F: target/riscv/insn_trans/trans_xventanacondops.c.inc
 F: disas/riscv-xventana*
 
 RENESAS RX CPUs
-R: Yoshinori Sato <ysato@users.sourceforge.jp>
+R: Yoshinori Sato <yoshinori.sato@nifty.com>
 S: Orphan
 F: target/rx/
 
@@ -368,7 +368,7 @@ F: tests/tcg/s390x/
 L: qemu-s390x@nongnu.org
 
 SH4 TCG CPUs
-R: Yoshinori Sato <ysato@users.sourceforge.jp>
+R: Yoshinori Sato <yoshinori.sato@nifty.com>
 S: Orphan
 F: target/sh4/
 F: hw/sh4/
@@ -1696,7 +1696,7 @@ F: docs/system/riscv/microblaze-v-generic.rst
 RX Machines
 -----------
 rx-gdbsim
-R: Yoshinori Sato <ysato@users.sourceforge.jp>
+R: Yoshinori Sato <yoshinori.sato@nifty.com>
 S: Orphan
 F: docs/system/target-rx.rst
 F: hw/rx/rx-gdbsim.c
@@ -1705,7 +1705,7 @@ F: tests/functional/test_rx_gdbsim.py
 SH4 Machines
 ------------
 R2D
-R: Yoshinori Sato <ysato@users.sourceforge.jp>
+R: Yoshinori Sato <yoshinori.sato@nifty.com>
 R: Magnus Damm <magnus.damm@gmail.com>
 S: Odd Fixes
 F: hw/char/sh_serial.c
@@ -2756,7 +2756,7 @@ F: tests/qtest/*xive*
 F: docs/*/*xive*
 
 Renesas peripherals
-R: Yoshinori Sato <ysato@users.sourceforge.jp>
+R: Yoshinori Sato <yoshinori.sato@nifty.com>
 R: Magnus Damm <magnus.damm@gmail.com>
 S: Odd Fixes
 F: hw/char/renesas_sci.c
@@ -2768,7 +2768,7 @@ F: include/hw/sh4/sh.h
 F: include/hw/timer/renesas_*.h
 
 Renesas RX peripherals
-R: Yoshinori Sato <ysato@users.sourceforge.jp>
+R: Yoshinori Sato <yoshinori.sato@nifty.com>
 S: Orphan
 F: hw/intc/rx_icu.c
 F: hw/rx/
-- 
2.50.0


