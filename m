Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835D2CD98E7
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQjJ-0006CK-HV; Tue, 16 Jun 2026 06:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQjE-00063W-FU
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:09 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQjD-0003nF-0W
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:08 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-36bba9a1089so2548549a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604545; x=1782209345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=klQeXcFqg6sY3LuPqqW6DC5KTXVw4lVlN5+eeEYUWIg=;
 b=L0E5Pusco9BovacrrtDIdCgVBsVDJEmnyl+1HShRdmwuy7xpjYOjsj02NqdU9gwRz3
 9vfU9ZPazkbfldsdf7X/nOjIZD2Vt9IZxUiJ2XkP9lF+xtRC0M/NRDrZVdg8bABRd3He
 jSxNzVWLNIByDYzD2+Gu1FVbkg03AacsY7Cdy8DJfp8o+a3R5eegkLeuSEUqTymXAZ5y
 XdEs+GGtb2I4xdNc/WsR+dhebAtlaB3n7NHeqfq7OFxGztrj+G9NnouNvqWP/Gk5Ivsu
 R/h/nD2rijun8IIiOztA32TXdtsbBDBWcyjYdA4chOp6/SjPQY9laMLokYa7ecKXh0lY
 GMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604545; x=1782209345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=klQeXcFqg6sY3LuPqqW6DC5KTXVw4lVlN5+eeEYUWIg=;
 b=d0aNy+UANoNE3XcXICo0j8C/WFgtkIbnwHQWm68cX2yJkLSIVlX1aupKQkyeROHpWf
 GS9JWM8n9uEreplu4RXNSBXA7FFu6Mrf/7ttElMtd2creizHmBpZEa1rWRL6YlAQJbYq
 CIQ6c6VRlbiQaJac9xXFjXyc2sMXcSJdRejGKOaaR5e23mhwPKVNxBAiZ+MjS9NL4jCA
 5hnDmjgAz9VcuYCLqycD2nn+xWvQeB3TmmeRPBk84vRnSa+rqnGf18NSN3Q+Yl3tm8aX
 rdxJmdwzOVIaTpPnsQ3fyOTEV/1TPXq4lRTA8Yy/ZYNeIllpZonvW+SxYeodgwL31zxk
 woIg==
X-Gm-Message-State: AOJu0Ywy6kjQAb+SUAxr6wzvIept7N1VUbbpBB5I8fh2htiLSlKQXLUY
 Am2SyO7wOgyUeAsdv8vdl3ev9ew4y58SLkvTOkMcFcFv5TbwrbnrOZuyov/NHztt
X-Gm-Gg: Acq92OHquRgv0DCatYYj41N7PnDN6EoyPFwWr5Fzn7N7PAVIeFbWwzwrSPm5nld6pMA
 1edtAYhpM2U/T14G1SJpUhGdh+E3x/oT/xIh0xjIMDJnYjI18JeNtBJ8RoqfaE5BYpGo6EpTm5E
 tD590IFiXofa/agIUkpm0y/KkD9hNDsJjJCSJQ5TjowvSDvp1KHwUZAcjkyXrGmIAfZ5sFSuWKU
 KnzfiJTU/D8/76d5uWtLGGUYEI+C1lZuhpRTKJdqOj+ZT+1++wb4K1XbFvGrxv4AYE2yxJv9FQU
 zdmP1r4HYrPeCc77ZYOR/cWiI/9iEjtGFyNnomsnkJYBVQLONUXa/VX5GwUsAzz8VdebSFvldX7
 bazeSS0yIZ2Vz3Ek2u1CC2MhXzfjMhvonKggMcb4+YgfwnV8IzGo3j76Fhj27FXICELb7N5smc0
 sJiVYiRJC8qy75tIuB6eK30jeZlrOqjLxqgdnMgjjK
X-Received: by 2002:a05:6a21:493:b0:3b3:bdfd:762c with SMTP id
 adf61e73a8af0-3b79625bf04mr16915087637.17.1781604545146; 
 Tue, 16 Jun 2026 03:09:05 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:09:04 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 60/83] hw/riscv: Don't insert DDT cache in Bare mode
Date: Tue, 16 Jun 2026 20:05:03 +1000
Message-ID: <20260616100527.1939565-61-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Jay Chang <jay.chang@sifive.com>

In Bare mode the IOMMU does not perform DDT look-ups, therefore
caching DDT entries is unnecessary.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20260518072239.16293-2-jay.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 1b8a8e9ef2..5b28b1ad63 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1358,16 +1358,23 @@ static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
 
     int fault = riscv_iommu_ctx_fetch(s, ctx);
     if (!fault) {
-        if (g_hash_table_size(ctx_cache) >= LIMIT_CACHE_CTX) {
+        if (mode != RISCV_IOMMU_DDTP_MODE_BARE) {
+            if (g_hash_table_size(ctx_cache) >= LIMIT_CACHE_CTX) {
+                g_hash_table_unref(ctx_cache);
+                ctx_cache = g_hash_table_new_full(riscv_iommu_ctx_hash,
+                                                  riscv_iommu_ctx_equal,
+                                                  g_free, NULL);
+                g_hash_table_ref(ctx_cache);
+                g_hash_table_unref(qatomic_xchg(&s->ctx_cache, ctx_cache));
+            }
+
+            g_hash_table_add(ctx_cache, ctx);
+            *ref = ctx_cache;
+        } else {
             g_hash_table_unref(ctx_cache);
-            ctx_cache = g_hash_table_new_full(riscv_iommu_ctx_hash,
-                                              riscv_iommu_ctx_equal,
-                                              g_free, NULL);
-            g_hash_table_ref(ctx_cache);
-            g_hash_table_unref(qatomic_xchg(&s->ctx_cache, ctx_cache));
+            /* Remember ctx so it can be freed */
+            *ref = ctx;
         }
-        g_hash_table_add(ctx_cache, ctx);
-        *ref = ctx_cache;
         return ctx;
     }
 
-- 
2.54.0


