Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB78606A883
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HVNRQx1h
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSwOL-0002zU-UU; Mon, 16 Nov 2026 08:05:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dzulfikar.at@gmail.com>)
 id 1xSntX-0008JJ-NF
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 23:00:42 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dzulfikar.at@gmail.com>)
 id 1xSntU-0001fT-AW
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 23:00:38 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c4322d310e7so560485266b.0
 for <qemu-devel@nongnu.org>; Sun, 15 Nov 2026 20:00:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794801634; cv=none;
 d=google.com; s=arc-20260327;
 b=rFz5oiYbqL/9YVCM0LV+bxwuUKlwl0Kp0Kh+xtAdauvSDhajit9zZIxPWL/4DRwpLi
 CyqPW3zkmByS6lWCKZPD3Gw0UNAI+FrIrEmYx4p8Z9fbzfZHleyDdP1stXoBa/IJ+wMA
 Y7wfDqvE/CmeXTrhtYFu9uJMOq8TUNObGrdG+tPa8GAEFINrH2w2TAAIWFQjwSlF839f
 XH/OcszhSpld8nB+R4+/yJH6CJhsKgjNfYjQ3xQ0apLcO6D8pRovIHNzj1nXDpNkEoMH
 LOBkhmY3QFpcCgMpGKH317CdETDBGlEIUx4P4CBgtPZRI3XWjIT1t3UcWV01EMEnDnvu
 MvuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=/teIbFDfFMVmxQje9kp2hS399UAI+EGdwUcW/53j7Yg=;
 fh=+1s+9yvYs7Nh3GwsadYf3eNpEFzOi0Ny4bdYxASykYA=;
 b=efmypcQrNPiCviwoop/egFYWShcJFcCN4CPRRB5hqGY48d327G9VWEeCzs3i09qh8Y
 /SAbikQL0OgNqzfhj+nwGg6a6STYrXtOdxH6uPPBbovSosth0+ZjIwzYYTaVW0fVWkQp
 JIb+1pyyWq7UJqGk4WYc+T9yQ27a2kc75ZXFWNqhI1w+E835tt+cGGZFe7aYliCYwpbj
 NW7TD4r1YsUMzIYm/BrHP5YUkjBuijSgAMweB03eJiuukb8nCUd6wRrmvRac9U+EOd/s
 7dxX1lY2SpzggHYlar4GVneeTIEju0PST5uceRwqbniQIkXV5LFofL52zZ4OPNZRJQo/
 fhuw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794801634; x=1795406434; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/teIbFDfFMVmxQje9kp2hS399UAI+EGdwUcW/53j7Yg=;
 b=HVNRQx1hQdmpQ9Ew7PHCuNWKRYltH8y/IekdgPr3SMWzNuhTvXR68U0ZHc3WC3bzxW
 kg3k1Qzii41UQDCHLFzfno52Hsn1GebqIfcAeHXQnK99xCY0vAB5WARCK5pbbN92p5/x
 yyrNVjEeulRA//ttrEE2ztAy8xrtG4YarXQUtuxiV1Z502dViNgV5gfvJI2h7WCoD+BE
 0L/SJaNJCM9dj5hUPwf0yhc03B4dEXfXCCycCA9r0kVH6G/K5HWxT7KoFDQcbOQCmiaB
 M07N67hFyfqpfJsCMgPTKTlbSxOKvlEC+k+qYk6tn7mg7r8FjDGlvWb3U3bPfyW6nkGL
 bSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794801634; x=1795406434;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/teIbFDfFMVmxQje9kp2hS399UAI+EGdwUcW/53j7Yg=;
 b=fOOYIA5ghxDJKy/cBEVSDefdNUF5jMc7yNEkTSCz1ToPWfZHS4798An6Muq87Bjpz/
 6+3HXoQjyS8vzehCZ4KfaqT3pT8v1YFjTU0ypgbSwVXmHUeGw7t9lZJLJ8qNFSYDwUyR
 0jbMIBSHZ5C8vgiiC+XFIGZwB03u79cb13KDXOOz84BwxFkXBHP0GptVo/yt6824Z0bv
 MthdXBpBu945CCVgsrVYexJvHUCTdlTRWWgYoR1jTQ70Zwoop7WDlP/nfEgUrlbqQ4aA
 laUOB4YYWWgFXlKZbZNupU14BJ9IJDXhs3UrehbfVq0qDEpoCOcIJm2m/+CEwRmb7Ww3
 xGwg==
X-Gm-Message-State: APuU4Z+a/uIO6SEzM9X8rCUPAyzqcHwfMR+D3sKtj03h4RN2dUiPhdKW
 g0PSi8SHhyLR8l0qKmw8gZNTB+eHrka3FSyoc8tnTd4xX7Y31ndDuWdFcW6Hp9NMXBRH4bWBTyk
 d43e4ct3NQ2SOw7aBQdl1lvdYwkkTM+Gb+8DQFcGWpA==
