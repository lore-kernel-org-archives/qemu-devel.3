Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390CDCF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQkk-0000CJ-Ai; Mon, 12 Jan 2026 17:51:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQki-00005y-HW
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:51:12 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQkg-00031b-Ne
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:51:12 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42fb03c3cf2so3688471f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258269; x=1768863069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l42FEzNcWfMTrvcSRpe+FZu2BodQsa7pUwm+Smus8I0=;
 b=E5a6MDig5xNfxHlxGguA7coquZTWVOUvAcV3WzjB5j6Uin957taE90tXAnRYO6Gd05
 L7WQTkTrrrNM7fhgZSfYGxiNcUHbgX6bG8kWppiI7t+Q0AjxvVLXSUGvhQ7Ntz4iUvoX
 uGRjk764aIBEfNpFJP+qrTTeOLXTZYygf3PrMD6PBjavYS1f7sEA1GNCw9AIQC2b5ui1
 t+DwgEcyWq466ywCxb4ryTF2K7J4WXHElz9xhACjL1SP+gQ5C0XiKIioJfX0wMO9uma0
 P9L6rrv9JYrhFmuVtlnrGpt3NSOs403sOh4RYRnoFB7yO9WIbkRzGh64+DxPdDoeunat
 AITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258269; x=1768863069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=l42FEzNcWfMTrvcSRpe+FZu2BodQsa7pUwm+Smus8I0=;
 b=T/KwKWGTsA1FkSO4+iEDur+IsyYe8zrBf79A6aeeneTpfDii5CyggTAGaVw7gDoRhR
 +bltZyNQI4hNAPlqp4k64VPYU1+XBNCiDZuWXHLt5zu4LWrzITgoJmuf35BVs2DXiSFu
 e6StwqQOtlfb+bVW9wSb5RKI4r15Le/jkMTDWGg7ndwZ57glXDB4pzcyDmpDs8nhBJR0
 NJaZUt7XGfta4g8mret05ibmgWtKzGcAM5zH3GXe3HxhQIEkwcXulKt+4/3iD6DM68ww
 jfUS+mvMlWHZXsZ3yqAk5EX9v+LcW78g70Zi5SWZttNqT+unob8Cr6b7AMnp2jrFOclB
 ILvg==
X-Gm-Message-State: AOJu0YzZneeygGl+aBTv4egSdkfmET5Lz8O6rDhBjpoNYONvExi2tBgU
 gt2KDGQMM1mEWaj4TDU+yWnSad30zuzROZ9k6BzAOtO6VjNWhGmj7FAg5QUTUhwkaweVRjWjZnz
 zwhtB38w=
X-Gm-Gg: AY/fxX48qE3zHpXcTK0geSOJFjzsWS2TIs+XH17/hHFeHZY5EfXRSd+fzYcbMGew6VJ
 mAvBcx4t29Mt9cLMxLE9BzXf70+STITzeAkObAW9BN+F/KHEABC6bt0WXLw2FDve/dp0U4JdpqL
 7CB3ZOS5654dcZmpw5OanUb1h0kHEVNXPNY5tiScqb0a4Bo1otx1ViD31cB99jkWiykvD6y7RYN
 CFRzAMN9ND+b9ZGEx+xvMPGCDK7+3Gu4wZq99JmzVy+eeU5cU5301zc/VJ1Dl+zCwleAws+4mCL
 QeUgbSffM55Gr77XGvd0xAbgXTnU/phEeoT+PkKlcGH01QjRSz9kXfkTeoygGXCe1FmIOZOrY2U
 QB+A47yculZrealhzSP4FEcKhTL9gVitsIklB1XJuuJFoaBKqHzl0dOobOC/G9AkLAGIPbnYZr+
 8mURm9k1ZOkNdVOhNWFWYU9K8kYIlQVvysykZOKtsReFFZ30EOaEk1rca/f/r9poCGaI8jO34=
X-Google-Smtp-Source: AGHT+IH3WHPEvkqCgEa4VSiDblg5WZz4hRnHCr6rj1iX76QahAoqmBr4Pm8uUMD/Wiwr0AZihYyxvA==
X-Received: by 2002:a05:6000:4023:b0:432:b951:e9fc with SMTP id
 ffacd0b85a97d-432c37636b0mr21668630f8f.47.1768258268870; 
 Mon, 12 Jan 2026 14:51:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dade5sm41062918f8f.9.2026.01.12.14.51.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:51:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/61] target/hppa: Use big-endian variant of cpu_ld/st_data*()
