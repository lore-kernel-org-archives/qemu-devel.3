Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF80EA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMjB-0002qa-7w; Sun, 08 Mar 2026 18:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMjA-0002po-Co
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:36:00 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMj8-0003LM-KQ
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:36:00 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4853510b4f3so10346535e9.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009357; x=1773614157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IvyubgiZnLR/Qn25dRzLRywypTI2tFXuMoTf+d/sfJE=;
 b=w1pfytaxVA42oYtx/okkAiV/taGqZdjQw7m8bd8wSnbJMyd4h3IzleW9VNFo8k69+A
 WsxcSiFIBviDEWY1VFk4N2wULUzxLZmfVuL+iVn2AUhzsLpHkd5alFwR01BbG85bPlLY
 kx7ZidnbNS9MfEgYmlLx248CYSNyMFPte+uzVYQfN+JjHGvOgHNYrEjgTQdLfBDnwlJZ
 yBuiR/oMBR6NzBlT88P9RTCcn+LCCawMBaJF/NbphuwVXKC02Wsna64oD/uLPMUCG//l
 63zHN2eYHOk9iNA9JDX2LF/GCcTaISBUKWig51uKNdb5lKy8Hnr6M6MWXTNEMlwL1rdA
 G32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009357; x=1773614157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IvyubgiZnLR/Qn25dRzLRywypTI2tFXuMoTf+d/sfJE=;
 b=f9LGvUx3u1CsWJ6MAMBD5C4EotVYLiDGdFNYAlVWhMadIaIFFInfVtvn0KhL0SCMnR
 KIqdvE71KZsEVSsOipdKNluY0iSnvRNbmWm6dJUhhb1U1XorLQpj4Gjkind9ERRehvjJ
 GTNwND8XniqSz0Vbxd41YpYgLCMmxC9/A2jR3fZr9ANMmgB8PEY2FqEGfuUvJj2YePyt
 vq5hPb61dboO/yKeNUzWeGSZrMd62AeQ9sMhp3gJEzQQlmWNuVp+Eb5FIViR5UAqNQfI
 IHGdhtY2v2NSdkTPT2+JHLzMt2+hTl8bN96HFxZ2gZiy08gy1BE2Md5pzF+XCIRLpn1X
 MM+A==
X-Gm-Message-State: AOJu0YyA/Mtson2kECBRShMTR61JsrpkmHNUlZcTPC9mGxPyEoL4riuP
 TijZlFdep1B0VSW+RcLVB7xlnLlLhLGqprp3bDRrUi1HdZRiCtdGpY8pDREDv0n1cpM7vCRtvm1
 Q/1jyIUE=
X-Gm-Gg: ATEYQzwrHWVyiJdZ3xLRti0tefktvIV5zWo4KuCubLUd+t0gx0McKqiClXVPFNzN8oe
 hNAJiTnX6UGbK9L6OPhf9gI5+J3P0xIFRt7oNTYs8/bwVMainY9Sh3O4bxLrERvXl3XDFoqbufe
 PF+XO1+fyknsC1NYLPcL7SqkGLYngj/tZeM4VoRR89iPlCFBPEWX5028ehkxli8lusOLbwDdG8F
 DSLQyE6k3PSiU53fDq2cixa3eMv73flYy41Ea3FVwi3dMcE2WSsc5gruJdbH+Dir+jvqGwiUo0Q
 RnG6i6m8t+q/GumiAoc9zoFwEJ771vWtNuZLn91VK18srD9fB4Wa/ZRTXaV2jEjRx1BN0aksb5r
 heV4VVdfmE3/s9zEPxrSYnFPG21afJkq/bIRNenODAlMN/eIQF5prnAiYMNKvfZW6MmxeDnYM09
 YO+RyywZXUB57NreSBWuQ2dCQQco5BAsxr/24ygDHxumIqD8PobYycAmUfdeyPnXDujw3EdaXz2
 KdkeA==
X-Received: by 2002:a05:600c:c173:b0:485:3812:36dc with SMTP id
 5b1f17b1804b1-485381238b3mr50587285e9.9.1773009356689; 
 Sun, 08 Mar 2026 15:35:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8ec97sm23445128f8f.5.2026.03.08.15.35.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:35:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/49] hw/*: Build stubs once
Date: Sun,  8 Mar 2026 23:33:56 +0100
Message-ID: <20260308223433.25503-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260225035739.42848-10-philmd@linaro.org>
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
index 821366f5e90..415e359e9fc 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -48,8 +48,6 @@ if have_vhost
     system_virtio_ss.add(files('vhost-vdpa.c'))
     system_virtio_ss.add(files('vhost-shadow-virtqueue.c'))
   endif
-else
-  system_virtio_ss.add(files('vhost-stub.c'))
 endif
 system_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
@@ -92,10 +90,9 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MD', if_true: files('virtio-md-pci.c'))
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
2.53.0


