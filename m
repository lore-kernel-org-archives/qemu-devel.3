Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494DDF417EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbyG-000522-25; Mon, 09 Mar 2026 10:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbwc-0003wR-LV
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:50:55 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbwb-0005hS-0v
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:50:54 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4853aec185aso10215175e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773067851; x=1773672651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Uao/CKWcfJ+UFrA+3AmPlD8nKqx8My4/8hpgD51tDU=;
 b=EtBZjDEwOkSKHu68pjYBoC8aJ8iPVq5CAQFVQubYPKJxi+cRH7kTkE7MYkMu7vFhPz
 VaGEVRT4bH8QE1D/NKajcmEGiSMdyWSzQG4OCwIoVDJyrt3HnVkvh5krFCenci4WY3eM
 fGSeg0RtbMBdUpR5cY5jclvmqDwMFDHwR5LeTEU0Au+HLk6s90RDFtAq/aVAm/n1XLId
 PEzZdubnMi2AjxpGTJyl92OslP0xlmRSEmY0h1gtCDwoa1fWl7Wzf9jT560wXmxTB2gT
 es4dCuoRga6yFcgjdexrZPs7kB8DeU90nVJGWA7pJ+V+ffvAWxG+bgtQqQ9tfDRfXmBm
 9mTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067851; x=1773672651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Uao/CKWcfJ+UFrA+3AmPlD8nKqx8My4/8hpgD51tDU=;
 b=GXj+HL8sner0X1lr3kfALNd+hGouutKDrzwkf47MaZywDykcppL1pQJUzHM0QylOnu
 IpwNSNGwDcGYDnmTHLgM6/lW3Rh/RYnsveIBgMBSUvMBYlkqj3gICoxjpCjslb4/UmEb
 IRMGwxlPilsDxe+CaKLQrV3oLfhfq0h049uOh3AGnQ08vrlqXrw4gTWLSKt5JVWvz467
 BUFkFFC1o86KLwM6h/5Jpp0Y+I0SCmAYLfMZwsHPAkSDhyv+EnqyI5us46v4NPAD/Nx+
 PozAmQSg/jLPx70gO1DP9GRwiO/7MZjzaGcofLAf1yGKpUDVKwH8fpe//H9xpXcykyC4
 PbOg==
X-Gm-Message-State: AOJu0YzUXu8gro1nUslF9wK6CmXIwE3a8C6fSH9c6ijdomfRt5fAUiof
 lKdlSXvn5GEFU7HgRuZMPYkYKBZcMTQKnjTIbkAUlnkFiuesIHFCp5QJBAm5lV1J/a1X002P62O
 0eR9vsrA=
X-Gm-Gg: ATEYQzw7DoY9QgRIIylDLEdjlCuB9/dONiUhABz7rI5HHk/Oqds9JvDLsMHvjPM+INM
 Tag86pifFyiwvlsJFYkaO5IbokVw2XF0IO/2lNWphA8YqhuH6sodAr1KlwV6ruAqfQYOZU/RNNt
 NNG/MRzNV9sK2u1KEk7NhE6FrcrJku3aUtYO5yTtcvYhHfFIrr8Kha4CHfBhjTW1wjjMxY5I5YR
 Jx7irCLunr73bwOPo5vBVs+hMqz4S9vkdWOMjWKp3t+rq43OaQrPJNeZTgzDyK3zl3udx+AtXCT
 iVGMwr12RqgqKg32JnEwfasY15sFBBlWMMS6ykQ4+oIHnIq7py+0ClIyy7D4QH6n66Vs2BNQhhR
 yeEuUfP6mCVSVbBxv0cMZ9vTUxXkgeKx+0dUN5GhKPg3+TSJHNIJi5trBtdBpRP+eBbtcuQSoHP
 3NAQ9iJJFEH/R/KuXXnYNFYZ3kBuVQK2g+WyCtgf3LdI9S6TcdciAwLBtBEyoVgaYH6r7vrXJ1d
 jklLGkXZwyY1aal
