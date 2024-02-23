Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9EEC54E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 12:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdUxf-0006Vj-4Q; Fri, 23 Feb 2024 07:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdUuX-0000YO-Pi
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:44:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdUuV-0003t4-Tp
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708692253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=h7WdA5OhmmfKzv8Y0O9YrSujyoqIWJuwCNXP8IoF72Y=;
 b=FnIJ0/GmwmMRvBgzvnXzKqVlZJqPUGU5pNGn/D0vvstP3/pTvDBucMy85mnl1V6BwbL7By
 CtSst2w4XWXMgtNi/WcyBicss70Caffz4XtBE7hVTiu+uacKGo2QCddShWeGPLZ5T04HMD
 PPjdg3zzUh57gd2ryAoByV0F+2QJQs0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-eXhu38prPaWqU2ei653tpw-1; Fri, 23 Feb 2024 07:44:12 -0500
X-MC-Unique: eXhu38prPaWqU2ei653tpw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40d62d3ae0cso4260135e9.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 04:44:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708692249; x=1709297049;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h7WdA5OhmmfKzv8Y0O9YrSujyoqIWJuwCNXP8IoF72Y=;
 b=C7bdIfNH7wjP1b9yOi1Hek9nBs2ShlQKBmtyWw3QkK8qi2bjYCkbTbRAg2F6Cu2DSY
 /j9yBCu6eTWlx48/MTU+Oi3irfDdRGI8G9yacSLPl077BKxkww3GDx0YYLxhlvYEajkg
 G2K+/oFpDZa8ezs9yNta58q8OYVVI0NkCbm6kgCSMg6iSWihdCANjz48TROWCWAVCaMh
 yQPIjaQm3kL4eXSyIxIky1LxMA5WufSrytl3C/+35PA7Zpvb2cUqOMUUXcSBlPGM+kAw
 uAuFbtUu8g+GEywRPXjn6pB0QE58pJwf/xog1lzGaBevvyjjlOaunCLZ/7zNpv3Xbbf9
 +NTQ==
X-Gm-Message-State: AOJu0Yxr3yJREvJMmlXocLludEztVdeZQjiM0+cP93iJodlK8lGtc6gq
 ujqlqrrMzSESCmsmwN+So/LpiMBoytdgJTc0FbJ/li9+r7jTtSKJmgtNseHpWGTVR/Bm33NNBgO
 2LzVeyxUn7w+7nFuOTPOCAZEyhvQBw33KY9LVY5w/+9mQ3X93vB8R9+ulo2/EepcsLf0usnNWjE
 /tZGSSbV1V0J0wIq+tF/YV+iGFvseZegGyMsTr
X-Received: by 2002:a05:600c:3d05:b0:412:97e3:2540 with SMTP id
 bh5-20020a05600c3d0500b0041297e32540mr155865wmb.12.1708692249356; 
 Fri, 23 Feb 2024 04:44:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHquLbdSngMhzFpti5Vb6ZgF9eMKL8XbJaVEH+qNftZzE6RQktFvmOdTX2ctB4r7Nzku0ZJpQ==
X-Received: by 2002:a05:600c:3d05:b0:412:97e3:2540 with SMTP id
 bh5-20020a05600c3d0500b0041297e32540mr155762wmb.12.1708692247720; 
 Fri, 23 Feb 2024 04:44:07 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a05600c0a4700b004105528c61fsm2359869wmq.35.2024.02.23.04.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 04:44:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	balaton@eik.bme.hu
Subject: [PATCH 00/10] usb cleanups: remove usb_bus_find(),
 extract sysbus-ohci to a separate file
Date: Fri, 23 Feb 2024 13:43:56 +0100
Message-ID: <20240223124406.234509-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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

Patches 1 to 3 start the removal of usb_bus_find() by replacing it
with object_resolve_type_unambiguous(), a function that is included
in the ACPI builder but should arguably be part of the core QOM API.
Because the only USB host controller must be the one created by the
machine init function itself, there is no need for a special functions
that looks for the "first" bus.

Patches 4 to 7 allow machines that have builtin USB devices to make
the USB system merely the default, and not require it.  At this point
usb_bus_find() is not used anymore outside usb.c, and the only remaining
caller can inline it in patch 8.

Patches 9 and 10 do other build system cleanups to the USB subsystem,
extracting sysbus-ohci to a separate file (as is already the case for
EHCI and XHCI sysbus variants) and removing a duplicate file in the
Meson sourcesets.

The diffstat looks unfavorable, but it's mostly due to
improved documentation and to the duplicated header comment
in hw/usb/hcd-ohci-sysbus.c.

Paolo

Paolo Bonzini (10):
  acpi, qom: move object_resolve_type_unambiguous to core QOM
  ppc: sam460ex: do not use usb_bus_find()
  sh4: r2d: do not use usb_bus_find()
  mips/loongson3_virt: do not require CONFIG_USB
  hppa: do not require CONFIG_USB
  mac_newworld: do not require CONFIG_USB
  pseries: do not require CONFIG_USB
  usb: remove usb_bus_find
  usb: extract sysbus-ohci to a separate file
  usb: remove duplicate file in system_ss

 include/hw/usb.h         |  1 -
 include/qom/object.h     | 13 ++++++
 hw/hppa/machine.c        |  7 +--
 hw/i386/acpi-build.c     | 19 ++------
 hw/mips/loongson3_virt.c |  5 +-
 hw/ppc/mac_newworld.c    |  7 ++-
 hw/ppc/sam460ex.c        |  6 ++-
 hw/ppc/spapr.c           |  7 ++-
 hw/sh4/r2d.c             |  4 +-
 hw/usb/bus.c             | 15 +-----
 hw/usb/hcd-ohci-sysbus.c | 91 ++++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-ohci.c        | 58 ------------------------
 qom/object.c             | 16 +++++++
 hw/arm/Kconfig           | 12 +++--
 hw/display/Kconfig       |  1 +
 hw/hppa/Kconfig          |  2 +-
 hw/ppc/Kconfig           |  5 +-
 hw/sh4/Kconfig           |  1 -
 hw/usb/Kconfig           |  4 ++
 hw/usb/meson.build       |  3 +-
 20 files changed, 163 insertions(+), 114 deletions(-)
 create mode 100644 hw/usb/hcd-ohci-sysbus.c

-- 
2.43.0


