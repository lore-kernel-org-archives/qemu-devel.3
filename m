Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B21C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 07:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsePK-0007G4-8k; Fri, 05 Apr 2024 03:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zack@buhman.org>) id 1rsePJ-0007Fw-1c
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 03:54:41 -0400
Received: from wfout3-smtp.messagingengine.com ([64.147.123.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zack@buhman.org>) id 1rsePG-00035B-Q8
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 03:54:40 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfout.west.internal (Postfix) with ESMTP id C52911C00126;
 Fri,  5 Apr 2024 03:54:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Fri, 05 Apr 2024 03:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=buhman.org; h=cc
 :cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1712303674; x=1712390074; bh=8j4qK/wGjDwsWHbtb4+2U
 94koTfaX6k5gDRZKE7tJ9k=; b=GNdE9GOnbwctt3yfDbCrGOzjjx8+GYsCZLk2J
 UGoIR9Hi6Y7m/+eFhD0b0bQ22hCg4FQhtQtAlvskMRFrIcUM7aQ4qpIzfN7uibV/
 +omCXvFl6t5iv45bGGQo0RzufuMUO6MlgvFW1HJ8iWfZGGXB7q8t94vJPuz7kPI7
 Nh7TZExQi8K82N4vojHO1I5fWDXE2MHi2mb6EK8vEWItNTl0lzQKEr/uDXz+tNJQ
 OqIf/cRJ4YsZa1qgol6VlZSlyI34IXCd7jCJh5Py1O7fU6EXRmozHBNd93x5fJaG
 n1VM8BRGOSqH64xDrxKSubnqJj6ZKuvzQ/eNK2h1V6kd9B+Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1712303674; x=1712390074; bh=8j4qK/wGjDwsWHbtb4+2U94koTfa
 X6k5gDRZKE7tJ9k=; b=YU+pmjJR6g90H8HEsTJzj6KvN9Yfyxn/WgNlw3OnNxQ1
 CihZ+O+NKNY3WD9vHnkfN3gG46TOV/tyKrShEJ84QSBE6q+Tn3iMMDr7D9rlBlt+
 aHFmGQ7hmobBYO2CiPviz0j0Jsnn38zTH+fvUJSkn9Xo2MfSvUmSDwTxQvreIvUR
 e6IO/qpW0xGCbBYUQtT95LEwvsA3cAXh62t5K6jQpgix86skAQgNLcJU4H9DSkgR
 h1Og2oDgwMcRKJk1a9iJqZeL+/+0oaNVjL3fC0sbl4n0VB4FufHI2OgSuJ8FwAc2
 fih7POyCW0R2iO9kYKhgJ8ZgZEUSz48kqriC15PaEg==
X-ME-Sender: <xms:Oa4PZlfS1QpT_JqAMDyhUnu52t5j0FP6kd9BlINJxwkMFFdLR0jpeQ>
 <xme:Oa4PZjPVLloATh66oeKOfQLeITalsO6doNJNfyYfcrztDA_BuKb9ccV2lc4L84UyL
 ZT5WV0C69CUs8oPiaA>
X-ME-Received: <xmr:Oa4PZujw4DXPnLY9i-1MAntRYmI2U-PB0kBdVLoXWerxedWSP49mPENDViIcgvnp2mHVOQY9Mtus>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefledguddviecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
 dtredttdenucfhrhhomhepkggrtghkuceuuhhhmhgrnhcuoeiirggtkhessghuhhhmrghn
 rdhorhhgqeenucggtffrrghtthgvrhhnpeduteeuleelfeduffejleelgfffiefhueehue
 dtfeeifeeugefhledtvdehudeiieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
 mhepmhgrihhlfhhrohhmpeiirggtkhessghuhhhmrghnrdhorhhg
X-ME-Proxy: <xmx:Oa4PZu9u-pM6xpS31Y_B33voC53Sqw4EC8T7gBf1ggY7-k_Rp-t3uQ>
 <xmx:Oa4PZhu648OFZmTwlbC6AdigHNSQtOrjuEceFWd3f5hiejhVwUIfcA>
 <xmx:Oa4PZtEb9XxCO48yloE2pLcpmR1CdDqrGLfz4WCX95Co--XcHSyDEg>
 <xmx:Oa4PZoMvpMAJqmhAUXIx0g4P9T9KAThikCr6FMYtftG0h-tyPxFfBg>
 <xmx:Oq4PZrILjV7aAFL_JqX2MJbT0bfQaYfawiNDpT72r1AQlBK7KeaveY9N>
Feedback-ID: i1541475f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Apr 2024 03:54:31 -0400 (EDT)
From: Zack Buhman <zack@buhman.org>
To: qemu-devel@nongnu.org
Cc: ysato@users.sourceforge.jp,
	Zack Buhman <zack@buhman.org>
Subject: [PATCH] sh4: mac.w: implement saturation arithmetic logic
Date: Fri,  5 Apr 2024 15:53:57 +0800
Message-ID: <20240405075404.2122-2-zack@buhman.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.146; envelope-from=zack@buhman.org;
 helo=wfout3-smtp.messagingengine.com
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

The saturation arithmetic logic in helper_macw is not correct.

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
	mac.w @r0+,@r1+

 _mach: .long 0xffffffff
 _macl: .long 0xfffffffe
 _m:    .word 0x0002
        .word 0
 _n:    .word 0x0003
        .word 0

test 0:
  (mach should not be modified if an overflow did not occur)

  given, prior to saturation mac.l:
    mach = 0xffffffff ; macl = 0xfffffffe
    @r0  = 0x0002     ; @r1  = 0x0003

  expected saturation mac.w result:
    mach = 0xffffffff (unchanged)
    macl = 0x00000004

  qemu saturation mac.w result (before this commit):
    mach = 0x00000001
    macl = 0x80000000

  In the context of the helper_macw implementation prior to this
  commit, initially this appears to be a surprising result. This is
  because (prior to unary negation) the C literal `0x80000000` (due to
  being outside the range of a `signed int`) is evaluated as an
  `unsigned int` whereas the literal `1` (due to being inside the
  range of `signed int`) is evaluated as `signed int`, as in:

    static_assert(1 < -0x80000000 == 1);
    static_assert(1 < -1 == 0);

  This is because the unary negation of an unsigned int is an
  unsigned int.

  In other words, if the `res < -0x80000000` comparison used
  infinite-precision literals, the saturation mac.w result would have
  been:

    mach = 0x00000000
    macl = 0x00000004

  Due to this (forgivable) misunderstanding of C literals, the
  following behavior also occurs:

test 1:
  (`2 * 3 + 0` is not an overflow)

  given, prior to saturation mac.l:
    mach = 0x00000000 ; macl = 0x00000000
    @r0  = 0x0002     ; @r1  = 0x0003

  expected saturation mac.w result:
    mach = 0x00000000 (unchanged)
    macl = 0x00000006

  qemu saturation mac.w result (before this commit):
    mach = 0x00000001
    macl = 0x80000000

test 2:
  (mach should not be accumulated in saturation mode)
  (16-bit operands are sign-extended)

  given, prior to saturation mac.l:
    mach = 0x12345678 ; macl = 0x7ffffffe
    @r0  = 0x0002     ; @r1  = 0xfffd

  expected saturation mac.w result:
    mach = 0x12345678 (unchanged)
    macl = 0x7ffffff8

  qemu saturation mac.w result (before this commit):
    mach = 0x00000001
    macl = 0x7fffffff

test 3:
  (macl should have the correct saturation value)

  given, prior to saturation mac.l:
    mach = 0xabcdef12 ; macl = 0x7ffffffa
    @r0  = 0x0002     ; @r1  = 0x0003

  expected saturation mac.w result:
    mach = 0x00000001 (overwritten)
    macl = 0x7fffffff

  qemu saturation mac.w result (before this commit):
    mach = 0x00000001
    macl = 0x80000000

All of the above also matches the description of MAC.W as documented
in cd00147165-sh-4-32-bit-cpu-core-architecture-stmicroelectronics.pdf

Signed-off-by: Zack Buhman <zack@buhman.org>
---
 target/sh4/op_helper.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index ee16524083..b3c1e69f53 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -187,20 +187,41 @@ void helper_macl(CPUSH4State *env, uint32_t arg0, uint32_t arg1)
 
 void helper_macw(CPUSH4State *env, uint32_t arg0, uint32_t arg1)
 {
-    int64_t res;
+    int16_t value0 = (int16_t)arg0;
+    int16_t value1 = (int16_t)arg1;
+    int32_t mul = ((int32_t)value0) * ((int32_t)value1);
 
-    res = ((uint64_t) env->mach << 32) | env->macl;
-    res += (int64_t) (int16_t) arg0 *(int64_t) (int16_t) arg1;
-    env->mach = (res >> 32) & 0xffffffff;
-    env->macl = res & 0xffffffff;
+    /* Perform 32-bit saturation arithmetic if the S flag is set */
     if (env->sr & (1u << SR_S)) {
-        if (res < -0x80000000) {
-            env->mach = 1;
-            env->macl = 0x80000000;
-        } else if (res > 0x000000007fffffff) {
+        const int64_t upper_bound =  ((1ul << 31) - 1);
+        const int64_t lower_bound = -((1ul << 31) - 0);
+
+        /*
+         * In saturation arithmetic mode, the accumulator is 32-bit
+         * with carry. MACH is not considered during the addition
+         * operation nor the 32-bit saturation logic.
+         */
+        int32_t mac = env->macl;
+        int32_t result;
+        bool overflow = sadd32_overflow(mac, mul, &result);
+        if (overflow) {
+            result = (mac < 0) ? lower_bound : upper_bound;
+            /* MACH is set to 1 to denote overflow */
+            env->macl = result;
             env->mach = 1;
-            env->macl = 0x7fffffff;
+        } else {
+            result = MIN(MAX(result, lower_bound), upper_bound);
+            /* If there was no overflow, MACH is unchanged */
+            env->macl = result;
         }
+    } else {
+        /* In non-saturation arithmetic mode, the accumulator is 64-bit */
+        int64_t mac = (((uint64_t)env->mach) << 32) | env->macl;
+
+        /* The carry bit of the 64-bit addition is discarded */
+        int64_t result = mac + (int64_t)mul;
+        env->macl = result;
+        env->mach = result >> 32;
     }
 }
 
-- 
2.41.0


