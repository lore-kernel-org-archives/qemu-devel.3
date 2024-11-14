Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D32D637D6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 01:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBOQs-0007dV-4R; Wed, 13 Nov 2024 20:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOQq-0007bp-Du
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:14:00 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOQo-0001zO-RM
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:14:00 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4319399a411so965915e9.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 17:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731546837; x=1732151637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X3oqMeHT71R3KdP9eZWoYcjlbOfOwEShX9l191wOq00=;
 b=n4+c/Fvo2dTX3JgaWSwTpv64eiLSaVvaJWy5x1ch0LlFGH6lVN/T2LLpSPUEHm2vd3
 KULM1pv/8+TtEa4mheq2m/+QcoUPy78jZr3Gxg65p1UcwwKaEluP/yha0GtC8hdTRped
 +34trvYpmLM6Lrei/Zz9+D42M/xcKAkxTM72CnVg6ZC8FKBGmDTfyjp6iRAlUho1aSMC
 LB4GsQvr9NPKK2Qmsjt3HAM1Z9pnjgdFaGlcq77pWBqYrzcqoeuQ3xlDaTTTzaVjQUVx
 ue4o0hjUNgB23SOmv4Z0yR1LBt9AfmNm1vQtnuIASaIzOKuuDxc6BjGnByPHgKebmxny
 wLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731546837; x=1732151637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X3oqMeHT71R3KdP9eZWoYcjlbOfOwEShX9l191wOq00=;
 b=wl8FDGegvSJY5TO4IGCumR4FLCr3qLr649cldO+Iu0Ct0qrftJ/4o36LXppoJjSOXC
 xQkU3+KuaqTLHsVQ15+KRKvpPivRDI7iV1nkWWaA9+UKX4znnMhFTjUvsqNXHJVmFSvO
 ibgxwRgpFsyfzzvOfwoHjEpIcUgjzpsPp5wZ97hQfQiIX9OOjZ2fDNPLjaRjG+R5VhOP
 sDmtXODhcShY0AFhxjx5G8nrWu+tVET2m271j0wZgGMIINMrLNGhczwQPZUJXl6S4TC2
 1sfre/opF+C8oD5KLPVG7OC1D2g7UCehe1CDy5cq9J1gVo+cOWDu9bz4C/ioqEf3QT8v
 7I8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDBB8rHc8bCwigXfRSBPn5cXsiDya4O0a+K/2T9psT2BfjLeg4nh2WLXnivSeuQszJ2PyFgHmuFYVi@nongnu.org
X-Gm-Message-State: AOJu0Ywo0bouQZXpXgozEgROP0gdp1yK6RM10+HBoU3A70tQCpUZMvFl
 NA+SiqWRHvqhHCd0mCfQfmNvAtYzLL30tRxIABOpjsdsGgL3z8LCxOmsds5zpmw=
X-Google-Smtp-Source: AGHT+IFH/9CySRShC94nFw9UunKX2sRCoFuNlkS4DCoQU46r6V+s7M3YfRcJ8MxE5SjH5yjXwvy3Zg==
X-Received: by 2002:a05:600c:a384:b0:431:1868:417f with SMTP id
 5b1f17b1804b1-432d2730ce1mr69929325e9.17.1731546837008; 
 Wed, 13 Nov 2024 17:13:57 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.238])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac0aea8sm1385325e9.31.2024.11.13.17.13.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Nov 2024 17:13:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/24] accel/tcg: Include missing 'exec/translation-block.h'
 header
Date: Thu, 14 Nov 2024 02:12:49 +0100
Message-ID: <20241114011310.3615-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114011310.3615-1-philmd@linaro.org>
References: <20241114011310.3615-1-philmd@linaro.org>
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

TB compile flags are defined in "exec/translation-block.h".
Include it in order to avoid when refactoring:

  accel/tcg/tcg-accel-ops.c:62:36: error: use of undeclared identifier 'CF_CLUSTER_SHIFT'
     62 |     cflags = cpu->cluster_index << CF_CLUSTER_SHIFT;
        |                                    ^
  accel/tcg/tcg-accel-ops.c:64:26: error: use of undeclared identifier 'CF_PARALLEL'
     64 |     cflags |= parallel ? CF_PARALLEL : 0;
        |                          ^
  accel/tcg/tcg-accel-ops.c:65:34: error: use of undeclared identifier 'CF_USE_ICOUNT'
     65 |     cflags |= icount_enabled() ? CF_USE_ICOUNT : 0;
        |                                  ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 3c19e68a79..22486c5dff 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -35,6 +35,7 @@
 #include "exec/exec-all.h"
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
+#include "exec/translation-block.h"
 #include "gdbstub/enums.h"
 
 #include "hw/core/cpu.h"
-- 
2.45.2


