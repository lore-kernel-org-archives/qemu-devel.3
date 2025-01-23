Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90476C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 23:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb6sV-0006IQ-1C; Thu, 23 Jan 2025 18:44:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6sS-0006Gk-Gh
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:44:48 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6sP-0003wm-Pw
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:44:48 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38a8b35e168so1073183f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 15:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737675884; x=1738280684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=89WHzW+ji4rB+60gFYzeRD9ADgUNDHjcXvYSPMINgc0=;
 b=IUCLje6AsykLpWFfkO2DPFz3e1nLIYD10d6w/vMvcWhKSLSKROfqvYPg4W3ifaK0sO
 z/txwjr0lY1M/oRcf3nk3Zf68DhZsZC4FOlCc8l4WzYUiHnsbEmGelRF1/wDm8mWzcZd
 51wDyPdo0FDgTVMpxcnYN2eST92TE1eZUWCTUUe+dnJ0MGZNxkpraRCea5+aXUqyzlQ2
 beA3qEuSULdpeCWrvqHc1gZ61g7zGXbMzkjFTehA1EpkND/LdO1ar5zyv6UzTUtUaGei
 K+wIJwN4i0k9ObTh2nqLB4MbtuMuUHz862nE+4aRjrFOGg+TGWDjWhhKRcCsKgo0U+nG
 XAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737675884; x=1738280684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=89WHzW+ji4rB+60gFYzeRD9ADgUNDHjcXvYSPMINgc0=;
 b=wuZ2wFf3ENMYotQ9oGqS11vLrlppECbtPQ66nL6HID4ZQfblZkEPi0O4d4XMmrx6RN
 NfCEh+oVkXuMHr6xUGaZojj7q6XRNCfnYrFucu7BQIWCWNByZAXq/pRmSZRJqIk1tNPz
 KszsE0qQnIXFy9hvPCTahxJ9N0ycx0hP8VBV1z8trjxaQyMwgqJrCR1L0wduGWECynbE
 staDYUkEoZSAPFL8ZUQFA/vTVmPFrlen6zOGoYsXbxApHucqDCglP8f/H2FxyKFowGSN
 86agIB8BBwIZc5hy0H2KmEDSQeA6c38jcM5cGF5P/A/tNL1hJfok3Ud0qgE+G3bWAMlI
 RotQ==
X-Gm-Message-State: AOJu0Yw9xLQrV4lr5Vbt5XHHv+2f7+vw3lLwEkNtIxs0L7vHmJlkyc6e
 EgncVs9tQ544Ppb3PvD4rVLlYYWMdXbtl36cGsrU1h1qjJ3BylxkBh88Mie0TEMGEX5kP9RheM/
 YgjM=
X-Gm-Gg: ASbGncsHPYio0cNrkwgHQbax6ZkBI9GeVsC2I8Bau7wl8FBrps8qubtYWsBR+ppd/q9
 fw53zJhtKKAQIb1oYP+AV2SphOv3qDnoz5tDHEUpeWzJ2fx256PV488JUJOtsmjpWeWs8j/fghw
 mdO4z1YBq7j2MQuLlAI6Vh2hE88WjGRX1qvLaHf/CmwUspuuHPkLO+z0g/Y9z35PUYq1OmvcRDP
 re6DY0IRx8821a3MBEGiUEWhCVdx/hYus1YZZ9Ri3EBE7B44a+YJw3B0zaZqiJNedlGfNi2voY/
 U6qRvEutrVYpyw85MZ8jiyeX4HmnZ+9LItAdE5+RdPlctaWg452wOYM=
X-Google-Smtp-Source: AGHT+IHfcp2D5aSm8Sn0VT4IidLdBYhD/KSzWcZHka724j1qpNfMP/dVIsxPCprx8nPoBb5TgAtEpw==
X-Received: by 2002:a05:6000:1fa9:b0:38b:f4dc:44ad with SMTP id
 ffacd0b85a97d-38c2b65ebf8mr997845f8f.5.1737675884076; 
 Thu, 23 Jan 2025 15:44:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4d29cesm6991745e9.35.2025.01.23.15.44.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 15:44:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/20] cpus: Keep default fields initialization in
 cpu_common_initfn()
Date: Fri, 24 Jan 2025 00:43:59 +0100
Message-ID: <20250123234415.59850-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123234415.59850-1-philmd@linaro.org>
References: <20250123234415.59850-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

cpu_common_initfn() is our target agnostic initializer,
while cpu_exec_initfn() is the target specific one.

The %as and %num_ases fields are not target specific,
so initialize them in the common helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 cpu-target.c         | 3 ---
 hw/core/cpu-common.c | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 89874496a41..75501a909df 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -234,9 +234,6 @@ void cpu_class_init_props(DeviceClass *dc)
 
 void cpu_exec_initfn(CPUState *cpu)
 {
-    cpu->as = NULL;
-    cpu->num_ases = 0;
-
 #ifndef CONFIG_USER_ONLY
     cpu->memory = get_system_memory();
     object_ref(OBJECT(cpu->memory));
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index ff605059c15..71425cb7422 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -244,6 +244,8 @@ static void cpu_common_initfn(Object *obj)
     gdb_init_cpu(cpu);
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
     cpu->cluster_index = UNASSIGNED_CLUSTER_INDEX;
+    cpu->as = NULL;
+    cpu->num_ases = 0;
     /* user-mode doesn't have configurable SMP topology */
     /* the default value is changed by qemu_init_vcpu() for system-mode */
     cpu->nr_threads = 1;
-- 
2.47.1