Date: Mon, 12 Jan 2026 23:48:14 +0100
Message-ID: <20260112224857.42068-20-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

We only build the HPPA target using big endianness order,
therefore the cpu_ld/st_data*() definitions expand to the big
endian declarations. Use the explicit big-endian variants.

Mechanical change running:

  $ tgt=hppa; \
    end=be; \
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251229225517.45078-2-philmd@linaro.org>
---
 target/hppa/op_helper.c | 44 ++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 0458378abb2..65faf03cd0a 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -107,7 +107,7 @@ static void do_stby_b(CPUHPPAState *env, target_ulong addr, target_ulong val,
         cpu_stb_data_ra(env, addr, val, ra);
         break;
     case 2:
-        cpu_stw_data_ra(env, addr, val, ra);
+        cpu_stw_be_data_ra(env, addr, val, ra);
         break;
     case 1:
         /* The 3 byte store must appear atomic.  */
@@ -115,11 +115,11 @@ static void do_stby_b(CPUHPPAState *env, target_ulong addr, target_ulong val,
             atomic_store_mask32(env, addr, val, 0x00ffffffu, ra);
         } else {
             cpu_stb_data_ra(env, addr, val >> 16, ra);
-            cpu_stw_data_ra(env, addr + 1, val, ra);
+            cpu_stw_be_data_ra(env, addr + 1, val, ra);
         }
         break;
     default:
-        cpu_stl_data_ra(env, addr, val, ra);
+        cpu_stl_be_data_ra(env, addr, val, ra);
         break;
     }
 }
@@ -132,7 +132,7 @@ static void do_stdby_b(CPUHPPAState *env, target_ulong addr, uint64_t val,
         cpu_stb_data_ra(env, addr, val, ra);
         break;
     case 6:
-        cpu_stw_data_ra(env, addr, val, ra);
+        cpu_stw_be_data_ra(env, addr, val, ra);
         break;
     case 5:
         /* The 3 byte store must appear atomic.  */
@@ -140,11 +140,11 @@ static void do_stdby_b(CPUHPPAState *env, target_ulong addr, uint64_t val,
             atomic_store_mask32(env, addr, val, 0x00ffffffu, ra);
         } else {
             cpu_stb_data_ra(env, addr, val >> 16, ra);
-            cpu_stw_data_ra(env, addr + 1, val, ra);
+            cpu_stw_be_data_ra(env, addr + 1, val, ra);
         }
         break;
     case 4:
-        cpu_stl_data_ra(env, addr, val, ra);
+        cpu_stl_be_data_ra(env, addr, val, ra);
         break;
     case 3:
         /* The 5 byte store must appear atomic.  */
@@ -152,7 +152,7 @@ static void do_stdby_b(CPUHPPAState *env, target_ulong addr, uint64_t val,
             atomic_store_mask64(env, addr, val, 0x000000ffffffffffull, 5, ra);
         } else {
             cpu_stb_data_ra(env, addr, val >> 32, ra);
-            cpu_stl_data_ra(env, addr + 1, val, ra);
+            cpu_stl_be_data_ra(env, addr + 1, val, ra);
         }
         break;
     case 2:
@@ -160,8 +160,8 @@ static void do_stdby_b(CPUHPPAState *env, target_ulong addr, uint64_t val,
         if (parallel) {
             atomic_store_mask64(env, addr, val, 0x0000ffffffffffffull, 6, ra);
         } else {
-            cpu_stw_data_ra(env, addr, val >> 32, ra);
-            cpu_stl_data_ra(env, addr + 2, val, ra);
+            cpu_stw_be_data_ra(env, addr, val >> 32, ra);
+            cpu_stl_be_data_ra(env, addr + 2, val, ra);
         }
         break;
     case 1:
@@ -170,12 +170,12 @@ static void do_stdby_b(CPUHPPAState *env, target_ulong addr, uint64_t val,
             atomic_store_mask64(env, addr, val, 0x00ffffffffffffffull, 7, ra);
         } else {
             cpu_stb_data_ra(env, addr, val >> 48, ra);
-            cpu_stw_data_ra(env, addr + 1, val >> 32, ra);
-            cpu_stl_data_ra(env, addr + 3, val, ra);
+            cpu_stw_be_data_ra(env, addr + 1, val >> 32, ra);
+            cpu_stl_be_data_ra(env, addr + 3, val, ra);
         }
         break;
     default:
-        cpu_stq_data_ra(env, addr, val, ra);
+        cpu_stq_be_data_ra(env, addr, val, ra);
         break;
     }
 }
