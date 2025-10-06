Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF68CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 16:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5nl2-0005j4-8P; Mon, 06 Oct 2025 12:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v5nl0-0005iu-CR
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 12:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v5nkt-0002gF-AC
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 12:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759766882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WcKisrJDBYFHbYfBFGUxfJ+DZh6SipHri+WkhFRfesM=;
 b=BUYSKozdrjOXXtFJf1EfRcZdgSRxdcuQ9YeazMshZUnY9lyW5HPkJX9Xi7AX5nO8JihBMk
 DpSvmtWbab1IjkCUzGjRG2bbA4Y3k+1Bb1dI84vZjpskv+eaT2vBpr+7UA31Gqof2IwW2A
 BbmSxlBBc3rmY2nc8qxkbC+9o36IUW8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-qW9egcrBPJGwz2jIQI4WQg-1; Mon, 06 Oct 2025 12:08:01 -0400
X-MC-Unique: qW9egcrBPJGwz2jIQI4WQg-1
X-Mimecast-MFC-AGG-ID: qW9egcrBPJGwz2jIQI4WQg_1759766880
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e3af78819so23883675e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 09:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759766880; x=1760371680;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WcKisrJDBYFHbYfBFGUxfJ+DZh6SipHri+WkhFRfesM=;
 b=OivfRrTzYW0HWJFiIlgcNcBDCLioBJ700QftE5X8kad56V7yFw8c29GChluKTVMkVT
 0MSAeo0lV7ICPANuo5PCzJy14uwYdeo82D0rdNaJOOY6Q3Ss4mkiZsyT3UeC5EevD/Jm
 sT9MrRzxZsFr52+w+ln9NPD4zNcONpWaCZXrldoBq02CppPs0yxeR5FlufkLCqodAFNU
 Ebkjxu3bEF9Rt2JVz4i41edU7tDF8nYqvYj4xzbHhXW1aA0nofRGQVlZKNZvnI9Jmasa
 5pwR8MnzXPEfEG2ZtMomEids5FhvaguJ+im8wI6mIgAcp0xcAhlyrmg0vSsEqAN4Vnyn
 x7kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp2xmVmAO80qDJnOdD7fONGlDBFR91Xg3teql5Y8JC2lAiNQG/rsZD7ihGLb6d/5ErnVi7eZtcZ0rs@nongnu.org
X-Gm-Message-State: AOJu0YwXqNsd0fvnNaY3fY3EeFcwiX8DWPsuDdDE4dVVjITCKEDPH1ED
 duaqBxgZXSk5bu6h96Cnjtrsnbyx9DjRdzTM1IW45CH9Nu3Lkum+uBZbVCfwSgNeNTwUM1rYSku
 sPt9/+XP4e1vXRlFqbr3SbIkFYxRTi1p1loYq8Fm2zYeakGqKp2PP2ZgY
X-Gm-Gg: ASbGncu6XKmAnmeiqDUpRpWQ6E7BCbNxGwNR/Fv73obhNhaeD+m2UCXhV7m+xdyST2e
 p3h1P/NfghhCpxf20tA9JKkVfBqO/5Q95akKbIvTO/V3UR7Cgk6R33eg3yE+J5hTt3a+XG/hBdN
 /j9HxI8qQTzwjXb1gZ27S9lQfn3iYYR9SyFYMmJNLezOBiRp0EdLFGEppUIlGvCR0TAlse3x9PN
 bqZNwczAbqFsTHlad28MGQ+DCLm+Jo8Pg1EHYjO753y+Fkt7L7pHTBjKAYOLOobN+zvRukWVyR3
 ispLHyKzl8ukA+vS0jD61ROg8ligZreJzdN7+FOxX5h7L++5LE4tjM9a8JwmDeLbIeppbzLLvN2
 DupJj4uCR
X-Received: by 2002:a05:600c:468e:b0:458:a7fa:211d with SMTP id
 5b1f17b1804b1-46e71151b26mr80575775e9.29.1759766879655; 
 Mon, 06 Oct 2025 09:07:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVeGVbOAEt7sK6C8Zk4ppmaJ+0xKm7nurx5dB3K1v0MUFStv1tWXx6B+svriW4ebNu5TUawQ==
X-Received: by 2002:a05:600c:468e:b0:458:a7fa:211d with SMTP id
 5b1f17b1804b1-46e71151b26mr80575525e9.29.1759766879204; 
 Mon, 06 Oct 2025 09:07:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e72374ac5sm184848945e9.18.2025.10.06.09.07.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 09:07:58 -0700 (PDT)
Message-ID: <505e04a7-ebd6-47a2-b4bd-02b1164d841b@redhat.com>
Date: Mon, 6 Oct 2025 18:07:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/22] AMD vIOMMU: DMA remapping support for VFIO
 devices
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, clement.mathieu--drif@eviden.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, Wei.Huang2@amd.com, Ankit.Soni@amd.com,
 ethan.milon@eviden.com, joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Alejandro,

