Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C73C4829D
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Feb 2024 10:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYkXh-00074M-KZ; Sat, 10 Feb 2024 05:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rYkXf-00073N-N4
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 05:25:03 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rYkXV-0002e5-RE
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 05:24:55 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3bb9d54575cso1168562b6e.2
 for <qemu-devel@nongnu.org>; Sat, 10 Feb 2024 02:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707560692; x=1708165492;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KshG4XdFN/TjxiO4+Kgrx0bCb7ZBpfjPIzIbQ6JKIZk=;
 b=rfJNGksGidj4aL4ZMIw+kqIUWEsnBJ1w63J/XTQ85EhqN6HZmKbWsIZFMeGEAvz9Wx
 2TQJEmn9/DwtyAxVn2YgEARXbk3Z4+9zSg45QUjRsZJe3+vbVmisP0yrzqloIs5IrlMa
 3Vam1WDwqKc2qCnmqHtJSAZyJdeTNMgCnKn8nS00aB3TYz2cgjLCZqBx+peT4K6kTdKs
 7NvvLHp0wL1JPErk7EO2HXVTiawwNz8PGJRTz8nsX/mfcjOjwcyvzp+g3lnjpNWAYXOV
 WM+M2YbXAkqz6PDuM+ffvf7+0Q2EP1RarJ10j7x+/xJ4uVBOxo67H5THPX5iuqr3EjXN
 QFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707560692; x=1708165492;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KshG4XdFN/TjxiO4+Kgrx0bCb7ZBpfjPIzIbQ6JKIZk=;
 b=H4SYxPGS4J6g+WRaACafbr4DgnXU3JfXu3WM1f1REYZJpwB4CEX+acvwhAdWRkZQ1m
 sZb1Bf89tBdzIWTXUN4th3GvrXv2mb1CeOg5INaKwaEKWKZa619mKbw9qwld+CGP7Oks
 7I0/o1H19SS8JiPxa6NqwMF29djCrYVILLkZePtW7KIPMqkEzEWh49fT3YLT6YR/QTf8
 5/A47r/Fp4z5EGpEPoJIvL9jzDoBkx73Ddw0kAr96pNWkPFf35FsfYMblECG8rhj0xIv
 tkT/pQN7+P6sPzxTQj2/czQ28N3kPgNaU+aYPPUWr+gPqgVp91iVdjCjJfHz6ldsOnOk
 C6Aw==
X-Gm-Message-State: AOJu0YzXFEPnRynOzAI8aNRn86gf8iXy9ST3n8mN08/rrF3KBrKNJcW/
 TKNrbea3guenkUT/Q75KWceH8ODM3KS5VtCCgQGhLT4DNbQtW4pXlvmVdobxNac=
X-Google-Smtp-Source: AGHT+IHKp5j+emFwwliVk3wDpqK9aBHdEgcqn1XGS4R0PelKs7l1KZPLMaEBqvsZMH/NBI1rqgSMcw==
X-Received: by 2002:a05:6808:1494:b0:3bf:f5f0:a8e with SMTP id
 e20-20020a056808149400b003bff5f00a8emr2138250oiw.3.1707560692603; 
 Sat, 10 Feb 2024 02:24:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVxEGN3xr++KS8+PsRVg7b+Ot1pFKfsC6ea5JXng3DK51os8W+CxL5UCUC4ReAbp03fAE2SWimlHez7sdkS2JDoT2tqsUwywKLhFENti0JGC708Wzbu+Zmp5EMAxmovOphYK9pOKrDveh3zTiQURBRBzyETxJo7Aie0AbdjCxjAlHITIkUishINOxL5MAiFwX2lo6HaA/Vf1KS1DWNymbeSSdcjgDv4OaAtVFEEoF+0JtykN8v4zXRxuZw/6u1Wb1G/zxR+iQH2964hd2sKpuPRCKv5rAzCUuHtDeIkfe67xBgF6aAVxlc7gTkYMRbXm9A0noc0UjBiNncp79Uz6NvSppA04pHFydKggocIs9Q6PV1BjAE25Tmj07a/DoQmc9NFsgebdZ0j3avpm4qW1V112fzyoU1Toeo8b64nvA==
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 o125-20020a62cd83000000b006dff7fd5dedsm2054672pfg.9.2024.02.10.02.24.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Feb 2024 02:24:52 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 10 Feb 2024 19:24:37 +0900
Subject: [PATCH v2 2/6] vfio: Avoid inspecting option QDict for rombar
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-reuse-v2-2-24ba2a502692@daynix.com>
References: <20240210-reuse-v2-0-24ba2a502692@daynix.com>
In-Reply-To: <20240210-reuse-v2-0-24ba2a502692@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::22b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Use pci_rom_bar_explicitly_enabled() to determine if rombar is explicitly
enabled.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/vfio/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d7fe06715c4b..44178ac9355f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1010,7 +1010,6 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
 {
     uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
     off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
-    DeviceState *dev = DEVICE(vdev);
     char *name;
     int fd = vdev->vbasedev.fd;
 
@@ -1044,7 +1043,7 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
     }
 
     if (vfio_opt_rom_in_denylist(vdev)) {
-        if (dev->opts && qdict_haskey(dev->opts, "rombar")) {
+        if (pci_rom_bar_explicitly_enabled(&vdev->pdev)) {
             warn_report("Device at %s is known to cause system instability"
                         " issues during option rom execution",
                         vdev->vbasedev.name);

-- 
2.43.0


