Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1985EC61CE8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 00:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPrv3-0006FL-R5; Thu, 12 Jun 2025 20:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3BmtLaAcKClM59769y319916z.x97Bz7F-yzGz689818F.9C1@flex--komlodi.bounces.google.com>)
 id 1uPruD-0005pE-MR
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:26 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3BmtLaAcKClM59769y319916z.x97Bz7F-yzGz689818F.9C1@flex--komlodi.bounces.google.com>)
 id 1uPruC-0000Yb-4e
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:25 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-23507382e64so13721565ad.2
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 17:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1749773062; x=1750377862; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=NO1C/XYn0cNc0jJwYcW3jpPIHQxOkwpZejg8rpn/AhI=;
 b=QeUuvCsdXl92znA3t7UbNu+WKqdMnW3G7IFNz9wAPzSnWTLh2d+eJxSu8s5niz0gsO
 K/X/UbhohwmjpFOBryPHzff4Td2+gWhWX5TtonmzBMB2Q9G1EDEnyKlrqZSEYd2TWu/j
 iMRn0eoQ0FAHCzZoKejcXqeNeutFqNC76RefV0T46bMlPqW9eGFLaFJqGP4CC2/g5tT/
 FxZD1ZrnZL26N1Mv8HDndDdKufM6EYwtL6616Pli1JR2tKv2/Fywl+/v3YrUuAbgwO6A
 ajpwSKS3qBOfiLd7VvnSQBFL71Rb8klnWxY2FCZgUMxlGShX2Vmcn5LuGk7MUSC9Wt9R
 pfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749773062; x=1750377862;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NO1C/XYn0cNc0jJwYcW3jpPIHQxOkwpZejg8rpn/AhI=;
 b=Odva11nslluDDRkfGHpTlHZDDO119G71ClQuxfz/Pg0c2JlH68LGYFUXg/zdcBAtlb
 z0E0823bYCys816DBj6jY7j7lzOqEtcN73TnwmDILHh03oYgOpyMtrMnPZinmtFg1ISV
 yxD7X95O8I3AlTAt5MFCOgTW0q810bFSyJHUfklndM6TnSccDXyQRy2vTuklBa7M54t+
 cJWDx9/5jVMIrKvsFO7TfW+5GXlxv8xU6ViCtI8td6HP4wPr6wiksh5z1ytZ6LHnG8ov
 OGLFrp2SkLKGMl4fO/tC+4KlaYbvAYgXqaZxZQBsZvl4kffRJNcH7KCLnDw518NT4GBI
 wcTg==
X-Gm-Message-State: AOJu0Yz6bxRJh8bBW8lki7yBgu8Kmo8AIcE/+Emh5jVCxmBYPjseErZk
 46VT9NF6XOitmX+39aH0WqjPTCp8El/mUfIP0n8Ccj3KTwZiaro4c8DI4u8YzYGQrQTE5XYD2iQ
 gVzJbY8MSU9oTeEfBGTYwLXcJJEPV1swXVZwO7lp1lsYUlFF65WVIFeBnyMO/cjzX0mQ/WIKV54
 mcxcj4a2QJoYOBpWhVo4hV6sjMvZ7XcRmo09P7YE16
X-Google-Smtp-Source: AGHT+IF9eJQlQuSnGUux3PbemsptH8BHWBlQK73JP4lTFI29QphP1Bx+UKQyMnvHcdm+jIpaXg+9fua7Py1l
X-Received: from pgac10.prod.google.com ([2002:a05:6a02:294a:b0:b2c:3a2e:ac7])
 (user=komlodi job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:4b2b:b0:235:f45f:ed41
 with SMTP id d9443c01a7336-2365d89f25fmr13389855ad.19.1749773062018; Thu, 12
 Jun 2025 17:04:22 -0700 (PDT)
Date: Fri, 13 Jun 2025 00:03:59 +0000
In-Reply-To: <20250613000411.1516521-1-komlodi@google.com>
Mime-Version: 1.0
References: <20250613000411.1516521-1-komlodi@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250613000411.1516521-8-komlodi@google.com>
Subject: [PATCH 07/19] hw/i3c/aspeed_i3c: Add register RO field masks
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, clg@kaod.org, 
 peter.maydell@linaro.org, steven_lee@aspeedtech.com, leetroy@gmail.com, 
 jamin_lin@aspeedtech.com, andrew@codeconstruct.com.au, joel@jms.id.au, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3BmtLaAcKClM59769y319916z.x97Bz7F-yzGz689818F.9C1@flex--komlodi.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Adds read-only register masks for the Aspeed I3C controller registers.

Signed-off-by: Joe Komlodi <komlodi@google.com>

Reviewed-by: Patrick Venture <venture@google.com>
---
 hw/i3c/aspeed_i3c.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c
index 7a16dfec53..1ad25e5a00 100644
--- a/hw/i3c/aspeed_i3c.c
+++ b/hw/i3c/aspeed_i3c.c
@@ -74,6 +74,21 @@ REG32(I3C6_REG1, 0x64)
     FIELD(I3C6_REG1, SA_EN,         15, 1)
     FIELD(I3C6_REG1, INST_ID,       16, 4)
 
+static const uint32_t ast2600_i3c_controller_ro[ASPEED_I3C_NR_REGS] = {
+    [R_I3C1_REG0]                   = 0xfc000000,
+    [R_I3C1_REG1]                   = 0xfff00000,
+    [R_I3C2_REG0]                   = 0xfc000000,
+    [R_I3C2_REG1]                   = 0xfff00000,
+    [R_I3C3_REG0]                   = 0xfc000000,
+    [R_I3C3_REG1]                   = 0xfff00000,
+    [R_I3C4_REG0]                   = 0xfc000000,
+    [R_I3C4_REG1]                   = 0xfff00000,
+    [R_I3C5_REG0]                   = 0xfc000000,
+    [R_I3C5_REG1]                   = 0xfff00000,
+    [R_I3C6_REG0]                   = 0xfc000000,
+    [R_I3C6_REG1]                   = 0xfff00000,
+};
+
 static uint64_t aspeed_i3c_read(void *opaque, hwaddr addr, unsigned int size)
 {
     AspeedI3CState *s = ASPEED_I3C(opaque);
@@ -97,6 +112,7 @@ static void aspeed_i3c_write(void *opaque,
 
     addr >>= 2;
 
+    data &= ~ast2600_i3c_controller_ro[addr];
     /* I3C controller register */
     switch (addr) {
     case R_I3C1_REG1:
-- 
2.50.0.rc1.591.g9c95f17f64-goog


