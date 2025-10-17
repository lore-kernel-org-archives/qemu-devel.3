Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FE0CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kDG-0003jW-WA; Fri, 17 Oct 2025 09:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kDC-0003fn-Oc
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:09:38 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kCq-0004Z4-TK
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:09:38 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-471076f819bso15516855e9.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760706552; x=1761311352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/GqgVIjIVxL9Bk7BWZfwdZrQ/R8VZlnoVGR9k0eNJZE=;
 b=P3ADTI2ObpzYGdRzEIUrIeecDvc2ADgodLxuOKJ0MPOOfoYbbT/lKFJud+GjbUSSid
 Wzfojc9DZZycpUgRcxswGWS5G1JFTTRGrlWsQO+N7W5r+QLuy6+4SX+XofqMbwyn45sF
 kJ9YwpU6CURc94AltMxutEnT/CkwzbiZnA6puxmThgsMUZjzna3JN8cujk6fVzUfaiF3
 zXxqwWc1HymcbuVM+oUkxWs6o2xp3NgaSFrSutvj340SOHxQce9aUbuxTowa4EJyPPjW
 Z+veDerSNLlCEKVmRCDUJiEmLUaIVafOfS5aQs9NkP9s89vkpVPsRlfnMxX/0iOzPOnp
 ePag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760706552; x=1761311352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/GqgVIjIVxL9Bk7BWZfwdZrQ/R8VZlnoVGR9k0eNJZE=;
 b=V3uTwGt7GmwG92dbDXD5M4ki3jHXm9Xj9w1OTIp1Gx9CIeD439EP26JAiwH955w1y/
 IfP6Ge7jXmKd+uUar85+JDrkmQ0C3bqxf6nCr8q6tHxaAuHLkhLjWX0IbXk6voPb594/
 TG1ZusGhYX3riLjJMyX2KoFhC8+T6Ti1BVRPFV/On3r/UaIhKM+RHyZsTsZRKy4ak8a6
 Rv1Sj6dBNNh6KuEFcEs+SgRRfAheTTaQTocnUvzqzS52ptdwmEhTAzbnFGU1NAM7zKvA
 cJQa1vyeP/OlPLVKQeFAvPbN3y97Ymypr+xLsv892zNMZR5S0UwTJo3mwtZSy1x1DZaD
 d3BQ==
X-Gm-Message-State: AOJu0YwgVQ2jpj1k6CL8rkGStdHVTnCxMQdvzsCsnLBS1zeAJOf1EA48
 U/9oQboMyoArnDF5n+PLLowZrHPCb0/wDgdh10bZ0XATOr0HZSqiPFRbZmfr4TpEY+lkkOj7imf
 f2lFMHP0=
X-Gm-Gg: ASbGncsa2GF2BETxLwpyef97JaC6D9vqO4CzyurFpP7eOq69dOHMHi8Zhc8mBp11uGZ
 ExXH/ZK49mFYjz1MIdVTTKyCP2V4mpDfqggrZRz6GTRg5RtQSx9n2UBtrNqEOyVPn9B4+G8liuU
 C6FKzfv7Mg1tWqWYCfQX0RLfVMWqpG6otXdJHPGVAr/ByM3FOoP/VN54BeswsFm3mvp3HTN+Jxt
 uKWzKHx2aIpnKFj9T3xRRdiSG7KM3AQAf8iIzOyzTZ6FIJOo4RRq9py1xMkDRKMH1o3ntQVLxj4
 +zCeG11rskThrQ+VT8FxTfMkUjLdWPIPU4ECoF+GX048o9vusfleix9E37qrmCNG4mln5I3kYcn
 cdah/WimxNzIZECvPUNlJNv3RYPtaUsOYaBlqS/fn578T5F+p1goyF/ZA8LNixAHiLxSRY+yh+E
 lL55ISJ+Oc+RIWhBP4/KpMbquchZZHzLpzl7uGZuanv0kQ1ZaY0zASFtMKj6SQkc7/59kvD4g=
X-Google-Smtp-Source: AGHT+IE8PhpIiHfHWpHcb8zHxB6YySKZ3L4Z+1bd8cjkOVSeAHxTMdwlRmXGPYuQj0ra9V8k/mg7sg==
X-Received: by 2002:a05:600c:8284:b0:45d:d505:a1c3 with SMTP id
 5b1f17b1804b1-47117920935mr31315235e9.37.1760706551922; 
 Fri, 17 Oct 2025 06:09:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e10e8sm40948238f8f.39.2025.10.17.06.09.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:09:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/20] hw/arm/virt: Remove VirtMachineClass::no_secure_gpio
 field
Date: Fri, 17 Oct 2025 15:08:09 +0200
Message-ID: <20251017130821.58388-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017130821.58388-1-philmd@linaro.org>
References: <20251017130821.58388-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The VirtMachineClass::no_secure_gpio field was
only used by virt-5.2 machine, which got removed.
Remove it as now unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/virt.h | 1 -
 hw/arm/virt.c         | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 96f3569c290..c5ccd6ec9ea 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -123,7 +123,6 @@ struct VirtMachineClass {
     MachineClass parent;
     bool no_tcg_its;
     bool no_highmem_compact;
-    bool no_secure_gpio;
     /* Machines < 6.2 have no support for describing cpu topology to guest */
     bool no_cpu_topology;
     bool no_tcg_lpa2;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e49af505431..33c0034b030 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2510,7 +2510,7 @@ static void machvirt_init(MachineState *machine)
         create_gpio_devices(vms, VIRT_GPIO, sysmem);
     }
 
-    if (vms->secure && !vmc->no_secure_gpio) {
+    if (vms->secure) {
         create_gpio_devices(vms, VIRT_SECURE_GPIO, secure_sysmem);
     }
 
-- 
2.51.0


