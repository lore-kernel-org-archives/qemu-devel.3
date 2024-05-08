Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501F9C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lNy-0003b3-3r; Wed, 08 May 2024 13:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lNi-0003Ig-5l
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:47:09 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lNZ-00009b-U2
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:47:05 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a59c448b44aso985115766b.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190416; x=1715795216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6IRJ9iX2zSqDzHgdCfHrvq8rCQLk6y62SmHm2Vf+BCI=;
 b=ekDCImcuXYSxXgmg0MuXw6Vn6TMlfXjcj07d1HgE5UiqzcZCvDAUy1PqygzQvyWFyJ
 KPnKKgcF7TPejfYERtvRr/dMv++f4wkmHHQPUe0CqzhQVhCBrPV8x+FAgnURCsMKbGJb
 BMiUF/JxKW3qxx23N4uuJzSBgqpggqV0FJZws1ZhutdBbv4ocuImT7mEiemzabv7J6lP
 cSqn3Y0CTBThnlbrr4/LIAzAFcM9qBBbDXdszF83W8p88Lz7OSq034WawZTOU7CfSQmu
 na3OHU/hcHtWgV9t+QmA0lGvTy5h+pQUnxaRu6RwDvmyHL5Rt4MOkCZuI4ceiSwHTMJ2
 Ljcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190416; x=1715795216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6IRJ9iX2zSqDzHgdCfHrvq8rCQLk6y62SmHm2Vf+BCI=;
 b=M3NwmXAZ1o6rYpQg+pTaS4wwxtficVJsWVCII8w+3tyWKaNOMSLQmuawXS2TBL6+d/
 ggSb70M7W2AWj59YK7eiPz/h/5cMdR7vL23F0Tgy1+mRvMyVA7L8f1LLp8cHZDRrSUSp
 OxHUtR+YqTCzLDGSsM4OxlBIt4zTME6EHDlAVvStOCwAr0SCDzImJc2LacpH3XvMRkHK
 rDIaHSEExwkl1FV6Z5cWD1hC6QshLskuWe7mp1XgDKI7hJLMuju39cfVY+/f13PQCtcR
 ghkfBpt8hzUOy5Znw/wbJlxB3+LXnHLZkRIae1KFR0G8qz+SrnAGAP9pQncaxxCdLy5l
 oV6g==
X-Gm-Message-State: AOJu0YxOA9rCSM5WkKA+lB/JhNNI6kJ7iYsNdZUhIhGQIRoa7pGZwGzi
 nOY5xSXqpDYfMzOSr5HjpWtJEZXk88hoenlCD9rvTMYn0PuO+ydPz6bDSlWKObBtwlxQeY57msu
 k
X-Google-Smtp-Source: AGHT+IFKMxM1zTkc2DzWmmrZeZ0MPvCLaSWY4ZfwFhiY5p7aKtVbKxHjhxRtRzOeQTHtzt1ZdyYkCg==
X-Received: by 2002:a50:ee10:0:b0:56e:60d:9b16 with SMTP id
 4fb4d7f45d1cf-5731f04235cmr1998594a12.6.1715190416264; 
 Wed, 08 May 2024 10:46:56 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 n18-20020a05640205d200b00572f0438b02sm4654580edx.6.2024.05.08.10.46.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 10:46:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/26] hw/loongarch/virt: Fix memory leak
Date: Wed,  8 May 2024 19:45:03 +0200
Message-ID: <20240508174510.60470-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508174510.60470-1-philmd@linaro.org>
References: <20240508174510.60470-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

From: Song Gao <gaosong@loongson.cn>

The char pointer 'ramName' point to a block of memory,
but never free it. Use 'g_autofree' to automatically free it.

Resolves: Coverity CID 1544773

Fixes: 0cf1478d6 ("hw/loongarch: Add numa support")
Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240507022239.3113987-1-gaosong@loongson.cn>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/loongarch/virt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 504e1fb349..69924a8734 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -884,7 +884,6 @@ static void loongarch_init(MachineState *machine)
     const CPUArchIdList *possible_cpus;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     CPUState *cpu;
-    char *ramName = NULL;
 
     if (!cpu_model) {
         cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
@@ -943,7 +942,7 @@ static void loongarch_init(MachineState *machine)
 
     for (i = 1; i < nb_numa_nodes; i++) {
         MemoryRegion *nodemem = g_new(MemoryRegion, 1);
-        ramName = g_strdup_printf("loongarch.node%d.ram", i);
+        g_autofree char *ramName = g_strdup_printf("loongarch.node%d.ram", i);
         memory_region_init_alias(nodemem, NULL, ramName, machine->ram,
                                  offset,  numa_info[i].node_mem);
         memory_region_add_subregion(address_space_mem, phyAddr, nodemem);
-- 
2.41.0


