Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EE2C36017
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 10:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzYwz-0008TN-Vg; Tue, 01 Apr 2025 06:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1tzYwk-0008S3-0L
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 06:34:25 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1tzYwh-0003q5-G0
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 06:34:17 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22423adf751so99147705ad.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 03:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1743503651; x=1744108451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0edgTYoWHKRu92ltgEpm8dVjfH0ldEKXvt5V/yx46BU=;
 b=hIIbjz1jl9SQvI6EMwEYhsy8vF13aBvzcn8zelPUEi12TxFfo36ttXT4gvBFHsySXU
 TETWX0lZLhBE0Rrb/XZUaPPS0AeQJHzzfzuCA3lDcecPZDM/nME/VGaMLJHJY8unT6zH
 NlpKM4hY22oo72QWxK3vveoGPKqU4S+dBz7bbGabHFb05gTPzJ/B7zDCZjGJeqPWk6CP
 24rQ5OIUe783OT8xv0GYGXhoXX1z33xL1VXtwx5fxqxnWvLtaRBxs45/D+7Hyhn/h66P
 96EUOeh2bN/KL3zjjmwk7LFiIfreiGXbR8+C6CmX27eaIDgOxkSSCNnwp0GR7r36tHht
 BuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743503651; x=1744108451;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0edgTYoWHKRu92ltgEpm8dVjfH0ldEKXvt5V/yx46BU=;
 b=sAbkfU3NrId8KgOPeYxG8pFZoiHLzhfsweWAbLplAg7EHbe1KZdx4GY0FuZq8jt0xA
 L7uJHxIlfAJJsHy89ZS/9WxyWdwlzyrAFIPrxT3TBjJwLxBeK7lIFhR1MIl4URwSgTV5
 Ugpsfr8Cx3kFmGxA72D8njbtrAn9DTkIMJiWvqrdhsm+RbBpJEX2S8oXFwK5ZVs6Jxk1
 TvJTiQUnBtnqohpQQT1nYwVXc0MdLZwGjXufE9dOUwUB7z1aNs7XolgFY79YA0sZ1bZl
 DGf7REnKISJiZCg1hff1pWnKa2i93g4oOhHQEAANgK0dex48Cq7do8hUrTUxTS63LCvI
 x8yA==
X-Gm-Message-State: AOJu0Yys+lgOtK0490cbctT1Mo9+FMslwgHISRJ/0XZNEMyyyfeR3rWk
 8Aq2gd2TYpRmZogxtpuHaszCnlqKztugfqk8e8CHOEsxIhPEmc2UojsSLQqycyOhSN8uWDtucEb
 aYL19qVgo/qtm8n7SW++f83fxwD3gj4sFLlxqPjRzJz2yE3HgusU2KfDFxqjXjG7stDzd1ijtgl
 KpKghbCwa4bxpi6r4Edg8zhcTfktMUuRSaoOQT
X-Gm-Gg: ASbGncuPWumPbHvnecq9LvaBPJLKGOIFdxJ9tBg3zsI8WwI74+/zqhk6Dq5revQRw70
 UPR40J2DMK/fwfn28QTU/FbT3E3td3bQMOifz9MCeoo55SY4shJ9y2dXKtOFGN8Fnvb+btNKHLx
 kt1fs/CzTc0XBJBZfeYY6xFk6UEpJWhRU9yCxnXxgk2O9ASwnJaz89BPwDqMXaFWUvOCnIAYjmj
 SRmYNPC3bowiM2Ub13P8hjDx55Vp2TspbOZDHo222NaPOCj5+YFxqjuwh8B/DMjUVV40BgzN526
 m0e3IbJXoPysRqBFdKke1t6MUIYg0GdPczeMboVVwFVi7w7eAVrldZXsU2zHYXXg2+D0aCao7qb
 Wzz7ZmYaL4MBqtwXZfA8=
X-Google-Smtp-Source: AGHT+IFx73hADwyBHytLjOTTwy5RRB6FDicjyUgmPVy7yswo23nRaMQ52Ur3vBtT93/iLrCXlw1EaA==
X-Received: by 2002:a17:902:e54e:b0:21a:8300:b9ce with SMTP id
 d9443c01a7336-2295c12e596mr40803515ad.49.1743503651219; 
 Tue, 01 Apr 2025 03:34:11 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1ded6asm85211795ad.184.2025.04.01.03.34.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 03:34:10 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v2 1/2] target/riscv: Restrict mideleg/medeleg/medelegh access
 to S-mode harts
Date: Tue,  1 Apr 2025 18:33:43 +0800
Message-ID: <20250401103344.84257-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=jay.chang@sifive.com; helo=mail-pl1-x630.google.com
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

RISC-V Privileged Spec states:
"In harts with S-mode, the medeleg and mideleg registers must exist, and
setting a bit in medeleg or mideleg will delegate the corresponding trap
, when occurring in S-mode or U-mode, to the S-mode trap handler. In
harts without S-mode, the medeleg and mideleg registers should not
exist."

Add smode predicate to ensure these CSRs are only accessible when S-mode
is supported.

Reviewed-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Jay Chang <jay.chang@sifive.com>
---
 target/riscv/csr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 7948188356..975d6e307f 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5783,8 +5783,8 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
                           NULL,                read_mstatus_i128           },
     [CSR_MISA]        = { "misa",       any,   read_misa,    write_misa,
                           NULL,                read_misa_i128              },
-    [CSR_MIDELEG]     = { "mideleg",    any,   NULL, NULL,   rmw_mideleg   },
-    [CSR_MEDELEG]     = { "medeleg",    any,   read_medeleg, write_medeleg },
+    [CSR_MIDELEG]     = { "mideleg",    smode,   NULL, NULL,   rmw_mideleg   },
+    [CSR_MEDELEG]     = { "medeleg",    smode,   read_medeleg, write_medeleg },
     [CSR_MIE]         = { "mie",        any,   NULL, NULL,   rmw_mie       },
     [CSR_MTVEC]       = { "mtvec",      any,   read_mtvec,   write_mtvec   },
     [CSR_MCOUNTEREN]  = { "mcounteren", umode, read_mcounteren,
@@ -5792,7 +5792,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
 
     [CSR_MSTATUSH]    = { "mstatush",   any32, read_mstatush,
                           write_mstatush                                   },
-    [CSR_MEDELEGH]    = { "medelegh",   any32, read_zero, write_ignore,
+    [CSR_MEDELEGH]    = { "medelegh",   smode32, read_zero, write_ignore,
                           .min_priv_ver = PRIV_VERSION_1_13_0              },
     [CSR_HEDELEGH]    = { "hedelegh",   hmode32, read_hedelegh, write_hedelegh,
                           .min_priv_ver = PRIV_VERSION_1_13_0              },
-- 
2.48.1