X-Gm-Gg: AYBFou3dKm2KhaCysqfhwOHm+Q06cJnzFb3jRZErNOZjdvv6cikvnxx3LBLarW9m5rF
 pTrJZJdvUxiZDaHJIY2BOkIftvvY8PSC+MMpHBTVIo3VkJ1f65tqai03VKIIKlmYjeya/H1OCPw
 a9JwJeynKUkeFxXXd0H9Bv+zoeR8d8k+2jSFSaTdjyFJeq+GjFHyI62bOeQkQ0r+zPetBodv9Lb
 n6I8HbNSNjfBcChZzGxdQKQUasjhVD7XTeaLXDkYV+afCKD1gei7p1XqNxHvKV3zl0yPOD9WCKu
 ET3eoI6+MPbN8aTaUTAG9yC+FAuXl//MmDhrzwVmSIBDicwNCb8ScBXoLAyoLMCZknvwOaLbFAG
 EreuLAcFOxe2Qgzh/RdGjYr6P3ZE5BtPMkdwbcOIwkxwrgsuOCgOCAKWKgQ3V+S7KPevei0nNpH
 jsHA8RBYGhna/SNKOileT8EhyHiEzSOC7CdUOG4CLs/U63qMBgtSLxPA2FtkJOH61tyfQoUk/Mp
 ZZlp/vSbCYU
X-Received: by 2002:a17:906:f596:b0:c42:3a77:80e5 with SMTP id
 a640c23a62f3a-c5096349305mr762081166b.29.1794801634080; Sun, 15 Nov 2026
 20:00:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Dzulfikar Ats Tsauri <dzulfikar.at@gmail.com>
Date: Mon, 16 Nov 2026 11:00:22 +0700
X-Gm-Features: AclHuK9RJYo_Pf7sTorHpSbFMZB9nO2LqDVHOtnTTe8jFUF5wZzdy4pbaSZRSXE
Message-ID: <CAEmBMp=RoDSKfBByo75OshYN4vK3yRgPM++yJsewBSioOb6odw@mail.gmail.com>
Subject: [PATCH] hw/net/can/ctucan: report fault confinement state, raise FCSI
 on enable
To: qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 Vikram Garhwal <vgarhw@gmail.com>, Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=dzulfikar.at@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 16 Nov 2026 08:05:00 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The CTU CAN FD model never leaves its reset fault confinement state:
INT_STAT[FCSI] is never set, and reads of the EWL/ERP/FAULT_STATE
(0x2c) and REC/TEC (0x30) words are not handled, so they return 0.

The CTU CAN FD datasheet (v2.7.0, section 2.5 "Operating modes")
describes what happens when software sets SETTINGS[ENA]: the core
integrates to the bus while it is bus-off, then becomes error-active,
and "the moment when CTU CAN FD joined CAN bus communication can be
determined by FCS interrupt, and subsequent probing of FAULT_STATE".
Section 2.12.2 adds that FCSI is set "upon any Fault confinement state
change (even bus-off to error-active)", and the COMMAND[ERCRST]
description that a disabled core (SETTINGS[ENA] = 0) is bus-off. The
RTL matches: fault_confinement_fsm.vhd resets to bus-off, the CAN core
is held in reset while ENA is 0, and protocol_control_fsm.vhd sets the
node error-active, clearing REC/TEC, at the end of integration.

