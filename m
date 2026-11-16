Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C03606A332
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eIZHYdXT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSuep-0003xk-Tu; Mon, 16 Nov 2026 06:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSuee-0003vs-Kx
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:44 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueZ-0002DK-Uz
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:44 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-492f0a1b685so2354487f8f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827615; x=1795432415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lqHPBwg6LCXp8nV/5IqQVT0IUGaBPYvsZU88BJzDtTE=;
 b=eIZHYdXTwSNhuJ6HDD8HGXbfwyEjExbr/getboERDmR+/ClOCS0olSqw7Wr+CwH7xx
 In2IeVUvqs2sbi9dGaHYKyMCa0QyxJH8W05+4BY1mgLoE5dVZPWDhcgwECiEY+PE5wKg
 ZGeCy5PCENLR4gPLCFqfPRgDoeG++ELmLyeD7Ps7yYvMp0ddwGgc0Ndta7T1T/3iIcju
 Vb/b+aPyis0Yik86KBCUQ21MbUpAHzaq/XOhiQ7RQZd1hecirhvSj6nK5FZPj86fhDCq
 rgupe2noYm71SE66KuSvB4xE8pzxIaBv0YVnkFrgoFWxLDXD01uTIflKhOhwgkFDS9/s
 WW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827615; x=1795432415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lqHPBwg6LCXp8nV/5IqQVT0IUGaBPYvsZU88BJzDtTE=;
 b=25uaRA3jhMB5Oyfq72X2Z582NRFQwgLHAeceNWYYGYmQaFOo+fJLTIi+GezP7EV2HN
 bUmRCmzlhV9+rw+1z23RFOWB2UYpayLZ1HKnfZLDyGN87+8EwbnqlX/O5bzqtAZs7dJs
 xzCOy7kmod9NqTIwQnws3aP/9VlxmjbYFh1szSVBj859lAcEF9aym4FvVeheHYVSmU13
 Ee/b9t2Qzm6lDLjXpW3DZ3OO58WhKyN/BDHGaH/TFcdfLMW78Ra6DYJmSvI90Z7E0xgT
 tmvKy+Ge8o/r5mVpWrX2ElS1FKlrZrBOmqRoT4nBl/7ErH/IktIZi5/FMrKAN1JD2kuQ
 yHuw==
X-Gm-Message-State: APuU4Z9j7Oe/r74qRcQjKs1XGXRwz/1iptdN0oAyUhXsrPYohD5ULT15
 uQ8I9mmm08BV4LA4y8K1ePxN2tXi75QyOJ0VJX82y2OoSYpxGtw0plqUBJATAbZ3RYipciv4WU9
 zpkXGtLY=
X-Gm-Gg: AZFdTZeVP4hX/U4Ck+5dBGeHAaui6J6xZvQhfY6FdvdIYgGY7dy0efyOCvNzgOf9uN6
 Hg48qNgkVkUXyhft3QKOni/wIzh640KTgHIcXB1vjy7hMxu7Lri7aKLXD6QD9BB5mf0+gUlISr1
 hrrZlt5KuGUWdnPobAdy54UDaTwe2IndJRdQXyafVv+fDNXXlot1iXl5A0rJYPqnM/KrLeS6iDM
 egAzP8rA30mHaTAK+I0/zH4q5TGAJG1sCM3uLvsoJ3LEMBro8bOhhJIc5B+t/nSLKyZTY9T9U2k
 Kb4VyREstuhHWgfLvpwfdLdpapCAoxAja/WmgIx4xaBclx+eM+S9KnRiNJRPjb9BX70hpWUfdhr
 MEOroh0oYDV0gD1oPSKDbUtLQ0wxTIYS+f+JuU0lpU3OTamHEMROifz1p2cubMtdV0367uS6W3v
 5ETLqTSaupkSOECbpq/8yH9bRw3GKaCcznSyp6DPjtrfkzMitFSZ4U7KglHkFpozMcyYsedl34X
 b9FMnFTXOQsiD3lKP75abalP+/nKWirvG7jE4MCGOer/tCs9XU+TbVZrvE5f88L3qmCoq+2IUdW
 t/1K1ku1QvnrTEgt/l5PwYx4DALGzfs/zBNX5O6XjKXbGsXpJLwufHCYq38DAzi+HObOKBthxdN
 S9Kf1ZRZ92ljxlkrO1C7yWRaKmD5+7UZ6Pg==
