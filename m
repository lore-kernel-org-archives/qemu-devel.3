Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3340CC54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 17:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkpKS-0005Mo-2V; Thu, 14 Mar 2024 13:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkpKQ-0005MN-Ml
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 13:57:18 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkpKO-0005Uw-TZ
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 13:57:18 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dc3b4b9b62so8672225ad.1
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 10:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710439034; x=1711043834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RRHN55ULEkatQtFgjdidQ4nkmjY6fdcGFkhAKHEXGks=;
 b=cO2h65TsVybz7d8T6VFdMaVu3ekXUm+cpi9tD/RLLwlCFNxs6rxAzr5/DUoheK4W7/
 zm9nIxfhuTKmKAiHHppMUjlNNVhdz++YjUNjCFkf2OiFCmrbaWt8+eIq7R+GKCSr1nrc
 NGd6FB9l8cPJtznf5qdarctN8wa6QcJCi86EOMjkxzYauO9W5bkij2LSy2j4LsFPTpfe
 vEQUX68HLLx4odaLsnV5dDIOixj8A4rf36oGVS7Ft7syPiCJbRPJrU/i7LnkCxaaem+F
 DTCj5GwlF+znjCzl2KHSG2atOzqQXmsBlQBfv2hpD79KGVvj5TpbWKYkZeGJxyR9cSJG
 LH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710439034; x=1711043834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RRHN55ULEkatQtFgjdidQ4nkmjY6fdcGFkhAKHEXGks=;
 b=XfCb6cuz7dyciiu9ChUV2IFv9ZGLrRh0zuSuqR2vPoBK3Gzx1VXXNheVUDkKXt5Sr0
 T3el0aP0tdROAN7KSQOXuO/NRnJiLL1nEif8bDLGteg7sf5v783Wg/UnArMCt9+umgAk
 dcbwSFMjZug/K13jqNqIoDr0qvFJADg9cSKsw+EWbokN1eXs/exTPZiREy0PvFdpt7kx
 98g1n1mKp87q6yxIZEg4XZA5MzHixqjF2yTclcz/IY2iQBxq+d2GP7cuXQqXu43fSdFO
 vCu5KlUBl95yrU6I7WPzi9E13WiyPBR8N2lCR9Dw4EP+R9Mbz4JYLTk+lJEWHkvJ1Ohj
 OV/g==
X-Gm-Message-State: AOJu0YxYexYR2jufugaktcJMR7rd6h3eUP/l/a1UUmUiqlSpQKu2oHY6
 sgDYr8R0v6kYqiQHwVMJbkXbrgBbqcxmDcNy9J8I9wCl6pFggzaOZX3OjLAXn1kHFgjz2gPPqqa
 4
X-Google-Smtp-Source: AGHT+IFnT8palw9PPj8YM/8Pg2kwW+RjZ2CL2jRET6rYVq+KxkyUwLPWvKPKVuQlDt6ulebQmGaQ9w==
X-Received: by 2002:a17:903:41c7:b0:1dd:b2de:e0bf with SMTP id
 u7-20020a17090341c700b001ddb2dee0bfmr9379694ple.18.1710439034194; 
 Thu, 14 Mar 2024 10:57:14 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 i7-20020a170902c94700b001db717d2dbbsm1991776pla.210.2024.03.14.10.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 10:57:13 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com, richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for 9.0 v15 01/10] target/riscv/vector_helper.c: set vstart =
 0 in GEN_VEXT_VSLIDEUP_VX()
Date: Thu, 14 Mar 2024 14:56:55 -0300
Message-ID: <20240314175704.478276-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240314175704.478276-1-dbarboza@ventanamicro.com>
References: <20240314175704.478276-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The helper isn't setting env->vstart = 0 after its execution, as it is
expected from every vector instruction that completes successfully.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index fe56c007d5..ca79571ae2 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4781,6 +4781,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
     }                                                                     \
+    env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
     vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
 }
-- 
2.44.0