The Linux ctucanfd driver relies on exactly this. ctucan_chip_start()
sets the interface state to CAN_STATE_STOPPED ("Controller enters
ERROR_ACTIVE on initial FCSI") and enables the core; the error
interrupt handler then reads FAULT_STATE to find the new state. With
the model, the interface stays STOPPED ("ip -details link show can0"
reports "state STOPPED") although frames are sent and received, and
raising FCSI alone would not be enough: FAULT_STATE reads as 0, which
the driver treats as an invalid state (WARN in
ctucan_read_fault_state()).

Model the documented behaviour:

- Reset (MODE[RST]) sets the register reset values: EW_LIMIT 96,
  ERP_LIMIT 128, FAULT_STATE bus-off, REC and TEC 0.
- Clearing SETTINGS[ENA] returns the node to bus-off with cleared
  error counters.
- Setting SETTINGS[ENA] makes the node error-active and raises FCSI.
  The model has no bit timing, so integration completes at once.
- EWL/ERP/FAULT_STATE and REC/TEC are readable.

The model does not produce bus errors, so the node then stays
error-active until it is disabled or reset. Writes to EWL/ERP are
still ignored (Linux never writes them). Both registers were already
part of the migration state, so no VMState change is needed.

Datasheet (v2.7.0):
https://canbus.pages.fel.cvut.cz/ctucanfd_ip_core/doc/Datasheet.pdf
RTL: src/can_core/fault_confinement_fsm.vhd at commit b76a8888ecd1 of
https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core
Driver: drivers/net/can/ctucanfd/ctucanfd_base.c in Linux

Signed-off-by: Dzulfikar Ats Tsauri <dzulfikar.at@gmail.com>
---
Tested on master 29760efaf9 (v11.2.0-rc0) with qemu-system-aarch64 -M virt
(--target-list=aarch64-softmmu), booting a Linux 6.18.59 (arm64) image with
-device ctucan_pci bridged to a host vcan interface (can-host-socketcan):

- With the patch: the driver logs "ctucan_err_interrupt: ISR = 0x00000010"
  and "state changes from CAN_STATE_STOPPED to CAN_STATE_ERROR_ACTIVE";
  "ip -details link show can0" reports ERROR-ACTIVE; after "ip link set
  can0 down" it reports STOPPED and the next "up" raises FCSI again;
  classic and CAN FD (64 bytes, BRS) frames pass in both directions.
- Without the patch, same image and setup: frames pass, but the state
  stays STOPPED.
- tests/qtest/xlnx-can-test (5/5) and xlnx-canfd-test (3/3) still pass.
  There is no qtest for the CTU CAN FD model yet; I can write one (enable
  the core, check FAULT_STATE and INT_STAT.FCSI) if that is wanted.

The same change on QEMU 10.2.0 has been in use in a Yocto build since
2026-11-11.

 hw/net/can/ctucan_core.c | 50 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/hw/net/can/ctucan_core.c b/hw/net/can/ctucan_core.c
index f6ff4ad..d2bb747 100644
--- a/hw/net/can/ctucan_core.c
+++ b/hw/net/can/ctucan_core.c
@@ -188,6 +188,36 @@
     s->status.s.txnf = txnf;
 }

+/*
+ * Fault confinement. While SETTINGS[ENA] is 0 the CAN core is held in reset:
+ * the node is bus-off and both error counters are zero. After the core is
+ * enabled it integrates to the bus and, coming from bus-off, becomes
+ * error-active, clears REC and TEC and raises FCSI. The model has no bit
+ * timing, so integration completes at once, and it never sees bus errors,
+ * so the node stays error-active until it is disabled or reset.
+ */
+static void ctucan_fault_confinement_reset(CtuCanCoreState *s)
+{
+    s->ewl_erp_fault_state.s.era = 0;
+    s->ewl_erp_fault_state.s.erp = 0;
+    s->ewl_erp_fault_state.s.bof = 1;
+    s->rec_tec.u32 = 0;
+}
+
+static void ctucan_set_err_active(CtuCanCoreState *s)
+{
+    union ctu_can_fd_int_stat int_stat;
+
+    s->ewl_erp_fault_state.s.era = 1;
+    s->ewl_erp_fault_state.s.erp = 0;
+    s->ewl_erp_fault_state.s.bof = 0;
+    s->rec_tec.u32 = 0;
+
+    int_stat.u32 = 0;
+    int_stat.s.fcsi = 1;
+    s->int_stat.u32 |= int_stat.u32 & ~s->int_mask.u32;
+}
+
 void ctucan_hardware_reset(CtuCanCoreState *s)
 {
     DPRINTF("Hardware reset in progress!!!\n");
@@ -230,6 +260,11 @@
     s->rx_fr_ctr.u32 = 0;
     s->tx_fr_ctr.u32 = 0;

+    s->ewl_erp_fault_state.u32 = 0;
+    s->ewl_erp_fault_state.s.ew_limit = 96;
+    s->ewl_erp_fault_state.s.erp_limit = 128;
+    ctucan_fault_confinement_reset(s);
+
     s->yolo_reg.s.yolo_val = 3735928559;

     qemu_irq_lower(s->irq);
@@ -311,12 +346,21 @@
     } else {
         switch (addr & ~3) {
         case CTU_CAN_FD_MODE:
+        {
+            bool was_enabled = s->mode_settings.s.ena;
+
             s->mode_settings.u32 = (uint32_t)val;
             if (s->mode_settings.s.rst) {
                 ctucan_hardware_reset(s);
                 s->mode_settings.s.rst = 0;
             }
+            if (!was_enabled && s->mode_settings.s.ena) {
+                ctucan_set_err_active(s);
+            } else if (was_enabled && !s->mode_settings.s.ena) {
+                ctucan_fault_confinement_reset(s);
+            }
             break;
+        }
         case CTU_CAN_FD_COMMAND:
         {
             union ctu_can_fd_command command;
@@ -494,6 +538,12 @@
             val = 0;
         }
         break;
+    case CTU_CAN_FD_EWL:
+        val = s->ewl_erp_fault_state.u32;
+        break;
+    case CTU_CAN_FD_REC:
+        val = s->rec_tec.u32;
+        break;
     case CTU_CAN_FD_TX_STATUS:
         val = s->tx_status.u32;
         break;
-- 
2.56.0

