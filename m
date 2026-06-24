Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4469CDE002
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcMPw-0006mG-Kn; Wed, 24 Jun 2026 08:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <suunj1331@gmail.com>)
 id 1wcJUD-0001AS-DW
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 05:01:33 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <suunj1331@gmail.com>)
 id 1wcJUB-0007kF-VX
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 05:01:33 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-37cb36ca63bso507667a91.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 02:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782291690; x=1782896490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oAFwvu0IIrO9LQu68/GCI7YYJ8LSf/BV4HbSMpLrHYo=;
 b=c0x+e1cye9xsFdU6hXEDteP2PPkqxi4JpI4l272YmW0sQwq/u/FDU74F5McSCK8338
 SUCaWt0t+xo1rnVaxU6/eRkMtEZcxwlXBuRhNDiFtrmMuDVBqBANLrvAo4gflnNrKQOs
 yTxHzgHDVhpN9pwyXfHTYXDFr3SGqFdRtgp2dm+fim4xgXM9FevsKncM3EkB4iMOcWxa
 MTtvYfBa+wbnnwetFRiZBhI7hBiepyF5r1X0U03pgZUBwxdfvkz2Qbtftac+80GmO6f/
 EPa7E7F/pR1u+WtTuaDewxcHdWyzIUN5U0mABM03Id6AR4XOtmovhuNkx4AkNdJXMaXu
 Q0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782291690; x=1782896490;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oAFwvu0IIrO9LQu68/GCI7YYJ8LSf/BV4HbSMpLrHYo=;
 b=Yc+mILoLe5QP1iOVwL252tHR65flQ1L/bz7W4OP6vZb16QXpi5Nxr8FpKYS09MS+Wf
 cVyAsEk8dCJpsqIwnmPn/dzBxHc90wTA5cAEhvxJaPxhVyaYuVdb1nwEhOJa0qqQV4AR
 z7w2antNGuvGWOgw0fIqDq5A6Fln3inqRkJMZ35oomb5Uva7uPOEtSRosQ+cTcz9xpyk
 H8M1h7N4ygBzJKj4oN7PF0UMmz2bPWNkkInT6DVDnFVIWIGr9OORDIuGzXpzZP8xP8Is
 YlDrnNWRaED2pmBUn9YfB8OJ7tpqkmgUIGGLDFr5PGD4qtqea5JjSkvL2Nb5vonqXQQU
 K2xw==
X-Gm-Message-State: AOJu0Yxl5H0APLLLK+UViRKoqxD8DVcejQtkobHP3mJuLF+SYnzVkpUo
 M9QkXcv6Vqdkf5T//BpW9G3YybMvnJO82q12NMuL1szYu9mpvPscj2JeOhXKtVdq83k=
X-Gm-Gg: AfdE7ckqBiPWJT4Yi/Eyg68h2u9siAJb8XSLHQBYtVyvzwD5D4bMTDOhdUjG4+z2e2d
 DYj4TtL308o3tD3/vBIGEcTy9W3bKjRDT6Up3igAiVXBfUgmeZ3xH77Nsjdsn4/PfSd6nAVylMz
 ot2lZAPC4fg5ZvhN5O/uz52PhmKcWEatPa3cMKa1bbzaKRtI67m/5EFvnby2C4oqkuiWBJUJMdc
 DCXQnAxYLkGCUvbErgjwJc7TTltsNcMb4BdsJj0kRpFXeJrEthjKvyBOe7s7tqGwm9OhBdLzQ+5
 uAp5lmUDeZ48g0e4yL1TSgFFOB57gl4xDW37NpLCXaJsSkwltOVSca3ajUoOtrC/94e1DOzIstT
 2EGhyJg/zFIopMfT11c0+n0MHi3sYmLAFNbPIsX6sahjPVYIm33PNccSWcPgBtd/vR9tRa2jRIU
 6+e27JYzf7CqcVQ0vX6QLBQc7iq6TLpsc7P5tQ
X-Received: by 2002:a17:90b:2d4b:b0:36b:8baa:a683 with SMTP id
 98e67ed59e1d1-37de428c477mr2618004a91.19.1782291689964; 
 Wed, 24 Jun 2026 02:01:29 -0700 (PDT)
Received: from fedora ([61.74.238.173]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc2c8d8a9sm12257944a12.5.2026.06.24.02.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 02:01:29 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH] target/riscv: Fix vsstatus.UXL reserved value
Date: Wed, 24 Jun 2026 18:00:52 +0900
Message-ID: <20260624090052.463075-1-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=suunj1331@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 24 Jun 2026 08:09:16 -0400
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

By the priv spec the value "3" is marked as 'Reserved' for
mstatus.UXL. write_mstatus() rejects this value, but
write_vsstatus() does not, allowing the reserved value to be
written and read back unchanged.

Handle a vsstatus.UXL = 3 write by writing the current 'xl'
instead.

Fixes: f310df58bd2 ("target/riscv: Enable uxl field write")
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 target/riscv/csr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index dd9726fcf4..4c1da61824 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5226,7 +5226,15 @@ static RISCVException write_vsstatus(CPURISCVState *env, int csrno,
     uint64_t mask = (target_ulong)-1;
     if ((val & VSSTATUS64_UXL) == 0) {
         mask &= ~VSSTATUS64_UXL;
+    } else {
+        uint64_t uxl = (val & VSSTATUS64_UXL) >> 32;
+        if (uxl == 3) {
+            int xl = riscv_cpu_mxl(env);
+            val = deposit64(val, 32, 2,
+                            xl == MXL_RV128 ? MXL_RV64 : xl);
+        }
     }
+
     if ((env->henvcfg & HENVCFG_DTE)) {
         if ((val & SSTATUS_SDT) != 0) {
             val &= ~SSTATUS_SIE;
-- 
2.52.0


