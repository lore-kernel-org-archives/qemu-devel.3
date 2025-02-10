Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A973C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 08:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thPUM-0003vO-F2; Mon, 10 Feb 2025 03:50:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1thPUA-0003sd-Ah
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:49:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1thPU7-0004FQ-SV
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739177383;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9XnpApMrWMs33jKiI5vvV2CtuS8qw1OBYUfsnaLN9E=;
 b=b6FGcgyKKQj+ZggG4o5FaUNnl4oJTxQe2dsokz+SlX4WIf99M7WcmZE/7Wn065/++Os/bC
 QCHooGqaN2bzj7GSyi5Z7QtY2sf2hIGrswPkcAbKVboh9pZOfVLrUYvrhx3T8f0bbhfcZu
 NY2wmSL/cRNA1ndC8oaO5uzbSLDwVEY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-bIH_-i9HPp6uLJyNbxoDfA-1; Mon, 10 Feb 2025 03:49:38 -0500
X-MC-Unique: bIH_-i9HPp6uLJyNbxoDfA-1
X-Mimecast-MFC-AGG-ID: bIH_-i9HPp6uLJyNbxoDfA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43933eb7e1dso10412315e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 00:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739177377; x=1739782177;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F9XnpApMrWMs33jKiI5vvV2CtuS8qw1OBYUfsnaLN9E=;
 b=KMlGHgPCmJfQLAFVOd5wS/puSxEFzVrklvo2CrUTJG1tFhqLxPN5YYsUjssOW3Jh02
 WngJSUTMazdXsCLiCUFC4s8JaxdnYsDldQK0qgj0d4Xx58M0IvESPFDpBCYN946RmiNh
 MPeGhiDj3ZSpjF6wvhdnCPhUkxRAMvmLcwViqkKYD/c1EJ8s9ZFcHL19IJLvTShzX03n
 Ob+Csml9B7I9lxhpS1OMk8obRei2q/Jvgelg6ooCBLwu+VM5y7Fe1RQV97Kxq4ei2GIy
 aXZKmtwFgmgu7pfwPSDyGqGOP/tInjTY/ArsBlu8uBtu592bua/D3UOM8X1IdnCzZQm+
 HF+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU606HwK/CGmVWze/ORmK90l2X/8zmMupjUJr8mZKPMdKiMRkI0Z9ApN7onxuntKE7fbiZKYLr6sYxQ@nongnu.org
X-Gm-Message-State: AOJu0YxnfjS4ZpBAjuP0l2lQfe9Vnml3DwOsSzzdKAiNn24zfQ2CJ+Zj
 BrA1tL/yi6pifzSpBUZnJXAgPL/vCpGyVMdb5WRuKvkJRLfGygpaJvK+8+CQGd5GO/lkZn13WD+
 vvAnIDed60ySk+UBkkH0zyLCZSRS1C6JeYMfQYG1J79pqjeTo2mEkjKYJ71Kv
X-Gm-Gg: ASbGncuU5ggLLx3qBJyz61AUJgICBtL5Bg1mJsEs3ratV8FFG4EhT5orS0DTQBYZYdm
 taIPRcU9uu28BmR8E0F09ouiZ3+P9fBF7kozpp4B9BMosbrc7UgxQtAc9L3xGz7bnpt+ROZYPzV
 ZjWHq8RtA2epH1DQAm3k9nq+92KLSywd1TZr2WLaP2qs5s98xjnSuJjgtDKMwVBCk5aKHD1/o7a
 BWsUcxg7d6V3qQxcDNi7748uHKtPdkS9HjPCo1zRoElUKmuJv4UnIhex1EL3axFjho9Fau3PXub
 V9OFe3Y7gbZluKNgTAVWr3WfNojfnqWCxyZzMVwDuDVwubpe0j9j
