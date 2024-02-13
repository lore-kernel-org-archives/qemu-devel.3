Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B9DC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 13:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZsTl-0002dY-Bj; Tue, 13 Feb 2024 08:05:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsSd-00020H-QT
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:04:32 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsSZ-000658-QA
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:04:31 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3394bec856fso3155776f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 05:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707829459; x=1708434259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O7zS4al2xd0Nh3hgWRIRyTwhfz5nLFlDSJ2u8jBzRpc=;
 b=pfFhyoS8RBCBOz+qNft59s7Rj1NCwwvIZOxPlQH5hJPfp2ViXevRuFmvYgXzUBgiwK
 +BLRDe/2KysYGQnpg+kHqEFgNXPeuaGhmofOXt8lryAirax9YechQ4fBY/LJFoRxKo6b
 mfnTCAP7Bz7XIMfrTh6GEQYAcC4jJPMdKBURlt2EPaWZtbcPXHVHRDrFvhsxLvrBddd9
 mlIUi7F08GxDVpTyz3Ptyjf7LtCfPrxbglpk3obFasve0zR2fuvsGTBxsD8SKQN7am80
 dOf2F7VtDkfmMvyzIGd8nVKqtPyKG+qUYsuckeIuog8nwTQUOy9Xh6p6HchiWYoSIYHN
 09CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707829459; x=1708434259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O7zS4al2xd0Nh3hgWRIRyTwhfz5nLFlDSJ2u8jBzRpc=;
 b=m5SuRt+DqvoLSKaCHi98lTKX2WsfbMKUZ261D/PMeDWD4Trxx4655i1Yl1l6FXnnMU
 tWM++exigEAdGpUUt+PYSGdtHutM7Z//CSENO6CJxU8R4kfGKiQyBvLpZdThZXZHy3wV
 UIBZWhDGE1dUVOFvRNAE3f9fw/HO87w9wAGYXhfVbd1S3A7/2pnVOQ0IfdlZhHdsm7FR
 L28uRlfZvRoh4o9FjZWthfujP7i8ozlPDv9P6TbaWgBWsVqFtX76Leej1/ZQfuLKaNvw
 7CIhy698mUA7T3un7oRS7LKEDlsfKCxQLfa+DaTNg3wZmX10Wtu821JGYF6BFsw0RL+k
 3OuA==
X-Gm-Message-State: AOJu0YwlBvCWlKoA3ev16K0UkPku8WopT0QmiGxuEFLpkZIdOX/bD/Yq
 kmTv/oSgErOoUTEei7yZEAVOXC8JP3imIcDV2iiKGlium09UpBbMXbGlMFNsZRy9wwgvZDdFNpC
 c
X-Google-Smtp-Source: AGHT+IHovyHAj8ZVS2+n6bCPWLyUwFM1uQefzYAGhA8B1P/XReDnTG1wfIEfddlkTKo6E1zqcH/NYQ==
X-Received: by 2002:adf:f546:0:b0:33c:d852:8e50 with SMTP id
 j6-20020adff546000000b0033cd8528e50mr1575682wrp.6.1707829458921; 
 Tue, 13 Feb 2024 05:04:18 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXZDPnYR47Ipvqgf5m3G/oOa0hCnEnYFyBtQ+VtnT3GFQRxp8s4QVzZNacjJdQ3pCTbza38kssUxzg+11QrvQCLNzVw0yQbtKYVWNXuDlL9s+W6TTn45FA32DooHtDvv2GxmHOBuUrdp8sn2XBO4YftlhVwhL1htVzAaT+jMAc+5+tgymwwW3BUxmlRmj9yv1FLP0ZIZy5Syz0mJqMC0ezOJu1ACKKaxVtHfp6hm4HvWH3h4+bR8nEfjAPQDBpxadkhHIxa91h/i8a4IEaIWz7Gl1v7QQNi5cSxWveCK7HTDnn6JbLIrT4V+cs2v+FOK3woNsph/e3LahuGkAWty5xQL5fINpOMotMi0fgYZ3s2KukEZUcU0bKXTmpbxn0CFlIUCJoC02A=
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 bj8-20020a0560001e0800b0033b3ca3a255sm9529863wrb.19.2024.02.13.05.04.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 05:04:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, Bernhard Beschow <shentey@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Subject: [PATCH v4 05/12] hw/ppc/prep: Realize ISA bridge before accessing it
Date: Tue, 13 Feb 2024 14:03:34 +0100
Message-ID: <20240213130341.1793-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213130341.1793-1-philmd@linaro.org>
References: <20240213130341.1793-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

We should not wire IRQs on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ppc/prep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 1a6cd05c61..4eb5477069 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -278,9 +278,9 @@ static void ibm_40p_init(MachineState *machine)
 
     /* PCI -> ISA bridge */
     i82378_dev = DEVICE(pci_new(PCI_DEVFN(11, 0), "i82378"));
+    qdev_realize_and_unref(i82378_dev, BUS(pci_bus), &error_fatal);
     qdev_connect_gpio_out(i82378_dev, 0,
                           qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_INT));
-    qdev_realize_and_unref(i82378_dev, BUS(pci_bus), &error_fatal);
 
     sysbus_connect_irq(pcihost, 0, qdev_get_gpio_in(i82378_dev, 15));
     isa_bus = ISA_BUS(qdev_get_child_bus(i82378_dev, "isa.0"));
-- 
2.41.0


