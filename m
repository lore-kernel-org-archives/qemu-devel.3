Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C20C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 10:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgiQ7-0002O3-Tc; Wed, 21 Aug 2024 06:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1sgiQ3-0002HY-QN; Wed, 21 Aug 2024 06:18:25 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1sgiQ1-0004KN-4z; Wed, 21 Aug 2024 06:18:23 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-714186ce2f2so1105316b3a.0; 
 Wed, 21 Aug 2024 03:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724235498; x=1724840298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QXre87V6dW4MjCwTivGblqjyuvQjV8pjZqbL7toTXcg=;
 b=VywEK1fuMUfZehJ48+kfyi79+EHMW+L5TeU5XD7/az2xXGej8wVsCtnSeSIuRF4Lg0
 LMmW/6SZv62SdAVMVXiyyrHuD9F/68tuiK54mOHt6oRWjidYyAJInLxX+N2EIKaYTogB
 hdrCAVUAeE6q5wuhjxf9fHBRA6It3gFkWrg9jFQ8+jFhbYPryhNsKJkjPVr5EmiTE9GE
 S5WYltm6Sbcuhj/fox/OEf3RqM+56gmYFJXMUN7df87Pr9+3lV5mXbdTvf2irX1PukMg
 ZFO9Go/ECXygmp8R4lc9P8OP++vaURbgDZMXmNnQjhFVeHDnS08If1xaWk6Cah7xcCvD
 1lIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724235498; x=1724840298;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QXre87V6dW4MjCwTivGblqjyuvQjV8pjZqbL7toTXcg=;
 b=kBw3WxgtaLui66m8Ca8gfaapLov+GC88z6z3O8wjZKVm8//2AdcoqrMJC8G/MzdkjB
 8n0Qhapvy5l2AbhAYVlHwh22yYZ1WSm5PE/XWjeBQim7i7qFKp2bIMxF+3BHHR/VZeeZ
 f8EgL7coGzyqHSuORT9pgDa4UClH3iROayVscyGYj2cHR+mlhJjFAU+YI7fCthaLiRCV
 IxFLXS2e8q0ThC4wYo7ml8HaY5pu8PU14SkRFR7K58y/OVQwpJeevpDfuNSgx8UGDBxw
 AKMwou9TJf2TSMT1r2xbzRYNteRtbdrhmDa05Dux1IJulEOKOdKxXbiYDw8TXxfUX3PX
 jdPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmRKe2Z8wpgmvWzOv9slvjvjvfRBz46wcon/9D5zcppEqLn8Gljqz2EyPvDKxwLractNBtuP1F273l@nongnu.org
X-Gm-Message-State: AOJu0Yy7Tmk3sYIOzOo9DSWoFLb9HAe/HDYnhAbDnn1r8khDLYhCINvu
 9QJlXWc39dXm/F6qZk5WBsQgd147/O10EZpXn9SDAtU3iXbLoHUp
X-Google-Smtp-Source: AGHT+IFdUQ7UEwIpoqc/2mGJ6n5/muQJCVcmJOxtidnTFLF7t97Tty6t6xXOG6Bb2J/VaLLulHr23Q==
X-Received: by 2002:a05:6a21:1805:b0:1be:c3c1:7be8 with SMTP id
 adf61e73a8af0-1cada091543mr1655530637.26.1724235498195; 
 Wed, 21 Aug 2024 03:18:18 -0700 (PDT)
Received: from [172.20.149.24] ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d5eb8d11desm1371743a91.12.2024.08.21.03.18.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 03:18:17 -0700 (PDT)
Message-ID: <fb23e042-4daf-478f-afae-501b7b2aa3b6@gmail.com>
Date: Wed, 21 Aug 2024 19:18:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v7 0/9] virtio-net: add support for SR-IOV
 emulation
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240813-sriov-v7-0-8515e3774df7@daynix.com>
Content-Language: en-US
From: Yui Washizu <yui.washidu@gmail.com>
In-Reply-To: <20240813-sriov-v7-0-8515e3774df7@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=yui.washidu@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 2024/08/13 15:36, Akihiko Odaki wrote:
> Based-on: <20240802-reuse-v11-0-fb83bb8c19fb@daynix.com>
> ("[PATCH for-9.2 v11 00/11] hw/pci: SR-IOV related fixes and improvements")

I couldn't apply this patch series
after applying "[PATCH for-9.2 v11 00/11] hw/pci: SR-IOV related fixes 
and improvements".


Regards,

Yui Washizu


