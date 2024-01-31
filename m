Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75955C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 08:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV6Jb-0001ws-Ej; Wed, 31 Jan 2024 03:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rV6JV-0001v0-FU
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 03:51:21 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rV6JT-0007sl-S5
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 03:51:21 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40ef3f351d2so3182535e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 00:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1706691078; x=1707295878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=++E/Dn1qTfQEQgf0YVqIQ3YMM6hUVCoKevVh61Nx1dE=;
 b=JaapevQ36C94dLja2e3Ypcig8PUgHXkHe8rUq0Y4RP7i6Cr1ihKiYSlYBTJYfaryf4
 dfJE/QbdnjzRkgsAhQ8Fbt7SAX3trYyn3tTxA3BQvfpxeaN2e2Mj7wq+aV74dQgjvQnz
 EVMpZ+uEzYSSLAFUyYq22YrmypuHWJrUccbSS0zakdh/voFDZ8dxDkx+QSkiaGojsF4g
 h9X12zX6fi7tsbynZUFTvtreHlNHdeMrdx6FJRxKMp9IKH2BPbaG32eb9K1AIvIaD1d4
 k3aM4cH2nUkLrUWenrCB2O0SwdujkJh9ZB1pPWJP/joJ4CYRt+SHDCdcSmZie2RDzT0q
 rGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706691078; x=1707295878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=++E/Dn1qTfQEQgf0YVqIQ3YMM6hUVCoKevVh61Nx1dE=;
 b=iv44t8YYnoEvEJXLA9sXRnJTS3YZSkAx4m2DnOWFsDxs4EH9zaxeADFzdh5QVxheZL
 lQYRn0m+HRAlxdfCy65s8UswlZeWybdKUbskxE9OEX3nMCVOOJ+UcrLKuOGDgh3aIvye
 iqgtdc4BYe3PQu0bbOw5h9BHrpsRDcZ4d5+FOTViP2KIqZ2zQ31STCHtrGSwQEexjIZ6
 0vN1XT+DjXGphONXFOcPb+kr4FCsORqWD8rTFrqw+ff/Ei81PJidqufJKzWyRuDK8xg3
 w2SnsiRBURwtzK+Q110drym9gxBqQ3aKJBgKB+sXh1T+18t5p2eeF9FdokT8eGf9KtaD
 bt2w==
X-Gm-Message-State: AOJu0YzxYtkFdP01BCLB02Bgu0t82CaatFBXGUip+8ik/sCCXcmQeHVE
 fHjh2wCy0h+upjKwqvkXEYpqXmoys3EKkdkUCHaKS5hsEV1QGlGW/zlGYJiyy5gBAxfQ0E09svQ
 =
X-Google-Smtp-Source: AGHT+IFCfOg6T7YVeeDOr/NiSOTkv41lTfH/GuKpeGzI/nTqyHbnRdxp8uZP0/NAQD6tHEGK3sOenA==
X-Received: by 2002:a05:600c:3548:b0:40e:6ca9:98a0 with SMTP id
 i8-20020a05600c354800b0040e6ca998a0mr926223wmq.15.1706691078143; 
 Wed, 31 Jan 2024 00:51:18 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWLpjoYvBUjYKuVnEIhCkGE+Eo4CK784ENwOaLxJoB+SmFgu2tCJXlW2nuwleZfxQRVi76KOu7nJCjOJ13xsK42HQRUWDtbLJOCnNfoqmNrCikSQkbIu8tmVKeB
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:aea2:cdf3:9482:a36])
 by smtp.gmail.com with ESMTPSA id
 n28-20020a05600c181c00b0040efd216050sm909926wmp.35.2024.01.31.00.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 00:51:17 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 8/9] leon3: check cpu_id in the tiny bootloader
Date: Wed, 31 Jan 2024 09:50:46 +0100
Message-Id: <20240131085047.18458-9-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131085047.18458-1-chigot@adacore.com>
References: <20240131085047.18458-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32a.google.com
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

Now that SMP is possible, the asr17 must be checked in the little boot code
or the secondary CPU will reinitialize the Timer and the Uart.

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sparc/leon3.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 252aff72cd..798dba1e5a 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -99,13 +99,27 @@ static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t val)
 
 /*
  * When loading a kernel in RAM the machine is expected to be in a different
- * state (eg: initialized by the bootloader). This little code reproduces
- * this behavior.
+ * state (eg: initialized by the bootloader).  This little code reproduces
+ * this behavior.  Also this code can be executed by the secondary cpus as
+ * well since it looks at the %asr17 register before doing any
+ * initialization, it allows to use the same reset address for all the
+ * cpus.
  */
 static void write_bootloader(CPUSPARCState *env, uint8_t *base,
                              hwaddr kernel_addr)
 {
     uint32_t *p = (uint32_t *) base;
+    uint32_t *sec_cpu_branch_p = NULL;
+
+    /* If we are running on a secondary CPU, jump directly to the kernel.  */
+
+    stl_p(p++, 0x85444000); /* rd %asr17, %g2      */
+    stl_p(p++, 0x8530a01c); /* srl  %g2, 0x1c, %g2 */
+    stl_p(p++, 0x80908000); /* tst  %g2            */
+    /* Filled below.  */
+    sec_cpu_branch_p = p;
+    stl_p(p++, 0x0BADC0DE); /* bne xxx             */
+    stl_p(p++, 0x01000000); /* nop */
 
     /* Initialize the UARTs                                        */
     /* *UART_CONTROL = UART_RECEIVE_ENABLE | UART_TRANSMIT_ENABLE; */
@@ -119,6 +133,10 @@ static void write_bootloader(CPUSPARCState *env, uint8_t *base,
     /* *GPTIMER0_CONFIG = GPTIMER_ENABLE | GPTIMER_RESTART;        */
     p = gen_store_u32(p, 0x80000318, 3);
 
+    /* Now, the relative branch above can be computed.  */
+    stl_p(sec_cpu_branch_p, 0x12800000
+          + (p - sec_cpu_branch_p));
+
     /* JUMP to the entry point                                     */
     stl_p(p++, 0x82100000); /* mov %g0, %g1 */
     stl_p(p++, 0x03000000 + extract32(kernel_addr, 10, 22));
-- 
2.25.1


