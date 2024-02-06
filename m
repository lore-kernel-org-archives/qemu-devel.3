Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17393C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 13:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXLRA-0005Xn-ID; Tue, 06 Feb 2024 08:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1rXFe2-0006VW-H2
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 02:13:26 -0500
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1rXFdx-0005H0-Cn
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 02:13:26 -0500
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-46d2fc41f16so474232137.1
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 23:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707203599; x=1707808399; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gc47ugBPn+ug+dEFhAGLLTKf3U44w75PGyY0ReTMaBI=;
 b=eZacwcgpEzfHw5zKEF/2/NS7j9vRcS8if9OK29myG5niKOqystFHWFhrws05/liDD7
 Yr+NM3gkCfMNpKf0fOXz0lK3denzqRfkwJiamw/LvnYLGOIHrVu37gkA97xdPzytmks3
 xndsE/Hu8i+C5CS/6Ux1YNxa4bPjexQiDbiLKM8UTs9cWweDfIJD71YKWE/RSwy4lfnP
 hJ2OLkCu1wKlUziuctQLk/fuhm0jgqdf7ecGDIrCGxe6bKZcqmQat7lQU9ATuDF+wz9+
 JQxF8rMJGiEw0QPh6gD5VrGy1SmzG9DhSZkp7AZgnuyDuqMlK0gWwfMkkaeVgCdSzw0Z
 Yi1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707203599; x=1707808399;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gc47ugBPn+ug+dEFhAGLLTKf3U44w75PGyY0ReTMaBI=;
 b=p0WgxEPhxZUDxqhfHVW/tDJnvbYn6oCGWXjzPeg/2jeTrk/WsdBXzju2bxsxC4iIUs
 OksLbNal8zj22TWkqjXj9AcopLURewiWieJvTDxivR0VnGIY4gpcQspASlPieIp0rGC4
 IBMRaAHvSyKSjeyf9RUscvgRzAG+hyUcx21QLLc6yKqPFXkPHP/9OHMXRt7Uko0qlL4Y
 YxI2aOUg9l7ddN4RJB/e+wHwfad6gih5ICsP6VgXgpJHWPCwKEpYZDodfZAyhL69l0vI
 xQKAxmhLKUJaqYp0l/RE1m72VgXqFCEHh240AkILA7N/Vlr+/x3UOtcI1fLg7d26JW7E
 OyqQ==
X-Gm-Message-State: AOJu0YzQF3qP62RY0kB40QuDlOaEXgijXaQqXoi//bHFCqkYWvUa+2yH
 hC0iwNS7F+ZW/gqMxfPoG/cKwkjKV40aUxQt/QfERv/NW4C8x5gDXQGlEEgnbMIoPN921bgehW2
 30HCHwMfnpfU5tkrQdogx0F7KY3xZJ+eI8E0=
X-Google-Smtp-Source: AGHT+IGOw5Zx7x6sH/0OrpGFPhUT6xyks10jZSDvg3yIqo7Ns4xTbJSt7NiIsGnLK+SUiVhoNHWnPjqgcStCDjmYTPQ=
X-Received: by 2002:a05:6102:50ab:b0:46c:b0d6:6037 with SMTP id
 bl43-20020a05610250ab00b0046cb0d66037mr1518392vsb.7.1707203599596; Mon, 05
 Feb 2024 23:13:19 -0800 (PST)
MIME-Version: 1.0
From: Cord Amfmgm <dmamfmgm@gmail.com>
Date: Tue, 6 Feb 2024 01:13:23 -0600
Message-ID: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
Subject: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2e;
 envelope-from=dmamfmgm@gmail.com; helo=mail-vs1-xe2e.google.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, HK_RANDOM_ENVFROM=0.999,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 06 Feb 2024 08:24:30 -0500
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
together.

Signed-off-by: David Hubbard <dmamfmgm@gmail.com>

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index d73b53f33c..a53808126f 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -927,6 +927,11 @@ static int ohci_service_td(OHCIState *ohci,
struct ohci_ed *ed)
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
index ed7dc210d3..b47d082fa3 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -28,6 +28,8 @@ usb_ohci_iso_td_data_overrun(int ret, ssize_t len)
"DataOverrun %d > %zu"
 usb_ohci_iso_td_data_underrun(int ret) "DataUnderrun %d"
 usb_ohci_iso_td_nak(int ret) "got NAK/STALL %d"
 usb_ohci_iso_td_bad_response(int ret) "Bad device response %d"
+usb_ohci_td_bad_buf(uint32_t cbp, uint32_t be) "Bad cbp = 0x%x > be = 0x%x"
+usb_ohci_td_bad_pid(const char *s, uint32_t edf, uint32_t tdf) "Bad
pid %s: ed.flags 0x%x td.flags 0x%x"
 usb_ohci_port_attach(int index) "port #%d"
 usb_ohci_port_detach(int index) "port #%d"
 usb_ohci_port_wakeup(int index) "port #%d"

