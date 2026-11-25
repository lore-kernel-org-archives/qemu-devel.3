Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54029606A6BC
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 06:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aro5Af0Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW6Lo-0003rT-V5; Wed, 25 Nov 2026 01:19:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1xW6Lk-0003r9-Cy
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 01:19:24 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1xW6Ld-00052n-Uj
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 01:19:20 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cde1479f76fso3046638a12.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 22:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795587556; x=1796192356; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lxP1NTfR25wlqRFvVkERExiqiUDV7C7lVRFPguJ00QI=;
 b=aro5Af0YHHzWX6cnRQv3oHV125AK1SWq8uL6sfpPPIdqAM3ueZ3Ucmi3wdRGK/b1Vu
 4i/XusG7E42iCdVAKCX1TUqEe0MNZIpCfQE3nfMtZok7Q5M8plsyzzGTyUaIrHZQ2qGX
 8Uxf+i4AMvULigl9On8S3NsJebXZfPDFsMyrlRYhdPWc8Szdk2exk0vQCbeozuhZxUCL
 +PhvJuyY/LveuvCBEfvVIaXi9oV/PXWcYNIL/jc/9YCsV4B1sKLLl/HxuWixHpRNR8lz
 435mERuDgd04XgKWOxF1uaxfqeZvJa3jackEW6jwf0dwnmnrgQUOpTIoorJZZpvkz1LO
 60wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795587556; x=1796192356;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lxP1NTfR25wlqRFvVkERExiqiUDV7C7lVRFPguJ00QI=;
 b=SGW52HW/NgATERefp4aduY8FjLhaRMTvojeaNCapr2hWJmYnmDnOXeQE/H/ItPZf60
 d4pYuCMDD0Ppk7/1GRMzG0ubopoW29iYfEAGfJnBD6038jDPEJWCRjm7y9BRpH3ebBUV
 5RVQwDXz+Z/QeTfDkOv2npYsKvvMrSq540apJEq4OuCo+fb+9z9BbKlcZYCmOVvNFGhV
 cL70rSCDFeBiSKpirMCoMcxPDlQtNCHBE/Cq3Xv7GSZO85pstJzt6cC6GCtuqf5J1vc/
 sw54IYfkkmL8nJoG6yU8ctziL9Aol8ekAHV9yOFs5f6WjbhYedG+mBw+ylCRtdW15Thn
 dZ2A==
X-Gm-Message-State: APuU4Z9pQm5KnJu0TUOsxXiDLgaz4IJA6vmAMJ06kXbly7giY4ajMeAv
 R8botRiy1nOBsTk52/OVLNV0jy24dqgZ0Z6hrrd3MouGzPoHR2juWCBG
X-Gm-Gg: AZFdTZdbM6MyImSQ9YhLkTkLdl+CKb2YdY13KCZetmlGab64XlVNt3yMnO83UuAwug0
 VX6gL4dYamhLwvifAFZrMzHyP+qp5SFFAaTHfnne5AKewF3LsZVakHbpPVo5yY69FHSgMJMvtCB
 dM67Vo6+dckLTvwC+HWj/2LR4BOKOkXezZnhTiYDi6akRUiOw1vcDLoTFyaQ2IJxnk32hlHo5Bl
 xlWj+o5XLkQ8hffuAa3hUtKuFf8uFZXhYnLEUK1QoL7wOBLT/egbWllELsYnZBKXYMhXr029UPE
 KfUxJsrWnZmidc5wxrtX0Z4dcd2V6n9pwB96bzC0eMUHp7QRFC2WLcVazG4+giGcEkLmYKb4xTK
 QL7XjbUtuxWpZuQvLI+I4dTucsKzmdj8Dm7VhDLcGXM7QXafkiQ0awptuweC3LZBF8vpvfJGQ1F
 aIDGF0FKUUCN65cQNmC0I4/riZNNev4zooDmp15dsrAZmPzUX5X1GUrRx11tkIUZthz6nTAPLy2
 CtNDzXYme+ZdcKrRP50MzOgTPNHvQKcUpy0qT+39BjgFRSO7fj29Z6KJxk3JTBMa8mTL+mjFEEa
 KEyEe8sDfndQNcH803etxLh3fHZc
X-Received: by 2002:a17:90a:da87:b0:3b0:9a2e:b494 with SMTP id
 98e67ed59e1d1-3b41c95b089mr14351521a91.54.1795587556210; 
 Tue, 24 Nov 2026 22:19:16 -0800 (PST)
