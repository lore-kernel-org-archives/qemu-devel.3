Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECC1CD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDQ1-0004r5-73; Thu, 21 May 2026 20:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOf-0003Db-Ru
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:57 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOe-0004pK-6E
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:49 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c827313dac0so3557732a12.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408347; x=1780013147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+wnKqlHEFv+wB5Dp8DNZh9e6UwUPUqIVSWViinG+pxU=;
 b=mEP6Wzm1vigos9wLqBN9xMIuPVUn6wh4VtsASgPcYJfW+unbkreOpanGeZ7oiuXkj+
 kOssEzbyM68NO5uhRipMhzDaZI7zumJECS2jFJOs+3+7OmsN6o33XpqqOXPeAjTrQvx5
 UhHS1DlIkZN1sXC9nkYpbLoYX1b9uJqBSAb2vpXYyfVrIHH1y5Aa+CrgswQ8oe6Fo+2q
 OXWkT9wMwW9znLJ3D2SpoezXXgCEYWzeHbtUZOOBKmzTjRzptL78c/lpmI6susR5p5m7
 HR1BBmEiQ7glr0xE1FRzNc3YMwA/DiX7hw8rsL6Dy/kmOWJyfbdjC+MjJk7Wo2+wwLkj
 CEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408347; x=1780013147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+wnKqlHEFv+wB5Dp8DNZh9e6UwUPUqIVSWViinG+pxU=;
 b=PyPONoy1rI8n5qw1F3gVOBtgfARjLEPODfJh3K9iVc5H5GAzyht2sAt5E2/nosYJ1h
 mQ6JvpXme0qevroVh/U01fvu2KxygNv3l2DnBfq3jvRj6qEWQ8oTOhowaQcGT57/kndw
 JO09Y0fdJkKAMwMC5fkeAEaK1o1ImLlmv3ueTh/4crCzZ2nXw08i7YwouMibHke92XIf
 J8fv2wtWAKh1l40ObVsvB/CbJrJH6K2Qo6ew7t3uR0PTilTFg0d7ftXkwEBgqWxcuDYz
 2Iq8hGbxQBWXw5/n30xfkysvKUOdmIvcAyNEdWVALPtppWd/iL8KzilklK+4f3Ph9DAO
 TGBA==
X-Gm-Message-State: AOJu0YwUpoMBUG/Kx9olvQXwkjpZvN8YKbiUbZuK63vGOBvHD1P2qINV
 8fec3aLoAY2ySqzqD9Y5gntoNw4jLyceUMDRyoGJO6VUQaxr7hN3+DtHkmtom3HO
X-Gm-Gg: Acq92OFbSLKn5KnAR04nQKuPRwwc3/mdIOBhDGwTsxaNlmSsRzonwnWnXecLzHHReu5
 uiQVkI1p+h6xYup5oVjAmEjUHmi2CHuQtvGZm2mBQ4yb6TanEScUOFfHvh38jxli7Use+U1i7l/
 yZGyNf3ekNflt9lCWlYGXo82Pe1E7gx7MuYIPm1/Bg0VqopVKGvqYGT4J0PiuwEKmlBkGgodM3g
 Ga9chw/+mrlx/XJ5Oud8gg5B7q0BshYNhm8IsfIwTMtMufuXg3z3kkhd11s+qGNlBl2dHToxMmj
 RH08Ez7+gBKB6jT54G92Aa378a58brFZngi/m63ZHH145TjBX5UPGBnUmaUZmDy3U4rgGh9CpUY
 nbpbNxedZ7hMbWOn2OgxLVgwIh79L2Wc9SORDKQIPzbwdFtb5hiJyhdO1n7I/OlZ2eYHrwelJpI
 WIHzOzr2expbVbD8qBOe1zs7lbVCloOwyz5KgDxexxZw==
X-Received: by 2002:a17:903:2f90:b0:2b9:6cde:c34b with SMTP id
 d9443c01a7336-2bea229bfc6mr48843935ad.15.1779408346663; 
 Thu, 21 May 2026 17:05:46 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:05:46 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 41/48] target/riscv/csr.c: fix read of pmpaddr(0-63) CSRs
Date: Fri, 22 May 2026 10:03:17 +1000
Message-ID: <20260522000324.23255-42-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52f.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

The priv spec defines, for RV64, that the upper 10 bits of
pmpaddr0-pmpaddr63 are WARL and are supposed to be cleared.

After this patch, using the bug reproducer in [1], writing
ffffffffffffffff in pmpaddr0 and reading it back now results in
003fffffffffffff.  Here's the 'diff -cp' dump before and after
this change:

*************** IN:
*** 5272,5278 ****
   pmpcfg10 0000000000000000
   pmpcfg12 0000000000000000
   pmpcfg14 0000000000000000
!  pmpaddr0 ffffffffffffffff
   pmpaddr1 0000000000000000
   pmpaddr2 0000000000000000
   pmpaddr3 0000000000000000
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260514123342.2139464-1-daniel.barboza@oss.qualcomm.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index b470d37050..0e4163b56b 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5365,6 +5365,23 @@ static RISCVException read_pmpaddr(CPURISCVState *env, int csrno,
                                    target_ulong *val)
 {
     *val = pmpaddr_csr_read(env, csrno - CSR_PMPADDR0);
+
+    /*
+     * For RV64, bits 54-63 of the address registers
+     * PMPAADDR(0-63) is a WARL zero field (priv spec,
+     * section "Physical Memory Protection CSRs").
+     *
+     * We'll have to add an annoying TARGET_RISCV64 gate
+     * here to avoid complaints about masking bits 0-53
+     * of a potential 32 bit target_ulong '*var'.
+     */
+#ifdef TARGET_RISCV64
+    if (env->misa_mxl == MXL_RV64
+        && csrno >= CSR_PMPADDR0 && csrno <= CSR_PMPADDR63) {
+        target_ulong read_mask = MAKE_64BIT_MASK(0, 54);
+        *val &= read_mask;
+    }
+#endif
     return RISCV_EXCP_NONE;
 }
 
-- 
2.53.0


