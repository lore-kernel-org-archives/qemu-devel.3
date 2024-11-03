Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14652D11041
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7al5-0006W5-Qa; Sun, 03 Nov 2024 08:35:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7aky-0006I8-0U; Sun, 03 Nov 2024 08:35:04 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7akw-0001Hh-HF; Sun, 03 Nov 2024 08:35:03 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9a2209bd7fso590720566b.2; 
 Sun, 03 Nov 2024 05:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640900; x=1731245700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ER63OFaSbqJru3HFylC612MYJYy6isDGIUx/mkHzX+E=;
 b=Z5jikzpC9DT26OF1Lr3zmTorrb3IaCt+a/H7h2+xykrmRCM49rYQ6cX6z+AKcHgTd3
 DVM4TTZD7kZYFhmYKWJFzlT+njz4ZJfUa8bz2rrbB7+tqvHeXsrQc0vehXUjdt3Tspn7
 4y8zJsLp0q+nlA6jBuovsASjmb3bFHy41Fb1B0nmYDuIphOuDUnRs0Pkyb3NHc1DO4NJ
 0Hz5A353SB+z3MIY6MX8Qd+Q4ykec9LNKZd3L0GVFhoGeb4x/J36DOOITANckN+8XpAS
 TkV85RFzbOSQwxMyQDYc9RPtje/kpG5hUT4UDhboxW4WyZCs+O2GAJIJ86uxkwS/qjoq
 jKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640900; x=1731245700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ER63OFaSbqJru3HFylC612MYJYy6isDGIUx/mkHzX+E=;
 b=NzX+nJ3dNNAajp8n7wdQZjxUmNjUcaUhEBit+41u2HUpJDaQEMBlQ4+7aE2fv3H7pC
 UWbkfu962fIKqCR26nETkCQ2jmDKL2d7oe8P/0SZkPuSH+AarZ7RCDosyDZZ6vjbFwBz
 4T4Poglsop/zLHdTSHuoA0LEDap8QspBvpf38L10NkxmbkTogNPj364lhtGC/k3vJg6x
 Y9EUkIhGDN/sxSStlniZo5rPoRtI6uN4rwBH0KW5ygvpVHSex1vJM3YPtf2w/k++sRSJ
 lRFKOtYTpZ3rPBki2wzBx1PE7Zud/Td3emKyCYnyyBxqZfWJ0qeyHm7aKjWqA48kDvJd
 WU6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo41KRSs6LqvmHT/qOH5As8rIu8tVC6mb0GBQToa7D0bzqR8pnD9sila8uP3nD8L88mfPvsPAwL+kt@nongnu.org,
 AJvYcCUyTRyimiocxIxz8Q2x6XB097ExE1bv/JJukwDP/9fKozPNoFdc8NQAVWhvNInxw/3T+M69xQw4/dM=@nongnu.org
X-Gm-Message-State: AOJu0YyrVFBi7bsKEUDXgyn7J3qGyKlBlcHG3UDRR0aVjWELRqGtF5+P
 sDibsGIOQ5aM/K15yiFOYvsX913fpIz8D/9nzqpy3iN6Y5Rw+s5fypdiUQ==
X-Google-Smtp-Source: AGHT+IG+AeFB/YT9Y7oMfdxq0o20C3QD+REAbj1Km5aeSINDXdqdJX5piKSzPElCQf5E3xMywqVpBA==
X-Received: by 2002:a17:906:6a15:b0:a9a:a891:b43e with SMTP id
 a640c23a62f3a-a9de616dfeamr3071310366b.50.1730640899523; 
 Sun, 03 Nov 2024 05:34:59 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:34:58 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 Kevin Wolf <kwolf@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-block@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 13/26] hw/pci-host/ppce500: Reuse TYPE_PPC_E500_PCI_BRIDGE
 define
Date: Sun,  3 Nov 2024 14:33:59 +0100
Message-ID: <20241103133412.73536-14-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
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

Prefer a macro rather than a string literal when instantiaging device models.

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/pci-host/ppce500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 97e5d47cec..d7ff2ba778 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -475,7 +475,7 @@ static void e500_pcihost_realize(DeviceState *dev, Error **errp)
     address_space_init(&s->bm_as, &s->bm, "pci-bm");
     pci_setup_iommu(b, &ppce500_iommu_ops, s);
 
-    pci_create_simple(b, 0, "e500-host-bridge");
+    pci_create_simple(b, 0, TYPE_PPC_E500_PCI_BRIDGE);
 
     memory_region_init(&s->container, OBJECT(h), "pci-container", PCIE500_ALL_SIZE);
     memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_be_ops, h,
-- 
2.47.0


