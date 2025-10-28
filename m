Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A276CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 08:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDegB-00064K-Qg; Tue, 28 Oct 2025 04:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeg0-000616-L5
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:03:32 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDefv-0000oE-6s
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:03:32 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4770c2cd96fso19420125e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 01:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761638602; x=1762243402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0bJEm1B8ks9h5HyZDKkIUNIPRZdg3XjuMbaxmF/lz1I=;
 b=UMfETVQOdyLejXM+bn0lXHRmLNYaPXRrl0gur2oUg0/hF+y80ManCvk1IsOGtf5PkJ
 fZCoBPMIYF+cz9HgADD6p8hqL17vHeD39aQXT0fANz2gAHXQpt9NNm2/czGSp73TB5YV
 UDLq2vis7IknDPMHwZsQtGqVl8smFHtgo5lXQ4cJuFi6fwzw0ehn/J76J3Nz4vSMQ77b
 HDAEwa4qZnERoYQ5EOClX/ZtQ7YZyYrjD7y856lf232PvUXO75r17ZtEV8ZzQY8AO725
 du08puqQ4h9FLEFIaYJGT/YR4C3WM2r92i+UlWjWScIRaaj+eyfLNTqSUl2zPPVo1r3Z
 sa3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761638602; x=1762243402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0bJEm1B8ks9h5HyZDKkIUNIPRZdg3XjuMbaxmF/lz1I=;
 b=okIhAvJwOnZSM4j69nKqbfasBEODvRaFsW+cEh531jX+i3F/DB4UAViGnZpgXBW/Q9
 emPOvR9oC8TdgTiA4JFB9nXyi0CddJmZzw+gsS5BY8KCvkRRFpoDlkuln7ZuC+d0p88i
 9+ht1Ks1snE/yQDKVBz3antOfRLbsC73GSW8VrR2Mw4vdT+Yz6fG303vP7qz4gxHDfoa
 BLLIWheLYmSu/JdnQ+IXSZma3rxCvWa9vxkRkeWSaE1S7Bcau3RuC3fwBLMkCwL6pZaJ
 UNk8QEfqwsaS98huNhsIsVaCrquFyGnTCCi93C86Iw8Z5W5IryBiepkCBjhfYggkg32t
 Cd7w==
X-Gm-Message-State: AOJu0Yw8l9J8ld2LqcrT0aqvcBGTOxLOEVlakO7tFT8cywcV67f9jVJl
 5nbs4POtpDywyxqOKM+5zVR7mwMi0Ux6hPjuIpck2AfLwTAgrgDY7W3zhp4/x0cCQNZlbmOnkx4
 btd8PB5M=
X-Gm-Gg: ASbGncsp6LRIbJVD23rnhCDauZmrnShmMSa3YuRHGCFCXIVg+aGnROv87pRiUgfcxeq
 onaiQDgAIh6W14s/OWo99hRjWVqgFM8x5o/xleCfez1GKpHFn3bAIAkG6MRfvHoLWZL1hlU0Va7
 CIMgeTucUYhHmaZ9gJzCr64Z+lUvT97VIzdruJjINP9yhfCukrOsd6syi9jDUJXlx2FPfZgS2nk
 HR6gxWIRD/JFFA48lBxgfVoj4FjRV0LzqXJDvT2NYHoPP+l+J5G4xG640gK00mfbfZ17qWN0VlR
 p+OcL9ZWG2xuY3mSQBBA4B9MxgkB4o/bZg1pn2+dJAOgxVlW4bKZOFBN5HhQnTbgy+SolbBr5PR
 fiAhg+EVVGfb0Nkttlt7Wyte+C3bSNOEt6Qrm4BAzkgtW9ZI8rTFv8vV14QvbFXaosylLW5KInD
 Sk++Vqt5FKDaIBzOJUQmXpSElgO0bRN0mJWe1Xk1hJ/k6fcliseEcaWwI=
X-Google-Smtp-Source: AGHT+IGu8tAz7QNSfENwh5DhebxcpB0Uf+T7MY5mWmoV8QBJEMMaI05N0PzFr/4r9vD0c/yed5mTVw==
X-Received: by 2002:a05:600c:1554:b0:470:ffd1:782d with SMTP id
 5b1f17b1804b1-47717df6c74mr21252585e9.6.1761638602070; 
 Tue, 28 Oct 2025 01:03:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd035dc2sm184181795e9.5.2025.10.28.01.03.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 01:03:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 1/7] hw/sysbus: Use memory_region_name()
Date: Tue, 28 Oct 2025 09:02:51 +0100
Message-ID: <20251028080258.23309-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028080258.23309-1-philmd@linaro.org>
References: <20251028080258.23309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

MemoryRegion::name is kind of internal. Use the proper
memory_region_name() accessor, which might return a different
name.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/sysbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index ae447c1196a..d33be6b2b52 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -154,7 +154,7 @@ void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr)
 int sysbus_mmio_map_name(SysBusDevice *dev, const char *name, hwaddr addr)
 {
     for (int i = 0; i < dev->num_mmio; i++) {
-        if (!strcmp(dev->mmio[i].memory->name, name)) {
+        if (!strcmp(memory_region_name(dev->mmio[i].memory), name)) {
             sysbus_mmio_map(dev, i, addr);
             return i;
         }
-- 
2.51.0


