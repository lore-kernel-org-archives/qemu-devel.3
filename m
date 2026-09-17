Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA83C982CF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 13:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7CJj-0003CS-Td; Thu, 17 Sep 2026 09:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x7CJT-0003BU-HG
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 09:38:10 -0400
Received: from mail-pj2-x24.google.com ([2607:f8b0:4864:39::24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x7CJR-00044Z-IO
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 09:38:07 -0400
Received: by mail-pj2-x24.google.com with SMTP id
 d9443c01a7336-2d747f05ffdso6705165ad.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 06:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1789652283; x=1790257083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zwzFyyvJC39ZPVbt9izsra+Ht73D68ICAZtqoph7Sq0=;
 b=SIzxwZERFxmgivJ11h0m/bsIfTUTjICy6bSxb8xklwDbPUW26qe1ddr/FDaa69srMf
 Y1l1EDJDKZo0UjDUWxSUup9AiZMnx1VeSkZ5ZOzx7LznK5nX5f9rj9NYCVLmkrhJZWbi
 w4fw29gB0YRx40cypN0N2EwoNQyl/Q9+vZkDdUVmzFYIFDWCl8/3M1a/xxx/LViGVnB2
 DuV9OQ3F2el62k0+p6xfbW1f1JMPPXDgOc/TdPs24D6H5JZ02ETKdZe2KVZ48SqRBX5Q
 zDeiYgHq9mZEOEbPQzJ5x/c8pZRiF85hiAm8G1g9ep1bOX5B4bT4WTebnM48h++1U1tY
 cBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789652283; x=1790257083;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zwzFyyvJC39ZPVbt9izsra+Ht73D68ICAZtqoph7Sq0=;
 b=z37UA76+DvZPDKFLn9nCfe0ww+7QUg/7wYSoccKD+X2GOTinesWLLBPFg8z29DB6Ro
 08reyyBOl668J7hJ1uI/D3dkmzWruv5fWW63AWjAVhkkVbWTGl7XVSddojBO1svryI7y
 jTlYUIQO5liXoB4d5OvOnzY7gh9R5Mm6V6J3Ma7y7+ap0z3lk6VwlT1oRNmJvpckeDmc
 rtx7N89NyLvcvfF6l6eOdI4i1WcE80tkYnz1xvT0Z98UGl6p9Q6FXPgs34OvmBjBomWx
 MeDP4DyPP68yvcNTeHWlAyniEy7leDUcPe6dPfulJcBdd6Egm4APW4V7pCg85paj1iXr
 loNg==
X-Gm-Message-State: AFuF++nDmhw3V8SmlJ5onSbJu0SY6whBE+lJ5SsNL63BYlyzOOyn7hgG
 /q5dYpc3Wg2EhL+hqMF3VNvRb+6WKuAG8hl6FT0lJqfm9N+fqIbDTr8ZOa3QHU0awjx/Pch2ZVh
 0A8AIyvH+NL+dGaz42l/3gtjbtaBaqwe4VYmPZZ6ZLbNRiMHDmZQcwPQpmrUY5a5yEVs4If4Atr
 twraB4F5F4U3iSyvldXbQ2zXP3YaIm80Gfw0tUwkE=
X-Gm-Gg: AYBFou133jfQMoX/+MWKbg3cQ8YlgojTiEw8/dnL6YQc0Hvkw8UGIy+0FGQBiaRlXjB
 GUIQxy3YDM8ZTc/PEQ+WLZB3F8EeqZHIegt5O5kgYE3ZbJztxOVczByhT06R3Oly2hIWRHW9VL+
 NiWuDNlugUo8lRPoUIvhky/8Lvqk3iFCVqOTPQ05LjzawKPBijHjQlmkeYZRkUgdBNGcrn+aiqv
 HupltxhuRUvUKgxSVJOLo+NMEJacFx3KdWpy99M5qTC+gZtWiDS0oVU+P0xsYEAp6MH0Dpc9IkU
 9A1/oQ7qnu7KbmdVAu2wpAUeBVcG74p7qv+xoQ7cGhIdx/02LblWzO8GQCWflt8fwT3e4k2QLGI
 7cJcszTyGvQdu3R0/ppBaOWTFv96pBm8WJti4fz7fC2uVKEIY+YwUo87iREc80dyi2iLpHx6JDU
 4dZytidPTIKNZZLOK7Egv9FH6PNMJDIqncEvQrt8S4fm/beDmNg8dxGRRqOO076GNtYaJFO3qqD
 O7RuLSwtkKKgaiSFQM56cf60H+QVUMx01Qr8wMd64PCSX37ZvgmPgi8LG63aHOmviANoTL9G7Vj
 xucDQRq5
X-Received: by 2002:a17:902:da47:b0:2dd:40cb:a054 with SMTP id
 d9443c01a7336-2dd8e73f743mr145968945ad.19.1789652283172; 
 Thu, 17 Sep 2026 06:38:03 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89ebe71bsm26539585ad.40.2026.09.17.06.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 06:38:02 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Max Chou <max.chou@sifive.com>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH v2] tcg/riscv64: Set vtype before whole-register vector moves
Date: Thu, 17 Sep 2026 21:37:55 +0800
Message-ID: <20260917133755.1049697-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::24;
 envelope-from=max.chou@sifive.com; helo=mail-pj2-x24.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

According to the RISC-V unpriviledge spec,
  "vset{i}vl{i} and whole register loads and stores do not depend upon
   vtype."
The whole-register vector move instructions reuqire legal vtype that
trap when VILL is set.

The tcg_out_mov in tcg/riscv64 missed the vtype setup before emitting the
OPC_VMVNR_V.

Fixes: d4be6ee1111 ("tcg/riscv: Implement vector mov/dup{m/i}")
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 tcg/riscv64/tcg-target.c.inc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 2ce9d47a633..e3cfedb579d 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -778,6 +778,10 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
         {
             int lmul = type - riscv_lg2_vlenb;
             int nf = 1 << MAX(lmul, 0);
+
+            if (s->riscv_cur_type == TCG_TYPE_COUNT) {
+                set_vtype_len(s, type);
+            }
             tcg_out_opc_vi(s, OPC_VMVNR_V, ret, arg, nf - 1);
         }
         break;
-- 
2.43.0


