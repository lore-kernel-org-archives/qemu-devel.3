Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F34C606A699
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utexas.edu header.i=@utexas.edu header.a=rsa-sha256 header.s=google header.b=CllBIBsP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVxiQ-0002MU-6c; Tue, 24 Nov 2026 16:06:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samarthsarda@utexas.edu>)
 id 1xVvBP-0001Lv-G7
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:23:59 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <samarthsarda@utexas.edu>)
 id 1xVvBN-0001PK-7y
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:23:58 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-71ad099391dso2376650eaf.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.edu; s=google; t=1795544632; x=1796149432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P/9Ni+Liwp7pDx23fwbNgwxFtK/lXPuSovTDiqO5Mvw=;
 b=CllBIBsPoRHjYHpLeAEi/ZLCmfcfC6Rpci7CuqNTET+gAwULQmTzs9EIY3TytMjl58
 LMaP6ABbHtJ+0zyrJXdwGH3NIFH/aOjiu1y4CB1juokmFOSnBQBOR/gVTO3ENN4KFJBV
 fCczPEqF/eUS0De9kg854ShwcD12UuHkvh2+0xDJ1faz8vOMEh77yDH+lgkdgzax+HR0
 yEuP5xWRRUr/id0pz6rnuHHkCDcHhwS/EZES2tTuozlBjg6tgqBUnctQk5+sm+ZWnWUz
 nbU+EjAhqEFPPSiBFx1UyVciBLi7npQOmWxyFoxWPlVH/p0y6yoYYxGBi2zMzVH5Yp2P
 AehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795544632; x=1796149432;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P/9Ni+Liwp7pDx23fwbNgwxFtK/lXPuSovTDiqO5Mvw=;
 b=m+5arBGvuLuV0MNHYTLo1Ytr4sKQZpMFfJMufOsbqw7ipKg8PjRhymWHiENXTEXxgT
 2vZQMioLiImxhTACMZ+DYIVJ3R1z4gZL0Lnx9yCN4rGU3c2xUlMB+zrBpE1v7ISEhIWS
 +QZD19DY1XBT/y6adP3QwXoM5RUtetFh8h4ECEW2fB7iSf5Mv0QGmNirkYeYkNcYVtMn
 n2Wwkkx9rN432JAUkUO1Mc6uW8XtxTv/1iTRNLdbjp+Mt2TjkXXdDXEniUf3IVQgnz/f
 lVm3wMGBZEo0WOgGxB4DwHvGsYkeH70QEjYgSRxCX253R0SO2ntSxMwtul5ol9wXMy8g
 WSxw==
X-Gm-Message-State: APuU4Z8Zl5qILkRrExFX+xRynVEtEjry+y7qRF6Oforl4aL5qpENk2tv
 /qgz54nc6/fvSiC8mLVzmHBPhCYC1ol5+DO31r+yH9uzlkJrBiyvhyXafF2xOlbzXehPTWOl76l
 IfMU0P5doRRp5sv3ktqC/gNdV4awIkj6X54Y011Ip6AFgpZ/C/JjnQfYqNrkEhAReiaatqDbDnv
 EkfHUNOcTIiSwBXcfxHQmLvg5qzz1/ADP3BjPrB2xSWhWAYC2l
X-Gm-Gg: AZFdTZfVj2TA1kKCnqeWu+b+gtAKqu85zy77Jem77Hf4RdEovkWK4sfv3xAplmfQhIQ
 WicrSxr8A5vLEB6r2IR6hv39HiM9PPPRI1IDseV6JZ6su+ivMvOPJRpQh/itrjEnKV/bnyAxldx
 m2C7Uec/ksqtN7LssAgn83Rmgu6H7j4GIopmb8glNFGq3GLixKxubpTglvhAwLrBe6SI45j8X+8
 E/91vvzrE2JwCG9sAy/4aRxjh3iT0QSFRu3cpxM1oFg4Y0vGJwvVvFuO9XnYHardBpijTHTYkEz
 i+SnNIIjd402V/ti1Qs9v/8PF6QSldQ6gJOFcYI3GjNPoPVA14vhp6GYNSi9hdFpWMftD3a4ly0
 KmxAniy3D/Qb47VYAV2c0wNN0kUDZ3mqR5loVr4/kN9kw2cvkpRy6koLvkwiWzUCdaPiVWfV+WW
 UURb2U+UA9Cq7pfNufxjQ3C5dv0uj8H5Fp8dc5TMEmbHg8CwzkNpIQpdBxb845NYrsI1efEv6WJ
 Y75XNGhY1ALOqJlaGaKSlMovEwPqcCXhXPCB0J8D8MTpZ1EPMAeAOYl2rMF0E/f6wJQmG3Q6GCK
 SlnnyTD80FrtR4dTJCEpxbGtL8+eicZvWQ9dLjAF
