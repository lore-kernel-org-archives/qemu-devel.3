Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79223C54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 09:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWwJ-0007Ai-2B; Mon, 26 Feb 2024 04:06:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reWwH-0007AG-Bm
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:06:21 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reWwF-0003Xj-8Y
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:06:20 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a3f4464c48dso307148866b.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 01:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708938376; x=1709543176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7oVTgSJUCJ05vrSeKkBPqU1gIvTy5EgxgQEBwc+GsnM=;
 b=BNwhKoFnTEdW+A4DVb5HmHw5P7SVuU3u3anlujgv69wEqvueoRKAbn4eywnVLXs9z/
 W7rwnsE8K6SDY5BHr+i5MjK6UWbc1BbKbl/1Vp9pAtQPauiCa0Jrge2vsHEtGkP6LJtN
 u7qZPgkAtF28rlIHFExxM9jbOkxaJzRmYJUpHYSiTgxVqQS0HGqLbP8JkajKPt6JHsYG
 6vhJtgFqdh5ZpHLa7LUOLSb5UeVhphZFH7MC6p8p/xOYB51LxZmJuU9528s215nIzaGf
 XFsB32aIY0KS9noYgHPP1aHrHe8b9uhmThRVPeOfwO/o8fvvnMtQe3s75gKVPZqojA6b
 +gfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708938376; x=1709543176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7oVTgSJUCJ05vrSeKkBPqU1gIvTy5EgxgQEBwc+GsnM=;
 b=coA3JSPT/fUnY4cflTl/d66Jmm4QdjiAxO9e8D7e08kG95x3IC6bJlV07Jnu2w/DhA
 FuhFyR+ZCK7mcBJeeCRjUgw60ai1D1BTtMMObKV+G9dkL+w2QmWD1D1112gFP0xVDRp3
 bqjqog0dLEV9ocLRSyvm7VVYfZKxVqWMmpZZ9WpzWaLGSKkIrOe0cs3wRTllgamQv6F1
 S7kE5aVYf53jOWcuq3JI0gIa0kP/sz1DBczBJUafWq7JfZWVnC1/ytsTx/OcU2Cw4Hjw
 aGfcNutVUbL+RCN2jj2qRR4+xMLgjC0WOI0zABTxXA7yinZvtpjPadQTm5PGBOk8deIW
 gX7w==
X-Gm-Message-State: AOJu0YzgNfUEFW00YvG8Gdk5SctnGlMyHa47bTrNWMvDf3wiv5cyr7Z8
 YOIVOtlcRBx3860NSH3cY+bSH0Wdr2MdZET8GQ3v+0+R9kMh9o4EpDLd8N1Dw2zi9zqpDcW1xn5
 w
X-Google-Smtp-Source: AGHT+IGO3jGtHMSN/HP//kxXs5Lz0HjhOYPU4EmaJEde0/u/s+C/8DK2WVwGlFc4MI7h+PchkSdiYQ==
X-Received: by 2002:a17:906:13db:b0:a42:f40e:3ac0 with SMTP id
 g27-20020a17090613db00b00a42f40e3ac0mr3740303ejc.6.1708938376553; 
 Mon, 26 Feb 2024 01:06:16 -0800 (PST)
Received: from m1x-phil.lan ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 d25-20020a170906305900b00a3eb1b1896bsm2196669ejd.58.2024.02.26.01.06.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 01:06:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/2] hw/i386/q35: Include missing 'hw/acpi/acpi.h' header
Date: Mon, 26 Feb 2024 10:06:00 +0100
Message-ID: <20240226090600.31952-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226090600.31952-1-philmd@linaro.org>
References: <20240226090600.31952-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

"hw/acpi/acpi.h" is implicitly included. Include it
explicitly to avoid the following error when refactoring
headers:

hw/i386/pc_q35.c:209:43: error: use of undeclared identifier 'ACPI_PM_PROP_ACPI_PCIHP_BRIDGE'
                              ACPI_PM_PROP_ACPI_PCIHP_BRIDGE,
                              ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_q35.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index e0b3f55a02..45a4102e75 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -30,6 +30,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "hw/acpi/acpi.h"
 #include "hw/char/parallel-isa.h"
 #include "hw/loader.h"
 #include "hw/i2c/smbus_eeprom.h"
-- 
2.41.0


