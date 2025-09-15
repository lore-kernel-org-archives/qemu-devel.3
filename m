Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EEFCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 13:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy9H1-0002Fv-9i; Mon, 15 Sep 2025 09:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uy9Gs-00029X-RW
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 09:29:32 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uy9Gj-00086P-SI
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 09:29:30 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3dae49b1293so2376883f8f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 06:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757942953; x=1758547753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BBugnVxa6GIRx7PYLmryOGEGnPy1qRYdN+ScLxAmtdM=;
 b=Fbvu3JAFRdDkNrZn3BMzUE/RHkvAj187hPguYpcSnqLsOwfYgWGBgUrz+y9KVQkXOL
 JLEptmnsgudshOGvi4KEC+41Na31Tpw/+Ya/3J6LNuhdluoWlbEB7moMtHCQLZE5OY70
 s/jhl40GygTikJJlV9X2YVaz+r+TovGd/zjcoyDAhmWXm1ev7g2X4F7QC2ZX1HR5/mFi
 3BQ2I2YPIWeiJqTrEIoDsjOsBIIPYdWOzR/DeUjtWvw84MrXb5hePv8Vc+FwmXpDf5EU
 YWOOZSGqZM2YNKrZpa5zkZJpBGk3lCWz7d4B3GnwqXGxElyqFTGimcZDjUGyWfm8RR+E
 /bFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757942953; x=1758547753;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BBugnVxa6GIRx7PYLmryOGEGnPy1qRYdN+ScLxAmtdM=;
 b=kqph/LbEIAx1deRW+GWbnmmPg5GndJGLokty4CuBMXOykSNlIbqiO4cQ1Pc2I7noYC
 vFZQ4EjWUP6bZUr3KRHPCE1MQwRmq7oG75zT2NuTHgAaWSTcjU81+bJYNXHd2K4SElny
 to0utkpxKX5Q41fGs8J6/A2lJP3ZyGdULHBBtvRoXusEBlwKOC5V22FmB3jsF1ryIujG
 W6GlRHO2C0nAiQmUYcdxkl7j/2qXkLlgcbBDqFVHFtDGs1xYO3xUWyTZba3XqvT7DyMZ
 SJYAnZQpQLsbj4IwFiIBOw8tB5mPDNFDxDTmBNZ+XpVUPRh6LZgk5ZJqI94ebRLpUBTr
 OZMA==
X-Gm-Message-State: AOJu0YxcaHYDrE7o4MfDORj0h4/8lf1+vGyOafZ6WAD+BATDjWdP71Mw
 JR6CQQgBtNWC/JNxysEY0mFoXy+LYz/ogu13l7+4O0wXEvQ0BDkAhoRr4aOkzLZ/pDlroK91CAQ
 YNsTA
X-Gm-Gg: ASbGncuWsasJS1X7p3z/cgWqT0HJMokvVTT70UEu78TDT8Pw812SHxCjTJw/+nPG5Go
 +f8+uGUuQ9rZdT/VQ2rxVMHWGi8XLLo8K3KvSP2CUND44cjrOeoKM6JynR/Wsg/nKrWgC6Y1XLX
 d3lidwVgF2RMq9tEq6pmzMCl7kIWqu5goLUWq0OP87l56Gx/EpHaWSFcHw1m7j79gjiUGnGH4dJ
 CM/HJzOlkT+l48Rw0CTWfIonffa3zUSAGhliFegSF0uK2aXUjL+7T/B5wcuPR0e1IfuplvLlR1+
 aIgaq3MsNp328dENH8UgvscF7cbwhkQF9cojogGt9yjEvYe9Ttq3I9KSVJBDahmNZ4lAH9S5CIp
 Op+z1b8pt3fMvf0aQm0WqI6PVfYJ/
X-Google-Smtp-Source: AGHT+IEmbqBRLwhIHvbpPbZtNEJdmgrx+f+zXv2ApaMM83WSCR/AWVXzwRmnC0JeCE5Mk2t+ND7yLQ==
X-Received: by 2002:a05:6000:2909:b0:3ea:f093:97d2 with SMTP id
 ffacd0b85a97d-3eaf093a09bmr1955710f8f.1.1757942953121; 
 Mon, 15 Sep 2025 06:29:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e0156b0a8sm181366835e9.3.2025.09.15.06.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 06:29:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] hw/usb/hcd-uhci: don't assert for SETUP to non-0 endpoint
Date: Mon, 15 Sep 2025 14:29:10 +0100
Message-ID: <20250915132910.1252212-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

If the guest feeds invalid data to the UHCI controller, we
can assert:
qemu-system-x86_64: ../../hw/usb/core.c:744: usb_ep_get: Assertion `pid == USB_TOKEN_IN || pid == USB_TOKEN_OUT' failed.

(see issue 2548 for the repro case).  This happens because the guest
attempts USB_TOKEN_SETUP to an endpoint other than 0, which is not
valid.  The controller code doesn't catch this guest error, so
instead we hit the assertion in the USB core code.

Catch the case of SETUP to non-zero endpoint, and treat it as a fatal
error in the TD, in the same way we do for an invalid PID value in
the TD.

This is the UHCI equivalent of the same bug in OHCI that we fixed in
commit 3c3c233677 ("hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or
OUT").

This bug has been tracked as CVE-2024-8354.

Cc: qemu-stable@nongnu.org
Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2548
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/usb/hcd-uhci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 4822c704f69..e207d0587a1 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -735,6 +735,7 @@ static int uhci_handle_td(UHCIState *s, UHCIQueue *q, uint32_t qh_addr,
     bool spd;
     bool queuing = (q != NULL);
     uint8_t pid = td->token & 0xff;
+    uint8_t ep_id = (td->token >> 15) & 0xf;
     UHCIAsync *async;
 
     async = uhci_async_find_td(s, td_addr);
@@ -778,9 +779,14 @@ static int uhci_handle_td(UHCIState *s, UHCIQueue *q, uint32_t qh_addr,
 
     switch (pid) {
     case USB_TOKEN_OUT:
-    case USB_TOKEN_SETUP:
     case USB_TOKEN_IN:
         break;
+    case USB_TOKEN_SETUP:
+        /* SETUP is only valid to endpoint 0 */
+        if (ep_id == 0) {
+            break;
+        }
+        /* fallthrough */
     default:
         /* invalid pid : frame interrupted */
         s->status |= UHCI_STS_HCPERR;
@@ -829,7 +835,7 @@ static int uhci_handle_td(UHCIState *s, UHCIQueue *q, uint32_t qh_addr,
             return uhci_handle_td_error(s, td, td_addr, USB_RET_NODEV,
                                         int_mask);
         }
-        ep = usb_ep_get(dev, pid, (td->token >> 15) & 0xf);
+        ep = usb_ep_get(dev, pid, ep_id);
         q = uhci_queue_new(s, qh_addr, td, ep);
     }
     async = uhci_async_alloc(q, td_addr);
-- 
2.43.0


