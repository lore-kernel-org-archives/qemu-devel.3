Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDD7EF8FEA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmTr-0007zc-F9; Wed, 04 Mar 2026 08:41:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmTJ-0007E8-K9
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:41:05 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmTH-0005L9-J3
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:41:04 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82735a41985so4084617b3a.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772631656; x=1773236456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+JT1mHQyii4VDWEe70HVQ+1DzFVc0uaDHKkQZnAv4e8=;
 b=fTeV1tmB3Y/pyut4A08dgEgS3EpIhy/si9M6orwC8sBMOOj4ZomYsMBeG4gIhxEE4m
 3AT2ZazcohFmRmgG6knl8P+2lbof10DnvgnuPsE3FuEkBX6WTbMWQu3SQ7jHs+SsG3I8
 rFYDJ8zEyNTn446d7tFb1EVNb22nmpaDv5S8X0F+VctgJHSsd6vQS3Q9ELBrKV00Fm+F
 kSZQH6TG+11wC09v8MMaaDsYFPNzuie81uDmebFAz6U8oin9MKl67ZbuI+kc8FGOLvxy
 1OqskeCImnVJnf+ZpHdLhiq/2TySUV6UIdymFmr3Og/SzMwpbX0JfZ/1J06Pq2W2pWMr
 kwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772631656; x=1773236456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+JT1mHQyii4VDWEe70HVQ+1DzFVc0uaDHKkQZnAv4e8=;
 b=VcW5irhqAV+mgUBPH3jPKaGMQKTMg+rYvGX105QAn3WRuIGJpM1Ty8l5ebqs4GJWmH
 qUovHjvKyVHZD+EfDvPM1W/bS3c/DJUzCOwq5GDXhNlWhy3OweLTuo3/NqV1kIN0yAXD
 KhG/hg3pwVvLO8ivRwGy4OstSZAa19TbQz652JYEgrozb7ooQpgZYdMjT1PNiVa5TR1U
 IZYzKcABjXaYem5/u0OTQROSCUmbe3oBGArES0fJyIC0j/UvobH1lC0c9PbdhNs3pI31
 epZu1fxHySkzblCuaTszHM+b+m+Py3ApxpgTWQ1vfWvaAYf+vyy5xQHeFIQaazshTYRQ
 SCUg==
X-Gm-Message-State: AOJu0YxniSTMpkFTTENSrohkV1pOTXHjzIj7Uw4QbKZlBQ20LohsH3Bo
 mW6Z5zA6Uu1qzJhw894gn5E8n0DxIwUb4Hd7vH0MhHMXRJ0p3v7FH3/w5OD+w6ccbjLak8Sshn7
 Egp34vfGOnoi7HvBc34J3lq2rzerNL5MM1gQQgD8CL9KX1BWOFlQdEbaGX6t2p4cl9MvgrHa/ML
 s8f8Ihb01pfTGOfN743PGXlXLULMM9NlM5g7ACjOFTDg==
X-Gm-Gg: ATEYQzw4tMkQIav8j6NhOXPIjrnP6mbXDaBo0t11m1ooG/ouclCr+jok7q8uDUWfBUX
 RdWNaDzoj/xy74xiQGrX+glyI231LhWagMNpTJBATlgZ5bz2qtNmsmAJdtIn/fHWSAhtp+QUiez
 TZ+PgyRJjQub8ZTh69SV6ZYYa0T39BHI9fFW9k+pBgv36q5oRGWo5WboeYAJVwFEOS7QWRAEOvV
 Sroc5mtCbmlABhgsMn1y3gB1VGMyDSGnwydKa0gtBm2ukTmp4Guoei4xFmnaW9rGNK/VuVWvy+P
 nmyL4bcmm777qtzDFkWeAh7MVK/5V/cx2HcMBnQyOZTaxtUAD67PNVQTpZNNDbzb7PJPBgIFXWb
 I9UQqxrboCJHA1e2TvD2A1lYzV1DSDB6W5vRl774aEPNxDjSKvqBhnqJkIPyOJbj5Qev/aUj2pB
 S7EDXrg7acRHU1nVE66EXNttEcD/l1JUJuDGDAfRh6pckHQpYhBk3h2pU1wPIFwbzuiDKLrVDai
 9U+10Zi64mcUrQFuqMhr7FcN3o=
X-Received: by 2002:a05:6a00:2e12:b0:81f:40e5:34b6 with SMTP id
 d2e1a72fcca58-82972b4404dmr2102082b3a.15.1772631655705; 
 Wed, 04 Mar 2026 05:40:55 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8297e11bf5dsm251921b3a.28.2026.03.04.05.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:40:55 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v4 14/14] disas/riscv: Add support of Zvfofp4min extension
Date: Wed,  4 Mar 2026 21:40:06 +0800
Message-ID: <20260304134006.2908449-15-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304134006.2908449-1-max.chou@sifive.com>
References: <20260304134006.2908449-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42b.google.com
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

This patch adds support to disassemble Zvfofp4min instructions.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 disas/riscv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index 30f585772a..5dbeb52c20 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -987,6 +987,7 @@ typedef enum {
     rv_op_vfncvtbf16_sat_f_f_w = 956,
     rv_op_vfncvt_f_f_q = 957,
     rv_op_vfncvt_sat_f_f_q = 958,
+    rv_op_vfext_vf2 = 959,
 } rv_op;
 
 /* register names */
@@ -2260,6 +2261,7 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "vfncvtbf16.sat.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
     { "vfncvt.f.f.q", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
     { "vfncvt.sat.f.f.q", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
+    { "vfext.vf2", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -3715,6 +3717,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     case 12: op = rv_op_vclz_v; break;
                     case 13: op = rv_op_vctz_v; break;
                     case 14: op = rv_op_vcpop_v; break;
+                    case 22: op = rv_op_vfext_vf2; break;
                     }
                     break;
                 case 20:
-- 
2.52.0


