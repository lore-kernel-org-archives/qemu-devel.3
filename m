Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8C3606A334
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XPKQ+AvH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJI7-0002JL-06; Tue, 17 Nov 2026 08:32:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTJI1-0002HG-HE
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:32:03 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTJHy-0000cQ-Bv
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:32:00 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso4899303f8f.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 05:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794922315; x=1795527115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=g/HhL0icM5bUtoKj5yDnzoPXIFsvViyLIg4hdd3bfBA=;
 b=XPKQ+AvHGdISp+xuHOuhoeET3AA8IcMhsIEwaTeagCx+so1eUXp8Cq0yhZupqHqqJH
 wCNhqLa8CB9m6rb6Y/Agw8kPnDDACBmLgNNnQyk6mYqrXvIhuyGmH6RFX28Jk5tVO09d
 dU7w2pEjWSdFIRe/TZEEUvIIZ60q2PIMYWL/ON/k9kRItZT77hv/NudMeZeKVhCs5GLd
 z7b5SwV24W9fZzxiaQRpRQeK5+SgRD7OhqGM/VPiA41ZUCn09gaa0nhRB2QqA3a+pM1v
 tNXzPPOU2f0HsYrtlnDlbO7XUhaKO19r/V+aQB17vbwHqvWlp24EoEneZt8l9/aPkZc9
 8fFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794922315; x=1795527115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=g/HhL0icM5bUtoKj5yDnzoPXIFsvViyLIg4hdd3bfBA=;
 b=qqfj8S53y4n1Yu7BVW8KAVyRfrUi280qCfIFy1MO3NnbMQdz9M/tUmj2g8verFI3+p
 hlebYO9yCgha9W9cj2nioU6sP1sdx8kKwB/pbHgF/at7bFn8R0XX0re7TGsmxcMZ9Qj5
 SJdbOCvmlR4NNWGH5LMvWZe0+WijgKI0H4t7N0jwSMGI7qtFC9bPjNu0Z6mBEUMp+VGI
 bGSB0MChYl9rqVhhaQpm31xRDNAA9Moz4mcx+iMH9scAcdctiz+QBWPnpi7X2PNYJJeg
 BZzjzvSPrD6LyMuNUqVbb1hxR8LHeD2uNGIILOaGvlJIK7jQ8qe4o+lzIdsTztGB2lsr
 KCag==
X-Gm-Message-State: APuU4Z+mGuRPqoTiH5KdbQ3QdiwMkl2zdi8Yg1kiFtjTb5Hldz1RKiTG
 EguNmO4HhIBYtoI7ztC0crnpPU8YrmZ3bNF6VVdpFOTxLimK8z649e5iKnDwF3B70ZKz+Q3VEl9
 rCqkpA4o=
X-Gm-Gg: AZFdTZczAgir9FGTE5PIcuKg5JLSWEea2lYagYjCmKZCSdGlcBb0e9HCBj1YCDHH5vb
 2K3ol8tRdK4+Z4Hdy75Hiz+Kr8syChYtk26SuxQzWOuMgmNQK22VsNCSUPwQz209FjF4T2qHNnv
 lbp8+YWS12mgaAvTI0+FEIkFjlFw4H7eDoUgwn5OcQO4A4f489hApz2Sw3L6R23l+sGY9Z5dZ7D
 Sj7nUrTFHleX4PxcamkMo37BeBhT/VzMlZkoAUuygqIIFtrqsDKkJVzMHEe82nXIRa9DRMG/OO7
 DhWOFHpjwDFpjJi8fI2QA6bXNaiO446YcfXTQDS1UQBNSb6S1PR2QMBM1HkFA6az/jmZuqpnTyQ
 LOsmGqUXXXg4J9IETZhP5fQdyrMJODxD0zsdzaejuOwNt5zXEu1N75nWz+bmSPaXMXy1gfEtKPZ
 89VCDi911a9gOtOtjc7MNPmQkR188/ZIuPQWF9c6sDES1vOCodP8ayz+aWp8tR0Slo1jhSIcmEr
 iiQUfG/V9CRkSRbESWMsY6Its3v9MUWO0G/ZeAENVLjhiraA2Bxunwo9f7RwyvICnPeRZsSoEXv
 Jp5PyJ+giUH6RO/egvK5ztfox4ZG+T33wCdj2mzI8ZMXfoBQeI0fVpVx+2C1ygLdFX2bDpQj95z
 Qh3OFCQUnbGDtrEJ7MM7KnwEEu0y8fI6ah6NHO8LOv4MbPO7ja50h2tw=
