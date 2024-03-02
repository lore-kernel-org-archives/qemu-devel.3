Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE339C54E55
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHkF-00035t-4l; Sat, 02 Mar 2024 00:17:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHkD-00035E-B0
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:17:09 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHkA-0007cn-Np
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:17:08 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3bbbc6b4ed1so2009427b6e.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356625; x=1709961425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+1osKk6aSpsOCl7jxzf2LpH2LtOYNkQ4L9oeYiweWNY=;
 b=yDQigkeIecb87j6j4OHeoVawN2WC3DNdBWAA175I0J9hCsHYUZZtUuBrhnwFXk4qYg
 VF4eX1WhVsWbMuM9xTvQzqrNVqUBS32xArMlQjObKwvDPFxaB/Gdrt6+X9KUdoZAIr18
 lNlElqh82mF7kceVrUO9Adcd6adPXP10nswZvDPRmiOHvuCO2JLDBGnN4n/6fSCYu5L4
 oIrgt98zxub8LbO8rF/Yhmg6Ls2zZc8V3yx8eiwC+6VSZWaoWI5Vlb+Kykjh/ib1LKmm
 I1Jwazalr9KP2AaCfxX+Ypw79Fg2H+CluC6z3yDtcWTb921zerwrJsZCEULtbYXfgMJ6
 uEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356625; x=1709961425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+1osKk6aSpsOCl7jxzf2LpH2LtOYNkQ4L9oeYiweWNY=;
 b=PYSvMnesRuM5VhpQssxEf8A/saffZtPdLAUrxhxczApO9fJCNDMkvL5di4Uhk7gHRC
 /utdc3BFc8yuSrhXpE+7RV4y7ozvMytIYjfK48qWXwuWQXo5b7WiNt00jlg1EmRg5Ujq
 ovtlK1W7w1xQM4ckH33+CRlGqk5SEvbBVk6WWM9Co/TCGj1xrdTm3vWhXL/4OND991fd
 NAJuaq1KeUKTEDeqV2SbaQwvaL3B5IMk3sfYIuavD4KJb4kUIWWU9gW5NUubM7exju4Q
 u8lUY7cWPvFX6OtuPoeALGgQqIXFc8pT7+mE8h2P0g5wobka8HfHJgrOVEPpTxYSyxdd
 7yfg==
X-Gm-Message-State: AOJu0YxFW9loiWMV3fOjD3Bu/MawImpuV3tW88qpbIwFsi2D4d1zERc5
 GQTjVlUsBozbY6y8IqvRpGZaqGzsfdJm4/pS2m3NIdZ7ixzjPh+Ou7X80JcaCegCtThJ9U7hL0o
 G
X-Google-Smtp-Source: AGHT+IGPX3i8YZXYPg6JuqhGnlMPTVFPgg54JH6L9NBVTWxtjOj3OHLvAx2R52uCdovAhGLN+0IF5w==
X-Received: by 2002:a05:6808:1983:b0:3c1:cd9d:7fb5 with SMTP id
 bj3-20020a056808198300b003c1cd9d7fb5mr4573340oib.4.1709356624789; 
 Fri, 01 Mar 2024 21:17:04 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:17:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 39/41] target/sparc: Implement MWAIT
Date: Fri,  1 Mar 2024 19:15:59 -1000
Message-Id: <20240302051601.53649-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c  | 11 +++++++++++
 target/sparc/insns.decode |  1 +
 2 files changed, 12 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 4775e39240..5694420a93 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3316,6 +3316,17 @@ static void do_wrpowerdown(DisasContext *dc, TCGv src)
 
 TRANS(WRPOWERDOWN, POWERDOWN, do_wr_special, a, supervisor(dc), do_wrpowerdown)
 
+static void do_wrmwait(DisasContext *dc, TCGv src)
+{
+    /*
+     * TODO: This is a stub version of mwait, which merely recognizes
+     * interrupts immediately and does not wait.
+     */
+    dc->base.is_jmp = DISAS_EXIT;
+}
+
+TRANS(WRMWAIT, VIS4, do_wr_special, a, true, do_wrmwait)
+
 static void do_wrpsr(DisasContext *dc, TCGv src)
 {
     gen_helper_wrpsr(tcg_env, src);
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 1f9e07e526..2927116031 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -124,6 +124,7 @@ CALL    01 i:s30
     WRTICK_CMPR     10 10111 110000 ..... . .............  @n_r_ri
     WRSTICK         10 11000 110000 ..... . .............  @n_r_ri
     WRSTICK_CMPR    10 11001 110000 ..... . .............  @n_r_ri
+    WRMWAIT         10 11100 110000 ..... . .............  @n_r_ri
   ]
   # Before v8, rs1==0 was WRY, and the rest executed as nop.
   [
-- 
2.34.1


