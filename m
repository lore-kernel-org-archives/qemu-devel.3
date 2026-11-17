Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E9A606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ik/UoI2b
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJI7-0002Jj-8T; Tue, 17 Nov 2026 08:32:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTJI1-0002HF-HD
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:32:03 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTJHy-0000hN-CJ
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:32:01 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4a2f4ca0dcfso763301f8f.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 05:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794922316; x=1795527116; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8khAikzYPXIWIZdUGIg72IOa1wY2dK1px0iM6iIku6k=;
 b=ik/UoI2b/uqM+kYSWG07YZugaHqQNWjiu9KFnxr+lz2K9DcPXcl1O1otxmv+ET/0tB
 6Ukmr70H+ciC8hY5yY+8V8LeghT7O9i4HYZuCgAjvQa5V3kKCz/B4PjnAGw/UqlZAyfJ
 AcJe4g+GMnsp+b9ZrROYQDlUemH6YqOAEuGXNy07beSFnxQnWlDolA+zsRXbRpzPEzxx
 4PTeiDsExPGnuPRKT6sLd4dpxoz4oAqkIdbHJw4sqZf8UtWSj+yfOXljyzwTFN6TQdtj
 qZbGLdHdp7u7ak1I0EX64nOm/Dc0SeeQiIriusWDBEewKtWO8D5roR8o3HltyembzD7L
 K9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794922316; x=1795527116;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8khAikzYPXIWIZdUGIg72IOa1wY2dK1px0iM6iIku6k=;
 b=hawlZBTEEFdsli3yoHNFGUPd/FQuZ4Iz2B2753nM1d6+9eZZlldu8EhmmYjshZGLV2
 EY2cjmYU39994TCAC3qYaf8xSYzWKZ0QoniIM3IxbYlGGfhgAmhRSk8RmC8uZqV50Fdi
 H5F7RNR/rfsnM8Crpgt09iiyxgafVtYit4TYb8kBbL4oK4MRWtNbVAEBVTDCXsqlDePz
 6B1BRmspuJ+7N6j0BOliMs8YIPkX+vMEfwhGUbRP8ITroTfqqDmXw1H60bJpSxG7gIEu
 2Gcy2OT6F9M2jXO1hZklzIKX1Mo/g1nBTnKtrw6Xt+zQih8YdqUZidCMCZdIfD9LmJ9+
 kApg==
X-Gm-Message-State: APuU4Z+tS3lqLRSwNd7QcuObbZqifLAUj8iT41ZO8dp+GRoZKi8aeh/P
 rnXQeP7lbWphuUBsAuAh2BCUE2x5focc78dopTLBGXJhn97cJOLW4SfeZb16T+nsM63bwYCdBhU
 yqrqHW58=
X-Gm-Gg: AZFdTZfSTep3dNorKjSrVx54xL9ZyPJNduchBUvJ2EWg6vE8WkSoa3u6hzzdlamkEL2
 tFoEt5xb1+xi9Jz8VcAUyUZNwS47Mh/CT//ZndEgv4w2HyTnda0ublloRzDgRxuvX6QzqoSYYtm
 2McD7xxntHEIyBXO29aEvqkpXRrUn0hXs3YXAE6EWWEucYEVjKtjKT8217c2jmU5EasI+4m4RVL
 I2XK0VTdmB9GkeL12jDPC78/dKxCnwL9YqfT0djFaYj4WMR9qboeZABJPPConzme2+x0I2fPvQ8
 MB7m5H9YrxqVb9gSoiS8Kt6tCIB2z1t1pEUUgkT2dCr0Mho9xWDbaOQ2xfbN+sjQmQNh0C2+n/K
 WWCrOxFrvgn3kyYpbu7oQcjb8707jcZo99udEGeFGQr97DhH4JNV1TBVtdgAYameVYMSfiOIx0N
 3YuVuze+aCmVAxXzwwR4Uyh/XcRclCzST0MBSKzUUIGcP9bfb+dlnYyKqcLgk/577k+0V+fcfBE
 6wm+7byqh855dZTo57ZdJ9Hc0ZhNPNWr60zmoxL9Ad3TE+juFA/CBz3jx9ftBSs83wAMpCBvpJG
 tiaOwK99xAVc+iREVCvrwamgG++ykdNWN6VCHOEyAsmx+n9Q57WWydf6pNtxPsZLNsudVT4AxUs
 A37hhJML2vF6YmUZ+rR+B58EABkRfQ82M5aOegEYC2E8dcWfRac0JkIQ=
X-Received: by 2002:a5d:59c9:0:b0:48e:5071:420 with SMTP id
 ffacd0b85a97d-4a378f8daccmr5713307f8f.2.1794922315963; 
 Tue, 17 Nov 2026 05:31:55 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c8a77sm28516886f8f.49.2026.11.17.05.31.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 05:31:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/8] target/arm: Fix RCsc ordering of store-release instructions