X-Received: by 2002:a05:6000:1a8d:b0:4a5:564a:6d50 with SMTP id
 ffacd0b85a97d-4a5564a6e81mr1843350f8f.2.1794922314977; 
 Tue, 17 Nov 2026 05:31:54 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c8a77sm28516886f8f.49.2026.11.17.05.31.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 05:31:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/8] target/riscv: Fix RCsc ordering of Zalasr store-release
Date: Tue, 17 Nov 2026 13:31:45 +0000
Message-ID: <20261117133149.2108068-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117133149.2108068-1-peter.maydell@linaro.org>
References: <20261117133149.2108068-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

The Zalasr load-acquire instructions carry an acquire-RCsc annotation
and the store-release instructions carry a release-RCsc annotation;
the extension has no RCpc variant (Zalasr specification, chapter 2).

Per Rule 7 of the RVWMO preserved program order rules ("a and b both
have RCsc annotations"), a Zalasr store-release must precede any
subsequent RCsc memory operation of the same hart in the global
memory order.  In particular "sw.rl X=1; lw.aq r1=Y" must be ordered,
which is what forbids the [0,0] outcome of a Store Buffering litmus
test that runs this pair on two harts.

gen_store_release() only emits a barrier before the store, which
orders the memory operations preceding the store before the store
itself (Rule 6, release semantics).  Nothing prevents the store from
being reordered with the memory operations that follow it, so under
MTTCG the host CPU may execute the load-acquire that immediately
follows a store-release before the store has left its store buffer:

  * on an x86 host (TSO), store-load is the only reordering the
    hardware may perform, and it is exactly the ordering that is
    missing here;

  * on an aarch64 host, no dmb follows the store either.

The defect is easily observed with a bare-metal Store Buffering
litmus test on a 4 vCPU guest: "sw.rl X=1; lw.aq r1=Y" on hart 0 and
"sw.rl Y=1; lw.aq r2=X" on hart 1 produce the architecturally
forbidden [0,0] result in 89881 out of 100000 iterations.

Fix this by emitting a full barrier after the store as well, which
mirrors the FENCE translation.  The TCG_MO_ST_LD bit included in
TCG_MO_ALL makes the x86 backend emit a serializing lock-prefixed
instruction after the store, draining the store buffer before any
subsequent load executes, and the aarch64 backend emit dmb ish; the
store therefore becomes globally visible before any subsequent memory
operation of the same vCPU, and Rule 7 is satisfied.  This is
stronger than Rule 7 strictly requires, since the barrier also orders
the store with respect to subsequent non-RCsc operations, but this
matches how QEMU already implements FENCE and keeps the fix simple.

The load-acquire side needs no change: the barrier emitted after the
load already orders it with all subsequent memory operations, which
covers Rule 5 and the remaining Rule 7 combinations (load-load and
load-store).

Cc: qemu-stable@nongnu.org
Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Co-authored-by: TANG TianCheng <tangtiancheng.ttc@alibaba-inc.com>
Signed-off-by: TANG TianCheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc b/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc
index 79b0b2c63b8..28d9b13c55e 100644
--- a/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc
@@ -86,6 +86,14 @@ static bool gen_store_release(DisasContext *ctx, arg_sb_aqrl *a, MemOp memop)
     tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL | bar);
 
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
+
+    /*
+     * Zalasr annotations are always RCsc: per RVWMO Rule 7, the store
+     * must also be ordered before any subsequent memory operation,
+     * e.g. a load-acquire in a Store Buffering litmus test.  The
+     * barrier above only orders previous memory ops before the store.
+     */
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
     return true;
 }
 
-- 
2.43.0


