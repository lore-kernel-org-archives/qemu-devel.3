Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08ADC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 03:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXBmX-0006xS-4P; Mon, 05 Feb 2024 22:05:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXBmV-0006vh-BX
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:05:55 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXBmQ-0003G6-BE
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:05:55 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5d81b08d6f2so4802782a12.0
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 19:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707188741; x=1707793541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gHPXu0j0nAO0+SMsvMvHJ8lHzrBgl7Y3ITORBgFmLRk=;
 b=U8orwk48UD4w2FFG5jHnixYJ29TCV5RRo9Et6BUusFiBj6Y/amebwMS7gFzVsmJ+mN
 dGIFhp6w/KKanlFjBmiT1/lAX+6c10shyuyI+M/MZ1vNvLG2YfDQsCi3krS8nolQU16D
 ZvF73O59vKVPi6tMgxJTVI3lvqkJYYhxFjABUSQkySiFdPbz/muuiJkcgk8OcXe1tojz
 ugQAHZaNCM+Rd0ZbOkHB7s4lEINVmBZbRWVxjoNdz+XN9Rn+klKxeMtZeZLqmzbi9ySe
 YA4HIIt4009w3BHKzixvrItlR1wqx7rxZODAd8+ThzSOkXmKhfmZmf2IwcbFC1d2I80O
 3OZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707188741; x=1707793541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gHPXu0j0nAO0+SMsvMvHJ8lHzrBgl7Y3ITORBgFmLRk=;
 b=E8gOW3HY/hYrQvKFKRqL4ztSQ8bZDpQhjB15PmJ6HjetTKG8wF3izCXRPJba09/kUQ
 cvh+vO6YYHeQ1iYrjK1b+oMgevrV8L3lrneSnGlPi+gjLAc8JLOu53DghT6fqRJGEs6R
 QKVLUAC3jU3AJq72nkIJNS3FSL+jKJaAZR5sBTQ2FA7AcRWjRarnRwdFpDRMn7sEvVTg
 wsYv/D02GqfrISkgFkTgzvLXuUvryYe7VFwxSybevvZEx6BCmGT1pjH8RqS4ZMvP+rpZ
 XFsqLlD+v7Mit+s6OUtXMnBwLeE8WrpANyXZ+4unbVETwMY9j/Es07MNB++9NuXQHf3M
 cGGg==
X-Gm-Message-State: AOJu0YzEk7U/BEMVtFuRZMM+03CouTeSEJrTz1l1ID+Q27XDFYDKaqyg
 /jJr85gkXefs2WruX+/QxeLpcTXTwaYzRdSVaV8QNopdYuAab+bHuRN/LsBORgBSApxn79t/1K9
 vuhM=
X-Google-Smtp-Source: AGHT+IHnyMLOLRWF69i5ATV9MfZhiLxkek8dWHa7GhoE4ZCazEaAoml3iTNYvEFOb2iKISlsD8/L4w==
X-Received: by 2002:a05:6a20:7209:b0:19b:673d:824d with SMTP id
 y9-20020a056a20720900b0019b673d824dmr327389pzb.46.1707188741089; 
 Mon, 05 Feb 2024 19:05:41 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUQ7tQ5Cubv0pchS/7CGd8F0TqpmNW3ud5JUcjf4DnVWODKV1G1Y796ss0PZHp738doxMf7t8HzvdkpyDdz2koAurvdHqLyOiuW
Received: from stoup.. ([43.252.112.200]) by smtp.gmail.com with ESMTPSA id
 r14-20020a62e40e000000b006e025030700sm627478pfh.190.2024.02.05.19.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 19:05:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v2 3/6] target/arm: Adjust and validate mtedesc sizem1
Date: Tue,  6 Feb 2024 13:05:24 +1000
Message-Id: <20240206030527.169147-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206030527.169147-1-richard.henderson@linaro.org>
References: <20240206030527.169147-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

When we added SVE_MTEDESC_SHIFT, we effectively limited the
maximum size of MTEDESC.  Adjust SIZEM1 to consume the remaining
bits (32 - 10 - 5 - 12 == 5).  Assert that the data to be stored
fits within the field (expecting 8 * 4 - 1 == 31, exact fit).

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h         | 2 +-
 target/arm/tcg/translate-sve.c | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index fc337fe40e..50bff44549 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1278,7 +1278,7 @@ FIELD(MTEDESC, TBI,   4, 2)
 FIELD(MTEDESC, TCMA,  6, 2)
 FIELD(MTEDESC, WRITE, 8, 1)
 FIELD(MTEDESC, ALIGN, 9, 3)
-FIELD(MTEDESC, SIZEM1, 12, SIMD_DATA_BITS - 12)  /* size - 1 */
+FIELD(MTEDESC, SIZEM1, 12, SIMD_DATA_BITS - SVE_MTEDESC_SHIFT - 12)  /* size - 1 */
 
 bool mte_probe(CPUARMState *env, uint32_t desc, uint64_t ptr);
 uint64_t mte_check(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index f50a426c98..2628ac2840 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4443,17 +4443,18 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
 {
     unsigned vsz = vec_full_reg_size(s);
     TCGv_ptr t_pg;
+    uint32_t sizem1;
     int desc = 0;
 
     assert(mte_n >= 1 && mte_n <= 4);
+    sizem1 = (mte_n << dtype_msz(dtype)) - 1;
+    assert(sizem1 <= R_MTEDESC_SIZEM1_MASK >> R_MTEDESC_SIZEM1_SHIFT);
     if (s->mte_active[0]) {
-        int msz = dtype_msz(dtype);
-
         desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
         desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
         desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
         desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
-        desc = FIELD_DP32(desc, MTEDESC, SIZEM1, (mte_n << msz) - 1);
+        desc = FIELD_DP32(desc, MTEDESC, SIZEM1, sizem1);
         desc <<= SVE_MTEDESC_SHIFT;
     } else {
         addr = clean_data_tbi(s, addr);
-- 
2.34.1


