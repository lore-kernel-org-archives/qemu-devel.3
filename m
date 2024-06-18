Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DC8C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbMQ-0001Bz-V2; Tue, 18 Jun 2024 12:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbMF-0000UT-FF
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:06:56 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbMD-0007pI-RY
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:06:55 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42281d8cd2dso39992775e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726812; x=1719331612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hte3egNIkJ/sFzULQkXNn/TRVVq6KAGN1byrZgRqcoo=;
 b=RkTVKHrP8jQnl4Moe7m8vNYOoYo8ZyAOE468q+ciVzgKtYF1F4N2AHxubiO9z3OOA/
 uRdWng9uIgv6K9rzFLY7mxWiiczgykk7W/n0bza0JLzt3kkIoBpQX51LTbTMm1NZQKUd
 z9W4gLhnn0YYQKdjCI9+GT3Fuzq5TshCVNyEU41VR2y/HJpocS0jjIDZWknVNssmQMCL
 K+SX1q8xCYBM1xIvdUyC1TIeQQYUTLzN59/mooJoc6jalG6qB4j9vH5LXHGXno5qTLdF
 YRYUl+6AtHfwWA4Z/iIqnOWEogQj72Im31nEDk2Lx7Rap+z9NRDhiDIsDuRDjOgi14ge
 1W2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726812; x=1719331612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hte3egNIkJ/sFzULQkXNn/TRVVq6KAGN1byrZgRqcoo=;
 b=jXXed5dQrqsalNEmpkbdepz2JW2qAErkOsZYQx9uzc5yhgVTXo0VLzgFferH56PI9P
 OmHlVTWxijp3YDzgwSKvvK/CpWgm9HlqLd+9VvSnM+eB10UDZYm/prYmDN+Op1ynomXC
 1gGIfM5vL4k7kmY5x4cRCy6f3SAV/u5z0TD/GG2K8opkc4EV+nnelzr+myy7K4ffCVQv
 DUK08SI/QIDW6o+SoTTZTb/FVz+2ZTrHFnNId5Jn8bpCsbGZu4+X84ZOKx59a9TzTVdm
 tVrMtTqV5LuLN9r67qEppSfS6oClMQcSGReIq7nIp0cTzMkBCcp1vqzteYG6KWVtn/QH
 HS0g==
X-Gm-Message-State: AOJu0YxzNBvEXvjMMC8th5KPCVQ1GIEro9y7eG4t6OilKxrS1WxlbbSk
 7dhR0iRtqQoaruVjzqNDuJSoG6Mr+xgEeg1CD1j39s3Z5uMvC615OziWN0+wozgkPBgKhddECbw
 L
X-Google-Smtp-Source: AGHT+IGJqS56tduJSATqOY7HymER6vn43KQQTpHXgf6SwaZb4ZfIcnncCc4bHIauy9Cz0P7HtIrobQ==
X-Received: by 2002:a05:600c:2e51:b0:41b:f979:e19b with SMTP id
 5b1f17b1804b1-42304854eeamr106019825e9.39.1718726812035; 
 Tue, 18 Jun 2024 09:06:52 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f641a633sm193554665e9.43.2024.06.18.09.06.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:06:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 64/76] hw/intc/loongson_ipi: Replace ipi_getcpu with
 cpu_by_arch_id
Date: Tue, 18 Jun 2024 18:00:26 +0200
Message-ID: <20240618160039.36108-65-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

cpu_by_arch_id is doing the same thing as our ipi_getcpu logic.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20240605-loongson3-ipi-v3-4-ddd2c0e03fa3@flygoat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/loongson_ipi.c | 39 +++------------------------------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 08a74a0b4f..e6a7142480 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -118,39 +118,6 @@ static MemTxResult send_ipi_data(CPUState *cpu, uint64_t val, hwaddr addr,
     return MEMTX_OK;
 }
 
-static int archid_cmp(const void *a, const void *b)
-{
-   CPUArchId *archid_a = (CPUArchId *)a;
-   CPUArchId *archid_b = (CPUArchId *)b;
-
-   return archid_a->arch_id - archid_b->arch_id;
-}
-
-static CPUArchId *find_cpu_by_archid(MachineState *ms, uint32_t id)
-{
-    CPUArchId apic_id, *found_cpu;
-
-    apic_id.arch_id = id;
-    found_cpu = bsearch(&apic_id, ms->possible_cpus->cpus,
-        ms->possible_cpus->len, sizeof(*ms->possible_cpus->cpus),
-        archid_cmp);
-
-    return found_cpu;
-}
-
-static CPUState *ipi_getcpu(int arch_id)
-{
-    MachineState *machine = MACHINE(qdev_get_machine());
-    CPUArchId *archid;
-
-    archid = find_cpu_by_archid(machine, arch_id);
-    if (archid) {
-        return CPU(archid->cpu);
-    }
-
-    return NULL;
-}
-
 static MemTxResult mail_send(uint64_t val, MemTxAttrs attrs)
 {
     uint32_t cpuid;
@@ -158,7 +125,7 @@ static MemTxResult mail_send(uint64_t val, MemTxAttrs attrs)
     CPUState *cs;
 
     cpuid = extract32(val, 16, 10);
-    cs = ipi_getcpu(cpuid);
+    cs = cpu_by_arch_id(cpuid);
     if (cs == NULL) {
         return MEMTX_DECODE_ERROR;
     }
@@ -176,7 +143,7 @@ static MemTxResult any_send(uint64_t val, MemTxAttrs attrs)
     CPUState *cs;
 
     cpuid = extract32(val, 16, 10);
-    cs = ipi_getcpu(cpuid);
+    cs = cpu_by_arch_id(cpuid);
     if (cs == NULL) {
         return MEMTX_DECODE_ERROR;
     }
@@ -227,7 +194,7 @@ static MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr,
         cpuid = extract32(val, 16, 10);
         /* IPI status vector */
         vector = extract8(val, 0, 5);
-        cs = ipi_getcpu(cpuid);
+        cs = cpu_by_arch_id(cpuid);
         if (cs == NULL || cs->cpu_index >= ipi->num_cpu) {
             return MEMTX_DECODE_ERROR;
         }
-- 
2.41.0


