Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87DDC3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 05:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTE8W-0001Qu-D0; Mon, 15 Jul 2024 01:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTE8U-00013e-2j
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:20:30 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTE8R-0007jK-LL
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:20:29 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3d9e13ef8edso2539963b6e.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 22:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721020820; x=1721625620;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RSyxXdQYMZg83yy/c3D8saUoTuohOw2eIYAXKlv1nkY=;
 b=jD4XVfdiyW3FJs8L80oeqr3UMclQrDS2Oht8y5XuMApwmMwjNbdMW2oDojFwcsLUor
 AxaQpxnUIzNkBWwG++5/EjHskoQiZal0AAjsNOkcCfWbiyKxNR/3dpZY+so4xhFhjWwU
 +WCD0Gjtsu/dvDsrywAbZt2/OwtUJOOXTxBD9Ky+TPUHx2wWH4BUz7Saipk3GvrLqw56
 EYj9syBdooSzuCcPtgv56Bu/tZqmPGXqvt2C4hEdX/2Ad3n1hJST4ouQLG8SjmSXik0W
 2UdjlyQCbb4PclduBN1i/n24fd0FW4nSGRgJD59IGqTY/Cb9qtI9JV6mkzgrLy2+1I8T
 Yfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721020820; x=1721625620;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RSyxXdQYMZg83yy/c3D8saUoTuohOw2eIYAXKlv1nkY=;
 b=b+5+Ma5J3777xH7zileDk4hFfnVkpiI/mussC7NxxNviLEk3W31rN/mvup4CECshdO
 j1+eCzdLGVH8vnXGDCd9eVQLYxJfWBV1Jd3TR4cj5rXHOHEtdcbRd4jr5CQM9BHlr9Hh
 pfp13IYtG+ZaP2aTc/eh8JxGC5gOGtWpGMEyEll6Hzvgx8/8xCJZG05eUgM3DwrZArQ3
 Q5v4Pz+8KJlwRRJXnm9idjG3W/dgQevo7KC2QJX/STlJTw8ibgB2T28gtPJ0amGGsJ1R
 q8dMJwrLrt5OBY7aVOYI/AAxhlND3sIjFrMUwyBMJMcX5B3iJk28sIiNRpmKLH4X5D5J
 PGOQ==
X-Gm-Message-State: AOJu0YxXriksbkfitl9PB/eaIJ7qYBcvE/9enSrWp8hnJJjQ7+in43dS
 aXiKSYPD3TByUkeMwab6WW7zrFbL0fh/wRY9nG92EVUR8oZmRgHsLXGMsl1tKG800DUMqvQ6/pV
 IMYM=
X-Google-Smtp-Source: AGHT+IGOeeOYo1mFPDGIODgqEMs+PesSFDuNNohkqj2KLkcAtBKb1XGMWVzdmJ5KT19m9Cq9/IsSRA==
X-Received: by 2002:a05:6808:179e:b0:3d9:2986:5a3b with SMTP id
 5614622812f47-3d93c085bb7mr22043699b6e.37.1721020818843; 
 Sun, 14 Jul 2024 22:20:18 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-78e32b6be78sm2105831a12.15.2024.07.14.22.20.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 22:20:18 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 15 Jul 2024 14:19:14 +0900
Subject: [PATCH v5 8/8] docs: Document composable SR-IOV device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-sriov-v5-8-3f5539093ffc@daynix.com>
References: <20240715-sriov-v5-0-3f5539093ffc@daynix.com>
In-Reply-To: <20240715-sriov-v5-0-3f5539093ffc@daynix.com>
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
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::233;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 MAINTAINERS           |  1 +
 docs/system/index.rst |  1 +
 docs/system/sriov.rst | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6725913c8b3a..ca0222e5528b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2008,6 +2008,7 @@ F: hw/pci-bridge/*
 F: qapi/pci.json
 F: docs/pci*
 F: docs/specs/*pci*
+F: docs/system/sriov.rst
 
 PCIE DOE
 M: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
diff --git a/docs/system/index.rst b/docs/system/index.rst
index c21065e51932..718e9d3c56bb 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -39,3 +39,4 @@ or Hypervisor.Framework.
    multi-process
    confidential-guest-support
    vm-templating
+   sriov
diff --git a/docs/system/sriov.rst b/docs/system/sriov.rst
new file mode 100644
index 000000000000..a851a66a4b8b
--- /dev/null
+++ b/docs/system/sriov.rst
@@ -0,0 +1,36 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Compsable SR-IOV device
+=======================
+
+SR-IOV (Single Root I/O Virtualization) is an optional extended capability of a
+PCI Express device. It allows a single physical function (PF) to appear as
+multiple virtual functions (VFs) for the main purpose of eliminating software
+overhead in I/O from virtual machines.
+
+There are devices with predefined SR-IOV configurations, but it is also possible
+to compose an SR-IOV device yourself. Composing an SR-IOV device is currently
+only supported by virtio-net-pci.
+
+Users can configure an SR-IOV-capable virtio-net device by adding
+virtio-net-pci functions to a bus. Below is a command line example:
+
+.. code-block:: shell
+
+    -netdev user,id=n -netdev user,id=o
+    -netdev user,id=p -netdev user,id=q
+    -device pcie-root-port,id=b
+    -device virtio-net-pci,bus=b,addr=0x0.0x3,netdev=q,sriov-pf=f
+    -device virtio-net-pci,bus=b,addr=0x0.0x2,netdev=p,sriov-pf=f
+    -device virtio-net-pci,bus=b,addr=0x0.0x1,netdev=o,sriov-pf=f
+    -device virtio-net-pci,bus=b,addr=0x0.0x0,netdev=n,id=f
+
+The VFs specify the paired PF with ``sriov-pf`` property. The PF must be
+added after all VFs. It is the user's responsibility to ensure that VFs have
+function numbers larger than one of the PF, and that the function numbers
+have a consistent stride.
+
+You may also need to perform additional steps to activate the SR-IOV feature on
+your guest. For Linux, refer to [1]_.
+
+.. [1] https://docs.kernel.org/PCI/pci-iov-howto.html

-- 
2.45.2


