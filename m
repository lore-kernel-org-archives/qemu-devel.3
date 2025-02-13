Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788DFC021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiber-0000vt-0H; Thu, 13 Feb 2025 11:01:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibeJ-0000op-JW
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibeD-0005PM-JT
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WszW0NxKZSYHFFSiUB5cJcU961As2uXrLrk50UN0l2U=;
 b=ZL92n1OJJupYecXua3K6tOmQDfE1EBXS/9Egz5xhhZTmGj4FjMWUcXs9U4lyrMdgxTc+Zd
 kszC4U6QeMTD9Jd5KaWnJNLz+w7f/zZ5EOIR8PMdkZov+tmq3jYXhx0VUzwKLmXmL2HoZC
 EKSoWqCwwemRRa/nE8hyPT1mwyrjdAY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-vHSMizb1NX6hT6xb5joKng-1; Thu, 13 Feb 2025 11:01:02 -0500
X-MC-Unique: vHSMizb1NX6hT6xb5joKng-1
X-Mimecast-MFC-AGG-ID: vHSMizb1NX6hT6xb5joKng
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43941ad86d4so8422565e9.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462461; x=1740067261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WszW0NxKZSYHFFSiUB5cJcU961As2uXrLrk50UN0l2U=;
 b=uyHngAvOp/AcAyKb3Iwh2mgORbmH/85dRKXAwqh47UrZ3hpLOOFUOstylkcC8jwGW5
 9Cg5MLSOJ2B+8HTBJH0VOf+A7/b4T0AnPAkFgO9H8cYvQDwGU6RVQRYSnECUJzktzR6V
 C1rSBpx6xWDoYClp5Hitluinek4cp1+t8FCGjbJVPBeTe4YnWeo/QhKn++cZl+83Fanh
 1/VIYerzEr/t/x2pwg8GX9cHXs8dBJpI873Q86/Bx+Hu/iS9aXEzTyU1yL61opB84Nsz
 HzuaDyKJpihWe1qUoYmgUCOQq3VQfMfgHvT6OdfZQgL+NbsW78tMfALLi3ajH+kpBZEQ
 I2Hw==
X-Gm-Message-State: AOJu0Yx6lztEu+OuW3G1acnmfovlWyzOvQMfy+VDLHe4dm/fD27D0TNl
 hAtTwdUaL9zVVQ4s24d2ea1HxWAJQvriAQTKTSaKlheqmGtRR5d1NmBocblHp3Dw8wjC1kpLq2T
 OGZOWMeDy4iSc7s8DVROdzz5dwEwGAG2y4u91T5Id3mSg6JgbF4TZEqFCnRrCv/P+dRpS55zj6E
 YVa02MTthQLPgL75HniypraHehn5YgPVra7Ls8FjA=
X-Gm-Gg: ASbGncu9XeXH1nfQ5c+1IisnsXOMn988Go0v9orxuxOWRA320clSVGngRHGjCXGinQf
 3Hj1fyicCTCCZ7vKvP9Gj+pmgm+OmxCiuHBAb8T6klw8RNibWwUorVQ2sh92jGWJ4uzFX62JroM
 vL1H83CqaeCbFNIv862mpJZqgu6GhM2lhOkJwKT++bF+6EfjaLr+xzuN+52ZTZ7tmHc5CQvlaU5
 xavVr723WLYsit3SSxoiFrZSVN69gFuiPtESee2MnnH8pJzaO6OxoZ93fuE+uTu7JNJgVYBWpcW
 TqGOHx2OydkTQSF5nIgzZNtaRcpo5Ews4Br87uJbGVacIw==
X-Received: by 2002:a5d:598e:0:b0:38f:21ce:aa28 with SMTP id
 ffacd0b85a97d-38f21ceb0famr6167230f8f.36.1739462460311; 
 Thu, 13 Feb 2025 08:01:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGV2iV679sLK2Kn6isMwwx8W+PjBeaDA8rvAcFeN/A8HvlbVfbSMlvN/1+ih+wfA+QMrBd4FQ==
X-Received: by 2002:a5d:598e:0:b0:38f:21ce:aa28 with SMTP id
 ffacd0b85a97d-38f21ceb0famr6167121f8f.36.1739462459383; 
 Thu, 13 Feb 2025 08:00:59 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ccd2csm2318611f8f.30.2025.02.13.08.00.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:00:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/27] rust: docs: document naming convention
Date: Thu, 13 Feb 2025 17:00:28 +0100
Message-ID: <20250213160054.3937012-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213160054.3937012-1-pbonzini@redhat.com>
References: <20250213160054.3937012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
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

As agreed in the "vtables and procedural macros" thread on
the mailing list.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 390aae43866..8cccca7a734 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -194,6 +194,50 @@ module           status
   interface either.  Also, ``unsafe`` interfaces may be replaced by safe interfaces
   later.
 
+Naming convention
+'''''''''''''''''
+
+C function names usually are prefixed according to the data type that they
+apply to, for example ``timer_mod`` or ``sysbus_connect_irq``.  Furthermore,
+both function and structs sometimes have a ``qemu_`` or ``QEMU`` prefix.
+Generally speaking, these are all removed in the corresponding Rust functions:
+``QEMUTimer`` becomes ``timer::Timer``, ``timer_mod`` becomes ``Timer::modify``,
+``sysbus_connect_irq`` becomes ``SysBusDeviceMethods::connect_irq``.
+
+Sometimes however a name appears multiple times in the QOM class hierarchy,
+and the only difference is in the prefix.  An example is ``qdev_realize`` and
+``sysbus_realize``.  In such cases, whenever a name is not unique in
+the hierarchy, always add the prefix to the classes that are lower in
+the hierarchy; for the top class, decide on a case by case basis.
+
+For example:
+
+========================== =========================================
+``device_cold_reset()``    ``DeviceMethods::cold_reset()``
+``pci_device_reset()``     ``PciDeviceMethods::pci_device_reset()``
+``pci_bridge_reset()``     ``PciBridgeMethods::pci_bridge_reset()``
+========================== =========================================
+
+Here, the name is not exactly the same, but nevertheless ``PciDeviceMethods``
+adds the prefix to avoid confusion, because the functionality of
+``device_cold_reset()`` and ``pci_device_reset()`` is subtly different.
+
+In this case, however, no prefix is needed:
+
+========================== =========================================
+``device_realize()``       ``DeviceMethods::realize()``
+``sysbus_realize()``       ``SysbusDeviceMethods::sysbus_realize()``
+``pci_realize()``          ``PciDeviceMethods::pci_realize()``
+========================== =========================================
+
+Here, the lower classes do not add any functionality, and mostly
+provide extra compile-time checking; the basic *realize* functionality
+is the same for all devices.  Therefore, ``DeviceMethods`` does not
+add the prefix.
+
+Whenever a name is unique in the hierarchy, instead, you should
+always remove the class name prefix.
+
 Common pitfalls
 '''''''''''''''
 
-- 
2.48.1


