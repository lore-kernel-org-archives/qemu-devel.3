Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB153C3ABC5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1ZL-0003Um-1N; Thu, 08 May 2025 09:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1Z3-0003Gm-Gs
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:45:30 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1Z0-0005EF-NX
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:45:29 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-30aa79ee726so1018257a91.2
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746711925; x=1747316725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OvirrR3TiqgBPme4BwNGSV4VqzG47GBw5DwB3TzFavY=;
 b=vNu66OQf3+aYtHHWTde5LBQ5T1cLOvD4h6+ypqUk6sMt7mqEYt7jXZ5Vn7NDo/R2vY
 l/SYIsYNP0BMl5IXb598aL4rweq94/FOadb4Ng6GVxHTlyCk97eEDjR25wonlgNO3Gd3
 5Va73geEn8xLRz5paluIFukReQYAq4Xk4kuwPJh/8JW+vrDQTPo5+2mGL4wRY/NBppxT
 sUh1PQ5n3E4zXIZRhawuA1CocV4OjqoxipPrXuosR9nnX6LDUS7r52FOhI+ReouFAsDO
 C07SvOCgOpjcb314jNaD6OU2HYdInP8YQVtFvB79OyIGcSMEubiKkTh62XJfKps1L5QN
 Vjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746711925; x=1747316725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OvirrR3TiqgBPme4BwNGSV4VqzG47GBw5DwB3TzFavY=;
 b=nzRPIMERLr6Mov+3dwSi351OdInOSfw4XW3TMhkfJkFeCHkacU4tUNW05gP43JmqG0
 ZUtYYFuNvXUHgsJdD8ttPvx/KcCTfmnYmLJLb+X1eB/eDR6eZJxvJ6u3D+x0fVh/Ee/m
 Y31ScigMOkqWGyoe2ifChTXT+h8iiFgvnJ4OhpssACGgVBqjYBgad8VBJVtJ0mqvlg/k
 Q4pljFhfJiR38YTCiDbYhpfW7+w/UHDGbypZ7xzvpUiTcW7eqtaiY0ZvhD0V92YAQwbe
 pwNZu+Edr7C1mW1bWzeysdru0V4hm4WhZmnNo4Er6B6i7LKGEgbbWmkMwGOvCrCYCS8N
 qRgA==
X-Gm-Message-State: AOJu0Yy0Rn74hs2L7XHpmdYu0ou9fhf7NtSvniOUV6BGEY3ICJS1yJJx
 ZlSXgsDCL85Ota+7zUfX930XnEU+lVClVjHctqDp6+xF8YAWWWooZP1bdllaQziZ0al6agS0689
 8Z170rw==
X-Gm-Gg: ASbGncvgba0bMBRp3rVX7VoeC5+Ps44LcbsHDRLMqaAFP33E00kCxi7o+VnWRp7dsxV
 FVG/cd60dGdUmStJA09Y43Td1ySETwiiyBrNvegutX3m55GmThhGSX3iYIMpoltVSP8iIldBseb
 QLMR+3J3/l5PyYbOaWoczDNc/Lltdpuqc2Y371lJbmYNHqq8+iZWIm1VGDFJw59UjxXTsSRbyRJ
 eNC7GVRGi7YfYmbCewkorgvxP+ZYI57kmP8QUNDDbDlJDS5bQcnqKeA2l0Ds61cmg5a3toED1ih
 TFoK1BLhfU8yOBmteM0WBLMDt1/c4Sg3bNXSvdBCiu2FnxP3JNuBcPA4brlgNRmTFMqy+PIcdMi
 AyCy9rtFObw5d6bBeW5n1EOabRQ==
X-Google-Smtp-Source: AGHT+IE3OguPxCt5UaaCz+npDDqEKcstgRYbru0eZkno/K2CabjL/K8uImloD5ic4QFfbuKjUmzxXw==
X-Received: by 2002:a17:90b:1a91:b0:2ee:ab29:1a63 with SMTP id
 98e67ed59e1d1-30b28cea048mr5022708a91.3.1746711924724; 
 Thu, 08 May 2025 06:45:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522f0c3sm112275035ad.209.2025.05.08.06.45.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 May 2025 06:45:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v4 25/27] hw/virtio/virtio-pci: Remove
 VirtIOPCIProxy::ignore_backend_features field
Date: Thu,  8 May 2025 15:35:48 +0200
Message-ID: <20250508133550.81391-26-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508133550.81391-1-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x102a.google.com
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

The VirtIOPCIProxy::ignore_backend_features boolean was only set
in the hw_compat_2_7[] array, via the 'x-ignore-backend-features=on'
property. We removed all machines using that array, lets remove
that property, simplify by only using the default version.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/virtio/virtio-pci.h | 1 -
 hw/virtio/virtio-pci.c         | 5 +----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index f962c9116c1..9838e8650a6 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -149,7 +149,6 @@ struct VirtIOPCIProxy {
     int config_cap;
     uint32_t flags;
     bool disable_modern;
-    bool ignore_backend_features;
     OnOffAuto disable_legacy;
     /* Transitional device id */
     uint16_t trans_devid;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 8d68e56641a..7c965771907 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1965,8 +1965,7 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
      * Virtio capabilities present without
      * VIRTIO_F_VERSION_1 confuses guests
      */
-    if (!proxy->ignore_backend_features &&
-            !virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)) {
+    if (!virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)) {
         virtio_pci_disable_modern(proxy);
 
         if (!legacy) {
@@ -2351,8 +2350,6 @@ static const Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT, false),
     DEFINE_PROP_BIT("page-per-vq", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT, false),
-    DEFINE_PROP_BOOL("x-ignore-backend-features", VirtIOPCIProxy,
-                     ignore_backend_features, false),
     DEFINE_PROP_BIT("ats", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_ATS_BIT, false),
     DEFINE_PROP_BIT("x-ats-page-aligned", VirtIOPCIProxy, flags,
-- 
2.47.1


