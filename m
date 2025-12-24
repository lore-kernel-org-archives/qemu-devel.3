Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07105E77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRWr-0002WN-Cy; Wed, 24 Dec 2025 11:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRWp-0002Tt-P4
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:15:59 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRWn-0001a3-U2
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:15:59 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-432777da980so142470f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592956; x=1767197756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X01UnrH3Aih6NqHoG8ayl9U/ueGy+rbJG6GIlGONLcQ=;
 b=rnIuwTAr/E24+ooYuE4L9tAInFT/AVLc3PcD/zLzpJEQYv8DwriQIGMJN0WU9VTZYs
 SjpAGOlyIdL/fmgo2avY7Oo6FOu1UGo3xtT3td8qd9r8iU+vH7ttnKUM1IOxyEuJBt0h
 gij4SJILHtad+JuqdmPj4hd2RK3Ne9U4+kMRus+xWvJEelgP5PnpkCr1AwrtjPHN090y
 eR3hgwstC0U58CRaugq8/rFQScyze3lvbpkQZFphseLWLV87V+qSxz2AxjZote0h+17O
 Ajo7Y/LlvjCauULWbtXgC2xhD9y4HJDk5g5Cu+42lmpjgQ/Kv7LNn+oO6NZoSLTBRhH5
 dHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592956; x=1767197756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X01UnrH3Aih6NqHoG8ayl9U/ueGy+rbJG6GIlGONLcQ=;
 b=waj9i63ibRwKlEGiyWVqaam6L9k+mpjY0AJKtIN104U67Vnb99FyUFOQ/27Nypsvn8
 mCqLcTTbaf2I/FwYgSUeFoHCYOzHee0Z+ahM9/0SI3IbpiEQVSZPzkWNlUyl6Zg/Fwws
 K75w5WeY7zuWUof2DgraTtt3TV3Jt4abJI6eUp6riE+rRvYJSR+fRa+7SUd0ZtgTbLYh
 IDe/zdJ5rutmL7wTto6E/daF+T+4kHVdjWex4eyj14Q7WQYoUtHtRWCVADFzvgy7y7cO
 g0RJjRP9HRX/f38eTw8CvAErIMNz747TvX9qPxr5IvwK0VXd72Os2t0sNfqJjn5B2ssB
 vVkg==
X-Gm-Message-State: AOJu0YyfoYBBeALcdkw9wDGGUIUpqkSB4NnsTSJscgV8XIQLFXaR85v0
 yMtFcM5DgLruQEjlAiJfrZxpP/CRS3wSrMghgXKvWKLtKjAcyMqdlsSOLfvIygc3HjaMrguDYG/
 kjx+d55Y=
X-Gm-Gg: AY/fxX4Iw+BCx2kMsme7S0wdVDDHc4DMF46S7pt93ZRgNlvxLhOVpk/XWtPViUCcfQj
 /yxGzyBELFTeX7spGJL/xuc+cxK+LeFUISidRfN2X5tHRgdtpzupLpsW+8tENDrDxXWBq+F1Nbc
 K+a0eShoPoY4ixH5BsNvhSPmmOPauP/wJfz6X6z4CsKM3hUQmBf4X4EzJNFanaDhg3DnSj06bh6
 eZvX7R+tyl5dcDItvX/dOo1vQ2GdQj5fSderZbeqWWFxYG2ADI4gCEknRDpF2NANh8JBDczM3iG
 r9VRiKJTMlMV97b9QroiEP8pDza+1poPdd0uxNp2wz18LYHY9UxL3R5qO+aEwvl1cns8DU5403n
 5uDO5eq7WqVFxft+XD5R+ucna53ykvZiGHBGPUAmoQQqbuajpOAy71Wo3RSnbClOaRlNQIRRqz7
 nSYD68PExXg2EH54XUfU+9hHyHS1iHLuOZUNfFj6ePRprQP0qs6S1ydxk=
X-Google-Smtp-Source: AGHT+IEdfNrV0LP0D4IXN8ZKoTkcsXt59PAZTf57ve/yduL8aA/K4oO+crbWj2o/v13x4FFIWeMpDQ==
X-Received: by 2002:a05:6000:1970:b0:432:5b81:48b with SMTP id
 ffacd0b85a97d-4325b8109e2mr11483183f8f.61.1766592956106; 
 Wed, 24 Dec 2025 08:15:56 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa64cesm35203828f8f.35.2025.12.24.08.15.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:15:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Anton Johansson <anjo@rev.ng>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/8] target/loongarch: Use explicit little-endian LD/ST API
Date: Wed, 24 Dec 2025 17:14:54 +0100
Message-ID: <20251224161456.89707-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224161456.89707-1-philmd@linaro.org>
References: <20251224161456.89707-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

The LoongArch architecture uses little endianness. Directly
use the little-endian LD/ST API.

