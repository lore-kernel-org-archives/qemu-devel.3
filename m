Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794E3C25B10
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 17:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s578Z-0002CI-7K; Thu, 09 May 2024 13:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s578X-0002Bm-Fd
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:00:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s578V-0003UC-IV
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715274050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=itudZeYBfZ/5DukRK1hcaOOUBJNhWgbPK+Y48SKsq5Q=;
 b=FvTch1plpv9Ec7Uq9xJW8uCXrePgFiV05iqGwUl8HPfoN5OyR4MqG5Gdy3X984k6AKqVU/
 rb8thEwl+Pm9DC/SDySIDnKMEuckpGIuewiLZ/zlduILuhwgcfWT5zi9vxc/UKdkNhYG1s
 mVg/y0gMd4xULCoLHWC9ChjSdgPbcGo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-VXa4herLNMy389UVJsCMrQ-1; Thu, 09 May 2024 13:00:48 -0400
X-MC-Unique: VXa4herLNMy389UVJsCMrQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2e2ec0c8807so8256911fa.1
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 10:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715274046; x=1715878846;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=itudZeYBfZ/5DukRK1hcaOOUBJNhWgbPK+Y48SKsq5Q=;
 b=fHlrIKhzF8UDqGDiFu20TtiruCqSp5qeG7q0RNudfMahzoJniEOUxhuT2tY8zGOlPJ
 3Vz9Pd8t2hhUxA+7oM58dck/S/Nxo5XDxLWgKvsgc3+0SDe46kfUtx0ryPsjX/DN0UVA
 i0F7GOPhHMQFUEJxi1I8pUUKagc6IWn+8QEUIq9KAWzhL+U+O+xlOVIBatward8Qi0g6
 EUBFkzbodlR4iLtITDPnknHvz5fXnC3Gb1rVGfw2cwuR3MKGU9JbOShTj6cqAVsUQ6/c
 cd1S3TZazXEMZHTYA/ETppP/+lXJlVE8b7Gjm91d0Mnkj3dT7qwkt+ePwywSVD0xwRML
 gVYg==
X-Gm-Message-State: AOJu0Yz5zvdgoTIO/YtrmeiV+JO9JfSUgDYADg1llINqj8rT3p5hUG6j
 AnGMACzCX3TNM4yvLYfX1JBzALL9k9C8jC0dAfplfIBSXJuAYN8FatZGVVHi2SSfpsR3jRCTP+b
 uj5yRRvwGNDKIhnzHA4xbllcOZkw5SL3b34Yiib5R6vj363/68IQ7hd/c7GJxKDSJDC8P06fujn
 L6/se+aF7ezwQyB9u7gSB5v/uxHNH+ZqhPJctG
X-Received: by 2002:a2e:a417:0:b0:2d8:713c:8313 with SMTP id
 38308e7fff4ca-2e5205ec6dbmr99811fa.45.1715274045911; 
 Thu, 09 May 2024 10:00:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCQyTtokRLq1NXdxk9IxZ1YPOirbwFdnaenp6H5qOiP8OWN3PgsDeonDdE+JBh9RyQZ1aEKQ==
X-Received: by 2002:a2e:a417:0:b0:2d8:713c:8313 with SMTP id
 38308e7fff4ca-2e5205ec6dbmr99661fa.45.1715274045331; 
 Thu, 09 May 2024 10:00:45 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733becfb77sm920595a12.41.2024.05.09.10.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 10:00:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com
Subject: [PATCH 00/13] fix --without-default-devices build and (mostly) tests
Date: Thu,  9 May 2024 19:00:31 +0200
Message-ID: <20240509170044.190795-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

The recent change to make boards "default y" made them go away from
a --without-default-devices build, because the boards are not anymore
enabled explicitly in configs/devices/.

This is a problem for some targets that were not fully ready for this
and have generic target code that needs symbols from boards or devices.
The more complicated ones are s390x and i386.  In some cases some
components simply have to be required by target/ARCH/, but often
it is better to move some code around, associating it with boards
instead of targets or vice versa.

