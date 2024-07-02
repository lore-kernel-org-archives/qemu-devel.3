Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9383BC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 15:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOfRD-0004t4-9w; Tue, 02 Jul 2024 11:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOfRC-0004sk-4z
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:28:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOfR9-0001zH-Uu
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719934135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MvJCpjClK9+6sgJ6euP8sx3+q2MufAr6TXeVQ1ajVIQ=;
 b=byYXpRcCbfw0/oNjitUn/HAXtF0t28udBrkrx6wIMtOaCS4Aw8CAQfJEgZQ+OaBjD/jtgO
 f5LzFjyQg+OKqPEJ3EFnizQrJHzJZmiy7v5oBpN9BABeuqIMKqTRXXoEB+uCZMsTb9iRw8
 tO9VBrlwcaVFFJdvXMTw2Mrut/wMCEw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-sCNiccUeMTqVhNpG3iqxFg-1; Tue, 02 Jul 2024 11:28:52 -0400
X-MC-Unique: sCNiccUeMTqVhNpG3iqxFg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ec617a3355so43008281fa.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 08:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719934130; x=1720538930;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MvJCpjClK9+6sgJ6euP8sx3+q2MufAr6TXeVQ1ajVIQ=;
 b=LL3wJvrWS53SJG7scwGEzI3v4BGU1U6VxUZxuZMssVJqEfkW5P1gukZYRsvbmnW/Jb
 C6d4DCl24ErX1XcnWe/ui51nhtNajU9mje7+nd906rf2Krd2a+5GFOdqMHTxUjm0fVPL
 Gx/6b17czQ7cchp4P2UXxvPz/jtIRZnOy9FB8GMabTp6BLvrs9uGFKRP4TfujRaJ6BDO
 +I203Faj/yF4FWxQ4mW0YOhyK9Ao88XUirtEYcnt4dUnXHCmaFYxjhpdrGtEjVzAP0Cy
 6mMV2WqSUICHxEeVyfn8VnG7lV6+bJ3I1Sf5yxuXXZiI9BcTa6SgNx27Yuzcv9P8DmER
 19ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1kNrvxVq632zZa8/ccibMomNWOFOt0Dlv3QZeL3dMrk/0Iz5rBQ7+TUt3ItIVmQIbkT3O2siNCLniLocmhnRhEiWtgqg=
X-Gm-Message-State: AOJu0YyQJbz11DSxxYcOXsgpKRd5O5209KJGYhk28DhVd/tuQCJBEBWV
 zxdWXl+RtwAWQpaioqS84VRx1YsH+IgJGnGfEDMwjGJH30HRa1udgMrfgWYQrjpnIzqhFipQP+8
 6H8+Q26tndw83iZauaGbpnFJJ59k8GxbgXcZWve4hiTyEw2cfEkvS
X-Received: by 2002:a2e:a813:0:b0:2ee:7a3e:4728 with SMTP id
 38308e7fff4ca-2ee7a3e48d9mr7438851fa.53.1719934130489; 
 Tue, 02 Jul 2024 08:28:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO8+dfuTwG1HQFlgaAK8NgjC3BGLBZ6pn/h0PnofuYfRPJWBXOQYhY/McBAqSJ3hn6O4c+Wg==
X-Received: by 2002:a2e:a813:0:b0:2ee:7a3e:4728 with SMTP id
 38308e7fff4ca-2ee7a3e48d9mr7438611fa.53.1719934129795; 
 Tue, 02 Jul 2024 08:28:49 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257d0d38bbsm119417465e9.38.2024.07.02.08.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 08:28:49 -0700 (PDT)
Date: Tue, 2 Jul 2024 11:28:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH ats_vtd v5 00/22] ATS support for VT-d
Message-ID: <20240702112821-mutt-send-email-mst@kernel.org>
References: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
 <20240701160122-mutt-send-email-mst@kernel.org>
 <AM8PR07MB76020A044539A40485F91F0A86DC2@AM8PR07MB7602.eurprd07.prod.outlook.com>
 <20240702081352-mutt-send-email-mst@kernel.org>
 <52efc1b0-5451-4e9e-a05d-4db360d3c573@intel.com>
 <5894d125-0365-4f1a-91f3-0dbb56c4e4cc@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5894d125-0365-4f1a-91f3-0dbb56c4e4cc@eviden.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Jul 02, 2024 at 03:27:13PM +0000, CLEMENT MATHIEU--DRIF wrote:
