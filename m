Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBACAC369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JRJ-0001gy-VM; Tue, 22 Apr 2025 15:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JPA-0005gO-1E
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:42 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP8-00077v-3p
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:39 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so85259735ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350537; x=1745955337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0pNZiYfei49mNgpV0jBnyPLCIko49eVtkxL+ip5wtaU=;
 b=Si3sFgLCwwZ/TT0eI7EgmGV1bYKHaUjEptL6bsQzTawg1LykusKkReIVxgcBBDReW8
 DyXdfwS7XkFgBp9Cw/5cUGjctEJvNGPfg7E4UW9yIF8h8DUuZsXnF3l7vIFE5K1IZjGZ
 ftkw4XCkDuPpWo2wPCfkEzsl3f7YlBmK4cLv0u2PtqBGDnQz42jtUDIulg+Hdqa3UEJG
 Kg6hOL+ePzAKJLF7IsccPQ6H8jRD8Wb2kk8VgG5EWIQOWzzLzauB50G++niTY9VFHtVM
 3YMEDgykOoGjAZe2nzzOZODkewPovVvqG3muR8Va/56g+xAmmEm46LWeIL2W/ZKadEP/
 l8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350537; x=1745955337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0pNZiYfei49mNgpV0jBnyPLCIko49eVtkxL+ip5wtaU=;
 b=sRbDMe+LdL4d8h4oP/kE2DLq+97J7n1xg7Ls2jbMdUisoIJ/7QY/eqZ7yrdXtR0O/F
 YXwGfqI7FDx6JTmKZU/SmRsyFqszedPL4Wlzqfm1skBiOiDPsyUE2hI06mty4DpbWh9N
 5S1Yei1TSX2RvpU7dECp8CtodgEPaX5HolxyHD3KH8tKn6UfQ6iV7kRrbqJNSZ/dVmqG
 l3ornJBhLl99lt2TJTbjngesJxw0RaaHYSuXK/TRkPdtxlH8RVxaykSDC05WR/ikJYPW
 Hv+LBJ7eGAbADDsEkpVBfWHDoT9H7LctO82FgCTYA6WddHOMnUBOUlCmuHi02ErRu8Ae
 M/LA==
X-Gm-Message-State: AOJu0YylzqK/n3x8Lx3eJxXG7OgsQ7wdo/IIP17Vx4UGAjGowZr9SEQ2
 lsTo3xlkCgdWx56aJ3xSbWBItgzDb8ItyuaLb1pijkfUgKvPBmgkFKvQ7KdxREbpSf7q8wofkJD
 S
X-Gm-Gg: ASbGnctg2vYa5TvUFvLrcLzspoA7PDyGR/RPJnKsGzy/Bnq81CCV7zpwSx2eycvYLRP
 K5M55DnDbUdhrHcKw/b/qOBDiQYeEhcA9aUyBVUnJxaI0dVMK3RScsNN2o130qhTlnFtDqQs0X7
 nobuO2mf+6oJDwqMzjJ1sIiCyBXIYlrs1fFFS2J4nA8wgsbsyUGBiAhDhoVL+1SZrzpZy4DA4uP
 RaCyaSX94/+R5j+3LCNWpJdMH6ZuEWgZdJiOWtaybyhzv7xb5gHYcWmfkkbbSCq6TIKZipKr9Xx
 OJgcHmdxTejw520LsnE/6Cj3OxE4IY8FpuZ+mM9Y9KzfxcbT7WhIQ9qeOQBRo0lQmh/WCU28b5U
 =
X-Google-Smtp-Source: AGHT+IGKO0lS6MmlVukS2kjxI+/y4wMCSvnucGmYgnjwyvOlTSFB/qDy91Kwyjneyu1HbTjNBxunqA==
X-Received: by 2002:a17:903:191:b0:21b:b3c9:38ff with SMTP id
 d9443c01a7336-22c53607e15mr229572985ad.37.1745350536661; 
 Tue, 22 Apr 2025 12:35:36 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 116/147] target/arm/cpu: flags2 is always uint64_t
Date: Tue, 22 Apr 2025 12:27:45 -0700
Message-ID: <20250422192819.302784-117-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Do not rely on target dependent type, but use a fixed type instead.
Since the original type is unsigned, it should be safe to extend its
size without any side effect.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-21-pierrick.bouvier@linaro.org>
---
 target/arm/cpu.h        | 10 ++++------
 target/arm/tcg/hflags.c |  4 ++--
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ab7412772b..cc975175c6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -194,7 +194,7 @@ typedef struct ARMPACKey {
 /* See the commentary above the TBFLAG field definitions.  */
 typedef struct CPUARMTBFlags {
     uint32_t flags;
-    target_ulong flags2;
+    uint64_t flags2;
 } CPUARMTBFlags;
 
 typedef struct ARMMMUFaultInfo ARMMMUFaultInfo;
@@ -2968,11 +2968,9 @@ uint64_t arm_sctlr(CPUARMState *env, int el);
  * We collect these two parts in CPUARMTBFlags where they are named
  * flags and flags2 respectively.
  *
- * The flags that are shared between all execution modes, TBFLAG_ANY,
- * are stored in flags.  The flags that are specific to a given mode
- * are stores in flags2.  Since cs_base is sized on the configured
- * address size, flags2 always has 64-bits for A64, and a minimum of
- * 32-bits for A32 and M32.
+ * The flags that are shared between all execution modes, TBFLAG_ANY, are stored
+ * in flags. The flags that are specific to a given mode are stored in flags2.
+ * flags2 always has 64-bits, even though only 32-bits are used for A32 and M32.
  *
  * The bits for 32-bit A-profile and M-profile partially overlap:
  *
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 8d79b8b7ae..e51d9f7b15 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -506,8 +506,8 @@ void assert_hflags_rebuild_correctly(CPUARMState *env)
 
     if (unlikely(c.flags != r.flags || c.flags2 != r.flags2)) {
         fprintf(stderr, "TCG hflags mismatch "
-                        "(current:(0x%08x,0x" TARGET_FMT_lx ")"
-                        " rebuilt:(0x%08x,0x" TARGET_FMT_lx ")\n",
+                        "(current:(0x%08x,0x%016" PRIx64 ")"
+                        " rebuilt:(0x%08x,0x%016" PRIx64 ")\n",
                 c.flags, c.flags2, r.flags, r.flags2);
         abort();
     }
-- 
2.43.0


