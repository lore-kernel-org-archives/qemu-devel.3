Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A622C02185
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJtM-0005hz-5k; Sat, 18 Jan 2025 20:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJtJ-0005XX-2G
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:17 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJtF-0003KR-DN
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:16 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ee9a780de4so4366030a91.3
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249252; x=1737854052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NdLEaQfdnKEQEDdTsYjN/zThxqSlLF48asIv/trDC5U=;
 b=fy2Id470hVPQ19pNDsM9IWI4J1eKWLimkX3jPLNuLHbNPcqI4AqD3QjGG980t9ib2d
 TRkDV2eqIcu6yzlKfiSQ8mDyd9rMZkzsDty7UMosm/HL27pMIblgVJunyNeda1U/kepW
 rf0FjHyzbgtLM2bULCHfX7Cjp723bovRzlMOKJmKdumOKSG4j6HePrSAZtEwFEyTyqNt
 F9ryAz+IDIUZ+R0QtBSDEeKlnQVn2dbPja5UHt5jRtduCDsuCWGX1aZpUP4otwvI1eHZ
 SznN6dpxn7wrP0ajlMEbWzSR5ep6XjuGbjxM6VfMciVpTqphG0KsKOqLJtwcGyRpc8A7
 2pSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249252; x=1737854052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NdLEaQfdnKEQEDdTsYjN/zThxqSlLF48asIv/trDC5U=;
 b=j9SQWy7TKVX3nnW0lH9+xVJbVL/1XjtjdBMkV8YJ03wB2u2zRw0OpLWeNnFx0EMkHe
 CyXN38LKeQ7/0f8W+EXc/7O/iWBiF7h9ko3IDKn0BHpCV0htCXk2tuYoHluJKJaLgwAi
 MxHVla4fOPZvky7yiZ3XInxHCGAG/7RTOqJLOlpJjxrSH/3VEGkpLnm1Gq2203UAMMqb
 Rmwlmp82Cc09bMS1U1CrRTvH5cnTAwjzmmQamNDnASHVdHvK3/o5tTgtzHOxH7NXstAQ
 S2E5tfcy0RgJ5D5vSEJpBNHOqqhSNc1q6gbXN8NaxRgAZ7GTvszdr9XyZkI+cVL9KzwJ
 XrRA==
X-Gm-Message-State: AOJu0YzMobIm0iXGEf1/dLl8AoStsK+puLfdRc/dHuMGe7wQBYJ0GmqT
 buCrAs1NB/7n73HLNmgwq4oFuoPmfWIcWP1kAiYKX4yUZ/hZNtMtvBdRq+mB
X-Gm-Gg: ASbGncsXbEFeEXQ0lbQBD9bL8bQ9zQ8b4RlcmQbMzXsOMjDscXqFmIvbX+B781z3F+l
 dw1E7HlwkU+apmoujZ2rhT0HesK2izg11uOARmWfp/vmFtLy2wbtFAZNjGsxf3br6ZCBVlurgN0
 CXOvz+zKoaw+tFokbjS/pdYa7JyIu14ki1prtO/VI4BJlzcI/ET1iGx6rj1WP/K5Vht3dovfdaN
 RLp3HJhrngqi14dmn/LoqJk6wIaV2e1JnF+Tv7JhlKEWmAi5bScR0b4YCl3mcG20syKqnkRAaLu
 pX9MPayjxKu5NHLvN2EuEY6V8W4HKQsN3pvCzskF860edkaqG7AVLMy3m/e4FN4zkfl2If+Jow=
 =
X-Google-Smtp-Source: AGHT+IEWpacPsKaadIgjRuh4J84ePW6xg7qrmEo6HagbmOpRRFBHbIVc6mF5WFZD+X6XqFp2nGJA+w==
X-Received: by 2002:a17:90a:c883:b0:2ee:b2be:f390 with SMTP id
 98e67ed59e1d1-2f782d37d55mr11524979a91.28.1737249251797; 
 Sat, 18 Jan 2025 17:14:11 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:14:11 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 27/50] hw/riscv/virt: Remove unnecessary use of &first_cpu
Date: Sun, 19 Jan 2025 11:12:02 +1000
Message-ID: <20250119011225.11452-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102a.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

virt_machine_init() creates the HARTs vCPUs, then later
virt_machine_done() calls create_fdt_sockets(), so the
latter has access to the first vCPU via:

  RISCVVirtState {
    RISCVHartArrayState {
      RISCVCPU *harts;
      ...

    } soc[VIRT_SOCKETS_MAX];
    ...

  } s;

Directly use that instead of the &first_cpu global.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250112231344.34632-3-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 9e8876be29..241389d72f 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -750,7 +750,7 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
     qemu_fdt_add_subnode(ms->fdt, "/cpus");
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
                           kvm_enabled() ?
-                          kvm_riscv_get_timebase_frequency(RISCV_CPU(first_cpu)) :
+                          kvm_riscv_get_timebase_frequency(&s->soc->harts[0]) :
                           RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", 0x1);
-- 
2.48.1


