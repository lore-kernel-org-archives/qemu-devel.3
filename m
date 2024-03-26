Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC217C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 18:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpBHv-0003LP-Lw; Tue, 26 Mar 2024 14:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpBHt-0003Ky-UU
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 14:12:41 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpBHs-0006a1-EG
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 14:12:41 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e6ee9e3cffso57056b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 11:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711476759; x=1712081559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I8a9WjWDrqxriphQGGBwyT2pmHKUNZR60B8CaaxBya8=;
 b=WVt4jykCpx6gbf9I74egcVebMaIKOiWVsCvu2lx64rh/hSBRZ548hQrG85bdlVDEsy
 PujID7zAlqdwHx+GiACJCzJ6Om1RpJZDrTSYRjHJrSVorBwU3r+uzUP9C2kKsn1pgTsy
 S9QZwsOaHL6eWex5lV2nshcfa7eD3UOxBJCZehfxw4HTg77LF9qRqcXTfoQpOjd2cpQ3
 gOUq29uBmq8FaSMUFiy+ebpPtsoyrHgGPCFTQc0HSh7PEC9RorFeQMom/7IGRrVteUQn
 XMcF4AHYhOoG7fEaUsJlwk6a7q/sLLyEujQaBeoaEEnLuSmhosUYNGs+McWs04D4MeFq
 MmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711476759; x=1712081559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I8a9WjWDrqxriphQGGBwyT2pmHKUNZR60B8CaaxBya8=;
 b=JqOtmd+M7A32IZeNMyqVZt+FEqmjkXUQ7gjdz1XG1r5EPempfNzfY3TjwwKwNfwRYQ
 ARrOdmJ/W/MmUBD71CsoeJOPDs5uziT1/Ba5xKeabgVRmaGT4g+yAc34hTo7Yg44LtjA
 ftUFWS9T0Z02LvSxzkXgzxd0tI1jX+Rt1GiPCXtZPYM0wRwbS+IROjW9bqNyjfsg1Koo
 4LwAXawJ1Jc1pQi6fPXvkGAWlyJ1fc1sdT+OsrWJzwQbe5+tSqZsnQN2PGLKmG559QTk
 3E56D+R+g0i7k5L5SAUW8QeU0cfSKiuv770r7rFMuE0LqsRjjGapFyRODMRSeGOgWH4P
 LTJA==
X-Gm-Message-State: AOJu0YyhU3RtGFfCt3CeUPj7Q27QCJeAua8Keqmv5aLHSYHoBrHzoiPT
 qC48KyxuyY9i7G/NJaY7P/qzWn49N6NrXCEApQwa108UoQgBf4gpM+nfkrTgDx6N7AS7B8cC5Hp
 a
X-Google-Smtp-Source: AGHT+IEGoWExyyzz9RoZpG9ci/cVludln7p5Z4TdcTcW/7W/qVGZRyZWAtYchJKZPigDV15W3HwfYQ==
X-Received: by 2002:a05:6a20:7f84:b0:1a3:b05a:52a5 with SMTP id
 d4-20020a056a207f8400b001a3b05a52a5mr2752099pzj.20.1711476758779; 
 Tue, 26 Mar 2024 11:12:38 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 q27-20020a63751b000000b005bd980cca56sm7835336pgc.29.2024.03.26.11.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 11:12:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org
Subject: [PATCH v2 2/3] target/hppa: Move diag argument handling to decodetree
Date: Tue, 26 Mar 2024 08:10:27 -1000
Message-Id: <20240326181028.332867-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326181028.332867-1-richard.henderson@linaro.org>
References: <20240326181028.332867-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Split trans_diag into per-operation functions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode |  8 +++++++-
 target/hppa/translate.c  | 34 +++++++++++++++++++++-------------
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 6a74cf23cd..9f6ffd8e2c 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -634,4 +634,10 @@ fdiv_d          001110 ..... ..... 011 ..... ... .....  @f0e_d_3
 xmpyu           001110 ..... ..... 010 .0111 .00 t:5    r1=%ra64 r2=%rb64
 
 # diag
-diag            000101 i:26
+{
+  [
+    diag_btlb               000101 00 0000 0000 0000 0001 0000 0000
+    diag_cout               000101 00 0000 0000 0000 0001 0000 0001
+  ]
+  diag_unimp                000101 i:26
+}
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 29e4a64e40..42dd3f2c8d 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4572,23 +4572,31 @@ static bool trans_fmpyfadd_d(DisasContext *ctx, arg_fmpyfadd_d *a)
     return nullify_end(ctx);
 }
 
-static bool trans_diag(DisasContext *ctx, arg_diag *a)
+/* Emulate PDC BTLB, called by SeaBIOS-hppa */
+static bool trans_diag_btlb(DisasContext *ctx, arg_diag_btlb *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
 #ifndef CONFIG_USER_ONLY
-    if (a->i == 0x100) {
-        /* emulate PDC BTLB, called by SeaBIOS-hppa */
-        nullify_over(ctx);
-        gen_helper_diag_btlb(tcg_env);
-        return nullify_end(ctx);
-    }
-    if (a->i == 0x101) {
-        /* print char in %r26 to first serial console, used by SeaBIOS-hppa */
-        nullify_over(ctx);
-        gen_helper_diag_console_output(tcg_env);
-        return nullify_end(ctx);
-    }
+    nullify_over(ctx);
+    gen_helper_diag_btlb(tcg_env);
+    return nullify_end(ctx);
 #endif
+}
+
+/* Print char in %r26 to first serial console, used by SeaBIOS-hppa */
+static bool trans_diag_cout(DisasContext *ctx, arg_diag_cout *a)
+{
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+#ifndef CONFIG_USER_ONLY
+    nullify_over(ctx);
+    gen_helper_diag_console_output(tcg_env);
+    return nullify_end(ctx);
+#endif
+}
+
+static bool trans_diag_unimp(DisasContext *ctx, arg_diag_unimp *a)
+{
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
     qemu_log_mask(LOG_UNIMP, "DIAG opcode 0x%04x ignored\n", a->i);
     return true;
 }
-- 
2.34.1


