Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF2EC52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 01:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1selRI-00011y-5M; Thu, 15 Aug 2024 21:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selR9-0000nr-VM
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:28 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selR8-0002JF-D6
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:27 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70d2ae44790so1198691b3a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 18:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723770443; x=1724375243;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NjZJpddrUYMLka+s3BuiKelWfoIA0sOQqw+ndLoWex0=;
 b=NcwYGdqx71qc5Srb+DNFU/OaAXykh7w/gDOYXNcOOAGNJYiAW/tyZHP5sdXH/GiSYx
 18HA1FCae5SFIQTYR033T66ok30j1IPIUzN16yHIN+XGhM40GUBLjkZkY5+1bBFXYyQ2
 jNBY8VW1WORNQ8AdkwuA1sJrDAuwcoJubpvyGe0Ek/N2D1KujV6wG9yTJ2LKzCWFUDj9
 3ydkKcGjXo/TYLSe5Hl3DemqGVpD104jSHNgZmD6bM+bhzYVEk+9IxAYD0ALl3IURIWA
 RlKcASNyN+FgpHm05jhp+aQMsP0liWu/1JIYJHhO9lWLiH8EgxHOA2+/wn42/VCu4uzh
 mNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723770443; x=1724375243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NjZJpddrUYMLka+s3BuiKelWfoIA0sOQqw+ndLoWex0=;
 b=LAzmQLt++d7ojXeYdpqJNH4FQfQ6i3H3LnLNHCsRI66L1nW7X4+djWbBhdKkpxFT+s
 N7shEEcpTLeE64YeT81/aJA45MzRTz6+L5lRvuIp0iD1auvrM4IvmSD9X1rbUGoJAnlW
 reLmfKMh9qdo6MWCBIWYayMP99thtZV8Ma/ukPbdnRlK/nDymlI9lNOcoT4+/kkWsuba
 bZxxz94rpGpiaDmCRFjtNCEGfe1GPUi4Rhff595nCdy0dwcqPsZjy8InGhHKdbsM39Uw
 mns+30KQwADpFyyvFxyBgf6o/rx5kqqcae3n6UcdaE8vk3s8Ka8wXzKAxXhkWVEcdZ+z
 mHbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcbu8vf3hXxzVmuUZuME5bY/WsclBKuU5obhN7rZCTKzQ8lfpuJABP9AFPIkbh14jw66AvK4c4H9b2yGWwzeDlbch6638=
X-Gm-Message-State: AOJu0YyFo0poduJSstw/AhU8ZkLxKfkAEnGcV5CfK3PrlKxoSiBxTWOb
 /4wnMEe3tH2y2slXmGAZpKSrNpSsnEZCQeGguTi9voiJgpIuWk/L+dB4ExjAK0s=
X-Google-Smtp-Source: AGHT+IFNMznghKfFGVhp7MzQqqjft87zVndkKXvy7aPJ+8C2GdmhupMmQoVu0JfrVydcNLRAhrXvzg==
X-Received: by 2002:a05:6a00:1813:b0:70d:244b:cad9 with SMTP id
 d2e1a72fcca58-713c4f1a1d4mr2012516b3a.28.1723770442745; 
 Thu, 15 Aug 2024 18:07:22 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127ae120cdsm1604806b3a.77.2024.08.15.18.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 18:07:22 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, richard.henderson@linaro.org,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v4 04/16] target/riscv: additional code information for sw
 check
Date: Thu, 15 Aug 2024 18:06:58 -0700
Message-ID: <20240816010711.3055425-5-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240816010711.3055425-1-debug@rivosinc.com>
References: <20240816010711.3055425-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


