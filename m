Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D1ECCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 19:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8O4N-0006bm-79; Mon, 13 Oct 2025 15:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O4I-0006PJ-KT
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:18:50 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O4G-0001sI-SN
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:18:50 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46fc5e54cceso9499415e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 12:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760383126; x=1760987926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3o++8qrLq+EGatO3dUhXeLk7H80tOMbmVeX+vOl05oo=;
 b=WKLCsr9K3TFTSlcIWmHLefD7HPQIHHji5jEfsPZulaGsd5NBgteO1d9zsyjGr1Kfz/
 tRuLSNduc2tqanTfAAU1QWNtL8J8IqTt/MgALPs3Tjyc7JAAmDvfQsEOdcbRbrsReM+V
 bWX4FSWwZAvv97Z2duRa/twwTdQ/pIPTLrjpc55p9T8QuZgAa7TX0LoPglpwZ9/l2uvq
 QNu9/BfVG2aJHm7sTBvmYKgC2nMjbiYJEXHVF+SnF6e2sbsK0Q0jok7VainYPCaRd3mH
 x1aroO9JDxmwIeiX8c1wy8M2wQ/rLiGeenyyCRq6K6xSRqCkjSaEMnZ7PX3joaKuzS5v
 ykUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760383126; x=1760987926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3o++8qrLq+EGatO3dUhXeLk7H80tOMbmVeX+vOl05oo=;
 b=YBx4t0vVNsH9BrYf2LXhwrvpJuUQCGRJ9LB3m97t/J0u+QyDJcvJ/GIXpa3cz6MjiL
 3hVyeM7JFnVN0EHuk02Czt80PAPeTYxngg14g86puwiryRs1Zccm+a3xy4LfxNWyvu07
 NNRKLTciIiAHj8GbHrm/gbNfCx1uzUvcx9B+DeIQg+gT4RnKkimcmYUz5lsSiRC1BEOC
 KObDKych49VRB2pTNeCViMK4AcK8Jp9XrzXbBpNHmXIYIjmWDYkvZ7BjyZkpviarZmRN
 GTlOLzhYfQcEiejIRIac8FooYNukkRPQpk54LuQm/C7bTRCDsOgoKZqoEUy0B+UKNkYU
 75Dw==
X-Gm-Message-State: AOJu0YyG5TJUCLQWxO7iXv2yXkjw8zQduHLc/2KMg1iVai/pYeYmmW71
 gfDY3aj9EEcDH0d+BV5WjQ+hv1SSHlJ5OqvI44jERrHiPcNMA5usD28lzbQ+ZcTZgyAysr2ZF+k
 3VO+UrZBTRA==
X-Gm-Gg: ASbGnctcvuQ8BWPm1fJ9fZONUECVbRDcg+he5tU8II77lK2YVc/t2MVKPc5ml7JUVft
 QuPJwQ4B04XgoXBK8bKNdhSWrkzG5JlCLH3Fax++280qq9YuDVhKj7JIRyHGbuMkNJwaho64W9H
 MMPEA/H/zY5OeGiCf06RMVNB+7xNVqL4SPHSCV49WgwPn/El//apW/gvQlhvnhmBj2mr5pt8d9t
 a4wAWuKgBAg/eFWrfqiBjWAWLObrmx1VadLOetaIN13N6iSXWchXDHKFt4O8uvuFrR73gKgmB4H
 fC7Ph8JEP8gcIfLBFGAQHfNxiZ6npwF5TEIRBH1AZGdGEZw1nFKBZyybCSv9nDNZ4QQ1Vng6Duq
 TflQ4wlAsMZ9X3iUFirlLWOyB3q4CgXCAcM78dQh5uPESnaTcJFQvIbzYDI3vrL6PihFq5j4/19
 BK3HNWVbjZDky+1KMzK/E=
X-Google-Smtp-Source: AGHT+IHfHF0Jcz36fCW9b6a35aYlV3oJwQtwj3o8JiFqeflivF511cRU7ISs/p2/HQ33gcjY/pyM3w==
X-Received: by 2002:a05:600d:41f3:b0:46e:6603:2a84 with SMTP id
 5b1f17b1804b1-46fa9b08bd7mr168268785e9.32.1760383126277; 
 Mon, 13 Oct 2025 12:18:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb489af92sm217038955e9.17.2025.10.13.12.18.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Oct 2025 12:18:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/12] hw/vmapple: include missing headers
Date: Mon, 13 Oct 2025 21:18:03 +0200
Message-ID: <20251013191807.84550-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013191807.84550-1-philmd@linaro.org>
References: <20251013191807.84550-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Disablement by default led to:

../hw/vmapple/vmapple.c:276:39: error: use of undeclared identifier 'GTIMER_VIRT'
  276 |         qdev_connect_gpio_out(cpudev, GTIMER_VIRT,
      |                                       ^
../hw/vmapple/vmapple.c:479:54: error: use of undeclared identifier 'QEMU_PSCI_CONDUIT_HVC'
  479 |         object_property_set_int(cpu, "psci-conduit", QEMU_PSCI_CONDUIT_HVC,
      |                                                      ^
../hw/vmapple/vmapple.c:556:13: error: call to undeclared function 'arm_build_mp_affinity'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  556 |             arm_build_mp_affinity(n, GICV3_TARGETLIST_BITS);
      |             ^
3 errors generated.

pretty quickly.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251007203153.30136-2-mohamed@unpredictable.fr>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vmapple/vmapple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index 16e6110b68f..1e4365f32c9 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -51,6 +51,8 @@
 #include "system/reset.h"
 #include "system/runstate.h"
 #include "system/system.h"
+#include "target/arm/gtimer.h"
+#include "target/arm/cpu.h"
 
 struct VMAppleMachineState {
     MachineState parent;
-- 
2.51.0