@@ -211,12 +211,12 @@ static void do_stby_e(CPUHPPAState *env, target_ulong addr, target_ulong val,
         if (parallel) {
             atomic_store_mask32(env, addr - 3, val, 0xffffff00u, ra);
         } else {
-            cpu_stw_data_ra(env, addr - 3, val >> 16, ra);
+            cpu_stw_be_data_ra(env, addr - 3, val >> 16, ra);
             cpu_stb_data_ra(env, addr - 1, val >> 8, ra);
         }
         break;
     case 2:
-        cpu_stw_data_ra(env, addr - 2, val >> 16, ra);
+        cpu_stw_be_data_ra(env, addr - 2, val >> 16, ra);
         break;
     case 1:
         cpu_stb_data_ra(env, addr - 1, val >> 24, ra);
@@ -239,8 +239,8 @@ static void do_stdby_e(CPUHPPAState *env, target_ulong addr, uint64_t val,
             atomic_store_mask64(env, addr - 7, val,
                                 0xffffffffffffff00ull, 7, ra);
         } else {
-            cpu_stl_data_ra(env, addr - 7, val >> 32, ra);
-            cpu_stw_data_ra(env, addr - 3, val >> 16, ra);
+            cpu_stl_be_data_ra(env, addr - 7, val >> 32, ra);
+            cpu_stw_be_data_ra(env, addr - 3, val >> 16, ra);
             cpu_stb_data_ra(env, addr - 1, val >> 8, ra);
         }
         break;
@@ -250,8 +250,8 @@ static void do_stdby_e(CPUHPPAState *env, target_ulong addr, uint64_t val,
             atomic_store_mask64(env, addr - 6, val,
                                 0xffffffffffff0000ull, 6, ra);
         } else {
-            cpu_stl_data_ra(env, addr - 6, val >> 32, ra);
-            cpu_stw_data_ra(env, addr - 2, val >> 16, ra);
+            cpu_stl_be_data_ra(env, addr - 6, val >> 32, ra);
+            cpu_stw_be_data_ra(env, addr - 2, val >> 16, ra);
         }
         break;
     case 5:
@@ -260,24 +260,24 @@ static void do_stdby_e(CPUHPPAState *env, target_ulong addr, uint64_t val,
             atomic_store_mask64(env, addr - 5, val,
                                 0xffffffffff000000ull, 5, ra);
         } else {
-            cpu_stl_data_ra(env, addr - 5, val >> 32, ra);
+            cpu_stl_be_data_ra(env, addr - 5, val >> 32, ra);
             cpu_stb_data_ra(env, addr - 1, val >> 24, ra);
         }
         break;
     case 4:
-        cpu_stl_data_ra(env, addr - 4, val >> 32, ra);
+        cpu_stl_be_data_ra(env, addr - 4, val >> 32, ra);
         break;
     case 3:
         /* The 3 byte store must appear atomic.  */
         if (parallel) {
             atomic_store_mask32(env, addr - 3, val >> 32, 0xffffff00u, ra);
         } else {
-            cpu_stw_data_ra(env, addr - 3, val >> 48, ra);
+            cpu_stw_be_data_ra(env, addr - 3, val >> 48, ra);
             cpu_stb_data_ra(env, addr - 1, val >> 40, ra);
         }
         break;
     case 2:
-        cpu_stw_data_ra(env, addr - 2, val >> 48, ra);
+        cpu_stw_be_data_ra(env, addr - 2, val >> 48, ra);
         break;
     case 1:
         cpu_stb_data_ra(env, addr - 1, val >> 56, ra);
-- 
2.52.0


