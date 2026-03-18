Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38C410706E8
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2oCy-0002dM-P0; Wed, 18 Mar 2026 06:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oCZ-0001vB-03
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:32:36 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oCX-0002T7-At
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:32:34 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43b47b95a77so2232978f8f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773829950; x=1774434750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ReDHWdpP5TDEHnNFL6nm8aWwnpncRYGom7vG/728ciA=;
 b=VHwkCwPvuhOlO8sTDExHJgX3S2/kOM2PR4LTFo3754VyCdXz9Omi8ves6vdm98FkiN
 +pGHV7/zi4acxw5SB5J9D6hMmOGHPWog0Bg6A1Umwq6S//LFUS+JOgN+iaJCN7gK5B9t
 jGenZ8FKJEgm7Jok0oEkflJZiGPNhnpnvDIdGoaPeu086iGWIY8YDXmDlDVLRsRovOgP
 DUuZJbisGJYXjk94ErP/qN99zo90OoyWn51CM+99KwYEBvqrZSeHeJVBP6KHPnSIzdm5
 QiC02LYuzPG7kUoCCZv2ZJt7VQ90W9FLj1K53emPAjGSRyakrIXeh8vh+iksfxniMFsa
 IaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773829950; x=1774434750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ReDHWdpP5TDEHnNFL6nm8aWwnpncRYGom7vG/728ciA=;
 b=mbo0WDSRqfKA3Cu4RFdHxizFqKHSalTtHTXRXEdjB96tlP7fZT0BLjBdIDz89CvRPl
 3mO5PwLm8jDa4PED/cnYpCC4ZFq4+z/dW9P4kxVxG7lBK20suhlZTiBwvBkNSWVcToxc
 uERW/dbcOn2D/xK63m3HT8ASuuoQkz2NjWSbDxu5HBO6pSDQSv3izhXa6hcnUttR5zSe
 0LNP+2HVrgxVGaRUObyzUeNtTudvdtnXjlZXU5D/X/uuB/HgxTogUlGWscTGR+LVPT3p
 SMlTgwcXjjhuoOUXSU0+dM7U3cucHERbHIy86dat+1QxT9A8mX4nJkozon9gIHsW5rLA
 Fz4A==
X-Gm-Message-State: AOJu0YxhLoJ/gTH73A2KRv6nWL9fbfcoQKAWk5bjnSQD6/ffNG475QGM
 6Aec/+t+EmW0HAVjrFAIrP5tb4zrlWbLLj0bMNLf+BPADsTiBsZ4/G5C003F3qcJ37NNShpuLbW
 5llgQ3VQ=
X-Gm-Gg: ATEYQzy/fA0EKTs4iSSuPcg/qkpVP46MkT3Ym+53nZsRq618nvzUtcAlBhrevclhMzh
 3kTCfis8z4nwzzLA84z1JfHQ5VuhRFCW+gEKDs1DefvV0f80wStA78x6yuXDqV4etyTUwMmgVMq
 AfUo56LhLms4DbKC+Rd7au7MAklY7AwDkFMoN10/zFC8vIYeuD6bZbBRvgvQX/PSL/DwfDugGXs
 eQm4GzOC31oPENJFPchTpmQ5R7KXADRiv7Llbq5pfMt6/0OR0WDaITZxOlm7bnGdlP/Xf16bnh6
 Ti1GOWwjPoVVb0N4nnHMT0vdvLB0tKw2ktSClrXCxgTHUUtPpvEf2b+3dgcYcFyLTnPral3QoOn
 0HQJJmAiqxziw0Tqh5aWgvt2Ni1Ql14bWozjePhSSiK5/HP6aNc996unk5Q1xtnXhVeLSg7Cn/O
 U4hv5iacmrMZQVhiGUUbHMA+WPE6CCtOTWGEWG+c4ZQqFq5Iv6I8ToWH6+Bm/uPwJ/dJVdL6qM
X-Received: by 2002:a05:6000:381:b0:439:c4f9:31f5 with SMTP id
 ffacd0b85a97d-43b527c4033mr4621654f8f.28.1773829950415; 
 Wed, 18 Mar 2026 03:32:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51892244sm7053489f8f.22.2026.03.18.03.32.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Mar 2026 03:32:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH-for-11.1 09/16] target/riscv: Expose mo_endian_env()
Date: Wed, 18 Mar 2026 11:31:14 +0100
Message-ID: <20260318103122.97244-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318103122.97244-1-philmd@linaro.org>
References: <20260318103122.97244-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Move mo_endian_env() definition to "internals.h" for re-use.
Do not restrict to system emulation only because this will
also be used by user emulation code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/internals.h | 12 ++++++++++++
 target/riscv/op_helper.c | 14 --------------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 35b923c4bf5..860c47732b6 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -62,6 +62,18 @@ static inline bool mmuidx_2stage(int mmu_idx)
     return mmu_idx & MMU_2STAGE_BIT;
 }
 
+static inline MemOp mo_endian_env(CPURISCVState *env)
+{
+    /*
+     * A couple of bits in MSTATUS set the endianness:
+     *  - MSTATUS_UBE (User-mode),
+     *  - MSTATUS_SBE (Supervisor-mode),
+     *  - MSTATUS_MBE (Machine-mode)
+     * but we don't implement that yet.
+     */
+    return MO_TE;
+}
+
 /* share data between vector helpers and decode code */
 FIELD(VDATA, VM, 0, 1)
 FIELD(VDATA, LMUL, 1, 3)
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 6ccc127c304..dde40a55493 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -28,20 +28,6 @@
 #include "exec/tlb-flags.h"
 #include "trace.h"
 
-#ifndef CONFIG_USER_ONLY
-static inline MemOp mo_endian_env(CPURISCVState *env)
-{
-    /*
-     * A couple of bits in MSTATUS set the endianness:
-     *  - MSTATUS_UBE (User-mode),
-     *  - MSTATUS_SBE (Supervisor-mode),
-     *  - MSTATUS_MBE (Machine-mode)
-     * but we don't implement that yet.
-     */
-    return MO_TE;
-}
-#endif
-
 /* Exceptions processing helpers */
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
                                       RISCVException exception,
-- 
2.53.0


