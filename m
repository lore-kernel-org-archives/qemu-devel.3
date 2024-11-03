Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1213D11041
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7alH-0006k3-Cc; Sun, 03 Nov 2024 08:35:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7alE-0006fV-T0; Sun, 03 Nov 2024 08:35:21 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7alD-0001YB-En; Sun, 03 Nov 2024 08:35:20 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a998a5ca499so443566266b.0; 
 Sun, 03 Nov 2024 05:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640917; x=1731245717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dKFAh2MnjhZ1jF0dRDKV/YEAdE5+3y61mz+4DueAPJw=;
 b=TB8rMvLCrK3PU2S1JF5qsrsRmkccIenPfMEUeuKpcqwRXKe5+fl/AR5GlxxoIdlWSU
 ayisoUbQtIflewMggyV7MuDZVQ5YnxkhYicg3yA62na7fWzr5ceZxn0b/sslWAX9dcNp
 /Ynyi5970dKZn3OEvgrpaT6rI+SeGuxBSG5moB9UzIH5/kx4wcfU/MhZicVMLfD7MVHQ
 yeJm5XcfpuCXeem0Ra8gysp/zeQ5TcmzI583EUCru44lf3MWADiOFc+vt2TjoADTxM6O
 VhjRK2oBP4afDc+l1YOEGGPcCcKmEs2LdQl4GTMp7sVFQ4rx9kDFjK4Ucxf6mydzemwx
 iJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640917; x=1731245717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dKFAh2MnjhZ1jF0dRDKV/YEAdE5+3y61mz+4DueAPJw=;
 b=PA7r9FvBIdNUlVvPnsz5vmmQqdD/K7sjxb/GDemc0AmJWbzVvZ3owUiakTvRt0WwJv
 L8jF9PSYKukfI83AOHk0kHvXIm+sOn1iKml1iaZ2oRfQCUGH+mC+JBDlzMgX8SUQ3ab6
 k6HxGO9pZ+c9uQAgMSqC9B9bmbU6V1kIRJw+WMQpNCkGX8/rtB/2HONBEA0UAyNr4oiX
 KMLdtJfx3N9sO2Mo054Ns81tYqcMcX3ewa9KZrsqO34FafziTXx0QfFC64nvXFSpFnXJ
 ayODfTeXLL3+vxL6T473QItJ1jP2gNdkB1oXFFNuhjc8nQ5bJsal2C5+SkQ7e0uTbKX7
 HBYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhBYS+ERJING0QUKxq1mTesDJy/AzEiEhWy77kecfAbfbdB10h8kmf5RHoy8yx9eEV2E0Ajwx3mO4=@nongnu.org,
 AJvYcCXtSENWWkNPv70ts7r0OQIQhgy5+Ctdzis89FsSEhNkjxuhsxWgUBmDuqJcGQGyE67w3hnUBXRrINHa@nongnu.org
X-Gm-Message-State: AOJu0Yz1Mu5HpGBfzeNFA9jlvDVXyEnx7rGhNY9RsOP6Qsx3E4bLzlt4
 JMJnWYFy/5ihLSRON5Z9/2Q2A5s1JiasViQJFeaB6uDuxm9NDFv68v8xsQ==
X-Google-Smtp-Source: AGHT+IHLUHMg6DKNnMQwTTj7ahrL/XdEShaCsfcEDWq4r0QiHLHEzLbnKyt4GkcyPClIdjdLqNxcIg==
X-Received: by 2002:a17:906:f8d1:b0:a9e:6e77:3ecd with SMTP id
 a640c23a62f3a-a9e6e77407bmr699875266b.54.1730640916913; 
 Sun, 03 Nov 2024 05:35:16 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:35:15 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 Kevin Wolf <kwolf@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-block@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v4 26/26] MAINTAINERS: Add hw/gpio/gpio_pwr.c
Date: Sun,  3 Nov 2024 14:34:12 +0100
Message-ID: <20241103133412.73536-27-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The device is only used in the ARM virt machine and designed to be used on top
of pl061 for use cases such as ARM Trusted Firmware. Add it to the same section
as hw/gpio/pl061.c.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a8f39aeb6f..5dd35f87ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -651,6 +651,7 @@ F: hw/display/pl110*
 F: hw/dma/pl080.c
 F: include/hw/dma/pl080.h
 F: hw/dma/pl330.c
+F: hw/gpio/gpio_pwr.c
 F: hw/gpio/pl061.c
 F: hw/input/pl050.c
 F: include/hw/input/pl050.h
-- 
2.47.0


