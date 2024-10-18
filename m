Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66004D30016
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1oCu-0008SE-5w; Fri, 18 Oct 2024 10:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCs-0008Rv-HM
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCq-0002d1-WE
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729262636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NsHsr8EGNkWFqpcJthGt4kDzKJbhQ29fHJHg6UgTL0s=;
 b=EK1racNa6fWMtSTqkRperfW0Uzw+qTdVDl1p7SQO7WpurjwG0UJcInhYhSSkkaWhHailH8
 DwXnu8eDaMqSlPy26r2eRC/FNaHyyE6/0+gp6zQb4hGrlRLhlpnCvLgS5O1z2Eo03qzwwN
 /jx3x9SHhkIrnf9QslWO2/yRMQEXmjk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-ohHSrTy1OEKQF0FBErNjfw-1; Fri, 18 Oct 2024 10:43:53 -0400
X-MC-Unique: ohHSrTy1OEKQF0FBErNjfw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d4854fa0eso1262965f8f.2
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729262631; x=1729867431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NsHsr8EGNkWFqpcJthGt4kDzKJbhQ29fHJHg6UgTL0s=;
 b=Trkmywp5rkq+Pk8tEo32eEvhsDvRfRfIYqQCGRryuTHrdhu2Cx8E823OV34f44jghD
 SUCNocmCrElzwJR+D9ULGfuevKjFZxmZo7u5ROMi00g2Jfx7vSVRPazqSx2ROb6/tcXh
 jCbgeY1ileDwDMmSZPR84gt4Vz71dHDjJkplZXjxC8gIysNnhhlaWYIefnv58/1wbkgr
 3tAH+IRmht4QYlchgZzlV7jNIqBkMk4bGbj1UZqI7+EKQNTMiDt7qgjWjsdYAtGQZMRp
 xvcqI9uQl0oIcE1EgeZtI4IvPbsnpyssNglw9TK+nKoois3KzVDVbU2vLR3gSEw58JjA
 JuiQ==
X-Gm-Message-State: AOJu0YyYhILvRzzRRxHU5tg3SMqVibPBqCdLv5FqvqwUPoTY+L3pr1xX
 KZojtfyG5DGCPyRHfw9OZY7EjsQZ3PP+S71eahtLr8MyBEenS+W+snx8/kKq/YxPhKYOEW2J+9n
 dcbf/+GGSS+92HbtwEMPhWuRc1eZg/ePft2jwVQvTtq1K4KO6fc7UXX5ClRbg/JFSCPEne3217N
 4ekRB/+yOODb/xKFGfepFkCjA+cEuzra2UFIUoHNc=
X-Received: by 2002:adf:fe90:0:b0:374:d25f:101 with SMTP id
 ffacd0b85a97d-37eab7436eamr1778397f8f.18.1729262630865; 
 Fri, 18 Oct 2024 07:43:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrXyip2B7LtCCXl5ep7RbXpHD6dbB/qSAaWohU2BHqVRE/wd2lXAFuBppiS2iDX/opSMiIXw==
X-Received: by 2002:adf:fe90:0:b0:374:d25f:101 with SMTP id
 ffacd0b85a97d-37eab7436eamr1778373f8f.18.1729262630362; 
 Fri, 18 Oct 2024 07:43:50 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ecf069298sm2121359f8f.39.2024.10.18.07.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:43:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 13/13] rust: do not use TYPE_CHARDEV unnecessarily
Date: Fri, 18 Oct 2024 16:43:05 +0200
Message-ID: <20241018144306.954716-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018144306.954716-1-pbonzini@redhat.com>
References: <20241018144306.954716-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

In the invocation of qdev_prop_set_chr(), "chardev" is the name of a
property rather than a type and has to match the name of the property
in device_class.rs.  Do not use TYPE_CHARDEV here, just like in the C
version of pl011_create.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 2b43f5e0939..0f6918dd224 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -572,7 +572,7 @@ pub fn update(&self) {
         let dev: *mut DeviceState = qdev_new(PL011State::TYPE_INFO.name);
         let sysbus: *mut SysBusDevice = dev.cast::<SysBusDevice>();
 
-        qdev_prop_set_chr(dev, bindings::TYPE_CHARDEV.as_ptr(), chr);
+        qdev_prop_set_chr(dev, c"chardev".as_ptr(), chr);
         sysbus_realize_and_unref(sysbus, addr_of!(error_fatal) as *mut *mut Error);
         sysbus_mmio_map(sysbus, 0, addr);
         sysbus_connect_irq(sysbus, 0, irq);
-- 
2.46.2


