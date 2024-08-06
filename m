Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC01C49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJk8-0002Rz-Oi; Tue, 06 Aug 2024 08:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJiI-0002no-0v
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:54:55 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJiF-0000UT-IL
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:54:53 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2f16d2f2b68so10343971fa.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948889; x=1723553689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=77mKDDwsQ4N9EU0OpMBcpTovtWIwsiedBtivnY0Iukw=;
 b=Qu2lRgvtWUoBdhyQV+WuXtEl9UdPNHwrsSQ8XP9xCBMeBlGAUeFrIMD+i83YjlUpGT
 yPelIYWqg/yXP4VKDsHyLmk/mag4luvj6xtakq/DNWFXLkSsaPd6gqmDJ5o2S4YVlu4b
 S73st1jgwnPifxnuZbFYhF8bwEE6Tj4cd6ukZ88GKfqX4fG336I99e6VCb+bsftIKOjz
 t+C7fjYr2g/DAlgLPCFT4rmc8pVKea/CLVcLKSNM3tZz6zW6YLh0FTJkAiLGTgMcfKop
 u2/SRWqzEBrvVuGTKTW8MU5I4GxkrGY5abGm8+NWqvax0DXjK7rbOVzym4N6k6v6vKyg
 DgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948889; x=1723553689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=77mKDDwsQ4N9EU0OpMBcpTovtWIwsiedBtivnY0Iukw=;
 b=gMuQ91hw0nW6aXKgNic9I0BOP1mLN2sS12c4euzWllle+O44XAYsANuaDX4MITTyxc
 PBS4GjPi3UCAA5/l5CVSIepnY5ukNHZfKvIgk5Z0Z+tppXbmAbQtKtEOpMoLEJRNUuGx
 3JXK8yrA/LrDvj2PEJta63YdzyDZmmV+NQl/P3v2XBipQrMM22ssnWqWCtLyjk8UthH+
 xDuSSgHgQN2sUGuWdYEq+53Ui//gfTsKKHMUCg9vxN45nnacoTNn8epEWcfIas6BKO02
 h0GnOfRLZwrU6RmRXue9OC4tX6yty9n0oWPKkVnTHqi57/mhDTfU/3W7Dv/VHvanKxXb
 yNUA==
X-Gm-Message-State: AOJu0YxPg82aq7W6pDCBn/oGqel0q0LgHAxo4jDBUOgdnTGtf/Vl/4Rh
 jTOz/7cJ/tFke8Q5LxdN1fQZUKlusExi8B+63v8sQEQv9TjHVfeLWviLH6Ih0LajFZrgFkwrCJQ
 V
X-Google-Smtp-Source: AGHT+IGPJ76mc/UQH9XLaxpy2CfyQDntSF5wjLya5+pAlsgmZ8swYga5cElYxvfYK29b00l582g1iQ==
X-Received: by 2002:a2e:8703:0:b0:2ef:1b1b:7f42 with SMTP id
 38308e7fff4ca-2f15ab2a580mr118277291fa.36.1722948889440; 
 Tue, 06 Aug 2024 05:54:49 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e7fe2fsm548850866b.178.2024.08.06.05.54.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:54:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: George Matsumura <gorg@gorgnet.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/28] docs/specs/pci-ids: Fix markup
Date: Tue,  6 Aug 2024 14:51:56 +0200
Message-ID: <20240806125157.91185-29-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
References: <20240806125157.91185-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

From: George Matsumura <gorg@gorgnet.net>

This fixes the markup of the PCI and PCIe Expander Bridge entries to be
consistent with the rest of the file.

Signed-off-by: George Matsumura <gorg@gorgnet.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240805031012.16547-4-gorg@gorgnet.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/specs/pci-ids.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
index 0de13de1e4..328ab31fe8 100644
--- a/docs/specs/pci-ids.rst
+++ b/docs/specs/pci-ids.rst
@@ -77,11 +77,11 @@ PCI devices (other than virtio):
 1b36:0008
   PCIe host bridge
 1b36:0009
-  PCI Expander Bridge (-device pxb)
+  PCI Expander Bridge (``-device pxb``)
 1b36:000a
   PCI-PCI bridge (multiseat)
 1b36:000b
-  PCIe Expander Bridge (-device pxb-pcie)
+  PCIe Expander Bridge (``-device pxb-pcie``)
 1b36:000c
   PCIe Root Port (``-device pcie-root-port``)
 1b36:000d
-- 
2.45.2


