Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4259D172A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgts-0004ot-LB; Sun, 01 Feb 2026 18:30:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgtd-0004EK-Lr
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:30:28 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgtc-0003Ih-5f
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:30:25 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso34669535e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769988622; x=1770593422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ndt0lbeDD0ND0g1x/Jn9T0fK6A3JG1sO3tAPHAKkC/A=;
 b=gif+MgpG8c7ywLj5Flsz2AYJkmQJt+rfvbjor9UGiOFVSkEHe3JRrjXVG3nIczkoRk
 Fg8pY3o4w++9vATyXIDTAYktg6xjO2YLI1kgWYJW0c+gHViCQPKh/O5rhDXT0U5oxE6O
 Q9YlVgiCuU8131/lwJTcmG+t+7ZuYY2qShZW7G2+RQ0z0dX1f4tciDsKClDXCLohPtz+
 v8/iB/IA156D1hM/dHJzmzQW5lIQu/h8jrVPlJg92kvEBTRNAtkpkZunj5gxLM2sBoFZ
 zxLdS1ij9OrwmjNFXHtWSaUpMFjQX1z79eO804lYfctdDoGyWsJRqNbEE9STBw7tJLZu
 6qCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769988622; x=1770593422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ndt0lbeDD0ND0g1x/Jn9T0fK6A3JG1sO3tAPHAKkC/A=;
 b=LDtg5PKkjXB9xE+L8uExMtjEfitOlKztRo8oSduOIsrtOoruZikp7iZ7qqxitWkhwB
 +sw4WqO7nJEKUX/1lSfr8iJQN6p3mc2f/cbDjKme89tzPq+68uxnnmMIqiK5aUVSqRdE
 6KIq786H17GZl7rgweZUCPUGB3qQStaXH0lM0oVMA0WTDzgIq8FrPsQm8vw2t3hNZIBe
 cvpf+CoCcT/YumUHDLWFUFPTkxt8QO+WoYJ6qw57DCDzPQ8+YhYIHv8cyf28AioXRzDA
 D0ujH/vzgmcURr0/Kl6b0KHTw9dv1tyvDjkaPIG541cqdKtbYsOpz8FUGixkU+O9HNrq
 sFzA==
X-Gm-Message-State: AOJu0YxunG+NKtK71jfwemxdbLK3llAdIi2iEnmyzMznWhi6NpPEWBGT
 seDTGAMevYilIxdaxf48JCATdTx6JtZMgVTOulhvkJP3iFej+XI7eVSBq1Sot5NucepALB06phE
 azSxr6Yw=
X-Gm-Gg: AZuq6aKL0fG61CG9evIUc2I1V+O9ca3tz5ryoVbp5nUqBSYlhT2M5XND7DNlf8GX1pX
 SJN+3l+gsP0XGx4wwCjnaJU8pHVbbri3qrVQ5vzuzuLMpRn5LsfAiL/d00sNmt3TFZRiyZbyU6g
 muzaKXtEmyJ5R3Sd+hwi7S+j7J1JwpZKbcqiplxI+8faO0PBS2kHi5q2f6TSt4ILjwNZE+Nl8Gl
 7GSuoK8cVCQ/fUD3SuLKDQINkxRqWvQPwPkzJO89VG9GLIjIvg46MazfVEKLR8jgKkmiRIwa4z8
 npYShWBuaxNzO6+jzggZT/PrOda73hWovabJV5HkY55Os+GtT5kDXSpBpeAhZIoJpIscm51FK2m
 YHKsupN7aQ7RjrAk4jnEY445iYJqctxM3GyXVFS+q8NzWQp7zIemEyWaSsQPJ1D5Zbfa/MAaKLa
 PS+wtnKCm58AgtIYqcPmkJ+47XJdEEpmBTJ7iwdp5uxE+PAcNJzuxPo/NbKper
X-Received: by 2002:a05:600c:19c7:b0:47e:e981:78b4 with SMTP id
 5b1f17b1804b1-482db477009mr143262975e9.12.1769988622247; 
 Sun, 01 Feb 2026 15:30:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10f82aesm42482450f8f.19.2026.02.01.15.30.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 15:30:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 08/11] hw/ppc/spapr: extract SPAPR_MAX_RAM_SLOTS in a new
 header
Date: Mon,  2 Feb 2026 00:29:20 +0100
Message-ID: <20260201232924.93399-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201232924.93399-1-philmd@linaro.org>
References: <20260201232924.93399-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Allow to include it from common code (vhost-user, in next commit),
else it pulls ppc/cpu.h which has target specifics.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/spapr.h        |  8 +-------
 include/hw/ppc/spapr_common.h | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 7 deletions(-)
 create mode 100644 include/hw/ppc/spapr_common.h

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 5476ac7ce7b..b022f8dd25d 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -4,6 +4,7 @@
 #include "qemu/units.h"
 #include "system/dma.h"
 #include "hw/core/boards.h"
+#include "hw/ppc/spapr_common.h"
 #include "hw/ppc/spapr_drc.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/ppc/spapr_ovec.h"
@@ -946,13 +947,6 @@ int spapr_rtc_import_offset(SpaprRtcState *rtc, int64_t legacy_offset);
 
 #define SPAPR_MEMORY_BLOCK_SIZE ((hwaddr)1 << 28) /* 256MB */
 
-/*
- * This defines the maximum number of DIMM slots we can have for sPAPR
- * guest. This is not defined by sPAPR but we are defining it to 32 slots
- * based on default number of slots provided by PowerPC kernel.
- */
-#define SPAPR_MAX_RAM_SLOTS     32
-
 /* 1GB alignment for hotplug memory region */
 #define SPAPR_DEVICE_MEM_ALIGN (1 * GiB)
 
diff --git a/include/hw/ppc/spapr_common.h b/include/hw/ppc/spapr_common.h
new file mode 100644
index 00000000000..a315b685805
--- /dev/null
+++ b/include/hw/ppc/spapr_common.h
@@ -0,0 +1,17 @@
+/*
+ * Common definitions for PPC sPAPR
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_SPAPR_COMMON_H
+#define HW_SPAPR_COMMON_H
+
+/*
+ * The maximum number of DIMM slots we can have for sPAPR guest.
+ * This is not defined by sPAPR but we are defining it to 32 slots
+ * based on default number of slots provided by PowerPC kernel.
+ */
+#define SPAPR_MAX_RAM_SLOTS     32
+
+#endif /* HW_SPAPR_COMMON_H */
-- 
2.52.0


