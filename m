Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2DAC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmW9-0005OY-Mq; Fri, 02 Feb 2024 00:55:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmW8-0005KQ-4m
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:12 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmW6-0002uz-8r
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:11 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d7232dcb3eso13085405ad.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853308; x=1707458108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wMA0Lk36Fd1VwYxsHHHznBGVGpg1MsjG0n+eTevqqnA=;
 b=YTCcuM7X2MKgH3Ng0t1D5I9ijyRwlMKRbWljKgf0iXdqnVmb6TIBTH3ywx53JP88/3
 Rxb6Bj2vfqSsChuNoLpRlpAMNopcGkLazUT94Q79HycJZ15DAA9g0NZqDhp+as8rAO7G
 rcOPb9GjuD5/L2oD9ZihzQ7IBQ7xFeWOOtMJA0pw4C9ZJ6t/EpU3vX0SP4C9NUwGoEzs
 2TOjidnWt4AmjfixEF+rJCpaozJpDW3fuIdK7MeQV5kv/lqALQF57aP5BWm0vk6UfcC1
 a0LWXppJVGSoBLpGNRlhUYKhY/PUtsvB0LgGqKlP87KlVcek8kHLOB2E53npNk+xnILc
 f6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853308; x=1707458108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wMA0Lk36Fd1VwYxsHHHznBGVGpg1MsjG0n+eTevqqnA=;
 b=c4XuEim1URdCoig8xBoxBbD4lnBFuannKtZc/ty4ORHmuNW24YfAdZJXOV95nmoyq5
 ixMl/vfdGE3Otu+1meGBNZ64Yuipj2X4+80qmKqOP7YrCOCYA6VR7VWrN9ZjAouhDuZl
 ePzigWgi/gSQ8xR+V2rLjYXatFBUyDcVEEfW+iKqEcagK+QpBtArCzKTa7i2HpE3OW9Y
 wIT2dA82tpnVSX2ClV+EVG00GTiG3QXsm3Alcl+v9kwkRG5A2nxPjXg0DabHylCUp6Kw
 JGKJitZLTb/EhCDUilaAw5meCssnAxjiEZJNWkWwcA8TObdIJsEsIaO/j6EuuEHqwopq
 SGfQ==
X-Gm-Message-State: AOJu0YxM2+rIPlXPPBr+IEorasQ7vpbk+yTmZDjmZvqw800542cLlzFa
 vvJN+4+maTwpQkp3RFmWbd5422n8Q3oObVb2Z7aguW6byhzNzx9nLIZ8m9IEzE8Ra2FfHRJTfpd
 s5GY=
X-Google-Smtp-Source: AGHT+IHBuwnC+L6I4AjIhaK0dpXIlbk9usstKsQ90l8bk5cVVWZZ/giS5jkrehM29qNBpUcdHNRzwA==
X-Received: by 2002:a17:902:d2c4:b0:1d9:fbe:466e with SMTP id
 n4-20020a170902d2c400b001d90fbe466emr1714804plc.66.1706853308630; 
 Thu, 01 Feb 2024 21:55:08 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXOK9uOC5dZiAh9TM7kvnRV54p6rFR1Fei+yyOYAnItVwRsEH6f78SP4nS2lMez4/FSSkKBC2lFw+5Y71WbY26H/QCYz78q0mD/pTMb7Q==
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001d8a80cbb15sm752059plb.238.2024.02.01.21.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:55:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 39/57] target/sparc: Introduce gen_{load,store}_fpr_Q
Date: Fri,  2 Feb 2024 15:50:18 +1000
Message-Id: <20240202055036.684176-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Use them for trans_FMOVq.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20231103173841.33651-5-richard.henderson@linaro.org>
---
 target/sparc/translate.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 6824b5d835..c68f6ca94e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -264,6 +264,22 @@ static TCGv_i64 gen_dest_fpr_D(DisasContext *dc, unsigned int dst)
     return cpu_fpr[DFPREG(dst) / 2];
 }
 
+static TCGv_i128 gen_load_fpr_Q(DisasContext *dc, unsigned int src)
+{
+    TCGv_i128 ret = tcg_temp_new_i128();
+
+    src = QFPREG(src);
+    tcg_gen_concat_i64_i128(ret, cpu_fpr[src / 2 + 1], cpu_fpr[src / 2]);
+    return ret;
+}
+
+static void gen_store_fpr_Q(DisasContext *dc, unsigned int dst, TCGv_i128 v)
+{
+    dst = DFPREG(dst);
+    tcg_gen_extr_i128_i64(cpu_fpr[dst / 2 + 1], cpu_fpr[dst / 2], v);
+    gen_update_fprs_dirty(dc, dst);
+}
+
 static void gen_op_load_fpr_QT0(unsigned int src)
 {
     tcg_gen_st_i64(cpu_fpr[src / 2], tcg_env, offsetof(CPUSPARCState, qt0) +
@@ -4615,7 +4631,7 @@ TRANS(FsTOx, 64, do_env_df, a, gen_helper_fstox)
 
 static bool trans_FMOVq(DisasContext *dc, arg_FMOVq *a)
 {
-    int rd, rs;
+    TCGv_i128 t;
 
     if (!avail_64(dc)) {
         return false;
@@ -4628,11 +4644,8 @@ static bool trans_FMOVq(DisasContext *dc, arg_FMOVq *a)
     }
 
     gen_op_clear_ieee_excp_and_FTT();
-    rd = QFPREG(a->rd);
-    rs = QFPREG(a->rs);
-    tcg_gen_mov_i64(cpu_fpr[rd / 2], cpu_fpr[rs / 2]);
-    tcg_gen_mov_i64(cpu_fpr[rd / 2 + 1], cpu_fpr[rs / 2 + 1]);
-    gen_update_fprs_dirty(dc, rd);
+    t = gen_load_fpr_Q(dc, a->rs);
+    gen_store_fpr_Q(dc, a->rd, t);
     return advance_pc(dc);
 }
 
-- 
2.34.1


