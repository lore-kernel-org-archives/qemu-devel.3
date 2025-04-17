Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E23C369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 10:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5MsS-0007cz-4t; Thu, 17 Apr 2025 06:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5MsH-0007TZ-99
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:53:42 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5MsE-0003NR-Sk
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:53:41 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso599504b3a.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 03:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744887217; x=1745492017; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Q73Ra6NhBnNXysABi6967YWRbV9gsBItuZ0tiWgYmXM=;
 b=MxQibbiCnjGq9Ic9H23T5yiZgGbiBswbIEMy/FdLrya3GSmYaMBiZnc40fMC+BIV2G
 QLFMt49EprBeHP6vWPRj9uyrbC+yzodT8ydQJ8MQOVjW1Mou+sWrUAlWXHcF7UeVRIcR
 1UgWAAf5XSQnegoqEuhGAAnaobvoqo6hSayu0fQbW9nJeTDRvPPiTAfvMfBOcyxa23N+
 /A+92NiXMU9HnX/3Bymz8yvaLl+jH6ExboWBXn+SL/48yr9Nra37aXsWXHTjITnjA5D5
 iuzjwL1N/ZSJRuoW72yOFZppbd6fxDLlqVXHq7i9/OHE5A9efbmgBVxL/q4m4R/4k6aL
 1ChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744887217; x=1745492017;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q73Ra6NhBnNXysABi6967YWRbV9gsBItuZ0tiWgYmXM=;
 b=A4TDK90PWZktwamFrSSJHJoN297oRPGaLWaxF8z4BIxwfeaOAoziW+CtqCqiGJLmah
 fthAEpgfy50RW7Mo05dfy42wqtlUo4F6DYp1rgKwkeu5+bOnR1p6AjvHdRrh8KVBhzNA
 a4FT5KlXQzFlszx8Sqnq2TCxridiYX/KeTrkR6FnH9mBga1UCjrUZc6Jw7D9+Osp9qLT
 OqPy0S89eS3USPfIjhLvwVygfaeZYCustVJ5ghKig7e9qBIB7AvVyrXV6dYrIBvldKFc
 QICBLdVW1p8Tx3bJeuwhufsbc6iL5g08O/VZoPzK+1azhF04Rlqo0ryEGAMBVow9trGE
 ZefQ==
X-Gm-Message-State: AOJu0YyFe8MvB0sAsqCxiHUjfyAQGv4q1ZHSPntlBMcJFVH9LdS3tC4h
 WKuDz3rkGbr/b07RCfOn2AkT89Ev3gRwLEAkMDUHoeU6MOmy6onGqEbbWV6dI04RzKKk49Q3+AT
 WWdJpDlji/WXgTGvLhGzS/v0odv1IoMDdWjoZCGQQT7K0pWFoJQu5qcDltZyg5bJb9vDPOqputA
 JO/pssLpk8mrmCZG/DGnOzdUdSLKatfx3MqQ==
X-Gm-Gg: ASbGnctpH82gCF4E27XANDRkkZjE7TBZyc6RNMrdnGnP1wqUmSP5rbu6NGzfT+4sSHM
 WOtWMdhq6ZxxEQdN6Eg0H1KWQQUktRhl/Wq9WHULMuB2rmCYVRX8pmO+V/XHdiYpEK/gF61ODri
 f1YweQDve++TB8D1VWH5SV6U4xjAvUDbL8i9GcdCoq54U3WlhQJ++wcyNTkTthNNWK6Ojs1vx9Y
 brj9MOm3IQ2O9ARxntwYKPAD/KiXw7Z3iYk/666Re7zADaz9JQ5JCj5lZBTqbXzUrOZmrTkOUvb
 dXW7nd4BBPD0LNRfd4EgJq7lDp9CJeBRvIsoOjdJ7vO0j0ewlFD0IGpkyiXrjmg=
X-Google-Smtp-Source: AGHT+IG9lIi4y81GtUAS/p2kFe8CuUnY6PtZhntDyHe9dS07v84VZAseI8Cz6apbvILdy6H2Wt/8XQ==
X-Received: by 2002:a05:6a00:26dd:b0:734:26c6:26d3 with SMTP id
 d2e1a72fcca58-73cdbf142f5mr3803664b3a.5.1744887216489; 
 Thu, 17 Apr 2025 03:53:36 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230ddaasm12366251b3a.138.2025.04.17.03.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 03:53:36 -0700 (PDT)
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
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 06/18] target/riscv: Add CPU options of WorldGuard CPU
 extension
Date: Thu, 17 Apr 2025 18:52:37 +0800
Message-Id: <20250417105249.18232-7-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250417105249.18232-1-jim.shu@sifive.com>
References: <20250417105249.18232-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x435.google.com
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


