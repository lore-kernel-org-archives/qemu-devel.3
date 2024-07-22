Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFD8C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgko-0007ms-KI; Sun, 21 Jul 2024 20:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkm-0007dU-T6
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkl-0005ry-4M
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5E7G/VDojDj4ibiTS3jf3QznN/MYs3lrA9S/9uTukCs=;
 b=QMrvZs1emuF/JtSyfv4Nqfz7+zIAeaTmreNBhbxLo15Tc0/1kicW2wvyDdPUmfcMnUsbQG
 tGYFUdtZrAHEQhNvgTwm9qLErHJhfzFQwRM18e5BrCIE+4GkveSslxyZfzAqJrXp8YKG+d
 b6h5IXwm/GIdkjkIGedwWgE373JchI8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-kvIZR77dPGu_tsauDmmbqg-1; Sun, 21 Jul 2024 20:18:08 -0400
X-MC-Unique: kvIZR77dPGu_tsauDmmbqg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4279837c024so26476995e9.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607487; x=1722212287;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5E7G/VDojDj4ibiTS3jf3QznN/MYs3lrA9S/9uTukCs=;
 b=P5fOofpueT2W4EBlRPGWQvHXwPUz9d6UuN05cIFkma7AIjmMCEJK6Md3R5MuOh/d9b
 CtG2prFcmD75OjC3V9dSk9llAfdGmH9r8igT9oW6jPgOX3oK9YLOjjXWixYt4bQS6+16
 fewbDQC70A78dbGG1cS4fI4KnUZvmDnmxS0RC93T6Ibk/8IwxHDV21g3uQq42ZGrb3Rt
 YgMlZlDjhAvKSK1af+lO/v0AjtLY12cP+Po9Tmbeu5YqNmuENv37SR7FkcowjnL1RpnE
 6i4DFVlcFK1Y1wmRH2fCG/uIG05OlQdM8Am4+ImiMkkvTXiAivNY11olTogzu+Aaybkd
 HVog==
X-Gm-Message-State: AOJu0Yyb403fPSDiZI4apjs7l1mVccNP2CHj6O4CVyU00gBRsfqLQI0E
 yA2IzUcq+ZrYBc6s1H1OaGNspHL7t/qEUBuGvrEvnNqKvUVzHBcqPJHwOnPvr0BKa9eYyLbfe61
 LpG77uc4dqAFI5RaU5+vxIl+fbn7SZgB6ZZnUBirJLmo5Nz897I99ovGJ7J8SMHGWqLn310Jsg9
 IuIR7XC2xRY5L0c6qZnTHCKpt+BMWStA==
X-Received: by 2002:a05:600c:4e0b:b0:426:6960:34b0 with SMTP id
 5b1f17b1804b1-427dc548427mr30233945e9.14.1721607486771; 
 Sun, 21 Jul 2024 17:18:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxEVQ3KwS2LR2rWd0mmLiuRESKoOlbbP4m71TqGOKmjnPQ5ZGQPJGqVksckWRSl4u/svDYxA==
X-Received: by 2002:a05:600c:4e0b:b0:426:6960:34b0 with SMTP id
 5b1f17b1804b1-427dc548427mr30233805e9.14.1721607486158; 
 Sun, 21 Jul 2024 17:18:06 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a721b7sm130681815e9.27.2024.07.21.17.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:18:05 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:18:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 36/63] docs: Document composable SR-IOV device
Message-ID: <7d09142ad4531b2c9f1a6394a591052a325f83c4.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240715-sriov-v5-8-3f5539093ffc@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS           |  1 +
 docs/system/index.rst |  1 +
 docs/system/sriov.rst | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)
 create mode 100644 docs/system/sriov.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 8ad64ff76b..93546cfb14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2010,6 +2010,7 @@ F: hw/pci-bridge/*
 F: qapi/pci.json
 F: docs/pci*
 F: docs/specs/*pci*
+F: docs/system/sriov.rst
 
 PCIE DOE
 M: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
diff --git a/docs/system/index.rst b/docs/system/index.rst
index c21065e519..718e9d3c56 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -39,3 +39,4 @@ or Hypervisor.Framework.
    multi-process
    confidential-guest-support
    vm-templating
+   sriov
diff --git a/docs/system/sriov.rst b/docs/system/sriov.rst
new file mode 100644
index 0000000000..a851a66a4b
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
MST


