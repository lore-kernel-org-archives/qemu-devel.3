Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A757C52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 12:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJjU-000759-Gx; Tue, 06 Aug 2024 08:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJiD-0002RH-5w
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:54:53 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJiB-0000Qw-Cm
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:54:48 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a7b2dbd81e3so81830966b.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948884; x=1723553684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mHh1GCcnST+B2sXjSnUGRo9NlbeZggGy0/xN/r51vXs=;
 b=Fy3VdGmRjdUPQX1AMXn7wnG2RMQvhxW0p0DTLLQ/bCrlEi53dXJrE+2Qq7vxKLE2l6
 4mnvJC/+9GMB83VGC46T/Z8cFNdEX3CvogTn0mezbZ8bjLYJf9fEB4ZZKoc95+QIsNxD
 Ja3feSDRbTWWz2yNEkWtpKBnul0vr0EtngIYUYOCyqJkVnelBK9ympQQv0+Sp5Q+RFT/
 P68LIiVkbJT6i9FLYfkZAO9gBRXMnCtN0PY5WwDneoTzlY5Jgi1dEgH6qaJXVvvPJZ77
 L6AB3MZR/zBNG/0dmritFpN1E9H7jGjjh63SbfI9u/x/LA+j21UrR5RYF2jNDBAuEo15
 pTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948884; x=1723553684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mHh1GCcnST+B2sXjSnUGRo9NlbeZggGy0/xN/r51vXs=;
 b=GhuvFiz4zHBBppAbXZd91bbp1w6rqRGgZ4bhjMoN5eiDg/x15MZ4nzBeiIq6owJ5A2
 DHlVM8/Xw2DSIaYNDLXRCGfqj9kMPaRqGW1YWNK+8r3YlMUusaMEl6I5345A+yVXGoGs
 t7x6MKeeN34qAR4jEHVD3AQEVtOP0Kpoz8tF6DiemQSikTJkQHJmaizELmuSIMJkkXdo
 u8SdP33xWnOILMCPaOJ7Xk1YsKGzOn+uVDeyHLBPBrRBv5SksYXgFIKGzIYShlhliJDn
 Fi11xfbAogv4ulHIILMXLIfIwA4UmEFnFYXet2TAOcPtYUS/tsbCELaOoVuupIvHt8o1
 1OVg==
X-Gm-Message-State: AOJu0YyO+u9Lp4ub3pjC6kSuAxbqbF0TAEGq7nU5FU9K7ja7bZ1xruo+
 nF080L4YSJcxnRJJDm1ZAJjXCp2EOTl6mpkMpPbkQM3hT/cLToQfHM3wfcSqbU9jRFyMPRPmOLh
 i
X-Google-Smtp-Source: AGHT+IE3lpmer7jwcaxfjWPfCrJ3cJok33zbvdGdK5O9H8+NFgrpYp9KVyjvnBdtMkUOB2ZHHkvZOg==
X-Received: by 2002:a17:907:9721:b0:a77:c26c:a571 with SMTP id
 a640c23a62f3a-a7dc509f309mr1087709166b.54.1722948883815; 
 Tue, 06 Aug 2024 05:54:43 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e80e77sm541169966b.169.2024.08.06.05.54.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:54:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: George Matsumura <gorg@gorgnet.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/28] docs/specs/pci-ids: Add missing devices
Date: Tue,  6 Aug 2024 14:51:55 +0200
Message-ID: <20240806125157.91185-28-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
References: <20240806125157.91185-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

Add the missing devices 1b36:000c (PCIe root port) and 1b36:000e
(PCIe-to-PCI bridge).

Signed-off-by: George Matsumura <gorg@gorgnet.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240805031012.16547-2-gorg@gorgnet.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/specs/pci-ids.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
index c0a3dec2e7..0de13de1e4 100644
--- a/docs/specs/pci-ids.rst
+++ b/docs/specs/pci-ids.rst
@@ -82,8 +82,12 @@ PCI devices (other than virtio):
   PCI-PCI bridge (multiseat)
 1b36:000b
   PCIe Expander Bridge (-device pxb-pcie)
+1b36:000c
+  PCIe Root Port (``-device pcie-root-port``)
 1b36:000d
   PCI xhci usb host adapter
+1b36:000e
+  PCIe-to-PCI bridge (``-device pcie-pci-bridge``)
 1b36:000f
   mdpy (mdev sample device), ``linux/samples/vfio-mdev/mdpy.c``
 1b36:0010
-- 
2.45.2


