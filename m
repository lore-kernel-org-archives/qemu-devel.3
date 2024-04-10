Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54671C67861
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 03:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruOCd-0007Wf-De; Tue, 09 Apr 2024 23:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1ruOCb-0007Vz-BI; Tue, 09 Apr 2024 23:00:45 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1ruOCZ-0000wF-CY; Tue, 09 Apr 2024 23:00:45 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-22efc6b8dc5so2485254fac.0; 
 Tue, 09 Apr 2024 20:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712718040; x=1713322840; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7yE75OHeYY2o3De6kqKsS5Sb4EjT8h9PWiWsiDQKW/g=;
 b=ippHVoP9s9u1GfGA0x6MwxX80C9HHxEdQ3CffcJrVKn2oRZERvB7xFXnwSemUtvzQ+
 aJjRVQa41ektleXfrQRWdWQZu3k7a8VgjAAOkk18wVDivxznSio0KAjAADS3TUXeGCid
 SwbXEVZl9RikKzHNZ+8FONjAE2ihEnMhy5H6JCMeuW2KhbsLEoJ7rtL3q9eCGQoui9e2
 xOzNWm9iwRsaxO5goSMeaqn65P+IJLDOjwjm2inuhDHI/s1gd9GHbgWR/WU+FjccFdF+
 VhgycsivkOKKjMc5RH5bHxJANccejqjS6VU4sGZzFlMBpBknSLZXFukekGZsIIB/k2kv
 yIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712718040; x=1713322840;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7yE75OHeYY2o3De6kqKsS5Sb4EjT8h9PWiWsiDQKW/g=;
 b=AHKzgTO9o5iIi3PbmG6kSppmIardAm4KNEvRajN6Yp39JPUEquA8Llyxf3mqBdTsoE
 rhfwZWZiBCTvWP7BHm+kNUjcfmf8BG1Z80TrXIweDCcTZYh/Y9L4h9DcZy73BjoAsWi5
 m619xgiYHLz9pDPUWUpnkqNp6aGF5Hej/hgaacKrtsn6dAySjr0jkNPTDM8VVlEA/Xic
 38cwVmFPbsRBs3J2XhY5k4x39kJKwPp0AxB3nxFqHJe5nORi/0Gi+kcpUOaIeb+oClcu
 qP34XrBU4XBlHN+8j4nZZo60cShifzZLLbwGkCuNRTZy7Ml7ELBSTAZsfJ3S6UqeiVXa
 DVkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLiPnkip8tKmptVKpbU9pi3n6D+lVqlkV0XRLgwf4vlfHQ/TxqPNTZdb/3DPkniO/IsQiKCkOeNXRMrpaNkgCI+1pu+uU=
X-Gm-Message-State: AOJu0YwEP20phSO8vIido5zZSVhn3pDEJzA9IChNaJOsazunsUMgj5E2
 ALuWuU9rAMkKfopjhW8sjayNis5xx9v1Jt4aJ4nwABkNV6qQ4rXJ
X-Google-Smtp-Source: AGHT+IFx/Lc0QaBRp8d9XqtDovYXPLJ/NLSJVYNTXekuO8/kF2MvQUlR3NbCkvPb7kkpzKOperBjBw==
X-Received: by 2002:a05:6870:82a4:b0:22e:ae2f:7a9c with SMTP id
 q36-20020a05687082a400b0022eae2f7a9cmr1499658oae.56.1712718040230; 
 Tue, 09 Apr 2024 20:00:40 -0700 (PDT)
Received: from [172.20.149.24] ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id
 k17-20020aa79d11000000b006e6b959b636sm9060013pfp.53.2024.04.09.20.00.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 20:00:39 -0700 (PDT)
Message-ID: <1311ffa0-785f-3e96-d1c5-395437656184@gmail.com>
Date: Wed, 10 Apr 2024 12:00:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RFC v3 0/6] virtio-net: add support for SR-IOV emulation
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 20240228-reuse-v8-0-282660281e60@daynix.com
References: <20240305-sriov-v3-0-abdb75770372@daynix.com>
From: Yui Washizu <yui.washidu@gmail.com>
In-Reply-To: <20240305-sriov-v3-0-abdb75770372@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=yui.washidu@gmail.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-1.751, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 2024/03/05 17:58, Akihiko Odaki wrote:
> Based-on: <20240228-reuse-v8-0-282660281e60@daynix.com>
> ("[PATCH v8 00/15] hw/pci: SR-IOV related fixes and improvements")
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


QEMU crashed same as RFC v2:

https://lore.kernel.org/all/20231210-sriov-v2-6-b959e8a6dfaf@daynix.com/T/#mb16bdef667a0b0b7c08f487fcd18e8d627694bf6


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
> Patch 2 and 3 adds validations.
> Patch 4 adds user-created SR-IOV VF infrastructure.
> Patch 5 makes virtio-pci work as SR-IOV PF for user-created VFs.
> Patch 6 allows user to create SR-IOV VFs with virtio-net-pci.
>
> [1] https://patchew.org/QEMU/1689731808-3009-1-git-send-email-yui.washidu@gmail.com/
> [2] https://lore.kernel.org/all/5d46f455-f530-4e5e-9ae7-13a2297d4bc5@daynix.com/
>
> Co-developed-by: Yui Washizu <yui.washidu@gmail.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v3:
> - Rebased.
> - Link to v2: https://lore.kernel.org/r/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com
>
> Changes in v2:
> - Changed to keep VF instances.
> - Link to v1: https://lore.kernel.org/r/20231202-sriov-v1-0-32b3570f7bd6@daynix.com
>
> ---
> Akihiko Odaki (6):
>        hw/pci: Do not add ROM BAR for SR-IOV VF
>        pcie_sriov: Ensure PF and VF are mutually exclusive
>        pcie_sriov: Check PCI Express for SR-IOV PF
>        pcie_sriov: Allow user to create SR-IOV device
>        virtio-pci: Implement SR-IOV PF
>        virtio-net: Implement SR-IOV VF
>
>   include/hw/pci/pci_device.h |   6 +-
>   include/hw/pci/pcie_sriov.h |  19 +++
>   hw/pci/pci.c                |  70 +++++++----
>   hw/pci/pcie_sriov.c         | 299 +++++++++++++++++++++++++++++++++++---------
>   hw/virtio/virtio-net-pci.c  |   1 +
>   hw/virtio/virtio-pci.c      |   7 ++
>   6 files changed, 319 insertions(+), 83 deletions(-)
> ---
> base-commit: 2c4eb0476e461b8a4b2f745d25f987e831c7f640
> change-id: 20231202-sriov-9402fb262be8
>
> Best regards,

