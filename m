Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA88606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XXFFKfI5;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OsVqlarJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM4iG-0004oC-Td; Wed, 28 Oct 2026 10:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM4i9-0004nk-KI
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:33:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM4i7-0004PZ-MQ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793197980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BO6pJHKoxi2mheoI+T1aXiON/Om/EHeNoy0tmHMkwE0=;
 b=XXFFKfI5z567ODS/P6gIgot4vOWPfpv7SMNMpWg2UhGdhmbL0HWIOj5nZ1TjhsWVv9JHFA
 hv/gDzwdXzq4PwelGmK8J2cV6XqG2MZN8twU/G4OwVGheu0qkF0Yx2dj/JXmGxlV/Kxw0d
 4PMdhhseC7ShJoGXf8tu4FhWIcGiLc8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-Z18651FVObGodC1xJfJmOg-1; Wed, 28 Oct 2026 10:32:59 -0400
X-MC-Unique: Z18651FVObGodC1xJfJmOg-1
X-Mimecast-MFC-AGG-ID: Z18651FVObGodC1xJfJmOg_1793197978
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48e4d1e29f3so863256f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 07:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793197978; x=1793802778; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BO6pJHKoxi2mheoI+T1aXiON/Om/EHeNoy0tmHMkwE0=;
 b=OsVqlarJRv2/E942aMyuzH6Pmn85ekBodgiWjPGUDJxJrxubC+OZFDZHq2+NBEMOvb
 efSUU713N0jDPzFtS54K6fZNcic+umgthXfqr4X8c7vsLdslDBmSwdH/JKqx5Iu5Kntg
 bFWPdmKY0P9+CI8SiTXxMApxn/pyEqH/XNE737MzNSEZ2CrFLHDxk2+aV4gqOWUZsqqL
 HniswxTaa+ynGi27/s3tXnqdKuDBYU8ATBjQ/EZmEHA31T0YuyA9jSQ3dasnePk3+y9L
 AO56kv5vx4z7NWzVe0Dlb1yu1FLkcgxGaNIHLy47yjvVK06nw8kcYD6jppgEjMkZZQFB
 yWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197978; x=1793802778;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BO6pJHKoxi2mheoI+T1aXiON/Om/EHeNoy0tmHMkwE0=;
 b=xb31Y70cgEnq+RPfsPJ052Dg0m+vZ2a/cIpTMvZcDB89fazOBCuWyr1V+RK1nRHgsR
 /Yh9xwDytCfmir0Klt37byLEyeMCbnJMDNnHDGXyMx/AEFlW0+71tZyOlfQ1TRdGIJE8
 qVuuy5uWS8Wt8d+nFaK0ZM8SUJeuhrjZtEzqsCbAwwjD/MAdMahtWPtH7N4oOekh/d/N
 V2fO1dRfwcJjOt3DhysuatnS2PQ4EGfammMFkGXZwBkpQfRK2iDv99kTwI10V+dwszzY
 O8wDqk6OzI5iStQwMRvMimRhoxKe45j0e0lq7076LT9HIPilqqENE3El9Z1k1mdu8+TA
 fBhw==
X-Gm-Message-State: AFq9FYJR29WgEnk12W6lJ4Vw8f9NheuGwBz7QXqnXlB2Ok8bdeci+g3t
 j6+abOJ5vj+Aiw3H/OHrPiWCOFVAqaznNCkwWo18VmWeNqQn4ryeXUuLbTvE9Q4U+aVwmSG4KLy
 vhf0VO9K+ZB7lcvGLSi3dWRgz38OrddGadbbn8DmQnqAnhGCaVL8JjJRa
X-Gm-Gg: AYBFou05JBEfy0qQSNU+oErlvMJ5uPyoMWK0GgGcueR3mn7k86UF7ozdf757pQX1WR5
 Mzjywj0a2f36/pU45lHI/Wc6vwdqarpNA1Kv/JHHOWGBrhyn+vUo7LAPESDrwMIaqeyjaGfrSYc
 M5mJAYK3vyaCbZD1R5rUaGdcr2hLHTwgA5GAWG/tAGgvylMBIhykOXFzijTtK7n3nxEXML6uDKs
 bpYZ8pRGy3ev1JAwMjF2gqcQdM+8qArfi9p3M0jSt6Xi52tj14L/zyvx82XuimY0eoI488EOCX+
 CrI0243QKOL/qPSwiiv9eHlq5h1PTo32Aim0noTNUR/45IqvE/qsclq2HGKUVQXtTRCCpMe6/oP
 okuc476ToFmQWQuDD96MwPYgE1F0tfZ3OyBk8cozp
X-Received: by 2002:adf:ed50:0:b0:48e:932:af0b with SMTP id
 ffacd0b85a97d-48e5d2f2b1emr5465620f8f.32.1793197977666; 
 Wed, 28 Oct 2026 07:32:57 -0700 (PDT)
X-Received: by 2002:adf:ed50:0:b0:48e:932:af0b with SMTP id
 ffacd0b85a97d-48e5d2f2b1emr5465555f8f.32.1793197977076; 
 Wed, 28 Oct 2026 07:32:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb8e0sm27991288f8f.29.2026.10.28.07.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:32:56 -0700 (PDT)