Mechanical change using:

  $ end=le; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/loongarch/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/cpu_helper.c       |  8 ++++----
 target/loongarch/tcg/iocsr_helper.c | 24 ++++++++++++------------
 target/loongarch/tcg/tlb_helper.c   |  4 ++--
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 2b27274f64e..51ad9ff2b46 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -172,7 +172,7 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
         /* get next level page directory */
         index = (address >> dir_base) & ((1 << dir_width) - 1);
         phys = base | index << 3;
-        base = ldq_phys(cs->as, phys);
+        base = ldq_le_phys(cs->as, phys);
         if (level) {
             if (FIELD_EX64(base, TLBENTRY, HUGE)) {
                 /* base is a huge pte */
@@ -204,8 +204,8 @@ restart:
     } else if (cpu_has_ptw(env)) {
         index &= 1;
         context->pte_buddy[index] = base;
-        context->pte_buddy[1 - index] = ldq_phys(cs->as,
-                                            phys + 8 * (1 - 2 * index));
+        context->pte_buddy[1 - index] = ldq_le_phys(cs->as,
+                                                    phys + 8 * (1 - 2 * index));
     }
 
     context->ps = dir_base;
@@ -237,7 +237,7 @@ restart:
         ret1 = loongarch_cmpxchg_phys(cs, phys, pte, base);
         /* PTE updated by other CPU, reload PTE entry */
         if (ret1 == MEMTX_DECODE_ERROR) {
-            base = ldq_phys(cs->as, phys);
+            base = ldq_le_phys(cs->as, phys);
             goto restart;
         }
 
diff --git a/target/loongarch/tcg/iocsr_helper.c b/target/loongarch/tcg/iocsr_helper.c
index c155f48564d..b0f171608bc 100644
--- a/target/loongarch/tcg/iocsr_helper.c
+++ b/target/loongarch/tcg/iocsr_helper.c
@@ -22,20 +22,20 @@ uint64_t helper_iocsrrd_b(CPULoongArchState *env, target_ulong r_addr)
 
 uint64_t helper_iocsrrd_h(CPULoongArchState *env, target_ulong r_addr)
 {
-    return address_space_lduw(env->address_space_iocsr, r_addr,
-                              GET_MEMTXATTRS(env), NULL);
+    return address_space_lduw_le(env->address_space_iocsr, r_addr,
+                                 GET_MEMTXATTRS(env), NULL);
 }
 
 uint64_t helper_iocsrrd_w(CPULoongArchState *env, target_ulong r_addr)
 {
-    return address_space_ldl(env->address_space_iocsr, r_addr,
-                             GET_MEMTXATTRS(env), NULL);
+    return address_space_ldl_le(env->address_space_iocsr, r_addr,
+                                GET_MEMTXATTRS(env), NULL);
 }
 
 uint64_t helper_iocsrrd_d(CPULoongArchState *env, target_ulong r_addr)
 {
-    return address_space_ldq(env->address_space_iocsr, r_addr,
-                             GET_MEMTXATTRS(env), NULL);
+    return address_space_ldq_le(env->address_space_iocsr, r_addr,
+                                GET_MEMTXATTRS(env), NULL);
 }
 
 void helper_iocsrwr_b(CPULoongArchState *env, target_ulong w_addr,
@@ -48,20 +48,20 @@ void helper_iocsrwr_b(CPULoongArchState *env, target_ulong w_addr,
 void helper_iocsrwr_h(CPULoongArchState *env, target_ulong w_addr,
                       target_ulong val)
 {
-    address_space_stw(env->address_space_iocsr, w_addr,
-                      val, GET_MEMTXATTRS(env), NULL);
+    address_space_stw_le(env->address_space_iocsr, w_addr,
+                         val, GET_MEMTXATTRS(env), NULL);
 }
 
 void helper_iocsrwr_w(CPULoongArchState *env, target_ulong w_addr,
                       target_ulong val)
 {
-    address_space_stl(env->address_space_iocsr, w_addr,
-                      val, GET_MEMTXATTRS(env), NULL);
+    address_space_stl_le(env->address_space_iocsr, w_addr,
+                         val, GET_MEMTXATTRS(env), NULL);
 }
 
 void helper_iocsrwr_d(CPULoongArchState *env, target_ulong w_addr,
                       target_ulong val)
 {
-    address_space_stq(env->address_space_iocsr, w_addr,
-                      val, GET_MEMTXATTRS(env), NULL);
+    address_space_stq_le(env->address_space_iocsr, w_addr,
+                         val, GET_MEMTXATTRS(env), NULL);
 }
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index aab89b9be19..b6e9a3a3c7f 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -719,7 +719,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
     get_dir_base_width(env, &dir_base, &dir_width, level);
     index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
     phys = base | index << 3;
-    return ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
+    return ldq_le_phys(cs->as, phys) & TARGET_PHYS_MASK;
 }
 
 void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
@@ -781,7 +781,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
         ptoffset0 = ptindex << 3;
         ptoffset1 = (ptindex + 1) << 3;
         phys = base | (odd ? ptoffset1 : ptoffset0);
-        tmp0 = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
+        tmp0 = ldq_le_phys(cs->as, phys) & TARGET_PHYS_MASK;
         ps = ptbase;
     }
 
-- 
2.52.0


