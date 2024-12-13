Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E2FE7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 09:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM1dk-0003Hx-8F; Fri, 13 Dec 2024 04:07:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1tM1di-0003Hb-Ha
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 04:07:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1tM1df-0007VL-6M
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 04:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734080829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jgpJKiAYEl42DHYPcy68quL+Q5EXcihFl1nu9oDOHy4=;
 b=d8IpJdF0+s1qbjppAIGCMCb53WfOUZspFfmWS8iHHLiLIHjfDCZXaJogF4Qu/HJC8a2nod
 vQ59QN4S2pImW7JIss0Ar9YET12Nu6TF1tnCTwu43HArtpkbuncZQ46rsVxap0AUYLw8I/
 6SXVtPTc/rvSbsh117gt5CwTAHbuOO0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-LT6Hi1WWM8S8oFb4P5f7Og-1; Fri, 13 Dec 2024 04:07:08 -0500
X-MC-Unique: LT6Hi1WWM8S8oFb4P5f7Og-1
X-Mimecast-MFC-AGG-ID: LT6Hi1WWM8S8oFb4P5f7Og
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43628594d34so1802945e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 01:07:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734080827; x=1734685627;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jgpJKiAYEl42DHYPcy68quL+Q5EXcihFl1nu9oDOHy4=;
 b=muLy9gVvJADmc8Rv9LbjCKi/qLK/dL6Rksn8LdPxURJEYeutma5zoPSL6iU12SNqE8
 yNSkPncYZBnOs6wZ/ULKXlViGBJHyxTDpNKOExnrryt+PseLR76dS/GFwmTHRaaq64NT
 3akEnqavO0zhNLc4/WciEVc6smmVbxXd60PKeSm4X1rPaQSOf5oavEXgY4w0qitvnzV1
 LC1MYgFSM8LMXTrLsGYkckjFRIxEUoGn5K2GWjkjWE0Z5g3oRlS7ADxdMJGljoIuN0Ej
 /Zc8JGNoz4O986Usji8fuXmv+yJgs1WMJa+AyXEInvIf9pwY9lcZPuKILB/TDFonbGGp
 8Rlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr8u/rl7u/2bEhrL4BDsPj/vL35lFPjExgnR3JH2YHkFPwsrF/iUcC0J3HEGKWUzSgSEk3TXg9aEIN@nongnu.org
X-Gm-Message-State: AOJu0Yy62Nk/Yx7EnfBs8QoaTUwaCwZOMzHrAN4yBAQ9mlQHmgy4+YRx
 adB4Q9UKkVmSsRw/lQ6SSvqjtQ0FGaWgpiqn79CXmumAFrn9/IFYmBLveg+T3CuGJXF83wTrpU2
 0sOdnNDkRSWGsAAiB5QStZxGIc4tX4ph+LgXtUQUHmSKm5G2lVJrG
X-Gm-Gg: ASbGnctFhD06MHQ0LGcujM7S5WPCLzMNtRUe5xGKxzdaUe9cjNwfWriEKpV3U7wlFFb
 AKJMUvExA8UqCHBBXD5tTGF4KedievcmeV9DdjeP8PVJsLsSMXtG07VyvvLqHfNRYCmG/VX0kIS
 z0RcXU0qELZZsaUVSnCH4xgeeqd6fU/+k7A60B1u7jCt+++OnmrJnQlb5m+2fyvIjuYFR2JPvn4
 KSTI0o3G1rNGmWgybX1m1oJQkZI0YadDChGumOgWY9+TgJbPUBRa9ps8QGxJrXEJFu4XoYliIQP
 /nTYNjfQYQ==
X-Received: by 2002:a05:600c:5254:b0:434:a902:97cd with SMTP id
 5b1f17b1804b1-4362aa3f7damr12197435e9.12.1734080826791; 
 Fri, 13 Dec 2024 01:07:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHabW/BBqEimbfVKHrqAjNFdXdsm35ZzurpEaqmekghfMwx51JZIM4X4XWKnZoydxmz9C3OMA==
X-Received: by 2002:a05:600c:5254:b0:434:a902:97cd with SMTP id
 5b1f17b1804b1-4362aa3f7damr12196915e9.12.1734080826136; 
 Fri, 13 Dec 2024 01:07:06 -0800 (PST)
Received: from [10.33.192.233] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43625706588sm43765035e9.29.2024.12.13.01.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 01:07:04 -0800 (PST)
Message-ID: <220b0480-8727-41bc-8dfd-f71f3e119207@redhat.com>
Date: Fri, 13 Dec 2024 10:07:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] s390x/pci: relax I/O address translation requirement
To: Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, qemu-devel@nongnu.org
References: <20241209192927.107503-1-mjrosato@linux.ibm.com>
 <990f5ccd-b05f-4e25-bc68-60793d4d21ad@redhat.com>
 <9b143fc7-9ac7-4b87-8089-5209aab186ec@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <9b143fc7-9ac7-4b87-8089-5209aab186ec@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/12/24 15:42, Matthew Rosato wrote:
> On 12/12/24 4:10 AM, Thomas Huth wrote:
>> On 09/12/2024 20.29, Matthew Rosato wrote:
>>> This series introduces the concept of the relaxed translation requirement
>>> for s390x guests in order to allow bypass of the guest IOMMU for more
>>> efficient PCI passthrough.
>>>
>>> With this series, QEMU can indicate to the guest that an IOMMU is not
>>> strictly required for a zPCI device.  This would subsequently allow a
>>> guest linux to use iommu.passthrough=1 and bypass their guest IOMMU for
>>> PCI devices.
>>>
>>> When this occurs, QEMU will note the behavior via an intercepted MPCIFC
>>> instruction and will fill the host iommu with mappings of the entire
>>> guest address space in response.
>>>
>>> There is a kernel series [1] that adds the relevant behavior needed to
>>> exploit this new feature from within a s390x linux guest.
>>>
>>> [1]: https://lore.kernel.org/linux-s390/20241209192403.107090-1-mjrosato@linux.ibm.com/
>>>
>>> Matthew Rosato (2):
>>>     s390x/pci: add support for guests that request direct mapping
>>>     s390x/pci: indicate QEMU supports relaxed translation for passthrough
>>
>>   Hi again!
>>
>> One more thought: This is a guest-visible feature, isn't it? So do we also need some migration handling for this? For example, what happens if you start a guest that is aware of this feature on a host that has a QEMU with this feature, and then try to live-migrate the guest to a QEMU that does not have this feature? I guess the guest will crash? It would be better to fail the migration instead. At least we should disable the feature in older machine types and only allow it for the latest one.
> 
> zPCI devices are currently marked as unmigratable in s390_pci_device_vmstate so it's not a reproducible issue yet.
> 
> Re: disabling the feature for older machines, OK -- Shall I fence similar to what we did for interpret/forwarding-assist with a new device property that is default to off on older machines ("relax-translation"? alternative suggestions welcome)

Looks good to me.

Thanks,

C.


