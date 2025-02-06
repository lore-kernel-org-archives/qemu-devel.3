Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9582C0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6T7-0008Ni-0y; Thu, 06 Feb 2025 13:19:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg6T5-0008Jd-CO
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:19:15 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg6T1-0006sJ-AU
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:19:15 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38daf156e97so692341f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738865945; x=1739470745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cvk5XVWM6B/U3edLFXPiRke7Pe808hVHpTM0rnQwgtQ=;
 b=SVIQACkHxIxHQXcjc1ksIuC4CypjMF+czbB9r4LmfXrZNM1d+hCDdgrzgZMSgtN/1/
 jjWPWNFTzb/YWWv3ts5ruL80JDW9XgCFF/hPnX1ub8ycVwoYLv89B8fTyheym9KnWuPm
 uWJk3h+Fj86prAJeHuh2dNPoY+x0s2cOcZNIdwKYEc/fBHlPUPmXnPcigbS/6PrhogLh
 8RVXXaBoa8t0wJRSe5IOMTvsBG8fQkDYnXOFvAxX/WR5fV3hGbSdMdX7IhYZ1IqeroNx
 ELuC8MIvwzY2ym+T/Qo559luruWDRnwY4RWdc/IvU4r3yevVEzqlFDWAlXHjyiKA5bd3
 a33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738865945; x=1739470745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cvk5XVWM6B/U3edLFXPiRke7Pe808hVHpTM0rnQwgtQ=;
 b=tXG47fvlC8/BYjcM+LhaEDV+7AK7fXoTsl9J5UtByeUkDokh8o3QeLe8Izkg+iQTEv
 f7+BApPPWYFk4x2btv2+KszPsSNYrKV5hZVofuaCKKbhbCrseNdUps3qYA1XUGdoX4zQ
 Itz4lmsh1bunvFnFL0UIOQWbou12BdZvgB2gxbojntrAlVnSIyi3Mry9aH9A8O/pSblQ
 KMSWgl/UHuCyb1plm0RkOqjic7Jl67YV1BRrYLlUsEFljBbxhcO+dXXwCxbCiOJHDNzl
 GzQIo38asw1tswj04FRqfKFo9b4ksnszoiqKC2oWVsteDvUz2WHfcim2cmwcfqSagnFP
 Yxjg==
X-Gm-Message-State: AOJu0Yzf/CxA0leVaQEAV4XQlwrjQRZeox1frOxJ+spEdzsgygmbW8rF
 uISKWYADXeuOfZy0qDYwRcvsiRxEVZZgNTfRQwMB6J8VtJikuayc72SOb4qXe5D2mlxqpYR3qqF
 0xTo=
X-Gm-Gg: ASbGncuqqySk/Bd7NhUlhb20UPC9tjKEApQUKIeU4KuEoqcy57YhDeY3TwICTcT5V9O
 c6uskgeI7nt5s9Q7FEdaYmd4/vLW5k4xF97kUjP5SUPtGOgk9Gq2pGSmhepfC4bA/fDWp8J7nV/
 CK4PsRkU8pLPM6EP6y+g0ROfuM4jJji9sKTM5Pr3cYMkmL1L07yyiAr/sqHr+jg6n6Qi08kYS9b
 e1RYkAiyBy146Mf9/5V0pyjrZcSNhMTAtZewjF8UmCAK3+aLuWcZtIa31Q8tisb9YHk4QNbDX2Z
 6vapRnzYFUHK4kcfWU2t7j9sHXVHYJ43q0BGJzyQsbH9g1zYWnrnaPO2pldgde/9XQ==
X-Google-Smtp-Source: AGHT+IEISMzuba5y5/a/hV1oFvHOX1dJCnIqiaCa55m0+aDk27ImuF5o9z6OsKXLJ5E4PHf3A2yCLA==
X-Received: by 2002:adf:e30e:0:b0:38d:c85c:f917 with SMTP id
 ffacd0b85a97d-38dc85cf9f1mr99566f8f.55.1738865945467; 
 Thu, 06 Feb 2025 10:19:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd1c151sm2310535f8f.7.2025.02.06.10.19.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 10:19:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/7] hw/riscv: Move few objects to common_ss[] to build them
 once
Date: Thu,  6 Feb 2025 19:18:27 +0100
Message-ID: <20250206181827.41557-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206181827.41557-1-philmd@linaro.org>
References: <20250206181827.41557-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

opentitan.c, riscv-iommu-pci.c, riscv-iommu-sys.c don't depend
on target-specific knowledge. Move them to common_ss[] to build
them once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/riscv/meson.build | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 3c7e083aca1..ff578a2e01a 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -2,7 +2,7 @@ riscv_ss = ss.source_set()
 riscv_ss.add(files('boot.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
 riscv_ss.add(files('riscv_hart.c'))
-riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
+common_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
 riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
@@ -10,7 +10,8 @@ riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
 riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
 riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_pfsoc.c'))
 riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
-riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c'))
+common_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu-pci.c', 'riscv-iommu-sys.c'))
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
 
 hw_arch += {'riscv': riscv_ss}
-- 
2.47.1


