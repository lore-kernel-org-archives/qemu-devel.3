Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43859CE7AFD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 10:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smW1h-0000HF-4R; Fri, 06 Sep 2024 06:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1smW1c-0000Fy-NK
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 06:17:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1smW1Z-0001xw-SZ
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 06:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725617824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BXAIyxdDugSd3fqR3MyK3cxBBXskmjK46N0xccTFl6o=;
 b=IRYhAaiDJXFGFzmX7LqpOhJRib11bLWM24966Tc7MxRqP7ce60PZ4Py3NTXC3SGlNYXYzS
 dfxr1BpT6E/6Hjakx3Gjg0HChCJQiXsOzSmPjAUby9xJsKSyJOg1aT4kn3A7RuGvIqkeoT
 6nSQLbD/5JzwyvYlJP46xLrefipWBbA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-aw2NfO5xMdqJA1S_3EH_cA-1; Fri, 06 Sep 2024 06:17:03 -0400
X-MC-Unique: aw2NfO5xMdqJA1S_3EH_cA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-374cbbaf315so994357f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 03:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725617821; x=1726222621;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BXAIyxdDugSd3fqR3MyK3cxBBXskmjK46N0xccTFl6o=;
 b=CuHR2Q9oTAEY9ddnzkNFpSiUgxqmIyNasgP3gzKcHTWDzts7Hy5/BoZzR0wN3BPEAH
 m5eNU+bf1wDFpmIv08Xd1KE/IfqMvkxQfhW9l7/dTdq3Qd930rHRwuQfP/DPmNaTMQrp
 2uKw8MwtfNJzCZLQOOh7oFlvB1CucOh4+dqaEwNwdAN//DRh9oLCpFpuHm0Ipd3awDs+
 YX7Tl7MW1es1jxyyfHxDav0hCNH8radeOb4jcLFUCu79lDK4LKr+ALJad2gXe3jduqOF
 1a6YzYYt7ML9F7s6+h+f/gQJnONoeKbKUSUi+7dtF22pZUoj8N8WbOBZxibYIfWa0Lr5
 iC0A==
X-Gm-Message-State: AOJu0YxVEiihtAL0k1rQIKRXx1TzkJjmTMb8j5yTdqUNJ50hYKaQ32y5
 Pis+WyQoC7e5T41297UOpE7EtrJTBdGsIHSwtcuTBJdNB/hO1bmca09PrT79+bPPhpPrkuENktH
 KherV5Yrvh7sHrQkBXz9wIrUjrdOcLeVL04jhZJTiiVeEXo+uE6ZCwhT4/0WBMTDKDmuJd1EBiW
 Ww8N6E0eZaTv6FAq6r6D92TLnuB2uOOq7j8fVXL/c=
X-Received: by 2002:a5d:5406:0:b0:378:7de8:df33 with SMTP id
 ffacd0b85a97d-378888478bfmr1210359f8f.31.1725617821428; 
 Fri, 06 Sep 2024 03:17:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmGAJaGELTfVGRxDX5u2jlr0rN7fwdCPApjWMDKMWEGFArauTo03LutCK9CizVUM525sarBg==
X-Received: by 2002:a5d:5406:0:b0:378:7de8:df33 with SMTP id
 ffacd0b85a97d-378888478bfmr1210345f8f.31.1725617820927; 
 Fri, 06 Sep 2024 03:17:00 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ef812cbsm21444746f8f.83.2024.09.06.03.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 03:17:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v2] virtio: kconfig: memory devices are PCI only
Date: Fri,  6 Sep 2024 12:16:58 +0200
Message-ID: <20240906101658.514470-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Virtio memory devices rely on PCI BARs to expose the contents of memory.
Because of this they cannot be used (yet) with virtio-mmio or virtio-ccw.
In fact the code that is common to virtio-mem and virtio-pmem, which
is in hw/virtio/virtio-md-pci.c, is only included if CONFIG_VIRTIO_PCI
is set.  Reproduce the same condition in the Kconfig file, only allowing
VIRTIO_MEM and VIRTIO_PMEM to be defined if the transport supports it.

Without this patch it is possible to create a configuration with
CONFIG_VIRTIO_PCI=n and CONFIG_VIRTIO_MEM=y, but that causes a
linking failure.

Cc: David Hildenbrand <david@redhat.com>
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index aa63ff7fd41..0afec2ae929 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -16,6 +16,7 @@ config VIRTIO_PCI
     default y if PCI_DEVICES
     depends on PCI
     select VIRTIO
+    select VIRTIO_MD_SUPPORTED
 
 config VIRTIO_MMIO
     bool
@@ -35,10 +36,17 @@ config VIRTIO_CRYPTO
     default y
     depends on VIRTIO
 
+# not all virtio transports support memory devices; if none does,
+# no need to include the code
+config VIRTIO_MD_SUPPORTED
+    bool
+
 config VIRTIO_MD
     bool
+    depends on VIRTIO_MD_SUPPORTED
     select MEM_DEVICE
 
+# selected by the board if it has the required support code
 config VIRTIO_PMEM_SUPPORTED
     bool
 
@@ -46,9 +54,11 @@ config VIRTIO_PMEM
     bool
     default y
     depends on VIRTIO
+    depends on VIRTIO_MD_SUPPORTED
     depends on VIRTIO_PMEM_SUPPORTED
     select VIRTIO_MD
 
+# selected by the board if it has the required support code
 config VIRTIO_MEM_SUPPORTED
     bool
 
@@ -57,6 +67,7 @@ config VIRTIO_MEM
     default y
     depends on VIRTIO
     depends on LINUX
+    depends on VIRTIO_MD_SUPPORTED
     depends on VIRTIO_MEM_SUPPORTED
     select VIRTIO_MD
 
-- 
2.46.0


