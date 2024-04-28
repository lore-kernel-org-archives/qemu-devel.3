Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667C3C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 09:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s10U5-0007Vy-6J; Sun, 28 Apr 2024 05:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s10U2-0007V2-PB
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 05:06:06 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s10U1-0003mY-8M
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 05:06:06 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e36b7e7dd2so29842295ad.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 02:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714295164; x=1714899964;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=41HOhmfFzvzHUWDzT1tLGC+0kqqS1QTmSsIo/CJC9aw=;
 b=dCMdHeAU/Z2mvUOY1034P82m1jOTLAXhAEpngd+P1vmFvFl0+fuJWiIz/81vRRbicp
 YmsXvDVpulaAf2Cm6MunSYOAXcBeLq/YsW4q9P8ihu8Xh8OIC7UJylxgu9O9aRlVgAVh
 CU2Su9xOmrk/fQtzKF2YcxdWSZddkKB7TYsWr8kWjK9WD/b98g6LwybGpL45xTQsum3n
 5yB4F4TPibmbKOpOFWQh8e89gD+J6A4WxZB4yuM7kosoSY7qY27G1xqcWDjn1JTEFG8P
 9wuWv4YExzBcLHGNA97M/anzX0cCjv0VgqsIHTt/I3ohHEengjQYrMNB0GkBOzqYIJb/
 bfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714295164; x=1714899964;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=41HOhmfFzvzHUWDzT1tLGC+0kqqS1QTmSsIo/CJC9aw=;
 b=MdaDtKTBTDA/ayMYtcp/NCgXzKfIYGGHda3r2B0NuMAs1DIXEKOqE/E1KlmmniUeAH
 DAvDvjDErI1LYuF3vdam8iJlecZqNuaoRpLuvKGhDWQxHM0lIrh9iCEdiv350jBR1Go8
 7EusGtSXExTbpSAMctPhszgkWemSIJvFWWzQIJFfOtetT6LAW/lSK5ZmtgU1FI8A7hcf
 UO7MWBKwCBjCYlqKOGB/WaKSgJX7WVGnjk9zugUwfbv7fAgjqr2QXIHU0bJ+tnICz/H5
 iEuB5jZ+w5YRRH+F3w9YEzJCfL1YElBOg4uscb3BTEMIEMq08b6Hse+yxe3udoysbUpM
 T5tA==
X-Gm-Message-State: AOJu0YzLJR0muM4lCSVZDE+Cmsh3lLZYlpzuWwZcGt6C8MH72ADE2WGS
 Ba9nC1rWr6Isn6lYY5LoD7JodrpaxZ+f85mPjVfO05Tv82N/h78AD8OmohQZd3Y=
X-Google-Smtp-Source: AGHT+IGAK9xbxuVHKL6BxfpFJd/TgK7Wt/UqqkOwZim4z10n7qUEPFekzjac4mu6uImKqK25Xlrfwg==
X-Received: by 2002:a17:902:e951:b0:1e3:cf2b:7151 with SMTP id
 b17-20020a170902e95100b001e3cf2b7151mr4912125pll.59.1714295163756; 
 Sun, 28 Apr 2024 02:06:03 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 k12-20020a170902f28c00b001e8123f90f1sm18146595plc.105.2024.04.28.02.06.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 02:06:03 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Apr 2024 18:05:41 +0900
Subject: [PATCH RFC v4 1/7] hw/pci: Do not add ROM BAR for SR-IOV VF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-sriov-v4-1-ac8ac6212982@daynix.com>
References: <20240428-sriov-v4-0-ac8ac6212982@daynix.com>
In-Reply-To: <20240428-sriov-v4-0-ac8ac6212982@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-a718f
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

A SR-IOV VF cannot have a ROM BAR.

Co-developed-by: Yui Washizu <yui.washidu@gmail.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index cb5ac46e9f27..201ff64e11cc 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2359,6 +2359,14 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
         return;
     }
 
+    if (pci_is_vf(pdev)) {
+        if (pdev->rom_bar != UINT32_MAX) {
+            error_setg(errp, "ROM BAR cannot be enabled for SR-IOV VF");
+        }
+
+        return;
+    }
+
     if (load_file || pdev->romsize == UINT32_MAX) {
         path = qemu_find_file(QEMU_FILE_TYPE_BIOS, pdev->romfile);
         if (path == NULL) {

-- 
2.44.0


