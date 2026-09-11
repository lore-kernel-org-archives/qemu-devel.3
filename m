Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21581C88E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4yxf-0006nM-Me; Fri, 11 Sep 2026 06:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1x4yxd-0006mi-GZ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:58:25 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1x4yxb-0003fp-NG
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:58:25 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49ccfbe062eso8905525e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 03:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789124302; x=1789729102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sWcE/Q7YLshEZzUifo4KMPSZOk2BdxGAGVgwp4m9NEo=;
 b=JrhExyi/Hxa9tHuqswHr+diibnYuVdvpKjtHx6LllI/nMO4f8xpKSZjtcrjcM/A7i8
 Lz0cNGSE/k53PjQ5Ac2M4XcmWQUBeo8OUCW9r+yrn/lG1VAp2z/osr65MWIrsp2OTpQq
 UoxP1Chg8qMlHgssQ11E4tf7eA73SaUNbnNOCYzgxWMTJEcRErMtks40dJMhtyyc+dJL
 MdEG2SF+nCr5U9w1HLzoY3Eh21/EOXgNJjNjA6IUdCbQ0ocsmDJeBxbO3gH2jCUymtz/
 81LIKLYf7l/Qy/yxi6D7tX+DnD+wyU8M9/JDR8jjSZvdcUAKYyHgm9iMPZ2LN1gcPDha
 dwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789124302; x=1789729102;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sWcE/Q7YLshEZzUifo4KMPSZOk2BdxGAGVgwp4m9NEo=;
 b=KAEZdl69mKOM8beLNXbiCq41CCAb8S1d4hkBa3NIQ5ocIiD/b6prJEslI5HJ8pVZiE
 0u4H93F6SIip/cl2N/QjjDqwxf/NqvNqH7f4LhM6OVRNHHgFyacUV81LcCxOw9piBINA
 yfkQFClgQq1WuONKe3+vI7iiGiwmG3bAucekPCPV38tVw5RAgHfC65b/jrpo619s0eYW
 uqi8HRDs6ZWnfjadQ4vYCCkGDbibI3WcMJWpNUt0PCcSQxLjbPlkPsk6H+3ftzQFa57R
 0hZ5nFTS/mvOq2bzILNGFHW2KJhz1YXJrKZ5VhgIFQpl6sGiSs6/2Jv7aFX457+enIkI
 hU4A==
X-Gm-Message-State: AFuF++mH61L3l/xJ3v7oGRqHxrZV9NGkkQxdt46zDnQoKxEd5wmRkvQ6
 W3jWxAC3FmwkJxxj0Xg/ya+KmX+sRJWqRr9OqijXOtUMnNgpf4/xLpCcreT9pqfYavTCUA==
X-Gm-Gg: AYBFou3ybKbdGqUtS1039QPx1pO3597gky5OCn1N0enG85O1VJzqkRKj+ox3Nf72S7b
 Keb5JBX492bteXgJgUweVJSQLtj8dA+Cy81bhtleyk1n+5xFuHD8dqjCNwiuk57KnOyFXK0DQhO
 5P+g1yAT58nNFhD9c0lzxTzycniABdcao5YrK8SJ4IcnHzRiEtyr/zWCtWwrhi58csoJpvnqiqx
 I/tKSsTrFVii60VZrXwZZR03WSd8nQdl+xuY34HcU5ibtreHCt9VwJ9inaTye/BtESNpLW7ZivE
 w5p3zsMhRzkuBvGRB3Yqu64xZEF9q3Aduz7B/AOn7XmDyIr9nqAPrn+7SzywaE8w8CyXaSP4H6C
 7MkPoebpB7aQghDcCc1S6eknZRGFt+GqS37wjcUpZtyd1ZWwhzC/xRShP6XA+6++/1M2TQ4dWia
 ffwCxLXpW4aIzd2FzjMvXp3VP2He1/j7cOk9cTqmLa8FXiHUNoa6VJ5Xbm5obnUftL3T87rWd+2
 ppJ5UBmCTazRDt8Uuk7tk2Gy/81K1hbvgw0ZZ/4mUOVQqXcmpvOOIY34BgbJiCHT1oJFJklvxxE
 Dg==
X-Received: by 2002:a05:600c:8b5b:b0:49c:fa20:cc04 with SMTP id
 5b1f17b1804b1-49e619d8827mr45148215e9.27.1789124301413; 
 Fri, 11 Sep 2026 03:58:21 -0700 (PDT)
Received: from simon-macbookpro ([2001:4bc9:c05d:1d06:76a9:c4a3:4ae9:6253])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6221963dsm35039455e9.2.2026.09.11.03.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 03:58:21 -0700 (PDT)
From: Simon Scherer <scherer.simon89@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, qemu-stable@nongnu.org,
 Simon Scherer <scherer.simon89@gmail.com>
Subject: [PATCH] target/i386: Don't clear C1 for FCOMI/FCOMIP/FUCOMI/FUCOMIP
Date: Fri, 11 Sep 2026 12:58:11 +0200
Message-ID: <20260911105811.16854-1-scherer.simon89@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=scherer.simon89@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Commit 6802a4b23919 ("target/i386: clear C1 for all x87 compare
instructions") added an unconditional C1 clear to helper_fcomi_ST0_FT0()
and helper_fucomi_ST0_FT0(), based on the SDM listing "C1 Set to 0" under
FPU Flags Affected for FCOMI/FCOMIP/FUCOMI/FUCOMIP.

Testing on real x86-64 Intel and AMD hardware shows these instructions leave
C1 unchanged, unlike FCOM/FUCOM/FICOM. The SDM text appears to have been
carried over from the FCOM/FUCOM description.

Revert that part of the commit. The FCOM/FUCOM/FICOM changes are kept.

Fixes: 6802a4b23919 ("target/i386: clear C1 for all x87 compare instructions")
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
---
This was caught before 6802a4b23919 landed. V3 [1] dropped the
fcomi/fucomi changes, but v2 was the version applied

[1] https://patchew.org/QEMU/20260902135705.261863-1-scherer.simon89@gmail.com/

 target/i386/tcg/fpu_helper.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 54ff4fe31313..56d093da8c9a 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -565,8 +565,6 @@ void helper_fcomi_ST0_FT0(CPUX86State *env)
     /* OF, SF, and AF are unconditionally cleared to 0 */
     CC_SRC = fcomi_ccval[ret + 1];
     CC_OP = CC_OP_EFLAGS;
-    /* C1 is unconditionally cleared to 0 */
-    env->fpus &= ~0x0200;
     merge_exception_flags(env, old_flags);
 }
 
@@ -579,8 +577,6 @@ void helper_fucomi_ST0_FT0(CPUX86State *env)
     /* OF, SF, and AF are unconditionally cleared to 0 */
     CC_SRC = fcomi_ccval[ret + 1];
     CC_OP = CC_OP_EFLAGS;
-    /* C1 is unconditionally cleared to 0 */
-    env->fpus &= ~0x0200;
     merge_exception_flags(env, old_flags);
 }
 
-- 
2.53.0