> 
> On 02/07/2024 15:42, Yi Liu wrote:
> > Caution: External email. Do not open attachments or click links,
> > unless this email comes from a known sender and you know the content
> > is safe.
> >
> >
> > On 2024/7/2 20:15, Michael S. Tsirkin wrote:
> >> On Tue, Jul 02, 2024 at 05:57:57AM +0000, CLEMENT MATHIEU--DRIF wrote:
> >>>
> >>>
> >>> ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> >>>
> >>> From: Michael S. Tsirkin <mst@redhat.com>
> >>> Sent: 01 July 2024 22:02
> >>> To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
> >>> Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; jasowang@redhat.com
> >>> <jasowang@redhat.com>; zhenzhong.duan@intel.com
> >>> <zhenzhong.duan@intel.com>;
> >>> kevin.tian@intel.com <kevin.tian@intel.com>; yi.l.liu@intel.com
> >>> <yi.l.liu@intel.com>; joao.m.martins@oracle.com
> >>> <joao.m.martins@oracle.com>;
> >>> peterx@redhat.com <peterx@redhat.com>
> >>> Subject: Re: [PATCH ats_vtd v5 00/22] ATS support for VT-d
> >>>
> >>> Caution: External email. Do not open attachments or click links,
> >>> unless this
> >>> email comes from a known sender and you know the content is safe.
> >>>
> >>>
> >>> On Mon, Jun 03, 2024 at 05:59:38AM +0000, CLEMENT MATHIEU--DRIF wrote:
> >>>> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> >>>>
> >>>> This series belongs to a list of series that add SVM support for VT-d.
> >>>>
> >>>> As a starting point, we use the series called 'intel_iommu: Enable
> >>>> stage-1
> >>> translation' (rfc2) by Zhenzhong Duan and Yi Liu.
> >>>>
> >>>> Here we focus on the implementation of ATS support in the IOMMU and
> >>>> on a
> >>> PCI-level
> >>>> API for ATS to be used by virtual devices.
> >>>>
> >>>> This work is based on the VT-d specification version 4.1 (March 2023).
> >>>> Here is a link to a GitHub repository where you can find the following
> >>> elements :
> >>>>      - Qemu with all the patches for SVM
> >>>>          - ATS
> >>>>          - PRI
> >>>>          - Device IOTLB invalidations
> >>>>          - Requests with already translated addresses
> >>>>      - A demo device
> >>>>      - A simple driver for the demo device
> >>>>      - A userspace program (for testing and demonstration purposes)
> >>>>
> >>>> https://eur06.safelinks.protection.outlook.com/?url=
> >>> https%3A%2F%2Fgithub.com%2FBullSequana%2FQemu-in-guest-SVM-demo&data=
> >>> 05%7C02%7Cclement.mathieu--drif%40eviden.com%7Cf5759aefcc5f4e7d4e6c08dc9a08d29a%7C7d1c77852d8a437db8421ed5d8fbe00a%7C0%7C0%7C638554609882544195%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C
> >>>
> >>> &sdata=2Gza1VD7hKr1Sx3fOLoRh6tk3taSPKTn5nfimhPLz70%3D&reserved=0
> >>>
> >>> I will merge, but could you please resend this using git format-patch
> >>> for formatting?  The patches have trailing CRs and don't show which
> >>> sha1
> >>> they are for, which makes re-applying them after each change painful.
> >>>
> >>>
> >>>
> >>> Hi Michael,
> >>> I sent the series again without the trailing new line.
> >>> Tell me if it's better.
> >>>
> >>> Is Zhenzhong's FLTS series merged? If not, it might the cause of the
> >>> sha1
> >>> problem you are facing
> >>
> >> I don't think I have FLTS in any queue.
> >>
> >> If your series has a dependency please specify this in
> >> the cover letter.
> >>
> >> Alternatively just include the dependency in the posting.
> >
> > seems this is the dependency.
> >
> > https://lore.kernel.org/qemu-devel/20240522062313.453317-1-zhenzhong.duan@intel.com/#t
> >
> >
> Sorry if I didn't make it clear.
> 
> As mentioned in the cover letter, this series is based on Zhenzhong's
> and Yi's FLTS implementation which (AFAIK) has only be posted as an RFC
> so far (keep me up to date please).
> 
> v5 is based on that branch :
> https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_rfcv2

Ah, OK so this is not for merge yet until that patchset is ready.


