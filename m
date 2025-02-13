Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FA8C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 11:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiXNX-0007om-EM; Thu, 13 Feb 2025 06:27:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiXNV-0007o7-Lg
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 06:27:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiXNT-0002cE-QL
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 06:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739446050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WszW0NxKZSYHFFSiUB5cJcU961As2uXrLrk50UN0l2U=;
 b=c0jQ/oTHK/bt32g7Hnda1syMvciDWSnXi3SRVt6usb8n86RhKCpSeqTlev2R7OrdZ+/Ph2
 9BLu49CeaG6P2VK8ojCPnXzksXYydsF3ohyH00bqIY0kCFGLaKn83XahKhpE0zL9DAbFFC
 SQBVGW7XHdhI/wan5/PwXy5J3Z5E9H8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-VftISt13OnGDG7rAOaRvfg-1; Thu, 13 Feb 2025 06:27:28 -0500
X-MC-Unique: VftISt13OnGDG7rAOaRvfg-1
X-Mimecast-MFC-AGG-ID: VftISt13OnGDG7rAOaRvfg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f20b530dfso761539f8f.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 03:27:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739446047; x=1740050847;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WszW0NxKZSYHFFSiUB5cJcU961As2uXrLrk50UN0l2U=;
 b=B+6ZS4yjkyQdO6FAlJTkHlQ10it6l35vEU9WRBbc9M+4Ij60acFlOUoYYq4BP0aWt5
 LdLhvd8pBsQEeK0kOmURPpPKKu48rL2elUYAyuwPgSj5gDMIw8bTitdKINqXbNFYhzGJ
 OLjkhVSKUe7XneFK5Rfx9HG7tJ8phCfHTR09W5mTNYsaSqjRttPYdy+F1BU/3ZVwPKP6
 lSslD6SoK9WupaWVWrYya+8WjYUGqYCoHNmux1ZhsXCoDMobKkO7zPVQ/qXTNPFWU+oq
 aV/D1bzBmqYohLAW8BgLzsSdFo5YJoO6562UPSJLt0kWYBYWdKEkMYwuvbLyI17pQy9F
 Vbzw==
X-Gm-Message-State: AOJu0YzarVsNDbZU76pInsCVeb6DWmvISZ9/dBnVkzaNRUJVUpQ6pP1m
 llr/1Xlo9NrxnBwoYCxTghO+0hK5nrX9AaI/XVhRXlJg9f/2AlzFJl09lQPggdS1zhk/PilDO4I
 ElMT2+1xggVOCmpNR/KaoKEUV2pNaehynuVbP40zSA10Foh5LFKM1WKydSD9uE24ENEsWNblXsV
 Kl2/SL6ecEiKNLlwn/mcRA5Z8Xk/8vg+ElZ10Fax0=
X-Gm-Gg: ASbGncta/uVXOgsuLAPxQam0CqXi3MXJeFySMqij6HFYlFXzEv+7GMTPESNdRU6UIj1
 sdCKqG9vV57woPmy43hCnRYXX9UyqIpip5fSOgSXJhYVv891v3m5+VLSoJWTzUVFez3nyLYsQ80
 pJd/IMOp6OqiDe4z+RtlrABu6KFliX4xteL7SsDZfzRGcJP4ovJZsF5FRkMLVLReolgSAdj+LCN
 lXgf6YrmNztQc1XTw03lxs0NB9AIb0miQFXQnRXl32q4azcNtK+/CI79x+cjoX12QTaQV476lCW
 kr+vw5INIQ==
X-Received: by 2002:a5d:59a5:0:b0:38d:e3db:9058 with SMTP id
 ffacd0b85a97d-38dea2706bdmr5089263f8f.12.1739446047366; 
 Thu, 13 Feb 2025 03:27:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlnFSeO2p9WVFB42H7rNJM2srb/DJKI+83tpwQj42tzHfE5/ndxvH6dLXs0C2fugHogyt4Xw==
X-Received: by 2002:a5d:59a5:0:b0:38d:e3db:9058 with SMTP id
 ffacd0b85a97d-38dea2706bdmr5089220f8f.12.1739446046868; 
 Thu, 13 Feb 2025 03:27:26 -0800 (PST)
Received: from [192.168.10.48] ([151.49.218.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f7df2sm1597545f8f.84.2025.02.13.03.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 03:27:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: junjie.mao@hotmail.com,
	qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH] rust: docs: document naming convention
Date: Thu, 13 Feb 2025 12:27:22 +0100
Message-ID: <20250213112722.3850356-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


