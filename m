Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5960CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWMl-0000rB-F9; Thu, 15 Oct 2026 21:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWLb-0000HL-Bu
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:01 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWLZ-0004DE-3I
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:02:58 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2d71d1cc8b2so31956265ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112576; x=1792717376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HFyH+5DZTbPdi9UXaqYYCr1jsYDxpuhVYIku+Zw9p8c=;
 b=haFjWD18nrQdoYseLRbCyFXd6KsqwIirI1yev6/LSgQShczVNW2WBh0fT8ccwGfobM
 iIVIgXkmx/OkfnOAN9/bchrkNAzUZaetAMo5tV/2+Ef72REnu3sOnwg9dltQDzLwdEei
 ZF5vNkajV5B60BJ0xIQoXj91it8lqntEQM5m+wrXQIYVGdAlOSeMdn/1/im3w5sSw+ay
 hikn4Zq1/FaiWn14RW/yHR49kBZxqdZ1EAtjSYa1pCs45EFMoFk36L5Tpo7BhvShUtbP
 ayO2gvCY+EJ+9T33dbXrz6egUPLoYNHIdO+RCH0dHk6xLKaOVof3X8CFn4T0bYFLzfDH
 j7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112576; x=1792717376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HFyH+5DZTbPdi9UXaqYYCr1jsYDxpuhVYIku+Zw9p8c=;
 b=blZrdVDBZ2zu6Q8XssxUvtv1N7WJKKbbV+Kkrg/zCi6Bbdmj9J6JwjT6wR0NCxzd5S
 ZcmGdwMbogXfF0mhk/EGngsRsna7wjRIoysf/Q7YOK4BUY7/OdbkJNu+Z/rc+jRkKirk
 EjdJBbJ0vY/LmlmPGaRoIRdrci5zTsTcXEFELVZy4CpMbZ6+30FY7S130VnpiLoG8wBM
 mv3xuRa/7d/Ex699DqJQxg4bjU2AUbMwdkHBA267k14BTBsMojShAcA5pyke6B79ucMG
 zdQ6Ed7Fv3YBbp8dGNn/JPe4I1HIcyLKU9/WWv/PTjCvPf6I1tfi9UiHqXXgWfpDb+Vg
 uFWQ==
X-Gm-Message-State: AFq9FYJqaJN0GnjIV7aJrQtlvAaGvjWwqWzQtSbcGGbXwS3vib7tnSNX
 PrnNO/gGl/wBJ60vqvtI3e3oF9dft+kR/5t2CqiijUp1wt44Ml/aDrId7ASzWw==
X-Gm-Gg: AYBFou0LUASM4fbApIWS7WThKXzureR/JUN/HOyQ+hVLV7DFBYyXQ3PTjaUvdbhTkoT
 UcIRb22kbTVtblp/llFOsiTMrsMTRcY+put8limkh45RZS7cODwpJcAG11l2k+f4EX+l/2OxkGA
 DBwyVGx4yww+eF2y9BkEHksGYoiV5AiZGSo4I2SuxziNLxqlAtBvianuc/b6BmZCj0zReKLANVZ
 ox0+i/ikGfoRlXiVZhM9LbcfeAHXx1oQJWQnjr4S+1CcaxSUL/5UdvShuOXBAYzPLUFgMWwFBLm
 MQvHNIqenqijlZI+r47ylUbyRBk3NrwdbToeT43FK3IMuU8cbfI7MEfenwDcWwSdwTU8hM5MlSR
 R1j19xVnehDX+fl/m+BATmgzEfQGclzQ8gYUUHo45A9DWlU3e4gYgeZAVOPJqz//hZRKBiy9a4e
 hC1PCkfQFMk6s+oDp88vrWJ5w1A9J4mt107M4VC1i4u51BDctzlVKKMLdh4fp6Ke+DhoqNOxejo
 PaAGwafuaLHMPUw
X-Received: by 2002:a17:902:f790:b0:2e9:5507:b540 with SMTP id
 d9443c01a7336-2e95507b969mr45190295ad.45.1792112575571; 
 Thu, 15 Oct 2026 18:02:55 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:02:53 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 03/50] disas/riscv: Fix csrrs decode
Date: Fri, 16 Oct 2026 11:01:50 +1000
Message-ID: <20261016010237.1102834-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Resolves: Coverity CID 1685513
Fixes: 4fec981f18fd ("disas/riscv: Split rvi_opcode_data")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260914015316.792751-1-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index e85dbac035..ef8b7ff20f 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2560,7 +2560,6 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 }
                 break;
             case 2:
-                return &op_csrrs;
                 if (operand_rs1(inst) == 0) {
                     switch (operand_csr12(inst)) {
                     case 0x001: return &op_frflags;
@@ -2574,7 +2573,7 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     case 0xc82: return &op_rdinstreth;
                     }
                 }
-                break;
+                return &op_csrrs;
             case 3: return &op_csrrc;
             case 4:
                 if (dec->cfg && dec->cfg->ext_zimop) {
-- 
2.55.0


