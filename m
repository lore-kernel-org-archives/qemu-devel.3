Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8127C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 21:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riiAc-0007TK-OP; Fri, 08 Mar 2024 16:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riiAZ-0007SI-HP
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:54:24 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riiAX-0001kR-PB
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:54:23 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dbd32cff0bso22203965ad.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 13:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709934860; x=1710539660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BTyg1i/1DQdgOJUu808vlkHFJKjnCQY7nU+Nk0IuvAs=;
 b=WVEgEPrOM7e9KJMqiFcmaMTvxQVB57TGN8XMcVnCGvhq9q3UZ2Qnpiwu24V+aaV3s4
 E63/EMvCU2E4Q8YXdJevJVWyZRK+Q6LxgyEzePD7my279wO4qeQoMYZoZ8tg+wTMMmFd
 2gMV3lEJUjjh3RsE3r8xM2nulZnY5Xq2HDEaIUGdTFeaInQmDNdLULmxJK8gQ6deJemg
 UDHg4mGhLGPvLFMcyw3yEnonqHAzDcY2HeC4VY2sq7vTHDZSStIWXtEPXvUCfWKOaSa1
 HpePMjLnowE0FlsMZiOI5amlVs/6U0aitIneA+rkHinPx7u/MpgBciQDDrCR05ScFVX1
 dbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709934860; x=1710539660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BTyg1i/1DQdgOJUu808vlkHFJKjnCQY7nU+Nk0IuvAs=;
 b=mT/Eya5eX6fav38NLDsue4vkOD9u0iMm9HUqzOmzJ+HtORXTNAwVpDh43I6C8OxaP7
 2dcigfoMyGMY6lcSOBgeXEb+5qq/KlE2jgDrjuiwEoaHoTrYHCChmirZMIkl0zP6pje3
 nUoLQUpyFDHm2nkWmSt+Cvn6jUqLw/9H4XToh6E78NWF77BQ0H8iv8IjL0Ws9J9A4Tb9
 ZYPz3FJVQqGpCwp8i/Ur9y6OfZ0rCmVp2micnpSTpkUXsSmMMOADseBwmi/R05NceeL7
 fTDPWsvbTjBQx54zEG1MDFxPckPyDJWWLUvVTKMvNU3IhNP0OaqZRcb2JHK5m8hBNe4L
 +EyQ==
X-Gm-Message-State: AOJu0YzsRXbYMfUsIRYUvjD9NQbv+L3azGTUHXUUuUmHDrPd96P2ohi0
 eYgptPqZn7q4r2bRoqEMGQ0FREIjfg0iviNObkjImvSJfGw6xUHqlmbDOCmAV3OpVyKl6PV1hS9
 s
X-Google-Smtp-Source: AGHT+IFfgYLLflSfXnjBIB5m6JqbLzjEkuJAVESXq9k3wB6190Dc254em0EJ2FjNsYW7O/tZkpUqHg==
X-Received: by 2002:a17:902:ef8c:b0:1dc:afd1:9c37 with SMTP id
 iz12-20020a170902ef8c00b001dcafd19c37mr298203plb.24.1709934859712; 
 Fri, 08 Mar 2024 13:54:19 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 d3-20020a170902b70300b001dd66e6ec91sm107702pls.140.2024.03.08.13.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 13:54:19 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 02/10] target/riscv: handle vstart >= vl in
 vext_set_tail_elems_1s()
Date: Fri,  8 Mar 2024 18:53:42 -0300
Message-ID: <20240308215402.117405-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308215402.117405-1-dbarboza@ventanamicro.com>
References: <20240308215402.117405-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
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

We're going to make changes that will required each helper to be
responsible for the 'vstart' management, i.e. we will relieve the
'vstart < vl' assumption that helpers have today.

To do that we'll need to deal with how we're updating tail elements
first. We can't update them if vstart >= vl.

We already have the vext_set_tail_elems_1s() helper to update tail
elements.  Change it to accept an 'env' pointer, where we can read both
vstart and vl, and make it a no-op if vstart >= vl. Note that the
callers will need to set env->start after the helper from now on.

We'll enforce the use of this helper to update tail elements on all
instructions, making everyone able to skip the tail update if vstart
isn't adequate.

Let's also simplify the API a little by removing the 'nf' argument since
it can be derived from 'desc'.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/vector_helper.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index ca79571ae2..db1d3f77ce 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -174,19 +174,27 @@ GEN_VEXT_ST_ELEM(ste_h, int16_t, H2, stw)
 GEN_VEXT_ST_ELEM(ste_w, int32_t, H4, stl)
 GEN_VEXT_ST_ELEM(ste_d, int64_t, H8, stq)
 
-static void vext_set_tail_elems_1s(target_ulong vl, void *vd,
-                                   uint32_t desc, uint32_t nf,
-                                   uint32_t esz, uint32_t max_elems)
+static void vext_set_tail_elems_1s(CPURISCVState *env, void *vd,
+                                   uint32_t desc, uint32_t esz,
+                                   uint32_t max_elems)
 {
     uint32_t vta = vext_vta(desc);
+    uint32_t nf = vext_nf(desc);
     int k;
 
-    if (vta == 0) {
+    /*
+     * Section 5.4 of the RVV spec mentions:
+     * "When vstart ≥ vl, there are no body elements, and no
+     *  elements are updated in any destination vector register
+     *  group, including that no tail elements are updated
+     *  with agnostic values."
+     */
+    if (vta == 0 || env->vstart >= env->vl) {
         return;
     }
 
     for (k = 0; k < nf; ++k) {
-        vext_set_elems_1s(vd, vta, (k * max_elems + vl) * esz,
+        vext_set_elems_1s(vd, vta, (k * max_elems + env->vl) * esz,
                           (k * max_elems + max_elems) * esz);
     }
 }
@@ -222,9 +230,8 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
             k++;
         }
     }
+    vext_set_tail_elems_1s(env, vd, desc, esz, max_elems);
     env->vstart = 0;
-
-    vext_set_tail_elems_1s(env->vl, vd, desc, nf, esz, max_elems);
 }
 
 #define GEN_VEXT_LD_STRIDE(NAME, ETYPE, LOAD_FN)                        \
@@ -281,9 +288,8 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
             k++;
         }
     }
+    vext_set_tail_elems_1s(env, vd, desc, esz, max_elems);
     env->vstart = 0;
-
-    vext_set_tail_elems_1s(evl, vd, desc, nf, esz, max_elems);
 }
 
 /*
@@ -402,9 +408,8 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
             k++;
         }
     }
+    vext_set_tail_elems_1s(env, vd, desc, esz, max_elems);
     env->vstart = 0;
-
-    vext_set_tail_elems_1s(env->vl, vd, desc, nf, esz, max_elems);
 }
 
 #define GEN_VEXT_LD_INDEX(NAME, ETYPE, INDEX_FN, LOAD_FN)                  \
@@ -532,9 +537,8 @@ ProbeSuccess:
             k++;
         }
     }
+    vext_set_tail_elems_1s(env, vd, desc, esz, max_elems);
     env->vstart = 0;
-
-    vext_set_tail_elems_1s(env->vl, vd, desc, nf, esz, max_elems);
 }
 
 #define GEN_VEXT_LDFF(NAME, ETYPE, LOAD_FN)               \
-- 
2.43.2


