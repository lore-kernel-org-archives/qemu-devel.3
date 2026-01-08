Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07A3D1489F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdifi-0004al-Px; Thu, 08 Jan 2026 00:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdifd-0004SC-67
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:34:53 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdifb-0005xP-Iu
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:34:52 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a137692691so21562955ad.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850490; x=1768455290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iPCUPgmqCPlQV857vKt3p+PMVqLWxwQcBCKjihbg3eo=;
 b=mEbB5duMqLYoefUX+m80lEYOWKTp+QLJ8O9krBcTRQP5n1PYcDWWIQdjRw3cE9h3rk
 yiH/B1ybR02i0N13X5ICmxFiv3XXjdbiTj6jOy9xGbXQiyrd1wz62NZXsk5LJfhEdZED
 tJf1e7Ekto6hKpfCPrNTEbIxkLmn23Zw7vkNMobwORQZx213Fdzwzs2NSQl7P4bTlSIj
 6KPcY+p8y6cfDIrOC42pmiYhB3AXT+d43zoKOVrCuz8qU4D3XzlDy9YZpELWjPjj0jUa
 KnKM4TeaIkGuNexmOkwV1amg5pIWbO6T7UbttyCR+1nh+mOuJOS+o2ExCBmYYLK4+dIU
 m9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850490; x=1768455290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iPCUPgmqCPlQV857vKt3p+PMVqLWxwQcBCKjihbg3eo=;
 b=rAtFcSsazQvtz39ykXv1+Dirgsc2XpkTdxqaq0ing4u+aU4P8I0+mwUs6YpSxyMOgR
 tXW4GogU7glikBpCUDZz3gohi54BfFVLNtVZ3sIoVMuj5jSZX2VdIYnJS98EhegC1Akn
 cOiebtyLJGMGmEPAYA54k1c+n4KWcRToUlMDIoQvMNf+JGFAQAg1YpEcO+RjG+/Otcts
 3BhKOtUzLKewMe8PQiDvjX2nyaNzFwLH6lXD4iZzOOApCFpLw8H0/CVK1TY0sA0QSmYt
 QqdpSGgD/lq08+JlKwzewkA0BGQ3IdbgoC44Tnb5ZtMqxnkB89dJlGHOV7TTQ5wQVULI
 oVPw==
X-Gm-Message-State: AOJu0Ywjn+hueLl66Tt4PRA0gNX3NXIKWMqohmnL9WNT/ETH1iyzoEaL
 Nut6HKZ0mTO2M3r3kN3YrDOxHA1NYENSM4ZFtBP+yu73fi3GqmejWuU+6lzfff/xJOOZgQSyRCa
 p3wWgiKk=
X-Gm-Gg: AY/fxX60VSwsGWcKtuR0tDvLUXdReQFkk8jwNrb8tNzgBrDatY4y+oyPOyOkiu+1tom
 9ER8LiSCF/Qc3pCclhUJ7P0zcrcYlBes/7g+nEZUyO3iJWtoShNpgDE8t6EC5pwt43gGZrCfCZ3
 Ty0RtPK1kfIN9qorRs8tvLn8OLvQ2BgHhoeHYcIwm/BD2irFr2twS6NcZhorNdmQC5j43cwc65Q
 Rop1pwO5fotq0HXv7kx+SbsqFn8YZH7wf311WGiek4J3hKHrjHtccQVzAyr3oCd4yb+0MWFXLnm
 9Xl5dilOrQbUHrk2zDpBJzRQEY0gCk0uwBksPmXmBtwmwMOFVftHx2yijY+h9mV2hyKztrFQ6pD
 AOTLERCeHEO4rEHl/IO1KSaAoJbU0uyLcWir6We25goQeXvQ2umFNMCZns7rzeiroIqfKBcOtTQ
 k5cqe7qbjjHDyUi1RJmA==
X-Google-Smtp-Source: AGHT+IHbUBkF+rrIgYIe/bh0oGoGWNs4Rwo953FbBBm0DV3FvD0lWrhTGy9tc+Zfzr7tHj/d0Ld30A==
X-Received: by 2002:a17:903:478d:b0:2a0:b438:fc15 with SMTP id
 d9443c01a7336-2a3ee468407mr47089545ad.11.1767850489855; 
 Wed, 07 Jan 2026 21:34:49 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2d93sm66341465ad.63.2026.01.07.21.34.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:34:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 43/50] target/m68k: Drop CONFIG_ATOMIC64 tests
Date: Thu,  8 Jan 2026 16:30:11 +1100
Message-ID: <20260108053018.626690-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/op_helper.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index e9c20a8e03..3f1d943afe 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -816,14 +816,11 @@ static void do_cas2l(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2,
     uint32_t u2 = env->dregs[Du2];
     uint32_t l1, l2;
     uintptr_t ra = GETPC();
-#if defined(CONFIG_ATOMIC64)
     int mmu_idx = cpu_mmu_index(env_cpu(env), 0);
     MemOpIdx oi = make_memop_idx(MO_BEUQ, mmu_idx);
-#endif
 
     if (parallel) {
         /* We're executing in a parallel context -- must be atomic.  */
-#ifdef CONFIG_ATOMIC64
         uint64_t c, u, l;
         if ((a1 & 7) == 0 && a2 == a1 + 4) {
             c = deposit64(c2, 32, 32, c1);
@@ -837,9 +834,7 @@ static void do_cas2l(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2,
             l = cpu_atomic_cmpxchgq_be_mmu(env, a2, c, u, oi, ra);
             l2 = l >> 32;
             l1 = l;
-        } else
-#endif
-        {
+        } else {
             /* Tell the main loop we need to serialize this insn.  */
             cpu_loop_exit_atomic(env_cpu(env), ra);
         }
-- 
2.43.0


