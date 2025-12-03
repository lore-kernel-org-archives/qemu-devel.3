Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41392D15DAF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 16:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQpVU-0004AG-UN; Wed, 03 Dec 2025 11:15:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQpVT-00049L-FS
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 11:15:07 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQpVR-0006YP-QI
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 11:15:07 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-3f0ec55ce57so4606623fac.2
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 08:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764778504; x=1765383304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PfNK2eyZFoaZUEw1YRhOUodNTu0hMWFGEWvpWiPmsR8=;
 b=jivJFTelWLewrFvykqwftprQ8f7LW+ie/5V8Z1h10ob33kER0Tl8mG7b2vj1rb5pJr
 roDJnPPFdUCzqbbQqEjWgD0ynnSfxG7ynI8skIKu4t9fEWPcS67T8TPaOmH9Nh7uA25P
 t6iugahe1SjcHPlxkewtTrWZ7rU2aUj2iSMoLtbnNoLoOA7lsHhcyJu+7jcj1JdxfV13
 vwASQS6rWtZQ3ACFPlrg1pSLmPbzNh1lTEORtHblSVeevmUy3gcI4OHhFsxKopFQIMYv
 YQISgwPjDC6qWnhLvJskYEYB0Ixea1FrUQuDVYm5TJLRs01QHO8DCJWzp3bcoCpLxnUM
 o4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764778504; x=1765383304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PfNK2eyZFoaZUEw1YRhOUodNTu0hMWFGEWvpWiPmsR8=;
 b=EukB75N07pq2fZzQan6f7P9YlijwTZeG+OZtDZ8jpcXMrPYm1M9FuFXnyjnZiz+z9p
 yxDqbIhWxRgqXqXqruyma9Xj6Hm89Pwhx0zv+k9s24ejyMq/IZuroD9vCr0hrQrmmusa
 CBRT/xJYpUprYEclonX82t59xKSBefB7DmId0CVs93Agfk0HcQcm1zhDdT2scWlsdyVa
 DD9OG5rrpQBAEkXm+O7Bb8o/g9edmKgLtJIYrYCENfeTimN3LOhCM2RSP+JeAYFg8V4m
 Nb7LEOiMRDnHTycIvi8FwNa6W6qOjgVVjxnkgsCO6Zz1zCdc4PyU0JdOj70LiKUpgFMa
 ynaQ==
X-Gm-Message-State: AOJu0YyHy6UtOvV+nKufmETWcDetK6Hz1FyHmX/V6XnWHS/o1KZg/AX5
 Z+Ba0OLMLV72jxoA4zou4rMJJ1xAjPus9JCy03Iiy3KvQ/s0eCItDPDW1pk4+mjqoUV7D7fxGa0
 /N694w9Y=
X-Gm-Gg: ASbGnctAu5QOTSypcwoe3qWnCt7an1sbQN+PcF+FlbZSvTMg2DC/r8DG3xfVqILt8HF
 s6dskyn9SH/veS1WB/EvXjv/NYVfirMdb2/6C9Pg+F4ezaVIhxm6uji5VcnQj7I72KoW5xCd1xC
 fWg/WVDsM9T8daqK24Hn2WVE2OGEmfjTbNCjxhi2W8uI+g48cTU+J/ANeJJgVU3VeQpXMW+T9QR
 kXGgtZGKuhbRMO7OeWJ2lBpB7yptrbR8BaNHz+BhcHaHzARozGlK1U+MhjcH31kkT2ddPjU5v9t
 wtojxmVWo3N4cWVv+tzytDZJQPhb4gd8AlK9emsl4FfXUNHNvgbD3PzYiKBNXJvsUsUtnAu47Q9
 pu1VSgJFtR5Bm0OtQjLGnfUwarbwg6D1OsLzvVNSgsfx1SR2IJZpLeBiwqqPcwZmx9nvW1kW3Hd
 De5Fto3XrojxU+b9AU2Q==
X-Google-Smtp-Source: AGHT+IHgAHHQtlndJJEmtbCRpVNgN42g+E08B55uiYOJ1M7GWHO93hRtGunv+/udL07c8DTokxSzPg==
X-Received: by 2002:a05:6871:ea10:b0:3e0:ffcb:2f84 with SMTP id
 586e51a60fabf-3f16935c3e3mr1494602fac.28.1764778504467; 
 Wed, 03 Dec 2025 08:15:04 -0800 (PST)
Received: from stoup.. ([187.210.107.189]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dca40d4dsm10141625fac.9.2025.12.03.08.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 08:15:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v3 3/6] tcg: Remove duplicate test from
 plugin_gen_mem_callbacks
Date: Wed,  3 Dec 2025 08:14:56 -0800
Message-ID: <20251203161500.501084-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203161500.501084-1-richard.henderson@linaro.org>
References: <20251203161500.501084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

All callers have already tested tcg_ctx->plugin_insn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-ldst.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 1c0b06dbc7..7716c3ad7c 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -182,23 +182,21 @@ static void
 plugin_gen_mem_callbacks(TCGv_i64 copy_addr, TCGTemp *orig_addr, MemOpIdx oi,
                          enum qemu_plugin_mem_rw rw)
 {
-    if (tcg_ctx->plugin_insn != NULL) {
-        qemu_plugin_meminfo_t info = make_plugin_meminfo(oi, rw);
+    qemu_plugin_meminfo_t info = make_plugin_meminfo(oi, rw);
 
-        if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-            if (!copy_addr) {
-                copy_addr = tcg_temp_ebb_new_i64();
-                tcg_gen_extu_i32_i64(copy_addr, temp_tcgv_i32(orig_addr));
-            }
+    if (tcg_ctx->addr_type == TCG_TYPE_I32) {
+        if (!copy_addr) {
+            copy_addr = tcg_temp_ebb_new_i64();
+            tcg_gen_extu_i32_i64(copy_addr, temp_tcgv_i32(orig_addr));
+        }
+        tcg_gen_plugin_mem_cb(copy_addr, info);
+        tcg_temp_free_i64(copy_addr);
+    } else {
+        if (copy_addr) {
             tcg_gen_plugin_mem_cb(copy_addr, info);
             tcg_temp_free_i64(copy_addr);
         } else {
-            if (copy_addr) {
-                tcg_gen_plugin_mem_cb(copy_addr, info);
-                tcg_temp_free_i64(copy_addr);
-            } else {
-                tcg_gen_plugin_mem_cb(temp_tcgv_i64(orig_addr), info);
-            }
+            tcg_gen_plugin_mem_cb(temp_tcgv_i64(orig_addr), info);
         }
     }
 }
-- 
2.43.0


