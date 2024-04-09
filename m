Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EB8C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 19:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruHGn-0000go-2Z; Tue, 09 Apr 2024 15:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGk-0000ev-T7
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:34 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGj-0004gA-Bl
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:34 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5d8ddbac4fbso4757312a12.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 12:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712691392; x=1713296192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pLzmDWgl8qUDWCq3D57/PwLyiFcPLxohH0NJBMBSEDg=;
 b=o9Qut07XbMczd7B1Kb2LlS8YoQ5gcYQgNZ6KeFSY37HTW7pCttILpTBtagi/Zoc/fC
 QrDn5cNqYEIfqzsGCzielU/H0Hbptj5eG5tqbpHrKaN1tASPtgsYI9IxOJveEEXx81f5
 lFJGS/56weGIqGM2HMghvp3JVp1O18ToS7O8X5zhCpERSlr8nRLnx/wqMRTSVu2capDt
 MwKdGwxG7DapfEIX/5gXDof6C12QvgQAYnOLt/o/n8Q9aNkuRT1u97abW9KoQ31oqpWh
 YUrzM63chS6iOT1+hs+2l5bkwwtpr1tut4P/90BxTYT0Z9czpr6AoscpiKaBYUROro/K
 u+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712691392; x=1713296192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pLzmDWgl8qUDWCq3D57/PwLyiFcPLxohH0NJBMBSEDg=;
 b=pjxqgHoJeUVM5vbFVsvx5teWyR5hzwjBFka//SdDc8MDMNyEbwS8+07KRc7Iw+gYWF
 pGxXBuNUxNJdw1PyxEZS4H7isgdcahFlQQM0ucpFrV4ejhAbCJ0YeuzS5pYphB+ttSu+
 npYcK3Whec0/1p+FRcSzmDcF5UdXh71Zd7Ha28FU1g/wMIKs8gwxpB0KHXsYnO+MOdxr
 Pq+SOLbv68zqoHyYa+qZTAPJxzpjTtGE/S8DQFVC2fL+tTBb/348m5/DmjWm6FZwtg9s
 htFwZ3sXsrqWXapNi0b3/UbkmlZ+Mv+a8Mi8xbevfXHbk1n/4W0DewSjIpCVdYVr/44G
 BYAg==
X-Gm-Message-State: AOJu0YxmDvgyZvjBQTROGIY0/jLT2mM05Y4Tm8mAd8iltd1V0M8I8VMa
 3E1LUjjKFK9lFrMTbX2CIXIoSP0jGQdnB8QSyxy0q7yQ4La2LaAQTLKhMuhamWeo51kVtYR8OO6
 u
X-Google-Smtp-Source: AGHT+IHrOnXBPSif+Mie6VCs4zbiBM+O9v4jnlIMYgWGbzPZXo2LpCRDsXcMu1LFk7XsnQenv7tcag==
X-Received: by 2002:a17:903:2302:b0:1e4:344b:734c with SMTP id
 d2-20020a170903230200b001e4344b734cmr1114683plh.19.1712691391996; 
 Tue, 09 Apr 2024 12:36:31 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001e1071cf0bbsm6065843plg.302.2024.04.09.12.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 12:36:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 18/20] target/s390x: Use insn_start from DisasContextBase
Date: Tue,  9 Apr 2024 09:36:01 -1000
Message-Id: <20240409193603.1703216-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409193603.1703216-1-richard.henderson@linaro.org>
References: <20240409193603.1703216-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


