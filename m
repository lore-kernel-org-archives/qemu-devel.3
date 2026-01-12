Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8188ACF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQkc-0008AC-GK; Mon, 12 Jan 2026 17:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQkb-00084H-Eo
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:51:05 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQkZ-0002zu-QJ
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:51:05 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47d5e021a53so51053515e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258261; x=1768863061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KFn/MIL+bUlyBivtVdAugKseDoZ0UZFHpDrGBmS0DoA=;
 b=d2J1ezlhXBEG7ptSopKXzQxFCTYJLa8zFVm7fdg92KYYBQXP/4CYPgiuMkN8nQIloF
 aGKveDYwKfuv4uEyAxRlojIACYtE0bopENWN9RVb82UrvJtbgg1rLV2EvcYaxMTgKJQB
 frxsoGxaokT7rMGuWaKevOVl90oa6flFA9pDEyI/Z+Cq+8DB5NlNZ9eHBV3uAOV85/OP
 gcrsWrkmprkJcGdP5SibSjW4uKN8dHahijxwg6nQwrPL7jVXvixruI5WAMGtThXpTCul
 7tBhgGIksQYl66/B2SkIjvsPmAzkuoAYz7W7Xo7Qic/3wm31E7xXzYgMIhI4aelSelCs
 AKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258261; x=1768863061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KFn/MIL+bUlyBivtVdAugKseDoZ0UZFHpDrGBmS0DoA=;
 b=fiJRLOaiKYNLyJasR6QrxoJyt1/4Oe9ZhCTCaEEwdcu/PwJ6bZZXMOyIfDXA3oK3nH
 cFOHd3Jkh8w2QSNotpGNoiCorc+9jgPVLIDNaoOJOKOkIBEg6Gjqeksibdrkop4e9r3P
 oEDQEPvK3WhJ2FK9Z2Nw1GnOZq3dYD0JGSAWaItnalk6Z3ZmQ32ROepM+Sm6R5i58U6F
 clXVFohi4M694kxxDn+LhW6a6nwUoNFoyHL38yegX+Z+NojkR0gfGDzGaevYvjJKr568
 zAoKWrPPTPUKP1ghKE8hiH0cDlASP1Vjrqb6UvtODTWWYYoQST5Ca0Q+bmmkH6IsTZ5+
 0Tmw==
X-Gm-Message-State: AOJu0Yz/GQ1HWWk04p7GJ8vyfTFD7tun8RpBYpsjxjbRPJnFQ5FDBI+/
 kOPCH/85Lxtuog1ZhTP8udv6HIEyJg0G2QOrg1QxMe/lAzn1Bt33MwdvygjXMVF1dkrhA2f8eRB
 kI0cKA1E=
X-Gm-Gg: AY/fxX5KfBhumEjQ85j9zWrhclO1faln834LOT8TYMA85C9WbGz5bz0qtHq+s9EMQRF
 lbeoK6YufnbIjcYHszD8wXtP7oXg/9ELrw0FN+6fiPbSdr3SVqDK0YbpWj1lhUPCnGHIE8FRKCQ
 ohYspLPnyp5idSi/Y01iZ1MbWkQTMIaQO+VNv67NJQbXL9MXpRBK4Ets/yoxcHrs1pVF4oGTZNp
 hULGDSf95P/M8FRKjIKOcH5ZDF5PeBp/Gz4atzRpqM+g96051hyd3rg+tgQyX/DRcApPF9gWGJR
 K2lEsg+v/wnCIYgwUllmDUycjv4pXWbDAL4gKoycuIye2b80JNdzI/L4+cRIx/95kG9A5rZmXnc
 jmei2gvJHq6d5W9lKLvRW3/9y3Mqn2J8cC78toXyIyKSj9srZkjUZSVcZnQpkPDxVZMQrcx+PYu
 bO3owDBDO3z7Hf3fdKlA/uBKysKVxIoS+zT6p6jZLxGCA9dAj2pOLjig3413af
X-Google-Smtp-Source: AGHT+IH3Cki+8MIGLrZpOMxi3frvkY5r/OgExnnzDf/GEByPuEY+BWlbYt5aFAGDGSnJZJYFGfXrDA==
X-Received: by 2002:a05:600c:190e:b0:477:7c7d:d9b7 with SMTP id
 5b1f17b1804b1-47d84b4099amr222205275e9.33.1768258261508; 
 Mon, 12 Jan 2026 14:51:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e6784sm41588755f8f.19.2026.01.12.14.50.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:51:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/61] target/hexagon: Use little-endian variant of
 cpu_ld/st_data*()
Date: Mon, 12 Jan 2026 23:48:13 +0100
Message-ID: <20260112224857.42068-19-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
Message-ID: <20251219185025.97318-3-philmd@linaro.org>
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
index 554e7dd447d..bfeadd65fcb 100644
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


