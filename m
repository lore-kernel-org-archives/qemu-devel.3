Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F78C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 15:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYSNM-0007BO-FJ; Fri, 09 Feb 2024 10:01:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYSNE-0007Af-7R
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 10:01:04 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYSN9-0000Tj-Jj
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 10:01:03 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33b65b2e43eso434784f8f.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 07:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707490856; x=1708095656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3TQbFIKBrA58mD0J5hzum2Y6ObE019XfQgAO3Dz+7uI=;
 b=kjKI7qaVXL1JNbHNVRAQkCcPs3zewIaMbjgu50hhgQh+put+XibSMyBMMYXma63Llf
 phB8+Dz7L4tk82yxpgps8DOy8uUyBVoSfaG7AA6jgxCTxNEUiVdYnF673Mo98KQul70g
 blOY7ytU4MoUh01rN6EkmynXdZ4xW35IVyQPd8lEyIL2BRPSSl1Py8hsls7Oav0A9M4P
 FtnTOk6gjBiob1wAtuk0eqJeygs1l30tvcR9lpvN0z1mi+dTs1J1/XIZ1iBh0i5p2pph
 QTfuC0sBAj8+g7J0SLqWp0zzUd/Y3zOiU60wL4bKuoiDcq3DgktliGbui3ThWfBAaWHq
 sLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707490856; x=1708095656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3TQbFIKBrA58mD0J5hzum2Y6ObE019XfQgAO3Dz+7uI=;
 b=EUCbvuSiBuOrt6F65sXr8omtxSBlazlbyz9LjPDHI298lYxn1/wDOnuc0tYrlh8ekD
 VG/1gr0zv7czDy4CnFz0dzvB2UVgF0V5+wyCBqbwmEEygR5vl6flqTdLtOniGk2n+aE3
 TAGmISCQ2hk87+i2MsZIU5GjkMuUDlna5GrCDMM/mlYYfekcrZWdDMNLEcJd0ilpvXLq
 VDOLRSms2Fzu8352YfABGf7u6QKGWKGrP5ow9j9YnR4dxAvn57r9/1M1a+hp2jQVT2WO
 ljtZkCABu2lifQ4hNDKxmfaKuSqgoaHTb5QLoyB7dWePiCwGqPy8AmHhlLDiMM0bz0br
 DT2Q==
X-Gm-Message-State: AOJu0Yyjj/S+y0KYH3ZhBNGQdReKbJLsuU3Oo0dN01DqrQG7Hn0d0nbz
 1Y1noL52Xeyikicwo6WkJGgmqftvpdPUqS7NpQ27pLCuEkJmK73n0f9V9lGfs0gNe3c6368ag1/
 3
X-Google-Smtp-Source: AGHT+IGE58hrzoM/BZ0wVkojqhV/OprqYysCPEfJbvzcAe0ru/emhwlayDk4ZDK3F2FhAbhLRNfTaw==
X-Received: by 2002:adf:f6c7:0:b0:33b:183f:b194 with SMTP id
 y7-20020adff6c7000000b0033b183fb194mr1189391wrp.38.1707490856084; 
 Fri, 09 Feb 2024 07:00:56 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUEzHFdSgcsL5aUNJ6sEx57bh/NWSrPJt5Us8drIzBkFyGf02PM9uTiFMRwfWyPvOlAfVUUMjn1efLbjDYCGY4rzHe31488bytV7qD9LINMG3Pts7kcH29DXCeWDBuqUsqk7N/gTv/7vpYiWszNwodbO3KKvhnuf6h8QikuKbaZ17XI0DLZ2/MNof5wHRXx98QHJEI62U7PJFs56ufLSNc9IAK3fbMsW6bTFf59KaH+7ASa4OFz3YTdBL+kPGIL3AlwolMsDA2bo5r5CsEaK9dUcOP1TSsMfw==
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 bw17-20020a0560001f9100b0033b3b878bf6sm2037509wrb.89.2024.02.09.07.00.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 07:00:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, David Hildenbrand <david@redhat.com>
Subject: [PATCH 2/3] monitor/target: Include missing 'exec/memory.h' header
Date: Fri,  9 Feb 2024 16:00:38 +0100
Message-ID: <20240209150039.22211-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240209150039.22211-1-philmd@linaro.org>
References: <20240209150039.22211-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Include "exec/memory.h" in order to avoid:

  monitor/hmp-cmds-target.c:263:10: error: call to undeclared function 'memory_region_is_ram';
  ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      if (!memory_region_is_ram(mrs.mr) && !memory_region_is_romd(mrs.mr)) {
           ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 monitor/hmp-cmds-target.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index d9fbcac08d..9338ae8440 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "disas/disas.h"
 #include "exec/address-spaces.h"
+#include "exec/memory.h"
 #include "monitor/hmp-target.h"
 #include "monitor/monitor-internal.h"
 #include "qapi/error.h"
-- 
2.41.0


