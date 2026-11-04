Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1EE606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UJ1lXWMl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOVqP-0005Bv-Px; Wed, 04 Nov 2026 02:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1xOVqN-0005An-Ev
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 02:55:39 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1xOVqJ-0000AV-TW
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 02:55:39 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2e831e86ebfso2779365ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 23:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793778934; x=1794383734; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FI1Dc+Zcf8G9GtH62lYeDaeCt1po3M2JxcIMockyW0g=;
 b=UJ1lXWMlxUot+bNk63CMZC9RC/neCv+GEdu3H7I+IfpdT9ASqu/IzJMyml5LHJIUXY
 YqaAJB6M6FtswnA0TE9cymyup1kTJLRwj5WX4JUHglaZ7cYKKqVgOODDu6YJt1x25MI6
 3q44EgZfpHyAJqMmiD7KoWu1bm45dn44NqWbl1Aj1YfwFL7IfSdf2wqpCPCLQjo2iyt+
 YuUJ+lfLBz/Ck7wljGL6VLhaXo46f35tsEK64KzXhsklrK85q2lOKTFwEvYDkjLMF1Mq
 oCzEsHT4M/WfiagJnGeV9C6W2IBncT3lsLvFeR3weDnczgwzKfK3k0fDb6SEyz4QAK26
 Lafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793778934; x=1794383734;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FI1Dc+Zcf8G9GtH62lYeDaeCt1po3M2JxcIMockyW0g=;
 b=GRnanM6rURcxc8B/NL+dpoHKTC6tz0XFJJFjB5NRDQjN4JnRBnUA0PFnzT5frtRTvf
 dJDVoPLzXe0XvvK5uMqqhoefqqV8azbsWWaSNQt5U5bye7DKB+ceWyuXXNiit7ffOQfa
 gK/ATmW+fqheI5SwMa7OcVj4q63VK/DABR6BAyY6iAn6Mli9n8oe4lrx9iECV88Wi6ks
 TmUS78AEzafJ/bxf4eRIlqzYGGZhokdCbJRP4X8YC97+j4/Tj+3Jjv2COiRyIupUYWLs
 ybIoua4zO9w/23hsrMdbf//Fo3BwoxSv1M3zdyhM5MZh8mfXfluaOMQLTJzqYHCZoQAN
 j5Gw==
X-Gm-Message-State: APuU4Z8IkrQ7XMsCfpCNK2V4+cpZ2p/EvHW7cSRtld09twsGQ2Vw/bx4
 QXzaZ+FS2smF7B0UkZqithD4Eo5Fq6kc7qKP9kJYoO4RHDn5vy7PE2HD
X-Gm-Gg: AYBFou0eTsoeeS8B8BK71marOVJsFa7Gkk5B3JlVzJNpHHgEboyxucQf7Q89GiFRUpT
 JKF6TYi8FSMSVzm0yh648FggPwfojaG6zOP3xfPdh8Yq++Cla1Lwi2lsE2sEKPSDenxYHecjJfb
 NHixKJlIPKJ8DxQNlD5yj4ZB0JT8Ax4aiR1jxHBiuroo1zRH0EKwBHHTDz9CdbMbTa0lkuKq/RA
 RUN1CIUGw3zHWosjz3s7LkOdbr/ZwrVLREgXWkr1Mn4S0hTQeUeSduBvS2W2prffjVTHYWDh/oc
 qFkblvI+d3gxOwoacJyl453477pBbk61eDm1W4hMsbzfKifeFOUahm7Y/k6MyeZ9qC2agp22lKA
 TR7N/nSMxNtdxo4ki/kilTbOYooIQ8UpJK0ypW1WYByDZS9fs7+hsJp3flyAyC+21S4DLwJrz6i
 KuXQly+1NENTWYSfRObbJ2GKkQHdsr+R8eAi5Xt+BfOM7EE8SGuAHFrvlBs+qyOVDQ1EdthxW1Y
 hQlimQ0fg57EMlgao6wfXX6+rDmohq3YsQps2fgj1aZBhJ441NEPyAe3fO0qYgi6mnSzAyxdna1
 HWQiVttrvbCx/+G4UlnUDSjRJGd1
