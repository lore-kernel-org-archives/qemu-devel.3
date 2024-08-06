Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EE8C52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 06:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbDe6-0003Lg-Kb; Tue, 06 Aug 2024 02:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbDe4-0003H3-UU
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 02:26:08 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbDe3-0003xF-3t
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 02:26:08 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fd640a6454so1766075ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 23:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722925565; x=1723530365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OTX/GHXUmXFh0D4AEM8ZY3l4zU6LP3K0z3O3UyAfsjo=;
 b=DXUJkiskpBzfwoGnMlRgOFv1sX+Vy0aVpyJtXbC25dqyE7ibhI1icf2b5Ga+cjt0Cr
 yllI1lyUzbtA6Y+2NQLnrPRkE450+k9IhYeRLnIHqkznPEXCaucEAbxKVyc4FJ1FI+ji
 sVC6TUk8qy7UUzq1POUjRB9rqyE8D4ZAn/rXt7U207/9eHinAWzDboHaWtKuoeXqRry4
 Om80/DrYpufEZC53tP5fPKEf+oVdiX+e3Q+1PlEHpTgxcVZNAiAQEhfwmVH4euuO24Lx
 ydwSdianQXmN/JRkfM3HfzWkU+OT5mq1jejPROWiOLmTm+UJB0N+43GwD4E4Bn2SC/Bw
 /RIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722925565; x=1723530365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OTX/GHXUmXFh0D4AEM8ZY3l4zU6LP3K0z3O3UyAfsjo=;
 b=wZRIe/UlQKlqmg+g5JjfM8qeZV5FSQ9IgNBmIQPyJa7DPjvn+DNINDxSvHLLCx/xQr
 0qOb0HmEv55lkHG3mO8H/tAQZFFIArp9uJNIqE2z5FfopEbZ091XgE+ySY1AghTZQGuL
 OENSE+NzLTvTEFCelzC3BzMEijF12UZuFVieWRODMJSgG5sa8bkTaP/XXVEs2HhMqrEf
 PzcZHyy4EIrGN67l7/7vZONpEF6dygGkoCZEUC+M670tSNGqlXcPKjsTPFyWyLUCMOad
 jC4H+4pUylxI7TJB5NhKQkg8hZUmPcwWH4hMgbD7GeqeX5grNy6EBQJG+3xynG6vM1k4
 DEaA==
X-Gm-Message-State: AOJu0Yyy5uU+Oui31TAIu7BEWaShpJz5ORp/gjKWiH1/qZLDlwrHdePO
 Ieov2fK//148gfIDLL03lBPfYMYzukFzV9JNYop9r3avFVIlPM/4q4+eNIup
X-Google-Smtp-Source: AGHT+IF5Pl8s81U4n/WjooUF8w3HVO5+U4CDYPQsgS7HIJmcv4isCuQj5MMesKX9GIfrsx177CDIqw==
X-Received: by 2002:a17:903:110f:b0:1fb:8e00:e5e8 with SMTP id
 d9443c01a7336-1ff5727cff6mr152124725ad.10.1722925564932; 
 Mon, 05 Aug 2024 23:26:04 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5927f161sm79464975ad.232.2024.08.05.23.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 23:26:04 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 3/5] target/riscv: Relax fld alignment requirement
Date: Tue,  6 Aug 2024 16:25:43 +1000
Message-ID: <20240806062545.1250910-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806062545.1250910-1-alistair.francis@wdc.com>
References: <20240806062545.1250910-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

According to the risc-v specification:
"FLD and FSD are only guaranteed to execute atomically if the effective
address is naturally aligned and XLEN≥64."

We currently implement fld as MO_ATOM_IFALIGN when XLEN < 64, which does
not violate the rules. But it will hide some problems. So relax it to
MO_ATOM_NONE.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240802072417.659-4-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvd.c.inc | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_trans/trans_rvd.c.inc
index 49682292b8..8a46124f98 100644
--- a/target/riscv/insn_trans/trans_rvd.c.inc
+++ b/target/riscv/insn_trans/trans_rvd.c.inc
@@ -48,11 +48,17 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
     REQUIRE_EXT(ctx, RVD);
 
     /*
-     * Zama16b applies to loads and stores of no more than MXLEN bits defined
-     * in the F, D, and Q extensions.
+     * FLD and FSD are only guaranteed to execute atomically if the effective
+     * address is naturally aligned and XLEN≥64. Also, zama16b applies to
+     * loads and stores of no more than MXLEN bits defined in the F, D, and
+     * Q extensions.
      */
-    if ((get_xl_max(ctx) >= MXL_RV64) && ctx->cfg_ptr->ext_zama16b) {
+    if (get_xl_max(ctx) == MXL_RV32) {
+        memop |= MO_ATOM_NONE;
+    } else if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
+    } else {
+        memop |= MO_ATOM_IFALIGN;
     }
 
     decode_save_opc(ctx);
@@ -71,8 +77,12 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
 
-    if ((get_xl_max(ctx) >= MXL_RV64) && ctx->cfg_ptr->ext_zama16b) {
+    if (get_xl_max(ctx) == MXL_RV32) {
+        memop |= MO_ATOM_NONE;
+    } else if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
+    } else {
+        memop |= MO_ATOM_IFALIGN;
     }
 
     decode_save_opc(ctx);
-- 
2.45.2


