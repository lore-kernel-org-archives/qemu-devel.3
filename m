Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C55BF55452
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv62z-0006XD-Mp; Tue, 24 Feb 2026 22:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv62y-0006O7-F3
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:58:48 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv62w-0001ko-OG
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:58:48 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4376c0bffc1so4649209f8f.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771991924; x=1772596724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uGy+xlqaHkF3GLZUDRmGWtEgpnZ35L7EwQCPWm2/m/g=;
 b=AndXtIkq7l6DQDK7joBO2Kn5rwDYpVAujewLpJmm/Z7l12UA1l9+fRTEo+XZvZfswm
 y2DKi1FDE3tkw/J/YSRCWPtIpQBae4jREkqdCG0WeVHuo8hc6zFLom49AGDITSWaMS4Y
 n3Omhl3vwGfEQW7VZRL5VczO9cNwxObYoBrX5rvyRR0O8BziDEccG50Aqj/YXPYseowN
 tEtGxbXk/KcCXO0QHRpGMiaE0cSSbBMFL5vwICZoST9YRpl4u+X+LvCHzoQFBcfYYIZT
 V635/EMURJctuXBUv2AJkZ68foHAot3IvNmBDZSlk1jwLOqZjT3gJRRmyAOtTqcNeN/I
 n0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991924; x=1772596724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uGy+xlqaHkF3GLZUDRmGWtEgpnZ35L7EwQCPWm2/m/g=;
 b=cfefC01cKlAL7zlYXD1ruBf0hA5B/zmUoHoSl7o1DJ/PcdpmALmglnwsD+4cl6Wcjr
 R1Onpy8TY2EzvySwh3aY/Gce+C4cVbf4omIdnEsO7vZfixM+eG/uftg0LlDv6QDX3G4B
 RxURKc9Yb9z+2S5r/wTnpr6SaR8pVe0Pt1v2PR6PtVRq4V9uNx3fBOvQOcOHZx8jE3vl
 YAv6uFd1ab2DilzH0Ogc6RrdTwerAUmBFSiOq+LZkRIyt4wAzdN3yrbDMgHI71M6gIk4
 eKEMCjBFYXMgtB228YNoWzCu+GjWkbNdoQ/nRt1pO13PiDcJr3ehM1Il3yCEp0aUhcb3
 9lwQ==
X-Gm-Message-State: AOJu0Yy5sZmRrHTLa5xLHhBPMWyvT3I+i+Y2Ewt9ClILuN4+C47nfycD
 3k5B2prf5OaqFvjuRFebGz5hkKyPnxpMr5kvSrxUkPutrUQKocwHNPsxoLTQb+CgkdeAsAI7X5C
 tZkvVRgg=
X-Gm-Gg: ATEYQzzJDL8xGgYeQCrKcW+EHLX2oc0hMjMmrMFkXSDehuF4YxEGofiy0zEfUH6ZS5C
 X7uGV93XrQusLngLFVNcfX1l1U2qnvicUmNtuIb0vdFLSaGTBlW15ppZzykGIGy1GkyQqbud/6x
 PSrHLnnZd3sIPx5bAK0yW5v9yL3sKDYoqNZPcAS9AfX/w8NqMN9YH9uVP1wDowfjFSiEVQgUFzd
 9HiCa1+O/8W6JtNkLlrcv7uXCuQZft0kGpbiPmBLKZmNvKwxQW4zm0VeTkIlhG8U9VXpsybsqAV
 WRhhMyOQEn4XfWzrFPABNEvxn16L98SZ84CKM6nIlqVGikqFK0tBUAkpnqmRfuBD7NDcCE/UjQV
 Z36SON4Yhe/L7VZFabNtX0zY6r0Q6aypzEVYTnb07k80I6XjtWsPbD+KM443neXaMjorgbrDuye
 twxVgalalcD+aq4fXzDC+pikWxd0Z/utHLi29WRHGs09jaHSuYpD6JeXnQgWY/sCpgvmyptwYP
