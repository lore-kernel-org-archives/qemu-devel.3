Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDB1E68949
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MGl-0000ht-EU; Wed, 30 Oct 2024 23:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MGj-0000Zg-LE
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:54:45 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MGh-0003zY-FI
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:54:44 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20ca388d242so5282965ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346882; x=1730951682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/PW3fIgA/mqOmh+ReEA9cKJU38Sv2BOJ1Nhu0vSIdE=;
 b=AbgjLVBzpCx3QWPeSGF0gC6gSUr/IRSo76NX5bFskTjyb9EYeHR43qHBMm8RevtTYM
 qr8yGLnKmkQQy4aNTHWy6otiQYbCNNZnMkxOqqnAOlc59kBBqA/sJ/iyTIvep58RVz7A
 xLMqhrR0QF41IY7splui8vQ2z3NU+RMObEA+YZV6KZPFT5bpNmHUfYVnHQk44cs76QZm
 0lRf8pRvgt56+fjkt702rBz0YyHiGQ/ykX8sHPIKh5+Blgb9jkEM7/KC21xptf65Sth9
 7Bu/5nKakvOn1ulfaAKVHotn/3L+bJTM8+obydflUDd1JVrYQRbQB6iM346tnY55TuhC
 KbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346882; x=1730951682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y/PW3fIgA/mqOmh+ReEA9cKJU38Sv2BOJ1Nhu0vSIdE=;
 b=tct/GKp61ybPRwwgS+ZgE/sjX3tDOZEAN/zsjTVLjFNHTTir7GyP2msgz9VRasyFsk
 QRtfABRPC/Qn99ACInvC8aDjTHPDtSuOnVL/iKUmXylNGh7YsbQ2iC0t2lM2FXAzGVX2
 T8en2YioNHZWKmVLpjaD6q8JF6xzU5gR4yyXBTvkSNkwPJ6ZpmBWBR0rPXNjU3ya4NZ5
 6aRyg5asJKvPt4QnDUv3DWfNM+sSLdAhxeX/ZaytraY8qFLvMIt3/bWOZd8eB4sWPQqb
 Bcaa9NYaEktLvU5XIL0GHJ72E1FY9l9fZfL97IG16QgeipSvtAJh7wGYL02DugKgQfxg
 zVSQ==
X-Gm-Message-State: AOJu0YzGoJBgnUzTZTXP4olDIkzBUx0e4OqdY5VHrlYfIKnezCqKsPNV
 +SFuRhSRYqu09xcJiFaHNdfyzxYo48M16Nflz4Y0JH8JBzi9yFYx65s44pOQ
X-Google-Smtp-Source: AGHT+IHaxgxfgvls7zkz/qG68uKDUBfI+DfSN2B2A3in9fv85T6QjQk1qUvGg/f0JWfBlMWOSNnfvQ==
X-Received: by 2002:a17:902:dace:b0:20b:a41f:6e48 with SMTP id
 d9443c01a7336-210c69ed062mr245348585ad.27.1730346881977; 
 Wed, 30 Oct 2024 20:54:41 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.54.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:54:41 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 24/50] target/riscv: Expose zicfilp extension as a cpu property
Date: Thu, 31 Oct 2024 13:52:52 +1000
Message-ID: <20241031035319.731906-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

From: Deepak Gupta <debug@rivosinc.com>

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241008225010.1861630-10-debug@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 27fbbd11b9..ee6646848b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1471,6 +1471,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
     MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
+    MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
-- 
2.47.0


