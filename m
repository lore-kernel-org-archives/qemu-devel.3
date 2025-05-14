Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EC1C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAdt-0006Ik-Dx; Wed, 14 May 2025 07:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdg-00062v-KV
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdY-0006Ek-34
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kBvJJ1guqk+Wh8WSiEg/aaEDfWIkM3a0BJ0cG44g7BE=;
 b=P0FsWYSZb0kCcjreZoQdDQx86qMpDPsVbqGr/FwP3D+SAtrLrmyh6PxzasjDM0SfOh5yze
 yoF0V2NPeizOvPcdgziVtORRqJ4Grzn7jBAhOVH7wq+2ZOsKqI+38b5CTvr55FGfgbXySV
 RrRRLQb93i7MQ7858qo/IZkk4Jbpluo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-63sCOTZNPnKAfhCjOb46sQ-1; Wed, 14 May 2025 07:50:56 -0400
X-MC-Unique: 63sCOTZNPnKAfhCjOb46sQ-1
X-Mimecast-MFC-AGG-ID: 63sCOTZNPnKAfhCjOb46sQ_1747223455
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-441d438a9b7so3167505e9.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223455; x=1747828255;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kBvJJ1guqk+Wh8WSiEg/aaEDfWIkM3a0BJ0cG44g7BE=;
 b=dE7CFzYKjLDpxLXihp/ximpPp9h63wdcTjKg5vNlQhgpQgbuzWh461StxE5ATokyYP
 yrClRqFrCV3m+mRQAAMuE38uXfhVQVYD9OufLkeyKvxl2yCjCkiSavaKy1GJsG93s6ur
 eZYmrFDoXNKkb89fP+CaeTZShNvoUU6di9WHpibxeNMHXaLtYrnhve/bMrHZ4zKakyuS
 FHCLP9MwBaCmDwQIHk9juYhcUFW74/x/J4EVlWyI1Y1aCezdijE9rxpTfLfqn7w2UtZ5
 Pn0HbqwmNE+ktQFqDJc3jFmH2ZpgpKrO/UhKVPyDqip7EWrceIkP82NHvaCUWlWCklBE
 IzIA==
X-Gm-Message-State: AOJu0YzZ0pUBkdLmxV03vqBzr16OB9CBRp1Zb/f1946LlMCTOMcNniXp
 ksiEMMGUIVwA21YkCnq30RNln52ay43LKONyCENMnYcIjYA292A9FARY0OsZeaX6+2pajhUus4K
 vWdqcEefgbgFZ8y87NdZQHWRE3Oj9fn7rbDGkvLE6W37YTXpssRFbJtPL1fAqnvgoo+UmyC/B7S
 LoseNulk2Qxm7RxPd8JylKCu0Xttm1tA==
X-Gm-Gg: ASbGncvXQJcmO/rjz0pRqXGZrP5AJcCLIIWPqAw1UVZyxLQHFJyvd5CCXZhZfgWoA5B
 qcvwqjoXro9tQ784nzKqbiu8lFbMmidFNKPDv/sjYRcNYftZNTVM66aCmAZ49iKjLpJzfl4KVzS
 Srk7zJBqleJtKBuEb+2yGAw7cSI8dKMNndaivknb3dyy6CXIQ9i6mh0aC6dJWA9KynVsxGz1NlX
 jDjt7Pd4b759jRcz5103pzxozrg6sV796E/OLGbUjpMZk7pHAtbpG9QU6VuXgj2wpYQJ5OgtTcI
 +ft+qw==
X-Received: by 2002:a05:600c:4f53:b0:439:8878:5029 with SMTP id
 5b1f17b1804b1-442f1a0d906mr25135305e9.2.1747223455027; 
 Wed, 14 May 2025 04:50:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnWl41lYrbfwjbiy1PM1u2OOHTggK1qSmnllwJQPj4jtb2JnyoXL+84o5BHp2qS2crE0qSbg==
X-Received: by 2002:a05:600c:4f53:b0:439:8878:5029 with SMTP id
 5b1f17b1804b1-442f1a0d906mr25135095e9.2.1747223454616; 
 Wed, 14 May 2025 04:50:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c052sm27873355e9.29.2025.05.14.04.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:50:54 -0700 (PDT)
Date: Wed, 14 May 2025 07:50:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Yui Washizu <yui.washidu@gmail.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 15/27] docs: Document composable SR-IOV device
Message-ID: <6f9bebf1dc6b54b63be739ea247b3942f841b9e3.1747223385.git.mst@redhat.com>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Message-Id: <20250314-sriov-v9-8-57dae8ae3ab5@daynix.com>
Tested-by: Yui Washizu <yui.washidu@gmail.com>
Tested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS           |  1 +
 docs/system/index.rst |  1 +
 docs/system/sriov.rst | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)
 create mode 100644 docs/system/sriov.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dacd6d004..b579358cdd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2058,6 +2058,7 @@ F: hw/pci-bridge/*
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


