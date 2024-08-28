Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D975DC63798
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 17:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjMlu-0006Ye-Q2; Wed, 28 Aug 2024 13:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjMlt-0006Wm-6J
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 13:47:53 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjMlp-0004PL-F4
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 13:47:52 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7cd9cfe4748so4778934a12.2
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 10:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724867267; x=1725472067;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7pauwM0+hP6l/++RwE00z55KwBTr5ElLKZY19bWfmTk=;
 b=wW2B92mKzDSPnqIg9wWjWnzcrr3Ek5BrO1cuVIoyc746VrnEISNHRQgA+9wKUhebOR
 fsiybfRry3PlAZYfcibm0h04a2DqeIYN5/HivXpisnU5mzBRklmZcO8FMYo7YG7rHxPn
 nK9p28hMKP7Y1GbTlw5d+2GcZHy3w0K/+acWcBPy2+hdk2P/7c4OdiB+0s1W87ELl779
 8na6wqdmpkGiixB7pQmkjoUJFFCSAYRDZlCXY71P8VY3lW0udeTxA8gBC6UK1ihW1cLJ
 xq6H0GIt9UOe2EklFNXx4HpmIvjAsEmntsxfLxU1d7YEFZfDUINV7iAxA6Aj22OQ48Iy
 +Y7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724867267; x=1725472067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7pauwM0+hP6l/++RwE00z55KwBTr5ElLKZY19bWfmTk=;
 b=oBRFtM86jDVogf4GAHlJeo14o/OCMx9FJTc8MZW6ctavoteXgXhRMgFlx9lDskOV1z
 RazBzRcDV7rTURa8U8ujObe8+NijkySeLF+Bbh1Z3LZBjtVlPlB1DK8lcbzMH3ocPeI8
 rTlQenHA9op54pPWvdMios5Ky3RIj2pW/gjag8EcgIzBU/7PUVSEyxLoUeFzkPt9M72e
 cKsQS5gDBa4XRab2V/3Q6qbBF5GrsSQjopT+k/F928Wo3jkQCdxsMsqC40mUC/jCUEFB
 jbAuEdaGVaypTmL+4QUvhWT1WHhBtNoH1AYCAOj4ahPwYHkvvuk8gSrxy+460OcuAY7g
 KK3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnjxpROAQCeNNJlhRYe26zmzGykHW7rrkR2GU3uJP6qU528wczWSkpobrwcWHVXIkC1Iz8SIOdRiO/@nongnu.org
X-Gm-Message-State: AOJu0YzUAGe1+PLsFFXV+l6nJ5c0SVflbIoZ21si+c4vWW3UR57PrtCj
 hVibHTP9Zqd9u/Uq1Jy+Fbpnyo/Bqn8Z3QoGAfxbiVNNVJCjlkdcx2ZEq+Roh34=
X-Google-Smtp-Source: AGHT+IGeXQGA/PHCq3dGzrIclVs6fQQmGOjlQf4vYP2vYW60lVUA6HNFLTc+ELGTL1JzMiKY451swg==
X-Received: by 2002:a05:6a20:2d07:b0:1cc:be79:92ca with SMTP id
 adf61e73a8af0-1cce0fed498mr85076637.5.1724867266961; 
 Wed, 28 Aug 2024 10:47:46 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7cd9acdcf7dsm9778316a12.50.2024.08.28.10.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 10:47:46 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v11 01/20] target/riscv: expose *envcfg csr and priv to
 qemu-user as well
Date: Wed, 28 Aug 2024 10:47:19 -0700
Message-ID: <20240828174739.714313-2-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240828174739.714313-1-debug@rivosinc.com>
References: <20240828174739.714313-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=debug@rivosinc.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Execution environment config CSR controlling user env and current
privilege state shouldn't be limited to qemu-system only. *envcfg
CSRs control enabling of features in next lesser mode. In some cases
bits *envcfg CSR can be lit up by kernel as part of kernel policy or
software (user app) can choose to opt-in by issuing a system call
(e.g. prctl). In case of qemu-user, it should be no different because
qemu is providing underlying execution environment facility and thus
either should provide some default value in *envcfg CSRs or react to
system calls (prctls) initiated from application. priv is set to PRV_U
and menvcfg/senvcfg set to 0 for qemu-user on reest.

`henvcfg` has been left for qemu-system only because it is not expected
that someone will use qemu-user where application is expected to have
hypervisor underneath which is controlling its execution environment. If
such a need arises then `henvcfg` could be exposed as well.

Relevant discussion:
https://lore.kernel.org/all/CAKmqyKOTVWPFep2msTQVdUmJErkH+bqCcKEQ4hAnyDFPdWKe0Q@mail.gmail.com/

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 5 +++++
 target/riscv/cpu.h | 9 +++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 33ef4eb795..c4ea1d4038 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1011,7 +1011,12 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     }
 
     pmp_unlock_entries(env);
+#else
+    env->priv = PRV_U;
+    env->senvcfg = 0;
+    env->menvcfg = 0;
 #endif
+
     env->xl = riscv_cpu_mxl(env);
     riscv_cpu_update_mask(env);
     cs->exception_index = RISCV_EXCP_NONE;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 87742047ce..270a2a031c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -226,8 +226,12 @@ struct CPUArchState {
     uint32_t elf_flags;
 #endif
 
-#ifndef CONFIG_USER_ONLY
     target_ulong priv;
+    /* CSRs for execution environment configuration */
+    uint64_t menvcfg;
+    target_ulong senvcfg;
+
+#ifndef CONFIG_USER_ONLY
     /* This contains QEMU specific information about the virt state. */
     bool virt_enabled;
     target_ulong geilen;
@@ -429,12 +433,9 @@ struct CPUArchState {
     target_ulong upmmask;
     target_ulong upmbase;
 
-    /* CSRs for execution environment configuration */
-    uint64_t menvcfg;
     uint64_t mstateen[SMSTATEEN_MAX_COUNT];
     uint64_t hstateen[SMSTATEEN_MAX_COUNT];
     uint64_t sstateen[SMSTATEEN_MAX_COUNT];
-    target_ulong senvcfg;
     uint64_t henvcfg;
 #endif
     target_ulong cur_pmmask;
-- 
2.44.0


