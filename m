Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5FDE77188
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8co-0004Lr-Bz; Sun, 12 Jan 2025 19:48:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8cc-0004KK-GN
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:48:03 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8cZ-0000hC-P9
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:48:01 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-436a39e4891so25845445e9.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 16:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736729278; x=1737334078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/OQZjDy+9AZ385RtNjGyKnjx3vgcN7yxotXGYLE1Pg=;
 b=duU8Ei8wr2aulTD8egwK6WzBqiMGohM3lseV/Ox7JDDw/sZ1uLfqQoH4tWEvayTqJq
 6pt0NSa6at4Y8H2EQc1uaJ/lhe3U6fKYuocdpqvXcRilg/4en+Ozzaxqw3KpYyylXZ0/
 8EIjWOC4nNrdj1zK+/AD5WWxqMGwJx/hWuNJGuz/C5cDLiMdFwJZlmI1wVoVdhwEC2zr
 Lpz4Q5Rr/sg/+CDRldXwc49OZtMRqSmzuDXIM9llI9mnB4JfQQx8G9p9nGlvsBgrowzU
 Bel13IFeiYwVQZ9NMu4UW3xXFaLEP1bDjkkBsNuOvTlUzR9TDBh/keL9Kj7ysUNt+gFH
 N9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736729278; x=1737334078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e/OQZjDy+9AZ385RtNjGyKnjx3vgcN7yxotXGYLE1Pg=;
 b=uWPIrgy0d6h12b2VQWkONinYRo3RaH4Wafx/NNjTvXYSMqhZRSBAoig6w9NVLUyNCl
 KaUJ3C6qa5QytqsCXSIRXm2j80Oot8g3JTMe55vgWClRZPwUYQk8Ed+ryUgk8ZdEXjL7
 NyJs4ivvL46KuwsTyvx7SE/iQ3UKw7ojJfeba8Miu58FduPFgoADUprl42gR/LS+YEjh
 wVnnYJT3Jq8ViN9QNrylKKO6QChBT3TRN7KrBq9SONVjR8WkTYBaiXZYnasjEk2pwH8H
 HSYoKaPQM8dk6TsnzCyblHXUit/YowmrmgOFc1vXHt62PizFfUBbMRQjFy+N4RzfYesn
 zHow==
X-Gm-Message-State: AOJu0YxqeLVsEqhRBKgAVOo1BAib4PGSfdIrRqrrCzABCfC0gNUYaqf3
 tQcf/MJaaOJWcwwJ4dsm2vNwqdk5Z2rnaP7D/yZWr17DOorEnAHf88PByTKwOMMEiB6gSGfHjua
 K5Q0=
X-Gm-Gg: ASbGncv84SvhuEIGbw94BEto+tfVCHmdmWx+TN1Y1ERMEOmWgmV0ICR7K/BUVCeT2Vr
 a56gdIGGZyuxcfBy7LNEsvc/ojxTeNQ5fNw1taqQdUAsr1YXwjdUIsJB4ZHTYCxs8ECo6yzEXi8
 7VkttzNs18wLgxmagK15HI/9SWvPaiNpHcx/Yw6Pl6BrBPdv1BfgUddZA3C4i6smZS6REomysfG
 xWjzmKboLTTCayGp9tNeJBaKR7YVM02eIHWPMa2cSJZ3psXyYgMUmfdAOTxITzkuJoecjlxgmFO
 4D9ruwBE7fJe6jGzyjg3GqR+R8r4rCo=
X-Google-Smtp-Source: AGHT+IFmyIk7L9Tk2SPY38KgfSt4E6nYM8ctmJsUIUEGZmu+L8SltrZOXWVvb2mDFIN3G1xiefNAPQ==
X-Received: by 2002:a05:6000:1f85:b0:386:4a0c:fe17 with SMTP id
 ffacd0b85a97d-38a872e9105mr16097785f8f.27.1736729278044; 
 Sun, 12 Jan 2025 16:47:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d0casm10891447f8f.11.2025.01.12.16.47.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 16:47:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 01/23] hw/mips/cps: Keep reference of vCPUs in MIPSCPSState
Date: Mon, 13 Jan 2025 01:47:26 +0100
Message-ID: <20250113004748.41658-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113004748.41658-1-philmd@linaro.org>
References: <20250113004748.41658-1-philmd@linaro.org>
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

When a QOM object create children with object_new(),
it is better to keep reference to them for further
use. In particular, this allow to remove one global
&first_cpu use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/mips/cps.h | 1 +
 hw/mips/cps.c         | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/hw/mips/cps.h b/include/hw/mips/cps.h
index 05ef9f76b74..0968b57c5a0 100644
--- a/include/hw/mips/cps.h
+++ b/include/hw/mips/cps.h
@@ -40,6 +40,7 @@ struct MIPSCPSState {
     char *cpu_type;
     bool cpu_is_bigendian;
 
+    MIPSCPU **cpus;
     MemoryRegion container;
     MIPSGCRState gcr;
     MIPSGICState gic;
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 293b405b965..494213b2ab6 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -73,6 +73,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    s->cpus = g_new(MIPSCPU *, s->num_vp);
     for (int i = 0; i < s->num_vp; i++) {
         MIPSCPU *cpu = MIPS_CPU(object_new(s->cpu_type));
         CPUMIPSState *env = &cpu->env;
@@ -91,6 +92,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
         if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
             return;
         }
+        s->cpus[i] = cpu;
 
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
@@ -146,7 +148,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
                             sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gic), 0));
 
     /* Global Configuration Registers */
-    gcr_base = MIPS_CPU(first_cpu)->env.CP0_CMGCRBase << 4;
+    gcr_base = s->cpus[0]->env.CP0_CMGCRBase << 4;
 
     object_initialize_child(OBJECT(dev), "gcr", &s->gcr, TYPE_MIPS_GCR);
     object_property_set_uint(OBJECT(&s->gcr), "num-vp", s->num_vp,
-- 
2.47.1


