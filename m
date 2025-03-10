Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8F1C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 13:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trdLE-0003vW-Ds; Mon, 10 Mar 2025 09:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trdLB-0003kK-8m
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:38:45 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trdL7-000875-UB
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:38:44 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43bc63876f1so36173045e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 06:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741613918; x=1742218718; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fI8Ir2Zu1z7LkL/zkdFv81XeyawLXZhGTuauzkxQWC0=;
 b=rLxH4vbZFLDihk+ZtMR6BlmHm9Pf/hGjlO3LGpuovBsCGMvXnhEUXBo8mf4ZZADCBp
 L332gs/Kik5kqJdamJTAMbqbZwvVI0pkW5nIkM6nGPUIu9u4eCRKHiHuucyo+yDguHkm
 zwHhOgv7U46NWupV+8KOhgYcx4XKT4Qnoz268fo1aIXXM79LGk71nJnxdMixk3qLMWHZ
 uE6s7hyBklmfYavMrNDgmTW08/ZeStIL/iwgv6yu53PdxL2xap/WnEvqpptBRde8raIP
 4kjHGhtYvoT4FmrEIYNoFlmeO4s5Sq2UGfZTes9tnulM2KsxhVl1kwzx5OG+itMWrc2c
 +OTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741613918; x=1742218718;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fI8Ir2Zu1z7LkL/zkdFv81XeyawLXZhGTuauzkxQWC0=;
 b=sjL1YsGcU1BMrv6kQUozoPM6I0owuNKqrjCcQehhW/IIERobR0WSXlJdVfAnexR8gR
 xx6Vk+bohgloCBhU15gZltOntuhdHocAp9m4GEsNNiVJ+DdB5ke9q0rCNTWvhEy6gJeg
 70YMC3ab2ECRYFX8ReN9YmjsSe9pamGyKYdGhjex3Z/HHp58ADF0avEajOy33EqBYdvh
 qwhOcH5Y/Nw7uJzJQPQNdeHwSrDywX7fUK/YX3lf4Y5f0tP2xnL/gFLPeD+G8oMOdzz7
 ZWpb+NUPsfmjBj8C7dh0C52cDtb+9BWifgUrlLLooTTXv1DPN3SA5wKT/YglXzbGB18z
 aadA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuV82Qhc2tdA5WdUtp/i1C6MDabtgzYhD9L6VFve0BUE0rI9pcQy6a3GnWbzU5Q6lqN18eMpgMMtYN@nongnu.org
X-Gm-Message-State: AOJu0YwHaNJRodi5jFLoFZ2Pkicuug/yMEtbpDIFROQFylgx6G/PxHKo
 lYFCCj2jM6aQ68S2IJYa8+sIblDfdcpIEQTZemA0TTsXVL+/MinZo9N+e7AP+Ho=
X-Gm-Gg: ASbGncuNbgnm1M1kD3uiMb3qOvnh1SpzMmBzHahJ5JLuvNY3e0xFR1x3MvVnG4UEQtc
 LF3eB3ZC5j7I6g783MeqcgWEVHj01H5Pph5EjMQn2cNu/9KLxlwGemwjEpmPCnShVHY9zJS42tG
 Oh80s49Th7bpm/6F4LHCimHDTZBNuCuJ3fzVA48k7Z8sxdfJsZMPjXT+gHitob5nI68v1HLbOOd
 Fk3is7teimy6ujBnrxwP6tNpZfttsRPkH5Dx92dTrrYRwGHzKdzy+gJ0CivXL/fWhQy65QoHdzE
 xor0EMid91zYCkGN41qBWYWn/RzZasaW/UgrCy1z5GVBnaHU1iWTmD67R25tvjxJwMgkWet/0YN
 JeOzP9SucozVTG+hmMKLD29E=
X-Google-Smtp-Source: AGHT+IFI1n3NuoI/n8U8/SXHlifSn7tQ/FUgR7JfVMlIX6tnbG1hMXfpyjk+3Tr3iEzmpdh1YIRDsg==
X-Received: by 2002:a05:6000:402a:b0:391:2dea:c9a5 with SMTP id
 ffacd0b85a97d-39132d6b61cmr8799479f8f.20.1741613917931; 
 Mon, 10 Mar 2025 06:38:37 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01cb82sm15420203f8f.51.2025.03.10.06.38.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 06:38:37 -0700 (PDT)
