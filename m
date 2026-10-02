Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27ECCA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xChTg-0008Ed-SP; Fri, 02 Oct 2026 13:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChR0-0004ly-Bx
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:52:40 -0400
Received: from mail-dy2-x15.google.com ([2607:f8b0:4864:36::15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChQw-0007WM-TX
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:52:37 -0400
Received: by mail-dy2-x15.google.com with SMTP id
 5a478bee46e88-34b48100af4so3490699eec.3
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 10:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790963543; x=1791568343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ChpBbIoUUB3K4Vnyut46y+psaR7c+v1x9LwLs1SfZyw=;
 b=jA1NNC+dctz3o1NBYUNNxYe21IuLDzwcZVBk67Hx1doVOc3pRytxKfeRJw8u5Ox/Rp
 +HElLCOy7yIyxqVLSS4TJgKd/oMvn4ly/P13vjvymZF7oykvFFpSYvKtwZQWXLWmvjYT
 +e1Wd02ZNieozXOVsoCXQmc8DacfWb0XY+LWAE+PZnHFXioSx45y09tFPodWV9JMRHEt
 yRBu4NOkzgJ40URld/mVKXu7fM9Mz0zkmtklzQ+L1PKUWN+EqsR1mTn2LJIhFt0F/tWr
 lJN43fwFOC9cTHlGbAW7xda112FRZU+XOJ8ELQJc8Vye/iV58VU+3m2dwy+7DaAbYhJu
 2+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790963543; x=1791568343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ChpBbIoUUB3K4Vnyut46y+psaR7c+v1x9LwLs1SfZyw=;
 b=1cirSTUk9GZG5mphJNaBpBVTXFXg/A1J49VSiFsqgNM2vOTlWrHtGit53KyJDGEje4
 tUT1q33uJ/X6me/SsbuQ397ib54xWtYOLX9iWXkc3LqPJAupeBHDTwV4mvN7C/IVYS6d
 vsuQImPTiKKTeyVvfNC7T4Ff61eQLgwnz4yhgt8C0N2hELdk7NIw7X4OjHbRfGThrHE2
 LYkKUqECQ8tGHUz9QdLgcKjYykNwpJ69wcmX2aHtBymes43Yr+Yp8HBnsIxZyODJIXj6
 8umxv2aSI4FOTVQ+gdqCxkoO9SvgnTi5K8vF7XfhToJ3mFMWJ6G6p6xiS5xgNaMsrutH
 CVhQ==
X-Gm-Message-State: AFq9FYLHFy213n3UizxmcaD1VU8tfE56PYqgLMcJUkK+ePR1BW8/fl5g
 uj3KuGI0tNcf5vS2p0lDSNpba8+fvrXt8A4zXdhE9QU602B6i+AEIXRWl2gHJkFcseM=
X-Gm-Gg: AYBFou0GOTkZJzOQmdAov587q4JRt33oOeQPdqzOA8AjeRWf7HzKr3T3KB0c8Pwfx/A
 iSnNZoyxvo9rf0AWR0o2L0FJNoYOtyjJumEwPShgXN7/NyMHdKGSHtSwPUwani7Nuu/GvQx9hrq
 59GU+OOWg8SaOJknIMiiYJPmn0+w9kbc0oI/+x9WJ4onPB2yyfv+dLQMwSqyBrKRacQ2lNpst3t
 oVlnZ6mRKoB/FKU08kfP65BPqXOaJ/vxb4pvqtxeWmBMhNCmP94wQOFrkKeQbnY/j/9XLMwnKZy
 MrcNyY/3IDPiuUBSPWHN++Y7VF1eGyc0A1b/A4fbV1bS88rgbg2QyJYVHAJRgpNFjOOD6WBeRMV
 8Q4EfeADfO5WGJTJ4lc8H5ianiiM8AtzcLH/P2lczF3A6FqQmJ6h0H1/8LrTha3xv1X0Jo1nZCU
 lt6jZvaI5czwuiiDkbeJUhCPyOmPk2lb/JQfTjpqemV+v8hkOx1f6RiDyy5jLxMESKcTfjb543u
 Y7yXe4pB5+sys3uwi2r1xRDe8ossDk=
X-Received: by 2002:a05:7300:d40c:b0:334:7f2a:1188 with SMTP id
 5a478bee46e88-34f1509e2a9mr3807155eec.14.1790963542651; 
 Fri, 02 Oct 2026 10:52:22 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34f14f9f2afsm18027361eec.18.2026.10.02.10.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 10:52:22 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-s390x@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Rolnik <mrolnik@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Helge Deller <deller@gmx.de>, Chinmay Rath <rathc@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Glenn Miles <milesg@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 12/27] target/s390x: convert exception to raise_excp
Date: Sat,  3 Oct 2026 01:50:20 +0800
Message-ID: <20261002175037.1747-13-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261002175037.1747-1-luoyonggang@gmail.com>
References: <20261002175037.1747-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::15;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x15.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Drop the redundant S390x exception helper and use the current
cpu_raise_excp() API for SVC execution. Translate exceptions through the
shared raise_excp helper.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/helper.h          |  1 -
 target/s390x/tcg/mem_helper.c  |  2 +-
 target/s390x/tcg/misc_helper.c | 10 ----------
 target/s390x/tcg/translate.c   |  2 +-
 4 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 6a7426fdac7..ec27ef104f2 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -1,4 +1,3 @@
-DEF_HELPER_2(exception, noreturn, env, i32)
 DEF_HELPER_2(data_exception, noreturn, env, i32)
 DEF_HELPER_FLAGS_4(nc, TCG_CALL_NO_WG, i32, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(oc, TCG_CALL_NO_WG, i32, env, i32, i64, i64)
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 414e6838c87..ca94960354a 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -2488,7 +2488,7 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
     } else if (opc == 0x0a) {
         env->int_svc_code = extract64(insn, 48, 8);
         env->int_svc_ilen = ilen;
-        helper_exception(env, EXCP_SVC);
+        cpu_raise_excp(env_cpu(env), EXCP_SVC);
         g_assert_not_reached();
     }
 
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index f1c8563af00..f5e31419268 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -56,16 +56,6 @@
 #define HELPER_LOG(x...)
 #endif
 
-/* Raise an exception statically from a TB.  */
-void HELPER(exception)(CPUS390XState *env, uint32_t excp)
-{
-    CPUState *cs = env_cpu(env);
-
-    HELPER_LOG("%s: exception %d\n", __func__, excp);
-    cs->exception_index = excp;
-    cpu_loop_exit(cs);
-}
-
 /* Store CPU Timer (also used for EXTRACT CPU TIME) */
 uint64_t HELPER(stpt)(CPUS390XState *env)
 {
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 474d604ed17..d2bf1422b1f 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -400,7 +400,7 @@ static int get_mem_index(DisasContext *s)
 
 static void gen_exception(int excp)
 {
-    gen_helper_exception(tcg_env, tcg_constant_i32(excp));
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(excp));
 }
 
 static void gen_program_exception(DisasContext *s, int code)
-- 
2.52.0.windows.1


