Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226B4C98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkkA-0002Pq-Vx; Sun, 27 Sep 2026 05:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkk5-0002P7-GT
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:18 -0400
Received: from mail-pj2-x0c.google.com ([2607:f8b0:4864:39::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkk3-0007Nx-HV
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:17 -0400
Received: by mail-pj2-x0c.google.com with SMTP id
 98e67ed59e1d1-3a0d31bda43so887372a91.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499613; x=1791104413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5HPNR2uKle5bPVNP0yb7kgcm/aJRfrsNf7JM6905Ueo=;
 b=cUq2s9Htzr7fe9NAk92dRthorJA+8LyAyrxs6L+XQnShDgNy3fo+wz11AgunTjHKua
 Ri0uzuWERjso/noZv7VjPoQJqnvnRKwpiRb8ogqJxum/Yvo9YkSf4XX9WrXjpSNrk1cj
 hi47aU3XpiSAFxBZ2AhXqr8w5t0jBXcgotDdDPvrUzP536J1yJCYD07aConiUUe7YEI+
 Vf44CBsgcYLehl9s0oK/+uwl1nK3J+dYYl6DMGRmh1dMVkTOoOqbLGb1Qx17dAR9cD9q
 h+XJaJItpf5HEX6pcJ4AOqJiUHm7CaDMpedbfeFOHZVZ3dtmcM+ItNp2riw3JOoJ2vWk
 I5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499613; x=1791104413;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5HPNR2uKle5bPVNP0yb7kgcm/aJRfrsNf7JM6905Ueo=;
 b=HOnJcsN+ou8UOfxFO/t3lYqZMRPiCcg79dyDqhx0j9kCoUbMB8Yp7N9cMg+eQdCdgD
 6CoQSFAE/Aqst9kz3ambk34wpDFvhuIq720oY9cUgIG7S/r8hqg2XSdQ/2YNFWqjWQ7M
 yz9RAhA+ojnRMlO8BlKXVSs+9LAOPgqLmPxGsC2G16aZvvrkujmvSLbxBJic3r7Rk+Zx
 k+mpdNLAvFjLxyeUcTT5H3xZd7h8gDSes3uTyD9JW5+JwQXSbEn2VyxHyIcepuPnn/Qm
 8WQ88LH6x6kQDcxVas+XKVQZvcnh0v/N6Z/LYvkblK66DSDWNW5f9I2BN5e5/4I1j0lU
 qurQ==
X-Gm-Message-State: AFq9FYL4qSsYwMYnvXqkmyyh2ZXz1ZYZYG5INArzgjqdGpNNMoJiel9N
 hWds9RCJKFLta+Y2KzjTuR2DOmB9pLSO33OLvhMrbv3vatDTnUQbKX6HiZ/fae9jbwjrrQGydTt
 QV1Ku
X-Gm-Gg: AYBFou1FnM2Lkez5So7xJCz9Z4QIT0tfLX0TbXZ1Xk7zqaXxMKyDBgABWULNW/ynAhs
 PYY4K9SE4MBTY18mOyE470qqGZoTKWg+4P8l9o/ejEI2HM6aOW6sHOVfwvo3VQN7L+m1raiy5Rw
 r2OSW/AU7gtUJot9/+/wcFR7GkisRfm+SPPVtcXt1UyDydx5SV41vpCGg0yGnETY5sOinaFmSvx
 yib2rE1XqY28HP1G3B84xfMB0hvAeCEsDerHByTc7Hdb5mTxB0UT1s3Fw+fJoPDugBBPXT7YAKa
 GBFk7wAKnpLzYxlxe4YqbhWPLYJAOEZp4N3efFYWCrjTKq6P2NDbQ18MGrAnoq1gHMcvHjs0q6r
 myLmTnkJMXMd+w7p2zqMCnp4g0t7y+LBwtd/EMDKvjMcSObAUd6dRnKfoGoYZEnlx1ywvvUsd6G
 ic3a2IzsL4Jdx/uxoO2rz++HzPLhxPJYiKHSTT+FZFkAneHcK2+BAX909w64ei3M6aAfnGpwOho
 tBXhLMnaaS2hZK/TSTPvc0xM68WDQ==
X-Received: by 2002:a17:90b:1a8d:b0:3a0:c0f0:9a97 with SMTP id
 98e67ed59e1d1-3a0c0f0ab42mr5062893a91.9.1790499613383; 
 Sun, 27 Sep 2026 02:00:13 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 000/101] tcg: Generic expansion of most operations
Date: Sun, 27 Sep 2026 01:58:30 -0700
Message-ID: <20260927090011.10724-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The driver here is the boilerplate I needed to write for the
recent lea opcode addition.

This eliminates the majority of the code duplication between
the _i32 and _i64 expanders.  What remains are those expanders
that truly differ between the two widths, or that are only
present for one width.

Of course, due to touching most opcode expansion, I noticed a
few cleanups and improvements in the process.

Changes for v5:
  - Export stuff from tcg-op.c to tcg-internal.h, allowing...
  - Convert tcg-op-ldst.c entry points to tcg-op-def.h.inc.

r~

Richard Henderson (101):
  include/qemu/compiler: Add QEMU_*_NONNULL attributes
  include/qemu/compiler: Define QEMU_ALIAS
  tcg: Annontate functions in tcg.h with QEMU_*_NONNULL
  tcg: Annontate functions in tcg-op-mem.h with QEMU_*_NONNULL
  tcg: Annontate functions in tcg-internal.h with QEMU_*_NONNULL
  tcg: Use QEMU_ALIAS to define most tcg_gen_*_ptr
  tcg: Use QEMU_*_NONULL with all tcg_gen_*_ptr
  tcg: Prepare for easy temp lifetimes
  tcg: Generic expansion of tcg_gen_mov_*
  tcg: Generic expansion of tcg_gen_movi_*
  tcg: Generic expansion of tcg_gen_discard_*
  tcg: Generic expansion of tcg_gen_add_*
  tcg: Generic expansion of tcg_gen_addi_*
  tcg: Generic expansion of tcg_gen_sub_*
  tcg: Generic expansion of tcg_gen_subi_*
  tcg: Generic expansion of tcg_gen_neg_*
  tcg: Generic expansion of tcg_gen_subfi_*
  tcg: Generic expansion of tcg_gen_and_*
  tcg: Generic expansion of tcg_gen_or_*
  tcg: Generic expansion of tcg_gen_xor_*
  tcg: Generic expansion of tcg_gen_shl_*
  tcg: Generic expansion of tcg_gen_shr_*
  tcg: Generic expansion of tcg_gen_sar_*
  tcg: Generic expansion of tcg_gen_mul_*
  tcg: Generic expansion of tcg_gen_shli_*
  tcg: Generic expansion of tcg_gen_shri_*
  tcg: Generic expansion of tcg_gen_sari_*
  tcg: Generic expansion of tcg_gen_andi_*
  tcg: Generic expansion of tcg_gen_ori_*
  tcg: Generic expansion of tcg_gen_xori_*
  tcg: Generic expansion of tcg_gen_muli_*
  tcg: Generic expansion of tcg_gen_not_*
  tcg: Drop division helpers
  tcg: Generic expansion of tcg_gen_div_*
  tcg: Generic expansion of tcg_gen_rem_*
  tcg: Generic expansion of tcg_gen_divu_*
  tcg: Generic expansion of tcg_gen_remu_*
  tcg: Generic expansion of tcg_gen_andc_*
  tcg: Generic expansion of tcg_gen_eqv_*
  tcg: Generic expansion of tcg_gen_nand_*
  tcg: Generic expansion of tcg_gen_nor_*
  tcg: Generic expansion of tcg_gen_orc_*
  tcg: Generic expansion of tcg_gen_brcond_*
  tcg: Generic expansion of tcg_gen_brcondi_*
  tcg: Generic expansion of tcg_gen_setcond_*
  tcg: Generic expansion of tcg_gen_setcondi_*
  tcg: Generic expansion of tcg_gen_negsetcond_*
  tcg: Generic expansion of tcg_gen_negsetcondi_*
  tcg: Generic expansion of tcg_gen_movcond_*
  tcg: Split out tcg_gen_ext{rl,rh,s,u}
  tcg: Generic expansion of tcg_gen_clz_*
  tcg: Use signed integer for tcg_gen_{clz,ctz}i_{i32,i64}
  tcg: Generic expansion of tcg_gen_clzi_*
  tcg: Generic expansion of tcg_gen_ctpop_*
  tcg: Generic expansion of tcg_gen_ctz_*
  tcg: Generic expansion of tcg_gen_ctzi_*
  tcg: Generic expansion of tcg_gen_clrsb_*
  tcg: Generic expansion of tcg_gen_rotl_*
  tcg: Generic expansion of tcg_gen_rotr_*
  tcg: Generic expansion of tcg_gen_rotri_*
  tcg: Generic expansion of tcg_gen_rotli_*
  tcg: Generic expansion of tcg_gen_deposit_*
  tcg: Generic expansion of tcg_gen_extract_*
  tcg: Generic expansion of tcg_gen_sextract_*
  tcg: Generic expansion of tcg_gen_deposit_z_*
  tcg: Generic expansion of tcg_gen_ext8s_*
  tcg: Generic expansion of tcg_gen_ext8u_*
  tcg: Generic expansion of tcg_gen_ext16s_*
  tcg: Generic expansion of tcg_gen_ext16u_*
  tcg: Generic expansion of tcg_gen_ext_*
  tcg: Generic expansion of tcg_gen_smin_*
  tcg: Generic expansion of tcg_gen_smax_*
  tcg: Generic expansion of tcg_gen_umin_*
  tcg: Generic expansion of tcg_gen_umax_*
  tcg: Generic expansion of tcg_gen_abs_*
  tcg: Generic expansion of tcg_gen_ussub_*
  tcg: Use umax in ussub if available
  tcg: Generic expansion of tcg_gen_extract2_*
  tcg: Generic expansion of tcg_gen_addcio_*
  tcg: Generic expansion of tcg_gen_add2_*
  tcg: Generic expansion of tcg_gen_sub2_*
  tcg: Generic expansion of tcg_gen_mulu2_*
  tcg: Generic expansion of tcg_gen_muls2_*
  tcg: Use unsigned for flags for bswap and revbit operations
  tcg: Generic expansion of tcg_gen_bswap16_*
  tcg: Split out gen_bitswap
  tcg: Generic expansion of tcg_gen_revbit8_*
  tcg: Generic expansion of tcg_gen_ld_*
  tcg: Generic expansion of tcg_gen_ld8s_*
  tcg: Generic expansion of tcg_gen_ld8u_*
  tcg: Generic expansion of tcg_gen_ld16s_*
  tcg: Generic expansion of tcg_gen_ld16u_*
  tcg: Generic expansion of tcg_gen_st_*
  tcg: Generic expansion of tcg_gen_st8_*
  tcg: Generic expansion of tcg_gen_st16_*
  tcg: Generic expansion of tcg_gen_dup_*
  tcg: Generic expansion of tcg_gen_qemu_ld_chk
  tcg: Generic expansion of tcg_gen_qemu_st_chk
  tcg: Generic expansion of tcg_gen_{non}atomic_qemu_cmpxchg_chk
  tcg: Generic expansion of remaining atomic operations
  tcg: Annontate functions in tcg-op-common.h with QEMU_*_NONNULL

 accel/tcg/tcg-runtime.h                    |   10 -
 include/qemu/compiler.h                    |   15 +
 include/tcg/tcg-op-common.h                |  637 ++---
 include/tcg/tcg-op-mem.h                   |   36 +-
 include/tcg/tcg-temp-internal.h            |    2 +
 include/tcg/tcg.h                          |   61 +-
 tcg/tcg-internal.h                         |  160 +-
 include/tcg/tcg-op-def.h.inc               |  110 +
 accel/tcg/tcg-runtime.c                    |   44 -
 tcg/tcg-op-gvec.c                          |   41 -
 tcg/tcg-op-ldst.c                          |  729 ++---
 tcg/tcg-op.c                               | 2988 +++++++-------------
 tcg/tcg.c                                  |    4 +
 target/ppc/translate/fixedpoint-impl.c.inc |    4 +-
 14 files changed, 1784 insertions(+), 3057 deletions(-)
 create mode 100644 include/tcg/tcg-op-def.h.inc

-- 
2.53.0


