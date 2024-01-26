Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFD1C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHF-0002Hz-Eu; Fri, 26 Jan 2024 09:33:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHD-0002F8-22
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:51 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHB-0007t7-De
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:50 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3394dc75eadso451919f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279628; x=1706884428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SayjVZreUIIZvwgWfW2preOvFMoE7PMcRfYHzIZ+5wg=;
 b=AJ4+1TzMLsSYIAejsV+VIv9vMqf2ZvMb6Tz4ejpGJi29/RNJ4I67/oAMxFtx09C+eY
 oAYF6ODr/oDbEqnBI/6sz7q8mvGjTP9Xu40MKb3qgDpc5ECk9wEDQKNCvSRHKcRywS/6
 tHEmKHLl8FwhNe7bpnsVCQ3NZu7yeN3Hb0sCx9D1mMkiNyB44oSHvNSkDYyFBuk0KoVz
 4XgVH1m3U5CxHAAE1FCO8wILM022HVpacJkmd19nefPvt9vJRg42LDJyXV7yf6Q1sHXS
 ski9BWrNPSKymCsEqa8/f3Xk8/TJhdWITBqthv5XM8o/W60lMhCArUHwST1jtw67845w
 34AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279628; x=1706884428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SayjVZreUIIZvwgWfW2preOvFMoE7PMcRfYHzIZ+5wg=;
 b=Y1ePOvkYK9VY9xyHFZfvpfVPQOPmLTqbv3fQIB1Jei50Zp7z0b4eEG6N/CeYc76AK0
 BCLweqqxNW3U1QLZa2llTGDsgxFn7umLFKTM7pa2UNLMHFbal8NrxD+GwmKSZzpBSLja
 PiwOQDvVWOINpGDN+3cSK+IFquuRB3DxW5VbPla/4/lQtpkrF/xEc/6WHZgiOFfoAgFy
 4DN+yr/xC65zbnubstK8y0sMVmTRABuzF59KDHgCViEJ8uPDUAVZvtjzBkzvCeiNhx6t
 NjmWITAAYXs6h+PI6mlGZnGR905O3VjZNmz6YXwHvPSB+Wzyo2okdWdEMfUIn4HAzqqo
 tyCA==
X-Gm-Message-State: AOJu0Yy7ESb/MJLVf6/Qg/9A76Bolq9b+dyJCYect9Y5NpRSTa8wnLJl
 yF6LrDHFup/ly6CayE3TCcvSyXW2kBX0MHliHSxLBRLdSObeOTrn+48zWtLqH0esCZAKHVyBUAi
 j
X-Google-Smtp-Source: AGHT+IH38csVYwjKhtQbIj15R9ZNILBM9iRhfOcaZr5ANC3f2NvcK/INsCNOYmibZDQojnTVsrawqg==
X-Received: by 2002:adf:a199:0:b0:337:cab8:b7e1 with SMTP id
 u25-20020adfa199000000b00337cab8b7e1mr1028565wru.81.1706279627975; 
 Fri, 26 Jan 2024 06:33:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/36] hw/arm/xlnx-versal: Include missing 'cpu.h' header
Date: Fri, 26 Jan 2024 14:33:18 +0000
Message-Id: <20240126143341.2101237-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

include/hw/arm/xlnx-versal.h uses the ARMCPU structure which
is defined in the "target/arm/cpu.h" header. Include it in
order to avoid when refactoring unrelated headers:

  In file included from hw/arm/xlnx-versal-virt.c:20:
  include/hw/arm/xlnx-versal.h:62:23: error: array has incomplete element type 'ARMCPU' (aka 'struct ArchCPU')
              ARMCPU cpu[XLNX_VERSAL_NR_ACPUS];
                        ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240118200643.29037-5-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index b24fa64557f..025beb5532d 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -34,6 +34,7 @@
 #include "hw/net/xlnx-versal-canfd.h"
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
+#include "target/arm/cpu.h"
 
 #define TYPE_XLNX_VERSAL "xlnx-versal"
 OBJECT_DECLARE_SIMPLE_TYPE(Versal, XLNX_VERSAL)
-- 
2.34.1


