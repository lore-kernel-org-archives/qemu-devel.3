Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10692D6ACD2
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 13:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGIXz-0003dz-LD; Wed, 27 Nov 2024 08:57:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIXw-0003dd-2u
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:57:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIXu-0007gD-6p
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732715852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=fFk4yg9WVAmZpD8IXlTuhdpMwYzS9dXXsIOBVyz0gZM=;
 b=W2HlBXryiL2mr2SzXgXQ/JJ0ldV5xfecgPsEn1HwGbCPqJiT3bDicZ30wRVPUtOqePJgEY
 8kovCRYp9NX/laqPCbibbtSWBnj6QmfrVUS6RLrV884VetjkdeTAdGbsISKhVbV9DE6kKo
 Lx8b/5FVYMYPTfbyfV6ukTRJKANY4Iw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-JxWuvbOvPwiTj97v0NYw7w-1; Wed, 27 Nov 2024 08:57:31 -0500
X-MC-Unique: JxWuvbOvPwiTj97v0NYw7w-1
X-Mimecast-MFC-AGG-ID: JxWuvbOvPwiTj97v0NYw7w
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-434a90fecfeso9757585e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 05:57:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732715849; x=1733320649;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fFk4yg9WVAmZpD8IXlTuhdpMwYzS9dXXsIOBVyz0gZM=;
 b=EpQQUdr6Wjr2pM2hhkqqMG0/bWcSDiU7f8YKV6ofBMMSH1K6xltWudGZ6k3hnt2Ezx
 v3LT5jR+kgE2+1D+0SdibE58CPZl6VjfERwIriebJMEN8sl/ez5OebSRtf/bYkgn7K3z
 2V2KCBKwdBMWTWg3T47UXzim1nALMMF4eyGjpMWzTPDyPSl7w4OgzqhYqDZ9apGAopg4
 m2eEoH0GVYwC4KTNn9wPClqX2sRaaNlvSDBUlB9t1BG/+hSmSOrFdpH9B4EWU8zHMvIX
 SrIgbdIRXldSzi1KGaje2sT4+R13Vy1/14lGryUL4NijwwY9N6hT0PtxVItomtZPZbmN
 TM5w==
X-Gm-Message-State: AOJu0YyZqF3zIjARKxwdaMbWIPHtxyOcHfPUcFywDyf7H9Ve+jxPkZr4
 PvQQTsoLRwsu22tI5ANQrLgEn6EPmKmRv95g44r+HhKAWlZFyG633bvLRq17Ffm5K1wJuadC0aE
 PbyMF+/e1h5joXaFk2sEClcvRgSxn5IEb4cKT0SD6W9R0e9CSRdd4N+IN7UDgWrs78oxv3kdyOb
 cfCdGnEWdStq7TN89K6ts/u0+fBVSp6NQr
X-Gm-Gg: ASbGnctyNkuWzeaI5YsE6ekCA7hCFy6YUmAw9hPCKbb4/Sy+rCPcSbkay6dEXh+A/iq
 v+x9FusTIFhQLMC+Xoa3OGrnrFAd9OH+DnGkW6fHD6ZUqu6M8tN/jX63GLtN5/iM1bhAuNDNy3D
 /sXsoevpIabl/PV2x3clcVwH1yMYwGtMS2TEASZtwu8obAYVbnHZBlzvqg4dV0UmskgvCZCihIO
 KN37bIp9nfH10tWcfqfiZQqFnkKrI9jRcpWj8v0JeJT
X-Received: by 2002:a05:600c:1d8d:b0:426:6edf:6597 with SMTP id
 5b1f17b1804b1-434a9dd02a5mr25754815e9.19.1732715849579; 
 Wed, 27 Nov 2024 05:57:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpUZBjRH/ILo80g+A3UHuw15Bu9YnDsGGONMHBUNbX2NdYQYRuAe/RotSaVCz+6DJxssyMFg==
X-Received: by 2002:a05:600c:1d8d:b0:426:6edf:6597 with SMTP id
 5b1f17b1804b1-434a9dd02a5mr25754665e9.19.1732715849201; 
 Wed, 27 Nov 2024 05:57:29 -0800 (PST)
