Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCC3C5DF98
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNar-0004X7-S7; Mon, 24 Aug 2026 01:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNa7-0003oj-5F
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:52 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNa5-0002Wc-JS
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:50 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2d01663d816so24337225ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550648; x=1788155448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y3jYg6CN2EN6XbjmWcdyGyDrijaVSsDsBzbN2Vh61c0=;
 b=Spp+XgfBsz170yt1HAV+2o7vfQg/rYQhY3vKrtCEetPDWTw5l6x2+efqy5DrKnfUJo
 /X3uznRigwfBEG9ERgT22j4CiwFnxzrLWoztTPmPPtr2in9hunJGI0lH5CTETdDDt8u/
 jI4XqXbv3KUlUNlST838aB1TtSRBBPY/bDRakLP3RPPEpUzX4r82sibnZ/nTyypTBjBa
 cY1RSZvwxTB8wOESDQLxSMoU6ouUr/rvQX5uNosItipJWmHYErIzZFr3xH92+roG7m/6
 dAKud9qKhyTd2TdEH4u0Uph+0hTLO8mjKE/dOaxkFzI0s6KuN2LgozNoD6MsBtz2QziY
 gBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550648; x=1788155448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y3jYg6CN2EN6XbjmWcdyGyDrijaVSsDsBzbN2Vh61c0=;
 b=ne3VXyeNhBKeJtSj7ax+O2B/+KRSLZmEjHxygoF0PFB1Yc8FEJIDAGp5G8DsvqPTNp
 1FAcQN+atbSFGXpfwr5OxveLgC5iEF++C3HdUo0px1bjYNG37zDYQFLyysgukyEBuojl
 aNxiYOXXqr7qB96vRebKmMML/4h50GveSroy33Vhpl3MM1SQYlbK26sLfc8Z+/y8jj3s
 6tKeL5Ez75XDy3a45rzca0UXl4w5wu4qVIkFIpccEKgveBNo8+Jw00d9v36i1t6Te8Fd
 8XiYMPwXWPIQ+0si91c1ehebljLIQlxNyzJj5XHwi+eyjWWC/lgbvgZriT0ddkJaRTuW
 WQgQ==
X-Gm-Message-State: AFuF++kTmaZsGoEKukjIPjdJxz/ivRuQO4LJGEjCDVZ7thy9LCCfEyZ9
 E8xZ3lPa8tcYBgjFMWm8qgFVzyCgHPHOj1yWILB0/DQHKDF34jdKS9jK69CS+w==
X-Gm-Gg: AR+sD10y9ioMtyeNd45YBWniGb4mj2BoQJu/ll7zDxoWgPSsRJ+G5wLPghkKShG6d0V
 dSAps8LEmyMtvu1h/LMzLJ5GcMUwd+oqwUNtVbWVLunck4ugaR5VqkdbZ+JaYrqRF0bX5x/geAa
 xfHmEdUMi4Ps3EwLKgqVCh/zh0jFiHxtEV++Rb8GOBpNTUAebyA7pL/jJtTKMxX121r3KOfPlom
 yaYA/I4hKi9a/FeFkZ9sNi2KToz3Re5FW/I8Mnl12gar1Ro+rivyR2hpWqkiMzyuIdL5wMvB1T2
 1JEw8HESmwGXvGr8h1P8wbFCnKPMgXtEW9XCGN3qOvw4VmwnJ2oVu1MeSFim+sBd9X3T+Btiyba
 FQL8tNJqZw1FLxK+D0YmcA86LP6ftdqZUI6h6ILcz9yMc8xV7s+KqHk2Dz+a60pcw2cF6UXmn8y
 RmQn8kKAncOdaBXvMjuwODl4Eh7QjCqNRToHC2y+2aQLZxHvZJSWHcRGw94T1c5UN53Vh8a2Wqi
 93XWw==
X-Received: by 2002:a17:90b:3902:b0:38f:240d:b857 with SMTP id
 98e67ed59e1d1-395c3377f59mr36448181a91.2.1787550648267; 
 Sun, 23 Aug 2026 22:50:48 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:50:47 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 48/96] disas/riscv: Handle c.lui imm != 0 during decode
Date: Mon, 24 Aug 2026 15:47:18 +1000
Message-ID: <20260824054806.2790041-49-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-16-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 7978ffb378..d6fbb3bca6 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1902,9 +1902,9 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "c.li", rv_codec_ci_li, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi,
       rv_op_addi },
     { "c.addi16sp", rv_codec_ci_16sp, rv_fmt_rd_rs1_imm, NULL, rv_op_addi,
-      rv_op_addi, rv_op_addi, rvcd_imm_nz },
+      rv_op_addi, rv_op_addi },
     { "c.lui", rv_codec_ci_lui, rv_fmt_rd_uimm, NULL, rv_op_lui, rv_op_lui,
-      rv_op_lui, rvcd_imm_nz },
+      rv_op_lui },
     { "c.srli", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srli,
       rv_op_srli, rv_op_srli, rvcd_imm_nz },
     { "c.srai", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srai,
@@ -3032,9 +3032,11 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     break;
                 }
             }
-            switch ((inst >> 7) & 0b11111) {
-            case 2: op = rv_op_c_addi16sp; break;
-            default: op = rv_op_c_lui; break;
+            if (inst & ((1 << 12) | (0x1f << 2))) {
+                switch ((inst >> 7) & 0b11111) {
+                case 2: op = rv_op_c_addi16sp; break;
+                default: op = rv_op_c_lui; break;
+                }
             }
             break;
         case 4:
-- 
2.54.0


