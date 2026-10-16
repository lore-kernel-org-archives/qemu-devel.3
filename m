Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0493BCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHczm-0003wA-BZ; Fri, 16 Oct 2026 04:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karthika.b@cdac.in>)
 id 1xHcza-0003rR-Pa; Fri, 16 Oct 2026 04:08:43 -0400
Received: from mailsender.cdac.in ([196.1.113.117]
 helo=mailsender-core1.pune.cdac.in)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karthika.b@cdac.in>)
 id 1xHczW-0005yY-P3; Fri, 16 Oct 2026 04:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cdac.in; s=default;
 t=1792138093; bh=ctZgAjNW/jTbpIBcY7W8+yJg8zzvQ9YcMD2822CbeH8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dw5V3Lhd3Qmmwx4gKUJPqFZ5dHwAutwsyzb4BxDi/lfn3oP006L0Sub5E5muSNZCs
 pH9EpJ5rcAiou1rtNmCFqFU+AVVURbG6IFdx97lkmf+6UoRzNkGjFUXyUemPKPL39k
 6xEyWslxGb/5jXdPFVXiItBCBiNgBc4Jh7BgBIgY=
Received: from mscr-int.pune.cdac.in (mscr-int.pune.cdac.in [10.208.193.2])
 by mailsender.cdac.in (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 69G88BIF3825318; Fri, 16 Oct 2026 13:38:11 +0530
Received: from mailgw-cip.pune.cdac.in (mscr-haproxy.pune.cdac.in
 [10.208.193.46])
 by mscr-int.pune.cdac.in (Postfix) with ESMTP id D5B9710007297;
 Fri, 16 Oct 2026 13:38:01 +0530 (IST)
X-Auth: karthika.b@cdac.in
Received: from hdg164.tvm.cdac.in (hd_hdg164.tvm.cdac.in [10.176.18.107])
 (Authenticated sender: karthika.b@cdac.in)
 by mailgw-cip.pune.cdac.in (Postfix) with ESMTPSA id 80B6814E17D2;
 Fri, 16 Oct 2026 13:38:01 +0530 (IST)
From: Karthika B <karthika.b@cdac.in>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, sreenadh@cdac.in, raokk@cdac.in,
 Karthika B <karthika.b@cdac.in>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 7/7] MAINTAINERS: Add entry for VEGA machine
Date: Fri, 16 Oct 2026 13:37:07 +0530
Message-ID: <20261016080709.17331-8-karthika.b@cdac.in>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016080709.17331-1-karthika.b@cdac.in>
References: <385625713.441366.1761727810206@webmail2.cdac.in>
 <20261016080709.17331-1-karthika.b@cdac.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CDAC-PUNE-MailScanner-Information: Please contact the ISP for more
 information
X-CDAC-PUNE-MailScanner-ID: D5B9710007297.AE1DF
X-CDAC-PUNE-MailScanner: Found to be clean
X-CDAC-PUNE-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
 BAYES_00 -1.90)
X-CDAC-PUNE-MailScanner-From: karthika.b@cdac.in
Received-SPF: pass client-ip=196.1.113.117; envelope-from=karthika.b@cdac.in;
 helo=mailsender-core1.pune.cdac.in
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

Signed-off-by: Karthika B <karthika.b@cdac.in>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b5b581e17..ece538b4f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1786,6 +1786,20 @@ F: docs/system/riscv/xiangshan-kunminghu.rst
 F: hw/riscv/xiangshan_kmh.c
 F: include/hw/riscv/xiangshan_kmh.h
 
+VEGA
+M: Karthika B <karthika.b@cdac.in>
+L: qemu-riscv@nongnu.org
+S: Odd Fixes
+F: hw/riscv/vega.c
+F: hw/intc/vega_plic.c
+F: hw/intc/vega_aclint.c
+F: include/hw/riscv/vega.h
+F: include/hw/intc/vega_plic.h
+F: include/hw/intc/vega_aclint.h
+F: docs/system/riscv/vega.rst
+F: tests/functional/riscv32/test_vega.py
+F: tests/functional/riscv64/test_vega.py
+
 RX Machines
 -----------
 rx-gdbsim
-- 
2.43.0


------------------------------------------------------------------------------------------------------------
[ C-DAC is on Social-Media too. Kindly follow us at:
Facebook: https://www.facebook.com/CDACINDIA & Twitter: @cdacindia ]

This e-mail is for the sole use of the intended recipient(s) and may
contain confidential and privileged information. If you are not the
intended recipient, please contact the sender by reply e-mail and destroy
all copies and the original message. Any unauthorized review, use,
disclosure, dissemination, forwarding, printing or copying of this email
is strictly prohibited and appropriate legal action will be taken.
------------------------------------------------------------------------------------------------------------


