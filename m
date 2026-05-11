Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478BECD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMR4x-0000Bx-CH; Mon, 11 May 2026 09:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMR4r-00005h-7Y
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:53:46 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMR4j-0004Rp-By
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:53:38 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso50626395e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 06:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778507615; x=1779112415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tRuU/inbb+Eaj7b9xaJfM5WKP8b7b+xhLkC4V34QYE8=;
 b=nnYkCRwWketJQj26f60VpMHJmA9IDnPxwk97se6FB34NW4tQ7J5usbzrJ97UxLDe73
 xPQrs+Z3JOeZjg86JdmhkU8230df3Q2NfN/JPaEQmo1YXKYZu+7OkFTlABSlOfhxnj5y
 xDQ/IdR5NgZAbvKZ0iUnI7caZ+sooOBmAlILEki/56KF8lHUT+Wu6ljWkLT8N54vUUC1
 r9grtyqx38m/4UMmrfjrt3Sqv92rysUUwb8sn7rx+24vlTOVXOe/db826STJp799F4QO
 15MICOTZC7MToepgfeChMm8tmgeO/b7AHTKT7MfGAE6fLeDbPQNbWqEYyR4BQwMlKxa2
 o+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778507615; x=1779112415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tRuU/inbb+Eaj7b9xaJfM5WKP8b7b+xhLkC4V34QYE8=;
 b=l4Oc2u0mGkfNhARU1Z4dG8kviYRvEnslIWeuPPmmHXJ8HcsR7LCWDjS6/hm5gPoIzz
 +gDUnZyeV8FWoZ82bnvCovqDipqIHDM+hyoBltb3bNkCNQprzLc310no6pipd3SiBMRC
 A2Q23AtTkbljsUyYM2PduW3KhaPyKlxI3MHZ904otmiz2RqfdiNw6qOoU90/zGMXzZwK
 ngjDiwMAqxVbj69AVx8NPhnKU62n6h5ZetlhDPqpYN1TGcx5JoE+SxBPs1PQxBS3UO2a
 xoBlvitW8HPC3Bg+uXhsLhMM6s4V4va0tLraGfwnxvT1F/jB86Dd3PX3SSMuqb4zop2/
 greg==
X-Gm-Message-State: AOJu0YyeD3wBidCgl9FawK4ii5FNXLtHcSALvN4TD/HY3EpRgOuZTVRi
 S6G+WXkEPz3T5KrgvRq/BdtNpA9Ic7V3F9lq4aGpqxqG3W8edvr4weRGzq8yPe7D+1TbqZEbHRH
 Sgx4hwNo=
X-Gm-Gg: Acq92OEii2NfRzJQAFkJsQ4W6v972pSI1rV1Ut6Qf1bq+foKZO6nCZDtrqQV3QGfKtS
 RANDfIgqMM1BX4KUaVUNhylEvT4NRpl+bS+JOcZu+q/LP8NSMm8fseQ5iTvN77jVKYlDMLx8xpx
 obTJmwoHUPX4lp1z2uPRgbkkADsus27GHxKuffFveTRUbAeFT+iLR6M/s3BVlxljsdN9rHvCzFf
 bbo7IQ6q566tX88seMg5Qqjq8sCAeMmpEmn9PLXKpf+X4gp55pNVgepkvTFNl/8Lh3aRO410HMN
 9IFCCkQK333PWWVRrGj4ztkMT+WdID2lBTHKDgNWCS3B3N+Iyt7En2vNjk9uwEOzUpCIWFV5gUr
 XP5PfKYSFg7g1kjt7abnExqY3VQ5abVBkaxFU9ai7o4JNV8ITzwSMbfpv5lUJcttLe+eaBS+gSx
 jQek1hxGlBgRiksi+48oP5v1RhVvQTV+ekBH37sACxfO+/QNTswRfk4VKXivlnEdvEvRxED0b3A
 XBNlDT27fQ=
X-Received: by 2002:a05:600c:4755:b0:48a:58ae:992f with SMTP id
 5b1f17b1804b1-48e51f2e8cfmr382129745e9.16.1778507615225; 
 Mon, 11 May 2026 06:53:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491cab9c2sm27072127f8f.31.2026.05.11.06.53.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 06:53:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, devel@lists.libvirt.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH 3/5] hw/mips: Include missing 'cpu.h' header
Date: Mon, 11 May 2026 15:53:09 +0200
Message-ID: <20260511135312.38705-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511135312.38705-1-philmd@linaro.org>
References: <20260511135312.38705-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

"target/mips/cpu.h" is indirectly pulled in via the "system/kvm.h"
header, which next commit will remove. Explicitly include the "cpu.h"
header, otherwise we'd get:

  hw/mips/mips_int.c:29:5: error: use of undeclared identifier 'MIPSCPU'
     29 |     MIPSCPU *cpu = opaque;
        |     ^
  hw/mips/mips_int.c:30:5: error: use of undeclared identifier 'CPUMIPSState'
     30 |     CPUMIPSState *env = &cpu->env;
        |     ^

  hw/mips/loongson3_virt.c:156:39: error: unknown type name 'MIPSCPU'
    156 | static uint64_t get_cpu_freq_hz(const MIPSCPU *cpu)
        |                                       ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/loongson3_virt.c | 1 +
 hw/mips/mips_int.c       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index cd94e9f5f77..c29cae86872 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -51,6 +51,7 @@
 #include "system/runstate.h"
 #include "system/system.h"
 #include "qemu/error-report.h"
+#include "target/mips/cpu.h"
 
 #define PM_CNTL_MODE          0x10
 
diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index 2b740afc4d8..fa9c78e74de 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -25,6 +25,7 @@
 #include "hw/core/irq.h"
 #include "system/kvm.h"
 #include "kvm_mips.h"
+#include "target/mips/cpu.h"
 
 static void cpu_mips_irq_request(void *opaque, int irq, int level)
 {
-- 
2.53.0


