Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA51C3ABB0
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 19:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAvZf-0004sn-9b; Fri, 02 May 2025 14:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvZb-0004oR-BW
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:57:23 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvZZ-0005Pi-8M
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:57:22 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac29fd22163so402092066b.3
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 11:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746212239; x=1746817039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ksLm8Hbb5N8Btg8hJJq48kxuL5GRhX/1Dl4RQBlOi+Q=;
 b=CeBxNecBb7II4FgXONKuyCX6Ox3xOhW5ETBJot7ExX2rskH23D1gdEBwM5xaFoVYB2
 mESOD3HbGfbVTweveHzxIspv+8rXyIdEWvSHSQMIUdFC1+QRoupib4+hzt5ejYJ+hUXf
 1h/EaWYygWKDxJFT1aFIaatsEeoJ4FqTTQGPaJql4gTa2wBaPsLFliYGoJxYAMZx/6EU
 GBA3Ut2BI4nt8Gbjw1FNpM7wh4jpueDYSXsgnC2qhxDJ7fd++eANbfUs48b4VSTqbD5q
 F1Z/GBne9889T1zZ02cOSXvr9v3J2KfBglGUi+95rwSN6LzZ+cDy25PBIxOvVi/bH/TJ
 nLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746212239; x=1746817039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ksLm8Hbb5N8Btg8hJJq48kxuL5GRhX/1Dl4RQBlOi+Q=;
 b=FVtzQLIct1YGMDhtj09qPdxITtWHOQueskdKxaCRZfAZAI+zvNgOjBRMQ6fiMFofDZ
 MLjR6oihZ+VKUGHuCImK7KmQp3nnuv3ERuFw4IAVr+WqSvKTJBkYnVcrAZgONlWw632S
 SgVS4jsIENeIdDASmxzMV/UXaYQ1aiypUIzGfNgvFmvoRMZt5zW0epvG732GF+GTtt90
 fso5WvlkDYvG4/4+cxrZrEoVG6itsw2I2aG9eHRfEn9lOH1AzdIkRT65RTbl16nYv5jE
 Wrg0EY8qg+4jHai1dy1aFHO2t898V5YIDaMZZAidQYHQyxzmojqGwT52z60FHjJt/SSS
 JK3Q==
X-Gm-Message-State: AOJu0Yzaz0Xz8fZvF5WdSZKbC0l0W0AUgEuVu7ysgKXfunJdD334Pe1w
 Eb8Wwt7aCRU5NjHFbJjE4+UCQ2lhRssvTysi5jKJwYhS7lEmBztdqjPOJ8r0gd0lxSrcQbcv8FD
 m
X-Gm-Gg: ASbGncuKNbXU+G57HpwfUGdoCOyKYhvRAueHrx8jHMXgDzRlXTewMrkOsc/Db5rrpbO
 hweoHjJcxyx9pGZ3091t4tNFjVXiWEE2JDXa3Lsz+3Z0BBaKcaqTFrTLFI1cGE2ec8pNQ/RHgsL
 LtY+CR+zVtBpTUlQWESH4+625SWy297OVOtqEp+o9pMO0NYsjVwhWf4nL2e6XhI3t6j2lHdjhiV
 pHFKbnuF/y1zWEF6ho/SM70ZDYGV2QLeuWTbLh3nN47weyncVGBZYJ9H/byLvPmvU8OdI+Ftfar
 c4f/BAXV0DGdYw0/DPzU8GBprLdaFZlz+kzNnCsqDBkoHsvGmlEtglVxbAP2QGOL5xz8RyzCUvv
 J4vRPQ4ZapLdKEU00m3KG
X-Google-Smtp-Source: AGHT+IF64ZWhIWsiGX5oz2cpTj0cDIKYneInRJynvtE0nzBQ7o9ZRfkMwXwKsDh34cDk/QZPJZaYAA==
X-Received: by 2002:a17:907:a05:b0:ac7:b368:b193 with SMTP id
 a640c23a62f3a-ad17adbf7fbmr463741066b.27.1746212238974; 
 Fri, 02 May 2025 11:57:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f6b05sm86006066b.86.2025.05.02.11.57.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 11:57:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 04/19] hw/nvram/fw_cfg: Factor fw_cfg_init_mem_internal()
 out
Date: Fri,  2 May 2025 20:56:36 +0200
Message-ID: <20250502185652.67370-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502185652.67370-1-philmd@linaro.org>
References: <20250502185652.67370-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

Factor fw_cfg_init_mem_internal() out of fw_cfg_init_mem_wide().
In fw_cfg_init_mem_wide(), assert DMA arguments are provided.
Callers without DMA have to use the fw_cfg_init_mem() helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/nvram/fw_cfg.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 54cfa07d3f5..d119c10d308 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1053,9 +1053,9 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
     return s;
 }
 
-FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
-                                 hwaddr data_addr, uint32_t data_width,
-                                 hwaddr dma_addr, AddressSpace *dma_as)
+static FWCfgState *fw_cfg_init_mem_internal(hwaddr ctl_addr,
+                                         hwaddr data_addr, uint32_t data_width,
+                                         hwaddr dma_addr, AddressSpace *dma_as)
 {
     DeviceState *dev;
     SysBusDevice *sbd;
@@ -1087,11 +1087,19 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
     return s;
 }
 
+FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
+                                 hwaddr data_addr, uint32_t data_width,
+                                 hwaddr dma_addr, AddressSpace *dma_as)
+{
+    assert(dma_iobase && dma_as);
+    fw_cfg_init_mem_internal(ctl_addr, data_addr, data_addr, dma_addr, dma_as);
+}
+
 FWCfgState *fw_cfg_init_mem(hwaddr ctl_addr, hwaddr data_addr)
 {
-    return fw_cfg_init_mem_wide(ctl_addr, data_addr,
-                                fw_cfg_data_mem_ops.valid.max_access_size,
-                                0, NULL);
+    return fw_cfg_init_mem_internal(ctl_addr, data_addr,
+                                    fw_cfg_data_mem_ops.valid.max_access_size,
+                                    0, NULL);
 }
 
 
-- 
2.47.1


