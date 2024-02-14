Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7BFC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDEE-0003iS-Dc; Wed, 14 Feb 2024 06:15:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEC-0003fQ-Ht
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEB-0006yR-4j
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s/uvRz6NqAtcw4NfACRR0TvuyVvMvzlS8V+gAdYV2LQ=;
 b=VE44sy85Dx+gKRi6+KWV5veh9aY3QCWYO4s/HcBeKELWVh+RswkWPMhCqAvDFIm8hZT/5d
 cA574G4aVnhhUZe7gGN+KX0iYF6y6moiKfblLHW6+oNkLnNftw5CtLyXPGT0wTo2tr+4VB
 Uq/PtTb9ziqGY4l7+hiD2sJzOYElLPI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-JPytBuucNI68ZQx80FsLMw-1; Wed, 14 Feb 2024 06:14:57 -0500
X-MC-Unique: JPytBuucNI68ZQx80FsLMw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a27eddc1c27so115463666b.3
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:14:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909295; x=1708514095;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s/uvRz6NqAtcw4NfACRR0TvuyVvMvzlS8V+gAdYV2LQ=;
 b=Oz/as7I14AxMV2+KXtKDhSPzFCc95JeuoL0JCwAzF+eLsUaBhRIHJ+HusrzMZLmc7q
 /WdqNK7rYoeZ9Usm6UlWVPSAdT3TVzB9WTQvqOAwoitpWn+fIZkGBABUZ5jaJQ2Z8FH1
 0sLGRVeaGlR8dTfvb8mOTbaOPnYV2EemggJUUMOwlkyeXbOMflvcUoyKEm4ostsQ2s5n
 HRebonc5xlLz6AAI8uuRAI6hAEmH5PnEtA9leRZ6WlXsdYYknP/SXZAC8IBuwYxztmlI
 DPPv45kwcYfZYOtC8CXDNfs6CjdSRYCesetl/WNx5cTqQzPSgwoUpLklgS9RvQ6t0iBm
 zirA==
X-Gm-Message-State: AOJu0YwGk2ng1Hq8q4ybNBIA4cB2UebO7s97y8ox+7c1M8kH0pWden7w
 Ljzd2jzkB2AFs0aFTYiN9CroRoRZ03688t5rdbtwjRZH8vUfyxTb8BGIiq0HXmtEc/I9/DUOeT2
 1E5JdxWqoYJw1rB0Pci3ySWu9TydCqpJvWdFwyMKlR7zIIeK8YcsgwH1CErsxmNk7qNvUCamJfj
 fM/8LaxoIKINCsg+WxM3UGtUhbQfsyeQ==
X-Received: by 2002:a17:906:c13:b0:a3c:ffbb:b47c with SMTP id
 s19-20020a1709060c1300b00a3cffbbb47cmr1458258ejf.72.1707909295256; 
 Wed, 14 Feb 2024 03:14:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbMT8fA2YEV9bk+O+Ln3/XbRME1NygdGCkdkvS5mwmdQHeYLIt/V8BE6DQifwPSVugixtJHQ==
X-Received: by 2002:a17:906:c13:b0:a3c:ffbb:b47c with SMTP id
 s19-20020a1709060c1300b00a3cffbbb47cmr1458241ejf.72.1707909294940; 
 Wed, 14 Feb 2024 03:14:54 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXQQkuBtSu5oB2RP3FEfHM3PdnpW3n6dvFMQ2xo4nV2c2GujC878mOleSuKgQs4CqCpuz5l/eJfOhlFoE+jhQP337xuPb+Tc5w1YP4DPbsrAcrA+vmIl1YwdtzHqZdlo9su0LsSRHkYgjds
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 u15-20020a170906408f00b00a3bc368ca7esm2219174ejj.53.2024.02.14.03.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:14:54 -0800 (PST)
Date: Wed, 14 Feb 2024 06:14:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org
Subject: [PULL 31/60] hw/ppc/pegasos2: Let pegasos2 machine configure
 SuperI/O functions
Message-ID: <79a7f53065abea95b33e2212dcfb58e1de4be479.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

This is a preparation for implementing relocation and toggling of SuperI/O
functions in the VT8231 device model. Upon reset, all SuperI/O functions will be
deactivated, so in case if no -bios is given, let the machine configure those
functions the same way Pegasos II firmware would do.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20240114123911.4877-11-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/ppc/pegasos2.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index d84f3f977d..04d6decb2b 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -285,6 +285,12 @@ static void pegasos2_pci_config_write(Pegasos2MachineState *pm, int bus,
     pegasos2_mv_reg_write(pm, pcicfg + 4, len, val);
 }
 
+static void pegasos2_superio_write(uint8_t addr, uint8_t val)
+{
+    cpu_physical_memory_write(PCI1_IO_BASE + 0x3f0, &addr, 1);
+    cpu_physical_memory_write(PCI1_IO_BASE + 0x3f1, &val, 1);
+}
+
 static void pegasos2_machine_reset(MachineState *machine, ShutdownCause reason)
 {
     Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
@@ -310,6 +316,12 @@ static void pegasos2_machine_reset(MachineState *machine, ShutdownCause reason)
 
     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
                               PCI_INTERRUPT_LINE, 2, 0x9);
+    pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
+                              0x50, 1, 0x6);
+    pegasos2_superio_write(0xf4, 0xbe);
+    pegasos2_superio_write(0xf6, 0xef);
+    pegasos2_superio_write(0xf7, 0xfc);
+    pegasos2_superio_write(0xf2, 0x14);
     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
                               0x50, 1, 0x2);
     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
-- 
MST


