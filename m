Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E25EC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOdG-00077v-UH; Fri, 09 Feb 2024 06:01:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOcC-0005gn-18
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:18 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOc6-0000Z4-2B
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:15 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e04fd5e05aso588560b3a.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476408; x=1708081208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M7SiNKu0SAKBEFVVG0KYvd/dpkNt9NxsveWdCiu00YQ=;
 b=U0rotmkRXBmfe4FhXG5Lgpk2K54cu6CTwvaPkG1+CZ9vjVKjdFqCYyxyNwxndZqWUm
 jJIprRQt7Q4bfxXlR19aKDwxc0UNMlHfRo2ME0D/YU3eZ06OeKcgiSoUSrfzX/5cQG/6
 hXBy0K8CHtyUZ1em001xh4GleEf7G3m0nUpgLg+83WpB9m+aDw8ZWPwHDMFCPNWugKM+
 j5I7O7nRJRliTifm5+EB9zHGLmqRg1qTgVCcOmSvLEXOdgTgFjb5TsMDXL5NM5AD39z5
 hZ0jSEMMcf4ueRmnfCQAGopO90EY6RRMtUdU8JDVHqYIs6xe8Xo1yOItD7SisVM561/z
 YAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476408; x=1708081208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M7SiNKu0SAKBEFVVG0KYvd/dpkNt9NxsveWdCiu00YQ=;
 b=nNyp81NC4hMS/DGeaGB8mYXa0mMOeuQxKSHBOWMgfGdj7L9lx7R4Dbg6gdX6xrffYg
 H7kHSoqy82YTsO8loBIxp3zyKu15KkJljAHbdSv+cv461twIshyXcG8UZB4C9kARrCyL
 z0L8FGGvOM5HzoDFutmlogCWoirlmJCKHJyMzi4wUDtnaJWvRMJ3SXRQdBKyWx1s4cR9
 CySQUuxGmuz/98w+e4Axogy0TMqb/XTM5A123/cJ0ZZnuh5guGpq+Dd4KY0oLjJP/4tb
 5SAzXYvs52gq4E55xF5a8FIm+fqwBtxrNp3jl2KsV0ZqkuKYBZmYzKS8QmjyLzhcBDXJ
 mwTQ==
X-Gm-Message-State: AOJu0Yz836wZNIvv7/i8KmVXmwtswB++tp32rvDClPj2Y6Lm2jDUKlxr
 9EXAuGgJkwYU85ggU2vAcvWKUXuXnygHiXfDCKJoTs4hMjtPpJoJBqPOTmn60A1Txg==
X-Google-Smtp-Source: AGHT+IEp0IRCOy3g6KE1HdSIjkeB9xkKPVXqvblcQrbQNkX02nA6Dttwg2DieQo1vWd4q8v+qFannQ==
X-Received: by 2002:a05:6a20:d90a:b0:19e:b532:6d15 with SMTP id
 jd10-20020a056a20d90a00b0019eb5326d15mr954308pzb.13.1707476407535; 
 Fri, 09 Feb 2024 03:00:07 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUbeKtBsZ5pCLXTbIXWGWNypkB0xuMdFTD3Fj/SlfQTVX7KO5KnTIa5XfeFGUnrpDND5MnV51pLjNgSCnICsBRkhd/sNuJ/Akeu8fdJi5RMCvKbfPEqGLqrD+cyFdmshUvtpa4=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:00:07 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 31/61] target/riscv/cpu.h: use 'vlenb' in vext_get_vlmax()
Date: Fri,  9 Feb 2024 20:57:43 +1000
Message-ID: <20240209105813.3590056-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Rename the existing 'sew' variable to 'vsew' for extra clarity.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240122161107.26737-11-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 20997b0886..1c5a363e4b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -690,9 +690,16 @@ static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *env)
  */
 static inline uint32_t vext_get_vlmax(RISCVCPU *cpu, target_ulong vtype)
 {
-    uint8_t sew = FIELD_EX64(vtype, VTYPE, VSEW);
+    uint8_t vsew = FIELD_EX64(vtype, VTYPE, VSEW);
     int8_t lmul = sextract32(FIELD_EX64(vtype, VTYPE, VLMUL), 0, 3);
-    return cpu->cfg.vlen >> (sew + 3 - lmul);
+    uint32_t vlen = cpu->cfg.vlenb << 3;
+
+    /*
+     * We need to use 'vlen' instead of 'vlenb' to
+     * preserve the '+ 3' in the formula. Otherwise
+     * we risk a negative shift if vsew < lmul.
+     */
+    return vlen >> (vsew + 3 - lmul);
 }
 
 void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
-- 
2.43.0


