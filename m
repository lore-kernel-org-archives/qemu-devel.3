Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CC5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 18:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb27p-0004c7-3K; Mon, 05 Aug 2024 14:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb27k-00047V-3L
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:08:01 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb27h-0006T0-KW
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:07:59 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-428178fc07eso68960575e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 11:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722881275; x=1723486075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1vkVvGYva6AXVxaYurK5JW7ap7wfr9UqBuNEWmzqSg=;
 b=EsjxB9JR9/rTu8urC/rQYdAKQbeI+LO8HpUMV9/5KYWbam8DqPLEWvfkfLmMf5BnVH
 An3jQ5v2YuWQ/hHIMXakN4XH0kjvfihu8+GJM+4AakBYTRmbpzXqJVNaa84ygADTVBk5
 WjMsgqcpkdY9JRjKTPXKSfPCA4A0TsASx6UIHr0RZrWhZjQMOg19CCGCqFNS9cgfOYC3
 C8hBqZZwI/kDuS1vpBJoY5nfF9uHMwnjPyuXgM3AF5yiVClHdA3vrhJo1XsZNM2F0QWD
 /H239Qnng0Y2w3zEZ5mvFkkAFIVTVv9Ypy8UUbtD0e80AuiuG77aKZ6egrj03E/L/0zf
 FjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722881275; x=1723486075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I1vkVvGYva6AXVxaYurK5JW7ap7wfr9UqBuNEWmzqSg=;
 b=EyITy70nqyaNfsOSaqlwlQ7Z5/H7RYmLacl/Ka0yYkRKtDYSW/gfTj7DolSr7FTVSh
 BQ/8QzhYQK/Wii5xJtTTL1KgV7ZpcjwrxWwFbyOP4ZQrUfnZSSpx+gnGvNm7evT1oJGO
 56RxHHSV8/T9bcsEhhRmsDNsdYsV3ITl1k8atO6+f5BtL+ocXEt8qQEsPiB7apXZ5s4e
 iAYBtiy5ibq3XSOuuYSgYbHkn4qe9rZi66OuXqIlnpsMlyARqKXKzpxUBjREZXCTSr8W
 8TwxsV8vQ8k4S6qolBGXUJzH7FYmLPrA/ef/UU5dAMtS5eoU7Tf8NFe9IPUeevsOpbqW
 YMvQ==
X-Gm-Message-State: AOJu0YzeZC5qfW0MHNyPE2x+QlL17voKPVnDssJTTobBRT0YH+mfk/rS
 xjCqXKGt3JmUsrtocT5TWL3qZBN8cuQEClmfA3uyfIgT9eAEN29o3SA6p7raWzqJNs8xZikgKHw
 t
X-Google-Smtp-Source: AGHT+IEz2MQjO8x4lIg7LEaQxjcSkCSQCqHmDIVYU2NaAy1a06fM4z+xPuGID5IWPa5YFDMhnqBWMg==
X-Received: by 2002:a05:600c:3111:b0:426:5c9b:dee6 with SMTP id
 5b1f17b1804b1-428e6b7f2c7mr86127005e9.26.1722881275198; 
 Mon, 05 Aug 2024 11:07:55 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282bb64952sm212345545e9.37.2024.08.05.11.07.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Aug 2024 11:07:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH-for-9.1 v6 14/15] hw/intc/loongson_ipi: Restrict to MIPS
Date: Mon,  5 Aug 2024 20:06:21 +0200
Message-ID: <20240805180622.21001-15-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805180622.21001-1-philmd@linaro.org>
References: <20240805180622.21001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Bibo Mao <maobibo@loongson.cn>

Now than LoongArch target can use the TYPE_LOONGARCH_IPI
model, restrict TYPE_LOONGSON_IPI to MIPS.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20240718133312.10324-18-philmd@linaro.org>
---
 MAINTAINERS            |  2 --
 hw/intc/loongson_ipi.c | 14 --------------
 2 files changed, 16 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5ca701cf0c..74a85360fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1251,10 +1251,8 @@ F: hw/loongarch/
 F: include/hw/loongarch/virt.h
 F: include/hw/intc/loongarch_*.h
 F: include/hw/intc/loongson_ipi_common.h
-F: include/hw/intc/loongson_ipi.h
 F: hw/intc/loongarch_*.c
 F: hw/intc/loongson_ipi_common.c
-F: hw/intc/loongson_ipi.c
 F: include/hw/pci-host/ls7a.h
 F: hw/rtc/ls7a_rtc.c
 F: gdb-xml/loongarch*.xml
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 0b88ae3230..8382ceca67 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -16,22 +16,9 @@
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "migration/vmstate.h"
-#ifdef TARGET_LOONGARCH64
-#include "target/loongarch/cpu.h"
-#endif
-#ifdef TARGET_MIPS
 #include "target/mips/cpu.h"
-#endif
 #include "trace.h"
 
-#ifdef TARGET_LOONGARCH64
-static AddressSpace *get_iocsr_as(CPUState *cpu)
-{
-    return LOONGARCH_CPU(cpu)->env.address_space_iocsr;
-}
-#endif
-
-#ifdef TARGET_MIPS
 static AddressSpace *get_iocsr_as(CPUState *cpu)
 {
     if (ase_lcsr_available(&MIPS_CPU(cpu)->env)) {
@@ -40,7 +27,6 @@ static AddressSpace *get_iocsr_as(CPUState *cpu)
 
     return NULL;
 }
-#endif
 
 static const MemoryRegionOps loongson_ipi_core_ops = {
     .read_with_attrs = loongson_ipi_core_readl,
-- 
2.45.2


