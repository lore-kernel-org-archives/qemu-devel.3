Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF928D4A5F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgagL-00056z-7Z; Thu, 15 Jan 2026 22:39:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgafu-0004xU-8v
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:07 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgafs-0008HP-PB
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:02 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a09d981507so11113505ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534739; x=1769139539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=joRi6369pVbDsKfJdtidvp6zyQujsSJuuqqcthZ9YJA=;
 b=pPRfhSPBzBVJ9Va1y4uwHlamj59KAKd5VCp1R5JtT7SyVpjWMAR7I1quc4PeMJ1Ii2
 Blhdx1wy43rbQDNax4w+KPaFcSyLgU9KpRRkOndRLOQmtEkXWrxRTd1QNyKUra/hPzjB
 onWF+753Ue3jaZS4nRoKxYh2sljMqRi8D4A1sOaNrVc4ZUIyOhbfHAfzd+beIs7/ouRY
 12pmPOPYPlXckpJBEYzv4bNKvU3JCWH1c075CeOO3d5oTxK9x9KMn3z0tD5zcuD44cUt
 tf6Y0VzCnZVKqdvk+YuxbtoFzd3EDr6q2oQOA6mWsgjPN7mpeesQ9DZt89+WTwpEvH+B
 PXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534739; x=1769139539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=joRi6369pVbDsKfJdtidvp6zyQujsSJuuqqcthZ9YJA=;
 b=PUklkT/HNPcRJtBBBKmOZ5q9gFXbEKxOJf0JVR+DOIlcq4ndc+C4iF6hUnXUdw/yH+
 ZSD0k6ZhlgkfIrIwLN2qFj6Bra8e6wsxSIqbABJznOHPhzmcyO9FwnNAsxuEeX+IKe8c
 l+9NpHLGjsaQBdMJHW17zCiGKRv/IjU1AvPaGbTsgDtxrC99PYroSuXIH22aMDtCsgt4
 05rqeYb3i/U/JQe8zyQmwuvPRu08U29mBdDx+H8C677EWdufcJ4CO9UnkrA+2hifMiLw
 RmaqtyNbIYbsNLAZAg0sYPpsz8+Xn4D4t9hp0hUAmY17WJFS+7I92grmAFIu57+lidy+
 gEsQ==
X-Gm-Message-State: AOJu0Yxuhi9+XsAmAAxNF+EZkJwDeq8Fl10VWvPi9Vdm50CkKYBp8jTg
 MPLkU3Gj7/Y+Xxf2XBsRj7+wvws4EyW3CuvcAn+OZM5HmEYKBjLw/BIqkP8WAIqHJtq6I6OiItg
 RTpkCKUY+lA==
X-Gm-Gg: AY/fxX5g2sYyju3kSmpgbMo62pYG6fZpc4ByjjanfKMz7v4nVgsplMkBjh1XSsg197G
 K3YHPRVa7u/S6e/HTC+VaYtg09S+Ub8f5ZgswhpRneCeiouIOyoP/VmKlqo46tAqjBaeCTVf8DG
 veQPxco7mYahHRV4oyRkzzTRPbqd6plbIpZ6JG7oGAHSq60T79Q1DvchhaksFQSYDPqwcZt/Cia
 kONN7rtiwE83j3XuzPzyy9c/EtXJv4NlPVmccrytDKkZjyeHxdF8jTYJswBefA2QH2GvaqwdQr1
 SZam9SGabTIfEH7fz3S/i5NULpbEA3o0EfbUWWKtz5gesAJjW3+Vj4jnVmGs2CYkLXl4xOnOcA9
 pI4jLCVeWCZMmAfzutZLRRTZvvDcXUAgjrLFdnNlSxpuQ+fa9/i485R5dwcHu0zRqbQZta89RY/
 QecyjnREEGYToDU2tA+g==
X-Received: by 2002:a17:902:ea06:b0:295:28a4:f0c6 with SMTP id
 d9443c01a7336-2a71744bd09mr17126365ad.0.1768534739406; 
 Thu, 15 Jan 2026 19:38:59 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ca9d5sm6527975ad.25.2026.01.15.19.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:38:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 42/58] accel/tcg/runtime: Remove helper_nonatomic_cmpxchgo
Date: Fri, 16 Jan 2026 14:32:48 +1100
Message-ID: <20260116033305.51162-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

This were only required for some 32-bit hosts.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