Received: from redhat.com ([2a02:14f:1ec:7d4b:8b11:bed7:9e00:8df7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a972c33csm24190135e9.1.2024.11.27.05.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 05:57:28 -0800 (PST)
Date: Wed, 27 Nov 2024 08:57:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/13] virtio,pc,pci: bug fixes, new test
Message-ID: <cover.1732715823.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The following changes since commit 34754a3a627e1937be7f3daaa0c5e73d91c7d9b5:

  Update version for v9.2.0-rc1 release (2024-11-20 18:27:48 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 571bdc97b83646dfd3746ec56fb2f70bca55b9a2:

  vhost: fail device start if iotlb update fails (2024-11-26 17:18:07 -0500)

----------------------------------------------------------------
virtio,pc,pci: bug fixes, new test

Some small bug fixes, notably a fix for a regression
in cpu hotplug after migration. I also included a
new test, just to help make sure we don't regress cxl.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Igor Mammedov (3):
      Revert "hw/acpi: Update ACPI `_STA` method with QOM vCPU ACPI Hotplug states"
      Revert "hw/acpi: Make CPUs ACPI `presence` conditional during vCPU hot-unplug"
      tests/acpi: update expected blobs

Jonathan Cameron (6):
      hw/cxl: Check for zero length features in cmd_features_set_feature()
      hw/acpi: Fix size of HID in build_append_srat_acpi_device_handle()
      qapi/qom: Change Since entry for AcpiGenericPortProperties to 9.2
      bios-tables-test: Allow for new acpihmat-generic-x test data.
      bios-tables-test: Add complex SRAT / HMAT test for GI GP
      bios-tables-test: Add data for complex numa test (GI, GP etc)

Prasad J Pandit (1):
      vhost: fail device start if iotlb update fails

Salil Mehta (1):
      qtest: allow ACPI DSDT Table changes

Vladimir Sementsov-Ogievskiy (1):
      qapi: fix device-sync-config since-version

zuoboqun (1):
      vhost_net: fix assertion triggered by batch of host notifiers processing

 qapi/qdev.json                                    |   2 +-
 qapi/qom.json                                     |   2 +-
 include/hw/core/cpu.h                             |   2 -
 hw/acpi/aml-build.c                               |   2 +-
 hw/acpi/cpu.c                                     |  53 ++----------
 hw/cxl/cxl-mailbox-utils.c                        |   4 +
 hw/net/vhost_net.c                                |  35 +++++---
 hw/virtio/vhost.c                                 |  13 ++-
 tests/qtest/bios-tables-test.c                    |  97 ++++++++++++++++++++++
 tests/data/acpi/x86/pc/DSDT                       | Bin 8560 -> 8526 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst              | Bin 8471 -> 8437 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat              | Bin 9885 -> 9851 bytes
 tests/data/acpi/x86/pc/DSDT.bridge                | Bin 15431 -> 15397 bytes
 tests/data/acpi/x86/pc/DSDT.cphp                  | Bin 9024 -> 8990 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm               | Bin 10214 -> 10180 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge              | Bin 8511 -> 8477 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot              | Bin 5067 -> 5033 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs               | Bin 8632 -> 8598 bytes
 tests/data/acpi/x86/pc/DSDT.memhp                 | Bin 9919 -> 9885 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet                | Bin 8418 -> 8384 bytes
 tests/data/acpi/x86/pc/DSDT.numamem               | Bin 8566 -> 8532 bytes
 tests/data/acpi/x86/pc/DSDT.roothp                | Bin 12353 -> 12319 bytes
 tests/data/acpi/x86/q35/APIC.acpihmat-generic-x   | Bin 0 -> 136 bytes
 tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x   | Bin 0 -> 68 bytes
 tests/data/acpi/x86/q35/DSDT                      | Bin 8389 -> 8355 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst             | Bin 8406 -> 8372 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat             | Bin 9714 -> 9680 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x   | Bin 0 -> 12565 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator | Bin 8668 -> 8634 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc             | Bin 8435 -> 8401 bytes
 tests/data/acpi/x86/q35/DSDT.bridge               | Bin 12002 -> 11968 bytes
 tests/data/acpi/x86/q35/DSDT.core-count           | Bin 12947 -> 12913 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2          | Bin 33804 -> 33770 bytes
 tests/data/acpi/x86/q35/DSDT.cphp                 | Bin 8853 -> 8819 bytes
 tests/data/acpi/x86/q35/DSDT.cxl                  | Bin 13180 -> 13146 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm              | Bin 10043 -> 10009 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt               | Bin 8464 -> 8430 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus            | Bin 8477 -> 8443 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs                 | Bin 8406 -> 8372 bytes
 tests/data/acpi/x86/q35/DSDT.memhp                | Bin 9748 -> 9714 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64               | Bin 9519 -> 9485 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge         | Bin 13242 -> 13208 bytes
 tests/data/acpi/x86/q35/DSDT.noacpihp             | Bin 8269 -> 8235 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet               | Bin 8247 -> 8213 bytes
 tests/data/acpi/x86/q35/DSDT.numamem              | Bin 8395 -> 8361 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa          | Bin 8490 -> 8456 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count         | Bin 12947 -> 12913 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2        | Bin 33804 -> 33770 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12            | Bin 8995 -> 8961 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2             | Bin 9021 -> 8987 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count          | Bin 18623 -> 18589 bytes
 tests/data/acpi/x86/q35/DSDT.viot                 | Bin 14646 -> 14612 bytes
 tests/data/acpi/x86/q35/DSDT.xapic                | Bin 35752 -> 35718 bytes
 tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x   | Bin 0 -> 360 bytes
 tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x   | Bin 0 -> 520 bytes
 55 files changed, 145 insertions(+), 65 deletions(-)
 create mode 100644 tests/data/acpi/x86/q35/APIC.acpihmat-generic-x
 create mode 100644 tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x


