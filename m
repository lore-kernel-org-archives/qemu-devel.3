Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8EFC5CFEB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHUb-0007ND-Ew; Wed, 12 Aug 2026 18:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUZ-0007Kt-00
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:11 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUU-000104-CO
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:10 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so153120a91.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573924; x=1787178724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fkr8ILSgdmdAd6Z+/5pTP1IGHAginhfzN0HdJ9S2suo=;
 b=wYRofGrEpyCl3C6frqzI13s+asSqCupk93efLgOJwbhawQnzhBlYMRVGVDJxh5RUg/
 qtDwJZ3kLAgllzrTP/SDUM+CVSIwsz8Dvgg5GJmBpVnJsernYNDb8UaZIhvhIsThknWb
 RmHJ0OTAcRvlbG0mluVhy/olvve5osWqNxJDV1ncu7P08n1T5XGDWvHmsacrqc4n5m5N
 Hvj8mr2Uqgh9/1ZPud7cUVMmhTnX1AjAK7yIuNnak/DJ9FmlvvtOsOaglMKR45QinEex
 lat/twUASrk7xUQYqe/TpZeI2hT+2ySnah/vaxKliX1z3SZxblEjT/k+LgFC7MdV0FQK
 NrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573924; x=1787178724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Fkr8ILSgdmdAd6Z+/5pTP1IGHAginhfzN0HdJ9S2suo=;
 b=GuyT8bLW1KxvqAwwJKXteOmcwC8r7JxZUNwUcOKFURs9ywZW+cHip0wN9AYqe1B9s+
 hDRc4E9pTPGoY6a9a9Dle8SyLUSw7yeD+53g8MVfMcq5Eh4Gdy3dNqdBMA9syewf4HyW
 kYqhoQ3GOt4MRVhH5jhPdN3dSSo1Xfe5k7U8ZtQGbVMsD65QKBHqZ8e8JweXwOi0c9I7
 RrCjBfaa6Vn5k/fwcSBNHO0SvIRpNkn5ZpKoMm/5jJ8pY/sS+UHuxpEnX3pGl45ab4bq
 6alm0cwawz2y03ylaMO9fbIC2ZS2AHaayCyj5UIXsybw5Oe0/LNnJqGlnqkcVVnzbZPe
 8KIQ==
X-Gm-Message-State: AOJu0Yz58d9mKPiaSs4XZ5wtc1MflqqoVKsrkVl/gX4YnRN+C3o4WQCX
 154xQ4ORwSfNOw9E8J6JWSOvQWqq1+cBAyg9HHzqWY2JQuGx91CaU9QoryoTdQgpMaQwofe1N1z
 MMGYF
X-Gm-Gg: AR+sD13n+T3DRuiWFg6n8QAtj/RzO46C8s6RzbL+qYGuET2KlhE7ItOseMS2Kvzikp6
 AP0KSvGzU5jvyATm7k+D8lN3FgG/OpkNE0DWUMGRwTepcLpkS2Pq/ehgQ5eWpZ0p4ntWYIGJ6gs
 Jjo87u8X4no3nDhGm8QDh9NhLXmk6EnBpUmCCWQIMRjWSARfq21Vjdf/ojs0hp5QRGU2aFi616C
 0FJ0HYqYtGOoq89SGNMMIpEiRoHvSl+EHGO+jeH0DCDVh9pvkSLcTqk61r2WIo9+bslHaMbNv0w
 L+K9XT+rwdHCjBNfiWABsYNgMpoMsOzWYzpLTWxyOTejd5kMF7iG/EMT0qroK/3nDVcKpMv0hnv
 ifAqQZiqBcj9cqaAhUV81cwEWbyZuG180dMXJo3VZmJNOK8rzBZ1o1+n2vtAj7tZ3qwus0Tn/CL
 fvtj51tj7acuMHVLgteFf0+lBFC1gy8JbMEeD3joy8V+a9brjMgOTD3FpTZbrQIp7us5DJweqGZ
 sOs0u1S1AfAowj/vJHL
X-Received: by 2002:a05:6a21:7111:b0:3c3:af85:85e7 with SMTP id
 adf61e73a8af0-3cc55423424mr2118204637.34.1786573924289; 
 Wed, 12 Aug 2026 15:32:04 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:32:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 19/52] disas/riscv: Remove rvcd_imm_nz
Date: Wed, 12 Aug 2026 15:31:09 -0700
Message-ID: <20260812223142.349142-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Remove rvcd_imm_nz and rv_opcode_data.decomp_data as unused.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.h | 5 -----
 disas/riscv.c | 7 +------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index 31bb0db86c..3909d73dd0 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -186,7 +186,6 @@ typedef struct {
     short decomp_rv32;
     short decomp_rv64;
     short decomp_rv128;
-    short decomp_data;
 } rv_opcode_data;
 
 typedef struct {
@@ -217,10 +216,6 @@ enum {
     rv_op_illegal = 0
 };
 
-enum {
-    rvcd_imm_nz = 0x1
-};
-
 /* instruction formats */
 
 #define rv_fmt_none                   "O\t"
diff --git a/disas/riscv.c b/disas/riscv.c
index ddc2f73eae..95957506bd 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5417,12 +5417,7 @@ static const rv_opcode_data *decode_inst_decompress(rv_decode *dec, rv_isa isa,
     }
 
     if (decomp_op != rv_op_illegal) {
-        if ((op->decomp_data & rvcd_imm_nz) && dec->imm == 0) {
-            dec->opcode_data = rvi_opcode_data;
-            dec->op = rv_op_illegal;
-        } else {
-            dec->op = decomp_op;
-        }
+        dec->op = decomp_op;
         op = &dec->opcode_data[decomp_op];
     }
     return op;
-- 
2.43.0


