Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0093C54E41
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 12:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdUxp-0007Kg-3o; Fri, 23 Feb 2024 07:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdUuw-0000sn-3T
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:44:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdUuu-0003vG-Jv
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708692280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/EEabN0n+ev512MEiobhlaPXaFyHc3L1SDEjqtz9S28=;
 b=Qy460FhAglq5qgCLwM1xln1oRxLkZIEKB2UxNO2WhhhS8LErPnq71GS9Bj0/tKg5UuqYN4
 m7TxN52D69+x+zC4Pcq7RYX5VTHaZLu7nDk5Mt3NAbOypUi7eFf/dLi0S38xApuOZy2YgD
 stfgo2d0SC786iK3+Xt7WudVOqZhRs4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-NPfLpbrsNbuv0N1FvQsBNA-1; Fri, 23 Feb 2024 07:44:38 -0500
X-MC-Unique: NPfLpbrsNbuv0N1FvQsBNA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-41294afc0d4so2392955e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 04:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708692277; x=1709297077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/EEabN0n+ev512MEiobhlaPXaFyHc3L1SDEjqtz9S28=;
 b=fPY5mU0/5PVmlnVz9FU2r3kVLh8Uyf3JP41f5i6fdU7PTS5RmLcqdWw3cI6gs4+Id3
 U+LQdqjn+ql+Rxwg15gCgcLU4er7Lcik+JjeDD+Bd6acrsWWV1YG8EN9z7DvJiPG5nm+
 Uv2MG0gbWcvhshaXKhM2/lekktLDDEHPdqManI42+3aeVRYMh2RZ6fpFf+FLztIDZsTK
 7aAeulJNc1P09a37zm/J2jgnjozLLdyaqw24ftknlKleHD9fOyYaQW53r0yJFoezPSo2
 rXt+CBPc4Vl2oLRHWh1tCXPVxDK5lZE+qSZp28PwydZhEwzvEOdANxeZiYqk+11cFKQR
 qwQA==
X-Gm-Message-State: AOJu0YxHg9cgOySLYmdeB0H0p9wYioN2Rt5UD7VOfAiWO3Ffqs8mWLR7
 THj+asty3de+m58ynSf+IeWOL36Sj/2oh4gxQUZ2pxMUXFQc7AuY1n4pYcZ5YogAeKn6/3Mq9Xy
 RYY0YNu+KDihW6C/3G5tBhFD/Wvbhrglz15fXDMJlRuaKN3m3+LIAmsaA41lgxNSPK+4X0T0odL
 lt4pSA0mNTIPaTOhUYavIhbgybfIDCi/N/Z9hc
X-Received: by 2002:a05:600c:3109:b0:412:4375:38c1 with SMTP id
 g9-20020a05600c310900b00412437538c1mr5063265wmo.3.1708692276896; 
 Fri, 23 Feb 2024 04:44:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+BPWz50nYnhH8NdhEh8kCe6VFaGWsD7Pdac02UV7tVNtFuznFu7ZdVsjARKnOkSDHJ65rNQ==
X-Received: by 2002:a05:600c:3109:b0:412:4375:38c1 with SMTP id
 g9-20020a05600c310900b00412437538c1mr5063254wmo.3.1708692276674; 
 Fri, 23 Feb 2024 04:44:36 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 k20-20020a05600c0b5400b004129018510esm2222942wmr.22.2024.02.23.04.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 04:44:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	balaton@eik.bme.hu
Subject: [PATCH 10/10] usb: remove duplicate file in system_ss
Date: Fri, 23 Feb 2024 13:44:06 +0100
Message-ID: <20240223124406.234509-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223124406.234509-1-pbonzini@redhat.com>
References: <20240223124406.234509-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

Because USB_EHCI_SYSBUS selects USB_EHCI, there is no need to include
hcd-ehci.c explicitly.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/usb/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index 94f0e3b034d..aac3bb35f27 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -18,7 +18,7 @@ system_ss.add(when: 'CONFIG_USB_OHCI_PCI', if_true: files('hcd-ohci-pci.c'))
 system_ss.add(when: 'CONFIG_USB_OHCI_SYSBUS', if_true: files('hcd-ohci-sysbus.c'))
 system_ss.add(when: 'CONFIG_USB_EHCI', if_true: files('hcd-ehci.c'))
 system_ss.add(when: 'CONFIG_USB_EHCI_PCI', if_true: files('hcd-ehci-pci.c'))
-system_ss.add(when: 'CONFIG_USB_EHCI_SYSBUS', if_true: files('hcd-ehci.c', 'hcd-ehci-sysbus.c'))
+system_ss.add(when: 'CONFIG_USB_EHCI_SYSBUS', if_true: files('hcd-ehci-sysbus.c'))
 system_ss.add(when: 'CONFIG_USB_XHCI', if_true: files('hcd-xhci.c'))
 system_ss.add(when: 'CONFIG_USB_XHCI_PCI', if_true: files('hcd-xhci-pci.c'))
 system_ss.add(when: 'CONFIG_USB_XHCI_SYSBUS', if_true: files('hcd-xhci-sysbus.c'))
-- 
2.43.0


