Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E569606D810
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GsMhGHUe;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OITDXlHi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOD28-0003Zj-Vt; Tue, 03 Nov 2026 06:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD27-0003ZL-0D
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:50:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD25-0000JN-6j
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793706627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KIzktQ2fiCWeV8Tryp+7m+/Kn/CNR/7dD0eFjteZy3Q=;
 b=GsMhGHUe2pQVAnq8iubl4xIt39OfSfhI+52krddRdVgBLT5F5tSjO0/YB/0d+88Vvn2zPX
 BJrJErgTTUIRhgSXipni7CXHc3SQiSvNisK25gOks3IRRlfmBs7uvd/X6XL7VISJqJ4Xxa
 dQ9APiJTobqRphAWJcAoko5A+i92N9U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-TVWn_BNYPFuVfB3bzZXQLg-1; Tue, 03 Nov 2026 06:50:25 -0500
X-MC-Unique: TVWn_BNYPFuVfB3bzZXQLg-1
X-Mimecast-MFC-AGG-ID: TVWn_BNYPFuVfB3bzZXQLg_1793706624
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4994d67d0e3so29203135e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793706624; x=1794311424; darn=nongnu.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KIzktQ2fiCWeV8Tryp+7m+/Kn/CNR/7dD0eFjteZy3Q=;
 b=OITDXlHisz7wQBv192ODFzWNoX5ImYToHNqQh0ZKkXjmv5D5hJGNEN+DhEBvL54/+s
 ZNl5MOb/0loYiYsV+N8ioaitTD/pNkPqwbkxlTY9Fj9Svz8+ehGBgsezbH81m1wMGXdz
 6/DZu30nf6MRbi/Vst5cwx+MJEpd+jD/bJB/tryK0rh4JQAjCJtQXAbvZg+OJOQKF+Kx
 RLbZNJziMv2vn6Bvmpgm+xz5/wUrdv8+jE3aFbBeKyjzQ+49+B2sc8RC2pF9eUFRiWPJ
 XEoU3SXlN38sI+j2NscSv01CIrBpd9tVP/eh4QjfDrmCURO/XCdaxEzxz8RH4hlOiJXY
 m52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793706624; x=1794311424;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KIzktQ2fiCWeV8Tryp+7m+/Kn/CNR/7dD0eFjteZy3Q=;
 b=IdItQaGehONn/ONAkCGjEdDE3gcYyF0RCkatyzTwjg9CwL1Qe3iG7P0dM6W1GNQsxw
 k5Thr14307rTshL6dJkspfLFL+o8bMmB2Wbn0lRC/ebl2Ic40N43T8aMPm2IaocKA3wo
 aAkw6YNLN1GgOTZn4AaAubWLEL9rISObNrWdvxwqmYBSeU9NbAbCEmh1nnk3nJXSFtuw
 1lOypDz8AjTMJFTN0fV/DawaeokLIk50/wJ4vU2/2fipx1Dk9T569ZY6QgYm+YVRVTJD
 SpYetbxksdnTeHNkZymGNfUl86fRQX5eeDHGOYVBnpUMgeTUI+fCapqi22YdjvvyIXwJ
 wEgQ==
X-Gm-Message-State: APuU4Z/Cqi8VFIvZpHx1J2UrHU9qdCD7Zznzj/f/Mkox41A85XaJlYSa
 pnM9HgPAjxrjgRp3UFo0022S2dycok29E8HKV5LhTpbYyhYD8GvGi/goVPB0pVALlcRCZ+/tqfV
 ezRTqzjPBLNkZNcHFtT/tjPEYrXOkDfhX8O2E62amQU6zEg7i1E6A7x66zCEjsrr7o1ELO3IXmu
 ngMeQu/3uAlCewoJugq0Jeimi1irbmN1bc7w==
X-Gm-Gg: AYBFou15WYqwqLAEqWR383UoZSzdJRIiHSkTRDCem5ndNGok+QZ8YmzOHZ2TsX0gITx
 zT4YwmqnKEdaOwozqnYCaKpsvnbxR3Qe+zHG2SVvPGr1Zp/nFw4uWhMIhwju5qf3o3DllGXdWJW
 XnsKoBtcfXI6GtZwvlMmgO8Xv/3sH8YdDTxRa68FiT9A76hevO1EFjP9UB76MXkvQRbeDj6W0Z4
 D+9UtFxwaRdjS1lITzqerfaBOszHBDrE0WxfgWeNj2oheO/HQHIVYTv+IzxHXvj6KIYdq7Mn4rG
 5C60zfFwI7uo/Rw5k8kMLarcgPPZwl6te/n0sstoKLHWElv92QE6sEiJJ+erOY9MfYHQIDdVNyX
 02g7eHerMHGwIaCVTm1J36M81UDxe50x3hA91mX9g/A==
