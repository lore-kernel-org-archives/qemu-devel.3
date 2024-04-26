Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53A3C19F4F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RVy-00031v-BE; Fri, 26 Apr 2024 15:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RVw-0002p0-8S
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:45:44 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RVu-0004q1-Ef
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:45:43 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a55911bff66so327645166b.0
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160740; x=1714765540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rBREpUZQ0r3GUKko+t9VMOEs4AUMGwGQ0XgatsXxsV4=;
 b=XcmflDGOl8Qt98eajrPFbuXni1rhiWTTaGibRfYCpKbjL+q8DCDvVxKSIDweDvY6gv
 NTxVdZIMS+WhDt/YGkD5fgLSBjWPO3fnez78At/yFk0vP092Tqr5xon8BgJxu7iWqpBB
 PDMzn+TOSh3Agl5XuPsc1KgqOHCqOjF9bflWYi9zhHHEJW+o7B2GXpv2V3H6W7qVZ8Fa
 7JhQxMsyvPtMGbZRsYRuEDDklsaWbw+ZgQioxQKay1F+FxU17kNd7AvcwogxnsCJf3Q6
 9cq+6oVFRTK/b2K2WobBOjhaeqeSYU2JWpPnVhhCzhrqkPfsnL66gubkNAAHdeTh7e6v
 rhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160740; x=1714765540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rBREpUZQ0r3GUKko+t9VMOEs4AUMGwGQ0XgatsXxsV4=;
 b=uD30Pw4yX/qd2/878FD95UZSzG33ZpUIDfpGBJeDSQV7m2iSf0TG2BRjKsnDKikWkY
 zOKSr4pUxCUKKLceuCHu6pY1DwojxBio9MW/2OzJtwGSiCQLlkQtr6/+ingwnIatQcXd
 VsJs/FpVtY4yfXVXdGckSxjBYPO7rXmuXdnEcofFXokCXQsBk3IRN/QiWS0KHz78NIGw
 ZLSZYi1r61XsaWtFzCEaVLkhfAFV0F6mK8EtEuhgIX/k01EfxvN+lOoTbFLlAxsPRFX/
 efURXnm2hKvdmxn/KQo9VdaUJS8BB5f1/P28x9K6Vg36VodRQwmnlotrhBhgUk2s6AI6
 6ipw==
X-Gm-Message-State: AOJu0YyJsM4FB5vnX9Iwvt/i15UmpuZtM+H4rK0nc2bqRszQN7diJpZR
 CEIIjEAboVMhh+0g+cUXWSBCKc5gj4zkTW4KEfbKGYx9n0ZdjztMg9rkLw9yKTWR69oRYo5R7pf
 LZls=
X-Google-Smtp-Source: AGHT+IHjSw9zdV3vqmgmRnB18I52aARA6bvPfoPPdGqh++TJMtUZutBBWfdUBtaqCGJjnAhvwkQDfQ==
X-Received: by 2002:a17:906:2854:b0:a58:9a74:5e6d with SMTP id
 s20-20020a170906285400b00a589a745e6dmr335495ejc.11.1714160740621; 
 Fri, 26 Apr 2024 12:45:40 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 se12-20020a170906ce4c00b00a587271f77dsm5326419ejb.176.2024.04.26.12.45.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:45:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 37/38] hw/core: Avoid including the full 'hw/core/cpu.h' in
 'tcg-cpu-ops.h'
Date: Fri, 26 Apr 2024 21:41:57 +0200
Message-ID: <20240426194200.43723-38-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

Only include what is required, avoiding the full
CPUState API from the huge "hw/core/cpu.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240418192525.97451-4-philmd@linaro.org>
---
 include/hw/core/tcg-cpu-ops.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index dc1f16a977..9387d38748 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -10,7 +10,11 @@
 #ifndef TCG_CPU_OPS_H
 #define TCG_CPU_OPS_H
 
-#include "hw/core/cpu.h"
+#include "exec/breakpoint.h"
+#include "exec/hwaddr.h"
+#include "exec/memattrs.h"
+#include "exec/mmu-access-type.h"
+#include "exec/vaddr.h"
 
 struct TCGCPUOps {
     /**
-- 
2.41.0


