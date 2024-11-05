Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9342BD2B921
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8JGL-0004kR-Dx; Tue, 05 Nov 2024 08:06:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JGJ-0004cl-7M
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:06:23 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JGF-0002aX-5l
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:06:22 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso46044925e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730811977; x=1731416777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ofAZFiczDEOu9xgPawLxt48aoodtpVY0sVqQebDNA74=;
 b=XeSG3ZtHsbO0F6EF9/mYVy/zZKIgeVbGJxqwyoPI5lmtzGuoVr3mAIg8c4LoiLyoHS
 +p8v4B9IXZJEGRxJq/YbjxFGpWQcE/wSHhc1iwvtFjLuGyg7h9lEMOrcSplz55+Zi6YR
 5b6XpZUYsGoCGGArYTS5WWRGrR1VFQmDnlUnlB1Oc+0izmis8HiLmUElsmsConxNxa5j
 u7lbaeAPtdVHEcZCgH4IKYBxCEQMcGBT+FZlP1PhEDyc/YJFgCZ+KFzRnRhYGqe500zN
 vupHAQCNvokEnfHWo47KtrZSDcv+Del6bnJITDvQDlCuFUD0G/7r7y2PeDt4AaF6nXvT
 QjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730811977; x=1731416777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ofAZFiczDEOu9xgPawLxt48aoodtpVY0sVqQebDNA74=;
 b=pOVL6ezWUqRcEhNnBfpKj5QvCoivQ/GN0cDt7gO7JZukNhBiFs3wsYynxcx520xWeQ
 e3qGu1T3+10ELmVDW6tiCTu1oC3CXGzIqGxqNtSP01J84NWUS6Q77x7jHDY+WKDMSveM
 l4ttcYOf9JIhxtExdnEKTPaRchKzW/r7Eon8TkEfryU2q4kRjyaQZ8Rgj0oBShPVGiiV
 /PmzajqYEWnrTk0bUIaNPPHGhso7NMWKAd8XjHBN+yO36ThfpffCmFqyVWKlwz/dkq9x
 okM0/jg6wMiRN6IbNzQ0mDpVi8kEW/4Yk4LD6heqBKT58XgTi8JZp6coU4dUxP45w415
 VUYw==
X-Gm-Message-State: AOJu0Yx0DN98CAs9Ax5OO3HownTg6TGZ6Wth7lI4AEUjAJ3UcKyWqxy0
 i4uD1dKzhp+jrKXeTYhyefFgAJTu47xvO288EPzgOEU5dZkhiUeBf6IRyJoYwlmrFLja4R5Nakf
 kHAQ=
X-Google-Smtp-Source: AGHT+IF4uaP7NjPFamDGcyl+la1qxC3RIS3oU3RixeHv2G3YBtTX3BECiMTyJmfanvavmJ/rByZK8w==
X-Received: by 2002:a05:600c:1c15:b0:42f:8fcd:486c with SMTP id
 5b1f17b1804b1-43283297a37mr131910645e9.33.1730811977415; 
 Tue, 05 Nov 2024 05:06:17 -0800 (PST)
Received: from localhost.localdomain (86.red-88-29-160.dynamicip.rima-tde.net.
 [88.29.160.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5e7c8bsm193062535e9.26.2024.11.05.05.06.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 05:06:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/19] hw/timer/xilinx_timer: Only expect big-endian accesses
Date: Tue,  5 Nov 2024 14:04:22 +0100
Message-ID: <20241105130431.22564-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105130431.22564-1-philmd@linaro.org>
References: <20241105130431.22564-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Per the datasheet (reference added in file header, p.10):
'Register Data Types and Organization':

  "The XPS Timer/Counter registers are organized as big-endian data."

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/xilinx_timer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 28ac95edea1..3e272c8bb39 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -3,6 +3,9 @@
  *
  * Copyright (c) 2009 Edgar E. Iglesias.
  *
+ * DS573: https://docs.amd.com/v/u/en-US/xps_timer
+ * LogiCORE IP XPS Timer/Counter (v1.02a)
+ *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
  * in the Software without restriction, including without limitation the rights
@@ -192,7 +195,7 @@ timer_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps timer_ops = {
     .read = timer_read,
     .write = timer_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
-- 
2.45.2


