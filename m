Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC741C52D7B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 00:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbUCl-0002Uv-N2; Tue, 06 Aug 2024 20:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUCj-0002TQ-QG
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:01 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUCh-00017J-Cm
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:01 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fc5296e214so11805415ad.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 17:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722989218; x=1723594018;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VJOhnSghwUlcGLtcqpB8a6GrX3vCsWVBjHp5kS9dbdk=;
 b=hoyPcePyiQYvgEykv7/QetK15hlDY1icg1GkSNxQa8HxEkQRvbYwqGVQRdqnV+2+MO
 wkJc496VXG78VfGFp1ImsNOxRK4RgSExhVTO7MSI/h3bVJMVemS8TgN4OTCGD1nClweT
 qlujvCLoUS2evjA0Z9cJyGXX7VByfg8ZSM0MKXVhj+xWr7HitfVBX74A7c8pfRiQINPu
 EX0EJeLey+UHkWeFglrQUAcPn6TEmtCQWQejTBH0kdRSZHIOEZWaf3o8oOen1S7OH9fo
 ULbTJzCZQZbxnm40Fut/f5SsGXnIK6lw2e/sWZ083GZlriJM5ByutGO7Wutz6hbvcTLj
 rLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722989218; x=1723594018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VJOhnSghwUlcGLtcqpB8a6GrX3vCsWVBjHp5kS9dbdk=;
 b=O5Cc2PCqElVr83hy0DXE+4Ht87SWga+zvP+Jol3OA6/zlWk+45G/WXBajnN2Rot/tR
 OISW7La1wDoAtqUNkeUHrp37X2GuLc6XcYsZjU8N1Uqy5aKM6jeIzDRetxbcxgUV1teE
 YJ7hRTAB8iqHkTYpb0Xl+d4jwSNsfhuJeKAyt47/pI2QmjTqKwhSxlM9ia4gZ5qgyG8k
 kCl8UIafAASyuT+0Fn6k/DM0aoh9CGTWt8Q7nkMIx+GIwSRexng37LLGGEGoVfdce6i3
 Us+nrFKj6btScs3QgyCFMP9I4ux2s0ztYj+WLwrBJlwrHfFs6JWm3CNrdb6tAbJTjZtm
 rrQA==
X-Gm-Message-State: AOJu0YxINn4LsA4SYVbG72yEdvcKBpGD/M/k6XGsvoHVZkx+w6syoIBn
 rFfLBa/AJiHwF0eHrSWexy/iph35cn6cQKKJVadWnahAOvkj6Va8prQNe7dUEJm7otinR0Dr0G+
 U
X-Google-Smtp-Source: AGHT+IHJlLbITAB4l/G2YSjELLMT8UcI2cKdNyRpE2Y6OwSM/+uuC2XMdFqdLfMhjCPrX9zstQqJSQ==
X-Received: by 2002:a17:902:f9c4:b0:1fd:6c5b:afd4 with SMTP id
 d9443c01a7336-1ff574e222amr176216145ad.64.1722989217732; 
 Tue, 06 Aug 2024 17:06:57 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f59cc2sm93381845ad.92.2024.08.06.17.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 17:06:57 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v3 01/20] accel/tcg: restrict assert on icount_enabled to
 qemu-system
Date: Tue,  6 Aug 2024 17:06:32 -0700
Message-ID: <20240807000652.1417776-2-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240807000652.1417776-1-debug@rivosinc.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

commit 16ad9788 [1] restricted icount to qemu-system only. Although
assert in `cpu_loop_exec_tb` is on `icount_enabled()` which is 0 when
its qemu-user and debug build starts asserting.
Move assert for qemu-system.

[1] - https://lists.gnu.org/archive/html/qemu-riscv/2024-01/msg00608.html

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 accel/tcg/cpu-exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 245fd6327d..8cc2a6104f 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -927,9 +927,9 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
         return;
     }
 
+#ifndef CONFIG_USER_ONLY
     /* Instruction counter expired.  */
     assert(icount_enabled());
-#ifndef CONFIG_USER_ONLY
     /* Ensure global icount has gone forward */
     icount_update(cpu);
     /* Refill decrementer and continue execution.  */
-- 
2.44.0


