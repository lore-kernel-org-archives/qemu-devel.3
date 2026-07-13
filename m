Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C1CC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEi7-000050-Af; Mon, 13 Jul 2026 07:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjEi1-0008MQ-EF
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:20:26 -0400
Received: from mx1.catap.net ([2a01:4f8:271:125e::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjEhz-00080Z-4P
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:20:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=iU8C/Gx
 VPk2o4IHrNPKHIKmeiFCDD2vrEtZJU+E5QUUuP4TwjmUYmPZhof9KSZ3ZIzowIloRjcZDV
 Lf19ZPquO36ieriy9P1/26o1tjnB+w/rDBkMF0PTDZHoZKzJubmzOxMfxToLReIn/v/mI4
 Tck03tnCgiuGjUsGSx3XH7y7uk834G761/N7tJgjoOUNp8OFFxDHOI5Xa7b6fxRJYVbhMI
 p6AhfnX6xb8gj99PGmxuGiOXd7RpilJF9stuTXQRKcMtrMDxVRBtnnrEgeHALHAhJcPqs8
 JX0Tke4rpOY1h/dRhXAuM5ogZPUGMYkaGQj3s8+Iq+/wkz8eYlX2uqA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=A
 HNAZgfLB8xDDhalUO+7466I/1HRryiDJ1zC/K0+gcg=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=cky9pIlhEGU16Wgg6ajO8m94lvHJ8HH3cSGDN5pUx5qBS0X/PhxI0/ubeZrLyrp2gtXa
 q0LVj6lUH5M07WUIuKjLUQ0p4nNyDpFMZngEdw05t9DuujnyXxb0wg/pV8IvzMuSADCwzc
 DCKMFE4tFfWS/mLB2/YKriLdF3FaYF2Z8kMEsyGkpwxUUFAihifNsInQRLVaEkE8pWDqMb
 sZIZPDryZtWeNmGDQRxIQBT1ClEcmbSN6vCtMb/fshKdExUQQ6N3sAf/Pqyf6l+gx7Jh4I
 zwUFR9IczFc3uOeyCmdyXYK/p8p8QNN7oJLthYbhUiH66NlJrjEUc4q/3o1Tx5lg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=zdal3EN3; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=INqBjHlp;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=AHNAZgfL
 B8xDDhalUO+7466I/1HRryiDJ1zC/K0+gcg=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=zdal3EN3Upcej9HfIUNmxpPBURa0P163tXX
 21X6fObmCae77URkmNXWSMNQvCLWU8vjdNSmtiniSvHU4z6hVG/aBrG+JtOvvtqtGa2jGW
 EXL75tv1wqGVZDahk+ACNeoMCkWGPNhRPd7n1cEj6A+Gu6YZ9mNrb5YNoIOojjoN7bY4Xk
 AOEIgMTMJLEq2uHmDb6fo3pcTQuxlvUIA//CaXy2Pvpj6PRbqD4kpAiaWhv28UA9cq8X7+
 zQTK23stg/ykpf+fgwSt+kV9oiSTPfEkgIvBx6DuHjnCNoblaKq6nLkajc3yEQfarCVv9p
 CZgiBKO+S8NOglRUbKF2kyq4fdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=AHNAZgfLB8xDDhalUO+7466I/1HRryiDJ1zC/K0+gcg=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=INqBjHlpL6P9fnEq8C
 Kwpg6NJTuJgeRlqBRHg7QNnQ5Chv/qGTiwDnAZG+A36Jb8ZCe1ZpDrY3QbolUbQgn4AA==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id 6c533594
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 13 Jul 2026 13:20:16 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id bf80800e;
 Mon, 13 Jul 2026 13:20:13 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH 1/9] hw/usb/xhci: reassert pending busy interrupts
Date: Mon, 13 Jul 2026 13:16:29 +0200
Message-ID: <20260713112004.4956-2-kirill@korins.ky>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713112004.4956-1-kirill@korins.ky>
References: <20260713112004.4956-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f8:271:125e::2;
 envelope-from=kirill@korins.ky; helo=mx1.catap.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

xhci_intr_raise() returned early whenever ERDP.EHB was set; that also
skipped IRQ assertion after the guest cleared IMAN.IP while leaving the
event handler busy bit asserted.

Track the previous IMAN.IP state and suppress only duplicate raises;
when ERDP.EHB remains set after IMAN.IP is cleared, assert the IRQ again
so the guest can observe the pending event.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 hw/usb/hcd-xhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 2cdab3ba0e..ce06d52c36 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -577,12 +577,13 @@ static void xhci_intr_update(XHCIState *xhci, int v)
 static void xhci_intr_raise(XHCIState *xhci, int v)
 {
     bool pending = (xhci->intr[v].erdp_low & ERDP_EHB);
+    bool was_raised = (xhci->intr[v].iman & IMAN_IP);
 
     xhci->intr[v].erdp_low |= ERDP_EHB;
     xhci->intr[v].iman |= IMAN_IP;
     xhci->usbsts |= USBSTS_EINT;
 
-    if (pending) {
+    if (pending && was_raised) {
         return;
     }
     if (!(xhci->intr[v].iman & IMAN_IE)) {
-- 
2.54.0


