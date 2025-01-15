Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556BAC02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 17:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY6vG-000840-PU; Wed, 15 Jan 2025 12:11:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6vA-0007v5-Lq
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:11:12 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6v8-0006dM-BE
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:11:12 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso37092f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 09:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736961068; x=1737565868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yWo77aykn0azdzOtkEKhvI1Uh0zOSmfZ8twQPYS0aJk=;
 b=VFRtnxc+vPd1OTid85ro9u3kvuXpI+jMNR2SwpnQDHF2Z9pGZ5TZIze6bN6YUglwqx
 dY9WF8sKtkPX8I+sWBWGON0aXLoIfzaExQa/oMfBgiyBL1gFceTQhDyXfklMDJbkvWJI
 jACbGc/3M5n9jisXu0X+9IAJk+NyB/P6ZsKEHjv9Ast03V04CBkwi2+HNeav7vr+A5Xm
 kCsdGDvccLbZEyaZTZHeAQh5RwisX86gT0HiNtPeJGbvNxcYmPCm3LJsIIwEFLv8IMoh
 HxFe/gc7XQK4XseBBCaukwkOTq+TgweYWR6av36ZtldsPiGTouIyt9ftB7/9Q/yybynw
 9+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736961068; x=1737565868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWo77aykn0azdzOtkEKhvI1Uh0zOSmfZ8twQPYS0aJk=;
 b=qn7vrLE8D8aJUw4P1aodNFGcgxrpF6KeO6z4989sSVi+AygPAI1Z+fGsensZnP4sCw
 NPSsPYstEfsSvO4cezlwkIJlkqwk/hG7c9DJi4/GLSs4et9AtYdSlTQw470cxJF3VlPy
 ewJrOoZo939XY3YzrItQrvcxQLvqpp2WMua02DfCONe4WZUaNd//DjVOzjutvgIvDnwj
 3gZn1ahhMSdBE4JOaiyWPEEl7inCZdqVRJZQ8DGj4IERh0q4chmbRwU+c0MpIM93rx5x
 G1/pLLBTEseU5yQvwJ5Y1F1/QO5jr63HLBX0vuBB8zlqUtc4LnlOaBVq1jzSi7iwOlqA
 UXxA==
X-Gm-Message-State: AOJu0YyqXzAFf6hvn/6I5VR/IN1VGX2Qn5MsFmT7KC8CXX0DEvzO067g
 bwaeHKVPEycpbGbk9XjvsI0LOKB9PJ60fT21Veqz8yr6LBgK14EjpLn+DBrSTxcgsSZG3ZW0w10
 +h04=
X-Gm-Gg: ASbGncsgvtELTQA7CjfC+pQCI7UL5paapxSW7GxDt8IKvqpMu6RyzZrjRjrzTCR64HD
 90GHhDSOib2sk8Gvkgxvrrwi8UmBcnnu3+5SUtOU1JNjoubeO+gcwLuohtwRKQCNcoGMgu5kcMh
 LxFnkrTgbY+Hhkuj8iaBnty7TTDVGEqZlrD0iXGW9rw4sVigwVTlB5YAX5SFHPS66xhBhVcsYY2
 A436WyuUvg8bv/Gjg3ms4xCXXBC7qpBOKG7ZUDSUo2jSSq/tMWAu2vIoGnTeh1wY+JgSjOM+fjg
 1LarehYlTKmqjkNsN+iQhW8yojRtHcuN+7qL
X-Google-Smtp-Source: AGHT+IEByJXVgKrJbPCPYTA/lVh3xaA5xEtb6KN2ZM7ZMsyU/96Ownea/OF6jdGBPrGrg7XIiO7RhQ==
X-Received: by 2002:a05:6000:460b:b0:385:dffb:4d56 with SMTP id
 ffacd0b85a97d-38a87317e45mr25546703f8f.53.1736961068358; 
 Wed, 15 Jan 2025 09:11:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7527fd1sm30048215e9.31.2025.01.15.09.11.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 09:11:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>, qemu-arm@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 12/13] hw/arm/virt: Remove deprecated virt-2.12 machine
Date: Wed, 15 Jan 2025 18:10:08 +0100
Message-ID: <20250115171009.19302-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115171009.19302-1-philmd@linaro.org>
References: <20250115171009.19302-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

This machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/removed-features.rst |  2 +-
 hw/arm/virt.c                   | 11 -----------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 0594bbd4363..c915b2cbd41 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1065,7 +1065,7 @@ for all machine types using the PXA2xx and OMAP2 SoCs. We are also
 dropping the ``cheetah`` OMAP1 board, because we don't have any
 test images for it and don't know of anybody who does.
 
-Arm ``virt-2.6`` up to ``virt-2.11`` (removed in 10.0)
+Arm ``virt-2.6`` up to ``virt-2.12`` (removed in 10.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''
 These versioned machines have been supported for a period of more than 6 years.
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 08117b396a6..a607a66a198 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3512,14 +3512,3 @@ static void virt_machine_3_0_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_3_0, hw_compat_3_0_len);
 }
 DEFINE_VIRT_MACHINE(3, 0)
-
-static void virt_machine_2_12_options(MachineClass *mc)
-{
-    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-
-    virt_machine_3_0_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_12, hw_compat_2_12_len);
-    vmc->no_highmem_ecam = true;
-    mc->max_cpus = 255;
-}
-DEFINE_VIRT_MACHINE(2, 12)
-- 
2.47.1


