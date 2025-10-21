Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34FCCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 08:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB7zQ-0000cV-2u; Tue, 21 Oct 2025 04:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7yk-00008z-3v
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:44:32 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7yi-0000xP-8Z
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:44:25 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47100eae3e5so8719905e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 01:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761036262; x=1761641062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qI+hF79G3saS4cJM9gBn0qvW7x/aK3K4EItDfXm9eIU=;
 b=ETsqUbdKHnwMAqctzEbyxKSbNzR6g2eLtI12NigYzvBcytiCys3HaXU0WpbnUH9evv
 qv5VseI4ff4VUsPEov94zg/YHFwfc4rogamcUKYa0sX6G9y+ojth6c72RA2sP4R2bxNI
 fKmMSJ86blPBHvh/rLS0A08ZqTAMu9gWMPU5S7gJ6y2wUsIDgnCQJ/JjJKfg6DhOWAe9
 DtAl/joz033KNq46tTX9Q788/vdR+v0h54zDSIFk7dpHCNCkQdlcY5DvxkeF0lMDztt8
 X/p6Tczw4CaEIWPraOOs8ZLKKMtMW7P3n/5mys8VzZXzNEdV9dGOY9sSphCrZRoQ45sy
 C/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761036262; x=1761641062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qI+hF79G3saS4cJM9gBn0qvW7x/aK3K4EItDfXm9eIU=;
 b=sNIj7D+bCJHCtQs5Aha4BLmUY0CFcaOvNi0g2PU+udwODIjRVsqG1/sFQIYTPxnkcC
 uP5o152NVnT2JNHwY817/ZlAwjfpA4OA1WsYPzN4R6nneRv1xgXekuQ8SdFWNtM12jGC
 AHLTsWyf38ToKyxb4DyBFPQtztURvSlawEJ+ccUZ7XfOP3NObAWYix8qLSyVuLCo01dE
 JtcIeQmTXcWEBtptCIMFZadnKN+puPltpRYI4ybJkE/K+NU4ulIosdanwpMH/lZiXyR2
 Y+7PSnMvJPwT9w0bY0T1yKsahHeCoIBM/4B+YMowgZgnVbts4Ovh0rPiaMk40Gw1WiOD
 VfBg==
X-Gm-Message-State: AOJu0Yw8vVy+KNMprUT9Wp3aNG7efV4fvziAxEYMowQY2C4TaPCqpWYA
 CX5cclBG6UTEPREQPjCwwGZzmo/uUjVWjz3ZtjhvEViHRU0kzLeULi3MmQsiUyoeyo1iCg2rFaJ
 +gZuXmIE=
X-Gm-Gg: ASbGnctWg3DI2sv2+7VgeV+gyQC8N+CtFN2/H89QZAyWoCeKjrj/hWaabIbo2ozge6U
 Kz5UcW23jwPMINYArwHOIAbASwpnYtaynOIutTORSdoaK2jHSFSXwhh6VasPNVuv+iiy/ZGRkwc
 cNtAAteJn+L3wQV0JZla7xrn0qMpktLhOFuUsAOz1vzDpEpEy5oUMzWQYvLa3LfGHdyQR69F5Ve
 NqdhF6SRPi5K/PutHySGv0j6INQv/eIXFeUiI8v4B8ouijO6cR0BmamjasXmODTiif8uGcaGJUb
 rhgjdKOUjaoAE/Wglo2WMb9S4TgKup7XFQRwPLDA4Yu7qRzNsSG59UbkMoRu7jTiivKFwCyrFhh
 7NFkeMyfpi4gujfOr4ZZds57uemX46zEznql9aK+qRUWf6/UCd22779ehNggguVk/iqkK5o21qc
 QiKnxcPzxytcB1nYIxJ+60H73iGkyf7KL2ibMqia5DRRk5MKUqUw==
X-Google-Smtp-Source: AGHT+IE8rS6VZYx/i8JiXQJLTMpGlcor/1LQLKzg9IWBTT3rtLq5Bk5Lslt0pycRlR21ilSWorrGLA==
X-Received: by 2002:a05:600c:8b62:b0:45d:d97c:235e with SMTP id
 5b1f17b1804b1-47117876bcdmr112776075e9.12.1761036262467; 
 Tue, 21 Oct 2025 01:44:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a0f7dsm18934148f8f.4.2025.10.21.01.44.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 01:44:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 07/11] target/ppc/kvm: Remove kvmppc_get_host_model() as
 unused
Date: Tue, 21 Oct 2025 10:43:41 +0200
Message-ID: <20251021084346.73671-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021084346.73671-1-philmd@linaro.org>
References: <20251021084346.73671-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/kvm_ppc.h | 6 ------
 target/ppc/kvm.c     | 5 -----
 2 files changed, 11 deletions(-)

diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index f24cc4de3c2..742881231e1 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -21,7 +21,6 @@
 
 uint32_t kvmppc_get_tbfreq(void);
 uint64_t kvmppc_get_clockfreq(void);
-bool kvmppc_get_host_model(char **buf);
 int kvmppc_get_hasidle(CPUPPCState *env);
 int kvmppc_get_hypercall(CPUPPCState *env, uint8_t *buf, int buf_len);
 int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, int level);
@@ -128,11 +127,6 @@ static inline uint32_t kvmppc_get_tbfreq(void)
     return 0;
 }
 
-static inline bool kvmppc_get_host_model(char **buf)
-{
-    return false;
-}
-
 static inline uint64_t kvmppc_get_clockfreq(void)
 {
     return 0;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index cb61e99f9d4..43124bf1c78 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1864,11 +1864,6 @@ uint32_t kvmppc_get_tbfreq(void)
     return cached_tbfreq;
 }
 
-bool kvmppc_get_host_model(char **value)
-{
-    return g_file_get_contents("/proc/device-tree/model", value, NULL, NULL);
-}
-
 /* Try to find a device tree node for a CPU with clock-frequency property */
 static int kvmppc_find_cpu_dt(char *buf, int buf_len)
 {
-- 
2.51.0


