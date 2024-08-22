Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062C6C5321E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 08:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh38J-0005ON-W7; Thu, 22 Aug 2024 04:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sh38D-00055j-A3
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 04:25:21 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sh385-0005wO-4J
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 04:25:21 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-201f2b7fe0dso4655225ad.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 01:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724315112; x=1724919912;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NjZJpddrUYMLka+s3BuiKelWfoIA0sOQqw+ndLoWex0=;
 b=QJCUd+8Fdah4udItwlTl960HXHAqVvahgYIRhBLFqEkD/SpPmxnWAbzOkqH4y8TF2M
 Nhg00Jev9Sh24ebn7VA3DtNWcp62OxluKRYbx8RRHPm1ptlPt8C5r5BnTvSJsuIk65CL
 Wl/7xmwEbBOzdRv8cDLpYw2sqAmUf4caQU48sdO4BSaxlAZTn98bxkJZMFlHbKdcsRPL
 rXKcMITn3Hw+ObqIhfmvHusnrf982YongmjMmg02hmbfDzBYClu08DJYJ+Sd65+A61ja
 3ztgHes4jsAyiogq6ufB49Z/QTCH7szhby4Vdt85CC1Hd8/IeQ8msjnctuXLlfcwl+Q2
 Vkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724315112; x=1724919912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NjZJpddrUYMLka+s3BuiKelWfoIA0sOQqw+ndLoWex0=;
 b=opbxQ3ZYXaD5ay7jTOQuoP+Q/ohpd3Sg55pec6IbmoLbT5C62dbS3/l2gW8yTAgxDq
 +BiXocsdPhrb7UOTO0yaWSaKLN1S3IB4iViJP75vys8Qh4Ak3l6pcQ2GI55UPFaWWXQb
 xyA3n5qeFJxGW3qNgaNjTXputqPDmud5uq+hb/hQqUJ+BuVfxcjCVwSqBLqvzRbofdLy
 yI7x8w7hrSpaOSq+JfiuTb2b0SheHqhqCgORDFbDWgRRVHFaCTR+f1oiyUpCMzY76SPY
 ZbWqLVfp/nDoeUnfaR6VrduBGOL6B3MPOUJ5w81b6am4X6mN4Zezfdz8DUGQ80l6IKGp
 w8bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF/gHqXH5dLseAkM2FcQOoKtXcprx4RzmzS41JSXFJXxQflwY34JSNZ588RxvmY+/S6SBYP+c40L61@nongnu.org
X-Gm-Message-State: AOJu0Yz7TdG4cuRfJznW1h3+pCbmay2euP+v0wtUfH6+7+PYRJ2iJgKg
 2wq1tLIS2qobs3nvyI0kmjAADUI97QBBO2CSsHQwN2jk7/ZGeaJlLsHOzw7IvF4=
X-Google-Smtp-Source: AGHT+IEk+pWc9kiR7CAu8KIZHsVZRZfGycRtXJQNFfyAGl6LGuO6k3+EEswPJq4HNYjwMjbXcMzZHg==
X-Received: by 2002:a17:902:e5c2:b0:202:190e:2adb with SMTP id
 d9443c01a7336-2038834abcamr13351125ad.36.1724315111569; 
 Thu, 22 Aug 2024 01:25:11 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20385589225sm7641295ad.115.2024.08.22.01.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 01:25:11 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 04/17] target/riscv: additional code information for sw
 check
Date: Thu, 22 Aug 2024 01:24:50 -0700
Message-ID: <20240822082504.3979610-5-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240822082504.3979610-1-debug@rivosinc.com>
References: <20240822082504.3979610-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x635.google.com
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

sw check exception support was recently added. This patch further augments
sw check exception by providing support for additional code which is
provided in *tval. Adds `sw_check_code` field in cpuarchstate. Whenever
sw check exception is raised *tval gets the value deposited in
`sw_check_code`.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.h        | 2 ++
 target/riscv/cpu_helper.c | 2 ++
 target/riscv/csr.c        | 1 +
 3 files changed, 5 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7be0fa30f7..11c6513a90 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -224,6 +224,8 @@ struct CPUArchState {
 
     /* elp state for zicfilp extension */
     bool      elp;
+    /* sw check code for sw check exception */
+    target_ulong sw_check_code;
 #ifdef CONFIG_USER_ONLY
     uint32_t elf_flags;
     bool ufcfien;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 12484ca7d2..9f08a67a9e 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1761,6 +1761,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                 cs->watchpoint_hit = NULL;
             }
             break;
+        case RISCV_EXCP_SW_CHECK:
+            tval = env->sw_check_code;
         default:
             break;
         }
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5771a14848..a5a969a377 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1179,6 +1179,7 @@ static const uint64_t all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS |
                          (1ULL << (RISCV_EXCP_INST_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_LOAD_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_STORE_PAGE_FAULT)) | \
+                         (1ULL << (RISCV_EXCP_SW_CHECK)) | \
                          (1ULL << (RISCV_EXCP_INST_GUEST_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT)) | \
                          (1ULL << (RISCV_EXCP_VIRT_INSTRUCTION_FAULT)) | \
-- 
2.44.0


