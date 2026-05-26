Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7B6CD5BD2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRoXv-0008Uz-EV; Tue, 26 May 2026 05:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRoXu-0008SI-Et
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:57:58 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRoXs-0000VB-Qn
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:57:58 -0400
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-48fde648a71so67818645e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779789475; x=1780394275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=okE4M75YzjDtywKE9rAcAkUOOM4qAq1H17UH1rYCeIw=;
 b=uVHeaSchWFEOesPAik0UiuowH/LWu+JgQjsms8rgBWhks+N0zhrCyF+RnbXE3+Iqtd
 4FrCBMkQKkoDrdrkcSD2kXR3TsijpQY+H9lHQWZoNiNXXEj/pWosq+BSc0TaAqQJMGVA
 S41t3bYAG3yldhO+QUJc50S5ery6MuiHCF3/92wGFNXSvnXJiEr6BEt8au6Q8aAsVLq1
 ClP7PLQBSJjomtmcbo1bLSV/q8sHg4vhDoShs02BS7nAdE0Ta/beyWsmKOP4IXWagsud
 jtbxuAhNNkedSpkBy1HleYwjgpgYIKwPA3VhLWuzm6nrsFIlPVIZ6DzkD/ATkhoj81tQ
 CMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779789475; x=1780394275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=okE4M75YzjDtywKE9rAcAkUOOM4qAq1H17UH1rYCeIw=;
 b=QfDkXUqG93llc2QIAHEIEkZzKLQFmTE7ktgeqxUi4jswZr0yju9M9B2jqKITs0flwU
 aKprsd9eBGNr1NQUfNdkH/5OWucaaza9NSkILBgUQpXIry3wamVeQXPls1+biFEzB/IT
 MuhKSdXViflZOdW7u6xbOU4afyuae1YYZO+bUpqKG2agmYNyxgZEK1qoC7766tP2GNNj
 twufCeZlG1JjqADSrFBcg1EZKEq7fMiN5jDhRpd/CVgvmMxCH3IETnNl5xTVUd5qj3m8
 99glC3UCQUSEnxWX9zILz1Cw347QcyeEW9JchUAfmKnE8NuBNBLxQU2yXLJ/jhtKN3JR
 OORg==
X-Gm-Message-State: AOJu0Yy2DCB5J1CxHjyvQ559SYg2L1v2jmP5H3DetaBTxJCNoUN6bI7x
 GXKGW3LCGkrPrHj9+lxg/TwxCkXHPr+CGYPdpLSHw9xiZoT1bn1LwJgkvNojMSxYXHuvolPVmQh
 Bk28CMosEAVzn
X-Gm-Gg: Acq92OF6I6l1jvIjoX7/jjzKv0wItYy/Sscq+x3EPuhRjHPl2PZmr1xhjvLN+m3h98k
 5pbNoTU+cJtLabPRF6L0Q/30+lD2E5ahyOeM9uK2zsVt3pPBcNjB6AwulJ5Fx9CMLKkiZP14ism
 QsgOApF7XOd867Da/FZRSAaYkVrrvGEvzIjbsqmBNPngwncTwLpunOyI4NrXqgtUmJh33s7ONzn
 zMQFnstwDJItYUQye7Z0BCeOFQFioWPTofJbxYld1fxdo8uNssRc9SPTrMc1dgWAwUYS/kRdeo8
 SxI7l45iTfSQGYIZNUHKvETk113UD1zi2t2RbVyu5LLlv+Gj/39Vhss02eSGEL6rTeouheoCMsJ
 OUJdPPag6jmcoffovy35U6CWD8xnI9PLluY8af4KKb3GYJ4OhyMGDzaoQcQehpjnHaTqkOakLDC
 feAbDuv9EuJqnr24zGmsRqWG9Ua7D2JrT98WGLTyKS3WO2lP11E3hvWA0=
X-Received: by 2002:a05:600c:3b08:b0:490:50ff:d394 with SMTP id
 5b1f17b1804b1-49050ffd4f7mr225810005e9.16.1779789475243; 
 Tue, 26 May 2026 02:57:55 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d4903bsm31719981f8f.21.2026.05.26.02.57.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 02:57:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 3/4] hw/riscv/microblaze-v: Use RV32I / RV64I CPU type by
 default
Date: Tue, 26 May 2026 11:57:30 +0200
Message-ID: <20260526095731.63525-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526095731.63525-1-philmd@linaro.org>
References: <20260526095731.63525-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

Per [*]:

  AMD MicroBlaze™ V processor Key Capabilities:

  - Configurable ISA support for RV32I and RV64I Base
    Integer Instruction Set

[*] https://www.amd.com/en/products/software/adaptive-socs-and-fpgas/microblaze-v.html

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/riscv/microblaze-v-generic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index b0494b1ac50..04a201dcd95 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -14,6 +14,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "target/riscv/cpu.h"
@@ -182,7 +183,8 @@ static void mb_v_generic_machine_init(MachineClass *mc)
     mc->init = mb_v_generic_init;
     mc->min_cpus = 1;
     mc->max_cpus = 1;
-    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
+    mc->default_cpu_type = target_riscv64() ? TYPE_RISCV_CPU_RV64I
+                                            : TYPE_RISCV_CPU_RV32I;
     mc->default_cpus = 1;
 }
 
-- 
2.53.0


