Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7D8C67861
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2024 22:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtEaz-0003P1-Ea; Sat, 06 Apr 2024 18:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtEay-0003OV-2J
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 18:33:08 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtEaw-0006m8-Iw
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 18:33:07 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2a2f007a33dso2160606a91.0
 for <qemu-devel@nongnu.org>; Sat, 06 Apr 2024 15:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712442785; x=1713047585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NX9Ag++TnmEtIL49KdN8wfC5CW3UFh53IC9I9+TmU/s=;
 b=EofMBaj/Tqc1jReXhhRVJFkZz4yhAAEWlix6d8bhw86xTpA/o2NpXs4f2dBCR0fG7e
 vDTPHTVpyS6stFBtdnKBP/CzK9HfkRUaaS0qwScjUnGWevn0wqbeKf93eFhHEH/O+y8v
 jqInLSzKiL8tXWPKoerPb51Axr7B0QeeYMsr5PgXx1lmXYYWW0rmLMWoMhcO2UoIbVAp
 ih9TbxdW7ZGl6w9k35m7VUt/SYD2r6PmLGeY5uvzFm5izG+pXrRnedx7caGXUokK7RRe
 sFWXpUZ2bPkocLHucCZiYUiLeA+cLuoidOkz9V0CD35gVOlpMAn5uFgFK5O+ccIrfIog
 uUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712442785; x=1713047585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NX9Ag++TnmEtIL49KdN8wfC5CW3UFh53IC9I9+TmU/s=;
 b=XOyJWyJUd41QXYkLpFxbrXNSWup4bH7IcNxOmn0hxFrWMYQtIK1GXRuOmydw3GsjxN
 XrhRlziJ1P8lmG9nm6qlww5ui96k7Dp5PJ6ZhRpvQJpNXTCxK7a+SCPeUPwxiGqSgEcF
 yws8m8QcH7Tzx9uS3353cj5NbC5P1AJhbOIYFuPhuwvYymfLtUoktaRi/iEIUXrrzhPZ
 /5KIzYmK+EdkujSqgrMPpHQSbngNbjHhx6BWt/hRoBWhS64XOwEtyNiouppKCDjgrTZv
 0Rg4oyqvdO7fr+GudSTz3o8O2tgrBRcCYNJWgEHpOsBvrN1m7mVCNP2jKj78Rm5XgT9l
 4qpg==
X-Gm-Message-State: AOJu0YyJxide5R8g7xiVZgR0DFezjKovHUper7Qkla+BtJuOefRkePp1
 CwxDr4EoJSfHbiJ/Aug/VwmQxK2ZIfxiIRjEwcvT5mugUvuQ2rNyLaQXLfRVwlUq3CviuucUayo
 Y
X-Google-Smtp-Source: AGHT+IHYOBkC/tVr9XQnUsLDf4qmmqdSuaXzPwppauLJh3EXu8d8scHM2yoGpW1A1RnyYZeBvN7EqQ==
X-Received: by 2002:a17:90a:eb0f:b0:2a2:53a5:7559 with SMTP id
 j15-20020a17090aeb0f00b002a253a57559mr4607335pjz.38.1712442785243; 
 Sat, 06 Apr 2024 15:33:05 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a17090ace1700b002a20c0dcebbsm3643279pju.31.2024.04.06.15.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Apr 2024 15:33:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Subject: [PATCH 8/9] target/s390x: Use insn_start from DisasContextBase
Date: Sat,  6 Apr 2024 12:32:47 -1000
Message-Id: <20240406223248.502699-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240406223248.502699-1-richard.henderson@linaro.org>
References: <20240406223248.502699-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 57b7db1ee9..90a74ee795 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -141,7 +141,6 @@ struct DisasFields {
 struct DisasContext {
     DisasContextBase base;
     const DisasInsn *insn;
-    TCGOp *insn_start;
     DisasFields fields;
     uint64_t ex_value;
     /*
@@ -6314,7 +6313,7 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
     insn = extract_insn(env, s);
 
     /* Update insn_start now that we know the ILEN.  */
-    tcg_set_insn_start_param(s->insn_start, 2, s->ilen);
+    tcg_set_insn_start_param(s->base.insn_start, 2, s->ilen);
 
     /* Not found means unimplemented/illegal opcode.  */
     if (insn == NULL) {
@@ -6468,7 +6467,6 @@ static void s390x_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 
     /* Delay the set of ilen until we've read the insn. */
     tcg_gen_insn_start(dc->base.pc_next, dc->cc_op, 0);
-    dc->insn_start = tcg_last_op();
 }
 
 static target_ulong get_next_pc(CPUS390XState *env, DisasContext *s,
-- 
2.34.1


