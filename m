Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36308C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCqf-0007RM-IM; Wed, 15 Jan 2025 18:30:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCqY-0006rv-6t
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:30:50 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCqV-00059n-FU
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:30:49 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38632b8ae71so269765f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983844; x=1737588644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oBmzOwwa/rqiVq09wwGIeAFFq9Z7MiUbusM3HZSK1Bs=;
 b=lryqALIrnpwG61/VosLmHrbIcLUlJEewhsfGiOZPEJ5l1Ak4YFwCmu8n6dTlkBTcxi
 HK1ZwaEcRTNWXmY7jTIN4TsO01Vovg+TsGCs5yrPKMOKay6RyoBLW2IopxdB50lJF3We
 1FaSPkNZnqQ8IWRxOXndZNy/zVrFVY4Pqa0GVU8RwXKLONt4bqiWFTtAvFUAxgbse94m
 qG5SXHJHObYM4JzyFXXYPforbSj4TdjzO8vA/uLC3j81Tt+lVoRIGqjFCtxtiWlloaxD
 5XX2Hw6lrQMxSdLibS2Cc4dnBZuobpNbMqunQRpA8dZd6siG69Ab+59iyo99pxvwJf2D
 iTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983844; x=1737588644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oBmzOwwa/rqiVq09wwGIeAFFq9Z7MiUbusM3HZSK1Bs=;
 b=q02SgzyvpJscXg00n7xkncyq8hjgWsVwIGoVGBmhO8OaJqBfkonhi/13SH0pFAe8+y
 1dGhBRYAMz4IJoUoN2QvpEYTmNJ3wASMLrWl4oPC7/SVQcsWKiZ8Wve/uEfJrkj2j29c
 3vFa5lAXjuMASd7M+5rvjWqNjYAM1H0RArXgwmYiJNyVhcY2gFXnzs8lziLz11DbDSMY
 JXlDs5exjp2HI+k2MO1emfjYj6lndN6IPKghhrYGV8a/ZvOTu5xv+mw9Ad1RfZrs+tHJ
 Bo0XPrSlQIojF0klzvXRCibKE9zlIX8JiJ8goVEMoqkvnqh5iLSNejpU3jQbS5Fdcspw
 WHRQ==
X-Gm-Message-State: AOJu0YyJnwwitVA6ofgAFxschWGeN2oIrxLsYCW3zZfaSRYEaiEP/ZIt
 55BBhSo0PD95klJQFs7yBnPdAfae/xbidwcxA/9kdZDXdqJNKkBqDLx5DGw0p67EaaEZirRYli9
 bsa0=
X-Gm-Gg: ASbGncszoryALlvEbWlR+/c3uvM+fhTNaKj/gnnAIF/2bCXpsXpHgY6OgYLkmR+Ilpu
 cTK+lAnk5tP23xGk5WH9ZINHwCxI/7w649WHMq0qR8rSTnGMpwsn3iuFNTfGJObZwliwWdG0l/x
 2o16vfPPTyAuBiwbfOGddW68UjU2MnorM8ccwQLhFsGQwUkrr6DP79fojIeGeuckS6nB5iYnWCJ
 sXHKFUgejfVAO2nZukf5Aw4rt3iEClHX6hqvGQ/RKvBWwnZTJR+JiVxhjNOb4Th0vzScFNrcJMM
 a6kaEIKhAVYOWbYd3DCQE4a213DThvU=
X-Google-Smtp-Source: AGHT+IECMYKwfs99AUPDlyT8MMED+2wzNOLIBYVrN8sF9XcniKU6ROqXqL3JmUp6tLqBjgHn7pBeNw==
X-Received: by 2002:a05:6000:144d:b0:388:e377:8a1b with SMTP id
 ffacd0b85a97d-38a8730cc78mr28628549f8f.28.1736983843838; 
 Wed, 15 Jan 2025 15:30:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74aca93sm39607455e9.13.2025.01.15.15.30.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:30:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 10/11] hw/mips/loongson3_virt: Propagate %processor_id to
 init_boot_param()
Date: Thu, 16 Jan 2025 00:29:50 +0100
Message-ID: <20250115232952.31166-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232952.31166-1-philmd@linaro.org>
References: <20250115232952.31166-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Propagate %processor_id from mips_loongson3_virt_init() where
we have a reference to the first vCPU, so use it instead of
the &first_cpu global.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/mips/loongson3_virt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 4924ea88eda..7d6369876ba 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -173,7 +173,7 @@ static uint64_t get_cpu_freq_hz(const MIPSCPU *cpu)
     return DEF_LOONGSON3_FREQ;
 }
 
-static void init_boot_param(unsigned cpu_count)
+static void init_boot_param(unsigned cpu_count, uint32_t processor_id)
 {
     static void *p;
     struct boot_params *bp;
@@ -184,8 +184,7 @@ static void init_boot_param(unsigned cpu_count)
     bp->efi.smbios.vers = cpu_to_le16(1);
     init_reset_system(&(bp->reset_system));
     p += ROUND_UP(sizeof(struct boot_params), 64);
-    init_loongson_params(&(bp->efi.smbios.lp), p, cpu_count,
-                         MIPS_CPU(first_cpu)->env.CP0_PRid,
+    init_loongson_params(&(bp->efi.smbios.lp), p, cpu_count, processor_id,
                          loaderparams.cpu_freq, loaderparams.ram_size);
 
     rom_add_blob_fixed("params_rom", bp,
@@ -642,7 +641,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
         loaderparams.kernel_entry = load_kernel(&cpu->env);
 
         init_boot_rom();
-        init_boot_param(machine->smp.cpus);
+        init_boot_param(machine->smp.cpus, cpus[0]->env.CP0_PRid);
     } else {
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
                                   machine->firmware ?: LOONGSON3_BIOSNAME);
-- 
2.47.1


