Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE17D10366
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 21:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO0ts-0001YP-IF; Tue, 25 Nov 2025 16:48:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0td-0001TL-9z
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:48:25 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0tb-0005Dd-JX
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:48:25 -0500
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-42b3c965cc4so125108f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 13:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764107302; x=1764712102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d6d95B2GWp5Ove4p4VnyCUqYCaY8kuW0FwTElFhEInU=;
 b=E6ZYRZ/5GG1Gz79fkSPOeKWa7SssNATbjIe7M8yobgEtS6BcUBTR+olV9s2lX11/C6
 VlE8KGNhYGuLQBj4tRPgh1GA9LcFfjv70pVkP/8Y9mLr09ADYJGoATUwUQR5x3Z4oEHI
 NfCUTOb3L/VKgQB/KV5PtqDpXwXrh04ffa+eHLuYbVJqPWqjJwqxNgVWlUJGl3wuz7lc
 d2rzCfnDjB6YuLsKpSO1x7N+jSfOJeW0oOsHi47DuX7jVAuuuEHlGoup0EG36o42EjRf
 G3BlD81AJVygT2wCcItEJ7PAW1rQ+SDSgUqlS6c1Ipy7ojWNSJ4eWdrINCXWIyYi89Vd
 XYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764107302; x=1764712102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=d6d95B2GWp5Ove4p4VnyCUqYCaY8kuW0FwTElFhEInU=;
 b=jh9KXx9RxO0qQQ6UP0ELnW8DbF6G605LmOOszgu2Gr1xYZd5ZvdJiha443nvXFUG++
 dVnSKbTSRIAQBWx+Uv+tw40mFCVG1199tNj6wQA++QiG2nhAvmaHam2Z7UK5kW5H+sVL
 cS3RC9FdytBhyJH+ZtyGk2gJ1SJ4pR4qG4AH5ymR6PpN5CjOul3YnX46VNPzTH9zU2qh
 LpuYaaDh5GcJceZjCRQbOqBMEjwcl8klF58m8Aa9IC63meR1I9MPFX/GFWLB/BLzD/HP
 VVqb0NQ9wdgTRf5RUX0ERonDzVVqeMbe+yjwxaQWyD+UAsbM4MAfACdD4muYxrdjPqdA
 gDdA==
X-Gm-Message-State: AOJu0Yx1HYXFODed7U0gnvPBGCSHYtzGbYCP26MNYmba0i/f5Cbw/Pxc
 /vcYtxJEUMq8MqO+qSdG4K8Hr/TIL6WZvKfG447icB5bgqedPive7ydEmzdGK6biz8MQH6aiGLN
 YWOeYBlEZ7/9d
X-Gm-Gg: ASbGnct9xjRW0CaAp6uA7AUHJZ6wFYsi7c9oEUOJfOiPwgASF12+AmRp6FbKBMa+0sU
 PSP31aNWMjf3xXjwf52Lxuiq6/tF+tobCKkl7g6xgTXkAKQHuMgbZpeWOyvExTIQdugs58HHk0y
 E5FGJ8fdzTcT6pdL7ic2j1xq17r/SehgWw4cibMqdbHHg00cJjAQXwFHdPDtldrBFIwOGAuYAxY
 zZ5rPt1g0AVtw1GV86GpSpWtAgxhhMjtC5v71ZEfGb1jXtgcyprNFhtNLUIun8Fxy8i4VCxtmxe
 a/lbeqLLM8T3xVPfH0RVX+Z4/FdV9wsOrm/f93ECVuqNJurla/DvMj2cdwMMR27nfW8/iea2LuF
 hcm+hk0SJCPLvEzwJ1OI/zhd4zxgKhcS5yV0S6fx2ycAqj4OOq7trg88yqtG/l9QZn1bzC61mmv
 bmlXaedbtHfMkSIPjmgXYHolDrURGarHZSNNnT80BJ5+xbM5lRTG4N0aXcCIjR
X-Google-Smtp-Source: AGHT+IFD7SkpHNFLe42ShT6gQ6VD9+0FhGQu0QeIhti0WWdCjJP2+E+5xlSML7Rhq2xclARrW40lRA==
X-Received: by 2002:a05:6000:2911:b0:429:cfa3:5fde with SMTP id
 ffacd0b85a97d-42cba652baamr24556664f8f.11.1764107301685; 
 Tue, 25 Nov 2025 13:48:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd8baesm36862625f8f.39.2025.11.25.13.48.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Nov 2025 13:48:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/9] hw/pci: Make msix_init take a uint32_t for nentries
