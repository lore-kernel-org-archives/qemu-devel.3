Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E172FE5202
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGDll-0005PU-Am; Fri, 24 Apr 2026 06:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wGDlj-0005Od-3b
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:28:19 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wGDlh-0006Qq-L7
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:28:18 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c70ea5e9e9dso3371375a12.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 03:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777026496; x=1777631296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hfYiP5dksUUHNGg1Q2tKEehZ8qQGjLLlEBFXz7KBkHU=;
 b=DLVUqbnh5F9Erwf2PMASx6cWT9Io+22Toy6I8i01fKPdb1YzkOey7NzJA6x9AB8WQ/
 YQqTTckxhGXEzq68rCXPp3DARD3MWcuV20oM/S/35pwEC6IcAEFjgroXD3iXf9cQliJr
 ypiwjOvXxY66CJzJ1emeO5UXwIjmd0KmdU2LF5cAArkwZkeC56WDUDIRfRoOhsng8Veu
 iFN6CMa7MlDF23VsrYXWbDB19HjgjM9TMxEa0XUHCsEEk7OxNhvQ4SMecEYZn7ySDl05
 kpSp2h7pG3jkfNwpQLXYYIbAccYE6yv4SeRMkP+m1bPj54Nds5qF5uwkT50dEQtgnMll
 UJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777026496; x=1777631296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hfYiP5dksUUHNGg1Q2tKEehZ8qQGjLLlEBFXz7KBkHU=;
 b=K9c1wgb3wFpeJBwS/fBSa3PCTuLkLtFJnuFm58fGmz9+Dzon+zGsIDeMMkmHmp2tsb
 3MK0bmPwvEa8Bw65WEwTl+Les+bX4y+k8iUz9GYX+r7kQeJEYR86o6ZKf3Do6a7nemFA
 /vF+i9G+L9hJ63atojc5Pq2W44yzAGRqgYIwmB5x/+r70hVWv44wBu38vvniI+TdvsRx
 kjnCr48RIkRsIJpxOJem7sqYPJxdxVZkA73D0b8yhKBQdDoaykS0+jDSQjDQoqfJHKI0
 Yr7JeLYGuL1RCjMrM2XCvAiNQueW6UUXG7pF8zdFLSpZtQZ+9pEiCGsF3um6B5mNxpkj
 ro/A==
X-Gm-Message-State: AOJu0YyZQOG+Jt0Nu6db/4GK75OEG5tIHWvcfAieYt9zJG+Jfv3K1yue
 yX/VCwozrp2dLKiD6TtWenQcWDxtaPh9l5K9NMlT40qDdBWXtdmoeWhVg9kJhz7AMIRN+c16+OR
 eXL7OKqNU9WL0yyFxqjxAG56yl/Zk1Fxm8c1IXRDbUvm8kd6fv74cdDGmDeFiAS2IocS7i5H/2C
 fxjparPfJm4Ksz54+Il+HyO4TAvMDbrxFOx/J8+xn02ZQ6YQk2
X-Gm-Gg: AeBDietaoO+645XPwj0q2wE5MS5F8qrhPvKnFNIcmvasbcfpt9hlhH5fmS2aLPHP5tO
 dQk6kYsOD9nMDi1mlYfH1WikRzEqB4MUFl7tFaKPvHsKqx3keL7DxlOPRAutUni5i1XYEiAQ/2O
 HXhp6nh8E0+mK2ZHqHhZV4DL66BQbOhpjPEUZrbwfbYyhW0kuSS8MC0EpKKdTTmNUBatLigAGBB
 d7Bb5UNFvYslvzdRbKGYojDas3InTrRpr4XBujBIl6vRxFFuA363M2TrROAgp51ZN7HXcCaxgOu
 3SGkCEtiCQuOJJhQHmUla7avRev8R7QFaromKi+mn3Q+sTyKF7P4spZM4odDd8WK8ci5ru7CEaA
 VDBk28Itd8ySsWS4h+5UwUN+i6fmJ8YyPURpqxAe5Jhu7pvhpfWTzuPT9rrvhPziyAsoqSIw2ZM
 C5IS/HxeZiCBKRq9awEYGWdqiGrhlwVKsKC0OVJsjX4IyGDoHMZrMCMskbZ4y2
X-Received: by 2002:a17:903:2acb:b0:2ae:450c:951e with SMTP id
 d9443c01a7336-2b5f9f08968mr332418265ad.17.1777026495758; 
 Fri, 24 Apr 2026 03:28:15 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0c17esm218889585ad.41.2026.04.24.03.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 03:28:15 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH 4/4] target/riscv: Expose Zicclsm extension as a CPU property
Date: Fri, 24 Apr 2026 18:28:00 +0800
Message-ID: <20260424102800.24022-5-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424102800.24022-1-frank.chang@sifive.com>
References: <20260424102800.24022-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x530.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Expose Zicclsm extension as a CPU property to allow user to turn on/off
Zicclsm extension.

Zicclsm is set to true by default to be backward compatible with the old
RISC-V QEMU design.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index df56b64a736..7f5e06ef83d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1327,6 +1327,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zicbop", ext_zicbop, true),
     MULTI_EXT_CFG_BOOL("zicboz", ext_zicboz, true),
 
+    MULTI_EXT_CFG_BOOL("zicclsm", ext_zicclsm, true),
+
     MULTI_EXT_CFG_BOOL("zmmul", ext_zmmul, false),
 
     MULTI_EXT_CFG_BOOL("zca", ext_zca, false),
-- 
2.43.0


