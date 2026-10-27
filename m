Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDE9606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jXctEM5f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLai2-0004WV-K7; Tue, 27 Oct 2026 02:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLahA-0003hP-CM
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:30:07 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLah4-0008FQ-2P
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:30:01 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-ccce6d9abfeso2406944a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082590; x=1793687390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=funHIXQPOmWBmb41JNVWXREHomSz3djf1dTRB4xtDX4=;
 b=jXctEM5f6gbEwGe6w8rpXVAQo2BGk+0pu03STlWWVw46Jw+KsjgzxtlhB/JIT2tOMk
 P7JZuanxRAw2fX+9TXsSoviqEaw1HR+f/eTXevgeFF1GA8tWUkP9dUuzGt+/dwl0q9yR
 btOayyysWQ6Db/LBbnMX3hYGdzIMGHA+dzQNydVQVtUgFyBo6wSLLv5NYrGbcsWZHPmt
 a+XNLhR/7FDAD1uiJu+RSpg7Ku2+N8kl7SVJNI/xCtID37jP6LCaGOah4Irsz3Zu/wXo
 yNwYWQGd+riYSTYF4lA3alecmpwZjxbUwBhNonm1NfO3+4YWs9ZNDzsfBH0CY/8YLabG
 c4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082590; x=1793687390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=funHIXQPOmWBmb41JNVWXREHomSz3djf1dTRB4xtDX4=;
 b=hEobPI/fGYYl93KNLSOA4S+6t2kk8f+lu09bclJRjBsbIx+rEW71+1EyB9CwVO/4Uf
 64YQvQvMM34wu3DlqqGwvXP+MsgbpUPhi1r43m0/yQCI2SL1vO08zhAHBhkFf3Auh85b
 vUZfhbjoLJySPtHLWFod3MS0cJgiZs6iN5LeGqOz6RxRZZwqhecy6KzfbwvJTyVsekEQ
 10Wdo2tpYiZKbjD/7bjlHaWPYRonmtp+NwsEre1Ex8uU8s/3esI6/Dm6q40QE4/aboSI
 yUuSJHO6lDHJzfbMNusibZzJ7CeYkxcMVa0+RHG9Pzdk96UjPTUsCgVtwDTlXomj9yt4
 ZODA==
X-Gm-Message-State: AFq9FYIU6RX+fpgNt5KckvcV+hW9CjXePbWgMt9GfFied8hnhUmdYhR4
 hzcy4HiB81xjBoefmBHDKb521YFEF6W1r979OTRcg42QjAiLP80rARdOJVrpJA==
X-Gm-Gg: AYBFou1a/qYxsS5FEJKATNZLbPx7AYT87yilYyRVbm0EsYnMO1zOO6qvyKjIO101ocT
 5RF+a5CDXkBti4xBVy5Hf8FjNbLjIFY1kQYHiggvtyRKiypxGAPO+IeNrVSAnheT9umCkMwhMn/
 UYOe1Xp1cRSxD/slT3WTBkx7KrhWPwxTzrN+gT9jxQwM22qExvZJhpkf6AmLe1a6X9pDFkb9NMy
 lOQIL+UA95gfRletTuxm2lReQuSVVxKZep9YaM0stIvKDxm9/DLhTcF5uxdsplJcweFQV/Kpp9V
 SIDT7c+PV58zRp4nV+qnWPXRIJeuBju3JG9fogW6PvJOCZt1n4N+wv3uS1IXWCSCuskpWPkiwEb
 ZQWSWSOaz7MrAkNRlEqyc1yHpd/uz1rWcPXukLSuWD9mqlqAuQhkQ97/GzuehNlu+r5Ri+lyhgj
 VCaAn04kR5jwbygnzesENj/fY+Us4LMDiJaotervlaKPLWqfeZf2oqXNn6jYE/t2PojceoKj1OT
 AOPRGpp8NXcLjglbwbzeMTNjx7DXSY7mIlu71sM+d2ZzTNcmnc0CZBmrAC/kO/KjNXUCalIlQ==
X-Received: by 2002:a17:90a:d40c:b0:3ac:ba49:2fed with SMTP id
 98e67ed59e1d1-3adeafd65e2mr7466392a91.58.1793082590040; 
 Mon, 26 Oct 2026 23:29:50 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:29:49 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fangyu Yu <fangyu.yu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 27/29] target/riscv/csr.c: allow regular mstatus MPV/GVA writes
 again
Date: Tue, 27 Oct 2026 16:28:06 +1000
Message-ID: <20261027062808.1995205-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52d.google.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

In commit 18645f195789 we removed the capability of MPV/GVA writes by
software, claiming that the ISA says that these bits are changed by the
implementation (i.e. hardware).

This fact alone can't be interpret as "so software can't change them".
The ISA never mentions that, and we shouldn't just assume read/write
accesses based on whether hardware updates it or not.  M-mode software
can do whatever they want, unless clearly stated in the ISA, and that
includes mstatus MPV and GVA updates.

And in fact existing software is writing to these bits, as reported by
Fangyu in [1], and that change ended up causing real problems in the
end.

Revert "target/riscv/csr.c: do not allow mstatus MPV/GVA writes".

This reverts commit 18645f19578955ec5ff2c40cd2c8753d6bc460c2.

[1] https://lore.kernel.org/qemu-devel/20261022120111.24298-1-fangyu.yu@linux.alibaba.com/

Reported-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20261024065930.26750-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/csr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 13675b4a8439..af444e3e6f32 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -2108,6 +2108,9 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
     }
 
     if (xl != MXL_RV32 || env->debugger) {
+        if (riscv_has_ext(env, RVH)) {
+            mask |= MSTATUS_MPV | MSTATUS_GVA;
+        }
         if ((val & MSTATUS64_SXL) != 0) {
             mask |= MSTATUS64_SXL;
             val = riscv_write_uxl(env, val, MSTATUS64_SXL);
@@ -2150,7 +2153,7 @@ static RISCVException write_mstatush(CPURISCVState *env, int csrno,
                                      target_ulong val, uintptr_t ra)
 {
     uint64_t valh = (uint64_t)val << 32;
-    uint64_t mask = 0;
+    uint64_t mask = riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GVA : 0;
 
     if (riscv_cpu_cfg(env)->ext_smdbltrp) {
         mask |= MSTATUS_MDT;
-- 
2.55.0