Date: Tue, 25 Nov 2025 22:47:54 +0100
Message-ID: <20251125214802.1929-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125214802.1929-1-philmd@linaro.org>
References: <20251125214802.1929-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

msix_init() and msix_init_exclusive_bar() take an "unsigned short"
argument for the number of MSI-X vectors to try to use.  This is big
enough for the maximum permitted number of vectors, which is 2048.
Unfortunately, we have several devices (most notably virtio) which
allow the user to specify the desired number of vectors, and which
use uint32_t properties for this.  If the user sets the property to a
value that is too big for a uint16_t, the value will be truncated
when it is passed to msix_init(), and msix_init() may then return
success if the truncated value is a valid one.

The resulting mismatch between the number of vectors the msix code
thinks the device has and the number of vectors the device itself
thinks it has can cause assertions, such as the one in issue 2631,
where "-device virtio-mouse-pci,vectors=19923041" is interpreted by
msix as "97 vectors" and by the virtio-pci layer as "19923041
vectors"; a guest attempt to access vector 97 thus passes the
virtio-pci bounds checking and hits an essertion in
msix_vector_use().

Avoid this by making msix_init() and its wrapper function
msix_init_exclusive_bar() take the number of vectors as a uint32_t.
The erroneous command line will now produce the warning

 qemu-system-i386: -device virtio-mouse-pci,vectors=19923041:
   warning: unable to init msix vectors to 19923041

and proceed without crashing.  (The virtio device warns and falls
back to not using MSIX, rather than complaining that the option is
not a valid value this is the same as the existing behaviour for
values that are beyond the MSI-X maximum possible value but fit into
a 16-bit integer, like 2049.)

To ensure this doesn't result in potential overflows in calculation
of the BAR size in msix_init_exclusive_bar(), we duplicate the
nentries error-check from msix_init() at the top of
msix_init_exclusive_bar(), so we know nentries is sane before we
start using it.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2631
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251107131044.1321637-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/pci/msix.h |  4 ++--
 hw/pci/msix.c         | 10 ++++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/hw/pci/msix.h b/include/hw/pci/msix.h
index 11ef9454c13..551a2bcfe73 100644
--- a/include/hw/pci/msix.h
+++ b/include/hw/pci/msix.h
@@ -7,12 +7,12 @@
 
 void msix_set_message(PCIDevice *dev, int vector, MSIMessage msg);
 MSIMessage msix_get_message(PCIDevice *dev, unsigned int vector);
-int msix_init(PCIDevice *dev, unsigned short nentries,
+int msix_init(PCIDevice *dev, uint32_t nentries,
               MemoryRegion *table_bar, uint8_t table_bar_nr,
               unsigned table_offset, MemoryRegion *pba_bar,
               uint8_t pba_bar_nr, unsigned pba_offset, uint8_t cap_pos,
               Error **errp);
-int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
+int msix_init_exclusive_bar(PCIDevice *dev, uint32_t nentries,
                             uint8_t bar_nr, Error **errp);
 
 void msix_write_config(PCIDevice *dev, uint32_t address, uint32_t val, int len);
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 8c7f6709e2a..b35476d0577 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -318,7 +318,7 @@ static void msix_mask_all(struct PCIDevice *dev, unsigned nentries)
  * also means a programming error, except device assignment, which can check
  * if a real HW is broken.
  */
-int msix_init(struct PCIDevice *dev, unsigned short nentries,
+int msix_init(struct PCIDevice *dev, uint32_t nentries,
               MemoryRegion *table_bar, uint8_t table_bar_nr,
               unsigned table_offset, MemoryRegion *pba_bar,
               uint8_t pba_bar_nr, unsigned pba_offset, uint8_t cap_pos,
@@ -392,7 +392,7 @@ int msix_init(struct PCIDevice *dev, unsigned short nentries,
     return 0;
 }
 
-int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
+int msix_init_exclusive_bar(PCIDevice *dev, uint32_t nentries,
                             uint8_t bar_nr, Error **errp)
 {
     int ret;
@@ -401,6 +401,12 @@ int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
     uint32_t bar_pba_offset = bar_size / 2;
     uint32_t bar_pba_size = QEMU_ALIGN_UP(nentries, 64) / 8;
 
+    /* Sanity-check nentries before we use it in BAR size calculations */
+    if (nentries < 1 || nentries > PCI_MSIX_FLAGS_QSIZE + 1) {
+        error_setg(errp, "The number of MSI-X vectors is invalid");
+        return -EINVAL;
+    }
+
     /*
      * Migration compatibility dictates that this remains a 4k
      * BAR with the vector table in the lower half and PBA in
-- 
2.51.0


