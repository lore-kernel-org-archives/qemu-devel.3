Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF7BC79FAF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 18:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcp7a-0001AY-FU; Mon, 05 Jan 2026 13:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vcp7U-00017S-24
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 13:15:57 -0500
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vcp7P-00036X-F9
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 13:15:55 -0500
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-88a35a00502so1459246d6.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 10:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767636937; x=1768241737; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/9Fx5rLfzSRK3bLfXlACPoaE0s79Ml+6B18vzxJguro=;
 b=RFFkaQwSYDSlkqo+gKhVj6PFok1mcNm9H00txbhy/W5K6Hw+l/EsgSc4FXiqF2kZps
 r2adOtMYG7qovn2RQMhmZDHc+qWQf1hyVgvFoGUZz+2+JzQKiE02UXjT3p6hHDut6tAo
 kWEffeej7sLByWs8DGUlZaBDD9NQWeFKI72+xwmES/pj3yiI15hwwhc8dQNOInmjn36y
 3nvraUANT8lIqEkCqF8zBfLtor2coB/I10g2brftwwRjqW04re5zLIqOnpXxZCJRXIb1
 llZuvee2QPl/muYBpRZVqyFQmPThXV6Isw8K/0+5KMANsOwpGHCy7vwRYbMm0+4gcAjq
 njrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767636937; x=1768241737;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/9Fx5rLfzSRK3bLfXlACPoaE0s79Ml+6B18vzxJguro=;
 b=M9s24XpwqTJSAvbs2g3AGeimsRcF70GzyU1se/0qK2ITzmZR3zseOKs2X0eX/S4Nwl
 /Mo7TNhE0ZR9ACzgpj7i+4qd34fGjXZF8XxKJEI9BD4zWxzzbxguQEtZSFJ65AU/W89h
 NTHlYf8ayaFHTgQj28p8FhNKVn597FvVKK3qjdRv7kg47bHtkSwpEZXkifdm2zaeTs5n
 dZZws3EH5dx0DrXXv/E6oqsSZfwViPzDO0kEZTxiJskxGMC7Ap38PgKZRv2V5qkF2bUJ
 B5bKDVa4rj7vJNs9cRyXjD2syU4svaEVhMz7iKICNE6igktKWuahFBDOA8pHN04LE1x7
 RvCA==
X-Gm-Message-State: AOJu0YxsVkKSHNCKgR32RLrb50I8BjZuNyvlGhURs1GOPzht1kGYuvXP
 lo4DmQAyulrn8bxr9icqAoy1m/0X5fSKBARcchraVfQNTdgq/A4sRKrK
X-Gm-Gg: AY/fxX7dhZyjZDHRE4w0pdjzRB+cYtdpXK5mnQCMrJf6iEV+m3HulBOcy6uPHSyU9PI
 2HagIVHQKQDFA5fzkhtql7Nnxq+No6sU33IxWksz5D7IYRBPphvzb3Q6omX4Zu9grpVBHT7QJxM
 3EiJojnFtCP68WN0elWVRZlDBSbpuqGQcOQOdf69DTufe0iZk4GHmw5UtWM+0qETFYlQWTpJstp
 nwfSdqArxLS+zZgCpvhisVFL8PwI1UNfhVWt4FN2IhSD6tnH7fjgELJ8hY2O0jXUBeI2esKjqJ7
 4BodH73htJUfdBLFlQTvVcQx6A/vWPW8i6PG6FXNzBWd+BEgUGiC2kG/+A1RtnOpCaivUCCLXCI
 SDUy9zN4gxFj004E2hIzpEZFmSih3Qb+5FBD9pmqZ9iPgS7993YXuMY4Yl1paUo3aTkLmAWl4i+
 tqbJZCiIXD7X/nUDShaMyIZKXn
X-Google-Smtp-Source: AGHT+IGH0yXr0l71SERYlH3uPyirXQAI7liNy2+TqYI4q0I2pPz76zhuNWbwN83FnL+DB/uz4WD+3A==
X-Received: by 2002:a05:6214:1306:b0:87d:cad9:ccba with SMTP id
 6a1803df08f44-89075ce86a4mr7720336d6.14.1767636936937; 
 Mon, 05 Jan 2026 10:15:36 -0800 (PST)
