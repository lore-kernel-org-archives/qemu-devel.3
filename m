Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B32FC44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 04:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkaZb-0001dE-7l; Fri, 17 Jul 2026 00:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jianghaotian.sunday@gmail.com>)
 id 1wkaZZ-0001cz-PK
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 00:53:17 -0400
Received: from mail-pj2-x01.google.com ([2607:f8b0:4864:39::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jianghaotian.sunday@gmail.com>)
 id 1wkaZX-0002il-UM
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 00:53:17 -0400
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-37fb1883fbfso1578515a91.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 21:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784263994; x=1784868794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=A2FJkZW2/6/XvxRekeDsl5ImVnfRSwjbV/A7iBIingk=;
 b=qLy/fw7Mx+LW6k6UN+WVxccJgrO/ktF24XzO20PAlXMaXpV7inZNYRift1mM7zcoop
 Q2VyBR7KAhwKok3nHzsnuR711BfHsfThItfwL7cKS/U+y6Q9hYp8nQI1qXv1NaUz8JcB
 KyNcVBjUeXqbg20+Z/JKAVdFzKWojN7z08ftEqlnzc8zFmQ30DJVCxTPUG4okqq15tkC
 0jQwR7uyzv4KzlfiZgI3iQ3mQYqTA4TLio9JKdTm6fDHrQBjOFiPuYFeOglT9jPv5OzM
 6x72WQ3zvxD4L1g1aNCA9CKkVxJguWQu7wVqWFHY4nYGM/7t9Jyf/6c9oVNNuYPBqvd9
 JSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784263994; x=1784868794;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A2FJkZW2/6/XvxRekeDsl5ImVnfRSwjbV/A7iBIingk=;
 b=dpSeV5bO5YKBq4zBqXs4vR2qmN83AxDyawusxIqyRg5RlGRsE+JvzcezvfxUkJCoAG
 qiOwu1b71XCVkVLxjbbvwH4lSDoLfvr2UGFQYToPCskTFsmW1/RJGiMt24IPzzsgfvOj
 yQfHhSHwKb4Y4Zo+kZF7RtfGfV4EsG3pGUfNUkfQ3hrg2IcCRPjkwi+W5Cobk9unTYMG
 4e5JQv2d1OQtrGYn2u8GVoQosaXGwGe8AtXepqE5qnJKa2g2/j6Okg5gKiIrYIntSXrH
 7Oo6O0HWYCKyRMEjp5ygvuHVQXI1pYqITtXfObArTiLG+NxyqT5czTWj71BUJt232ut6
 RxOg==
X-Gm-Message-State: AOJu0Yzhrlz75KDTv/rRkh+PvpCKVPsqVyDhvij9N+YS6WAsayvqtjNR
 LjJjHsVdrdAfjCYGpXQbYVE3Pbc8SppD8lLCkoxsdHIN35hagFt//1M+zV6MSZLD6R0=
X-Gm-Gg: AfdE7ckw7DH/zFpdcq51E8kABcFp8KHdorp3XuxCxQRgI9G/MXef+tIJ1PMYXMLL02E
 CikflC2t++sx59+Bhjrt9KeB2ETut6/p2bW+U6+1GrXRMNz2k2aj6ANnAXH38XGRG4QeL6QALut
 c3j839qkSZLqZNUv9gvXIaNwKOk41cF7x+zwBnHtf7VNzo4uUq7owc6Q6gQbFWzvanj4rHhW9UD
 gIpxuhnOicCQPb+xenOThcw0CuTQU58Ffgv1G53aL6cXkvyWBxwtGm/FZwXlqkdY5Dt1gDCnlqW
 +gmuDlYZpSn0XqvfK67TV/Och+2jNvPcx3I2+c82pXlF/RteKu/W92MQ+Dx2y2bx8pRpkE7L99r
 EWmjqjhNvMwHTPFfpIcKtB+wwR/KrrEEEtnQxTOrSGWRy9HLou0a5GM7WuZSR/AUKa81WAwxvKF
 wEPA5gbCyK3UkaR7O8Jwps7qGuVn4AW8djU8uNPXu/CS4/s6u5R1QCo9qBAMRHSWb+WAjH6m1Sl
 TRJ+Zu6cXka3+qEsRSt+bYhp8d/
X-Received: by 2002:a17:90a:d44e:b0:38d:ddc2:7ccb with SMTP id
 98e67ed59e1d1-38e4b3d0fdamr911730a91.1.1784263993749; 
 Thu, 16 Jul 2026 21:53:13 -0700 (PDT)
Received: from VM-210-252-ubuntu.. ([14.22.11.166])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e4b22a0c7sm353628a91.14.2026.07.16.21.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 21:53:13 -0700 (PDT)
From: jianghaotian.sunday@gmail.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, philmd@mailo.com, vsementsov@yandex-team.ru,
 thuth@redhat.com, farosas@suse.de, qemu-stable@nongnu.org,
 Haotian Jiang <jianghaotian.sunday@gmail.com>
Subject: [PATCH] hw/display/qxl: unregister vm_change_state handler and BHs on
 device exit (CVE-2026-63322)
Date: Fri, 17 Jul 2026 12:52:53 +0800
Message-Id: <20260717045253.4004241-1-jianghaotian.sunday@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::1;
 envelope-from=jianghaotian.sunday@gmail.com; helo=mail-pj2-x01.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Haotian Jiang <jianghaotian.sunday@gmail.com>

qxl_realize_common() registers a vm_change_state handler via
qemu_add_vm_change_state_handler() and creates three bottom halves
(update_irq, update_area_bh, cursor_bh), but none are ever cleaned up.
The return value of qemu_add_vm_change_state_handler() is discarded, so
the handler is never removed from the global list, and there is no
PCIDeviceClass.exit callback to delete the BHs.

When a secondary QXL device (hotpluggable by default) is hot-unplugged
via device_del, the PCIQXLDevice memory is freed but the vm_state
handler and BH entries remain with dangling opaque pointers. On the
next VM state change (stop/cont/migrate) or BH dispatch, the callback
dereferences freed memory, causing a use-after-free.

Fix this by storing the VMChangeStateEntry returned by
qemu_add_vm_change_state_handler() and adding a qxl_exit() callback
that deletes the vm_state handler, all three BHs, and the
guest_surfaces.cmds allocation before the device memory is freed.

Fixes: a19cbfb34642 ("spice: add qxl device")
Fixes: CVE-2026-63322
Reported-by: Haotian Jiang of Tencent Security (Yunding Lab) <jianghaotian.sunday@gmail.com>
Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3607
---
 hw/display/qxl.c | 29 ++++++++++++++++++++++++++++-
 hw/display/qxl.h |  1 +
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 74258afa58..23608f988a 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2203,7 +2203,8 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
         error_report_err(err);
     }
 
