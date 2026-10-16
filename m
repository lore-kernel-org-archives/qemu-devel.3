Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698F7CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWQR-0007qE-G0; Thu, 15 Oct 2026 21:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWNq-0002NK-0y
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:05:21 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWNm-0004fE-Rd
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:05:17 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2db80fcdf8bso34406555ad.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112713; x=1792717513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4ZDAmHkNaL2GP9TNvzH/Eukg/ShmgpFy8KOEiXKGsSA=;
 b=S8srXIuf+YBi1bWVfL9yHnXm5z19V5kADh9BFzR6XUtMTFG5UXRBNGbNKehlWaqDUn
 1aVBkl4ZbdWBBonTm3svX4lz9wvsH8C90eRRevMMe00W301mDSkBZ5jrxb9RsiaaL5bw
 YEVrCNaYrgUZsrvAd+8OSK6NX/WNwzrkETmOyi7wJJh+0qSJRhkGjX/xJaI5/EQulsxv
 1VHdoHNEihSsO3LNYOdMg5wkbyMf5ouOzq7X7Y3LOeBet0c6SKmHGPeA+TaP9zhHhlsJ
 hR8rYSY2n6IKBS9jHwAX4TQOwDJeq+StWEblfzBhxkShHA6gUbULt4f8n9RCAiTdY8pn
 CVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112713; x=1792717513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4ZDAmHkNaL2GP9TNvzH/Eukg/ShmgpFy8KOEiXKGsSA=;
 b=zy1rd+utHIsOyg2tqkP0OvNNKy24JTcp4Qrmtr74eOQA8V6SpuLkd1mBSPsujSxQ+w
 K9rLdAVKC3r5q44riCXEu3aPeHPD0XLew01O34xjSVjYnm+bkI91zpXW2GpQlsSAQFoD
 bLIX5jGpsgZ5l2v5UW/rifQ7sO3qrj6fjYxfpupkRPre6vu/Zj3gafJGL/bPDaVRVvST
 gjunQVnwH1TrlVO5uXUtb6oggekec5PTKUjlZWAkvuf13Tp2XtQ2WalcVlV107l1WGMm
 dfcdW9wrRDzT6estqPhO/mH4QfyIgSYtT1vtvzxpbiNYjW3EdUrTp0oIOuXeHdoer+9R
 KXCQ==
X-Gm-Message-State: AFq9FYLfs3Q2W1LcSJy9o2c57dc4JTCt86c++Bj31TNPWcb1Lw/wfTC0
 Z76EYe2nU6mCaJ8ojZVYmBLh6Y+WYZ5nDTA9bJPjzo5Y6fA1ncPvyyf/2R9k9A==
X-Gm-Gg: AYBFou3Bg29wJbhB6PNMsbWmVBpJIjM3mVizIg0Tfoh/lLUq9N8uAubJjFKx+8YNrgv
 3bAHMaMc9nzSmTPYMUFCWk3vr9gtbRF4NpsoDyypr3I+QJTufdQPV+2+7I9Mbcw8eIb3Zx3YVOy
 5T47/fzbZjGSPTiwgPg3ezzEjZSSuatha7qmbZF1ulQkNOcut1usiF/gQP4LFEO+MUpN4MjrVf8
 n1WzEcLPw2ePiFlP1K1daCe2WmvFkAjD5IxvPW5XTJRtGvzHoJ6dG4cdeKvVBjtsvtp0mGsYKuB
 F+q5Dn98gKlZw5V0+zMT1UbkgiMdDBN379At5UsTiyEJMbcxU7+UKnRXWtQ2reC0JEvA5CslnJ+
 Myl1zqlk6hIVRIYLER0N9Rld1FuP5i2BUxKRdiv/UyQQOkjKqcOqXVzjt8XELADhSF3ZWv1zKnm
 Q2MoRui4lM3SQfStSm+Nozp1R3bHC8JXiN+pJoIZiRK1BcQDeqA9GvzeEppzp02XjeQE5Nmotv6
 t0gFz97/MtIO3p6
X-Received: by 2002:a17:902:f691:b0:2e9:628d:e9a6 with SMTP id
 d9443c01a7336-2e9628df265mr29222865ad.57.1792112713531; 
 Thu, 15 Oct 2026 18:05:13 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:05:13 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 50/50] target/riscv: normalize Zcmt jvt.mode on writes
Date: Fri, 16 Oct 2026 11:02:37 +1000
Message-ID: <20261016010237.1102834-51-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_HEX=0.1 autolearn=no autolearn_force=no
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

From: wangyang <wangyang25@otcaix.iscas.ac.cn>

Only jvt.mode=0 is implemented by QEMU. write_jvt() currently retains
reserved mode bits, so a legal WARL write of base|1 is read back
unchanged and causes a subsequent cm.jt to trap. Mask the write with
JVT_BASE to normalize the unsupported mode.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4408
Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <a64897d07c6b0c61451cd5382afafcd27201367d.20260904092608.git.wangyang25.otcaix.iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 64be8ca309..063590f56a 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -6086,7 +6086,7 @@ static RISCVException read_jvt(CPURISCVState *env, int csrno,
 static RISCVException write_jvt(CPURISCVState *env, int csrno,
                                 target_ulong val, uintptr_t ra)
 {
-    env->jvt = val;
+    env->jvt = val & JVT_BASE;
     return RISCV_EXCP_NONE;
 }
 
-- 
2.55.0


