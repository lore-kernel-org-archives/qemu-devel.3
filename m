Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF23FC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 12:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kKJ-0002BS-2X; Tue, 29 Apr 2025 08:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kKF-00021g-L4
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:44:39 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kKB-0004Lh-Oz
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:44:37 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2295d78b45cso84197695ad.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 05:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745930674; x=1746535474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TOeCBxmoJl3fpGbBgDl7Mncm5lacwWUBmOxyjJ4Qi9g=;
 b=hAX9uZDuHbE1n9c7HGuhphuQuEcFp7EwqmKXIWYOx1Ao/UDOsFzqQ9J/umCOHCyDVf
 N0oFplVC+9/+Fp9ZIIKRdnPVCQAsDSeyP3eimKe4tjGbnSqqU8mAtY7vOSdaiv/nX/8h
 0imSJY5EdiLbl1p/ViCY6eyyyorGx3w4AkzvM/dlw3rv2XZNQsTNl1H/LZLBl8RArAPB
 b/VIexn6wfByoNo4jiyYOKQh3x+Luy8djU3m3DzmoWTwyFAlrfRa7fruom119UQnxW8g
 CRHsF/xFChNmkM49pu17jDKgtlQXny4MGbk7GR2Xyf7d6IyTI3Kh4b15SUwHgNd7x97M
 Nydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745930674; x=1746535474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TOeCBxmoJl3fpGbBgDl7Mncm5lacwWUBmOxyjJ4Qi9g=;
 b=M75iS9Y5N+GH88qlo1N4ipsFmYMVw2woTgy4VPBnTA/Zg4KtrIVgiZPgXYgbHTXKjm
 F9QgN3X0GbUsasifXccy2/S343GqHMYILu5kLgjSFYxtF20yiBwenOQ8f3pokolPz4lg
 nCRZQriq/aqtf9+Sluga+V+hIWugyUc6MC2ytzAUlwwhsBIK3PpBHtz5FGQ5otal+K2a
 H1jaS5OsoZAa9e+qd84z+CmvKUCVWDz/2rjDw4xjBmF6S+Ib1BZrLDfaQS+mlbbBH+vx
 FUQHQnhQGJFIL95XobIrJx4zjxhpf7LXkJM0y+6kMB0mvB9PlRJ1QqCfFLV6MgC70u/4
 3z5w==
X-Gm-Message-State: AOJu0YyS8QNJZD36XWS0aLSvfv0XDmDsfflzpJMF2RhRrS/ZFTQMsH1N
 KZqbDh+53BDvwcREa/KaXAWvb4e6HiHr2J5NuQX1JvcbNPNYHCz1X/TcDrjV4HVY3y1FDqQiV2q
 R
X-Gm-Gg: ASbGncvZVsxDvZcsS1tnJEPtthkTMjxefpufHjs+dkKfhgZW2UQO55GYpwOkwxXAJeO
 5K3dQvzQLZ84lq84Te/fn0Iz37e2n2NJ5zObC/V2F6ROIqULp79KCIkvfY2SFzuFk8xeDkJH/yL
 B3A7DDB/iHokO3F9Wnrqy13Azrz76ZctbM79PFqg+F1X474IeeeV3G/P71stwlOfrl3u3rMoe71
 /sP2ZQfdLNs5uQVorVponp27g5kwnrZtqXoqIaK9NrUDqBYGZPkyOIDpsTN8Atijckc2eJf0bOV
 CtN31sUy1akSG4XxDoZY5KHOO+S9uBipgkpUp02qSQo=
X-Google-Smtp-Source: AGHT+IG0kV+b/9mbeBsZ6EulQJW96YRtgdh0hbcUnanb8I/4a3Ck5d/RiB5XnBEm3PcRdoYrtZULOA==
X-Received: by 2002:a17:902:d485:b0:224:1609:a74a with SMTP id
 d9443c01a7336-22dc6a6851emr189852765ad.34.1745930673749; 
 Tue, 29 Apr 2025 05:44:33 -0700 (PDT)
Received: from grind.. ([152.234.125.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309ef04ba89sm11001161a91.10.2025.04.29.05.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 05:44:33 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 3/9] target/riscv/kvm: turn u32/u64 reg functions into
 macros
Date: Tue, 29 Apr 2025 09:44:15 -0300
Message-ID: <20250429124421.223883-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429124421.223883-1-dbarboza@ventanamicro.com>
References: <20250429124421.223883-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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

This change is motivated by a future change w.r.t CSRs management. We
want to handle them the same way as KVM extensions, i.e. a static array
with KVMCPUConfig objs that will be read/write during init and so on.
But to do that properly we must be able to declare a static array that
hold KVM regs.

C does not allow to init static arrays and use functions as
initializers, e.g. we can't do:

.kvm_reg_id = kvm_riscv_reg_id_ulong(...)

When instantiating the array. We can do that with macros though, so our
goal is turn kvm_riscv_reg_ulong() in a macro. It is cleaner to turn
every other reg_id_*() function in macros, and ulong will end up using
the macros for u32 and u64, so we'll start with them.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 6ba122f360..c91ecdfe59 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -58,6 +58,12 @@ void riscv_kvm_aplic_request(void *opaque, int irq, int level)
 
 static bool cap_has_mp_state;
 
+#define KVM_RISCV_REG_ID_U32(type, idx) (KVM_REG_RISCV | KVM_REG_SIZE_U32 | \
+                                         type | idx)
+
+#define KVM_RISCV_REG_ID_U64(type, idx) (KVM_REG_RISCV | KVM_REG_SIZE_U64 | \
+                                         type | idx)
+
 static uint64_t kvm_riscv_reg_id_ulong(CPURISCVState *env, uint64_t type,
                                  uint64_t idx)
 {
@@ -76,16 +82,6 @@ static uint64_t kvm_riscv_reg_id_ulong(CPURISCVState *env, uint64_t type,
     return id;
 }
 
-static uint64_t kvm_riscv_reg_id_u32(uint64_t type, uint64_t idx)
-{
-    return KVM_REG_RISCV | KVM_REG_SIZE_U32 | type | idx;
-}
-
-static uint64_t kvm_riscv_reg_id_u64(uint64_t type, uint64_t idx)
-{
-    return KVM_REG_RISCV | KVM_REG_SIZE_U64 | type | idx;
-}
-
 static uint64_t kvm_encode_reg_size_id(uint64_t id, size_t size_b)
 {
     uint64_t size_ctz = __builtin_ctz(size_b);
@@ -119,12 +115,12 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
     kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG, \
                            KVM_REG_RISCV_CONFIG_REG(name))
 
-#define RISCV_TIMER_REG(name)  kvm_riscv_reg_id_u64(KVM_REG_RISCV_TIMER, \
+#define RISCV_TIMER_REG(name)  KVM_RISCV_REG_ID_U64(KVM_REG_RISCV_TIMER, \
                  KVM_REG_RISCV_TIMER_REG(name))
 
-#define RISCV_FP_F_REG(idx)  kvm_riscv_reg_id_u32(KVM_REG_RISCV_FP_F, idx)
+#define RISCV_FP_F_REG(idx)  KVM_RISCV_REG_ID_U32(KVM_REG_RISCV_FP_F, idx)
 
-#define RISCV_FP_D_REG(idx)  kvm_riscv_reg_id_u64(KVM_REG_RISCV_FP_D, idx)
+#define RISCV_FP_D_REG(idx)  KVM_RISCV_REG_ID_U64(KVM_REG_RISCV_FP_D, idx)
 
 #define RISCV_VECTOR_CSR_REG(env, name) \
     kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_VECTOR, \
-- 
2.49.0


