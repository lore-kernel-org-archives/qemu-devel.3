Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91F7E6894E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MGW-0008Dj-9W; Wed, 30 Oct 2024 23:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MGV-00088q-9Y
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:54:31 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MGT-0003yJ-OY
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:54:31 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20cf6eea3c0so4688275ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346868; x=1730951668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+T1/qmTRYfbLgasuElLQo88//CQU/xJLxY5iXRbEKPI=;
 b=OKH5j+LJhBbwIh0Xk99SmeJivg0/6GDcw0etrhCgfppUBS87gdZeBMCgMZnZm5ZqUv
 VIZBLXyy2DnDMJoBD3UCGEqlXqQb6Nbn7BtYQKxuOoMgFOjdJLMIvFB0MDmY6uM+ArnU
 NBWGwg06WIlksH5OUA0nMPQ12vqHcRHlmKGtRGoQXo0mqEJ1f6WPhXsz3KP3Up0Tuly3
 /E5Id68Tpgrj5mWuHrYTUK98PZ7eEcwwhwVWmGVTfxhhRWmzGxrYfsyr7kAGJXJ6Nv5X
 QirwPZtrvvzLEg8Lpp0VTAC6XNWWfwA+L5xqdAGvZEjuukQ6R4TKHFTLX9WIUI77GxTC
 j1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346868; x=1730951668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+T1/qmTRYfbLgasuElLQo88//CQU/xJLxY5iXRbEKPI=;
 b=d9v8D58EuM2E57UYBWE9N3I1g19uNkkNQWJ4BP+UizvMvdnWSz1MZxnpaKMgUFQnOE
 8o4cogG8XvFd31YO8dAulnzO56bX53bRvBthBh6qcX1foVrxk/4DLzJDYzbmDNCE8FiC
 1uQVh8v2Fm8v2OknkMnnTlkgaYkZ18e+ccjjF6m/aI1dTHm5vRV/2IKIJuUwYtsLIkv/
 jJAgrF2BOrcLWt2W4AoyBFlmpbzSWNjyLhHV9Oqb+Iph2zbPXtKhKrRjXJxZ1QVCyCA4
 z+OmRyVNYUVnlVNS+5dnRuH5JMzm2Iv+wJAARTluztMiLL/i+85acGMGSUGPCURA8Q0y
 Y2YQ==
X-Gm-Message-State: AOJu0YwrHhPp/aW0VaQIbyFSwTcCGEvYyADMFmXB4rTkKDAllFFQJD02
 dqHWZ9ougulzOPmGOALK7aferMM1C6HOseGCMGFd61usJru2TFeash5WpRgV
X-Google-Smtp-Source: AGHT+IEePDL7jlW7H8Q/DfPdXG0bV7AITCggT+JesQvJ6XeKIkcZoEkca7pI/LMvlHw73rABVtU8cw==
X-Received: by 2002:a17:903:2309:b0:20c:5e86:9b5e with SMTP id
 d9443c01a7336-210c687399amr216572905ad.3.1730346868310; 
 Wed, 30 Oct 2024 20:54:28 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:54:27 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 20/50] target/riscv: additional code information for sw check
Date: Thu, 31 Oct 2024 13:52:48 +1000
Message-ID: <20241031035319.731906-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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

sw check exception support was recently added. This patch further augments
sw check exception by providing support for additional code which is
provided in *tval. Adds `sw_check_code` field in cpuarchstate. Whenever
sw check exception is raised *tval gets the value deposited in
`sw_check_code`.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241008225010.1861630-6-debug@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        | 2 ++
 target/riscv/cpu_helper.c | 3 +++
 target/riscv/csr.c        | 1 +
 3 files changed, 6 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 2170792ad7..67ce6e0a03 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -232,6 +232,8 @@ struct CPUArchState {
 
     /* elp state for zicfilp extension */
     bool      elp;
+    /* sw check code for sw check exception */
+    target_ulong sw_check_code;
 #ifdef CONFIG_USER_ONLY
     uint32_t elf_flags;
 #endif
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 62f455dbd3..fa4982e940 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1775,6 +1775,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                 cs->watchpoint_hit = NULL;
             }
             break;
+        case RISCV_EXCP_SW_CHECK:
+            tval = env->sw_check_code;
+            break;
         default:
             break;
         }
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 02bcb8a23a..ec1e2af72d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1377,6 +1377,7 @@ static const uint64_t all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS |
                          (1ULL << (RISCV_EXCP_INST_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_LOAD_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_STORE_PAGE_FAULT)) | \
+                         (1ULL << (RISCV_EXCP_SW_CHECK)) | \
                          (1ULL << (RISCV_EXCP_INST_GUEST_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT)) | \
                          (1ULL << (RISCV_EXCP_VIRT_INSTRUCTION_FAULT)) | \
-- 
2.47.0


