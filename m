Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C823C54E4A
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 17:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj0ql-0005e3-Tf; Sat, 09 Mar 2024 12:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rj0qk-0005dZ-9T
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 12:51:10 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rj0qi-0004tK-R7
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 12:51:10 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5dcc4076c13so2086329a12.0
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 09:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710006666; x=1710611466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pxxy6rYsXE+YgbqfLQwa9qOUOHg4ePBRyOPqmtL2n8Q=;
 b=DAEoAIuTkSeNkp6FY4+Ik2YIG6lZOc/bwHop7S8ZMywcd+AE31J+coKADvHDkAwF6L
 Z65oHEnJu0htjzqU1o3s7nop7QBD6FX8RgoLnc2vr8Jt7DTwzgIxBbxQfxcUujDhgwXp
 S96o86C4aQgPkG3lWEENE87h28A3+5yH3OPAuvzsZuW+0AZutV0WYqUr4jzo9y5UZcIA
 vOEE1MyTmitgVkjQ2aYogZWOTpQXZZEeU5uXz4ZLDfb8jcJM5dbFyrTC02qN4lUHmWav
 McHgB4xw8qeHbc98D2vkuF0WS5lJsPjD80hoghBJ+n4Qo+/TlzVWmlg0bkn1ZbMqdwTg
 fhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710006666; x=1710611466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pxxy6rYsXE+YgbqfLQwa9qOUOHg4ePBRyOPqmtL2n8Q=;
 b=GXOXK60Q9GtUQZEpuEIDoNcyDK7MaG2g611X0tqP8IFr4vGdunq/8qxf8xTe+SEdIZ
 HcdPnm2csjbdFcpKsm6SwG8ytVKqzcaM/W3qB30ilKTuFOAl/l59xLN2/oDDBMVyM1fH
 COPKp77SChnXL6cjC6q2jspTjEtRA7W81zYdo+F91WF9myzqlIe80MZUfj7V3tqiPiIM
 AFr7ilSWKoXJwj/3GToSuk4Kdh3siqIo1YvRDu6eVmuWc2WZM4P5RfYLBIpqXFqoEOmW
 6/K/sSy6k3EYa5EA35K1wLE8uusq+NTWhj5bzkyxty2S43eN78kPYDpjOFvfI8jS2e4Y
 QKEw==
X-Gm-Message-State: AOJu0Yx5kvJtH5ax4SVorDFh/znGwmnkymwAHbAtAxjFXvKqNLRWpjxU
 Cv34B4gyhy/aFAG8RCsoo8DILpkm6ureSaSmRhSyBhUkPpVgjhuOV2BJB7YlyYK2+RzcF9wip60
 E
X-Google-Smtp-Source: AGHT+IEx+bOvSOwMHksIVFxcsgcSP4rxnsTSVAF28Zp9s46pJ2NEMUab5ccR70BSrvz4juisze4qNw==
X-Received: by 2002:a17:902:da8e:b0:1dc:6b26:d1cd with SMTP id
 j14-20020a170902da8e00b001dc6b26d1cdmr2951651plx.2.1710006666317; 
 Sat, 09 Mar 2024 09:51:06 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a170902d4cc00b001dcfbbb1ddesm1578556plg.7.2024.03.09.09.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 09:51:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	peter.maydell@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH 1/2] tcg/aarch64: Fix tcg_out_cmp for test comparisons
Date: Sat,  9 Mar 2024 07:51:01 -1000
Message-Id: <20240309175102.726332-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240309175102.726332-1-richard.henderson@linaro.org>
References: <20240309175102.726332-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Pass the type to tcg_out_logicali; remove the assert, duplicated
at the start of tcg_out_logicali.

Cc: qemu-stable@nongnu.org
Fixes: 339adf2f38e ("tcg/aarch64: Support TCG_COND_TST{EQ,NE}")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index dec8ecc1b6..38446c167e 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1388,8 +1388,7 @@ static void tcg_out_cmp(TCGContext *s, TCGType ext, TCGCond cond, TCGReg a,
         if (!const_b) {
             tcg_out_insn(s, 3510, ANDS, ext, TCG_REG_XZR, a, b);
         } else {
-            tcg_debug_assert(is_limm(b));
-            tcg_out_logicali(s, I3404_ANDSI, 0, TCG_REG_XZR, a, b);
+            tcg_out_logicali(s, I3404_ANDSI, ext, TCG_REG_XZR, a, b);
         }
     } else {
         if (!const_b) {
-- 
2.34.1


