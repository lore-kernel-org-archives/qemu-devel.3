Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE1BEE644D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socR0-0006tB-1H; Thu, 12 Sep 2024 01:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socQV-0004KR-HX
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:31:32 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socQT-00036n-VL
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:31:31 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-71798a15ce5so1209263b3a.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119088; x=1726723888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qJALkI8HV3SBcr9TBDcg3UJ2jagYIjwgM/kVzVZonT8=;
 b=jACjA6K5UxpKhuOZmdr2teJoZ5M2RPf53Mr+TYvXf0dEQxCjsITZA9BMVCNcF/GKqi
 Kg9L1d3SgjW9pIVQyJOx5/W0ZzqTE7cEjeMM4SD5gdx4OdLJgK9p8zY/6ytzePfYCrqO
 7cTcmzDsKFbBa/LDbhlSyIuzsgY82aDLgWiwOF6v3ygiJqi9Xs/J5m5TtEFAkGUDMWVa
 OGS556tXqbE+QpkDhLfAtcUnkg4w6Cm13EiBOZ9E1npNAVhywFvsep6v9cs9sa9oDiOc
 /aSPCzNYd3Ve60a8N+I9FxNNErKW6eDZEgLuE/CX/fLd19bL4ISSDjKbQuZQgt5VUscz
 oJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119088; x=1726723888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qJALkI8HV3SBcr9TBDcg3UJ2jagYIjwgM/kVzVZonT8=;
 b=WBvlZZep50CN9krIrA8YHzeZrTOcJ5EamtXKwTTkVRlwQSrjfFdVWoY3lxEr0WcxOl
 5bDg3T4RSMLSYiXEYnbf9lPBiF+uBDOC4YxYlGGrbx3VmK612+J6WoJ4b/lLOS6cmi/t
 cEJXciFBL8bt9RurAJtvwJU9L1A7JqluyWeDnaRnroijTdm20/zAG2mFN//8FwpGwc6r
 EKVppdBTmwsz7JD7Yn3ZqdAs7MZSyN1l7YRU5GrX0Osl7QvTOQ0KEqKdNoKFriHqsd8m
 9axdSLyf5ZsEydyn7AQ0DFQUShq9pecXf80uGlfzOavGFMhdBxYM9E7K1eyLXWoiLvJk
 No4w==
X-Gm-Message-State: AOJu0YwQpoVExtRC3QBu/12NwJVShkBq5dgheXp+UjPAngrZ841qrnLz
 WZ3SNEgOXMDeSnZG1A/sBFCLlQfKSqucrtTN2yO0sL1jaCr7lzd7rHf2qQ==
X-Google-Smtp-Source: AGHT+IGdvC2c7mVFo+8JYHgrsqCC31/1y5aARZNbfvqJsaOvnEgf38NhRRcjhv5kr67guYLSzIVy4g==
X-Received: by 2002:a05:6a21:1190:b0:1cf:49a6:992a with SMTP id
 adf61e73a8af0-1cf758ddaacmr2710725637.21.1726119088373; 
 Wed, 11 Sep 2024 22:31:28 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:31:27 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 28/47] bsd-user: Implement RISC-V CPU register cloning and
 reset functions
Date: Thu, 12 Sep 2024 15:29:33 +1000
Message-ID: <20240912052953.2552501-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Mark Corbin <mark@dibsco.co.uk>

Added functions for cloning CPU registers and resetting the CPU state
for RISC-V architecture.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240907031927.1908-4-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 bsd-user/riscv/target_arch_cpu.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_cpu.h
index ea2a8d1ace..57abfbd556 100644
--- a/bsd-user/riscv/target_arch_cpu.h
+++ b/bsd-user/riscv/target_arch_cpu.h
@@ -130,4 +130,18 @@ static inline void target_cpu_loop(CPURISCVState *env)
     }
 }
 
+static inline void target_cpu_clone_regs(CPURISCVState *env, target_ulong newsp)
+{
+    if (newsp) {
+        env->gpr[xSP] = newsp;
+    }
+
+    env->gpr[xA0] = 0;
+    env->gpr[xT0] = 0;
+}
+
+static inline void target_cpu_reset(CPUArchState *env)
+{
+}
+
 #endif /* TARGET_ARCH_CPU_H */
-- 
2.46.0


