Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E7EC9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 19:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhYb1-0008QJ-KA; Sun, 18 Jan 2026 14:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYZp-000742-8a
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:36:46 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYZn-0006sG-JC
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:36:45 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa9so1952189f8f.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 11:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768765001; x=1769369801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m7nwKohwrUhcs5GBd6WgjNcDHff3KfVrztRvD4pmA+o=;
 b=IGfGRwVkEl0KprS1zKjsCfHkLqouJC8xKY2M2lcQofy4ajqkTRJ0HbJRWkc4rWREbJ
 1POUfUiRYbfEmRk4u1RSI+0qSmFI9DeBGXkLN/p9t7dzHMBd1Cz7hPyZuNl2j/S3c0dT
 su9RBCe1a86+cE+TxhESsfkgZnlIT84K7WfticbSUvex4WqOuHNYK5Kap/t+pSjx9Wuq
 IRu3FIdyLNXThFYCRx6S26eqH7TJWnC6ZVVf9F8Dhf4c3PRxW8/vKw72TUVHBStFb4EU
 aE4eOcyZZWYpKa4iNrHzzdb57q619sPNYOwD5AYe/GHHiZp2i02BxUsWgGy4e993RsjG
 iAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768765001; x=1769369801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m7nwKohwrUhcs5GBd6WgjNcDHff3KfVrztRvD4pmA+o=;
 b=sGBFkqJG4sZE01yEHel7wCC4DeMxEmGPKdHZyG4Ukk/eYpim3CQrtyba4ysDiuZmu0
 U28wd5a3SfdxALjBI+6YqdPy83RF2Gk55tAhmIkU30xHnG0yEDYzGyWKkyIVHjWyUbm9
 wWW9Ld3IDUoLRZFWVqrlHSKI+Dp3ye1OZatxpAUlEDjNH+E55i/KFGnjHOnSNzzAIpfb
 QFBi1dR5Mkb1d+/kMOFMh5KGRxnVwjBLo8GnKGiclU7nC18I+VCuliGtBJU5pT/Uo2Qe
 gT2qJxjAPgTzRmsLGUg5gUZ+aOigj7kv7yh278bbJIo/sSpwoDu2u3EYkYej0g7rpjZO
 RIQw==
X-Gm-Message-State: AOJu0YwPbyUO9rCoK4J+XJ433ctyxdYtpvRXfZ1spzMOCRXKWNSp2ZmD
 Xrv56RwS/rWeIYORpqQWDdLDwkORDJJ8N/qFeenyX8zCuFTzgJixnWu3nPFkfuhDCrSmhxUscYM
 JnTqheAw=
X-Gm-Gg: AY/fxX7cuCfd/PcHwL+MPpXDV8kvSlZiozXHY5I3Q+9LZ+rQrd64ZdmPSFzfD7r57ng
 qwe3fUfHIBgj85qRknXk1LQ68juBRjgB8ICkIg6/CaYg4W/N0L+sqqfvWgawXnzBjdXx4CewAkt
 XlJkXn97G5P/XhEkImCjkpR5WgY7ZAiRfjkEA7cOfJpHp3Wnk6Uk7oJ53gWHPV9F/Q2yZ2399gy
 Y+J39vuXf2HpVH4TxbNQAxq8LUSfZ6a/d/pM7k5K49/eYUTsGDoMATrk47BS2GIhzFVl2cnu+JZ
 XzMxC2bF0jnEOEkfqfsi+OvT0RiJ1+yJNWMYbRClHOrxXKtAum6v4YlAWBKcpo4Pe+yu7U5+cHi
 hPDyEznUAJhv70YiplR5Ap8ZXJ9dZj411l9oFa/+QoQLzJh79bCrCF6z5GO2ImoPXvMZayHKteC
 SfxaKdhqvkrcHt2StiyH1PvWy2xWUgKoP9EoNdOR5n3mSrTqJxCSc/pPPtIHhWwz7hv93J7/g=
X-Received: by 2002:a5d:5d83:0:b0:431:808:2d58 with SMTP id
 ffacd0b85a97d-4356a05d583mr11643440f8f.51.1768765001483; 
 Sun, 18 Jan 2026 11:36:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997ed8bsm18705692f8f.36.2026.01.18.11.36.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Jan 2026 11:36:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 13/18] system: Allow restricting legacy
 address_space_ldst() native-endian API
Date: Sun, 18 Jan 2026 20:35:03 +0100
Message-ID: <20260118193509.42923-14-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260118193509.42923-1-philmd@linaro.org>
References: <20260118193509.42923-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Guard the native endian APIs we want to remove by surrounding
them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll set the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/memory_cached.h   | 2 ++
 include/system/memory_ldst.h.inc | 2 ++
 system/memory_ldst.c.inc         | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/include/system/memory_cached.h b/include/system/memory_cached.h
index e0ed54bd1eb..6eb6179140b 100644
--- a/include/system/memory_cached.h
+++ b/include/system/memory_cached.h
@@ -80,8 +80,10 @@ void address_space_stb_cached(MemoryRegionCache *cache,
     }
 }
 
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 #define ENDIANNESS
 #include "system/memory_ldst_cached.h.inc"
+#endif
 
 #define ENDIANNESS   _le
 #include "system/memory_ldst_cached.h.inc"
diff --git a/include/system/memory_ldst.h.inc b/include/system/memory_ldst.h.inc
index dd1fb482eac..896550bdd65 100644
--- a/include/system/memory_ldst.h.inc
+++ b/include/system/memory_ldst.h.inc
@@ -25,8 +25,10 @@ uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
 void glue(address_space_stb, SUFFIX)(ARG1_DECL,
           hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result);
 
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 #define ENDIANNESS
 #include "system/memory_ldst_endian.h.inc"
+#endif /* TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API */
 
 #define ENDIANNESS              _le
 #include "system/memory_ldst_endian.h.inc"
diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index ebb441f1a66..a728b7737c2 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -105,9 +105,11 @@ void glue(address_space_stb, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val,
                                              attrs, result);
 }
 
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 #define ENDIANNESS
 #define MO_ENDIAN               (target_big_endian() ? MO_BE : MO_LE)
 #include "memory_ldst_endian.c.inc"
+#endif /* TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API */
 
 #define ENDIANNESS              _le
 #define MO_ENDIAN               MO_LE
-- 
2.52.0


