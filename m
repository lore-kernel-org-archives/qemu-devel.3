Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE712CAC5A7
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 07:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1KFM-0000tf-4C; Wed, 24 Sep 2025 03:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1v1KFA-0000rW-9k
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:48:52 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1v1KF6-0007de-8n
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:48:50 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-77716518125so3452453b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 00:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1758700124; x=1759304924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eb55lICRRwyizrb+ynSF6MmTdD+9/2j2YC45GQfIco0=;
 b=huT9JV1QfeZhIWjl6bqyT8tBWy4bHFacDBuh6mEHZrUQxlC56Th2J0QR2wztsuC3HK
 jm/SaDU4sumzH8HNV2ECk0GRK2kghhkw9+Dy3EAwXBRL2XXRInobP1yFfhOFs+c8k9MW
 kwRDvUgPdDZn0Gc5Dd2EKebVy+B83yBweGIErJ/7LmbMqx6UJrNNfQTlf93UU9FdC2t/
 o9cYRvnnVU/jY/k+McwSaRq22NbsKYOQid5VDrtjuDZmjpYQKdnNAdKEUcwp3tqc3sZv
 OG0ZxYff3wUeSvNSV5qkYGI6jjssz4Dg861VYt+ojLkTtHDuJbUga8UF5tmFndkAidBo
 XEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758700124; x=1759304924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eb55lICRRwyizrb+ynSF6MmTdD+9/2j2YC45GQfIco0=;
 b=B/EwdvxYDcKM7KlNlnTVVdBKKeAVYCWsaT4ej1AY3iLIIXxMzTKRjOdcf06oKRsC34
 ZfFAqJAorlaVOpCqlufCCMWOUTGIEeCnzGNPyrWjY8gcbEQ4MtkPqXTsj6xHXzuvzkmQ
 FUjoPjbEWpGauY35cv5wt6AlZavSMWPf1nzkZ7S9c8l9HMvjGCT/e05pz11vt+dggyYl
 Q7+SnTaTYbRZM/Pwk3Ojsr1L30230cNs7jyMITIoA/flcUwlgwu3EP74jST2/ZBOSoVg
 8Tt9F+jId4k1jYyeajnK5KLBzlg4zGuO/5L1/bOTVOSQFYH/FhOLHsb91cRGhsDEO08o
 UaYg==
X-Gm-Message-State: AOJu0Yw2NbvYC3gb/T/YxSw1C2ZLlAuRoFRoREMcuVlSdYbTOi3Ru32O
 PtWkYHdc/+E0aOVR9ulMjkNU6gfbov3JTrSOelMLTaOMvun13uodEQZ9erS4OwQN95cP6ntai84
 VvQQwT6GYCiW5MtIhc/TtUKzbob/E5WZiIU751epCPU/VTn+31PBo7MP8aDH9kK63uwTix/t6zE
 kG4G0m0o0RUG61CemT6TCibB8KvUKA7cdEFMWGJw==
X-Gm-Gg: ASbGncspEfiDTlFD9Cv9AGSoMbhEoQFQAJYdtMrXY2qowzpznXEBJoURJ97KPf3vOc5
 +NvkaBj/FZkAe4KqJsHCXFFuOoLQsf2Pxw04pdi085AnpwM9vkJVgRFCcyc8rpQIo//E3eQjUSg
 EBCW2xt4Sa6y+Vx2WzTlR2FhM0fLAbYqTdBFv8ffsxOfipZGN+TUSLPtKB/vy0jUW4Z63uLc7m1
 NlDJM8xIAnLF/ELaltAzFVA0YeD7DOfxAnN4l59omPGvtNvfqAB7wYTsUkhNOfumaJIqYeuDWQ2
 9IxSPMihtO+2TFKu3+CDQFYY0FggBkM99jUb9Nc84sTZ+W2yL0rzeTN4k45Uy9nOoq9ZHHo/omI
 2Lr81Gax/pJlpHjfzt2kA9ka6SgxnxEGOs9kKUyFaTLJ+
X-Google-Smtp-Source: AGHT+IGnzKxU10AMbfLST1qfylj0DTrLsvoSmcBWAaqYshPA2yR88f2r00biVnO8c4F2wOrEmYATtA==
X-Received: by 2002:a05:6a20:3d24:b0:262:c083:bb41 with SMTP id
 adf61e73a8af0-2cfde03e8b8mr6921745637.3.1758700124330; 
 Wed, 24 Sep 2025 00:48:44 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b5541f0374csm8778502a12.49.2025.09.24.00.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 00:48:43 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v1 2/3] target/riscv: Fix SSP CSR error handling in VU/VS mode
Date: Wed, 24 Sep 2025 15:48:17 +0800
Message-ID: <20250924074818.230010-3-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924074818.230010-1-jim.shu@sifive.com>
References: <20250924074818.230010-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x42f.google.com
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

In VU/VS mode, accessing $ssp CSR will trigger the virtual instruction
exception instead of illegal instruction exception if SSE is disabled
via xenvcfg CSRs.

This is from RISC-V CFI v1.0 spec ch2.2.4. Shadow Stack Pointer

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/csr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 8842e07a73..0299a214ef 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -204,6 +204,8 @@ static RISCVException cfi_ss(CPURISCVState *env, int csrno)
 #if !defined(CONFIG_USER_ONLY)
         if (env->debugger) {
             return RISCV_EXCP_NONE;
+        } else if (env->virt_enabled) {
+            return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
         }
 #endif
         return RISCV_EXCP_ILLEGAL_INST;
-- 
2.43.0


