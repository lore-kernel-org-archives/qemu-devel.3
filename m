Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9302C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 13:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl6gR-0003eI-3S; Thu, 20 Feb 2025 08:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tl6g4-0003cO-4p
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 08:33:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tl6fz-00081l-TM
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 08:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740058393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3r5BzHwwGLE8w4wpYRt2uj1rsGj25j/C0CBMCevqqBU=;
 b=e6RHocxtb7EgRL0Zoed8KreXNyr2LLD8azXAL9FGwD2NqG0wo6pmR6KfCYCzNe5SB78KQq
 QkXwTvJRbCb3CueC/Q3si0mDW4nzwLADMJflyq+m4W5mgTeYowZH6oohDKG00rJvfWakWw
 EGj7hnv8ZNQ+cJ8JWf/7kCpaOSQ7Uj8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-aLWKjP00M52JCOtlYgq5vQ-1; Thu, 20 Feb 2025 08:33:12 -0500
X-MC-Unique: aLWKjP00M52JCOtlYgq5vQ-1
X-Mimecast-MFC-AGG-ID: aLWKjP00M52JCOtlYgq5vQ_1740058391
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f55ccb04bso628836f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 05:33:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740058390; x=1740663190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3r5BzHwwGLE8w4wpYRt2uj1rsGj25j/C0CBMCevqqBU=;
 b=KMnCZqzqaex3BkChmRh+CDetfP49xHA9qjxWEq6Aw+6feqdHfRDsvj4DwD2+Govnk7
 cAg2//NKkS0X7Fd1uMcm4nCkiDLoeWKGMeHZSCXTQAHrifdIN1TdSzb9t65IMcvZ0e/U
 RhC5ZGhWLhNqryX4cCub7L1mqsLsetfXRQQ7TwkyShB9JnB3zqdDGuyybOGxRURHzIBM
 gzALsWIbaPJFc1yRXkSfvQl4fIBgryZCTZnTz+X8BWeO+HTiKKrk37J3jBTTySZ87VkZ
 4Dmz6K60vEHLd0bWOk3F0fiPUskuoLaQO2HbPKzYOmnqRcwwF70iehKgw3IyI8MMLm/m
 v4zQ==
X-Gm-Message-State: AOJu0YxLWFvNXZO1qGZzeXMOalFqXI3R8b1XqV6xAw3kNuxnJ9ztUuqr
 ap1s8R6qBlUc1SXPpw4SR6H/6LGt6hYNNBAijfdbSMb9Wovvwogq9PZVsdHD9rqflZIn9DFetev
 C878bV/Fzl8Esy0pU/atOyLfx4HcjKGDp/YZ0kPsF71NWYNy6vW1mcIeP+978NpL4/4SRWU7Mfm
 vifP9TxXRXQ1QLv4ajy+6pBl1uDrnqZ5HNriLcPY8=
X-Gm-Gg: ASbGncuyd/DoEegwQlp5ZtFvHxy6XFFiLEIx/rSpE60P7q+BBYij1eIsQHqhmEIRzy3
 aDM6VdMTzsTuKIs7I5SfVE1dUcUb7kkwyeC0/l4BOnSgRbrt2StR3NAnsnhITnNKAD45vYh3mjJ
 P/Poywqc7f8qYFMBNgzP+wLY4sFrcLZ+KSVemVhW1BohYn3uBiLhMMgvCPkycyc3RsLJLWJ+jqf
 VyYa/IUUt0+bJG4ur96Q9KhBA9p4KEk2jcOfaz4O/77gQX+KL9efenG3C0v8gG2A18V6JqNWzZQ
 c8B4cWDNYwg=
X-Received: by 2002:a05:6000:712:b0:38f:2766:759f with SMTP id
 ffacd0b85a97d-38f587ca5c4mr6813248f8f.41.1740058389931; 
 Thu, 20 Feb 2025 05:33:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHryIqD6TUAbszIvZ4RYaXVPLhzQGY+jeQeO5PavQqs2XJLBL+2C+bhCOeh/VCSeVXRL4nrMA==
X-Received: by 2002:a05:6000:712:b0:38f:2766:759f with SMTP id
 ffacd0b85a97d-38f587ca5c4mr6813221f8f.41.1740058389417; 
 Thu, 20 Feb 2025 05:33:09 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25914d73sm21010745f8f.54.2025.02.20.05.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 05:33:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 1/2] pvg: do not enable it on cross-architecture targets
Date: Thu, 20 Feb 2025 14:33:05 +0100
Message-ID: <20250220133306.1104382-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220133306.1104382-1-pbonzini@redhat.com>
References: <20250220133306.1104382-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


