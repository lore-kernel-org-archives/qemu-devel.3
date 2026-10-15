Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C70CC6B3E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIdk-0000eU-Nd; Thu, 15 Oct 2026 06:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIdd-0000a0-ER
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:24:43 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIdZ-0003Ey-DN
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:24:39 -0400
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4956869750eso33947255e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792059875; x=1792664675;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wyuy2rktXggsAmL76/K7kLk/zQD6P6G+cIxBCgNKHGg=;
 b=Oeq4S3cjuus+w0uyaQFcQazhKwVxWi8eA5aMtwL4S1hxGmagwLE7HhNYS6+i2ec1U1
 Rnvw8L8VPnhdjHPL1cwULHhnRErMnoZZXv3/YnGQc+++GMIOHbl7yVEG37ypDiBWFjMm
 zQ4RzWyPmcE/H2dgHoYMZLLdixYjhdKF3g1o1HpZY2LCPaJmHTj3AZ0serqlixX10a3B
 3Q5OyEsT0NdtIaFHqd7Av52LJ0XNehfrScRXyJaYhzdNEsivXEOUw6MTuFSbj6AFC0LK
 RUOPN+Vl9vkJKAXPnWKftmFWQxEXadyI4kyX2RAyb82YcTjqnkgvnchv68JhdA6rHqEZ
 A4Rg==
X-Gm-Message-State: AFq9FYKlepCyyFfDtzn1SAc8i2d/9qsHTarkBGl+kleVZiq3Wys6A1vN
 sumjj/pa96LjtxaCNY7FuHkPNNVMYHG6I+QD0GHMVqtk9yjyXtYbQw7OLJrmgQ2E
X-Gm-Gg: AYBFou1ImQPvQBvh1YSq6KE/GdkPMuOzJl+71ulh/q7XTdqt/QqKvW48fZD4ujt5T47
 zJDucmwLHIDt792jTa1y58rTJFWm5HKEZ+NTn/z6maEkbYTMi6UapQI/cYrTymmzJ/o3BCBnJqm
 Ibg3chs2XCdcxoQXKcNifsN5JOvEQYboL5/R1IBRmGKKg485GEpKxtGw5q8XwfT8z+TkKLxzU6d
 7kneLoequNDAEHgD5B5rIEaTdUavVG2Pqt4v579sjpPUUzFy4VLa6EW1yDRfhpm1+2DlspbvyS5
 MgP8k1BJmNULfrl20MJXhiPuLcu84PjJ7NnGjVii3MwrwV5hMeZsrXMbO/ZYVIYDNXqNYF4dC1W
 cbxG4oDcDaFKcE/88d0kvTDpwLf1c2PD4miZ33VM+RC9zBDghARDsDwCzTO33fDcP1D7cq39JCI
 k38lm2VZYeTCUK5rnw+0WhzEVQYtHiE4KXtUPgSASE6By7fAB15nHQ/eYE6/46Wo4xulR5cZl02
 Zq+47ITtM7UFM6IIBP6slfu1fzpQ7Osn9vslsUOxMR3yw==
X-Received: by 2002:a05:600c:3e83:b0:4a1:6d35:779a with SMTP id
 5b1f17b1804b1-4a18e446880mr341688695e9.3.1792059874580; 
 Thu, 15 Oct 2026 03:24:34 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd66ab3dsm56129535e9.2.2026.10.15.03.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:24:33 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:27:51 +0200
Subject: [PATCH v3 04/50] hw/i2c: pca954x: drop unused header inclusions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261015-bmc-minerva-v3-4-7d50c8a108e5@free.fr>
References: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
In-Reply-To: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792056474; l=892;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=GLj3AqYRa9mINpG5YoTmBh1sQwRVDiaGrNDDg2Hh/b0=;
 b=ZY5YmJ/6jWLNSEgZHRfp0lhNgeO69qtpIB0iK7KytOQABfNNQ94S50cQDVhgqbbeFgyP+4sbN
 cmxVIJjz6hZAAmOe26SjjoBtMCL+btJbha9Yvlrh/tcT6vz8yJo0eF1
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.43; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f43.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The qapi/error.h, hw/core/sysbus.h and qemu/module.h headers are
included but not used by i2c_mux_pca954x.c. Remove them.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/i2c/i2c_mux_pca954x.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
index c603446028..c8e75da8b2 100644
--- a/hw/i2c/i2c_mux_pca954x.c
+++ b/hw/i2c/i2c_mux_pca954x.c
@@ -15,15 +15,12 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
 #include "hw/i2c/smbus_slave.h"
 #include "hw/core/qdev.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/core/sysbus.h"
 #include "qemu/log.h"
-#include "qemu/module.h"
 #include "qemu/queue.h"
 #include "qom/object.h"
 #include "trace.h"

-- 
2.53.0-Meta


