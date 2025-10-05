Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC52CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFe-0003To-9f; Sun, 05 Oct 2025 15:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFO-0002RS-Su
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFL-0006b7-7F
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oGAY834jKYfbFDJ68UHHIZdDsuzgPXz3Cw6hb0ar51o=;
 b=JcfZcsqHX3AeGEaYwyDWrM0RhxqorXn6KhXDBodfW4+Jsn2C4WNYWdxyHSvMMe907Lv4ZN
 09oH+YlVAI+wFBZ0XOSJCimrIuzaWHS/PboxYPTCUi657XCnF63T3haHw9IKVl3+D1qQYq
 Uz5DZSG32u5/fElybhPDVINVmiQHQZ0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-y2r6h5l6MPSfVotsXLKhMw-1; Sun, 05 Oct 2025 15:18:09 -0400
X-MC-Unique: y2r6h5l6MPSfVotsXLKhMw-1
X-Mimecast-MFC-AGG-ID: y2r6h5l6MPSfVotsXLKhMw_1759691878
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e375dab7dso18415455e9.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691878; x=1760296678;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oGAY834jKYfbFDJ68UHHIZdDsuzgPXz3Cw6hb0ar51o=;
 b=q2faXsG70DbKNHQz6AfvLRTgSA1b21uXxkr+dI1uywqNjfiqfKosIKzsNQXrWCM583
 y2NB4EOTjky9NsMGO8FcBzzzpYyiqxPcoI5Rlz6J3VguTh9wjDLAcA16ZylxocV8iosr
 Rh60/YTWnliItQ9Rn1MFdpC+n5J6BXniDy2H2s/Iuxko4T5eya896tF8+nOAAvMWaKXr
 jQMyNf6noJit+oYVDyCPYG7+FZmOSJcjDB4v/73fT/qCAhNl2C9Xoq4QRwSQVlRkf1w7
 XfuEowRy2CBnlVd3FH0tGPxtDZP/mOoVVHEiqxRP5luv16QbgeTfyVTcMWVCAB/iev8p
 ybQg==
X-Gm-Message-State: AOJu0YzZNVJc22qaCb4M5s4euqhkgQtrAqxEYFv/HsGHih8qCqWP612t
 5tSlgIPL/BeYmxmV+jEr2jgc9pw6gHV27U4A5++ssO7g/7aoFn+5H6504elxwcoHvb7qkAsmpwb
 xcKxAyhPSrY0r3k3ozjt48DTiZxjfEWbqwARBCFRBTGK75MncjGQmpG17TTaH6C56I4/w5QDTQz
 n0nblBS7QSuKsECsecJV4KI2ameVBlYV4jyQ==
X-Gm-Gg: ASbGncuElzCFglWf82mTvmbOHEEAFnAOmSAV4Yv5OhCotnatMk8zzoCf/VjURXF6FSN
 va8NUe0kg/3CqE8dwvdwlLvmEKWZOgWANR+TEa/flSZzZKRtQmVNN3SwLbQJgEplMXwJBLwZll8
 5fubNkbfbXoPGKcTLinj+6cMCrKDV6f/pPx6foQgpH0haF2jxeJ2KnBQHr1wZowK5zBVQYtRGpu
 m7MxCK8gb2AP8q9t500zT5z9vKf/qjcaoghgoNAizqj/RVemVsYlyuDmqn3pzUwC1dR+rUQ0z5H
 TgMr231CAD3LMVFAQfdg2q7z2UcwaoHPzkwe6L0=
X-Received: by 2002:a05:600c:a319:b0:46e:74cc:42b8 with SMTP id
 5b1f17b1804b1-46e74cc4609mr51030425e9.17.1759691878156; 
 Sun, 05 Oct 2025 12:17:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2Rx4DnBOal6t//z0yM/sD+4kOgczG33Pu07EYw0/ix+ith9EWVS0PcJ7lVfH5jiZme8Yf8g==
X-Received: by 2002:a05:600c:a319:b0:46e:74cc:42b8 with SMTP id
 5b1f17b1804b1-46e74cc4609mr51030315e9.17.1759691877627; 
 Sun, 05 Oct 2025 12:17:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e723593d8sm135637725e9.11.2025.10.05.12.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:57 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 51/75] amd_iommu: Document '-device amd-iommu' common options
Message-ID: <0888c071ff8370f118ce22c0fe873b13e11d319a.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Document the common parameters used when emulating AMD vIOMMU.
Besides the two amd-iommu specific options: 'xtsup' and 'dma-remap', the
the generic x86 IOMMU option 'intremap' is also included, since it is
typically specified in QEMU command line examples and mailing list threads.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250919213515.917111-3-alejandro.j.jimenez@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qemu-options.hx | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 3ff10ec09d..9b4e870350 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1238,6 +1238,29 @@ SRST
         Accepts either the default root complex (pcie.0) or a
         pxb-pcie based root complex.
 
+``-device amd-iommu[,option=...]``
+    Enables emulation of an AMD-Vi I/O Memory Management Unit (IOMMU).
+    Only available with ``-machine q35``, it supports the following options:
+
+    ``dma-remap=on|off`` (default: off)
+        Support for DMA address translation and access permission checking for
+        guests attaching passthrough devices to paging domains, using the AMD v1
+        I/O Page Table format. This enables ``-device vfio-pci,...`` to work
+        correctly with a guest using the DMA remapping feature of the vIOMMU.
+
+    ``intremap=on|off`` (default: auto)
+        Generic x86 IOMMU functionality implemented by ``amd-iommu`` device.
+        Enables interrupt remapping feature in guests, which is also required to
+        enable x2apic support.
+        Currently only available with ``kernel-irqchip=off|split``, it is
+        automatically enabled when either of those modes is in use, and disabled
+        with ``kernel-irqchip=on``.
+
+    ``xtsup=on|off`` (default: off)
+        Interrupt remapping table supports x2apic mode, enabling the use of
+        128-bit IRTE format with 32-bit destination field by the guest. Required
+        to support routing interrupts to vCPUs with APIC IDs larger than 0xff.
+
 ERST
 
 DEF("name", HAS_ARG, QEMU_OPTION_name,
-- 
MST


