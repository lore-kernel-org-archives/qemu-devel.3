Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB81C67861
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2024 22:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtEav-0003Ns-5M; Sat, 06 Apr 2024 18:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtEat-0003NQ-Cm
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 18:33:03 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtEar-0006hI-Qi
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 18:33:03 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5d3907ff128so2806936a12.3
 for <qemu-devel@nongnu.org>; Sat, 06 Apr 2024 15:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712442780; x=1713047580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=huPDBBhYc/g4B/wyxsCiRcrglSPPFxdW6/Rpm03HcSo=;
 b=kONFEQ4y5iwAb3rt2Q6Wlc18pqdSqTPWD/QcIz6ichYzohOijEdcwPfOoOWqSqSQMl
 RlsW6H5yST21p9U8/+6+JMqJEbQMx4ZLUXqGDNlElpqym1ic4OFGBn8tjPk7VVlPouL1
 AOdcT0yynzL2x3EKH8IfibXSPkeRKbhUuVneCkn+bOXro9zDHnDjq8SotaCgKIPjmCQH
 LDk/dBbl0HSqN1Zi86qRKXVptsRLRMLROenqrgdhrOH1+/Hca78nwIJfC4v5X8Xse2Wn
 GQpbYHHzYuWngzv1NaoyysbLHgl8UYPLJyRw2fqKZGKbi2gq276fo6SuOeRrD6YZTrOp
 9LrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712442780; x=1713047580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=huPDBBhYc/g4B/wyxsCiRcrglSPPFxdW6/Rpm03HcSo=;
 b=a0uP4XkJtG7kYbK9cutxDLtN9cl37FOqCb9lZAakZUH3ms2BpsnS4Jo87W2Svkud6M
 MDzqp8l9RjQ+BPzle4QlABGPxkYQdaN43rIIFmH81DDpInoFF+h8vvSSQHgfv5NmxDi+
 l2UdQjum6r/BcqQc+vNePI8g1twl7wiJfYQW+zHu/8076KIs0NTf18Iy5SfA22YGlRtD
 JQo8tA32FZ/hplsF0EvcmB+EJKQ6uNp60H5ZPQVnQ4MpL+YJHY3ttsYrNqgtlAd8rl+y
 mCknvlGD+jTom+nEScn+UN9UUFEhW7jMKeCPfCri4ww2Z6DX2tgCSso7WTerJQ2PQUEf
 FPHA==
X-Gm-Message-State: AOJu0YxQmlCDeY0BG0rVcCZ85OxFemj0y7Ns5XjhjP/zk3fAQyt3Yq0W
 z8OPLnr8KIkvqGECVL7+uWjCNJCp8OjEHZECqZjZjS63KtOWkwzgWpp+3+l09sqsbB8NMP+OGYa
 L
X-Google-Smtp-Source: AGHT+IGEa0Av52jCbBtMbWWy9iMQU8BOTXVPB447WkmKSEkAq9y1mG0gRgVU8ut5HYzGH/9FPhpsNw==
X-Received: by 2002:a05:6a20:5518:b0:1a7:5b43:326d with SMTP id
 ko24-20020a056a20551800b001a75b43326dmr426867pzb.22.1712442780564; 
 Sat, 06 Apr 2024 15:33:00 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a17090ace1700b002a20c0dcebbsm3643279pju.31.2024.04.06.15.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Apr 2024 15:33:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Subject: [PATCH 5/9] target/i386: Preserve DisasContextBase.insn_start across
 rewind
Date: Sat,  6 Apr 2024 12:32:44 -1000
Message-Id: <20240406223248.502699-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240406223248.502699-1-richard.henderson@linaro.org>
References: <20240406223248.502699-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

When aborting translation of the current insn, restore the
previous value of insn_start.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 07f642dc9e..76a42c679c 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -139,6 +139,7 @@ typedef struct DisasContext {
     TCGv_i64 tmp1_i64;
 
     sigjmp_buf jmpbuf;
+    TCGOp *prev_insn_start;
     TCGOp *prev_insn_end;
 } DisasContext;
 
@@ -3123,6 +3124,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         /* END TODO */
         s->base.num_insns--;
         tcg_remove_ops_after(s->prev_insn_end);
+        s->base.insn_start = s->prev_insn_start;
         s->base.is_jmp = DISAS_TOO_MANY;
         return false;
     default:
@@ -6995,6 +6997,7 @@ static void i386_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     target_ulong pc_arg = dc->base.pc_next;
 
+    dc->prev_insn_start = dc->base.insn_start;
     dc->prev_insn_end = tcg_last_op();
     if (tb_cflags(dcbase->tb) & CF_PCREL) {
         pc_arg &= ~TARGET_PAGE_MASK;
-- 
2.34.1


