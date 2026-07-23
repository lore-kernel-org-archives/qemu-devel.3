Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEAAC531D4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 14:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmuKY-00022M-Pu; Thu, 23 Jul 2026 10:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wmuKP-00021u-DF
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 10:23:14 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wmuKM-00087t-Gu
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 10:23:12 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38e3617ba36so641572a91.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 07:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784816586; x=1785421386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+PGGAe6FXYOVxuf/N4iVswFpWLZT3NlFAzsJ75ks3dU=;
 b=Yys980N5nwlEOASWw7m6zV7I6qxzT/DHJ3sq8NJzslmDQKhWqoTchl390Tw60E9Lk1
 XM+CdU0FDhha3FE5ivt+KjM24RV6nynl8FpDRPaJv2fq5VO807LY/g3s5q5fapAobg58
 Hku5KnMmUOdnWCRpofOJCSNaChAJva9DvznldTHRUvj/eNxFVwBqz2nwryRIrN2YVIcM
 5EDeGTSDt++yra1bHelAvsXtHOuLUPRup1aMdtf9EeRrQaT4Gqak2NBYjdZBnTK1rJpS
 m5813Bb1+nPvbltUW0DkidKREUxb8+21vPiY9JDGLXzeuajpDoDpmuwwHcnpkjSqW3Sf
 bPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784816586; x=1785421386;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+PGGAe6FXYOVxuf/N4iVswFpWLZT3NlFAzsJ75ks3dU=;
 b=bQDzwfjLViW66UG571JGmXhhj2Wka8CE8WC0Jwmynr4ys5SyhIHnw6sYgNtYKDaeBN
 FYsR+xNM8PLqaI9+o5q5CQPbDHZ9xR6f9bDPkdNj1m55NgRD7GOYJ6unLfVSYzuw0lwP
 Q1D7WOjs1PvjdM7gxCRSnjzUk7ULUm4CAJGG8egaV2tKv7bS2xp2No2FlD2Tx4FZfpHC
 ZdBRUhkKF7BiPypf+bMODUCWFrGps1Jk3tAEHrukycdVtH442PUfUIk75KDDHEWWA6xa
 BR6H7lrX/fWbMILS2U4xUx5jixAgm3LAuUxZIJorPhT5KifwpJvHv6wqjV6vetLR3O/l
 rm2w==
X-Gm-Message-State: AOJu0YyhoaKnnp3JLIiUnxZ5boSB8neD4pNNVhwprYIWQUdm+E7gLpfs
 A+GTNUkhfRpe0sk55mFeRULAiIRs3IuM5Oxn8+UMcYyUBKmrMx72hh1+msMnCg==
X-Gm-Gg: AR+sD13c3XAY7c8c5dgoRDv8LQopKbJqd5dtXHuQt5jqbE5oLgDKO22/J5QhOyatxKw
 2pYtXtmO+J3j7AcvBnpx/SYB0K8sby8LJWrLH1v80nTSMslC8x8mSyahcHPUnxvTK91r+r1w7ie
 8/s6LnP6PLlOmnPnernLpsAXgofLXheLJWMMJ8Y8OnzlodW8tJCa1rGuiDdxv8Urd60Z/u0dgkP
 kxfoIjUBrEfnmiSRI+NaCsC3F9rZM5ltM+19MOSElc9HKg8AvyTwPLhbNeKONSSwmNU2h4xjTMe
 k5EG+ziIdxMjqNOrDwmqhLxGg9KndDNvfuGOF03yXesvktK9FYvSwxF6hmn8YvL3N76vH/nR5/l
 cIxr30B3+A01Z21KDYBqYjxZkh1tDyT2E76/13JEuxN6QG1ZtlCer7fZFj4wrq2s=
X-Received: by 2002:a17:90b:4b0a:b0:387:e0bb:57f9 with SMTP id
 98e67ed59e1d1-38ec6a9cfcamr3106503a91.42.1784816585985; 
 Thu, 23 Jul 2026 07:23:05 -0700 (PDT)
Received: from arch ([112.133.246.8]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d130a87e9sm15720558c88.11.2026.07.23.07.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 07:23:05 -0700 (PDT)
From: Abhigyan Kumar <314abh@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Abhigyan Kumar <314abh@gmail.com>
Subject: [PATCH v2] target/riscv: use SXL instead of MXL for read_sstatus
Date: Thu, 23 Jul 2026 19:52:54 +0530
Message-ID: <20260723142254.1683113-1-314abh@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=314abh@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

According to the RISC-V spec, a 64-bit system can have M-mode in 64-bit
with S-mode being 32-bit (SXL bits or mstatus[35:34] being 1). In this
case, read_sstatus should use SXL.

QEMU doesn't allow changing the SXL bits in mstatus in M-mode. This was
because of the missing MSTATUS64_SXL mask in write_mstatus. Now, both
the SXL field in mstatus can be safely modified in M-mode and
read_sstatus correctly uses SXL not MXL.

Fixes: b550f89457 ("target/riscv: Compute mstatus.sd on demand")
Signed-off-by: Abhigyan Kumar <314abh@gmail.com>
---
 target/riscv/tcg/csr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 36f2004bc..a90449b87 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -2067,6 +2067,11 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
     }
 
     if (xl != MXL_RV32 || env->debugger) {
+        if ((val & MSTATUS64_SXL) != 0) {
+            mask |= MSTATUS64_SXL;
+            val = riscv_write_uxl(env, val, MSTATUS64_SXL);
+        }
+
         if ((val & MSTATUS64_UXL) != 0) {
             mask |= MSTATUS64_UXL;
             val = riscv_write_uxl(env, val, MSTATUS64_UXL);
@@ -4014,8 +4019,8 @@ static RISCVException read_sstatus(CPURISCVState *env, int csrno,
     if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
         mask |= SSTATUS_SDT;
     }
-    /* TODO: Use SXL not MXL. */
-    *val = add_status_sd(riscv_cpu_mxl(env), env->mstatus & mask);
+
+    *val = add_status_sd(riscv_cpu_sxl(env), env->mstatus & mask);
     return RISCV_EXCP_NONE;
 }
 
-- 
2.55.0


