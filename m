Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF441D11197
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 20:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOM23-0002Jc-6W; Wed, 26 Nov 2025 15:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM1q-000286-NI
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:22:21 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM1j-00024U-Sp
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:22:14 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so531955e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 12:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764188530; x=1764793330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xZit3asfOgEOVwzxp+et8Gfv2AWjf+pVkM2qBGtjPUY=;
 b=uwNaIK2+PCXCvgFoiLPu7mTWIsiLfL/EqTYwvA1A5NdLzQfIDpVVkASvq7O8HA96ZD
 EOEU/wJq40BXNL4DPOqkGIamlMKgGOgUbGWb/Hg/k1aNEL3L5W1df7i2ZQ9N36z2fMW+
 uNTo1rS1mg7Wow7fWZAZNrLoK/e621PYvwddpeohgg3+42XAV3AFyZhbuGRRxGw+pqYG
 URwf93/Lp3pXlQ7cYQtqy3J7xkgi2fsGbcvddGsJMUCMroeev3fCdeDZOLTu/PqCEKXI
 02PivDwLOqj3DSX2O/zu7vfIilhGf4CAPdRLVlyCL5PSF8/zSTYdmeyp/AR+WiOq9rUT
 +YPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764188530; x=1764793330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xZit3asfOgEOVwzxp+et8Gfv2AWjf+pVkM2qBGtjPUY=;
 b=mfu1CwVNncD9D1p85MRoCeK8aKxPLqwm4wBKy/DAdURoeOfGSgeXVKAl5+7VTuKY+y
 KEMWq4AHXqeAZgZUL7utei6v/H6arKHBJ13ikv52tPDBFStqfYCGDsewtL+QMoaDLN9U
 g6hQcdZsD90+w1l14rv8sVG1JPqKVPhcfFfD7CZ+ckOjxbN+FXQ7NAnNCngA5iCHFkQ3
 20v2fzyeP8QGR0axzORd0JA32UUjpw+RjeTE3Vqo4A4cVXHpK7S7kYWIXF6IzEGaCC8w
 Izwc/oEi8EzWrPy4Pl/DMbd0NkRhvPxlfFsFp712Z9HAJFVIl3rymEKUKzYUxlDSpIyr
 /w8A==
X-Gm-Message-State: AOJu0YzUt9Q6qoGz5Nyi0vBswq7yMG2YHMp5yYvnVzV1d4kykmnUYr43
 gbdIgQftkCizlnYDFqyL1PDmNOkmKLqR390xIem9m3kPGtfNaLmnwzBdMTTjt2DlH5cR42NWwcR
 XeE51SSFAf2tc
X-Gm-Gg: ASbGncs3SErMQA2CBZpvvZs+ipI5BsM/Xk3jYETZK/2gygd3k4fJcEHU1CEKk+++Zoa
 AQO6ALRGkpxkcoYBprwjOW46Kzhr3MBzKUHjFJB4ip6g2TtI45i42Xj8r7s6WgcoKNUsJOsxZi7
 Ct49qpoyViaspG7/z1UMID0VoNvuzI0xUUCiABZOzT3Yd3cvKF/XKl9vNuDp2zrrRidNw2iskCk
 oRPDfnJZxsPXE3UN/iNXUepAvtAVuNIdHVEcfU1jTZx0wYJ/zlMYcky9BwUoeLTHAz0p6Pb5Yaz
 Z9KSOsNykqrqpSGZ50rGQgnrkJP6f2vZ0yAUUWdgFUzsioEsUfYA8GB1RrqOKVheBHqgDAZaEtX
 45R3720zYlv/6mpTYSp+ReOemSzOA2EEk6KBrGQ2IzfLGYP/1PkZjo2nIS4t+tnn0Lxuo1zWLUz
 zRMzNDQLlZf+yHxVKfSFKi87JghvHmuxGqi13kwLLxT/bp+37VOQj6rvko03sz
X-Google-Smtp-Source: AGHT+IG4dSZCvZgG3Tvo+D195zC/W9JpFSfCDJ2icMJnmkn52udzdUtFfmNtEE/FAYba1+LsC9avLA==
X-Received: by 2002:a05:600c:3541:b0:477:7f4a:44b4 with SMTP id
 5b1f17b1804b1-477c0162dfamr202858115e9.1.1764188529766; 
 Wed, 26 Nov 2025 12:22:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790b0cc186sm56851335e9.13.2025.11.26.12.22.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 26 Nov 2025 12:22:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH-for-11.0 v3 01/22] target/hexagon: Use little-endian variant
 of cpu_ld/st_data*()
Date: Wed, 26 Nov 2025 21:21:37 +0100
Message-ID: <20251126202200.23100-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126202200.23100-1-philmd@linaro.org>
References: <20251126202200.23100-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

We only build the Hexagon target using little endianness order,
therefore the cpu_ld/st_data*() definitions expand to the little
endian declarations. Use the explicit little-endian variants.

Mechanical change running:

  $ tgt=hexagon; \
    end=le; \
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
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/macros.h    | 6 +++---
 target/hexagon/op_helper.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index 088e5961ab7..6c2862a2320 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -519,9 +519,9 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
 #define fLOAD(NUM, SIZE, SIGN, EA, DST) MEM_LOAD##SIZE##SIGN(DST, EA)
 #else
 #define MEM_LOAD1 cpu_ldub_data_ra
-#define MEM_LOAD2 cpu_lduw_data_ra
-#define MEM_LOAD4 cpu_ldl_data_ra
-#define MEM_LOAD8 cpu_ldq_data_ra
+#define MEM_LOAD2 cpu_lduw_le_data_ra
+#define MEM_LOAD4 cpu_ldl_le_data_ra
+#define MEM_LOAD8 cpu_ldq_le_data_ra
 
 #define fLOAD(NUM, SIZE, SIGN, EA, DST) \
     do { \
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index e2e80ca7efa..08db1e9c56b 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -77,13 +77,13 @@ static void commit_store(CPUHexagonState *env, int slot_num, uintptr_t ra)
         cpu_stb_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
         break;
     case 2:
-        cpu_stw_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
+        cpu_stw_le_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
         break;
     case 4:
-        cpu_stl_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
+        cpu_stl_le_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
         break;
     case 8:
-        cpu_stq_data_ra(env, va, env->mem_log_stores[slot_num].data64, ra);
+        cpu_stq_le_data_ra(env, va, env->mem_log_stores[slot_num].data64, ra);
         break;
     default:
         g_assert_not_reached();
-- 
2.51.0


