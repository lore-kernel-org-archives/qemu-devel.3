Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225F9E7716A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 00:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMzJ5-0001G2-4Z; Sun, 15 Dec 2024 19:49:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tMzJ3-0001Fk-54
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 19:49:53 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tMzIw-00073I-GB
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 19:49:52 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-216728b1836so24537615ad.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 16:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1734310181; x=1734914981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KGU2u7dc4vF2vyfDv3T9ZFSN7CKazY7j/eyKw4lus10=;
 b=MN9zGA17PStnPXAYgKMsCO1SAv3FCefEW7nhEpWTQ7PJAW/UXoQcPbq/ZdaP/HXz87
 Y6BTOB5AjhjKGAiQwf3X7Sa4i2rVjAlIXyfK2aNqH8SwmXo8kHXQkW6BBTvVjqYh7c1j
 oM8HhvYgGcXT1o6lSronAYTDa+CKcHC0EwciDvxopfneFxMbjTSLhmOnzf7LgUSB/44R
 c8+fAIvYLgV+CHDNk1JNPb8qQgdICe536CRR4845aTrPM46Eso/PUzCpWtF2AvBqK63Q
 unSiKHbvCmyCcjWO8oD8ollTjfstojMwiYFRIK4dLzThrSyMcHJKZoY0w3CEiGQ2SjF5
 tXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734310181; x=1734914981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KGU2u7dc4vF2vyfDv3T9ZFSN7CKazY7j/eyKw4lus10=;
 b=nvlcp+HD5ZNQN8JXhcCQNnklesqcVPg29K1PkMjB5ZrcVe6v8DEeS233CGI4Fy9rqB
 UPUnDzRRQAUMu2Q6VQabJUVCe01MOMBOvskwIOJDbJ1wGJP087dPzXJHh4wQd6hfroEp
 U3hZZlIP5BfqlvrN6W71DpldfAbuI4MQMBTb6hQTlPXqpPVpmj3AxM6byYvKV0nXiEfV
 VcqnyEv9XvEBySyey4xdcmvywcN69+qkcqc/mHaLtFTgtfgbJydjoDuF3v8+tFsjGkwW
 0YeoBNCwB07yK8JYX/ez/aGJD+aZlSk4jdnEmaLviImloL3kxI3AySqHz+ZRto9hpj62
 sB7Q==
X-Gm-Message-State: AOJu0YzUGQW6XDuiqwWvoGVCCxs5zLHgGgcBx06ZkFVzCrHWyiBkvtTR
 L7CDCHTtb5nyTP9FXHznZ/B1OqbRu1jpfR7qcpsg5vCJRjTQ7duY6qISguZu9n+kMUGGyEtqFC5
 Z1/MoM8yq2CcJycGQRqRWndP/yvemdXju2/cmTp2Q76ynR3P4yuqNd11u88zhvntyIYEo+evZjT
 Sz76jmjqn2V1u0ExvRqUPZQrMiNG2mhUPQxb2xfSlpq5r2qJo=
X-Gm-Gg: ASbGncuTCqttX1Ov2C/ONr3sUYxaoM1uncS9DyFCXrWRliuQ5jlybTrzv1bi+nQCATB
 TZK1N76yrnj7Tr0/omJAdl4YaktyfkJQenO+eVP0KCtFi/ny8U2tB3meywmuIKWn6q3kFCwd/OG
 pawWHCFty7jqAY5mxsddNx4xdwNF2BUir9reEc8ytE8oKojq7sY5Bh3mUXvPzRqArcFTt5kYwxN
 /2xcADNoBQjrwjKMwmPe06gYtu53cwSbd95bgYZlWUenCARUE/EyFTjW6pMgTYsTyhiHf3mputx
 IqqqSqH/
X-Google-Smtp-Source: AGHT+IHHXEDgr6REu1/UiEmWcihNjDhUHo43i90n1NWtN7yO5Bz8w417fbDj8Tgyg0Q2/o9Dcvfbpg==
X-Received: by 2002:a17:902:ced0:b0:216:1ec6:9888 with SMTP id
 d9443c01a7336-21892a13eeemr124259335ad.33.1734310180693; 
 Sun, 15 Dec 2024 16:49:40 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5addbf9sm3059586a12.47.2024.12.15.16.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 16:49:40 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-arm@nongnu.org (open list:MCIMX7D SABRE / i...),
 Jason Chien <jason.chien@sifive.com>
Subject: [RFC PATCH 1/6] include/hw/pci: Add a callback to set the downstream
 memory region of a pci bus
Date: Mon, 16 Dec 2024 08:48:52 +0800
Message-ID: <20241216004857.9367-2-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241216004857.9367-1-jason.chien@sifive.com>
References: <20241216004857.9367-1-jason.chien@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

PCIIOMMUOps.set_memory_region() is introduced to set the downstream memory
region of a pci bus. When PCIIOMMUOps.get_address_space() is already
registered by the pci host(e.g. TYPE_DESIGNWARE_PCIE_HOST),
PCIIOMMUOps.set_memory_region() should be registered as well, so an IOMMU
can designate the downstream memory region for the pci bus.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
---
 include/hw/pci/pci.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index c0717e3121..cb3039bce8 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -388,6 +388,19 @@ typedef struct PCIIOMMUOps {
      * @devfn: device and function number
      */
     AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int devfn);
+    /**
+     * @set_memory_region: set the downstream memory region for a set of
+     * devices on a PCI bus.
+     *
+     * Optional callback, which should be implemented when get_address_space()
+     * is registered by the PCI host(e.g. TYPE_DESIGNWARE_PCIE_HOST), which
+     * makes an IOMMU not able to register get_address_space() again.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @mr: the downsteam memory region
+     */
+    void (*set_memory_region)(void *opaque, MemoryRegion *mr);
     /**
      * @set_iommu_device: attach a HostIOMMUDevice to a vIOMMU
      *
-- 
2.43.2


