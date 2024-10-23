Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95602D2E010
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 03:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3S9M-0007BR-Rg; Tue, 22 Oct 2024 23:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S96-00070R-Ld
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:54 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S92-0008Kq-KO
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:52 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-71806621d42so3106082a34.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729654475; x=1730259275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hj9WfdZOd9QxUtgBpaqB5NEBeOIleiheJZ+XpZVq7nw=;
 b=gO7h/VdBku3xj9jj+SIQ1UX8S+ZLV8fj3rGMCSzm48xd6R5aFKYas6N09JDzcWjO10
 Cw1sZacdREkvtzoLQR3E5zC6dzwgD9zEMwwl6NLHZe/lPCCe9YMoMlpawtIX6oVSTxCl
 xifND6ILVK0IZwUvb6GCtLvjovCYEQ+GpITXQ9f2KfFXVQHHQluHnhYw/nzMaPnJ85Js
 NAoPQf3RWTOKXszbVIrbAPzjNKDyA6HefZ7Opep/ZmNdK3svJ/UHDilDq/zEtDP63MVw
 dOdM1g0pFWqsuw7jH5ZTDUnfSU9ae4q93tQey+Remw0XC/u7n9ERb29K85Ofiv6xGnAR
 s7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729654475; x=1730259275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hj9WfdZOd9QxUtgBpaqB5NEBeOIleiheJZ+XpZVq7nw=;
 b=pTcxrxv2GSB6RXRMCJ1WbtClYP+bSGKOgNM8sxIliOGX38YbnF5OkskfOnbsMRxWdw
 3kT1x0B5XmiUhh8bRJXAukKWvvmKEeo7U5ubZHvMcaRIGbYLZqXy8QlMEa2Ep8XZgfVd
 ozUQ1/xXj691yLDg11nEGB1k2q+lAo/QyFfhxTA4SHFYFJP036lHWH1If1YOdEHJKTdo
 berx19RpkLAWUhadvr9v0wiJ+Pk89xDh9IWd6q/bfkLLqMOM/jTUzwsuvYELggvzyew2
 pRmNtyHCzT2I3LNPer7i22vF32NQTXa6mHl1DiN559Q5Nfqs3Oe3UxfgaEp5yktF3pI0
 KzZg==
X-Gm-Message-State: AOJu0Yyi2+77mHqg3Q4go6h8mgAbaEdClhzsr1x4vuL1dQIn6bmoHJoo
 o184rRJo6cbQQiE6ZmLqj8PL6fvGPYDUR+ADy4fdfRF+we8zH8BphZ3V2Njrxg2306u0L3OEBME
 w
X-Google-Smtp-Source: AGHT+IGjk3hrgpSp9JkbYAkwb7eiAFwpvO2ozNRjEYLsFAZtsJcECkUSbE4O0an+N30v44qWeLM0TA==
X-Received: by 2002:a05:6830:270a:b0:717:fe7d:a19e with SMTP id
 46e09a7af769-7184b2bfdadmr1235867a34.11.1729654475388; 
 Tue, 22 Oct 2024 20:34:35 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d73b1sm5438338b3a.105.2024.10.22.20.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 20:34:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 02/24] disas/riscv: Fix vsetivli disassembly
Date: Tue, 22 Oct 2024 20:34:10 -0700
Message-ID: <20241023033432.1353830-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023033432.1353830-1-richard.henderson@linaro.org>
References: <20241023033432.1353830-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

The first immediate field is unsigned, whereas operand_vimm
extracts a signed value.  There is no need to mask the result
with 'u'; just print the immediate with 'i'.

Fixes: 07f4964d178 ("disas/riscv.c: rvv: Add disas support for vector instructions")
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.h | 2 +-
 disas/riscv.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index 16a08e4895..0d1f89ce8a 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -290,7 +290,7 @@ enum {
 #define rv_fmt_fd_vs2                 "O\t3,F"
 #define rv_fmt_vd_vm                  "O\tDm"
 #define rv_fmt_vsetvli                "O\t0,1,v"
-#define rv_fmt_vsetivli               "O\t0,u,v"
+#define rv_fmt_vsetivli               "O\t0,i,v"
 #define rv_fmt_rs1_rs2_zce_ldst       "O\t2,i(1)"
 #define rv_fmt_push_rlist             "O\tx,-i"
 #define rv_fmt_pop_rlist              "O\tx,i"
diff --git a/disas/riscv.c b/disas/riscv.c
index 5965574d87..fc0331b90b 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -4808,7 +4808,7 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa)
         break;
     case rv_codec_vsetivli:
         dec->rd = operand_rd(inst);
-        dec->imm = operand_vimm(inst);
+        dec->imm = extract32(inst, 15, 5);
         dec->vzimm = operand_vzimm10(inst);
         break;
     case rv_codec_zcb_lb:
-- 
2.43.0


