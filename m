Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35F4E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4YB-000299-J0; Tue, 07 Jan 2025 03:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4XD-0000NI-Dw
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:57 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4X8-0002zd-Tl
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:53 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-216426b0865so216731845ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236908; x=1736841708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o7SCT29N5BBhzi5MEE82XugxyYi9HADlW0L0D0UEGk4=;
 b=pcU6p0OmtO62ht4ywkmu8t5CYaOrYxw+yS35iSCz/WHkyl37Z7gOfHq/4hJxmab8TK
 0npofPBptq8ah/NK5HsiRg5XCv+n/uXyX9VkNnfeN+VSj+NXB6EyMQ6k7KFcHvbFSwBY
 6S/Y4vwWEBBc9NEo0tnzNVSNVSdJRAjXQsGVURUCsvQWgn3W+hBHuxluLoGld4T7pnvV
 vL5lJolxWwScYzBABXQb+XG6DlFB6V++XI5u/EhQAONfaSHGdtnqHZRraNWPnPuptxdd
 oL8Qlxaj7BScKhwOD9dnzMA/RgMYmJuTxnyJTSJX4U7wDETpLz2DdXCy8jzM8h3EpPh9
 ANHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236908; x=1736841708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o7SCT29N5BBhzi5MEE82XugxyYi9HADlW0L0D0UEGk4=;
 b=KE83W6bG5jEDYd5VfMQSUp429kleX17X2dbblLfFZCgL7hxpAQMfx16MJkEa10G7hl
 /SBhJk6u7PZTENORyEDfy29ChRpU6SNqux9OedZPCRtjy8dgRIoqhzcfzBau5+1pesik
 mg1phEK0M+r5yMnSBYs98944KgFbs5b0e/SvQXSMjTxZpvEQd3V20nArcXsguOb2nTGw
 nMNxFIX1u92aE0mne2Sei5vtZ6cMcrAR+3paP+AQPuRDGiHzS6g9k3XryK+uIUBrDkNf
 Zbwe6KnjNL5svNfdQR1dRYNVRfyhBq/SDdYCU6JAXdco77QyPFX8AyAYp67U8/2GtV/0
 gaXQ==
X-Gm-Message-State: AOJu0Yy8Gf064RbUupQfnAggn8YVghjpsbqmc4bUAwXb3pE9tCtAmgLY
 UTDZ5bLMVXdvhTekq3YZq6fKbNe/BPQK2HImQpkd/b90tmSgIJBhhcHd2CzoFQbU0z7ghwpkDom
 S
X-Gm-Gg: ASbGnctt7jSrN0MSm7GVvkRCiromh6n4k/b2yiFG6xXbhggaTIyO5Z16ZWcdO9Gyc3z
 td6aj3NoBV1i/GWDhI1BNeMeXO6+UN+EBx5fYmSqdE+hBwD+oofzvuRjlMQUCgCeKc/87r3Osgg
 BcLGPDaecU6mYi7A4evzQ957fN/wINj19KYnyhYf24QSFXexpbSwmN8MuqdbQBJbu/pWcRDLzN0
 moYtFcEjv+z1kh2PeHk0uhzBoBpXk4px88n6Tx1rD1HkyILMBTx86zLdWDWCDPSIzY3wswSrrh1
 6TuyonIlk9hMobMEGw==
X-Google-Smtp-Source: AGHT+IFVY5p9VCey7PDEUk5TDtWKBUSjU3qVeRgqmsbYyCSTZyFHPyW40h2BnYckctM9P51dBRPkXA==
X-Received: by 2002:a17:903:11c5:b0:216:30f9:93d4 with SMTP id
 d9443c01a7336-219e6e894demr850053245ad.8.1736236908008; 
 Tue, 07 Jan 2025 00:01:48 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 33/81] tcg/i386: Handle all 8-bit extensions for i686
Date: Tue,  7 Jan 2025 00:00:24 -0800
Message-ID: <20250107080112.1175095-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

When we generalize {s}extract_i32, we'll lose the
specific register constraints on ext8u and ext8s.
It's just as easy to emit a couple of insns instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index e51269f81d..047c5da81c 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1329,16 +1329,31 @@ static inline void tcg_out_rolw_8(TCGContext *s, int reg)
 
 static void tcg_out_ext8u(TCGContext *s, TCGReg dest, TCGReg src)
 {
-    /* movzbl */
-    tcg_debug_assert(src < 4 || TCG_TARGET_REG_BITS == 64);
+    if (TCG_TARGET_REG_BITS == 32 && src >= 4) {
+        tcg_out_mov(s, TCG_TYPE_I32, dest, src);
+        if (dest >= 4) {
+            tcg_out_modrm(s, OPC_ARITH_EvIz, ARITH_AND, dest);
+            tcg_out32(s, 0xff);
+            return;
+        }
+        src = dest;
+    }
     tcg_out_modrm(s, OPC_MOVZBL + P_REXB_RM, dest, src);
 }
 
 static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg dest, TCGReg src)
 {
     int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
-    /* movsbl */
-    tcg_debug_assert(src < 4 || TCG_TARGET_REG_BITS == 64);
+
+    if (TCG_TARGET_REG_BITS == 32 && src >= 4) {
+        tcg_out_mov(s, TCG_TYPE_I32, dest, src);
+        if (dest >= 4) {
+            tcg_out_shifti(s, SHIFT_SHL, dest, 24);
+            tcg_out_shifti(s, SHIFT_SAR, dest, 24);
+            return;
+        }
+        src = dest;
+    }
     tcg_out_modrm(s, OPC_MOVSBL + P_REXB_RM + rexw, dest, src);
 }
 
-- 
2.43.0


