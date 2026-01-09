Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B506D232E9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6zI-0002wG-CD; Fri, 09 Jan 2026 02:32:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1ve6yl-0002cZ-MA
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:32:15 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1ve6yk-0008J5-32
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:32:15 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-81c5ff546f6so867879b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 23:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767943933; x=1768548733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ph4xqbmoEVTv72fGeGTo/4FX3xeTc8ZJNboz33aWPA=;
 b=RomITAMjqD+r6F+Yt9NvrEb/yW7SWLROERIKQX+YpirJ6dXWH8F7WWV9Ramotx8PTb
 Y7U9zNhH+yLmc1cvDSHsPoCnxcisq3Wk6P2d085hISspsEndI2ZnMtjMUbCbh7fZGpx9
 LqTp2tTSYqebmECeCRe7v8vmQc65zJWXuM6altRg7ZRDjV8WG3Xfb5SO3nT7wM8y8ikI
 lomEQgy9lGq3mD8lFIyQffYNg3NXY782Sxcg9trN8pfebfmEe7IKnDStgGrkhj7KX6Ux
 bjO3jkoBqYRyKEouiBTDDKnYStKHlLeUnOLSJgqA+mjbvidXSZqrq9ivHO00ad4dYWaA
 0rBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767943933; x=1768548733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8ph4xqbmoEVTv72fGeGTo/4FX3xeTc8ZJNboz33aWPA=;
 b=EO7+Txk0LKRjuM6+AHKdfTiCNmOdcRKAz6bjMb1PmpY4kE13Tiq6VlyX86QK71akhp
 mhM6mboNjSLNbf5O5VICHXiNOVfyZlk4MIJi9R7wvxg8Vjet/hQGc+z41DC5UvN5B75C
 fDgtwZYsQrMTHiHOVqRRfzp0Wem5Kk3ZlmliHcz7SJAatURokAkGhWkztJRayYB0/AfA
 sGmWF4BgeaQb+OPrRYpxB3uqx8ligFCxYivvebgYEiUW2onHvCJKzSsdkdJ82M4wXYLd
 I4o4jvW2tRFy+hBDNuaXwQEE+EK6RtL7JIVYE9rt27KcJ49C1paWpN+cPX7bF2Hynz3H
 2dcA==
X-Gm-Message-State: AOJu0Yz2BfSqtCRbMnYFMCaElKYw7iHRAWBrwYOGoFoxYaI2SRHCBYtM
 C0FTdgY5noJyL8G/f7Rx0UeI6utd/tqK1D9mXsxHHnh2AiLimyqIs5WUCFqZeb0rc16LRaB8A3J
 1RdplP7w9vSs3r5OWBYVlqufL0MwcBG5Q5Pwuu9Qh69xZ2fR4b//zaL5I2Su6UdszABqSLAkHjR
 qmRZ/SS9PhnDvQ/G3SRbU+ih3bWQkKlOtV/j2qJTk=
X-Gm-Gg: AY/fxX7Kp+rc67A7Tht9vIcxPoKqHCH3K/dmEuk5OaJ6sWh/IecmC26BL9bWxcCrdNo
 xuOj9EkdOln8I7d31XM37z4pRcOWhEzk6z2DeQi3QLDMZnOEhYVXPWvhknc2h2aARQnDO9OrkQ8
 4lnvHlqLScuk5RcFD2P1W2GKvqbZAMhktv3uSEWTW/ZdL1iej44PE+Rl2tb4KVf+tlKC3+GUsJT
 Nmqq7S8j50PpZlwjSNsyz/l8pDtXz+aco/8x67hf8/061hgeK+sZ+5aYe0dNDeBWmpbpq2NaeT3
 uVg2p1NkUvrT9NgqLzzGbA/oB8W66rVB6CyKGY9n7UJVqwLf8nw4Pgcm3He+pRBFOp5YAXLwcrq
 s5Ja1mHNC5x/i+oTO9zK3EidaoQ9+A3k8Vp+5EZThw6nvSxS8dIj300mzQkblUcTPtpKZZRzY8+
 GsioL/0klT5bB7XGk7AMtbjEbkSrcpWxhmgw+TWBeI2JtAtvDwRhtcRAQ=
