Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4217CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 00:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utFCt-00055k-9k; Mon, 01 Sep 2025 20:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1utCEi-00068i-2n; Mon, 01 Sep 2025 17:38:48 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1utCEg-0001WT-FM; Mon, 01 Sep 2025 17:38:47 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b0431c12df3so195740566b.1; 
 Mon, 01 Sep 2025 14:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756762724; x=1757367524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4yTt4sEbaYXei+dSv43eNsIHDubDA3h78v1i98tBLMg=;
 b=W99iX3BQmQujZPKpQQ2oT1CjL6wHZWkFjUU7AURuGuXMniw6c1EJu5CWrC9JfUn0e8
 Ukg27LeOrKS9j5l6XKHroyY/brkkVoCQiTAx8CvtbpLrULCgjOVBGlsjHtIRYv9ET+hJ
 7Y7Ak598qH4tHCiavzrsQgEo/UvZKBTL3AHDqdwj1Gk1mupMVcbmZUCaHARNBQ+yuAkH
 jkaL3mOTdw5s9qNDMyAydm4rc3ZQaRWtPKxessRPQkMPYaqfQdMHrwkXVwx455E1dneq
 1bDJQdTaB9kPM3bbsSl3P+lqQjHF4y+kXMq8Fpol+lkNNMw/a94zC4t+IjHmkeEr/yc4
 Nmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756762724; x=1757367524;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4yTt4sEbaYXei+dSv43eNsIHDubDA3h78v1i98tBLMg=;
 b=Be4tlj1Qmg3u8j3TTHjWPnPo8+8qrqPUgRVoL40vyRG5PepEKqwdzIBcvv8GTIgyje
 lCgjp9y+8bmodaHyaQQ5aJAucyVp2btEEzvTXksunK30HomfOWjTwCXjB8lRWc9mQGcs
 NVJm0HnP30nZ1k1uhIq0tExZ+jl36V89fggqfinzrWZ+q+vwW0OtLcmRahxfvNAXVE4X
 G4v3yW5Z8SDdNpGpvVb2AzrdNZoAc+yC4VUF+RZeO0NoNVy0rPmOBdV1qIAUelveVWU7
 y3g9TR9gIPDVFUVGRR/EmdxrfWvWayOe9rnDzyzewQIMWqs8sGoBPiQuv7nrKay1V5P0
 kkjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXumIq2Zsvq4DH0kBepCZNXKVg18Sose/5y2ZiVp0y1gJKzPYrR+lqCRHx+OcQMNDr95gliP07QjKso@nongnu.org
X-Gm-Message-State: AOJu0YwWCvSNMppMcfz5Ay2CdvaJiIL7w51hQlTtcB2xVQElMyArGUMB
 njbUFDnIUMT78Q6wZRO34E78QZFDd73CwfOVc/E62wdD0TcOGglfWMd6
X-Gm-Gg: ASbGncs/56fK14EHqwohDv/2HRB9AD2Bljuz3mC9JPJ1vpnwzbP5AnPVL0QJeaYmGXl
 IFHCcMlm5X/r8v54jiM3J+r7xEUBuGrgib5KEqoDbS/LgR174DiaXS7ZZ7g7dZX/SKYf4Y1wU+5
 kkDpjDx8C6ytxK0VOwr7xep6cOkwLxxxEGSnwUSVB2eIwtnnkPN4HRejHjUYfBZZgw6DWG0a/Om
 zcjIhZlJzvsHDS6FfwithNJVl8/U1HJTiQ+Q25WR4CVdyzHl24X/qXuIegu2rLKq4hJDbdV+k0A
 bdHd72pcorlz1uJ0yCFvEEOW+IH8J7EkK4SC8sGUW8FHGJ1ZkCHQifbcA8A/Mr5mdoVDiv6AeKX
 3uxGkEKK4150Z48nM3fVt8Rs0Mb2FUHlC27s+Rh9CDpfIXhqnYn3Ndt72Z7eo/2SGPavMD+qEzs
 warWr9HkB2HK3q8ap4UDv+6byt8p5wea8MOhPmE5OOjk7PRbtwOuZnQ1xz75UzxNnzzVS0TZXu4
 sND6g==
X-Google-Smtp-Source: AGHT+IE7Vxtc6JQEhtQEynyXlQCVX0Z8Mhn1kuY0pYSTUg/bM0YNZEVJpzkOMfjq/Q7rQbk1g+6Cvw==
X-Received: by 2002:a17:907:94d6:b0:afe:d590:b6af with SMTP id
 a640c23a62f3a-b01d8a8b60bmr880558366b.20.1756762723846; 
 Mon, 01 Sep 2025 14:38:43 -0700 (PDT)
Received: from osama..
 (ipservice-092-210-202-008.092.210.pools.vodafone-ip.de. [92.210.202.8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0445cb9296sm109536466b.61.2025.09.01.14.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 14:38:43 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] hw/arm/raspi4b: replace fprintf with error_report
Date: Mon,  1 Sep 2025 23:35:53 +0200
Message-ID: <20250901213607.69603-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=osama.abdelkader@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 01 Sep 2025 20:49:04 -0400
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

Replace direct fprintf(stderr, …) with QEMU's error_report() API,
which ensures consistent formatting and integrates with QEMU's
logging infrastructure.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 hw/arm/raspi4b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 20082d5266..4a5f0eb91e 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -47,7 +47,7 @@ static int raspi_add_memory_node(void *fdt, hwaddr mem_base, hwaddr mem_len)
     scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
                                    NULL, &error_fatal);
     if (acells == 0 || scells == 0) {
-        fprintf(stderr, "dtb file invalid (#address-cells or #size-cells 0)\n");
+        error_report("dtb file invalid (#address-cells or #size-cells 0)");
         ret = -1;
     } else {
         qemu_fdt_add_subnode(fdt, nodename);
-- 
2.43.0


