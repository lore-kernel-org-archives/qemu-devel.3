Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6DDC3A59D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 23:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rst98-0000O0-TI; Fri, 05 Apr 2024 19:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zack@buhman.org>) id 1rst97-0000Nm-QA
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 19:38:57 -0400
Received: from fout5-smtp.messagingengine.com ([103.168.172.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zack@buhman.org>) id 1rst95-00056A-KS
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 19:38:57 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfout.nyi.internal (Postfix) with ESMTP id 21FBE1380522;
 Fri,  5 Apr 2024 19:38:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 05 Apr 2024 19:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=buhman.org; h=cc
 :cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1712360334; x=
 1712446734; bh=JyJaA02OJsx/nB58pukq3CZO30p1iPwHkLUv67ne780=; b=V
 lweo7W3mxweyjbRE82hCo+jbvzVjnPtcasmKd7305UNAKWLt/lfcunExT0Rgiith
 N7UbrfeX1xmfnD+GTVfVNKXr5jn8/3AX6vezpdpIs/2yN3RDn/BeHFn4Fd2oWbyl
 HFd4MMNOLWS48oiU6AqJm6Cd8Mt+xGzHejefxuAXpmar3wzrFCx4w+Cc8VQLCpkQ
 /+g4S4ALhJAw5tef/ssUjg1ufHjFuX514T02TEw4U4pNEoTfqfd5XJvzrKYNxg9p
 Z5CDAY+iC0G5iKvrTXjc5TGMhfHeMpRsGyHhaF6vFTEKTf3pMOevpIDy7bUhp5F7
 gPoLnTt8duQDz+hPa+0Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712360334; x=
 1712446734; bh=JyJaA02OJsx/nB58pukq3CZO30p1iPwHkLUv67ne780=; b=u
 otH/Z+2cP9n0JPcVjcPhbn+I8jDXinm0MpwYbEAl1zpKiS8LT/GOJgkjkPDaIlKH
 hUE7v/6Og0sAD1IamIDv8MPKB8BksioprzUUV9xcnpZ+nvsuxn8C5oE3fBHMjxyT
 iTRYmA75Z/aULN7XDcWFHsACBvpJq4fdMJPOfQNy/b3FzlPOHahDqs+9cQex/8Ag
 6LMvzQE/xLvGt5qKaU3RKnnf2rfhvfnSdRRCcHfja9ArKzuMsE2yzncQq4FCGuit
 gVMF+NybO98WpWMPrqaKBv55rlnN4+gCnYvcTwjRZRS2aq0MfncIFfzYJAnP26f6
 7cYPYHOk6MYzsHADWtSqA==
X-ME-Sender: <xms:jYsQZuJUPsA0-vSu1b-pB3OJqKpXr1XvB0Yv07aknJIBgraFSL8Icg>
 <xme:jYsQZmJMG19M0uNpfavDeWfsB2DB8eBNNQ5tFbq1PbJNqtly2lB0gb7NPQT6LvxH2
 XZT0O1cuHefnZ41qu0>
X-ME-Received: <xmr:jYsQZuvp92JOmx3lp079ZDrqQYSc7AHOvkP_cHWwdvLQYn9XjoserqvIYUpm314-vb61e3ILbDpz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeguddgvdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
 ertdertddtnecuhfhrohhmpegkrggtkhcuuehuhhhmrghnuceoiigrtghksegsuhhhmhgr
 nhdrohhrgheqnecuggftrfgrthhtvghrnhepvefhhedtveefvefgieehledtkeegvdefvd
 eftdffteehfeejhfejteeitdfgtdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
 rghmpehmrghilhhfrhhomhepiigrtghksegsuhhhmhgrnhdrohhrgh
X-ME-Proxy: <xmx:jYsQZjYnP5PU_z8zKoz2h0KgtwbU4knXjDBTYXLZQqJyNdIfOUZihQ>
 <xmx:jYsQZlb6KaXEm7Y8cJktiCH76ne3Md2t6k936xBlOWSOl7y7dSfyHA>
 <xmx:jYsQZvB29-VCYZjIp6E6TugN5Gw9sMEMSCxPrN-XPzRiGPEhsOHRoA>
 <xmx:jYsQZrbVFnetOEo-nYz6wCaq8NDv5WQmcQ7EV_KwJbk_IJM9gZi8YQ>
 <xmx:josQZozSWdxAus1ZJ04zZgB4HeTdIQJ5psQS05Es0YaLbOUfRRL1Oea8>
Feedback-ID: i1541475f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Apr 2024 19:38:50 -0400 (EDT)
From: Zack Buhman <zack@buhman.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ysato@users.sourceforge.jp,
 Zack Buhman <zack@buhman.org>
Subject: [PATCH v2] sh4: mac.w: implement saturation arithmetic logic
Date: Sat,  6 Apr 2024 07:38:04 +0800
Message-ID: <20240405233802.29128-3-zack@buhman.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <CAFEAcA93s+=sHFNU0duK8--3GhUg1tZ+n+UhiGeFErJoY5_+jQ@mail.gmail.com>
References: <CAFEAcA93s+=sHFNU0duK8--3GhUg1tZ+n+UhiGeFErJoY5_+jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.148; envelope-from=zack@buhman.org;
 helo=fout5-smtp.messagingengine.com
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
 target/sh4/op_helper.c | 45 ++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index ee16524083..07ff2cf53d 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -187,20 +187,45 @@ void helper_macl(CPUSH4State *env, uint32_t arg0, uint32_t arg1)
 
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
+        const int32_t upper_bound =  ((1u << 31) - 1);
+        const int32_t lower_bound = -((1u << 31) - 0);
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
+            /*
+             * If there is no overflow, the result is already inside
+             * the saturation bounds.
+             *
+             * If there was no overflow, MACH is unchanged.
+             */
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


