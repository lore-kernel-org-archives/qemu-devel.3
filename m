Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F058FE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMu0e-0005Ol-SY; Sun, 15 Dec 2024 14:10:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMu08-00043k-7k
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:10:00 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMu06-0001YM-Dn
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:59 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3eb8db8ae9aso1573122b6e.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289797; x=1734894597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKgQK+6ZUCTVplJd6G9s9xqdYnMK41SpV7U5E5JQQwQ=;
 b=yxJiUXA1fdGsUmK/HijnJyPjO5C39iggNKuTWUwuqynzKwLTdYCh9gKNZ+RZcIkupT
 gTK5bm5SQ8Uyfef0bpvCH4TSrikRM+38l8igt7qOPrB14wZEZW9aNJKIgJNO0/2NKjfj
 P9e9yrpPn0cnrEqUnSKvveodW5qO0D1eI4kC5QlouXGqac+TuGhw/jaCpxs984JdyhNo
 lqBz1IUHWoJ24BqigOGl11b703L+oCjT5758hoG6UEW7LzwbapnsNfYBuIIIsT7Hqk+p
 OHIC4rLDOOd/XPltnqLz3mVgfbZyaQGCgNDF41deu/+hRLsBzQN9A4Qjl/VY2EDcnfCJ
 M3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289797; x=1734894597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gKgQK+6ZUCTVplJd6G9s9xqdYnMK41SpV7U5E5JQQwQ=;
 b=axsVY5I25+cobJJ6Jzm6JW5zw71CB3y5X7h3NKN8trDRFrbb/I+CMvoeA+PqRj20lz
 ESDCUBtcJzfmEkHN+9fkuc21EopRC2WSKvCjrf5mUjzScpEytg7GNg4FFVmPe+PUf1gT
 qw7MhG7o3XeQo6HfOm+tBtsRYA1MtBGJejSwrEHx9kD0JSJxRFxgCBRj+oBLbyjm53Tx
 3k2tXZ0HGzgvwZ1ilTfuL39A7ViNg8sod6wEi/sDe3LwIWlNyXudLbohZH1KfxrtP3GV
 CHCkMuA0zWu4yzksFdqbEYlPkvj2/Ix9Fsano8JK31gyqmZHpkngFelJIvg8H6JTqL6+
 466Q==
X-Gm-Message-State: AOJu0YwXRDjPym5WFRO9rXzi1MPhFCmwdxasGb/9vkpm+6Zreo8lq69d
 2BAQR8KpYnm+9VNtd7/xrCpKx19cixaOUW58qsc0OA2pLr1O9KWTF+DgpBeCSvqmQaIw0A8XBhx
 pJFNaOXCa
X-Gm-Gg: ASbGncv1K/k7JDEJwztOk9uXedv+UdiJ6wm73j5p2cpPsCwLd3hZUjh7fTxh66CRSYM
 K5Fb48WdBe0wSAobWzIuDCXunwqI2cq5q6PMZ8BRJrwEbpDoXRi2K5VbiVZyVdOLWbQ5KFx0Moz
 6AdflO/IjJ144pTYSXUUuSjxjW+HnYwWwD70OAoEkv0CvrdamFPOY50OClMIUFf3pOdyLjBY31z
 NJSOy+2rp4jizKB1RriLXpx9Oxd8CiTlWRuHl6H0eVxAQtxhSbEDzGGlFZQSd+WnB+EttIwp9DV
 i+1PAAph7cnDT+bEVsgFSgkz28HSKl84b+ErIcyasiI=
X-Google-Smtp-Source: AGHT+IEhQEqW0uhgCYa4UdpqMzAwKF9AGRTO621G7cSKJnbnp00YItWV115hAUWzb6wE3qX9UUIiGQ==
X-Received: by 2002:a05:6808:23d4:b0:3e6:5f6:c2b5 with SMTP id
 5614622812f47-3eba69108e5mr5216975b6e.26.1734289796866; 
 Sun, 15 Dec 2024 11:09:56 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm1015316a34.34.2024.12.15.11.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:09:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 62/67] hw/vfio: Constify all Property
Date: Sun, 15 Dec 2024 13:05:28 -0600
Message-ID: <20241215190533.3222854-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/vfio/ap.c       | 2 +-
 hw/vfio/ccw.c      | 2 +-
 hw/vfio/pci.c      | 4 ++--
 hw/vfio/platform.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 4013e7b436..2e6ea2dd93 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -191,7 +191,7 @@ static void vfio_ap_unrealize(DeviceState *dev)
     g_free(vapdev->vdev.name);
 }
 
-static Property vfio_ap_properties[] = {
+static const Property vfio_ap_properties[] = {
     DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
 #ifdef CONFIG_IOMMUFD
     DEFINE_PROP_LINK("iommufd", VFIOAPDevice, vdev.iommufd,
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index c1cd7736cd..b96ab27e12 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -655,7 +655,7 @@ static void vfio_ccw_unrealize(DeviceState *dev)
     }
 }
 
-static Property vfio_ccw_properties[] = {
+static const Property vfio_ccw_properties[] = {
     DEFINE_PROP_STRING("sysfsdev", VFIOCCWDevice, vdev.sysfsdev),
     DEFINE_PROP_BOOL("force-orb-pfch", VFIOCCWDevice, force_orb_pfch, false),
 #ifdef CONFIG_IOMMUFD
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 14bcc725c3..93aca850e3 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3354,7 +3354,7 @@ static void vfio_instance_init(Object *obj)
     pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
 }
 
-static Property vfio_pci_dev_properties[] = {
+static const Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
     DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
     DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
@@ -3451,7 +3451,7 @@ static const TypeInfo vfio_pci_dev_info = {
     },
 };
 
-static Property vfio_pci_dev_nohotplug_properties[] = {
+static const Property vfio_pci_dev_nohotplug_properties[] = {
     DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
     DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate,
                             ON_OFF_AUTO_AUTO),
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index a85c199c76..766e8a86ef 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -629,7 +629,7 @@ static const VMStateDescription vfio_platform_vmstate = {
     .unmigratable = 1,
 };
 
-static Property vfio_platform_dev_properties[] = {
+static const Property vfio_platform_dev_properties[] = {
     DEFINE_PROP_STRING("host", VFIOPlatformDevice, vbasedev.name),
     DEFINE_PROP_STRING("sysfsdev", VFIOPlatformDevice, vbasedev.sysfsdev),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPlatformDevice, vbasedev.no_mmap, false),
-- 
2.43.0


