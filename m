Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3464AC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 18:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdBWt-0004cP-HS; Fri, 26 Jun 2026 14:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wdBWe-0004SM-3t
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:43:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wdBWb-0002y0-Ur
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782499417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/1KCHZo+ieM6pi6c9zEQo9m5LkqNOiRRjLlOENgpzdg=;
 b=hzHjDEcx+TNwYmk1iohHDKQB4KdxF6p+hRumzCMBh/AKry4vpwrpKif7Bg8pd5W7lVYjJn
 OLcfwmHywqiE5GF8rwq5o4CQPCbXFW3TlydyM8RERQLvNlhUb6PKSrPTFeCyL0CDnotdAy
 t+dpWumAkkaSDbsra38k+8QlE9GiyLI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-kEd7KR1hMkeb8AsMyniPtA-1; Fri, 26 Jun 2026 14:43:34 -0400
X-MC-Unique: kEd7KR1hMkeb8AsMyniPtA-1
X-Mimecast-MFC-AGG-ID: kEd7KR1hMkeb8AsMyniPtA_1782499414
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49277e7fc5cso227185e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 11:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782499413; x=1783104213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/1KCHZo+ieM6pi6c9zEQo9m5LkqNOiRRjLlOENgpzdg=;
 b=Lc5N8rXtuRPqHRu+/eHdXiAZ+OPr+eq/bHPcNwhroggyrfc8luw10CrijS7VnEEezh
 XMF+G51l+7i2Z0ZW4KOF4gAeBnfeWRLlITmU2jZDQyUegVdAkjgjvSKTH1Y/eib/0usq
 IGqR17/49LR7HTdjKegGdChohjGfgzV96L2sqHTSo8d4Sxx6pVLNiVDlxuf4TfDZODZ1
 q7kOv0ULC+9mOUKkY+HS2XR0selC370iB8RPZNmbn44Q5M3DpnxmoTtUlWMh5PwG9jI0
 7KmycjfsQR8wGjidUANDrxVgkq4qd5hvWRxtCL5ZwD9i5a4U0Wjs0Jwf/vQG2d48FRyE
 3/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782499413; x=1783104213;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/1KCHZo+ieM6pi6c9zEQo9m5LkqNOiRRjLlOENgpzdg=;
 b=GtacYkkOEoNQW09mqv6OhH2acGpSTLs7jX0eYB35VE/KzfsUO1sh/QrzLiz68NdPJb
 24be8/togatVzepT6+fuQQO0K/slN7VdvR+BrAMeXlDaXCfgN5vP7d24foZlM4wmwKdX
 ceeSbmXsOXqwrpWHXkUkM60jfTCShtQ8JMsqbxqaIIkOT/0q9uXQeFbfsEFg7PuQVRV8
 lrNYu2CS3vorTAInDJ3UBmKLptjSkWsKxML9qlxyoK5ZXrX/OV/CUx8t+hStsvqHULtz
 LOP84gQQH2/cBKVcya9vcyzaFc0Ytesr0OqYJNUmmVKIiIQltCrJs4qlKZjsRK3EPERg
 vgCA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8dT/18Bd1MeQxPdA0WJ6fInJAz9wyuC1mRxOfjqqGHpN0qXZ+HhCvty2054WlbQyCaza8Yeq6e6pOt@nongnu.org
X-Gm-Message-State: AOJu0YzZzW/9Dvm2UIQWlW86ZYaAgw1ZX3cMHCPTv1nUs/hcO+58GgjJ
 tihwBPAMs1PquBItaS5xXZtmVYwYWiC6ko8aOT4nfw0ZThb0ZZFmqeU9qBw+ADsqk9f15Yxi+nB
 wDNJiaVkIrEQJz15S53VV2he0q0iCcPSFH+N+fUFbgrIiTZq8448I1IEC
X-Gm-Gg: AfdE7ckGE/XTzHcaiWOnUn16tsNMKsOWvIlwD068qbQbIbWVGo2QHBZ6fs1r97jbTc4
 tfkX50Y+YZRwQbOwj+RAdElgEkGSsx8Mk4xzO3IOxTJgV7SvF9CWfvFij8yEe1zVkHkm9NRgarv
 /GtQZtky3yO22X+8SFwVnCM5OR5gf6hR1XRRFru0APGZVjwvu1ROAk7P6/d8J+y2SQEp1Hl9u4E
 LrUukyNFsRrEAMhF9Ds7qSvOl/SqPKuDvOsXDWCC3XrsJtXLHtIPRHV8tS7+eE4FtmuxKNwe/lO
 ZmwxINMImv/EkWib1anZ9rSusyELB+lUSkXWGRCt37r+W9V6ZEck4K2G/30pTMCAiyf9l82YrSY
 lkijfICan+TidNFt80uD/oQVuAlOFw3Ui7mHwtlWI/O5PiY36G6pn
X-Received: by 2002:a05:600d:6451:20b0:492:37b7:607a with SMTP id
 5b1f17b1804b1-492668833f3mr96690675e9.31.1782499413449; 
 Fri, 26 Jun 2026 11:43:33 -0700 (PDT)
