Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CBCC4829A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 09:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXdzU-0005Ly-Ul; Wed, 07 Feb 2024 04:13:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXdzP-0005HQ-5k
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 04:13:07 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXdzN-0008Gh-Do
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 04:13:06 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-55790581457so486103a12.3
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 01:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707297183; x=1707901983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qdGMcRfsmtGhYej/iom74nzzoWRpqiyUHpcA+be6vSE=;
 b=IVDfq4qgANHftUYI4IjFXArSeiMJib04Q556HO5bX6ihQrqMCYmuO0G/I9WXl5j2b/
 NvcWChN/HbAzbh/ue4guOoAV9Jv1M//bcScX9xVcv0nuzLsKJ7E58R4U6QnWK03tEKLM
 pic89958dgUBL1e3WQrUoyJSYQcQFZTI7+T8R1VeTALHKDHOMotrkcR6GyV9x+Bf8Fxd
 9gaHkX1jqkK0M1ClNFcZTaskch7F//hboYP9VDa5zZbBp1bi8tgr4fV8F7S3AyYOVcHI
 nM4gXMj+ItRCtVTP/7SRw4Lzy5cAwMmgecjw4Qf3AvBuyMAwF7PQeuj2z3mED3wu/CId
 tSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707297183; x=1707901983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qdGMcRfsmtGhYej/iom74nzzoWRpqiyUHpcA+be6vSE=;
 b=errFbp4i3DCQC9THQ1BgQyAUVb5SJnlQUZUn8IeZwEF5TiQtxk1EVW8FkGGHWSeiMc
 Bq7XQ73qcl9XHKays+qj0+M/jwTpulQC8Dy+yY3w0i1CSn1q+LRrdantfmeVjCGhVZlH
 X7o2jSz+w1yabZX0As7RtiTHyMlwvK++L/QDzJLMP08F9NrWS5BjO8VKK3l0ss7dCrTS
 zL6k8iD0umBzx9dQBOXGLM2K5bJjiUMN7gd1+Y3Y+9mf0MpB94uMXuxUyr7UHkxVJ71B
 4G/6YfJ4lqb3+gaCjqp+/Waw/neg01FQSy/IPLFpEY4BkoEuvamZT8SDbJt4ouelVie7
 pbug==
X-Gm-Message-State: AOJu0YzUm7/XwcSKZH0HdfR706wga6pjVF9EkMEvgUA5dLW17rhb/Mc7
 dkTUwFuA+Dm0zTkUnN75l5pCGjFSXxo7zsSamLBPPC5YdLR2bSSLntF+oIum1hJsLEyA6RNqtLz
 Y
X-Google-Smtp-Source: AGHT+IGn7aejHRfBB7NhzMHelQL6AH2NUOvJPvm+VPB9oZRKlDiV3NbTMtQKyqgfr2Uxg85XFVEEKQ==
X-Received: by 2002:a17:907:960b:b0:a35:edda:ca8b with SMTP id
 gb11-20020a170907960b00b00a35eddaca8bmr4708718ejc.76.1707297183122; 
 Wed, 07 Feb 2024 01:13:03 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXhd8ty0xLb2MwePx3PI+ojZX59wy9omw5on58bLRU/8WU+LeSOzP2u9ncHSm8CAzzEaYadlcg4wp+llFfEXreWmSeMXzYXRob2ssp1X0g/zfIaivRfBx9QdJjfG2wGd/e9sJ5kEnjAemK5ceEoEz7Aorq0Rb6vA4twDlIaBHg0ckgu8LS33HA+y+vX88l49qLueW3yRKRHIjpoe6dn+ViapySSg29wgMikSY1uCyNGRJvBv2A9YC8=
Received: from m1x-phil.lan ([176.176.170.22])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090652d800b00a3738c18c9csm528627ejn.178.2024.02.07.01.13.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Feb 2024 01:13:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/4] hw/ppc/ppc4xx_pci: Remove unused "hw/ppc/ppc.h" header
Date: Wed,  7 Feb 2024 10:12:51 +0100
Message-ID: <20240207091254.1478-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240207091254.1478-1-philmd@linaro.org>
References: <20240207091254.1478-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20231011132427.65001-2-philmd@linaro.org>
---
 hw/ppc/ppc440_pcix.c | 1 -
 hw/ppc/ppc4xx_pci.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index df4ee374d0..d84418cb7b 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -25,7 +25,6 @@
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "hw/irq.h"
-#include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_host.h"
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index 0a07aab5d1..e4101398c9 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/irq.h"
-#include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
-- 
2.41.0


