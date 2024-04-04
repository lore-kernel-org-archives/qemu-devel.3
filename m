Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9115FCD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 16:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsPvQ-0003GL-O7; Thu, 04 Apr 2024 12:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zack@buhman.org>) id 1rsPvO-0003FC-Sy
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 12:26:50 -0400
Received: from wfhigh2-smtp.messagingengine.com ([64.147.123.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zack@buhman.org>) id 1rsPvL-0006VE-8T
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 12:26:49 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.west.internal (Postfix) with ESMTP id 8E1CF18001FE;
 Thu,  4 Apr 2024 12:26:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 04 Apr 2024 12:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=buhman.org; h=cc
 :cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1712248004; x=
 1712334404; bh=CrS2tH4Wo60nrFr/QboqFPCXl98MV0fk8Z6FADCpxLE=; b=H
 Zun8PeornXEbquLwHxEF/91+PkYO+X4cGLrofZp3pYy7GiKDNlUnVBd2cD0WIrGC
 hmSP18/N3ufdZVZ9+1tMd3hzVP2H3I0IKVodjAvaE1EfD2YF5y8ps79n9VD4NMIk
 OqQTFGxkJ6V5KVwY8Bp+P6PcVvY2wXOMj5iM43E/uwAxTu4g9RTkL1q/unmmxh4o
 3uiAn4FPjx2aSlMQeJpf0gcXCQBtMT9wTD078pHq+4pCT7rszcV6l6qnfy+o16h8
 B5n887gEwqwwY6+Dkir3Lz9FDVREAlPox2WNN7yPuRKZ6x2cratapryL3+4X0iVx
 g/bbZ0S7Uc5MuC1zy5NIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712248004; x=
 1712334404; bh=CrS2tH4Wo60nrFr/QboqFPCXl98MV0fk8Z6FADCpxLE=; b=C
 mZgXB4dP98zqgsL4X4EO3N2CovRky/ZC1MP5sg01viiP598aX3os6Ws5yr9b/5Tj
 NE9VPfDkRjmON1ZC7d7nJ4omAUuHtNiGi0+Uk1iAldyg0ysXTg1f1w4YpzrYRfzL
 kpBPz3SIVOqWbs9pZsmEDuIihb6QKUK5yF6tXpxrZqWz3P0rnR0pP9Lpj9/zca2i
 rMlfDTZ2S23yv3gq76uGx49ZPM4AtiY8lHGxRcfxzoD0SteNaixdZSQ2vIkZxPgf
 dOgTIa2aukrlFOt1Cbzl19LUZWhl7jDyfPzLzMCe8FXojGUtSq7G6ZWMpfP2X9LG
 Ow9Q7lXfstbDzXMYmSVHw==
X-ME-Sender: <xms:w9QOZrf6iCqQygOcLvoQMeZ15ayhMzJXlVl7V0CmOupFK4Nwc1B4IA>
 <xme:w9QOZhNGPUjiNXizbziNA7HzhNCNwr6FKIGDemZMoB5U6IRmdrTa6uiMJFLM4uJfO
 Wbwusn-x28umD-EHi4>
X-ME-Received: <xmr:w9QOZkhA8Nm28rn4T9Vbkx8_dA6DlLLis70eKCQ4is8T0NKNjgYp6ZtOScf2thJV8lhJK2AbW60Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedguddtvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
 ekredtredttdenucfhrhhomhepkggrtghkuceuuhhhmhgrnhcuoeiirggtkhessghuhhhm
 rghnrdhorhhgqeenucggtffrrghtthgvrhhnpeevhfehtdevfeevgfeiheeltdekgedvfe
 dvfedtffetheefjefhjeetiedtgfdtjeenucevlhhushhtvghrufhiiigvpedtnecurfgr
 rhgrmhepmhgrihhlfhhrohhmpeiirggtkhessghuhhhmrghnrdhorhhg
X-ME-Proxy: <xmx:w9QOZs96T5yYFrbqF08Og1pYnvxxTpNfXbBxsL8fQb1TZtoZEh76QA>
 <xmx:w9QOZnsIRevKC6AlDZtHL8iJuFSn2mQYNJbbLBfH_nHu9ffIvHzHFg>
 <xmx:w9QOZrG6TS5mt5rF5ZTN2oVnw48d7UhD44UEVuIYKuC7z9tkchnFhg>
 <xmx:w9QOZuMUnZiX4VYedBJFmVkQJiXpbOUdkl9RlGkesvKupEzoDfIwyg>
 <xmx:xNQOZhI9-ZLk_s6R9-5EjtGlZAvb8YNdx0xqPG79zDWAacGXAM_GQP7s>
Feedback-ID: i1541475f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 12:26:41 -0400 (EDT)
From: Zack Buhman <zack@buhman.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Zack Buhman <zack@buhman.org>
Subject: [PATCH v2] sh4: mac.l: implement saturation arithmetic logic
Date: Fri,  5 Apr 2024 00:26:39 +0800
Message-ID: <20240404162641.27528-2-zack@buhman.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <CAFEAcA-VQ0yZMoFEuYWD2twe129OZHaer+-_49inW1exANKV2w@mail.gmail.com>
References: <CAFEAcA-VQ0yZMoFEuYWD2twe129OZHaer+-_49inW1exANKV2w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.153; envelope-from=zack@buhman.org;
 helo=wfhigh2-smtp.messagingengine.com
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
 target/sh4/op_helper.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 4559d0d376..ee16524083 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -160,18 +160,29 @@ void helper_ocbi(CPUSH4State *env, uint32_t address)
 
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
+    int64_t result;
+    bool overflow = sadd64_overflow(mac, mul, &result);
+    /* Perform 48-bit saturation arithmetic if the S flag is set */
     if (env->sr & (1u << SR_S)) {
-        if (res < 0)
-            env->mach |= 0xffff0000;
-        else
-            env->mach &= 0x00007fff;
+        /*
+         * The sign bit of `mac + mul` may overflow. The MAC unit on
+         * real SH-4 hardware has equivalent carry/saturation logic:
+         */
+        const int64_t upper_bound =  ((1ull << 47) - 1);
+        const int64_t lower_bound = -((1ull << 47) - 0);
+
+        if (overflow) {
+            result = (mac < 0) ? lower_bound : upper_bound;
+        } else {
+            result = MIN(MAX(result, lower_bound), upper_bound);
+        }
     }
+    env->macl = result;
+    env->mach = result >> 32;
 }
 
 void helper_macw(CPUSH4State *env, uint32_t arg0, uint32_t arg1)
-- 
2.41.0


