Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5643AC3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLY-0005Ph-8X; Thu, 01 May 2025 02:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANL0-0005AI-48
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:02 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANKy-00073a-96
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:01 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso699095b3a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080638; x=1746685438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LuLpPX6X06+NE7HHzhZQmUoQgosCpwXTe/wCgu+rNqA=;
 b=xRppGn2PvpR3s5TI1q0plADjud20xl6Jb/HlKqMkt46rg+dcvFZT2Qe9DuAzd5wyKW
 aUgsysnYH+KA+YCjPsQObNDhJ4NoqumL1RN4ysuy4lo68sC36uGAjdohdNWEzRVCNArt
 S7sUkfFb1fM5+AVdFc1QAoc8PqYYUmEIiUUeegPzdBwumhv+ElYxRwH8BGCrkuWElYxt
 Wbyas5cFN5Y+IBPHu41yyYomborDqzMCWcYOY1KEUI7mg92GuR3hk2dR9A35iq3j+jYI
 ZvZjAvySsJZkPtIaqyByYlyidoHzgWMya9ojZIgwyfeOyslz4CuxHE92HREEb6WZNSUX
 BnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080638; x=1746685438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LuLpPX6X06+NE7HHzhZQmUoQgosCpwXTe/wCgu+rNqA=;
 b=EB9Nb+AkEBJTwYlMzPD2dr1zAcvnrI6AZnPYzNYbvMK+9M6CPS6igOsFxwTbaFTHZ8
 eEI1P3zPONm0GH6GyP6dPxy+xeanKd/0QDaArOGaXTKZMOHbWEklsc+ykwTab3oM4Lp4
 EPUw/u74cqReSmZ4CQZdeglE+U0uelI1omO4Z5htkkcnoinkLDIXZ//eOrWwyjOuiK6q
 H/KOF6Vb2ArmwUof9OIS08kFRu8b+SIQDdURHhiOlP+NDqujvpQyCQbnA6JN7e0+0I9G
 wIdACGj6l/G/NigwwrzimsJI0v2MTPeCgp6K8a1nlSc2wPiqasdCbmc+e/9ZiU5U3BdP
 jPPg==
X-Gm-Message-State: AOJu0Yy505GGqamHSV7QlQKJWdgWNLh5qjkC8I/2e0z1SOHAkq46DUbn
 9MLGJ7EqEQH0ey6UfC6N5xIN6LX2fzg4AgE6czyh3Uo0ncvgRxCuGwzwbb7DYIWgqRviXYsBAVX
 u
X-Gm-Gg: ASbGncsljqsGq/NpzZJFQtKZBm3XFq4JAtEFVcbhvs0zCtJY8A3WPd1I384uH5pk2b2
 9GEpkf0+2TDIwbQaKV1DwyipNYMPaL72PvqhKLDlw2yObNL2cMNJdCXwbZqWqNZvomshSe4NOUG
 y20aDgPsguKBSQWnsG3TWK9Bld0+kiZA6xqzY8GCSAPBBvfej54D+JYNNGzIimjEYeuDFeDO8NJ
 qBy4vHhqIOkNXGPrpx6V0X5Wdlu1wSnbdkcSoYenu3+i0oVqlp3llihbBzwwB1nmYFszI53Cf19
 5b3dQw6LMC/JLP8uG1kHBupV+ONsAAcXhuMCcMcG
X-Google-Smtp-Source: AGHT+IH613J6jBPOj6ZjFX3LRjtYIvyadYMSVvpnBOyMYotPgpUzTvOi4tNvNr+D57Mb3NRqdNtA3g==
X-Received: by 2002:a05:6a00:21c3:b0:736:2d84:74da with SMTP id
 d2e1a72fcca58-7403a77d3b8mr7327701b3a.10.1746080638522; 
 Wed, 30 Apr 2025 23:23:58 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:23:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 08/33] target/arm/cpu: remove TARGET_BIG_ENDIAN dependency
Date: Wed, 30 Apr 2025 23:23:19 -0700
Message-ID: <20250501062344.2526061-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 07f279fec8c..37b11e8866f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "exec/page-vary.h"
+#include "exec/tswap.h"
 #include "target/arm/idau.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
@@ -1172,7 +1173,7 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 
     info->endian = BFD_ENDIAN_LITTLE;
     if (bswap_code(sctlr_b)) {
-        info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
+        info->endian = target_big_endian() ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
     }
     info->flags &= ~INSN_ARM_BE32;
 #ifndef CONFIG_USER_ONLY
-- 
2.47.2


