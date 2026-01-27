Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C9ED2594B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 06:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkchl-0002lf-P9; Tue, 27 Jan 2026 01:37:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkchi-0002ko-MT
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:37:34 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkchh-0006gB-DR
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:37:34 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-34be2be4b7cso2842001a91.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 22:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769495852; x=1770100652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LRPOC/3+XMfcKObCsTL8Q0o11X+pdIr3Wyk3iUXtQg0=;
 b=nPsYea5GfB7R3UII2qKkK2F0z9I9R6TsiAZ0dazg4CQabW1eBhESeCfZpgEJp2h54U
 oRtX1TR8RNT0Eq8qVeWr2bxR2YiqtluqBlu1fur29KvSW/cfSSWvbms0AK5PtFn7ygcy
 OvbmtcKWaPuhmF9OhBrCj3ZhFVrYxYRkdPUql/pHf4vx1Up3GHXpziz0f3Ypbn6E+Fyh
 ZywrnHqYFpjM9YhcrmlEl3N4Hz+ytls/A5Z68inHxry27eTTXYu1EBHu9sgWBrMeAeDj
 cAuwTrat70dV72//W4+2cJPcY9FmcI9/KxnSDzM+gBcHUeS5KBcW+7K8yjuT6YSfnAvb
 sjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769495852; x=1770100652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LRPOC/3+XMfcKObCsTL8Q0o11X+pdIr3Wyk3iUXtQg0=;
 b=QKHc77GjsuXvtUiIcRvwBDe/QHU7ZU/XUjVL7OAPDXpml3f9+7UnL9Rn8YtZMuC5Q6
 DJcnxpqsM0DCHHRXBhra8lH6+vvsXOjSWIgNx0KFH4PNtBmgq1O5OB1863qyBT/LvxHu
 IWd0l8XMBy/bmCswf8+rlJMlGdfI9XLe3FrdZem4dA30VUHCu9SFB0d1NK5+Sfmffwi3
 Rxnk8Vw6plqfhkI15JpD6zrdWdO/vd+NDowq1cB3Ltydn9jP71i1kTdNHWGEXwiKzzym
 ddrgQ0cHxG1rqhM9wmSkUASQGeR+m3/8CDF0KKHgW+4Er7/EWHb7JEpjj4RIk0D1T9w4
 H7fg==
X-Gm-Message-State: AOJu0YzJhcuYKgF73IzcS0Ut5K18EeaQQAf0Aj2vgcNZn+JyjeHldhaa
 4XgrtXq+/m4q3v+qCo1j+lugeUvzKHeypbnEnPvnZ3fYY0T5x+aJ+u7qYVp0NmMqh64182EXO79
 V/tsD7/mZHM077QOhTiFOgEAAJtH2YZCNb5PUpA9aT7oP5ZGxW643jpIHmTxwFwcovM6HUBn+Ii
 4SRpbU1Uno4K3oglD0CFs+rIRiTi2/OX2xBgcAZPQ=
X-Gm-Gg: AZuq6aKQJEGY9ifTF3mQy8gDsVu8XGJCqbDawCXeyqqEj9x543hapGP5fd3+JuK0jKE
 m5QlhoCD3vXwHeePH7v8DNeWBtUQSubUkhUw3YB+6LZ4rHrxm7weJeR+Bh1S79S4lDcAPV8rLl0
 Y3QTvqzP4/lCH1qjlficHTLLDgiW/gjKxHa1F4zM7LAVI41S0AGHtywugEOfsGaK3dzGVub+fmq
 RuGU0a48Fwq0NMbd/wW2cXaoGt17ClB0EHScNZnVlZ+UJrCiFHiIRurqgthPtw0AYd6ePUnifno
 JrJpjjvxtMqJZ2n9Rs+aYKpADxzdddLiwO2DbvnrsLo3xenJa/98vBrJFdzMBs1qy7dCwwDBClR
 f4pHS8AYNS2S0ZGTqGalXzjgBT1ELCbY0ON8tQMIHR/3AofW6Un4sfZ1A0GWIRBliXQDsTikB9P
 AQTMxYxNCPmIDW24Wpkotl0W6pbna3vRFxBPjNxGdv//5idlHe7ek9tXgkCN2IpmWh1BfKHFHTk
 wC6ISwGQ5QfafQ=
X-Received: by 2002:a17:90b:2d83:b0:34e:5aa2:cf68 with SMTP id
 98e67ed59e1d1-353fed8a891mr723319a91.30.1769495851703; 
 Mon, 26 Jan 2026 22:37:31 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f5f96293sm1414175a91.0.2026.01.26.22.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 22:37:31 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 01/17] target/riscv: rvv: Fix NOP_UU_B vs2 width
Date: Tue, 27 Jan 2026 14:37:07 +0800
Message-ID: <20260127063723.442734-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127063723.442734-1-max.chou@sifive.com>
References: <20260127063723.442734-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1033.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/vector_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 5aea553814..ec0ea4c143 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4972,7 +4972,7 @@ GEN_VEXT_V_ENV(vfwcvtbf16_f_f_v, 4)
 
 /* Narrowing Floating-Point/Integer Type-Convert Instructions */
 /* (TD, T2, TX2) */
-#define NOP_UU_B uint8_t,  uint16_t, uint32_t
+#define NOP_UU_B uint8_t,  uint16_t, uint16_t
 #define NOP_UU_H uint16_t, uint32_t, uint32_t
 #define NOP_UU_W uint32_t, uint64_t, uint64_t
 /* vfncvt.xu.f.v vd, vs2, vm # Convert float to unsigned integer. */
-- 
2.52.0