X-Google-Smtp-Source: AGHT+IEB5f1ZiW2KpF5jYMplQeHCOajUZU1N5ngDZ/acdPHhnO4UdtSa3nWrJsWwAI8PWzvPWKlwRA==
X-Received: by 2002:a05:6a00:1a15:b0:7e8:3fcb:9b0b with SMTP id
 d2e1a72fcca58-8194efe1e5dmr10337257b3a.33.1767943932479; 
 Thu, 08 Jan 2026 23:32:12 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c52fd904sm9490421b3a.33.2026.01.08.23.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 23:32:12 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v5 4/4] disas/riscv: Support the Zvqdotq extension
Date: Fri,  9 Jan 2026 15:31:54 +0800
Message-ID: <20260109073154.46251-5-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109073154.46251-1-max.chou@sifive.com>
References: <20260109073154.46251-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x434.google.com
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

The Zvqdotq provides following instructions:
- vqdot.[vv,vx] Vector 8-bit Signed-Signed Dot Product
- vqdotu.[vv,vx] Vector 8-bit Unsigned Dot Product
- vqdotsu.[vv,vx] Vector 8-bit Signed-Unsigned Dot Product
- vqdotus.vx Vector 8-bit Unsigned-Signed Dot Product

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 disas/riscv.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index 85cd2a9c2a..b7520f2b42 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -984,6 +984,13 @@ typedef enum {
     rv_op_ssamoswap_d = 953,
     rv_op_c_sspush = 954,
     rv_op_c_sspopchk = 955,
+    rv_op_vqdot_vv = 956,
+    rv_op_vqdot_vx = 957,
+    rv_op_vqdotu_vv = 958,
+    rv_op_vqdotu_vx = 959,
+    rv_op_vqdotsu_vv = 960,
+    rv_op_vqdotsu_vx = 961,
+    rv_op_vqdotus_vx = 962,
 } rv_op;
 
 /* register names */
@@ -2254,6 +2261,13 @@ const rv_opcode_data rvi_opcode_data[] = {
       rv_op_sspush, 0 },
     { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL, rv_op_sspopchk,
       rv_op_sspopchk, 0 },
+    { "vqdot.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, NULL, 0, 0, 0 },
+    { "vqdot.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm, NULL, 0, 0, 0 },
+    { "vqdotu.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, NULL, 0, 0, 0 },
+    { "vqdotu.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm, NULL, 0, 0, 0 },
+    { "vqdotsu.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, NULL, 0, 0, 0 },
+    { "vqdotsu.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm, NULL, 0, 0, 0 },
+    { "vqdotus.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -3738,8 +3752,11 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 37: op = rv_op_vmul_vv; break;
                 case 38: op = rv_op_vmulhsu_vv; break;
                 case 39: op = rv_op_vmulh_vv; break;
+                case 40: op = rv_op_vqdotu_vv; break;
                 case 41: op = rv_op_vmadd_vv; break;
+                case 42: op = rv_op_vqdotsu_vv; break;
                 case 43: op = rv_op_vnmsub_vv; break;
+                case 44: op = rv_op_vqdot_vv; break;
                 case 45: op = rv_op_vmacc_vv; break;
                 case 47: op = rv_op_vnmsac_vv; break;
                 case 48: op = rv_op_vwaddu_vv; break;
@@ -3945,9 +3962,13 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 37: op = rv_op_vmul_vx; break;
                 case 38: op = rv_op_vmulhsu_vx; break;
                 case 39: op = rv_op_vmulh_vx; break;
+                case 40: op = rv_op_vqdotu_vx; break;
                 case 41: op = rv_op_vmadd_vx; break;
+                case 42: op = rv_op_vqdotsu_vx; break;
                 case 43: op = rv_op_vnmsub_vx; break;
+                case 44: op = rv_op_vqdot_vx; break;
                 case 45: op = rv_op_vmacc_vx; break;
+                case 46: op = rv_op_vqdotus_vx; break;
                 case 47: op = rv_op_vnmsac_vx; break;
                 case 48: op = rv_op_vwaddu_vx; break;
                 case 49: op = rv_op_vwadd_vx; break;
-- 
2.43.7


