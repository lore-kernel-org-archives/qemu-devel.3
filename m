Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7615BC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 09:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMPAA-00046p-Gl; Wed, 26 Jun 2024 05:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1sMPA8-00046E-Ns
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 05:42:00 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1sMPA7-0003j3-0a
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 05:42:00 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4255fc43f1cso1635505e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 02:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719394916; x=1719999716;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P8qYPYgonjwo1wpMx8C0ssT0R3HItE5CU4PlGsXXMOY=;
 b=BsZivs9hle7JUBJm50+doOfoyWd9EzphjH+Fbr1+vtnrmBWFKfTf2LBrf+NAVoo7e5
 DG0AUiq8A3JneplFjYMJZy0JSzP7PV2v9mZuQ/BULvyyE5UbXiEE7J4JLKY3qhoyAFaY
 kWPvHF6iMFdvKH5ZsprS5aQe7OpBvOVUTMK/HMlzCpcGyB4ryk1hdq0CogGl3/KI7SnX
 4pewjZmb3/834qWxUiyMzomS9a+ocpLlyNunoDbTfhl/NniCYVWWlWbTbLwDN2nl4CnR
 UKjFhoYsvhgQzknRoHnGPefNSYhy2DVhUGbSX/wfYZKI4DG02TTsy83pNTkxvuGXdMML
 mWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719394916; x=1719999716;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P8qYPYgonjwo1wpMx8C0ssT0R3HItE5CU4PlGsXXMOY=;
 b=u+qI4bx+H+ZDPzrZaisEXLFxLghqBSMxORNOxjAeBaJEJEpoT8zCDYG/Dyl5vmAIH9
 Acdm+yk2ALybiqnIFZ3pjnWtzvW/3o2MSAqbRlSlD5Da1cqBGDNpkc5YrmhCVcBVfRkP
 aTjjuWPrlLG16q45kunH9AmYdwf72eRVkdDNP03wHhDwzx4uEDcxqSDrNcJH9vNg+IRB
 Z5zTL8UFZRVG4SyxpvMVwqnl2y0uyizIfmQ74AioXOUY8KfTgsQ3SDHaU1sGGHE3xf3N
 pkboRr2Yptca8CO6hBagtbQoMFYttzzuFnHvIwOf5hLJOPC65IM0yyMO+Eo/LDkAIz1X
 GYLg==
X-Gm-Message-State: AOJu0YwFGZ5IlhK9iytCKTCU+7H8lwZSWDKLxMxMjyRH5lvqz6OGlEO5
 ODo0El/raC6LuaY/F+GS9Pd1/ZgsPGpW9ZyAQPuepEMP3M1RyXfT1zg//J7IICL9kEmomy7/w4F
 v42w=
X-Google-Smtp-Source: AGHT+IFaVsHtv2TTJ05s6O2Qc+z9kE7NWjbSKzQ+feh14fJNM+wFxYTLAJ/4yKShv5Pmif13VDZUTw==
X-Received: by 2002:a5d:47a8:0:b0:366:f64b:288 with SMTP id
 ffacd0b85a97d-366f64b03e2mr7339359f8f.29.1719394916470; 
 Wed, 26 Jun 2024 02:41:56 -0700 (PDT)
Received: from rockhopper.. (214.11.169.217.in-addr.arpa. [217.169.11.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36638e90cbesm15266645f8f.58.2024.06.26.02.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 02:41:56 -0700 (PDT)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Balaji Ravikumar <bravikumar@rivosinc.com>,
 Rob Bradford <rbradford@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG target)
Subject: [PATCH] disas/riscv: Add decode for Zawrs extension
Date: Wed, 26 Jun 2024 10:41:53 +0100
Message-ID: <20240626094153.27208-1-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=rbradford@rivosinc.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
index 90d6b26de9..e79788ea0a 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -906,6 +906,8 @@ typedef enum {
     rv_op_amocas_w = 875,
     rv_op_amocas_d = 876,
     rv_op_amocas_q = 877,
+    rv_op_wrs_sto = 878,
+    rv_op_wrs_nto = 879,
 } rv_op;
 
 /* register names */
@@ -2096,6 +2098,8 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "amocas.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "amocas.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "amocas.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "wrs.sto", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "wrs.nto", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -3817,6 +3821,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
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


