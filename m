Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16DBC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x052K-0002sc-5e; Fri, 28 Aug 2026 18:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x052I-0002pv-08
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:26:58 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x052F-0002K3-2g
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:26:57 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2d71e253c90so14395585ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787956008; x=1788560808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B4qeYxozmzv5nUB9BT/DGHD7IZGaEHc1xEeHPC5DMdU=;
 b=hKvt7We/GA0BKaZdtANUDE3Qi4AsesQDoz8LXX8EkbmuOWYar7A3RwnfINgxKzLjqh
 ihwfo4WDlb9x0TQ2BTvNUCOQijwKgfatKS519ixr4KsseGuVZ7v72E3kpHmIsWE1jCWN
 KPGVgNrbl0SEFhz2S67uNF51uOa4AK7cBGqgkzBrv5gVTedR/rY2e7aYO8rjho8eMLe0
 k/y+gtcH6NsXQC6HW5JBYGHW0QqhOu/DPGe8dc174A8vr5vbnxfUJHZB7sq317nd6Ixt
 rS8WZUy6KGiIafuom3hBl8ET4eNiZOrDmlCjaZcFoAcq220l9yD2twTMUPEvjLIYy9v/
 RgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787956008; x=1788560808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B4qeYxozmzv5nUB9BT/DGHD7IZGaEHc1xEeHPC5DMdU=;
 b=GRkQrQPhA4KM9B9js83B3pDr9pRo0361DpjqGN121o9hh3pvGUVf9eF4zhxJLI/vjA
 Fa2eUPuePKxHPlwQjXJqsA5LwjJrXqMSUa7g8RQxKOw+0DPyn4vGP58pNcP34bCl3VK3
 n3Fc6e6RjLuku5rIC15rLST1iyhV+IP0URQ1mlTYT1+4eA8NvqZGihzZZb8TnRr7PIeM
 SQ56D0DFtcFHDLbUAERS0Q9LZ2PaeFHWKiUUt2p/G9wOFXO+ABLmKQLYyyJvJsfND4qc
 renWuwjlNQRdZt8VX6k0lE0mdN2OqoS9z7Y9O6a7t2ZMSRO3iZrDFw8Tli6sTc83XrDR
 57dQ==
X-Gm-Message-State: AFuF++nbDcYKzEVMxIlJIm7KQKBTnBS/l31zP0yth1bTP3iGl8Fl6OPS
 NqcwdDljopU/RZbOwqaQQPO7OocD2+fDkYWZpIZgOkcMS3XLPBedYV+PjDRtagTHcsMnIMgkTd7
 gzWc75hI=
X-Gm-Gg: AYBFou2TJ15AplVI2Vi+axgL1RnbW9BcqJBUyq0SgtpIV2UGmBpNJEWIl73kEyOuYfe
 FiXVGYXBXmUgtWMpVmCGuQsGKsovyFj/KK50/0f6GN6T3Zhbg+236tfKVqfvhlfFoAeSl3aM8Yj
 powp2fRHmsT/v1T/higc53zXkC69EsmDATBTT+U6LoCXUnuUnd1qJRywxQENx4Pxo6FyZ5CQoya
 b8pRsogsadNT+fseJPhB8OGOjHBfbZ2C2zsdZ9QyZnmi5sg83mIce5SYcXvvLDNccwtwK+gAnDp
 r30DmPB7/4J0rBxkHU/CEZSwuW914BGVRuX4i36c15uOUWZzOCKvwT7E/vTlBvOUGl895NGwzB1
 +h0t4GfAghxxskHIt/o8cwvEbMKq7A/D4uJE+ERW9lXEq91UGPmLiQGHJqrqDInQvtngb8tx2PE
 wcrK61cwT3+m5FrBI5GykGiLFFXGiCTGjKctBSG/0IQ4De9BDVDjbxT+3UxY2TDL/6UpLzEoMrJ
 m3IGehQUsMxR53i03Yg
X-Received: by 2002:a17:902:ce88:b0:2c9:c952:6e9 with SMTP id
 d9443c01a7336-2d74dca2281mr180565415ad.2.1787956008060; 
 Fri, 28 Aug 2026 15:26:48 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d759640270sm9178355ad.34.2026.08.28.15.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:26:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 09/13] target/arm: Widen cpsr_{read,
 write}_for_spsr_elx to uint64_t
Date: Fri, 28 Aug 2026 15:26:35 -0700
Message-ID: <20260828222639.1432046-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828222639.1432046-1-richard.henderson@linaro.org>
References: <20260828222639.1432046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

We will shortly need to handle bit 36: PSTATE.UINJ.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 4 ++--
 target/arm/helper.c    | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index be32a8c531f..69c9256984a 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -2015,8 +2015,8 @@ void vfp_clear_float_status_exc_flags(CPUARMState *env);
  */
 void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask);
 bool arm_pan_enabled(CPUARMState *env);
-uint32_t cpsr_read_for_spsr_elx(CPUARMState *env);
-void cpsr_write_from_spsr_elx(CPUARMState *env, uint32_t val);
+uint64_t cpsr_read_for_spsr_elx(CPUARMState *env);
+void cpsr_write_from_spsr_elx(CPUARMState *env, uint64_t val);
 
 /* Compare uint64_t for qsort and bsearch. */
 int compare_u64(const void *a, const void *b);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index ed6b4d985e1..e6b16eade76 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9353,9 +9353,9 @@ static int aarch64_regnum(CPUARMState *env, int aarch32_reg)
     }
 }
 
-uint32_t cpsr_read_for_spsr_elx(CPUARMState *env)
+uint64_t cpsr_read_for_spsr_elx(CPUARMState *env)
 {
-    uint32_t ret = cpsr_read(env);
+    uint64_t ret = cpsr_read(env);
 
     /* Move DIT to the correct location for SPSR_ELx */
     if (ret & CPSR_DIT) {
@@ -9368,7 +9368,7 @@ uint32_t cpsr_read_for_spsr_elx(CPUARMState *env)
     return ret;
 }
 
-void cpsr_write_from_spsr_elx(CPUARMState *env, uint32_t val)
+void cpsr_write_from_spsr_elx(CPUARMState *env, uint64_t val)
 {
     uint32_t mask;
 
-- 
2.53.0


