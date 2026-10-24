Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76163606A320
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=aOvpDqA+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKaVa-0002Za-IY; Sat, 24 Oct 2026 08:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qinzhengxiang@foxmail.com>)
 id 1xKaVQ-0002Xm-Ol; Sat, 24 Oct 2026 08:05:51 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qinzhengxiang@foxmail.com>)
 id 1xKaVO-0001oC-HG; Sat, 24 Oct 2026 08:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1792843542;
 bh=OZ0cn1cfhnQpiLeUOFB/RYIlHs7xdzQBQX+Bxjih0PU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aOvpDqA+wE19fYQkn9pDbByCciXt0HEvJx/YbVjwg7+4BG/i25uBXtUWGy11vEz1O
 6NbBAv3/MiXK1hMVxDLVumHN0/5EnVnlsHYF7lUB28p8Mi+mlV46S43+IHcbhA8kmA
 Np0AM7DSj+yifUi/mjDhhwQcWB1SCj55vRVSxWWU=
Received: from ubuntu-vm.. ([122.9.98.96])
 by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
 id 8F108B2; Sat, 24 Oct 2026 20:02:15 +0800
X-QQ-mid: xmsmtpt1792843345tcsx74wlf
Message-ID: <tencent_B260044F72C6F341E58608255B64FCE0AF08@qq.com>
X-QQ-XMAILINFO: NtksVjXir1SbDsJtBvA8zAfTPGmkqzB1s0+RyacsopDxCjJSIfiWLYV6aUx9Yt
 BfN+EQzIciZoAh98komri2yfgc5K25ezNrMenP4KVdkye/2CEV2wS05jHEXRwWuvcfeVdbNLqCt0
 K5i6QT+JlPD40kXfUOfU3xnKgULBrpCypoc5AuZi1EAAu7l8DiwbWSDA55JFqEHAnqCA5QfQjBmk
 F9D+BHoERtBLT6r9DqDzSgeiZPulX3VC1wOvkS2Jwk2Sbc/pS8O9ERsGAsnDjMw2JBmB641XYl2b
 dhGt6PMsPNzbFTIw7qei43IRaiQk6HqIcH4w3lgmPgRFrkkrx97zB7IdP7biRLIjaZ7W8g9uoii9
 bN+BpOwUjMTgC/MHyQzLBOzgDyGMi6ed+A/DcLJJRK8O5Z3uD1iSRZnXMzqAONGa8kjYKODnyY3e
 H698GbBxmixCD40T0rObzqEZBEeaS2l1lgJG/kM6d68zj7bjiZHNhxDKoQJwaPjz4kA97buNx78H
 UUKCuVaZdnRwUHmpqpmSpuFxfdxfEAe5izcEn5XP/+rwvzYXp5Q8n3xu0TN3ATpJKnp+b1D+Z0gw
 ZDedM0Y8jDZaWQz75iISfpmkkQjiZgH7WSIx/65+pDPOG6oC2wVV4p6yoSvZYG/KCBkzYv3PQmK4
 8+OXa6f3cNkjY1vp2MNB/DKccyxYLbF9Wq4CmIve1Ex6t7XVj22w0/YLUyLnOom0SwmSv+Cr4J6L
 gujpOGuoMpkP+OSFZ31uVXzCCxjoh+fp6e14HndBec53tCg0F9YEmxwLWzC2yS76OepT/NDdjTqL
 CWHoKuOaIE0e+YyRVdgLSpPLWTR2ZLEvWbQSHI85rp43OVMwsDcchu2j9NxzcxOZ1PRUzcVS7yWA
 9DkfT0cXCEvYL0RWSiRpeR72GydKAT4DmlkROKhSrneARcsgl7rbMBlMOIr+4jypdfzz9pCCJzJy
 1U+86x0bgLy86BRSxx5joocz0yKHcjUg7O38Vo26NNpJ1slxkWTXvcTd+oT/Khe1Syh5mFy1Ja4e
 w7NKeK2xcxspPks2Vx0u8xpa/NvCcfA5ciz9k1nA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: GavinQin <qinzhengxiang@foxmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 GavinQin <qinzhengxiang@foxmail.com>
Subject: [PATCH 2/3] target/riscv: Honor Zama16b for AMOCAS accesses
Date: Sat, 24 Oct 2026 12:02:10 +0000
X-OQ-MSGID: <20261024120211.236223-2-qinzhengxiang@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261024120211.236223-1-qinzhengxiang@foxmail.com>
References: <20261024120211.236223-1-qinzhengxiang@foxmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.44;
 envelope-from=qinzhengxiang@foxmail.com; helo=xmbghk7.mail.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

AMOCAS accesses retain their natural alignment requirement when
Zama16b is enabled, causing misaligned accesses within a naturally
aligned 16-byte granule to trap.

Clear the alignment requirement and request MO_ATOM_WITHIN16 in
gen_cmpxchg() and in gen_cmpxchg64(), which handles AMOCAS.D using
register pairs on RV32.

Preserve the existing alignment requirement when Zama16b is disabled.

Signed-off-by: GavinQin <qinzhengxiang@foxmail.com>
---
 target/riscv/tcg/insn_trans/trans_rvzacas.c.inc | 4 ++++
 target/riscv/tcg/translate.c                    | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/target/riscv/tcg/insn_trans/trans_rvzacas.c.inc b/target/riscv/tcg/insn_trans/trans_rvzacas.c.inc
index 79bca1e957..7b87f3e640 100644
--- a/target/riscv/tcg/insn_trans/trans_rvzacas.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvzacas.c.inc
@@ -77,6 +77,10 @@ static bool gen_cmpxchg64(DisasContext *ctx, arg_atomic *a, MemOp mop)
     TCGv_i64 src2 = get_gpr_pair(ctx, a->rs2);
 
     mop |= ctx->mo_endianness;
+    if (ctx->cfg_ptr->ext_zama16b) {
+        mop &= ~MO_AMASK;
+        mop |= MO_ATOM_WITHIN16;
+    }
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_atomic_cmpxchg_i64(dest, src1, dest, src2, ctx->mem_idx, mop);
 
diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
index 70c1088338..3d1bd7371d 100644
--- a/target/riscv/tcg/translate.c
+++ b/target/riscv/tcg/translate.c
@@ -1180,6 +1180,10 @@ static bool gen_cmpxchg(DisasContext *ctx, arg_atomic *a, MemOp mop)
     TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);
 
     mop |= ctx->mo_endianness;
+    if (ctx->cfg_ptr->ext_zama16b && (mop & MO_SIZE) >= MO_16) {
+        mop &= ~MO_ALIGN;
+        mop |= MO_ATOM_WITHIN16;
+    }
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop);
 
-- 
2.34.1