Date: Wed, 28 Oct 2026 10:32:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jishnu Warrier <jishnuvw@linux.ibm.com>
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, philmd@linaro.org,
 farosas@suse.de, akihiko.odaki@daynix.com,
 marcel.apfelbaum@gmail.com, david@gibson.dropbear.id.au,
 adityag@linux.ibm.com, harshpb@linux.ibm.com, amachhiw@linux.ibm.com
Subject: Re: [PATCH v6 00/10] tests/qtest: pci and MSI-X fixes
Message-ID: <20261028102612-mutt-send-email-mst@kernel.org>
References: <20260817185539.376740-1-jishnuvw@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260817185539.376740-1-jishnuvw@linux.ibm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Aug 18, 2026 at 12:25:30AM +0530, Jishnu Warrier wrote:
> To: qemu-devel@nongnu.org
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: Amit Machhiwal <amachhiw@linux.ibm.com>
> 
> This series fixes a number of issues in the pci and MSI-X qtest
> infrastructure, and adds new functionality.
> 
> Nicholas Piggin is the original author of all patches in this series.
> This submission takes his v5 posting forward, with the additional
> changes described below.
> 
> It was originally posted as v5 in May 2025 but was not merged.


Decided to dig this out and tried applying.

Breaks nvme in CI:
 https://gitlab.com/mstredhat/qemu/-/jobs/17536598571

If you can try rebasing, would be appreciated.

> Changes since v5
> (https://lore.kernel.org/qemu-devel/20250502030446.88310-1-npiggin@gmail.com/):
> 
> - Use sizeof(data) instead of literal 4 in qtest_memread/qtest_memset
>   calls inside qpci_msix_test_interrupt() [Akihiko Odaki]
> 
> - Fix MSI-X capitalisation in the qpci_msix_test_interrupt() doc
>   comment (was "msix", now "MSI-X" throughout) [Akihiko Odaki]
> 
> - Replace the per-device boolean flags (pci_enabled in AHCIQState,
>   enabled in QVirtioPCIDevice) with a bool mapped field on QPCIBar
>   itself. qpci_iounmap() is now a graceful no-op when called on a
>   bar that was never mapped, removing the need for guards in callers.
>   [Akihiko Odaki]
> 
> - Remove missed qpci_check_buggy_msi() guard in nvme-test.c
> 
> - Fix off-by-one bound check: use barno < QPCI_NUM_REGIONS instead of
>   barno <= QPCI_NUM_REGIONS in qpci_bar_reg() and qpci_iomap(); the
>   previous condition allowed barno == 6 which is one past the end of
>   the 6-element array [Amit Machhiwal]
> 
> - Remove redundant memset(&dev->bars_mapped[i], ...) in qpci_iounmap()
>   that immediately followed dev->bars_mapped[i] = false [Amit Machhiwal]
> 
> - Add explanatory comment before the msix_addr/msix_data != 0
>   assertions in qpci_msix_test_interrupt() clarifying that 0 is a
>   libqos-internal sentinel value [Amit Machhiwal]
> 
> - Remove always-true g_assert_cmpint(entry, >=, 0) assertions on
>   uint16_t parameters in qpci_msix_set_entry(), qpci_msix_pending(),
>   qpci_msix_masked(), and qpci_msix_set_masked() [Amit Machhiwal]
> 
> Nicholas Piggin (10):
>   tests/qtest: Enforce zero for the "un-fired" MSI-X message value
>   tests/qtest: Fix virtio MSI-X message endianness
>   tests/qtest: Add libqos function for testing MSI-X interrupt status
>   tests/qtest: Enable spapr dma with linear iommu map
>   tests/qtest/ahci: unmap pci bar before reusing device
>   tests/qtest/ahci: don't unmap pci bar if it wasn't mapped
>   tests/qtest/libquos/pci: Add migration fixup helper for pci devices
>   qtest/libqos/pci: Enforce balanced iomap/unmap
>   qtest/libqos/pci: Fix qpci_msix_enable sharing bar0
>   qtest/libqos/pci: Factor MSI-X entry helpers into pci common code
> 
>  hw/ppc/spapr_iommu.c                   |  10 +-
>  tests/qtest/ahci-test.c                |   8 +
>  tests/qtest/e1000e-test.c              |  21 ---
>  tests/qtest/igb-test.c                 |  21 ---
>  tests/qtest/libqos/ahci.c              |  12 ++
>  tests/qtest/libqos/ahci.h              |   2 +
>  tests/qtest/libqos/generic-pcihost.c   |   1 -
>  tests/qtest/libqos/pci-pc.c            |   3 -
>  tests/qtest/libqos/pci-spapr.c         |   7 +-
>  tests/qtest/libqos/pci.c               | 215 ++++++++++++++++++++++---
>  tests/qtest/libqos/pci.h               |  21 ++-
>  tests/qtest/libqos/virtio-pci-modern.c |  30 +---
>  tests/qtest/libqos/virtio-pci.c        |  86 ++--------
>  tests/qtest/nvme-test.c                |   4 -
>  tests/qtest/vhost-user-blk-test.c      |   6 -
>  tests/qtest/virtio-blk-test.c          |  12 --
>  16 files changed, 262 insertions(+), 197 deletions(-)
> 
> -- 
> 2.55.0


