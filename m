Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FA0C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDEB-000303-OE; Tue, 23 Jul 2024 06:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDE5-0002R9-2S
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:58:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDE2-0002Fw-NI
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5E7G/VDojDj4ibiTS3jf3QznN/MYs3lrA9S/9uTukCs=;
 b=UkJPngvuhDLfMcpKX/790upCuh+i67sUh5G6cs18I5FqvQn/Id7a3j1WMsjL+fqxuKeiOA
 x7ul62PAIUNIen7T8dEisSLe5Y3kP5RX7S3PeoW1yuK/LpHkBoz4PLMRK7aWzHkW5PVIpZ
 P0MXooGkJGiDSaBNMl7qaQasOiMvpXg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-2vkn-68UOT2ldQhHvwdXVg-1; Tue, 23 Jul 2024 06:58:32 -0400
X-MC-Unique: 2vkn-68UOT2ldQhHvwdXVg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5a355a541efso1428423a12.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732311; x=1722337111;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5E7G/VDojDj4ibiTS3jf3QznN/MYs3lrA9S/9uTukCs=;
 b=sI/Dq0kS74Rf2DsN6A2LUMg6VrQ2LrHbhrnQlEHdNwqDk+PFHXfBWmUDoDbTApVKmZ
 JzXftn3b90jTlBGFsPqLdi20AX8IGldBx7sqUqKdoCVQ9yNwuojqy6bM0KY7LccVT795
 AMvA/FKE2RoGyBJEPWusAaSqj1A708y+5cJFL7IM6aPgjxODKfkBTFUJN82onI13maCv
 L4l+bhll/RnbEbUm2/J5oSHHDDskeIqts/FgDanCr3q+hF0HQYKULMTw/oi6vQcoSjo6
 JLT5BaLt+jWKhF/Tmw0nCiIT4h3HvX1FbJWUNJdj9gVJ3K+QjnR36q0IvS9HPdj5djg5
 EQ2g==
X-Gm-Message-State: AOJu0Yxw3RETZ+2f8hjCJL0RBQZ85w/Mxk0ETUr2EcySa5Spg7mdr1aX
 L5zznWrDPImrKyssTrJiZg0vrbxIzPnTKUrKMu0fJJsqEpjDsXmU4xqR7QZ2u8ooruZT1Kaf0tA
 IoPRtQBZOVs8VbS2cKNYIAousQrRyVenuN65KiTrdG5850NZYZEEP0iAH1d1+5M7/00gzDGkLFA
 MrZqlnUc658P7upq2NR7oaIFyQiry6Yg==
X-Received: by 2002:a50:99db:0:b0:5a1:c4e3:a7a8 with SMTP id
 4fb4d7f45d1cf-5a47b1de8afmr7229807a12.30.1721732311277; 
 Tue, 23 Jul 2024 03:58:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcv9lXMcodxGXV8Uj0uGofXExG9ARXxwDi0tk9K4EadDUX6g4anfSTnwersMGA619+JYIY3g==
X-Received: by 2002:a50:99db:0:b0:5a1:c4e3:a7a8 with SMTP id
 4fb4d7f45d1cf-5a47b1de8afmr7229786a12.30.1721732310592; 
 Tue, 23 Jul 2024 03:58:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30c7d38f7sm7412156a12.88.2024.07.23.03.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:58:30 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:58:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v2 35/61] docs: Document composable SR-IOV device
Message-ID: <d6f40c95b35bd380340b698e4306704fe22a5d68.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


