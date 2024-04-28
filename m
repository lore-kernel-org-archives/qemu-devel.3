Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC9FC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 09:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s10UK-0007dB-4X; Sun, 28 Apr 2024 05:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s10UJ-0007cp-7x
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 05:06:23 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s10UF-0003tj-VV
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 05:06:21 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f26588dd5eso3012694b3a.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 02:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714295178; x=1714899978;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nGIxKzJCDQjXBXXZTFBIShCWXnStqnqlbVDl8BPQr3M=;
 b=MXnZ0ZIbOhl+tt0AhtlcuLD/aqKJOu0poY8J/jotgmDsJcLBXOBrS0nip1Q8Mbv1FO
 S13Ka44mAqaIdWvaw1BLmR0mgUfBR0F0CcOciMJYl4CFi0DyFHoqnMSh+qaUsP3QyvsF
 6MknJ7vQvijwRS8KtgOdDSTp+WtrdKUyDhqu3vGSn68DgBmNgz/cfLHPeLKBhDT6fRd2
 UD4W3fc7RerX/nZOqfgHSJbmP6zJXz/sf+nT0PrTvff59C6vYIitn2jcEYQxyjMpzXEw
 m7D2VeBGVy+LN9KvkSZ5+Ssh6E8ICYPwrTsduIVIv35aGrF3aYJXAsCnx8JFr13+c6FP
 VrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714295178; x=1714899978;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nGIxKzJCDQjXBXXZTFBIShCWXnStqnqlbVDl8BPQr3M=;
 b=dWF10JyhmXQ+XVA5NEE9DQB9595D8b7Slo0gpia+4q+e/41bg+yXDLfz2IYUld4t3c
 N9XklpXUSi3jtWRk00PoyxhK1Zh3e/lpx1dDjCcWdPNeJml97vZ56vQX5ABOrHgmLyBL
 fL87b56cK6Ju1yn5vUxTBZdQC1jA78IYagEL58qtHNHP8M0sLv+zydfU230Ak3YPt8U2
 w5zPYRHG6Iuwd+uq6USqYIYC3f6gpJx0wfCDDkFcUoxL4rSJQatyR6i/elUbeFFL9iKP
 1uo3zTfn4NgR7S7EWB+3EeJ0h4Z/yZ/6p6Eb72WCVt0c98vGug+6PPGlBGHxv07q4G+Q
 bU4A==
X-Gm-Message-State: AOJu0YzByrj55/oZNP4fyvrCHva8jNfA0qR2zGX9qMtMqgpctLokOE9i
 QjNMzQMUoSwPaCeP5UN5Yr8M62YgQpCKnF311F+rH3dz9mob3sY1yZ9qJaBaCYQ=
X-Google-Smtp-Source: AGHT+IFmVKm1nxOG7xEt5aqtcuE34/Xe4X4KSrl6yJVV4av6yGXYCQFjPnHkNr+4qkKYEkblhxPRyQ==
X-Received: by 2002:a05:6a20:5612:b0:1ac:4ea6:1a54 with SMTP id
 ir18-20020a056a20561200b001ac4ea61a54mr7963796pzc.38.1714295178732; 
 Sun, 28 Apr 2024 02:06:18 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 e21-20020a62ee15000000b006e729dd12d5sm17310801pfi.48.2024.04.28.02.06.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 02:06:18 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Apr 2024 18:05:44 +0900
Subject: [PATCH RFC v4 4/7] pcie_sriov: Check PCI Express for SR-IOV PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-sriov-v4-4-ac8ac6212982@daynix.com>
References: <20240428-sriov-v4-0-ac8ac6212982@daynix.com>
In-Reply-To: <20240428-sriov-v4-0-ac8ac6212982@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-a718f
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

SR-IOV requires PCI Express.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index ec8fc0757b92..3af0cc7d560a 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -42,6 +42,11 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
+    if (!pci_is_express(dev)) {
+        error_setg(errp, "PCI Express is required for SR-IOV PF");
+        return false;
+    }
+
     if (pci_is_vf(dev)) {
         error_setg(errp, "a device cannot be a SR-IOV PF and a VF at the same time");
         return false;

-- 
2.44.0


