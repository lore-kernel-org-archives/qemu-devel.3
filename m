Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD892C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 17:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2AnY-0000PW-By; Thu, 03 Sep 2026 13:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x2AnX-0000Oz-7T
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 13:00:23 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x2AnV-0002R3-33
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 13:00:22 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-39647aa9d52so76160a91.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1788454819; x=1789059619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xMzA1Edr4/9AcwAAKxC0Ug+VONOQc457rjo8K3c+xXg=;
 b=N9t7JbtgbQS2qGUZ6v2wjJAILQK2STI1QtMCRB233DpKnxF3fZDQ+WXbQGtKJ41mB9
 3v/s2pDzL6ptIJ+7Oeri5eXlHAwv/uuFQpEpXzw8ZAb/AplUXg988IYQnUGPsSUrezH1
 RgaFvIfS5+E0mUKNUY8nYo9PIipUYx73BYJt+iKSjXPXT5cOmXhfFrsNYcRGK8Pq0HMU
 PeDBIVc0h9vOoPkiuWCsnYnNmpkcmH6cc6RLwMf2sCWBhqRcQsvoNnO4gIz7/ebw5FaY
 1MPfqifyEw/f1LJTdS607nsWsa6SwmGLHi4vL61RVGp4fgtjepVepf9vKSb85v5NNx7M
 /Kyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788454819; x=1789059619;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xMzA1Edr4/9AcwAAKxC0Ug+VONOQc457rjo8K3c+xXg=;
 b=sKrXRvJcLmHGc4KjCof0ulxEcmKe8H49/PzOlYmMpc51cEd2XgvEtZD4gQPnmkR1mv
 +zZLT9UewdxHT3q9vkQAFupnm9wMs6+5DsJxzPTgNtrpHIBtRt4xx8NfYwcK+1BDFPDC
 P62Oam+LJ9f8LTJ2+x7JYLBZjxw4jbDfUjeqvvSOKJaIX4HWNGdxiN+XmJs4EjTkhHJ3
 /taatq+orCcpVBWWLwoXNSA62raYt84PYA27q0zuWanAybsFhZaWuEFYPtCYSUmUX4Ml
 C8OCoqK+CcPps50DlX6KHhKVbVrSQLHl8SihRe6COTke1Akx73SbtB8dxvMKLr5V4pZg
 mS2w==
X-Gm-Message-State: AFuF++lJebpYMmBEfwpslGWkh7NuLERNWCOLjEE0e4ZycHBUItLCjY4g
 4S6vLaYq5WBAJHtKtDAOYgsBfaLpZZoWwtbJLnbBQU2NK9rGbSeuuZouvO/zT1Ii1kPaezHwaCn
 MTqP1JUpEKaNs8lZYnrZemyKb+JNjmYSuPfmjkRGEpf9kjXuXeuxabTsi3AXei4QewuxgDzTAsH
 qpPmIkRq5lBqOF3yJLv0pdWe9orueTtH0k19ddrfEkUA==
X-Gm-Gg: AYBFou2Fi0nNJ5gMU9eBdh5R7myWuea2XxnRcw24lHhzUDnbGyiWpjhN7RcOpzK40om
 ZWz6+Er2WfoPWSX4AI5zqFt6ShUhr0gJt3f8LT9aJRHG0CYi+22/oFn5kR7xFCUwmfR6Eu60ssh
 QlyrPFw3Njbd7acXC6DZPdZmRBBDz2HatJwJ93uBnZ3OSdq5oufJdq9t8UGB+URxUo78vRtAvYC
 HfMPhC4MUx+LsZ7St32FUULxKPwrzY44POJ9VeFfA0HMn8/U+RjJzMitGGQYHLWTls0j0TsuMhZ
 8SzaVyyCeijQjilADxjpvopGr8s5Dg19dPCMZM2wHGGhbN91rOVshw/cXSse13oGP8RnsIRBsY3
 p4O58KF+fvyPsKbOKbCImNHj42TvbwuXK+9JQ2E+xGQ8fRdD/3WizDxqLg9rFyn/V/w8veLcT9+
 KmMx9wrdoiZo2qPw6N2mwr3uhQ1sMT6b2t0BJowSv0ZDI+RHjMeQeBbxKlnMyXLyyjfNJFqrspQ
 f5JCgP2L+VyY/1spwc93IhtObU6CWd7rVvT53P5rRYzSNc5jTsdTu6MpckptA4=
X-Received: by 2002:a17:90a:c106:b0:398:9bd3:d6d6 with SMTP id
 98e67ed59e1d1-39b13324513mr3809123a91.16.1788454817550; 
 Thu, 03 Sep 2026 10:00:17 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b087b59a0sm6592159a91.17.2026.09.03.10.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 10:00:17 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH] tcg/riscv64: Set vtype before whole-register vector moves
Date: Fri,  4 Sep 2026 01:00:11 +0800
Message-ID: <20260903170011.3627720-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

According to the RISC-V unpriviledge spec,
  "vset{i}vl{i} and whole register loads and stores do not depend upon
   vtype."
The whole-register vector move instructions reuqire legal vtype that
trap when VILL is set.

The tcg_out_mov in tcg/riscv64 missed the vtype setup before emitting the
OPC_VMVNR_V.

Fixes: d4be6ee1111 ("tcg/riscv: Implement vector mov/dup{m/i}")
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 tcg/riscv64/tcg-target.c.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 2ce9d47a633..fbfb4c44470 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -778,6 +778,8 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
         {
             int lmul = type - riscv_lg2_vlenb;
             int nf = 1 << MAX(lmul, 0);
+
+            set_vtype_len(s, type);
             tcg_out_opc_vi(s, OPC_VMVNR_V, ret, arg, nf - 1);
         }
         break;
-- 
2.43.0


