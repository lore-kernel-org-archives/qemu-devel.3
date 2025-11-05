Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E18CCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 13:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGdnq-0004xL-VF; Wed, 05 Nov 2025 08:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vGdno-0004wm-Su
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 08:43:56 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vGdnn-0002vM-B5
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 08:43:56 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b6ce6d1d3dcso4625520a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 05:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1762350233; x=1762955033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D26vXv+8Ed1orfqhFfArUAxk2oGjpGYqrtarHGtxK4I=;
 b=hQzfOsRa1w0uKpk+nrcPIdYsJp8PVf+bc0KXwihoch9HQo/J8AWTiu5Op+T3BhAwyZ
 03uhi01R6B22SjW8pnrpJRNmna6M1CmkfL4F8SI/pfz5v+mAqmuR1/Cv6DLteQ6PhEsf
 at5NNEJcHpmcAOBOhK2wx7n5tHpGuHUEji9AA7Gi4Ql05r4hxJgqeqLRBla0REql5a8C
 pR9mm6zNXWZIFsKc6sASsAWsNGy45tO4pgm8F6otRwcnTqqipXK2snRtb2Hp5TAAPjLl
 JijpEtQuNdWYPJMloFvnn/NuoA8nBoosDJ5fRJ7pt+wXA5Pcr6elaIa8hHMdSh8kI7UB
 qKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762350233; x=1762955033;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D26vXv+8Ed1orfqhFfArUAxk2oGjpGYqrtarHGtxK4I=;
 b=fkQat9ho1FgXvcQ36Evu8BBfaZW91njCxSWQI2qi4o4O1vb/fLsPM0f+4csP4xSS7p
 YAewxZknNcGaj1JLENDDh1ALyNm4WVV5KJPiZlwd/3PwltLfTz8b+XRo1aW+o9jaZKkA
 oTWnzwnjZ7dmwGVptF33u1uNSmVKNA/xdvOG5lMfOMmcp2BvhMnRtoEgLFeVe0jjzndP
 J0q/t+frHIZXOdbz8lX/xqQLfyEFxIE2Svr8WFYm7BMkev3nswvKawuWj+rvTCJSDrLO
 8jsi4LNGEZV+EwnGBPS9bCAFsxg703GMFokkl9WcE6NEiCjDZxdlkAHcyfhzw584foyA
 HgHg==
X-Gm-Message-State: AOJu0Yx99K7B6aXNpWboI+bTg+H9kwhYoR/csz2YfEtaOUTJ2s8io5BM
 leBceao84HW9U4MReWYcjYyp43EEjjO2jSiPyIO9EW4wr0hup/mDn/4IhfxniuaNL51oX0h4mSK
 D1sBxSItnBgryhud7TFQjkS9Ay49vpZzDZKdSxBxFHAB846iJQXoOSanzI89JbO1EXp/AW57e00
 ymFXu6im0u9SKQnSKYxsEpxdw2Ixz5pZdz1xIkIAdbmQ==
X-Gm-Gg: ASbGncsfa9nXXW0YUU7bnlbzK2jFfJzClFYaNr1CeaS3VU5ndMV4rIGUY1lKWkequuu
 KntHvNiS/OVJ5k9qrZzDj/erCMDWFkaH5MaPRF6BNRUHHaWWmbn1wfvrbs/XhAxPkRpJ/IIgtVm
 +Ns7ge3eYqMiijwlCgfKR0qBMHzO4cEu8PvTBVnFpWjSLzxAqyXZp7NMA4v2CEjYO44md8mqizD
 tje7v23usAIfSLHJi3JXkkcuuuz3KGcyuVRM6zavPv68kQJu/k7JvBN4pyJETWoYjdUy2MnJxnZ
 uem2YdwnnFHeEr6Pet73HCJV1lsrlPxrv0PaJAB8ake8CYOw63a0Gh8p87fdDR/EW1Y0yiBlqAr
 jvP4MNeFhnqY4fzUfhqNQ8UFd0i7ftQ2UZDXyVclrEYdsIRKhijquFpwXlg17cF2ThG2c+DOiTW
 1Yj7u4XKlVXkcGDKRFXSd1R+gUInzOZd/Yr3PNRGbsB+7fxhVZw2yrmMk=
X-Google-Smtp-Source: AGHT+IGYah24Y0s/NK6v+G6at5eKCyU5E4fM7XlHmy4bkrY2d+b1grd+elfj34qh1Sopd/vKvj5z+w==
X-Received: by 2002:a05:6a20:3d95:b0:349:c80b:d5e9 with SMTP id
 adf61e73a8af0-34f8400875fmr4208076637.23.1762350233055; 
 Wed, 05 Nov 2025 05:43:53 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ba1f87a6155sm5556501a12.29.2025.11.05.05.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 05:43:52 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH] target/riscv: Fix PC sync in trans_sspopchk for CFI exception
 handling
Date: Wed,  5 Nov 2025 21:43:31 +0800
Message-ID: <20251105134331.2865581-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x535.google.com
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

Move gen_update_pc call before conditional logic to ensure consistent
PC state regardless of execution path.

Previously, the host instructions generated to update the cpu_pc were
only executed in the failure path when shadow stack validation failed.
This created inconsistent PC synchronization.

This inconsistency caused issues in CF_PCREL mode where subsequent
instructions calculated wrong relative offsets from stale pc_save
values, and could lead to incorrect exception return addresses.

This fix ensures PC is always synchronized before any helper that
might raise an exception, maintaining consistent translator state
across all execution paths.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
index 0b6ad57965c..f76697b8a11 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -32,6 +32,9 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
     TCGLabel *skip = gen_new_label();
     uint32_t tmp = (get_xl(ctx) == MXL_RV64) ? 8 : 4;
     TCGv data = tcg_temp_new();
+
+    gen_update_pc(ctx, 0);
+
     tcg_gen_ld_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_qemu_ld_tl(data, addr, SS_MMU_INDEX(ctx),
@@ -40,7 +43,6 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
     tcg_gen_brcond_tl(TCG_COND_EQ, data, rs1, skip);
     tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_BCFI_TVAL),
                   tcg_env, offsetof(CPURISCVState, sw_check_code));
-    gen_update_pc(ctx, 0);
     gen_helper_raise_exception(tcg_env,
                   tcg_constant_i32(RISCV_EXCP_SW_CHECK));
     gen_set_label(skip);
-- 
2.43.0


