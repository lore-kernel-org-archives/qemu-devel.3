Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD7EC4828D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 09:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWCO0-0003zL-37; Sat, 03 Feb 2024 04:32:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWCNv-0003yU-5B
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:32:27 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWCNt-0005iO-PY
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:32:26 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5ce2aada130so2714443a12.1
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 01:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706952744; x=1707557544;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KshG4XdFN/TjxiO4+Kgrx0bCb7ZBpfjPIzIbQ6JKIZk=;
 b=ofcbErmUoYtRIb11ONDVUp/1BPx6uHT1QIkMQiQOJ8jL8VWgzK6HwfZrRK+4SPV802
 A1yVmz4vdHm2PBtB1ug+Rfx6dEf2CCm/4Df7P+LVQYouPvjPrWU2fxzEUXCEck/+wJkC
 f9zaW0K601RIP4e2h+RNOY7fY5VPPdezvqqOnOkqccBIjaGQU0I6qrNXoYofOHFjh19l
 QSPVLwsfFUbiid0MW6TFQrKFHenjfljfIPMJYHsN/gyfbhQOnhL4Xsqd5gwHxYx7/p1B
 yVt1PDQ1/7k9mO7cH5/PzhFkjApLnCrcx0peyDL2Z3B8L50ThAqZHU6AcZmPMgVwLStM
 XC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706952744; x=1707557544;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KshG4XdFN/TjxiO4+Kgrx0bCb7ZBpfjPIzIbQ6JKIZk=;
 b=Qskfgai2XX3dxcnqMgOqney6cm+p0uKvDpwXUmEfU5qxTq9EcM1qico5NZuBnoi55J
 LFw6gxzzhIhe78V7GcAItBOHR19fR7DaqFTsP1E///Basb9or7py7c0QGdlQFLmmuxte
 R6G6jRQVN+kJ69dKFRG5A3GMRtLpNf8/6FVe0TGQ26Sa8GyZppzySmEVqV7DsjAxeEYx
 rq9/Rb4vkAVKXz9OFz5/2YkTQgnflVpnLQeL1ab7JwrYCRGExIIChR6vWdLHbCEls9Hk
 jVTvXnpulT6POaof2MGA4BQi9OsaiZqY1LZIssCd3hZZ0BNTZ5BFUJrb3/YX+JAXS76d
 4G1g==
X-Gm-Message-State: AOJu0YxbSrvqwzy1aZ12/wty14+eXtXWp4pp/BSQKx5i3ECig1hAwqs8
 WqZFQA1wF57chIQlq7vnXuiL3+FvVzaM1ZTGUus1KPqZhBdTplqpOHfS+cgg8Ox5b9KwcYgxmgU
 7
X-Google-Smtp-Source: AGHT+IEQJf/kkDi0o0mkmhjmXwbxQNb/9Uno1/N+3iTDOGG9dqItVHvJZM4jmsGAvinGkGxxT6TjJw==
X-Received: by 2002:a05:6a20:dd9d:b0:19e:5517:c317 with SMTP id
 kw29-20020a056a20dd9d00b0019e5517c317mr2098338pzb.24.1706952744563; 
 Sat, 03 Feb 2024 01:32:24 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVut9Amib5yMWBuCJUHwjP9g8muCTXWx6WsPBGKsozNaLdI25IEcVTOlYfAU1E4UAJ6V+CycbKoWS27lAP2mqrR5CiiSti8IA64dMjnBhH1mqzBFiSPDpOlQkpj2kvnhVfXBGdq7oKGdRhtVFh49VgqLrY9+bEcQCalqJTN0EnbwBdXyWew1bC2Zet6UNmJNN7njt5fYh3Wl+dOj/jQryhUFdCGtdYm2o0V+xYN5R6pb1FO7sVwj/eUGA4xGW+66S9ZjhUUGkuFHJYD2c/beFuxxHEsn2cttfOqLiNZ0YgdpJqA1EUZ4dLP83GHVM5qSNkqElZT3rvubbnMUCDy5snztsEKMCtKf6NMwggueyI4KBUIlkmGvlLP3Fjc0m/7QrK4VsC8QOTDyJTTi8xABUTZWk9j+XrPUWABOPi5AA==
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 u26-20020aa7839a000000b006dfbecb5027sm3108142pfm.171.2024.02.03.01.32.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Feb 2024 01:32:24 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 03 Feb 2024 18:31:56 +0900
Subject: [PATCH 2/6] vfio: Avoid inspecting option QDict for rombar
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-reuse-v1-2-5be8c5ce6338@daynix.com>
References: <20240203-reuse-v1-0-5be8c5ce6338@daynix.com>
In-Reply-To: <20240203-reuse-v1-0-5be8c5ce6338@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::52f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52f.google.com
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


