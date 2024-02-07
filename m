Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013D0C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 05:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXa4q-0004Ew-Gf; Wed, 07 Feb 2024 00:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1rXa4o-0004ES-H9
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 00:02:26 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1rXa4m-0000Uy-SR
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 00:02:26 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3bda4bd14e2so253791b6e.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 21:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707282143; x=1707886943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HPDL006u4Y/f+j7F7SdoeRFchc9MjlKOa9T+hk+MibM=;
 b=ngG7Ep0nCTaXR180KLm6hzRGK3zGEQ8YI7ryR9MYkGtnhrvFAIHklYrhLHq1Z1kfoF
 QYqTk2qZkyyRVC+7NrUOyGeyPe/DRYyiPS9tkUvVTmMYUDnEgklpW8v0ox225cGzc9G7
 w7vCVrgjIZ+EAayu7ChHAZJQEJP5HtXykeb1V687MCcdufYqeMtSHfohms6T4jYS1061
 TZmu2szrNeCmCPEWOrc+Jm+EDcck14ywSjNKc29qIEcAcY1Amm0T7jQ1N4plJCvajOAG
 wrfsf+JSy10+lFQArAAcDbIVqTHIF33HJXbC2WfkFTubH2EeU2JlcKmh3ehhk7eHFLWr
 EOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707282143; x=1707886943;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HPDL006u4Y/f+j7F7SdoeRFchc9MjlKOa9T+hk+MibM=;
 b=gwSHvkQvXZaixrrWkKLw3Yp0rx6yEe0MEN0pmjyPXr+vo9YrspM7rVumoqHER8tIZ6
 Ph5hySLcIaBWBo1cUOTfqBSHl6gMLlqCTaDGTIS/KpJi54cxldJBngKghTeFg3itAJ6F
 rqamyOIKnePZlK6WzgKWa62tKK/2R1ijvTzFGd2nsQ80vRiJ8BvPDub0CdGqkLvdKNqM
 iQWgXDkn458AOctO3MXFpUohuiheOTxs8V0aOtvtMFlF/ewRM9tVkYbuPZLeSZF4HvoH
 hbvq22fabTMNxAwTKUYLzBLJSgjwFQlV93DcDb82p3S46osnbLtlkx/FD29YaSwSEv7o
 eJcw==
X-Gm-Message-State: AOJu0YyigbK9nM3RaiDP/0nokuQmhD/A488XZf4zbH5PyWCxl6Pe7bG3
 N99dIqCPCYpuOl6ADZVUFk7iAxRmqFxAQvfAqE7qJHIY8zSCzG3f8FXZDyNS
X-Google-Smtp-Source: AGHT+IFe5LgZu0WJoTfYjKUVMv9S1ygJEgYEOt91c9HMAT7vSz/5fMp3U2Iq1Y28Xa0DANgiGuPhjQ==
X-Received: by 2002:a05:6808:15:b0:3bf:ce2e:c4b2 with SMTP id
 u21-20020a056808001500b003bfce2ec4b2mr4628818oic.50.1707282143395; 
 Tue, 06 Feb 2024 21:02:23 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWDHyPUjTLmIB5bPrM/r0ImyGeZ46hl56WxCGk/RUz5gqlsUxsPOWTew4+y/mI8d2nnU1R5ynxAGBZ5UTLZHpz8P4M=
Received: from mintleaf.lan ([136.49.150.227])
 by smtp.gmail.com with ESMTPSA id
 bq2-20020a05680823c200b003bfd4e4fee0sm82646oib.58.2024.02.06.21.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 21:02:23 -0800 (PST)
From: David Hubbard <dmamfmgm@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	David Hubbard <dmamfmgm@gmail.com>
Subject: [PATCH] hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
Date: Tue,  6 Feb 2024 23:02:33 -0600
Message-Id: <20240207050233.183972-1-dmamfmgm@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=dmamfmgm@gmail.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This changes the ohci validation to not assert if invalid
data is fed to the ohci controller. The poc suggested in
https://bugs.launchpad.net/qemu/+bug/1907042
and then migrated to bug #303 does the following to
feed it a SETUP pid and EndPt of 1:

        uint32_t MaxPacket = 64;
        uint32_t TDFormat = 0;
        uint32_t Skip = 0;
        uint32_t Speed = 0;
        uint32_t Direction = 0;  /* #define OHCI_TD_DIR_SETUP 0 */
        uint32_t EndPt = 1;
        uint32_t FuncAddress = 0;
        ed->attr = (MaxPacket << 16) | (TDFormat << 15) | (Skip << 14)
                   | (Speed << 13) | (Direction << 11) | (EndPt << 7)
                   | FuncAddress;
        ed->tailp = /*TDQTailPntr= */ 0;
        ed->headp = ((/*TDQHeadPntr= */ &td[0]) & 0xfffffff0)
                   | (/* ToggleCarry= */ 0 << 1);
        ed->next_ed = (/* NextED= */ 0 & 0xfffffff0)

qemu-fuzz also caught the same issue in #1510. They are
both fixed by this patch.

The if (td.cbp > td.be) logic in ohci_service_td() causes an
ohci_die(). My understanding of the OHCI spec 4.3.1.2
Table 4-2 allows td.cbp to be one byte more than td.be to
signal the buffer has zero length. The new check in qemu
appears to have been added since qemu-4.2. This patch
includes both fixes since they are located very close
to each other.

Signed-off-by: David Hubbard <dmamfmgm@gmail.com>
---
 hw/usb/hcd-ohci.c   | 9 +++++++--
 hw/usb/trace-events | 2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index d73b53f33c..a53808126f 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -927,6 +927,11 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
     case OHCI_TD_DIR_SETUP:
         str = "setup";
         pid = USB_TOKEN_SETUP;
+        if (OHCI_BM(ed->flags, ED_EN) > 0) {  /* setup only allowed to ep 0 */
+            trace_usb_ohci_td_bad_pid(str, ed->flags, td.flags);
+            ohci_die(ohci);
+            return 1;
+        }
         break;
     default:
         trace_usb_ohci_td_bad_direction(dir);
@@ -936,8 +941,8 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
         if ((td.cbp & 0xfffff000) != (td.be & 0xfffff000)) {
             len = (td.be & 0xfff) + 0x1001 - (td.cbp & 0xfff);
         } else {
-            if (td.cbp > td.be) {
-                trace_usb_ohci_iso_td_bad_cc_overrun(td.cbp, td.be);
+            if (td.cbp > td.be + 1) {
+                trace_usb_ohci_td_bad_buf(td.cbp, td.be);
                 ohci_die(ohci);
                 return 1;
             }
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index ed7dc210d3..b47d082fa3 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -28,6 +28,8 @@ usb_ohci_iso_td_data_overrun(int ret, ssize_t len) "DataOverrun %d > %zu"
 usb_ohci_iso_td_data_underrun(int ret) "DataUnderrun %d"
 usb_ohci_iso_td_nak(int ret) "got NAK/STALL %d"
 usb_ohci_iso_td_bad_response(int ret) "Bad device response %d"
+usb_ohci_td_bad_buf(uint32_t cbp, uint32_t be) "Bad cbp = 0x%x > be = 0x%x"
+usb_ohci_td_bad_pid(const char *s, uint32_t edf, uint32_t tdf) "Bad pid %s: ed.flags 0x%x td.flags 0x%x"
 usb_ohci_port_attach(int index) "port #%d"
 usb_ohci_port_detach(int index) "port #%d"
 usb_ohci_port_wakeup(int index) "port #%d"
-- 
2.34.1


