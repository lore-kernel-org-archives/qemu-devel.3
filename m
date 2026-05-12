Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4310FCD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgWL-00017z-BS; Tue, 12 May 2026 02:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgWJ-00014e-Pj
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:23:08 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgWH-0004nq-Jt
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:23:07 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48e56c1bf5dso31029505e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778566982; x=1779171782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fG2F23ViZCDQaV13ekvtxg89EgiB1GeZgfbNuM5RSM4=;
 b=wlVLjQNGXt3a/KaIzo5unnWw615+lHR8Cf2B6z+qlJvXMoGb2tlH8SjzalP+s9A/5P
 6TjxxLevglvtPGNkMu+zPXqx/Q+hlOJVAMPZKc37mqyULuKddmeD2csCwNCnbO1Lf7Pp
 hd3wmjxBrpLa56snUq3vC7B4L2e0gnOgSFai+E7ZsYFnr4R0DZawWbFJ3ffqLFvy32oh
 shskQDSUCr2+QgUzrcX2fvrsCt/BMFEpQVF+gV4Eq+v+2qNWD61ibGVv4hNiS4NcxPTK
 aHFvlh77DRBhfiZXYwy44cOhM+Bet097tCAk+qBkMOMuiD4nSpuhmkMP0888gYJT2C/O
 8hzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778566982; x=1779171782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fG2F23ViZCDQaV13ekvtxg89EgiB1GeZgfbNuM5RSM4=;
 b=b2zwMU16GpJUsUuELl6jb4gAOka2uevo5iozKh9lUfUsQoCmzdMAtcUEWQvd6rVJlQ
 mc+mKnKNGV+x5+QKcV7Vj8XJb6I74RddHFc0oV5B+t61PMC82iBxPpzE8ghJvcfsMHsy
 4LoOJI32pQgwL/9e0RY0dW8T1pNDVO43aNuvbrMDKCT0CAyF+qbIs5NPh5nBTc9KoV8m
 hl7efH+jeqFnychdj3be/p/0oJwloRtXvD3FP9ACbY5Mk1iXo5MY3mgSPl1rXg/DMMg0
 92AsjwyOyhFJGZrQRmukumG3tn/EzvSBZ2dvTPYA8o1/MirSQ3m/IJNrQbXNCFeqOgMu
 P/bg==
X-Gm-Message-State: AOJu0YwST/tQ7z5B8IQi/9+fBcvfeUlsYmcllzR4Vo2LvI2hTXM0/CXa
 /uP/tHPj/OLgqQHudHhjihL9NKoPkLD2/UD4sQhHr6jRs/1V43h0KGSq3fs5gTEy4L7FKIQDRSy
 bsB9kXt4=
X-Gm-Gg: Acq92OH6f8oCn0vDYNsNaP5UjZCJALaCJ/oIqREcC4+j2DAEu0dUXTgRBiiGmW56da3
 zzFvgueJKKuGusYVDdZVNVyPOhz0u99AdezAWtQ9+6pIzyBR/yqlZaFOQLrjzsdQFifFrEEfnOi
 QSWEy/GVuhzpLEla9rEAaZfvmr14EN3ER4W+9SX9TvbN9dNBiVWFBckGABuVgQ/NiJNkplGrY6l
 iFs+tG8Nr7+B3fZOLGZ/9FkC78f5G5jhpC0crPnACseWPJzWKyq2PJOUDqJet8/kG4WzUp1gouh
 fSDHAZeha8elLK7S4qEA1ZI7DlPU2kw6r4rMpTkr0Un2HVQZyEHOAMqDFSqqvef/73BYcF91466
 IwEes9xR7Qf+sPrp7GJMXp+gzvEdgmb8zvYzAhu/Iuie77Tzv2Jdi0I00N5/Bcwq3cB54jkcpYz
 4J2/lKgszdoyhlm4aDbocVv2s84z+IItyeP1OBLxaRP6oIPlwxY6Zkq6OMKfRG4ZGNgw6WRl0+E
 u5KsK4x6ro=
X-Received: by 2002:a05:600c:4fc4:b0:48a:5342:36b5 with SMTP id
 5b1f17b1804b1-48e706c48d5mr191982315e9.21.1778566982240; 
 Mon, 11 May 2026 23:23:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e4bb87bsm29283576f8f.2.2026.05.11.23.23.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:23:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/41] target/riscv: Make get_phys_page_debug handle
 non-page-aligned addrs
Date: Tue, 12 May 2026 08:21:12 +0200
Message-ID: <20260512062142.67998-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Currently our implementations of SysemuCPUOps::get_phys_page_debug
and SysemuCPUOps::get_phys_page_attrs_debug are a mix of "accepts a
non-page-aligned virtual address and returns the corresponding
non-page-aligned physical address" and "only returns a page-aligned
physical address".  This is awkward for callsites, which in practice
all want the physical address for an arbitrary virtual address and
have to work around the possibility of getting a page-aligned
address, and it doesn't account for protection being possibly on a
sub-page-sized granularity.  We want to standardize on the
implementation having to handle non-page-aligned addresses.

The only thing in the riscv implementation that we need to fix
is the place where we explicitly round the return value down to
a page boundary before returning it. Drop that.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260417173105.1648172-2-peter.maydell@linaro.org
Message-ID: <20260430093810.2762539-3-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 39c3486ae0f..f786b1ebcd3 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1730,7 +1730,7 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
         }
     }
 
-    return phys_addr & TARGET_PAGE_MASK;
+    return phys_addr;
 }
 
 void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
-- 
2.53.0