> >>
> >>
> >>
> >>
> >>> Thanks
> >>>> cmd
> >>>
> >>>
> >>>> v2
> >>>>      - handle huge pages better by detecting the page table level
> >>>> at which the
> >>> translation errors occur
> >>>>      - Changes after review by ZhenZhong Duan :
> >>>>        - Set the access bit after checking permissions
> >>>>        - helper for PASID and ATS : make the commit message more
> >>>> accurate
> >>> ('present' replaced with 'enabled')
> >>>>        - pcie_pasid_init: add PCI_PASID_CAP_WIDTH_SHIFT and use it
> >>>> instead of
> >>> PCI_EXT_CAP_PASID_SIZEOF for shifting the pasid width when preparing
> >>> the
> >>> capability register
> >>>>        - pci: do not check pci_bus_bypass_iommu after calling
> >>> pci_device_get_iommu_bus_devfn
> >>>>        - do not alter formatting of IOMMUTLBEntry declaration
> >>>>        - vtd_iova_fl_check_canonical : directly use s->aw_bits
> >>>> instead of aw
> >>> for the sake of clarity
> >>>>
> >>>> v3
> >>>>      - rebase on new version of Zhenzhong's flts implementation
> >>>>      - fix the atc lookup operation (check the mask before
> >>>> returning an entry)
> >>>>      - add a unit test for the ATC
> >>>>      - store a user pointer in the iommu notifiers to simplify the
> >>> implementation of svm devices
> >>>>      Changes after review by Zhenzhong :
> >>>>        - store the input pasid instead of rid2pasid when returning
> >>>> an entry
> >>> after a translation
> >>>>        - split the ATC implementation and its unit tests
> >>>>
> >>>> v4
> >>>>      Changes after internal review
> >>>>        - Fix the nowrite optimization, an ATS translation without
> >>>> the nowrite
> >>> flag should not fail when the write permission is not set
> >>>>
> >>>> v5
> >>>>      Changes after review by Philippe :
> >>>>        - change the type of 'level' to unsigned in vtd_lookup_iotlb
> >>>>
> >>>>
> >>>>
> >>>> Clément Mathieu--Drif (22):
> >>>>    intel_iommu: fix FRCD construction macro.
> >>>>    intel_iommu: make types match
> >>>>    intel_iommu: return page walk level even when the translation fails
> >>>>    intel_iommu: do not consider wait_desc as an invalid descriptor
> >>>>    memory: add permissions in IOMMUAccessFlags
> >>>>    pcie: add helper to declare PASID capability for a pcie device
> >>>>    pcie: helper functions to check if PASID and ATS are enabled
> >>>>    intel_iommu: declare supported PASID size
> >>>>    pci: cache the bus mastering status in the device
> >>>>    pci: add IOMMU operations to get address spaces and memory regions
> >>>>      with PASID
> >>>>    memory: store user data pointer in the IOMMU notifiers
> >>>>    pci: add a pci-level initialization function for iommu notifiers
> >>>>    intel_iommu: implement the get_address_space_pasid iommu operation
> >>>>    intel_iommu: implement the get_memory_region_pasid iommu operation
> >>>>    memory: Allow to store the PASID in IOMMUTLBEntry
> >>>>    intel_iommu: fill the PASID field when creating an instance of
> >>>>      IOMMUTLBEntry
> >>>>    atc: generic ATC that can be used by PCIe devices that support SVM
> >>>>    atc: add unit tests
> >>>>    memory: add an API for ATS support
> >>>>    pci: add a pci-level API for ATS
> >>>>    intel_iommu: set the address mask even when a translation fails
> >>>>    intel_iommu: add support for ATS
> >>>>
> >>>>   hw/i386/intel_iommu.c                     | 142 +++++-
> >>>>   hw/i386/intel_iommu_internal.h            |   6 +-
> >>>>   hw/pci/pci.c                              | 127 +++++-
> >>>>   hw/pci/pcie.c                             |  42 ++
> >>>>   include/exec/memory.h                     |  51 ++-
> >>>>   include/hw/i386/intel_iommu.h             |   2 +-
> >>>>   include/hw/pci/pci.h                      | 101 +++++
> >>>>   include/hw/pci/pci_device.h               |   1 +
> >>>>   include/hw/pci/pcie.h                     |   9 +-
> >>>>   include/hw/pci/pcie_regs.h                |   3 +
> >>>>   include/standard-headers/linux/pci_regs.h |   1 +
> >>>>   system/memory.c                           |  20 +
> >>>>   tests/unit/meson.build                    |   1 +
> >>>>   tests/unit/test-atc.c                     | 527
> >>>> ++++++++++++++++++++++
> >>>>   util/atc.c                                | 211 +++++++++
> >>>>   util/atc.h                                | 117 +++++
> >>>>   util/meson.build                          |   1 +
> >>>>   17 files changed, 1330 insertions(+), 32 deletions(-)
> >>>>   create mode 100644 tests/unit/test-atc.c
> >>>>   create mode 100644 util/atc.c
> >>>>   create mode 100644 util/atc.h
> >>>>
> >>>> --
> >>>> 2.45.1
> >>>
> >>
> >
> > --
> > Regards,
> > Yi Liu


