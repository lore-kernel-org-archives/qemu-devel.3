Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD058C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY8tq-0004vE-CE; Thu, 08 Feb 2024 13:13:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8to-0004nb-3t
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:13:24 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8tk-0006n9-PF
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:13:23 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5601eb97b29so315540a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 10:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707415999; x=1708020799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oP+Zl7qTTxZCu2Jq0yM9dMIapLtMm8swkthsq2XPVBs=;
 b=q8cpAV8vsMGa4v7NOjgzmsS+/pS+sXYH2xx9nErwIH3c2pYXpuiQgEPanqVCTbz+iL
 Fvu3bWo/P2etA6N/MhVCD91jdiq6LZNulQ14mzG9gPIcYyQtewhoshULxNO/WO9rMo+n
 25B9ZruI1kUzM7tLw3khLQxttvBtr5jrNRPUK/9fTAmmtSNskDjg217kMsCn3+9XcnMp
 OaAk0t/HkxOZKnS8ecXk4C1ku63we8etVVesa16AlY9IZt4kRU/5w4C5QZo8wGOi4b6F
 lN5c9bI5dJOBOQMFNQqvJQrWvAKx83o+BNAnIYcPPuE4m12yoljNEnz1C3XL3KSpZhhE
 U8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707415999; x=1708020799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oP+Zl7qTTxZCu2Jq0yM9dMIapLtMm8swkthsq2XPVBs=;
 b=u7FN9t3j/i6HSkj81nEgvieV1j9KDyHp6snJKJW4NEBS1c/kT4RzGe1voyIIFFXuxF
 5p4lbZnL3GFmHQ90uRe9MiKV5nvj5AbxPnl7V3PTCepCa3EuUcd8iCtTFnga91V+5EP+
 0hAdEferxn4K9u/szRm6wmUndk8bNoyLLwJmhkQpw95EsXuORxxUDvBN7gSD/LINPN3t
 ISw5vrtCSWS85PoQcC6Hr3oZGbk/7Upb3Hl/LG/l5QQ0RtOJ2TnOjXgE0tthHHPSv4Ne
 1u9sjhkJs3sTWycWKUfLTIoZPdfzpsfLOwROGvGNN5Kh096WxjW3JX7n7RJPZ9laeFAA
 wEMA==
X-Gm-Message-State: AOJu0YztpIu8coCZdoYgqKunX6RWws2cU32nAl4rQXt1dETvLSH7CDgo
 g0AXRwTSAicAWwM/f1sDMvuxSGGXgEu9RIjd5Xa0QNTG7atjZfRZ7tCnJ38aRwHnAeO7R+H0OP0
 vGEs=
X-Google-Smtp-Source: AGHT+IEItETvPITckNcl05+wO1c4FcwbwLkJLQQ4FDCJmqkncAx3B7CXqNG/NfXDz6zcmS3iTQlRZA==
X-Received: by 2002:a05:6402:8d8:b0:560:ef1d:a9e6 with SMTP id
 d24-20020a05640208d800b00560ef1da9e6mr318752edz.15.1707415999180; 
 Thu, 08 Feb 2024 10:13:19 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXQV6J/JY3fLcszotp40NVy3j7JppsbUHNDxnA1/uudNIpeBG3fM9u4JPS3GVW4p+PbeBc9Z2h66ceTx+abSJJmYx/h9HxdSDwfYTy4POyjIXsTHNkoXzPNidaLvQrc3KVrX19xYfBDE9Z0+D+4OfLVCUuYV6p63+P2xc4ukkXJu91u9wvtBlWxcmxE7sXO4zhcRIJigOfLVFl/Kd6vH6sno7A623F7B9IT1ybBcjZxNaNkv02FNNC0O/t9vWz9eRiAXnhvBF6w51SEs9N4Y4+RcLonARwLAPHCcPJk2ytVy8ZUj0oe5iyBxjcQQL5G5ZrlwzPhCp/fxcK2nttamhJhhkSQVxSX2ShGrAI=
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a056402414300b0056058f2603asm1071801eda.3.2024.02.08.10.13.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Feb 2024 10:13:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Subject: [PATCH v3 05/11] hw/ppc/prep: Realize ISA bridge before accessing it
Date: Thu,  8 Feb 2024 19:12:38 +0100
Message-ID: <20240208181245.96617-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240208181245.96617-1-philmd@linaro.org>
References: <20240208181245.96617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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