Received: from [192.168.1.204] ([185.213.193.254])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8907540e24csm3855706d6.25.2026.01.05.10.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 10:15:36 -0800 (PST)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 05 Jan 2026 11:14:57 -0700
Subject: [PATCH RFC v3 08/12] target/arm: storing to canonical tags faults
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-feat-mte4-v3-8-86a0d99ef2e4@gmail.com>
References: <20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com>
In-Reply-To: <20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767636923; l=3655;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=CcVL5fRovpSirzVToytYO4z5WjM+viKj7dzMRsgL4n8=;
 b=L3eBBGvMSl3dbAJ47+QpgN+q6PinoV2TJRj5h3VA4xv2vaoatW8f0+18BKcnj8F5mEJu+hoXv
 fam2POjTgaBArYmdd30LJxysWvUOoHws02jKLvNFwYN2bmQUqQDg/Rj
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qv1-xf35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

According to ARM ARM, section "Memory region tagging types", tag-store
instructions targeting canonically tagged regions cause a stage 1
permission fault.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
 target/arm/tcg/mte_helper.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 795a5ad20b..8f06ed3162 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -227,6 +227,20 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
 #endif
 }
 
+static void canonical_tag_write_fail(CPUARMState *env,
+                                uint64_t dirty_ptr, uintptr_t ra)
+{
+    uint64_t syn;
+
+    env->exception.vaddress = dirty_ptr;
+
+    syn = syn_data_abort_no_iss(arm_current_el(env) != 0, 0, 0, 0, 0, 1, 0);
+    syn |= BIT_ULL(42); /* TnD is bit 42 */
+
+    raise_exception_ra(env, EXCP_DATA_ABORT, syn, exception_target_el(env), ra);
+    g_assert_not_reached();
+}
+
 static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
                                    uint64_t ptr, MMUAccessType ptr_access,
                                    int ptr_size, MMUAccessType tag_access,
@@ -363,6 +377,11 @@ static inline void do_stg(CPUARMState *env, uint64_t ptr, uint64_t xt,
     int mmu_idx = arm_env_mmu_index(env);
     uint8_t *mem;
 
+    if (mtx_check(env, 1 & (ptr >> 55))) {
+        canonical_tag_write_fail(env, ptr, ra);
+        return;
+    }
+
     check_tag_aligned(env, ptr, ra);
 
     /* Trap if accessing an invalid page.  */
@@ -390,6 +409,11 @@ void HELPER(stg_stub)(CPUARMState *env, uint64_t ptr)
     int mmu_idx = arm_env_mmu_index(env);
     uintptr_t ra = GETPC();
 
+    if (mtx_check(env, 1 & (ptr >> 55))) {
+        canonical_tag_write_fail(env, ptr, ra);
+        return;
+    }
+
     check_tag_aligned(env, ptr, ra);
     probe_write(env, ptr, TAG_GRANULE, mmu_idx, ra);
 }
@@ -401,6 +425,11 @@ static inline void do_st2g(CPUARMState *env, uint64_t ptr, uint64_t xt,
     int tag = allocation_tag_from_addr(xt);
     uint8_t *mem1, *mem2;
 
+    if (mtx_check(env, 1 & (ptr >> 55))) {
+        canonical_tag_write_fail(env, ptr, ra);
+        return;
+    }
+
     check_tag_aligned(env, ptr, ra);
 
     /*
@@ -449,6 +478,11 @@ void HELPER(st2g_stub)(CPUARMState *env, uint64_t ptr)
     uintptr_t ra = GETPC();
     int in_page = -(ptr | TARGET_PAGE_MASK);
 
+    if (mtx_check(env, 1 & (ptr >> 55))) {
+        canonical_tag_write_fail(env, ptr, ra);
+        return;
+    }
+
     check_tag_aligned(env, ptr, ra);
 
     if (likely(in_page >= 2 * TAG_GRANULE)) {
@@ -548,6 +582,11 @@ void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
 
     ptr = QEMU_ALIGN_DOWN(ptr, gm_bs_bytes);
 
+    if (mtx_check(env, 1 & (ptr >> 55))) {
+        canonical_tag_write_fail(env, ptr, ra);
+        return;
+    }
+
     /* Trap if accessing an invalid page.  */
     tag_mem = allocation_tag_mem(env, mmu_idx, ptr, MMU_DATA_STORE,
                                  gm_bs_bytes, MMU_DATA_LOAD, ra);
@@ -594,6 +633,11 @@ void HELPER(stzgm_tags)(CPUARMState *env, uint64_t ptr, uint64_t val)
     intptr_t dcz_bytes, tag_bytes;
     uint8_t *mem;
 
+    if (mtx_check(env, 1 & (ptr >> 55))) {
+        canonical_tag_write_fail(env, ptr, ra);
+        return;
+    }
+
     /*
      * In arm_cpu_realizefn, we assert that dcz > LOG2_TAG_GRANULE+1,
      * i.e. 32 bytes, which is an unreasonably small dcz anyway,

-- 
2.52.0


