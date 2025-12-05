Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839BAD339B9
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 18:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRamJ-0003Hn-OW; Fri, 05 Dec 2025 13:43:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1vRamH-0003Gu-GE
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 13:43:37 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1vRamF-0002TP-01
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 13:43:37 -0500
DKIM-Signature: a=rsa-sha256; bh=lKcU4S4dX52gx3GTm/ddyMmDfJyf2aThLjJei3Ka8gc=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To; 
 q=dns/txt; s=20240113; t=1764960213; v=1;
 b=F9O8D0VFuT8ziwYkHHRanItYCNLVd7LBo41oga5ApwEDofO2cZaePuX5AXW+yckoy5l8DlK9
 KM0c5NY+fqlkVSy68iHodj7y1j4YUlM2Btt3fKW2HNV+ZQcbYsV0IBQBg5DKXJsxylnnJmREJHo
 4IvbY3ZPsN+A9WaSlSQPfDMpkMa2fCVjKqRlczWzDcxhrLVSs6Wa2nnH1Yg+JBo/1Ydd3MZdKDT
 nuktFQIjYySzuLzdXdozHvKd2iMERbA0IoRYm3AX2drEA4Ghv3n1vp4iC/q0MlbM/LJA1q2EIbi
 2i/t6e1DVHi3WlG2vM5h9aIXrDd6iww2p2G3NK7cJ4PIQ==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 8B811243E3
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 18:43:33 +0000 (UTC)
From: ~katharine_chui <katharine_chui@git.sr.ht>
Date: Fri, 05 Dec 2025 19:04:06 +0100
Subject: [PATCH qemu 1/1] hw/input/virtio-input-hid: remove mouse buttons on
 virtio-multitouch-pci
Message-ID: <176496021331.28461.6801034554708153621-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <176496021331.28461.6801034554708153621-0@git.sr.ht>
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~katharine_chui <kwchuiaa@connect.ust.hk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Katharine Chui <katharine.chui@gmail.com>

Having mouse buttons on the multitouch devices causes ui mouse
button events to get routed to the multitouch device, despite
having better options such as a single point tablet or a mouse.

This change fixes Android guests behavior when having both a mouse
and a multitouch device present.

Signed-off-by: Katharine Chui katharine.chui@gmail.com
---
 hw/input/virtio-input-hid.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index d986c3c16e3..5fe91fe498c 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -540,7 +540,7 @@ static const TypeInfo virtio_tablet_info = {
 
 static const QemuInputHandler virtio_multitouch_handler = {
     .name  = VIRTIO_ID_NAME_MULTITOUCH,
-    .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_MTT,
+    .mask  = INPUT_EVENT_MASK_MTT,
     .event = virtio_input_handle_event,
     .sync  = virtio_input_handle_sync,
 };
@@ -603,9 +603,6 @@ static void virtio_multitouch_init(Object *obj)
 
     vhid->handler = &virtio_multitouch_handler;
     virtio_input_init_config(vinput, virtio_multitouch_config);
-    virtio_input_extend_config(vinput, keymap_button,
-                               ARRAY_SIZE(keymap_button),
-                               VIRTIO_INPUT_CFG_EV_BITS, EV_KEY);
     virtio_input_extend_config(vinput, abs_props,
                                ARRAY_SIZE(abs_props),
                                VIRTIO_INPUT_CFG_PROP_BITS, 0);
-- 
2.49.1

