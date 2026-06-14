Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17D0CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 14:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYlb4-0001JJ-M9; Sun, 14 Jun 2026 10:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imaginos32@gmail.com>)
 id 1wYlb2-0001Iu-4k
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 10:13:56 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imaginos32@gmail.com>)
 id 1wYlb0-0003rh-KL
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 10:13:55 -0400
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-490ac10e337so16349915e9.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 07:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781446432; x=1782051232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gHUYLuZwuzMi7F4ecz5j9hrjNh+yhJRwg5RXiaHYtqQ=;
 b=p2IQiEf1U0LCsfo5tXM8HAOQmwuxoJC19j3rliJ5EgbYxN1yIPPKMAmgfWFqW2sx69
 eiWFBuWEIPL1LUETEQgLkjlpG+s1GTfKKjKwEKPRjPyNac8vHgp9ftwRbZIwEHNDA+Z+
 Vvi5bwgVWCyOEywp3aMCDPjjeg6E5t3oYrlowWZVETS6Omo3DNbHAgflNdbBiujsLXVf
 EVUN6TRIKMl1kwcDAKijXqwWVR83ceSIxij1N5uvD/F+OZN/VewPBX6SfdvF4D/ojPxz
 nimnx5RweTi9cc/72sfHBIv8NlzgFrp4YHI8m4jKO0GgTWSdu6mS/y/1jupFA3htLXYq
 QOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781446432; x=1782051232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gHUYLuZwuzMi7F4ecz5j9hrjNh+yhJRwg5RXiaHYtqQ=;
 b=oqHf6H8E5OoYWBLvkqkgmCTpivIW3aLdvjfm2vRl8gjWlroWUrUMuvZcrRpHPgnwJw
 3fbAK4kMyKUjuHDdKN5b9ntpYcVcO1NsJLOjcmHeIaLx1ocxej+mLzDC9C6v9NjL2bLD
 5XGstvvTimdgJL0mZ5ezPON3HaobOsZUJbugJP5tlKHeQB1Be87mGBoMfxaydXVFCXxY
 46mlE1JSS9ze/1rImmEcgIdAUQM73an61CesWyaZNkE0+ZRixp52j9Sir9xqXErHYMiO
 TVhD8eLi2N8qLzWbxe4wNhKryvKQR4Ap+LAb0fxuFPSung1odbQ5bJ9dWGX7yreNxKov
 Jb2Q==
X-Gm-Message-State: AOJu0Yxm4QB5EDWqIMxUcBxbxv+PQk0T7b7kR+OGQPQqCP7LT1hwZUWW
 jUt8AfH7bKALhCbE/5rUFpKlNzTJWEhcBF0UREtb3DDZCDhZiKsUUOorl0SdnzGABgI=
X-Gm-Gg: Acq92OHwIpd3mXXA0pwvidFHozHoU6Bza97+c0ddtmjGVnuryvUbFWsPeCjbQ45TcxD
 b+78Q+VU6RqeYuvNAX6s41MhW9CCEVH7/RABMTmUFfKgN3ocFCaQX+GLV8Q5xEsmak3/KjT7M9l
 zfCVBxv1j4ekkDM0NpGpGGh0xatKUa4iT2G5H/cxB/RIEQ2WhjkPq8mXyFwU/WVMTErgdpSBDV1
 8VjMvY+5icH5uUVPZsuRIG4GVCWHXoF95bb20W+o1TbL9Pk/AoWgDnylHjZ8hlW3pkI9/heZBqh
 amEMRiDXxmQi/viDoih3+Umb8dq0njhcD3rbOFm7xBi8iXAWiJ6JXWJdEtmxCZkYQ31Wz73zmnD
 W9mhEvAnTRcqxOBt30ml6ZEO/04FrcKvcO6GdU2QckXFLF1hckdtXYEk7Nd3aowuVuPOU8Q4Bjs
 YPjc10Jw4U9dUddvOY1ixwZOu8G4xCe00srYX90vj7PDh+ba7r985U2Z0N1082vH3exM1zP33Sw
 qX5brc=
X-Received: by 2002:a05:600c:55c2:b0:490:b1b8:95f5 with SMTP id
 5b1f17b1804b1-4922006282bmr62664325e9.15.1781446432172; 
 Sun, 14 Jun 2026 07:13:52 -0700 (PDT)
Received: from user-Legion-Pro-5-16ARX8.. (cable-89-216-220-81.dynamic.sbb.rs.
 [89.216.220.81]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492202edf89sm177523435e9.1.2026.06.14.07.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 07:13:51 -0700 (PDT)
From: imaginos <imaginos32@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 imaginos <imaginos32@gmail.com>
Subject: [PATCH v2] disas/riscv: enable `mnret` disassembly
Date: Sun, 14 Jun 2026 16:12:24 +0200
Message-ID: <20260614141315.17320-1-imaginos32@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260606145520.34152-1-imaginos32@gmail.com>
References: <20260606145520.34152-1-imaginos32@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=imaginos32@gmail.com; helo=mail-wm1-x343.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The translator has supported mnret since commit 3157a553ec6b9a
("target/riscv: Add Smrnmi mnret instruction"), but the
disassembler still renders it as illegal. Add it unguarded,
since the encoding does not overlap any other extension.

Signed-off-by: imaginos <imaginos32@gmail.com>
---
v2: rebase on riscv-to-apply.next

 disas/riscv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index b8ec546883..7f1b262773 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -989,6 +989,7 @@ typedef enum {
     rv_op_cbo_clean = 957,
     rv_op_cbo_flush = 958,
     rv_op_cbo_zero = 959,
+    rv_op_mnret = 960,
 } rv_op;
 
 /* register names */
@@ -2263,6 +2264,7 @@ const rv_opcode_data rvi_opcode_data[] = {
    { "cbo.clean", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
    { "cbo.flush", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
    { "cbo.zero", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
+   { "mnret", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -4077,6 +4079,11 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     case 64: op = rv_op_mret; break;
                     }
                     break;
+                case 1792:
+                    switch ((inst >> 15) & 0b1111111111) {
+                    case 64: op = rv_op_mnret; break;
+                    }
+                    break;
                 case 1952:
                     switch ((inst >> 15) & 0b1111111111) {
                     case 576: op = rv_op_dret; break;
-- 
2.43.0