>
> Introduction
> ------------
>
> This series is based on the RFC series submitted by Yui Washizu[1].
> See also [2] for the context.
>
> This series enables SR-IOV emulation for virtio-net. It is useful
> to test SR-IOV support on the guest, or to expose several vDPA devices
> in a VM. vDPA devices can also provide L2 switching feature for
> offloading though it is out of scope to allow the guest to configure
> such a feature.
>
> The PF side code resides in virtio-pci. The VF side code resides in
> the PCI common infrastructure, but it is restricted to work only for
> virtio-net-pci because of lack of validation.
>
> User Interface
> --------------
>
> A user can configure a SR-IOV capable virtio-net device by adding
> virtio-net-pci functions to a bus. Below is a command line example:
>    -netdev user,id=n -netdev user,id=o
>    -netdev user,id=p -netdev user,id=q
>    -device pcie-root-port,id=b
>    -device virtio-net-pci,bus=b,addr=0x0.0x3,netdev=q,sriov-pf=f
>    -device virtio-net-pci,bus=b,addr=0x0.0x2,netdev=p,sriov-pf=f
>    -device virtio-net-pci,bus=b,addr=0x0.0x1,netdev=o,sriov-pf=f
>    -device virtio-net-pci,bus=b,addr=0x0.0x0,netdev=n,id=f
>
> The VFs specify the paired PF with "sriov-pf" property. The PF must be
> added after all VFs. It is user's responsibility to ensure that VFs have
> function numbers larger than one of the PF, and the function numbers
> have a consistent stride.
>
> Keeping VF instances
> --------------------
>
> A problem with SR-IOV emulation is that it needs to hotplug the VFs as
> the guest requests. Previously, this behavior was implemented by
> realizing and unrealizing VFs at runtime. However, this strategy does
> not work well for the proposed virtio-net emulation; in this proposal,
> device options passed in the command line must be maintained as VFs
> are hotplugged, but they are consumed when the machine starts and not
> available after that, which makes realizing VFs at runtime impossible.
>
> As an strategy alternative to runtime realization/unrealization, this
> series proposes to reuse the code to power down PCI Express devices.
> When a PCI Express device is powered down, it will be hidden from the
> guest but will be kept realized. This effectively implements the
> behavior we need for the SR-IOV emulation.
>
> Summary
> -------
>
> Patch 1 disables ROM BAR, which virtio-net-pci enables by default, for
> VFs.
> Patch 2 makes zero stride valid for 1 VF configuration.
> Patch 3 and 4 adds validations.
> Patch 5 adds user-created SR-IOV VF infrastructure.
> Patch 6 makes virtio-pci work as SR-IOV PF for user-created VFs.
> Patch 7 allows user to create SR-IOV VFs with virtio-net-pci.
>
> [1] https://patchew.org/QEMU/1689731808-3009-1-git-send-email-yui.washidu@gmail.com/
> [2] https://lore.kernel.org/all/5d46f455-f530-4e5e-9ae7-13a2297d4bc5@daynix.com/
>
> Co-developed-by: Yui Washizu <yui.washidu@gmail.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v7:
> - Removed #include <error-report.h>, which is no longer needed.
> - Rebased.
> - Link to v6: https://lore.kernel.org/r/20240802-sriov-v6-0-0c8ff49c4276@daynix.com
>
> Changes in v6:
> - Added ARI extended capability.
> - Rebased.
> - Link to v5: https://lore.kernel.org/r/20240715-sriov-v5-0-3f5539093ffc@daynix.com
>
> Changes in v5:
> - Dropped the RFC tag.
> - Fixed device unrealization.
> - Rebased.
> - Link to v4: https://lore.kernel.org/r/20240428-sriov-v4-0-ac8ac6212982@daynix.com
>
> Changes in v4:
> - Added patch "hw/pci: Fix SR-IOV VF number calculation" to fix division
>    by zero reported by Yui Washizu.
> - Rebased.
> - Link to v3: https://lore.kernel.org/r/20240305-sriov-v3-0-abdb75770372@daynix.com
>
> Changes in v3:
> - Rebased.
> - Link to v2: https://lore.kernel.org/r/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com
>
> Changes in v2:
> - Changed to keep VF instances.
> - Link to v1: https://lore.kernel.org/r/20231202-sriov-v1-0-32b3570f7bd6@daynix.com
>
> ---
> Akihiko Odaki (9):
>        hw/pci: Do not add ROM BAR for SR-IOV VF
>        hw/pci: Fix SR-IOV VF number calculation
>        pcie_sriov: Ensure PF and VF are mutually exclusive
>        pcie_sriov: Check PCI Express for SR-IOV PF
>        pcie_sriov: Allow user to create SR-IOV device
>        virtio-pci: Implement SR-IOV PF
>        virtio-net: Implement SR-IOV VF
>        docs: Document composable SR-IOV device
>        pcie_sriov: Make a PCI device with user-created VF ARI-capable
>
>   MAINTAINERS                    |   1 +
>   docs/system/index.rst          |   1 +
>   docs/system/sriov.rst          |  37 ++++++
>   include/hw/pci/pci_device.h    |   6 +-
>   include/hw/pci/pcie_sriov.h    |  21 +++
>   include/hw/virtio/virtio-pci.h |   1 +
>   hw/pci/pci.c                   |  76 +++++++----
>   hw/pci/pcie_sriov.c            | 295 +++++++++++++++++++++++++++++++++--------
>   hw/virtio/virtio-net-pci.c     |   1 +
>   hw/virtio/virtio-pci.c         |  24 +++-
>   10 files changed, 378 insertions(+), 85 deletions(-)
> ---
> base-commit: f5cebc77fe020e6ca0c33d8e06cd36edf3ff1d4c
> change-id: 20231202-sriov-9402fb262be8
>
> Best regards,