X-Received: by 2002:a17:90b:3c44:b0:3ad:77fd:c3d8 with SMTP id
 98e67ed59e1d1-3ae8957cb1dmr12214798a91.1.1793778934228; 
 Tue, 03 Nov 2026 23:55:34 -0800 (PST)
Received: from [127.0.1.1] ([2406:da18:807:8900:4cee:6ca:4323:84f7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b096b72d5asm1071112a91.4.2026.11.03.23.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 23:55:33 -0800 (PST)
From: WX Chen <wxchen0913@gmail.com>
Date: Wed, 04 Nov 2026 15:55:24 +0800
Subject: [PATCH] target/riscv: use gen_goto_tb for vsetvli
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-research-vsetvli-direct-chain-20261104-v1-1-7d5737100a27@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOvk6moC/z2NywrCMBBFf6XM2kCadBLjr4iLPKZ2QKJMShFK/
 93owt09cDh3h0bC1OAy7CC0ceNn7TCeBshLrHdSXDqD0caNo56UUKMoeVFbo3V7sCoslFfVba7
 qrxntUjZ9lZKgx15CM79/R9db5xQbqSSx5uWbjxYdBuuTDd6HMpH1ejLhrAPO6Bx5xBALWjiOD
 6CCFmqzAAAA
X-Change-ID: 20261104-research-vsetvli-direct-chain-20261104-206bc2104ddb
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, WX Chen <wxchen0913@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793778927; l=4977;
 i=wxchen0913@gmail.com; s=20260725; h=from:subject:message-id;
 bh=xBJfjaj+wBVfGkm+n0ulxhPZW21JQW7JVUCqKssFaNI=;
 b=TV6Pm+m4kpkXB9lNnQqImYWZXEH7MmnSGWyR4Gcuay9jlamgbIm6XFzBJVfcT5bOCfuqc9SLV
 1jDIJ4y+AEKCJDuHdNNJt6ouGlCQzwWWJb4+vzE0wgVwSjtbN/5/b51
X-Developer-Key: i=wxchen0913@gmail.com; a=ed25519;
 pk=FX63IRxmtz1BCNzHxOOWDPTo8L/D0YUxlIKc1WKi7wo=
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=wxchen0913@gmail.com; helo=mail-pl1-x631.google.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch uses gen_goto_tb() to reduce the overhead of the
unconditional lookup_and_goto_ptr() exit currently generated
for vsetvli.

The shared do_vsetvl() function handles both vsetvl and vsetvli.
The two instructions differ primarily in the source of their vtype
operand: vsetvl takes it from a register, while vsetvli provides it
as an immediate.

When translating vsetvli, the immediate vtype provides information
that can be used to optimize the exit generated by do_vsetvl().

To use gen_goto_tb(), each jump slot must correspond to a deterministic
successor-TB lookup key (pc, flags, cflags, cs_base) for a given source
TB. The relevant state changes are confined to the vector-related
translation state: VILL, SEW, ALTFMT, VSTART_EQ_ZERO, VS, LMUL, VTA,
VMA, and VL_EQ_VLMAX.

For the vsetvli forms optimized by this patch, given the CPU
configuration and source TB context, the immediate vtype and existing
state update flow determine the other relevant translation state.
Only VL_EQ_VLMAX can vary with AVL. This patch therefore uses separate
jump slots depending on whether the returned VL equals VLMAX,
enabling direct TB linking after vsetvli.

The register-vtype vsetvl instruction retains the existing lookup
path, as its vtype is not known at translation time.

Measured on an AMD Ryzen AI 9 H 365 (x86-64) host, using qemu-riscv64
with -cpu rv64,v=true,vlen=128,elen=64. A RISC-V GCC 14.2.0 cc1 built
for rv64gcv compiles the packages with
-O2 -g0 -march=rv64gcv -mabi=lp64d. Only cc1 runs under emulation;
make, the compiler driver and cross-binutils run on the host.

Each variant is warmed up once, followed by three paired clean builds
in AB/BA/AB order, using -j1 and fixed host CPU affinity (CPU 7).
The SQLite workload builds the amalgamation and command-line shell.
Median build wall times are:

                    Before (s)    After (s)    Wall time reduction
    LZ4 1.10.0         125.120      123.867                  1.00%
    zlib 1.3.1          70.269       69.911                  0.51%
    SQLite 3.45.1      438.322      433.213                  1.17%

In a separate untimed test, a loop executes two vsetvli instructions
per iteration for 37 iterations. Host-side GDB entry breakpoints show
that helper_lookup_tb_ptr() entries at the two sequential successor
PCs fall from 74 to 0.

Signed-off-by: WX Chen <wxchen0913@gmail.com>
---
 target/riscv/tcg/insn_trans/trans_rvv.c.inc | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
index 7e1295f33e7d4b7a2ff26cbf428f6b5d9eb682ff..5e9a861b6af1565485e9be89b393d0d64080a662 100644
--- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
@@ -191,7 +191,8 @@ static bool require_noover(const int8_t dst, const int8_t dst_lmul,
     return !is_overlapped(dst, dst_size, src, src_size);
 }
 
-static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2)
+/* A negative vtype denotes the register-supplied form. */
+static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2, int vtype)
 {
     TCGv s1, dst;
 
@@ -215,8 +216,22 @@ static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2)
     gen_set_gpr(s, rd, dst);
     finalize_rvv_inst(s);
 
