Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D659C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 05:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra7at-0005qQ-PC; Wed, 14 Feb 2024 00:14:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra7as-0005pq-8J
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 00:14:02 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra7aq-0007qm-Uv
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 00:14:02 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d746856d85so38640955ad.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 21:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707887639; x=1708492439;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VHN067INkkZHjqlocgeNRkot+SvYyjvp5oGzjd4gfAY=;
 b=m94hwDg1QMmVOe7YIfcl8evYoDTosjfzPgCtwp6ZsDnwLy/0UOIG+Kqr+PrLpVmGAu
 h31nIXliL0wpf3pdh8n8ihilkYWXgV1yqijBlHY53bYagNsyk9VsMV4+0C5XP78Eo+lj
 1a0MmJXPtYngvT2aO4w0cXNiJ7htu6Tlk3sURcbSDuP629RU0f/f1cdm82pP1T5ux7m6
 CNrjLMP6h8jWT9ZSfYxoTxvM30cfh0sgbJImFc4l1fs68dDg741iAD2+h6zBClfGSthU
 Zj6OrhIv9RHFGV64QUT2BGs6Bbsnvt1HMCk9p3nCS/CIAwEU6E3+vgLcOMtIB2r48LdS
 NOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707887639; x=1708492439;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VHN067INkkZHjqlocgeNRkot+SvYyjvp5oGzjd4gfAY=;
 b=YWHO2XJw2W+WjojMotPjiQdxJPK3RE/4CkfXi0D9GINm8eboyFRSoaHu0GtP2gN7LN
 /tx8pBlf6nJ871P20MwX4QKQKzp4ZaRRw+I53yX8i0UOTLBEK6H3OlyFCB447MwqlgLN
 87pMBVmtOkOpSnhUIbNc/Cnvbsce2jrvX/ySAhCVk/lpiwElfxYcBH+7uuuxbaL6N+/F
 qZkBRRDjW+xW0c+2U0Er4uDOds108bcIO1TDUN4HR4Sk/v8Iv1sU0SVF+YMEshQKfszr
 BuIoesbDxD2zJZNJAnWeV2CRXC1kyEnwphB/1DwxrkZCJK/NnM15QTjjbYn7i3YL5ZBV
 ciZQ==
X-Gm-Message-State: AOJu0YwVHaw3KNA+do1a+O/P9l7PcbkL53kjZ+0otJHJFow5jD3Cfqwa
 E3HCJQBT0zszURcMq82LKjIoR8dRBwPx5HeX575PhQCTpntKkzYuV4Nfl9pP43o=
X-Google-Smtp-Source: AGHT+IH2FGBIu9QCoE9aEHKrrw2BfdioS8blYsBJ3CZCIEILit3plMRG0cPLKgZDjJC/7beqf8lheQ==
X-Received: by 2002:a17:902:ea8b:b0:1d5:dac4:5015 with SMTP id
 x11-20020a170902ea8b00b001d5dac45015mr1650461plb.11.1707887639565; 
 Tue, 13 Feb 2024 21:13:59 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU6wG/7/RK70wnxnbS+iunJmixB2pzdQM4pHaNJVXN+NJxFScN6PU2QJYB0WjAkO/3XqAtnjrBFIs6k7YToZAsQNgbst+8HXyTIHu/cqO/K3plKN58g/+qEe1bvUGtRjEVUEEz/yRPOin63hR61IEyRqmYgZzquUgqVxzU5QHJbLN0CYSMnmzQxgMUy/VGwmrqkm1AMe9KPL5ofuASCJfOG5myCHSBiytRXDrFtny3/V6nhf55RsF59UO0oMhohQ2bKuz5Pq0/APrfHZ+hxfxu+sF1zqw3WXeCPC16xsqwX0YU91XwcgH0J5P+s++dLnP19y++6cltk6mLcmfeUpjco3A3aeB/3B9a8yOJybkjJ3J2EMp8Q2EeKcE8Wzk7E5Y+CMJR+Z7WC5klpVyfKxXRaq9IjEz7I+mz/NkB5exH2YCAkPw2Nr9ZMdpSHL+s=
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 lg3-20020a170902fb8300b001db5bdd5e33sm316711plb.48.2024.02.13.21.13.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 21:13:59 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 14 Feb 2024 14:13:41 +0900
Subject: [PATCH v4 3/9] vfio: Avoid inspecting option QDict for rombar
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-reuse-v4-3-89ad093a07f4@daynix.com>
References: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
In-Reply-To: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Use pci_rom_bar_explicitly_enabled() to determine if rombar is explicitly
enabled.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/vfio/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4fa387f0430d..647f15b2a060 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1012,7 +1012,6 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
 {
     uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
     off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
-    DeviceState *dev = DEVICE(vdev);
     char *name;
     int fd = vdev->vbasedev.fd;
 
@@ -1046,7 +1045,7 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
     }
 
     if (vfio_opt_rom_in_denylist(vdev)) {
-        if (dev->opts && qdict_haskey(dev->opts, "rombar")) {
+        if (pci_rom_bar_explicitly_enabled(&vdev->pdev)) {
             warn_report("Device at %s is known to cause system instability"
                         " issues during option rom execution",
                         vdev->vbasedev.name);

-- 
2.43.0


