Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE81C79FB7
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 01:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Tgg-0003Jp-Aq; Wed, 09 Sep 2026 21:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x4Tgf-0003JR-23
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 21:34:49 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x4Tgd-00022t-H7
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 21:34:48 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 956f58d0204a3-66e4ab19127so1128041d50.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 18:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789004086; x=1789608886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g8ERa42Os9aVokkYe4ss/840Zsv/ImM2me3tQ7NsMxQ=;
 b=YRHd6XZMz4f4ptmeK9pgRJOiAAy4nawDYlLluu0UgXdxHAQbmxhhTTRg5o5ZzQu1YO
 LTDuu4F0MKA44QmcRzMVCXXw4LkLMBieKvD9PDrsR5bkrB0ErDj3zMUksRzjKe/Em5G6
 HSSK1rgoOKKhR/PodYyWiS8NA+56MD/HGCm2Fxqpqt3A9y9ZmZ3FYmBKXNWQoyggPNyV
 J2FKf6ZCsSzPhLVh66y/PCpEhUM+XzF5ty6a1DZFUyT2AotDw273ILPkm0TJZjhRoevY
 QRAOlDPkudINz2mv4TJWC50rnZksHannsmZJjuqBVI6HFe8GNFYs8s3KTvvVf6z3Kxbb
 RgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789004086; x=1789608886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g8ERa42Os9aVokkYe4ss/840Zsv/ImM2me3tQ7NsMxQ=;
 b=esQZxfsfbF5iNpqRRFWNCV89R0wN0dNsFwXWQEPiZNFuUzZZHxGVGXilrYyl1WICQI
 FkE3v7gMOIOBBlU4q9Wg4CMg5uzXBcC6J24SqVMxk99NaQ3FIxGMpQP8ji8K9LA9dAIM
 vXg24n7GgJ4Op2FKQhfe4VLfdnPiP7VfV7em9KBfIoeOPJ5R875qUTAIf0nkTJ7mQpf2
 Qf3Cflz6qKdBuDlSw469cI+Uy7ZkkCKcUps1B2lA0OwW2jcAsb2lxf5ZUtZI/8YOLiYd
 gjwesH9PrjaFqywdP+tARdoE0+X1p29QwPmE0S70pf08riGzwXuckrTFpOn43KRG0Lt1
 rrDw==
X-Gm-Message-State: AFuF++nGXd8JEYSjST8TjPv9YMWDBlxEHceW30UApc49FURbhlEJFJDW
 Btv97AROFmrV6YhZmr+tXzJncppLXpV88qzV/Vid65pQ9nXTYjOLeMlzrtZ3DPd4
X-Gm-Gg: AYBFou2eF4olbk38jqcoc14/MyrRWDCGTJWsBTYSdWq3PvO+5Gn6KPFfiABOgg65yW+
 sj5WOo46idpFwKOiXba2PWoXtJtXz3ez1ujemQ7vyDAuRVebuniHGCrP1P9XUzfqxmuUlgi3ckM
 SbwQYQFnVolk6C2lfT2ARg9D9qaotwvz2sn5dnn26FlRVkRFKCM6/WjkW7p6gPqUElsDSjL2cP5
 95Vx+4Ze00tfQBSUj7LbTQrZ3dSIpfKy9NjFGT7U6IH4oN3tLmRkTPhAhh5Hjne51soNBVp0YIx
 agOrPBQwxtp3sW9YSIlOHnPhLmhWbyWsyBQpsEDnOtbPPi6CovrhiZNlkEPS/o7ILg2RejozfxD
 32T8dfW70OA6WkLwtLapGwJNKeA1YKa3PfZ56VMRIfw072HjbQVIYB0VrSXyZyg0jh2Atjw7v1+
 cuh+OWGjX1AFnQc7lTcwD90qxvB304b0c7NgJoaAM6PIBKWLJ8Ad12OC25lnkQUipBIpv22Bk=