X-Received: by 2002:a05:600d:6451:20b0:492:37b7:607a with SMTP id
 5b1f17b1804b1-492668833f3mr96690455e9.31.1782499413028; 
 Fri, 26 Jun 2026 11:43:33 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8426:ae00:a924:b4e0:1ee:f5c5?
 ([2a01:cb19:8426:ae00:a924:b4e0:1ee:f5c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46e95f3d71fsm10531746f8f.12.2026.06.26.11.43.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 11:43:32 -0700 (PDT)
Message-ID: <29d69017-6a9e-4d46-a212-068e3ce00dfa@redhat.com>
Date: Fri, 26 Jun 2026 20:43:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] vfio/pci: add vfio-pci ATS control property
To: Nathan Chen <nathanc@nvidia.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Alex Williamson
 <alex@shazbot.org>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260623204943.989903-1-nathanc@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260623204943.989903-1-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/23/26 22:49, Nathan Chen wrote:
> Hi,
> 
> This is a follow-up to the series [0] that adds an ATS control property
> to vfio-pci and wires iommufd support reporting so vfio-pci can decide
> whether to expose the ATS PCIe extended capability to the guest.
> 
> The new vfio-pci property is:
>    ats=on|off|auto (default: auto)
> 
> Behavior:
> - off: always masks ATS from guest view
> - on: requires ATS support; fails realize if kernel reports no ATS
>    support via IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
> - auto: masks ATS only when kernel reports no ATS support via
>          IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
> 
> If the physical device does not have ATS, the ATS cap will not be
> present for the device in the guest, and a warning will be emitted when
> ats is set to on.
> 
> We intentionally omit a legacy ats=on compat override because forcing
> the value to "on" on old machine types can turn a host-kernel capability
> update (IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED) into a new realize-time boot
> failure. So we keep the uniform default ats=auto to preserve bootability
> and follow effective kernel ATS support rather than preserving the old
> behavior of always advertising ATS when available.
> 
> Please note that no linux-headers sync patch is included in this series
> because IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED is already present in
> linux-headers/linux/iommufd.h in the current base.
> 
> Testing:
> Verified ATS capability visibility changes with vfio-pci ats=off/on/auto
> on an NVIDIA Grace system:
> - ats=on + ATS supported by kernel => propagate ATS extended cap to
>    guest view
> - ats=auto + ATS supported by kernel => propagate ATS extended cap to
>    guest view
> - ats=on + hiod_iommufd_support_ats modified to return false (mimic
>    kernel-reported unsupported ATS) => realize failure
> - ats=auto + hiod_iommufd_support_ats modified to return false (mimic
>    kernel-reported unsupported ATS) => ATS masked
> - ats=off => ATS masked
> - ats=on + no ATS support in physical device => warning + no ATS ext cap
> 
> Changes from v3:
> - Move warning for missing kernel ATS support when ats=auto to after
>    checking the presence of host device ATS cap. Only emit the warning
>    about masking ATS cap when ATS cap is present on the host device.
> - Emit warning about no ATS support in physical device only when ats=on
>    instead of both ats=auto and ats=on cases (via ats_needed).
> 
> Changes from v2:
> - Added R-by tags, thanks all!
> - Fixed alignment of two
>    object_class_property_set_description() blocks in vfio_pci_properties[]
> - Removed compat override setting ats=on and added a warning to the case
>    where ats=auto and kernel reports ATS is not supported.
> - Squash patch for warning when ats=on and there is no ATS support in
>    physical device into patch #2
> - Emit warning when ats=auto and no ATS support in physical device
> 
> Changes from v1:
> - Set ats_needed to false by default in
>    vfio_pci_ats_requested_and_supported()
> - Revise log prefix from "vfio" to "vfio-pci" in
>    vfio_pci_ats_requested_and_supported()
> - Squash compat update patch into patch for introducing ats property for
>    bisectibility
> - Revise comments and descriptions for support_ats(),
>    vfio_pci_ats_requested_and_supported(), and vfio_pci_class_init() to
>    be more generic, removing references to
>    IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
> - Emit a warning when ats=on and no ATS support in physical device
> 
> Changes from "Resolve AUTO properties" series:
> - Split into separate patches for support_ats() handler introduction and
>    iommufd implementation, "ats" property addition, and compat property fix
> - Rebase on vfio-next
> - Remove unnecessary includes for hw/vfio/pci.c
> - Rename ats_need to ats_needed for vfio_pci_ats_requested_and_supported()
> - Move the vfio_pci_ats_requested_and_supported() call to
>    vfio_pci_add_capabilities() so we can propagate the Error **, and then pass
>    ats_needed as a new input arg to vfio_add_ext_cap
> - Fix indent error in vfio_add_ext_cap()
> - Break and add a pcie_add_capability() call for the PASID case in
>    vfio_add_ext_cap()
> - Update comment about return value for support_ats()
> 
> Thanks,
> Nathan
> 
> [0] https://lore.kernel.org/qemu-devel/20260623023540.836825-1-nathanc@nvidia.com/
> 
> Nathan Chen (2):
>    iommufd: Introduce handler for device ATS support
>    vfio/pci: Add ats property
> 
>   hw/vfio/pci.h                      |  1 +
>   include/system/host_iommu_device.h |  9 +++
>   backends/iommufd.c                 |  8 +++
>   hw/vfio/pci.c                      | 88 ++++++++++++++++++++++++++++--
>   4 files changed, 102 insertions(+), 4 deletions(-)
> 


Applied to

     https://github.com/legoater/qemu vfio-next

Thanks,

C.