Date: Tue, 17 Nov 2026 13:31:46 +0000
Message-ID: <20261117133149.2108068-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117133149.2108068-1-peter.maydell@linaro.org>
References: <20261117133149.2108068-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

The Armv8 memory model has no RCpc store: every store-release in the
architecture, including the AArch64 STLR and STLPUR and the A32/T32
STL, STLB and STLH, carries RCsc semantics (Arm Architecture Reference
Manual, DDI 0487, section B2.3.8 "Acquire and release semantics").
The architecture therefore orders a Store-Release tagged RCsc before
any subsequent Load-Acquire tagged RCsc of the same shareability
domain, which is what forbids the [0,0] outcome of a Store Buffering
litmus test that pairs "STLR X=1; LDAR Y" on one PE with
"STLR Y=1; LDAR X" on another.

The translators only emit a barrier before the store, which orders the
memory operations preceding the store before the store itself (release
semantics).  Nothing prevents the store from being reordered with the
memory operations that follow it, so under MTTCG the host CPU may
execute the load-acquire that immediately follows a store-release
before the store has left its store buffer:

  * on an x86 host (TSO), store-load is the only reordering the
    hardware may perform, and it is exactly the ordering that is
    missing here;

  * on an aarch64 host, no dmb follows the store either.

The defect is easily observed with a bare-metal Store Buffering litmus
test on a 2 vCPU virt guest: "STLR X=1; LDAR Y" on CPU 0 and
"STLR Y=1; LDAR X" on CPU 1 produce the architecturally forbidden [0,0]
result in 6 to 7 out of 100000 iterations, while inserting a DMB ISH
between the store and the load on each CPU brings the number to 0,
which validates the harness.

Fix this by emitting a full barrier after the store as well, for
STLR/STLLR and STLPUR on the AArch64 side and STL/STLB/STLH on the
A32/T32 side.  The TCG_MO_ST_LD bit included in TCG_MO_ALL makes the
x86 backend emit a serializing lock-prefixed instruction after the
store, draining the store buffer before any subsequent load executes,
and the aarch64 backend emit dmb ish; the store therefore becomes
globally visible before any subsequent memory operation of the same
vCPU, and the RCsc store->load ordering is satisfied.  This is
stronger than the architecture strictly requires, since the barrier
also orders the store with respect to subsequent RCpc operations such
as LDAPR, but this matches how QEMU already implements FENCE-like
ordering and keeps the fix simple.  After the fix the litmus test no
longer produces the forbidden outcome.

The load-acquire side needs no change: the barrier emitted after an
RCsc LDAR already orders it with all subsequent memory operations, and
QEMU deliberately implements the RCpc LDAPR family as full load-acquire.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4872
Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 13 +++++++++++++
 target/arm/tcg/translate.c     |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 941254983e9..49472f7d975 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3686,6 +3686,13 @@ static bool trans_STLR(DisasContext *s, arg_stlr *a)
                                 true, a->rn != 31, memop);
     do_gpr_st(s, cpu_reg(s, a->rt), clean_addr, memop, true, a->rt,
               iss_sf, a->lasr);
+    /*
+     * STLR is an RCsc store-release: the Armv8 architecture orders it
+     * before any subsequent RCsc load-acquire, which is what forbids the
+     * store-buffering litmus test.  The barrier above only orders
+     * previous accesses before the store.
+     */
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
     return true;
 }
 
@@ -4429,6 +4436,12 @@ static bool trans_STLR_i(DisasContext *s, arg_ldapr_stlr_i *a)
     /* Store-Release semantics */
     tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
     do_gpr_st(s, cpu_reg(s, a->rt), clean_addr, mop, true, a->rt, iss_sf, true);
+    /*
+     * Like STLR, STLPUR is an RCsc store-release and must be ordered
+     * before any subsequent RCsc load-acquire, so it needs a barrier
+     * after the store as well.
+     */
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
     return true;
 }
 
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index c1970f93c8f..20a58a24134 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -4296,6 +4296,12 @@ static bool op_stl(DisasContext *s, arg_STL *a, MemOp mop)
     tmp = load_reg(s, a->rt);
     tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
     gen_aa32_st_i32(s, tmp, addr, get_mem_index(s), mop | MO_ALIGN);
+    /*
+     * STL has the same RCsc store-release semantics as the AArch64 STLR
+     * and must be ordered before a subsequent RCsc load-acquire (LDA).
+     * The barrier above only orders previous accesses before the store.
+     */
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
     disas_set_da_iss(s, mop, a->rt | ISSIsAcqRel | ISSIsWrite);
 
     return true;
-- 
2.43.0


