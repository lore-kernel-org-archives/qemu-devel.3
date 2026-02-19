Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19D2E9A053
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7mO-0003ff-JZ; Thu, 19 Feb 2026 12:25:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7mK-0003f5-5t
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:25:30 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7mF-00023h-MF
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:25:27 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-65a36583ef9so2493514a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 09:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771521921; x=1772126721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TlxnWY3WbQiT4E/p8Y0OKDOkVWTi7VBe2yqZtOJIOQw=;
 b=D+mOLxD3W6lxg442yuBeRDYwSERBrMrAZdaKzDQl8X/9NZkObQMbVSNZyxlCmzcxfh
 giA6H5EcriEBDhdh5DKh2hGJuNmDaD9wIi2sDi4pVepGbz+szohVda1KKJ2nhRVDoqBa
 rks6AB+QC1C9n+mXXjYn6lxtqChRcOfic22g4+rUVHjy0LUvmrVy6/JgZq2BHyELIAce
 tU4AskXc5O498cwVkXKblPKatqZejR5iqKvewQSDSbhK+ksiv5Sm1NLGDT7fiv0eCoTG
 vSpA1mi+rjOwykdF7CigGJta0Q0FfYyj/QKjVI8lJ/8cMAgLVozrUJCnzGxLB+TlAfQO
 d9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771521921; x=1772126721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TlxnWY3WbQiT4E/p8Y0OKDOkVWTi7VBe2yqZtOJIOQw=;
 b=kDqIc48ay5mC8hve4oZCxIPd50VbyDuv8UY09fqbROR3trvooKMR0SUjXoq1Wp5y+a
 2JuY4oBj0FQ8920EEAyhi1OwqBvxEmAQsSBP7zlaSBrPM8HxD/Ei/3cooh0BDfucjwkG
 Nn+UPYXbO2+QNYlYvgk+V67/2kOKlhJJk63Tx92HWkvwjFsdIG5fOPwKvY2YFTAKQpEw
 Tz7Fe+iGGPxBec6+NQyfrsyhR8jik1I7QCWCFe8nDryukjicHGurgjBG4myTGdY1Mlo0
 R/+rYubLk98zXtfFFuoHz1LSwDGN1tWhBFlSnmDAIXWXVvOn5Xx310usJIKuKr1K8A4d
 7TrQ==
X-Gm-Message-State: AOJu0YyPutmkNIR24sescdRPwc1/0aN5brk9yjSk4uoOmrarwLu0XB3M
 M2GpXybxhcANAh7/KsjIKZYm9RgNBsyUKl1qct73oTUTkjuKpzAtMCgFlDf//2W+ltc=
X-Gm-Gg: AZuq6aJ+cxNsIsADqKW+Dwl3jpMudFP/+E0Ulf+W0qzbhyqE0pF9yoLq1xbK5Tep65+
 m1qRtkS81fcM01/p3nHjQROOfujOudB9bsfV0NSNvlwKvj9ZToHIAGKdo7KGgf+/bvL62f28tur
 3w8ED+pOg7aQBIT/+YFAHpRl4AYei7r4VrvuYE+C+QONY5eFpfZqkDqZ6muOa7Lvd97DAK2XaR7
 nZJZdks/VJwpfTKCCc9iWOeKbMepTrBHNt3MwV9NfhOsEUjeTxOHfYvgv5jJ9f/7+ZLfzHm6j8r
 rwtpOhjpx3xzt6Z9APgDEQJu2/9ty+FwTa1V1t6B22f62h2m5UQtUB37CcFyDEGvFY1HTC7GCFs
 PO/AWt+iQkfIyA2N0zhmndAeXlgsA3JHvDNqnIc7CyLQMvkndmL3q8tDkXx/VOrllHt27vI5aLb
 1fmg4FXM5b/9ZXG6UXrTLX9Og=
X-Received: by 2002:a05:6402:3553:b0:64d:4149:4924 with SMTP id
 4fb4d7f45d1cf-65e4f13e8aemr1621136a12.4.1771521920731; 
 Thu, 19 Feb 2026 09:25:20 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65bad19bf20sm4269435a12.5.2026.02.19.09.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:25:20 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8F1185F8D8;
 Thu, 19 Feb 2026 17:18:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH v2 12/14] hw/alpha: add a reset function for the clipper
 machine
Date: Thu, 19 Feb 2026 17:18:08 +0000
Message-ID: <20260219171810.602667-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219171810.602667-1-alex.bennee@linaro.org>
References: <20260219171810.602667-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

Once this is setup we can move CPU reset to a 3-phase reset handler.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/alpha/dp264.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 98219f04569..f660fc41bcd 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -17,6 +17,7 @@
 #include "hw/ide/pci.h"
 #include "hw/isa/superio.h"
 #include "qemu/datadir.h"
+#include "system/reset.h"
 
 static uint64_t cpu_alpha_superpage_to_phys(void *opaque, uint64_t addr)
 {
@@ -42,6 +43,14 @@ static int clipper_pci_map_irq(PCIDevice *d, int irq_num)
     return (slot + 1) * 4 + irq_num;
 }
 
+static void clipper_reset(MachineState *ms, ResetType type)
+{
+   CPUState *cs = first_cpu;
+
+   qemu_devices_reset(type);
+   cpu_reset(cs);
+}
+
 static void clipper_init(MachineState *machine)
 {
     ram_addr_t ram_size = machine->ram_size;
@@ -205,6 +214,7 @@ static void clipper_machine_init(MachineClass *mc)
 {
     mc->desc = "Alpha DP264/CLIPPER";
     mc->init = clipper_init;
+    mc->reset = clipper_reset;
     mc->block_default_type = IF_IDE;
     mc->max_cpus = 4;
     mc->is_default = true;
-- 
2.47.3


