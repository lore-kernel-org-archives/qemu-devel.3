Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD37C54E41
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 12:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdUwl-0005e7-Fn; Fri, 23 Feb 2024 07:46:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdUur-0000ob-SL
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:44:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdUun-0003ub-ST
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:44:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708692273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wdFeJfFPd+rESlH0Stf2Q7C2WzvaU7Ne4mFpQgmpfoM=;
 b=RrmFS3hI7BfhZkgdGJdgihNwbeKE0Ma+hgDkXjO3yx3im/8R7iS9Gs+hjJTLEA0gmc/9TX
 mp+9Kdh9Fn3/+AibmKvoHME1HhiwWEwKdgpmWj1v5dT4oNSK2wIN7GxMaWFSB2hWWKnm2S
 q8FNT5eKca4Dru4bNBWdShKn0hnTvms=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-Ae52FGZxO_29WQSjnxE78g-1; Fri, 23 Feb 2024 07:44:32 -0500
X-MC-Unique: Ae52FGZxO_29WQSjnxE78g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33d23c8694dso130694f8f.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 04:44:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708692270; x=1709297070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wdFeJfFPd+rESlH0Stf2Q7C2WzvaU7Ne4mFpQgmpfoM=;
 b=t3BcvK3zIkO4rssli860QT2lff3A4hpPdKCtWFJaY9r+77DAxHfSSDmzVaRuZIzidA
 FAJLCb1MdRD2eJVCF2n6KXlLdNdbw6FTbtJ7tIPHTa8vINUA+engp598MGXEAMa4CuE7
 /VPb9UTbfhjUuSt+569L6wuXaRfVavGBsKSmbeeAMbNbpJOZTKVaeKBVnkVKr67Yx5pH
 fSxtGewBoPqNNJP2zubBIip94oxYsACALs876WS3mwtPF0RyaKi1rIb/3jPDnPuHqCcB
 sNU36F1VWaFi/dRr13mHhetH3ccnQcA36RTVigYuHvUt10ez82j1mfDFH2AtJbXtLCSB
 RBFg==
X-Gm-Message-State: AOJu0Yw0MHvvFODUY/hOWyZLofKRalPfgEv20DKMT2BzLdAwG6DJ2Gpo
 quS7d/7pVB3NVPRq0fV0DXcIXVXsTO3WhKo87cek4pyvu4vDDN7QjeL3GhnIG7y9cKMpUL5urDd
 RsxGHtVBe/NbWsT5WHuzoM3MvhA1FG8fzPpxrtxapELKsd7HYdxkhYFgdjdgdj//r8sVYjCBzeu
 9lX6kzCdrwcTWPcG9WWYkPY750tDQnKm7a9zAu
X-Received: by 2002:a5d:4206:0:b0:33b:636e:c967 with SMTP id
 n6-20020a5d4206000000b0033b636ec967mr1294125wrq.1.1708692269924; 
 Fri, 23 Feb 2024 04:44:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS0LU2NZ6+ixSSAqdRDaqXiQKZUgk7K7RMRwoMbR7rTgMASC/o2VDWNaw0NVSYvNF9nkBHzg==
X-Received: by 2002:a5d:4206:0:b0:33b:636e:c967 with SMTP id
 n6-20020a5d4206000000b0033b636ec967mr1294110wrq.1.1708692269551; 
 Fri, 23 Feb 2024 04:44:29 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a05600c444900b0041228b2e179sm2262252wmn.39.2024.02.23.04.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 04:44:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	balaton@eik.bme.hu
Subject: [PATCH 07/10] pseries: do not require CONFIG_USB
Date: Fri, 23 Feb 2024 13:44:03 +0100
Message-ID: <20240223124406.234509-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223124406.234509-1-pbonzini@redhat.com>
References: <20240223124406.234509-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

With --without-default-devices it is possible to build a binary that
does not include any USB host controller and therefore that does not
include the code guarded by CONFIG_USB.  While the simpler creation
functions such as usb_create_simple can be inlined, this is not true
of usb_bus_find().  Remove it, replacing it with a search of the single
USB bus on the machine.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ppc/spapr.c | 7 +++----
 hw/ppc/Kconfig | 1 +
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0d72d286d80..44d339982da 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3024,10 +3024,9 @@ static void spapr_machine_init(MachineState *machine)
         }
 
         if (has_vga) {
-            USBBus *usb_bus = usb_bus_find(-1);
-
-            usb_create_simple(usb_bus, "usb-kbd");
-            usb_create_simple(usb_bus, "usb-mouse");
+            Object *usb_bus = object_resolve_type_unambiguous(TYPE_USB_BUS, &error_abort);
+            usb_create_simple(USB_BUS(usb_bus), "usb-kbd");
+            usb_create_simple(USB_BUS(usb_bus), "usb-mouse");
         }
     }
 
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 9841c2c9690..d497fa2b825 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -1,5 +1,6 @@
 config PSERIES
     bool
+    imply USB_OHCI_PCI
     imply PCI_DEVICES
     imply TEST_DEVICES
     imply VIRTIO_VGA
-- 
2.43.0