X-Received: by 2002:a05:600c:354a:b0:4a3:5a55:f454 with SMTP id
 5b1f17b1804b1-4ac17e10ac3mr305043155e9.19.1793706624219; 
 Tue, 03 Nov 2026 03:50:24 -0800 (PST)
X-Received: by 2002:a05:600c:354a:b0:4a3:5a55:f454 with SMTP id
 5b1f17b1804b1-4ac17e10ac3mr305042675e9.19.1793706623710; 
 Tue, 03 Nov 2026 03:50:23 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac0950d533sm199209575e9.3.2026.11.03.03.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:50:23 -0800 (PST)
Date: Tue, 3 Nov 2026 06:50:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/17] pci: fixes
Message-ID: <cover.1793706601.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-28.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 4075aa42daecf701cd3869da8b3271dc3c04a4b1:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2026-10-30 15:26:36 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to cc82fad46af62a3f5488538b6261eb7d54837294:

  qtest/libqos/pci: Factor msix entry helpers into pci common code (2026-11-02 03:52:53 -0500)

----------------------------------------------------------------
pci: fixes

pcie_sriov: fix for user-creation of VFs replaced by v2
pcie sriov: a couple more robustness improvements
pci: id docs clarified
pci: a bunch of test fixes, robustness

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Clément MATHIEU--DRIF (2):
      pcie_sriov: Rework the assert statements checking region numbers
      pcie_sriov: Adapt bar type array size to the number of regions

Daniel Paziyski (3):
      pci: fix null pointer dereference on pci device registration failure
      pcie_sriov: perform additional checks after pci device realization
      pcie_sriov: fix null pointer dereference when initializing PFs in a system with user and device created VFs

Gerd Hoffmann (2):
      pci id: clarify pci subsystem id usage
      pci id: assign pci subsystem id for osmates

Nicholas Piggin (9):
      tests/qtest: Enforce zero for the "un-fired" msix message value
      tests/qtest: Fix virtio msix message endianness
      tests/qtest: Add libqos function for testing MSI-X interrupt status
      tests/qtest: Enable spapr dma with linear iommu
      tests/qtest/ahci: unmap pci bar before reusing device
      tests/qtest/libquos/pci: Add migration fixup helper for pci devices
      qtest/libqos/pci: Enforce balanced iomap/unmap
      qtest/libqos/pci: Fix qpci_msix_enable sharing bar0
      qtest/libqos/pci: Factor msix entry helpers into pci common code

Utkarsh Verma (1):
      tests/qtest/nvme-test: fix NVMe struct field endianness

 docs/specs/pci-ids.rst                 |   9 +-
 include/hw/pci/pcie_sriov.h            |   4 +-
 tests/qtest/libqos/ahci.h              |   2 +
 tests/qtest/libqos/pci.h               |  21 +++-
 hw/pci/pci.c                           |  11 +-
 hw/pci/pcie_sriov.c                    |  24 +++-
 hw/ppc/spapr_iommu.c                   |  10 +-
 tests/qtest/ahci-test.c                |   7 ++
 tests/qtest/e1000e-test.c              |  21 ----
 tests/qtest/igb-test.c                 |  21 ----
 tests/qtest/libqos/ahci.c              |  12 ++
 tests/qtest/libqos/generic-pcihost.c   |   1 -
 tests/qtest/libqos/pci-pc.c            |   3 -
 tests/qtest/libqos/pci-spapr.c         |   7 +-
 tests/qtest/libqos/pci.c               | 217 +++++++++++++++++++++++++++++----
 tests/qtest/libqos/virtio-pci-modern.c |  30 +----
 tests/qtest/libqos/virtio-pci.c        |  86 +++----------
 tests/qtest/nvme-test.c                |  39 +++---
 tests/qtest/vhost-user-blk-test.c      |   6 -
 tests/qtest/virtio-blk-test.c          |  12 --
 20 files changed, 319 insertions(+), 224 deletions(-)


