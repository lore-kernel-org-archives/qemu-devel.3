Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70354FF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 11:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKDWK-00034N-6s; Tue, 05 May 2026 07:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1wKDWF-0002zr-FA
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:00:53 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1wKDWD-0004lE-Hq
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:00:51 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2b458ca2296so28935695ad.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 04:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777978847; x=1778583647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wpG61Sm+VTsYPNIBqYulcbNVCgfeGjPbFP1lPVoJ4/Q=;
 b=qQ9Gc4uTZ871wIjMKCZIGn80YjjmeJ6TjUYqhp1Qs0AdB1gAkeEsr4vifhSNtkFluz
 qjUCx+511D4u5+KNqPTTHBljryfvkK9iPQP1NnTryNi3NqexsM5DrBWJ5DX6f4mi46iv
 A9PHwtxcYp7NWBCEph5eez+l9pbJhHdvE3bg16ZXgrXJFd4uCYFtAT2zykoP1aZRBtIq
 UVxvqNarNnSRvkp2D4OtGe3bXe8/53mx5/8Jbi0gZ75jgx5HOEsQILPQLTYuiJrGFjju
 sb/p/07c2inb1iItsXGfQU5IO+ekBzfQwdCuYhjZceJ+5hTdWkEz66b46KPPYPkO+uA1
 BNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777978847; x=1778583647;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wpG61Sm+VTsYPNIBqYulcbNVCgfeGjPbFP1lPVoJ4/Q=;
 b=Ovo/YZnMNfnymgwlttYEYtMjeP5Abocv8MJp5JmO4JuCD+QmrZw3PNRSKgBNjxGNwM
 KXhZZq6DsevBWyXPnvWbU+OHLW9W5HTjnbYXOZz2rOo8CE2Sj2ZYvtO6T3MPbLPZKSxl
 +O0Bx1a82fRYhE2cKluCaZmMb8GmBDAcHDplnomjLQZEf1VQMb8zeHgPK/laa8MofeQ1
 LYOgtSyiW5Y/DTBYAbk6jVJIK4cMIGo4K7iQDXZE4xpo95LnokxH/cAlgvZENxF3YnnN
 9GqtFglYTj+Vn0zbi26IwosyiLCmZ7FbcvYyv+U4V2Y3Cp743Ho5tdW9sPLO+4DrJPu4
 l0Aw==
X-Gm-Message-State: AOJu0YwBOBYLVoDd1fZsiAK/vIeVbUSoFOZLsL/RVKJG/0jzPvnhJDcX
 HV4NcqjHMAFMZWQZ61D8uyVYKe5Jf0IuJqrGS+IMxeV00xEwbJ9v/M7vXv5/XWoP
X-Gm-Gg: AeBDiet3p2Lg9ylV56JL7RJptblri05BvG0pcU+NI3snik2+UxkiQQ7N74mEmTMv84s
 W3rRlfPysfhbfVHO8EbanX63w+lmm4nhBbnTjHBmOeepZn8BExk62zp+om+vWHYqUUJM0vL4Ueb
 OEdnbIj6tdq45Xl9YH7QFBp0c5UZNLWodYxrx2VRXsbaNFxT0BkLMB2suujwgqSHgBd5pSRRbMm
 eD1uazDGhq1Ttv7Aoyhddo+gWK7AQVAuCiKZDEtr3zMwRom73qLvFrdyINJW3dx6kKF7AwlhqUc
 dsQM6CPSjqc92Bywh0/jgy1AVzs6TEOdDWUMw4qxuLtRfPrYgzy67QqEnxJhODFIgNpJvgXtFQl
 O1Gzk9YjffghuL9SfMUB0uJVOrhRW+W2ECEAlE0rq0HJJ5vjIFKzN0tbiqRp4tpnKRA7bc1Uw7T
 ci96z/dhaAJC0moOfqtBlWJYjYEvHJeehfHItbWei/gHK3kGK0unHaMKElitDXqPZK
X-Received: by 2002:a17:903:1b4c:b0:2b9:ff02:a154 with SMTP id
 d9443c01a7336-2b9ff02a9f5mr117372635ad.15.1777978846621; 
 Tue, 05 May 2026 04:00:46 -0700 (PDT)
Received: from localhost.localdomain ([202.55.186.124])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9cae0f6d8sm135690485ad.39.2026.05.05.04.00.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 May 2026 04:00:45 -0700 (PDT)
From: munkhuu0825@gmail.com
To: qemu-devel@nongnu.org
Cc: heropd <munkhuu0825@gmail.com>
Subject: [PATCH] hw/usb/hcd-ohci: Fix memory leak in ohci_service_iso_td()
Date: Tue,  5 May 2026 19:00:36 +0800
Message-ID: <20260505110036.47574-1-munkhuu0825@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=munkhuu0825@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: heropd <munkhuu0825@gmail.com>

Fix a memory leak in ohci_service_iso_td() by calling
usb_packet_cleanup() before freeing USBPacket.

Signed-off-by: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
---
 hw/usb/hcd-ohci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 6ed8046fc2..43c49a42ec 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -748,6 +748,7 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed)
     usb_handle_packet(dev, pkt);
     if (pkt->status == USB_RET_ASYNC) {
         usb_device_flush_ep_queue(dev, ep);
+        usb_packet_cleanup(pkt);
         g_free(pkt);
         return 1;
     }
@@ -756,6 +757,7 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed)
     } else {
         ret = pkt->status;
     }
+    usb_packet_cleanup(pkt);
     g_free(pkt);
 
     trace_usb_ohci_iso_td_so(start_offset, end_offset, start_addr, end_addr,
-- 
2.50.1 (Apple Git-155)


