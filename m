Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA9EC48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDDC-0008Ts-8y; Wed, 14 Feb 2024 06:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDD7-0008QF-Aj
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:13:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDD5-0006k7-LF
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t2Py5K1KV4TIQcdeM+IKUI8vM0Fvjo561iUpW9cAFpE=;
 b=cxaMXjEzAxLA77d99dwbMyy3XyHUuLSeZvrqeBd4Rkg4uIQ/dMALLkbiYw+XXqht1MNLbT
 bqisnD5FpJLgU7yOHsVjP9wC/D7C03q1q7gMkZBSYGi8gKIowzChptRYzJxpdzrScro3l4
 JncksV4o4uFT0Jx0mTUNGzUCfiL6L7A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-HNCCbDiwNi-ps32gxoOApQ-1; Wed, 14 Feb 2024 06:13:49 -0500
X-MC-Unique: HNCCbDiwNi-ps32gxoOApQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-560f41972easo3123162a12.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:13:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909228; x=1708514028;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t2Py5K1KV4TIQcdeM+IKUI8vM0Fvjo561iUpW9cAFpE=;
 b=JgydlApXVxuiatOTCy5t1WQhjVvkH875k7h4Biz2yMvMFSB9tWNjwct/A+kOsM+jpU
 1hXieic9kmQEk2twkWUY6+HAjsykNtUriWSKbpn3ZECk2ybuo3HqlwX/MSu4/rb6pKwj
 lVcuxismwnGsIrkYTwIDCJAyDLIlH44ZkieThKgfGzlft2JQIt4kVyMrPcFDpbtCJn/8
 alN6X+nO/MRyBd4gunKa2AkgBMjaoYEAZ7XLHNMplXO6MQuovmCEjDDGjtY9Q5tIfxu3
 26XPKJ16LPD3fUTLYxa7b61PgzDcbZ3tMhDJPixc2nFk0K+YE1854QxeP98cTKkxWuwC
 E1tw==
X-Gm-Message-State: AOJu0Yyq1+dEVg0SlAiCsG2DXlu8tLQr8+feoxWBWFrC8A4zHxtwWdxY
 +SZBAw/lqVIRQfnvdpAPHET7LWP3Xx9Scdri9zJjH/ECJYrKdv6j9Bcp5o722H/RAW3S7f493n8
 cn5MLw2eJgCxG+d7hGGODCqEuSrJO0PCGtFXlzzjPUaXaqs3l3ZqBRPDwOq9pdrnJ5M4VcXlPKl
 YNq+y0zKyukhV4+1YB8gh7+XW+poOHPQ==
X-Received: by 2002:aa7:c901:0:b0:561:aed9:37e8 with SMTP id
 b1-20020aa7c901000000b00561aed937e8mr1823343edt.3.1707909228118; 
 Wed, 14 Feb 2024 03:13:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfKFfhlFDN8YbVpAlvmtN/QzRARAVj3rFSkTefBbyEu7xrJEuDVyBUq9BBKzb69vKJnh8guw==
X-Received: by 2002:aa7:c901:0:b0:561:aed9:37e8 with SMTP id
 b1-20020aa7c901000000b00561aed937e8mr1823289edt.3.1707909226850; 
 Wed, 14 Feb 2024 03:13:46 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVyzTL8BmDkFj6R8/MA9LIsDVFmI5VE4YjiqZTYPzhroHU094AfhLPdQgg5DKfFNTWceqfePe/HE09zAxTndq6G82s3g0p5THox7AHX9KHfdYGq3jOMNVPjvjTY9GHDupJU1Gft9/8Q2CHU7GyI8BY+HkhPwDhhTFlUjZdskr+qp37xmZKxmhdmr7V9botVD3LFjNlV0jO8bTd5SiXyAAprPUElu40cS0shyqLh2Q3Q7nN19mM+h1YsRubIHsUGduFBBjvFqSZU5GUUr9XWOchgCD+ARnSqJeZ94UJ+pAuRXHki+HYWo09RsKE=
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 cq9-20020a056402220900b0055ffe74e39dsm4549878edb.85.2024.02.14.03.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:13:46 -0800 (PST)
Date: Wed, 14 Feb 2024 06:13:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Leo Yan <leo.yan@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 10/60] hw/virtio: Move vhost-user-input into virtio folder
Message-ID: <87c7fb7819962e052a69046167949fe266611abf.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Leo Yan <leo.yan@linaro.org>

vhost-user-input is in the input folder.  On the other hand, the folder
'hw/virtio' maintains other virtio stubs (e.g. I2C, RNG, GPIO, etc).

This patch moves vhost-user-input into the virtio folder for better code
organization.  No functionality change.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20231120043721.50555-4-leo.yan@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240104210945.1223134-11-alex.bennee@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/{input => virtio}/vhost-user-input.c | 0
 MAINTAINERS                             | 2 +-
 hw/input/meson.build                    | 1 -
 hw/virtio/meson.build                   | 4 +++-
 4 files changed, 4 insertions(+), 3 deletions(-)
 rename hw/{input => virtio}/vhost-user-input.c (100%)

diff --git a/hw/input/vhost-user-input.c b/hw/virtio/vhost-user-input.c
similarity index 100%
rename from hw/input/vhost-user-input.c
rename to hw/virtio/vhost-user-input.c
diff --git a/MAINTAINERS b/MAINTAINERS
index 66c9e81c55..89f2d31f70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2290,8 +2290,8 @@ virtio-input
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Odd Fixes
 F: docs/system/devices/vhost-user-input.rst
-F: hw/input/vhost-user-input.c
 F: hw/input/virtio-input*.c
+F: hw/virtio/vhost-user-input.c
 F: include/hw/virtio/virtio-input.h
 F: contrib/vhost-user-input/*
 
diff --git a/hw/input/meson.build b/hw/input/meson.build
index 640556bbbc..3cc8ab85f0 100644
--- a/hw/input/meson.build
+++ b/hw/input/meson.build
@@ -11,7 +11,6 @@ system_ss.add(when: 'CONFIG_TSC2005', if_true: files('tsc2005.c'))
 system_ss.add(when: 'CONFIG_VIRTIO_INPUT', if_true: files('virtio-input.c'))
 system_ss.add(when: 'CONFIG_VIRTIO_INPUT', if_true: files('virtio-input-hid.c'))
 system_ss.add(when: 'CONFIG_VIRTIO_INPUT_HOST', if_true: files('virtio-input-host.c'))
-system_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files('vhost-user-input.c'))
 
 system_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_keypad.c'))
 system_ss.add(when: 'CONFIG_TSC210X', if_true: files('tsc210x.c'))
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index af8abae020..d7f18c96e6 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -25,6 +25,7 @@ if have_vhost
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true: files('vhost-user-i2c.c'))
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user-rng.c'))
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SND', if_true: files('vhost-user-snd.c'))
+    system_virtio_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files('vhost-user-input.c'))
 
     # PCI Stubs
     system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('vhost-user-device-pci.c'))
@@ -36,6 +37,8 @@ if have_vhost
                          if_true: files('vhost-user-rng-pci.c'))
     system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SND'],
                          if_true: files('vhost-user-snd-pci.c'))
+    system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_INPUT'],
+                         if_true: files('vhost-user-input-pci.c'))
   endif
   if have_vhost_vdpa
     system_virtio_ss.add(files('vhost-vdpa.c'))
@@ -59,7 +62,6 @@ virtio_pci_ss = ss.source_set()
 virtio_pci_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-blk-pci.c'))
-virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files('vhost-user-input-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost-user-scsi-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs-pci.c'))
-- 
MST


