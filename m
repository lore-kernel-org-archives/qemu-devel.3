Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39360C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 16:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7eH8-0000sC-4U; Thu, 16 May 2024 12:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7eH6-0000s2-6V
 for qemu-devel@nongnu.org; Thu, 16 May 2024 12:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7eH4-0001cD-E5
 for qemu-devel@nongnu.org; Thu, 16 May 2024 12:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715878089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uKb9EJ9kTOyZ9157IF7Z76w9cLjrmYo8X5cNJ3BUJSg=;
 b=X3j6Cp21H6xlcffj7WHOpDgExP1KQGvZLisWayEgJpydGTuI+qULEMDECfZYeQZ8Vs0GlF
 CgzcEgXejG5by11HQmzGmtqcAtllyLA9Uk/9WQ95T/1Wr2qHDsu5bguXV7R7uR6/NNXEd3
 v2UqBh5l8EBCu9Ayjo1hPkds4l/3p5E=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-ovLYFkCVO2y-5kys2Z2M2A-1; Thu, 16 May 2024 12:48:06 -0400
X-MC-Unique: ovLYFkCVO2y-5kys2Z2M2A-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6a1530209deso177376666d6.1
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 09:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715878086; x=1716482886;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uKb9EJ9kTOyZ9157IF7Z76w9cLjrmYo8X5cNJ3BUJSg=;
 b=WKzwdajWsJZoNDHoCQ7KuDDPYP/s/CMybkWsST4LmF9yTOP5D3mDW9i2w7uC+S4b7T
 vK233np5+jzjGWPqzr3ETNi0sCeMBrJYYbnXP0L1AWYSFmK1FuF3mbwYIX7T2MPmYlq6
 1XO1oTZdO5Gbva14T2bwdcTDTsVzB9J2IzTkTJqKirp6v2VbTnNGUHyljYVtp7aYyRoy
 hdjCK2pbkpu9/2UUaHjw8+tdwgyRHGbrLmu1qCyMog5iWIrFv0PFVrF72EPoo0E0kMqM
 t+K8wO1QHbhSWOb8nA6qoF2bwIwhtUHTzYsd08GEJSN2dWaYvI40XAZczLxkasN7ohJe
 Lp0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvnuSL22orCiKs5JbMbCbQj19ANCBkgPHq2GV7qNCrJ2Yf5NNUz3jJhaXlWaW2/57wvC5aTsq0HS5nTCKFXBkapxawgFQ=
X-Gm-Message-State: AOJu0Yz3OGH/L+7LdBZvI2cMglMmTzhvHySJJWs2RSVonHSOX7f673W1
 LW9yYAv/oRkC97SZ/BJNT6pSr+CksyxbvoOmEUIOv78UB6zhkP+1tCU8ANmJvHjx9e/XgVUh0TP
 s0LQHY7VBPyITg0IUKnQLzRhp/wMYASCFc8RX/rnH9l5hK1b6BMfI
X-Received: by 2002:a05:6214:310f:b0:6a0:66ad:c29 with SMTP id
 6a1803df08f44-6a167914316mr398167446d6.10.1715878085437; 
 Thu, 16 May 2024 09:48:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErZm1/id2NuKFHEfj6ShcZ5/ZmuiH6VP+Icz2Inx9cztvTn2KA432LCAoaUxWJ0hXUxLfBdA==
X-Received: by 2002:a05:6214:310f:b0:6a0:66ad:c29 with SMTP id
 6a1803df08f44-6a167914316mr398167056d6.10.1715878085064; 
 Thu, 16 May 2024 09:48:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f194950sm76154566d6.60.2024.05.16.09.48.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 09:48:04 -0700 (PDT)
Message-ID: <e242532d-01eb-4521-90b9-0b1069b498b5@redhat.com>
Date: Thu, 16 May 2024 18:48:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] VFIO: misc cleanups part2
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240515082041.556571-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
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

Hello Zhenzhong,

On 5/15/24 10:20, Zhenzhong Duan wrote:
> Hi
> 
> This is the last round of cleanup series to change functions in hw/vfio/
> to return bool when the error is passed through errp parameter.
> 
> The first round is at https://lists.gnu.org/archive/html/qemu-devel/2024-05/msg01147.html
> 
> I see Cédric is also working on some migration stuff cleanup,
> so didn't touch migration.c, but all other files in hw/vfio/ are cleanup now.
> 
> Patch1 is a fix patch, all others are cleanup patches.
> 
> Test done on x86 platform:
> vfio device hotplug/unplug with different backend
> reboot
> 
> This series is rebased to https://github.com/legoater/qemu/tree/vfio-next

I queued part 1 in vfio-next with other changes. part 2 is in vfio-9.1
for now and should reach vfio-next after reviews next week.

Then, we have to work on your v5 [1] which should have all my attention
again after the next vfio PR. You, Joao and Eric have followups series
that need a resync on top of v5, possibly others [2] and [3], not sent
AFAICT. Anyhow, we will need inputs from these people and IOMMU
stakeholders/maintainers.

Thanks,

C.

[1] [PATCH v5 00/19] Add a host IOMMU device abstraction to check with vIOMMU
     https://lore.kernel.org/qemu-devel/20240507092043.1172717-1-zhenzhong.duan@intel.com/

[2] [PATCH ats_vtd v2 00/25] ATS support for VT-d
     https://lore.kernel.org/all/20240515071057.33990-1-clement.mathieu--drif@eviden.com/

[3] Add Tegra241 (Grace) CMDQV Support
     https://lore.kernel.org/all/cover.1712978212.git.nicolinc@nvidia.com/
     https://github.com/nicolinc/qemu/commits/wip/iommufd_vcmdq/



> 
> Thanks
> Zhenzhong
> 
> Zhenzhong Duan (16):
>    vfio/display: Fix error path in call site of ramfb_setup()
>    vfio/display: Make vfio_display_*() return bool
>    vfio/helpers: Use g_autofree in hw/vfio/helpers.c
>    vfio/helpers: Make vfio_set_irq_signaling() return bool
>    vfio/helpers: Make vfio_device_get_name() return bool
>    vfio/platform: Make vfio_populate_device() and vfio_base_device_init()
>      return bool
>    vfio/ccw: Make vfio_ccw_get_region() return a bool
>    vfio/pci: Make vfio_intx_enable_kvm() return a bool
>    vfio/pci: Make vfio_pci_relocate_msix() and vfio_msix_early_setup()
>      return a bool
>    vfio/pci: Make vfio_populate_device() return a bool
>    vfio/pci: Make vfio_intx_enable() return bool
>    vfio/pci: Make vfio_populate_vga() return bool
>    vfio/pci: Make capability related functions return bool
>    vfio/pci: Use g_autofree for vfio_region_info pointer
>    vfio/pci-quirks: Make vfio_pci_igd_opregion_init() return bool
>    vfio/pci-quirks: Make vfio_add_*_cap() return bool
> 
>   hw/vfio/pci.h                 |  12 +-
>   include/hw/vfio/vfio-common.h |   6 +-
>   hw/vfio/ap.c                  |  10 +-
>   hw/vfio/ccw.c                 |  25 ++--
>   hw/vfio/display.c             |  22 ++--
>   hw/vfio/helpers.c             |  33 ++---
>   hw/vfio/igd.c                 |   5 +-
>   hw/vfio/pci-quirks.c          |  50 ++++----
>   hw/vfio/pci.c                 | 227 ++++++++++++++++------------------
>   hw/vfio/platform.c            |  61 ++++-----
>   10 files changed, 213 insertions(+), 238 deletions(-)
> 


