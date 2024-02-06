Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E0EC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 13:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXLRB-0005YJ-VC; Tue, 06 Feb 2024 08:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1rXFTD-00026l-Px
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 02:02:15 -0500
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1rXFTC-000372-4O
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 02:02:15 -0500
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7d5fce59261so234462241.3
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 23:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707202932; x=1707807732; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=P5Dx10JkOUAbkQXsroVOO62dbh+qn5mA5DUfHm8O3xQ=;
 b=gtm/kKwFC3KWBueT1r2UXyVAaADP52j4aXk/MCc7d5URHxeasZo7JeKy0DCmddbIKj
 LVTLyhgA0iQOhrV0sihctSgUnughBqJiXHvCAToX2SNPcIL+BKS+CgXvia2oIuZJI00s
 jwvddk/zP2CWfYIAuBpNPXUDp8xCc/Z/7sJbNfQwQvk5AdznM6bf33+k/kjFW8mdpOai
 BCZIevh/NqqzTdpr2n2DMp0KjB0MRN0OenH2VuQjf4Os26t0/6qMtJuwEZ0Vwt3L04Rz
 SJcAV2BdxO5d0tK1zGzTb8h1uEaDIMreqBJsIV2rxz8INpiWeXvdnbyWTGofMdZKyBFv
 RjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707202932; x=1707807732;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P5Dx10JkOUAbkQXsroVOO62dbh+qn5mA5DUfHm8O3xQ=;
 b=XP/ccmdeuURF3QA1JvcwmPY8ZaNJbKkg0csSc5agA6GeGooHOPnFmop7lVG2WZL58S
 ypJRLPik+8xSOeSJv62wZ9YwcWjhdxn1e5tBSevyGXQGprrXuPwv7GJTsTHXFuFRy0ew
 UA4PtrSfVoiipTH3kCxYuTco1AeEJxBpe+b7DUA3fKzo+Gls1wOnT3QxPZqDgwkzFYH7
 EWlUigiMJiqYI88vdpGWpoy6s23wK3XUwKCAFgFMT8c0p2qG/h/RVF+wv6PwNVAaHfoS
 CjSsRe33e7TaT60Dek2civ33ZFJ31oQq6mBd0EFCQYLRY9QHJ2J1tc7MIQdW6xQqOznd
 uhyQ==
X-Gm-Message-State: AOJu0YxZNHWl+T/du7yT7/NKwSshEkl4Nwv2xcDOaNfRD7FeP6e1VIoK
 mq51F21BlQ6ojTk8MTo1KmfCTX+JILB115zlbgS6sTTqULOh5h/evSHZOKINHKm6wkgsJalwU/w
 FF4+RhkRNPpd/V+cCQXr2Cb5en4nIPElgmrQ=
X-Google-Smtp-Source: AGHT+IGqcZh9prgtpeqEO34lKCEzv3yiXhKxA/u+AcVVsvzlfuFRr4g1PfyPBoxMLGW8jMbFMj5Ox7vkoptt+NXUkAE=
X-Received: by 2002:a05:6102:3a64:b0:46d:398d:757a with SMTP id
 bf4-20020a0561023a6400b0046d398d757amr1911846vsb.13.1707202932215; Mon, 05
 Feb 2024 23:02:12 -0800 (PST)
MIME-Version: 1.0
From: Cord Amfmgm <dmamfmgm@gmail.com>
Date: Tue, 6 Feb 2024 01:02:15 -0600
Message-ID: <CACBuX0T3FqTY_BAYjfjQsevJWf=zKafQXO2oPs98hEv93ALHNQ@mail.gmail.com>
Subject: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=dmamfmgm@gmail.com; helo=mail-ua1-x92a.google.com
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
        ed->attr = (MaxPacket << 16) | (TDFormat << 15) |(Skip << 14)
| (Speed << 13)
                   | (Direction << 11) | (EndPt << 7) | FuncAddress;
        ed->tailp = /*TDQTailPntr= */ 0;
        ed->headp = ((/*TDQHeadPntr= */ &td[0]) & 0xfffffff0) | (/*
ToggleCarry= */ 0 << 1);
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

