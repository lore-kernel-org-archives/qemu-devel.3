Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5D7C4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkFD-0002IC-GV; Sun, 04 Feb 2024 16:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFB-0002Hf-N9
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:41 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFA-0003Y6-5F
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:41 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d9b2400910so1721095ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082898; x=1707687698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YlDly1L5SvwoPmODhXTBc/fHcqZbTHU7ULTRsNqIufw=;
 b=oyHlJTi3BZgPGqVS2kSg7pkwhnRS8ConAapw6sAUr2XyB+CEFLV5pUUiE9qO1nxlJ/
 ZFhsfrJxD5rLNK+o4NR+69zWY2gB5LLdlEjPlUj21U+/q7MPOUhauSezYhdrPXz1/1mI
 LKlnM4NtU08DaKLm3xKIWr0uQarjymFjr8whFijMaaDLfc42BhDKq9Z+loeEaULjAFKT
 wEXIG0xLS4bXpcTswuziX7D672c/xtzpMuMvruGEd+cLfbh6sIDKrjwEm5ty+G8TvANk
 3iBJOhHf+PIWuNoLoaKejfLMY6NLORDVlqSyGH8e3TwvjWgikyXi2pkcJ1JgcrTAxKR+
 SF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082898; x=1707687698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YlDly1L5SvwoPmODhXTBc/fHcqZbTHU7ULTRsNqIufw=;
 b=HomQDxO2Ie7zlCgEzYkf/zzD93ge8YVs8ZL0HX87MW/vBbjlLi30V1nLp2ncMbus5b
 FS4fz9K6d4DLy+fxg9mX8RbJSjsHmCzbD7ObMgq9/RGvazit5+Ynre95mD1rVLGqaQ87
 ldlz3P2s4tik3QaZ8jaoU0vjTx5BOG/F+PDcMqu9ifpWtFxXLjUqbFjEIUVtf/SxdCSM
 dcmXOBDjq5uCN2C6oo/tGBIWgKTUQ3EVU8qH5YeRTkY+NKimVOVRU6pj7aZ/dEhGBPHC
 v3yghIi+c6Fco5ovzJrp/zX5FAGivu5skjqZz/O7RoOvWUqxLl6KAGfy+o+z3Gh8cQM7
 hXHg==
X-Gm-Message-State: AOJu0Yy+qZNZr/bH7lm/CwdWp0lcwe9b3QOMwVZgMR2lDrHSpWx4NIC4
 p9fujBWr/I/rDuA01jS2u6vTE8nJpISo2yVCpaLdeXKI96ys7QXglHCLct0s0qHPZssj7qIN8LQ
 4ud4=
X-Google-Smtp-Source: AGHT+IGhWL7g5+/HguHbq8pZB/HtVOO8w7ZeYHvq1uPeATJEDFe1YNgSB+rpbhfRP2HhcKHUeZxluw==
X-Received: by 2002:a17:902:c952:b0:1d9:adc9:2962 with SMTP id
 i18-20020a170902c95200b001d9adc92962mr1644927pla.20.1707082898629; 
 Sun, 04 Feb 2024 13:41:38 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUMOjWLSGT8ox8/ySYP472LGlCuC10WJBFrh8hBA/drSBUjUWcE0B3aDYal0rrHxx/azxeeBsU3PTWbr8F9SpCz4Q==
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/39] tcg/aarch64: Generate CBNZ for TSTNE of UINT32_MAX
Date: Mon,  5 Feb 2024 07:40:33 +1000
Message-Id: <20240204214052.5639-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

... and the inverse, CBZ for TSTEQ.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 36fc46ae93..dec8ecc1b6 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1463,6 +1463,12 @@ static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
         break;
     case TCG_COND_TSTEQ:
     case TCG_COND_TSTNE:
+        /* tst xN,0xffffffff; b.ne L -> cbnz wN,L */
+        if (b_const && b == UINT32_MAX) {
+            ext = TCG_TYPE_I32;
+            need_cmp = false;
+            break;
+        }
         /* tst xN,1<<B; b.ne L -> tbnz xN,B,L */
         if (b_const && is_power_of_2(b)) {
             tbit = ctz64(b);
-- 
2.34.1


