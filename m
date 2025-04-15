Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3FBC369B8
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 08:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4bQC-00084J-9m; Tue, 15 Apr 2025 04:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4bQ9-0007t7-Le
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:13:29 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4bQ5-0001yP-E5
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:13:28 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2240b4de12bso70875425ad.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 01:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744704802; x=1745309602; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Q73Ra6NhBnNXysABi6967YWRbV9gsBItuZ0tiWgYmXM=;
 b=MkWtanBdA+GKcKMIZ6hFY2LIIhqEQd3iHpDg80AwDnTXcSTOG8XuHJGWvEpl49LJOQ
 Q7J98MIY61Y7RD3GZFJw+i8av3rwiR1XvbZlF2ggW9O/veCHPUGoMoN00S35cl1GmeCm
 Kvt9uFHa0GkmUpBllfWIpU+4CBZHU5SE44VO5dW/M3dB0Cn43viQ7wWgqQouNlIBF+1L
 2h+dHp/Z0Tr5RQ7HR/nVwkvF5s4bcCUCzGaO2A/VfzZ819/9lDqmmK0l9wx4C44t0I6U
 6aDq2O54BG65uFjHGvfrdavO3/jcFVo7sMXKmnH+sHjtcdFc837/xzGdXVzYGWk3iMPE
 d9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744704802; x=1745309602;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q73Ra6NhBnNXysABi6967YWRbV9gsBItuZ0tiWgYmXM=;
 b=cfU17qRdcziXKsV8GxMVj/Q4C58hdQ8247cSNIdRpOMYOf8ERpiOEtYOIBhs0YSEhv
 VBi8AdU2h4ZcqPrHESQjzSQT1AHb3RHUitc3RtuUwsZO3dZd7ZVG9EBGFocLGQPgZPLL
 2RXHryJGbg91b+f3C+M0zeQ5EiXm/cgeFRSkQJU0kipdWohCGkotgjz6dPHf/ZNOQhUe
 lNwpsRip5FmbhZq8pzpNf+7t7tcTpI+3IL+uqFcisnfE3Sp/8Iq/B5UNoh7/GF3R39cW
 W9LUyeKtYqpaE/+oBJrkia2oiu1aLTAkp4J8jjLCT+kR8mSVlXXRPOs80psm5T/vN1XJ
 ogkQ==
X-Gm-Message-State: AOJu0YxBuPstfM+xrmowT2zBOJMqCP8zZ2WoAdTRLd48mB9zhU+zdoTh
 8XwE+hZrKHC7dZ3z0TsN6MRYC02mH71etgBK0a8No0P688p/aoC8Dhv7ueTPdOjKY77R78t+dRj
 z4OT3Nx8CQ336uUy0BH6FV3YNu6OjgNWDCBn/U5wMMS/7v6LT/WfUhWysTcgbeHAG/sDqHhmgDf
 F//Fd4XjHj5GdMB8fwPip1emwShVYFVSCtC/9o
X-Gm-Gg: ASbGncuYlenVwuz1GiGPP8giG+eMEU5bFWHacTALEIuihFmg+yQKsH7j7n5nuxKVT7b
 7d9J7X3zDNjtMiVn4kxGzMht7gNueouMWaDAuluPxOe3yyIkju1KuhttDNBu3jsYG4uR9InVTbc
 kpye0mOOV6P89IPRInDzcN60gY9F/JRjO5iP/VSLGg/kxVPCM24TyhX3ID3zoYUgvmgLD0mpepP
 x+D369ZxsB8bHs6P3qRvlYVMGsPzI8wVsXSwlqwhbsCx3fhdbDC6dGQ/LxsFW/YiIBr9cU5tTx+
 hbYxgzPPZeZS3YCEJYZzs+KRyqmjrtVZcnR5O7Hk+wwt+uB7vf03VF1g9kR1rbU=
X-Google-Smtp-Source: AGHT+IFY+kcpFxFOZHPc6XkK9i/XWDOlT9N3HZYQv5GsAe8eibEW6UNlcFcker9hPQ8wlwpq6MXkgA==
X-Received: by 2002:a17:902:dacc:b0:21f:7a8b:d675 with SMTP id
 d9443c01a7336-22bea4a1cf9mr225370105ad.4.1744704795481; 
 Tue, 15 Apr 2025 01:13:15 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c95cd1sm111082335ad.150.2025.04.15.01.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 01:13:15 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 05/17] target/riscv: Add CPU options of WorldGuard CPU
 extension
Date: Tue, 15 Apr 2025 16:12:19 +0800
Message-Id: <20250415081231.21186-6-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250415081231.21186-1-jim.shu@sifive.com>
References: <20250415081231.21186-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We define CPU options for WG CSR support in RISC-V CPUs which
can be set by machine/device emulation. The RISC-V CSR emulation
will also check this feature for emulating WG CSRs.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/cpu.c         |  3 +++
 target/riscv/cpu_cfg.h     |  3 +++
 target/riscv/tcg/tcg-cpu.c | 11 +++++++++++
 3 files changed, 17 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 09ded6829a..a182e8c61f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -236,6 +236,9 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(xtheadmempair, PRIV_VERSION_1_11_0, ext_xtheadmempair),
     ISA_EXT_DATA_ENTRY(xtheadsync, PRIV_VERSION_1_11_0, ext_xtheadsync),
     ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentanaCondOps),
+    ISA_EXT_DATA_ENTRY(smwg, PRIV_VERSION_1_12_0, ext_smwg),
+    ISA_EXT_DATA_ENTRY(smwgd, PRIV_VERSION_1_12_0, ext_smwgd),
+    ISA_EXT_DATA_ENTRY(sswg, PRIV_VERSION_1_12_0, ext_sswg),
 
     { },
 };
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 8a843482cc..a5b045aa2f 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -143,6 +143,9 @@ struct RISCVCPUConfig {
     bool ext_smmpm;
     bool ext_sspm;
     bool ext_supm;
+    bool ext_smwg;
+    bool ext_smwgd;
+    bool ext_sswg;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
     bool rvv_vl_half_avl;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 5aef9eef36..343e46e698 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -694,6 +694,17 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu->cfg.ext_ssctr = false;
     }
 
+    /* RISC-V WorldGuard */
+    if (cpu->cfg.ext_sswg && !cpu->cfg.ext_smwg) {
+        error_setg(errp, "Sswg extension requires Smwg extension");
+        return;
+    }
+
+    if (cpu->cfg.ext_smwgd != cpu->cfg.ext_sswg) {
+        error_setg(errp, "Smwgd/Sswg extensions should be enabled together");
+        return;
+    }
+
     /*
      * Disable isa extensions based on priv spec after we
      * validated and set everything we need.
-- 
2.17.1


