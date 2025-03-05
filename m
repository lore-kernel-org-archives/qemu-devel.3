Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DDAC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 17:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpsm6-0004Ab-92; Wed, 05 Mar 2025 12:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpsm3-00042f-0j
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 12:43:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpsm0-0008AC-Lx
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 12:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741196591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fJlvV6Jzg+ipSMnsibP4xOxDrlO2DrjF4Et80X4/LL8=;
 b=C/lVUGOEd7+G0JHNx+LR6SRpoidi2HQoqo3qw5n9931Ohna4gV3jqY6Ul2WqGDpyzyZu1g
 vgN9K5d01Dykv96OgbKXWwsQtbZTWRRyex/PZL5qGBfYoccxFnRXpLoEN1foGsU2K+FzqQ
 k8htPUN4om4IhtjEC4d0HRJNIEV/jbw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-8sF4f7JzPwa2TRHHxZE2sQ-1; Wed, 05 Mar 2025 12:42:55 -0500
X-MC-Unique: 8sF4f7JzPwa2TRHHxZE2sQ-1
X-Mimecast-MFC-AGG-ID: 8sF4f7JzPwa2TRHHxZE2sQ_1741196574
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43947979ce8so28158435e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 09:42:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741196574; x=1741801374;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fJlvV6Jzg+ipSMnsibP4xOxDrlO2DrjF4Et80X4/LL8=;
 b=FWQ5F+J4XpiwJfWRHlUcF79XxWM/reJDtiDIBETTN17IWSzCtvjk6CasF0oatmmYLW
 dGk6W0KE+CwJYrqKtdsgaYrN5dL+4WeSS70QR32MCQu/zt2RB0H1c6MCogT6YZ5yWsDp
 WtGxoB3+eQtMT7ONtfJ/cPXNBMRjVWMSZv6KChTVLCadP0n2KqJh21mOV4BifN1oqFVz
 Jay+ECNcST/a7eTNAuCIsrFY1R7vYwQhMGSE0JUSQ8AgtrWhDyrE6BqHfTjy41zRKrWv
 aG3BpiTuedEVe/dea1sbgF1bxk2YNvYIm/B77QAhB1i8xrlsVRlFpyOHO5/D6jyyA4Cu
 p+Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqifonSukVHcOyRTNMufTTrVTYIaj7TkYylXlA2dYpGPiIL6PMvO4cW+acd7CHsK+J+QtKr7PS68Ui@nongnu.org
X-Gm-Message-State: AOJu0Yz2wKIElMBTLkWmA26mqYuFjcZPs7dntTGdp+Lco4Os/LNZJu8Y
 2kd7+7Avw7cWZoWOjYjvgIp54iMnqvNGxFw5pEP9PJGhtyTgi0BijZnCJIQPxdQS3KoA2JUIQ1A
 I4LYHT83H96kjdM4tVCqi3ARQoSZ7E3HyvYypDIKToNQTu90wpFeG
X-Gm-Gg: ASbGncs49J/19dlhQwiKMuw40gEyRO01jZRtL6+dTy8hmnybJFXxmGacxNORLNjiyAA
 mz+v7+WJnEM1JDCbvP9Ytaj/u2FgafQQTGZw/h+tZ8aLga9aSgjypF+1RJJAKMdlT0EMLe4sfFu
 OJIcAsEK2RQUKlulECtr4hPSGFuwcNnz8InjkpXR5IuK3gQudMmFEAumaiwjUT6wK1Z9JnTfDkz
 rQqZcKziubMFw1cNDA6cMKJNV5nhbb8K/WSSm+k+Cx5uTkQAFKe9xe+tkL7jQyFt5UGJMMsiAaO
 W2EuMubFYvk22rP8X3fmn4mnMdPgYR0KuepyH1tFD7NKG9XUxOwSFA==
X-Received: by 2002:a05:600c:198f:b0:439:9192:f088 with SMTP id
 5b1f17b1804b1-43bd2951b6fmr29288875e9.8.1741196574042; 
 Wed, 05 Mar 2025 09:42:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtMBK8Ts89chepK5au6sSlpR56r88WAyx2MV+XX8fVbwePoniaLLZqy6dWriOHtMlTX2sNWw==
X-Received: by 2002:a05:600c:198f:b0:439:9192:f088 with SMTP id
 5b1f17b1804b1-43bd2951b6fmr29288635e9.8.1741196573583; 
 Wed, 05 Mar 2025 09:42:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42c5dd1sm23696865e9.18.2025.03.05.09.42.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 09:42:53 -0800 (PST)
