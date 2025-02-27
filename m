Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D66C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnekb-0007EN-DN; Thu, 27 Feb 2025 09:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekX-0007CD-KE
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekU-0003l2-UW
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3r5BzHwwGLE8w4wpYRt2uj1rsGj25j/C0CBMCevqqBU=;
 b=SsOBAILotg0oXhmTlLCkfGNAZ/STfrDKo/Cr3KzFT7r9EtvC/Kq0UUomesfFxk6xmOR0vj
 54SHtYjhNiBY59e9hfafWiZOXeVBPLYBP5gh6zLel/Aw1IljMlamYonW9Q0ZfNSfohLdgh
 xHJ+2YqYhUI4/TdpweU4OEiA80UZiIA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-UQYzrzFhMM27S47IaMrfOw-1; Thu, 27 Feb 2025 09:20:21 -0500
X-MC-Unique: UQYzrzFhMM27S47IaMrfOw-1
X-Mimecast-MFC-AGG-ID: UQYzrzFhMM27S47IaMrfOw_1740666021
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-abf16f47749so73097166b.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666020; x=1741270820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3r5BzHwwGLE8w4wpYRt2uj1rsGj25j/C0CBMCevqqBU=;
 b=lzJVYKJnoxia5wruVxHsR3hnSEk4VDuza4q527RHJqYn2c8IhkP2YHsGcXwmXfjp9L
 Zwt7Y+lZUlkrFF8E0Y/CBNCBTTclNYpVSR/Dp1M8K5X/3ZJ+zWyVZFo2F0lzmYjjvrPE
 kVnyRTylfvARDQgg7aHNffiFjCivS1dW2vOxbYwpJ01suULl/AwSO6vTSjqzNjjQtZeX
 sMw7GrbO5BCJRaC3RuuMvIZRjoTFd2EWAM14cmMGr5dcpkPcanLhJmVxFgplA13dZ9IF
 fC74yC3SamuYTIOebMF3QXbSeFZ5oUjWeiEvkXDipZ6l8RitCK93WhQXmxEQkQitCbZA
 1CEA==
X-Gm-Message-State: AOJu0YzqDn3eHR569McZ0o7mOE3cQFJ6Bspxpg3gb9LeQmsRkoEIJeyi
 Rey9L93LLzm/HzIoKJ2E0uIJnM8y8yRvsbrn33a0vb4eLiyZFh84jS5nL33JizGXExDTaNG5U8Y
 bpCumTGymQAFAt8FSqbefQdnH9YEvY1h6GvODGE8icDa94fuO50Y3u5Cxv/nauIXB1kWnJIqbNU
 7Wx161npwYFUL/BZEvJQQNspcqkha12cQUVeG05Tc=
X-Gm-Gg: ASbGncvTDRmP+At45l1i6h5I6IuHvKraXPPHtMKpt8eV0fhUZYAUPsDEI7lUypZhAzK
 Verd9SZGgHRHITIolc/8s9hO11pdkM8f1w9ZUEoMBCtC0MvKY1sJPzdEmIsgSLf7nJV487+pxrW
 v2rclMuGOWlv41ufmU35eKZPNyrnbfKzMWfG++ZPESh/VbFTJ86YsH9aaHlQYEEwpidH9FZo/0x
 ByhBg+tfQk/cbDo6aDE4Fv/ZFaMoLwZL9O866aNI/o3Ga4BVvb/8FTnvnX66WRDegf4kvH4PLpG
 NVnYpc+HJW0pxixm6usm
X-Received: by 2002:a05:6402:4310:b0:5de:5939:6c34 with SMTP id
 4fb4d7f45d1cf-5e4bfba9848mr4139849a12.15.1740666020232; 
 Thu, 27 Feb 2025 06:20:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9emLnvHCCggBF1OEIDrmWorMy2I48000PcEQ7IZrLuP0QRKyPgEoe8g1cWCogbehQCz0Oeg==
X-Received: by 2002:a05:6402:4310:b0:5de:5939:6c34 with SMTP id
 4fb4d7f45d1cf-5e4bfba9848mr4139825a12.15.1740666019667; 
 Thu, 27 Feb 2025 06:20:19 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c43a55e0sm1145604a12.79.2025.02.27.06.20.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/34] pvg: do not enable it on cross-architecture targets
Date: Thu, 27 Feb 2025 15:19:30 +0100
Message-ID: <20250227141952.811410-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

PVG is not cross-architecture; the PVG guest drivers with x86-64 macOS do not give
useful results with the aarch64 macOS host PVG framework, and vice versa.
To express this repurpose CONFIG_MAC_PVG, making it true only if the target has
the same architecture as the host.  Furthermore, remove apple-gfx.m unless
one of the devices is actually present.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build            | 6 ++++++
 Kconfig.host           | 3 +++
 hw/display/Kconfig     | 4 ----
 hw/display/meson.build | 9 +++------
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/meson.build b/meson.build
index 0ee79c664d3..ad2c6b61930 100644
--- a/meson.build
+++ b/meson.build
@@ -3367,6 +3367,12 @@ foreach target : target_dirs
     target_kconfig += 'CONFIG_' + config_target['TARGET_ARCH'].to_upper() + '=y'
     target_kconfig += 'CONFIG_TARGET_BIG_ENDIAN=' + config_target['TARGET_BIG_ENDIAN']
 
+    # PVG is not cross-architecture.  Use accelerator_targets as a proxy to
+    # figure out which target can support PVG on this host
+    if pvg.found() and target in accelerator_targets.get('CONFIG_HVF', [])
+      target_kconfig += 'CONFIG_MAC_PVG=y'
+    endif
+
     config_input = meson.get_external_property(target, 'default')
     config_devices_mak = target + '-config-devices.mak'
     config_devices_mak = configure_file(
diff --git a/Kconfig.host b/Kconfig.host
index 842cbe0d6c5..933425c74b4 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -61,3 +61,6 @@ config HV_BALLOON_POSSIBLE
 
 config HAVE_RUST
     bool
+
+config MAC_PVG
+    bool
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 2b53dfd7d26..1e95ab28ef4 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -141,10 +141,6 @@ config XLNX_DISPLAYPORT
 config DM163
     bool
 
-config MAC_PVG
-    bool
-    default y
-
 config MAC_PVG_MMIO
     bool
     depends on MAC_PVG && AARCH64
diff --git a/hw/display/meson.build b/hw/display/meson.build
index 94f4f05d36f..b9bdf219103 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -61,12 +61,9 @@ system_ss.add(when: 'CONFIG_ARTIST', if_true: files('artist.c'))
 
 system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c', 'ati_2d.c', 'ati_dbg.c'), pixman])
 
-if host_os == 'darwin'
-  system_ss.add(when: 'CONFIG_MAC_PVG',         if_true: [files('apple-gfx.m'), pvg, metal])
-  system_ss.add(when: 'CONFIG_MAC_PVG_PCI',     if_true: [files('apple-gfx-pci.m'), pvg, metal])
-  if cpu == 'aarch64'
-    system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',  if_true: [files('apple-gfx-mmio.m'), pvg, metal])
-  endif
+if pvg.found()
+  system_ss.add(when: 'CONFIG_MAC_PVG_PCI',     if_true: [files('apple-gfx.m', 'apple-gfx-pci.m'), pvg, metal])
+  system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',    if_true: [files('apple-gfx.m', 'apple-gfx-mmio.m'), pvg, metal])
 endif
 
 if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
-- 
2.48.1


