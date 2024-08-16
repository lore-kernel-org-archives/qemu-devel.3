Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACC7C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 17:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf0Sz-0004bB-3i; Fri, 16 Aug 2024 13:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0Sx-0004V2-Qu
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:19 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0Ss-0007MJ-Il
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:19 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2d3bd8784d3so1629553a91.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723828208; x=1724433008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hX/4M8mloLpHNNVLuqmhPFzZ0yvCRxneReSS3A7I3Y0=;
 b=CU4vb4D0VvJ85llRfkSk3yv7+kRvsIhGim3vf7fzQOotop3FoBWI62bywtGBiPfFBW
 EEnGGxwVgMjIksrT3NTmXq4OmnqQxTSjYGA/R0j1KFqzVuLeWuXSIQXGvgZP1R4Pb4o+
 m7EIAlzNsULlaXLT+f25z0mPppB96nIobAx6eGDVikqLCKk+mTgKToQTqTAt4qSaPwnI
 5s0DGDJqyRYNKGh/PgefXRgZl+VnEntKNhHlbCd3W+WpgmVA+UNohcbSPIoadf6dlIID
 SQ/vhc8nRHoRIMoc6rzCq3vTRxf34dyb8TOdFkTNchTQRiDcl+1WM68UGE9kmd2usA8+
 V/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723828208; x=1724433008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hX/4M8mloLpHNNVLuqmhPFzZ0yvCRxneReSS3A7I3Y0=;
 b=nN8D6Ri33G2SwUI8TgFe5sBQlOCqrUttX7eid+QnRjopgwWt8sCB+fVhQgGOCitXYd
 4G2Pb4TTZhbAONYX+f1C5al34z/c8DRJ2mcIkUrCTzJWVKlUthDVN3PRtb7dn38EnHsK
 iiAbvFdtxme2KGHvs7F/zwOpOky1+JWmdeVd676fj1DOHDiLWthx9BInhSOODiYIYfcB
 34Oi8xGTwxPCh62I784IblHi3rZbmZGfKmZuyP6OdmJjGcHYgrUsIBwmyODKMeUSx4Ap
 jBzijMeIK/bKAWTg391NFRNkDpbcLIeNljB4+gwrvjxgkdDpQqUezv7K2E7nlA0reT2j
 Iw+Q==
X-Gm-Message-State: AOJu0Yxs2JoBb6FMQgsVvT1JPIUy9mYtDJeJzv5PZnrwmPZ/pt5t/fDa
 wWXnrFs2kd5YvxCkPFqdNJwRHy1CUvmNadtwHdX7pah8rrSOCNz0pGV5LLxzN+I=
X-Google-Smtp-Source: AGHT+IFm4Geu+WWMGM5ngKPRQGM7JJi+kVj8UUL11nVR2vBApTnJmiH08CJZ14ZGryzvZ0+p0H1rBg==
X-Received: by 2002:a17:90a:2e83:b0:2c9:6f5e:f5c1 with SMTP id
 98e67ed59e1d1-2d40556d190mr145615a91.10.1723828207626; 
 Fri, 16 Aug 2024 10:10:07 -0700 (PDT)
Received: from localhost.localdomain (121-45-122-195.tpgi.com.au.
 [121.45.122.195]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac7ca33dsm5988407a91.6.2024.08.16.10.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 10:10:07 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 03/17] bsd-user: Implement RISC-V CPU register cloning and
 reset functions
Date: Sat, 17 Aug 2024 03:09:35 +1000
Message-Id: <20240816170949.238511-4-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816170949.238511-1-itachis@FreeBSD.org>
References: <20240816170949.238511-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=itachis6234@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
---
 bsd-user/riscv/target_arch_cpu.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_cpu.h
index 5b436b2ac9..bdb527573b 100644
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
+    env->gpr[xA0] = 0; /* a0 */
+    env->gpr[xT0] = 0; /* t0 */
+}
+
+static inline void target_cpu_reset(CPUArchState *env)
+{
+}
+
 #endif /* TARGET_ARCH_CPU_H */
-- 
2.34.1


