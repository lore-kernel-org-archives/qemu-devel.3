Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BEFC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 13:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXLRA-0005Xa-Hw; Tue, 06 Feb 2024 08:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1rXFWM-0003bs-Qs
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 02:05:30 -0500
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1rXFWK-0003mt-TU
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 02:05:30 -0500
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-7d6275d7d4dso2254437241.2
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 23:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707203127; x=1707807927; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jibtGl1lwp1WLYGMWUKBho12OAcB3gwVAxVCqv8vTqQ=;
 b=gY7PTVuYCT3MLLHBJCNvZmnmRf8k2DXAdpU8TFt19V0sWU5KvA9cDRvXzwnS/cEzKV
 50/LB6+ClV1o0LzGnQxFqtMC8FejieLfH3KxpXCQl55pMeI28pt+V9gPFjE8hJz8UZIx
 18bjex7a0EZK5WO69ZNjyz7FPpX/mFqjzVCBkjUAEfqZls6tXTCBDNOiI7zEcbNS8O+o
 WMN9wV0Bk0pV7EkVmXLdGF8rGw6k0+GAeFrwZQ8LAfSf5s1wsflSDcxfxw7769WzbpX0
 usnMhukv3UeTS+nbgGz+AH5ChqfnT6LNf4M92WR6MYGadTyrGMRECW9AIFIgFcH9nL3w
 +sDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707203127; x=1707807927;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jibtGl1lwp1WLYGMWUKBho12OAcB3gwVAxVCqv8vTqQ=;
 b=MMquXtkPbLf+m4/E68Gg7E/PykfrYyta6PCpgiV5hDkTNnqBaTaKYgdDXPqDIi7z2H
 TYTi5yjGlb2C6BuzfoC2+PG//UMD6oLY7qrGSz2tcU4+O89f0jqP5psaoIy55xMDPZJN
 Oq9+Mm9sjdhsB4knUHatvOQ9zKnL/IZC5gGhdCfMVf9Blz4dfM3n/ktcugQYjgFZf4Ow
 r5rArmTb3YSH6q9z/fyI8xJ87fuokFuu0nsv2UKLL31GQX4KHTMlI7EntR6FKXYcUDTM
 q4lveVDbg/BWnO/D3NmioN/sFpVEXLCHQPtBU8Q1pUL7ULauW2YGoMQYR0/OFelWps17
 TePg==
X-Gm-Message-State: AOJu0YxlF21H3D1oOMEdPHYVkw9wSeLvb6FJlg2jtq7vTCN1ZTC9hhdD
 YSx/BHJ7sXZOHB8d6Wplto28NRQbxYaYRfmJZ+Xg70Ma21dDBBBXi68hL0X9AF64Scpv+Nvfs6P
 1cbL7rqZdTHgWMWs67IFARHppWBAzB1tA5Pg=
X-Google-Smtp-Source: AGHT+IHVBtLUktgJ96aGzT/oDPODJoLISn44+j9SNqyVCZ+C5XBHH0Yyvg8W5kaAmqnilpCssviDrJnk0+7v5QmTVDI=
X-Received: by 2002:a67:ec0d:0:b0:46d:2a9c:8f44 with SMTP id
 d13-20020a67ec0d000000b0046d2a9c8f44mr1173517vso.8.1707203127364; Mon, 05 Feb
 2024 23:05:27 -0800 (PST)
MIME-Version: 1.0
References: <CACBuX0T3FqTY_BAYjfjQsevJWf=zKafQXO2oPs98hEv93ALHNQ@mail.gmail.com>
In-Reply-To: <CACBuX0T3FqTY_BAYjfjQsevJWf=zKafQXO2oPs98hEv93ALHNQ@mail.gmail.com>
From: Cord Amfmgm <dmamfmgm@gmail.com>
Date: Tue, 6 Feb 2024 01:05:30 -0600
Message-ID: <CACBuX0TKSHoAcdxKh+5Z+RrrwjXOcPnGcyWZf1-PD2OrR1Ppog@mail.gmail.com>
Subject: Re: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=dmamfmgm@gmail.com; helo=mail-ua1-x92f.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 06 Feb 2024 08:24:29 -0500
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

Attempting to resend with both files in the patch this time:

This changes the ohci validation to not assert if invalid
data is fed to the ohci controller. The poc suggested in
https://bugs.launchpad.net/qemu/+bug/1907042
migrated to #303 does the following to feed it a
SETUP pid and EndPt of 1:

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

qemu-fuzz also caught the same issue in #1510

The if (td.cbp > td.be) logic in ohci_service_td() causes an
ohci_die() as well. My understanding of the OHCI spec 4.3.1.2
Table 4-2 allows td.cbp to be one byte more than td.be to
signal the buffer has zero length. The new check in qemu
appears to have been added since qemu-4.2.

Signed-off-by: David Hubbard <dmamfmgm@gmail.com>

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index d73b53f33c..d087f36618 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -927,6 +927,11 @@ static int ohci_service_td(OHCIState *ohci,
struct ohci_ed *ed)
     case OHCI_TD_DIR_SETUP:
         str = "setup";
         pid = USB_TOKEN_SETUP;
+        if (OHCI_BM(ed->flags, ED_EN) > 0) {  /* setup only allowed
to ep == 0 */
+            trace_usb_ohci_td_bad_pid(str, ed->flags, td.flags);
+            ohci_die(ohci);
+            return 1;
+        }
         break;
     default:
         trace_usb_ohci_td_bad_direction(dir);
@@ -936,8 +941,8 @@ static int ohci_service_td(OHCIState *ohci, struct
ohci_ed *ed)
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
index ed7dc210d3..46cab1d550 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -28,6 +28,8 @@ usb_ohci_iso_td_data_overrun(int ret, ssize_t len)
"DataOverrun %d > %zu"
 usb_ohci_iso_td_data_underrun(int ret) "DataUnderrun %d"
 usb_ohci_iso_td_nak(int ret) "got NAK/STALL %d"
 usb_ohci_iso_td_bad_response(int ret) "Bad device response %d"
+usb_ohci_td_bad_buf(uint32_t cbp, uint32_t be) "Bad cbp = %x > be = %x"
+usb_ohci_td_bad_pid(const char *s, uint32_t edf, uint32_t tdf) "Bad
pid %s: ed.flags %x td.flags %x"
 usb_ohci_port_attach(int index) "port #%d"
 usb_ohci_port_detach(int index) "port #%d"
 usb_ohci_port_wakeup(int index) "port #%d"

