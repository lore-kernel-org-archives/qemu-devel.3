Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92630C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 17:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYUZ5-0004hj-Jm; Mon, 29 Jul 2024 13:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZ4-0004cs-Ax
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:42 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUYz-0000H8-9J
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:41 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7093b53f315so1209829a34.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 10:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722275616; x=1722880416;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7bXtglqSyDHmhS5ymxp0JdF77BUhuOGby1CsDo/HdPw=;
 b=JKQCRykrBn32vREMpFOLUeCDOnTOGI9MSQEYydQevIVMrDRw/ykl0Mv8GEhugQ5icX
 /z8NtWZk9/i97Sm2Op+wB2UNR4iBPaPvW0a1A7QUCulMWXcsMIFJaNDs2A3K+A1BBJhW
 g6AZqUB9UH+VT+gv5mfPxYbv9HyjKIigtgY9ObngTo/YAMTUgBfI7wwFCoI+WKmYW/Dw
 cMH0j+nu7X5LmALOI8xsBLshxy3ltg5s3+p1guBp2kqS/Wu7kMytU5srz1HNeEDWTAf8
 uHnuxWKokMmjJoXO7vc/N7XpIVLGiewbKOzGGTW0axBTz6K8SunEZwZM6EVKP38ymTib
 C+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722275616; x=1722880416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7bXtglqSyDHmhS5ymxp0JdF77BUhuOGby1CsDo/HdPw=;
 b=vNlub/9zZK1mI7GfM/IDhjzwnz51ce/D2VycD+DG83W6zjcWKRCQHT4fe+HC3+JNJa
 GGa+/ug9oNzTxF4bLkinRgcV0d63b3Mv86JTIwRcwNrotCTsJVfdQv6RzNe0Zd4sM9CW
 dQB5i5huL3uy5MDcjomErGKvJXjckF3E1XAUFdWQoGqWHJosyvPwuzlYGZ2xjDgww4UD
 tQsoOBEnJwCQ0y5GxiHpcSyDTWgY618bQc0NLmD+vifyXebRm4Blrco3eUeIlNvEm6dP
 FdDu9ubdoKQVxpLIKCcliRwZTLMQoMKkXVqCKlI9WE7bUPvGQVAq4CBf5IQbef7mpTlm
 IYJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHqFqCWUkEXJXClsNKXlebkWylWA6p4apwXbNDbuIdja7uwe0n4zI/pytu4N+9nPgha6CdpSgUAq+oOAoGJpJXjaggNKw=
X-Gm-Message-State: AOJu0Yybx8R6vFsd12q5wPQiJFrNLbqkUDX/yqPs0H9SPqet7zdigJni
 sikNWdtvwlPW6RC2bhbh7vj/p8ch8fwGwGE+y9zRZWyZZRMJFIOqAF8ShsNhrH8=
X-Google-Smtp-Source: AGHT+IHNb7tLEjV4/XWOQ7SxaCxoruBtsRBkmUz8yjdCMnZvEFf/Q6Uk+id3FU9OJ9tN/PJsy8UZCA==
X-Received: by 2002:a05:6870:440d:b0:261:d43:3eef with SMTP id
 586e51a60fabf-267d4f029d7mr10811351fac.31.1722275615844; 
 Mon, 29 Jul 2024 10:53:35 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c71b15sm6303141a12.18.2024.07.29.10.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 10:53:35 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v2 04/24] target/riscv: additional code information for sw
 check
Date: Mon, 29 Jul 2024 10:53:06 -0700
Message-ID: <20240729175327.73705-5-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729175327.73705-1-debug@rivosinc.com>
References: <20240729175327.73705-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=debug@rivosinc.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
---
 target/riscv/cpu.h        | 2 ++
 target/riscv/cpu_helper.c | 2 ++
 target/riscv/csr.c        | 1 +
 3 files changed, 5 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8c7841fc08..12334f9540 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -224,6 +224,8 @@ struct CPUArchState {
 
     /* elp state for zicfilp extension */
     cfi_elp      elp;
+    /* sw check code for sw check exception */
+    target_ulong sw_check_code;
 #ifdef CONFIG_USER_ONLY
     uint32_t elf_flags;
     bool ufcfien;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index fb4b6066d3..41bc73ad60 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1762,6 +1762,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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


