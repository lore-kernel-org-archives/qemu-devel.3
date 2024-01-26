Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255B5C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHF-0002HQ-4a; Fri, 26 Jan 2024 09:33:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHC-0002Eu-Ga
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:50 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHA-0007sf-FY
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:50 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33922d2cb92so650785f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279627; x=1706884427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PQlpwttdu93pWOUx8f8ZpRO+tP7SjE8rg5GEXBoZTSo=;
 b=seGSi7NnkrNRe7w71GD2OVmjB1BCv5HjLtsVd6FS85WtfafRWb01v+7W7HVgf3kgRj
 sOGHF7N+UiZ+jfl+mikfAib7i0FxzqP2xkBfAviMAf3HV3jbMp0m2upeTH71k5N54qkf
 Vg7SJBnPTsKrJRlPFWzGglqtgyvYmlmgwNp73w6ZhxDX4pRPyHL6yGGlTQGUUsnHWuMv
 XHwoO4LWsuKJJQw5r5Fh+2o7Ih/l3DQS7w2R9lWgxPBdbUU9pEDmU4C6VPKk/WjEJAJ8
 Yz75fCQ+QYQhqoEOAovg8zB6CsKii1FP9zA7yNcju6jK6QRZcHIXqhyJWUMlrcBSuiJ5
 KyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279627; x=1706884427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PQlpwttdu93pWOUx8f8ZpRO+tP7SjE8rg5GEXBoZTSo=;
 b=tmgaf6S93km5ZMVqcy/2BVPXjHZjVIP2MyskX69fwl3mwcgx/gF1UqqM3mUiNgcr+4
 EJJoJNybep0rUkGipFyh5b6WyT+C/1lLrUM+vkIPKPJfxd2hDHqfkfAuwtCRMeEcwGfe
 47BZuSaElsozRVMUQJkoxoYOzn+KJ1553d4Wimz1RfMeF0Y89ud6ywzY30lJqH9hxu0D
 CooChHRrFRUlLKgoGQte67/wCm45E9Fp7kX8RaHsrRjDIjlmki3xmrLiJvD76LPxZRFm
 BpGjLJjVsHooqWNw6Xp+phnTAHpKm6FWWq+UGk+OxRsApyOiihuvA1mV0CTwxByyDVNv
 sL4w==
X-Gm-Message-State: AOJu0Yzt+GLzOsecWHz9ccbXFmTa5/q9nP4oIO1JOb/rn1yKbLIvPnEh
 ihC1UUOoOZWQFKi+Q4lGzZvlL9LaGC5UfadQW4fjbTU4ZRv1gQNJB2Jy0rGXGOVOSkUwHJvzSD+
 l
X-Google-Smtp-Source: AGHT+IGuBCfmCEmJaHUcfVSPNBDGHt1VP1D8fr6a+qLf7wsrg+sWOuft+daQEJYCbDZC25qzk3/o3Q==
X-Received: by 2002:adf:eac9:0:b0:33a:ea1:538f with SMTP id
 o9-20020adfeac9000000b0033a0ea1538fmr736911wrn.121.1706279627192; 
 Fri, 26 Jan 2024 06:33:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/36] hw/arm/xilinx_zynq: Include missing 'exec/tswap.h' header
Date: Fri, 26 Jan 2024 14:33:16 +0000
Message-Id: <20240126143341.2101237-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

hw/arm/xilinx_zynq.c calls tswap32() which is declared
in "exec/tswap.h". Include it in order to avoid when
refactoring unrelated headers:

  hw/arm/xilinx_zynq.c:103:31: error: call to undeclared function 'tswap32';
  ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
          board_setup_blob[n] = tswap32(board_setup_blob[n]);
                                ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240118200643.29037-3-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xilinx_zynq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index dbb9793aa13..d4c817ecdc0 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -37,6 +37,7 @@
 #include "hw/qdev-clock.h"
 #include "sysemu/reset.h"
 #include "qom/object.h"
+#include "exec/tswap.h"
 
 #define TYPE_ZYNQ_MACHINE MACHINE_TYPE_NAME("xilinx-zynq-a9")
 OBJECT_DECLARE_SIMPLE_TYPE(ZynqMachineState, ZYNQ_MACHINE)
-- 
2.34.1


