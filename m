Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3CAC4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 10:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZTQk-0007r3-U7; Mon, 12 Feb 2024 05:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZTQf-0007oz-9I
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 05:20:50 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZTQd-0007cA-Pl
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 05:20:49 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-296717ccc2aso2757044a91.1
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 02:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707733246; x=1708338046;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VGD7NdBuxyVN5oOj4Dj9saOxKZSHKiM5XIWGuWT6lRM=;
 b=n/qo785f3GR4gPg5HfM14dTBEYUMfZDGM9KEULufBEiaP8eKcUpVHkxSJEbXRkZcrt
 cG0PgES76CHAQJiGKK1EDPnECwCIU8VHiRPMI+DiBF26cVjsDka92yChktNS2607iNIn
 MuoN11HmxApPxX7ozr/i4/3SAImOmcSjXKAn8EM7hM40BN6+RdA3dMcHWuCPg9nbplbh
 /vQymQe1ciLnM5mrgkZsG07eKvT1DCKcaToVi99BH3zEIm6rzoRSEcpkoIZ7PibCyvLI
 yjYgPo9F6W/l8o2LW0+22w8lEdCBvfregPpUVhaLaRyd4KyPht0gDDFsjwEeha4iKI7P
 2lEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707733246; x=1708338046;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VGD7NdBuxyVN5oOj4Dj9saOxKZSHKiM5XIWGuWT6lRM=;
 b=PQ1c3SevvEGD6NTDtmT034ofp+KD1j0ZGx12POx/LmllsKTKNWO8moJKKTzBt2KEUZ
 A5LsXQw45jMEiaEBQMhqHpY2nIaRKzT0Cygp0iCCjNS0/pBXLyVE+00xtZhM0/VFEMeu
 Mzw1r3Ll+/hYET5y3Nv1xsAvfY71/iPnUyM9JmsjrwtvPpPmBAqpZbpa5wZwKXwqgsYR
 oQC4MR8mm6hgzYsUQqRl2QcGZUarHbLYC4N3kvYO61ok5YQFV6ymYnw+J1imnEsWm/0+
 sOhlnUbptUi35+9s1y00hBzpBDpUipHBDBAHAKoypXIziv3gQu21Onu9tp7PPqjo1d72
 G/og==
X-Gm-Message-State: AOJu0YwICjPDdme4VPOza+Jcz2vYNMMKS8d683RNbIPcjg3T5Z0JhrDQ
 HHrmQGz02FNZKW86sD8n/Roscfkq92kOev6q8ILUgOFl6ZsMSKhEerMwn3fODMw=
X-Google-Smtp-Source: AGHT+IHT/mnhecOT2Z9Sf7yNUodkH06Hi/x4WS7l10UvIWlfOMeAbncQ7zfx5tI9tSc/UBbzNc2zMA==
X-Received: by 2002:a17:90a:d708:b0:296:c788:b280 with SMTP id
 y8-20020a17090ad70800b00296c788b280mr10966365pju.18.1707733246477; 
 Mon, 12 Feb 2024 02:20:46 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVWI9UrSH5wBNXo/gS+RhzSY0OzOlbfSeZuOKsljvRBq+39zamKdE4k9qTPyrxOB8VI511rkBF8XYrmBVpgiSxPdVMSe+kOlthLP1oCFR2OruV1gBVl/6U5IS8QtJbZvow3enwtjmAoo/N7vqx3HBlpXiacs3RMcWNiax3HWhc5F4AW+mfi7w+8mb5Az/sfs5XaWI0DNCLR77ZzT+l8BpNfnQlRDQFK+AkQFE63fP4mZfyiEVx+Hx9mmhlZWwupX1Y6NKU+D2g1AutszU0k8gTDrfK4Cy85L+hbu7v4eUpx3hR/+Y4vWeOK0kZcCfwfCu5y8vN8wyPiEQNfTH83SoSh4n8NAC1rCAVL8Ep4t4Se6eiQlcxtaOUOCjuA1LHGazBYiPBncDK5Kukf6X36KUuv7yxVxfClRgV1OWG8WUM9F/SHa62qNIYuJ1eVdPQ=
Received: from localhost ([157.82.207.134])
 by smtp.gmail.com with UTF8SMTPSA id
 sz13-20020a17090b2d4d00b0029552a03219sm142765pjb.29.2024.02.12.02.20.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 02:20:46 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 12 Feb 2024 19:20:30 +0900
Subject: [PATCH v3 2/7] hw/pci: Determine if rombar is explicitly enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-reuse-v3-2-8017b689ce7f@daynix.com>
References: <20240212-reuse-v3-0-8017b689ce7f@daynix.com>
In-Reply-To: <20240212-reuse-v3-0-8017b689ce7f@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
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
Received-SPF: none client-ip=2607:f8b0:4864:20::1029;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

vfio determines if rombar is explicitly enabled by inspecting QDict.
Inspecting QDict is not nice because QDict is untyped and depends on the
details on the external interface. Add an infrastructure to determine if
rombar is explicitly enabled to hw/pci.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pci_device.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index d3dd0f64b273..7564e9536dbd 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -205,6 +205,11 @@ static inline uint16_t pci_get_bdf(PCIDevice *dev)
     return PCI_BUILD_BDF(pci_bus_num(pci_get_bus(dev)), dev->devfn);
 }
 
+static inline bool pci_rom_bar_explicitly_enabled(PCIDevice *dev)
+{
+    return dev->rom_bar > 0;
+}
+
 uint16_t pci_requester_id(PCIDevice *dev);
 
 /* DMA access functions */

-- 
2.43.0


