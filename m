Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930BFD5AE61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 04:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8trJ-0006H2-RK; Wed, 06 Nov 2024 23:11:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8trH-0006Gr-Vb
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 23:10:59 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8trG-00050o-DP
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 23:10:59 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20c803787abso4930365ad.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 20:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730952657; x=1731557457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lH5GO7G9PC7qoCbAKl94qNlYtwmp9Vy76+NSbGNno7g=;
 b=EqmSpeitiHO0FE655k85i8EoFjOrsl7b9lhlHSbfFUvvscFfcZe9yQQqnV3lZotueo
 i6Z/uQNiSOCpFG7MpBoBsUQZy4/5eYVKv0zOdCSc7nuuKDSgS417CygYSJj4/w2B0T4W
 Oveni/xn6lA+PfVFt/jYOt2IpF0SrxRmcEBTz+1dUpVw7uOUHbTPBHeZ/Hjw3QHN0xEk
 UfNOkCwBCeIa8Z88XULePijBJduiv++TNBO/UURVInZT2tw2I0L9zP+vvTSB+42RNulI
 QnmCYvf0vTCDRLkO46zr0X5fy16Y2WS3n3/BnwxUpIY9114RSg1OKVpfHsfHzJJ8xPLi
 NrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730952657; x=1731557457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lH5GO7G9PC7qoCbAKl94qNlYtwmp9Vy76+NSbGNno7g=;
 b=B1MPDGRVgeHDnNG077AwpfFxlWW/Ts3w2IIMD1dbysYEW3zGhAlgRhxwLVbAQWVUIV
 u6r4Ou6oz3dMJ8ujQnIJJwTLB37wr6n4p15RPUAERe5xta1W38o4cuybaNffhQqqZadO
 cdgskNQHTunTVZM/XTF0N3hyngY1ZeQUzcfWL/fKQYQO6mLYpi6jWbZ0hd0z1sp6PJw6
 5jAwbQfMjHpt+Nb4S4lKBFGPVBUo/DDkEX8JJjzwtUxPuxmXa/NhdV8fpp+DL9ow2p8E
 cQpAvhF4YaV7gZNIFsb1iSZwbiY2wFvG/LhVyvUR+g/0u3+NS5MbyjwshOSPW3fGmZf2
 LFGA==
X-Gm-Message-State: AOJu0Yx0w4DFieyBzqF2Yy2+U2hGN2iluDRYiCCq/G8/LfMaQ2RvnIXW
 cdqdGZZH9WyvlG4Sx4AlvzoC9/HPyhUQg0PHogIeKtxUCSH7n1KhQRmlKw==
X-Google-Smtp-Source: AGHT+IEak4JzKJKrOrwuHzo+IMDpbsYSUuFba/nuYTvv+vb1LQihVvRBbKI6NV8Z7iv7bWh/PU+big==
X-Received: by 2002:a17:902:fb0b:b0:20c:d71d:69c5 with SMTP id
 d9443c01a7336-21175c13bd8mr25771775ad.4.1730952656655; 
 Wed, 06 Nov 2024 20:10:56 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc3f12sm2789105ad.9.2024.11.06.20.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 20:10:56 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/12] target/riscv: Inline unit-stride ld/st and corresponding
 functions for performance
Date: Thu,  7 Nov 2024 14:10:14 +1000
Message-ID: <20241107041016.40800-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107041016.40800-1-alistair.francis@wdc.com>
References: <20241107041016.40800-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

From: Max Chou <max.chou@sifive.com>

In the vector unit-stride load/store helper functions. the vext_ldst_us
& vext_ldst_whole functions corresponding most of the execution time.
Inline the functions can avoid the function call overhead to improve the
helper function performance.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240918171412.150107-8-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 3d10ff94cd..a85dd1d200 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -153,14 +153,16 @@ typedef void vext_ldst_elem_fn_tlb(CPURISCVState *env, abi_ptr addr,
 typedef void vext_ldst_elem_fn_host(void *vd, uint32_t idx, void *host);
 
 #define GEN_VEXT_LD_ELEM(NAME, ETYPE, H, LDSUF)             \
-static void NAME##_tlb(CPURISCVState *env, abi_ptr addr,    \
+static inline QEMU_ALWAYS_INLINE                            \
+void NAME##_tlb(CPURISCVState *env, abi_ptr addr,           \
                 uint32_t idx, void *vd, uintptr_t retaddr)  \
 {                                                           \
     ETYPE *cur = ((ETYPE *)vd + H(idx));                    \
     *cur = cpu_##LDSUF##_data_ra(env, addr, retaddr);       \
 }                                                           \
                                                             \
-static void NAME##_host(void *vd, uint32_t idx, void *host) \
+static inline QEMU_ALWAYS_INLINE                            \
+void NAME##_host(void *vd, uint32_t idx, void *host)        \
 {                                                           \
     ETYPE *cur = ((ETYPE *)vd + H(idx));                    \
     *cur = (ETYPE)LDSUF##_p(host);                          \
@@ -172,14 +174,16 @@ GEN_VEXT_LD_ELEM(lde_w, uint32_t, H4, ldl)
 GEN_VEXT_LD_ELEM(lde_d, uint64_t, H8, ldq)
 
 #define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)             \
-static void NAME##_tlb(CPURISCVState *env, abi_ptr addr,    \
+static inline QEMU_ALWAYS_INLINE                            \
+void NAME##_tlb(CPURISCVState *env, abi_ptr addr,           \
                 uint32_t idx, void *vd, uintptr_t retaddr)  \
 {                                                           \
     ETYPE data = *((ETYPE *)vd + H(idx));                   \
     cpu_##STSUF##_data_ra(env, addr, data, retaddr);        \
 }                                                           \
                                                             \
-static void NAME##_host(void *vd, uint32_t idx, void *host) \
+static inline QEMU_ALWAYS_INLINE                            \
+void NAME##_host(void *vd, uint32_t idx, void *host)        \
 {                                                           \
     ETYPE data = *((ETYPE *)vd + H(idx));                   \
     STSUF##_p(host, data);                                  \
@@ -318,7 +322,7 @@ GEN_VEXT_ST_STRIDE(vsse64_v, int64_t, ste_d_tlb)
  */
 
 /* unmasked unit-stride load and store operation */
-static void
+static inline QEMU_ALWAYS_INLINE void
 vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
                   uint32_t elems, uint32_t nf, uint32_t max_elems,
                   uint32_t log2_esz, bool is_load, int mmu_index,
@@ -370,7 +374,7 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
     }
 }
 
-static void
+static inline QEMU_ALWAYS_INLINE void
 vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
              vext_ldst_elem_fn_tlb *ldst_tlb,
              vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
@@ -757,7 +761,7 @@ GEN_VEXT_LDFF(vle64ff_v, int64_t, lde_d_tlb, lde_d_host)
 /*
  * load and store whole register instructions
  */
-static void
+static inline QEMU_ALWAYS_INLINE void
 vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
                 vext_ldst_elem_fn_tlb *ldst_tlb,
                 vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
-- 
2.47.0


