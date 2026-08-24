Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AA6C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNcN-0001Jp-6a; Mon, 24 Aug 2026 01:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNcL-0001GK-LE
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:53:09 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNcJ-0003Hm-Us
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:53:09 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-cbedda4c154so1807379a12.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550786; x=1788155586; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g7vCLZFyzm937jgIhV3Z2Vex0I/08uZ3yWQtzgoRbwM=;
 b=kniknyZnFJTwyOonVlmK6mR/XXPBozNp7oVJLo0CyN02Paq8l3OiXDbQL3viWuqzky
 T5aOZCoMmQoePA0jzsktkd+YVA6FJ4u2Bzf7DF2rObP9G6wfFqkh3z9HvNBKKp9U4YWz
 Bu/Pr1ijg063tdWocnlQJUgK7clG2qOzmWs1hTFvfKLZLk9nRkCU5Y8eJgES9uEnNU21
 WxH/FLuc+Cjw/j/QT7ayCl/Jh7c1hgks334BF7ud1S5Izz8iPyBI5biYSIYNG6lISJpg
 v5F2daP3E4dcfSn9OwWdFE4I7tZgYNehd/T39GkvTF/PiaaOJ4adSJIIBmbzPmahjqeu
 Uxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550786; x=1788155586;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g7vCLZFyzm937jgIhV3Z2Vex0I/08uZ3yWQtzgoRbwM=;
 b=Mcy4FUDu2xn8/UKPArItJhUsOcyDGbrPy2f3yvjWoDXHi8SLrklUCoaGi87JwnNKAD
 XDlqr7kUDzg0g98tgWPjWashetv6Kl/YPOPFT/UlKcjlVxs2GVZV3jjioAU4MymO7OO2
 LQg+2fiicIEohxuAZXmJWvN1+Wkc75G/Ka8nnEobUHwwtzoxeHihOPZYt5GfXooAbdxD
 VBVy1fca3hMxkY/veNFxyODPklLRp8E6A8oM/O6qy1fK3P2rN0qF2SBpNTMOdlAOt3Lq
 HfnxEVVetVPtJCwD/8GwMDsXZaI1dBy8sSfWFqeLMxuCr97ExfyJTba+cqxfUWxBO9W2
 xjhw==
X-Gm-Message-State: AFuF++lToGrSCglLGQ8/4Ek388O6/6N2BQVKRN1tcq6aNP0KttH6uW6U
 pOcr3/SU7QkkRfMbpAEy4IC/VLKR7B0TozTNSoEJirWKOZxmwuPC4HNBexjvtw==
X-Gm-Gg: AR+sD11uWtDEdrq1HB8wsP/SyaGmx0UWo2tDP6Q3GmSQe9Q560MgKzwEFSBE0eeEfq1
 e/9i5TkG8tu6q9tZxfUMFAczYBo3myYWB+QErU4ASgUhyAt+vl0f97LcXBlxgbzMkMYacj8obSA
 xCfL2/33Nj8N14YtwWRDD/cNl+03TOTbzienJHlZyeZ4xjzrpXesnDX1z+hZ/fPcH6u7OnpYjPr
 PJet2x7zafgjJPvzzdyc30p3v4IG7LNe7DIqmzdgWM6QCP13rBxmoq0tYnuOjSD2y1SB2/JX/5p
 o0UlIx6eQT1DkRd1hTuo6N0mE5pCDcM4IJbPdxOWdezFGWne/Uf+u89np2MEHZC2n76Tvk7I371
 P8TzxQ4uzb8/KZHnuJJjo210NQ45s3ZpgBy2s/0+mTiqDMIoG9eB/CizCMUmCwKxEPKJRWmLtVp
 IJARl0LrowYvW+cONgGIGxo5k4Cl9aQyeSiivAe/LuA4/E322AChiRGz8JkooztwpV9qNua7+iw
 2ysww==
X-Received: by 2002:a17:90b:580f:b0:380:f389:447b with SMTP id
 98e67ed59e1d1-395c386d163mr47850617a91.11.1787550786502; 
 Sun, 23 Aug 2026 22:53:06 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:53:05 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Vladimir Isaev <vvisaev@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PULL v2 93/96] riscv: csr: do not drop C bit on misa write
Date: Mon, 24 Aug 2026 15:48:03 +1000
Message-ID: <20260824054806.2790041-94-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
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

From: Vladimir Isaev <vvisaev@gmail.com>

According to spec:
> Writing misa may increase IALIGN, e.g., by disabling the "C" extension.
> If an instruction that would write misa increases IALIGN, and the
> subsequent instruction’s address is not IALIGN-bit aligned, the
> write to misa is suppressed, leaving misa unchanged.

So attempt to disable C extension if next instruction is not aligned should not
change the misa.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Vladimir Isaev <vvisaev@gmail.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20260817150653.40357-2-vvisaev@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/csr.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 4c8959a33d..002f7e69c1 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -2187,9 +2187,13 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
     /* Mask extensions that are not supported by this hart */
     val &= env->misa_ext_mask;
 
-    /* Suppress 'C' if next instruction is not aligned. */
-    if ((val & RVC) && (get_next_pc(env, ra) & 3) != 0) {
-        val &= ~RVC;
+    /* drop write if RVC is cleared and next instruction is not aligned */
+    if ((env->misa_ext & RVC) && !(val & RVC) &&
+         (get_next_pc(env, ra) & 3) != 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Unable to write MISA ext value "
+                      "0x%x, MISA.C disable failed\n", env->misa_ext);
+
+        return RISCV_EXCP_NONE;
     }
 
     /* Disable RVG if any of its dependencies are disabled */
-- 
2.54.0