-    gen_update_pc(s, s->cur_insn_len);
-    lookup_and_goto_ptr(s);
+    if (vtype >= 0 && (rd != 0 || rs1 != 0)) {
+        uint32_t vsew = FIELD_EX32(vtype, VTYPE, VSEW);
+        int8_t lmul = sextract32(FIELD_EX32(vtype, VTYPE, VLMUL), 0, 3);
+        uint32_t vlmax = vext_get_vlmax(s->cfg_ptr->vlenb, vsew, lmul);
+        target_ulong pc_save = s->pc_save;
+        TCGLabel *not_vlmax = gen_new_label();
+
+        tcg_gen_brcondi_tl(TCG_COND_NE, dst, vlmax, not_vlmax);
+        gen_goto_tb(s, 0, s->cur_insn_len);
+        s->pc_save = pc_save;
+        gen_set_label(not_vlmax);
+        gen_goto_tb(s, 1, s->cur_insn_len);
+    } else {
+        gen_update_pc(s, s->cur_insn_len);
+        lookup_and_goto_ptr(s);
+    }
     s->base.is_jmp = DISAS_NORETURN;
     return true;
 }
@@ -244,13 +259,13 @@ static bool do_vsetivli(DisasContext *s, int rd, TCGv s1, TCGv s2)
 static bool trans_vsetvl(DisasContext *s, arg_vsetvl *a)
 {
     TCGv s2 = get_gpr(s, a->rs2, EXT_ZERO);
-    return do_vsetvl(s, a->rd, a->rs1, s2);
+    return do_vsetvl(s, a->rd, a->rs1, s2, -1);
 }
 
 static bool trans_vsetvli(DisasContext *s, arg_vsetvli *a)
 {
     TCGv s2 = tcg_constant_tl(a->zimm);
-    return do_vsetvl(s, a->rd, a->rs1, s2);
+    return do_vsetvl(s, a->rd, a->rs1, s2, a->zimm);
 }
 
 static bool trans_vsetivli(DisasContext *s, arg_vsetivli *a)

---
base-commit: a3565937b39779d4e3704298095f566e7559ad53
change-id: 20261104-research-vsetvli-direct-chain-20261104-206bc2104ddb

Best regards,
-- 
WX Chen <wxchen0913@gmail.com>


