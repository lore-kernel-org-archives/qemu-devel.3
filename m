Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E63606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZeCLllWr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsVp-000695-UT; Sun, 25 Oct 2026 03:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsVm-00068Q-3h
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:22 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsVj-0003eo-UO
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:21 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso1814473f8f.2
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912758; x=1793517558; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=416UlVG31+2PR+x5fDd1optOGRhJMvDkRnvhg85Jig8=;
 b=ZeCLllWrnt7C5GnyVdRmY/rv6xoaEXsrbG7WE0leGS+fRUlzpSNGuPkXBPflM9hwhq
 w7KbNP431shk8M+beFVZq+LpAPmux/+8OOtkCuSX4W1lNLweadsWOerO2+nCW12SZ9UE
 R0nllKI8bOCLrfncCY2duOLv96R//3aL6MmhYSmqJcBwfJqhxXr+ebaIOeuxkOhXVW/E
 keHQf8k4hpE4zRTtXXa1dkYFKwDBtVJfuJlShAipTueMAmVwJJ+zoTokivplFsQuRSht
 4zVArg34loGuAWsBSxODGjXogvlL1iF+7LWHTcWgzlmzpcNGe6opLAT070uwulYKZY1j
 VmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912758; x=1793517558;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=416UlVG31+2PR+x5fDd1optOGRhJMvDkRnvhg85Jig8=;
 b=NnzhH5DpGrlE7bDfszp/DFq7jYH/u8B8c0CtqSljMgjO7cuNM7hDDZu+E/t7A2e39+
 8RJPiHmGyWNWSCzXPNrLt+8mpD3Yf2d2EBtv3yaQT3Np3SRBb/X+OhrjENNljgksZ1Rn
 yWCSorwv8O8og4oXeayKO3q/DRGsGairMnTN80opP0bBKW2GUCAuKh0QvoRFZN7PfGGv
 Hae9eqEURqITPVp8QnQSZeG31XDtYqEssgaIfyA6xuOMbXgeOUHsy06kalqI0TRIzxSl
 kAkVObTruMTpjNKZAdB3S7VEnZG49AcN0Bi8UO54S8+wq6P5M7HMwwGOLHYhuYFDi317
 Ostg==
X-Gm-Message-State: AFq9FYK/MWMS+0IpKcGeTGevaTxgTTR3nCczX+/g9TqzrU+/img9o699
 ydxWVVF1kz/Xo4E+9wn3ngKlagm6IZ3KY+IsRncMqfd16ygU2Hv1p7XdSV22E3piPwZpDKZY+Xf
 Q9g+pRQs=
X-Gm-Gg: AYBFou2PgVTDj+FfSTvJz7PWThzzRsyZWmwxvomYEMaxinhjC0SPZGGK7p8ofGdcShB
 tJUQz2L9+Liwj4uA6waWI+AP9dgJuCt6rhJtYledBXjfei/QjJkMmtKKngwHeUqxle4IBv2VvuK
 XG+g8YyC5jVQVI+KndPyOSV7o9piSOZOFxgugZMQ+KMqS3cwXSNPemUzw9VGVOAuKwONpaatWaM
 fcPL+2zqo4crDrxTDYVD6fB4PShiVuEAzUGujrCytxkgUrPeyoSkAqxXlw+3a1ZJ4b2Ur8ZxteQ
 ePMkL9/UuSfHAQAEYgIFVJ90i7DLqV3NEXVTJBjiH4bswxcOGtOrLvdyOXkNrD05lHSmoVk/uUv
 mKM+9oEe22G1WeMAx1PZUmmlpOxQsF9JsVDfrxg27hWsUVHuTW8WgKiQiLU5owaE0X27kE/XJIt
 eyOVJaAOfQ47AMPQWpbv00ygQvVCi8gBTEdm2y7KpM2obfHncHY7KZeSfzPdDJrTZLDW43dLQKs
 VabtRVWITETbKg8tf3v9WOpgV2DRX3QchgQf1ksNcH4vxR4EKk9FQOK6Q==
X-Received: by 2002:a5d:5d86:0:b0:48d:f996:1814 with SMTP id
 ffacd0b85a97d-48e3eb9c7fdmr5498535f8f.57.1792912758024; 
 Sun, 25 Oct 2026 00:19:18 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 000/100] tcg patch queue 20261025
Date: Sun, 25 Oct 2026 08:17:35 +0100
Message-ID: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit d73149283205645625bfa9fe029cfb68e4c4a9ae:

  Merge tag 'samuel-thibault' of https://people.debian.org/~sthibault/qemu into staging (2026-10-24 16:09:37 +0200)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20261025

for you to fetch changes up to 0509b1a38002d99c28e24ba96a89c75ac08d9da7:

  tcg: Annontate functions in tcg-op-common.h with QEMU_*_NONNULL (2026-10-24 17:14:50 +0200)

----------------------------------------------------------------
tcg: Generic expansion of integer opcodes.
tcg: Annontate functions with QEMU_*_NONNULL

----------------------------------------------------------------
Richard Henderson (100):
      include/qemu/compiler: Add QEMU_*_NONNULL attributes
      tcg: Annotate functions in tcg.h with QEMU_*_NONNULL
      tcg: Annotate functions in tcg-op-mem.h with QEMU_*_NONNULL
      tcg: Annotate functions in tcg-internal.h with QEMU_*_NONNULL
      tcg: Prepare for easy temp lifetimes
      tcg: Enforce sign-extension for TCG_TYPE_I32 in tcg_constant_internal
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
      tcg: Convert ext/trunc from TCGv_ptr to the new interfaces
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
      tcg: Split out tcg_gen_bitswap
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
      tcg: Generic expansion of tcg_gen_{non}atomic_cmpxchg_chk
      tcg: Generic expansion of remaining atomic operations
      tcg: Annontate functions in tcg-op-common.h with QEMU_*_NONNULL

 accel/tcg/tcg-runtime.h                    |   10 -
 include/qemu/compiler.h                    |    8 +
 include/tcg/tcg-op-common.h                |  556 ++---
 include/tcg/tcg-op-mem.h                   |   36 +-
 include/tcg/tcg-temp-internal.h            |    2 +
 include/tcg/tcg.h                          |   61 +-
 tcg/tcg-internal.h                         |  160 +-
 include/tcg/tcg-op-def.h.inc               |  110 +
 accel/tcg/tcg-runtime.c                    |   44 -
 tcg/tcg-op-gvec.c                          |   41 -
 tcg/tcg-op-ldst.c                          |  738 +++----
 tcg/tcg-op.c                               | 3031 ++++++++++------------------
 tcg/tcg.c                                  |    8 +
 target/ppc/translate/fixedpoint-impl.c.inc |    4 +-
 14 files changed, 1837 insertions(+), 2972 deletions(-)
 create mode 100644 include/tcg/tcg-op-def.h.inc

