Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B479C05023
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 19:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXPi-0000Bu-LN; Thu, 18 Apr 2024 15:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXOO-0007ef-BE
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:25:57 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXOI-0007H3-5l
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:25:51 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5194a4da476so1633759e87.3
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 12:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713468347; x=1714073147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qM1+ePV7JI08UmjLq5CXr5Pnp/lUDlPFaqkC073bDHw=;
 b=wezRyQWSZWKwxXifmcQF0z7lKN6y241aje35cbC9rX6PjqiAeOiL6fvOXfYzbrivwP
 0iqnvJKuzbpD4e0l3Qq5AQXY1poJryZQzbzVoV30r1hwGQYWMWOzZZqbNJSG4etVz4v8
 e4VjqYNCaRq4o5NJhv8Bbfp5u4Sso1E+lXOjuagJrKnpMaIKFEA+a+hHYQ6+P5uF4Lqb
 H7HGkCq6oMQ9lZqUPNRTzksIMmUNr2CMPbh4HsyN8cx0v849vZt62j8xV6Ae/p5RNqWt
 oVhoOVIl94RLa+MXZLYl111APRJQvYF1aHgWDhD+PId81B27EIoHo/RvPFNIetgh7/Kb
 w6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713468347; x=1714073147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qM1+ePV7JI08UmjLq5CXr5Pnp/lUDlPFaqkC073bDHw=;
 b=qmuDUN1v+qcMufn68Q607uIGOTVgDqXXir+VhIVGxwb/PGqPRKhlkVAMAcUiotXvGw
 ZGpyoRIjBJKBZ5bH7a8jOCv2mIVZq///rOqxftrPK/NG42mIoXpdUWCIrmcLIOBYJH+M
 4y1YKBrBGVCZserZ/M1mTGFGQZoIDWLW1+CrJzzLk1P30BMvzmj5vg4OqLIOduSLCpjr
 rh4s6fvY0ADn7Rm55OpGiEuyNpcHToA1IbBCVjHE35xQXqGbqkVxEYkMA0mTw+Df32Fw
 9V0P4WpAyKwzsD/SW5vgFpVlqtPNA5SnIovfR0DN6+rt7NydPlbuVg/xXkYCMqaseJ8/
 Onhg==
X-Gm-Message-State: AOJu0YxcsOFNqNkVmZCd6tFwCTnb5mUuUznHNWkczEaiNo3TJirozf8E
 r+7aLF+aZVvLR4H/r9Xgyfvts6kQcZDk/4IZorHzgk1hRsB2hGodSJiFYI6wgElIAOiTcg7U9rR
 w
X-Google-Smtp-Source: AGHT+IGbmgL9q5GYwqiriM3TxUUJmdVS5GsQvbF3Zc7lx0z/Cqw6N44I5tEaB6OpQn1vVifcnkd4Ww==
X-Received: by 2002:a19:f616:0:b0:518:d6ea:9f5d with SMTP id
 x22-20020a19f616000000b00518d6ea9f5dmr2755246lfe.42.1713468347556; 
 Thu, 18 Apr 2024 12:25:47 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 w23-20020a170907271700b00a556f2f18d6sm1195356ejk.57.2024.04.18.12.25.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Apr 2024 12:25:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/24] hw/core: Avoid including the full 'hw/core/cpu.h' in
 'tcg-cpu-ops.h'
Date: Thu, 18 Apr 2024 21:25:02 +0200
Message-ID: <20240418192525.97451-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240418192525.97451-1-philmd@linaro.org>
References: <20240418192525.97451-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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

Only include what is required, avoiding the full
CPUState API from the huge "hw/core/cpu.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


