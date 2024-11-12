Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8ECAD42BB3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAua8-0003nG-1U; Tue, 12 Nov 2024 12:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAuZb-0003Jl-0i
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:21:03 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAuZY-0003kM-Rs
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:21:02 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43162cf1eaaso74894095e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 09:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731432059; x=1732036859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kDP/lIwlRm+EPmYlmR49NSb6qEjZ/RID3Kmdg460Duk=;
 b=FtrsSTMm0VjDLU1peflxDKOXKoVhh34tq8OqMOVl2kk8kW45Ih0WzeeGfoHHNBhW7O
 T/a4iwJD8PHpTOEA56NpJdhM6eJSPw+SO5xY+LDPwMxIZYo6xkHBta2qcWQkYaR4iNl2
 u8PscAxUjdNI9SxVJ147XnS2SHamxLKkIRdz0p/jXcNmVVVa7X5ru2iVT3a2f7t5FC0Y
 vPruH0EfNP6shBPIjJjJdJvYIWcQ+6OBGnesWzVoJYTdB0fPrljDWI4KKJ/Df20gxcJW
 ChisNYy3OleDnQKOimXcU9Rm4jkE1vsFD893oqT8H0dSUnXsjXWJl2a5OFHKhriAXIJu
 evAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731432059; x=1732036859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kDP/lIwlRm+EPmYlmR49NSb6qEjZ/RID3Kmdg460Duk=;
 b=IW0wyTSALAvTCDgVDTiwst/vtBED08TLrd+AZqC3ruc9VmsDiRJANvT8lJ/eFj19//
 VqNDp7ROOks4Ml8J70sRN7FUGZEEAQhRy5sZ/eJeQgLGOYgSuzWsMgVb5wlCK2ZoX3ow
 3EeSBwC3PTNraHR0brKtJFVIeW0VtPA+g1uFyRLWjeBVuAV1BHLu4yCcF/7pc3bbD1C2
 tJG0BnuY+nhamdN3yFveRljyHzafE9wDlV3xIh6o2BuhSnWKOH6y6LM7MBh8Kyc9JyZ3
 Kxtcz9uFKU9i5mlglLstjQPxCkA9JZfhYDbEeb0mBLrOkJHCoWl2l2hP9Yz8slMVHO3A
 Bfww==
X-Gm-Message-State: AOJu0Yz7sSWObZ5HnwX/chnLLqYr4jwgxmB+r6tGrKO3DHJbgGu4yEqx
 zK4o0Ib7sSJE61V1VVcm+3d3jlrr8z7o/8UMraVUElrPrGZdMoQB8fGUmsZJYBNvjpzyFKIVPMl
 t
X-Google-Smtp-Source: AGHT+IG0yx6oy4jTEJyjt349X7gFgH3zWoCWXVedC3njOhbNOi3Td84JaejW2E1ypzcFz0A/Tkh5+Q==
X-Received: by 2002:a05:600c:1c9b:b0:431:5c7b:e939 with SMTP id
 5b1f17b1804b1-432b750b52amr202064115e9.18.1731432058977; 
 Tue, 12 Nov 2024 09:20:58 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381eda04ad0sm15834386f8f.100.2024.11.12.09.20.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 09:20:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v2 6/6] target/mips: Convert nanoMIPS LSA opcode to decodetree
Date: Tue, 12 Nov 2024 18:20:22 +0100
Message-ID: <20241112172022.88348-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112172022.88348-1-philmd@linaro.org>
References: <20241112172022.88348-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Simply call the generic gen_lsa() helper.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/nanomips32.decode        | 6 ++++++
 target/mips/tcg/nanomips_translate.c     | 7 +++++++
 target/mips/tcg/nanomips_translate.c.inc | 4 ----
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/target/mips/tcg/nanomips32.decode b/target/mips/tcg/nanomips32.decode
index 9cecf1e13d..96d2299bfb 100644
--- a/target/mips/tcg/nanomips32.decode
+++ b/target/mips/tcg/nanomips32.decode
@@ -6,3 +6,9 @@
 #
 # Reference: nanoMIPS32 Instruction Set Technical Reference Manual
 #            (Document Number: MD01247)
+
+&r                  rs rt rd sa
+
+@lsa                ...... rt:5 rs:5 rd:5 sa:2 --- ... ...  &r
+
+LSA                 001000 ..... ..... ..... .. ... 001 111 @lsa
diff --git a/target/mips/tcg/nanomips_translate.c b/target/mips/tcg/nanomips_translate.c
index c148c13ed9..43a934d857 100644
--- a/target/mips/tcg/nanomips_translate.c
+++ b/target/mips/tcg/nanomips_translate.c
@@ -12,3 +12,10 @@
 /* Include the auto-generated decoders.  */
 #include "decode-nanomips16.c.inc"
 #include "decode-nanomips32.c.inc"
+
+static bool trans_LSA(DisasContext *ctx, arg_r *a)
+{
+    gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
+
+    return true;
+}
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index e118013edc..0e012ab3d0 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -399,7 +399,6 @@ enum {
 /* POOL32A7 instruction pool */
 enum {
     NM_P_LSX        = 0x00,
-    NM_LSA          = 0x01,
     NM_EXTW         = 0x03,
     NM_POOL32AXF    = 0x07,
 };
@@ -3625,9 +3624,6 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
             case NM_P_LSX:
                 gen_p_lsx(ctx, rd, rs, rt);
                 break;
-            case NM_LSA:
-                gen_lsa(ctx, rd, rt, rs, extract32(ctx->opcode, 9, 2));
-                break;
             case NM_EXTW:
                 gen_ext(ctx, 32, rd, rs, rt, extract32(ctx->opcode, 6, 5));
                 break;
-- 
2.45.2


