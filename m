Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE22ECD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 15:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsOkB-00027F-13; Thu, 04 Apr 2024 11:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zack@buhman.org>) id 1rsOk8-00026C-Tn
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 11:11:08 -0400
Received: from wfhigh1-smtp.messagingengine.com ([64.147.123.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zack@buhman.org>) id 1rsOk3-0007BS-Qx
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 11:11:08 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfhigh.west.internal (Postfix) with ESMTP id 1146A18001F0;
 Thu,  4 Apr 2024 11:10:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Thu, 04 Apr 2024 11:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=buhman.org; h=cc
 :cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1712243459; x=1712329859; bh=FwtUJhPA2dsE7VBmoJwnm
 8cZt/eKYh26YYzk+Idp0iU=; b=RHlCeTZi8Ai8yYoa4cDKufYhALHt32p6HgaWo
 H0uObxH7tNhi3oQ4qLJGpXlWgdeBM2o8UEFbJEOz1F4/VJe850t/TqB7xmTh/LEA
 SxeQGmhAs7+ROoFfmyEc+JLVFGsAQaKFaIHZKjtZmQadoqzKBp3mQY2er5CdP9Mr
 iVgABG+/59J3fX+lOsz4TNb1l3nbAe1HWRR08qShZ6tI7bae731eGvfARlklxImE
 gtb5+dmcdA4XDI3Y6M5mZ9BUwzBmdGKcChEeEhbJ9LMgShuZPJ4R4ki1XbRhN1Ld
 c+qjW1kYeOd/CN0l6YNrYaAY/haaZoF5L/zLSeNtgO0KsjYBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1712243459; x=1712329859; bh=FwtUJhPA2dsE7VBmoJwnm8cZt/eK
 Yh26YYzk+Idp0iU=; b=mKa8PLZB8xWznudQeL9LP7mrxKCo3W94FOkYj46E/1ga
 Qu4evQQODJPsY7IUplnSH75ZqZphkJI1vXKKtM2+ArE499/SN0zZOOIAPvHw2LIP
 DJpsVI4kE3fTLxUf2YaBZ1jEEjm2ISn4sW4dfnrmsaEFJCgzvWW5xnH9H1fbN9HE
 lSd3yGead46TVRzp9atQi0BThX604XlXo9CdNNmIR+rYKT1tkaPLHmk8Q8IW7Txr
 a1ik5o8DGvqRH6JT+bSl/KI7zy3EPhug95Ou8c2TspJfKiOj+l/jLb8Je6bWnIs/
 XeKgtVikS1Ekfk9CNp5UBQpcV3MqjMwRlfyjn+gfhQ==
X-ME-Sender: <xms:AsMOZmiIXHR9DDdnljlUic7-OxI2YnTfrgvvRPhSziAogbYUhBGDRA>
 <xme:AsMOZnCgyeUpoPmiTlOymGFRSh7EQxojBgwIbD2LOE6l7Q0abBKB0eIlJuIFeFzyw
 DWPK6yK2oa4bmKbQhs>
X-ME-Received: <xmr:AsMOZuFHnvtF6V19DXgHmQPhs5Ipwhxwk-cWU2Tm9yvafUT9PY0rRRzNTl13aspauS2KalOW3GRe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgkeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
 ertddtnecuhfhrohhmpegkrggtkhcuuehuhhhmrghnuceoiigrtghksegsuhhhmhgrnhdr
 ohhrgheqnecuggftrfgrthhtvghrnhepudetueelleefudffjeellefgffeihfeuheeutd
 efieefueeghfeltddvheduieeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
 pehmrghilhhfrhhomhepiigrtghksegsuhhhmhgrnhdrohhrgh
X-ME-Proxy: <xmx:AsMOZvQsSP3SeJirIrvSFNrHQaf-AEBR776KYZSjx22jZ3AQuVsxpw>
 <xmx:AsMOZjwgUvXdnVLhUAis1kcrfOkXLkyVP1TUGfXzM69HDPfGDIjohg>
 <xmx:AsMOZt49JH2e30EDWd2AFbxWL_xTpuKbTHahLSoxH7ByKC5Mj5ZE-g>
 <xmx:AsMOZgxdSdeFEcF3UbZKCDSsRi-7pNDcKx4W-w2a3MeG6eGRy95mfA>
 <xmx:A8MOZj9B11y_3pW4iO91W-zlKzr9rqJsSe1ix4OsL_9SDyORgUxz_Gzx>
Feedback-ID: i1541475f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 11:10:57 -0400 (EDT)
From: Zack Buhman <zack@buhman.org>
To: qemu-devel@nongnu.org
Cc: Zack Buhman <zack@buhman.org>
Subject: [PATCH] sh4: mac.l: implement saturation arithmetic logic
Date: Thu,  4 Apr 2024 23:10:35 +0800
Message-ID: <20240404151100.24063-1-zack@buhman.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.152; envelope-from=zack@buhman.org;
 helo=wfhigh1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

The saturation arithmetic logic in helper_macl is not correct.

I tested and verified this behavior on a SH7091, the general pattern
is a code sequence such as:

	sets

	mov.l _mach,r2
	lds r2,mach
	mov.l _macl,r2
	lds r2,macl

	mova _n,r0
	mov r0,r1
	mova _m,r0
	mac.l @r0+,@r1+

    _mach: .long 0x00007fff
    _macl: .long 0x12345678
    _m:    .long 0x7fffffff
    _n:    .long 0x7fffffff

Test case 0: (no int64_t overflow)
  given; prior to saturation mac.l:
    mach = 0x00007fff macl = 0x12345678
    @r0  = 0x7fffffff @r1  = 0x7fffffff

  expected saturation mac.l result:
    mach = 0x00007fff macl = 0xffffffff

  qemu saturation mac.l result (prior to this commit):
    mach = 0x00007ffe macl = 0x12345678

Test case 1: (no int64_t overflow)
  given; prior to saturation mac.l:
    mach = 0xffff8000 macl = 0x00000000
    @r0  = 0xffffffff @r1  = 0x00000001

  expected saturation mac.l result:
    mach = 0xffff8000 macl = 0x00000000

  qemu saturation mac.l result (prior to this commit):
    mach = 0xffff7fff macl = 0xffffffff

Test case 2: (int64_t addition overflow)
  given; prior to saturation mac.l:
    mach = 0x80000000 macl = 0x00000000
    @r0  = 0xffffffff @r1  = 0x00000001

  expected saturation mac.l result:
    mach = 0xffff8000 macl = 0x00000000

  qemu saturation mac.l result (prior to this commit):
    mach = 0xffff7fff macl = 0xffffffff

Test case 3: (int64_t addition overflow)
  given; prior to saturation mac.l:
    mach = 0x7fffffff macl = 0x00000000
    @r0 = 0x7fffffff @r1 = 0x7fffffff

  expected saturation mac.l result:
    mach = 0x00007fff macl = 0xffffffff

  qemu saturation mac.l result (prior to this commit):
    mach = 0xfffffffe macl = 0x00000001

All of the above also matches the description of MAC.L as documented
in cd00147165-sh-4-32-bit-cpu-core-architecture-stmicroelectronics.pdf
---
 target/sh4/op_helper.c | 45 ++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 4559d0d376..a3eb2f5281 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -160,18 +160,43 @@ void helper_ocbi(CPUSH4State *env, uint32_t address)
 
 void helper_macl(CPUSH4State *env, uint32_t arg0, uint32_t arg1)
 {
-    int64_t res;
-
-    res = ((uint64_t) env->mach << 32) | env->macl;
-    res += (int64_t) (int32_t) arg0 *(int64_t) (int32_t) arg1;
-    env->mach = (res >> 32) & 0xffffffff;
-    env->macl = res & 0xffffffff;
+    int32_t value0 = (int32_t)arg0;
+    int32_t value1 = (int32_t)arg1;
+    int64_t mul = ((int64_t)value0) * ((int64_t)value1);
+    int64_t mac = (((uint64_t)env->mach) << 32) | env->macl;
+    int64_t result = mac + mul;
+    /* Perform 48-bit saturation arithmetic if the S flag is set */
     if (env->sr & (1u << SR_S)) {
-        if (res < 0)
-            env->mach |= 0xffff0000;
-        else
-            env->mach &= 0x00007fff;
+        /*
+         * The following xor/and expression is necessary to detect an
+         * overflow in MSB of res; this is logic necessary because the
+         * sign bit of `mac + mul` may overflow. The MAC unit on real
+         * SH-4 hardware has carry/saturation logic that is equivalent
+         * to the following:
+         */
+        const int64_t upper_bound =  ((1ull << 47) - 1);
+        const int64_t lower_bound = -((1ull << 47) - 0);
+
+        if (((((result ^ mac) & (result ^ mul)) >> 63) & 1) == 1) {
+            /* An overflow occured during 64-bit addition */
+            if (((mac >> 63) & 1) == 0) {
+                result = upper_bound;
+            } else {
+                result = lower_bound;
+            }
+        } else {
+            /* An overflow did not occur during 64-bit addition */
+            if (result > upper_bound) {
+                result = upper_bound;
+            } else if (result < lower_bound) {
+                result = lower_bound;
+            } else {
+                /* leave result unchanged */
+            }
+        }
     }
+    env->macl = result;
+    env->mach = result >> 32;
 }
 
 void helper_macw(CPUSH4State *env, uint32_t arg0, uint32_t arg1)
-- 
2.41.0


