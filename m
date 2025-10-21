Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC2BCCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJH1-0005Qk-Rk; Tue, 21 Oct 2025 16:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJGe-0004wF-Kk
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:47 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJGW-00014Z-Kg
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:38 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47495477241so12032575e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079651; x=1761684451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vkfjenACGdmDby4HSj/Tls/WuVgzSU93DPeVdbTcqK0=;
 b=AshTeHY/MGniy2bhUYXJuM4Blt/g9fT15mZSfqDISHTy0YApN651IybQ3FAhNsbfwj
 38QeHVT7PgJqz4KKjZp7p2TA/Ge4MDcziHtFE6p8oolVmQufJxADX8TTzlFaBeDu7brj
 W0pkXjqhAjOJ8nTZkr2F48Tkc3HnBDThfCuuTtWUyINbAFKHldQtF/U1NXLOtsVBWHlw
 jq86LT6hEomvEly9uHio7lShx5rRs4Ude5oeoMAD3jXVkFntLUSHASkQXsp8yUG8Dtt+
 XCQ0FzniIE90dA42SxyWwudQAVrZ+6tewvxqtlz+Ft0JzVomZXFwZ1QETKgZE5P53WGt
 Mqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079651; x=1761684451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vkfjenACGdmDby4HSj/Tls/WuVgzSU93DPeVdbTcqK0=;
 b=a+vYU7+j00+gnjW8i1oo4qWEcZUrOcYwHZ+SNArUtofKT/Cc6vv9XyS2p17q7kzd2/
 XxPpPeYwYU+wRb2I83u8hq90+HaszsgZ9vQoCYBZIH9IVjOGkhxAoHIUxhJACbtAIzGC
 +VbZC5p9AJlqUnSIdw0JzZ+6csWw0PNW8Jveq0Fph8Pug9io7HMg39P1HSvq886OWltH
 k7ejwe/jwPDkYIYVyaI2VaiTf3EQLGhy0w88NLyDWIznNBopbVDmXjkOA1MLwQVLyUzR
 2cWlIpDhdJFV55BUFsnencrzy/DbPPO0Ov3Af9oAEiy+fruA2+IfDKowJCkXi4kf+jVu
 QTOA==
X-Gm-Message-State: AOJu0YzrApBeNfPPysJxbnkMYcef61KelmOwQA+1Pf6p5qCbWlYuXMeh
 yC4Jw7BaYE3jITTqpLlc0lFwxvr/G5q8Dn6C2dzlPkT++o3gQx3vMyBoztzJ4lSY2ZoMYFV1Pw/
 8cT1lXdo=
X-Gm-Gg: ASbGncuiSyn8ZUZc4g0A2Y/VQr9mPsVq/0x3yZDSBfzO+WZzm6hfNGxqpbGkC+yPl/M
 lP4aOO5/WePqy8BvNwtFHpSgqT+HBo/bnjYC+Sp4Gdj1b6aV4wGT3FmOY7V3Gc0UhD3EoSh+BQp
 SsWWHmTN/l8yIjJMXg+z9nQ9YAsEsQnr7XF6lQFDkfSyM8K8wCDq+PTpBBH2UtU+kB9b0mhQ5oY
 nK00/WlH2Z24rssLkLLImUvyLcq7WZGB8bJ8fOZLE6JMWESG828UA852hxQE2XhdCT/T2Xnvh5c
 GnXaxW70ty8R/CAOg1iF5kGadpxfs0O8Zy77P0Bfh+BlbKK82V4D/5BlqEGI0++bSGNDBYYAKtn
 ClRFxVmzQr6xhA3z0MO8IhSsUuhSL2H/PNBbr5DId+8xu03CMn4OqqYp1QWoQW/vG/k9QZuG9i0
 zuV8erN7AVhhoGkjlrSwQVIaAEVbxlVy2EICx5rlAV0ZdbMbeT3pTvy5FytZUH
X-Google-Smtp-Source: AGHT+IE1W6hc8UJf/gnlYEgM61KC6RA11l7SXpbB9VWjUbiWQBGiyvArmboEyGzB2ulB9ee7D8Q0kA==
X-Received: by 2002:a05:600c:64cf:b0:46e:3dad:31ea with SMTP id
 5b1f17b1804b1-471178af7cemr124960245e9.17.1761079650688; 
 Tue, 21 Oct 2025 13:47:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c429e745sm10619525e9.9.2025.10.21.13.47.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:47:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/45] hw/pci-host/raven: Use correct parameter in direct
 access ops
Date: Tue, 21 Oct 2025 22:46:20 +0200
Message-ID: <20251021204700.56072-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Instead of passing unneeded enclosing objects to the config direct
access ops that only need the bus we can pass that directly thus
simplifying the functions.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <226e0756661e72a03ba363887730112a58acde85.1760795082.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/raven.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index e0ebc81c247..eacffc86d84 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -80,16 +80,16 @@ static inline uint32_t raven_idsel_to_addr(hwaddr addr)
 static void raven_mmcfg_write(void *opaque, hwaddr addr, uint64_t val,
                               unsigned int size)
 {
-    PREPPCIState *s = opaque;
-    PCIHostState *phb = PCI_HOST_BRIDGE(s);
-    pci_data_write(phb->bus, raven_idsel_to_addr(addr), val, size);
+    PCIBus *hbus = opaque;
+
+    pci_data_write(hbus, raven_idsel_to_addr(addr), val, size);
 }
 
 static uint64_t raven_mmcfg_read(void *opaque, hwaddr addr, unsigned int size)
 {
-    PREPPCIState *s = opaque;
-    PCIHostState *phb = PCI_HOST_BRIDGE(s);
-    return pci_data_read(phb->bus, raven_idsel_to_addr(addr), size);
+    PCIBus *hbus = opaque;
+
+    return pci_data_read(hbus, raven_idsel_to_addr(addr), size);
 }
 
 static const MemoryRegionOps raven_mmcfg_ops = {
@@ -252,7 +252,7 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
                           "pci-conf-data", 4);
     memory_region_add_subregion(&s->pci_io, 0xcfc, &h->data_mem);
 
-    memory_region_init_io(&h->mmcfg, OBJECT(s), &raven_mmcfg_ops, s,
+    memory_region_init_io(&h->mmcfg, OBJECT(h), &raven_mmcfg_ops, h->bus,
                           "pci-mmcfg", 0x00400000);
     memory_region_add_subregion(address_space_mem, 0x80800000, &h->mmcfg);
 
-- 
2.51.0


