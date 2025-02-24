Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50671C021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 18:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdH0-0001zH-Hd; Mon, 24 Feb 2025 13:33:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tmdDO-0005n0-2W
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:30:04 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tmdDK-0003Ob-4I
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:30:01 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2211cd4463cso95523035ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 10:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740421795; x=1741026595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VP4n7opB8QbukdZTzJ/LfTVgdfdNgX/zuMQKCJL71FE=;
 b=cbtJcPKT+laILcR9vOYpLeGgSH4S71mPg1FnsTzaw9qV4ABU4Pm93NhpDKub0sFJeF
 STpc2vPW/Nja7hhMvK3DxWCEBAAEiKvZSPtnxD9a30wRzIgXpZ42zKBOIkH2Zzwb9NYA
 Aspz40UBQyA/L04Ut5sqezyeJ8bBJaeZEXRdtW8L9FiqKIdgyXQNlTWY1IeULrBakb83
 ylGcQkXCnTfj82ka7QzsgixBlP+vqzG3J2H6zh8oQxBKfAgDJXKq9f/x5p4HwA+TPW2U
 t1IhhKAeA6W1OSTWKpTOlhjJJp/tx0VfWR12WHbHH4JLZPlR1WS5q7o6oKcH0PQjc//p
 xF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740421795; x=1741026595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VP4n7opB8QbukdZTzJ/LfTVgdfdNgX/zuMQKCJL71FE=;
 b=vcqzjTmGCt71/m/IxITM8XgfJUqQNTfy8dCOXxpK2Ir+MbRyco4fKRqcC0t0qfumfr
 rYxYEsLoDuFIGPhgl+XwSNxn2ZxQzfPaPOf+w3x3N/3stWVSG+kqVaMrr7esKaWBoh3S
 9XyhksgXRyqU0Ziklz0ETBh4eCKf777szh/yRiurCMwjJ0vrmhXcgla1VfgiNhdo8Wja
 7t73/jxbj6oXFcMe7AVKvn2yk3HZqBCX8U40wN/3SXcO9qeb8RBKU3eP4q++pZFeadS9
 1WPCv83X2lEj2Yl1wIyLEInwbiZrWmeVoqpT5tqlB13z0FJlhVIAeqpkxnQtsm3D1T7g
 KzJw==
X-Gm-Message-State: AOJu0Yz0AicEewUq5bj7cFnc8Wz4TVA84+2PLeTB7xjQ2YSr3Bv8lRLj
 YrQA5TpJVEi72Hwq0boz1uZhWl+DlNDq3jrE7jd2VhIlDVNOZno=
X-Gm-Gg: ASbGncvOmRjqCb75IIU6O6SqWj3y4Vn97p/AWx81W4DEZL8yyaXo74GJZKJ4N/JaEM0
 v0gQmsZh3V6R7C5Q3wvkuUmxwSFte1V6YbcjdbF2gT56RDu+dKeZFgBhcNWGbqjeA7S1X0E0Sq9
 ua/ickQZkn9CwucX4yq09vCR3C4NT9cxc7L7LuMfpKKi/iD+EQ8+4n3TSCps1sa/e3itQWwJPws
 3ApjKOQzfiy+qVnnKjb6DQLRRGvsowJdojJVookD9bKDelG+4VX1sCRb2d+uALGpoT8QFGBHp0w
 1lWkKhSYHnjFjn5h3ftIxpzAl37nlkBhFp+L39E=
X-Google-Smtp-Source: AGHT+IE1w4lE5U9bUzPUCbbkcruo6kYxA/96ec9zeQ4Yck/h8QPGjs4Wt6qKa+nUQDBYCiRtrDGZdQ==
X-Received: by 2002:a17:902:ccc8:b0:215:44fe:163e with SMTP id
 d9443c01a7336-22307b33029mr3774315ad.1.1740421794986; 
 Mon, 24 Feb 2025 10:29:54 -0800 (PST)
Received: from localhost.localdomain ([116.227.8.253])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545cf6bsm183662615ad.123.2025.02.24.10.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 10:29:54 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 08/10] vfio/pci: Add placeholder for device-specific config
 space quirks
Date: Tue, 25 Feb 2025 02:29:25 +0800
Message-ID: <20250224182927.31519-9-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250224182927.31519-1-tomitamoeko@gmail.com>
References: <20250224182927.31519-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x642.google.com
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

IGD devices require device-specific quirk to be applied to their PCI
config space. Currently, it is put in the BAR4 quirk that does nothing
to BAR4 itself. Add a placeholder for PCI config space quirks to hold
that quirk later.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/pci-quirks.c | 5 +++++
 hw/vfio/pci.c        | 4 ++++
 hw/vfio/pci.h        | 1 +
 3 files changed, 10 insertions(+)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index cac0aa1910..8a81c60400 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1117,6 +1117,11 @@ static void vfio_probe_rtl8168_bar2_quirk(VFIOPCIDevice *vdev, int nr)
 /*
  * Common quirk probe entry points.
  */
+bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp)
+{
+    return true;
+}
+
 void vfio_vga_quirk_setup(VFIOPCIDevice *vdev)
 {
     vfio_vga_probe_ati_3c3_quirk(vdev);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 56d7097a7a..10f63d4589 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3124,6 +3124,10 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto out_unset_idev;
     }
 
+    if (!vfio_config_quirk_setup(vdev, errp)) {
+        goto out_unset_idev;
+    }
+
     if (vdev->vga) {
         vfio_vga_quirk_setup(vdev);
     }
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index ca7c0415f0..5570f08f4f 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -205,6 +205,7 @@ uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
 void vfio_vga_write(void *opaque, hwaddr addr, uint64_t data, unsigned size);
 
 bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev);
+bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp);
 void vfio_vga_quirk_setup(VFIOPCIDevice *vdev);
 void vfio_vga_quirk_exit(VFIOPCIDevice *vdev);
 void vfio_vga_quirk_finalize(VFIOPCIDevice *vdev);
-- 
2.47.2


