Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E42E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 10:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVq8S-0007X8-Tu; Thu, 09 Jan 2025 05:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVq8O-0007W2-FT
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:51:28 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVq8M-0007bN-Uz
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:51:28 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43626213fffso11781155e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 02:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736419880; x=1737024680; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CI/kIU53QavW/MIQDGwS2J0plaHH50TR2I7O/Dng8YM=;
 b=i7jVhkbtmPiMakWMmGmrBDUbzcxisXFibr7hObuTWfDl/DatNt+PmxiAU/n1KDuLxb
 ih2QExiqIqwOh0TrAYXOirvkWnRcO8/dGHhD968HJP77m06WaUkibwdcqMZUGVBjC8jI
 edjSM5V6SCfzyVx+CNSN+Q21SUhICY4QDqNUwY5C2okqChx/DjSTp4nu1b5/S3BTdKSq
 mZnLkYd9qs4B1VVMLAdpAoic00PlYk+fEQgnmeSrtYRzd5NFS6FgPPpV+7udQovmWue5
 Hck78kU8H6RhUs9LtKRl+rHfKwE8bmOPH1OPf6dWtkzbbOeKqRlzil33TVdlc7OFFut1
 DqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736419880; x=1737024680;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CI/kIU53QavW/MIQDGwS2J0plaHH50TR2I7O/Dng8YM=;
 b=EBNM9q8gRapw1VFf5rOP2+llYltd3cmWWR5TTsmqHVIVu9ETPFOWvWKT6H3Gmw9Ozi
 TRWlN4sAxrdmK76Q3lee2njXtGnliJwPJzx7mhqrvlDxJGCmHAlpIazgLTrtAG/WS/9q
 e/3pVhQbnZG6QUip6hOYzEtk7EirQg3J7xmD5MQxb3WG+PoLWKn+XhW92wz0xuCHnJEC
 tjARKlrCnCS0luZiMMBna5pA1Nux92KfCqjYj6hny5g/pSsZxxnDYElRb3lDv/gLIAiv
 otj6hOEH4ob6kkEJk+ntakGSW5LbnaKyUMQrPXN7/6UT6xnSeYshKi132pUVaUylWIIn
 59LA==
X-Gm-Message-State: AOJu0Yxm/wr30DkxlQm29g2BpHvVxJYQ1FUBC/r2Ce9krXSy+S34Wt31
 USsRjf1FPcS5XVxnOKeFFGj/IkoeDcoSj+5/XSlBpcQtmjNxZrXx3Qv8/rztyIE=
X-Gm-Gg: ASbGncslf83S3qpIEuogAM5GPGzFGuxHksOnKLtP97nBZ6RenvoxfJnC9nZ2R+syX0L
 rI1nqX7+r5gGmbtJuujk8kFtwyNnKQuJVeNsoPsaOWwaFzV69YCUXftsnH6czBqmkJShyvXcLLK
 eBRs7wY/IHBoLqG0JDiScDiE4c4xmDpDJpqPqFFogi+7mHRxCG228KM+T11tX//0Cb4APGKbtSj
 Wbb/m37nEQ/+reCURi6wTIyG+puP+GVqGMRzqbmJshyCm/NeVLBQvr2w4BXIF9Yq6S3X4IHllIF
 Oo9WNUFMvQOxdf54uewVkCLT
X-Google-Smtp-Source: AGHT+IF9YcmDHhlK3eZAfMFhskfBXZCvrdJofwCP+DxKifaXd/HX03s8gygVUdSyRRhRKxYJC1TSmw==
X-Received: by 2002:a05:600c:358a:b0:436:e69a:7341 with SMTP id
 5b1f17b1804b1-436e9d686b2mr15097845e9.3.1736419879718; 
 Thu, 09 Jan 2025 02:51:19 -0800 (PST)
Received: from [192.168.69.102] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fc5csm16871635e9.2.2025.01.09.02.51.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 02:51:19 -0800 (PST)
Message-ID: <01eac6ff-e128-4b1c-a5de-66ffa28b43b1@linaro.org>
Date: Thu, 9 Jan 2025 11:51:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 09/14] pcie_sriov: Reuse SR-IOV VF device instances
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com
References: <20250109-reuse-v19-0-f541e82ca5f7@daynix.com>
 <20250109-reuse-v19-9-f541e82ca5f7@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250109-reuse-v19-9-f541e82ca5f7@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Hi Akihiko,

On 9/1/25 07:29, Akihiko Odaki wrote:
> Disable SR-IOV VF devices by reusing code to power down PCI devices
> instead of removing them when the guest requests to disable VFs. This
> allows to realize devices and report VF realization errors at PF
> realization time.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   include/hw/pci/pcie_sriov.h |  1 -
>   hw/pci/pci.c                | 14 ++++++-
>   hw/pci/pcie_sriov.c         | 94 +++++++++++++++++++--------------------------
>   3 files changed, 51 insertions(+), 58 deletions(-)


>   void pci_set_enabled(PCIDevice *d, bool state)
> @@ -2977,7 +2987,7 @@ void pci_set_enabled(PCIDevice *d, bool state)
>       memory_region_set_enabled(&d->bus_master_enable_region,
>                                 (pci_get_word(d->config + PCI_COMMAND)
>                                  & PCI_COMMAND_MASTER) && d->enabled);
> -    if (!d->enabled) {
> +    if (d->qdev.realized) {

I'm not a big fan of accessing an internal field that way, without
accessor. Besides, we use this field atomicly within qdev.c.

>           pci_device_reset(d);

Anyhow, resetting an unrealized device is a bug IMO.

>       }
>   }


