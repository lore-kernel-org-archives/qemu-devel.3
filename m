Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF69FD3CCA3
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 02:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgDBx-0000Zq-GM; Wed, 14 Jan 2026 21:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1vgDBu-0000K0-T5
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 21:34:30 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1vgDBr-0002jj-1N
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 21:34:29 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-383153e06d1so3408951fa.3
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 18:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768444465; x=1769049265; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XEwI3n+jj47LEe/J2yYJsmC8bzHTTE7rgMyYKiTpSrA=;
 b=oZcYFsUx8jB5q42OTDdi5vNhfvVNWU9DFT4ce3ivG+qp0JI78CLqv9DHtcC9iK5m0C
 QIDSlv4BsIrnpM2CDng9wYbdgFd2qyXo8gUhjdlDS6w83d2okvZbH5IZJ/ae8pZldj45
 CFbr8Xdu2B+puAp+Mjnf7a8FJWGZffmI8fnYoJFzFvrvxQ8fgk6XQzl3bUtidSrSLfP/
 lhLPU5+ohLXEjx1OgO4p+75pRpHhufjrH++s8cPj3KBFzhMQdYEvllF6nikFDLJCpfEo
 4CI8ET5tz1NmAXXHs2tIRm1+zxqcbu9wNIMkqKfGtvrXqHwBt0H/fuST1wabW90HC/wY
 NZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768444465; x=1769049265;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XEwI3n+jj47LEe/J2yYJsmC8bzHTTE7rgMyYKiTpSrA=;
 b=brgswkh4AZXFFO02UBBtQuyYY4oDRORbCvKGZX2SLgv3jm9OqzQVrvR6YhCVxIbg+S
 Igl3DvI9Y2gKkVTDjT3SQYUYO3NWj5c5uRjTPPjKHTLTA5VotPdtxY2MWzm0LnCJ+mpQ
 8Vnf9uozMxnh+gdo38vm2HkaXV6loyTZNg6QxEWDDrhFRbpzu+9WQDzxHKibI/ekx079
 L2v9eyVHxkZ5q1sylOS3bgWrnsPKb9/x3fUk4pfHahwqnmKGj6b1TVGAkERPWhpFuDZm
 SxV7B5ZvRmiDdy8jx22GpDe4KVuJ5c5CGVnbCnQjm0i4yTD02MJ4P1s6DAT2KkNJuG6Y
 aphw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc55yyPyPByAl/cJ4n1zIqfHR4wNCSnuQwPqtyg1S3MVbyw4gTYVElRWczdYiAWvN6YbofT/estJpG@nongnu.org
X-Gm-Message-State: AOJu0Yw0GCy10fyMm2EeqciLrWf6nAV0VbgI1EXLgoal3EmMplyQ2IwR
 Uuv3t9XliLSX7gM7I2TzvI+n+yiuViQdeNUdzcsO/mr1Man4F/fRluDNamwSbAisOcWv0fFBYbU
 zJMWOkwi/4mPtlllolBYQYEBdvXfDu9qlthqNBIoRAQ==
X-Gm-Gg: AY/fxX7KurWuB1QXVk0gwOWRoUByv3WBO4e0VMn7P9TzW77z+lpsz6PzTc7rdYCQfs/
 qVtjHek5bbcBEnws+dOvWK+sTjrHS/6N6FT5iJ8Eh5A6XJr8L8YvJ6lLxxc/ooEzPT9u5ZCZEwD
 vKLl31ECEYhhSNcboy6eWfAq11FhYU0StwBfn/2DJVn6EuSd/NRd1+DKmmq5GWNy5DztMjbNDLi
 M8soXxx+ICFeQdeQCbtYT4zUFEk24NS879wZBS9d39jEnn9juWYlAbBpU5sK4KrmMU/BrA=
X-Received: by 2002:a2e:a98e:0:b0:383:2425:ca9 with SMTP id
 38308e7fff4ca-3836073f894mr15442791fa.20.1768444465177; Wed, 14 Jan 2026
 18:34:25 -0800 (PST)
MIME-Version: 1.0
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
 <20260111195508.106943-34-skolothumtho@nvidia.com>
 <CABQgh9FwSTB8Cp8f1POSBti376ZH3B0e0mLu9FU==p1wVwquGg@mail.gmail.com>
 <CH3PR12MB7548626563C6E67FB802D850AB8FA@CH3PR12MB7548.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB7548626563C6E67FB802D850AB8FA@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 15 Jan 2026 10:34:13 +0800
X-Gm-Features: AZwV_QgtZIyDAV-lHkaiV-7Dyd_AGklw0IDLv6nbjh1wh-g-_sDA7JEaFNPp3i8
Message-ID: <CABQgh9EUMtEO4xdBhZZuD23G0j89PcnSZ_Zjgfja+u=z7xvwEw@mail.gmail.com>
Subject: Re: [PATCH v7 33/36] hw/pci: Add helper to insert PCIe extended
 capability at a fixed offset
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>, 
 "berrange@redhat.com" <berrange@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen <nathanc@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, 
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, 
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, 
 Krishnakant Jaju <kjaju@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=zhangfei.gao@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 14 Jan 2026 at 18:36, Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>