X-Received: by 2002:a05:600c:8708:b0:485:3c8f:e4c5 with SMTP id
 5b1f17b1804b1-4853c8fe526mr37311855e9.17.1773067850991; 
 Mon, 09 Mar 2026 07:50:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48536b5b3absm40687275e9.32.2026.03.09.07.50.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 07:50:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 05/10] hw/i386/pc: Remove pc_compat_3_1[] array
Date: Mon,  9 Mar 2026 15:50:07 +0100
Message-ID: <20260309145013.44327-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309145013.44327-1-philmd@linaro.org>
References: <20260309145013.44327-1-philmd@linaro.org>
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

The pc_compat_3_1[] array was only used by the pc-q35-3.1
and pc-i440fx-3.1 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260307152635.83893-6-philmd@linaro.org>
---
 include/hw/i386/pc.h |  3 ---
 hw/i386/pc.c         | 25 -------------------------
 2 files changed, 28 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 908de5e1eab..4e1dd436ab7 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -271,9 +271,6 @@ extern const size_t pc_compat_4_1_len;
 extern GlobalProperty pc_compat_4_0[];
 extern const size_t pc_compat_4_0_len;
 
-extern GlobalProperty pc_compat_3_1[];
-extern const size_t pc_compat_3_1_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 00581dd8b44..f33e3f72656 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -180,31 +180,6 @@ const size_t pc_compat_4_1_len = G_N_ELEMENTS(pc_compat_4_1);
 GlobalProperty pc_compat_4_0[] = {};
 const size_t pc_compat_4_0_len = G_N_ELEMENTS(pc_compat_4_0);
 
-GlobalProperty pc_compat_3_1[] = {
-    { "intel-iommu", "dma-drain", "off" },
-    { "Opteron_G3" "-" TYPE_X86_CPU, "rdtscp", "off" },
-    { "Opteron_G4" "-" TYPE_X86_CPU, "rdtscp", "off" },
-    { "Opteron_G4" "-" TYPE_X86_CPU, "npt", "off" },
-    { "Opteron_G4" "-" TYPE_X86_CPU, "nrip-save", "off" },
-    { "Opteron_G5" "-" TYPE_X86_CPU, "rdtscp", "off" },
-    { "Opteron_G5" "-" TYPE_X86_CPU, "npt", "off" },
-    { "Opteron_G5" "-" TYPE_X86_CPU, "nrip-save", "off" },
-    { "EPYC" "-" TYPE_X86_CPU, "npt", "off" },
-    { "EPYC" "-" TYPE_X86_CPU, "nrip-save", "off" },
-    { "EPYC-IBPB" "-" TYPE_X86_CPU, "npt", "off" },
-    { "EPYC-IBPB" "-" TYPE_X86_CPU, "nrip-save", "off" },
-    { "Skylake-Client" "-" TYPE_X86_CPU,      "mpx", "on" },
-    { "Skylake-Client-IBRS" "-" TYPE_X86_CPU, "mpx", "on" },
-    { "Skylake-Server" "-" TYPE_X86_CPU,      "mpx", "on" },
-    { "Skylake-Server-IBRS" "-" TYPE_X86_CPU, "mpx", "on" },
-    { "Cascadelake-Server" "-" TYPE_X86_CPU,  "mpx", "on" },
-    { "Icelake-Client" "-" TYPE_X86_CPU,      "mpx", "on" },
-    { "Icelake-Server" "-" TYPE_X86_CPU,      "mpx", "on" },
-    { "Cascadelake-Server" "-" TYPE_X86_CPU, "stepping", "5" },
-    { TYPE_X86_CPU, "x-intel-pt-auto-level", "off" },
-};
-const size_t pc_compat_3_1_len = G_N_ELEMENTS(pc_compat_3_1);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
-- 
2.53.0


