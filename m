Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACAEC61DB2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 12:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOxgt-00067r-VU; Tue, 10 Jun 2025 08:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uOxfj-0005ca-SH
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:01:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uOxfg-0003Rp-Fl
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749556897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OoIeLdcMpFtfEUOvfgtVZDzO71WL39cQEKlY0zojNeI=;
 b=XzCbypsKpuqm1XhTJS+KBfaGxP1EdQKnBRKInkR38YnjXPFWYJkiwlKI8I8CA9Yn20GnAD
 7Tuo6+5efgAD8LKc8gz1jv38VDqeoRmDEST7bh2jaKK514PH0edg6VClpbfRnZy9uDFkHy
 XwMiFgdVe6ZUGauU5s/gSh9332JGJQk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-TcChW9jTOkOKrilyPuHtzg-1; Tue,
 10 Jun 2025 08:01:36 -0400
X-MC-Unique: TcChW9jTOkOKrilyPuHtzg-1
X-Mimecast-MFC-AGG-ID: TcChW9jTOkOKrilyPuHtzg_1749556894
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 893721955F43; Tue, 10 Jun 2025 12:01:34 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.89])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C490019560B0; Tue, 10 Jun 2025 12:01:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] MAINTAINERS: Drop the defunct mail address from Yoshinori Sato
Date: Tue, 10 Jun 2025 14:01:23 +0200
Message-ID: <20250610120123.37689-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

From: Thomas Huth <thuth@redhat.com>

The OSDN / sourceforge.jp site ceased to work (according to
https://en.wikipedia.org/wiki/OSDN#History at least since midth
of April 2025) and mails to Yosinori Sato are currently bouncing.
Since it's unlikely that the site will be back, let's remove the
defunct mail entries for now and hope that Yoshinori will be back
with a working e-mail address sometime in the future.
While we're at it, downgrade some related "Odd Fixes" entries
to "Orphan" since we don't have a maintainer listed here anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb2b338fb11..d6d5f47c9a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -367,7 +367,6 @@ F: tests/tcg/s390x/
 L: qemu-s390x@nongnu.org
 
 SH4 TCG CPUs
-R: Yoshinori Sato <ysato@users.sourceforge.jp>
 S: Orphan
 F: target/sh4/
 F: hw/sh4/
@@ -1693,7 +1692,6 @@ F: docs/system/riscv/microblaze-v-generic.rst
 RX Machines
 -----------
 rx-gdbsim
-R: Yoshinori Sato <ysato@users.sourceforge.jp>
 S: Orphan
 F: docs/system/target-rx.rst
 F: hw/rx/rx-gdbsim.c
@@ -1702,9 +1700,8 @@ F: tests/functional/test_rx_gdbsim.py
 SH4 Machines
 ------------
 R2D
-R: Yoshinori Sato <ysato@users.sourceforge.jp>
 R: Magnus Damm <magnus.damm@gmail.com>
-S: Odd Fixes
+S: Orphan
 F: hw/char/sh_serial.c
 F: hw/sh4/r2d.c
 F: hw/intc/sh_intc.c
@@ -2753,9 +2750,8 @@ F: tests/qtest/*xive*
 F: docs/*/*xive*
 
 Renesas peripherals
-R: Yoshinori Sato <ysato@users.sourceforge.jp>
 R: Magnus Damm <magnus.damm@gmail.com>
-S: Odd Fixes
+S: Orphan
 F: hw/char/renesas_sci.c
 F: hw/char/sh_serial.c
 F: hw/timer/renesas_*.c
@@ -2765,7 +2761,6 @@ F: include/hw/sh4/sh.h
 F: include/hw/timer/renesas_*.h
 
 Renesas RX peripherals
-R: Yoshinori Sato <ysato@users.sourceforge.jp>
 S: Orphan
 F: hw/intc/rx_icu.c
 F: hw/rx/
-- 
2.49.0


