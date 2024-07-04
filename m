Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE98C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 12:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPLOw-0008Fs-SD; Thu, 04 Jul 2024 08:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPLNr-0007s9-96
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:16:20 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPLNm-0002SI-Qj
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:16:18 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42138eadf64so3815015e9.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 05:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720095372; x=1720700172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sebo8kp7DAxDc5R9inOIScJcgh+uRNdHOYeHTAuds3E=;
 b=PiWzHlbnjoxKZgAhW/047cEQbBQSLywuXkRu5SdeXtysfq1P2pKUwblzvuuuuXh7FE
 HxVqVLFwY/+XYERhebaL3e9sQzXrc+qdkibv8+XplWnGe8X6vDRUwStBBgevveBRC0QR
 Dgu4vGFl+TRXZrfwpboIW1T632DgiTaJCjUhvBrGBik6nBGnp9jSsXNZqlggCux+9HDq
 3kQwxHtApOPGQCIyyTzcgg4vnSO62rLclRwewHbn5xmqwMkKyP8Pwka/BErFlvZ1Zy8f
 VyuGbwo93sSYATm0E2T9QoP2C97PUxwFQ7HwyafaB43V1HChuruFgZIblYpVrBsXWQVs
 +U4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720095372; x=1720700172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sebo8kp7DAxDc5R9inOIScJcgh+uRNdHOYeHTAuds3E=;
 b=w8zcoTaxAp6NOkIBVIev/gpPOyIKm4GQYdDuMYpK4maT2I3EqNuxZYw3qANgbxfl0k
 AV4N5nb9QpPOZwlysjWKLU5gg3NTPx58WE9H7Mtg5prXJN67MnCN4z6IAzCAmiluMYDi
 PZQ/Gb4+oQGLlnf/a2mBu5d+vf+2Q9WRmOVhmzzZ/I0368Rn/0DqU4+rodCH7o7SuMml
 o6KGrkFDhlkPj2pJRqjnMh0K0n2kKKoyYH088QnAgVu8ctTcOMa63cfgd1FeESnIePKj
 k/bo2QJoFFn3wbIUkv+hKg1iypV56ZpoaUBd0lybqX8+q4Vz0t7Qm244Ajql/C7FMhbu
 kMcA==
X-Gm-Message-State: AOJu0YxTgJhcl3jq2UKVloLQHVHglo/sj7qaZ4cZpfrHT7Mvs0SdTSY8
 hc2y4FZcEQUA1GAmoBHnAsQC31HmkgrEcAReGf4Dc6qQPpaZf9TNOn8WRaUfqxN8k0dRBw97Jso
 KFjg=
X-Google-Smtp-Source: AGHT+IGWtIyHVdRRDQf6UCO/aG+PUwZ52bIwCYcWjqtTvhy4DkR8vJ0g+c0CIxrJtgmEO3DIoK5/HA==
X-Received: by 2002:a05:600c:158b:b0:422:62db:5a02 with SMTP id
 5b1f17b1804b1-4264a4561d7mr10600945e9.32.1720095372023; 
 Thu, 04 Jul 2024 05:16:12 -0700 (PDT)
Received: from localhost.localdomain (adsl-241.37.6.160.tellas.gr.
 [37.6.160.241]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2ca5casm22471015e9.32.2024.07.04.05.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 05:16:11 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Subject: [RFC PATCH v4 7/7] DO NOT MERGE: replace TYPE_PL011 with x-pl011-rust
 in arm virt machine
Date: Thu,  4 Jul 2024 15:15:43 +0300
Message-ID: <99604de6015556c4dc57bef0fa89e53b1c42b4c6.1720094395.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32b.google.com
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

Convenience patch for testing the rust device.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/arm/virt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b0c68d66a3..49dd0b815e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -929,7 +929,11 @@ static void create_uart(const VirtMachineState *vms, int uart,
     int irq = vms->irqmap[uart];
     const char compat[] = "arm,pl011\0arm,primecell";
     const char clocknames[] = "uartclk\0apb_pclk";
+#ifdef CONFIG_WITH_RUST
+    DeviceState *dev = qdev_new("x-pl011-rust");
+#else
     DeviceState *dev = qdev_new(TYPE_PL011);
+#endif
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
     MachineState *ms = MACHINE(vms);
 
-- 
γαῖα πυρί μιχθήτω


