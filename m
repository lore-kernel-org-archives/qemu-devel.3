Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A29606A31F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QZ4eFdwB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLagm-0002xI-FW; Tue, 27 Oct 2026 02:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagc-0002NN-2W
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:31 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLaga-0008DG-FA
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:29 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3ae1da332bcso675982a91.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082567; x=1793687367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WHqD3jPXwrwTC/WBM1Eq/5pdVFWNU0i6avwoEeLZZ+w=;
 b=QZ4eFdwBLRXuZfuLzpAfGi/R1TlCqgPCZ08zDowI/9YoKw839/Ti5BTS+hd3rrP4PE
 Xjz3b9ID48qeYMidycrYuEBA/BwPmk2atk+FKQuJvYCdhhkSp6nOe5CJcTiXxMFFF8+1
 3wodZCrmryk3iBmClgEaTQUfF7BGN32AMQyr6j3e0aM9vAe+cbQUBmSqSmTxKiL8zgEG
 y5YVVQDvwxh0BrH/8HoJ7vbV6ohyLGbTFYQH4LELzRLzoWyxmX04ylJKP3nA900/zxUa
 Hl++VDmrnbEvoim6zD5H1nsO+BLSUfHQ+29WYeuXFeodrYLTAPmSZktfeUY8PISitMp6
 MyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082567; x=1793687367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WHqD3jPXwrwTC/WBM1Eq/5pdVFWNU0i6avwoEeLZZ+w=;
 b=p+y+Xid/ySc3KzTgfrbwrfQDeBtCDyxcsRVscX17AmCenun6WM0zPKdzZCLs0o5Pmq
 JQPm////HGMzR36apeagjGV1kgvh1AZCgrrtC2knOC0Pwb/7dW9WkT7vlHPa8Luwz2GL
 nO4AxgFQuR7yXYeVgPsnOnBfFWp/NWJvEdTRisDmZoD1APLysU39fjieqV2U3BTBzdQI
 JBB99fAR4cCsLays8anM/ef1GchLOLHn335Sq9HET5HuxLaNtU0gQCaWErjHyErSbBrf
 ItfLXbP3AX5qty1xSPfrQOLgaWPJi2uBEO10zfM201XkYeZ2OwbA+Ij0xEdTz3JXN/+D
 8TTw==
X-Gm-Message-State: AFq9FYLNo2MyTmbKVCwnNVtSVmGdLcG7cHqk9Hpn1BSjm9CjKzxY2Jio
 HZuYaiXsDquNSAdXAlq+OFD9sNqY0knKU5WuyjIn/BloPgsarvirHFbtZj0IzQ==
X-Gm-Gg: AYBFou2V9dDxaZWiziyCa1qQBuYRt5KGApMXYXvcoW9NAWXOCYtynHKj539rW6qIBqj
 Kwcrjg/z5hW2fr9xZkrUYHCTDQISz+VolxcHV67BLtlk+ZAooplLPJUyyDF5CjuNaleyYOjvFY4
 jZsVG0E7+jzGXRyGiXstrVsK6uzNQ0YxIlDRNRdJMMw8qnKmaBrFLZjYKC953efxHpG1FmUTS5Y
 LxdXfsmBQagU+bhESy+K5O+unBvR/qYhoSB85gjJLQH2bXo/rtucn9fhJE9DJgEhDWGUuAr3tPs
 B3y7O4EfiahsNpo/4erY9WYNta3+y36PfUDkpJvzyIpW/lgKPmpnBuyZw3YsCoBzE+V91jkLSQ3
 U7YmcbjvOlrtyvNc4faELLqoQs0thGgHVxBx5cpFVovcWKu6CLmCjpGSG6N/3C/3GMUF789Jgnl
 GqPlyehUiJr0WNIV6eyJ8voZ1zp3Ava8Y6OPGw4/IQRW1EReb+TX9ceb8ruPL5cP1+lJl7VDyXf
 eUy4/FObl1nLaeJgJxXpcankexPdYVW7dl7LGvvfq1bnQKHxdry5urNONw8thnIRKOQKxcKfoZG
 3cnEyza00qa9Fy7f7Yc=
X-Received: by 2002:a17:90b:6c3:b0:3ac:8897:7b88 with SMTP id
 98e67ed59e1d1-3adeaf9c9c2mr7702901a91.58.1793082566668; 
 Mon, 26 Oct 2026 23:29:26 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:29:26 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Rick Richard <rick@sloservers.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 19/29] target/riscv: Use TSO barriers instead of full barriers
 for Ztso
Date: Tue, 27 Oct 2026 16:27:58 +1000
Message-ID: <20261027062808.1995205-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1030.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Rick Richard <rick@sloservers.com>

With Ztso, plain loads and stores follow RVTSO, but the barriers
around them use TCG_MO_ALL.  That also orders a store before a later
load, which TSO doesn't require, and is expensive: on x86 hosts it
adds a locked instruction around every load and store in a
multi-threaded guest.

The barrier after a load now only keeps later loads and stores
behind it, and the barrier before a store only keeps earlier loads
and stores ahead of it.  That is all TSO needs.

Signed-off-by: Rick Richard <rick@sloservers.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
Message-ID: <d6db9f89-36d6-436d-a915-407cd28e1778@sloservers.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/insn_trans/trans_rvi.c.inc | 4 ++--
 target/riscv/tcg/insn_trans/trans_rvv.c.inc | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/riscv/tcg/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
index cc1b5dbbadc0..4784ea1607e7 100644
--- a/target/riscv/tcg/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
@@ -424,7 +424,7 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
     }
 
     if (ctx->ztso) {
-        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+        tcg_gen_mb(TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_BAR_LDAQ);
     }
 
     return out;
@@ -485,7 +485,7 @@ static bool gen_store_tl(DisasContext *ctx, arg_sb *a, MemOp memop)
     TCGv data = get_gpr(ctx, a->rs2, EXT_NONE);
 
     if (ctx->ztso) {
-        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+        tcg_gen_mb(TCG_MO_LD_ST | TCG_MO_ST_ST | TCG_BAR_STRL);
     }
 
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
index 14ef961607f4..7e1295f33e7d 100644
--- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
@@ -731,7 +731,7 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
      * around the loop.
      */
     if (is_store && s->ztso) {
-        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+        tcg_gen_mb(TCG_MO_LD_ST | TCG_MO_ST_ST | TCG_BAR_STRL);
     }
 
     mark_vs_dirty(s);
@@ -739,7 +739,7 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     fn(dest, mask, base, tcg_env, desc);
 
     if (!is_store && s->ztso) {
-        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+        tcg_gen_mb(TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_BAR_LDAQ);
     }
 
     finalize_rvv_inst(s);
-- 
2.55.0


