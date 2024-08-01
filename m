Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8569C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZT9Y-0001UZ-7S; Thu, 01 Aug 2024 06:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZT9X-0001U4-4n
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:35:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZT9V-0001N5-BD
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722508519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=VQbqw3cz0BCZeoRtx2NwlPNrtTjGgCcDHveIKrngEOM=;
 b=Nz0Qi96RHu0Gz747/gKOJInzsZgE6ONq60rzptuVUrJm3RWBGn9KQ2Ru3GsV7cHkvCVjMm
 6z/qsCRH4fu2Ig8OrVPJSLQByTILCj3D4GHaK1AZ+XSMXJOuwfe4Ae34/Y38y++YKirc1E
 DvgpGMUj3BjfOmHEmNf1kB3GGEw8Chk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-xg-KRd1ZMHO2SK7In_Efyg-1; Thu, 01 Aug 2024 06:35:17 -0400
X-MC-Unique: xg-KRd1ZMHO2SK7In_Efyg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2f01a8b90b6so79359201fa.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722508516; x=1723113316;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VQbqw3cz0BCZeoRtx2NwlPNrtTjGgCcDHveIKrngEOM=;
 b=HiRQasqGflg0AEDeyZLjitA76yjuXQjJ9POqK6Y1mVoXhfpFjOuyRvpBjwEQXaQosJ
 mKNBpzbFHGKGmKKge9l26u85A/hvyDwLhWp2x2OoVYfwQjElIEoCNWUixgpNSs8uOmvh
 ZiNQKndOQXvWWAAr93OD/21qHdohmSuuRq3YA2e23PcFzPUhy0YoTueHoLzUyzaiY8Y3
 /7RBTqz1wsx5jOTwLjAwj9BdQMlBSXdoloH7GIsINDrAq7SMRloHMsBOHKdgWbwhuUOb
 SFEnbTEDeBJsSdTuu5UXC8QowVLqVJFY0vjlYD2pJH75UuI23zzQZw9j/RXzpCcsPsJ2
 jMrw==
X-Gm-Message-State: AOJu0YxWN0P9sN5LXZeUyT53EZljnWlBFxQmStcyeIBrJoZwIpKAm4E9
 MizrxXEv0UgUn/JenS/jPm64OF0uFnC0nZzbvV45p8hP58nFmZ7ywB3ierSSs0ik+dUv1lRau26
 4wH5Vi6mOlNVy7Pj2XwjQDKTN3RHk+dZGr0ONAQ43xX71lCqf4+KcpGgdFVK5YhKiK4Md1TZhx0
 tgRLlrX0qhHg9XyASO26Hl9ZpbadKXGQ==
X-Received: by 2002:a2e:9645:0:b0:2ef:2e98:9718 with SMTP id
 38308e7fff4ca-2f1530ea4a7mr17613421fa.15.1722508515684; 
 Thu, 01 Aug 2024 03:35:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELG9sFfQUXFvYKWgkDSADApo7CxEm/+gfYPUZ8SEH0eUDJixibBQ9SlqJOPiYWqXbPBy6YKw==
X-Received: by 2002:a2e:9645:0:b0:2ef:2e98:9718 with SMTP id
 38308e7fff4ca-2f1530ea4a7mr17612791fa.15.1722508514648; 
 Thu, 01 Aug 2024 03:35:14 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab28249sm876555266b.30.2024.08.01.03.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:35:09 -0700 (PDT)
Date: Thu, 1 Aug 2024 06:35:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/19] virtio,pci,pc: fixes
Message-ID: <cover.1722508478.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit e9d2db818ff934afb366aea566d0b33acf7bced1:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-08-01 07:31:49 +1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 515457757ff8540c524ff39ea1d9564b251c6532:

  intel_iommu: Fix for IQA reg read dropped DW field (2024-08-01 04:32:00 -0400)

----------------------------------------------------------------
virtio,pci,pc: fixes

revert virtio pci/SR-IOV emulation at author's request
a couple of fixes in virtio,vtd

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (17):
      virtio-rng: block max-bytes=0
      Revert "docs: Document composable SR-IOV device"
      Revert "virtio-net: Implement SR-IOV VF"
      Revert "virtio-pci: Implement SR-IOV PF"
      Revert "pcie_sriov: Allow user to create SR-IOV device"
      Revert "pcie_sriov: Check PCI Express for SR-IOV PF"
      Revert "pcie_sriov: Ensure PF and VF are mutually exclusive"
      Revert "hw/pci: Fix SR-IOV VF number calculation"
      Revert "pcie_sriov: Register VFs after migration"
      Revert "pcie_sriov: Remove num_vfs from PCIESriovPF"
      Revert "pcie_sriov: Release VFs failed to realize"
      Revert "pcie_sriov: Reuse SR-IOV VF device instances"
      Revert "pcie_sriov: Ensure VF function number does not overflow"
      Revert "pcie_sriov: Do not manually unrealize"
      Revert "hw/ppc/spapr_pci: Do not reject VFs created after a PF"
      Revert "hw/ppc/spapr_pci: Do not create DT for disabled PCI device"
      Revert "hw/pci: Rename has_power to enabled"

Peter Maydell (1):
      hw/i386/amd_iommu: Don't leak memory in amdvi_update_iotlb()

yeeli (1):
      intel_iommu: Fix for IQA reg read dropped DW field

 docs/pcie_sriov.txt            |   8 +-
 include/hw/pci/pci.h           |   2 +-
 include/hw/pci/pci_device.h    |  23 +--
 include/hw/pci/pcie_sriov.h    |  27 +--
 include/hw/virtio/virtio-pci.h |   1 -
 hw/i386/amd_iommu.c            |   8 +-
 hw/i386/intel_iommu.c          |   4 +-
 hw/net/igb.c                   |  13 +-
 hw/nvme/ctrl.c                 |  24 +--
 hw/pci/pci.c                   |  89 +++------
 hw/pci/pci_host.c              |   4 +-
 hw/pci/pcie_sriov.c            | 433 +++++++++++------------------------------
 hw/ppc/spapr_pci.c             |   8 +-
 hw/virtio/virtio-net-pci.c     |   1 -
 hw/virtio/virtio-pci.c         |  20 +-
 hw/virtio/virtio-rng.c         |   5 +-
 MAINTAINERS                    |   1 -
 docs/system/index.rst          |   1 -
 docs/system/sriov.rst          |  36 ----
 hw/pci/trace-events            |   2 +-
 20 files changed, 188 insertions(+), 522 deletions(-)
 delete mode 100644 docs/system/sriov.rst


