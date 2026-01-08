Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55F6D148A0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdieR-00012Y-3A; Thu, 08 Jan 2026 00:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdicS-00084n-4J
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:39 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdicQ-0005bh-Ju
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:35 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c0ec27cad8cso1284374a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850292; x=1768455092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZjgbuWaanDrNExLqWK4KBit4/Io3yfr3ZpZa80ElVWM=;
 b=bRjKgrZdRHG2sNCFtyZVU2ZRM/4nJx7mFVQzdDGSOnX0d2h5gx8u1Yfsnw6H7qokTd
 kW+FrvvHBW7FmIqReXxQv2brG6VTQqfnzt8dlI+8xfjiQdXH72wmaRXU/ZtwOZVCp71B
 mH1xhlatNayvxFB2R0Sh2E7vlXbV7mEnX4MivdxE0jhUMQvDDmUKZgURX+O3vl1gDCMJ
 SzVzEQBv5NAvGNu4bwnf8g+CvIvfI2paVeyBU+47rQB3RJsCUqsIvLSkl82gZVMIjkgv
 e9BU/CVNNSZ7umKdCh2DQxDj4Ckj962msn0ojcCPYgggY31MvDHCrUXogzb+yV+u9CAd
 qltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850292; x=1768455092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZjgbuWaanDrNExLqWK4KBit4/Io3yfr3ZpZa80ElVWM=;
 b=V6vzgP148JzRAGNDtNzAihZO28ZwENs/IBxGu+lhajwDNT0FErovjviZzloG9NFBM9
 VUV2R6jNhg6MrTiVR3edsKx7v6k5YFXWBCw0u+9uMDzVTCmuUE7pD5p/CxjURKCuhYv3
 xfebYp7AZhNeSXIbyhVQTZ5CCn0e8qAHmQclrsuesYwYfE9I2BU8DdTDJgPD57SxVC5L
 OmHWLAKXej3jrp/rJP35tg/Lw2hEXfF/qdQb4Js9RUNNddVsCd0U0mBiDrVPgpzvxW2u
 6bCsnUS5pxiEFGQ4WZPurWoJ5yBlAGRUgxEnOMl0WdL7hvWP8NGvkMxptQ8bet45KjIi
 +Dxw==
X-Gm-Message-State: AOJu0YyFvCwBB29JZJxoJa5r5az29SjFUeRWTWdTVjDrKvRo9rkU7jG7
 Gh4w9FmoOg921ntqKCdPxsA+pgRT2MuojB5SUmN7JJzTGDO15Bn1H1HrfYkZ9LzqXqOyy4qDpaN
 mnLMyU7I=
X-Gm-Gg: AY/fxX42tKhEq9QhiyETTEIWTnMcqi8aZY7eA1QuttV8PU3fzUPM0BAv1tsQr7PyV5/
 UWPpzJ8htzLKpMx6hb/uMGVBRf2Czd3IFBB040nq64am7/LSFK4/M91k2U59MtGLhz3NPLO0wnG
 NIoc05sQuscTcLJhRwmFvgrnNH6Fs4ZZZ5ExtRecfu+cR6sXYrW2CD980S3KtB1faaPLeMf2qqP
 x42L3alV6rMqfmdte63GKXyx5MK/J7HNNB0rrPef6PBKnpOErc01f173BZNSIakv4nE+E139IYb
 02A4OPHVHqMOuvy98mqCjrimhAO44JHaRWEC0QGqhbrVC8czCtB8678XCon3zcYpx4SezLkD1G+
 Yhb/pwotCMWxm2JCuQ+P+UstEK/HL6gBx6OzTnMurRutkQtDkswdVKHYCreKzVOAgtnpy+WVuaN
 NCE5m6L860WZhWEqtfMw==
X-Google-Smtp-Source: AGHT+IERFBmVOCsOpzn1MP7JYHLhFvrzdV9ovhZFXQuDBll3kEW2kTewWp6Tju3V3wzOpiTg//ho1w==
X-Received: by 2002:a05:6a20:12d5:b0:35d:d477:a7e7 with SMTP id
 adf61e73a8af0-3898f906c7bmr4047572637.22.1767850292126; 
 Wed, 07 Jan 2026 21:31:32 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.31.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:31:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 35/50] accel/tcg/runtime: Remove helper_nonatomic_cmpxchgo
Date: Thu,  8 Jan 2026 16:30:03 +1100
Message-ID: <20260108053018.626690-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

This were only required for some 32-bit hosts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h       |  3 ---
 accel/tcg/atomic_common.c.inc | 20 --------------------
 2 files changed, 23 deletions(-)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 698e9baa29..dc89155c0f 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -73,9 +73,6 @@ DEF_HELPER_FLAGS_4(atomic_fetch_oro_le, TCG_CALL_NO_WG,
                    i128, env, i64, i128, i32)
 #endif
 
-DEF_HELPER_FLAGS_5(nonatomic_cmpxchgo, TCG_CALL_NO_WG,
-                   i128, env, i64, i128, i128, i32)
-
 #ifdef CONFIG_ATOMIC64
 #define GEN_ATOMIC_HELPERS(NAME)                                  \
     DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), b),              \
diff --git a/accel/tcg/atomic_common.c.inc b/accel/tcg/atomic_common.c.inc
index bca93a0ac4..1ff80d19fe 100644
--- a/accel/tcg/atomic_common.c.inc
+++ b/accel/tcg/atomic_common.c.inc
@@ -59,26 +59,6 @@ CMPXCHG_HELPER(cmpxchgo_le, Int128)
 
 #undef CMPXCHG_HELPER
 
-Int128 HELPER(nonatomic_cmpxchgo)(CPUArchState *env, uint64_t addr,
-                                  Int128 cmpv, Int128 newv, uint32_t oi)
-{
-#if TCG_TARGET_REG_BITS == 32
-    uintptr_t ra = GETPC();
-    Int128 oldv;
-
-    oldv = cpu_ld16_mmu(env, addr, oi, ra);
-    if (int128_eq(oldv, cmpv)) {
-        cpu_st16_mmu(env, addr, newv, oi, ra);
-    } else {
-        /* Even with comparison failure, still need a write cycle. */
-        probe_write(env, addr, 16, get_mmuidx(oi), ra);
-    }
-    return oldv;
-#else
-    g_assert_not_reached();
-#endif
-}
-
 #define ATOMIC_HELPER(OP, TYPE) \
     TYPE HELPER(glue(atomic_,OP))(CPUArchState *env, uint64_t addr,  \
                                   TYPE val, uint32_t oi)                 \
-- 
2.43.0