-    qemu_add_vm_change_state_handler(qxl_vm_change_state_handler, qxl);
+    qxl->vmstate_handler =
+        qemu_add_vm_change_state_handler(qxl_vm_change_state_handler, qxl);
 
     qxl->update_irq = qemu_bh_new_guarded(qxl_update_irq_bh, qxl,
                                           &DEVICE(qxl)->mem_reentrancy_guard);
@@ -2475,6 +2476,31 @@ static const Property qxl_properties[] = {
         DEFINE_PROP_UINT32("yres", PCIQXLDevice, yres, 0),
 };
 
+static void qxl_exit(PCIDevice *dev)
+{
+    PCIQXLDevice *qxl = PCI_QXL(dev);
+
+    if (qxl->vmstate_handler) {
+        qemu_del_vm_change_state_handler(qxl->vmstate_handler);
+        qxl->vmstate_handler = NULL;
+    }
+    if (qxl->update_irq) {
+        qemu_bh_delete(qxl->update_irq);
+        qxl->update_irq = NULL;
+    }
+    if (qxl->update_area_bh) {
+        qemu_bh_delete(qxl->update_area_bh);
+        qxl->update_area_bh = NULL;
+    }
+    if (qxl->ssd.cursor_bh) {
+        qemu_bh_delete(qxl->ssd.cursor_bh);
+        qxl->ssd.cursor_bh = NULL;
+    }
+
+    g_free(qxl->guest_surfaces.cmds);
+    qxl->guest_surfaces.cmds = NULL;
+}
+
 static void qxl_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -2482,6 +2508,7 @@ static void qxl_pci_class_init(ObjectClass *klass, const void *data)
 
     k->vendor_id = REDHAT_PCI_VENDOR_ID;
     k->device_id = QXL_DEVICE_ID_STABLE;
+    k->exit = qxl_exit;
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
     device_class_set_legacy_reset(dc, qxl_reset_handler);
     dc->vmsd = &qxl_vmstate;
diff --git a/hw/display/qxl.h b/hw/display/qxl.h
index ad8a912878..48d664f777 100644
--- a/hw/display/qxl.h
+++ b/hw/display/qxl.h
@@ -83,6 +83,7 @@ struct PCIQXLDevice {
 
     /* thread signaling */
     QEMUBH             *update_irq;
+    VMChangeStateEntry *vmstate_handler;
 
     /* ram pci bar */
     QXLRam             *ram;
-- 
2.34.1


