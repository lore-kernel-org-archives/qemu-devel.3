Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2114AC4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 02:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wle4F-0004mt-SI; Sun, 19 Jul 2026 22:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jianghaotian.sunday@gmail.com>)
 id 1wle4C-0004mH-8M
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 22:49:16 -0400
Received: from mail-pj2-x0a.google.com ([2607:f8b0:4864:39::a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jianghaotian.sunday@gmail.com>)
 id 1wle4A-0001X9-Fe
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 22:49:15 -0400
Received: by mail-pj2-x0a.google.com with SMTP id
 d9443c01a7336-2cf49dc298bso14586185ad.0
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2026 19:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784515753; x=1785120553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=m8lltpzLlvYxzHjHcmkKzoMmUMZ6AAvTk0ePIiurVHc=;
 b=pzQELLBHPHRkSBolH9F8LAtTNUb89LN0qkICRXUmGzFBgmmfRbvSxXQA/cQVggiMrZ
 P+J4CxPNUgXYNsBxIvsv7zgzYtyCYLxkdgEt6jGCkXKElc+RWhINppru0/JHTf91y6p0
 D7IIt9wPOKTQhRknvMDPxtZEFNsqrLcfmt0Ejk4/nznuJT841nDtVbdIug3kN/VVddzY
 vKUm+8CUzbRplpjh5++J2RHLjC4MrbTWbkNj4oK99IisuOpiiArkGyPUWthe/81uIvSP
 Iy1ugFUpMJW78fMtmLdJWAT3r+sfXB/964ScmW7cSky5jhx235Mb0ntcz2OMPljLBR/t
 5Oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784515753; x=1785120553;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m8lltpzLlvYxzHjHcmkKzoMmUMZ6AAvTk0ePIiurVHc=;
 b=dgUyXaJu2m1lXBF5O3CcyH2vETIkm3Bzj4dnH+WTb3iKTjHPXEHoYpX2CJ6YB4Dfq/
 efswHxMMSWXQm9DplRMAlXBZit2cqBUYEnlqyCidCxANhpQsDuhO3ibQsoQxUn5n7zmG
 aqJGNb4T0Ds2jsBNuNUgxOTjSyGXY2aU3UXLjDtcNoScY8U4tfgNtaN9qJrw+eWdYIrw
 LXuM6WfVM6GG1rgWvwDR5UAdxR0U724tIeXsE6mlIB4wQUFAder1F9ls/neFZRE21CbE
 OD4OxvMcnZQmTozDuD7tVGUeC1U1Ffy54EqC6T7FkUS87v3ZLW24s6OqQcpzU4kB99TZ
 ny8A==
X-Gm-Message-State: AOJu0YzWcc2q03gRxC38XgueP8hTOHUrYLtJp8MLYEc78i1ml03MtXmF
 j+13uDgZypiE9+sWbAZf6CCa/E6o+ov1Dq/Za6c2lLj4i1Bz6RNcpg5Zn+LWgtubsFhAx2Xm
X-Gm-Gg: AfdE7ck2Knceazbwg2HprmOcusHyeMXOcdW5pVSYZ/9d0HCRVNviCAoLL1q8OTegFCH
 XmYMaNa1OpIL6A1jT286WloZXggAnuS5KMW4Yhgc+Szg4ZP5E9/gLjdm49A0PfGgNhh2HwZsN5Z
 R4ooXqXpPHGwVR3NZTAG+G7g32Y4OQpW6MXksTYOxWKLljjhVtIZOsZgXZntQNHxSpzsNmTXlPI
 Ec6HLgv017lbYSivv+CaamQTORItAqB1jdKb53cVzJW78u5zqEOqpebhi28mRQYjYn0MX6VKh7c
 fv/6G7XExgPtECR3/Lb9GQrhTSVHQcBshyIe8uKp2mrFpZk1XRPUbFoEXGqZggsvtUQ02BJv2y0
 0za2K+Oe+EP4MF+L3lX1hlAdxt/WLegAsbk9kLzxM56xSvFjPHfRUsXsMXAEmJmXxRE9I5kq3MY
 eWiqV9/MP5Cz9Ze+/4KaIqH5SQ2knicj1H2klY1apaF9PgrEZ8PAoUcDppdIVpTF7oCy+8KAgYN
 VmgFI++tBLDRIychCboZSHdi4tk
X-Received: by 2002:a17:903:1a43:b0:2cc:7d4a:3f5a with SMTP id
 d9443c01a7336-2cf3487711cmr143468335ad.20.1784515752770; 
 Sun, 19 Jul 2026 19:49:12 -0700 (PDT)
Received: from VM-210-252-ubuntu.. ([14.22.11.168])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf347554a2sm48885115ad.73.2026.07.19.19.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 19:49:12 -0700 (PDT)
From: jianghaotian.sunday@gmail.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, philmd@mailo.com, vsementsov@yandex-team.ru,
 thuth@redhat.com, farosas@suse.de, qemu-stable@nongnu.org,
 Haotian Jiang <sundayjiang@tencent.com>,
 Haotian Jiang of Tencent Security <jianghaotian.sunday@gmail.com>
Subject: [PATCH] hw/display/qxl: unregister vm_change_state handler and BHs on
 device exit (CVE-2026-63322)
Date: Mon, 20 Jul 2026 10:48:55 +0800
Message-Id: <20260720024855.3757499-1-jianghaotian.sunday@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::a;
 envelope-from=jianghaotian.sunday@gmail.com; helo=mail-pj2-x0a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Haotian Jiang <sundayjiang@tencent.com>

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
 hw/display/qxl.c | 15 ++++++++++++++-
 hw/display/qxl.h |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 74258afa58..c9323672a6 100644
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
@@ -2475,6 +2476,17 @@ static const Property qxl_properties[] = {
         DEFINE_PROP_UINT32("yres", PCIQXLDevice, yres, 0),
 };
 
+static void qxl_exit(PCIDevice *dev)
+{
+    PCIQXLDevice *qxl = PCI_QXL(dev);
+
+    g_clear_pointer(&qxl->vmstate_handler, qemu_del_vm_change_state_handler);
+    g_clear_pointer(&qxl->update_irq, qemu_bh_delete);
+    g_clear_pointer(&qxl->update_area_bh, qemu_bh_delete);
+    g_clear_pointer(&qxl->ssd.cursor_bh, qemu_bh_delete);
+    g_clear_pointer(&qxl->guest_surfaces.cmds, g_free);
+}
+
 static void qxl_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -2482,6 +2494,7 @@ static void qxl_pci_class_init(ObjectClass *klass, const void *data)
 
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
Changes v1 -> v2:
  - Use g_clear_pointer() for cleanup per Marc-Andre Lureau's suggestion
  - Simplifies the code by removing redundant NULL checks and assignments
2.34.1


