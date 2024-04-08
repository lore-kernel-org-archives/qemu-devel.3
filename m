Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8088DC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrJx-0001I8-Uj; Mon, 08 Apr 2024 11:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrJw-0001HP-Qu
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrJu-0001pY-Fo
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712591645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O49FEyqxVwMKh/6RjnlTehcwAT4fAZK02uPZnpIFwno=;
 b=hY5z3u90wB0NWFYScRZTkyMiBd/+TvaMCRqF5HOLTXtU5ccSE5VF2QjbNzWcl44PKyQE0D
 cLJ2IY4afi9YVzl6FiegeOoRqu28vIbY6+OKDn5mQds2lhOgwy0n0DjH51D/mkLY9ZYJDY
 zNOH9evc0MRzlA5qlXu8Tm+TuYiY9g8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-utt6t9YaM6OSHtI3wHrhTw-1; Mon, 08 Apr 2024 11:54:04 -0400
X-MC-Unique: utt6t9YaM6OSHtI3wHrhTw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-343eb273904so1605029f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712591643; x=1713196443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O49FEyqxVwMKh/6RjnlTehcwAT4fAZK02uPZnpIFwno=;
 b=paeSh8VUzrD+wbSHr8favVJUJ6IHJup0LFF/rKXkN3Qz85XvhmcGqv4gWuJ4l5KQ9C
 P10V/UAL2dRjaBBfp1AvtalqKNUVpmGIET4sulBoidmTeoIwe7ItywTVs+9LoJpD3fyL
 6vMlnEW2pziiBAmWyl9TOO8dFHC/U5ARJDwic+4rFvJphK7bJQ2aZQHemAVw89l+pPJa
 2AsVRcPoBRkQ4hS8LAqD35oafJ29WJ+LEr/TjIAYcxoOB2G6UapLYc8kU+ps//0l1SBK
 WACXyxT8uTJpQJTjgHPY97E9xs2SWvAR3HDmiMK5EoDllHUac4QO9VBToyxmu9ngj0CG
 Nk7g==
X-Gm-Message-State: AOJu0YwGI/20+FFm6gQyt67MiKHzOX8mizT6EBNKpVqROZWUGMMS9OAp
 I9GjZICslsefIiIHB1QHDgCUfhkBD9EQ+cjUV4l2ehT/G9FIQsxhLlEYbzI6SSasNCmRVwdhIFT
 OLaH3HgIpyezQ9fRj6vIT7pDS7+S/iA0jMvH9+EBbeDUrtKfYuNKs8VwsetNZJh3QPFUtzA3JhV
 JU79DZtLZ3QkmSnmG7qckxsJMCBCR4A5N0heUH
X-Received: by 2002:adf:f14b:0:b0:342:40b0:abf5 with SMTP id
 y11-20020adff14b000000b0034240b0abf5mr6016552wro.55.1712591642764; 
 Mon, 08 Apr 2024 08:54:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpRYlzRZjtf6WgchuEgz2KMAE4YJglRic3cJjII0dkCZsgjqPQpz8P+EFaN4H5YlFgHdSKbw==
X-Received: by 2002:adf:f14b:0:b0:342:40b0:abf5 with SMTP id
 y11-20020adff14b000000b0034240b0abf5mr6016542wro.55.1712591642506; 
 Mon, 08 Apr 2024 08:54:02 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 k26-20020adfb35a000000b0034607c7d194sm301597wrd.8.2024.04.08.08.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 08:54:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 10/18] hw/usb: move stubs out of stubs/
Date: Mon,  8 Apr 2024 17:53:22 +0200
Message-ID: <20240408155330.522792-11-pbonzini@redhat.com>
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

Since the USB stubs are needed exactly when the Kconfig symbols are not
enabled, they can be placed in hw/usb/ and conditionalized on CONFIG_USB.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 stubs/usb-dev-stub.c => hw/usb/bus-stub.c | 0
 hw/usb/meson.build                        | 2 +-
 stubs/meson.build                         | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)
 rename stubs/usb-dev-stub.c => hw/usb/bus-stub.c (100%)

diff --git a/stubs/usb-dev-stub.c b/hw/usb/bus-stub.c
similarity index 100%
rename from stubs/usb-dev-stub.c
rename to hw/usb/bus-stub.c
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index aac3bb35f27..23f7f7acb50 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -9,7 +9,7 @@ system_ss.add(when: 'CONFIG_USB', if_true: files(
   'desc-msos.c',
   'libhw.c',
   'pcap.c',
-))
+), if_false: files('bus-stub.c'))
 
 # usb host adapters
 system_ss.add(when: 'CONFIG_USB_UHCI', if_true: files('hcd-uhci.c'))
diff --git a/stubs/meson.build b/stubs/meson.build
index aa7120f7110..45616afbfaa 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -56,7 +56,6 @@ endif
 if have_system
   stub_ss.add(files('fw_cfg.c'))
   stub_ss.add(files('semihost.c'))
-  stub_ss.add(files('usb-dev-stub.c'))
   stub_ss.add(files('xen-hw-stub.c'))
   stub_ss.add(files('virtio-md-pci.c'))
 else
-- 
2.44.0


