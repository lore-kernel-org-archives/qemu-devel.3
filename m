Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893E4C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrK0-0001Iy-MU; Mon, 08 Apr 2024 11:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrJz-0001Ik-Lt
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrJy-0001pt-6t
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712591648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OvEz71KolpHlDr+wtkEJnZoMG97tnaT6MHtThZyJnbM=;
 b=TNiP6vlCcgj0tkdY0EHiZo/6wZ8I9n44KuP2IMbFBW2mqGF60uF5mxgx/yb51ZGNIt/hp6
 2hTZA809Fe26JkKr+WIJIOq9ERqz66Ig/VS8w6y7ieaNpHzFXfkp6YCV1HzDHPE9XrRPoH
 A/xn7LkkhzCpeCrto9LcuURvV54kFOY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-_DWMPJLtMwuy54RKPX5zeg-1; Mon, 08 Apr 2024 11:54:07 -0400
X-MC-Unique: _DWMPJLtMwuy54RKPX5zeg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-416664de900so9019105e9.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712591645; x=1713196445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OvEz71KolpHlDr+wtkEJnZoMG97tnaT6MHtThZyJnbM=;
 b=cmy3ev/vyd1py+3on3siGTrzY5AvaZFr1p0Dal1sv4qrNMYvQ3OmeRv8aSUaN/t8Wl
 P9DFwIdl00FQYGa83WHc57g9ODTZYRfLZsPpmJIJM4P3EX3Dg5fyFZNIJqt6rAHl8NdX
 2ic5zqwKaYcLYJGVPXEK0dEIryJOYsTaqO2Z1Rohi7IRDuD7HxUVNHxmGJVqtntExUMh
 o5/Bq9rkRFxs1r+wrtLPfVI5CvII8ezUIyGUywXM2WiV0lBNsqrilnswDDbOHBVikI77
 qIUorxxNoaMSXpZBkhjcRSkgfUXE5nH95ZfUzFRbr3QfJsPamB8CxjQ/mRylr14ZfFM+
 mrjw==
X-Gm-Message-State: AOJu0Yw3a46gf2KnFvFT9pxMHUkjG/7trI9jDS3kFdkAc6ydBjhcWf4r
 zyu6fh7zkABnaB2SCCOYQojjCQFlJhmgc06Yn4DRDLh7b9mtl3wrc95FZJ2uC4DJG4M38zxfaBg
 Z2+qw/iDBH3+KrIsF2asPdmH7f9ZYf8AywHm9J2e9q2kVk9E8rRrN9+dkTCgLv6ANhYMQqSwziu
 Mh1e3s/v8Zyyq21gcOFjj+SARirhXqoqY84R98
X-Received: by 2002:a05:600c:4fc6:b0:416:5f18:820d with SMTP id
 o6-20020a05600c4fc600b004165f18820dmr4237476wmq.2.1712591645347; 
 Mon, 08 Apr 2024 08:54:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIc750yA3u0pXt4JtIGtQM43YSM0d1V/ikPnXq/IjDcmvZY6lH9qWMEPtCvSPu78ybfq7XDQ==
X-Received: by 2002:a05:600c:4fc6:b0:416:5f18:820d with SMTP id
 o6-20020a05600c4fc600b004165f18820dmr4237460wmq.2.1712591645077; 
 Mon, 08 Apr 2024 08:54:05 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 p5-20020adfce05000000b00343e760c637sm8826197wrn.84.2024.04.08.08.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 08:54:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 11/18] hw/virtio: move stubs out of stubs/
Date: Mon,  8 Apr 2024 17:53:23 +0200
Message-ID: <20240408155330.522792-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408155330.522792-1-pbonzini@redhat.com>
References: <20240408155330.522792-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since the virtio memory device stubs are needed exactly when the
Kconfig symbol is not enabled, they can be placed in hw/virtio/ and
conditionalized on CONFIG_VIRTIO_MD.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 stubs/virtio-md-pci.c => hw/virtio/virtio-md-stubs.c | 0
 hw/virtio/meson.build                                | 3 ++-
 stubs/meson.build                                    | 1 -
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename stubs/virtio-md-pci.c => hw/virtio/virtio-md-stubs.c (100%)

diff --git a/stubs/virtio-md-pci.c b/hw/virtio/virtio-md-stubs.c
similarity index 100%
rename from stubs/virtio-md-pci.c
rename to hw/virtio/virtio-md-stubs.c
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index d7f18c96e60..2a086f7904b 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -80,7 +80,8 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem-pci.c'
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev-pci.c'))
-virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MD', if_true: files('virtio-md-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MD', if_true: files('virtio-md-pci.c'),
+                                            if_false: files('virtio-md-stubs.c'))
 
 specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
 
diff --git a/stubs/meson.build b/stubs/meson.build
index 45616afbfaa..60e32d363fa 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -57,7 +57,6 @@ if have_system
   stub_ss.add(files('fw_cfg.c'))
   stub_ss.add(files('semihost.c'))
   stub_ss.add(files('xen-hw-stub.c'))
-  stub_ss.add(files('virtio-md-pci.c'))
 else
   stub_ss.add(files('qdev.c'))
 endif
-- 
2.44.0


