Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCEFCD1296
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2024 22:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtEaw-0003O6-4D; Sat, 06 Apr 2024 18:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtEau-0003Ni-TA
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 18:33:04 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtEat-0006if-EA
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 18:33:04 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5aa27dba8a1so175023eaf.0
 for <qemu-devel@nongnu.org>; Sat, 06 Apr 2024 15:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712442782; x=1713047582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XUzNX9wVB6qbDLCwM/K8CjqXVmj1FUosoEHWX0Cy0rY=;
 b=NCF8Bx48+UG3ilgO8Mg6b7O/agyUyY+qQhQCL06Kay8OXyz4An29hzmk5ATbFgk0xp
 acO/um8hCDMJyvqWsX1ArTVHXqDC7gKOYD4Hj7m26+f4J1yGn+NaV4Gn8Dzq+4lXkhKo
 CFyQKaiPZnhAmZQOwbgyGkgpr9u6ZVmQF+DDtYL97Ectlbs6WQKDckICWIqseFauaMi5
 MzfDnGL0npXXyFJsk7kqDaXAGyARX/he2rH3/rnjD3FR+/7ktK442Yy5e5W/dsgPj5uK
 WxYU8UUPtVVm2ttcMZAGIPEWfHiE0hwQ0VfgWKA6Xm7D5Tkx7j9V2X75EHjnzO6FHc3u
 yJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712442782; x=1713047582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XUzNX9wVB6qbDLCwM/K8CjqXVmj1FUosoEHWX0Cy0rY=;
 b=EEnSNA5PKQqjc4WunT6zJqa5W/IhvaXkqZxvJ9E4bs2+JI8U/itsJ+srt49Amya/Yc
 1lRakESqSFWRowFuiOxlzyvfPjuyYFGpXopvh0+AR5BrxM0P8sFekN+tlhWBrAi7hqcb
 uW3OPLYfj1CUaiCgCs3BtF3OOh+GdpEimaSc8K3ctu74IPx3e1Z7EodwAl2yyJS2tsyK
 uo0j0ObRe07FUOYXTd5Sfk7b1ZrGYpmooj0vM3aO5hvojNfSMTFplen2nFPzz2KhdG8W
 Tu8EIL6TNr2Pv92JYxaGbshU5trz96LEEb5GVgc2zDbj4UCc6uObJCHo7xSOWtK6gVyU
 84MA==
X-Gm-Message-State: AOJu0YyQjbDkRiupwNDQt3WyEKe8yCJdhdYE+o4bqBfoaWeikLSsdrr9
 rDo/8+p0DxlqwVMEfPPgxfbhHGPzp5PlkiXWY7QKN0n1WB/033ABcVtJAOTlsLHyxnWCXmmdeCJ
 R
X-Google-Smtp-Source: AGHT+IHo2yLEETdAst9o5o1IGSNTCzGyLb/wyHFihxgL403DK8gVFtTMbMP8D6raA8o6AFRUJW/UPg==
X-Received: by 2002:a05:6358:7a8e:b0:17c:263a:5b8e with SMTP id
 f14-20020a0563587a8e00b0017c263a5b8emr6804018rwg.14.1712442782138; 
 Sat, 06 Apr 2024 15:33:02 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a17090ace1700b002a20c0dcebbsm3643279pju.31.2024.04.06.15.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Apr 2024 15:33:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Subject: [PATCH 6/9] target/microblaze: Use insn_start from DisasContextBase
Date: Sat,  6 Apr 2024 12:32:45 -1000
Message-Id: <20240406223248.502699-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240406223248.502699-1-richard.henderson@linaro.org>
References: <20240406223248.502699-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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
 target/microblaze/translate.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 4e52ef32db..fc451befae 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -62,9 +62,6 @@ typedef struct DisasContext {
     DisasContextBase base;
     const MicroBlazeCPUConfig *cfg;
 
-    /* TCG op of the current insn_start.  */
-    TCGOp *insn_start;
-
     TCGv_i32 r0;
     bool r0_set;
 
@@ -699,14 +696,14 @@ static TCGv compute_ldst_addr_ea(DisasContext *dc, int ra, int rb)
 static void record_unaligned_ess(DisasContext *dc, int rd,
                                  MemOp size, bool store)
 {
-    uint32_t iflags = tcg_get_insn_start_param(dc->insn_start, 1);
+    uint32_t iflags = tcg_get_insn_start_param(dc->base.insn_start, 1);
 
     iflags |= ESR_ESS_FLAG;
     iflags |= rd << 5;
     iflags |= store * ESR_S;
     iflags |= (size == MO_32) * ESR_W;
 
-    tcg_set_insn_start_param(dc->insn_start, 1, iflags);
+    tcg_set_insn_start_param(dc->base.insn_start, 1, iflags);
 }
 #endif
 
@@ -1624,7 +1621,6 @@ static void mb_tr_insn_start(DisasContextBase *dcb, CPUState *cs)
     DisasContext *dc = container_of(dcb, DisasContext, base);
 
     tcg_gen_insn_start(dc->base.pc_next, dc->tb_flags & ~MSR_TB_MASK);
-    dc->insn_start = tcg_last_op();
 }
 
 static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
-- 
2.34.1


