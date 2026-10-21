Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E95B606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=p2ybxckb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJX7l-00032X-B0; Wed, 21 Oct 2026 10:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX7i-00032K-Uw
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:16:58 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX7g-0001T3-Nl
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:16:58 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a0e1b0681bso4370165e9.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592215; x=1793197015; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lxIsZjRG7xX/kfwBcVV+Sepp3f0qLgh48ynM1xT10K0=;
 b=p2ybxckbC2/euYkQoctFzp17+FjyD9qm0MsgOvU+Pa/2nucFUQzGqOSBnyVzoZPclQ
 gb9y5muTxwW/78k4jKQRGRv/d5Zw7CT+WpBpydSeevi5XIS63ZKplA4ZYU+l3yWMp9y1
 cfP4tYuH/OdXTugEhKrIRaogNzKyXsNZXNSfU6mxiaVEWJRfON4u6/wvchL+5YkBnxE1
 DLmDDulITSogtp4pK1z0HSUpey0EDY1RuKZTEjZr9WmpNUYuJntHuE5VW1EJhi6nsE7+
 pjqYNGH6fhOiaYf1VD6BTaueJrbDy0jSh5KCVcELhqo+c4mV84dXkxTrPAH2uKnBAe2D
 pbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592215; x=1793197015;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lxIsZjRG7xX/kfwBcVV+Sepp3f0qLgh48ynM1xT10K0=;
 b=DtPEMXffh1iiHL334znxIdXr9kpaAkHtQHcJi15PvidoPhzr8IDEUNc6wkZ2pjMTo2
 3Tp0UdbluTYt0JxkTY8uMcvsk2m6GzVBTQVP6mh2xF9rFJj0kTwyLMOmUTGBbgxS31wx
 CQ4mqbSW7XzqNGHvwBPWXwdUTLupdkAKrPYkRFsXakMnCDczF3zajrXiFhKEDUrS2pJv
 NEkhs0BCtHt9V4dyc67nVblB4Ah+lnEjKmC5bmOutyStb9v1NllgnWck//5Frk8fp4cL
 cFlLETIfble3PLeHAdDEW6k4XF+J9d92/OL9HEeKPEBMHL9L5Zvkju50gCbC/0nSQNHF
 S/nQ==
X-Gm-Message-State: AFq9FYIKcGJ81uEY0XKLeIMNtq4XTdos8FwXoCL94vMFlnW5t3N6iPGo
 zoUo9Fu67bL+fOLYTXC3Vx/tajY8Qy4QeIR8zf2q4/KFNLsDPxGY91YsJZak7e2MAMHmvIURlBM
 YBKlpZP0=
X-Gm-Gg: AYBFou2UI7LVHFZAIuXvagijV7faS7LIJ565jZf5ikZDC9qyceT/2zm/GxS+0Tu4AQl
 bEXsfvd/cA8CVKyUgJEaa9eGslnh66hmu5KTWcLWpoyikF6F+0H2SHcPTk7m24EHtPpxh08wJ0P
 kuOYSFGfS/D09mcvRv37efBVSntlpeQA8zvRW9Wj26rfmpANMR97uTZdC++/KfT9x855Z4VGNvK
 mIvEpm2jhUKaGtK+niawrIG6NThVyX2sa+yDHNM+bXPkCaNkAHlaaEFhtLB4kQC1Xjxs7t7RNaq
 wXIMx3xuET9T+zPwHm8jY1I/Kj+Moc3zyNYDewZRe17a4Y3Z9n5kdMmgzR0C4DF8ToeEUUo4zaA
 ggm3o7ILbLR0l9tTOCvZKZZqIx+nevKSrHxSoH98dZmqadb1jYtC3fsy0eiKaMvXE86rM1IPMwH
 Um+PKF5x4x0cuFCNlhXuzQIAMr//RUIG3XsgfnzOPR/DWH0BAnUUI64axBqqEAgbR+GR/P5br2A
 UjfF0VYrdShit5O4efa3v3jTYrjPZRSdMTim2YrjnW5Xw1tRoxOf/6I0G7uv04VDIFEYFIU+is0
 wt+0PX9QBZVXOlIbqK+36HOcIls=
X-Received: by 2002:a05:600d:8645:20b0:4a1:f377:5c75 with SMTP id
 5b1f17b1804b1-4a1fdd6097cmr34816795e9.33.1792592214698; 
 Wed, 21 Oct 2026 07:16:54 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:16:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 000/100] tcg: Generic expansion of most operations
Date: Wed, 21 Oct 2026 16:15:12 +0200
Message-ID: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This eliminates the majority of the code duplication between
the _i32 and _i64 expanders.  What remains are those expanders
that truly differ between the two widths, or that are only
present for one width.

Changes for v6:
  - No __attribute__((alias)), since unsupported on MacOS.
  - Constants canonicalized in tcg_constant_internal, as pointed out in review.
  - Other flubs fixed, also per review.


r~


Richard Henderson (100):
  include/qemu/compiler: Add QEMU_*_NONNULL attributes
  tcg: Annontate functions in tcg.h with QEMU_*_NONNULL
  tcg: Annontate functions in tcg-op-mem.h with QEMU_*_NONNULL
  tcg: Annontate functions in tcg-internal.h with QEMU_*_NONNULL
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
 include/qemu/compiler.h                    |    8 +
 include/tcg/tcg-op-common.h                |  556 ++--
 include/tcg/tcg-op-mem.h                   |   36 +-
 include/tcg/tcg-temp-internal.h            |    2 +
 include/tcg/tcg.h                          |   61 +-
 tcg/tcg-internal.h                         |  160 +-
 include/tcg/tcg-op-def.h.inc               |  110 +
 accel/tcg/tcg-runtime.c                    |   44 -
 tcg/tcg-op-gvec.c                          |   41 -
 tcg/tcg-op-ldst.c                          |  734 ++---
 tcg/tcg-op.c                               | 3030 +++++++-------------
 tcg/tcg.c                                  |    8 +
 target/ppc/translate/fixedpoint-impl.c.inc |    4 +-
 14 files changed, 1834 insertions(+), 2970 deletions(-)
 create mode 100644 include/tcg/tcg-op-def.h.inc

-- 
2.53.0


