Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74EDC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 21:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1YaR-00073f-UE; Mon, 29 Apr 2024 17:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1YaP-00072y-EB
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:30:57 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1YaN-0003GY-34
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:30:57 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-34d7b0dac54so55489f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 14:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714426253; x=1715031053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FEPdW/cQwaGmjJpToMWNRsEfe9Fg4JUc+PIbVk1G56M=;
 b=UiGQLlpm4iG/oWvlM8DLSbWj3+WQpXf9Uf4NAOpFnUMi8AKVNxw3RaqpgryQnuiBpN
 CQWmVQOhESmHWKASsomLte8RFLp1QlaGFHpv0uRUsQ8mGfGDrKaNHPnMg9IgCKWe3VEz
 0x78BwPWu8chPguvtdn5LgavCqEkymC8cJ2NdrTI6C8F1Ivwnrmv/mV8O98DFXd87YM6
 dRHvIhhwFsYqw53Ol3n4ge0pHxR4LPeeJGzd1bgGgGLJjOPR9hvYct9qvCOfzG+10PX7
 mcTCKU1y20/qoxA/03qC7Juu2s2r16G/MYEgYoY205rAwRu/l1c6EgzTUkBxEj3kklaf
 Mekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714426253; x=1715031053;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FEPdW/cQwaGmjJpToMWNRsEfe9Fg4JUc+PIbVk1G56M=;
 b=Dp/o3I3+w1RetEO8lAXuq/q6SjHr+xPdvvYkv4VV0I+VXWrLDOUMA2euFlrl7R6TTN
 HFJz3Rp/lEWuXAPo8qMWcwrUagmtx80iYFqG8A3U4EKgpg8QflSsOU45BP0ns5lgp+t+
 M6hJUxyGUbGbv5O2gBMXVpGy2VkiLGJyRKTDg3KTj8b8Ariu4oq6xmM8GIu/N1Pgc+ue
 glzm8Ekw7SNADKjrA59Sd4Td+0tczcY5uVWJAHYx9lpWtMbUXPwQkvZ0d4aD+Egstcxn
 /Wq6zLLHx5eChbhM8IDNHOsiWiC0R0763u3OXV4aRYmk1eIWz2VKdeaDLyvTjoPxyf5q
 IQqA==
X-Gm-Message-State: AOJu0YxQY8latI4MD9eGYZQyKMoWDEz27Ol5tg4WWzU+SCqYrjMu1f8F
 xS3PwfToizNTQ3qw5bqvPawXJROeHpB/k87c+6bQQgabT9TFEYc6uXIXmG+NwR1fX5gv1yTPZXd
 DrPU=
X-Google-Smtp-Source: AGHT+IEk6hZCz3iSS2jlxXveSr21LlHVyX24d7Y29ps9gJu0P0nfhoASne8zKx77Gi7TCGRKsSENgw==
X-Received: by 2002:a5d:526d:0:b0:34a:6fac:6dab with SMTP id
 l13-20020a5d526d000000b0034a6fac6dabmr547954wrc.12.1714426252869; 
 Mon, 29 Apr 2024 14:30:52 -0700 (PDT)
Received: from m1x-phil.lan (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 ay24-20020a05600c1e1800b0041bf29ab003sm9106641wmb.30.2024.04.29.14.30.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Apr 2024 14:30:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/13] exec: Rework around CPUState user fields (part 2)
Date: Mon, 29 Apr 2024 23:30:37 +0200
Message-ID: <20240429213050.55177-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Missing review: 1, 3, 4, 10

Since v1:
- First 13 patches queued
- Restrict qemu_plugin_vcpu_exit_hook() to (TCG) plugins
- Restrict cpu_plugin_mem_cbs_enabled() to TCG (plugins)
- Addressed Richard review comments on the others:
  - Move cpu_plugin_mem_cbs_enabled()
  - Do not move mem_io_pc, waiting for [*]
  - Mention can_do_io restricted

Finish extracting TCG fields from CPUState:
- Extract tcg_cpu_exit() from cpu_exit()
- Introduce AccelOpsClass::exit_vcpu_thread()
- cpu_exit() calls exit_vcpu_thread=tcg_cpu_exit for TCG
- Forward declare TaskState and more uses of get_task_state()
- Introduce TCG AccelCPUState
- Move TCG specific fields from CPUState to AccelCPUState
- Restrict "exec/tlb-common.h" to TCG
- Restrict iommu_notifiers, icount to system emulation

[*] https://lore.kernel.org/qemu-devel/20240416040609.1313605-3-richard.henderson@linaro.org/

Based-on: <20240428214915.10339-1-philmd@linaro.org>

Philippe Mathieu-Daudé (13):
  accel/tcg: Restrict qemu_plugin_vcpu_exit_hook() to TCG plugins
  accel/tcg: Restrict cpu_plugin_mem_cbs_enabled() to TCG
  accel/tcg: Move @plugin_mem_cbs from CPUState to
    CPUNegativeOffsetState
  accel/tcg: Move @plugin_state from CPUState to TCG AccelCPUState
  accel/tcg: Restrict IcountDecr / can_do_io / CPUTLB to TCG
  accel/tcg: Move @jmp_env from CPUState to TCG AccelCPUState
  accel/tcg: Move @cflags_next_tb from CPUState to TCG AccelCPUState
  accel/tcg: Move @iommu_notifiers from CPUState to TCG AccelCPUState
  accel/tcg: Move @tb_jmp_cache from CPUState to TCG AccelCPUState
  accel/tcg: Remove NULL check in tcg_flush_jmp_cache()
  accel/tcg: Move @tcg_cflags from CPUState to TCG AccelCPUState
  accel/tcg: Restrict icount to system emulation
  accel/tcg: Move icount fields from CPUState to TCG AccelCPUState

 accel/tcg/internal-common.h      | 18 ++++++++++
 accel/tcg/tb-jmp-cache.h         |  4 +--
 accel/tcg/tcg-accel-ops.h        |  1 +
 accel/tcg/vcpu-state.h           | 20 +++++++++++
 include/exec/tlb-common.h        |  4 +++
 include/hw/core/cpu.h            | 58 ++++++++------------------------
 include/qemu/plugin.h            |  2 +-
 include/qemu/typedefs.h          |  1 -
 accel/tcg/cpu-exec-common.c      |  2 +-
 accel/tcg/cpu-exec.c             | 51 +++++++++++++++-------------
 accel/tcg/cputlb.c               |  2 +-
 accel/tcg/icount-common.c        |  7 ++--
 accel/tcg/plugin-gen.c           |  9 +++--
 accel/tcg/tb-maint.c             |  6 ++--
 accel/tcg/tcg-accel-ops-icount.c | 14 ++++----
 accel/tcg/tcg-accel-ops.c        |  2 ++
 accel/tcg/translate-all.c        |  9 ++---
 accel/tcg/watchpoint.c           |  5 +--
 hw/core/cpu-common.c             |  9 +++--
 linux-user/main.c                |  2 +-
 plugins/core.c                   |  9 ++---
 system/physmem.c                 | 37 +++++++++++++++-----
 22 files changed, 157 insertions(+), 115 deletions(-)

-- 
2.41.0


