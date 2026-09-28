Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB433C98328
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB3s7-00089l-OF; Mon, 28 Sep 2026 01:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3pZ-000521-IE
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:23:16 -0400
Received: from mail-dy2-x0d.google.com ([2607:f8b0:4864:36::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3pV-00084D-5d
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:23:11 -0400
Received: by mail-dy2-x0d.google.com with SMTP id
 5a478bee46e88-3468ec309afso490218eec.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 22:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790572987; x=1791177787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X7b/dJOQ8n/cIrrEJW6O4TLysukMn1IvMkhhR/OEoxQ=;
 b=lfiLcw5UZ/T7HoYu1TtdOUTAZIjz9/0cW/lXa2/uuu3x1WOh+Z0wDczEZIyViy+j64
 sZ2b/bqlau8grh3ri2Ffb4Xyi4vvuPpIpLPsUGPr/dQ4fYYnEKg0Vj6FHMhDFJn56Kzi
 IpsuzvI+E94Pgul2zzz1wgY3fdxbF+C2OiljE20TDIAPlKxN+fQn4Dbihns5H+aZN0ik
 8oQZobtdoeTzmJQi++68lgKAF6s8IcHgyfC5u2mKsB89FqZZeT7jIWi5KTHLnlpGo3U5
 oGx4HNXcilJwdmoN+yxWxO9LZGadodPvVbSvmEspxMMvPBK0ytK2yTv2NgMGXiyG6pyH
 zHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790572987; x=1791177787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=X7b/dJOQ8n/cIrrEJW6O4TLysukMn1IvMkhhR/OEoxQ=;
 b=NBC/1sUyF1Rjvn/7/oiyB7DnWIQMaaDEoglXyg/ertKtgU7FcvDHOmWaXfc3Wvc32F
 FJSw5tspJ5+hrUIqlTCuLVHJl0Pda7VetD8FRsetPtlsou51nkrTOOWfHct0oaHA/8JV
 vuoHkqxC/wcbzBBQIYamhPBhB7BBbCcdLyWVyAbJrDGQkTL05/wjsQjwbCdzsdFYq9mf
 vtWtS5T9uabwPlJKS21IyJleFMybEO1Cc6jqdnNJWiRw7LvTSAQbv/dyQhGK0R/1mjzc
 W6QiPszbkOCI0fjFcB3uPXY4YqPVBCnsoSwhVUk4dE5NZ9qMZRQrVyDlpU/qCfrP68AM
 Rohw==
X-Gm-Message-State: AFuF++kU1nweNfUU5NJj8/fz4fzKoej6Fa0W0fA9uqPOkSPyfh2NmAoA
 TnJUWKd6uP9TYsYbgtQUXzRnRZvSLybN4UG23OY76IF3zHEfsXQFbRlN7Ou1krFSfis=
X-Gm-Gg: AYBFou1QecbljvyN8wjeCZSQ/pkooUTUN6CaOeMP8n96wRRL/xJXZe8PtvYzuY5nc/j
 gKUJmzlLpVDMc6N4SOHDslYFCl19AEkuH32zd+1+Lxel+MR/SnTCPkg1S9nAWGbPQ6LuWt2dIVD
 iTvtf+KQu9L0WjQCNlI8F2FRlnGpFPtqy74Lbz8GxogJjGWmMdIl6dXbYCDPJMkRhdQEmFFsZNm
 uXTN/x1LWSBlZxOywUnTkiUaprBTHF3odyMcSvIKs8IgrpoOCBvvOIB07igQwVv7RdRZc+OFuEb
 kconjPnOdRjY3/76xyCCN9DKHWM9p3Xl3iHRcRCVihCtyU5o1GUT1xx5GHIBc+p00MMwGWd3uE9
 2LJvROyLuDVqlIQOPY/NOJDfTwsdMgmtcdL+i+6K7ks6FEcURI0rDgYisjAxsw8fgJAEUmBkUeR
 xoGyoVS1cITs/Jw23KvEtoiR3hYyB6xSMR0xhZvJsf13oxRjtv14oQrZs6w+7lgyg1DFIQLfAAs
 FSKEwpLKHxYPr5/+T4Of56Fl7wgRoA=
X-Received: by 2002:a05:701b:281b:b0:144:f4b9:9be4 with SMTP id
 a92af1059eb24-146ce492cb6mr7528924c88.15.1790572987367; 
 Sun, 27 Sep 2026 22:23:07 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-146bb6551d9sm14726248c88.9.2026.09.27.22.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 22:23:06 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Chao Liu <chao.liu@processmission.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Stafford Horne <shorne@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>, Glenn Miles <milesg@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Song Gao <17746591750@163.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Michael Rolnik <mrolnik@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org
Subject: [PATCH v2 16/24] target/s390x: convert exception to raise_excp
Date: Mon, 28 Sep 2026 13:20:42 +0800
Message-ID: <20260928052051.251-17-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260928052051.251-1-luoyonggang@gmail.com>
References: <20260928052051.251-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::d;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0d.google.com
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

Drop TCG exception and call raise_excp. Keep data_exception. Route
leftover C SVC execute through cpu_loop_exit_excp.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
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
index 414e6838c87..3f754dac00f 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -2488,7 +2488,7 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
     } else if (opc == 0x0a) {
         env->int_svc_code = extract64(insn, 48, 8);
         env->int_svc_ilen = ilen;
-        helper_exception(env, EXCP_SVC);
+        cpu_loop_exit_excp(env_cpu(env), EXCP_SVC, 0);
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


