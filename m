Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DA6C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1ouP-00030x-PK; Tue, 30 Apr 2024 10:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1ouN-00030f-EC
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:56:39 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1ouK-0006hC-Eh
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:56:39 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2def8e5ae60so66840251fa.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 07:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714488994; x=1715093794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=upYrT6zRZ258RQvIX6lEsJRlpAaxzaJODGSB0NJY3bM=;
 b=GIbI9qfvPi+zIAZSMiFHLV9uZhgsbJ+Jrb79uf9hRCsc2x9NnZmu7d+xxwHucfauWJ
 snjnB8mODWHHlwkueSs164IUu88rUm8CEhY0rdrNIctYqrYL7CJW1MbhVrB7pB0QFX4h
 N6EZLTt8Rim9RyieBSBiXper77vazQnCtbLWnetiRPR3vqda1Do2JcspdECRYM6bkhmd
 3NiUZKbYG+QYR5+EcX4p7yf8htTKSk/4S0rJGinWs8qFyRXKbHhImLiVlRoFbxZVwQSo
 T0P391NwUO6i/Ug7OfP2vGitLseJTfNV+kKeuFmJ9L7tBu8g23zOA2wJLFJN5jgUIM0S
 MwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714488994; x=1715093794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=upYrT6zRZ258RQvIX6lEsJRlpAaxzaJODGSB0NJY3bM=;
 b=Pu4uigBIjI70T/YS3GKxEsDszM9Zia1kDqaSK4opH/f7KKLCqI7PMmke1FMEf3TASX
 KEQth61DtlIZewMKk3rU4bVsNYG5veMW4VqwlqN3u7yHivL4x1GWrTFt4omDshBGEosM
 xB31i6e1UnFk92f1hXmn7YSXUf7qH73dWuCrqwpdScC6ClP3mpSGGZxSnWGxmThVE05V
 zGI3V35tpuHhnHDgzzQ+2qNsJAvNfiq8MQJDTfIrwY20Mt9PKhZ7r8ow8dwqMTPZbGXP
 sMHy2GPCXxbgHw64UcOnLuBoTwygg76jPK29f3SiwRGNnNVSj60ad/zDWRuu9UaE7O/X
 8rjQ==
X-Gm-Message-State: AOJu0Yyrs4mnhs2pvVzmvsEBL4Mz9J94azmfBdZQk9yXVC5TkqD4Em8P
 DM51DGP99qzdmXdM3iy3QeFApFK+FV83uraeqVzgwA0QLgzO3572p2J0pPAXynK9MFe1wuEsecG
 1
X-Google-Smtp-Source: AGHT+IGSTew6Z+IJNKwZGICGp3yTi2Etqi4PS8j1Er/cm1fX/D/WmPJIs+J/h3QcTg1hXObJq/oEwg==
X-Received: by 2002:a2e:8552:0:b0:2df:d2a4:4360 with SMTP id
 u18-20020a2e8552000000b002dfd2a44360mr5766930ljj.49.1714488994368; 
 Tue, 30 Apr 2024 07:56:34 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 g9-20020a05600c310900b0041aa79f27a0sm28419086wmo.38.2024.04.30.07.56.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 07:56:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Cercueil <paul@crapouillou.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 3/4] target/sh4: Rename TCGv variables as manual for ADDV
 opcode
Date: Tue, 30 Apr 2024 16:56:13 +0200
Message-ID: <20240430145614.76475-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240430145614.76475-1-philmd@linaro.org>
References: <20240430145614.76475-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

To easily compare with the SH4 manual, rename:

  REG(B11_8) -> Rn
  REG(B7_4) -> Rm
  t0 -> result

Mention how overflow is calculated.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/translate.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 3e013b7c7c..47c0f3404e 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -705,16 +705,20 @@ static void _decode_opc(DisasContext * ctx)
         return;
     case 0x300f: /* addv Rm,Rn */
         {
-            TCGv t0, t1, t2;
-            t0 = tcg_temp_new();
-            tcg_gen_add_i32(t0, REG(B7_4), REG(B11_8));
+            TCGv Rn = REG(B11_8);
+            TCGv Rm = REG(B7_4);
+            TCGv result, t1, t2;
+
+            result = tcg_temp_new();
             t1 = tcg_temp_new();
-            tcg_gen_xor_i32(t1, t0, REG(B11_8));
             t2 = tcg_temp_new();
-            tcg_gen_xor_i32(t2, REG(B7_4), REG(B11_8));
+            tcg_gen_add_i32(result, Rm, Rn);
+            /* T = ((Rn ^ Rm) & (Result ^ Rn)) >> 31 */
+            tcg_gen_xor_i32(t1, result, Rn);
+            tcg_gen_xor_i32(t2, Rm, Rn);
             tcg_gen_andc_i32(cpu_sr_t, t1, t2);
             tcg_gen_shri_i32(cpu_sr_t, cpu_sr_t, 31);
-            tcg_gen_mov_i32(REG(B11_8), t0);
+            tcg_gen_mov_i32(Rn, result);
         }
         return;
     case 0x2009: /* and Rm,Rn */
-- 
2.41.0


