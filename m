Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BD0E7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYROo-0004th-VF; Wed, 24 Dec 2025 11:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYROd-0004ro-QV
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:07:33 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYROb-0007uT-Ph
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:07:31 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42e2ba54a6fso2656098f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592448; x=1767197248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gBtqVF9aU011XQ+13ZQmCZYCeHcb9NebZ4I9xBYMCpE=;
 b=KsnI7JRetYmKosWCNoCOGWgoI1rppdET0UUN9jRiujDM9NmE3/kGr2cvRjXCDYy6JE
 GHmYvlktBYQAAgvzBwMLOUaYA9hY8wQSyLN5AgoznQhQmb/sLkE9j/5YWgO8rzgnPlXc
 uZZSV9jM4/iNVgtQai+s/t5drVJrig+pQ//JZiHT+whkSwZlCSd3I+TsiEOfUH6YtZ8J
 hwECt9sUN6rxP63e1YahXKoMHGQzTM7+tvH4v/q6EHCYS65eJZniGN7zw8PeuqgSQ3ag
 OIBz9Gz9fHDa28Em7Gi5itO6dVmBIabf8AgjlNKE1ouW4HFwTZMBKE5Mf5cN4xHIHsFg
 KUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592448; x=1767197248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gBtqVF9aU011XQ+13ZQmCZYCeHcb9NebZ4I9xBYMCpE=;
 b=jzDrGnYRtIKBYfnX4/03NLnOvSeDomG7b4CLXm45wJQ3Jzfgi3xQPFLje8rwQLv1Mw
 uqT/geN8PBdmLhAAwNYo2Uh12OeiOAXbzxtAnZbukjOq9uw69RxTi/l/8deNjIS/FiXx
 dmM7ZForzjpeZihxXntE8DUiGmDwf+g1X4JkjK8U2avx5b6D8BzP5Jtf6dzqww7MWBhs
 ccpgmK01U3cwVIeoYDMyPpHO9o8fXl6RwmWv1ICXDE52pDa5jzNc5TLfcz9cjt/0GOpB
 IXYT90zxR5rLUi5bjO83M2qxNThDrJXRdo2ePJaq/79sfYmzLNteu62En8jrBkeZnwS/
 7DfA==
X-Gm-Message-State: AOJu0YwPMYb3r7cn06E3nmjnMkputn/PBiPzKH+Bhs7PTrNUAthZ+zeD
 0uxQSW8ogOfDMDm0lBW7pb6sPZRHefeHiqtyByEAvni6qIAmfskCyqq0KnldwGlDFfgpIB7Bsha
 DPoKt17k=
X-Gm-Gg: AY/fxX4a66EysE2u5Cmmiy0Qfi228X4Uy0thXEmO7nVjhBwrmmz5xk0x1M8E07WfEgn
 3FT0rsOS76zFcwcm5K4n5TwiqJtbtg8xO1GVSpFhWOHNX6DhfhfFEIiIPyFlJwJUl2po94z9xzn
 1+Nlce9JyOkdDGlz9jgVlFrqg7NLop5CNoLW6zKaEYlu6zHaTUijZ1i2X2KHXWMMsSyns1wYjnp
 ik3tUaso+Jrar8RVPiZiwu0OF9SL2zWqth9CUJe5XyAjZQ2BeJKuKNlJCQuTj3X2XU6lJO7Pz19
 8mbbrifJ/DIeQEUogHqPqIEiRLrQQ63Cn7ViN2Ud++SuHSvX09g5YJ3wE6hflVI5LzIvhkjzwe6
 Yg67I+/nfbFz2KT8pMCVHEY5TcAv6ORFye93LAmb7xc4TvW1LT0ANYoG5uX9MwmjZK36xx+J09E
 LjYcFl/i6F5sveLqPEqTChM8t6obS53ZRzLBG+euI/9euqm2DnB0Jj3De3c2qyQ/bhAQ==
X-Google-Smtp-Source: AGHT+IG8Dezet4T6sN5vB51hGAqoCeOAnFGSLBTzVUo7I54cqNqeDqNnkxwznKhySCC/iL0OILS8nA==
X-Received: by 2002:a05:6000:26c3:b0:430:ff41:5c87 with SMTP id
 ffacd0b85a97d-4324e701157mr19535999f8f.60.1766592447930; 
 Wed, 24 Dec 2025 08:07:27 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2ebfsm34569577f8f.40.2025.12.24.08.07.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:07:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 2/3] target/hexagon: Use little-endian variant of
 cpu_ld/st_data*()
Date: Wed, 24 Dec 2025 17:07:07 +0100
Message-ID: <20251224160708.89085-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224160708.89085-1-philmd@linaro.org>
References: <20251224160708.89085-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
2.52.0