--without-default-devices builds in practice will always use a
custom config, but let's keep things tidy.  This series does
this for s390x (patches 1 to 5) and x86 (patches 6 to 12).  As a
small addendum, patch 13 fixes qtest for ARM (32- and 64-bit) on a
--without-default-devices build.

The series seems huge, but it's mostly code movement.  Patch 10
in particular moves board building code, which is unrelated to the
X86MachineState superclass and has many dependencies on NUMA or
hw/i386/pc-sysfw.c.

I suspect that there are more issues, for example when building
a CONFIG_MICROVM-only binary.  Fixing builds without boards on vanilla
upstream configs is the more pressing problem, though.

Patches 6 and 7 were tested with the Avocado Xen-on-KVM tests.

Paolo


Paolo Bonzini (13):
  s390x: move s390_cpu_addr2state to target/s390x/sigp.c
  s390_flic: add migration-enabled property
  s390: move css_migration_enabled from machine to css.c
  s390x: select correct components for no-board build
  tests/qtest: s390x: fix operation in a build without any boards or
    devices
  xen: initialize legacy backends from xen_bus_init()
  xen: register legacy backends via xen_backend_init
  i386: correctly select code in hw/i386 that depends on other
    components
  i386: pc: remove unnecessary MachineClass overrides
  hw/i386: split x86.c in multiple parts
  hw/i386: move rtc-reset-reinjection command out of hw/rtc
  i386: select correct components for no-board build
  tests/qtest: arm: fix operation in a build without any boards or
    devices

 include/hw/i386/x86.h               |   10 +-
 include/hw/rtc/mc146818rtc.h        |    2 +-
 include/hw/s390x/css.h              |    6 +
 include/hw/s390x/s390-virtio-ccw.h  |    7 -
 include/hw/s390x/s390_flic.h        |    1 +
 include/hw/xen/xen-legacy-backend.h |   14 +-
 include/hw/xen/xen_pvdev.h          |    1 -
 hw/9pfs/xen-9p-backend.c            |    8 +-
 hw/display/xenfb.c                  |    8 +-
 hw/i386/fw_cfg.c                    |    2 +
 hw/i386/monitor.c                   |   46 ++
 hw/i386/pc.c                        |    4 -
 hw/i386/x86-common.c                | 1007 +++++++++++++++++++++++++
 hw/i386/x86-cpu.c                   |   97 +++
 hw/i386/x86.c                       | 1058 +--------------------------
 hw/intc/ioapic-stub.c               |   29 +
 hw/intc/s390_flic.c                 |    6 +-
 hw/rtc/mc146818rtc.c                |   12 +-
 hw/s390x/css.c                      |   10 +-
 hw/s390x/s390-virtio-ccw.c          |   32 +-
 hw/usb/xen-usb.c                    |   14 +-
 hw/xen/xen-bus.c                    |    4 +
 hw/xen/xen-hvm-common.c             |    2 -
 hw/xen/xen-legacy-backend.c         |   16 -
 hw/xenpv/xen_machine_pv.c           |    5 +-
 target/s390x/sigp.c                 |   17 +
 tests/qtest/arm-cpu-features.c      |    4 +
 tests/qtest/drive_del-test.c        |    7 +-
 tests/qtest/migration-test.c        |    6 +
 tests/qtest/numa-test.c             |    4 +
 .gitlab-ci.d/buildtest.yml          |    4 +-
 hw/i386/meson.build                 |    7 +-
 hw/intc/meson.build                 |    2 +-
 target/i386/Kconfig                 |    1 +
 target/s390x/Kconfig                |    2 +
 35 files changed, 1289 insertions(+), 1166 deletions(-)
 create mode 100644 hw/i386/monitor.c
 create mode 100644 hw/i386/x86-common.c
 create mode 100644 hw/i386/x86-cpu.c
 create mode 100644 hw/intc/ioapic-stub.c

-- 
2.45.0


