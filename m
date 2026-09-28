Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989AAC9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB3pg-0004zu-1K; Mon, 28 Sep 2026 01:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3p3-0004Jf-1I
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:22:42 -0400
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3p0-0007y6-Vv
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:22:40 -0400
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-144f79153f5so1389303c88.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 22:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790572957; x=1791177757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V7+TSeCs1OkWi/fweWHWaqMKw8c/A0ZiNHA+KMl1mwg=;
 b=Vn0NeLPBMnSS52QqrhG38ARaNza6N1yPkj1WMQHKQTb9dQDAotGMCOW+iYv6Utq+al
 ebmdFjKPZ5vtZpEhm50fHFUF5wH9fLrqBi5cRiIkLhjA2m2V3owLvI6lzvjLqNHKMSDy
 XiteJ/NAHUQyhhLgVk1cPIHTEvr54LyJDpTu3U2elDfQDtyO7hmFhKc4AXhOCp/y6NA0
 5rwb+niHzcrfQMvvsrwhUhPu43XYqfkT1lAjZrM+f/otkaWffmnk9uA5xv7fZrVIscZM
 O7eUbVS+PKlMLisk0M5q12D12+GN8r3jkXhw6kaQchCSrmk1g25Rdi8LnsyOmHthBCoO
 Gb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790572957; x=1791177757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V7+TSeCs1OkWi/fweWHWaqMKw8c/A0ZiNHA+KMl1mwg=;
 b=kIQF96+1YST4ypyzD5wj5tlGIHgJ6SAjbJY2mj+C5opc9PGD+wPUp0UhWFQGTdqziT
 e+ze62zw17TOkIrpfIYuiXwcp/y0Rn5efu5Qd6Qj/ACfHEVHtDZCOKIylkZNt9HtJk6o
 +kTlJp5Ae2UwVzmbnB5A169lnIK00WLkDrO7fP0ewtorVPtE4QZr7yTGnR43QS4Mqo4x
 mZ+lY87TS+gwT8RiAOt1ynlBt+BwfoGuKbkhkQWFIe3SdvMuVPSOKQdezrdnQtnJ8+fn
 XvZisD8GEbsJbZlajEWuOpr2ZYFwBEscLCGnzyGFHlxgFFNPol4gleAzG2A4Ws+NbMMP
 7ffA==
X-Gm-Message-State: AFuF++mr9YAp7+HQPuFmrPhypWo1yhj2BFdPmJaOvymg+Sd06dkyRCHc
 OiJkvuv8rzY2vEtx+Kq0N6g3ytgG6PJEeE+qvcJb2z+JpkVTnNi1osskwTjWQcPGxLA=
X-Gm-Gg: AYBFou13s+mbv+1tZhl8So2EUvYyR8jf70HFlcauq/KdDni5j3LIDfSBi/HK7oYEsqm
 wjZ4fYXvlo1Y64KKjrxFGIgYk9PC4ZHlDQM7ovkiRpjdywycZAS8FeEFQj+rC9axdQ7MkOOk3Hf
 DVKpPqLMbp5HG4WEgnVtZT4ghQGEykxTr+wdJJ/hQiHMWJJQdH9/32F1Fmq279PGZeZHI3ijVfH
 yBD4jP64lCh+r/NJAZqWylReYtrV0/4Gxjpy168hDJclTZkXJy7Bjt5aHjZ70ae77qskJPcocGQ
 Jot0bJhueX4ttG0dTZrW1Z+jHBn0QOaJn75pSGkQNLmTkjNyyS3kmveXAK9ASpQiVvMbjNBQ/XU
 nTghH4wv3vHwqW3DFnJQ1ZgSFaGCRyCt07r9edGc1lhtDrvQygn4emJc8HisnabCdbJRrP/Yfab
 +G70Q/QVc8L7sN1qkGnwK2r2K+B6Gxtfo/2j8QM6gMCjxKzryyAPUE96P5V52Tn/y2ZXZtkgR2l
 lnIryrmL2zguMQkOBJOeLfYFS92h4E=
X-Received: by 2002:a05:7022:f508:b0:143:3769:c680 with SMTP id
 a92af1059eb24-146d0d46e43mr6412033c88.25.1790572956658; 
 Sun, 27 Sep 2026 22:22:36 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-146bb6551d9sm14726248c88.9.2026.09.27.22.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 22:22:35 -0700 (PDT)
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
Subject: [PATCH v2 12/24] target/loongarch: convert raise_exception to
 raise_excp
Date: Mon, 28 Sep 2026 13:20:38 +0800
Message-ID: <20260928052051.251-13-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260928052051.251-1-luoyonggang@gmail.com>
References: <20260928052051.251-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1235;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Translate through raise_excp_restore after storing PC. Drop TCG
raise_exception. Keep C do_raise_exception and use
cpu_loop_exit_excp.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/loongarch/tcg/helper.h    | 2 --
 target/loongarch/tcg/op_helper.c | 6 ------
 target/loongarch/tcg/tcg_cpu.c   | 4 +---
 target/loongarch/tcg/translate.c | 2 +-
 4 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
index e76c73c7755..e3a7bc9e9da 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -3,8 +3,6 @@
  * Copyright (c) 2021 Loongson Technology Corporation Limited
  */
 
-DEF_HELPER_2(raise_exception, noreturn, env, i32)
-
 DEF_HELPER_FLAGS_3(asrtle_d, TCG_CALL_NO_WG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(asrtgt_d, TCG_CALL_NO_WG, void, env, tl, tl)
 
diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
index f98fe4d4a16..109417b7503 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -16,12 +16,6 @@
 #include <zlib.h> /* for crc32 */
 #include "cpu-csr.h"
 
-/* Exceptions helpers */
-void helper_raise_exception(CPULoongArchState *env, uint32_t exception)
-{
-    do_raise_exception(env, exception, GETPC());
-}
-
 /* loongarch assert op */
 void helper_asrtle_d(CPULoongArchState *env, target_ulong rj, target_ulong rk)
 {
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 4b1d44a1644..56ef0d912cc 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -69,9 +69,7 @@ void G_NORETURN do_raise_exception(CPULoongArchState *env,
                   __func__,
                   exception,
                   loongarch_exception_name(exception));
-    cs->exception_index = exception;
-
-    cpu_loop_exit_restore(cs, pc);
+    cpu_loop_exit_excp(cs, exception, pc);
 }
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 124dce62695..b7e8ce8a653 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -95,7 +95,7 @@ static void gen_nanbox_s(TCGv_i64 out, TCGv_i64 in)
 void generate_exception(DisasContext *ctx, int excp)
 {
     tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(excp));
+    gen_helper_raise_excp_restore(tcg_env, tcg_constant_i32(excp));
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
-- 
2.52.0.windows.1