X-Received: by 2002:a05:600c:4e43:b0:439:34d3:63cd with SMTP id
 5b1f17b1804b1-43934d364e7mr50688335e9.9.1739177376962; 
 Mon, 10 Feb 2025 00:49:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFud7khxQWw6vUXNUADTUoYCxmYf7OZTaPafuYFQ61i41FYGncOEi7wxAEZf2Yq3D8Cn/HMFw==
X-Received: by 2002:a05:600c:4e43:b0:439:34d3:63cd with SMTP id
 5b1f17b1804b1-43934d364e7mr50688115e9.9.1739177376638; 
 Mon, 10 Feb 2025 00:49:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfd8047sm137405245e9.33.2025.02.10.00.49.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 00:49:35 -0800 (PST)
Message-ID: <c6b63631-181c-4cad-b542-5fc89f6d066d@redhat.com>
Date: Mon, 10 Feb 2025 09:49:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Fix vIOMMU reset order
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com,
 imammedo@redhat.com, alex.williamson@redhat.com, philmd@linaro.org,
 zhenzhong.duan@intel.com, ddutile@redhat.com
References: <20250206142307.921070-1-eric.auger@redhat.com>
 <Z6Y6sf064FBWT5G1@x1.local> <2a18c763-cde4-4798-8866-3e023fc6ffc3@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <2a18c763-cde4-4798-8866-3e023fc6ffc3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Cédric,


On 2/7/25 6:25 PM, Cédric Le Goater wrote:
> On 2/7/25 17:54, Peter Xu wrote:
>> On Thu, Feb 06, 2025 at 03:21:51PM +0100, Eric Auger wrote:
>>> This is a follow-up of Peter's attempt to fix the fact that
>>> vIOMMUs are likely to be reset before the device they protect:
>>>
>>> [PATCH 0/4] intel_iommu: Reset vIOMMU after all the rest of devices
>>> https://lore.kernel.org/all/20240117091559.144730-1-peterx@redhat.com/
>>>
>>> This is especially observed with virtio devices when a qmp system_reset
>>> command is sent but also with VFIO devices.
>>>
>>> This series puts the vIOMMU reset in the 3-phase exit callback.
>>>
>>> This scheme was tested successful with virtio-devices and some
>>> VFIO devices. Nevertheless not all the topologies have been
>>> tested yet.
>>
>> Eric,
>>
>> It's great to know that we seem to be able to fix everything in such
>> small
>> changeset!
>>
>> I would like to double check two things with you here:
>>
>>    - For VFIO's reset hook, looks like we have landed more changes so
>> that
>>      vfio's reset function is now a TYPE_LEGACY_RESET, and it always
>> do the
>>      reset during "hold" phase only (via legacy_reset_hold()).  That
>> part
>>      will make sure vIOMMU (if switching to exit()-only reset) will
>> order
>>      properly with VFIO.  Is my understanding correct here?
>
>
> Eric,
>
> We were still seeing DMA errors from VFIO devices :
>
>   VFIO_MAP_DMA failed: Bad address
>
> with this series at shutdown (machine or OS) when using an intel_iommu
> device. We could see that the VIOMMU was reset and the device DMAs
> were still alive. Do you know why now ?

I have started debugging this other case. At first sight this looks like
a different problem. First this occurs on a qmp system_powerdown
The error messages do not occur on qemu reset but rather as a result of
the guest disabling the intel iommu anc curiously when the aliased IOMMU
MR (nodma) is re-enabled. I need more time to debug this.

Eric

>
> Thanks,
>
> C.
>
>
>>
>>    - Is it possible if some PCIe devices that will provide its own
>>      phase.exit(), would it matter on the order of PCIe device's
>>      phase.exit() and vIOMMU's phase.exit() (if vIOMMUs switch to use
>>      exit()-only approach like this one)?
>>
>> PS: it would be great to attach such information in either cover
>> letter or
>> commit message.  But definitely not a request to repost the patchset, if
>> Michael would have Message-ID when merge that'll be far enough to help
>> anyone find this discussion again.
>>
>> Thanks!
>>
>