X-Received: by 2002:a05:6820:3413:20b0:71a:e9eb:6b94 with SMTP id
 006d021491bc7-71b3942f2b6mr7775912eaf.20.1795544632553; 
 Tue, 24 Nov 2026 10:23:52 -0800 (PST)
Received: from ubuntu.. ([172.56.23.167]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168f6d33sm11104415a34.18.2026.11.24.10.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:23:52 -0800 (PST)
From: Samarth Sarda <samarthsarda@utexas.edu>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 Samarth Sarda <samarthsarda@utexas.edu>,
 Dana Coates <elladana.coates@gmail.com>,
 Juliet Mathis <julietmathis2004@gmail.com>
Subject: [PATCH] target/riscv: Fix mnepc alignment for Smrnmi
Date: Tue, 24 Nov 2026 18:23:41 +0000
Message-ID: <20261124182341.70418-1-samarthsarda@utexas.edu>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=samarthsarda@utexas.edu; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 24 Nov 2026 16:06:09 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When the RISC-V C extension is enabled, instructions may only need
to be 16-bit aligned. Some RISC-V implementations allow software to
dynamically enable/disable the extension through misa.C. That means
IALIGN can change while the CPU is running. When switching between
IALIGN=16 and IALIGN=32, bit 1 must be preserved when written, even
when IALIGN=32. However, bit 1 must appear as zero when read under
IALIGN=32. The same masking applies to the implicit read performed
by MNRET.

Bit 1 of mnepc is being cleared permanently when IALIGN=32.

Our fix preserves bit 1 of mnepc if IALIGN is switchable
regardless of the current IALIGN value.

Fixes: 5db557f82bff ("target/riscv: Add Smrnmi CSRs")
Reported-by: David Harris
Signed-off-by: Samarth Sarda <samarthsarda@utexas.edu>
Signed-off-by: Dana Coates <elladana.coates@gmail.com>
Signed-off-by: Juliet Mathis <julietmathis2004@gmail.com>
---
 target/riscv/tcg/csr.c       | 11 +++++++++--
 target/riscv/tcg/op_helper.c |  2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index af444e3e6f..bd395a129d 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -5752,14 +5752,21 @@ static RISCVException write_mnscratch(CPURISCVState *env, int csrno,
 static RISCVException read_mnepc(CPURISCVState *env, int csrno,
                                  target_ulong *val)
 {
-    *val = env->mnepc;
+    *val = env->mnepc & get_xepc_mask(env);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_mnepc(CPURISCVState *env, int csrno,
                                   target_ulong val, uintptr_t ra)
 {
-    env->mnepc = val;
+    target_ulong mask = get_xepc_mask(env);
+
+    /* Preserve bit 1 when IALIGN can change from 32 to 16. */
+    if (riscv_cpu_cfg(env)->misa_w && (env->misa_ext_mask & RVC)) {
+        mask = ~(target_ulong)1;
+    }
+
+    env->mnepc = val & mask;
     return RISCV_EXCP_NONE;
 }
 
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index f9c79fe6b9..001241cea1 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -543,7 +543,7 @@ void HELPER(sdext_ebreak)(CPURISCVState *env, target_ulong pc)
 
 target_ulong HELPER(mnret)(CPURISCVState *env)
 {
-    target_ulong retpc = env->mnepc;
+    target_ulong retpc = env->mnepc & get_xepc_mask(env);
     privilege_mode_t prev_priv = get_field(env->mnstatus, MNSTATUS_MNPP);
     bool prev_virt;
     uintptr_t ra = GETPC();
-- 
2.43.0