Message-ID: <f76f27e7-730e-4bd9-8a91-7b329aa1249f@linaro.org>
Date: Mon, 10 Mar 2025 14:38:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/21] hw/vfio: Build various objects once
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Tomita Moeko
 <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
 <ef7dcee1-90fe-44be-aa14-6c016d98369f@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ef7dcee1-90fe-44be-aa14-6c016d98369f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/3/25 09:03, Cédric Le Goater wrote:
> On 3/9/25 00:08, Philippe Mathieu-Daudé wrote:
>> By doing the following changes:
>> - Clean some headers up
>> - Replace compile-time CONFIG_KVM check by kvm_enabled()
>> - Replace compile-time CONFIG_IOMMUFD check by iommufd_builtin()
>> we can build less vfio objects.
>>
>> Since v1:
>> - Added R-b tags
>> - Introduce type_is_registered()
>> - Split builtin check VS meson changes (rth)
>> - Consider IGD
>>
>> Philippe Mathieu-Daudé (21):
>>    hw/vfio/common: Include missing 'system/tcg.h' header
>>    hw/vfio/spapr: Do not include <linux/kvm.h>
>>    hw/vfio: Compile some common objects once
>>    hw/vfio: Compile more objects once
>>    hw/vfio: Compile iommufd.c once
>>    system: Declare qemu_[min/max]rampagesize() in 'system/hostmem.h'
>>    hw/vfio: Compile display.c once
>>    system/kvm: Expose kvm_irqchip_[add,remove]_change_notifier()
>>    hw/vfio/pci: Convert CONFIG_KVM check to runtime one
>>    qom: Introduce type_is_registered()
>>    hw/vfio/igd: Define TYPE_VFIO_PCI_IGD_LPC_BRIDGE
>>    hw/vfio/igd: Check CONFIG_VFIO_IGD at runtime using vfio_igd_builtin()
>>    hw/vfio/igd: Compile once
>>    system/iommufd: Introduce iommufd_builtin() helper
>>    hw/vfio/pci: Check CONFIG_IOMMUFD at runtime using iommufd_builtin()
>>    hw/vfio/pci: Compile once
>>    hw/vfio/ap: Check CONFIG_IOMMUFD at runtime using iommufd_builtin()
>>    hw/vfio/ccw: Check CONFIG_IOMMUFD at runtime using iommufd_builtin()
>>    hw/vfio/s390x: Compile AP and CCW once
>>    hw/vfio/platform: Check CONFIG_IOMMUFD at runtime using
>>      iommufd_builtin
>>    hw/vfio/platform: Compile once
>>
>>   docs/devel/vfio-iommufd.rst  |  2 +-
>>   hw/vfio/pci-quirks.h         |  8 +++++
>>   include/exec/ram_addr.h      |  3 --
>>   include/qom/object.h         |  8 +++++
>>   include/system/hostmem.h     |  3 ++
>>   include/system/iommufd.h     |  6 ++++
>>   include/system/kvm.h         |  8 ++---
>>   target/s390x/kvm/kvm_s390x.h |  2 +-
>>   hw/ppc/spapr_caps.c          |  1 +
>>   hw/s390x/s390-virtio-ccw.c   |  1 +
>>   hw/vfio/ap.c                 | 27 ++++++++---------
>>   hw/vfio/ccw.c                | 27 ++++++++---------
>>   hw/vfio/common.c             |  1 +
>>   hw/vfio/igd-stubs.c          | 20 +++++++++++++
>>   hw/vfio/igd.c                |  4 +--
>>   hw/vfio/iommufd.c            |  1 -
>>   hw/vfio/migration.c          |  1 -
>>   hw/vfio/pci-quirks.c         |  9 +++---
>>   hw/vfio/pci.c                | 57 +++++++++++++++++-------------------
>>   hw/vfio/platform.c           | 25 ++++++++--------
>>   hw/vfio/spapr.c              |  4 +--
>>   qom/object.c                 |  5 ++++
>>   hw/vfio/meson.build          | 35 +++++++++++++---------
>>   23 files changed, 152 insertions(+), 106 deletions(-)
>>   create mode 100644 hw/vfio/igd-stubs.c
>>
> 
> Patches 1-9 still look ok and could be merged through the vfio tree
> if maintainers ack patch 6 and 8.
> 
> The rest, depending on type_is_registered(), would be nice to have,
> but since there are conflicts and soft freeze is scheduled for
> tomorrow, we would probably have to wait QEMU 10.1.

No particular rush for the 10.0 release.

