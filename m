Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73BAC54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 09:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpm5v-0002he-MM; Thu, 28 Mar 2024 05:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rpm5u-0002hQ-Ls
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 05:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rpm5s-0006Du-IQ
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 05:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711618242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FQWW+mOh8BdxtFe8eYzFiv5O4mZSp01nIMopDnGEp1o=;
 b=X+qqEwcW7Cl7Yb46Cs+IS0nT/OKBP8w/m8XZM9oLk49uQTWqE7XbJVssoojXYB3d/qN4NX
 jKI3JEtZ4Ll9QyOroyc42srzh2KoSwqt07eC7QfhkWLusbvnBHyVgj8P745iAUXacQ6iET
 asOLPacAya8ZkVBuUs4sTD5FoDreUQc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-GtvYzNbaNJOSx1YFEtmeVA-1; Thu, 28 Mar 2024 05:30:41 -0400
X-MC-Unique: GtvYzNbaNJOSx1YFEtmeVA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4140bf38378so5550745e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 02:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711618240; x=1712223040;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FQWW+mOh8BdxtFe8eYzFiv5O4mZSp01nIMopDnGEp1o=;
 b=Q8oA/OoKEsetsd4niivnm3FOqmxABMvo/He8EsrfJOAd3ZDIXytLkZYBkpyyV8zzUp
 VwFm1ghcI1nrrFCch///lLgpm5artnS6zx0OET5mT1n7aG/jJlegQqu4EIF+G3gehs7W
 7a0dfmN4L7xOGjtNF8qF21LlHInWF/RwH8/FTNu7svhfyY9DMGk8hr4NebqcEnwSLwUO
 8U2z8WhKUmMMX9ddooUjPEXcX1aDII+/G8S9UKgDyG2PlIsgN92Gg5a/ZIktITmb/IFZ
 6SYpUNOgMBPIuMVNU6R43oJreHFoF+XtccGyBy8g6WkiQ16RmTw/K+CcPyavjUL2tV3b
 c1Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqJ+NfMWb4ZEIHDa3pz3zqksZaC4DEU/eBE5zmmy6y3IdsIlwmAwsEt2fXxenspnovrUmoIe0wnABLlBkKYxpS+c2eC+A=
X-Gm-Message-State: AOJu0Yzm0X1mUuMTwBR3ZhM+ihiUxhWM+7eTXNdAFxMwG+7fbOHwPEUm
 O+zju4Sn2tQb8k7yXCrWDEYY1ooHxQ7sxrnemQ6NYkb/rhO6vwsd2KxrTUWI1ZxdArKL2seOWu5
 JY8ytpeCe1mCALy3K1lLTxhG93bC7AnuhGNskQMMIaR9E7L6MHVQM
X-Received: by 2002:a05:600c:358f:b0:414:24d:7f9 with SMTP id
 p15-20020a05600c358f00b00414024d07f9mr2664766wmq.1.1711618239991; 
 Thu, 28 Mar 2024 02:30:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpu+DyqKl6BrfNbknLdN+rGX9ya+Or7yIy0/p5SlBuhvdl00XViqNUUgkjmq8A58c7+ptXgA==
X-Received: by 2002:a05:600c:358f:b0:414:24d:7f9 with SMTP id
 p15-20020a05600c358f00b00414024d07f9mr2664744wmq.1.1711618239610; 
 Thu, 28 Mar 2024 02:30:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a05600c4e8800b0041489e97565sm4821139wmq.10.2024.03.28.02.30.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Mar 2024 02:30:39 -0700 (PDT)
Message-ID: <10a42156-067e-4dc1-8467-b840595b38fa@redhat.com>
Date: Thu, 28 Mar 2024 10:30:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vfio/pci: migration: Skip config space check for
 Vendor Specific Information in VSC during restore/load
To: Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Vinayak Kale <vkale@nvidia.com>, qemu-devel@nongnu.org,
 marcel.apfelbaum@gmail.com, avihaih@nvidia.com, acurrid@nvidia.com,
 cjia@nvidia.com, zhiw@nvidia.com, targupta@nvidia.com, kvm@vger.kernel.org
References: <20240322064210.1520394-1-vkale@nvidia.com>
 <20240327113915.19f6256c.alex.williamson@redhat.com>
 <20240327161108-mutt-send-email-mst@kernel.org>
 <20240327145235.47338c2b.alex.williamson@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240327145235.47338c2b.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 3/27/24 21:52, Alex Williamson wrote:
> On Wed, 27 Mar 2024 16:11:37 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
>> On Wed, Mar 27, 2024 at 11:39:15AM -0600, Alex Williamson wrote:
>>> On Fri, 22 Mar 2024 12:12:10 +0530
>>> Vinayak Kale <vkale@nvidia.com> wrote:
>>>    
>>>> In case of migration, during restore operation, qemu checks config space of the
>>>> pci device with the config space in the migration stream captured during save
>>>> operation. In case of config space data mismatch, restore operation is failed.
>>>>
>>>> config space check is done in function get_pci_config_device(). By default VSC
>>>> (vendor-specific-capability) in config space is checked.
>>>>
>>>> Due to qemu's config space check for VSC, live migration is broken across NVIDIA
>>>> vGPU devices in situation where source and destination host driver is different.
>>>> In this situation, Vendor Specific Information in VSC varies on the destination
>>>> to ensure vGPU feature capabilities exposed to the guest driver are compatible
>>>> with destination host.
>>>>
>>>> If a vfio-pci device is migration capable and vfio-pci vendor driver is OK with
>>>> volatile Vendor Specific Info in VSC then qemu should exempt config space check
>>>> for Vendor Specific Info. It is vendor driver's responsibility to ensure that
>>>> VSC is consistent across migration. Here consistency could mean that VSC format
>>>> should be same on source and destination, however actual Vendor Specific Info
>>>> may not be byte-to-byte identical.
>>>>
>>>> This patch skips the check for Vendor Specific Information in VSC for VFIO-PCI
>>>> device by clearing pdev->cmask[] offsets. Config space check is still enforced
>>>> for 3 byte VSC header. If cmask[] is not set for an offset, then qemu skips
>>>> config space check for that offset.
>>>>
>>>> Signed-off-by: Vinayak Kale <vkale@nvidia.com>
>>>> ---
>>>> Version History
>>>> v2->v3:
>>>>      - Config space check skipped only for Vendor Specific Info in VSC, check is
>>>>        still enforced for 3 byte VSC header.
>>>>      - Updated commit description with live migration failure scenario.
>>>> v1->v2:
>>>>      - Limited scope of change to vfio-pci devices instead of all pci devices.
>>>>
>>>>   hw/vfio/pci.c | 24 ++++++++++++++++++++++++
>>>>   1 file changed, 24 insertions(+)
>>>
>>>
>>> Acked-by: Alex Williamson <alex.williamson@redhat.com>
>>
>>
>> A very reasonable way to do it.
>>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>
>> Merge through the VFIO tree I presume?
> 
> Yep, Cédric said he´d grab it for 9.1.  Thanks,


Applied to vfio-next.

Thanks,

C.



