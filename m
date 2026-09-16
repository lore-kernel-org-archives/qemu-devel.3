Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2141C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pJF-0000y6-IS; Wed, 16 Sep 2026 09:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJD-0000xJ-8f
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:19 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJB-0000G5-BD
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:19 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39dbdfaef3cso842943a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563855; x=1790168655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JQYLLI7HbxSPsPAy97T/1IEMfz2BS6ZzFdCraMpZnP0=;
 b=pxvdyF40xJk8+1WUnPJQnImE3LxdM3uEvlA79KK6zZos18KRti6GECR0dTkjFEgXk4
 YW7zMSFBh1jBIqieKnExeJx3VcvKrEi7ZKS8lvugH26SqQxfMwe1kVT158cwOxETHyJU
 6XQ4kaJIxNAxIGxYopGxe2GDP4eJagZFsFgVfxjMMudlOAkbD2hjVqeZbRB5uRtV03+k
 PLMTT5uPcCjaLpfh7hW3weM+qC26DMdpWuTvgDFLgp0xfe37DNBi/fTZhJVGaUL3YgAE
 Qgyc6QHz70BTKR9dZtjEmy8LqpJGFnjEthaMYabqwcup1ytSRXevCidw4eH/0quuYMV9
 e5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563855; x=1790168655;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JQYLLI7HbxSPsPAy97T/1IEMfz2BS6ZzFdCraMpZnP0=;
 b=jPup/W18oD0i0ff7g8p/GJQ4eCeYzpdxJDZ0fLkjLcYsfXpFUeTzgGUyfm8ptfjW7p
 RM6c8L5MaJAxmWV9iH9cT7BYDI2MoZH3O1HlztJZLHGK+UhPrcTMKAVdscPx1QD9HqPj
 trobiq0/tYGh1zDSq1iAhvthdwPNmnOoQA0lcm9PtHwjZjo++HadFfjI6V7IqL0Uw+R0
 21yNLDuxdn9UX5soNBSmsrzdJ3by0vm9u2KT65PdlTapZK/kkMD48okmGarfLoQxLWBz
 cS7Gm2zuul2WsDHuxazlPy+mFLSXfDAiiUavdgWlA/fkHG6GIdpI3nXOGSrpsA72He9w
 vqZA==
X-Gm-Message-State: AFuF++maO0SwHmWry3/a7/oAC9BEL3k2rmd9eiw+DJSJg3iUkfdzE0iJ
 PkekMIYOiLvahZHT7+nHg1BiZYjvI9cY0m6mJl/lN1uePsQu6FSnANhMaoRXmHZfFiicHCUVT9i
 FXvHLqB4=
X-Gm-Gg: AYBFou1ESywyqCp9KG98Pnfoz6QfvhvT6zcGt7LoWWXp5BxvaeUbUaMRTNNPKuF64Sd
 DbrJPA3TkIvWlAbqAgTnld5IzP3mG2rTqgfsIAz7F1i6Yw6+bk0gA/OLWDNSlJLVM7X1YdLgswA
 +KFj3EpvszARmcx9G/vJKmJMYOzl5jUWVWEWxh5SqgQituGtbg8OAHiOsjt3VnWWoc+N/u9R7e7
 ati997r7ispMlevCZ3KNjaqt+vJQvq0zYAXCuQ0qQTjkheFO3L0sXxr+f5l4MxTaDo+nKo/98di
 58haEXuBvoC/AFw+EhcMyxou8NbHVXOA9qUmy7zGp15FVsNSIbldnNRCa/zk6wPmJL8yK0//vKx
 NWqeSbOatqUYuYh+roPU1gUgjSoMWVSVVl8gn/8NQ99ymlBjRbv6s3eYpGUNwOgVyw/L/rWX/UG
 jg+bKdOVgiQ8QstozJh32IxSTJBlczZNF5XEanu8Pwtsp6xUE8eoWh01qTsVlC4t6VS6APRxyu5
 V33CdA1j5cQ09dmr9w=
X-Received: by 2002:a17:90b:4c09:b0:39d:ec44:28b8 with SMTP id
 98e67ed59e1d1-39e1e4674d9mr5760491a91.13.1789563855395; 
 Wed, 16 Sep 2026 06:04:15 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/92] tcg: Generic expansion of most operations
Date: Wed, 16 Sep 2026 03:02:35 -1000
Message-ID: <20260916130409.3382710-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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

Changes for v3:
  - Introduce and use QEMU_*_NONNULL.

Changes for v2:
  - Use DEF<n> instead of DEF_<fmt>, which requires even less boilerplate.
  - Convert a few more operations which are made feasable by the above.

Requires 
  20260914220000.1757165-1-richard.henderson@linaro.org
  ("[PATCH] target/i386/tcg: Always initialize CCPrepare.reg")
  20260914230901.1781309-1-richard.henderson@linaro.org
  ("[PATCH 0/6] target/mips/tcg: MXU fixes and cleanups")
to build cleanly, as the nonnull annotations break them.


r~


Richard Henderson (92):
  include/qemu/compiler: Add QEMU_*_NONNULL attributes
  include/qemu/compiler: Define QEMU_ALIAS
  tcg: Annontate functions in tcg.h with QEMU_*_NONNULL
  tcg: Use QEMU_ALIAS to define most tcg_gen_*_ptr
  tcg: Use QEMU_*_NONULL with all tcg_gen_*_ptr
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
  tcg: Split out gen_extrl_i64_i32
  tcg: Split out gen_extu_i32_i64
  tcg: Split out gen_extrh_i64_i32
  tcg: Split out gen_ext_i32_i64
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
  tcg: Use smax in abs if available
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
  tcg: Expand missing mulu2_i64 during liveness
  tcg: Annontate functions in tcg-op-common.h with QEMU_*_NONNULL
  tcg: Annontate functions in tcg-op-mem.h with QEMU_*_NONNULL
  tcg: Annontate functions in tcg-internal.h with QEMU_*_NONNULL

 accel/tcg/tcg-runtime.h                    |   13 -
 include/qemu/compiler.h                    |   15 +
 include/tcg/tcg-op-common.h                |  597 ++--
 include/tcg/tcg-op-mem.h                   |   20 +-
 include/tcg/tcg.h                          |   59 +-
 tcg/tcg-internal.h                         |   38 +-
 include/tcg/tcg-op-def.h.inc               |   75 +
 accel/tcg/tcg-runtime.c                    |   58 -
 tcg/tcg-op-ldst.c                          |   54 -
 tcg/tcg-op.c                               | 2966 ++++++++------------
 tcg/tcg.c                                  |  214 +-
 target/ppc/translate/fixedpoint-impl.c.inc |    4 +-
 12 files changed, 1708 insertions(+), 2405 deletions(-)
 create mode 100644 include/tcg/tcg-op-def.h.inc

-- 
2.53.0


