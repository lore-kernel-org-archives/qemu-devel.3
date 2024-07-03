Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B54C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 09:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOwAa-0006xY-EZ; Wed, 03 Jul 2024 05:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOwAR-0006ql-91; Wed, 03 Jul 2024 05:20:47 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOwAP-0000e8-52; Wed, 03 Jul 2024 05:20:46 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-70df213542bso2838379a12.3; 
 Wed, 03 Jul 2024 02:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719998443; x=1720603243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t+wS3hv0icffnZAPLdGTguKnNLO8tS7zhQ2s1WZd2/g=;
 b=dW/R1uohQaUX0hmvGOwcQm6qslQRrZifdXNponQiI85suN/RXQK6fsqqqmLzrMsZG7
 7uZ8LnyxsYM8leOwbhE6XCSRI+PvAn13GlOvPo2a0+f/IoT+OfEEPg8H0g/xmLpcLOL+
 71x7xYw7JfbJTyrLl1Ik5JpLs8wZtG4PXRwUrj9ovddQGDPxiq8oh8M8gZT9EIPYK3Q1
 cc8WvBEHZXuXG7TOvOW6jamZ4q2q4jsz5HuWt6eI6Ec5J36IWbYTVmpJKbjni+yll4iM
 AdIAXWbVnmspQ6rbO2KIjmmiu2z8pE1lhDBTaeP38DhwddwNq2bMniGSHGKKqNL5ReG/
 sPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719998443; x=1720603243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t+wS3hv0icffnZAPLdGTguKnNLO8tS7zhQ2s1WZd2/g=;
 b=TgTUxikKlHL76qxSCaL1wb8rzK9U8C875oJMF3yrGHid6GOt2zGJ6ELp1iCAakdsbx
 vQJzy/wkdoL6SsEcZjo31RxD3KRxN54GgTI/NGRFFVnBc+95aitpTgwZ1sHkwDecKG2I
 DQJVdDOgdm3S3Jrqnt5ctXmJ00CS0l+/vG2WbX6HFR7y6LMdI7O0A2pQJGgu3ShvJHRn
 tewmM/mha0OU2S91nGmIGh8caShD/ezrgVnItn3Yh2j1p4GLhOb53GLlHbVpuFctPbAt
 ajVlR1KoqqaH834Rg9C05NXLKE0q4zHDoE/dqnUPukYoizc/XDCV/GDr5hEYpeD/nvFf
 228g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOSAYW1z7OjneT1UaND+mrTovv/AWqKNO2+Q3nldmIKNqTSFY8/c9N+UZC5aLSB60dkMDFelhVbs6wNL3InEpL7/dQFGT2A2fgbu07Z7MUyKHnToPg9Okm+jYV1A==
X-Gm-Message-State: AOJu0Yx//RL7oUh4vxbAXFjjPTokdMeA5cAhjpNxQq3oeEkJRe4WQyJe
 FTBR4dtJO8Ei47AcHEB30QNHXlXrYNyLAS7+Bm8cEnSsr9wTKTIy
X-Google-Smtp-Source: AGHT+IEdnQtp+aBJYUdFyTaTvB5VsyQo4rMqRXyLoPfEmpc+bTgTBcIUEwcj4w3M58zX+/40ilWwhA==
X-Received: by 2002:a05:6a20:8422:b0:1b5:fd58:30e8 with SMTP id
 adf61e73a8af0-1bef6140771mr11101961637.18.1719998443124; 
 Wed, 03 Jul 2024 02:20:43 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c95ca64649sm2905596a91.13.2024.07.03.02.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 02:20:42 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: its@irrelevant.dk, mst@redhat.com, hchkuo@avery-design.com.tw,
 wilfred.mallawa@wdc.com, jiewen.yao@intel.com, marcel.apfelbaum@gmail.com,
 lukas@wunner.de, cbrowy@avery-design.com, qemu-devel@nongnu.org,
 Jonathan.Cameron@Huawei.com, kbusch@kernel.org
Cc: Alistair Francis <alistair.francis@wdc.com>, alistair23@gmail.com,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Jesper Devantier <foss@defmacro.it>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 1/3] hw/pci: Add all Data Object Types defined in PCIe r6.0
Date: Wed,  3 Jul 2024 19:20:25 +1000
Message-ID: <20240703092027.644758-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703092027.644758-1-alistair.francis@wdc.com>
References: <20240703092027.644758-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add all of the defined protocols/features from the PCIe-SIG r6.0
"Table 6-32 PCI-SIG defined Data Object Types (Vendor ID = 0001h)"
table.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 include/hw/pci/pcie_doe.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/pci/pcie_doe.h b/include/hw/pci/pcie_doe.h
index 87dc17dcef..15d94661f9 100644
--- a/include/hw/pci/pcie_doe.h
+++ b/include/hw/pci/pcie_doe.h
@@ -46,6 +46,8 @@ REG32(PCI_DOE_CAP_STATUS, 0)
 
 /* PCI-SIG defined Data Object Types - r6.0 Table 6-32 */
 #define PCI_SIG_DOE_DISCOVERY       0x00
+#define PCI_SIG_DOE_CMA             0x01
+#define PCI_SIG_DOE_SECURED_CMA     0x02
 
 #define PCI_DOE_DW_SIZE_MAX         (1 << 18)
 #define PCI_DOE_PROTOCOL_NUM_MAX    256
-- 
2.45.2


