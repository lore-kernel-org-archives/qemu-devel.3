Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA824C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzc0O-000278-AN; Thu, 27 Aug 2026 11:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wzc0M-00026j-64
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 11:27:02 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wzc0K-0005YU-F2
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 11:27:01 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49b8e527d63so6434975e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787844417; x=1788449217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1U21OR/IIXg06yAP0kDJrvdKDU3O+mHUuP5qP6imk/w=;
 b=orh91PFiPAt+Azeo3zaXztzwL8nlvBEeuq1BucLvLAjb5rOOyU6vbE3D51WBt7rXH4
 i8DkPZEPWqBfn+s3FYt1PKhoPrZmvu6Tb4SBJHVyaqMZ1EvD7qQz3WbjvfSvyiVBxeBr
 Fsj3zdriuebl4OFuJK+2D0p7Rsr1/Ggz8a9SBc3heuMKKKKUdMTXOpH5t1pcpjLW+kiE
 CR8Z/I2SSz4FtU1oTUHSxjBvSHMJCxN0oGDedN4V2dM2tz88DTwHJKTvfgC1dHGcAMpW
 uhIsMAp92R52JHroQv0qROyagwm7aAhTibJIOX/WNRpMQbki4SGDEjPGyVgYszmUxXmR
 GyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787844417; x=1788449217;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1U21OR/IIXg06yAP0kDJrvdKDU3O+mHUuP5qP6imk/w=;
 b=Y7bFudFQg/CrPEs/xGwQ81JR307gmZEs9VE6gPe7SFLrRzDB8nJuzLTV79+pV9v9O1
 xPWc7aJKzu0yzQ+xLuRTAN8N7xcl2ENDz8ThZTqPRazYsCzeuEraE0kgjdpChjFRh8tu
 cKeEO/gDmx/IDK5r1xxOD96rUsMM42tJnDD9DWX4JOuriplNHCjSAbIASO5ysoUBUOj2
 IuxenutE/TRtjf1h7y5336q2B/HN5osAuuDvpMzKIc0r3o553wypFYVhFxeul9hxmzbT
 f3p7yxvcpTPhg1hdj+apFf9G03zZ5oy8mj6hWdL89P/dIBKgtLtAju0n5/+zP/8+cjqe
 hSrg==
X-Gm-Message-State: AFuF++nbeRDo2+7Nmh8cQBK3wSdvTP3aWC7dO3gTQHo7JIn5tkvoiJ+F
 j1pnGVUVkG3Cvg2mOTbzUSSK25pynwNmpfquSkTvskuRtCav5pIbGz0IR9y9IKob
X-Gm-Gg: AR+sD12mhP0DdC9QsnDLJi17AylEbe+O/g16DMOYZjOSWjEK+jYeMD3kKHngg8ge2US
 a/DJLbt1xIKh3crJyD3N31xbpBI1LHnenUDK+/Z8xUWQbPL5un/z+f9Nj58iL73XM0/+Pk637U5
 6RaC7MBQsRorpJWCIPOkVXh5mGzrvhXMY4J267/d6wKxBOlNk2Q6g315Jzdra8E172d3x94UfDS
 vb+4O2reAaBX5cgEbQLFUM5J2070lpC8IOglTWYtLQPFs0Yz/fF9Y0fKVaLoPje62JSKg8IZ8ii
 14r9eF80oMiNPQu3xeXaskQp+Bg/fifVq+U998jiW1JwtrZspbBIdhpArfnQw/kuvJlyVXOJmYc
 ZnSB/bDjZ5JAlKfekqu8eQcOxS+8AyOJe2FG1j36Sq7x0RPvmcGpbZUHZRs2bCMbGW1rCkfq/xu
 8IHd53wl5n+jXDxdr4ok/nM7H8ktFAn1SZ2CDsza2yhBOjPXspRiPRXWusDTpkLPUn42uFm4Npi
 qyZSJKTCuFG9/js9Ed0fbrSrFWdu8WwpQa6tgt38/mLj0+Se06B90ERm2c6Y8MCR4g=
X-Received: by 2002:a05:600c:698c:b0:493:cefc:d113 with SMTP id
 5b1f17b1804b1-499dc6f5dcdmr225500345e9.5.1787844416901; 
 Thu, 27 Aug 2026 08:26:56 -0700 (PDT)
Received: from simon-macbookpro ([2001:4bc9:c076:abab:88db:4e13:7c97:ca38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd5771a3sm69625145e9.4.2026.08.27.08.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 08:26:55 -0700 (PDT)
From: Simon Scherer <scherer.simon89@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 Simon Scherer <scherer.simon89@gmail.com>
Subject: [PATCH] target/i386: clear C1 for all x87 compare instructions
Date: Thu, 27 Aug 2026 17:26:38 +0200
Message-ID: <20260827152638.307913-1-scherer.simon89@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=scherer.simon89@gmail.com; helo=mail-wm1-x32b.google.com
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

The SDM specifies that FCOM/FCOMP/FCOMPP/FUCOM/FUCOMP/FUCOMPP/FICOM/FICOMP/
FCOMI/FCOMIP/FUCOMI/FUCOMIP unconditionally clear C1 in the FPU status word,
regardless of the comparison result.

helper_fcom_ST0_FT0/helper_fucom_ST0_FT0 only cleared C3, C2, C0 (mask
0x4500) before OR-ing in the comparison result, leaving C1 (bit 9) at
whatever value it already had. FICOM/FICOMP dispatch through the same
helpers after converting their integer operand, so they inherited the
same bug.

helper_fcomi_ST0_FT0/helper_fucomi_ST0_FT0 never touched the FPU status
word at all, so C1 was left untouched by those too.

This patch clears C1 explicitly in all four helpers.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4378
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
---
 target/i386/tcg/fpu_helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index b812125efa..49459b5bc1 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -532,6 +532,8 @@ void helper_fcom_ST0_FT0(CPUX86State *env)
 
     ret = floatx80_compare(ST0, FT0, &env->fp_status);
     env->fpus = (env->fpus & ~0x4500) | fcom_ccval[ret + 1];
+    /* C1 is unconditionally cleared to 0 */
+    env->fpus &= ~0x0200;
     merge_exception_flags(env, old_flags);
 }
 
@@ -542,6 +544,8 @@ void helper_fucom_ST0_FT0(CPUX86State *env)
 
     ret = floatx80_compare_quiet(ST0, FT0, &env->fp_status);
     env->fpus = (env->fpus & ~0x4500) | fcom_ccval[ret + 1];
+    /* C1 is unconditionally cleared to 0 */
+    env->fpus &= ~0x0200;
     merge_exception_flags(env, old_flags);
 }
 
@@ -556,6 +560,8 @@ void helper_fcomi_ST0_FT0(CPUX86State *env)
     /* OF, SF, and AF are unconditionally cleared to 0 */
     CC_SRC = fcomi_ccval[ret + 1];
     CC_OP = CC_OP_EFLAGS;
+    /* C1 is unconditionally cleared to 0 */
+    env->fpus &= ~0x0200;
     merge_exception_flags(env, old_flags);
 }
 
@@ -568,6 +574,8 @@ void helper_fucomi_ST0_FT0(CPUX86State *env)
     /* OF, SF, and AF are unconditionally cleared to 0 */
     CC_SRC = fcomi_ccval[ret + 1];
     CC_OP = CC_OP_EFLAGS;
+    /* C1 is unconditionally cleared to 0 */
+    env->fpus &= ~0x0200;
     merge_exception_flags(env, old_flags);
 }
 
-- 
2.53.0