X-Received: by 2002:a05:6000:22c3:b0:437:6f0c:2ed with SMTP id
 ffacd0b85a97d-4396f183a3cmr26546216f8f.34.1771991924487; 
 Tue, 24 Feb 2026 19:58:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970c09897sm31881902f8f.17.2026.02.24.19.58.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 19:58:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 09/11] hw/*: Build stubs once
Date: Wed, 25 Feb 2026 04:57:37 +0100
Message-ID: <20260225035739.42848-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225035739.42848-1-philmd@linaro.org>
References: <20260225035739.42848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move stubs to the global stub_ss[] source set. These files
are now built once for all binaries, instead of one time
per system binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/cxl/meson.build      |  4 ++--
 hw/i386/kvm/meson.build |  5 +----
 hw/mem/meson.build      |  4 ++--
 hw/pci/meson.build      |  2 +-
 hw/smbios/meson.build   | 10 +++++-----
 hw/usb/meson.build      |  3 ++-
 hw/virtio/meson.build   |  9 +++------
 7 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
index 3e375f61a98..5f61273a68d 100644
--- a/hw/cxl/meson.build
+++ b/hw/cxl/meson.build
@@ -7,7 +7,7 @@ system_ss.add(when: 'CONFIG_CXL',
                    'cxl-cdat.c',
                    'cxl-events.c',
                    'switch-mailbox-cci.c',
-               ),
-               if_false: files(
+               ))
+stub_ss.add(files(
                    'cxl-host-stubs.c',
                ))
diff --git a/hw/i386/kvm/meson.build b/hw/i386/kvm/meson.build
index a4a2e23c06e..a34b3504cba 100644
--- a/hw/i386/kvm/meson.build
+++ b/hw/i386/kvm/meson.build
@@ -15,9 +15,6 @@ i386_kvm_ss.add(when: 'CONFIG_XEN_EMU', if_true: files(
 
 i386_ss.add_all(when: 'CONFIG_KVM', if_true: i386_kvm_ss)
 
-xen_stubs_ss = ss.source_set()
-xen_stubs_ss.add(when: 'CONFIG_XEN_EMU', if_false: files(
+stub_ss.add(files(
   'xen-stubs.c',
 ))
-
-specific_ss.add_all(when: 'CONFIG_SYSTEM_ONLY', if_true: xen_stubs_ss)
diff --git a/hw/mem/meson.build b/hw/mem/meson.build
index 1c1c6da24b5..8c2beeb7d4d 100644
--- a/hw/mem/meson.build
+++ b/hw/mem/meson.build
@@ -4,9 +4,9 @@ mem_ss.add(when: 'CONFIG_DIMM', if_true: files('pc-dimm.c'))
 mem_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_mc.c'))
 mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
 mem_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_true: files('cxl_type3.c'))
-system_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_false: files('cxl_type3_stubs.c'))
+stub_ss.add(files('cxl_type3_stubs.c'))
 
-system_ss.add(when: 'CONFIG_MEM_DEVICE', if_false: files('memory-device-stubs.c'))
+stub_ss.add(files('memory-device-stubs.c'))
 system_ss.add_all(when: 'CONFIG_MEM_DEVICE', if_true: mem_ss)
 
 system_ss.add(when: 'CONFIG_SPARSE_MEM', if_true: files('sparse-mem.c'))
diff --git a/hw/pci/meson.build b/hw/pci/meson.build
index b9c34b2acfe..a6cbd89c0a3 100644
--- a/hw/pci/meson.build
+++ b/hw/pci/meson.build
@@ -19,4 +19,4 @@ pci_ss.add(files('pcie_doe.c'))
 system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pcie_port.c', 'pcie_host.c'))
 system_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
 
-system_ss.add(when: 'CONFIG_PCI', if_false: files('pci-stub.c'))
+stub_ss.add(files('pci-stub.c'))
diff --git a/hw/smbios/meson.build b/hw/smbios/meson.build
index a59039f6692..9bf4b1ad1e5 100644
--- a/hw/smbios/meson.build
+++ b/hw/smbios/meson.build
@@ -1,12 +1,12 @@
 smbios_ss = ss.source_set()
 smbios_ss.add(files('smbios.c'))
 smbios_ss.add(when: 'CONFIG_IPMI',
-              if_true: files('smbios_type_38.c'),
-              if_false: files('smbios_type_38-stub.c'))
+              if_true: files('smbios_type_38.c'))
+stub_ss.add(files('smbios_type_38-stub.c'))
 
 smbios_ss.add(when: 'CONFIG_SMBIOS_LEGACY',
-              if_true: files('smbios_legacy.c'),
-              if_false: files('smbios_legacy_stub.c'))
+              if_true: files('smbios_legacy.c'))
+stub_ss.add(files('smbios_legacy_stub.c'))
 
 system_ss.add_all(when: 'CONFIG_SMBIOS', if_true: smbios_ss)
-system_ss.add(when: 'CONFIG_SMBIOS', if_false: files('smbios-stub.c'))
+stub_ss.add(files('smbios-stub.c'))
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index 17360a5b5a4..ba55c28ef69 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -9,7 +9,8 @@ system_ss.add(when: 'CONFIG_USB', if_true: files(
   'desc-msos.c',
   'libhw.c',
   'pcap.c',
-), if_false: files('bus-stub.c'))
+))
+stub_ss.add(files('bus-stub.c'))
 
 # usb host adapters
 system_ss.add(when: 'CONFIG_USB_UHCI', if_true: files('hcd-uhci.c'))
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 6675b63ce65..3af34ef9321 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -50,8 +50,6 @@ if have_vhost
     system_virtio_ss.add(files('vhost-vdpa.c'))
     system_virtio_ss.add(files('vhost-shadow-virtqueue.c'))
   endif
-else
-  system_virtio_ss.add(files('vhost-stub.c'))
 endif
 system_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
@@ -94,10 +92,9 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MD', if_true: files('virtio-md-pci.c'))
 system_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
 
 system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: system_virtio_ss)
-system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('vhost-stub.c'))
-system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('virtio-stub.c'))
-system_ss.add(when: ['CONFIG_VIRTIO_MD', 'CONFIG_VIRTIO_PCI'],
-              if_false: files('virtio-md-stubs.c'))
+stub_ss.add(files('vhost-stub.c'))
+stub_ss.add(files('virtio-stub.c'))
+stub_ss.add(files('virtio-md-stubs.c'))
 
 system_ss.add(files('virtio-hmp-cmds.c'))
 
-- 
2.52.0


