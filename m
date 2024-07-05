Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11ACC3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 16:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPmBc-0000Nl-2z; Fri, 05 Jul 2024 12:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1sPmBa-0000NO-2n
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 12:53:26 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1sPmBY-0000Cx-Cp
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 12:53:25 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4256aee6e4dso12570965e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 09:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720198402; x=1720803202;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LOa9Ak+x1ZCP6AAKN93g7PoxLp1f3FV1h6D+ky8VeJM=;
 b=H0xrMFUO0DCKg5A8WUn1uXn/TPc0I0/YKsQQkWQBFUnf7Chw2gmS942TJqWDdfoZFo
 yc7hzN0u+8nWGoPeFRHmKB0YqkB+hNauIwvtbbvagfS3fMdipAv9stN4WgdbPkFEKU6z
 o9tQ6mU8vhlWuwIu7DsLDi0Ddg1qw93qL75ULm8yH+8LPA+P8wpI2fEgr3G2HlB1Locr
 cRZDg5liQyjI0Mq7n3otdSWzJkGdZWqwRAI4xeOC5ifsNCu90a+amquY2TcxbpM38mDA
 ZjV7E+YB8Livdwm+GdwQ43sQcpWa1acEyPok2AoWJqryWz3/JXJO6corOyRbh5r6W4Zs
 qB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720198402; x=1720803202;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LOa9Ak+x1ZCP6AAKN93g7PoxLp1f3FV1h6D+ky8VeJM=;
 b=f+VsRELr0ZvFb0jJpQug00YGHylIKPtuTrJSooqTsJuDpUyFMOQnQsu6G+eZLrj9YF
 tWkhThhqDzu0yOJz1brBzA1qz7zbCU/yX3kPjimY3f2DDFUvgQTqt++2WKP9OqKdIjJL
 +/PR/B4mj7yRaTwP+tVhP6WlqQpId6ZN5FADMQKyuv08DnhenOYSo5tc29iVPgf4pYqY
 4SdutE/0nbqQWvsz0bdqhbpz4wOxz3Y0Av1XehmQi+ioS8YBmwtKQafe1AeIQaMsuG7a
 I1NF6UwJdhfE43eYtxShlfIuarMSGms6MdNGWw/mLsZ4GuObQkMH9lAFQu3cX4CkSWyO
 HrDQ==
X-Gm-Message-State: AOJu0YxDJomB3om+9jau+vj57/ahUrNNYuUoYjShn2aWQ94pVLXhVAxx
 E4YEVvrXoddb5jXBG8QxMfbSjXpQGyKti17dGNf7kVaSpJwUzN4rHPv0rKZK6I4vznGCKrUGDP9
 E
X-Google-Smtp-Source: AGHT+IGoEMpY0ly+N/wT1Wyu5UNmV1ZPStf9LBXSmZ1zfttcixLWGjjJ1TpGkWsfPQaZqM3FKbuxpQ==
X-Received: by 2002:a05:600c:4fd3:b0:425:73c9:e60e with SMTP id
 5b1f17b1804b1-4264a429065mr39141385e9.25.1720198401943; 
 Fri, 05 Jul 2024 09:53:21 -0700 (PDT)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1d1692sm70231075e9.9.2024.07.05.09.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 09:53:21 -0700 (PDT)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Balaji Ravikumar <bravikumar@rivosinc.com>,
 Rob Bradford <rbradford@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG target)
Subject: [PATCH v2] disas/riscv: Add decode for Zawrs extension
Date: Fri,  5 Jul 2024 17:53:16 +0100
Message-ID: <20240705165316.127494-1-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=rbradford@rivosinc.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Balaji Ravikumar <bravikumar@rivosinc.com>

Add disassembly support for these instructions from Zawrs:

* wrs.sto
* wrs.nto

Signed-off-by: Balaji Ravikumar <bravikumar@rivosinc.com>
Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
---
 disas/riscv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index 05b663ebfe..ff0323f0dd 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -974,6 +974,8 @@ typedef enum {
     rv_op_amomaxu_h = 943,
     rv_op_amocas_b  = 944,
     rv_op_amocas_h  = 945,
+    rv_op_wrs_sto = 946,
+    rv_op_wrs_nto = 947,
 } rv_op;
 
 /* register names */
@@ -2232,6 +2234,8 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "amomaxu.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "amocas.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "amocas.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "wrs.sto", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "wrs.nto", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -4000,6 +4004,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     case 0: op = rv_op_ecall; break;
                     case 32: op = rv_op_ebreak; break;
                     case 64: op = rv_op_uret; break;
+                    case 416: op = rv_op_wrs_nto; break;
+                    case 928: op = rv_op_wrs_sto; break;
                     }
                     break;
                 case 256:
-- 
2.45.2