Message-ID: <91cc7203-abce-4873-8e77-7fbc1ff2467d@redhat.com>
Date: Wed, 5 Mar 2025 18:42:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] PCI: Implement basic PCI PM capability backing
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 zhenzhong.duan@intel.com, mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20250225215237.3314011-1-alex.williamson@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250225215237.3314011-1-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/25/25 22:52, Alex Williamson wrote:
> v2:
> 
> Eric noted in v1 that one of the drivers had a redundant wmask setting
> since pci_pm_init() enabled writes to the power state field.  This was
> added because vfio-pci was not setting wmask for this capability but
> is allowing writes to the PM state field through to the device.  For
> vfio-pci, QEMU emulated config space is rather secondary to the config
> space through vfio.
> 
> It turns out therefore, that vfio-pci is nearly unique in not already
> managing the wmask of the PM capability state and if we embrace that
> it's the pci_pm_init() caller's responsibility to manage the remaining
> contents and write-access of the capability, then I think we also
> solve the question of migration compatibility.  The new infrastructure
> here is not changing whether any fields were previously writable, it's
> only effecting a mapping change based on the value found there.
> 
> This requires only a slight change to patch 1/, removing setting of
> the wmask, but commit log is also updated and comments added.  I also
> made the bad transition trace a little more obvious given Eric's
> comments.  Patch 2/ is also updated so that vfio-pci effects the wmask
> change locally.  The couple drivers that don't currently update wmask
> simply don't get this new BAR unmapped when not in D0 behavior.
> 
> Incorporated reviews for the unmodified patches.  Please re-review and
> report any noted issues.  Thanks,
> 
> Alex
> 
> v1:
> 
> https://lore.kernel.org/all/20250220224918.2520417-1-alex.williamson@redhat.com/
> 
> Eric recently identified an issue[1] where during graceful shutdown
> of a VM in a vIOMMU configuration, the guest driver places the device
> into the D3 power state, the vIOMMU is then disabled, triggering an
> AddressSpace update.  The device BARs are still mapped into the AS,
> but the vfio host driver refuses to DMA map the MMIO space due to the
> device power state.
> 
> The proposed solution in [1] was to skip mappings based on the
> device power state.  Here we take a different approach.  The PCI spec
> defines that devices in D1/2/3 power state should respond only to
> configuration and message requests and all other requests should be
> handled as an Unsupported Request.  In other words, the memory and
> IO BARs are not accessible except when the device is in the D0 power
> state.
> 
> To emulate this behavior, we can factor the device power state into
> the mapping state of the device BARs.  Therefore the BAR is marked
> as unmapped if either the respective command register enable bit is
> clear or the device is not in the D0 power state.
> 
> In order to implement this, the PowerState field of the PMCSR
> register becomes writable, which allows the device to appear in
> lower power states.  This also therefore implements D3 support
> (insofar as the BAR behavior) for all devices implementing the PM
> capability.  The PCI spec requires D3 support.
> 
> An aspect that needs attention here is whether this change in the
> wmask and PMCSR bits becomes a problem for migration, and how we
> might solve it.  For a guest migrating old->new, the device would
> always be in the D0 power state, but the register becomes writable.
> In the opposite direction, is it possible that a device could
> migrate in a low power state and be stuck there since the bits are
> read-only in old QEMU?  Do we need an option for this behavior and a
> machine state bump, or are there alternatives?
> 
> Thanks,
> Alex
> 
> [1]https://lore.kernel.org/all/20250219175941.135390-1-eric.auger@redhat.com/
> 
> 
> Alex Williamson (5):
>    hw/pci: Basic support for PCI power management
>    pci: Use PCI PM capability initializer
>    vfio/pci: Delete local pm_cap
>    pcie, virtio: Remove redundant pm_cap
>    hw/vfio/pci: Re-order pre-reset
> 
>   hw/net/e1000e.c                 |  3 +-
>   hw/net/eepro100.c               |  4 +-
>   hw/net/igb.c                    |  3 +-
>   hw/nvme/ctrl.c                  |  3 +-
>   hw/pci-bridge/pcie_pci_bridge.c |  3 +-
>   hw/pci/pci.c                    | 93 ++++++++++++++++++++++++++++++++-
>   hw/pci/trace-events             |  2 +
>   hw/vfio/pci.c                   | 34 ++++++------
>   hw/vfio/pci.h                   |  1 -
>   hw/virtio/virtio-pci.c          | 11 ++--
>   include/hw/pci/pci.h            |  3 ++
>   include/hw/pci/pci_device.h     |  3 ++
>   include/hw/pci/pcie.h           |  2 -
>   13 files changed, 127 insertions(+), 38 deletions(-)
> 


Applied to vfio-next.

Thanks,

C.



