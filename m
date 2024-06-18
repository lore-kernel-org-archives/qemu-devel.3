Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D303C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbLb-0006gM-4r; Tue, 18 Jun 2024 12:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbLX-0006be-EU
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:06:11 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbLK-0007jj-VN
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:06:00 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52c7f7fdd24so6967927e87.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726756; x=1719331556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0/64oD6YGuylDgLtXH7Lbj+6VvSz1oEhiWnSPMdAPVU=;
 b=HhHcU31jtoze88KvXQobPGm56ZERIATDlciQoSUeAwxAir2KY4W3DM6ySO9zLrM8FG
 xQ7gCaJnV5gN2lk8p6D1rUbF41Js3YHFYcHOGpukqQdEZT2mpRIB6WtIXYVwgx9YKtiC
 2g5AMIKXA6SD8SxpzNstvtGbAfoEJdO+uWkyn3ka5SLZZoew0KwsCkGRdJsqekVlbsT7
 ArDNbrx0Ary7pbz6QNnhTDbYR8R15mi4XZJuw90d9v5wQeXn/HdhPqSf0UDTKB1ghlC9
 quk9fbOFWqB766DA2QsQOvdLUySxRYdWcojv4aeouK5an0N6VqJHnJVUiN43bRskNi9g
 H/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726756; x=1719331556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0/64oD6YGuylDgLtXH7Lbj+6VvSz1oEhiWnSPMdAPVU=;
 b=GjxAWsCWkOf8tmgEcrAdAYUABU2SyolbzZVqtSUmY2jAhHXhQF3NQUG08tQ34JOKzi
 fG3mba8p6dIBSF/Fyh4tFwBdNqbfscX1Vqv7ndYS38NGye8omP7D3v2Xm9WO0767dNBx
 0GDRgfT+HwL0YwCD0Lu3O+eIFxDD9JQklx/qnm12OXi8+fB4N3jXZPO9kIo4d3dWnceC
 zz9oW823nQ9EW2fBGtQHnGR5UnsjmSJ1E0FANqCeBHdmzhA9xkx3OEYdqb7t8zvIXNnW
 wZneN+noyEz09O97UArPaMjBHR1aNadKEMFSvBCKHKOeIm1pH3md9R6dvjdKLfxUd4l2
 vdew==
X-Gm-Message-State: AOJu0Yzxh6pCFIMiITvbwCHBlXw95XMTW0c8xdMb1QgdTrU2Qg6tCC9r
 nlm+wNfIEseE7un+XNjhKFiTm4vxGeEuFc2O2jjoAdugjFrkACnrr58Wa/I8oN0YTa0AFGDEYKX
 O
X-Google-Smtp-Source: AGHT+IHBXBTY6viwOoU8OhNCJ/fHbtWRmQQCfXfanA8mpfZo/0Zw3HCdz+V0j4tBBfJvQ5+YnnfLnA==
X-Received: by 2002:a05:6512:1152:b0:52c:8ddd:7beb with SMTP id
 2adb3069b0e04-52ccaa5879amr57074e87.6.1718726756569; 
 Tue, 18 Jun 2024 09:05:56 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4246b67f0aesm60973935e9.45.2024.06.18.09.05.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:05:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 54/76] target/arm: Set arm_v7m_tcg_ops cpu_exec_halt to
 arm_cpu_exec_halt()
Date: Tue, 18 Jun 2024 18:00:16 +0200
Message-ID: <20240618160039.36108-55-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In commit a96edb687e76 we set the cpu_exec_halt field of the
TCGCPUOps arm_tcg_ops to arm_cpu_exec_halt(), but we left the
arm_v7m_tcg_ops struct unchanged.  That isn't wrong, because for
M-profile FEAT_WFxT doesn't exist and the default handling for "no
cpu_exec_halt method" is correct, but it's perhaps a little
confusing.  We would also like to make setting the cpu_exec_halt
method mandatory.

Initialize arm_v7m_tcg_ops cpu_exec_halt to the same function we use
for A-profile.  (On M-profile we never set up the wfxt timer so there
is no change in behaviour here.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240603160933.1141717-2-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/internals.h   | 3 +++
 target/arm/cpu.c         | 2 +-
 target/arm/tcg/cpu-v7m.c | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 11b5da2562..e45ccd983e 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -364,6 +364,9 @@ void arm_restore_state_to_opc(CPUState *cs,
 
 #ifdef CONFIG_TCG
 void arm_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb);
+
+/* Our implementation of TCGCPUOps::cpu_exec_halt */
+bool arm_cpu_exec_halt(CPUState *cs);
 #endif /* CONFIG_TCG */
 
 typedef enum ARMFPRounding {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 35fa281f1b..948e904bd8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1133,7 +1133,7 @@ static bool arm_cpu_virtio_is_big_endian(CPUState *cs)
 }
 
 #ifdef CONFIG_TCG
-static bool arm_cpu_exec_halt(CPUState *cs)
+bool arm_cpu_exec_halt(CPUState *cs)
 {
     bool leave_halt = cpu_has_work(cs);
 
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index c059c681e9..5496f14dc1 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -244,6 +244,7 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
 #else
     .tlb_fill = arm_cpu_tlb_fill,
     .cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt,
+    .cpu_exec_halt = arm_cpu_exec_halt,
     .do_interrupt = arm_v7m_cpu_do_interrupt,
     .do_transaction_failed = arm_cpu_do_transaction_failed,
     .do_unaligned_access = arm_cpu_do_unaligned_access,
-- 
2.41.0