X-Received: by 2002:a05:6000:2888:b0:493:d5f0:4e68 with SMTP id
 ffacd0b85a97d-49c72307130mr23606735f8f.36.1794827614728; 
 Mon, 16 Nov 2026 03:13:34 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/33] hw/net/eepro100: fix use-after-free on reset after
 hot-unplug
Date: Mon, 16 Nov 2026 11:12:57 +0000
Message-ID: <20261116111303.1692832-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stefan Weil <sw@weilnetz.de>

e100_nic_realize() registers a system reset handler via
qemu_register_reset(nic_reset, s), but pci_nic_uninit() never
unregisters it. After the device is hot-unplugged, the LegacyReset
object stored in the root reset container still holds the raw pointer
to the freed EEPRO100State, so the next system reset invokes
nic_reset() on freed memory.

Instead, define a reset phase on the device itself: assign
phases.hold in eepro100_class_init() to a wrapper around nic_reset().
The device is already part of the resettable tree via its parent bus
(TYPE_DEVICE implements the Resettable interface), so no explicit
registration is needed, and the reset state is automatically dropped
when the device is unplugged. This follows the approach used by the
e1000, e1000e and igb emulations.

Reported-by: Hui Peng <benquike@gmail.com>
Reported-by: MyeonghunPak <https://gitlab.com/mhun512>
Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261103215430.703404-1-sw@weilnetz.de
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4058
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4510
Signed-off-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/eepro100.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index aaa3eb60f8a..8fe7f31bd2f 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -617,6 +617,13 @@ static void nic_reset(void *opaque)
     nic_selective_reset(s);
 }
 
+static void eepro100_reset_hold(Object *obj, ResetType type)
+{
+    EEPRO100State *s = DO_UPCAST(EEPRO100State, dev, PCI_DEVICE(obj));
+
+    nic_reset(s);
+}
+
 #if defined(DEBUG_EEPRO100)
 static const char * const e100_reg[PCI_IO_SIZE / 4] = {
     "Command/Status",
@@ -1871,8 +1878,6 @@ static void e100_nic_realize(PCIDevice *pci_dev, Error **errp)
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     logout("macaddr: %s\n", nic_dump(&s->conf.macaddr.a[0], 6));
 
-    nic_reset(s);
-
     s->nic = qemu_new_nic(&net_eepro100_info, &s->conf,
                           object_get_typename(OBJECT(pci_dev)),
                           pci_dev->qdev.id,
@@ -1881,8 +1886,6 @@ static void e100_nic_realize(PCIDevice *pci_dev, Error **errp)
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
     TRACE(OTHER, logout("%s\n", qemu_get_queue(s->nic)->info_str));
 
-    qemu_register_reset(nic_reset, s);
-
     s->vmstate = g_memdup(&vmstate_eepro100, sizeof(vmstate_eepro100));
     s->vmstate->name = qemu_get_queue(s->nic)->model;
     vmstate_register_any(VMSTATE_IF(&pci_dev->qdev), s->vmstate, s);
@@ -2064,6 +2067,7 @@ static void eepro100_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
     E100PCIDeviceInfo *info;
 
     info = eepro100_get_class_by_name(object_class_get_name(klass));
@@ -2080,6 +2084,7 @@ static void eepro100_class_init(ObjectClass *klass, const void *data)
     k->revision = info->revision;
     k->subsystem_vendor_id = info->subsystem_vendor_id;
     k->subsystem_id = info->subsystem_id;
+    rc->phases.hold = eepro100_reset_hold;
 }
 
 static void eepro100_register_types(void)
-- 
2.43.0


