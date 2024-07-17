Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870F8C3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 21:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUCVh-0002Rx-NP; Wed, 17 Jul 2024 17:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCVe-000292-RE
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:48:26 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCVd-0002MA-5M
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:48:26 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4267300145eso1125755e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 14:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721252903; x=1721857703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kmy7cURki6nBytni2EwGHik2KgRQEv6ru/qUUAFzUoU=;
 b=brLHCxbdkxJaX68+HRvy14UMjbW4ZQVnl3lJl9V2wsXNMDIdyTO0BgfIs5UV9LEClW
 Rurur116KAW8FDhQIrOgStCqliR50bmX6x5VSpn4r4CWc0aAr3QHXoSGdixBUH5kcdBn
 EYqIDXhModh67sbDQvVzR41pQ9iKqpNTLniQkOKlby4jUXEysU//I095cNmON0dR0HGK
 riQlkos2hbtG9QL6VE56e1s1+WtA2gRAdLZr07KiC2UNd5jXpdfqhokWt1mIuBrrGfmm
 CX6ZzvpG6QrynOinFabkq6Y/yAbcmkv/p+ZSPb6PIdEfLWZlcIA/YiZb/shmM/9eE63P
 vKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721252903; x=1721857703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kmy7cURki6nBytni2EwGHik2KgRQEv6ru/qUUAFzUoU=;
 b=oKF02EK4lWpdpp006eTrJdodz9EYFa4nKeosPhipRKOXryQFSvATFJV+HpwoEAOX9f
 hrzuCjwAlfFgT/g3dIchlCH5UNnsYUG+iq7AIVw2PK+5V0ZE7PfwKKPOTarpeuRTY9r0
 JWk6cZJgWVfrwSPfIVVexqlYDIpsm9+ePr4hVv5CAi3DT+fWivLNRwcKyLfTe2c1N963
 iss6tz9+qD2E9GXUkG/MZqNcCPUh94S8zLGZ8kmQ8h5yPPODE4zA8N8NOCcA9EP28UeS
 y/1WNYLuK0vqpse46tyoiWP2wtWUwufhkBGDXrM28049F5dv7wRBZ6SWFW7fxilK1Cc0
 Em5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGcjQr8ch6zDlzSBe7Ux9F9q/nWwuDAPfylIAevP8/qZV2m0YDPhTw2BNLq0zXo6jPqzqLdSunrk/aEe/pXw6XbeV8PPo=
X-Gm-Message-State: AOJu0Yxr3Uv1u84fYVEghjl0g/ZanSRNBcvCo+iHSLGEMpkHesH10ZFi
 ao8WutLl8hAT2YfULU+jxiVYCsRz6VJBTPTloCS7BVbwjOFlsIJdtFSKwrfO6d4=
X-Google-Smtp-Source: AGHT+IEcm8/Q+oSidIfnZA6aaKTsyrxwIbLRXWbMJ+g92n3D2R4wi6pkUyHwPUYpgDpwpvcKz0kHGg==
X-Received: by 2002:a05:600c:1547:b0:426:545b:ec00 with SMTP id
 5b1f17b1804b1-427c2cc90dfmr26634995e9.19.1721252903529; 
 Wed, 17 Jul 2024 14:48:23 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427c7805253sm11478415e9.32.2024.07.17.14.48.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jul 2024 14:48:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH v3 09/17] hw/intc/loongson_ipi: Pass LoongsonIPICommonState to
 send_ipi_data()
Date: Wed, 17 Jul 2024 23:47:00 +0200
Message-ID: <20240717214708.78403-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240717214708.78403-1-philmd@linaro.org>
References: <20240717214708.78403-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

In order to get LoongsonIPICommonClass in send_ipi_data()
in the next commit, propagate LoongsonIPICommonState.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/loongson_ipi.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 5346bbb267..8acd563db9 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -88,8 +88,8 @@ static AddressSpace *get_cpu_iocsr_as(CPUState *cpu)
     return NULL;
 }
 
-static MemTxResult send_ipi_data(CPUState *cpu, uint64_t val, hwaddr addr,
-                          MemTxAttrs attrs)
+static MemTxResult send_ipi_data(LoongsonIPICommonState *ipi, CPUState *cpu,
+                                 uint64_t val, hwaddr addr, MemTxAttrs attrs)
 {
     int i, mask = 0, data = 0;
     AddressSpace *iocsr_as = get_cpu_iocsr_as(cpu);
@@ -119,7 +119,8 @@ static MemTxResult send_ipi_data(CPUState *cpu, uint64_t val, hwaddr addr,
     return MEMTX_OK;
 }
 
-static MemTxResult mail_send(uint64_t val, MemTxAttrs attrs)
+static MemTxResult mail_send(LoongsonIPICommonState *ipi,
+                             uint64_t val, MemTxAttrs attrs)
 {
     uint32_t cpuid;
     hwaddr addr;
@@ -134,10 +135,11 @@ static MemTxResult mail_send(uint64_t val, MemTxAttrs attrs)
     /* override requester_id */
     addr = SMP_IPI_MAILBOX + CORE_BUF_20 + (val & 0x1c);
     attrs.requester_id = cs->cpu_index;
-    return send_ipi_data(cs, val, addr, attrs);
+    return send_ipi_data(ipi, cs, val, addr, attrs);
 }
 
-static MemTxResult any_send(uint64_t val, MemTxAttrs attrs)
+static MemTxResult any_send(LoongsonIPICommonState *ipi,
+                            uint64_t val, MemTxAttrs attrs)
 {
     uint32_t cpuid;
     hwaddr addr;
@@ -152,7 +154,7 @@ static MemTxResult any_send(uint64_t val, MemTxAttrs attrs)
     /* override requester_id */
     addr = val & 0xffff;
     attrs.requester_id = cs->cpu_index;
-    return send_ipi_data(cs, val, addr, attrs);
+    return send_ipi_data(ipi, cs, val, addr, attrs);
 }
 
 static MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr,
@@ -249,15 +251,16 @@ static const MemoryRegionOps loongson_ipi_iocsr_ops = {
 static MemTxResult loongson_ipi_writeq(void *opaque, hwaddr addr, uint64_t val,
                                         unsigned size, MemTxAttrs attrs)
 {
+    LoongsonIPICommonState *ipi = opaque;
     MemTxResult ret = MEMTX_OK;
 
     addr &= 0xfff;
     switch (addr) {
     case MAIL_SEND_OFFSET:
-        ret = mail_send(val, attrs);
+        ret = mail_send(ipi, val, attrs);
         break;
     case ANY_SEND_OFFSET:
-        ret = any_send(val, attrs);
+        ret = any_send(ipi, val, attrs);
         break;
     default:
        break;
-- 
2.41.0