Received: from [127.0.1.1] ([183.6.125.102]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405d96bd3sm29138804a91.12.2026.11.24.22.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 22:19:15 -0800 (PST)
From: WX Chen <wxchen0913@gmail.com>
Date: Wed, 25 Nov 2026 14:19:06 +0800
Subject: [PATCH v2] target/riscv: weaker memory ordering for guest FENCE
 instructions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-fix-riscv-fence-20261119-v2-1-89c8558ae091@gmail.com>
X-B4-Tracking: v=1; b=H4sIANl9BmsC/42OQQ6CMBBFr2K6dkynBdq68h6GxbQO0ETAtIZoC
 He36AVcvsz8l7eKzClyFufDKhIvMcd5KqCOBxEGmnqGeCsslFQNopLQxRekmMMCHU+B4XdAByi
 pUrU3tjFalPkjcfn9qq9tYU+ZwSeawrALpeWbM0HroC1a7mokE2ytdGVIWXZd01hpfL2rhpifc
 3p/IxfchX/0LAgIxN55whLm7KUfKd5PYR5Fu23bB8rmyGX7AAAA
X-Change-ID: 20261120-fix-riscv-fence-20261119-10a425b78673
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Tao Tang <tangtao1634@phytium.com.cn>, WX Chen <wxchen0913@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795587551; l=2390;
 i=wxchen0913@gmail.com; s=20260725; h=from:subject:message-id;
 bh=0SIg6f8OnpZMyq4OW2XcYT50xW3wD0CdzCOR46bjWpk=;
 b=QxAuKlAsW+h7ImWIfJq0AXAMl9CB76ySw7okdBI+P0s03zVSQ5U9cMFBjWnk7y2CUdAw18BVw
 OrA/t1PnpMVCtw/j3xcLSEAdDEfwESBq0qot9tZU6rFxzv5B7zHFqSx
X-Developer-Key: i=wxchen0913@gmail.com; a=ed25519;
 pk=FX63IRxmtz1BCNzHxOOWDPTo8L/D0YUxlIKc1WKi7wo=
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=wxchen0913@gmail.com; helo=mail-pg1-x529.google.com
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

Currently, they are implemented as full memory barriers, which may
introduce stronger host barriers than the guest actually requires.

Signed-off-by: WX Chen <wxchen0913@gmail.com>
---
Changes in v2:
- Place the var declaration in the beginning of the function.
- Fix the commit title.
- Link to v1: https://lore.kernel.org/qemu-devel/20261120-fix-riscv-fence-20261119-v1-1-aeb9ba142598@gmail.com
---
 target/riscv/tcg/insn_trans/trans_rvi.c.inc | 36 +++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
index 4784ea1607e74eb5b0076425a732b5d3817b3482..a096da48cb95c69f56d12fd6f4f19061b74a1620 100644
--- a/target/riscv/tcg/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
@@ -968,8 +968,40 @@ static bool trans_pause(DisasContext *ctx, arg_pause *a)
 
 static bool trans_fence(DisasContext *ctx, arg_fence *a)
 {
-    /* FENCE is a full memory barrier. */
-    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
+    TCGBar ordering = 0;
+    /*
+     * FENCE.TSO orders all R/W pairs except W -> R.
+     * For TSO, the pred and succ should all be RW,
+     * otherwise it should be treated as normal FENCE.
+     */
+    if ((ctx->opcode & 0xf0000000) == 0x80000000 &&
+        a->pred == 3 && a->succ == 3) {
+        tcg_gen_mb(TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST | TCG_BAR_SC);
+        return true;
+    }
+
+    /* Reserved case, choose the strongest ordering.  */
+    if (ctx->opcode & 0xf0000000) {
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
+        return true;
+    }
+
+    /* Normal FENCE. I/R for BIT 3/BIT 1, O/W for BIT 2/BIT 0 */
+    if ((a->pred & 0xa) && (a->succ & 0xa)) {
+        ordering |= TCG_MO_LD_LD;
+    }
+    if ((a->pred & 0xa) && (a->succ & 0x5)) {
+        ordering |= TCG_MO_LD_ST;
+    }
+    if ((a->pred & 0x5) && (a->succ & 0xa)) {
+        ordering |= TCG_MO_ST_LD;
+    }
+    if ((a->pred & 0x5) && (a->succ & 0x5)) {
+        ordering |= TCG_MO_ST_ST;
+    }
+    if (ordering) {
+        tcg_gen_mb(ordering | TCG_BAR_SC);
+    }
     return true;
 }
 

---
base-commit: 08ed97c33c3818ef51a7c852347a28e9f66807b5
change-id: 20261120-fix-riscv-fence-20261119-10a425b78673

Best regards,
-- 
WX Chen <wxchen0913@gmail.com>