X-Received: by 2002:a05:690e:4188:b0:66e:ac6f:cdf with SMTP id
 956f58d0204a3-6710feec5eamr1586879d50.5.1789004086251; 
 Wed, 09 Sep 2026 18:34:46 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66fc939d4edsm9727304d50.4.2026.09.09.18.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 18:34:45 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/3] target/i386: split the FNINIT out of do_fsave()
Date: Wed,  9 Sep 2026 21:34:40 -0400
Message-ID: <20260910013442.1517793-2-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260910013442.1517793-1-mattst88@gmail.com>
References: <20260910013442.1517793-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=mattst88@gmail.com; helo=mail-yx2-x10.google.com
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

do_fsave() ends with an FNINIT, which is what the FSAVE instruction and
the signal frame setup both want, but it makes the helper unusable for a
caller that only wants to read the state out: recording the registers
would destroy them.

Move the FNINIT into helper_fsave() and cpu_x86_fsave(), and expose the
store alone as cpu_x86_fsave_noinit(). No functional change; the next
patch uses the new entry point to write the x87 registers to a guest
core dump.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 target/i386/cpu.h            |  2 ++
 target/i386/tcg/fpu_helper.c | 13 +++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git ./target/i386/cpu.h ./target/i386/cpu.h
index 9ce8ca0038..2a543ee808 100644
--- ./target/i386/cpu.h
+++ ./target/i386/cpu.h
@@ -2717,6 +2717,8 @@ int cpu_x86_get_descr_debug(CPUX86State *env, unsigned int selector,
  */
 void cpu_x86_load_seg(CPUX86State *s, X86Seg seg_reg, int selector);
 void cpu_x86_fsave(CPUX86State *s, void *host, size_t len);
+/* As cpu_x86_fsave(), but leaving the FPU state undisturbed. */
+void cpu_x86_fsave_noinit(CPUX86State *s, void *host, size_t len);
 void cpu_x86_frstor(CPUX86State *s, void *host, size_t len);
 void cpu_x86_fxsave(CPUX86State *s, void *host, size_t len);
 void cpu_x86_fxrstor(CPUX86State *s, void *host, size_t len);
diff --git ./target/i386/tcg/fpu_helper.c ./target/i386/tcg/fpu_helper.c
index b812125efa..f7cf4220ff 100644
--- ./target/i386/tcg/fpu_helper.c
+++ ./target/i386/tcg/fpu_helper.c
@@ -2536,6 +2536,10 @@ void helper_fldenv(CPUX86State *env, target_ulong ptr, int data32)
     do_fldenv(&ac, ptr, data32);
 }
 
+/*
+ * Store the environment and the register stack, as FSAVE does, but
+ * without the FNINIT that FSAVE performs afterward.
+ */
 static void do_fsave(X86Access *ac, target_ulong ptr, int data32)
 {
     CPUX86State *env = ac->env;
@@ -2548,8 +2552,6 @@ static void do_fsave(X86Access *ac, target_ulong ptr, int data32)
         do_fstt(ac, ptr, tmp);
         ptr += 10;
     }
-
-    do_fninit(env);
 }
 
 void helper_fsave(CPUX86State *env, target_ulong ptr, int data32)
@@ -2559,6 +2561,7 @@ void helper_fsave(CPUX86State *env, target_ulong ptr, int data32)
 
     access_prepare(&ac, env, ptr, size, MMU_DATA_STORE, GETPC());
     do_fsave(&ac, ptr, data32);
+    do_fninit(env);
 }
 
 static void do_frstor(X86Access *ac, target_ulong ptr, int data32)
@@ -3085,6 +3088,12 @@ void helper_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 
 #if defined(CONFIG_USER_ONLY)
 void cpu_x86_fsave(CPUX86State *env, void *host, size_t len)
+{
+    cpu_x86_fsave_noinit(env, host, len);
+    do_fninit(env);
+}
+
+void cpu_x86_fsave_noinit(CPUX86State *env, void *host, size_t len)
 {
     X86Access ac = {
         .haddr1 = host,
-- 
2.54.0