On 9/19/25 23:34, Alejandro Jimenez wrote:
> This series adds support for guests using the AMD vIOMMU to enable DMA remapping
> for VFIO devices. Please see v1[0] cover letter for additional details such as
> example QEMU command line parameters used in testing.
> 
> I have sanity tested on an AMD EPYC Genoa host, booting a Linux guest with
> 'iommu.passthrough=0' and several CX6 VFs, and there are no issues during
> typical guest operation.
> 
> When using the non-default parameter 'iommu.forcedac=1' in the guest kernel
> cmdline, this initially fails due to a VFIO integer overflow bug which requires
> the following fix in the host kernel:
> 
> https://github.com/aljimenezb/linux/commit/014be8cafe7464d278729583a2dd5d94514e2e2a
> This is a work in progress as there are other locations in the driver that are
> susceptible to overflows, but the above is sufficient to fix the initial
> problem.
> 
> Even after that fix is applied, I see an issue on guest reboot when 'forcedac=1'
> is in use. Although the guest boots, the VF is not properly initialized, failing
> with a timeout. Once the guest reaches userspace the VF driver can be reloaded
> and it then works as expected. I am still investigating the root cause for this
> issue, and will need to discuss all the steps I have tried to eliminate
> potential sources of errors in a separate thread.
> 
> I am sending v3 despite this known issue since forcedac=1 is not a default or
> commonly known/used setting. Having the large portions of the infrastructure for
> DMA remapping already in place (and working) will make it easier to debug this
> corner case and get feedback/testing from the community. I hope this is a viable
> approach, otherwise I am happy to discuss all the steps I have taken to debug
> this issue in this thread and test any suggestions to address it.
> 
> Changes since v2[2]:
> - P5: Fixed missed check for AMDVI_FR_DTE_RTR_ERR in amdvi_do_translate() (Sairaj)
> - P6: Reword commit message to clarify the need to discern between empty PTEs and errors (Vasant)
> - P9: Use correct enum type for notifier flags and remove whitespace changes (Sairaj)
> - P11: Fixed integer overflow bug when guest uses iommu.forcedac=1. Fixed in P8. (Sairaj)
> - P15: Fixed typo in commit message (Sairaj)
> - P16: On reset, use passthrough mode by default on all address spaces (Sairaj)
> - P18: Enforce isolation by using DMA mode on errors retrieving DTE (Ethan & Sairaj)
> - P20: Removed unused pte_override_page_mask() and pte_get_page_mask() to avoid -Wunused-function error.
> - Add HATDis support patches from Joao Martins (HATDis available in Linux since [1])
> 
> Thank you,
> Alejandro
> 
> [0] https://lore.kernel.org/all/20250414020253.443831-1-alejandro.j.jimenez@oracle.com/
> [1] https://lore.kernel.org/all/cover.1749016436.git.Ankit.Soni@amd.com/
> [2] https://lore.kernel.org/qemu-devel/20250502021605.1795985-1-alejandro.j.jimenez@oracle.com/
> 
> Alejandro Jimenez (20):
>    memory: Adjust event ranges to fit within notifier boundaries
>    amd_iommu: Document '-device amd-iommu' common options
>    amd_iommu: Reorder device and page table helpers
>    amd_iommu: Helper to decode size of page invalidation command
>    amd_iommu: Add helper function to extract the DTE
>    amd_iommu: Return an error when unable to read PTE from guest memory
>    amd_iommu: Add helpers to walk AMD v1 Page Table format
>    amd_iommu: Add a page walker to sync shadow page tables on
>      invalidation
>    amd_iommu: Add basic structure to support IOMMU notifier updates
>    amd_iommu: Sync shadow page tables on page invalidation
>    amd_iommu: Use iova_tree records to determine large page size on UNMAP
>    amd_iommu: Unmap all address spaces under the AMD IOMMU on reset
>    amd_iommu: Add replay callback
>    amd_iommu: Invalidate address translations on INVALIDATE_IOMMU_ALL
>    amd_iommu: Toggle memory regions based on address translation mode
>    amd_iommu: Set all address spaces to use passthrough mode on reset
>    amd_iommu: Add dma-remap property to AMD vIOMMU device
>    amd_iommu: Toggle address translation mode on devtab entry
>      invalidation
>    amd_iommu: Do not assume passthrough translation when DTE[TV]=0
>    amd_iommu: Refactor amdvi_page_walk() to use common code for page walk
> 
> Joao Martins (2):
>    i386/intel-iommu: Move dma_translation to x86-iommu
>    amd_iommu: HATDis/HATS=11 support
> 
>   hw/i386/acpi-build.c        |    6 +-
>   hw/i386/amd_iommu.c         | 1056 ++++++++++++++++++++++++++++++-----
>   hw/i386/amd_iommu.h         |   51 ++


The current status of AMD-Vi Emulation in MAINTAINERS is Orphan.
Since this series is about to be merged, should AMD-Vi be considered
maintained now ? and if so by whom ?

Thanks,

C.




>   hw/i386/intel_iommu.c       |    5 +-
>   hw/i386/x86-iommu.c         |    1 +
>   include/hw/i386/x86-iommu.h |    1 +
>   qemu-options.hx             |   23 +
>   system/memory.c             |   10 +-
>   8 files changed, 999 insertions(+), 154 deletions(-)> 
> 
> base-commit: ab8008b231e758e03c87c1c483c03afdd9c02e19