> Hi Zhangfei,
>
> > -----Original Message-----
> > From: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Sent: 14 January 2026 04:18
> > To: Shameer Kolothum <skolothumtho@nvidia.com>
> > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> > eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> > <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; ddutile@redhat.com;
> > berrange@redhat.com; clg@redhat.com; alex@shazbot.org; Nathan Chen
> > <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> > smostafa@google.com; wangzhou1@hisilicon.com;
> > jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> > zhenzhong.duan@intel.com; yi.l.liu@intel.com; Krishnakant Jaju
> > <kjaju@nvidia.com>; Michael S . Tsirkin <mst@redhat.com>
> > Subject: Re: [PATCH v7 33/36] hw/pci: Add helper to insert PCIe extended
> > capability at a fixed offset
> >
> > External email: Use caution opening links or attachments
> >
> >
> > Hi, Shameer
> >
> > On Mon, 12 Jan 2026 at 03:58, Shameer Kolothum
> > <skolothumtho@nvidia.com> wrote:
> > >
> > > Add pcie_insert_capability(), a helper to insert a PCIe extended
> > > capability into an existing extended capability list at a
> > > caller-specified offset.
> > >
> > > Unlike pcie_add_capability(), which always appends a capability to the
> > > end of the list, this helper preserves the existing list ordering
> > > while allowing insertion at an arbitrary offset.
> > >
> > > The helper only validates that the insertion does not overwrite an
> > > existing PCIe extended capability header, since corrupting a header
> > > would break the extended capability linked list. Validation of
> > > overlaps with other configuration space registers or
> > > capability-specific register blocks is left to the caller.
> > >
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> >
> > The guest kernel fails to boot with para "ssidsize=16" with v7 series.
> > Without ssidsize, guest kernel can boot no problem.
>
> Thanks for giving this a spin.
>
> > However, pasid feature requires ssidsize.
> > smmuv3_accel_get_viommu_flags
> > if (s->ssidsize) {
> > flags |= VIOMMU_FLAG_PASID_SUPPORTED;
> >
> > v6 does not has such issue, and does not requires ssidsize param.
>
> As mentioned in cover letter this series has changed the way the overall
> PASID is enabled. It now allows user to specify an offset to place the
> PASID CAP for vfio-pci devices,
>
> -device vfio-pci,host=0018:06:00.0,..,x-vpasid-cap-offset=xxx
>
> If none is specified it will place it at the last offset as default.
>
> And you need "ssidsize" to specify the SMMUv3 sub stream Id bits.
>
> > log:
> > ASSERT_EFI_ERROR (Status = Invalid Parameter) ASSERT [PciBusDxe]
> > /home/linaro/work/edk2/MdeModulePkg/Bus/Pci/PciBusDxe/PciLib.c(626):
> > !(((INTN)(RETURN_STATUS)(Status)) < 0)
>
> It could be that the pcie_insert_capability() helper added here is corrupting
> the config space. Looking at it again, I can see that it is not handling a few
> corner cases.  Could you please replace the pcie_insert_capability() with
> the below and retest.
>
> Thanks,
> Shameer
>
> ...
>
> bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8_t cap_ver,
>                             uint16_t offset, uint16_t size)
> {
>     uint16_t pos = PCI_CONFIG_SPACE_SIZE, prev = 0;
>     uint32_t header;
>
>     assert(offset >= PCI_CONFIG_SPACE_SIZE);
>     assert(offset < (uint16_t)(offset + size));
>     assert((uint16_t)(offset + size) <= PCIE_CONFIG_SPACE_SIZE);
>     assert(size >= 8);
>     assert(pci_is_express(dev));
>
>     header = pci_get_long(dev->config + pos);
>     if (!header) {
>         /* No extended capability, check requested offset is at PCI_CONFIG_SPACE_SIZE*/
>         if (offset != pos) {
>             return false;
>         }
>         pci_set_long(dev->config + pos, PCI_EXT_CAP(cap_id, cap_ver, 0));
>         goto out;
>     }
>
>     while (header && pos && offset >= pos) {
>         uint16_t next = PCI_EXT_CAP_NEXT(header);
>
>         /* Reject insertion inside an existing ECAP header (4 bytes) */
>         if (offset < pos + PCI_EXT_CAP_ALIGN) {
>             return false;
>         }
>
>         prev = pos;
>         pos = next;
>         header = pos ? pci_get_long(dev->config + pos) : 0;
>     }
>
>     pci_set_long(dev->config + offset, PCI_EXT_CAP(cap_id, cap_ver, pos));
>     if (prev) {
>         pcie_ext_cap_set_next(dev, prev, offset);
>     }
>
> out:
>     /* Make capability read-only by default */
>     memset(dev->wmask + offset, 0, size);
>     memset(dev->w1cmask + offset, 0, size);
>     /* Check capability by default */
>     memset(dev->cmask + offset, 0xFF, size);
>     return true;
> }

Yes, this works

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>

