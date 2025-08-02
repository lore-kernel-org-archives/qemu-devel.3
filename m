Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E35C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLpu-0001Kp-JZ; Sat, 02 Aug 2025 19:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLnE-0004QJ-NY
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:37:38 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLnC-0005v6-86
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:37:35 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7419f3e5f9dso856193a34.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177850; x=1754782650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1dB1cHT1ha866F85MzBv2WZgn+PHcRylb/+Q2tL/eLA=;
 b=lbSK57HoubrZylrWfx+AX3sR6T2Gx7wfHzgbU8PodysBStd0OAUui8KBMMm7PuuBTm
 Pnhnuqd6c/ISSfhuZMakdbKe8+7vJlXhK0PruqBGR848r9s42NJu+QvZLsOVDfLyt+ly
 610b3jbOymw2OLBgNSaYGHBEgHgowURdD+gDbT0Rwr1G9e+Y9J7JyBQT6Whtr26tGsIk
 CF9JXmDFKhx63K0Odt89EhFMgM3/66klBwcK19VhsxaSXPgrYcDDO1fviFsHLOfMWc2f
 3UCVA1xsSgX8US9L3vWUm+tV9uMiEoWKzLxaOLH/FviUqiy9BN6qOq0wMqLQPBXrHr/8
 lEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177850; x=1754782650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1dB1cHT1ha866F85MzBv2WZgn+PHcRylb/+Q2tL/eLA=;
 b=EJAD8W+hs3dgJL+lL97qdKU1F9YMuJyCiPjVri3/b5+UPrN9k6i3XvruSTjl/nGa53
 CkLv7GXHsiS15/kimoQWWeGckYhKxXslTY61n1WmAz81z5M3ivcm9hczzY/Q6SAaOE6i
 PKlJjnIH3nv/F9tHSR0ysZqFJgIwf8GRbTizAXGf6mD/vkcctFfz6WTHh09sl+sC+bXY
 kKAHepnJnj5ei5Jbb5N9q5zaoXpURZbAafyd6dJ4B9CBZlnWHKddlCwMmRTtO846qHzV
 bibbgq7Exjd9CT1zw9GBXQD0SvriYWbrBZr9p1ogY7Elq2Sq0Ov9B5mXgqKWXWylcSJv
 PSzg==
X-Gm-Message-State: AOJu0YzT3eABVFcDGlMIrWiKOkwljHjUfGOhW5KC6pSz+FRA0ISLh1Ms
 95taOuR9mN1mxDrhrtIs0Anp2AvfX3ymdJxkI2znLoPlyUXc5O/7TxbG5gCEiOmsuK4BsYwUBsA
 l9ci5O9M=
X-Gm-Gg: ASbGncuoxidRY0m/wjOXxCCNj7hqZL3g/N1cRc5lBgChJ7Orlvi6ADrnIK5yPVfaf0B
 WJ73xX5XpVf3c0NcBtNDgoO4IJTWLlBbAW7G5OLY8KLB2xaqk8e7mjRUiw4kd2ST8/6Azzbezib
 YuLOnNMYGyVgoQXIOGBzAGql9c7Ia7GeGDw13Yvyh4vrzu6JSoi9kTzIeHlmiF1SuQQX07znhfU
 tcP+JITI5xVmmNKbfhvDtjGg9ChwRk3vWaAHhimuzWYsADwbOwRPYz+Jmr0BXp6ogLXLuY/4LJM
 sEs2Av6xcbPEK4WPlL0cq7e2lueG3pGygfN4+hzYoWfGdoVNDsIfy9RfdZwmkKrnSKeEr0FBO+7
 PljLEgkv0tisgbzb0uOCwMm6wUrwTVu5YpeebOs/O9ahg0nFxLrWw
X-Google-Smtp-Source: AGHT+IEXhEhNo7CnpN0vQxN9axj3V2wowQr9vlAAiYarC9ZntpXwBeY2DEyV21f8+JOEyCRz+DmlIQ==
X-Received: by 2002:a05:6830:3901:b0:741:213e:2212 with SMTP id
 46e09a7af769-7419d1d4362mr2703195a34.17.1754177849810; 
 Sat, 02 Aug 2025 16:37:29 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a71dc78asm380409a34.30.2025.08.02.16.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:37:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 56/85] target/arm: Emit v7m LTPSIZE exception out of line
Date: Sun,  3 Aug 2025 09:29:24 +1000
Message-ID: <20250802232953.413294-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index f6fdfaa551..e787acfc66 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6885,11 +6885,10 @@ static bool trans_LE(DisasContext *s, arg_LE *a)
 
     if (!a->tp && dc_isar_feature(aa32_mve, s) && fpu_active) {
         /* Need to do a runtime check for LTPSIZE != 4 */
-        DisasLabel skipexc = gen_disas_label(s);
+        TCGLabel *fail = delay_exception(s, EXCP_INVSTATE, syn_uncategorized());
+
         tmp = load_cpu_field(v7m.ltpsize);
-        tcg_gen_brcondi_i32(TCG_COND_EQ, tmp, 4, skipexc.label);
-        gen_exception_insn(s, 0, EXCP_INVSTATE, syn_uncategorized());
-        set_disas_label(s, skipexc);
+        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 4, fail);
     }
 
     if (a->f) {
-- 
2.43.0


