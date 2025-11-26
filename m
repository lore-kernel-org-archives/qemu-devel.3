Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5427CD11198
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 20:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOM2j-0003TX-Go; Wed, 26 Nov 2025 15:23:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM2h-0003Ik-57
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:23:11 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM2e-0002Rf-Ms
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:23:10 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42b38de7940so94845f8f.3
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 12:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764188587; x=1764793387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pidw5T6Zpmn8AtM8Pz/FN7kD5XrD+2TAbGQhpUrAR/g=;
 b=veMmjgwIR1QuT+5YhFVPvvBuX08UJolMC2tjgZ3hXS/P4DP+fTOnmEkFb+FrbVTjAK
 M/iTF183Vtne8s8rbtdH27q2E9vWsEW6fFcHkxjWKh2t7jQhgjrTgOAIFhtTSSSMbhks
 qNSbGRe49gSkdqgqd7ilzq/xoiO3HtjBwFlzYvF4Ffj7HRPAMNyuwJO+kRZTwE9zcPh4
 dTS8RWU7TtNPk8tmXQDgtCfqLrym0iAxIi8mAwnJQzPlofLx1jFGraBJOwtk0sKCeaI4
 o3svQOGFBIHRIRGXSz3dcQJba0XmoEcXiYH8gVB/qLKEjQFSNyxJeELRBWyFgfyeIHnA
 Ieig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764188587; x=1764793387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pidw5T6Zpmn8AtM8Pz/FN7kD5XrD+2TAbGQhpUrAR/g=;
 b=oLCm6ZhMhpJyJfab1aidBS+kxnlnUOXojLVWRME6jIEWvcXtPpLHobvDYOSQS2Fu13
 rW+LnCAjO4yJop+H0Dx2nu3tzuHYKgzjRyokH9cm4+0jgtBkYy8XpxOda1mLaU83Q1//
 syTN2nogEAD5VPp6XWtu6sjwhb8XT7AtmBG78wcrQWaLQ+EukK9nJY8Y/SowBmlUy6bO
 mADGmEf+xjj3+uDK8aCj2UGyPTF83V9Bz72hwKuzgBUKIgUB+2KYdIrcyo+1av4SAFJu
 4EryTriASJZxedHgV46q2ubaYSgG+7lbhuRlY4GI0yuDhuMckNKsDDzPSEDVcI5bQU1b
 hNgw==
X-Gm-Message-State: AOJu0YxphaimiT+gBlFKUanjy4QAPqcWkaKw7e9GR/HBLKLyRwJo9QMZ
 5W40tDTSA6TdD8unJ4M2b3yrz4dyvpZjGy5lP2CnUJWOvCB5igAU66Yod1FBlGOr8CX9DPrD0+1
 w7Hm0yIBNjgD6
X-Gm-Gg: ASbGncugPkNuj2tMB8/G2VO/BqQqS4C/9SFFPsw8OYJfaj5lulCiBx6Vg+pmIVrkxgm
 jyUQ6PcQoCc5TVPlgnTHZ4cr+5/GyOXC0J3jPwZLr3nc4uvo+cNSQk8Ii6M3sl+z6+rNwihz6ZR
 SaxH6WOgMdUNfPsL0G2LlA87ClVyasovfbsgHvJA4C4QQnEY++BjEF7Z/6QUBIw83TnQrdKBGOi
 Jph/EFqLzUWG1A7HLebQT7TYdZgcyg0ZKH/5r0AbOlIKdX6vNWPbhOOlJ+vuWxN7QRGvb5lQDdL
 fGQmdlvjmF2DZRpF/RSgT9PMqBPn9Mj4eOaAavGyUM+C32DTbJjPvvLTLKuHnT5ImRPhldIwVxD
 0gGVhGhd4pntMCi3q/FCl/KbSV0fjuUO4r954+HwU6B8i5AW3CO4o1nMBb3n+RQWhesjCiVyXwm
 s52cEjrCvXEYhGODOgRo6vmrKcf7kBw5jfZdNeyc6xc8os44N0ZIx2At+FEUc7
X-Google-Smtp-Source: AGHT+IGvJuPSNVRj/S/F737sI/9otdZJ93L9g24a+RFEOkkbYzfNltaLmzyBztbVGoPsAMxLcjq0xA==
X-Received: by 2002:a05:6000:4310:b0:429:c54d:8bd3 with SMTP id
 ffacd0b85a97d-42cc1d192e7mr22800878f8f.53.1764188586920; 
 Wed, 26 Nov 2025 12:23:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa7affsm43170047f8f.23.2025.11.26.12.23.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 26 Nov 2025 12:23:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH-for-11.0 v3 09/22] target/sparc: Use big-endian variant of
 cpu_ld/st_data*()
Date: Wed, 26 Nov 2025 21:21:45 +0100
Message-ID: <20251126202200.23100-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126202200.23100-1-philmd@linaro.org>
References: <20251126202200.23100-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We only build the SPARC targets using big endianness order,
therefore the cpu_ld/st_data*() definitions expand to the big
endian declarations. Use the explicit big-endian variants.

Mechanical change running:

  $ tgt=sparc; \
    end=be; \
    for op in data mmuidx_ra; do \
      for ac in uw sw l q; do \
        sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
      for ac in w l q; do \
        sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/ldst_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 2c63eb9e036..bd0257d313a 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1228,13 +1228,13 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
             ret = cpu_ldub_data(env, addr);
             break;
         case 2:
-            ret = cpu_lduw_data(env, addr);
+            ret = cpu_lduw_be_data(env, addr);
             break;
         case 4:
-            ret = cpu_ldl_data(env, addr);
+            ret = cpu_ldl_be_data(env, addr);
             break;
         case 8:
-            ret = cpu_ldq_data(env, addr);
+            ret = cpu_ldq_be_data(env, addr);
             break;
         default:
             g_assert_not_reached();
-- 
2.51.0


